package icube.common.api.biz;

import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.security.InvalidAlgorithmParameterException;
import java.security.InvalidKeyException;
import java.security.KeyFactory;
import java.security.NoSuchAlgorithmException;
import java.security.PublicKey;
import java.security.interfaces.RSAPublicKey;
import java.security.spec.InvalidKeySpecException;
import java.security.spec.X509EncodedKeySpec;
import java.util.ArrayList;
import java.util.Base64;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Random;
import java.util.concurrent.TimeUnit;

import javax.crypto.BadPaddingException;
import javax.crypto.Cipher;
import javax.crypto.IllegalBlockSizeException;
import javax.crypto.NoSuchPaddingException;
import javax.crypto.spec.IvParameterSpec;
import javax.crypto.spec.SecretKeySpec;

import org.egovframe.rte.fdl.string.EgovDateUtil;
import org.egovframe.rte.fdl.string.EgovStringUtil;
import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.json.simple.parser.ParseException;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;

import icube.common.util.DateUtil;
import icube.common.util.JsonUtil;
import icube.common.values.CodeMap;
import okhttp3.MediaType;
import okhttp3.OkHttpClient;
import okhttp3.Request;
import okhttp3.RequestBody;
import okhttp3.Response;

/**
 * 틸코블렛 API
 */
@Service("tilkoApiService")
public class TilkoApiService {

	@Value("#{props['Tilko.Cert.Dir']}")
	private String tilkoCertDir;

	@Value("#{props['Tilko.Cert.Password']}")
	private String tilkoCertPassword;

	@Value("#{props['Tilko.Api.Host']}")
	private String apiHost;

	@Value("#{props['Tilko.Api.Key']}")
	private String apiKey;

	@Value("#{props['Tilko.BusinessNumber']}")
	private String businessNumber;

	private String url_recipientContractDetail  = "api/v1.0/Longtermcare/NPIA201M01"; // 복지용구 대상자 조회
	private String url_recipientToolList 		  =  "api/v1.0/Longtermcare/NPIA201P01"; // 복지용구 급여 가능/불가능 품목 조회
	private String url_recipientContractHistory	  = "api/v1.0/Longtermcare/NPIA208P01"; // 복지용구 적용기간별 계약내역 조회

