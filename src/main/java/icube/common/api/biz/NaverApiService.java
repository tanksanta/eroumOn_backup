package icube.common.api.biz;

import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.InputStreamReader;
import java.io.OutputStreamWriter;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLEncoder;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;

import javax.annotation.Resource;

import org.egovframe.rte.fdl.string.EgovStringUtil;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;

import com.google.gson.JsonElement;
import com.google.gson.JsonParser;

import icube.common.framework.abst.CommonAbstractServiceImpl;
import icube.common.util.UnicodeUtil;
import icube.manage.mbr.mbr.biz.MbrService;
import icube.manage.mbr.mbr.biz.MbrVO;


@Service("naverApiService")
public class NaverApiService extends CommonAbstractServiceImpl{

	@Resource(name = "mbrService")
	private MbrService mbrService;

	@Value("#{props['Naver.Client.Id']}")
	private String NaverClientId;

	@Value("#{props['Naver.Client.Secret']}")
	private String NaverClientSecret;

	@Value("#{props['Naver.Redirect.Url']}")
	private String NaverRedirectUrl;

	@Value("#{props['Naver.Token.Url']}")
	private String NaverTokenUrl;

	@Value("#{props['Naver.Profl.Url']}")
	private String NaverProflUrl;

	/**
	 * 인가 발급 URL
	 * @return URL
	 * @throws Exception
	 */
	public String getUrl() throws Exception {
		StringBuffer sb = new StringBuffer();
		sb.append("https://nid.naver.com/oauth2.0/authorize?response_type=code");
		sb.append("&client_id=");
		sb.append(NaverClientId);
		sb.append("&redirect_uri=");
		sb.append(NaverRedirectUrl);
		sb.append("&state=");
		sb.append(URLEncoder.encode("icube","UTF-8"));
		sb.append("&inapp_view=true");

		return sb.toString();
	}

	// 재인증
	public String getNaverReAuth() throws Exception {
		StringBuffer sb = new StringBuffer();
		sb.append("https://nid.naver.com/oauth2.0/authorize?response_type=code");
		sb.append("&client_id=");
		sb.append(NaverClientId);
		sb.append("&redirect_uri=");
		sb.append(NaverRedirectUrl);
		sb.append("&state=");
		sb.append(URLEncoder.encode("icube","UTF-8"));
		sb.append("&inapp_view=true&auth_type=reauthenticate");

		return sb.toString();
	}


	/**
	 * 토큰 발급
	 * @param paramMap(code, state)
	 * @return keyMap(accessToken, refreshToken, tokenType)
	 * @throws Exception
	 */
	public Map<String, Object> getToken(String code, String state) throws Exception {

		Map<String, Object> resultMap = new HashMap<String, Object>();
		String accessToken = "";
		String refreshToken = "";

		HttpURLConnection conn = getHeader(NaverTokenUrl, null);

		BufferedWriter bufferedWriter = new BufferedWriter(new OutputStreamWriter(conn.getOutputStream(), "UTF-8"));
		 
		StringBuffer sb = new StringBuffer();
		sb.append("grant_type=authorization_code");
		sb.append("&client_id=" + NaverClientId);
		sb.append("&client_secret=" + URLEncoder.encode(NaverClientSecret, "UTF-8"));
		sb.append("&redirect_uri=" + URLEncoder.encode(NaverRedirectUrl, "UTF-8"));
		sb.append("&code=" + code);
		sb.append("&state=" + state);
		String parameterStr = sb.toString();
		
		bufferedWriter.write(parameterStr);
		bufferedWriter.flush();

		Map<String, Object> eleMap = getResponse(conn);
		JsonElement element = (JsonElement)eleMap.get("element");

		accessToken = element.getAsJsonObject().get("access_token").getAsString();
		refreshToken = element.getAsJsonObject().get("refresh_token").getAsString();

		bufferedWriter.close();

		resultMap.put("accessToken", accessToken);
		resultMap.put("refreshToken", refreshToken);
		resultMap.put("tokenType", "N");

		return resultMap;
	}
	
