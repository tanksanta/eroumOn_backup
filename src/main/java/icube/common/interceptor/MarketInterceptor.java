package icube.common.interceptor;

import java.util.ArrayList;
import java.util.Enumeration;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.egovframe.rte.fdl.string.EgovStringUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.MessageSource;
import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.ModelAndViewDefiningException;

import icube.common.util.HMACUtil;
import icube.common.values.CodeMap;
import icube.manage.exhibit.banner.biz.BnnrMngService;
import icube.manage.exhibit.banner.biz.BnnrMngVO;
import icube.manage.exhibit.popup.biz.PopupService;
import icube.manage.exhibit.popup.biz.PopupVO;
import icube.manage.gds.ctgry.biz.GdsCtgryService;
import icube.manage.gds.ctgry.biz.GdsCtgryVO;
import icube.manage.mbr.mbr.biz.MbrService;
import icube.manage.members.bplc.biz.BplcService;
import icube.manage.sysmng.menu.biz.MngMenuVO;
import icube.manage.sysmng.usermenu.biz.MngUserMenuService;
import icube.market.mbr.biz.MbrSession;

/**
 * 마켓 인터셉터
 * - 마켓 기본정보 호출 + 회원정보
 */
public class MarketInterceptor implements HandlerInterceptor {

	protected Log log = LogFactory.getLog(this.getClass());

	@Resource(name = "gdsCtgryService")
	private GdsCtgryService gdsCtgryService;

	@Resource(name = "mbrService")
	private MbrService mbrService;

	@Resource(name = "popupService")
	private PopupService popupService;

	@Resource(name = "bplcService")
	private BplcService bplcService;

	@Resource(name = "mngUserMenuService")
	private MngUserMenuService mngUserMenuService;

	@Resource(name = "bnnrMngService")
	private BnnrMngService bnnrMngService;

	@Resource(name="messageSource")
	private MessageSource messageSource;

	@Value("#{props['Globals.Market.path']}")
	private String marketPath;

	@Value("#{props['Globals.Membership.path']}")
	private String membershipPath;

	@Value("#{props['Globals.Members.path']}")
	private String membersPath;

	@Value("#{props['Globals.Planner.path']}")
	private String plannerPath;

	@Value("#{props['Bootpay.Script.Key']}")
	private String bootpayScriptKey;

	@Value("#{props['Talk.Secret.key']}")
	private String talkSecretKey;

	@Value("#{props['Profiles.Active']}")
	private String activeMode;

	@Autowired
	private MbrSession mbrSession;

