package icube.membership;

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
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.View;

import icube.common.framework.abst.CommonAbstractController;
import icube.common.framework.view.JavaScript;
import icube.common.framework.view.JavaScriptView;
import icube.common.util.CommonUtil;
import icube.common.util.RSA;
import icube.common.util.WebUtil;
import icube.manage.mbr.mbr.biz.MbrMngInfoService;
import icube.manage.mbr.mbr.biz.MbrMngInfoVO;
import icube.manage.mbr.mbr.biz.MbrService;
import icube.manage.mbr.mbr.biz.MbrVO;
import icube.manage.mbr.recipter.biz.RecipterInfoVO;
import icube.market.mbr.biz.MbrSession;


/**
 * 통합회원
 */
@Controller
@RequestMapping(value="#{props['Globals.Membership.path']}")
public class MbrsLoginController extends CommonAbstractController  {

	@Resource(name = "mbrService")
	private MbrService mbrService;

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

	private static final String SAVE_ID_COOKIE_ID = "_membersSaveId_";
	private static final String RSA_MEMBERSHIP_KEY = "__rsaMembersKey__";

	// login
	@RequestMapping(value="login")
	public String login(
			HttpServletRequest request
			, @RequestParam Map<String,Object> reqMap
			, HttpSession session
			, Model model) throws Exception {

		// 로그인 체크
		if(mbrSession.isLoginCheck()){
			return  "redirect:/" + plannerPath + "/index";
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
			}
		}

		String returnUrl = request.getHeader("REFERER");
		if(returnUrl.contains("srch") || returnUrl.contains("action") || returnUrl.contains("Action")) {
			returnUrl = "/" + plannerPath;
		}

		model.addAttribute("returnUrl", returnUrl);


