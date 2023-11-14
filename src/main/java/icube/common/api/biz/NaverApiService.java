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
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpSession;

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
import icube.manage.mbr.recipter.biz.RecipterInfoVO;
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

	@Autowired
	private MbrSession mbrSession;

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
	 * 로그인 및 회원가입 처리
	 * @param paramMap
	 * @return result
	 * @throws Exception
	 */
	public Integer mbrAction(Map<String, Object> paramMap, HttpSession session) throws Exception {
		int resultCnt = 0;

		Map<String, Object> keyMap = this.getToken(paramMap);
		MbrVO proflInfo = getMbrProfl(keyMap);

		// 재인증 추가 20230922 START
		String checkId = proflInfo.getMbrId();
		if(mbrSession.isLoginCheck()) {
			String mbrSnsId = mbrSession.getNaverAppId() + "@N";
			log.debug("### 재인증 진행 ###" + mbrSnsId +"//" +checkId);

			if(EgovStringUtil.equals(mbrSnsId, checkId)) {
				return 11;
			}else {
				return 12;
			}
		}
		//재인증 END

		paramMap.clear();
		SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
		paramMap.put("srchMblTelno", proflInfo.getMblTelno());
		paramMap.put("srchMbrStts", "NORMAL");

		List<MbrVO> mbrList = mbrService.selectMbrListAll(paramMap);

		if(mbrList.size() < 1) {
			mbrService.insertMbr(proflInfo);

			mbrSession.setParms(proflInfo, true);

			if(EgovStringUtil.equals(proflInfo.getRecipterYn(), "Y")) {
				mbrSession.setRecipterInfo(proflInfo.getRecipterInfo());
			}else {
				
			}
			mbrSession.setMbrInfo(session, mbrSession);

			resultCnt = 1; // 회원가입
		}else if(mbrList.size() > 1) {
			resultCnt = 5; // 동일 정보 2건 이상
		}else {
			resultCnt = 3; // 로그인

			if(mbrList.get(0).getJoinTy().equals("E")) {
				resultCnt = 4; // 이로움 회원가입
			}else if(mbrList.get(0).getJoinTy().equals("K")) {
				resultCnt = 2; // 카카오 회원 가입
			}else {
				Map<String, Object> drmtMap = new HashMap<String, Object>();
				drmtMap.put("srchNaverAppId", mbrList.get(0).getNaverAppId());
				drmtMap.put("srchMbrStts", "EXIT");
				drmtMap.put("srchWhdwlDt", 7);
				int drmtCnt = mbrService.selectMbrCount(paramMap);

				if(mbrList.get(0).getMberSttus().equals("BLACK")) {
					resultCnt = 8;
				}else if(mbrList.get(0).getMberSttus().equals("HUMAN")) {
					resultCnt = 9;
					mbrSession.setMbrId(mbrList.get(0).getMbrId());
				}else if(mbrList.get(0).getMberSttus().equals("EXIT") && drmtCnt > 0) {
					resultCnt = 10;
				}else {
					// 로그인
					mbrSession.setParms(mbrList.get(0), true);

					if(EgovStringUtil.equals(mbrList.get(0).getRecipterYn(), "Y")) {
						mbrSession.setRecipterInfo(mbrList.get(0).getRecipterInfo());
					}else {
					}
					mbrSession.setMbrInfo(session, mbrSession);

				}
			}
		}
		return resultCnt;
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

			BufferedWriter bufferedWriter = new BufferedWriter(new OutputStreamWriter(conn.getOutputStream(), "UTF-8"));
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
			HttpURLConnection con = this.getHeader(NaverTokenUrl, header);
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
		if(EgovStringUtil.isEmpty(state)) {
			state = null;
		}
		String refreshToken = (String) paramMap.get("refreshToken");

		StringBuffer sb = new StringBuffer();

		switch(type) {
		case"getToken":
			sb.append("grant_type=authorization_code");
			sb.append("&client_id=" + NaverClientId);
			sb.append("&client_secret=" + URLEncoder.encode(NaverClientSecret, "UTF-8"));
			sb.append("&redirect_uri=" + URLEncoder.encode(NaverRedirectUrl, "UTF-8"));
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

        	String appId = mbrInfo.getAsJsonObject().get("id").getAsString();
        	String gender = mbrInfo.getAsJsonObject().get("gender").getAsString();

            String email = mbrInfo.getAsJsonObject().get("email").getAsString();
            String phone = mbrInfo.getAsJsonObject().get("mobile").getAsString();
            String name = mbrInfo.getAsJsonObject().get("name").getAsString();
            String birthDay = mbrInfo.getAsJsonObject().get("birthday").getAsString();
            String birthYear = mbrInfo.getAsJsonObject().get("birthyear").getAsString();

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

            System.out.println(proflVO.toString());

        }else {
        	log.debug("네이버 간편 로그인 사용자 정보 조회 실패");
        }

		return proflVO;
	}

}