	/**
	 * 토큰 갱신
	 */
	private Map<String, Object> getToken(String refreshToken) throws Exception {

		Map<String, Object> resultMap = new HashMap<String, Object>();
		String newAccessToken = "";
		String newRefreshToken = "";

		HttpURLConnection conn = getHeader(NaverTokenUrl, null);

		BufferedWriter bufferedWriter = new BufferedWriter(new OutputStreamWriter(conn.getOutputStream(), "UTF-8"));
		 
		StringBuffer sb = new StringBuffer();
		sb.append("grant_type=refresh_token");
		sb.append("&client_id=" +  NaverClientId);
		sb.append("&client_secret=" + NaverClientSecret);
		sb.append("&refresh_token=" + refreshToken);
		String parameterStr = sb.toString();
		
		bufferedWriter.write(parameterStr);
		bufferedWriter.flush();

		Map<String, Object> eleMap = getResponse(conn);
		JsonElement element = (JsonElement)eleMap.get("element");

		newAccessToken = element.getAsJsonObject().get("access_token").getAsString();
		newRefreshToken = element.getAsJsonObject().get("refresh_token").getAsString();

		bufferedWriter.close();

		resultMap.put("accessToken", newAccessToken);
		resultMap.put("refreshToken", newRefreshToken);
		resultMap.put("tokenType", "N");

		return resultMap;
	}
	
	/**
	 * 연동 해제
	 */
	public Map<String, Object> deleteNaverConnection(String refreshToken) throws Exception {
		//토큰 갱신
		Map<String, Object> tokenMap = getToken(refreshToken);
		String newAccessToken = (String)tokenMap.get("accessToken");
		
		Map<String, Object> resultMap = new HashMap<String, Object>();
		HttpURLConnection conn = getHeader(NaverTokenUrl, null);

		BufferedWriter bufferedWriter = new BufferedWriter(new OutputStreamWriter(conn.getOutputStream(), "UTF-8"));
		 
		StringBuffer sb = new StringBuffer();
		sb.append("grant_type=delete");
		sb.append("&client_id=" +  NaverClientId);
		sb.append("&client_secret=" + NaverClientSecret);
		sb.append("&access_token=" + newAccessToken);
		String parameterStr = sb.toString();
		
		bufferedWriter.write(parameterStr);
		bufferedWriter.flush();

		Map<String, Object> eleMap = getResponse(conn);
		JsonElement element = (JsonElement)eleMap.get("element");

		newAccessToken = element.getAsJsonObject().get("access_token").getAsString();
		String newRefreshToken = element.getAsJsonObject().get("refresh_token").getAsString();

		bufferedWriter.close();

		resultMap.put("accessToken", newAccessToken);
		resultMap.put("refreshToken", newRefreshToken);
		resultMap.put("tokenType", "N");

		return resultMap;
	}
	

	/**
	 * 토큰 유효성 검사 (사용하는 곳이 없음)
	 * @param keyMap(accessToken, refreshToken)
	 * @return resultMap
	 * @throws Exception
	 */
//	public Map<String, Object> tokenCheck(Map<String, Object> keyMap) throws Exception {
//		Map<String, Object> resultMap = new HashMap<String, Object>();
//		boolean result = false;
//
//		String accessToken = (String)keyMap.get("accessToken");
//		String header = "Bearer " + accessToken;
//
//		try {
//			HttpURLConnection con = this.getHeader(NaverTokenUrl, header);
//			this.getResponse(con, keyMap);
//			result = true;
//		}catch(Exception e) {
//			e.printStackTrace();
//			log.debug("실패");
//		}
//
//		resultMap.put("result", result);
//		return resultMap;
//	}

	/**
	 * 헤더 세팅
	 * @param apiUrl , header
	 * @return HttpURLConnection
	 * @throws Exception
	 */
	private HttpURLConnection getHeader(String apiUrl, String header) throws Exception{

		URL url = new URL(apiUrl);
		HttpURLConnection con = (HttpURLConnection) url.openConnection();
		con.setRequestMethod("POST");
		con.setDoOutput(true);

		if(EgovStringUtil.isNotEmpty(header)) {
			con.setRequestProperty("Authorization", header);
		}

		return con;
	}

