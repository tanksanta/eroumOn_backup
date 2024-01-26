package icube.app.matching.membership;

import javax.annotation.Resource;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.View;

import icube.common.api.biz.NaverApiService;
import icube.common.framework.abst.CommonAbstractController;
import icube.common.framework.view.JavaScript;
import icube.common.framework.view.JavaScriptView;

/**
 * 매칭앱 - 네이버 로그인
 */
@Controller
@RequestMapping(value="#{props['Globals.Matching.path']}/naver")
public class MatNaverController extends CommonAbstractController {
	
	@Resource(name = "naverApiService")
	private NaverApiService naverApiService;
	
	@Value("#{props['Globals.Matching.path']}")
	private String matchingPath;
	
	
	@RequestMapping(value = "/get")
	public View auth(
			HttpSession session
			)throws Exception {

		JavaScript javaScript = new JavaScript();
		String getUrl = naverApiService.getUrl();
		
		session.setAttribute("prevSnsPath", "matching");

		javaScript.setLocation(getUrl);
		return new JavaScriptView(javaScript);
	}
}
