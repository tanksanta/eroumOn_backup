package icube.app.matching.membership.info;

import java.util.Date;
import java.util.HashMap;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.util.HtmlUtils;

import com.google.gson.JsonElement;
import com.google.gson.JsonParser;

import icube.app.matching.membership.mbr.biz.MatMbrService;
import icube.app.matching.membership.mbr.biz.MatMbrSession;
import icube.common.framework.abst.CommonAbstractController;
import icube.manage.mbr.mbr.biz.MbrAppSettingVO;
import icube.manage.mbr.mbr.biz.MbrService;

/**
 * 회원정보 수정
 */
@Controller
@RequestMapping(value="#{props['Globals.Matching.path']}/membership/info")
public class MatMbrInfoController extends CommonAbstractController{
	
	@Resource(name = "mbrService")
	private MbrService mbrService;
	
	@Resource(name = "matMbrService")
	private MatMbrService matMbrService;
	
	@Autowired
	private MatMbrSession matMbrSession;
	
	
	/**
	 * 앱에서 받은 지도 및 푸시 알림 정보 저장
	 */
	@ResponseBody
	@RequestMapping("updatePermissionInfo")
	public Map<String, Object> updatePermissionInfo(
		@RequestParam String permissionInfoJson
	) {
		Map <String, Object> resultMap = new HashMap<String, Object>();
		resultMap.put("success", true);
		
		try {
			
			if (matMbrSession.isLoginCheck() == false) {
				return resultMap;
			}
			
			boolean isInsert = false;
			MbrAppSettingVO appSetting = matMbrService.selectMbrAppSettingByMbrUniqueId(matMbrSession.getUniqueId());
			if (appSetting == null) {
				isInsert = true;
				appSetting = new MbrAppSettingVO();
				appSetting.setMbrUniqueId(matMbrSession.getUniqueId());
			}
			
			
			String jsonStr = HtmlUtils.htmlUnescape(permissionInfoJson);
			JsonElement element = JsonParser.parseString(jsonStr);
			
			JsonElement pushPermission = element.getAsJsonObject().get("pushPermission");
			if (pushPermission != null && pushPermission.isJsonNull() == false) {
				boolean isAllow = pushPermission.getAsJsonObject().get("allow").getAsBoolean();
				
				//push 토큰 정보 저장
				if (isAllow) {
					String pushToken = pushPermission.getAsJsonObject().get("pushToken").getAsString();
					appSetting.setPushToken(pushToken);
				}
				
				appSetting.setAllowPushYn(isAllow ? "Y" : "N");
				appSetting.setAllowPushDt(new Date());
			}
			
			JsonElement locationPermission = element.getAsJsonObject().get("locationPermission");
			if (locationPermission != null && locationPermission.isJsonNull() == false) {
				boolean isAllow = locationPermission.getAsJsonObject().get("allow").getAsBoolean();
				
				//위치 정보 저장
				if (isAllow) {
					String latitude = locationPermission.getAsJsonObject().get("latitude").getAsString();
					String longitude = locationPermission.getAsJsonObject().get("longitude").getAsString();
					mbrService.updateMbrLocation(matMbrSession.getUniqueId(), latitude, longitude);
				}
				
				appSetting.setAllowLocationYn(isAllow ? "Y" : "N");
				appSetting.setAllowLocationDt(new Date());
			}
			
			//앱 설정 회원에 반영하기
			if (isInsert) {
				appSetting.setAutoLgnYn("Y");
				appSetting.setAutoLgnDt(new Date());
				matMbrService.insertMbrAppSetting(appSetting);
			} else {
				matMbrService.updateMbrAppSetting(appSetting);
			}
			
		} catch (Exception ex) {
			log.error("========앱 접근 권한 정보 업데이트 오류 : ", ex);
		}
		
		return resultMap;
	}
}
