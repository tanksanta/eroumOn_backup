package icube.membership;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.egovframe.rte.fdl.string.EgovStringUtil;
import org.json.simple.JSONObject;
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
import icube.common.util.Base64Util;
import icube.common.util.RSA;
import icube.manage.mbr.mbr.biz.MbrAuthService;
import icube.manage.mbr.mbr.biz.MbrAuthVO;
import icube.manage.mbr.mbr.biz.MbrMngInfoService;
import icube.manage.mbr.mbr.biz.MbrService;
import icube.manage.mbr.mbr.biz.MbrVO;
import icube.market.mbr.biz.MbrSession;


/**
 * 통합회원
 */
@Controller
@RequestMapping(value="#{props['Globals.Membership.path']}")
public class MbrsLoginController extends CommonAbstractController  {

	@Resource(name = "mbrService")
	private MbrService mbrService;

	@Resource(name = "mbrAuthService")
	private MbrAuthService mbrAuthService;
	
	@Resource(name = "mbrMngInfoService")
	private MbrMngInfoService mbrMngInfoService;

	@Autowired
	private MbrSession mbrSession;

	@Value("#{props['Globals.Membership.path']}")
	private String membershipPath;

	@Value("#{props['Globals.Planner.path']}")
	private String plannerPath;

	@Value("#{props['Globals.Market.path']}")
	private String marketPath;

	@Value("#{props['Globals.Main.path']}")
	private String mainPath;

	private static final String SAVE_ID_COOKIE_ID = "_membersSaveId_";
	private static final String RSA_MEMBERSHIP_KEY = "__rsaMembersKey__";

	// login
	@RequestMapping(value="login")
	public String login(
			HttpServletRequest request
			, @RequestParam Map<String,Object> reqMap
			, @RequestParam (value = "returnUrl", required=false) String returnUrl
			, HttpSession session
			, Model model) throws Exception {

		// 로그인 체크
		if(mbrSession.isLoginCheck()){
			return  "redirect:/" + mainPath + "/index";
		}

		//암호화
		RSA rsa = RSA.getEncKey();
		request.setAttribute("publicKeyModulus", rsa.getPublicKeyModulus());
		request.setAttribute("publicKeyExponent", rsa.getPublicKeyExponent());
		session.setAttribute(RSA_MEMBERSHIP_KEY, rsa.getPrivateKey());

		Cookie[] cookies = request.getCookies();
		if (cookies != null) {
			for (Cookie cookie : cookies) {
				if (SAVE_ID_COOKIE_ID.equals(cookie.getName())) {
					model.addAttribute("saveId", cookie.getValue());
				}
				if (MbrSession.RECENT_LGN_TY_COOKIE.equals(cookie.getName())) {
					model.addAttribute("recentLgnTy", cookie.getValue());
				}
			}
		}

		//String returnUrl = request.getHeader("REFERER");
		if(EgovStringUtil.isNotEmpty(returnUrl)) {
			if(returnUrl.contains("srch") || returnUrl.contains("action") || returnUrl.contains("Action")) {
				returnUrl = "/" + mainPath;
			}
		}
		session.setAttribute("returnUrl", returnUrl);
		model.addAttribute("returnUrl", returnUrl);
		
		if (EgovStringUtil.null2string((String) model.getAttribute("loginRedirectMethod"), "").equals("POST") ) {
			model.addAttribute("loginRedirectMethod", EgovStringUtil.null2string((String) model.getAttribute("loginRedirectMethod"), ""));
			model.addAttribute("loginRedirectUrl", EgovStringUtil.null2string((String) model.getAttribute("loginRedirectUrl"), ""));
			model.addAttribute("loginRedirectParam", EgovStringUtil.null2string((String) model.getAttribute("loginRedirectParam"), ""));
			model.addAttribute("loginRedirectDoubleSubmit", EgovStringUtil.null2string((String) model.getAttribute("loginRedirectDoubleSubmit"), ""));
		}

		return "/membership/login";
	}

