package icube.common.api.biz;

import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.concurrent.TimeUnit;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.egovframe.rte.fdl.string.EgovStringUtil;
import org.json.simple.JSONObject;
import org.json.simple.JSONArray;
import org.json.simple.parser.JSONParser;
import org.springframework.beans.factory.annotation.Value;

import icube.common.util.DateUtil;
import icube.common.values.CodeMap;
import icube.manage.mbr.mbr.biz.MbrVO;
import icube.manage.mbr.recipients.biz.MbrRecipientsVO;
import icube.manage.members.bplc.biz.BplcVO;
import okhttp3.MediaType;
import okhttp3.OkHttpClient;
import okhttp3.Request;
import okhttp3.RequestBody;
import okhttp3.Response;

@SuppressWarnings("unchecked")
public class BiztalkApiService {

	protected Log log = LogFactory.getLog(this.getClass());
	
	@Value("#{props['Profiles.Active']}")
	protected String activeMode;
	
	@Value("#{props['Biztalk.Send']}")
	protected boolean biztalkSend;

	@Value("#{props['Biztalk.Host']}")
	protected String biztalkHost;

	@Value("#{props['Biztalk.BsId']}")
	protected String biztalkBsId;//비즈톡에서 발급한 BS ID
	
	@Value("#{props['Biztalk.TestPhoneMember']}")
	protected String biztalkTestPhoneMember;//운영을 제외한 나머지 핸드폰 번호(멤버)
	
	@Value("#{props['Biztalk.TestPhoneBplc']}")
	protected String biztalkTestPhoneBplc;//운영을 제외한 나머지 핸드폰 번호(사업소)

	@Value("#{props['Biztalk.BsPwd']}")
	protected String biztalkBsPwd;//비즈톡에서 발급한 BS PW
	
	@Value("#{props['Biztalk.SenderKeyEroumOn']}")
	protected String biztalkSenderKeyEroumOn;//카카오 발신프로필 키 - @이로움온 용
	
	@Value("#{props['Biztalk.SenderKeyEroumcare']}")
	protected String biztalkSenderKeyEroumcare;//카카오 발신프로필 키 - @이로움케어 용
	
	@Value("#{props['Globals.EroumCare.host']}")
	protected String careHost;//케어서버 호스트
	
	
	// @Value("#{props['Biztalk.TargetEroumHost']}")//이로움온 서버
	protected String eroumOnHost = "https://eroum.co.kr";
	

	protected String biztalkTokenKey;//토큰 문자열
	protected String biztalkTokenExpireDate;//토큰 만료시간 (YYYYMMDDhhmmss) ( 최대 24시간 )//현재는 토큰을 신경 쓸 필요가 없다. 세션으로 4시간 관리하기때문에
	protected Date biztalkTokenExpireDate2 = null;//토근 만료시간
	/*
	 * 토큰발급
	 * 인증 토큰은 12시간마다 요청해서 사용을 권장합니다
	 * (사용자 토큰 요청은 1분당 최대 12회로 제한됩니다.)
	 * */ 
	protected Boolean getToken() throws Exception {
		
		if (EgovStringUtil.isNotEmpty(this.biztalkTokenKey) 
				&& this.biztalkTokenExpireDate2 != null) {
			int compare = this.biztalkTokenExpireDate2.compareTo(new Date(System.currentTimeMillis())); 
			if (compare > 0) {
				return true;
			}
		}
		
		JSONObject json = new JSONObject();
		json.put("bsid", biztalkBsId);
		json.put("passwd", biztalkBsPwd);

		String searchUrl = biztalkHost + "/v2/auth/getToken";

		OkHttpClient client	= new OkHttpClient.Builder()
				.connectTimeout(30, TimeUnit.SECONDS)
				.readTimeout(30, TimeUnit.SECONDS)
				.writeTimeout(30, TimeUnit.SECONDS)
				.build();

		Request request	= new Request.Builder()
				.url(searchUrl)
				.addHeader("accept", "application/json")
				.addHeader("Content-Type", "application/json")
				.post(RequestBody.create(MediaType.get("application/json; charset=utf-8") , json.toJSONString()))
				.build();


		Response response = client.newCall(request).execute();
		String responseStr = response.body().string();

		JSONParser jsonParser = new JSONParser();
		JSONObject jsonObject;
		
		try {
			jsonObject = (JSONObject) jsonParser.parse(responseStr);
		}catch(Exception e) {
			e.printStackTrace();
			log.debug(e.getMessage());
			
			throw e;
		}
		
		Boolean result = false;
		if (jsonObject.get("responseCode").equals("1000")) {
			result = true;
			biztalkTokenKey = jsonObject.get("token").toString();
			biztalkTokenExpireDate = jsonObject.get("expireDate").toString();
			
			Calendar cal = Calendar.getInstance();
			cal.setTime(new Date(System.currentTimeMillis()));
			cal.add( Calendar.HOUR_OF_DAY, 12 );/*토큰 만기를 12시간에 한번씩*/
			this.biztalkTokenExpireDate2 = cal.getTime();
			
			log.debug("biztalkTokenKey=" + biztalkTokenKey);
			log.debug("biztalkTokenExpireDate=" + biztalkTokenExpireDate);
		}
		
        return result;
    }
	
