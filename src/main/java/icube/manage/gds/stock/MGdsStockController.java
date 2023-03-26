package icube.manage.gds.stock;

import java.util.HashMap;
import java.util.List;
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
import icube.common.values.CodeMap;
import icube.common.vo.CommonListVO;
import icube.manage.gds.ctgry.biz.GdsCtgryService;
import icube.manage.gds.ctgry.biz.GdsCtgryVO;
import icube.manage.gds.gds.biz.GdsVO;
import icube.manage.gds.stock.biz.GdsStockService;

/**
 * 상품 재고 관리
 * @author ogy
 */
@Controller
@RequestMapping(value="/_mng/gds/stock")
public class MGdsStockController extends CommonAbstractController {

	@Resource(name = "gdsStockService")
	private GdsStockService gdsStockService;

	@Resource(name = "gdsCtgryService")
	private GdsCtgryService gdsCtgryService;

	@RequestMapping(value = "list")
	public String list(
			HttpServletRequest request
			, Model model
			) throws Exception {

		CommonListVO listVO = new CommonListVO(request);
		listVO.setParam("srchUseYn", "Y");
		listVO = gdsStockService.gdsStockListVO(listVO);


		//카테고리 호출
		List<GdsCtgryVO> gdsCtgryList = gdsCtgryService.selectGdsCtgryList(1);
		model.addAttribute("gdsCtgryList", gdsCtgryList);

		model.addAttribute("listVO", listVO);

		model.addAttribute("gdsTyCode", CodeMap.GDS_TY);
		model.addAttribute("dspyYnCode", CodeMap.DSPY_YN);
		model.addAttribute("useYnCode", CodeMap.USE_YN);

		return "/manage/gds/stock/list";
	}

	@RequestMapping(value = "action.json")
	@ResponseBody
	public Map<String, Object> action(
			@RequestParam(value = "gdsOptnNo", required=false) String gdsOptnNo
			, @RequestParam(value = "gdsNo", required=true) String gdsNo
			, @RequestParam(value = "optnTy", required=false) String optnTy
			, @RequestParam(value = "stockQy", required=true) String stockQy
			, @RequestParam(value = "yn", required=true) String useYn
			, HttpServletRequest request
			)throws Exception {

		Map<String, Object> resultMap = new HashMap<String, Object>();
		Map<String, Object> paramMap = new HashMap<String, Object>();
		boolean result = false;

		try {
			paramMap.put("gdsOptnNo", EgovStringUtil.string2integer(gdsOptnNo));
			paramMap.put("gdsNo", EgovStringUtil.string2integer(gdsNo));
			paramMap.put("optnTy", optnTy);
			paramMap.put("optnStockQy", EgovStringUtil.string2integer(stockQy));
			paramMap.put("useYn", useYn);

			gdsStockService.updateGdsStock(paramMap);

			result = true;
		}catch(Exception e) {
			e.printStackTrace();
			log.debug("#### 상품 재고 관리 수정 실패 ### " + e.toString());
		}

		resultMap.put("result", result);
		return resultMap;

	}

	@RequestMapping(value = "excel")
	public String excelDownload(
			HttpServletRequest request
			, @RequestParam Map<String, Object> reqMap
			, Model model
			) throws Exception {

		List<GdsVO> itemList = gdsStockService.gdsStockListAll(reqMap);

		model.addAttribute("itemList", itemList);

		model.addAttribute("gdsTyCode", CodeMap.GDS_TY);
		model.addAttribute("dspyYnCode", CodeMap.DSPY_YN);
		model.addAttribute("useYnCode", CodeMap.USE_YN);

		return "/manage/gds/stock/excel";
	}

}
