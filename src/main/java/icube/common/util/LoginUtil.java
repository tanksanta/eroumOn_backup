package icube.common.util;

import java.util.Map;

import org.springframework.web.servlet.mvc.support.RedirectAttributes;


public class LoginUtil {
	/*
	 * 세션 타임아웃시 로그인 화면으로 이동하기 전 현재 페이지로 돌아오기 위한 값들 저장
	 * */
	public static void loginRedirectValue(RedirectAttributes redirectAttributes, String loginRedirectUrl, Map<String, Object> reqMap, boolean bDoubleSubmitPreventer) throws Exception {
		
		redirectAttributes.addFlashAttribute("loginRedirectMethod", "POST");
	    redirectAttributes.addFlashAttribute("loginRedirectUrl", Base64Util.encoder(loginRedirectUrl));
	    
	    if (reqMap != null) {
	    	redirectAttributes.addFlashAttribute("loginRedirectParam", Base64Util.encoder(JsonUtil.getJsonStringFromMap(reqMap)));		
	    }
		
	    if (bDoubleSubmitPreventer) {
	    	redirectAttributes.addFlashAttribute("loginRedirectDoubleSubmit", "1");	
	    }
	}
}