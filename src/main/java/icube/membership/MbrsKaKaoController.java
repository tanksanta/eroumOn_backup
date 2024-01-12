package icube.membership;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.egovframe.rte.fdl.string.EgovStringUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.View;

import icube.common.api.biz.KakaoApiService;
import icube.common.framework.abst.CommonAbstractController;
import icube.common.framework.view.JavaScript;
import icube.common.framework.view.JavaScriptView;
import icube.manage.mbr.mbr.biz.MbrService;
import icube.manage.mbr.mbr.biz.MbrVO;
import icube.market.mbr.biz.MbrSession;
import icube.membership.info.biz.DlvyService;
import icube.membership.info.biz.DlvyVO;

/**
 * 카카오 간편 로그인
 * @author ogy
 *
 */
@Controller
@RequestMapping(value="#{props['Globals.Membership.path']}/kakao")
public class MbrsKaKaoController extends CommonAbstractController{

	@Resource(name = "kakaoApiService")
	private KakaoApiService kakaoApiService;

	@Resource(name = "mbrService")
	private MbrService mbrService;

	@Resource(name = "dlvyService")
	private DlvyService dlvyService;
	
	@Autowired
	private MbrSession mbrSession;

	@Value("#{props['Globals.Main.path']}")
	private String mainPath;

	@Value("#{props['Globals.Membership.path']}")
	private String membershipPath;
	
	@Value("#{props['Globals.Matching.path']}")
	private String matchingPath;

	@RequestMapping(value = "/auth")
	public View auth(
			HttpServletRequest request
			, HttpSession session
			, Model model
			)throws Exception {

		JavaScript javaScript = new JavaScript();
		String kakaoUrl = kakaoApiService.getKakaoUrl();

		session.setAttribute("prevSnsPath", "membership");
		
		javaScript.setLocation(kakaoUrl);
		return new JavaScriptView(javaScript);
	}

	@RequestMapping(value = "/getToken")
	public View getKakaoUserInfo(
			HttpServletRequest request
			, HttpSession session
			, Model model
			, @RequestParam(value="code", required=true) String code
			)throws Exception {

		JavaScript javaScript = new JavaScript();
		String returnUrl = (String)session.getAttribute("returnUrl");
		String prevPath = (String)session.getAttribute("prevSnsPath");
		if (EgovStringUtil.isEmpty(prevPath)) {
			javaScript.setMessage("카카오 로그인 유입 경로를 설정하세요.");
		}
		String rootPath = "membership".equals(prevPath) ? ("/" + mainPath) : ("/" + matchingPath);
		String membershipRootPath = "membership".equals(prevPath) ? ("/" + membershipPath) : rootPath;
		
		String accessToken = null;
		MbrVO kakaoUserInfo = null;
		try {
			accessToken = kakaoApiService.getToken(code);
			kakaoUserInfo = kakaoApiService.getKakaoUserInfo(accessToken);
			if (accessToken == null || kakaoUserInfo == null) {
				throw new Exception();
			}
		} catch (Exception ex) {
			javaScript.setMessage("카카오로부터 로그인정보를 받아오지 못하였습니다.");
			javaScript.setLocation(rootPath + "/login");
			return new JavaScriptView(javaScript);
		}
		
		
		//로그인 한 상태라면 재인증 처리
		if(mbrSession.isLoginCheck()) {
			return new JavaScriptView(mbrService.reAuthCheck("K", kakaoUserInfo, session));
		}
		
		
		//회원 정보 유효성 검사
		try {
			Map<String, Object> validationResult = mbrService.validateForSnsLogin(session, kakaoUserInfo);
			
			//검색 회원이 없으면 회원가입 처리
			if (!validationResult.containsKey("srchMbrVO")) {
				//kakao 주소 정보 get API 호출
				DlvyVO dlvyVO = kakaoApiService.getUserDlvy(accessToken);
				
				mbrService.registerSnsMbrAndLogin(session, kakaoUserInfo, dlvyVO);
				
				String registPath = "membership".equals(prevPath) ? (membershipRootPath + "/sns/regist?uid=" + mbrSession.getUniqueId()) : (rootPath + "/login");
				javaScript.setLocation(registPath);
				return new JavaScriptView(javaScript);
			}
			
			//검증 통과 여부 확인
			boolean isValid = (boolean)validationResult.get("valid");
			if (!isValid) {
				if (validationResult.containsKey("msg")) {
					javaScript.setMessage((String)validationResult.get("msg"));
				}
				javaScript.setLocation((String)validationResult.get("location"));
				return new JavaScriptView(javaScript);
			}
			
			//로그인 이후 redirect
			if(EgovStringUtil.isNotEmpty(returnUrl)) {
				javaScript.setLocation(returnUrl);
			} else {
				javaScript.setLocation(rootPath);
			}
			session.removeAttribute("returnUrl");
			
		} catch (Exception ex) {
			javaScript.setMessage(getMsg("fail.common.network"));
			javaScript.setLocation(rootPath + "/login");
		}
		
		return new JavaScriptView(javaScript);
	}


	@RequestMapping(value = "/reAuth")
	public View reAuth(
			@RequestParam(required = false) String requestView
			, @RequestParam(required = false) String resnCn
			, @RequestParam(required = false) String whdwlEtc
			, HttpServletRequest request
			, Model model
			, HttpSession session
			)throws Exception {

		JavaScript javaScript = new JavaScript();

		if (EgovStringUtil.isNotEmpty(requestView)) {
			session.setAttribute("requestView", requestView);
			session.setAttribute("resnCn", resnCn);
			session.setAttribute("whdwlEtc", whdwlEtc);
		} else {
			session.setAttribute("requestView", null);
			session.setAttribute("resnCn", null);
			session.setAttribute("whdwlEtc", null);
		}
		
		String kakaoUrl = kakaoApiService.getKakaoReAuth();

		javaScript.setLocation(kakaoUrl);
		return new JavaScriptView(javaScript);
	}


}
