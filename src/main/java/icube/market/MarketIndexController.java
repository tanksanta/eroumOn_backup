package icube.market;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import icube.common.framework.abst.CommonAbstractController;
import icube.manage.exhibit.banner.biz.BnnrMngService;
import icube.manage.exhibit.banner.biz.BnnrMngVO;
import icube.manage.exhibit.main.biz.MainMngService;
import icube.manage.exhibit.main.biz.MainMngVO;
import icube.manage.gds.gds.biz.GdsService;
import icube.manage.mbr.mbr.biz.MbrService;
import icube.manage.members.bplc.biz.BplcService;
import icube.manage.sysmng.bbs.biz.BbsService;

@Controller
@RequestMapping(value="#{props['Globals.Market.path']}")
public class MarketIndexController extends CommonAbstractController {

	@Resource(name ="bbsService")
	private BbsService bbsService;

	@Resource(name = "mbrService")
	private MbrService mbrService;

	@Resource(name = "bplcService")
	private BplcService bplcService;

	@Resource(name = "gdsService")
	private GdsService gdsService;

	@Resource(name = "bnnrMngService")
	private BnnrMngService bnnrMngService;

	@Resource(name = "mainMngService")
	private MainMngService mainMngService;

	@Value("#{props['Globals.Market.path']}")
	private String marketPath;

	@RequestMapping(value = {"", "index"})
	public String MarketIndex(
			@RequestParam Map<String,Object> reqMap
			, HttpServletRequest request
			, HttpServletResponse response
			, HttpSession session
			, Model model) throws Exception {

		// 메인, 띠 배너 리스트
		Map<String, Object> bannerMap = new HashMap<String, Object>();
		bannerMap.put("srchUseYn", "Y");
		bannerMap.put("srchNowDate", 1);
		bannerMap.put("srchBannerTy", "M");
		List<BnnrMngVO> mainBannerList = bnnrMngService.selectBnnrMngList(bannerMap);
		model.addAttribute("mainBannerList", mainBannerList);

		bannerMap.remove("srchNowDate");
		bannerMap.remove("srchBannerTy");
		List<MainMngVO> mainMngList = mainMngService.selectMainMngList(bannerMap);
		model.addAttribute("mainMngList", mainMngList);


		// 사업소 카운트
		Map<String, Object> paramMap = new HashMap<String, Object>();
		paramMap.put("srchUseYn", "Y");
		int bplcCnt = bplcService.selectBplcCnt(paramMap);

		model.addAttribute("bplcCnt", bplcCnt);

		return "/market/index";
	}

}
