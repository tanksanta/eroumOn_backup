package icube.app.matching;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
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
	
	
	@RequestMapping(value = "/auth")
	public View auth(
			HttpServletRequest request
			, HttpSession session
			, Model model
			)throws Exception {

		JavaScript javaScript = new JavaScript();
		String kakaoUrl = kakaoApiService.getKakaoUrl();
		
		session.setAttribute("prevKakaoPath", "matching");

		javaScript.setLocation(kakaoUrl);
		return new JavaScriptView(javaScript);
	}
}
