package icube.market.etc.story;

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
import icube.manage.exhibit.theme.biz.ThemeDspyGdsService;
import icube.manage.exhibit.theme.biz.ThemeDspyGdsVO;
import icube.manage.exhibit.theme.biz.ThemeDspyService;
import icube.manage.exhibit.theme.biz.ThemeDspyVO;

/**
 * 이로움 스토리
 * @author ogy
 *
 */
@Controller
@RequestMapping(value="#{props['Globals.Market.path']}/etc/story")
public class StoryController extends CommonAbstractController{

	@Resource(name = "themeDspyService")
	private ThemeDspyService themeService;

	@Resource(name = "themeDspyGdsService")
	private ThemeDspyGdsService gdsService;

	/**
	 * 스토리 > 리스트
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
		listVO = themeService.themeDspyListVO(listVO);

		model.addAttribute("listVO", listVO);


		return "/market/etc/story/list";
	}

	/**
	 * 스토리 > 상세
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
			, @RequestParam Map<String,Object> reqMap
			) throws Exception {

		int themeDspyNo = EgovStringUtil.string2integer((String)reqMap.get("themeDspyNo"));

		//스토리 정보
		ThemeDspyVO themeDspyVO = themeService.selectThemeDspy(themeDspyNo);

		//연관상품 정보
		List<ThemeDspyGdsVO> itemList = gdsService.selectGdsList(themeDspyNo);

		model.addAttribute("themeVO", themeDspyVO);
		model.addAttribute("itemList", itemList);

		return "/market/etc/story/view";
	}

}
