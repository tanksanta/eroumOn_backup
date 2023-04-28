package icube.market.mbr;

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
import org.springframework.beans.factory.annotation.Value;
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
import icube.manage.mbr.mbr.biz.MbrMngInfoService;
import icube.manage.mbr.mbr.biz.MbrMngInfoVO;
import icube.manage.mbr.mbr.biz.MbrService;
import icube.manage.mbr.mbr.biz.MbrVO;
import icube.manage.mbr.recipter.biz.RecipterInfoVO;
import icube.market.mbr.biz.MbrSession;

@Controller
@RequestMapping(value="#{props['Globals.Market.path']}")
public class MarketLoginController extends CommonAbstractController {

	@Resource(name = "mbrService")
	private MbrService mbrService;

	@Resource(name = "mbrMngInfoService")
	private MbrMngInfoService mbrMngInfoService;

	@Autowired
	private MbrSession mbrSession;

	@Value("#{props['Globals.Market.path']}")
	private String marketPath;

	private static final String SAVE_ID_COOKIE_ID = "_marketSaveId_";
	private static final String RSA_PARTNERS_KEY = "__rsaMarketKey__";

	@RequestMapping(value = {"login"})
	public String MarketIndex(
			@RequestParam Map<String,Object> reqMap
			, HttpServletRequest request
			, HttpServletResponse response
			, HttpSession session
			, Model model) throws Exception {


		// 로그인 체크
		if(mbrSession.isLoginCheck()){
			return  "redirect:/" + marketPath + "/mypage/index"; // TO-DO : 마이페이지?
		}

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

		String returnUrl = request.getHeader("REFERER");
		if(returnUrl.contains("info") || returnUrl.contains("action") || returnUrl.contains("Action")) {
			returnUrl = "/" + marketPath;
		}

		model.addAttribute("returnUrl", returnUrl);

		return "/market/mbr/login";
	}


	@RequestMapping("loginAction")
	public View action(
			MbrVO mbrVO
			, @RequestParam(defaultValue="N", required=false) String saveId
			, @RequestParam(required=false) String returnUrl
			, @RequestParam(required=true) String loginId
			, @RequestParam(required=true) String encPw
			, HttpServletRequest request
			, HttpServletResponse response
			, HttpSession session) throws Exception {

		log.debug(" # partners loginAction # ");

		JavaScript javaScript = new JavaScript();
		String loginPasswd = "";

		if(null != request.getSession().getAttribute(RSA_PARTNERS_KEY)) {
			try {
				loginPasswd = RSA.decryptRsa((PrivateKey) request.getSession().getAttribute(RSA_PARTNERS_KEY), encPw); //암호화된 비밀번호를 복호화한다.
			} catch (Exception e) {
				log.warn(" #W# decrypt rsa fail! ");
				log.warn(" #W# " + e.getMessage());
				mbrVO = null;
			}
		} else {
			mbrVO = null;
		}

		log.debug(" # loginPasswd # " + loginPasswd);

		if(EgovStringUtil.isNotEmpty(loginPasswd)) {
			loginId     = WebUtil.clearSqlInjection(loginId);
			loginPasswd = WebUtil.clearSqlInjection(loginPasswd);

			mbrVO = mbrService.selectMbrIdByOne(loginId);

		if (mbrVO != null) {
			// 최근 접속 일시 업데이트
			mbrService.updateRecentDt(mbrVO.getUniqueId());

			// 블랙리스트 회원
			Map<String, Object> paramMap = new HashMap<String, Object>();
			paramMap.put("srchUniqueId", mbrVO.getUniqueId());
			MbrMngInfoVO MbrMngInfoVO = mbrMngInfoService.selectMbrMngInfo(paramMap);
			if(MbrMngInfoVO != null && MbrMngInfoVO.getMngTy().equals("BLACK") && !MbrMngInfoVO.getMngSe().equals("NONE")) {
				//1. 일시정지
				if(MbrMngInfoVO.getMngSe().equals("PAUSE")) {
					javaScript.setMessage("일시정지된 회원입니다.");
					javaScript.setMethod("window.history.back()");
				}else if(MbrMngInfoVO.getMngSe().equals("UNLIMIT")) {
					javaScript.setMessage("영구정지된 회원입니다.");
					javaScript.setMethod("window.history.back()");
				}
			}else {


				if (BCrypt.checkpw(loginPasswd, mbrVO.getPswd())) {
					if((mbrVO.getMberSttus()).equals("HUMAN")) {
						//휴면 회원
						javaScript.setLocation("/"+ marketPath +"/drmt/view");
					}else {
						mbrSession.setParms(mbrVO, true);
						if("Y".equals(mbrVO.getRecipterYn())){
							mbrSession.setPrtcrRecipter(mbrVO.getRecipterInfo(), mbrVO.getRecipterYn(), 0);
						}else {
							RecipterInfoVO recipterInfoVO = new RecipterInfoVO();
							recipterInfoVO.setUniqueId(mbrVO.getUniqueId());
							recipterInfoVO.setMbrId(mbrVO.getMbrId());
							recipterInfoVO.setMbrNm(mbrVO.getMbrNm());
							recipterInfoVO.setProflImg(mbrVO.getProflImg());
							recipterInfoVO.setMberSttus(mbrVO.getMberSttus());
							recipterInfoVO.setMberGrade(mbrVO.getMberGrade());
							mbrSession.setPrtcrRecipter(recipterInfoVO, mbrVO.getRecipterYn(), 0);
						}


						mbrSession.setMbrInfo(session, mbrSession);

						// saveId용 쿠키
						Cookie cookie = new Cookie(SAVE_ID_COOKIE_ID, mbrVO.getMbrId());
						cookie.setPath("/");
						cookie.setMaxAge("Y".equals(saveId) ? (60 * 60 * 24 * 7) : 0);
						cookie.setSecure(true);
						response.addCookie(cookie);

						// 로그인에 성공하면 로그인 실패 횟수를 초기화
						mbrService.updateFailedLoginCountReset(mbrVO);

						// return page check
						if(EgovStringUtil.isNotEmpty(returnUrl)) {
							javaScript.setLocation(returnUrl);
						}
					}

				}else { // 실패횟수 체크 : 정책 미정

					//int passCount = mbrService.getFailedLoginCountWithCountUp(mbrVO);
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
		}else {
			javaScript.setMessage(getMsg("login.fail.idsearch"));
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

		return "redirect:/"+ marketPath +"/index"; //TO-DO : 첫화면으로..
	}
}
