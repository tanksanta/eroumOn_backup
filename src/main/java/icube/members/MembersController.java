package icube.members;

import java.security.PrivateKey;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
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

import icube.common.file.biz.FileService;
import icube.common.framework.abst.CommonAbstractController;
import icube.common.framework.view.JavaScript;
import icube.common.framework.view.JavaScriptView;
import icube.common.util.AES256Util;
import icube.common.util.RSA;
import icube.common.util.WebUtil;
import icube.common.values.CRUD;
import icube.common.values.CodeMap;
import icube.manage.mbr.mbr.biz.MbrService;
import icube.manage.members.bplc.biz.BplcService;
import icube.manage.members.bplc.biz.BplcVO;
import icube.members.biz.PartnersSession;
import icube.members.stdg.biz.StdgCdService;
import icube.members.stdg.biz.StdgCdVO;

/**
 * 파트너스
 * - 검색,  소개, 로그인, 가입 페이지 등 포함
 */

@Controller
@RequestMapping(value="#{props['Globals.Members.path']}")
public class MembersController extends CommonAbstractController {

	@Resource(name = "bplcService")
	private BplcService bplcService;

	@Resource(name = "stdgCdService")
	private StdgCdService stdgCdService;

	@Resource(name = "mbrService")
	private MbrService mbrService;

	@Resource(name = "fileService")
	private FileService fileService;

	@Autowired
	private PartnersSession partnersSession;

	@Value("#{props['Globals.Members.path']}")
	private String membersPath;

	@Value("#{props['Globals.Server.Dir']}")
	private String serverDir;

	@Value("#{props['Globals.File.Upload.Dir']}")
	private String fileUploadDir;

	@Value("#{props['Globals.EroumCare.PrivateKey']}")
	private String eroumKey;

	@Value("#{props['Kakao.Script.key']}")
	private String kakaoScriptKey;

	private static final String SAVE_ID_COOKIE_ID = "_partnersSaveId_";
	private static final String RSA_PARTNERS_KEY = "__rsaPartnersKey__";


	// 사업소 찾기 화면 (스토리보드 > 첫화면)
	@RequestMapping(value={"", "bplcSrch"})
	public String bplcSearch(
			HttpServletRequest request
			, Model model) throws Exception {

		List<StdgCdVO> stdgCdList = stdgCdService.selectStdgCdListAll(1);

		model.addAttribute("stdgCdList", stdgCdList);
		model.addAttribute("_kakaoScriptKey", kakaoScriptKey);

		return "/members/bplc_srch";
	}

	//
	/**
	 * 사업소 목록
	 * - plannerController에서도 사용 > 확인 할 것
	 */
	@ResponseBody
	@RequestMapping(value="bplcList.json")
	public Map<String, Object> bplcList(
			@RequestParam(value="srchMode", required=false) String srchMode
			, @RequestParam(value="sido", required=false) String sido
			, @RequestParam(value="gugun", required=false) String gugun
			, @RequestParam(value="srchText", required=false) String srchText

			, @RequestParam(value="isAllow", required=false) boolean isAllow
			, @RequestParam(value="lat", required=false) String lat
			, @RequestParam(value="lot", required=false) String lot
			, @RequestParam(value="dist", required=false) int dist
			) throws Exception {


		Map<String, Object> paramMap = new HashMap<String, Object>();
		paramMap.put("srchAprvTy","C"); // 승인
		paramMap.put("srchUseYn","Y"); // 사용중
		paramMap.put("srchMode",srchMode.toUpperCase()); // 검색모드

		if(EgovStringUtil.equals("LOCATION", srchMode)) {
			paramMap.put("sido", sido); //시도
			paramMap.put("gugun", gugun); //구군
		}else if(EgovStringUtil.equals("TEXT", srchMode)) {
			paramMap.put("srchText", srchText); // 검색어 (주소 or 상호명)
		}else if(EgovStringUtil.equals("RECOMMEND", srchMode)) {
			paramMap.put("rcmdtnYn", "Y");
		}

		if(isAllow) {
			paramMap.put("isAllow", isAllow);
			paramMap.put("lat", lat); // 위도
			paramMap.put("lot", lot); // 경도
			paramMap.put("dist", dist); // 검색범위
		}

		List<BplcVO> resultList = bplcService.selectBplcListAll(paramMap);

		// result
		Map<String, Object> resultMap = new HashMap<String, Object>();
		resultMap.put("resultList", resultList);

		return resultMap;
	}