	private long timer = 0;

	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {

		timer = System.currentTimeMillis();

		//HttpSession session = request.getSession();

		response.setContentType("text/html; charset=UTF-8");
		request.setCharacterEncoding("UTF-8");

		log.debug(" ################################################################## ");
		log.debug(" # START Market interceptor preHandle");
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
		String matchPath = "/" + marketPath + "/mypage";

		if(curPath.startsWith(matchPath)) {
			System.out.println("matchPath: " + matchPath);
			if(!mbrSession.isLoginCheck()) {
				ModelAndView modelAndView = new ModelAndView("redirect:/"+membershipPath+"/login");
				throw new ModelAndViewDefiningException(modelAndView);
			}
		}


		// 회원정보 호출
		Map<String, Object> mbrEtcInfoMap = new HashMap<String, Object>();
		if(mbrSession.isLoginCheck()) {
			// 급여잔액 & 마일리지 & 포인트 & 장바구니 & 위시리스트
			mbrEtcInfoMap = mbrService.selectMbrEtcInfo(mbrSession.getPrtcrRecipterInfo().getUniqueId());

			// 마일리지 정보
			double mileagePercent = 0.0; // 신규:0.1%
			if(EgovStringUtil.equals("N", mbrSession.getMberGrade())) {
				mileagePercent = 0;
			}else if(EgovStringUtil.equals("S", mbrSession.getMberGrade())) {
				mileagePercent = 050;
			}else if(EgovStringUtil.equals("B", mbrSession.getMberGrade())) {
				mileagePercent = 150;
			}else if(EgovStringUtil.equals("E", mbrSession.getMberGrade())) {
				mileagePercent = 250;
			}
			request.setAttribute("_mileagePercent", mileagePercent);

			String secretKey = talkSecretKey;
			String hash = HMACUtil.encode(mbrSession.getMbrId(), secretKey, "HMACSHA256");

			System.out.println("hash: " + hash);
			request.setAttribute("_mbrIdHash", hash);

		}
		request.setAttribute("_mbrEtcInfoMap", mbrEtcInfoMap);

		// ### return value ###
		request.setAttribute("_mbrSession", mbrSession);
		request.setAttribute("gradeCode", CodeMap.GRADE);


		// 카테고리 정보 S
		List<GdsCtgryVO> gdsCtgryList = gdsCtgryService.selectGdsCtgryList(-1, "Y");
		Map<Integer, String> gdsCtgryListMap = gdsCtgryService.selectGdsCtgryListToMap(-1);
		request.setAttribute("_gdsCtgryList", gdsCtgryList);
		request.setAttribute("_gdsCtgryListMap", gdsCtgryListMap);

		// 상품카테고리 tree(vo < list<vo>)구조로 변경
		GdsCtgryVO rootCategory = gdsCtgryService.findRootCategory(gdsCtgryList);
		rootCategory.setChildList(new ArrayList<>()); // childList 초기화
		rootCategory.buildChildList(gdsCtgryList);
		request.setAttribute("_gnbCtgry", rootCategory);


		// 카테고리 정보 E

		// 사용자 메뉴 S
		Map<String, Object> paramMap = new HashMap<String, Object>();
		paramMap.put("useYn", "Y");
		List<MngMenuVO> userMenuList = mngUserMenuService.selectMngMenuList(paramMap);
		request.setAttribute("_userMenuList", userMenuList);
		// 사용자 메뉴 E

		// 띠 배너 S
		Map<String, Object> bannerMap = new HashMap<String, Object>();
		bannerMap.put("srchUseYn", "Y");
		bannerMap.put("srchNowDate", "1");
		bannerMap.put("srchBannerTy", "S");
		List<BnnrMngVO> bannerList = bnnrMngService.selectBnnrMngList(bannerMap);
		request.setAttribute("_bannerList", bannerList);
		// 띠 배너 E

		// 경로정보
		request.setAttribute("_marketPath", "/" + marketPath);
		request.setAttribute("_membersPath", "/" + membersPath);
		request.setAttribute("_membershipPath", "/" + membershipPath);
		request.setAttribute("_plannerPath", "/" + plannerPath);

		request.setAttribute("_curPath", curPath);

		// 팝업
		Map<String, Object> paramMap2 = new HashMap<String, Object>();
		paramMap2.put("srchYn", "Y");
		paramMap2.put("srchDate", "TODAY");
		List<PopupVO> popupList = popupService.selectPopupListAll(paramMap2);

		request.setAttribute("_popupList", popupList);

		// 마켓정보

		//코드
		request.setAttribute("_gdsTagCode", CodeMap.GDS_TAG);
		request.setAttribute("_gdsTyCode", CodeMap.GDS_TY);

		//기타
		request.setAttribute("_bootpayScriptKey", bootpayScriptKey);
		request.setAttribute("_activeMode", activeMode.toUpperCase());

		return true;
	}



	@Override
	public void postHandle(HttpServletRequest request, HttpServletResponse response, Object handler, ModelAndView modelAndView) throws Exception {

		log.debug(" ################################################################## ");
		log.debug(" # START Market interceptor postHandle");
		log.debug(" # servlet execute time millis : " + (System.currentTimeMillis() - timer));
		request.setAttribute("_executeTimeMillis", System.currentTimeMillis() - timer);

		// 캐시 삭제
		response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
		response.setHeader("Pragma", "no-cache");
		response.setDateHeader("Expires", 0);

		log.debug(" ################################################################## ");
	}

}
