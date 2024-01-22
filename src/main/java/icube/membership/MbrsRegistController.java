package icube.membership;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.egovframe.rte.fdl.string.EgovStringUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.security.crypto.bcrypt.BCrypt;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.View;

import icube.common.file.biz.FileService;
import icube.common.framework.abst.CommonAbstractController;
import icube.common.framework.view.JavaScript;
import icube.common.framework.view.JavaScriptView;
import icube.common.util.DateUtil;
import icube.common.util.WebUtil;
import icube.common.util.egov.EgovDoubleSubmitHelper;
import icube.common.values.CodeMap;
import icube.manage.mbr.mbr.biz.MbrAgreementVO;
import icube.manage.mbr.mbr.biz.MbrAuthVO;
import icube.manage.mbr.mbr.biz.MbrService;
import icube.manage.mbr.mbr.biz.MbrVO;
import icube.manage.mbr.recipients.biz.MbrRecipientsService;
import icube.manage.mbr.recipients.biz.MbrRecipientsVO;
import icube.manage.sysmng.terms.TermsService;
import icube.manage.sysmng.terms.TermsVO;
import icube.market.mbr.biz.MbrSession;

/**
 * 회원가입
 * @author ogy
 *
 */
@Controller
@RequestMapping(value = "#{props['Globals.Membership.path']}")
public class MbrsRegistController extends CommonAbstractController{

	@Resource(name = "mbrService")
	private MbrService mbrService;

	@Resource(name = "fileService")
	private FileService fileService;

	@Resource(name= "mbrRecipientsService")
	private MbrRecipientsService mbrRecipientsService;

	@Resource(name = "termsService")
	private TermsService termsService;

	@Value("#{props['Globals.Server.Dir']}")
	private String serverDir;

	@Value("#{props['Globals.File.Upload.Dir']}")
	private String fileUploadDir;

	@Value("#{props['Globals.Planner.path']}")
	private String plannerPath;

	@Value("#{props['Globals.Main.path']}")
	private String mainPath;

	@Value("#{props['Globals.Membership.path']}")
	private String membershipPath;

	@Value("#{props['Globals.Nonmember.session.key']}")
	private String NONMEMBER_SESSION_KEY;

	@Autowired
	private MbrSession mbrSession;


	@RequestMapping(value = "regist")
	public String registStep(
			HttpServletRequest request
			, Model model
			) throws Exception {

		return "/membership/regist";
	}


	/**
	 * 본인인증 및 약관동의
	 */
	@RequestMapping(value = "registStep1")
	public String registStep1(
			HttpServletRequest request
			, HttpSession session
			, Model model)throws Exception {

		// 로그인 체크
		if(mbrSession.isLoginCheck()){
			return  "redirect:/" + plannerPath + "/index";
		}

		MbrAgreementVO mbrAgreementVO = new MbrAgreementVO();
		Date now = new Date();
		mbrAgreementVO.setTermsDt(now);
		mbrAgreementVO.setPrivacyDt(now);
		mbrAgreementVO.setProvisionDt(now);
		mbrAgreementVO.setThirdPartiesDt(now);
		model.addAttribute("mbrAgreementVO", mbrAgreementVO);

		TermsVO termsVO;
		termsVO = termsService.selectListJoinVO("TERMS");
		if (termsVO != null){
			model.addAttribute("termsTerms", termsVO.getContentBody());
		}

		termsVO = termsService.selectListJoinVO("PRIVACY");
		if (termsVO != null){
			model.addAttribute("termsPrivacy", termsVO.getContentBody());
		}

		return "/membership/regist_step1";
	}