	// 소개페이지
	@RequestMapping(value="introduce")
	public String introduce(
			HttpServletRequest request
			, HttpSession session
			, Model model) throws Exception {

		// 세션 초기화
		session.setAttribute("brno", null);
		session.setAttribute("bplcNm", null);
		session.setAttribute("agree1", null);
		session.setAttribute("agree2", null);


		// 사업소 카운트
		Map<String, Object> paramMap = new HashMap<String, Object>();
		paramMap.put("Y", "srchUseYn"); // 사용중
		paramMap.put("C", "srchAprvTy"); // 승인

		int bplcCnt = bplcService.selectBplcCnt(paramMap);
		model.addAttribute("bplcCnt", bplcCnt);

		return "/members/introduce";
	}


	/**
	 * 파트너스(사업소) 로그인
	 * @return rsa info
	 */
	@RequestMapping(value="login")
	public String login(
			HttpServletRequest request
			, HttpSession session
			, Model model
			, @RequestParam(name= "business_id", required=false) String businessId) throws Exception {


		if(partnersSession.isLoginCheck()){  // 로그인이 되어 있으면 return
			return "redirect:/"+ membersPath +"/"+partnersSession.getPartnersId()+"/mng/index";
		}

		if (EgovStringUtil.isNotEmpty(businessId)) {
			try {
				//사업자 번호를 암호화해서 보냈다면 sso 인증
				String aesKey = eroumKey.substring(0, 32);
				String decodedBusinessId = AES256Util.AESDecode(businessId, aesKey);

				//복호화되고 복화된 사업자번호로 등록된 사업소가 있으면 해당 사업소로 로그인 처리
				if (!EgovStringUtil.isNotEmpty(decodedBusinessId)) {
					throw new Exception();
				}

				BplcVO searchBplcVo = new BplcVO();
				searchBplcVo.setBrno(decodedBusinessId);
				BplcVO findBplcVo = bplcService.selectBrno(searchBplcVo);
				if (findBplcVo == null) {
					throw new Exception();
				}

				//해당 사업소로 로그인 처리
				// 파트너스(사업소) 세션 생성
				partnersSession.setLoginCheck(true);
				partnersSession.setUniqueId(findBplcVo.getUniqueId());
				partnersSession.setPartnersId(findBplcVo.getBplcId());
				partnersSession.setPartnersNm(findBplcVo.getBplcNm());

				partnersSession.setProflImg(findBplcVo.getProflImg());

				// 로그인에 성공하면 로그인 실패 횟수를 초기화
				bplcService.updateFailedLoginCountReset(findBplcVo);
				return "redirect:/"+ membersPath + "/" + partnersSession.getPartnersId() + "/mng/index";
			} catch (Exception ex) {
				model.addAttribute("ssoResultMsg", "사업소 로그인 실패");

				return "/members/login";
			}
		} else {
			//암호화
			RSA rsa = RSA.getEncKey();
			request.setAttribute("publicKeyModulus", rsa.getPublicKeyModulus());
			request.setAttribute("publicKeyExponent", rsa.getPublicKeyExponent());
			session.setAttribute(RSA_PARTNERS_KEY, rsa.getPrivateKey());

			Cookie[] cookies = request.getCookies();
			if (cookies != null) {
				for (Cookie cookie : cookies) {
					if (SAVE_ID_COOKIE_ID.equals(cookie.getName())) {
						model.addAttribute("saveId", cookie.getValue());
					}
				}
			}

			return "/members/login";
		}
	}

