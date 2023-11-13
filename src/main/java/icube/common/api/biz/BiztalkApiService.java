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
import org.springframework.stereotype.Service;

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
	private String biztalkSenderKeyEroumOn;//카카오 발신프로필 키 - @이로움온 용
	
	@Value("#{props['Biztalk.SenderKeyEroumcare']}")
	private String biztalkSenderKeyEroumcare;//카카오 발신프로필 키 - @이로움케어 용
	
	@Value("#{props['Globals.EroumCare.host']}")
	private String careHost;//케어서버 호스트
	
	
	// @Value("#{props['Biztalk.TargetEroumHost']}")//이로움온 서버
	private String eroumOnHost = "https://eroum.co.kr";
	

	private String biztalkTokenKey;//토큰 문자열
	private String biztalkTokenExpireDate;//토큰 만료시간 (YYYYMMDDhhmmss) ( 최대 24시간 )//현재는 토큰을 신경 쓸 필요가 없다. 세션으로 4시간 관리하기때문에
	private Date biztalkTokenExpireDate2 = null;//토근 만료시간
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
		if (activeMode.equals("real")) {/*운영은 핸드폰 번호 그대로 보낸다*/
			if (EgovStringUtil.isEmpty(sPhoneNo)) {
				log.debug("sPhoneNo undefined");
				
				return true;
			}
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
		
		try {
			jsonParser.parse(responseStr);
		}catch(Exception e) {
			e.printStackTrace();
			log.debug(e.getMessage());
			
			throw e;
		}
		
		return true;
	}

	// ON_0001 이로움ON회원_가입완료 biztalkApiService.sendJoinComleted("이동열", "010-2808-9178");
	public boolean sendOnJoinComleted(MbrVO mbrVO) throws Exception {
		String tmpltCode = "ON_0001";
		JSONObject param = this.msgOn0001(tmpltCode, mbrVO.getMbrNm());

		return this.sendApiWithToken("/v2/kko/sendAlimTalk", mbrVO.getMblTelno(), param);
	}

	// ON_0004 이로움ON회원_상담신청취소 biztalkApiService.sendTalkCancel("이동열", "010-2808-9178");
	public boolean sendOnTalkCancel(MbrVO mbrVO, MbrRecipientsVO mbrRecipientsVO) throws Exception {
		String tmpltCode = "ON_0004";
		JSONObject param = this.msgOn0004(tmpltCode, mbrVO, mbrRecipientsVO);
		
        boolean bResult = this.sendApiWithToken("/v2/kko/sendAlimTalk", mbrVO.getMblTelno(), param);
        
        this.getResultAll();
        
        return bResult;
	}
	
	// ON_0002 이로움ON회원_상담접수완료 biztalkApiService.sendTalkCreated("이동열", "010-2808-9178");
	public boolean sendOnTalkCreated(MbrVO mbrVO, MbrRecipientsVO mbrRecipientsVO) throws Exception {
		String tmpltCode = "ON_0002";
		JSONObject param = this.msgOn0002(tmpltCode, mbrVO, mbrRecipientsVO);
		
        boolean bResult = this.sendApiWithToken("/v2/kko/sendAlimTalk", mbrVO.getMblTelno(), param);
        
        // this.getResultAll();
        
        return bResult;
	}

	// ON_0003 이로움ON회원_재상담접수완료 biztalkApiService.sendTalkMatchAgain("이동열", "010-2808-9178");
	public boolean sendOnTalkMatchAgain(MbrVO mbrVO, MbrRecipientsVO mbrRecipientsVO) throws Exception {
		String tmpltCode = "ON_0003";
		JSONObject param = this.msgOn0003(tmpltCode, mbrVO, mbrRecipientsVO);
		
        boolean bResult = this.sendApiWithToken("/v2/kko/sendAlimTalk", mbrVO.getMblTelno(), param);
        
        // this.getResultAll();
        
        return bResult;
	}
	
	// ON_0005 이로움ON회원_매칭완료(공통) biztalkApiService.sendTalkMatchAgain("이동열", "010-2808-9178");
	public boolean sendOnTalkMatched(MbrVO mbrVO, MbrRecipientsVO mbrRecipientsVO, BplcVO bplcVO) throws Exception {
		String tmpltCode = "ON_0005";
		JSONObject param = this.msgOn0005(tmpltCode, mbrVO, mbrRecipientsVO, bplcVO);
		
        boolean bResult = this.sendApiWithToken("/v2/kko/sendAlimTalk", mbrVO.getMblTelno(), param);
        
        // this.getResultAll();
        
        return bResult;
	}

	// Care_0001 사업소_수급자매칭 biztalkApiService.sendCareTalkMatched("사업소", "010-2808-9178");
	public boolean sendCareTalkMatched(String bplcNm, String consltID, String sPhoneNo) throws Exception {
		String tmpltCode = "Care_0001";
		JSONObject param = this.msgCare0001(tmpltCode, bplcNm, consltID);
		
        boolean bResult = this.sendApiWithToken("/v2/kko/sendAlimTalk", sPhoneNo, param);
        
        // this.getResultAll();
        
        return bResult;
	}
	
	// Care_0002 사업소_수급자매칭 biztalkApiService.sendCareTalkCancel("사업소", "010-2808-9178");
	public boolean sendCareTalkCancel(String bplcNm, String sPhoneNo) throws Exception {
		String tmpltCode = "Care_0002";

		JSONObject param = this.msgCare0002(tmpltCode, bplcNm);
		
        boolean bResult = this.sendApiWithToken("/v2/kko/sendAlimTalk", sPhoneNo, param);
        
        // this.getResultAll();
        
        return bResult;
	}


	// ON_0001 이로움ON 회원가입이 완료되었습니다
	private JSONObject msgOn0001(String tmpltCode, String mbrNm) throws Exception {
		
		String jsonStr;
		
		
		JSONObject jsonObject;
		JSONParser jsonParser = new JSONParser();
		JSONArray list = new JSONArray();
		
		jsonStr = "{" + " \"name\":\"채널 추가\"," + " \"type\":\"AC\"" + "}" ;
		jsonObject= (JSONObject) jsonParser.parse(jsonStr);
		list.add(jsonObject);
		
		jsonStr = "{" + " \"name\":\"◼︎ 이로움ON 바로가기\"," + " \"type\":\"WL\"" + " , \"url_mobile\":\"#{url}/\", \"url_pc\":\"#{url}/\"}" ;
		jsonStr = jsonStr.replace("#{url}", "https://eroum.co.kr");//URL 고정
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
		
		param.put("tmpltCode", tmpltCode);
		param.put("senderKey", this.biztalkSenderKeyEroumOn);
		param.put("message", msg);
		param.put("title", "회원가입 완료");
		param.put("attach", btn);
		
		return param;
	}

	// ON_0002 상담을 신청해 주셔서 감사합니다.
	private JSONObject msgOn0002(String tmpltCode, MbrVO mbrVO, MbrRecipientsVO mbrRecipientsVO) throws Exception {
		
		String jsonStr;
		
		JSONObject jsonObject;
		JSONParser jsonParser = new JSONParser();
		JSONArray list = new JSONArray();
		
		jsonStr = "{" + " \"name\":\"◼︎ 상담내역 바로가기\"," + " \"type\":\"WL\"" + " , \"url_mobile\":\"#{url}\", \"url_pc\":\"#{url}\"}" ;
		jsonStr = jsonStr.replace("#{url}", this.eroumOnHost + "/membership/conslt/appl/list");
		jsonObject= (JSONObject) jsonParser.parse(jsonStr);
		list.add(jsonObject);
		
		
		JSONObject btn = new JSONObject();
		btn.put("button", list);
		
		String timeInFormat = DateUtil.getCurrentDateTime("yyyy-MM-dd");
		
		String msg = "#{회원이름}님, 상담을 신청해 주셔서 감사합니다.\r\n" + //
				"\r\n" + //
				"[수급자 정보]\r\n" + //
				"성명: #{수급자 성명} 님\r\n" + //
				"회원님과의 관계 : #{가족 관계}\r\n" + //
				"상담 신청일 : #{YYYY-MM-DD}\r\n" + //
				"\r\n" + //
				"장기요양기관과 상담 매칭 완료 시 안내드리겠습니다. 감사합니다.";
		
		
		msg = msg.replace("#{회원이름}", mbrVO.getMbrNm());
		msg = msg.replace("#{YYYY-MM-DD}", timeInFormat);

		msg = msg.replace("#{수급자 성명}", mbrRecipientsVO.getRecipientsNm());
		msg = msg.replace("#{가족 관계}", CodeMap.MBR_RELATION_CD.get(mbrRecipientsVO.getRelationCd()));
		
		JSONObject param = new JSONObject();
		
		param.put("tmpltCode", tmpltCode);
		param.put("senderKey", this.biztalkSenderKeyEroumOn);
		param.put("message", msg);
		param.put("title", "상담 접수 완료");
		param.put("attach", btn);
		
		return param;
	}

	// ON_0003 #{회원이름}님, 재상담을 신청해 주셔서 감사합니다.
	private JSONObject msgOn0003(String tmpltCode, MbrVO mbrVO, MbrRecipientsVO mbrRecipientsVO) throws Exception {
		
		String jsonStr;
		
		JSONObject jsonObject;
		JSONParser jsonParser = new JSONParser();
		JSONArray list = new JSONArray();
		
		jsonStr = "{" + " \"name\":\"◼︎ 상담내역 바로가기\"," + " \"type\":\"WL\"" + " , \"url_mobile\":\"#{url}\", \"url_pc\":\"#{url}\"}" ;
		jsonStr = jsonStr.replace("#{url}", this.eroumOnHost + "/membership/conslt/appl/list");
		jsonObject= (JSONObject) jsonParser.parse(jsonStr);
		list.add(jsonObject);
		
		String timeInFormat = DateUtil.getCurrentDateTime("yyyy-MM-dd");
		
		JSONObject btn = new JSONObject();
		btn.put("button", list);
		
		String msg = "#{회원이름}님, 재상담을 신청해 주셔서 감사합니다.\r\n" + //
				"\r\n" + //
				"[수급자 정보]\r\n" + //
				"성명: #{수급자 성명} 님\r\n" + //
				"회원님과의 관계 : #{가족 관계}\r\n" + //
				"상담 신청일 : #{YYYY-MM-DD}\r\n" + //
				"\r\n" + //
				"재상담은 총 2회 가능합니다.\r\n" + //
				"- 현재 재상담 #{n}회 신청 중\r\n" + //
				"\r\n" + //
				"장기요양기관과 상담 매칭 완료 시 안내드리겠습니다. 감사합니다.";
		
		
		msg = msg.replace("#{회원이름}", mbrVO.getMbrNm());

		msg = msg.replace("#{YYYY-MM-DD}", timeInFormat);

		msg = msg.replace("#{수급자 성명}", mbrRecipientsVO.getRecipientsNm());
		msg = msg.replace("#{가족 관계}", CodeMap.MBR_RELATION_CD.get(mbrRecipientsVO.getRelationCd()));
		
		JSONObject param = new JSONObject();
		
		param.put("tmpltCode", tmpltCode);
		param.put("senderKey", this.biztalkSenderKeyEroumOn);
		param.put("message", msg);
		param.put("title", "재상담 접수 완료");
		param.put("attach", btn);
		
		return param;
	}

	// ON_0004 #{회원이름}님, 요청하신 1:1 상담이 취소되었습니다
	private JSONObject msgOn0004(String tmpltCode, MbrVO mbrVO, MbrRecipientsVO mbrRecipientsVO) throws Exception {
		
		String jsonStr;
		
		JSONObject jsonObject;
		JSONParser jsonParser = new JSONParser();
		JSONArray list = new JSONArray();
		
		jsonStr = "{" + " \"name\":\"◼︎ 요양정보 간편조회\"," + " \"type\":\"WL\"" + " , \"url_mobile\":\"#{url}\", \"url_pc\":\"#{url}\"}" ;
		jsonStr = jsonStr.replace("#{url}", this.eroumOnHost + "/main/recipter/sub");
		jsonObject= (JSONObject) jsonParser.parse(jsonStr);
		list.add(jsonObject);
		
		jsonStr = "{" + " \"name\":\"◼︎ 인정등급 예상 테스트\"," + " \"type\":\"WL\"" + " , \"url_mobile\":\"#{url}\", \"url_pc\":\"#{url}\"}" ;
		jsonStr = jsonStr.replace("#{url}", this.eroumOnHost + "/main/cntnts/test");
		jsonObject= (JSONObject) jsonParser.parse(jsonStr);
		list.add(jsonObject);
		
		
		JSONObject btn = new JSONObject();
		btn.put("button", list);
		
		String timeInFormat = DateUtil.getCurrentDateTime("yyyy-MM-dd");
		
		String msg = "#{회원이름}님, 요청하신 1:1 상담이 취소되었습니다.\r\n" + //
				"\r\n" + //
				"[수급자 정보]\r\n" + //
				"성명: #{수급자 성명} 님\r\n" + //
				"회원님과의 관계 : #{가족 관계}\r\n" + //
				"상담 취소일 : #{YYYY-MM-DD}\r\n" + //
				"\r\n" + //
				"상담을 원하시는 경우 이로움ON에서 다시 상담을 요청해 주세요.";
		
		
		msg = msg.replace("#{회원이름}", mbrVO.getMbrNm());
		msg = msg.replace("#{YYYY-MM-DD}", timeInFormat);

		msg = msg.replace("#{수급자 성명}", mbrRecipientsVO.getRecipientsNm());
		msg = msg.replace("#{가족 관계}", CodeMap.MBR_RELATION_CD.get(mbrRecipientsVO.getRelationCd()));
		
		JSONObject param = new JSONObject();
		
		param.put("tmpltCode", tmpltCode);
		param.put("senderKey", this.biztalkSenderKeyEroumOn);
		param.put("message", msg);
		param.put("title", "상담 취소 안내");
		param.put("attach", btn);
		
		return param;
	}

	// ON_0005 #{회원이름}님, 장기요양기관이 매칭되었습니다
	private JSONObject msgOn0005(String tmpltCode, MbrVO mbrVO, MbrRecipientsVO mbrRecipientsVO, BplcVO bplcVO) throws Exception {
		
		String jsonStr;
		
		JSONObject jsonObject;
		JSONParser jsonParser = new JSONParser();
		JSONArray list = new JSONArray();
		
		jsonStr = "{" + " \"name\":\"◼︎ 상담내역 바로가기\"," + " \"type\":\"WL\"" + " , \"url_mobile\":\"#{url}\", \"url_pc\":\"#{url}\"}" ;
		jsonStr = jsonStr.replace("#{url}", this.eroumOnHost + "/membership/conslt/appl/list");
		jsonObject= (JSONObject) jsonParser.parse(jsonStr);
		list.add(jsonObject);
		
		
		JSONObject btn = new JSONObject();
		btn.put("button", list);
		
		String msg = "#{회원이름}님, 장기요양기관이 매칭되었습니다.\r\n" + //
				"\r\n" + //
				"[수급자 정보]\r\n" + //
				"성명: #{수급자 성명} 님\r\n" + //
				"회원님과의 관계 : #{가족 관계}\r\n" + //
				"\r\n" + //
				"48시간(2일/영업일 기준) 이내에 #{장기요양기관명}에서 연락드릴 예정입니다.\r\n" + //
				"감사합니다.\r\n" + //
				"\r\n" + //
				"◼︎ 장기요양기관명 : #{장기요양기관명}";
		
		
		msg = msg.replace("#{회원이름}", mbrVO.getMbrNm());
		msg = msg.replace("#{장기요양기관명}", bplcVO.getBplcNm());

		msg = msg.replace("#{수급자 성명}", mbrRecipientsVO.getRecipientsNm());
		msg = msg.replace("#{가족 관계}", CodeMap.MBR_RELATION_CD.get(mbrRecipientsVO.getRelationCd()));
		
		JSONObject param = new JSONObject();
		
		param.put("tmpltCode", tmpltCode);
		param.put("senderKey", this.biztalkSenderKeyEroumOn);
		param.put("message", msg);
		param.put("title", "1:1상담 매칭 완료");
		param.put("attach", btn);
		
		return param;
	}

	// Care_0001 사업소_수급자매칭 사업소님, 1:1 상담이 매칭되었습니다.
	private JSONObject msgCare0001(String tmpltCode, String bplcNm, String consltID) throws Exception {
		
		String jsonStr;
		
		JSONObject jsonObject;
		JSONParser jsonParser = new JSONParser();
		JSONArray list = new JSONArray();
		jsonStr = "{" + " \"name\":\"◼︎ 매칭된 상담 확인하기\"," + " \"type\":\"WL\"" + " , \"url_mobile\":\"#{url}\", \"url_pc\":\"#{url}\"}" ;
		jsonStr = jsonStr.replace("#{url}", this.careHost + "/shop/eroumon_members_conslt_view.php?consltID=" + consltID);
		jsonObject= (JSONObject) jsonParser.parse(jsonStr);
		list.add(jsonObject);
		
		
		JSONObject btn = new JSONObject();
		btn.put("button", list);
		
		String msg = "[1:1 상담 매칭 완료]\n" + //
				"\n" + //
				"#{장기요양기관명} 사업소님, 1:1 상담이 매칭되었습니다.\n" + //
				"아래 버튼을 눌러 상담 요청자 정보 확인 후, 상담진행 요청드립니다.\n" + //
				"\n" + //
				"상담 완료 후, 상담 완료 버튼을 꼭 눌러주세요.\n" + //
				"상담 완료 전에 상담 내용도 자유롭게 작성하실 수 있습니다.\n" + //
				"\n" + //
				"사업소의 상담 내용을 반영하여 더욱 만족하실 수 있는 이로움이 되겠습니다. 감사합니다.";
		
		
		msg = msg.replace("#{장기요양기관명}", bplcNm);
		
		JSONObject param = new JSONObject();
		
		param.put("tmpltCode", tmpltCode);
		param.put("senderKey", this.biztalkSenderKeyEroumcare);
		param.put("message", msg);
		param.put("attach", btn);
		
		return param;
	}
	
	// Care_0002 사업소_상담취소 사업소님, 1:1 상담 매칭 취소.
	private JSONObject msgCare0002(String tmpltCode, String bplcNm) throws Exception {
		
		String jsonStr;
		
		JSONObject jsonObject;
		JSONParser jsonParser = new JSONParser();
		JSONArray list = new JSONArray();
		
		jsonStr = "{" + " \"name\":\"◼︎ 상담관리 바로가기\"," + " \"type\":\"WL\"" + " , \"url_mobile\":\"#{url}\", \"url_pc\":\"#{url}\"}" ;
		jsonStr = jsonStr.replace("#{url}", this.careHost + "/shop/eroumon_members_conslt_list.php");
		jsonObject= (JSONObject) jsonParser.parse(jsonStr);
		list.add(jsonObject);
		
		
		JSONObject btn = new JSONObject();
		btn.put("button", list);
		
		String msg = "[1:1 상담 매칭 취소]\r\n"
				+ "\r\n"
				+ "#{장기요양기관명} 사업소님, 상담 요청자에 의해 1:1 상담 매칭이 취소되었습니다.\r\n"
				+ "\r\n"
				+ "아래 버튼을 누르면 수급자 상담관리 페이지로 바로 이동됩니다.";
		
		
		msg = msg.replace("#{장기요양기관명}", bplcNm);
		
		JSONObject param = new JSONObject();
		
		param.put("tmpltCode", tmpltCode);
		param.put("senderKey", this.biztalkSenderKeyEroumcare);
		param.put("message", msg);
		param.put("attach", btn);
		
		return param;
	}


	//********************************************************************************************************************** */
	// ON_00002 #{회원이름}님, 요청하신 1:1 상담이 취소되었습니다
	/*
	// private JSONObject msgOn00002(String mbrNm) throws Exception {
		
	// 	String jsonStr;
		
	// 	JSONObject jsonObject;
	// 	JSONParser jsonParser = new JSONParser();
	// 	JSONArray list = new JSONArray();
		
	// 	jsonStr = "{" + " \"name\":\"◼︎ 요양정보 간편조회\"," + " \"type\":\"WL\"" + " , \"url_mobile\":\"#{url}\", \"url_pc\":\"#{url}\"}" ;
	// 	jsonStr = jsonStr.replace("#{url}", this.eroumOnHost + "/main/recipter/sub");
	// 	jsonObject= (JSONObject) jsonParser.parse(jsonStr);
	// 	list.add(jsonObject);
		
	// 	jsonStr = "{" + " \"name\":\"◼︎ 인정등급 예상 테스트\"," + " \"type\":\"WL\"" + " , \"url_mobile\":\"#{url}\", \"url_pc\":\"#{url}\"}" ;
	// 	jsonStr = jsonStr.replace("#{url}", this.eroumOnHost + "/main/cntnts/test");
	// 	jsonObject= (JSONObject) jsonParser.parse(jsonStr);
	// 	list.add(jsonObject);
		
		
	// 	JSONObject btn = new JSONObject();
	// 	btn.put("button", list);
		
	// 	SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
	// 	long timeInMillis =System.currentTimeMillis();
	// 	Date timeInDate = new Date(timeInMillis); 
    //     String timeInFormat = sdf.format(timeInDate);
		
	// 	String msg = "#{회원이름}님, 요청하신 1:1 상담이 취소되었습니다.\r\n"
	// 			+ "\r\n"
	// 			+ "◼︎ 상담 취소일 : #{YYYY-MM-DD}\r\n"
	// 			+ "\r\n"
	// 			+ "상담을 원하시는 경우 이로움ON에서 다시 상담을 요청해 주세요.";
		
		
	// 	msg = msg.replace("#{회원이름}", mbrNm);
	// 	msg = msg.replace("#{YYYY-MM-DD}", timeInFormat);
		
	// 	JSONObject param = new JSONObject();
		
	// 	param.put("tmpltCode", "ON_00002-");
	// 	param.put("senderKey", this.biztalkSenderKeyEroumOn);
	// 	param.put("message", msg);
	// 	param.put("title", "상담 취소 안내");
	// 	param.put("attach", btn);
		
	// 	return param;
	// }
	*/
	
	// // ON_00003 이로움ON 회원가입이 완료되었습니다
	/*
	// private JSONObject msgOn00003(String mbrNm) throws Exception {
		
	// 	String jsonStr;
		
		
	// 	JSONObject jsonObject;
	// 	JSONParser jsonParser = new JSONParser();
	// 	JSONArray list = new JSONArray();
		
	// 	jsonStr = "{" + " \"name\":\"채널 추가\"," + " \"type\":\"AC\"" + "}" ;
	// 	jsonObject= (JSONObject) jsonParser.parse(jsonStr);
	// 	list.add(jsonObject);
		
	// 	jsonStr = "{" + " \"name\":\"◼︎ 이로움ON 바로가기\"," + " \"type\":\"WL\"" + " , \"url_mobile\":\"#{url}/\", \"url_pc\":\"#{url}/\"}" ;
	// 	jsonStr = jsonStr.replace("#{url}", "https://eroum.co.kr");//URL 고정
	// 	jsonObject= (JSONObject) jsonParser.parse(jsonStr);
	// 	list.add(jsonObject);
		
		
	// 	JSONObject btn = new JSONObject();
	// 	btn.put("button", list);
		
	// 	String msg = "안녕하세요, #{회원이름}님\n"
	// 			+ "이로움ON 회원가입이 완료되었습니다.\n"
	// 			+ "\n"
	// 			+ "이로움ON을 통해 시니어들을 위한 다양한 생활용품과 노인장기요양보험 지원 혜택 및 복지 정보를 확인해 보세요!";
		
		
	// 	msg = msg.replace("#{회원이름}", mbrNm);
		
	// 	JSONObject param = new JSONObject();
		
	// 	param.put("tmpltCode", "ON_00003");
	// 	param.put("senderKey", this.biztalkSenderKeyEroumOn);
	// 	param.put("message", msg);
	// 	param.put("title", "회원가입 완료");
	// 	param.put("attach", btn);
		
	// 	return param;
	// }
	*/

	// // ON_00004 상담을 신청해 주셔서 감사합니다.
	/*
	// private JSONObject msgOn00004(String mbrNm) throws Exception {
		
	// 	String jsonStr;
		
	// 	JSONObject jsonObject;
	// 	JSONParser jsonParser = new JSONParser();
	// 	JSONArray list = new JSONArray();
		
	// 	jsonStr = "{" + " \"name\":\"◼︎ 상담내역 바로가기\"," + " \"type\":\"WL\"" + " , \"url_mobile\":\"#{url}\", \"url_pc\":\"#{url}\"}" ;
	// 	jsonStr = jsonStr.replace("#{url}", this.eroumOnHost + "/membership/conslt/appl/list");
	// 	jsonObject= (JSONObject) jsonParser.parse(jsonStr);
	// 	list.add(jsonObject);
		
		
	// 	JSONObject btn = new JSONObject();
	// 	btn.put("button", list);
		
	// 	SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
	// 	long timeInMillis =System.currentTimeMillis();
	// 	Date timeInDate = new Date(timeInMillis); 
    //     String timeInFormat = sdf.format(timeInDate);
		
	// 	String msg = "#{회원이름}님, 상담을 신청해 주셔서 감사합니다.\r\n"
	// 			+ "\r\n"
	// 			+ "고객님의 1:1상담이 정상 접수되어 장기요양기관과 상담 매칭 준비 중입니다.\r\n"
	// 			+ "\r\n"
	// 			+ "매칭 완료 시 안내드리겠습니다. 감사합니다.\r\n"
	// 			+ "\r\n"
	// 			+ "◼︎ 상담 신청일 : #{YYYY-MM-DD}";
		
		
	// 	msg = msg.replace("#{회원이름}", mbrNm);
	// 	msg = msg.replace("#{YYYY-MM-DD}", timeInFormat);
		
	// 	JSONObject param = new JSONObject();
		
	// 	param.put("tmpltCode", "ON_00004");
	// 	param.put("senderKey", this.biztalkSenderKeyEroumOn);
	// 	param.put("message", msg);
	// 	param.put("title", "상담 접수 완료");
	// 	param.put("attach", btn);
		
	// 	return param;
	// }
	*/

	// // ON_00005 #{회원이름}님, 재상담을 신청해 주셔서 감사합니다.
	/*
	// private JSONObject msgOn00005(String mbrNm) throws Exception {
		
	// 	String jsonStr;
		
	// 	JSONObject jsonObject;
	// 	JSONParser jsonParser = new JSONParser();
	// 	JSONArray list = new JSONArray();
		
	// 	jsonStr = "{" + " \"name\":\"◼︎ 상담내역 바로가기\"," + " \"type\":\"WL\"" + " , \"url_mobile\":\"#{url}\", \"url_pc\":\"#{url}\"}" ;
	// 	jsonStr = jsonStr.replace("#{url}", this.eroumOnHost + "/membership/conslt/appl/list");
	// 	jsonObject= (JSONObject) jsonParser.parse(jsonStr);
	// 	list.add(jsonObject);
		
		
	// 	JSONObject btn = new JSONObject();
	// 	btn.put("button", list);
		
	// 	String msg = "#{회원이름}님, 재상담을 신청해 주셔서 감사합니다.\r\n"
	// 			+ "\r\n"
	// 			+ "고객님의 1:1상담이 정상 접수되어 장기요양기관과 상담 매칭 준비 중입니다.\r\n"
	// 			+ "\r\n"
	// 			+ "재상담의 경우 총 2회까지 가능합니다.\r\n"
	// 			+ "매칭 완료 시 안내드리겠습니다. 감사합니다.";
		
		
	// 	msg = msg.replace("#{회원이름}", mbrNm);
		
	// 	JSONObject param = new JSONObject();
		
	// 	param.put("tmpltCode", "ON_00005");
	// 	param.put("senderKey", this.biztalkSenderKeyEroumOn);
	// 	param.put("message", msg);
	// 	param.put("title", "재상담 접수 완료");
	// 	param.put("attach", btn);
		
	// 	return param;
	// }
	*/

	// // ON_00006 #{회원이름}님, 장기요양기관이 매칭되었습니다
	/*
	// private JSONObject msgOn00006(String mbrNm, String bplcNm) throws Exception {
		
	// 	String jsonStr;
		
	// 	JSONObject jsonObject;
	// 	JSONParser jsonParser = new JSONParser();
	// 	JSONArray list = new JSONArray();
		
	// 	jsonStr = "{" + " \"name\":\"◼︎ 상담내역 바로가기\"," + " \"type\":\"WL\"" + " , \"url_mobile\":\"#{url}\", \"url_pc\":\"#{url}\"}" ;
	// 	jsonStr = jsonStr.replace("#{url}", this.eroumOnHost + "/membership/conslt/appl/list");
	// 	jsonObject= (JSONObject) jsonParser.parse(jsonStr);
	// 	list.add(jsonObject);
		
		
	// 	JSONObject btn = new JSONObject();
	// 	btn.put("button", list);
		
	// 	String msg = "#{회원이름}님, 장기요양기관이 매칭되었습니다.\r\n"
	// 			+ "\r\n"
	// 			+ "48시간(2일/영업일 기준) 이내에 #{장기요양기관명}에서 연락드릴 예정입니다.\r\n"
	// 			+ "감사합니다.\r\n"
	// 			+ "\r\n"
	// 			+ "◼︎ 장기요양기관명 : #{장기요양기관명}";
		
		
	// 	msg = msg.replace("#{회원이름}", mbrNm);
	// 	msg = msg.replace("#{장기요양기관명}", bplcNm);
		
	// 	JSONObject param = new JSONObject();
		
	// 	param.put("tmpltCode", "ON_00006");
	// 	param.put("senderKey", this.biztalkSenderKeyEroumOn);
	// 	param.put("message", msg);
	// 	param.put("title", "1:1상담 매칭 완료");
	// 	param.put("attach", btn);
		
	// 	return param;
	// }
	*/

	// Care_00001 사업소_수급자매칭 사업소님, 1:1 상담이 매칭되었습니다.
	/*
	private JSONObject msgCare00001(String bplcNm, String consltID) throws Exception {
		
		String jsonStr;
		
		JSONObject jsonObject;
		JSONParser jsonParser = new JSONParser();
		JSONArray list = new JSONArray();
		jsonStr = "{" + " \"name\":\"◼︎ 매칭된 상담 확인하기\"," + " \"type\":\"WL\"" + " , \"url_mobile\":\"#{url}\", \"url_pc\":\"#{url}\"}" ;
		jsonStr = jsonStr.replace("#{url}", this.careHost + "/shop/eroumon_members_conslt_view.php?consltID=" + consltID);
		jsonObject= (JSONObject) jsonParser.parse(jsonStr);
		list.add(jsonObject);
		
		
		JSONObject btn = new JSONObject();
		btn.put("button", list);
		
		String msg = "[1:1 상담 매칭 완료]\r\n"
				+ "\r\n"
				+ "#{장기요양기관명} 사업소님, 1:1 상담이 매칭되었습니다.\r\n"
				+ "아래 버튼을 눌러 상담 요청자 정보 확인 후, 상담진행 요청드립니다.\r\n"
				+ "\r\n"
				+ "상담완료 후, 상담완료 버튼을 꼭 클릭해 주세요.\r\n"
				+ "(상담완료 하시기 전에 상담하신 내용도 자유롭게 작성 가능합니다.)";
		
		
		msg = msg.replace("#{장기요양기관명}", bplcNm);
		
		JSONObject param = new JSONObject();
		
		param.put("tmpltCode", "Care_00001");
		param.put("senderKey", this.biztalkSenderKeyEroumcare);
		param.put("message", msg);
		param.put("attach", btn);
		
		return param;
	}
	*/
	
	// Care_00002 사업소_상담취소 사업소님, 1:1 상담 매칭 취소.
	/*
	private JSONObject msgCare00002(String bplcNm) throws Exception {
		
		String jsonStr;
		
		JSONObject jsonObject;
		JSONParser jsonParser = new JSONParser();
		JSONArray list = new JSONArray();
		
		jsonStr = "{" + " \"name\":\"◼︎ 상담관리 바로가기\"," + " \"type\":\"WL\"" + " , \"url_mobile\":\"#{url}\", \"url_pc\":\"#{url}\"}" ;
		jsonStr = jsonStr.replace("#{url}", this.careHost + "/shop/eroumon_members_conslt_list.php");
		jsonObject= (JSONObject) jsonParser.parse(jsonStr);
		list.add(jsonObject);
		
		
		JSONObject btn = new JSONObject();
		btn.put("button", list);
		
		String msg = "[1:1 상담 매칭 취소]\r\n"
				+ "\r\n"
				+ "#{장기요양기관명} 사업소님, 상담 요청자에 의해 1:1 상담 매칭이 취소되었습니다.\r\n"
				+ "\r\n"
				+ "아래 버튼을 누르면 수급자 상담관리 페이지로 바로 이동됩니다.";
		
		
		msg = msg.replace("#{장기요양기관명}", bplcNm);
		
		JSONObject param = new JSONObject();
		
		param.put("tmpltCode", "Care_00002");
		param.put("senderKey", this.biztalkSenderKeyEroumcare);
		param.put("message", msg);
		param.put("attach", btn);
		
		return param;
	}
	*/
}
