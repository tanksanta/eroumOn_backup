package icube.app.matching.membership;

import javax.annotation.Resource;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.View;

import icube.common.api.biz.KakaoApiService;
import icube.common.framework.abst.CommonAbstractController;
import icube.common.framework.view.JavaScript;
import icube.common.framework.view.JavaScriptView;

/**
 * 매칭앱 - 카카오 로그인
 */
@Controller
@RequestMapping(value="#{props['Globals.Matching.path']}/kakao")
public class MatKakaoController extends CommonAbstractController {
	
	@Resource(name = "kakaoApiService")
	private KakaoApiService kakaoApiService;
	
	@Value("#{props['Globals.Matching.path']}")
	private String matchingPath;
	
	
	/**
	 * 카카오 로그인 버튼이 있는 화면
	 */
	@RequestMapping(value = "/login")
	public String loginView() {
		return "/app/matching/membership/kakaoLogin";
	}
	
	/**
	 * 카카오측 로그인화면 이동
	 */
	@RequestMapping(value = "/auth")
	public View auth(
			HttpSession session
			)throws Exception {

		JavaScript javaScript = new JavaScript();
		String kakaoUrl = kakaoApiService.getKakaoUrl();
		
		session.setAttribute("prevSnsPath", "matching");

		javaScript.setLocation(kakaoUrl);
		return new JavaScriptView(javaScript);
	}
}
