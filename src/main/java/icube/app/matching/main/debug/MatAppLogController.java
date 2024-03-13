package icube.app.matching.main.debug;

import java.util.HashMap;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import icube.app.matching.main.debug.biz.AppLogDAO;
import icube.app.matching.main.debug.biz.AppLogVO;

/**
 * 앱에서 발생하는 오류 로그 수집
 */
@Controller
@RequestMapping(value="#{props['Globals.Matching.path']}/debug")
public class MatAppLogController {
	
	@Resource(name = "appLogDAO")
	private AppLogDAO appLogDAO;
	
	
	@ResponseBody
	@RequestMapping("log")
	public Map<String, Object> log(
		@RequestParam String log) throws Exception {
		Map<String, Object> resultMap = new HashMap<String, Object>();
		resultMap.put("success", false);
		
		try {
			AppLogVO appLogVO = new AppLogVO();
			appLogVO.setLog(log);
			appLogDAO.insertAppLog(appLogVO);
		} catch (Exception ex) {
		}
		
		return resultMap;
	}
}