	/**
	 * 파트너스 로그인처리 - 현재는 사업소 로그인만 처리
	 * @param saveId
	 * @param loginId
	 * @param encPW
	 * @return session or fail alert
	 * @throws Exception
	 */
	@RequestMapping("loginAction")
	public View action(
			BplcVO bplcVO
			, @RequestParam(defaultValue="N", required=false) String saveId
			, @RequestParam(required=true) String loginId
			, @RequestParam(required=true) String encPw
			, HttpServletRequest request
			, HttpServletResponse response
			, HttpSession session) throws Exception {

		log.debug(" # members loginAction # ");

		JavaScript javaScript = new JavaScript();
		String loginPasswd = "";

		if(null != request.getSession().getAttribute(RSA_PARTNERS_KEY)) {
			try {
				loginPasswd = RSA.decryptRsa((PrivateKey) request.getSession().getAttribute(RSA_PARTNERS_KEY), encPw); //암호화된 비밀번호를 복호화한다.
			} catch (Exception e) {
				log.warn(" #W# decrypt rsa fail! ");
				log.warn(" #W# " + e.getMessage());
				bplcVO = null;
			}
		} else {
			bplcVO = null;
		}

		log.debug(" # loginPasswd # " + loginPasswd);

		if(EgovStringUtil.isNotEmpty(loginPasswd)) {
			loginId     = WebUtil.clearSqlInjection(loginId);
			loginPasswd = WebUtil.clearSqlInjection(loginPasswd);

			bplcVO = bplcService.selectBplcById(loginId);
		}

		if (bplcVO != null) {

			//승인진행중
			if(EgovStringUtil.equals("W", bplcVO.getAprvTy()) ) { //대기
				javaScript.setMessage(getMsg("partners.error.approval.ing"));
				javaScript.setMethod("window.history.back()");
			} else if(EgovStringUtil.equals("R", bplcVO.getAprvTy()) ) { //거부
				javaScript.setMessage(getMsg("partners.error.approval.reject"));
				javaScript.setMethod("window.history.back()");
			} else {
				if(bplcVO.getBplcPswd() == null) {
					javaScript.setMessage("비밀번호 설정을 위해 멤버스 등록 화면으로 이동합니다.");
					javaScript.setLocation("/"+ membersPath +"/regist");
				}else if (BCrypt.checkpw(loginPasswd, bplcVO.getBplcPswd())) {

					// 파트너스(사업소) 세션 생성
					partnersSession.setLoginCheck(true);
					partnersSession.setUniqueId(bplcVO.getUniqueId());
					partnersSession.setPartnersId(bplcVO.getBplcId());
					partnersSession.setPartnersNm(bplcVO.getBplcNm());

					partnersSession.setProflImg(bplcVO.getProflImg());

					// saveId용 쿠키
					Cookie cookie = new Cookie(SAVE_ID_COOKIE_ID, bplcVO.getBplcId());
					cookie.setPath("/");
					cookie.setMaxAge("Y".equals(saveId) ? (60 * 60 * 24 * 7) : 0);
					cookie.setSecure(true);
					response.addCookie(cookie);

					// 로그인에 성공하면 로그인 실패 횟수를 초기화
					bplcService.updateFailedLoginCountReset(bplcVO);
					javaScript.setLocation("/"+ membersPath +"/"+ bplcVO.getBplcUrl() +"/mng/index");

				}else { // 실패횟수 체크 : 정책 미정

					//int passCount = bplcService.getFailedLoginCountWithCountUp(bplcVO);
					//String[] arg = { Integer.toString(passCount) };
					//javaScript.setMessage(getMsg("login.fail.password", arg));
					javaScript.setMessage(getMsg("login.fail.password"));
					javaScript.setMethod("window.history.back()");
				}
			}
		} else {
			javaScript.setMessage(getMsg("login.fail"));
			javaScript.setMethod("window.history.back()");
		}

		return new JavaScriptView(javaScript);

	}

