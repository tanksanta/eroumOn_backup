package icube.market.mypage.info;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.egovframe.rte.fdl.string.EgovStringUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.View;

import icube.common.framework.abst.CommonAbstractController;
import icube.common.framework.view.JavaScript;
import icube.common.framework.view.JavaScriptView;
import icube.common.mail.MailService;
import icube.common.values.CodeMap;
import icube.manage.mbr.mbr.biz.MbrPrtcrService;
import icube.manage.mbr.mbr.biz.MbrPrtcrVO;
import icube.manage.mbr.mbr.biz.MbrService;
import icube.manage.mbr.mbr.biz.MbrVO;
import icube.manage.promotion.mlg.biz.MbrMlgService;
import icube.manage.promotion.mlg.biz.MbrMlgVO;
import icube.manage.promotion.point.biz.MbrPointService;
import icube.manage.promotion.point.biz.MbrPointVO;
import icube.market.mbr.biz.MbrSession;

/**
 * 마이페이지 > 회원정보 > 가족회원 관리
 */
@Controller
@RequestMapping(value = "#{props['Globals.Market.path']}/mypage/fam")
public class MyFamController extends CommonAbstractController {

	@Resource(name="mbrPrtcrService")
	private MbrPrtcrService mbrPrtcrService;

	@Resource(name="mbrService")
	private MbrService mbrService;

	@Resource(name="mailService")
	private MailService mailService;

	@Resource(name = "mbrPointService")
	private MbrPointService mbrPointService;

	@Resource(name = "mbrMlgService")
	private MbrMlgService mbrMlgService;

	@Autowired
	private MbrSession mbrSession;

	@Value("#{props['Globals.Market.path']}")
	private String marketPath;

	@Value("#{props['Mail.Form.File']}")
	private String mailFormFile;

	@Value("#{props['Mail.Username']}")
	private String sendMail;

	@Value("#{props['Profiles.Active']}")
	private String activeMode;

