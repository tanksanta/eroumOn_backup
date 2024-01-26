package icube.common.api.biz;

import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.InputStreamReader;
import java.io.OutputStreamWriter;
import java.net.HttpURLConnection;
import java.net.URL;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;

import javax.annotation.Resource;

import org.egovframe.rte.fdl.string.EgovStringUtil;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;

import com.google.gson.JsonArray;
import com.google.gson.JsonElement;
import com.google.gson.JsonObject;
import com.google.gson.JsonParser;

import icube.common.framework.abst.CommonAbstractServiceImpl;
import icube.manage.mbr.mbr.biz.MbrService;
import icube.manage.mbr.mbr.biz.MbrVO;
import icube.membership.info.biz.DlvyService;
import icube.membership.info.biz.DlvyVO;


@Service("kakaoApiService")
public class KakaoApiService extends CommonAbstractServiceImpl{

	@Resource(name = "mbrService")
	private MbrService mbrService;

	@Resource(name = "dlvyService")
	private DlvyService dlvyService;

	@Value("#{props['Kakao.Api.Key']}")
	private String kakaoApiKey;

	@Value("#{props['Kakao.Redirect.Url']}")
	private String redirectUrl;

	@Value("#{props['Kakao.Auth.Url']}")
	private String authUrl;

	@Value("#{props['Kakao.User.Url']}")
	private String userUrl;

	@Value("#{props['Kakao.Dlvy.Url']}")
	private String dlvyUrl;

	SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");

	// 0 : 오류
	// 1 : 성공
	// 2 : 카카오 회원 가입
	// 3 : 네이버 회원가입
	// 4 : 이로움 회원가입
	// 5 : 가입정보 2개
	// 6 : 사용자 정보 SET
	// 7 : 배송지 정보 SET
	// 8 : 블랙리스트
	// 9 : 휴면
	// 10: 탈퇴

	// 11: 재인증 성공
	// 12: 재인증 실패

	public String getKakaoAuthUrl(String url) throws Exception {
		if (EgovStringUtil.isEmpty(url)) {
			url = redirectUrl;
		}
		
		StringBuffer sb = new StringBuffer();
		sb.append("https://kauth.kakao.com/oauth/authorize?client_id=" + kakaoApiKey);
		sb.append("&redirect_uri=" + url);
		return sb.toString();
	}
	
	/**
	 * 인가 코드 발급
	 * @return authUrl
	 * @throws Exception
	 */
	public String getKakaoUrl() throws Exception {
		return getKakaoAuthUrl(null) + "&response_type=code";
	}

	// 코드 재인증
	public String getKakaoReAuth() throws Exception {
		return getKakaoAuthUrl(null) + "&response_type=code&auth_type=reauthenticate";
	}
	
	
	/**
	 * 토큰 발급
	 * @param code
	 * @return result
	 * @throws Exception
	 */
	public Map<String, Object> getToken(String code) throws Exception {
		Map<String, Object> resultMap = new HashMap<String, Object>();

		String accessToken = "";
		String refreshToken = "";

		URL url = new URL(authUrl);
		HttpURLConnection conn = (HttpURLConnection) url.openConnection();

		conn.setRequestMethod("POST");
		conn.setDoOutput(true);

		BufferedWriter bufferedWriter = new BufferedWriter(new OutputStreamWriter(conn.getOutputStream(), "UTF-8"));
		StringBuffer sb = new StringBuffer();
		sb.append("grant_type=authorization_code");
		sb.append("&client_id=" + kakaoApiKey);
		sb.append("&redirect_uri=" + redirectUrl);
		sb.append("&code=" + code);
		bufferedWriter.write(sb.toString());
		bufferedWriter.flush();

		int responseCode = conn.getResponseCode();

		if(responseCode == HttpURLConnection.HTTP_OK) {
			BufferedReader bufferedReader = new BufferedReader(new InputStreamReader(conn.getInputStream(), "UTF-8"));
			String line = "";
			StringBuilder result = new StringBuilder();

			while ((line = bufferedReader.readLine()) != null) {
				result.append(line);
			}

			JsonElement element = JsonParser.parseString(result.toString());

			accessToken = element.getAsJsonObject().get("access_token").getAsString();
			refreshToken = element.getAsJsonObject().get("refresh_token").getAsString();


			bufferedReader.close();
			bufferedWriter.close();

			resultMap.put("accessToken", accessToken);
			resultMap.put("refreshToken", refreshToken);
		}

		return resultMap;
	}

