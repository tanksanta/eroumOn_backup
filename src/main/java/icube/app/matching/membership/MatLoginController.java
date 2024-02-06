package icube.app.matching.membership;

import java.util.HashMap;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.egovframe.rte.fdl.string.EgovStringUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import icube.app.matching.membership.mbr.biz.MatMbrSession;
import icube.common.framework.abst.CommonAbstractController;
import icube.common.util.RSA;
import icube.common.util.WebUtil;
import icube.manage.mbr.mbr.biz.MbrService;
import icube.manage.mbr.mbr.biz.MbrVO;

/**
 * 매칭앱 - 일반 로그인
 */
@Controller
@RequestMapping(value="#{props['Globals.Matching.path']}/membership")
public class MatLoginController extends CommonAbstractController {
	
	@Resource(name = "mbrService")
	private MbrService mbrService;
	
	@Autowired
	private MatMbrSession matMbrSession;
	
	@Value("#{props['Globals.Matching.path']}")
	private String matchingPath;
	
	@Value("#{props['Bootpay.Script.Key']}")
	private String bootpayScriptKey;

	@Value("#{props['Profiles.Active']}")
	private String activeMode;
	
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
		Object privateKey = session.getAttribute(RSA_MEMBERSHIP_KEY);
		if (privateKey == null) {
			RSA rsa = RSA.getEncKey();
			String publicKeyModulus = rsa.getPublicKeyModulus();
			String publicKeyExponent = rsa.getPublicKeyExponent();
			
			request.setAttribute("publicKeyModulus", publicKeyModulus);
			request.setAttribute("publicKeyExponent", publicKeyExponent);
			session.setAttribute("publicKeyModulus", publicKeyModulus);
			session.setAttribute("publicKeyExponent", publicKeyExponent);
			session.setAttribute(RSA_MEMBERSHIP_KEY, rsa.getPrivateKey());
		} else {
			request.setAttribute("publicKeyModulus", (String)session.getAttribute("publicKeyModulus"));
			request.setAttribute("publicKeyExponent", (String)session.getAttribute("publicKeyExponent"));
		}
		
		session.setAttribute("_matchingPath", matchingPath);
		request.setAttribute("_bootpayScriptKey", bootpayScriptKey);
		request.setAttribute("_activeMode", activeMode.toUpperCase());
		
		return "/app/matching/membership/login";
	}
	
	@ResponseBody
	@RequestMapping("loginAction")
	public Map<String, Object> action(
			@RequestParam String mbrId
			, @RequestParam String encPw  //RSA 암호화된 패스워드
			, HttpServletRequest request
			, HttpServletResponse response
			, HttpSession session
	) throws Exception {
		Map <String, Object> resultMap = new HashMap<String, Object>();
		resultMap.put("success", false);
		
		try {
			//아이디, 패스워드 및 각종 회원 유효성 검사
			Map<String, Object> validationResult = mbrService.validateForEroumLogin(mbrId, encPw, session);
			boolean isValid = (boolean)validationResult.get("valid");
			if (!isValid) {
				resultMap.put("msg", validationResult.get("msg"));
				return resultMap;
			}
			MbrVO srchMbrVO = (MbrVO)validationResult.get("srchMbrVO");
			
			// 최근 접속 일시 업데이트
			mbrService.updateRecentDtAndLgnTy(srchMbrVO.getUniqueId(), srchMbrVO, "E");
			
			//로그인 성공 시 실패 횟를 초기화
			mbrService.updateFailedLoginCountReset(srchMbrVO);
			
			//매칭앱 토큰 발급
			String appToken = mbrService.updateMbrAppTokenInfo(srchMbrVO.getUniqueId());
			resultMap.put("appMatToken", appToken);
			
			//위치정보 가져오기
			String locationValueStr = WebUtil.getCookieValue(request, "location");
			if (EgovStringUtil.isNotEmpty(locationValueStr)) {
				String[] location = locationValueStr.split("AND");
				if (location.length > 1) {
					mbrService.updateMbrLocation(srchMbrVO.getUniqueId(), location[0], location[1]);
				}
			}
			
			//로그인 처리
			matMbrSession.login(session, srchMbrVO);
			
			resultMap.put("success", true);
		} catch (Exception ex) {
			resultMap.put("msg", "로그인 중 오류가 발생하였습니다.");
		}
		
		return resultMap;
	}
	
	@ResponseBody
	@RequestMapping("logoutAction")
	public Map<String, Object> logoutAction() {
		
		matMbrSession.logout();
		
		Map <String, Object> resultMap = new HashMap<String, Object>();
		resultMap.put("success", true);
		return resultMap;
	}
}
