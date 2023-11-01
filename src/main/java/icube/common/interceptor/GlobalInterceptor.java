/*
 *
 */
package icube.common.interceptor;

import java.util.Enumeration;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.egovframe.rte.fdl.string.EgovStringUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.MessageSource;
import org.springframework.lang.Nullable;
import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.servlet.ModelAndView;

import icube.common.interceptor.biz.CustomProfileVO;
import icube.common.util.CommonUtil;
import icube.common.values.CodeMap;
import icube.common.vo.CommonListVO;
import icube.manage.consult.biz.MbrConsltService;
import icube.manage.mbr.mbr.biz.MbrService;
import icube.manage.mbr.mbr.biz.MbrVO;
import icube.market.mbr.biz.MbrSession;


public class GlobalInterceptor implements HandlerInterceptor {

	protected Log log = LogFactory.getLog(this.getClass());

	@Resource(name = "mbrService")
	private MbrService mbrService;
	
	@Resource(name = "mbrConsltService")
	private MbrConsltService mbrConsltService;

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

	@Value("#{props['Globals.Main.path']}")
	private String mainPath;

	@Value("#{props['Bootpay.Script.Key']}")
	private String bootpayScriptKey;

	@Value("#{props['Profiles.Active']}")
	private String activeMode;

	@Value("#{props['Kakao.Script.key']}")
	private String kakaoScriptKey;


	@Autowired
	private MbrSession mbrSession;

	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {


		response.setContentType("text/html; charset=UTF-8");
		request.setCharacterEncoding("UTF-8");

		log.debug(" ################################################################## ");
		log.debug(" # START Global interceptor preHandle");
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
			// 주소
			if(EgovStringUtil.isNotEmpty(mbrSession.getAddr())) {
				String[] spAddr = mbrSession.getAddr().split(" ");
				if(spAddr.length > 1) {
					String mbrAddr = spAddr[0] + " " + spAddr[1];
					request.setAttribute("_mbrAddr", mbrAddr.trim());
					request.setAttribute("_mbrAddr1", spAddr[0].trim());
					request.setAttribute("_mbrAddr2", spAddr[1].trim());
				}
			}

			// 나이
			if(mbrSession.getBrdt() != null) {
				String mbrAge = CommonUtil.getAge(mbrSession.getBrdt());
				request.setAttribute("_mbrAge", mbrAge);
			}
		}

		// 코드
		request.setAttribute("gradeCode", CodeMap.GRADE);
		request.setAttribute("recipterYnCode", CodeMap.RECIPTER_YN);

		// 경로
		request.setAttribute("_membershipPath", "/" + membershipPath);
		request.setAttribute("_marketPath", "/" + marketPath);
		request.setAttribute("_membersPath", "/" + membersPath);
		request.setAttribute("_plannerPath", "/" + plannerPath);
		request.setAttribute("_mainPath", "/" + mainPath);
		request.setAttribute("_curPath", curPath);

		// 기타
		request.setAttribute("_bootpayScriptKey", bootpayScriptKey);
		request.setAttribute("_kakaoScriptKey", kakaoScriptKey);
		request.setAttribute("_activeMode", activeMode.toUpperCase());

		request.setAttribute("_mbrSession", mbrSession);
		

		//채널톡 연동 데이터 셋팅
		if (mbrSession.isLoginCheck()) {
			CustomProfileVO customProfileVO = new CustomProfileVO();
			
			if (mbrSession.getCustomProfileVO() == null) {
				try {
					MbrVO mbrVO = mbrService.selectMbrByUniqueId(mbrSession.getUniqueId());
					customProfileVO.setMbrId(mbrVO.getMbrId());
					customProfileVO.setMbrNm(mbrVO.getMbrNm());
					customProfileVO.setMblTelno(mbrVO.getMblTelno());
					customProfileVO.setEml(mbrVO.getEml());
					customProfileVO.setSmsRcptnYn(mbrVO.getSmsRcptnYn() == null || "N".equals(mbrVO.getSmsRcptnYn()) ? "미수신" : "수신");
					customProfileVO.setEmlRcptnYn(mbrVO.getEmlRcptnYn() == null || "N".equals(mbrVO.getEmlRcptnYn()) ? "미수신" : "수신");
					
					CommonListVO listVO = new CommonListVO(request);
					listVO.setParam("srchUseYn", "Y");
					listVO.setParam("srchUniqueId", mbrSession.getUniqueId());
					listVO = mbrConsltService.selectMbrConsltListVO(listVO);
					
					customProfileVO.setMbrConsltCnt(listVO.getListObject().size());
					
					mbrSession.setCustomProfileVO(customProfileVO);
				} catch (Exception ex) {
					log.error("===== globalInterceptor mbr 조회 오류", ex);
				}
			} else {
				customProfileVO = mbrSession.getCustomProfileVO();
			}
			
			request.setAttribute("customProfileVO", customProfileVO);
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
