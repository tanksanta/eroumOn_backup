package icube.market.mypage.ordr;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.egovframe.rte.fdl.string.EgovStringUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import icube.common.framework.abst.CommonAbstractController;
import icube.common.values.CodeMap;
import icube.common.vo.CommonListVO;
import icube.manage.ordr.ordr.biz.OrdrService;
import icube.manage.ordr.ordr.biz.OrdrVO;
import icube.manage.ordr.rebill.biz.OrdrRebillService;
import icube.manage.ordr.rebill.biz.OrdrRebillVO;
import icube.market.mbr.biz.MbrSession;

/**
 * 마이페이지 > 내역 > 대여 조회
 */

@Controller
@RequestMapping(value = "#{props['Globals.Market.path']}/mypage/lend")
public class MyLendController extends CommonAbstractController {

	@Resource(name = "ordrService")
	private OrdrService ordrService;

	@Resource(name = "ordrRebillService")
	private OrdrRebillService ordrRebillService;

	@Autowired
	private MbrSession mbrSession;

	@Value("#{props['Globals.Market.path']}")
	private String marketPath;

	// 주문/배송
	@RequestMapping(value="list")
	public String list(
			HttpServletRequest request
			, Model model) throws Exception {

		CommonListVO listVO = new CommonListVO(request);
		listVO.setParam("srchUniqueId", mbrSession.getUniqueId());
		listVO.setParam("ordrSttsTy", "OR09");
		listVO.setParam("srchOrdrTy", "L");
		listVO = ordrService.ordrListVO(listVO);
		model.addAttribute("listVO", listVO);

		model.addAttribute("gdsTyCode", CodeMap.GDS_TY);
		model.addAttribute("bassStlmTyCode", CodeMap.BASS_STLM_TY);
		model.addAttribute("ordrSttsCode", CodeMap.ORDR_STTS);
		model.addAttribute("ordrCancelTyCode", CodeMap.ORDR_CANCEL_TY);

		return "/market/mypage/lend/list";
	}

	// 대여 상세
	@RequestMapping(value = "view/{ordrCd}")
	public String view(
			@PathVariable String ordrCd
			, HttpServletRequest request
			, Model model) throws Exception {


		OrdrVO ordrVO = ordrService.selectOrdrByCd(ordrCd);
		if(ordrVO == null) {
			model.addAttribute("alertMsg", getMsg("alert.author.common"));
			return "/common/msg";
		}
		model.addAttribute("ordrVO", ordrVO);

		return "/market/mypage/lend/view";
	}


	@RequestMapping(value = {"view/{ordrCd}/srchList"})
	public String srchList(
			@PathVariable String ordrCd // 카테고리
			, @RequestParam Map<String,Object> reqMap
			, HttpServletRequest request
			, HttpServletResponse response
			, HttpSession session
			, Model model) throws Exception {

		int curPage = EgovStringUtil.string2integer((String) reqMap.get("curPage"), 1);
		int cntPerPage = EgovStringUtil.string2integer((String) reqMap.get("cntPerPage"), 10);

		CommonListVO listVO = new CommonListVO(request, curPage, cntPerPage);
		listVO.setParam("srchOrdrCd", ordrCd);
		listVO = ordrRebillService.ordrRebillListVO(listVO);

		/*
		Map<String, Object> paramMap = new HashMap<String, Object>();
		paramMap.put("srchOrdrCd", ordrCd);
		List<OrdrRebillVO> resultList = ordrRebillService.selectOrdrRebillListAll(paramMap);
		model.addAttribute("resultList", resultList);
		*/
		model.addAttribute("listVO", listVO);


		model.addAttribute("bassStlmTyCode", CodeMap.BASS_STLM_TY);

		return "market/mypage/lend/include/srch_list";
	}

}
