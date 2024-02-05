package icube.common.interceptor;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.Enumeration;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.egovframe.rte.fdl.string.EgovStringUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.servlet.ModelAndView;

import icube.manage.sysmng.mngr.biz.MngrService;
import icube.manage.sysmng.mngr.biz.MngrSession;


/**
 * 관리자 인터셉터 > 접속 권한체크
 */
public class MngAuthInterceptor implements HandlerInterceptor {

	protected Log log = LogFactory.getLog(this.getClass());

	@Autowired
	private MngrSession mngrSession;

	private long timer = 0l;

	@Resource(name = "mngrService")
	private MngrService mngrService;

	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {

		if (log.isDebugEnabled()) {
			log.debug(" ################################################################## ");
			log.debug(" # START manager's interceptor preHandle");
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
			log.debug(" # MNGR_SESSION_KEY : " + mngrSession.getMNGR_SESSION_KEY());
			log.debug(" # MNGR ID : " + mngrSession.getMngrId());
			log.debug(" # IS LOGIN : " + mngrSession.isLoginCheck());
			log.debug(" ################################################################## ");
		}

		if(mngrSession.isLoginCheck() || mngrService.getLoginInfoFromCookies(request)) {

			String curPath = request.getServletPath();
			int cutpos = curPath.lastIndexOf("/");
			String matchPath = curPath.substring(0,cutpos+1);

			if(matchPath.startsWith("/_mng/sysmng/bbs/")) {
				matchPath = "/_mng/sysmng/bbsSet/";
			}else if(matchPath.startsWith("/_mng/clcln/partners")) {
				matchPath = "/_mng/clcln/partners";
			}else if(matchPath.startsWith("/_mng/mbr/black/")) {
				matchPath = "/_mng/mbr/black/";
			}else if(matchPath.startsWith("/_mng/mbr/human")) {
				matchPath = "/_mng/mbr/human/";
			}else if(matchPath.startsWith("/_mng/mbr/exit")) {
				matchPath = "/_mng/mbr/exit/";
			}else if(matchPath.startsWith("/_mng/mbr/sms")) {
				matchPath = "/_mng/mbr/sms/";
			}else if(matchPath.startsWith("/_mng/mbr/")) {
				matchPath = "/_mng/mbr/";
			}else if(matchPath.startsWith("/_mng/sysmng/entrps/dlvygrp")) {
				matchPath = "/_mng/sysmng/entrps/dlvygrp/list";
			}else if(matchPath.startsWith("/_mng/sysmng/entrps")) {
				matchPath = "/_mng/sysmng/entrps/list";
			}

			List<String> mngMenuPathList = new ArrayList<String>();
			for(int i=0; i<mngrSession.getMngMenuList().size(); i++) {
				String url = mngrSession.getMngMenuList().get(i).getMenuUrl();
				if(EgovStringUtil.isNotEmpty(url) && url.startsWith(matchPath)) {
					request.setAttribute("_mngMenuVO", mngrSession.getMngMenuList().get(i));

					for(String path : mngrSession.getMngMenuList().get(i).getMenuPath().replaceAll("/", " ").trim().split(" ")) {
						mngMenuPathList.add(path);
					}
					break;
				}
			}

			request.setAttribute("_mngrSession", mngrSession);
			request.setAttribute("_mngMenuList", mngrSession.getMngMenuList());
			request.setAttribute("_mngMenuPathList", mngMenuPathList);
			request.setAttribute("_curPath", curPath);

			log.debug(" # _mngMenuPathList : " + mngMenuPathList);
			log.debug(" # _curPath : " + curPath);

		} else {
			log.debug(" # You need login to use this system. ");

			printLoginError(response);
			//response.sendRedirect("/_mng/login");// alert으로 변경 필요
			return false;
		}


		return true;
	}

	@Override
	public void postHandle(HttpServletRequest request, HttpServletResponse response, Object handler, ModelAndView modelAndView) throws Exception {
		log.debug(" ################################################################## ");
		log.debug(" # START manager's interceptor postHandle");
		log.debug(" # servlet execute time millis : " + (System.currentTimeMillis() - timer));
		request.setAttribute("_executeTimeMillis", System.currentTimeMillis() - timer);

		response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
		response.setHeader("Pragma", "no-cache");
		response.setDateHeader("Expires", 0);

		log.debug(" ################################################################## ");

	}


	private void printLoginError(HttpServletResponse response) throws IOException {

		response.setCharacterEncoding("UTF-8");
		response.setContentType("text/html; charset=UTF-8");

		PrintWriter out = response.getWriter();
		out.println("<!DOCTYPE html>");
		out.println("<html lang=\"ko\">");
		out.println("<head>");
		out.println("<meta charset=\"UTF-8\">");
		out.println("<script>");
		out.println("alert(\"이로움마켓 관리시스템을 이용하시려면 로그인이 필요합니다.\");");
		out.println("window.location.replace('/_mng/login')");
		out.println("</script>");
		out.println("</head>");
		out.println("<body>You need login to use this system</body>");
		out.println("</html>");
		out.flush();
		out.close();
	}

}