	/**
	 * 정보 입력
	 */
	@RequestMapping(value = "registStep2")
	public String registStep2(
			MbrVO mbrVO
			, MbrAgreementVO mbrAgreementVO
			, @RequestParam(value="mbrNm", required=false) String mbrNm
			, @RequestParam(value="mblTelno", required=false) String mblTelno
			, @RequestParam(value="gender", required=false) String gender
			, @RequestParam(value="brdt", required=false) String brdt
			, @RequestParam(value="receiptId", required=false) String receiptId
			, HttpServletRequest request
			, HttpSession session
			, Model model)throws Exception {

		// 로그인 체크
		if(mbrSession.isLoginCheck()){
			return  "redirect:/" + plannerPath + "/index";
		}
		SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");

		MbrVO certMbrInfoVO = new MbrVO();
		if(EgovStringUtil.isNotEmpty(mbrNm) && EgovStringUtil.isNotEmpty(mblTelno)) {

	        Date sBrdt = formatter.parse(DateUtil.convertDate(brdt, "yyyy-MM-dd"));

	        certMbrInfoVO.setMbrNm(mbrNm);
	        certMbrInfoVO.setMblTelno(mblTelno);
	        certMbrInfoVO.setGender(gender);
	        certMbrInfoVO.setBrdt(sBrdt);

		}else if(EgovStringUtil.isNotEmpty(receiptId)) {
			//본인인증 체크
			Map<String, Object> resultMap = mbrService.certificateBootpay(receiptId);
			if ((boolean)resultMap.get("valid") == false) {
				model.addAttribute("alertMsg", (String)resultMap.get("msg"));
				return "/common/msg";
			}
			
			certMbrInfoVO = (MbrVO)resultMap.get("certMbrInfoVO");
		}else {
			model.addAttribute("alertMsg", "잘못된 방법으로 접근하였습니다.");
			return "/common/msg";
		}

		
		//바인딩 회원 체크
		MbrAuthVO checkAuthVO = new MbrAuthVO();
		checkAuthVO.setJoinTy("E");
		checkAuthVO.setCiKey(certMbrInfoVO.getCiKey());
		Map<String, Object> checkMap = mbrService.checkDuplicateMbrForRegist(checkAuthVO, certMbrInfoVO.getDiKey());
		
		if ((boolean)checkMap.get("valid") == false) {
			//계정 연결 안내 페이지 이동
			if (checkMap.containsKey("bindingMbr")) {
				MbrVO bindingMbr = (MbrVO) checkMap.get("bindingMbr");
				certMbrInfoVO.setUniqueId(bindingMbr.getUniqueId());
				certMbrInfoVO.setJoinTy("E");
				mbrSession.setParms(certMbrInfoVO, false);
				
				return "redirect:/membership/binding";
			}
			
			model.addAttribute("alertMsg", (String)checkMap.get("msg"));
			if (checkMap.containsKey("location")) {
				model.addAttribute("goUrl", (String)checkMap.get("location"));
			}
			return "/common/msg";
		}
		

		mbrSession.setParms(certMbrInfoVO, false);
		
		Date now = new Date();
		mbrVO.setSmsRcptnDt(now);
		mbrVO.setEmlRcptnDt(now);
		mbrVO.setTelRecptnDt(now);

        session.setAttribute(NONMEMBER_SESSION_KEY, mbrSession);
		session.setMaxInactiveInterval(60*5);

		model.addAttribute("noMbrVO", certMbrInfoVO);

		model.addAttribute("recipterYnCode", CodeMap.RECIPTER_YN);
		model.addAttribute("expirationCode", CodeMap.EXPIRATION);
		model.addAttribute("genderCode", CodeMap.GENDER);
		model.addAttribute("itrstFieldCode", CodeMap.ITRST_FIELD);
		model.addAttribute("mbrRelationCode", CodeMap.MBR_RELATION_CD);

		return "/membership/regist_step2";
	}

