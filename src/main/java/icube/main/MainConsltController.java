package icube.main;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.egovframe.rte.fdl.string.EgovStringUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import icube.common.api.biz.BiztalkConsultService;
import icube.common.api.biz.TilkoApiService;
import icube.common.framework.abst.CommonAbstractController;
import icube.common.mail.MailService;
import icube.common.values.CodeMap;
import icube.main.biz.MainService;
import icube.manage.consult.biz.MbrConsltChgHistVO;
import icube.manage.consult.biz.MbrConsltGdsService;
import icube.manage.consult.biz.MbrConsltService;
import icube.manage.consult.biz.MbrConsltVO;
import icube.manage.mbr.mbr.biz.MbrService;
import icube.manage.mbr.mbr.biz.MbrVO;
import icube.manage.mbr.recipients.biz.MbrRecipientsService;
import icube.manage.mbr.recipients.biz.MbrRecipientsVO;
import icube.manage.members.bplc.biz.BplcService;
import icube.manage.members.bplc.biz.BplcVO;
import icube.market.mbr.biz.MbrSession;

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

	@Resource(name = "biztalkConsultService")
	private BiztalkConsultService biztalkConsultService;

	@Resource(name = "mbrConsltGdsService")
	private MbrConsltGdsService mbrConsltGdsService;
	
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
	public synchronized Map<String, Object> addMbrConslt(
			MbrConsltVO mbrConsltVO,
			Boolean saveRecipientInfo,
			@RequestParam(value="ctgry10Nms[]", required = false) String[] ctgry10Nms, //판매 카테고리명
			@RequestParam(value="ctgry20Nms[]", required = false) String[] ctgry20Nms  //대여 카테고리명
		)throws Exception {

		Map <String, Object> resultMap = new HashMap<String, Object>();

		try {
			//복지용구상담인데 선택한 복지용구 품목이 없는 경우
			int ctgry10Length = ctgry10Nms == null ? 0 : ctgry10Nms.length;
			int ctgry20Length = ctgry20Nms == null ? 0 : ctgry20Nms.length;
			if ("equip_ctgry".equals(mbrConsltVO.getPrevPath()) && (ctgry10Length + ctgry20Length == 0)) {
				resultMap.put("success", false);
                resultMap.put("msg", "관심 복지용구를 선택하세요");
                return resultMap;
			}
			
			MbrRecipientsVO mbrRecipient = mbrRecipientsService.selectMbrRecipientsByRecipientsNo(mbrConsltVO.getRecipientsNo());			
			//수굽저 정보 저장동의시 같은 수급자명이 다른 수급자명으로 등록하려는 경우
			if (saveRecipientInfo) {
	            List<MbrRecipientsVO> srchMbrRecipientList = mbrRecipientsService.selectMbrRecipientsByMbrUniqueId(mbrSession.getUniqueId());
	            if (srchMbrRecipientList.stream().filter(f -> mbrConsltVO.getMbrNm().equals(f.getRecipientsNm()) && f.getRecipientsNo() != mbrConsltVO.getRecipientsNo()).count() > 0) {
	                resultMap.put("success", false);
	                resultMap.put("msg", "이미 등록한 수급자입니다 (수급자명을 확인하세요)");
	                return resultMap;
	            }
			}
			
			//같은 상담(prev_path)중 진행중인 상담이 있다면 불가능
			//수급자 최근 상담 조회(진행 중인 상담 체크)
			MbrConsltVO recipientConslt = mbrConsltService.selectRecentConsltByRecipientsNo(mbrRecipient.getRecipientsNo(), mbrConsltVO.getPrevPath());
			if (recipientConslt != null && (
					!"CS03".equals(recipientConslt.getConsltSttus()) &&
					!"CS04".equals(recipientConslt.getConsltSttus()) &&
					!"CS09".equals(recipientConslt.getConsltSttus()) &&
					!"CS06".equals(recipientConslt.getConsltSttus())
					)) {
				resultMap.put("success", false);
				resultMap.put("msg", "진행중인 " + CodeMap.PREV_PATH.get(mbrConsltVO.getPrevPath()) + "이 있습니다.");
				return resultMap;
			}
			
			
			//요양인정번호를 입력한 경우 조회 가능한지 유효성 체크
			if (EgovStringUtil.isNotEmpty(mbrConsltVO.getRcperRcognNo())) {
				Map<String, Object> returnMap = tilkoApiService.getRecipterInfo(mbrConsltVO.getMbrNm(), mbrConsltVO.getRcperRcognNo(), true);
				
				Boolean result = (Boolean) returnMap.get("result");
				if (result == false) {
					resultMap.put("success", false);
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
				
				
				//복지용구상담인 경우 선택 복지용구 정보 추가 저장
				if ("equip_ctgry".equals(mbrConsltVO.getPrevPath())) {
					mbrConsltGdsService.insertMbrConsltGds(srchMbrConslt.getConsltNo(), ctgry10Nms, ctgry20Nms);
				}
				
				
				//1:1 상담신청시 관리자에게 알림 메일 발송
				mbrConsltService.sendConsltRequestEmail(mbrConsltVO);
			}

			MbrVO mbrVO = mbrService.selectMbrByUniqueId(mbrConsltVO.getRegUniqueId());
			biztalkConsultService.sendOnTalkCreated(mbrVO, mbrRecipient, insertCnt); 

			resultMap.put("success", true);
		} catch (Exception ex) {
			resultMap.put("success", false);
			resultMap.put("msg", "상담신청에 실패하였습니다");
		}
		return resultMap;
	}
}
