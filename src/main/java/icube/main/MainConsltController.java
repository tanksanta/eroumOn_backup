package icube.main;

import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.egovframe.rte.fdl.string.EgovStringUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.core.env.Environment;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import icube.common.api.biz.TilkoApiService;
import icube.common.framework.abst.CommonAbstractController;
import icube.common.mail.MailService;
import icube.common.util.FileUtil;
import icube.common.values.CodeMap;
import icube.main.biz.MainService;
import icube.manage.consult.biz.MbrConsltChgHistVO;
import icube.manage.consult.biz.MbrConsltService;
import icube.manage.consult.biz.MbrConsltVO;
import icube.manage.mbr.mbr.biz.MbrService;
import icube.manage.mbr.recipients.biz.MbrRecipientsService;
import icube.manage.mbr.recipients.biz.MbrRecipientsVO;
import icube.manage.members.bplc.biz.BplcService;
import icube.manage.members.bplc.biz.BplcVO;
import icube.market.mbr.biz.MbrSession;
import icube.common.api.biz.BiztalkApiService;

@Controller
@RequestMapping(value="#{props['Globals.Main.path']}/conslt")
public class MainConsltController extends CommonAbstractController{

	@Resource(name = "mainService")
	private MainService mainService;

	@Resource(name = "mbrConsltService")
	private MbrConsltService mbrConsltService;

	@Resource(name = "mbrService")
	private MbrService mbrService;

	@Resource(name = "bplcService")
	private BplcService bplcService;
	
	@Resource(name= "mbrRecipientsService")
	private MbrRecipientsService mbrRecipientsService;
	
	@Resource(name= "tilkoApiService")
	private TilkoApiService tilkoApiService;

	@Resource(name = "biztalkApiService")
	private BiztalkApiService biztalkApiService;

	@Autowired
	private MbrSession mbrSession;

	@Value("#{props['Globals.Main.path']}")
	private String mainPath;

	@Resource(name = "mailService")
	private MailService mailService;

	@Value("#{props['Mail.Form.FilePath']}")
	private String mailFormFilePath;

	@Value("#{props['Mail.Username']}")
	private String sendMail;

	@Autowired
	private Environment environment;
	
	/**
	 * 상담신청이 모달방식으로 변경됨에 따라 주석처리
	 */
//	@RequestMapping(value = "form")
//	public String form(
//			HttpServletRequest request
//			, Model model
//			, HttpSession session
//			, MbrConsltVO mbrConsltVO
//			)throws Exception {
//
//		if(!mbrSession.isLoginCheck()) {
//			session.setAttribute("returnUrl", "/"+mainPath+"/conslt/form");
//			return "redirect:" + "/membership/login?returnUrl=/"+mainPath+"/conslt/form";
//		}
//
//		model.addAttribute("mbrConsltVO", mbrConsltVO);
//		model.addAttribute("genderCode", CodeMap.GENDER);
//
//		return "/main/conslt/form";
//	}
//
//	@RequestMapping(value = "action")
//	public View action(
//			HttpServletRequest request
//			, Model model
//			, MbrConsltVO mbrConsltVO
//			)throws Exception {
//
//		JavaScript javaScript = new JavaScript();
//
//		mbrConsltVO.setRegId(mbrSession.getMbrId());
//		mbrConsltVO.setRegUniqueId(mbrSession.getUniqueId());
//		mbrConsltVO.setRgtr(mbrConsltVO.getMbrNm());
//
//		if(EgovStringUtil.isNotEmpty(mbrConsltVO.getBrdt())) {
//			mbrConsltVO.setBrdt(mbrConsltVO.getBrdt().replace("/", ""));
//		}
//
//		int insertCnt = mbrConsltService.insertMbrConslt(mbrConsltVO);
//
//		if (insertCnt > 0) {
//			//1:1 상담신청 이력 추가
//			Map<String, Object> paramMap = new HashMap<String, Object>();
//			paramMap.put("srchRgtr", mbrConsltVO.getRgtr());
//			paramMap.put("srchUniqueId", mbrConsltVO.getRegUniqueId());
//			MbrConsltVO srchMbrConslt = mbrConsltService.selectLastMbrConsltForCreate(paramMap);
//			
//			MbrConsltChgHistVO mbrConsltChgHistVO = new MbrConsltChgHistVO();
//			mbrConsltChgHistVO.setConsltNo(srchMbrConslt.getConsltNo());
//			mbrConsltChgHistVO.setConsltSttusChg(srchMbrConslt.getConsltSttus());
//			mbrConsltChgHistVO.setResn(CodeMap.CONSLT_STTUS_CHG_RESN.get("접수"));
//			mbrConsltChgHistVO.setMbrUniqueId(mbrSession.getUniqueId());
//			mbrConsltChgHistVO.setMbrId(mbrSession.getMbrId());
//			mbrConsltChgHistVO.setMbrNm(mbrSession.getMbrNm());
//			mbrConsltService.insertMbrConsltChgHist(mbrConsltChgHistVO);
//			
//			
//			//1:1 상담신청시 관리자에게 알림 메일 발송
//			String MAIL_FORM_PATH = mailFormFilePath;
//			String mailForm = FileUtil.readFile(MAIL_FORM_PATH + "mail_conslt.html");
//			String mailSj = "[이로움 ON] 장기요양테스트 신규상담건 문의가 접수되었습니다.";
//			String putEml = "help@thkc.co.kr";
//
//			if (Arrays.asList(environment.getActiveProfiles()).stream().anyMatch(profile -> "real".equals(profile))) {
//				mailService.sendMail(sendMail, putEml, mailSj, mailForm);
//			}
//		}
//
//		javaScript.setMessage(getMsg("action.complete.insert"));
//		javaScript.setLocation("/"+mainPath+"/conslt/view");
//		return new JavaScriptView(javaScript);
//	}
//
//	@RequestMapping(value = "view")
//	public String view(
//			HttpServletRequest request
//			, Model model
//			)throws Exception {
//
//		return "/main/conslt/view";
//	}

