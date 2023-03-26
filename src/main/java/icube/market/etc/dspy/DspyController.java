package icube.market.etc.dspy;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.egovframe.rte.fdl.string.EgovStringUtil;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import icube.common.framework.abst.CommonAbstractController;
import icube.common.vo.CommonListVO;
import icube.manage.promotion.dspy.biz.PlanngDspyGrpGdsService;
import icube.manage.promotion.dspy.biz.PlanngDspyGrpService;
import icube.manage.promotion.dspy.biz.PlanngDspyGrpVO;
import icube.manage.promotion.dspy.biz.PlanningDspyService;
import icube.manage.promotion.dspy.biz.PlanningDspyVO;

/**
 * 이로움 기획전
 * @author ogy
 *
 */
@Controller
@RequestMapping(value="#{props['Globals.Market.path']}/etc/dspy")
public class DspyController extends CommonAbstractController{

	@Resource(name = "planningDspyService")
	private PlanningDspyService planningDspyService;

	@Resource(name = "planngDspyGrpService")
	private PlanngDspyGrpService pdgsService;

	@Resource(name = "planngDspyGrpGdsService")
	private PlanngDspyGrpGdsService pdgsGdsService;

	/**
	 * 기획전 > 리스트
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "list")
	public String list(
			HttpServletRequest request
			, Model model
			)throws Exception {

		CommonListVO listVO = new CommonListVO(request);
		listVO.setParam("srchYn", "Y");
		listVO = planningDspyService.pDspyListVO(listVO);

		model.addAttribute("listVO", listVO);

		return "/market/etc/dspy/list";
	}

	/**
	 * 기획전 > 상세
	 * @param request
	 * @param model
	 * @param reqMap
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "view")
	public String view(
			HttpServletRequest request
			, Model model
			, @RequestParam Map <String, Object> reqMap
			)throws Exception {

		int planngDspyNo = EgovStringUtil.string2integer((String) reqMap.get("planngDspyNo"));

		//기획전 정보
		PlanningDspyVO PlanningDspyVO = planningDspyService.selectPdspy(planngDspyNo);

		//연관상품 그룹
		List <PlanngDspyGrpVO> dspyGrpList =  pdgsService.selectGrpList(planngDspyNo);

		model.addAttribute("dspyVO", PlanningDspyVO);
		model.addAttribute("dspyGrpList", dspyGrpList);

		return "/market/etc/dspy/view";
	}

}