	@RequestMapping(value = {"logout"})
	public String logout(
			HttpServletRequest request,
			HttpServletResponse response,
			HttpSession session) throws Exception {

		session.invalidate();

		return "redirect:/"+ membersPath +"/login";
	}

	// 정보찾기 > 아이디 찾기
	@RequestMapping(value="idSrch")
	public String idSrch(
			HttpServletRequest request
			, BplcVO bplcVO
			, Model model) throws Exception {

		model.addAttribute("bplcVO", bplcVO);

		return "/members/id_srch";
	}

	@RequestMapping(value = "idSrchDo")
	public View idSrchDo(
			BplcVO bplcVO
			, HttpSession session
			)throws Exception {

		JavaScript javaScript = new JavaScript();

		bplcVO = bplcService.selectBrno(bplcVO);


		if(bplcVO != null) {
			session.setAttribute("srchId", bplcVO.getBplcId());
			javaScript.setLocation("/"+ membersPath +"/idSrchComplate");
			return new JavaScriptView(javaScript);
		}

		javaScript.setMessage(getMsg("error.default"));
		javaScript.setMethod("window.history.back()");
		return new JavaScriptView(javaScript);
	}

	//정보 찾기 > 아이디 찾기 완료
	@RequestMapping(value = "idSrchComplate")
	public String idSrchComplate(
			HttpServletRequest request
			, BplcVO bplcVO
			, HttpSession session
			, Model model
			)throws Exception {

		//절차 검사
		if((String)session.getAttribute("srchId") == null) {
			return "/members/id_srch";
		}

		String bplcId = (String)session.getAttribute("srchId");
		model.addAttribute("bplcId", bplcId);

		session.setAttribute("srchId", null);

		return "/members/id_srch_complate";
	}

	// 정보찾기 > 비밀번호 찾기
	@RequestMapping(value="pswdSrch")
	public String pswdSrch(
			HttpServletRequest request
			, BplcVO bplcVO
			, Model model) throws Exception {


		return "/members/pswd_srch";
	}

	// 정보찾기 > 비밀번호 찾기
	@RequestMapping(value="pswdSrchDo")
	public View pswdSrchDo(
			HttpServletRequest request
			, HttpSession session
			, BplcVO bplcVO
			, Model model) throws Exception {

		JavaScript javaScript = new JavaScript();

		bplcVO = bplcService.selectBrno(bplcVO);
		if(bplcVO == null) {
			javaScript.setMessage(getMsg("error.default"));
			javaScript.setMethod("window.history.back()");
			return new JavaScriptView(javaScript);
		}
		session.setAttribute("srchUniqueId", bplcVO.getUniqueId());
		javaScript.setLocation("/"+membersPath+"/pswdChg");
		return new JavaScriptView(javaScript);
	}


	// 정보찾기 > 비밀번호 찾기
	@RequestMapping(value="pswdChg")
	public String pswdChg(
			HttpServletRequest request
			, BplcVO bplcVO
			, Model model) throws Exception {

		return "/members/pswd_chg";
	}

	// 새 비밀번호 등록
	@RequestMapping(value="pswdChgDo")
	@ResponseBody
	public boolean pswdChgDo(
			HttpServletRequest request
			, @RequestParam(value="bplcPswd", required=true)String bplcPswd
			, HttpSession session
			, Model model) throws Exception {

		String encPswd = BCrypt.hashpw(bplcPswd, BCrypt.gensalt());

		bplcService.updateBplcPswd((String)session.getAttribute("srchUniqueId"), encPswd);

		return true;
	}

	// 등록 신청 > 등록 확인
	@RequestMapping(value="regist")
	public String regist(
			HttpServletRequest request
			, Model model
			, BplcVO bplcVO
			)throws Exception {

		model.addAttribute("bplcVO", bplcVO);

		return "/members/regist";
	}