	/**
	 * 회원가입 등록
	 * @param mbrVO
	 * @param 장기요양정보
	 */
	@RequestMapping(value = "action")
	public View action(
			MbrVO mbrVO
			, MbrAgreementVO mbrAgreementVO
			, String[] relationCds
			, String[] recipientsNms
			, String[] rcperRcognNos
			, MultipartHttpServletRequest multiReq
			, @RequestParam Map <String, Object>reqMap
			, HttpSession session
			, HttpServletRequest request) throws Exception {

		JavaScript javaScript = new JavaScript();

		//가입 매체 구분
		mbrVO.setJoinCours(WebUtil.getDevice(request));
		mbrVO.setJoinTy("E"); //이로움 가입

		// 더블 서브밋 방지
		if (EgovDoubleSubmitHelper.checkAndSaveToken("preventTokenKey", request)) {

			//비밀번호 암호화
			if(EgovStringUtil.isNotEmpty(mbrVO.getPswd())) {
				String encPswd = BCrypt.hashpw(mbrVO.getPswd(), BCrypt.gensalt());
				mbrVO.setPswd(encPswd);
			}

			MbrVO noMbrVO = (MbrVO) session.getAttribute(NONMEMBER_SESSION_KEY);


			//인증정보 리턴
			mbrVO.setCiKey(noMbrVO.getCiKey());
			mbrVO.setDiKey(noMbrVO.getDiKey()); //di
			mbrVO.setMbrNm(noMbrVO.getMbrNm());
			mbrVO.setMblTelno(noMbrVO.getMblTelno());
			mbrVO.setGender(noMbrVO.getGender());
			mbrVO.setBrdt(noMbrVO.getBrdt());

			//소문자 치환
			mbrVO.setMbrId(mbrVO.getMbrId().toLowerCase());

			//정보 등록
			mbrService.insertMbr(mbrVO);
			
			
			//회원가입 후 부가정보 등록
			mbrService.workAfterMbrRegist(mbrVO, mbrAgreementVO);
			
			
			//수급자 정보 등록
			try {
				//회원의 수급자 정보 등록
				MbrRecipientsVO[] mbrRecipientsArray = new MbrRecipientsVO[recipientsNms.length];
				for (int i = 0; i < recipientsNms.length; i++) {
					mbrRecipientsArray[i] = new MbrRecipientsVO();
					mbrRecipientsArray[i].setMbrUniqueId(mbrVO.getUniqueId());
					if (i < relationCds.length) {
						mbrRecipientsArray[i].setRelationCd(relationCds[i]);
					}
					if (i < recipientsNms.length) {
						mbrRecipientsArray[i].setRecipientsNm(recipientsNms[i]);
					}
					if (i < rcperRcognNos.length) {
						mbrRecipientsArray[i].setRcperRcognNo(rcperRcognNos[i]);
					}
					mbrRecipientsArray[i].setRecipientsYn(EgovStringUtil.isNotEmpty(mbrRecipientsArray[i].getRcperRcognNo()) ? "Y" : "N");
				}
				mbrRecipientsService.insertMbrRecipients(mbrRecipientsArray);
			} catch (Exception e) {
				log.debug("회원 가입 수급자 등록 실패" + e.toString());
			}
			

			//임시정보 추가
			mbrSession.setParms(mbrVO, false);
			//회원가입 처리
			mbrSession.setRegistCheck(true);
	        session.setAttribute(NONMEMBER_SESSION_KEY, mbrSession);
			session.setMaxInactiveInterval(60*60);

			javaScript.setLocation("/"+membershipPath+"/registStep3");
		}else {
			javaScript.setLocation("/"+membershipPath);
		}

		return new JavaScriptView(javaScript);
	}


	/**
	 * 가입완료
	 */
	@RequestMapping(value = "registStep3")
	public String registStep3(
			HttpServletRequest request
			, HttpSession session
			, Model model)throws Exception {

		// 로그인 체크
		if(mbrSession.isLoginCheck()){
			return  "redirect:/" + plannerPath + "/index";
		}

		MbrVO noMbrVO = (MbrVO) session.getAttribute(NONMEMBER_SESSION_KEY);
		if(noMbrVO == null) { //임시세션 값이 없으면 첫스탭으로
			return  "redirect:/" + membershipPath + "/registStep1";
		}

		model.addAttribute("noMbrVO", noMbrVO);

		return "/membership/regist_step3";
	}


	/**
	 * 추천인 아이디 확인
	 * @param rcmdtnId
	 * @return result
	 */
	@RequestMapping(value="rcmdIdChk.json")
	@ResponseBody
	public Map<String, Object> mbrIdChk(
			@RequestParam(value="rcmdtnId", required=true) String rcmdtnId
			, @RequestParam Map <String,Object> reqMap
			, HttpServletRequest request
			, Model model)throws Exception {

		boolean result = false;

		int mbrCnt = mbrService.selectMbrIdChk(rcmdtnId.toLowerCase());
		if(mbrCnt > 0) {
			result = true;
		}

		Map<String, Object> resultMap = new HashMap<String, Object>();
		resultMap.put("result", result);
		return resultMap;
	}
	
