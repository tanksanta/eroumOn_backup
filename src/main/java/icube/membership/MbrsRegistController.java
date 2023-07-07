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
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.View;

import icube.common.api.biz.BootpayApiService;
import icube.common.file.biz.FileService;
import icube.common.framework.abst.CommonAbstractController;
import icube.common.framework.view.JavaScript;
import icube.common.framework.view.JavaScriptView;
import icube.common.mail.MailService;
import icube.common.util.ArrayUtil;
import icube.common.util.DateUtil;
import icube.common.util.FileUtil;
import icube.common.util.ValidatorUtil;
import icube.common.util.WebUtil;
import icube.common.util.egov.EgovDoubleSubmitHelper;
import icube.common.values.CodeMap;
import icube.manage.mbr.mbr.biz.MbrService;
import icube.manage.mbr.mbr.biz.MbrVO;
import icube.manage.mbr.recipter.biz.RecipterInfoService;
import icube.manage.mbr.recipter.biz.RecipterInfoVO;
import icube.manage.promotion.coupon.biz.CouponLstService;
import icube.manage.promotion.coupon.biz.CouponLstVO;
import icube.manage.promotion.coupon.biz.CouponService;
import icube.manage.promotion.coupon.biz.CouponVO;
import icube.manage.promotion.mlg.biz.MbrMlgService;
import icube.manage.promotion.point.biz.MbrPointService;
import icube.manage.promotion.point.biz.MbrPointVO;
import icube.market.mbr.biz.MbrSession;
import icube.market.mypage.info.biz.DlvyService;
import icube.market.mypage.info.biz.DlvyVO;

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

	@Value("#{props['Mail.Form.FilePath']}")
	private String mailFormFilePath;

	@Value("#{props['Mail.Username']}")
	private String sendMail;

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

		return "/membership/regist_step1";
	}

	/**
	 * 정보 입력
	 */
	@RequestMapping(value = "registStep2")
	public String registStep2(
			MbrVO mbrVO
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
	        mblTelno = authMap.get("phone");
	        gender = authMap.get("gender"); //1.0 > 부트페이 제공문서와 다름
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

        session.setAttribute(NONMEMBER_SESSION_KEY, mbrSession);
		session.setMaxInactiveInterval(60*5);

		model.addAttribute("noMbrVO", noMbrVO);

		model.addAttribute("recipterYnCode", CodeMap.RECIPTER_YN);
		model.addAttribute("expirationCode", CodeMap.EXPIRATION);
		model.addAttribute("genderCode", CodeMap.GENDER);
		model.addAttribute("itrstFieldCode", CodeMap.ITRST_FIELD);

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
			, @RequestParam (value="rcperRcognNo", required=false) String rcperRcognNo
			, @RequestParam (value="rcognGrad", required=false) String rcognGrad
			, @RequestParam (value="selfBndRt", required=false) String selfBndRt
			, @RequestParam (value="vldBgngYmd", required=false) String vldBgngYmd
			, @RequestParam (value="vldEndYmd", required=false) String vldEndYmd
			, @RequestParam (value="aplcnBgngYmd", required=false) String aplcnBgngYmd
			, @RequestParam (value="aplcnEndYmd", required=false) String aplcnEndYmd
			, @RequestParam (value="sprtAmt", required=false) String sprtAmt
			, @RequestParam (value="bnefBlce", required=false) String bnefBlce
			, @RequestParam (value="itrstField", required=false) String[] itrstFeild
			, @RequestParam (value="testName", required=false) String testName
			, MultipartHttpServletRequest multiReq
			, @RequestParam Map <String, Object>reqMap
			, HttpSession session
			, HttpServletRequest request) throws Exception {

		JavaScript javaScript = new JavaScript();
		Map<String, MultipartFile> fileMap = multiReq.getFileMap();

		// 관심 분야
		String field = ArrayUtil.arrayToString(itrstFeild, ",");
		mbrVO.setItrstField(field);

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

			//이미지 등록
			if (!fileMap.get("uploadFile").isEmpty()) {
				String profileImg = fileService.uploadFile(fileMap.get("uploadFile"), serverDir.concat(fileUploadDir), "PROFL");
				mbrVO.setProflImg(profileImg);
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
			mbrVO.setRcmdtnId(mbrVO.getRcmdtnId().toLowerCase());
			mbrVO.setRcmdtnMbrsId(mbrVO.getRcmdtnMbrsId().toLowerCase());

			//정보 등록
			mbrService.insertMbr(mbrVO);

			SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");

			if(mbrVO.getRecipterYn().equals("Y")) {
				RecipterInfoVO recipterInfoVO = new RecipterInfoVO();
				String uniqueId = mbrVO.getUniqueId();

				recipterInfoVO.setUniqueId(uniqueId);
				recipterInfoVO.setRcperRcognNo(rcperRcognNo);
				recipterInfoVO.setRcognGrad(rcognGrad);
				recipterInfoVO.setSelfBndRt(EgovStringUtil.string2integer(selfBndRt));
				recipterInfoVO.setVldBgngYmd(formatter.parse(vldBgngYmd));
				recipterInfoVO.setVldEndYmd(formatter.parse(vldEndYmd));
				recipterInfoVO.setAplcnBgngYmd(formatter.parse(aplcnBgngYmd));
				recipterInfoVO.setAplcnEndYmd(formatter.parse(aplcnEndYmd));
				recipterInfoVO.setBnefBlce(EgovStringUtil.string2integer(bnefBlce));
				recipterInfoVO.setSprtAmt(EgovStringUtil.string2integer(sprtAmt));
				recipterInfoVO.setTestName(testName);

				recipterInfoService.mergeRecipter(recipterInfoVO);
			}

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
			}catch(Exception e) {
				log.debug("회원 가입 쿠폰 발송 실패" + e.toString());
			}

			// 추천인 포인트
			try {
				if(EgovStringUtil.isNotEmpty(mbrVO.getRcmdtnId())) {
					if(!mbrVO.getMbrId().equals(mbrVO.getRcmdtnId())) {
						MbrVO mbrRcmdtnVO = mbrService.selectMbrIdByOne(mbrVO.getRcmdtnId());
						if(mbrRcmdtnVO != null) {
							MbrPointVO mbrPointVO = new MbrPointVO();
							mbrPointVO.setUniqueId(mbrRcmdtnVO.getUniqueId());
							mbrPointVO.setPointMngNo(0);
							mbrPointVO.setPointSe("A");
							mbrPointVO.setPointCn("03");
							mbrPointVO.setPoint(500);
							mbrPointVO.setRegUniqueId(mbrVO.getUniqueId());
							mbrPointVO.setRegId(mbrVO.getMbrId());
							mbrPointVO.setRgtr(mbrVO.getMbrNm());
							mbrPointVO.setGiveMthd("SYS");

							mbrPointService.insertMbrPoint(mbrPointVO);

						}
					}
				}

			}catch(Exception e) {
				e.printStackTrace();
				log.debug("회원가입 추천인 포인트 지급 실패 : " + e.toString());
			}

			//임시정보 추가
			mbrSession.setParms(mbrVO, false);
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
				String mailSj = "[이로움ON] 이로움 회원 가입을 축하드립니다.";
				if(EgovStringUtil.equals("real", activeMode)) {
					mailService.sendMail(sendMail, noMbrVO.getEml(), mailSj, mailForm);
				}else if(EgovStringUtil.equals("dev", activeMode)) {
					mailService.sendMail(sendMail, noMbrVO.getEml(), mailSj, mailForm);
				} else {
					mailService.sendMail(sendMail, "gyoh@icubesystems.co.kr", mailSj, mailForm); //테스트
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
}
