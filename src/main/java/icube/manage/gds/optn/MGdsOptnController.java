package icube.manage.gds.optn;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import icube.common.framework.abst.CommonAbstractController;
import icube.manage.gds.optn.biz.GdsOptnService;
import icube.manage.gds.optn.biz.GdsOptnVO;

@Controller
@RequestMapping(value={"/_mng/gds/optn", "#{props['Globals.Market.path']}/gds/optn"})
public class MGdsOptnController extends CommonAbstractController {

	@Resource(name = "gdsOptnService")
	private GdsOptnService gdsOptnService;


	/**
	 * 상품 옵션 - 사용중
	 * @param optnTy
	 * @param optnVal
	 * @param reqMap
	 * @return
	 * @throws Exception
	 */
	@ResponseBody
	@RequestMapping(value="getOptnInfo.json")
	public Map<String, Object> getOptnInfo(
			@RequestParam(value="gdsNo", required=true) int gdsNo
			, @RequestParam(value="optnTy", required=true) String optnTy
			, @RequestParam(value="optnVal", required=false) String optnVal
			, @RequestParam Map<String,Object> reqMap) throws Exception {

		boolean result = false;

		Map<String, Object> paramMap = new HashMap<String, Object>();
		paramMap.put("gdsNo", gdsNo);
		paramMap.put("optnTy", optnTy);
		paramMap.put("optnVal", optnVal);
		paramMap.put("useYn", "Y"); // 사용중


		// result
		Map<String, Object> resultMap = new HashMap<String, Object>();

		try {
			List<GdsOptnVO> optnList = gdsOptnService.selectGdsOptnList(paramMap);
			resultMap.put("optnList", optnList);
			result = true;
		} finally {
			log.debug("List Error");
		}

		resultMap.put("result", result);
		return resultMap;
	}

}
