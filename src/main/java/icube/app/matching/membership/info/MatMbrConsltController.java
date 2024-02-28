package icube.app.matching.membership.info;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

import javax.annotation.Resource;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import icube.common.framework.abst.CommonAbstractController;
import icube.manage.consult.biz.MbrConsltService;
import icube.manage.consult.biz.MbrConsltVO;

/**
 * 상담 관련
 */
@Controller
@RequestMapping(value="#{props['Globals.Matching.path']}/membership/conslt")
public class MatMbrConsltController extends CommonAbstractController {
	
	@Resource(name = "mbrConsltService")
	private MbrConsltService mbrConsltService;
	
	
	/**
	 * 특정 수급자의 진행중인 상담 조회(서비스 > swipe 구성)
	 */
	@ResponseBody
	@RequestMapping("progress")
	public Map<String, Object> getConsltInProgress(@RequestParam int recipientsNo) {
		Map <String, Object> resultMap = new HashMap<String, Object>();
		resultMap.put("success", false);
		
		try {
			List<MbrConsltVO> mbrConsltList = mbrConsltService.getConsltInProgress(recipientsNo);
			List<String> prevPathList = mbrConsltList.stream().map(m -> m.getPrevPath()).distinct().collect(Collectors.toList());
			resultMap.put("success", true);
			resultMap.put("prevPathList", prevPathList);
		} catch (Exception ex) {
			log.error("===== 진행중인 상담 조회 API 오류", ex);
		}
		
		return resultMap;
	}
}