	protected void getResultAll() throws Exception {
		String searchUrl = biztalkHost + "/v2/kko/getResultAll";
		
		OkHttpClient client	= new OkHttpClient.Builder()
				.connectTimeout(30, TimeUnit.SECONDS)
				.readTimeout(30, TimeUnit.SECONDS)
				.writeTimeout(30, TimeUnit.SECONDS)
				.build();

		Request request	= new Request.Builder()
				.url(searchUrl)
				.addHeader("accept", "application/json")
				.addHeader("Content-Type", "application/json")
				.addHeader("bt-token", biztalkTokenKey)
				.build();
		
		Response response = client.newCall(request).execute();
		String responseStr = response.body().string();
		
		log.debug("responseStr=" + responseStr);
	}
	
	protected boolean sendApiWithToken(String url, String sPhoneNo, JSONObject postData) throws Exception {
		Boolean result = false;
		
		if (!this.biztalkSend) {
			return true;
		}
		
		result = this.getToken();
		
		if (!result) {
			log.debug("can not found token");
			return result;
		}
		
		if (postData.get("countryCode") == null) {
			postData.put("countryCode", "82");
		}
		
		if (postData.get("resMethod") == null) {
			postData.put("resMethod", "PUSH");
		}
		
		if (postData.get("recipient") != null) {
			postData.remove("recipient");
		}
		
		postData.put("recipient", sPhoneNo);
		
		if (postData.get("tmpltCode") == null) {
			throw new Exception("tmpltCode not founded");
		}
		
		
		
		String tmpltCode = postData.get("tmpltCode").toString();
		
		SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMddHHmmssSSS");
		long timeInMillis =System.currentTimeMillis();
		Date timeInDate = new Date(timeInMillis); 
        String timeInFormat = sdf.format(timeInDate);
        
        postData.put("msgIdx", tmpltCode + "_" + timeInFormat);
         
		log.debug("postData=" + postData.toJSONString());
		
		String searchUrl = biztalkHost + url;
		
		OkHttpClient client	= new OkHttpClient.Builder()
				.connectTimeout(30, TimeUnit.SECONDS)
				.readTimeout(30, TimeUnit.SECONDS)
				.writeTimeout(30, TimeUnit.SECONDS)
				.build();

		Request request	= new Request.Builder()
				.url(searchUrl)
				.addHeader("accept", "application/json")
				.addHeader("Content-Type", "application/json")
				.addHeader("bt-token", biztalkTokenKey)
				.post(RequestBody.create(MediaType.get("application/json; charset=utf-8") , postData.toJSONString()))
				.build();
		
		Response response = client.newCall(request).execute();
		String responseStr = response.body().string();
		
		log.debug("responseStr=" + responseStr);
		
		JSONParser jsonParser = new JSONParser();
		
		try {
			jsonParser.parse(responseStr);
		}catch(Exception e) {
			e.printStackTrace();
			log.debug(e.getMessage());
			
			throw e;
		}
		
		return true;
	}

	protected String changeDevPhoneNo(Boolean bBplc, String sPhoneNo) {
		if (activeMode.equals("real")) {/*운영은 핸드폰 번호 그대로 보낸다*/
			return sPhoneNo;
		}else {/*개발 서버는 번호를 특정번호로 변경해서 보낸다*/
			if (bBplc) {
				return biztalkTestPhoneBplc;
			}else {
				return biztalkTestPhoneMember;	
			}
		}
	}
}