	// 등록 확인 > 사업자 번호 체크
	@RequestMapping(value = "brnoChk")
	@ResponseBody
	public BplcVO brnoChk(
			@RequestParam(value="bplcNm",required=true) String bplcNm
			, @RequestParam(value="brno",required=true) String brno
			, HttpSession session
			)throws Exception {

		BplcVO bplcVO = new BplcVO();
		bplcVO.setBplcNm(bplcNm);
		bplcVO.setBrno(brno);
		bplcVO.setAprvTy("X");

		//세션 처리
		session.setAttribute("bplcNm", bplcNm);
		session.setAttribute("brno", brno);

		BplcVO srchVO = bplcService.selectBrno(bplcVO);
		if(srchVO != null) {
			return srchVO;
		}

		return bplcVO;
	}

	@RequestMapping(value = "action")
	public View action(
			HttpServletRequest request
			, HttpSession session
			, Model model
			, BplcVO bplcVO
			)throws Exception {

		JavaScript javaScript = new JavaScript();

		model.addAttribute("bplcVO", bplcVO);

		javaScript.setLocation("/"+membersPath+"/registStep1");

		return new JavaScriptView(javaScript);
	}

	// 등록신청 > 약관동의
	@RequestMapping(value="registStep1")
	public String registStep1(
			HttpServletRequest request
			, HttpSession session
			, Model model) throws Exception {

		log.debug(" ##  Session Check   ##  : " + session.getAttribute("bplcNm"));
		log.debug(" ##  Session Check   ##  : " + session.getAttribute("brno"));
		String bplcNm = (String)session.getAttribute("bplcNm");
		String brno = (String)session.getAttribute("brno");

		//확인 화면 redirect
		if(EgovStringUtil.isNull(brno) ||EgovStringUtil.isNull(bplcNm)) {
			return "redirect:/" + membersPath +"/regist";
		}

		return "/members/regist_step1";
	}

	// 약관동의 검사
	@RequestMapping(value = "step1action")
	public View step1Chk(
			HttpServletRequest request
			, HttpSession session
			)throws Exception  {


		JavaScript javaScript = new JavaScript();

		//약관 동의 검사
		String agree1 = request.getParameter("agree1");
		String agree2 = request.getParameter("agree2");
		session.setAttribute("agree1", agree1);
		session.setAttribute("agree2", agree2);

		javaScript.setLocation("/"+membersPath+"/registStep2");

		return new JavaScriptView(javaScript);
	}

	// 등록신청 > 정보입력
	@RequestMapping(value="registStep2")
	public String registStep2(
			HttpServletRequest request
			, BplcVO bplcVO
			, HttpSession session
			, Model model) throws Exception {

		String returnUrl="";
		String brno = (String)session.getAttribute("brno");
		String bplcNm = (String) session.getAttribute("bplcNm");
		String agree1 = (String) session.getAttribute("agree1");
		String agree2 = (String) session.getAttribute("agree2");

		//사업자 등록 번호 check
		if(!EgovStringUtil.isNull(brno) && !EgovStringUtil.isNull(bplcNm)) {
			//약관 동의 check
			if(!EgovStringUtil.isNull(agree1) && !EgovStringUtil.isNull(agree2)) {
				bplcVO.setBrno(brno);
				bplcVO.setBplcNm(bplcNm);

				bplcVO = bplcService.selectBrno(bplcVO);

				//기존, 신규 구분
				if (bplcVO != null) {
					// 기존 사업소
					bplcVO.setCrud(CRUD.UPDATE);
					model.addAttribute("bplcVO", bplcVO);
				}else {
					// 신규 사업소
					BplcVO newBplcVO = new BplcVO();
					newBplcVO.setCrud(CRUD.CREATE);
					model.addAttribute("bplcVO", newBplcVO);
				}

				model.addAttribute("bankTy", CodeMap.BANK_TY);
				model.addAttribute("brno", brno);
				model.addAttribute("bplcNm", bplcNm);
				returnUrl = "/members/regist_step2";

			}else {
				returnUrl = "redirect:/" + membersPath + "/registStep1";
			}
		}else {
			returnUrl = "redirect:/" + membersPath + "/regist";
		}

		return returnUrl;
	}

