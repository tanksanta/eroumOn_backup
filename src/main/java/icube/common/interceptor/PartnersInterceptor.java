package icube.common.interceptor;

import java.util.Enumeration;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.MessageSource;
import org.springframework.web.servlet.HandlerInterceptor;

import icube.common.util.DateUtil;
import icube.manage.members.bplc.biz.BplcService;
import icube.manage.members.bplc.biz.BplcVO;
import icube.members.biz.PartnersSession;

/**
 * 파트너스(사업소,입점업체) 인터셉터
 * - 사업소 관리자 접속권한 체크
 */
public class PartnersInterceptor implements HandlerInterceptor {

	protected Log log = LogFactory.getLog(this.getClass());

	@Resource(name="messageSource")
	private MessageSource messageSource;

	@Resource(name = "bplcService")
	private BplcService bplcService;

	@Autowired
	private PartnersSession partnersSession;

	@Value("#{props['Globals.Market.path']}")
	private String marketPath;

	@Value("#{props['Globals.Members.path']}")
	private String membersPath;

	@Value("#{props['Globals.Membership.path']}")
	private String membershipPath;

	@Value("#{props['Globals.Planner.path']}")
	private String plannerPath;

	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
		log.debug(" ################################################################## ");
		log.debug(" # START Members interceptor preHandle");
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
					log.debug(" #### parameter name = '" + key + "', value = '" + request.getParameter(key)
							+ "'");
				}
			} else {
				log.debug(" #### parameter name is Object");
			}
		}
		log.debug(" # Partners ID : " + partnersSession.getPartnersId());
		log.debug(" # IS LOGIN : " + partnersSession.isLoginCheck());
		log.debug(" ################################################################## ");

		if(partnersSession.isLoginCheck()) { //로그인이 되어 있고 관리자에 접속하려고 하면

			BplcVO bplcSetupVO = bplcService.selectBplcByUniqueId(partnersSession.getUniqueId());
			String curPath = request.getServletPath();
			String uriPathSplit[] = curPath.split("/");

			/*if(!EgovStringUtil.equals(uriPathSplit[3], bplcSetupVO.getBplcUrl())) { //다른곳에서 관리자 접속하면 해당 사용자의 관리자로 이동
				response.sendRedirect("/" + membersPath + "/list");
				return false;
			}*/

			request.setAttribute("bplcSetupVO", bplcSetupVO);
			request.setAttribute("_partnersSession", partnersSession);
			request.setAttribute("_bplcPath", "/" + membersPath + "/" + bplcSetupVO.getBplcUrl());

			request.setAttribute("_marketPath", "/" + marketPath);
			request.setAttribute("_plannerPath", "/" + plannerPath);

			request.setAttribute("_curPath", curPath);

			// 오늘 날짜
			request.setAttribute("_today", DateUtil.getToday("yyyy.MM.dd.") +"("+ DateUtil.getDayOfWeek()+")");

		} else {
			// 로그인 필요
			response.sendRedirect("/" + membersPath + "/login");
			return false;
		}

		return true;
	}
}
