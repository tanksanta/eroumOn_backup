package icube;

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
import java.util.Base64;
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
import org.springframework.jmx.export.metadata.JmxMetadataUtils;

import icube.common.util.DateUtil;
import icube.common.util.JsonUtil;
import okhttp3.MediaType;
import okhttp3.OkHttpClient;
import okhttp3.Request;
import okhttp3.RequestBody;
import okhttp3.Response;

public class TilkoTest {



	static String apiHost   = "https://api.tilko.net/";
	static String apiKey = "a55aaf2f84a0477da82bb4572f97babf";
	static String BusinessNumber = "32623000271";

	String url_recipientContractDetail  = apiHost + "api/v1.0/Longtermcare/NPIA201M01"; // 복지용구 대상자 조회
	String url_recipientToolList 		  = apiHost + "api/v1.0/Longtermcare/NPIA201P01"; // 복지용구 급여 가능/불가능 품목 조회
	String url_recipientContractHistory	  = apiHost + "api/v1.0/Longtermcare/NPIA208P01"; // 복지용구 적용기간별 계약내역 조회



	// 조회

	// AES 암호화 함수
	public String aesEncrypt(byte[] key, byte[] iv, byte[] plainText) throws NoSuchAlgorithmException, NoSuchPaddingException, InvalidKeyException, InvalidAlgorithmParameterException, IllegalBlockSizeException, BadPaddingException {
		Cipher cipher						= Cipher.getInstance("AES/CBC/PKCS5Padding");	// JAVA의 PKCS5Padding은 PKCS7Padding과 호환
		SecretKeySpec keySpec				= new SecretKeySpec(key, "AES");
		IvParameterSpec ivSpec				= new IvParameterSpec(iv);

		cipher.init(Cipher.ENCRYPT_MODE, keySpec, ivSpec);
		byte[] byteEncryptedData			= cipher.doFinal(plainText);

		// Base64로 인코딩
		String encryptedData				= new String(Base64.getEncoder().encodeToString(byteEncryptedData));

		return encryptedData;
	}


	// AES 암호화 함수
	public String aesEncrypt(byte[] key, byte[] iv, String plainText) throws NoSuchAlgorithmException, NoSuchPaddingException, InvalidKeyException, InvalidAlgorithmParameterException, IllegalBlockSizeException, BadPaddingException, UnsupportedEncodingException {
		Cipher cipher						= Cipher.getInstance("AES/CBC/PKCS5Padding");	// JAVA의 PKCS5Padding은 PKCS7Padding과 호환
		SecretKeySpec keySpec				= new SecretKeySpec(key, "AES");
		IvParameterSpec ivSpec				= new IvParameterSpec(iv);

		cipher.init(Cipher.ENCRYPT_MODE, keySpec, ivSpec);
		byte[] byteEncryptedData			= cipher.doFinal(plainText.getBytes("UTF-8"));

		// Base64로 인코딩
		String encryptedData				= new String(Base64.getEncoder().encodeToString(byteEncryptedData));

		return encryptedData;
	}


	// RSA 암호화 함수
	public static String rsaEncrypt(String rsaPublicKey, byte[] aesKey) throws NoSuchAlgorithmException, UnsupportedEncodingException, InvalidKeySpecException, NoSuchPaddingException, InvalidKeyException, IllegalBlockSizeException, BadPaddingException {
		String encryptedData				= null;

        KeyFactory keyFactory				= KeyFactory.getInstance("RSA");
        byte[] keyBytes						= Base64.getDecoder().decode(rsaPublicKey.getBytes("UTF-8"));
        X509EncodedKeySpec spec				= new X509EncodedKeySpec(keyBytes);
        PublicKey fileGeneratedPublicKey	= keyFactory.generatePublic(spec);
        RSAPublicKey key					= (RSAPublicKey)(fileGeneratedPublicKey);

        // 만들어진 공개키객체를 기반으로 암호화모드로 설정하는 과정
		Cipher cipher						= Cipher.getInstance("RSA");
		cipher.init(Cipher.ENCRYPT_MODE, key);

		// 평문을 암호화하는 과정
		byte[] byteEncryptedData			= cipher.doFinal(aesKey);

		// Base64로 인코딩
		encryptedData						= new String(Base64.getEncoder().encodeToString(byteEncryptedData));

		return encryptedData;
	}


	// RSA 공개키(Public Key) 조회 함수
	public String getPublicKey() throws IOException, ParseException {
		OkHttpClient client		= new OkHttpClient();

		Request request			= new Request.Builder()
									.url(apiHost + "/api/Auth/GetPublicKey?APIkey=" + apiKey)
									.header("Content-Type", "application/json").build();

		Response response		= client.newCall(request).execute();
		String responseStr		= response.body().string();

		JSONParser jsonParser	= new JSONParser();
		JSONObject jsonObject	= (JSONObject) jsonParser.parse(responseStr);

		String rsaPublicKey		= (String) jsonObject.get("PublicKey");

		return rsaPublicKey;
	}