	//아이디 중복 체크
	@RequestMapping(value = "bplcIdChk" )
	@ResponseBody
	public boolean bplcIdChk(
			@RequestParam(value="bplcId",required=true) String bplcId
			, BplcVO bplcVO
			)throws Exception {

		boolean result = false;

		int cnt = bplcService.selectBplcIdChk(bplcId);
		if(cnt == 0){
			result = true;
		}
		return result;
	}

	//url 중복 체크
	@RequestMapping(value = "bplcUrlChk" )
	@ResponseBody
	public boolean bplcUrlChk(
			@RequestParam(value="bplcUrl",required=true) String bplcUrl
			, @RequestParam(value="crud",required=true) String crud
			, @RequestParam(value="uniqueId", required=false) String uniqueId
			, BplcVO bplcVO
			)throws Exception {

		boolean result = false;

		//1. 수정시 자기 자신의 것은 가능, 다른 사람의 것은 안됨
		//2. 다른 아이디랑 중복검사

		bplcVO = bplcService.selectBplcUrl(uniqueId);
		if(crud.equals("UPDATE")) {
			if(bplcUrl.equals(bplcVO.getBplcUrl())) {
				result = true;
			}
		}else {
			if(bplcVO == null) {
				result = true;
			}
		}
		return result;
	}

