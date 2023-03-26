package icube.common.framework.exception;

import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.servlet.ModelAndView;

/**
 * ExceptionAdvice
 * 에러페이지를 어떻게 처리할까하다 만들어 둠.. 사용x
 *
 */
//@ControllerAdvice
public class CommonExceptionAdvice {

	@ExceptionHandler(CommonErrorException.class)
	public ModelAndView commonExceptionHandler(Exception e, String url) {
		ModelAndView view = new ModelAndView();
		view.addObject("errorMessage", e.getMessage());
		view.setViewName("/common/error");
		return view;
	}

}