	/**
	 * 목록
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="list")
	@SuppressWarnings({"rawtypes","unchecked"})
	public String list(
			HttpServletRequest request
			, Model model
			) throws Exception{
		int mbrPoint = 0;
		int mbrMlg = 0;

		Map<String, Object> resultMap = new HashMap();
		Map<String, Object> paramMap = new HashMap();
		paramMap.put("srchMyUniqueId", mbrSession.getUniqueId());
		paramMap.put("srchReqTy", "C");
		paramMap.put("srchMberSttus", "EXIT");

		// 내가 신청 했거나, 받은 리스트
		List<MbrPrtcrVO> playList = mbrPrtcrService.selectPrtcrListByMap(paramMap);

		// 상대방 정보에 대한 리스트
		List<MbrPrtcrVO> infoList = mbrPrtcrService.selectAppListByList(playList);

		// 본인 마일리지, 포인트
		paramMap.put("srchUniqueId", mbrSession.getUniqueId());
		paramMap.put("srchMyUniqueId", null);
		paramMap.put("srchReqTy", null);

		MbrPointVO  mbrPointVO = mbrPointService.selectMbrPoint(paramMap);
		MbrMlgVO mbrMlgVO = mbrMlgService.selectMbrMlg(paramMap);

		if(mbrPointVO != null) {
			mbrPoint = mbrPointVO.getPointAcmtl();
		}

		if(mbrMlgVO != null) {
			mbrMlg = mbrMlgVO.getMlgAcmtl();
		}

		resultMap.put("mbrPoint", mbrPoint);
		resultMap.put("mbrMlg", mbrMlg);

		model.addAttribute("prtcrRltCode", CodeMap.PRTCR_RLT);
		model.addAttribute("infoList", infoList);
		model.addAttribute("resultMap", resultMap);

		return "/market/mypage/family/list";
	}

	/**
	 * 가족회원 승인&거부 처리
	 * @param request
	 * @param model
	 * @param reqMap
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="appFam.json")
	@ResponseBody
	@SuppressWarnings({"unchecked","rawtypes"})
	public Map<String, Object> appFam(
			@RequestParam (value="prtcrMbrNo", required=true) int prtcrMbrNo
			, @RequestParam (value="appType", required=true) String appType
			, @RequestParam (value="prtcrRel", required=false) String prtcrRlt
			, @RequestParam (value="rltEtc", required=false) String rltEtc
			, @RequestParam(value="uniqueId", required=false) String uniqueId
			, @RequestParam Map<String, Object> reqMap
			, HttpServletRequest request, HttpSession session, Model model) throws Exception {

		boolean result = false;

		Map paramMap = new HashMap();
		paramMap.put("srchPrtcrMbrNo", prtcrMbrNo);
		paramMap.put("srchPrtcrUniqueId", uniqueId);

		MbrPrtcrVO mbrPrtcrVO = mbrPrtcrService.selectMbrPrtcr(paramMap);
		if(mbrPrtcrVO == null) {
			paramMap.put("srchUniqueId", uniqueId);
		}

		Map resultMap = new HashMap();
		resultMap.put("type", appType);

		if(appType.equals("app")) {

			//승인
			mbrPrtcrVO.setReqTy("F");
			mbrPrtcrVO.setPrtcrRlt(prtcrRlt);
			mbrPrtcrVO.setRltEtc(rltEtc);

			mbrPrtcrService.updateReqTy(mbrPrtcrVO);
			resultMap.put("result", true);

		}else if(appType.equals("den")){
			//거부
			mbrPrtcrVO.setReqTy("C");

			mbrPrtcrService.updateReqTy(mbrPrtcrVO);
			resultMap.put("result", true);

		}else if(appType.equals("modify")) {
			//변경
			mbrPrtcrVO.setPrtcrRlt(prtcrRlt);

			//기타
			if(!EgovStringUtil.isEmpty(rltEtc)) {
				mbrPrtcrVO.setRltEtc(rltEtc);
			}else {
				mbrPrtcrVO.setRltEtc(null);
			}

			mbrPrtcrService.updateReqTy(mbrPrtcrVO);
			resultMap.put("result", true);
		}else {
			resultMap.put("result", result);
		}

		paramMap.clear();
		paramMap.put("srchReqTy", "F");
		paramMap.put("srchUniqueId", mbrSession.getUniqueId());
		List<MbrPrtcrVO> prtcrList = mbrPrtcrService.selectPrtcrListByUniqueId(paramMap);


		mbrSession.setPrtcrList(prtcrList);
		mbrSession.setMbrInfo(session, mbrSession);

		return resultMap;
	}

	/**
	 * 가족회원 초대장
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="action")
	@SuppressWarnings({"rawtypes","unchecked"})
	public View action(
			HttpServletRequest request
			, Model model
			, @RequestParam(value="mblTelno", required=false) String mblTelno
			//, @RequestParam(value="eml", required=false) String eml
			) throws Exception {
		JavaScript javaScript = new JavaScript();

		Map paramMap = new HashMap();
		paramMap.put("srchMbrSttus", "NORMAL");
		paramMap.put("srchMblTelno", mblTelno);
		/*if(!EgovStringUtil.isNull(mblTelno)) {
			paramMap.put("srchMblTelno", mblTelno);
		}else {
			paramMap.put("srchEml", eml);
		}*/

		int mbrCount = mbrService.selectMbrCount(paramMap);

