package icube.common.api.biz;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.concurrent.TimeUnit;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.egovframe.rte.fdl.string.EgovStringUtil;
import org.json.simple.JSONObject;
import org.json.simple.JSONArray;
import org.json.simple.parser.JSONParser;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;

import okhttp3.MediaType;
import okhttp3.OkHttpClient;
import okhttp3.Request;
import okhttp3.RequestBody;
import okhttp3.Response;

@Service("biztalkApiService")
public class BiztalkApiService {

	protected Log log = LogFactory.getLog(this.getClass());
	
	@Value("#{props['Profiles.Active']}")
	private String activeMode;
	
	@Value("#{props['Biztalk.Send']}")
	private boolean biztalkSend;

	@Value("#{props['Biztalk.Host']}")
	private String biztalkHost;

	@Value("#{props['Biztalk.BsId']}")
	private String biztalkBsId;//비즈톡에서 발급한 BS ID
	
	@Value("#{props['Biztalk.TargetPhone']}")
	private String biztalkTargetPhone;//운영을 제외한 나머지 핸드폰 번호

	@Value("#{props['Biztalk.BsPwd']}")
	private String biztalkBsPwd;//비즈톡에서 발급한 BS PW
	
	@Value("#{props['Biztalk.SenderKeyEroumOn']}")
	private String biztalkSenderKeyEroumOn;//카카오 발신프로필 키

	private String biztalkTokenKey;//토큰 문자열
	private String biztalkTokenExpireDate;//토큰 만료시간 (YYYYMMDDhhmmss) ( 최대 24시간 )//현재는 토큰을 신경 쓸 필요가 없다. 세션으로 4시간 관리하기때문에

