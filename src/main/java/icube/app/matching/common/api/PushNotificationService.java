package icube.app.matching.common.api;

import java.util.concurrent.TimeUnit;

import javax.annotation.Resource;

import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.springframework.stereotype.Service;

import icube.common.framework.abst.CommonAbstractServiceImpl;
import icube.manage.mbr.mbr.biz.MbrAppSettingDAO;
import okhttp3.MediaType;
import okhttp3.OkHttpClient;
import okhttp3.Request;
import okhttp3.RequestBody;
import okhttp3.Response;

@Service("pushNotificationService")
public class PushNotificationService extends CommonAbstractServiceImpl {
	
	@Resource(name = "mbrAppSettingDAO")
	private MbrAppSettingDAO mbrAppSettingDAO;
	
	@SuppressWarnings("unchecked")
	public boolean sendPushNotification(String pushToken, String title, String body) {
		try {
			JSONObject json = new JSONObject();
			json.put("to", pushToken);
			json.put("title", title);
			json.put("body", body);
			
			OkHttpClient client	= new OkHttpClient.Builder()
					.connectTimeout(30, TimeUnit.SECONDS)
					.readTimeout(30, TimeUnit.SECONDS)
					.writeTimeout(30, TimeUnit.SECONDS)
					.build();
			
			Request request	= new Request.Builder()
					.url("https://exp.host/--/api/v2/push/send")
					.addHeader("accept", "application/json")
					.addHeader("Content-Type", "application/json")
					.post(RequestBody.create(MediaType.get("application/json; charset=utf-8") , json.toJSONString()))
					.build();
			
			Response response = client.newCall(request).execute();
			String responseStr = response.body().string();
			
			JSONParser jsonParser = new JSONParser();
			JSONObject jsonObject = (JSONObject)jsonParser.parse(responseStr);
			JSONObject data = (JSONObject)jsonObject.get("data");
			String status =  data.get("status").toString();
			if ("ok".equals(status)) {
				return true;
			}
		} catch (Exception ex) {
			log.error("=======push 알림 오류 : ", ex);
		}
		return false;
	}
}