	/**
	 * 간편 로그인 최초 회원가입
	 */
	@RequestMapping(value = "sns/regist")
	public String registSns(
			@RequestParam(required=false) String complete
			, HttpServletRequest request
			, HttpSession session
			, Model model)throws Exception {
		
		if (EgovStringUtil.isEmpty(complete)) {
			if (mbrSession == null || mbrSession.isLoginCheck() == false) {
				model.addAttribute("alertMsg", "세션이 만료되었습니다. 처음부터 다시 시작해 주세요.");
	            model.addAttribute("goUrl", "/membership/login");
	            mbrSession.setParms(new MbrVO(), false);
	            return "/common/msg";
			}
            
			//SNS 로그인에서 넘어온 정보
			MbrVO tempMbrVO = mbrSession;
			
			Date now = new Date();
			tempMbrVO.setSmsRcptnDt(now);
			tempMbrVO.setEmlRcptnDt(now);
			tempMbrVO.setTelRecptnDt(now);
			model.addAttribute("mbrVO", tempMbrVO);
			
			MbrAgreementVO mbrAgreementVO = new MbrAgreementVO();
			mbrAgreementVO.setTermsDt(now);
			mbrAgreementVO.setPrivacyDt(now);
			mbrAgreementVO.setProvisionDt(now);
			mbrAgreementVO.setThirdPartiesDt(now);
			model.addAttribute("mbrAgreementVO", mbrAgreementVO);
			model.addAttribute("expirationCode", CodeMap.EXPIRATION);
		} else {
			model.addAttribute("mbrVO", new MbrVO());
			model.addAttribute("isComplete", complete);
		}
		
		
		return "/membership/sns_regist";
	}
	
