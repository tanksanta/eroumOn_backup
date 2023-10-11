package icube.market.ordr;

import java.util.HashMap;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import icube.common.framework.abst.CommonAbstractController;
import icube.market.ordr.biz.DlvyCtAditRgnService;
/**
 * 배송비용_추가지역
 *
 * 추후 지역별 배송비를 다르게 한다면 배송비 컬럼을 추가하여 사용하세요
 *
 */

@Controller
@RequestMapping(value="/comm/dlvyCt")
public class DlvyCtAditRgnController extends CommonAbstractController{

	@Resource(name = "dlvyCtAditRgnService")
	private DlvyCtAditRgnService dlvyCtAditRgnService;

	@ResponseBody
	@RequestMapping(value="chkRgn.json")
	public Map<String, Object> chkRgn(
			@RequestParam(value="zip", required=true) String zip
			, Model model) throws Exception {

		Map<String, Object> resultMap = new HashMap<String, Object>();

		boolean result = false;

		try {
			int resultCnt = dlvyCtAditRgnService.selectDlvyCtAditRgnCnt(zip);
			if(resultCnt > 0) {
				result = true;
			}

		}catch(Exception e) {
			e.printStackTrace();
			log.debug("DELIVERY COST CHECK ERROR");
		}

		resultMap.put("result", result);

		return resultMap;
	}
}
