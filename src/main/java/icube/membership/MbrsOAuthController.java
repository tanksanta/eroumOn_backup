package icube.membership;

import java.util.HashMap;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.http.HttpStatus;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import icube.common.util.RSA;
import icube.manage.mbr.mbr.biz.MbrService;

@Controller
@RequestMapping(value="#{props['Globals.Membership.path']}/oauth")
public class MbrsOAuthController {
    @Resource(name = "mbrService")
	private MbrService mbrService;

    private static final String RSA_LOGINPUBLIC_KEY = "__rsaLoginPublicKey__";

    
	@ResponseBody
	@RequestMapping(value="loginpublic.json")
	public Map<String, Object> loginPublic(HttpServletRequest request
		, @RequestParam Map<String,Object> reqMap
		, @RequestParam (value = "returnUrl", required=false) String returnUrl
		, HttpSession session
		, Model model) throws Exception{

		Map<String, Object> resultMap = new HashMap<String, Object>();
		//암호화
		RSA rsa = RSA.getEncKey();
		session.setAttribute(RSA_LOGINPUBLIC_KEY, rsa.getPrivateKey());
		// session.setAttribute("publicKeyModulus", rsa.getPublicKeyModulus());

		resultMap.put("publicKeyModulus", rsa.getPublicKeyModulus());
		resultMap.put("publicKeyExponent", rsa.getPublicKeyExponent());

		return resultMap;
	}

	@ResponseBody
	@RequestMapping(value="loginaction.json")
	public Map<String, Object> loginAction(
		@RequestParam(required=true, value="mbrId") String mbrId
		, @RequestParam(required=true, value="encPw") String encPw
		, HttpServletRequest request
		, HttpServletResponse response
		, HttpSession session
		, Model model) throws Exception{

		Map<String, Object> resultMap = new HashMap<String, Object>();

		if (session.getAttribute(RSA_LOGINPUBLIC_KEY) == null){
			response.setStatus(HttpStatus.FORBIDDEN.value());
			
			return resultMap;
		}
		resultMap = mbrService.validateForEroumLogin(RSA_LOGINPUBLIC_KEY, mbrId, encPw, session);

		return resultMap;
	}

}