		return "/membership/login";
	}

	// login action
	@RequestMapping("loginAction")
	public View action(
			MbrVO mbrVO
			, @RequestParam(defaultValue="N", required=false) String saveId
			, @RequestParam(required=false) String returnUrl
			, @RequestParam(required=true, value="mbrId") String mbrId
			, @RequestParam(required=true, value="encPw") String encPw
			, HttpServletRequest request
			, HttpServletResponse response
			, HttpSession session) throws Exception {

		JavaScript javaScript = new JavaScript();
		String loginPasswd = "";

		if(null != request.getSession().getAttribute(RSA_MEMBERSHIP_KEY)) {
			try {
				loginPasswd = RSA.decryptRsa((PrivateKey) request.getSession().getAttribute(RSA_MEMBERSHIP_KEY), encPw); //암호화된 비밀번호를 복호화한다.
			} catch (Exception e) {
				log.warn(" #W# decrypt rsa fail! ");
				log.warn(" #W# " + e.getMessage());
				mbrVO = null;
			}
		} else {
			mbrVO = null;
		}

		if(EgovStringUtil.isNotEmpty(loginPasswd)) {
			mbrId     = WebUtil.clearSqlInjection(mbrId);
			loginPasswd = WebUtil.clearSqlInjection(loginPasswd);

			mbrVO = mbrService.selectMbrIdByOne(mbrId.toLowerCase());

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
						javaScript.setLocation("/"+ membershipPath +"/drmt/view?mbrId="+mbrVO.getMbrId());
					}else {

					mbrSession.setParms(mbrVO, true);
					if ("Y".equals(mbrVO.getRecipterYn())) {
						mbrSession.setPrtcrRecipter(mbrVO.getRecipterInfo(), mbrVO.getRecipterYn(), 0);
					} else {
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
					if (EgovStringUtil.isNotEmpty(returnUrl)) {
						javaScript.setLocation(returnUrl);
					}else {
						javaScript.setLocation("/"+plannerPath);
					}
				}

				} else {
					javaScript.setMessage(getMsg("login.fail.password"));
					javaScript.setMethod("window.history.back()");
				}
				}
			} else {
				javaScript.setMessage(getMsg("login.fail"));
				javaScript.setMethod("window.history.back()");
			}
		} else {
			javaScript.setMessage(getMsg("login.fail.idsearch"));
			javaScript.setMethod("window.history.back()");
		}

		return new JavaScriptView(javaScript);

	}

	// logout
	@RequestMapping(value = {"logout"})
	public String logout(
			HttpServletRequest request,
			HttpServletResponse response,
			HttpSession session) throws Exception {

		session.invalidate();

		return "redirect:/"+ plannerPath;
	}



	/* modal login action > loginAction 복사
	 * resultCode
				PAUSE : 일시정지 회원
				UNLIMIT : 영구정지 회원
				HUMAN : 휴면회원
				PASSWORD : 비밀번호x
				FAIL : XXX
	*/
	@ResponseBody
	@RequestMapping(value="modalLoginAction.json", method=RequestMethod.POST)
	public Map<String, Object> modalLoginAction(
			MbrVO mbrVO
			, @RequestParam(defaultValue="N", required=false) String saveId
			, @RequestParam(required=true, value="loginId") String loginId
			, @RequestParam(required=true, value="encPw") String encPw
			, HttpServletRequest request
			, HttpServletResponse response
			, HttpSession session
			) throws Exception {

		Map<String, Object> resultMap = new HashMap<String, Object>();
		boolean result = false;
		String resultCode = "FAIL";

		String loginPasswd = "";

		if(null != request.getSession().getAttribute(RSA_MEMBERSHIP_KEY)) {
			try {
				loginPasswd = RSA.decryptRsa((PrivateKey) request.getSession().getAttribute(RSA_MEMBERSHIP_KEY), encPw); //암호화된 비밀번호를 복호화한다.
			} catch (Exception e) {
				mbrVO = null;
			}
		} else {
			mbrVO = null;
		}

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
					resultCode = MbrMngInfoVO.getMngSe();
				}else {

					if (BCrypt.checkpw(loginPasswd, mbrVO.getPswd())) {

						// return page check
						if((mbrVO.getMberSttus()).equals("HUMAN")) {
							resultCode = mbrVO.getMberSttus(); //HUMAN
							resultMap.put("mbrId", mbrVO.getMbrId());
						}else {
							resultCode = "SUCCESS";

							mbrSession.setParms(mbrVO, true);
							if ("Y".equals(mbrVO.getRecipterYn())) {
								mbrSession.setPrtcrRecipter(mbrVO.getRecipterInfo(), mbrVO.getRecipterYn(), 0);
							} else {
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

							// 로그인에 성공하면 로그인 실패 횟수를 초기화
							mbrService.updateFailedLoginCountReset(mbrVO);

							resultMap.put("mbrNm", mbrSession.getMbrNm());
							resultMap.put("mbrItrst", mbrSession.getItrstField());

							// 주소
							if(EgovStringUtil.isNotEmpty(mbrSession.getAddr())) {
								String[] spAddr = mbrSession.getAddr().split(" ");
								if(spAddr.length > 1) {
									String mbrAddr = spAddr[0] + " " + spAddr[1];
									resultMap.put("mbrAddr", mbrAddr);
									resultMap.put("mbrAddr1", spAddr[0]);
									resultMap.put("mbrAddr2", spAddr[1]);
								}
							}

							// 나이
							if(mbrSession.getBrdt() != null) {
								String mbrAge = CommonUtil.getAge(mbrSession.getBrdt());
								resultMap.put("mbrAge", mbrAge);
							}

							result = true;

							// saveId용 쿠키
							Cookie cookie = new Cookie(SAVE_ID_COOKIE_ID, mbrVO.getMbrId());
							cookie.setPath("/");
							cookie.setMaxAge("Y".equals(saveId) ? (60 * 60 * 24 * 7) : 0);
							cookie.setSecure(true);
							response.addCookie(cookie);
						}
					} else {
						resultCode = "PASSWORD";
					}
				}
			} else {
				resultCode = "FAIL";
			}
		}

		resultMap.put("result", result);
		resultMap.put("resultCode", resultCode);

		return resultMap;

	}


}
