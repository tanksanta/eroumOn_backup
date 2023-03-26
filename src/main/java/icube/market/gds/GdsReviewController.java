package icube.market.gds;

import java.util.HashMap;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.egovframe.rte.fdl.string.EgovStringUtil;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import icube.common.framework.abst.CommonAbstractController;
import icube.common.util.HtmlUtil;
import icube.common.vo.CommonListVO;
import icube.manage.consult.biz.GdsReviewService;
import icube.manage.consult.biz.GdsReviewVO;

/**
 * 상품리뷰
 * @author kkm
 */

@Controller
@RequestMapping(value="#{props['Globals.Market.path']}/gds/review")
public class GdsReviewController extends CommonAbstractController  {

	@Resource(name = "gdsReviewService")
	private GdsReviewService gdsReviewService;

	@RequestMapping(value="photoList")
	public String photoList(
			@RequestParam(value="srchGdsCd", required=true) String srchGdsCd
			, @RequestParam Map<String,Object> reqMap
			, HttpServletRequest request
			, Model model) throws Exception {

		int curPage = EgovStringUtil.string2integer((String) reqMap.get("curPage"), 1);
		int cntPerPage = EgovStringUtil.string2integer((String) reqMap.get("cntPerPage"), 5);

		CommonListVO listVO = new CommonListVO(request, curPage, cntPerPage);
		listVO.setParam("srchGdsCd", srchGdsCd);
		listVO.setParam("srchImgUseYn", "Y");
		listVO = gdsReviewService.gdsReviewListVO(listVO);

		model.addAttribute("listVO", listVO);

		return "/market/gds/include/photo_review_list";
	}

	@RequestMapping(value="list")
	public String list(
			@RequestParam(value="srchGdsCd", required=true) String srchGdsCd
			, @RequestParam Map<String,Object> reqMap
			, HttpServletRequest request
			, Model model) throws Exception {

		int curPage = EgovStringUtil.string2integer((String) reqMap.get("curPage"), 1);
		int cntPerPage = EgovStringUtil.string2integer((String) reqMap.get("cntPerPage"), 5);

		CommonListVO listVO = new CommonListVO(request, curPage, cntPerPage);
		listVO.setParam("srchGdsCd", srchGdsCd);
		listVO.setParam("srchImgUseYn", "N");
		listVO = gdsReviewService.gdsReviewListVO(listVO);

		model.addAttribute("listVO", listVO);

		return "/market/gds/include/review_list";
	}


	@ResponseBody
	@RequestMapping(value="getReview.json")
	public Map<String, Object> getReviewData(
			@RequestParam(value="gdsReviewNo", required=true) int gdsReviewNo
			, @RequestParam Map<String,Object> reqMap
			, HttpServletRequest request) throws Exception {

		String rtnMsg = "success";
		Map<String, Object> resultMap = new HashMap<String, Object>();

		GdsReviewVO gdsReviewVO = gdsReviewService.selectGdsReview(gdsReviewNo);
		if(gdsReviewVO != null) {
			gdsReviewVO.setCn(HtmlUtil.enterToBr(gdsReviewVO.getCn()));
			gdsReviewVO.setRegId(EgovStringUtil.null2void(gdsReviewVO.getRegId()).replaceAll("(?<=.{3}).", "*") );
			gdsReviewVO.setMdfcnId(EgovStringUtil.null2void(gdsReviewVO.getMdfcnId()).replaceAll("(?<=.{3}).", "*") );

			resultMap.put("vo", gdsReviewVO);
		} else {
			rtnMsg = "nodata";
		}
		resultMap.put("rtnMsg", rtnMsg);

		return resultMap;
	}

}