	public static void main(String[] args) throws IOException, ParseException, NoSuchAlgorithmException, InvalidKeySpecException, NoSuchPaddingException, InvalidKeyException, IllegalBlockSizeException, BadPaddingException, InvalidAlgorithmParameterException {
		TilkoTest tc			= new TilkoTest();

		// RSA Public Key 조회
		String rsaPublicKey		= tc.getPublicKey();
		System.out.println("rsaPublicKey: " + rsaPublicKey);


		// AES Secret Key 및 IV 생성
		byte[] aesKey			= new byte[16];
		new Random().nextBytes(aesKey);

		byte[] aesIv = new byte[] { 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00 };


		// AES Key를 RSA Public Key로 암호화
		String aesCipherKey	= rsaEncrypt(rsaPublicKey, aesKey);
		System.out.println("aesCipherKey: " + aesCipherKey);


		// API URL 설정(정부24 주민등록진위여부 조회: https://tilko.net/Help/Api/POST-api-apiVersion-Gov-AA090UserJuminCheckResApp)
		String url = tc.apiHost + "api/v1.0/Longtermcare/NPIA201M01"; //= tc.apiHost + "api/v1.0/Gov/AA090UserJuminCheckResApp";


		// 인증서 경로 설정
		String certPath  = "C:\\ATTACH_FILES\\eroum\\";
		String certFile  = certPath + "signCert.der";
		String keyFile   = certPath + "signPri.key";

		String CertPassword = "thkc##1301493";


		//$id = '권숙자';
		//$rn = '2007175271';

		//'이간난'
		//'1612104758'

		// API 요청 파라미터 설정
		JSONObject json			= new JSONObject();
		json.put("CertFile"				, tc.aesEncrypt(aesKey, aesIv, Files.readAllBytes(Paths.get(certFile))));
		json.put("KeyFile"				, tc.aesEncrypt(aesKey, aesIv, Files.readAllBytes(Paths.get(keyFile))));
		json.put("CertPassword"			, tc.aesEncrypt(aesKey, aesIv, CertPassword));
		json.put("BusinessNumber"		, tc.aesEncrypt(aesKey, aesIv, BusinessNumber));
		json.put("Name"					, tc.aesEncrypt(aesKey, aesIv, "권숙자"));
		json.put("IdentityNumber"		, tc.aesEncrypt(aesKey, aesIv, "2007175271")); //L2007175271


		// API 호출
		OkHttpClient client		= new OkHttpClient.Builder()
									.connectTimeout(30, TimeUnit.SECONDS)
									.readTimeout(30, TimeUnit.SECONDS)
									.writeTimeout(30, TimeUnit.SECONDS)
									.build();

		Request request			= new Request.Builder()
									.url(url)
									.addHeader("API-KEY"			, tc.apiKey)
									.addHeader("ENC-KEY"			, aesCipherKey)
									.post(RequestBody.create(MediaType.get("application/json; charset=utf-8"), json.toJSONString())).build();

		Response response		= client.newCall(request).execute();
		String responseStr		= response.body().string();
		System.out.println("responseStr: " + responseStr);

        JSONParser jsonParser = new JSONParser();
        Object obj = jsonParser.parse(responseStr);

        JSONObject jsonObject = new JSONObject((Map) obj);

        System.out.println(jsonObject);

        JSONObject resultData = (JSONObject) jsonObject.get("Result");

        System.out.println(resultData);


        JSONArray welToolTgtList = (JSONArray) resultData.get("ds_welToolTgtList");
        JSONArray toolPayLmtList = (JSONArray) resultData.get("ds_toolPayLmtList");
        JSONArray welToolTgtHistList = (JSONArray) resultData.get("ds_welToolTgtHistList");

        System.out.println(welToolTgtList); // 인정기간 외
        System.out.println(toolPayLmtList); // 적용기간 사용금액/제한금액/급여잔액
        System.out.println(welToolTgtHistList);// 히스토리


        List<Map<String, Object>> welToolTgtListMap =  JsonUtil.getListMapFromJsonArray(welToolTgtList);
        for(Map<String, Object> welToolTgt : welToolTgtListMap) {

        	System.out.println("welToolTgt: " + welToolTgt);

        	System.out.println("LTC_MGMT_NO" + welToolTgt.get("LTC_MGMT_NO")); // 요양번호
        	System.out.println("LTC_RCGT_GRADE_CD" + welToolTgt.get("LTC_RCGT_GRADE_CD")); // 등급
        	System.out.println("QLF_TYPE" + welToolTgt.get("QLF_TYPE")); //본인부담율
        	System.out.println("RCGT_EDA_DT" + welToolTgt.get("RCGT_EDA_DT")); // 인정유효기간

        	System.out.println("REDUCE_NM" + welToolTgt.get("REDUCE_NM")); // 대상자 구분
        	System.out.println("SBA_CD" + welToolTgt.get("SBA_CD")); // 대상자 구분 경감율

        	String reduceNm = (String) welToolTgt.get("REDUCE_NM");

        	System.out.println("REDUCE_NM" + reduceNm); // 대상자 구분


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
        		selfBndRt = EgovStringUtil.string2integer(sbaCd.split("(")[1].substring(0, sbaCd.split("(")[1].length()-1).replace("%", "")); // 9% or 6%
        	}


        	System.out.println("selfBndRt" + selfBndRt); // 대상자 구분 경감율

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
        	}
        }



        //JSONObject jsonObj = (JSONObject) obj;
        /*
        System.out.println(jsonObj.get("Status"));
        System.out.println(jsonObj.get("Message"));
        System.out.println(jsonObj.get("Result"));
        */



	}




/*
	public static void main(String[] args) throws Exception {

		String dateStr = "2022-11-21T19:00:31+09:00";
		SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd'T'HH:mm:ss");
		SimpleDateFormat output = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		Date parseStlmDt = format.parse(dateStr);
		Date convertStlmDt =  output.parse(output.format(parseStlmDt));

		System.out.println("parseStlmDt: " + parseStlmDt);
		System.out.println("convertStlmDt: " + convertStlmDt);

	}
*/
}