	// login action
	@SuppressWarnings("unchecked")
	@RequestMapping("loginAction")
	public View action(
			MbrVO mbrVO
			, @RequestParam(defaultValue="N", required=false) String saveId
			, @RequestParam(value = "returnUrl", required=false) String returnUrl
			, @RequestParam(value = "loginRedirectMethod", required=false) String loginRedirectMethod
			, @RequestParam(value = "loginRedirectUrl", required=false) String loginRedirectUrl
			, @RequestParam(value = "loginRedirectParam", required=false) String loginRedirectParam
			, @RequestParam(value = "loginRedirectDoubleSubmit", required=false) String loginRedirectDoubleSubmit
			, @RequestParam(required=true, value="mbrId") String mbrId
			, @RequestParam(required=true, value="encPw") String encPw
			, HttpServletRequest request
			, HttpServletResponse response
			, HttpSession session) throws Exception {

		JavaScript javaScript = new JavaScript();

		//아이디, 패스워드 및 각종 회원 유효성 검사
		Map<String, Object> validationResult = mbrService.validateForEroumLogin(mbrId, encPw, session);
		boolean isValid = (boolean)validationResult.get("valid");
		if (!isValid) {
			Object code = validationResult.get("code");
			if (code != null && "EROUM_HUMAN".equals(code)) {
				MbrVO humanMbr = (MbrVO)validationResult.get("srchMbrVO");
				javaScript.setLocation("/" + membershipPath + "/drmt/view?mbrId=" + humanMbr.getMbrId());
			} else if (code != null && "EROUM_FAIL_PWD".equals(code)) {
				javaScript.setMessage((String)validationResult.get("msg"));
				javaScript.setLocation("/" + membershipPath + "/srchPswd");
			} else {
				javaScript.setMessage((String)validationResult.get("msg"));
				javaScript.setMethod("window.history.back()");
			}
			return new JavaScriptView(javaScript);
		}
		MbrVO srchMbrVO = (MbrVO)validationResult.get("srchMbrVO");
		
		
		// 최근 접속 일시 업데이트
		mbrService.updateRecentDtAndLgnTy(srchMbrVO.getUniqueId(), srchMbrVO, "E");
		
		//로그인 처리
		mbrSession.setParms(srchMbrVO, true);
		mbrSession.setMbrInfo(session, mbrSession);

		// saveId용 쿠키
		Cookie cookie = new Cookie(SAVE_ID_COOKIE_ID, srchMbrVO.getMbrId());
		cookie.setPath("/");
		cookie.setMaxAge("Y".equals(saveId) ? (60 * 60 * 24 * 7) : 0);
		cookie.setSecure(true);
		response.addCookie(cookie);
		
		// 최근 로그인 쿠키
		Cookie recentLgnTyCookie = mbrSession.getRecentLgnTyCookie();
		response.addCookie(recentLgnTyCookie);

		// 로그인에 성공하면 로그인 실패 횟수를 초기화
		mbrService.updateFailedLoginCountReset(srchMbrVO);

		// return page check
		if (EgovStringUtil.isNotEmpty(loginRedirectMethod) && loginRedirectMethod.equals("POST") 
				&& EgovStringUtil.isNotEmpty(loginRedirectUrl) && EgovStringUtil.isNotEmpty(loginRedirectParam)) {
			
			JSONObject jObj = new JSONObject();
			jObj.put("loginRedirectDoubleSubmit", loginRedirectDoubleSubmit);
			
			javaScript.setHttpMethod(loginRedirectMethod);
			javaScript.setLocation(Base64Util.decoder(loginRedirectUrl));
			javaScript.setReqParamsBase64(loginRedirectParam);
			javaScript.setJsonObject(jObj);
		} else if (EgovStringUtil.isNotEmpty(returnUrl)) {
			javaScript.setLocation(returnUrl);
		} else {
			javaScript.setLocation("/" + mainPath);
		}

		return new JavaScriptView(javaScript);

	}