	@SuppressWarnings("unchecked")
	public Map<String, Object> getRecipterInfo(String name, String identityNumber) throws Exception {

		// RSA Public Key 조회
		String rsaPublicKey		= getPublicKey();
		//System.out.println("rsaPublicKey: " + rsaPublicKey);


		// AES Secret Key 및 IV 생성
		byte[] aesKey = new byte[16];
		new Random().nextBytes(aesKey);

		byte[] aesIv = new byte[] { 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00 };


		// AES Key를 RSA Public Key로 암호화
		String aesCipherKey	= rsaEncrypt(rsaPublicKey, aesKey);
		//System.out.println("aesCipherKey: " + aesCipherKey);

		// API URL 설정
		String url = apiHost + url_recipientContractDetail;

		// 인증서 경로 설정
		String certPath  = tilkoCertDir;
		String certFile  = certPath + "signCert.der";
		String keyFile   = certPath + "signPri.key";
		String CertPassword = tilkoCertPassword;

		// API 요청 파라미터 설정
		JSONObject json = new JSONObject();
		json.put("CertFile", aesEncrypt(aesKey, aesIv, Files.readAllBytes(Paths.get(certFile))));
		json.put("KeyFile", aesEncrypt(aesKey, aesIv, Files.readAllBytes(Paths.get(keyFile))));
		json.put("CertPassword", aesEncrypt(aesKey, aesIv, CertPassword));
		json.put("BusinessNumber", aesEncrypt(aesKey, aesIv, businessNumber));
		json.put("Name", aesEncrypt(aesKey, aesIv, name));
		json.put("IdentityNumber", aesEncrypt(aesKey, aesIv, identityNumber));


		// API 호출
		OkHttpClient client	= new OkHttpClient.Builder()
				.connectTimeout(30, TimeUnit.SECONDS)
				.readTimeout(30, TimeUnit.SECONDS)
				.writeTimeout(30, TimeUnit.SECONDS)
				.build();

		Request request	= new Request.Builder()
				.url(url)
				.addHeader("API-KEY", apiKey)
				.addHeader("ENC-KEY", aesCipherKey)
				.post(RequestBody.create(MediaType.get("application/json; charset=utf-8"), json.toJSONString())).build();

		boolean result = false;
		Map<String, Object> returnMap = new HashMap<String, Object>();
		Map<String, Object> infoMap = new HashMap<String, Object>();

		Response response = client.newCall(request).execute();
		String responseStr = response.body().string();

        JSONParser jsonParser = new JSONParser();
        Object obj = jsonParser.parse(responseStr);

        JSONObject jsonObject = new JSONObject((Map<String, Object>) obj);

        System.out.println(jsonObject);
        
        String Status = (String) jsonObject.get("Status");


        if(EgovStringUtil.equals("OK", Status)) { // 정상

	        JSONObject resultData = (JSONObject) jsonObject.get("Result");

	        JSONArray welToolTgtList = (JSONArray) resultData.get("ds_welToolTgtList");
	        JSONArray toolPayLmtList = (JSONArray) resultData.get("ds_toolPayLmtList");
	        JSONArray welToolTgtHistList = (JSONArray) resultData.get("ds_welToolTgtHistList");

	        System.out.println(welToolTgtList); // 인정기간 외
	        System.out.println(toolPayLmtList); // 적용기간 사용금액/제한금액/급여잔액
	        System.out.println("@@ : " + welToolTgtHistList);// 히스토리

	        if(welToolTgtList != null) {
	        	result = true;

		        List<Map<String, Object>> welToolTgtListMap =  JsonUtil.getListMapFromJsonArray(welToolTgtList);
		        for(Map<String, Object> welToolTgt : welToolTgtListMap) {

		        	System.out.println("LTC_MGMT_NO" + welToolTgt.get("LTC_MGMT_NO")); // 요양번호
		        	System.out.println("LTC_RCGT_GRADE_CD" + welToolTgt.get("LTC_RCGT_GRADE_CD")); // 등급
		        	System.out.println("QLF_TYPE" + welToolTgt.get("QLF_TYPE")); //본인부담율
		        	System.out.println("RCGT_EDA_DT" + welToolTgt.get("RCGT_EDA_DT")); // 인정유효기간

		        	System.out.println("REDUCE_NM" + welToolTgt.get("REDUCE_NM")); // 대상자 구분
		        	System.out.println("SBA_CD" + welToolTgt.get("SBA_CD")); // 대상자 구분 경감율


		        	String reduceNm = (String) welToolTgt.get("REDUCE_NM");
		        	String sbaCd = (String) welToolTgt.get("SBA_CD");
		        	int selfBndRt  = 0;

		        	//TO-DO : 본인부담율 계산
		        	//let penPayRate = rep_info['REDUCE_NM'] == '일반' ? '15%': rep_info['REDUCE_NM'] == '기초' ? '0%' : rep_info['REDUCE_NM'] == '의료급여' ? '6%': (rep_info['SBA_CD'].split('(')[1].substr(0, rep_info['SBA_CD'].split('(')[1].length-1));
		        	if( reduceNm.equals("일반") ) {
		        		selfBndRt = 15;
		        	}else if( reduceNm.equals("기초") ) {
		        		selfBndRt = 0;
		        	}else if( reduceNm.equals("의료급여") ) {
		        		selfBndRt = 6;
		        	}else {
		        		selfBndRt = EgovStringUtil.string2integer(sbaCd.split("\\(")[1].substring(0, sbaCd.split("\\(")[1].length()-1).replace("%", "")); // 9% or 6%
		        	}

		        	infoMap.put("LTC_MGMT_NO", welToolTgt.get("LTC_MGMT_NO"));
		        	infoMap.put("LTC_RCGT_GRADE_CD", welToolTgt.get("LTC_RCGT_GRADE_CD"));
		        	infoMap.put("QLF_TYPE", welToolTgt.get("QLF_TYPE"));
		        	infoMap.put("RCGT_EDA_DT", welToolTgt.get("RCGT_EDA_DT"));
		        	infoMap.put("REDUCE_NM", welToolTgt.get("REDUCE_NM"));
		        	infoMap.put("SBA_CD", welToolTgt.get("SBA_CD"));
		        	infoMap.put("SELF_BND_RT", selfBndRt);

		        }

		        List<Map<String, Object>> toolPayLmtListMap =  JsonUtil.getListMapFromJsonArray(toolPayLmtList);
		        for(Map<String, Object> toolPayLmt : toolPayLmtListMap) {

		        	String apdtFrDt = (String) toolPayLmt.get("APDT_FR_DT");
		        	String apdtToDt = (String) toolPayLmt.get("APDT_TO_DT");

		        	String today = DateUtil.getToday("yyyy-MM-dd");
		        	String convertApdtFrDt = DateUtil.convertDate(apdtFrDt, "yyyy-MM-dd");
		        	String convertApdtToDt = DateUtil.convertDate(apdtToDt, "yyyy-MM-dd");

		        	int diffStDt = 0;
		        	int diffEdDt = 0;
		        	try {
						diffStDt = EgovDateUtil.getDayCountWithFormatter(convertApdtFrDt, today, "yyyy-MM-dd");
						diffEdDt = EgovDateUtil.getDayCountWithFormatter(convertApdtToDt, today, "yyyy-MM-dd");

						System.out.println("diffStDt: " + diffStDt);
						System.out.println("diffEdDt: " + diffEdDt);

					} catch (java.text.ParseException e) {
						// TODO Auto-generated catch block
						e.printStackTrace();
					}

		        	if(diffStDt > 0 && diffEdDt < 0) {
			        	System.out.println("APDT_FR_DT" + toolPayLmt.get("APDT_FR_DT")); // 적용기간 시작
			        	System.out.println("APDT_TO_DT" + toolPayLmt.get("APDT_TO_DT")); // 적용기간 종료
			        	System.out.println("REMN_AMT" + toolPayLmt.get("REMN_AMT")); // 급여잔액
			        	System.out.println("USE_AMT" + toolPayLmt.get("USE_AMT")); // 사용금액
			        	System.out.println("LMT_AMT" + toolPayLmt.get("LMT_AMT")); // 제한금액

			        	infoMap.put("APDT_FR_DT", toolPayLmt.get("APDT_FR_DT"));
			        	infoMap.put("APDT_TO_DT", toolPayLmt.get("APDT_TO_DT"));
			        	infoMap.put("REMN_AMT", toolPayLmt.get("REMN_AMT"));
			        	infoMap.put("USE_AMT", toolPayLmt.get("USE_AMT"));
			        	infoMap.put("LMT_AMT", toolPayLmt.get("LMT_AMT"));
		        	}
		        }
		        
		        List<Map<String, Object>> welToolTgtHistListMap =  JsonUtil.getListMapFromJsonArray(welToolTgtHistList);
		        for(Map<String, Object> welTooTgtHistMap : welToolTgtHistListMap) {
		        	infoMap.put("LTC_MGMT_NO_SEQ", welTooTgtHistMap.get("LTC_MGMT_NO_SEQ"));
		        }
	        }
        }
        
        //API 요청 파라미터 설정
	    returnMap.put("result", result);
	    returnMap.put("infoMap", infoMap);
	    
	    // 급여 가능 불가능 품목 리스트
	    String seq = (String) infoMap.get("LTC_MGMT_NO_SEQ");
	    json.put("Col", seq);
	    url = apiHost + url_recipientToolList;
	    
		// 판매/대여 가능 API 호출
		client	= new OkHttpClient.Builder()
				.connectTimeout(30, TimeUnit.SECONDS)
				.readTimeout(30, TimeUnit.SECONDS)
				.writeTimeout(30, TimeUnit.SECONDS)
				.build();

		request	= new Request.Builder()
				.url(url)
				.addHeader("API-KEY", apiKey)
				.addHeader("ENC-KEY", aesCipherKey)
				.post(RequestBody.create(MediaType.get("application/json; charset=utf-8"), json.toJSONString())).build();
		
		response = client.newCall(request).execute();
		responseStr = response.body().string();

        jsonParser = new JSONParser();
        obj = jsonParser.parse(responseStr);

        jsonObject = new JSONObject((Map<String, Object>) obj);

        System.out.println("@@@ re: " + jsonObject);
        
        JSONObject dsPayPsblObj = (JSONObject) jsonObject.get("Result");
        JSONArray ds_payPsbl1 = new JSONArray();
        JSONArray ds_payPsblLnd1 = new JSONArray();
        
        if(dsPayPsblObj != null) {
        	ds_payPsbl1 = (JSONArray) dsPayPsblObj.get("ds_payPsbl1");
            ds_payPsblLnd1 = (JSONArray) dsPayPsblObj.get("ds_payPsblLnd1");
            
            // 판매 급여 품목
            List<Map<String, Object>> ds_payPsbl1Map =  JsonUtil.getListMapFromJsonArray(ds_payPsbl1);
            // 대여 급여 품목
            List<Map<String, Object>> ds_payPsblLnd1Map =  JsonUtil.getListMapFromJsonArray(ds_payPsblLnd1);
            
            List<String> saleList = new ArrayList<String>();
            List<String> lendList = new ArrayList<String>();
            for(Map<String, Object> saleMap : ds_payPsbl1Map) {
            	saleList.add(CodeMap.RECIPTER_ITEM.get((String) saleMap.get("WIM_ITM_CD")));
            }
            for(Map<String, Object>lendMap : ds_payPsblLnd1Map) {
            	lendList.add(CodeMap.RECIPTER_ITEM.get((String) lendMap.get("WIM_ITM_CD")));
            }
            
            infoMap.put("saleList", saleList);
            infoMap.put("lendList", lendList);
        }else {
        	infoMap.put("saleList", null);
            infoMap.put("lendList", null);
        }
        
        
        System.out.println("@@@ infoMap : " + infoMap.toString());
        
        
        // 계약 리스트 API 호출
        url = apiHost + url_recipientContractHistory;
        json.remove("Col");
        json.remove("name");
        json.put("StartDate", infoMap.get("APDT_FR_DT"));
        json.put("EndDate", infoMap.get("APDT_TO_DT"));
        
        
		client	= new OkHttpClient.Builder()
				.connectTimeout(30, TimeUnit.SECONDS)
				.readTimeout(30, TimeUnit.SECONDS)
				.writeTimeout(30, TimeUnit.SECONDS)
				.build();
	
		request	= new Request.Builder()
				.url(url)
				.addHeader("API-KEY", apiKey)
				.addHeader("ENC-KEY", aesCipherKey)
				.post(RequestBody.create(MediaType.get("application/json; charset=utf-8"), json.toJSONString())).build();
		
		response = client.newCall(request).execute();
		responseStr = response.body().string();
	
	     jsonParser = new JSONParser();
	     obj = jsonParser.parse(responseStr);
	
	     jsonObject = new JSONObject((Map<String, Object>) obj);
	     System.out.println("@@@ re23232: " + jsonObject);
	     
	     JSONObject Ds_result = (JSONObject) jsonObject.get("Result");
	     String returnResult = (String) Ds_result.get("ds_result");
	     
	     System.out.println("@@@ : " + returnResult);
	     
	     if(EgovStringUtil.isNotEmpty(returnResult)) {
	    	 List<String> ownSaleList = new ArrayList<String>();
		     List<String> ownLendList = new ArrayList<String>();
		     if(Ds_result != null) {
		    	 JSONArray arr_Ds_result = (JSONArray) jsonObject.get("Result");
		    	 List<Map<String, Object>> Ds_resultMap =  JsonUtil.getListMapFromJsonArray(arr_Ds_result);
			     for(Map<String, Object> dsResult : Ds_resultMap) {
			    	 String itemNm = (String) dsResult.get("PROD_NM");
			    	 String recipterTy = (String) dsResult.get("WLR_MTHD_CD");
			    	 if(recipterTy.equals("판매")) {
			    		 ownSaleList.add(CodeMap.RECIPTER_ITEM.get(itemNm));
			    	 }else {
			    		 ownLendList.add(CodeMap.RECIPTER_ITEM.get(itemNm));
			    	 }
			     }
			     infoMap.put("ownSaleList", ownSaleList);
			     infoMap.put("ownLendList", ownLendList);
		     }
	     }else {
	    	 infoMap.put("ownSaleList", null);
	    	 infoMap.put("ownLendList", null);
	     }
	    
	    return returnMap;
	}



