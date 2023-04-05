package icube;

import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.concurrent.TimeUnit;

import org.egovframe.rte.fdl.string.EgovStringUtil;
import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.json.simple.parser.ParseException;

import icube.common.util.JsonUtil;
import okhttp3.HttpUrl;
import okhttp3.MediaType;
import okhttp3.OkHttpClient;
import okhttp3.Request;
import okhttp3.RequestBody;
import okhttp3.Response;

public class Bokji24ApiTest {


	//private static String BOKJI_DOMAIN = "https://api.bokji24.com"; // Prod
	private static String BOKJI_DOMAIN = "https://api-dev.bokji24.com"; // Dev
	private static String SIGN_IN_URL = BOKJI_DOMAIN + "/api/auth/partner/signIn";
	private static String SEARCH_URL = BOKJI_DOMAIN + "/api/partner/v2/search/keyword";
	private static String DETAIL_URL = BOKJI_DOMAIN + "/api/partner/v2/search";

	private static String INST_URL = BOKJI_DOMAIN + "/api/partner/v2/distance";

	public static void main(String[] args) throws Exception {

		String accessToken = (String) getToken();
		System.out.println("getToken : " + accessToken);

		getInstList(accessToken);


		//getSrvcList(accessToken, "경기도");
		//getSrvcDtl(accessToken, "163078");

	}

	/**
"lat": 37.47768581218323,
  "lng": 126.88549917743,
  "distance": 10
	 */
	private static void getInstList(String accessToken) throws IOException, ParseException {
		StringBuilder urlBuilder = new StringBuilder(INST_URL);

        urlBuilder.append("?lat=37.47768581218323");
        urlBuilder.append("&lng=126.88549917743");
        urlBuilder.append("&distance=100");

		OkHttpClient client	= new OkHttpClient.Builder()
				.connectTimeout(30, TimeUnit.SECONDS)
				.readTimeout(30, TimeUnit.SECONDS)
				.writeTimeout(30, TimeUnit.SECONDS)
				.build();

		System.out.println("url: " + urlBuilder.toString());

		//https://api-dev.bokji24.com/api/partner/v2/distance?lat=37.47768581218323&lng=126.88549917743&distance=10
		//https://api-dev.bokji24.com/api/partner/v2/distance?lat=37.47768581218323&lng=126.88549917743&distance=10

		Request request	= new Request.Builder()
				.url(urlBuilder.toString())
				.addHeader("accept", "application/json")
				.addHeader("Authorization", "Bearer " + accessToken)
				.build();

		Response response = client.newCall(request).execute();
		String responseStr = response.body().string();

		JSONParser jsonParser = new JSONParser();
		JSONObject jsonObject = (JSONObject) jsonParser.parse(responseStr);
		JSONObject resultData = (JSONObject) jsonObject.get("data");

		System.out.println("### JSON ### " + jsonObject.toJSONString());

		//System.out.println(resultData);

		JSONArray instList = (JSONArray) resultData.get("content");

		List<Map<String, Object>> instListMap =  JsonUtil.getListMapFromJsonArray(instList);

		System.out.println("instListMap size: " + instListMap.size());


		for(Map<String, Object> inst : instListMap) {

			System.out.println("@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@");
			System.out.println("id: " + inst.get("id"));
			System.out.println("bokjiServerId: " + inst.get("bokjiServerId"));
			System.out.println("cityName: " + inst.get("cityName"));
			System.out.println("sprName: " + inst.get("sprName"));
			System.out.println("address: " + inst.get("address"));
			System.out.println("institutionName: " + inst.get("institutionName"));
			System.out.println("contactNumber: " + inst.get("contactNumber"));

			System.out.println("location: " + inst.get("location"));

			Map location = (Map) inst.get("location");

			System.out.println("lat: " + location.get("lat"));
			System.out.println("lon: " + location.get("lng"));

			System.out.println("distance: " + inst.get("distance"));

		}

	}



