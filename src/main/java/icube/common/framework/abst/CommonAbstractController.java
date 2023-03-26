package icube.common.framework.abst;

import java.util.Locale;

import javax.annotation.Resource;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.context.MessageSource;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;
import org.springframework.web.servlet.i18n.SessionLocaleResolver;

public abstract class CommonAbstractController {

	protected Log log = LogFactory.getLog(this.getClass());

	@Resource(name = "messageSource")
	private MessageSource messageSource;

	public String getMsg(String code) {
		Locale locale = (Locale) ((ServletRequestAttributes) RequestContextHolder
				.currentRequestAttributes())
				.getRequest()
				.getSession()
				.getAttribute(
						SessionLocaleResolver.LOCALE_SESSION_ATTRIBUTE_NAME);
		return messageSource.getMessage(code, null, locale);
	}

	public String getMsg(String code, String[] args) {
		Locale locale = (Locale) ((ServletRequestAttributes) RequestContextHolder
				.currentRequestAttributes())
				.getRequest()
				.getSession()
				.getAttribute(
						SessionLocaleResolver.LOCALE_SESSION_ATTRIBUTE_NAME);
		return messageSource.getMessage(code, args, locale);
	}


}