	/**
	 * 응답 값
	 * @param con
	 * @return JsonElement
	 * @throws Exception
	 */
	private Map<String, Object> getResponse(HttpURLConnection con) throws Exception{
		BufferedReader bufferedReader = new BufferedReader(new InputStreamReader(con.getInputStream(), "UTF-8"));
		StringBuilder result = new StringBuilder();
		Map<String, Object> resultMap = new HashMap<String, Object>();

		int responseCode = con.getResponseCode();
		//System.out.println("responseCode : " + responseCode);

		if(responseCode == HttpURLConnection.HTTP_OK) {

			String line = "";
			while ((line = bufferedReader.readLine()) != null) {
				result.append(line);
			}
			//System.out.println("response body : " + result);
		}
		
		JsonElement element = JsonParser.parseString(result.toString());

		bufferedReader.close();
		resultMap.put("element", element);
		return resultMap;
	}

	/**
	 * 사용자 정보 조회
	 * @param keyMap(accessToken, refreshToken)
	 * @return mbrVO
	 * @see 성별, 이메일, 휴대폰번호, 이름(유니코드), 생일(년, 월일)
	 * @throws Exception
	 */
	public MbrVO getNaverUserInfo(String accessToken, String refreshToken) throws Exception {
		String header = "Bearer " + accessToken; // Bearer 다음 공백 주의

		HttpURLConnection con = this.getHeader(NaverProflUrl, header);
		Map<String, Object> eleMap = this.getResponse(con);

		MbrVO naverUserInfo = setProflVO(eleMap);
		naverUserInfo.setAccessToken(accessToken);
		naverUserInfo.setRefreshToken(refreshToken);
		return naverUserInfo;
	}

	/**
	 * 회원 정보
	 * @param eleMap(element, refreshToken)
	 * @return mbrVO
	 * @throws Exception
	 */
	private MbrVO setProflVO (Map<String, Object> eleMap) throws Exception {
		MbrVO proflVO = new MbrVO();

		JsonElement element = (JsonElement) eleMap.get("element");
        String resultCode = element.getAsJsonObject().get("resultcode").getAsString();
        if(resultCode.equals("00")) {
        	JsonElement mbrElement = element.getAsJsonObject().get("response");
        	JsonElement mbrInfo = JsonParser.parseString(mbrElement.toString());

        	String appId = mbrInfo.getAsJsonObject().get("id").getAsString();
        	String gender = mbrInfo.getAsJsonObject().get("gender").getAsString();

            String email = mbrInfo.getAsJsonObject().get("email").getAsString();
            String phone = mbrInfo.getAsJsonObject().get("mobile").getAsString();
            String name = mbrInfo.getAsJsonObject().get("name").getAsString();
            String birthDay = mbrInfo.getAsJsonObject().get("birthday").getAsString();
            String birthYear = mbrInfo.getAsJsonObject().get("birthyear").getAsString();
            String ci = mbrInfo.getAsJsonObject().get("ci").getAsString();

            //System.out.println(birthDay);
            //System.out.println(birthYear);

            SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
            Date birth = formatter.parse(birthYear+ "-" + birthDay);

            if(gender.equals("F")) {
            	gender = "W";
            }
            proflVO.setGender(gender);
            proflVO.setEml(email);
            proflVO.setMblTelno(phone);
            proflVO.setMbrNm(UnicodeUtil.codeToString(name));
            proflVO.setBrdt(birth);
            proflVO.setJoinTy("N");
            proflVO.setNaverAppId(appId);
            proflVO.setMbrId(appId+"@N");
            proflVO.setCiKey(ci);

            System.out.println(proflVO.toString());

        }else {
        	log.debug("네이버 간편 로그인 사용자 정보 조회 실패");
        }

		return proflVO;
	}

}
