package icube.market.etc.dspy;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.egovframe.rte.fdl.string.EgovStringUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import icube.common.framework.abst.CommonAbstractController;
import icube.common.vo.CommonListVO;
import icube.manage.mbr.itrst.biz.WishService;
import icube.manage.mbr.itrst.biz.WishVO;
import icube.manage.promotion.dspy.biz.PlanngDspyGrpGdsService;
import icube.manage.promotion.dspy.biz.PlanngDspyGrpGdsVO;
import icube.manage.promotion.dspy.biz.PlanngDspyGrpService;
import icube.manage.promotion.dspy.biz.PlanngDspyGrpVO;
import icube.manage.promotion.dspy.biz.PlanningDspyService;
import icube.manage.promotion.dspy.biz.PlanningDspyVO;
import icube.market.mbr.biz.MbrSession;

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
	
	@Resource(name = "wishService")
	private WishService wishService;
	
	@Autowired
	private MbrSession mbrSession;
	

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
		
		//회원의 위시정보 추가
		if (mbrSession.isLoginCheck()) {
			Map<String, Object> paramMap = new HashMap<String, Object>();
			paramMap.put("srchUniqueId", mbrSession.getUniqueId());
			List<WishVO> wishList = wishService.selectWishListAll(paramMap);
			
			if (wishList.size() > 0) {
				for (PlanngDspyGrpVO dspyGrp : dspyGrpList) {
					for (PlanngDspyGrpGdsVO dspyGrpGds : dspyGrp.getGrpGdsList()) {
						if (wishList.stream().anyMatch(f -> f.getGdsNo() == dspyGrpGds.getGdsNo())) {
							dspyGrpGds.setWishYn(1);
						}
					}
				}
			}
		}
		
		model.addAttribute("dspyVO", PlanningDspyVO);
		model.addAttribute("dspyGrpList", dspyGrpList);

		return "/market/etc/dspy/view";
	}

}
