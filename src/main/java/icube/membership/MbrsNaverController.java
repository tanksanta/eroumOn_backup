package icube.membership;

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

import icube.common.api.biz.NaverApiService;
import icube.common.framework.abst.CommonAbstractController;
import icube.common.framework.view.JavaScript;
import icube.common.framework.view.JavaScriptView;
import icube.manage.mbr.mbr.biz.MbrService;
import icube.manage.mbr.mbr.biz.MbrVO;
import icube.market.mbr.biz.MbrSession;

/**
 * 네이버 간편 로그인
 * @author ogy
 *
 */
@Controller
@RequestMapping(value="#{props['Globals.Membership.path']}/naver")
public class MbrsNaverController extends CommonAbstractController{

	@Resource(name = "naverApiService")
	private NaverApiService naverApiService;

	@Resource(name = "mbrService")
	private MbrService mbrService;

	@Autowired
	private MbrSession mbrSession;

	@Value("#{props['Globals.Main.path']}")
	private String mainPath;

	@Value("#{props['Globals.Membership.path']}")
	private String membershipPath;
	
	@Value("#{props['Globals.Matching.path']}")
	private String matchingPath;
	
	@RequestMapping(value = "/get")
	public View get(HttpSession session) throws Exception {
		JavaScript javaScript = new JavaScript();
		String getUrl = naverApiService.getUrl();

		session.setAttribute("prevSnsPath", "membership");
		
		javaScript.setLocation(getUrl);
		return new JavaScriptView(javaScript);
	}

	@RequestMapping(value = "/auth")
	public View auth(
			HttpServletRequest request
			, HttpSession session
			, Model model
			, @RequestParam(value = "code", required=false) String code
			, @RequestParam(value = "state", required=false) String state
			, @RequestParam(value = "error", required=false) String error
			) throws Exception {

		JavaScript javaScript = new JavaScript();
		String returnUrl = (String)session.getAttribute("returnUrl");
		String prevPath = (String)session.getAttribute("prevSnsPath");
		if (EgovStringUtil.isEmpty(prevPath)) {
			javaScript.setMessage("네이버 로그인 유입 경로를 설정하세요.");
		}
		String rootPath = "membership".equals(prevPath) ? ("/" + mainPath) : ("/" + matchingPath);
		String membershipRootPath = "membership".equals(prevPath) ? ("/" + membershipPath) : rootPath;
		
		//로그인 실패오류 또는 동의하지 않은 경우
		if ("access_denied".equals(error)) {
			javaScript.setLocation(rootPath + "/login");
			return new JavaScriptView(javaScript);
		}
		
		String accessToken = null;
		String refreshToken = null;
		MbrVO naverUserInfo = null;
		try {
			Map<String, Object> resultMap = naverApiService.getToken(code, state);
			accessToken = (String)resultMap.get("accessToken");
			refreshToken = (String)resultMap.get("refreshToken");
			
			naverUserInfo = naverApiService.getNaverUserInfo(accessToken, refreshToken);
			if (naverUserInfo == null) {
				throw new Exception();
			}
		} catch (Exception ex) {
			javaScript.setMessage("네이버로부터 로그인정보를 받아오지 못하였습니다.");
			javaScript.setLocation(rootPath + "/login");
			return new JavaScriptView(javaScript);
		}


		//로그인 한 상태라면 재인증 처리
		if(mbrSession.isLoginCheck()) {
			return new JavaScriptView(mbrService.reAuthCheck("N", naverUserInfo, session));
		}
		
		
		//회원 정보 유효성 검사
		try {
			Map<String, Object> validationResult = mbrService.validateForSnsLogin(session, naverUserInfo);
			
			//검색 회원이 없으면 회원가입 처리
			if (!validationResult.containsKey("srchMbrVO")) {
				mbrService.registerSnsMbrAndLogin(session, naverUserInfo, null);
				
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
			, HttpSession session
			) throws Exception {
		
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
		
		String naverUrl = naverApiService.getNaverReAuth();

		javaScript.setLocation(naverUrl);
		return new JavaScriptView(javaScript);
	}
}
