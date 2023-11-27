package icube.manage.sysmng.mngr;

import java.security.PrivateKey;
import java.util.HashMap;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.egovframe.rte.fdl.string.EgovStringUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCrypt;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.View;

import icube.common.framework.abst.CommonAbstractController;
import icube.common.framework.view.JavaScript;
import icube.common.framework.view.JavaScriptView;
import icube.common.util.RSA;
import icube.common.util.WebUtil;
import icube.manage.sysmng.menu.biz.MngMenuService;
import icube.manage.sysmng.mngr.biz.MngrService;
import icube.manage.sysmng.mngr.biz.MngrSession;
import icube.manage.sysmng.mngr.biz.MngrVO;

@Controller
@RequestMapping(value = "/_mng")
public class MLoginController extends CommonAbstractController {

	@Resource(name = "mngrService")
	private MngrService mngrService;

	@Resource(name = "mngMenuService")
	private MngMenuService mngMenuService;

	@Autowired
	private MngrSession mngrSession;

	private static final String SAVE_ID_COOKIE_ID = "_saveId_";

	private static final String RSA_PRIVATE_KEY = "__rsaPrivateKey__";

	@RequestMapping(value = {"", "index"})
	public String index(
			HttpServletRequest request) throws Exception {

		if(mngrSession.isLoginCheck()) {
			return "redirect:/_mng/intro";
		}
		return "redirect:/_mng/login";
	}


	@RequestMapping(value = {"login"})
	public String login(
			MngrVO mngrVO
			, HttpServletRequest request
			, HttpServletResponse response
			, HttpSession session
			, Model model) throws Exception {


		if(mngrSession.isLoginCheck()){
			return "redirect:/_mng/intro";
		}
		RSA rsa = RSA.getEncKey();
		request.setAttribute("publicKeyModulus", rsa.getPublicKeyModulus());
		request.setAttribute("publicKeyExponent", rsa.getPublicKeyExponent());
		session.setAttribute(RSA_PRIVATE_KEY, rsa.getPrivateKey());

		model.addAttribute("mngrVO", mngrVO);

		Cookie[] cookies = request.getCookies();
		if (cookies != null) {
			for (Cookie cookie : cookies) {
				if (SAVE_ID_COOKIE_ID.equals(cookie.getName())) {
					model.addAttribute("saveId", cookie.getValue());
				}
			}
		}

		setResponseHeader(response);
		return "/manage/login/login";
	}


	/**
	 * 관리자 로그인 처리
	 */
	@RequestMapping(value = {"loginAction"})
	public View action(
			MngrVO mngrVO,
			@RequestParam(defaultValue="N", required=false) String saveId,
			@RequestParam(required=true) String loginId,
			@RequestParam(required=true) String encPw,
			HttpServletRequest request,
			HttpServletResponse response,
			HttpSession session) throws Exception {


		log.debug(" # manager loginAction # ");

		JavaScript javaScript = new JavaScript();
		String loginPasswd = "";

		if(null != request.getSession().getAttribute(RSA_PRIVATE_KEY)) {
			try {
				loginPasswd = RSA.decryptRsa((PrivateKey) request.getSession().getAttribute(RSA_PRIVATE_KEY), encPw); //암호화된 비밀번호를 복호화한다.
			} catch (Exception e) {
				log.warn(" #W# decrypt rsa fail! ");
				log.warn(" #W# " + e.getMessage());
				mngrVO = null;
			}
		} else {
			mngrVO = null;
		}


		log.debug(" # loginPasswd # " + loginPasswd);

		if(EgovStringUtil.isNotEmpty(loginPasswd)) {
			loginId     = WebUtil.clearSqlInjection(loginId);
			loginPasswd = WebUtil.clearSqlInjection(loginPasswd);

			Map<String, String> paramMap = new HashMap<String, String>();
			paramMap.put("mngrId", loginId);
			paramMap.put("srchUseYn", "Y");
			mngrVO = mngrService.selectMngrById(paramMap);
		}

		if (mngrVO != null) {

			//int failCnt = mngrService.selectFailedLoginCount(mngrVO);

			//if (failCnt < 5) {
				if (BCrypt.checkpw(loginPasswd, mngrVO.getMngrPswd())) {

					mngrService.setMngrSession(mngrVO);
					mngrService.setMngrCookie(mngrVO, response);

					// 최근 접속일시
					Map<String, Object> paramMap = new HashMap<String, Object>();
					paramMap.put("srchUniqueId", mngrVO.getUniqueId());
					mngrService.updateRecentLgnDt(paramMap);

					// saveId용 쿠키
					Cookie cookie = new Cookie(SAVE_ID_COOKIE_ID, mngrVO.getMngrId());
					cookie.setPath("/");
					cookie.setMaxAge("Y".equals(saveId) ? (60 * 60 * 24 * 7) : 0);
					cookie.setSecure(true);
					response.addCookie(cookie);

					// 로그인에 성공하면 로그인 실패 횟수를 초기화
					/*
					mngrService.updateFailedLoginCountReset(mngrVO);*/
					javaScript.setLocation("/_mng/intro");

					/*} else {

					int passCount = mngrService.getFailedLoginCountWithCountUp(mngrVO);
					String[] arg = { Integer.toString(passCount) };
					javaScript.setMessage(getMsg("login.fail.password", arg));
					javaScript.setMethod("window.history.back()");
				}*/
			} /*else {
				javaScript.setMessage(getMsg("login.fail.count.password"));
				javaScript.setMethod("window.history.back()");
			}*/
			else {
				javaScript.setMessage(getMsg("login.fail"));
				javaScript.setMethod("window.history.back()");
			}
		}else {
			javaScript.setMessage(getMsg("login.fail.idsearch"));
			javaScript.setMethod("window.history.back()");
		}

		setResponseHeader(response);
		return new JavaScriptView(javaScript);
	}


	@RequestMapping(value = {"logout"})
	public String logout(
			HttpServletRequest request,
			HttpServletResponse response,
			HttpSession session) throws Exception {

		mngrService.clearMngrCookie(request, response);

		session.setAttribute(mngrSession.getMNGR_SESSION_KEY(), null);
		session.invalidate();

		setResponseHeader(response);
		return "redirect:/_mng/login";
	}


	void setResponseHeader(HttpServletResponse response) {
		response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
		response.setHeader("Pragma", "no-cache");
		response.setDateHeader("Expires", 0);
	}

}
