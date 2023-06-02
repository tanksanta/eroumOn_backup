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
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;

import com.google.gson.JsonElement;
import com.google.gson.JsonParser;

import icube.common.framework.abst.CommonAbstractServiceImpl;
import icube.common.util.UnicodeUtil;
import icube.manage.mbr.mbr.biz.MbrService;
import icube.manage.mbr.mbr.biz.MbrVO;
import icube.market.mbr.biz.MbrSession;


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

	@Value("#{props['Naver.Dlvy.Url']}")
	private String NaverDlvyUrl;

	@Value("#{props['Naver.Token.Check']}")
	private String NaverTokenCheck;

	@Autowired
	private MbrSession mbrSession;

	public boolean mbrAction(Map<String, Object> paramMap) throws Exception {
		boolean result = false;

		Map<String, Object> keyMap = this.getToken(paramMap);
		Map<String, Object> resultMap = this.tokenCheck(keyMap);

		if(EgovStringUtil.isNotEmpty((String)resultMap.get("accessToken"))) {
			keyMap.put("accessToken", (String)resultMap.get("accessToken"));
		}

		paramMap.clear();
		paramMap.put("srchNaverToken", (String)keyMap.get("refreshToken"));
		MbrVO mbrVO = mbrService.selectMbr(paramMap);

		if(mbrVO != null) {
			mbrSession.setParms(mbrVO, true);
			result = true;
		}else {
			MbrVO proflInfo = this.getMbrProfl(keyMap);

			// 배송 정보 조회
			// DlvyVO dlvyInfo = this.getMbrDlvy(keyMap);

			mbrService.insertMbr(proflInfo);
			mbrSession.setParms(proflInfo, true);
		}
		//TODO 요양정보 SET
		//TODO 주소 처리 -> planner 리스트 로딩
		return result;
	}

	/**
	 * 토큰 발급
	 * @param paramMap(code, state)
	 * @return keyMap(accessToken, refreshToken, tokenType)
	 * @throws Exception
	 */
	public Map<String, Object> getToken(Map<String, Object> paramMap) throws Exception {

		Map<String, Object> resultMap = new HashMap<String, Object>();

		try {
			String accessToken = "";
			String refreshToken = "";

			HttpURLConnection conn = this.getHeader(NaverTokenUrl, null);

			BufferedWriter bufferedWriter = new BufferedWriter(new OutputStreamWriter(conn.getOutputStream()));
			paramMap.put("type", "getToken");
			StringBuffer sb = this.setStr(paramMap);
			bufferedWriter.write(sb.toString());
			bufferedWriter.flush();

			Map<String, Object> eleMap = this.getResponse(conn, paramMap);
			JsonElement element = (JsonElement)eleMap.get("element");

			accessToken = element.getAsJsonObject().get("access_token").getAsString();
			refreshToken = element.getAsJsonObject().get("refresh_token").getAsString();

			bufferedWriter.close();

			resultMap.put("accessToken", accessToken);
			resultMap.put("refreshToken", refreshToken);
			resultMap.put("tokenType", "N");

		}catch(Exception e) {
			e.printStackTrace();
			log.debug("네이버 토큰 발급 실패 : " + e.getMessage());
		}

		return resultMap;
	}

	/**
	 * 토큰 유효성 검사
	 * @param keyMap(accessToken, refreshToken)
	 * @return resultMap
	 * @throws Exception
	 */
	public Map<String, Object> tokenCheck(Map<String, Object> keyMap) throws Exception {
		Map<String, Object> resultMap = new HashMap<String, Object>();
		boolean result = false;

		String accessToken = (String)keyMap.get("accessToken");
		String header = "Bearer " + accessToken;

		try {
			HttpURLConnection con = this.getHeader(NaverTokenCheck, header);
			this.getResponse(con, keyMap);
			result = true;
		}catch(Exception e) {
			e.printStackTrace();
			log.debug("실패");
		}

		resultMap.put("result", result);
		return resultMap;
	}

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
	 * 파라미터 세팅
	 * @param paramMap(type, code, state)
	 * @return StringBuffer setStr
	 * @throws Exception
	 */
	private StringBuffer setStr (Map<String, Object> paramMap) throws Exception {
		String type = (String) paramMap.get("type");
		String code = (String) paramMap.get("code");
		String state = (String) paramMap.get("state");
		String refreshToken = (String) paramMap.get("refreshToken");

		StringBuffer sb = new StringBuffer();

		switch(type) {
		case"getToken":
			sb.append("grant_type=authorization_code");
			sb.append("&client_id=" + NaverClientId);
			sb.append("&client_secret=" + NaverClientSecret);
			sb.append("&redirect_uri=" + NaverRedirectUrl);
			sb.append("&code=" + code);
			sb.append("&state=" + state);

			break;
		case"check":
			sb.append(NaverTokenUrl + "grant_type=refresh_token");
			sb.append("&client_id=" +  NaverClientId);
			sb.append("&client_secret=" + NaverClientSecret);
			sb.append("&refresh_token=" + refreshToken);
			break;
		default:
			break;
		}

		return sb;
	}

	/**
	 * 응답 값
	 * @param con
	 * @return JsonElement
	 * @throws Exception
	 */
	private Map<String, Object> getResponse(HttpURLConnection con, Map<String, Object> keyMap) throws Exception{
		BufferedReader bufferedReader = new BufferedReader(new InputStreamReader(con.getInputStream()));
		StringBuilder result = new StringBuilder();
		Map<String, Object> resultMap = new HashMap<String, Object>();

		int responseCode = con.getResponseCode();
		System.out.println("responseCode : " + responseCode);

		if(responseCode == HttpURLConnection.HTTP_OK) {

			String line = "";
			while ((line = bufferedReader.readLine()) != null) {
				result.append(line);
			}
			System.out.println("response body : " + result);

		}else {
			Map<String, Object> paramMap = new HashMap<String, Object>();
			paramMap.put("type", "check");
			paramMap.put("refreshToken", (String)keyMap.get("refreshToken"));
			StringBuffer sb = this.setStr(paramMap);

			String header = "Bearer " + (String) keyMap.get("accessToken");
			con = this.getHeader(sb.toString(), header);
			Map<String, Object> eleMap = this.getResponse(con, keyMap);
			JsonElement element = (JsonElement) eleMap.get("element");

			String accessToken = element.getAsJsonObject().get("access_token").getAsString();
			resultMap.put("accessToken", accessToken);
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
	public MbrVO getMbrProfl(Map<String, Object> keyMap) throws Exception {
		MbrVO proflVO = new MbrVO();

		String accessToken = (String) keyMap.get("accessToken");
		String refreshToken = (String) keyMap.get("refreshToken");
		String header = "Bearer " + accessToken; // Bearer 다음 공백 주의

		HttpURLConnection con = this.getHeader(NaverProflUrl, header);

		keyMap.put("getProfl", true);
		Map<String, Object> eleMap = this.getResponse(con, keyMap);
		eleMap.put("refreshToken", refreshToken);

		proflVO = this.setProflVO(eleMap);

		return proflVO;
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

        	String gender = mbrInfo.getAsJsonObject().get("gender").getAsString();

            String email = mbrInfo.getAsJsonObject().get("email").getAsString();
            String phone = mbrInfo.getAsJsonObject().get("mobile").getAsString();
            String name = mbrInfo.getAsJsonObject().get("name").getAsString();
            String birthDay = mbrInfo.getAsJsonObject().get("birthday").getAsString();
            String birthYear = mbrInfo.getAsJsonObject().get("birthyear").getAsString();

            System.out.println(birthDay);
            System.out.println(birthYear);

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
            proflVO.setNaverToken((String)eleMap.get("refreshToken"));
            proflVO.setMbrId(email);

            System.out.println(proflVO.toString());

        }else {
        	log.debug("네이버 간편 로그인 사용자 정보 조회 실패");
        }

		return proflVO;
	}
}
