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
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.egovframe.rte.fdl.string.EgovStringUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;

import com.google.gson.JsonArray;
import com.google.gson.JsonElement;
import com.google.gson.JsonObject;
import com.google.gson.JsonParser;

import icube.common.framework.abst.CommonAbstractServiceImpl;
import icube.manage.mbr.mbr.biz.MbrService;
import icube.manage.mbr.mbr.biz.MbrVO;
import icube.market.mbr.biz.MbrSession;
import icube.market.mypage.info.biz.DlvyService;
import icube.market.mypage.info.biz.DlvyVO;


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

	@Autowired
	private MbrSession mbrSession;
	
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
	
	
	/**
	 * 인가 코드 발급
	 * @return authUrl
	 * @throws Exception
	 */
	public String getKakaoUrl() throws Exception {

		StringBuffer sb = new StringBuffer();
		sb.append("https://kauth.kakao.com/oauth/authorize?client_id=" + kakaoApiKey);
		sb.append("&redirect_uri=" + redirectUrl);
		sb.append("&response_type=code");

		return sb.toString();
	}

	/**
	 * 카카오 로그인
	 * @param code
	 * @return result
	 * @throws Exception
	 */
	public Map<String, Object> mbrAction(String code) throws Exception {
		int result = 0;

		result = getToken(code);

		Map<String, Object> resultMap = new HashMap<String, Object>();
		resultMap.put("result", result);
		return resultMap;
	}

	/**
	 * 토큰 발급
	 * @param code
	 * @return result
	 * @throws Exception
	 */
	public Integer getToken(String code) throws Exception {
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
			return getUserInfo(resultMap);
	}

	/**
	 * 사용자 정보 조회
	 * @param keyMap
	 * @return result
	 * @throws Exception
	 */
	public Integer getUserInfo(Map<String, Object> keyMap) throws Exception {

		String accessToken = (String) keyMap.get("accessToken");

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
        
        return setUserInfo(element);
	}

	/**
	 * 사용자 정보 SET
	 * @param element
	 * @return result
	 * @throws Exception
	 */
	private Integer setUserInfo(JsonElement element) throws Exception {
		MbrVO mbrVO = new MbrVO();
		mbrVO.setKakaoAccessToken(element.getAsJsonObject().get("accessToken").getAsString());

		JsonElement info = element.getAsJsonObject().get("kakao_account");
		
		log.debug("@@@@@@@@ : " + info.toString());

		boolean genderFlag = info.getAsJsonObject().get("has_gender").getAsBoolean();
		boolean emailFlag = info.getAsJsonObject().get("has_email").getAsBoolean();
		boolean birthDayFlag = info.getAsJsonObject().get("has_birthday").getAsBoolean();
		boolean birthYearFlag = info.getAsJsonObject().get("has_birthyear").getAsBoolean();
		boolean mblTelnoFlag = info.getAsJsonObject().get("has_phone_number").getAsBoolean();


		if(genderFlag) {
			String codeGender = "M";
			String enGender = info.getAsJsonObject().get("gender").getAsString();
			if(enGender.equals("female")) {
				codeGender = "W";
			}
			mbrVO.setGender(codeGender);
		}

		if(mblTelnoFlag) {
			String mblTelno = info.getAsJsonObject().get("phone_number").getAsString();
			mbrVO.setMblTelno(mblTelno.replace("+82 10", "010"));
		}

		if(emailFlag) {
			String email = info.getAsJsonObject().get("email").getAsString();
			mbrVO.setEml(email);
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
			mbrVO.setBrdt(birthDate);
		}
		
		String name = info.getAsJsonObject().get("name").getAsString();
		if(EgovStringUtil.isNotEmpty(name)) {
			mbrVO.setMbrNm(name);
		}
		
		// 기존 회원가입 여부
		Map<String, Object> paramMap = new HashMap<String, Object>();
		paramMap.put("srchMblTelno", mbrVO.getMblTelno());
		paramMap.put("srchBirth", formatter.format(mbrVO.getBrdt()));
		paramMap.put("srchMbrStts", "NORMAL");
		List<MbrVO> mbrList = mbrService.selectMbrListAll(paramMap);
		
		if(mbrList.size() > 0) {
			if(mbrList.size() > 1) {
				return 5; // 가입정보 2개 이상
			}else {
				if(EgovStringUtil.equals(mbrList.get(0).getJoinTy(), "K")) {
					int mbrTy = 0;
					
					if(mbrList.get(0).getMberSttus() != null) {
						String sttus = mbrList.get(0).getMberSttus();
						String mbrId = mbrList.get(0).getMbrId();
						
						Map<String, Object> drmtMap = new HashMap<String, Object>();
						drmtMap.put("srchKakaoAppId", mbrVO.getKakaoAppId());
						drmtMap.put("srchMbrStts", "EXIT");
						drmtMap.put("srchWhdwlDt", 7);
						int drmtCnt = mbrService.selectMbrCount(paramMap);
						
						if(EgovStringUtil.equals("BLACK", sttus)) {
							mbrTy = 8; // 블랙
						}else if(EgovStringUtil.equals("HUMAN", sttus)) {
							mbrSession.setMbrId(mbrId);
							mbrTy = 9; // 휴면
						}else if(EgovStringUtil.equals("EXIT", sttus) && drmtCnt > 0) {
							mbrTy = 10; // 탈퇴
						}else {
							mbrVO.setUniqueId(mbrList.get(0).getUniqueId());
							
							if(EgovStringUtil.isNotEmpty(mbrVO.getEml()) && EgovStringUtil.isNotEmpty(mbrVO.getMblTelno())) {
								mbrService.updateKaKaoInfo(mbrVO);
							}
							
							mbrSession.setParms(mbrList.get(0), true);
							
							if(EgovStringUtil.equals(mbrList.get(0).getRecipterYn(), "Y")) {
								mbrSession.setRecipterInfo(mbrList.get(0).getRecipterInfo());
							}
							mbrTy = 2;
						}
						
					}
					return mbrTy; // 카카오 로그인
					
				}else if(EgovStringUtil.equals(mbrList.get(0).getJoinTy(), "N")){
					return 3; // 네이버 회원가입
				}else {
					return 4; // 이로움 회원가입
				}
			}
		}else {
			String appId = element.getAsJsonObject().get("id").getAsString();
			mbrVO.setMbrId(appId+"@K");
			mbrVO.setJoinTy("K");
			mbrVO.setKakaoAppId(appId);
			
			return setUserDlvy(mbrVO);
		}
	
	}

	/**
	 * 사용자 배송지 정보 SET
	 * @param mbrVO
	 * @return result
	 * @throws Exception
	 */
	private Integer setUserDlvy(MbrVO mbrVO) throws Exception  {

		//1. 엑세스 토큰을 이용한 발급
		//2. 주소 정보 SET
		//3. 배송지 정보 SET
		//4. 생일, 전화번호로 회원 판별
		int resultCnt = 0;
		
		try {
			
			URL url = new URL(dlvyUrl);
	        HttpURLConnection conn = (HttpURLConnection) url.openConnection();
	        conn.setRequestMethod("GET");
	        conn.setDoOutput(true);
	        conn.setRequestProperty("Authorization", "Bearer " + mbrVO.getKakaoAccessToken());

	        BufferedReader br = new BufferedReader(new InputStreamReader(conn.getInputStream(), "UTF-8"));
	        String line = "";
	        StringBuilder result = new StringBuilder();

	        while ((line = br.readLine()) != null) {
	            result.append(line);
	        }
	        JsonElement element = JsonParser.parseString(result.toString());

	        JsonElement dlvyInfo = element.getAsJsonObject().get("shipping_addresses");
	        
	        if(EgovStringUtil.isEmpty(dlvyInfo.toString())) {
	        	
	        	insertUserInfo(mbrVO);
	        	
	        	resultCnt = 6;
	        }else {
	        	 JsonArray addresses = dlvyInfo.getAsJsonArray();
	        	 DlvyVO dlvyVO = new DlvyVO();
	        	 
	 	        for(JsonElement address : addresses) {
	 	        	
	 	        	boolean defaultYn = address.getAsJsonObject().get("default").getAsBoolean();

	 	        	String zip = address.getAsJsonObject().get("zone_number").getAsString();
	 	        	String addr = address.getAsJsonObject().get("base_address").getAsString();
	 	        	String daddr = address.getAsJsonObject().get("detail_address").getAsString();

	 	        	String dlvyNm = address.getAsJsonObject().get("name").getAsString();
	 	        	String nm = address.getAsJsonObject().get("receiver_name").getAsString();

	 	        	log.debug(defaultYn);
	 	        	log.debug(zip);
	 	        	log.debug(addr);
	 	        	log.debug(daddr);
	 	        	log.debug(dlvyNm);
	 	        	log.debug(nm);

	 	        	if(defaultYn) {
	 	        		mbrVO.setZip(zip);
	 	            	mbrVO.setAddr(addr);
	 	            	mbrVO.setDaddr(daddr);
	 	        		dlvyVO.setBassDlvyYn("Y");
	 	        		dlvyVO.setDlvyNm(dlvyNm);
		 	        	dlvyVO.setNm(nm);
		 	        	dlvyVO.setZip(zip);
		 	        	dlvyVO.setAddr(daddr);
		 	        	dlvyVO.setDaddr(daddr);
	 	        	}

	 	        }
	 	        
				mbrVO.setDlvyInfo(dlvyVO);
 				insertUserInfo(mbrVO);
 				
	 	        resultCnt = 7;
	        }

		}catch(Exception e) {
			e.printStackTrace();
			log.debug(e.getMessage());
		}
		return resultCnt;
	}

	/**
	 * 사용자 정보 INSERT
	 * @param mbrVO
	 * @return result
	 * @throws Exception
	 */
	private void insertUserInfo(MbrVO mbrVO) throws Exception {

     	mbrService.insertMbr(mbrVO);

     	DlvyVO dlvyVO = mbrVO.getDlvyInfo();
     	dlvyVO.setUniqueId(mbrVO.getUniqueId());
		dlvyService.insertBassDlvy(dlvyVO);
     	
        mbrSession.setParms(mbrVO, true);
	}

}