	@RequestMapping(value = "registAction")
	public View action(
			BplcVO bplcVO
			, MultipartHttpServletRequest multiReq
			, @RequestParam Map<String,Object> reqMap
			, HttpSession session
			)throws Exception {

		JavaScript javaScript = new JavaScript();

		Map<String, MultipartFile> fileMap = multiReq.getFileMap();
		String profileImg = "";
		String bsnmCeregrt = "";
		String bsnmOffcs = "";

		//비밀번호 암호화
		if(EgovStringUtil.isNotEmpty(bplcVO.getBplcPswd())) {
			String encPswd = BCrypt.hashpw(bplcVO.getBplcPswd(), BCrypt.gensalt());
			bplcVO.setBplcPswd(encPswd);
		}


		switch (bplcVO.getCrud()) {
		case CREATE:

			// 대표이미지
			if (!fileMap.get("profImgFile").isEmpty()) {
				String profNm = fileMap.get("profImgFile").getOriginalFilename();
				profileImg = fileService.uploadFileNFixFileName(fileMap.get("profImgFile"), serverDir.concat(fileUploadDir),
						"PROFL", profNm.substring(0, profNm.length()-4));
				bplcVO.setProflImg(profileImg);
			}

			// 사업자 등록증
			if (!fileMap.get("bizrFile").isEmpty()) {
				String cereNm = fileMap.get("bizrFile").getOriginalFilename();
				bsnmCeregrt = fileService.uploadFileNFixFileName(fileMap.get("bizrFile"), serverDir.concat(fileUploadDir),
						"CEREGRT", cereNm.substring(0, cereNm.length()-4));
				bplcVO.setBsnmCeregrt(bsnmCeregrt);
			}

			//사업자 직인
			if (!fileMap.get("offcsFile").isEmpty()) {
				String offcsNm = fileMap.get("offcsFile").getOriginalFilename();
				bsnmOffcs = fileService.uploadFileNFixFileName(fileMap.get("offcsFile"), serverDir.concat(fileUploadDir),
						"OFFCS", offcsNm.substring(0, offcsNm.length()-4));
				bplcVO.setBsnmOffcs(bsnmOffcs);
			}

			//url
			bplcVO.setBplcUrl((bplcVO.getBplcUrl()).trim().toLowerCase());

			bplcService.insertBplc(bplcVO);

			//step2 > step3 방지
			session.setAttribute("step2", "Y");


			javaScript.setMessage(getMsg("action.complete.partners.save"));
			javaScript.setLocation("/"+membersPath+"/registStep3");
			break;

		case UPDATE:

			// 대표이미지 삭제

			if (!fileMap.get("profImgFile").isEmpty()) {
				profileImg = fileService.uploadFileNFixFileName(fileMap.get("profImgFile"), serverDir.concat(fileUploadDir),
						"PROFL", bplcVO.getUniqueId());
				bplcVO.setProflImg(profileImg);
			} else if (EgovStringUtil.equals("Y", bplcVO.getDelProflImg())) {
				bplcVO.setProflImg(null);
			}

			// 사업등록증 삭제
			if (!fileMap.get("bizrFile").isEmpty()) {
				bsnmCeregrt = fileService.uploadFileNFixFileName(fileMap.get("bizrFile"), serverDir.concat(fileUploadDir),
						"CEREGRT", bplcVO.getUniqueId());
				bplcVO.setBsnmCeregrt(bsnmCeregrt);
			} else if (EgovStringUtil.equals("Y", bplcVO.getDelBsnmCeregrt())) {
				bplcVO.setBsnmCeregrt(null);
			}

			// 사업자 직인 삭제
			if (!fileMap.get("offcsFile").isEmpty()) {
				bsnmOffcs = fileService.uploadFileNFixFileName(fileMap.get("offcsFile"), serverDir.concat(fileUploadDir),
						"PROFL", bplcVO.getUniqueId());
				bplcVO.setBsnmOffcs(bsnmOffcs);
			} else if (EgovStringUtil.equals("Y", bplcVO.getDelBsnmOffcs())) {
				bplcVO.setBsnmOffcs(null);
			}

			//url
			bplcVO.setBplcUrl((bplcVO.getBplcUrl()).trim().toLowerCase());

			bplcService.updatePartnersBplc(bplcVO);

			//step2 > step3 방지
			session.setAttribute("step2", "Y");

			javaScript.setMessage(getMsg("action.complete.update"));
			javaScript.setLocation("/"+membersPath+"/registStep3");
			break;

		default:
			break;

		}

		return new JavaScriptView(javaScript);
	}


	// 등록신청 > 신청완료
	@RequestMapping(value="registStep3")
	public String registStep3(
			HttpServletRequest request
			, HttpSession session
			, BplcVO bplcVO
			, Model model) throws Exception {

		String returnUrl = "/members/regist";
		String brno = (String)session.getAttribute("brno");
		String bplcNm = (String)session.getAttribute("bplcNm");
		String agree1 = (String)session.getAttribute("agree1");
		String agree2 = (String)session.getAttribute("agree2");
		String step2 = (String)session.getAttribute("step2");

		model.addAttribute("bplcVO", bplcVO);

		//regist check
		if(!EgovStringUtil.isNull(bplcNm) && !EgovStringUtil.isNull(bplcNm)) {
			//agree check
			if(!EgovStringUtil.isNull(agree1) && !EgovStringUtil.isNull(agree2)) {
				//step2 check
				if(!EgovStringUtil.isNull(step2)) {
					//세션 초기화
					session.setAttribute("brno", null);
					session.setAttribute("bplcNm", null);
					session.setAttribute("agree1", null);
					session.setAttribute("agree2", null);
					session.setAttribute("step2", null);

					returnUrl = "/members/regist_step3";
				}else {
					returnUrl = "redirect:/" + membersPath + "/registStep2";
				}
			}else {
				returnUrl = "redirect:/" + membersPath + "/registStep1";
			}
		}else {
			returnUrl = "redirect:/" + membersPath + "/regist";
		}

		log.debug("  ## Session Check ## : " + brno );
		log.debug("  ## Session Check ## : " + bplcNm );

		return returnUrl;
	}
}
