package icube.common.framework.exception;

import java.util.Enumeration;

import javax.servlet.http.HttpServletRequest;

import org.egovframe.rte.fdl.string.EgovStringUtil;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

/**
 * Error 핸들링 컨트롤러
 */
@Controller
public class ErrorController {
	
	@RequestMapping(value = "/errors")
	public ModelAndView procErrors(HttpServletRequest request) {
		ModelAndView mav = new ModelAndView();
		Integer httpErrorCode = Integer.parseInt(request.getAttribute("javax.servlet.error.status_code").toString());
		String errorUri = request.getAttribute("javax.servlet.error.request_uri").toString();
		
//		Object ex = request.getAttribute("javax.servlet.error.exception");
//		String errorMsg = "";
//		if (ex != null) {
//			errorMsg = ((Exception)ex).getMessage();
//		}
		
		if (errorUri.startsWith("/matching")) {
			switch (httpErrorCode) {
				case 400:
					mav.setViewName("/app/matching/error/error");
					break;
				case 404:
					mav.setViewName("/app/matching/error/pageNotFound");
					break;
				case 500:
					mav.setViewName("/app/matching/error/error");
					break;
				default:
					mav.setViewName("/app/matching/error/error");
					break;
			}
		}
		else {
			switch (httpErrorCode) {
				case 400:
					mav.setViewName("error/error");
					break;
				case 404:
					mav.setViewName("error/pageNotFound");
					break;
				case 500:
					mav.setViewName("error/error");
					break;
				default:
					mav.setViewName("error/error");
					break;
			}
		}
		
		return mav;
	}
}