	/**
	 * 간편 로그인 회원가입 등록
	 * @param mbrVO
	 * @param 장기요양정보
	 */
	@RequestMapping(value = "/sns/action")
	public View snsAction(
			MbrVO mbrVO
			, MbrAgreementVO mbrAgreementVO
			, @RequestParam(value="receiptId", required=true) String receiptId
			, @RequestParam(value="uniqueId", required=true) String uniqueId
			, HttpSession session
			, HttpServletRequest request) throws Exception {
		JavaScript javaScript = new JavaScript();
		MbrVO certMbrInfoVO = new MbrVO();
		
		if (mbrSession == null || mbrSession.isLoginCheck() == false) {
			javaScript.setMessage("세션이 만료되었습니다. 처음부터 다시 시작해 주세요.");
			javaScript.setLocation("/membership/login");
			mbrSession.setParms(new MbrVO(), false);
			return new JavaScriptView(javaScript);
		}
		MbrVO tempMbrVO = mbrSession;
		
		try {
			// 더블 서브밋 방지
			if (EgovDoubleSubmitHelper.checkAndSaveToken("preventTokenKey", request)) {

				//본인인증 체크
				Map<String, Object> resultMap = mbrService.certificateBootpay(receiptId);
				if ((boolean)resultMap.get("valid") == false) {
					javaScript.setMessage((String)resultMap.get("msg"));
					javaScript.setLocation("/membership/login");
					mbrSession.setParms(new MbrVO(), false);
					return new JavaScriptView(javaScript);
				}
				
				certMbrInfoVO = (MbrVO)resultMap.get("certMbrInfoVO");
				
				
				//바인딩 회원 체크
				MbrAuthVO checkAuthVO = new MbrAuthVO();
				checkAuthVO.setJoinTy(tempMbrVO.getJoinTy());
				checkAuthVO.setNaverAppId(tempMbrVO.getNaverAppId());
				checkAuthVO.setKakaoAppId(tempMbrVO.getKakaoAppId());
				checkAuthVO.setCiKey(certMbrInfoVO.getCiKey());
				Map<String, Object> checkMap = mbrService.checkDuplicateMbrForRegist(checkAuthVO, certMbrInfoVO.getDiKey());
				
				if ((boolean)checkMap.get("valid") == false) {
					//계정 연결 안내 페이지 이동
					if (checkMap.containsKey("bindingMbr")) {
						MbrVO bindingMbr = (MbrVO) checkMap.get("bindingMbr");
						certMbrInfoVO.setUniqueId(bindingMbr.getUniqueId());
						certMbrInfoVO.setJoinTy(tempMbrVO.getJoinTy());
						certMbrInfoVO.setNaverAppId(tempMbrVO.getNaverAppId());
						certMbrInfoVO.setKakaoAppId(tempMbrVO.getKakaoAppId());
						certMbrInfoVO.setEml(tempMbrVO.getEml());
						mbrSession.setParms(certMbrInfoVO, false);
						
						javaScript.setLocation("/membership/binding");
						return new JavaScriptView(javaScript);
					}
					
					javaScript.setMessage((String)checkMap.get("msg"));
					if (checkMap.containsKey("location")) {
						javaScript.setLocation((String)checkMap.get("location"));
					}
					return new JavaScriptView(javaScript);
				}
				

				//회원가입 처리
				tempMbrVO.setCiKey(certMbrInfoVO.getCiKey());
				tempMbrVO.setDiKey(certMbrInfoVO.getDiKey());
				tempMbrVO.setMbrNm(certMbrInfoVO.getMbrNm());
				tempMbrVO.setMblTelno(certMbrInfoVO.getMblTelno());
				tempMbrVO.setGender(certMbrInfoVO.getGender());
				tempMbrVO.setBrdt(certMbrInfoVO.getBrdt());
		        
				tempMbrVO.setZip(mbrVO.getZip());
				tempMbrVO.setAddr(mbrVO.getAddr());
				tempMbrVO.setDaddr(mbrVO.getDaddr());
		        
				tempMbrVO.setEml(mbrVO.getEml());
				tempMbrVO.setPrvcVldPd(mbrVO.getPrvcVldPd());
				tempMbrVO.setSmsRcptnYn(mbrVO.getSmsRcptnYn());
				tempMbrVO.setSmsRcptnDt(mbrVO.getSmsRcptnDt());
				tempMbrVO.setEmlRcptnYn(mbrVO.getEmlRcptnYn());
				tempMbrVO.setEmlRcptnDt(mbrVO.getEmlRcptnDt());
				tempMbrVO.setTelRecptnYn(mbrVO.getTelRecptnYn());
				tempMbrVO.setTelRecptnDt(mbrVO.getTelRecptnDt());
				tempMbrVO.setSnsRegistDt(new Date());
		        
		        //간편로그인은 ID를 새로 생성해준다.
		        String newId = mbrService.generateMbrId(tempMbrVO.getJoinTy());
		        tempMbrVO.setMbrId(newId);
				mbrService.insertMbr(tempMbrVO);
				
				
				//회원가입 후 부가정보 등록
				mbrService.workAfterMbrRegist(tempMbrVO, mbrAgreementVO);
				

				// 최근 접속 일시 업데이트
				mbrService.updateRecentDtAndLgnTy(tempMbrVO.getUniqueId(), tempMbrVO, tempMbrVO.getJoinTy());
				
				//임시정보 추가(등록하러가기 기능 때문에 로그인 처리로 변경)
				mbrSession.setParms(tempMbrVO, true);
				mbrSession.setMbrInfo(session, mbrSession);
				//회원가입 처리
				mbrSession.setRegistCheck(true);

				javaScript.setLocation("/"+membershipPath+"/sns/regist?complete=Y");
			}else {
				javaScript.setMessage("잘못된 접근입니다.");
				javaScript.setLocation("/");
			}
		} catch (Exception ex) {
			javaScript.setMessage("가입 중 오류가 발생하였습니다.");
			javaScript.setLocation("/");
		}

		return new JavaScriptView(javaScript);
	}
	
	/**
	 * 가입취소
	 */
	@RequestMapping(value = "cancel/sns/regist")
	public String cancelRegistSns(
			HttpServletRequest request
			, HttpSession session
			, Model model)throws Exception {
		
		mbrService.deleteMbr(mbrSession.getUniqueId());
		mbrSession.setParms(new MbrVO(), false);
		
		return "redirect:/membership/login";
	}
}
