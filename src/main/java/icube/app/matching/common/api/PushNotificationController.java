package icube.app.matching.common.api;

import java.util.Date;
import java.util.HashMap;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import icube.app.matching.membership.mbr.biz.MatMbrService;
import icube.common.framework.abst.CommonAbstractController;
import icube.manage.mbr.mbr.biz.MbrAppSettingVO;

/**
 * 앱 푸시 관련 컨트롤러
 */
@Controller
@RequestMapping(value="app/push")
public class PushNotificationController extends CommonAbstractController {
	
	@Resource(name = "pushNotificationService")
	private PushNotificationService pushNotificationService;
	
	@Resource(name = "matMbrService")
	private MatMbrService matMbrService;
	
	
	/**
	 * 푸시 토큰 수집 시 저장 API
	 */
	@RequestMapping(value = "save.json")
	@ResponseBody
	public Map<String, Object> savePushInfo(@RequestBody HashMap<String, Object> jsonMap) {
		Map <String, Object> resultMap = new HashMap<String, Object>();
		resultMap.put("success", false);
		
		String pushToken = (String)jsonMap.get("pushToken");
		
		try {
			MbrAppSettingVO appSettingVO = matMbrService.selectMbrAppSettingByPushToken(pushToken);
			if (appSettingVO == null) {
				appSettingVO = new MbrAppSettingVO();
				appSettingVO.setPushToken(pushToken);
				appSettingVO.setAllowPushYn("Y");
				appSettingVO.setAllowPushDt(new Date());
				matMbrService.insertMbrAppSetting(appSettingVO);
			}
			resultMap.put("success", true);
		} catch (Exception ex) {
			log.error("===== 익명 푸시 토큰 저장 실패", ex);
		}
		return resultMap;
	}
}