	/*
	 * 토큰발급
	 * 인증 토큰은 12시간마다 요청해서 사용을 권장합니다
	 * (사용자 토큰 요청은 1분당 최대 12회로 제한됩니다.)
	 * */ 
	protected Boolean getToken() throws Exception {

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
		
		if (EgovStringUtil.isEmpty(this.biztalkTokenKey)) {
			result = this.getToken();
		}
		
		if (!result) {
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
		if (activeMode.equals("real")) {/*운영은 핸드폰 번호 그대로 보낸다*/
			postData.put("recipient", sPhoneNo);
		}else {/*개발 서버는 번호를 특정번호로 변경해서 보낸다*/
			postData.put("recipient", biztalkTargetPhone);
		}
		
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
		JSONObject jsonObject;
		
		try {
			jsonObject = (JSONObject) jsonParser.parse(responseStr);
		}catch(Exception e) {
			e.printStackTrace();
			log.debug(e.getMessage());
			
			throw e;
		}
		
		return true;
	}

	// ON_00003 이로움ON회원_가입완료 biztalkApiService.sendJoinComleted("이동열", "010-2808-9178");
	public boolean sendJoinComleted(String mbrNm, String sPhoneNo) throws Exception {
		
		JSONObject param = this.msgOn00003(mbrNm);
		
        return this.sendApiWithToken("/v2/kko/sendAlimTalk", sPhoneNo, param);
        
        // this.getResultAll();
    }
	
	// ON_00002 이로움ON회원_상담신청취소 biztalkApiService.sendTalkCancel("이동열", "010-2808-9178");
	public boolean sendTalkCancel(String mbrNm, String sPhoneNo) throws Exception {
		JSONObject param = this.msgOn00002(mbrNm);
		
        boolean bResult = this.sendApiWithToken("/v2/kko/sendAlimTalk", sPhoneNo, param);
        
        this.getResultAll();
        
        return bResult;
	}
	
	// ON_00004 이로움ON회원_상담접수완료 biztalkApiService.sendTalkCreated("이동열", "010-2808-9178");
	public boolean sendTalkCreated(String mbrNm, String sPhoneNo) throws Exception {
		JSONObject param = this.msgOn00004(mbrNm);
		
        boolean bResult = this.sendApiWithToken("/v2/kko/sendAlimTalk", sPhoneNo, param);
        
        // this.getResultAll();
        
        return bResult;
	}

	// ON_00005 이로움ON회원_재상담접수완료 biztalkApiService.sendTalkMatchAgain("이동열", "010-2808-9178");
	public boolean sendTalkMatchAgain(String mbrNm, String sPhoneNo) throws Exception {
		JSONObject param = this.msgOn00005(mbrNm);
		
        boolean bResult = this.sendApiWithToken("/v2/kko/sendAlimTalk", sPhoneNo, param);
        
        // this.getResultAll();
        
        return bResult;
	}
	
	// ON_00006 이로움ON회원_매칭완료(공통) biztalkApiService.sendTalkMatchAgain("이동열", "010-2808-9178");
	public boolean sendTalkMatched(String mbrNm, String bplcNm, String sPhoneNo) throws Exception {
		JSONObject param = this.msgOn00006(mbrNm, bplcNm);
		
        boolean bResult = this.sendApiWithToken("/v2/kko/sendAlimTalk", sPhoneNo, param);
        
        // this.getResultAll();
        
        return bResult;
	}


	// ON_00002 #{회원이름}님, 요청하신 1:1 상담이 취소되었습니다
	private JSONObject msgOn00002(String mbrNm) throws Exception {
		
		String jsonStr;
		
		JSONObject jsonObject;
		JSONParser jsonParser = new JSONParser();
		JSONArray list = new JSONArray();
		
		jsonStr = "{" + " \"name\":\"◼︎ 요양정보 간편조회\"," + " \"type\":\"WL\"" + " , \"url_mobile\":\"#{url}\", \"url_pc\":\"#{url}\"}" ;
		jsonStr = jsonStr.replace("#{url}", "https://eroum.co.kr/main/recipter/list");
		jsonObject= (JSONObject) jsonParser.parse(jsonStr);
		list.add(jsonObject);
		
		jsonStr = "{" + " \"name\":\"◼︎ 인정등급 예상 테스트\"," + " \"type\":\"WL\"" + " , \"url_mobile\":\"#{url}\", \"url_pc\":\"#{url}\"}" ;
		jsonStr = jsonStr.replace("#{url}", "https://eroum.co.kr/main/cntnts/test");
		jsonObject= (JSONObject) jsonParser.parse(jsonStr);
		list.add(jsonObject);
		
		
		JSONObject btn = new JSONObject();
		btn.put("button", list);
		
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		long timeInMillis =System.currentTimeMillis();
		Date timeInDate = new Date(timeInMillis); 
        String timeInFormat = sdf.format(timeInDate);
		
		String msg = "#{회원이름}님, 요청하신 1:1 상담이 취소되었습니다.\r\n"
				+ "\r\n"
				+ "◼︎ 상담 취소일 : #{YYYY-MM-DD}\r\n"
				+ "\r\n"
				+ "상담을 원하시는 경우 이로움ON에서 다시 상담을 요청해 주세요.";
		
		
		msg = msg.replace("#{회원이름}", mbrNm);
		msg = msg.replace("#{YYYY-MM-DD}", timeInFormat);
		
		JSONObject param = new JSONObject();
		
		param.put("tmpltCode", "ON_00002");
		param.put("senderKey", this.biztalkSenderKeyEroumOn);
		param.put("message", msg);
		param.put("title", "상담 취소 안내");
		param.put("attach", btn);
		
		return param;
	}
	
	// ON_00003 이로움ON 회원가입이 완료되었습니다
	private JSONObject msgOn00003(String mbrNm) throws Exception {
		
		String jsonStr;
		
		
		JSONObject jsonObject;
		JSONParser jsonParser = new JSONParser();
		JSONArray list = new JSONArray();
		
		jsonStr = "{" + " \"name\":\"채널 추가\"," + " \"type\":\"AC\"" + "}" ;
		jsonObject= (JSONObject) jsonParser.parse(jsonStr);
		list.add(jsonObject);
		
		jsonStr = "{" + " \"name\":\"◼︎ 이로움ON 바로가기\"," + " \"type\":\"WL\"" + " , \"url_mobile\":\"https://eroum.co.kr/\", \"url_pc\":\"https://eroum.co.kr/\"}" ;
		jsonObject= (JSONObject) jsonParser.parse(jsonStr);
		list.add(jsonObject);
		
		
		JSONObject btn = new JSONObject();
		btn.put("button", list);
		
		String msg = "안녕하세요, #{회원이름}님\n"
				+ "이로움ON 회원가입이 완료되었습니다.\n"
				+ "\n"
				+ "이로움ON을 통해 시니어들을 위한 다양한 생활용품과 노인장기요양보험 지원 혜택 및 복지 정보를 확인해 보세요!";
		
		
		msg = msg.replace("#{회원이름}", mbrNm);
		
		JSONObject param = new JSONObject();
		
		param.put("tmpltCode", "ON_00003");
		param.put("senderKey", this.biztalkSenderKeyEroumOn);
		param.put("message", msg);
		param.put("title", "회원가입 완료");
		param.put("attach", btn);
		
		return param;
	}

	// ON_00004 상담을 신청해 주셔서 감사합니다.
	private JSONObject msgOn00004(String mbrNm) throws Exception {
		
		String jsonStr;
		
		JSONObject jsonObject;
		JSONParser jsonParser = new JSONParser();
		JSONArray list = new JSONArray();
		
		jsonStr = "{" + " \"name\":\"◼︎ 상담내역 바로가기\"," + " \"type\":\"WL\"" + " , \"url_mobile\":\"#{url}\", \"url_pc\":\"#{url}\"}" ;
		jsonStr = jsonStr.replace("#{url}", "https://eroum.co.kr/membership/conslt/appl/list");
		jsonObject= (JSONObject) jsonParser.parse(jsonStr);
		list.add(jsonObject);
		
		
		JSONObject btn = new JSONObject();
		btn.put("button", list);
		
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		long timeInMillis =System.currentTimeMillis();
		Date timeInDate = new Date(timeInMillis); 
        String timeInFormat = sdf.format(timeInDate);
		
		String msg = "#{회원이름}님, 상담을 신청해 주셔서 감사합니다.\r\n"
				+ "\r\n"
				+ "고객님의 1:1상담이 정상 접수되어 장기요양기관과 상담 매칭 준비 중입니다.\r\n"
				+ "\r\n"
				+ "매칭 완료 시 안내드리겠습니다. 감사합니다.\r\n"
				+ "\r\n"
				+ "◼︎ 상담 신청일 : #{YYYY-MM-DD}";
		
		
		msg = msg.replace("#{회원이름}", mbrNm);
		msg = msg.replace("#{YYYY-MM-DD}", timeInFormat);
		
		JSONObject param = new JSONObject();
		
		param.put("tmpltCode", "ON_00004");
		param.put("senderKey", this.biztalkSenderKeyEroumOn);
		param.put("message", msg);
		param.put("title", "상담 접수 완료");
		param.put("attach", btn);
		
		return param;
	}

	// ON_00005 #{회원이름}님, 재상담을 신청해 주셔서 감사합니다.
	private JSONObject msgOn00005(String mbrNm) throws Exception {
		
		String jsonStr;
		
		JSONObject jsonObject;
		JSONParser jsonParser = new JSONParser();
		JSONArray list = new JSONArray();
		
		jsonStr = "{" + " \"name\":\"◼︎ 상담내역 바로가기\"," + " \"type\":\"WL\"" + " , \"url_mobile\":\"#{url}\", \"url_pc\":\"#{url}\"}" ;
		jsonStr = jsonStr.replace("#{url}", "https://eroum.co.kr/membership/conslt/appl/list");
		jsonObject= (JSONObject) jsonParser.parse(jsonStr);
		list.add(jsonObject);
		
		
		JSONObject btn = new JSONObject();
		btn.put("button", list);
		
		String msg = "#{회원이름}님, 재상담을 신청해 주셔서 감사합니다.\r\n"
				+ "\r\n"
				+ "고객님의 1:1상담이 정상 접수되어 장기요양기관과 상담 매칭 준비 중입니다.\r\n"
				+ "\r\n"
				+ "재상담의 경우 총 2회까지 가능합니다.\r\n"
				+ "매칭 완료 시 안내드리겠습니다. 감사합니다.";
		
		
		msg = msg.replace("#{회원이름}", mbrNm);
		
		JSONObject param = new JSONObject();
		
		param.put("tmpltCode", "ON_00005");
		param.put("senderKey", this.biztalkSenderKeyEroumOn);
		param.put("message", msg);
		param.put("title", "재상담 접수 완료");
		param.put("attach", btn);
		
		return param;
	}
	
	// ON_00006 #{회원이름}님, 장기요양기관이 매칭되었습니다
	private JSONObject msgOn00006(String mbrNm, String bplcNm) throws Exception {
		
		String jsonStr;
		
		JSONObject jsonObject;
		JSONParser jsonParser = new JSONParser();
		JSONArray list = new JSONArray();
		
		jsonStr = "{" + " \"name\":\"◼︎ 상담내역 바로가기\"," + " \"type\":\"WL\"" + " , \"url_mobile\":\"https://eroum.co.kr/membership/conslt/appl/list\", \"url_pc\":\"https://eroum.co.kr/membership/conslt/appl/list\"}" ;
		jsonObject= (JSONObject) jsonParser.parse(jsonStr);
		list.add(jsonObject);
		
		
		JSONObject btn = new JSONObject();
		btn.put("button", list);
		
		String msg = "#{회원이름}님, 장기요양기관이 매칭되었습니다.\r\n"
				+ "\r\n"
				+ "48시간(2일/영업일 기준) 이내에 #{장기요양기관명}에서 연락드릴 예정입니다.\r\n"
				+ "감사합니다.\r\n"
				+ "\r\n"
				+ "◼︎ 장기요양기관명 : #{장기요양기관명}";
		
		
		msg = msg.replace("#{회원이름}", mbrNm);
		msg = msg.replace("#{장기요양기관명}", bplcNm);
		
		JSONObject param = new JSONObject();
		
		param.put("tmpltCode", "ON_00006");
		param.put("senderKey", this.biztalkSenderKeyEroumOn);
		param.put("message", msg);
		param.put("title", "1:1상담 매칭 완료");
		param.put("attach", btn);
		
		return param;
	}
}
