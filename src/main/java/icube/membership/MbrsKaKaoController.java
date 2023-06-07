package icube.membership;

import java.util.HashMap;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
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
import icube.market.mbr.biz.MbrSession;

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

	@Autowired
	private MbrSession mbrSession;

	@RequestMapping(value = "/auth")
	public View auth(
			HttpServletRequest request
			, Model model
			)throws Exception {

		JavaScript javaScript = new JavaScript();
		String kakaoUrl = kakaoApiService.getKakaoUrl();

		javaScript.setLocation(kakaoUrl);
		return new JavaScriptView(javaScript);
	}

	@RequestMapping(value = "/getToken")
	public View getKakaoUserInfo(
			HttpServletRequest request
			, Model model
			, @RequestParam(value="code", required=true) String code
			)throws Exception {

		JavaScript javaScript = new JavaScript();
		Map<String, Object> resultMap = new HashMap<String, Object>();
		boolean result = false;

		resultMap = kakaoApiService.mbrAction(code);
		result = (boolean)resultMap.get("result");

		if(!result) {
			if(!mbrSession.isEasyCheck()) {
				//TODO 랜딩 페이지로 변경
				javaScript.setLocation("/");
			}else{
				javaScript.setMessage("회원가입이 완료되었습니다.");
				javaScript.setLocation("/");
			}
		}else {
			javaScript.setMessage("카카오 간편 로그인 오류가 발생하였습니다. 잠시 후 다시 시도해주세요.");
			javaScript.setMethod("window.history.back()");
		}
		return new JavaScriptView(javaScript);
	}
}
