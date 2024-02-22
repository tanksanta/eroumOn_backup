package icube.app.matching.common.interceptor;

import java.util.ArrayList;
import java.util.Enumeration;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.lang.Nullable;
import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.servlet.ModelAndView;

import icube.app.matching.membership.mbr.biz.MatMbrService;
import icube.app.matching.membership.mbr.biz.MatMbrSession;

public class MatInterceptor implements HandlerInterceptor {
	protected Log log = LogFactory.getLog(this.getClass());
	
	@Resource(name = "matMbrService")
	private MatMbrService matMbrService;
	
	@Autowired
	private MatMbrSession matMbrSession;
	
	@Value("#{props['Globals.Matching.path']}")
	private String matchingPath;
	
	@Value("#{props['Bootpay.Script.Key']}")
	private String bootpayScriptKey;

	@Value("#{props['Profiles.Active']}")
	private String activeMode;
	
	/**
	 * 인증이 필요한 페이지 정의
	 */
	private List<String> checkUri = new ArrayList<String>(){
		private static final long serialVersionUID = 968028594716471048L;
		{
			add("/matching");
		}
	};
	
	
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
			request.setAttribute("_matchingPath", matchingPath);
			
			//시스템 점검으로 redirect (임시 구현)
//			if (true && !"/matching/common/systemCheck".equals(request.getServletPath())) {
//				response.sendRedirect("/matching/common/systemCheck");
//				return false;
//			}
			
			
			//자동로그인 검사
			boolean isAutoLogin = matMbrService.checkAutoLogin(request);
			request.setAttribute("_matMbrSession", matMbrSession);
			if (isAutoLogin) {
				response.sendRedirect("/matching");
				return false;
			}
			
			//인증이 필요없으면 바로 페이지 반환
			if (!checkUri.contains(request.getServletPath())) {
				return true;
			}
			
			//로그인 되어 있지 않으면 로그인창으로 이동
			if (matMbrSession.isLoginCheck() == false) {
				response.sendRedirect("/matching/kakao/login");
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