	// 추천 멤버스 리스트
	@RequestMapping(value="include/popup")
	public String popup(
			Model model
			)throws Exception  {

		Map<String, Object> paramMap = new HashMap<String, Object>();
		paramMap.put("srchAprvTy", "C");
		paramMap.put("srchUseYn", "Y");
		paramMap.put("srchDspyYn", "Y");
		List<BplcVO> bplcList = bplcService.selectBplcList(paramMap);

		model.addAttribute("bplcList", bplcList);

		return "/main/conslt/include/popup";
	}
	
	/**
	 * 모달에서 1:1 상담신청하기
	 */
	@ResponseBody
	@RequestMapping(value = "/addMbrConslt.json")
	public Map<String, Object> addMbrConslt(
			MbrConsltVO mbrConsltVO,
			Boolean saveRecipientInfo
		)throws Exception {

		Map <String, Object> resultMap = new HashMap<String, Object>();

		try {
			//요양인정번호를 입력한 경우 조회 가능한지 유효성 체크
			if (EgovStringUtil.isNotEmpty(mbrConsltVO.getRcperRcognNo())) {
				Map<String, Object> returnMap = tilkoApiService.getRecipterInfo(mbrConsltVO.getMbrNm(), mbrConsltVO.getRcperRcognNo());
				
				Boolean result = (Boolean) returnMap.get("result");
				if (result == false) {
					returnMap.put("success", false);
					resultMap.put("msg", "유효한 요양인정번호가 아닙니다.");
					return resultMap;
				}
			}
			
			mbrConsltVO.setRegId(mbrSession.getMbrId());
			mbrConsltVO.setRegUniqueId(mbrSession.getUniqueId());
			mbrConsltVO.setRgtr(mbrSession.getMbrNm());

			if(EgovStringUtil.isNotEmpty(mbrConsltVO.getBrdt())) {
				mbrConsltVO.setBrdt(mbrConsltVO.getBrdt().replace("/", ""));
			}

			int insertCnt = mbrConsltService.insertMbrConslt(mbrConsltVO);

			if (insertCnt > 0) {
				//수급자 정보 저장동의시 저장
				if (saveRecipientInfo) {
					MbrRecipientsVO mbrRecipient = mbrRecipientsService.selectMbrRecipientsByRecipientsNo(mbrConsltVO.getRecipientsNo());
					mbrRecipient.setRelationCd(mbrConsltVO.getRelationCd());
					mbrRecipient.setRecipientsNm(mbrConsltVO.getMbrNm());
					if (EgovStringUtil.isNotEmpty(mbrConsltVO.getRcperRcognNo())) {
						mbrRecipient.setRcperRcognNo(mbrConsltVO.getRcperRcognNo());
						mbrRecipient.setRecipientsYn("Y");
					} else {
						mbrRecipient.setRecipientsYn("N");
					}
					mbrRecipient.setTel(mbrConsltVO.getMbrTelno());
					mbrRecipient.setSido(mbrConsltVO.getZip());
					mbrRecipient.setSigugun(mbrConsltVO.getAddr());
					mbrRecipient.setDong(mbrConsltVO.getDaddr());
					mbrRecipient.setBrdt(mbrConsltVO.getBrdt());
					mbrRecipient.setGender(mbrConsltVO.getGender());
					mbrRecipientsService.updateMbrRecipients(mbrRecipient);
				}
				
				//1:1 상담신청 이력 추가
				Map<String, Object> paramMap = new HashMap<String, Object>();
				paramMap.put("srchRgtr", mbrConsltVO.getRgtr());
				paramMap.put("srchUniqueId", mbrConsltVO.getRegUniqueId());
				MbrConsltVO srchMbrConslt = mbrConsltService.selectLastMbrConsltForCreate(paramMap);
				
				MbrConsltChgHistVO mbrConsltChgHistVO = new MbrConsltChgHistVO();
				mbrConsltChgHistVO.setConsltNo(srchMbrConslt.getConsltNo());
				mbrConsltChgHistVO.setConsltSttusChg(srchMbrConslt.getConsltSttus());
				mbrConsltChgHistVO.setResn(CodeMap.CONSLT_STTUS_CHG_RESN.get("접수"));
				mbrConsltChgHistVO.setMbrUniqueId(mbrSession.getUniqueId());
				mbrConsltChgHistVO.setMbrId(mbrSession.getMbrId());
				mbrConsltChgHistVO.setMbrNm(mbrSession.getMbrNm());
				mbrConsltService.insertMbrConsltChgHist(mbrConsltChgHistVO);
				
				
				//1:1 상담신청시 관리자에게 알림 메일 발송
				String MAIL_FORM_PATH = mailFormFilePath;
				String mailForm = FileUtil.readFile(MAIL_FORM_PATH + "mail_conslt.html");
				String mailSj = "[이로움 ON] 장기요양테스트 신규상담건 문의가 접수되었습니다.";
				String putEml = "help@thkc.co.kr";

				if (Arrays.asList(environment.getActiveProfiles()).stream().anyMatch(profile -> "real".equals(profile))) {
					mailService.sendMail(sendMail, putEml, mailSj, mailForm);
				}
			}

			biztalkApiService.sendOnTalkCreated(mbrConsltVO.getMbrNm(), mbrConsltVO.getMbrTelno()); 

			resultMap.put("success", true);
		} catch (Exception ex) {
			resultMap.put("success", false);
			resultMap.put("msg", "상담신청에 실패하였습니다");
		}
		return resultMap;
	}
}
