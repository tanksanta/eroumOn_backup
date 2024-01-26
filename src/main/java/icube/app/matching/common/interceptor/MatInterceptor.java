package icube.app.matching.common.interceptor;

import java.util.Enumeration;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.lang.Nullable;
import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.servlet.ModelAndView;

import icube.app.matching.membership.mbr.biz.MatMbrSession;

public class MatInterceptor implements HandlerInterceptor {
	protected Log log = LogFactory.getLog(this.getClass());
	
	@Autowired
	private MatMbrSession matMbrSession;
	
	@Value("#{props['Bootpay.Script.Key']}")
	private String bootpayScriptKey;

	@Value("#{props['Profiles.Active']}")
	private String activeMode;
	
	
	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {

		try {
			response.setContentType("text/html; charset=UTF-8");
			request.setCharacterEncoding("UTF-8");

			log.debug(" ################################################################## ");
			log.debug(" # START Matching interceptor preHandle");
			log.debug(" # preHandle URI : " + request.getServletPath());
			Enumeration<?> en = request.getParameterNames();
			while (en.hasMoreElements()) {
				Object keyObj = en.nextElement();

				if (keyObj instanceof String) {
					String key = (String) keyObj;
					if (request.getParameterValues(key).length != 1) {
						for (String value : request.getParameterValues(key)) {
							log.debug(" #### parameter name = '" + key + "',Array value = '" + value + "'");
						}
					} else {
						log.debug(" #### parameter name = '" + key + "', value = '" + request.getParameter(key) + "'");
					}
				} else {
					log.debug(" #### parameter name is Object");
				}
			}
			log.debug(" # MBER UNIQUE ID : " + matMbrSession.getUniqueId());
			log.debug(" # MBER ID : " + matMbrSession.getMbrId());
			log.debug(" # IS LOGIN : " + matMbrSession.isLoginCheck());
			log.debug(" ################################################################## ");
			
			request.setAttribute("_bootpayScriptKey", bootpayScriptKey);
			request.setAttribute("_activeMode", activeMode.toUpperCase());
			
			request.setAttribute("_matMbrSession", matMbrSession);
			
			if (matMbrSession.isLoginCheck() == false) {
				response.sendRedirect("/matching/membership/login");
				return false;
			}
		} catch (Exception ex) {
			log.error("============= 매칭앱 인터셉터 오류 ================", ex);
		}
		
		return true;
	}
	
	
	@Override
	public void postHandle(HttpServletRequest request, HttpServletResponse response, Object handler,
			@Nullable ModelAndView modelAndView) throws Exception {

		response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
		response.setHeader("Pragma", "no-cache");
		response.setDateHeader("Expires", 0);

	}
}