		if(mbrCount > 1) {
			javaScript.setMessage("중복된 전화번호가 존재합니다.");
			javaScript.setMethod("window.history.back()");
		}else {
			MbrVO mbrVO = mbrService.selectMbr(paramMap);

			if(mbrVO != null) {

				if(!EgovStringUtil.isNull(mblTelno)) {
					//TODO 휴대폰 message 전송
					//javaScript.setMessage("문자를 전송했습니다.");
					javaScript.setMessage("가족회원으로 초대하였습니다.");
					javaScript.setLocation("/"+ marketPath + "/mypage/fam/list");
				}else {
					/*
					try {
						if(ValidatorUtil.isEmail(mbrVO.getEml())) {
							String MAIL_FORM = mailFormFile;
							String mailForm = FileUtil.readFile(MAIL_FORM);

							// 메일 발송
							String mailSj = "[EROUM] 가족 회원으로 당신을 초대합니다."; //TO-DO : message로 이동

							if(EgovStringUtil.equals("real", activeMode)) {
								mailService.sendMail(sendMail, mbrVO.getEml(), mailSj, mailForm);
							} else {
								mailService.sendMail(sendMail, "ogy2658@gmail.com", mailSj, mailForm); //테스트
							}

						}else {
							log.debug("EMAIL 전송 실패 :: 이메일 체크 " + mbrVO.getEml());
						}

						javaScript.setMessage("이메일을 전송했습니다.");
						javaScript.setLocation("/"+ marketPath + "/mypage/fam/list");

					}catch(Exception e) {
						e.printStackTrace();
						log.debug("EMAIL 전송 실패 :: " + e.toString());
					}*/
					javaScript.setMessage("이메일을 전송했습니다.");
					javaScript.setLocation("/"+ marketPath + "/mypage/fam/list");

				}

				// 신청
				MbrPrtcrVO mbrPrtcrVO = new MbrPrtcrVO();
				mbrPrtcrVO.setUniqueId(mbrSession.getUniqueId());
				mbrPrtcrVO.setPrtcrUniqueId(mbrVO.getUniqueId());
				mbrPrtcrVO.setReqTy("P");

				// 가족회원 수 체크
				Map params = new HashMap();
				params.put("srchMyUniqueId", mbrSession.getUniqueId());
				params.put("srchReqTy", "C");

				int fmlCount = mbrPrtcrService.selectPrtcrCount(params);

				if(fmlCount < 4) {
					mbrPrtcrService.insertPrtcr(mbrPrtcrVO);
				}else {
					javaScript.setMessage("가족회원은 본인을 포함한 최대 5명 입니다.");
					javaScript.setMethod("window.history.back()");
				}

			}else {
				javaScript.setMessage(getMsg("error.default"));
				javaScript.setMethod("window.history.back()");
			}
		}



		return new JavaScriptView(javaScript);
	}

	/**
	 * 가족 회원 삭제
	 * @param request
	 * @param model
	 * @param uniqueId
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="excludeFml.json")
	@ResponseBody
	public Map<String, Object> excludeFml(
			HttpServletRequest request
			, Model model
			, @RequestParam(value="paramUniqueId", required=true) String uniqueId
			, @RequestParam(value="paramPrtcrId", required=true) String prtcrUniqueId
			, HttpSession session)throws Exception {

		Map<String, Object> resultMap = new HashMap<String, Object>();
		Map<String, Object> paramMap = new HashMap<String, Object>();

		/*paramMap.put("srchMyUniqueId", mbrSession.getUniqueId());
		MbrPrtcrVO mbrPrtcrVO = mbrPrtcrService.selectMbrPrtcr(paramMap);


		paramMap.clear();
		if(mbrPrtcrVO.getUniqueId().equals(uniqueId)) {*/
			paramMap.put("srchUniqueId", uniqueId);
			paramMap.put("srchPrtcrUniqueId", prtcrUniqueId);
		/*}else {
			paramMap.put("srchUniqueId", prtcrUniqueId);
			paramMap.put("srchPrtcrUniqueId", uniqueId);
		}*/

		boolean result = false;

		try {
			mbrPrtcrService.deleteFml(paramMap);
			result = true;


			paramMap.clear();
			paramMap.put("srchReqType", "F");
			paramMap.put("srchMyUniqueId", mbrSession.getUniqueId());
			List<MbrPrtcrVO> prtcrList = mbrPrtcrService.selectPrtcrListByMap(paramMap);

			mbrSession.setPrtcrList(prtcrList);
			mbrSession.setMbrInfo(session, mbrSession);

		}catch(Exception e) {
			e.printStackTrace();
			log.debug("가족 회원 삭제 실패  :: " + e.toString());
		}

		resultMap.put("result", result);
		return resultMap;
	}


}