	// AES 암호화 함수
	public String aesEncrypt(byte[] key, byte[] iv, byte[] plainText) throws NoSuchAlgorithmException, NoSuchPaddingException, InvalidKeyException, InvalidAlgorithmParameterException, IllegalBlockSizeException, BadPaddingException {
		Cipher cipher = Cipher.getInstance("AES/CBC/PKCS5Padding");	// JAVA의 PKCS5Padding은 PKCS7Padding과 호환
		SecretKeySpec keySpec = new SecretKeySpec(key, "AES");
		IvParameterSpec ivSpec = new IvParameterSpec(iv);

		cipher.init(Cipher.ENCRYPT_MODE, keySpec, ivSpec);
		byte[] byteEncryptedData = cipher.doFinal(plainText);

		// Base64로 인코딩
		String encryptedData = new String(Base64.getEncoder().encodeToString(byteEncryptedData));
		return encryptedData;
	}


	// AES 암호화 함수
	public String aesEncrypt(byte[] key, byte[] iv, String plainText) throws NoSuchAlgorithmException, NoSuchPaddingException, InvalidKeyException, InvalidAlgorithmParameterException, IllegalBlockSizeException, BadPaddingException, UnsupportedEncodingException {
		Cipher cipher = Cipher.getInstance("AES/CBC/PKCS5Padding");	// JAVA의 PKCS5Padding은 PKCS7Padding과 호환
		SecretKeySpec keySpec = new SecretKeySpec(key, "AES");
		IvParameterSpec ivSpec = new IvParameterSpec(iv);

		cipher.init(Cipher.ENCRYPT_MODE, keySpec, ivSpec);
		byte[] byteEncryptedData = cipher.doFinal(plainText.getBytes("UTF-8"));

		// Base64로 인코딩
		String encryptedData = new String(Base64.getEncoder().encodeToString(byteEncryptedData));
		return encryptedData;
	}


