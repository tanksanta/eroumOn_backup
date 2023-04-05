package icube.planner;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.egovframe.rte.fdl.string.EgovStringUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import icube.common.api.biz.BokjiApiService;
import icube.common.api.biz.BokjiServiceVO;
import icube.common.framework.abst.CommonAbstractController;
import icube.common.util.RSA;
import icube.common.vo.CommonListVO;
import icube.manage.members.bplc.biz.BplcService;
import icube.market.mbr.biz.MbrSession;
import icube.members.stdg.biz.StdgCdService;
import icube.members.stdg.biz.StdgCdVO;
import icube.planner.biz.PlannerService;


/**
 * 플래너

 * - default location : 서울특별시 금천구
 * - 내부에서 사용하는 약어와 복지24 API에서 사용하는 약어가 다르니 주의할 것
 */
@Controller
@RequestMapping(value="#{props['Globals.Planner.path']}")
public class PlannerController extends CommonAbstractController  {

	@Resource(name = "plannerService")
	private PlannerService plannerService;

	@Resource(name = "stdgCdService")
	private StdgCdService stdgCdService;

	@Resource(name="bokjiService")
	private BokjiApiService bokjiService;

	@Resource(name = "bplcService")
	private BplcService bplcService;

	@Autowired
	private MbrSession mbrSession;

	private static final String RSA_MEMBERSHIP_KEY = "__rsaMembersKey__";

	// INDEX
	@RequestMapping(value={"", "index"})
	public String index(
			@RequestParam Map<String,Object> reqMap
			, HttpServletRequest request
			, Model model) throws Exception {


		// 행정구역 목록
		List<StdgCdVO> stdgCdList = stdgCdService.selectStdgCdListAll(1);
		model.addAttribute("stdgCdList", stdgCdList);
		model.addAttribute("isIndex", true);

		return "/planner/index";
	}


	/**
	 * 복지서비스 목록
	 *
	 */
	@RequestMapping(value="srchSrvcList")
	public String srchSrvc(
			@RequestParam Map<String,Object> reqMap
			, HttpServletRequest request
			, Model model) throws Exception {

		int curPage = EgovStringUtil.string2integer((String) reqMap.get("curPage"), 1);
		String sido = (String) reqMap.get("sido");
		String gugun = (String) reqMap.get("gugun");
		String category = ((String) reqMap.get("category")).replace("|", ",");
		if(category.contains("지원")) {
			category = category.replace("지원", "지원금품");
		}

		CommonListVO listVO = new CommonListVO(request, curPage, 8);
		listVO.setParam("sprName", sido);
		listVO.setParam("cityName", gugun);
		listVO.setParam("categoryList", category);

		try {// 첫화면 부터 에러나지 않도록..
			listVO = bokjiService.getSrvcList(listVO);
		} catch (Exception e) {
			log.debug(e.getMessage());
		}

		model.addAttribute("listVO", listVO);

		return "/planner/include/srch_srvc_list";
	}


	@RequestMapping(value="srvcDtl")
	public String modalSrvcDetail(
			@RequestParam Map<String,Object> reqMap
			, HttpServletRequest request
			, Model model) throws Exception {

		String resultCode = "FAIL";

		int bokjiId = EgovStringUtil.string2integer((String) reqMap.get("bokjiId"), 0);

		BokjiServiceVO bokjiServiceVO = null;
		if(bokjiId > 0) {
			try {
				bokjiServiceVO = bokjiService.getSrvcDtl(bokjiId);

				// 로그인 체크> availableKeyword : true
				if(bokjiServiceVO.isAvailableKeyword() && !mbrSession.isLoginCheck()) {
					resultCode = "LOGIN";
				} else {
					resultCode = "SUCCESS";
					model.addAttribute("bokjiVO", bokjiServiceVO);
				}
			} catch (Exception e) {
				log.debug(e.getMessage());
			}
		}

		model.addAttribute("bokjiId", bokjiId);
		model.addAttribute("resultCode", resultCode);

		return "/planner/include/modal_srvc_detail";
	}

	/**
	 * 복지시설 목록
	 */
	@ResponseBody
	@RequestMapping(value="srchInstList.json")
	public Map<String, Object> srchInst(
			@RequestParam(value="srchMode", required=false) String srchMode
			, @RequestParam(value="sido", required=false) String sido
			, @RequestParam(value="gugun", required=false) String gugun

			, @RequestParam(value="isAllow", required=false) boolean isAllow
			, @RequestParam(value="lat", required=false) String lat
			, @RequestParam(value="lot", required=false) String lot
			, @RequestParam(value="dist", required=false) int dist
			, @RequestParam Map<String,Object> reqMap
			, HttpServletRequest request) throws Exception {


		return plannerService.srchInst(isAllow, reqMap, request);
	}


	// 장기요양보험 > Senior-Long-Term-Care
	@RequestMapping(value="Senior-Long-Term-Care")
	public String seniorLongTermCare(
			@RequestParam Map<String,Object> reqMap
			, HttpServletRequest request
			, Model model) throws Exception {


		return "/planner/senior_long_term_care";
	}


	// 고령친화 우수식품 > Senior Friendly Foods
	@RequestMapping(value="Senior-Friendly-Foods")
	public String seniorFriendlyFoods(
			@RequestParam Map<String,Object> reqMap
			, HttpServletRequest request
			, Model model) throws Exception {


		return "/planner/senior_friendly_foods";
	}



	// planner > login
	// 레이아웃마다 모달 로그인이 다를수 있다? -> css적용이 다름
	@RequestMapping(value="modalLogin")
	public String modalLogin(
			HttpServletRequest request
			, @RequestParam Map<String,Object> reqMap
			, HttpSession session
			, Model model) throws Exception {

		// 로그인 체크
		if(mbrSession.isLoginCheck()){

		}

		//암호화
		RSA rsa = RSA.getEncKey();
		request.setAttribute("publicKeyModulus", rsa.getPublicKeyModulus());
		request.setAttribute("publicKeyExponent", rsa.getPublicKeyExponent());
		session.setAttribute(RSA_MEMBERSHIP_KEY, rsa.getPrivateKey());

		return "/planner/include/modal_login";
	}


}
