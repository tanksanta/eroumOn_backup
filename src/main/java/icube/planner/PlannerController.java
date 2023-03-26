package icube.planner;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.egovframe.rte.fdl.string.EgovStringUtil;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import icube.common.api.biz.BokjiApiService;
import icube.common.api.biz.BokjiServiceVO;
import icube.common.framework.abst.CommonAbstractController;
import icube.common.vo.CommonListVO;
import icube.members.stdg.biz.StdgCdService;
import icube.members.stdg.biz.StdgCdVO;
import icube.planner.biz.PlannerService;


/**
 * 플래너
 *
 * default location : 서울특별시 금천구
 *
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

	// INDEX
	@RequestMapping(value={"", "index"})
	public String index(
			@RequestParam Map<String,Object> reqMap
			, HttpServletRequest request
			, Model model) throws Exception {


		// 행정구역 목록
		List<StdgCdVO> stdgCdList = stdgCdService.selectStdgCdListAll(1);
		model.addAttribute("stdgCdList", stdgCdList);


		// 복지제도 목록
		/*
		int curPage = EgovStringUtil.string2integer((String) reqMap.get("curPage"), 1);
		CommonListVO listVO = new CommonListVO(request, curPage, 8);
		listVO.setParam("sprName", "서울특별시");
		listVO = bokjiService.getSrvcList(listVO);
		model.addAttribute("listVO", listVO);
		*/

		// 복지시설 count



		// 파트너스 count



		// 복지제도count + 복지시설count + 파트너스count



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

		try {
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


		int bokjiId = EgovStringUtil.string2integer((String) reqMap.get("bokjiId"), 0);

		BokjiServiceVO bokjiServiceVO = null;
		if(bokjiId > 0) {
			//try {
				bokjiServiceVO = bokjiService.getSrvcDtl(bokjiId);
			//} catch (Exception e) {
				//log.debug(e.getMessage());
			//}
		}

		model.addAttribute("bokjiVO", bokjiServiceVO);

		return "/planner/include/modal_srvc_detail";
	}


	// 복지시설 목록



	//컨텐츠페이지 > 통합

	//장기요양보험
	@RequestMapping(value="Senior-Long-Term-Care")
	public String seniorLongTermCare(
			@RequestParam Map<String,Object> reqMap
			, HttpServletRequest request
			, Model model) throws Exception {


		return "/planner/senior_long_term_care";
	}


	//고령친화 우수식품
	//Senior Friendly Foods
	@RequestMapping(value="Senior-Friendly-Foods")
	public String seniorFriendlyFoods(
			@RequestParam Map<String,Object> reqMap
			, HttpServletRequest request
			, Model model) throws Exception {


		return "/planner/senior_friendly_foods";
	}




}
