package icube.common.interceptor;

import java.util.Enumeration;
import java.util.HashMap;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.MessageSource;
import org.springframework.lang.Nullable;
import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.servlet.ModelAndView;

import icube.common.values.CodeMap;
import icube.manage.members.bplc.biz.BplcService;
import icube.market.mbr.biz.MbrSession;


public class MbrAuthInterceptor implements HandlerInterceptor {

	protected Log log = LogFactory.getLog(this.getClass());


	@Resource(name = "bplcService")
	private BplcService bplcService;

	@Resource(name="messageSource")
	private MessageSource messageSource;

	@Value("#{props['Globals.Market.path']}")
	private String marketPath;

	@Value("#{props['Globals.Members.path']}")
	private String membersPath;

	@Value("#{props['Globals.Membership.path']}")
	private String membershipPath;

	@Value("#{props['Globals.Planner.path']}")
	private String plannerPath;

	@Value("#{props['Bootpay.Script.Key']}")
	private String bootpayScriptKey;

	@Value("#{props['Profiles.Active']}")
	private String activeMode;

	@Autowired
	private MbrSession mbrSession;

	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {


		response.setContentType("text/html; charset=UTF-8");
		request.setCharacterEncoding("UTF-8");

		log.debug(" ################################################################## ");
		log.debug(" # START MbrAuth interceptor preHandle");
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
		log.debug(" # MBER UNIQUE ID : " + mbrSession.getUniqueId());
		log.debug(" # MBER ID : " + mbrSession.getMbrId());
		log.debug(" # IS LOGIN : " + mbrSession.isLoginCheck());
		log.debug(" ################################################################## ");

		String curPath = request.getServletPath();

		// 로그인 확인
		if(mbrSession.isLoginCheck()) {


		}


		// 회원정보 페이지 체크


		// 멤버스(bplc) 카운트
		Map<String, Object> paramMap = new HashMap<String, Object>();
		paramMap.put("Y", "srchUseYn"); // 사용중
		paramMap.put("C", "srchAprvTy"); // 승인

		int bplcCnt = bplcService.selectBplcCnt(paramMap);
		request.setAttribute("_bplcCnt", bplcCnt);


		// 코드
		request.setAttribute("gradeCode", CodeMap.GRADE);

		// 경로
		request.setAttribute("_membershipPath", "/" + membershipPath);
		request.setAttribute("_marketPath", "/" + marketPath);
		request.setAttribute("_membersPath", "/" + membersPath);
		request.setAttribute("_plannerPath", "/" + plannerPath);
		request.setAttribute("_curPath", curPath);

		// 기타
		request.setAttribute("_bootpayScriptKey", bootpayScriptKey);
		request.setAttribute("_activeMode", activeMode.toUpperCase());



		request.setAttribute("_mbrSession", mbrSession);

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
