package icube.app.matching;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.View;

import icube.app.matching.mbr.biz.MatMbrSession;
import icube.common.framework.abst.CommonAbstractController;
import icube.common.framework.view.JavaScript;
import icube.common.framework.view.JavaScriptView;
import icube.common.util.RSA;

@Controller
@RequestMapping(value="#{props['Globals.Matching.path']}")
public class MatLoginController extends CommonAbstractController {
	
	@Autowired
	private MatMbrSession matMbrSession;
	
	@Value("#{props['Globals.Matching.path']}")
	private String matchingPath;
	
	private static final String RSA_MEMBERSHIP_KEY = "__rsaMembersKey__";
	
	
	@RequestMapping(value="login")
	public String login(
			HttpServletRequest request
			, HttpSession session) {
		
		//로그인되어 있다면 main으로 redirect
		if (matMbrSession.isLoginCheck()) {
			return "redirect:/" + matchingPath;
		}

		//암호화
		RSA rsa = RSA.getEncKey();
		request.setAttribute("publicKeyModulus", rsa.getPublicKeyModulus());
		request.setAttribute("publicKeyExponent", rsa.getPublicKeyExponent());
		session.setAttribute(RSA_MEMBERSHIP_KEY, rsa.getPrivateKey());
		
		return "/app/matching/login";
	}
	
	@RequestMapping("loginAction")
	public View action(
			@RequestParam(required=true, value="mbrId") String mbrId
			, @RequestParam(required=true, value="encPw") String encPw  //RSA 암호화된 패스워드
			, HttpServletRequest request
			, HttpServletResponse response
			, HttpSession session
	) throws Exception {
		JavaScript javaScript = new JavaScript();
		return new JavaScriptView(javaScript);
	}
}