	private static void getSrvcList(String accessToken, String sprName) throws IOException, ParseException {
		StringBuilder urlBuilder = new StringBuilder(SEARCH_URL);
		//urlBuilder.append("?query=" + query);
        urlBuilder.append("?sprName=" + sprName);
        urlBuilder.append("&page=0"); // 필수, 0~
        urlBuilder.append("&size=800"); // 필수, 1~

		OkHttpClient client	= new OkHttpClient.Builder()
				.connectTimeout(30, TimeUnit.SECONDS)
				.readTimeout(30, TimeUnit.SECONDS)
				.writeTimeout(30, TimeUnit.SECONDS)
				.build();

		Request request	= new Request.Builder()
				.url(urlBuilder.toString())
				.addHeader("accept", "application/json")
				.addHeader("Authorization", "Bearer " + accessToken)
				.build();

		Response response = client.newCall(request).execute();
		String responseStr = response.body().string();

		JSONParser jsonParser = new JSONParser();
		JSONObject jsonObject = (JSONObject) jsonParser.parse(responseStr);

		System.out.println("### JSON ### " + jsonObject.toJSONString());

		JSONObject resultData = (JSONObject) jsonObject.get("data");

		System.out.println(resultData);

		long total = (long) resultData.get("totalElements");
		System.out.println(total);

		JSONArray contentList = (JSONArray) resultData.get("content");
		List<Map<String, Object>> contentListMap =  JsonUtil.getListMapFromJsonArray(contentList);
		/*
		for(Map<String, Object> content : contentListMap) {

			System.out.println("beginDate: " + content.get("beginDate"));
			System.out.println("endDate: " + content.get("endDate"));
			System.out.println("benefitName: " + content.get("benefitName"));
			System.out.println("mainKind: " + content.get("mainKind"));
			System.out.println("bokjiId: " + content.get("bokjiId"));
			System.out.println("isAvailableKeyword: " + content.get("isAvailableKeyword"));
			System.out.println("category: " + content.get("category"));

		}
		*/

	}


	private static void getSrvcDtl(String accessToken, String bokjiId) throws IOException, ParseException {
		StringBuilder urlBuilder = new StringBuilder(DETAIL_URL);
		urlBuilder.append("/" + bokjiId); // 필수

		OkHttpClient client	= new OkHttpClient.Builder()
				.connectTimeout(30, TimeUnit.SECONDS)
				.readTimeout(30, TimeUnit.SECONDS)
				.writeTimeout(30, TimeUnit.SECONDS)
				.build();

		Request request	= new Request.Builder()
				.url(urlBuilder.toString())
				.addHeader("accept", "application/json")
				.addHeader("Authorization", "Bearer " + accessToken)
				.build();

		Response response = client.newCall(request).execute();
		String responseStr = response.body().string();

		JSONParser jsonParser = new JSONParser();
		JSONObject jsonObject = (JSONObject) jsonParser.parse(responseStr);

		System.out.println("### JSON ### " + jsonObject.toJSONString());

		JSONObject resultData = (JSONObject) jsonObject.get("data");

		System.out.println("resultData: " + resultData.get("requiredDocuments"));


	}


	@SuppressWarnings("unchecked")
	public static String getToken()throws Exception {
		String accessToken = "";

		// 계정 정보
		JSONObject json = new JSONObject();
		json.put("username", "thkc");
		json.put("password", "thkc1212!#");

		// API 호출
		OkHttpClient client	= new OkHttpClient();
		Request request	= new Request.Builder()
				.url(SIGN_IN_URL)
				.post(RequestBody.create(MediaType.get("application/json; charset=utf-8")
						, json.toJSONString())).build();

		Response response = client.newCall(request).execute();
		String responseStr = response.body().string();

		JSONParser jsonParser = new JSONParser();
		JSONObject jsonObject = (JSONObject) jsonParser.parse(responseStr);

		String status = (String) jsonObject.get("state");
		// 토큰 발급
		if (EgovStringUtil.equals("OK", status)) {
			JSONObject dataObject = (JSONObject) jsonObject.get("data");
			accessToken = (String) dataObject.get("accessToken");
		}

		return accessToken;

	}

}