	// logout
	@RequestMapping(value = {"logout"})
	public String logout(
			HttpServletRequest request,
			HttpServletResponse response,
			@RequestParam(value = "returnUrl", required=false) String returnUrl,
			HttpSession session) throws Exception {

		session.invalidate();

		if(EgovStringUtil.isNotEmpty(returnUrl)) {
			return "redirect:"+returnUrl;
		}else {
			return "redirect:/"+ mainPath;
		}

	}
	
	
	/**
	 * 회원 연결 페이지 이동(바인딩)
	 */
	@RequestMapping(value="binding")
	public String binding(
			HttpServletRequest request
			, Model model) throws Exception {

		if (mbrSession == null || EgovStringUtil.isEmpty(mbrSession.getUniqueId()) || mbrSession.isLoginCheck() == true) {
			model.addAttribute("alertMsg", "잘못된 접근입니다.");
			return "/common/msg";
		}
		
		MbrVO mbrVO = mbrSession;
		List<MbrAuthVO> authList = mbrAuthService.selectMbrAuthByMbrUniqueId(mbrVO.getUniqueId());
		MbrAuthVO eroumAuthInfo = authList.stream().filter(f -> "E".equals(f.getJoinTy())).findAny().orElse(null);
		MbrAuthVO kakaoAuthInfo = authList.stream().filter(f -> "K".equals(f.getJoinTy())).findAny().orElse(null);
		MbrAuthVO naverAuthInfo = authList.stream().filter(f -> "N".equals(f.getJoinTy())).findAny().orElse(null);
		
		model.addAttribute("tempMbrVO", mbrVO);
		model.addAttribute("eroumAuthInfo", eroumAuthInfo);
		model.addAttribute("kakaoAuthInfo", kakaoAuthInfo);
		model.addAttribute("naverAuthInfo", naverAuthInfo);
		
		return "/membership/mbr_binding";
	}
	
	/**
	 * sns 인증정보와 회원 연결 처리 ajax
	 */
	@ResponseBody
	@RequestMapping(value="sns/binding.json")
	public Map<String, Object> snsBindingJson(HttpSession session) {
		return mbrService.bindMbrWithTempMbr(session);
	}
	
	/**
	 * 이로움 계정정보와 회원 연결 처리 ajax(로그인 여부와 상관없이 세션에 UNIQUE_ID 필요)
	 */
	@ResponseBody
	@RequestMapping(value="eroum/binding.json")
	public Map<String, Object> addEroumAuth(
			@RequestParam String mbrId
			, @RequestParam String pswd
			, HttpSession session) throws Exception {
		Map<String, Object> resultMap = new HashMap<String, Object>();
		
		//비정상적인 요청 차단
		if (mbrSession == null || EgovStringUtil.isEmpty(mbrSession.getUniqueId()) || mbrSession.isLoginCheck() == true) {
			resultMap.put("msg", "잘못된 접근입니다.");
			return resultMap;
		}
		
		MbrVO mbrVO = new MbrVO();
		mbrVO.setUniqueId(mbrSession.getUniqueId());
		mbrVO.setMbrId(mbrId);
		mbrVO.setPswd(pswd);
		mbrVO.setMblTelno(mbrSession.getMblTelno());
		mbrVO.setCiKey(mbrSession.getCiKey());
		
		resultMap = mbrAuthService.registEroumAuth(mbrVO);
		
		if ((boolean)resultMap.get("success")) {
			MbrVO srchMbrVO = mbrService.selectMbrByUniqueId(mbrSession.getUniqueId());
			
			//로그인 처리
			mbrSession.setParms(srchMbrVO, true);
			mbrSession.setMbrInfo(session, mbrSession);
		}
		return resultMap;
	}
}
