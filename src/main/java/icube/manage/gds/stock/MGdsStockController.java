package icube.manage.gds.stock;

import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;
import java.util.function.Function;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.egovframe.rte.fdl.string.EgovStringUtil;
import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import icube.common.framework.abst.CommonAbstractController;
import icube.common.util.ExcelExporter;
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

	/**
	 * 상품재고 정보 일괄 수정
	 * @param request
	 * @param reqMap
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "list/action.json")
	@ResponseBody
	public Map<String, Object> listAction(
			@RequestParam(value = "gdsListJson", required=true) String gdsListJson
			)throws Exception {

		JSONParser parser = new JSONParser();
		JSONArray gdsList = (JSONArray) parser.parse(gdsListJson);

		for (int i = 0; i < gdsList.size(); i++) {
			JSONObject gdsMap = (JSONObject) gdsList.get(i);
			Long gdsOptnNo = (Long) gdsMap.get("gdsOptnNo");
			Long gdsNo = (Long) gdsMap.get("gdsNo");
			String optnTy = (String) gdsMap.get("optnTy");
			String stockQy = (String) gdsMap.get("stockQy");
			String useYn = (String) gdsMap.get("yn");

			Map<String, Object> paramMap = new HashMap<String, Object>();
			paramMap.put("gdsOptnNo", gdsOptnNo);
			paramMap.put("gdsNo", gdsNo);
			paramMap.put("optnTy", optnTy);
			paramMap.put("optnStockQy", EgovStringUtil.string2integer(stockQy));
			paramMap.put("useYn", useYn);

			gdsStockService.updateGdsStock(paramMap);
		}

		Map<String, Object> resultMap = new HashMap<String, Object>();
		resultMap.put("result", true);
		return resultMap;
	}

	@RequestMapping(value = "excel")
	public void excelDownload(
			HttpServletRequest request
			, HttpServletResponse response
			, @RequestParam Map<String, Object> reqMap
			, Model model
			) throws Exception {

		List<GdsVO> itemList = gdsStockService.gdsStockListAll(reqMap);

		Map<String, Function<Object, Object>> mapping = new LinkedHashMap<>();
		mapping.put("상품구분", obj -> CodeMap.GDS_TY.get(((GdsVO)obj).getGdsTy()));
		mapping.put("상품명", obj -> ((GdsVO)obj).getGdsNm());
		mapping.put("옵션항목", obj -> ((GdsVO)obj).getOptnNm().trim());

		mapping.put("판매가", obj -> String.format("%,d", ((GdsVO)obj).getPc()));
		mapping.put("급여가", obj -> String.format("%,d", ((GdsVO)obj).getBnefPc()));

		mapping.put("재고수량", obj -> {
			int stockQy = EgovStringUtil.isNotEmpty(((GdsVO)obj).getOptnTy()) ?
		              ((GdsVO)obj).getOptnStockQy() :
		              ((GdsVO)obj).getStockQy();
			return stockQy;
		});
		mapping.put("판매여부", obj -> {
			String useYn = EgovStringUtil.isEmpty(((GdsVO)obj).getOptnTy()) ?
		               CodeMap.DSPY_YN.get(((GdsVO)obj).getDspyYn()) :
		               CodeMap.USE_YN.get(((GdsVO)obj).getUseYn());
			return useYn;
		});

		List<LinkedHashMap<String, Object>> dataList = new ArrayList<>();
        for (GdsVO gdsVO : itemList) {
 		    LinkedHashMap<String, Object> tempMap = new LinkedHashMap<>();
 		    for (String header : mapping.keySet()) {
 		        Function<Object, Object> extractor = mapping.get(header);
 		        if (extractor != null) {
 		            tempMap.put(header, extractor.apply(gdsVO));
 		        }
 		    }
		    dataList.add(tempMap);
		}

		ExcelExporter exporter = new ExcelExporter();
		try {
			exporter.export(response, "상품재고_관리목록", dataList, mapping);
		} catch (IOException e) {
		    e.printStackTrace();
 		}
	}

}
