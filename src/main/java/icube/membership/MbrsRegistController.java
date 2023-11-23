package icube.membership;

import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.GregorianCalendar;
import java.util.HashMap;
import java.util.List;
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

import icube.common.api.biz.BiztalkConsultService;
import icube.common.api.biz.BootpayApiService;
import icube.common.file.biz.FileService;
import icube.common.framework.abst.CommonAbstractController;
import icube.common.framework.view.JavaScript;
import icube.common.framework.view.JavaScriptView;
import icube.common.mail.MailService;
import icube.common.util.DateUtil;
import icube.common.util.FileUtil;
import icube.common.util.ValidatorUtil;
import icube.common.util.WebUtil;
import icube.common.util.egov.EgovDoubleSubmitHelper;
import icube.common.values.CodeMap;
import icube.manage.mbr.mbr.biz.MbrAgreementVO;
import icube.manage.mbr.mbr.biz.MbrService;
import icube.manage.mbr.mbr.biz.MbrVO;
import icube.manage.mbr.recipients.biz.MbrRecipientsService;
import icube.manage.mbr.recipients.biz.MbrRecipientsVO;
import icube.manage.mbr.recipter.biz.RecipterInfoService;
import icube.manage.promotion.coupon.biz.CouponLstService;
import icube.manage.promotion.coupon.biz.CouponLstVO;
import icube.manage.promotion.coupon.biz.CouponService;
import icube.manage.promotion.coupon.biz.CouponVO;
import icube.manage.promotion.mlg.biz.MbrMlgService;
import icube.manage.promotion.point.biz.MbrPointService;
import icube.manage.sysmng.terms.TermsService;
import icube.manage.sysmng.terms.TermsVO;
import icube.market.mbr.biz.MbrSession;
import icube.membership.info.biz.DlvyService;
import icube.membership.info.biz.DlvyVO;

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

	@Resource(name = "recipterInfoService")
	private RecipterInfoService recipterInfoService;

	@Resource(name = "mbrMlgService")
	private MbrMlgService mbrMlgService;

	@Resource(name = "mbrPointService")
	private MbrPointService mbrPointService;

	@Resource(name = "dlvyService")
	private DlvyService dlvyService;

	@Resource(name = "couponService")
	private CouponService couponService;

	@Resource(name = "couponLstService")
	private CouponLstService couponLstService;

	@Resource(name="mailService")
	private MailService mailService;

	@Resource(name= "bootpayApiService")
	private BootpayApiService bootpayApiService;
	
	@Resource(name= "mbrRecipientsService")
	private MbrRecipientsService mbrRecipientsService;
	
	@Resource(name = "biztalkConsultService")
	private BiztalkConsultService biztalkConsultService;

	@Resource(name = "termsService")
	private TermsService termsService;

	@Value("#{props['Mail.Form.FilePath']}")
	private String mailFormFilePath;

	@Value("#{props['Mail.Username']}")
	private String sendMail;

	@Value("#{props['Mail.Testuser']}")
	private String mailTestuser;

	@Value("#{props['Profiles.Active']}")
	private String activeMode;

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
	
	private SimpleDateFormat format = new SimpleDateFormat("yyyyMMdd HHmmss");

	

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

		MbrVO noMbrVO = new MbrVO();
		if(EgovStringUtil.isNotEmpty(mbrNm) && EgovStringUtil.isNotEmpty(mblTelno)) {

	        Date sBrdt = formatter.parse(DateUtil.convertDate(brdt, "yyyy-MM-dd"));

			noMbrVO.setMbrNm(mbrNm);
			noMbrVO.setMblTelno(mblTelno);
			noMbrVO.setGender(gender);
			noMbrVO.setBrdt(sBrdt);

		}else if(EgovStringUtil.isNotEmpty(receiptId)) {
			certificateBootpay(receiptId, noMbrVO);
			
			Calendar calendar = new GregorianCalendar();
	        calendar.setTime(noMbrVO.getBrdt());
			
			//만 14세 미만인 경우 회원가입을 할 수 없다.
	        if (DateUtil.getRealAge(calendar.get(Calendar.YEAR), calendar.get(Calendar.MONTH) + 1, calendar.get(Calendar.DAY_OF_MONTH)) < 14) {
	        	model.addAttribute("alertMsg", "14세 이상만 가입 가능합니다.");
				return "/common/msg";
	        }

	        System.out.println("noMbrVO: " + noMbrVO.toString());
		}else {
			model.addAttribute("alertMsg", "잘못된 방법으로 접근하였습니다.");
			return "/common/msg";
		}

		// 가입된 회원인지 체크
		Map<String, Object> paramMap = new HashMap<String, Object>();
		paramMap.put("srchMbrNm", noMbrVO.getMbrNm());
		paramMap.put("srchMblTelno", noMbrVO.getMblTelno());
		paramMap.put("srchMbrStts", "NORMAL");

		MbrVO findMbrVO = mbrService.selectMbr(paramMap);
		if(findMbrVO != null) {
			if(findMbrVO.getJoinTy().equals("N")) {
				model.addAttribute("alertMsg", "네이버 계정으로 가입된 회원입니다.");
			}else if(findMbrVO.getJoinTy().equals("K")) {
				model.addAttribute("alertMsg", "카카오 계정으로 가입된 회원입니다.");
			}else {
				model.addAttribute("alertMsg", "가입된 회원정보가 존재합니다.아이디 찾기 또는 비밀번호 찾기를 진행하시기 바랍니다.");
			}
			model.addAttribute("goUrl", "/"+mainPath + "/login?returnUrl=/main");
			return "/common/msg";
		}

		// 재가입 7일 이내 불가
		paramMap.clear();
		paramMap.put("srchDiKey", noMbrVO.getDiKey());
		paramMap.put("srchMbrStts", "EXIT");
		paramMap.put("srchWhdwlDt", 7);
		int resultCnt = mbrService.selectMbrCount(paramMap);

		if(resultCnt > 0) {
			model.addAttribute("alertMsg", "탈퇴 후 7일 이내의 재가입은 불가능합니다.");
			return "/common/msg";
		}


		mbrSession.setParms(noMbrVO, false);
		
		Date now = new Date();
		mbrVO.setSmsRcptnDt(now);
		mbrVO.setEmlRcptnDt(now);
		mbrVO.setTelRecptnDt(now);

        session.setAttribute(NONMEMBER_SESSION_KEY, mbrSession);
		session.setMaxInactiveInterval(60*5);

		model.addAttribute("noMbrVO", noMbrVO);

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

			System.out.println("action noMbrVO:" + noMbrVO.toString());


			//인증정보 리턴
			mbrVO.setDiKey(noMbrVO.getDiKey()); //di
			mbrVO.setMbrNm(noMbrVO.getMbrNm());
			mbrVO.setMblTelno(noMbrVO.getMblTelno());
			mbrVO.setGender(noMbrVO.getGender());
			mbrVO.setBrdt(noMbrVO.getBrdt());

			//소문자 치환
			mbrVO.setMbrId(mbrVO.getMbrId().toLowerCase());

			//정보 등록
			mbrService.insertMbr(mbrVO);
			
			// 모든 항목 동의처리 로그
			String uniqueId = mbrVO.getUniqueId();
			mbrAgreementVO.setMbrUniqueId(uniqueId);
			mbrService.insertMbrAgreement(mbrAgreementVO);

			// 기본 배송지 등록
			DlvyVO dlvyVO = new DlvyVO();
			dlvyVO.setUniqueId(mbrVO.getUniqueId());
			dlvyVO.setDlvyNm(mbrVO.getMbrNm());
			dlvyVO.setNm(mbrVO.getMbrNm());
			dlvyVO.setZip(mbrVO.getZip());
			dlvyVO.setAddr(mbrVO.getAddr());
			dlvyVO.setDaddr(mbrVO.getDaddr());
			dlvyVO.setTelno(mbrVO.getTelno());
			dlvyVO.setMblTelno(mbrVO.getMblTelno());
			dlvyVO.setBassDlvyYn("Y");
			dlvyVO.setUseYn("Y");

			dlvyService.insertBassDlvy(dlvyVO);

			try {
				//회원의 수급자 정보 등록
				MbrRecipientsVO[] mbrRecipientsArray = new MbrRecipientsVO[recipientsNms.length];
				for (int i = 0; i < recipientsNms.length; i++) {
					mbrRecipientsArray[i] = new MbrRecipientsVO();
					mbrRecipientsArray[i].setMbrUniqueId(uniqueId);
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
			
			
			/** 2023-04-05 포인트 지급 삭제 **/

			// 회원가입 쿠폰
			try {
				Map<String, Object> paramMap = new HashMap<String, Object>();
				paramMap.put("srchCouponTy", "JOIN");
				paramMap.put("srchSttusTy", "USE");
				int cnt = couponService.selectCouponCount(paramMap);
				if(cnt > 0) {
					CouponVO couponVO = couponService.selectCoupon(paramMap);
					CouponLstVO couponLstVO = new CouponLstVO();
					couponLstVO.setCouponNo(couponVO.getCouponNo());
					couponLstVO.setUniqueId(dlvyVO.getUniqueId());

					if(couponVO.getUsePdTy().equals("ADAY")) {
						couponLstVO.setUseDay(couponVO.getUsePsbltyDaycnt());
					}

					couponLstService.insertCouponLst(couponLstVO);
				}else {
					log.debug("회원 가입 쿠폰 개수 : " + cnt);
				}
				
				
				// 2023년 11/6 ~ 12/08 까지 5천원 추가 쿠폰 자동 지급
				Date now = new Date();
				String startDtStr = "20231106 000000";
				Date startDt = format.parse(startDtStr);
				String endDtStr = "20231208 235959";
				Date endDt = format.parse(endDtStr);
				
				//쿠폰발급 기간조건 (크다(1), 같다(0), 작다(-1))
				if (now.compareTo(startDt) >= 0 && now.compareTo(endDt) <= 0) {
					paramMap = new HashMap<String, Object>();
					paramMap.put("srchCouponTy", "JOIN_ADD");
					paramMap.put("srchSttusTy", "USE");
					CouponVO couponVO = couponService.selectCoupon(paramMap);
					
					//회원가입 추가발급 쿠폰이 있는 경우
					if (couponVO != null) {
						CouponLstVO couponLstVO = new CouponLstVO();
						couponLstVO.setCouponNo(couponVO.getCouponNo());
						couponLstVO.setUniqueId(dlvyVO.getUniqueId());
						
						if(couponVO.getUsePdTy().equals("ADAY")) {
							couponLstVO.setUseDay(couponVO.getUsePsbltyDaycnt());
						}

						couponLstService.insertCouponLst(couponLstVO);
					}
				}
				
			}catch(Exception e) {
				log.debug("회원 가입 쿠폰 발송 실패" + e.toString());
			}

			//임시정보 추가
			mbrSession.setParms(mbrVO, false);
			//회원가입 처리
			mbrSession.setRegistCheck(true);
	        session.setAttribute(NONMEMBER_SESSION_KEY, mbrSession);
			session.setMaxInactiveInterval(60*60);
			
			biztalkConsultService.sendOnJoinComleted(mbrVO);

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

		// 가입 축하 메일 발송
		try {
			if(ValidatorUtil.isEmail(noMbrVO.getEml())) {
				String MAIL_FORM_PATH = mailFormFilePath;
				String mailForm = FileUtil.readFile(MAIL_FORM_PATH+"mail_join.html");

				mailForm = mailForm.replace("{mbrNm}", noMbrVO.getMbrNm()); // 회원 이름
				mailForm = mailForm.replace("{mbrId}", noMbrVO.getMbrId()); // 회원 아이디
				mailForm = mailForm.replace("{mbrEml}", noMbrVO.getEml()); // 회원 이메일
				mailForm = mailForm.replace("{mblTelno}", noMbrVO.getMblTelno()); // 회원 전화번호

				mailForm = mailForm.replace("{company}", "㈜티에이치케이컴퍼니");
				mailForm = mailForm.replace("{name}", "이로움마켓");
				mailForm = mailForm.replace("{addr}", "부산시 금정구 중앙대로 1815, 5층(가루라빌딩)");
				mailForm = mailForm.replace("{brno}", "617-86-14330");
				mailForm = mailForm.replace("{telno}", "2016-부산금정-0114");



				// 메일 발송
				String mailSj = "[이로움ON] 회원 가입을 축하드립니다.";
				if(EgovStringUtil.equals("real", activeMode)) {
					mailService.sendMail(sendMail, noMbrVO.getEml(), mailSj, mailForm);
				}else if(EgovStringUtil.equals("dev", activeMode)) {
					mailService.sendMail(sendMail, noMbrVO.getEml(), mailSj, mailForm);
				} else {
					mailService.sendMail(sendMail, this.mailTestuser, mailSj, mailForm); //테스트
				}
			} else {
				log.debug("회원 가입 알림 EMAIL 전송 실패 :: 이메일 체크 " + noMbrVO.getEml());
			}
		} catch (Exception e) {
			log.debug("회원 가입 알림 EMAIL 전송 실패 :: " + e.toString());
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
			@RequestParam(required=false) String uid
			, @RequestParam(required=false) String complete
			, HttpServletRequest request
			, HttpSession session
			, Model model)throws Exception {
		
		if (EgovStringUtil.isNotEmpty(uid)) {
			MbrVO srchMbr = mbrService.selectMbrByUniqueId(uid);
			Date now = new Date();
			srchMbr.setSmsRcptnDt(now);
			srchMbr.setEmlRcptnDt(now);
			srchMbr.setTelRecptnDt(now);
			model.addAttribute("mbrVO", srchMbr);
			
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
			, HttpServletRequest request
			, Model model) throws Exception {
		JavaScript javaScript = new JavaScript();
		
		// 더블 서브밋 방지
		if (EgovDoubleSubmitHelper.checkAndSaveToken("preventTokenKey", request)) {

			//본인인증 체크
			certificateBootpay(receiptId, mbrVO);

			Calendar calendar = new GregorianCalendar();
	        calendar.setTime(mbrVO.getBrdt());
			
			//만 14세 미만인 경우 회원가입을 할 수 없다.
	        if (DateUtil.getRealAge(calendar.get(Calendar.YEAR), calendar.get(Calendar.MONTH) + 1, calendar.get(Calendar.DAY_OF_MONTH)) < 14) {
				javaScript.setMessage("14세 이상만 가입 가능합니다.");
				javaScript.setLocation("/membership/login");
				return new JavaScriptView(javaScript);
	        }
			
			//정보 수정
	        MbrVO srchMbr = mbrService.selectMbrByUniqueId(uniqueId); 
	        srchMbr.setDiKey(mbrVO.getDiKey());
	        srchMbr.setMbrNm(mbrVO.getMbrNm());
	        srchMbr.setMblTelno(mbrVO.getMblTelno());
	        srchMbr.setGender(mbrVO.getGender());
	        srchMbr.setBrdt(mbrVO.getBrdt());
	        
	        srchMbr.setZip(mbrVO.getZip());
	        srchMbr.setAddr(mbrVO.getAddr());
	        srchMbr.setDaddr(mbrVO.getDaddr());
	        
	        srchMbr.setPrvcVldPd(mbrVO.getPrvcVldPd());
	        srchMbr.setSmsRcptnYn(mbrVO.getSmsRcptnYn());
	        srchMbr.setSmsRcptnDt(mbrVO.getSmsRcptnDt());
	        srchMbr.setEmlRcptnYn(mbrVO.getEmlRcptnYn());
	        srchMbr.setEmlRcptnDt(mbrVO.getEmlRcptnDt());
	        srchMbr.setTelRecptnYn(mbrVO.getTelRecptnYn());
	        srchMbr.setTelRecptnDt(mbrVO.getTelRecptnDt());
	        srchMbr.setSnsRegistDt(new Date());
	        
	        //간편로그인은 ID를 새로 생성해준다.
	        String newId = mbrService.generateMbrId(srchMbr.getJoinTy());
	        srchMbr.setMbrId(newId);
			mbrService.updateMbr(srchMbr);

			// 모든 항목 동의처리 로그
			mbrAgreementVO.setMbrUniqueId(srchMbr.getUniqueId());
			mbrService.insertMbrAgreement(mbrAgreementVO);
			
			// 기본 배송지 등록
			DlvyVO dlvyVO = new DlvyVO();
			dlvyVO.setUniqueId(mbrVO.getUniqueId());
			dlvyVO.setDlvyNm(mbrVO.getMbrNm());
			dlvyVO.setNm(mbrVO.getMbrNm());
			dlvyVO.setZip(mbrVO.getZip());
			dlvyVO.setAddr(mbrVO.getAddr());
			dlvyVO.setDaddr(mbrVO.getDaddr());
			dlvyVO.setTelno(mbrVO.getTelno());
			dlvyVO.setMblTelno(mbrVO.getMblTelno());
			dlvyVO.setBassDlvyYn("Y");
			dlvyVO.setUseYn("Y");

			dlvyService.insertBassDlvy(dlvyVO);
			
			// 회원가입 쿠폰
			try {
				Map<String, Object> paramMap = new HashMap<String, Object>();
				paramMap.put("srchCouponTy", "JOIN");
				paramMap.put("srchSttusTy", "USE");
				int cnt = couponService.selectCouponCount(paramMap);
				if(cnt > 0) {
					CouponVO couponVO = couponService.selectCoupon(paramMap);
					CouponLstVO couponLstVO = new CouponLstVO();
					couponLstVO.setCouponNo(couponVO.getCouponNo());
					couponLstVO.setUniqueId(dlvyVO.getUniqueId());

					if(couponVO.getUsePdTy().equals("ADAY")) {
						couponLstVO.setUseDay(couponVO.getUsePsbltyDaycnt());
					}

					couponLstService.insertCouponLst(couponLstVO);
				}else {
					log.debug("회원 가입 쿠폰 개수 : " + cnt);
				}
				
				
				// 2023년 11/6 ~ 12/08 까지 5천원 추가 쿠폰 자동 지급
				Date now = new Date();
				String startDtStr = "20231106 000000";
				Date startDt = format.parse(startDtStr);
				String endDtStr = "20231208 235959";
				Date endDt = format.parse(endDtStr);
				
				//쿠폰발급 기간조건 (크다(1), 같다(0), 작다(-1))
				if (now.compareTo(startDt) >= 0 && now.compareTo(endDt) <= 0) {
					paramMap = new HashMap<String, Object>();
					paramMap.put("srchCouponTy", "JOIN_ADD");
					paramMap.put("srchSttusTy", "USE");
					CouponVO couponVO = couponService.selectCoupon(paramMap);
					
					//회원가입 추가발급 쿠폰이 있는 경우
					if (couponVO != null) {
						CouponLstVO couponLstVO = new CouponLstVO();
						couponLstVO.setCouponNo(couponVO.getCouponNo());
						couponLstVO.setUniqueId(dlvyVO.getUniqueId());
						
						if(couponVO.getUsePdTy().equals("ADAY")) {
							couponLstVO.setUseDay(couponVO.getUsePsbltyDaycnt());
						}

						couponLstService.insertCouponLst(couponLstVO);
					}
				}
			}catch(Exception e) {
				log.debug("회원 가입 쿠폰 발송 실패" + e.toString());
			}

			
			// 최근 접속 일시 업데이트
			mbrService.updateRecentDt(srchMbr.getUniqueId());
			
			//임시정보 추가(등록하러가기 기능떄문에 로그인 처리로 변경)
			mbrSession.setParms(srchMbr, true);
			mbrSession.setMbrInfo(session, mbrSession);
			//회원가입 처리
			mbrSession.setRegistCheck(true);

			biztalkConsultService.sendOnJoinComleted(mbrVO);

			javaScript.setLocation("/"+membershipPath+"/sns/regist?complete=Y");
		}else {
			javaScript.setMessage("잘못된 접근입니다.");
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
	
	
	private void certificateBootpay(String receiptId, MbrVO noMbrVO) throws Exception {
		SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
		
		// 본인인증정보 체크
		HashMap<String, Object> res = bootpayApiService.certificate(receiptId);

		String authData =String.valueOf(res.get("authenticate_data"));
		String[] spAuthData = authData.substring(1, authData.length()-1).split(",");

		HashMap<String, String> authMap = new HashMap<String, String>();
		for(String auth : spAuthData) {
			System.out.println("spAuthData: " + auth.trim());
			String[] spTmp = auth.trim().split("=", 2);
			authMap.put(spTmp[0], spTmp[1]); //key:value
		}
		/*
		 !참고:부트페이 제공문서와 결과 값이 다름
		      결과값에 json 문자열 처리가 정확하지 않아 타입변환이 안됨

		 */
        
		Date sBrdt = formatter.parse(DateUtil.formatDate(authMap.get("birth"), "yyyy-MM-dd")); //생년월일
        
        String mblTelno = authMap.get("phone");
        String gender = authMap.get("gender"); //1.0 > 부트페이 제공문서와 다름
        if(EgovStringUtil.equals("1.0", gender)) {
        	gender = "M";
        }else {
        	gender = "W";
        }

        noMbrVO.setDiKey(authMap.get("di"));
        noMbrVO.setMbrNm(authMap.get("name"));
        noMbrVO.setMblTelno(mblTelno.substring(0, 3) + "-" + mblTelno.substring(3, 7) +"-"+ mblTelno.substring(7, 11));
        noMbrVO.setGender(gender);
        noMbrVO.setBrdt(sBrdt);
	}
}
