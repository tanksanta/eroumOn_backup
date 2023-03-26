package icube.members.stdg;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import icube.common.framework.abst.CommonAbstractController;
import icube.members.stdg.biz.StdgCdService;
import icube.members.stdg.biz.StdgCdVO;

@Controller
@RequestMapping(value="#{props['Globals.Members.path']}/stdgCd")
public class StdgCdController extends CommonAbstractController {

	@Resource(name = "stdgCdService")
	private StdgCdService stdgCdService;


	// 하위(LEVEL2) 법정동 호출
	@ResponseBody
	@RequestMapping(value="stdgCdList.json")
	public Map<String, Object> stdgCdList(
			@RequestParam(value="stdgCd", required=false) String stdgCd
			, @RequestParam Map<String,Object> reqMap) throws Exception {

		List<StdgCdVO> resultList = stdgCdService.selectStdgCdListAll(2, stdgCd);

		// result
		Map<String, Object> resultMap = new HashMap<String, Object>();
		resultMap.put("result", resultList);
		return resultMap;
	}
}