	/**
	 * 사용자 정보 조회
	 * @param keyMap
	 * @return result
	 * @throws Exception
	 */
	public MbrVO getKakaoUserInfo(String accessToken, String refreshToken) throws Exception {
		URL url = new URL(userUrl);
        HttpURLConnection conn = (HttpURLConnection) url.openConnection();
        conn.setRequestMethod("POST");
        conn.setDoOutput(true);

        conn.setRequestProperty("Authorization", "Bearer " + accessToken);

        BufferedReader br = new BufferedReader(new InputStreamReader(conn.getInputStream(), "UTF-8"));
        String line = "";
        StringBuilder result = new StringBuilder();

        while ((line = br.readLine()) != null) {
            result.append(line);
        }

        JsonElement element = JsonParser.parseString(result.toString());
        JsonObject jsonObj = element.getAsJsonObject();
        jsonObj.addProperty("accessToken", accessToken);
        element = JsonParser.parseString(jsonObj.toString());

        MbrVO kakaoUserInfo = new MbrVO();
        kakaoUserInfo.setAccessToken(accessToken);
        kakaoUserInfo.setRefreshToken(refreshToken);
        kakaoUserInfo.setJoinTy("K");
        
        //사용자 정보 추출
        String id = element.getAsJsonObject().get("id").getAsString();
        kakaoUserInfo.setMbrId(id + "@K");
        kakaoUserInfo.setKakaoAppId(id);
        
        JsonElement info = element.getAsJsonObject().get("kakao_account");
        boolean genderFlag = info.getAsJsonObject().get("has_gender").getAsBoolean();
		boolean emailFlag = info.getAsJsonObject().get("has_email").getAsBoolean();
		boolean birthDayFlag = info.getAsJsonObject().get("has_birthday").getAsBoolean();
		boolean birthYearFlag = info.getAsJsonObject().get("has_birthyear").getAsBoolean();
		boolean mblTelnoFlag = info.getAsJsonObject().get("has_phone_number").getAsBoolean();
		boolean ciFlag = info.getAsJsonObject().get("has_ci").getAsBoolean();

		if(genderFlag) {
			String codeGender = "M";
			String enGender = info.getAsJsonObject().get("gender").getAsString();
			if(enGender.equals("female")) {
				codeGender = "W";
			}
			kakaoUserInfo.setGender(codeGender);
		}

		if(mblTelnoFlag) {
			String mblTelno = info.getAsJsonObject().get("phone_number").getAsString();
			kakaoUserInfo.setMblTelno(mblTelno.replace("+82 10", "010"));
		}

		if(emailFlag) {
			String email = info.getAsJsonObject().get("email").getAsString();
			kakaoUserInfo.setEml(email);
		}

		if(birthDayFlag && birthYearFlag) {
			String birthYear = info.getAsJsonObject().get("birthyear").getAsString();
			String birthDay = info.getAsJsonObject().get("birthday").getAsString();

			StringBuffer sb = new StringBuffer();
			sb.append(birthYear);
			sb.append(birthDay);
			sb.insert(4, "-");
			sb.insert(7, "-");

			Date birthDate = formatter.parse(sb.toString().trim());
			kakaoUserInfo.setBrdt(birthDate);
		}

		String name = info.getAsJsonObject().get("name").getAsString();
		if(EgovStringUtil.isNotEmpty(name)) {
			kakaoUserInfo.setMbrNm(name);
		}
		
		if (ciFlag) {
			String ci = info.getAsJsonObject().get("ci").getAsString();
			kakaoUserInfo.setCiKey(ci);
		}
		
		
		return kakaoUserInfo;
	}

	/**
	 * 사용자 배송지 정보 조회
	 * @param mbrVO
	 * @return result
	 * @throws Exception
	 */
	public DlvyVO getUserDlvy(String accessToken) throws Exception {
		//1. 엑세스 토큰을 이용한 발급
		//2. 주소 정보 SET
		//3. 배송지 정보 SET
		//4. 생일, 전화번호로 회원 판별
		
		URL url = new URL(dlvyUrl);
        HttpURLConnection conn = (HttpURLConnection) url.openConnection();
        conn.setRequestMethod("GET");
        conn.setDoOutput(true);
        conn.setRequestProperty("Authorization", "Bearer " + accessToken);

        BufferedReader br = new BufferedReader(new InputStreamReader(conn.getInputStream(), "UTF-8"));
        String line = "";
        StringBuilder result = new StringBuilder();

        while ((line = br.readLine()) != null) {
            result.append(line);
        }
        JsonElement element = JsonParser.parseString(result.toString());

        JsonElement dlvyInfo = element.getAsJsonObject().get("shipping_addresses");

        if(dlvyInfo == null) {
        	return null;
        } 
        
        DlvyVO dlvyVO = null;
    	JsonArray addresses = dlvyInfo.getAsJsonArray();

        for(JsonElement address : addresses) {

        	boolean defaultYn = address.getAsJsonObject().get("default").getAsBoolean();

        	String zip = address.getAsJsonObject().get("zone_number").getAsString();
        	String addr = address.getAsJsonObject().get("base_address").getAsString();
        	String daddr = address.getAsJsonObject().get("detail_address").getAsString();

        	String dlvyNm = address.getAsJsonObject().get("name").getAsString();
        	String nm = address.getAsJsonObject().get("receiver_name").getAsString();

        	if(defaultYn) {
        		dlvyVO = new DlvyVO();
        		dlvyVO.setZip(zip);
	        	dlvyVO.setAddr(addr);
	        	dlvyVO.setDaddr(daddr);
        		dlvyVO.setBassDlvyYn("Y");
        		dlvyVO.setDlvyNm(dlvyNm);
	        	dlvyVO.setNm(nm);
        	}
        }
        return dlvyVO;
	}
}
