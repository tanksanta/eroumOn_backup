/*
 *
 */
package icube.common.interceptor;

import java.util.HashMap;
import java.util.Map;

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

import icube.manage.mbr.mbr.biz.MbrService;
import icube.market.mbr.biz.MbrSession;


public class MbrAuthInterceptor implements HandlerInterceptor {

	protected Log log = LogFactory.getLog(this.getClass());

	@Resource(name = "mbrService")
	private MbrService mbrService;

	@Value("#{props['Globals.Membership.path']}")
	private String membershipPath;

	@Autowired
	private MbrSession mbrSession;

	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {
		response.setContentType("text/html; charset=UTF-8");
		request.setCharacterEncoding("UTF-8");

		log.debug(" ################################################################## ");
		log.debug(" # START MbrAuth interceptor preHandle");
		log.debug(" # IS LOGIN : " + mbrSession.isLoginCheck());
		log.debug(" ################################################################## ");

		Map<String, Object> mbrEtcInfoMap = new HashMap<String, Object>();
		// 로그인 확인
		if(mbrSession.isLoginCheck()) {
			mbrEtcInfoMap = mbrService.selectMbrEtcInfo(mbrSession.getUniqueId());
		} else {
			response.sendRedirect("/" + membershipPath + "/login");
			return false;
		}
		request.setAttribute("_mbrEtcInfoMap", mbrEtcInfoMap);


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
