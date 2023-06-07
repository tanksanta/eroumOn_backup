package icube.membership;

import java.util.HashMap;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.View;

import icube.common.api.biz.NaverApiService;
import icube.common.framework.abst.CommonAbstractController;
import icube.common.framework.view.JavaScript;
import icube.common.framework.view.JavaScriptView;

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

	@RequestMapping(value = "/get")
	public View get() throws Exception {
		JavaScript javaScript = new JavaScript();
		String getUrl = naverApiService.getUrl();

		javaScript.setLocation(getUrl);
		return new JavaScriptView(javaScript);
	}

	@RequestMapping(value = "/auth")
	public View auth(
			HttpServletRequest request
			, Model model
			, @RequestParam(value = "code", required=true) String code
			, @RequestParam(value = "state", required=false) String state
			) throws Exception {
		JavaScript javaScript = new JavaScript();

		Map<String, Object> paramMap = new HashMap<String, Object>();
		paramMap.put("code", code);
		paramMap.put("state", state);

		boolean result = naverApiService.mbrAction(paramMap);

		if(result) {
			javaScript.setLocation("/");
		}else {
			javaScript.setMessage("회원가입이 완료되었습니다.");
			javaScript.setLocation("/");
		}

		return new JavaScriptView(javaScript);
	}

}