	// RSA 암호화 함수
	public static String rsaEncrypt(String rsaPublicKey, byte[] aesKey) throws NoSuchAlgorithmException, UnsupportedEncodingException, InvalidKeySpecException, NoSuchPaddingException, InvalidKeyException, IllegalBlockSizeException, BadPaddingException {
		String encryptedData				= null;

        KeyFactory keyFactory = KeyFactory.getInstance("RSA");
        byte[] keyBytes = Base64.getDecoder().decode(rsaPublicKey.getBytes("UTF-8"));
        X509EncodedKeySpec spec = new X509EncodedKeySpec(keyBytes);
        PublicKey fileGeneratedPublicKey = keyFactory.generatePublic(spec);
        RSAPublicKey key = (RSAPublicKey)(fileGeneratedPublicKey);

        // 만들어진 공개키객체를 기반으로 암호화모드로 설정하는 과정
		Cipher cipher = Cipher.getInstance("RSA");
		cipher.init(Cipher.ENCRYPT_MODE, key);

		// 평문을 암호화하는 과정
		byte[] byteEncryptedData = cipher.doFinal(aesKey);

		// Base64로 인코딩
		encryptedData = new String(Base64.getEncoder().encodeToString(byteEncryptedData));
		return encryptedData;
	}


	// RSA 공개키(Public Key) 조회 함수
	public String getPublicKey() throws IOException, ParseException {
		OkHttpClient client	= new OkHttpClient();
		Request request	= new Request.Builder()
				.url(apiHost + "/api/Auth/GetPublicKey?APIkey=" + apiKey)
				.header("Content-Type", "application/json").build();

		Response response = client.newCall(request).execute();
		String responseStr = response.body().string();

		JSONParser jsonParser = new JSONParser();
		JSONObject jsonObject = (JSONObject) jsonParser.parse(responseStr);

		String rsaPublicKey = (String) jsonObject.get("PublicKey");
		return rsaPublicKey;
	}




}
