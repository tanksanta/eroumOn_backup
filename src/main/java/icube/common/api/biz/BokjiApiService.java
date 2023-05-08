package icube.common.api.biz;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.concurrent.TimeUnit;

import org.egovframe.rte.fdl.string.EgovStringUtil;
import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;

import icube.common.util.HtmlUtil;
import icube.common.util.JsonUtil;
import icube.common.vo.CommonListVO;
import okhttp3.MediaType;
import okhttp3.OkHttpClient;
import okhttp3.Request;
import okhttp3.RequestBody;
import okhttp3.Response;

@SuppressWarnings("unchecked")
@Service("bokjiService")
public class BokjiApiService {

	@Value("#{props['Globals.Bokji.UseName']}")
	private String bokjiId;

	@Value("#{props['Globals.Bokji.Password']}")
	private String bokjiPw;

	@Value("#{props['Globals.Bokji.Url']}")
	private String bokjiDomain;

	private String BOKJI_TOKEN;

	/**
	 * 복지서비스 목록
	 * @param CommonListVO
	 * @return CommonListVO
	 */
	public CommonListVO getSrvcList(CommonListVO listVO) throws Exception {

		String searchUrl = bokjiDomain + "/api/partner/v2/search/keyword";


		String sprName = listVO.getParam("sprName");
		String cityName = listVO.getParam("cityName");
		String query = listVO.getParam("query");
		String categoryList = listVO.getParam("categoryList");
		int page = listVO.getCurPage();
		int size = listVO.getCntPerPage();

		String accessToken = getToken();
		//System.out.println("getToken : " + accessToken);

		StringBuilder urlBuilder = new StringBuilder(searchUrl);
        urlBuilder.append("?sprName=" + sprName);
        if(EgovStringUtil.isNotEmpty(cityName)) {
        	urlBuilder.append("&cityName=" + cityName); //cityName
        }
        if(EgovStringUtil.isNotEmpty(query)) {
        	urlBuilder.append("&query=" + query); //query
        }
        if(EgovStringUtil.isNotEmpty(categoryList)) {
        	urlBuilder.append("&categoryList=" + categoryList); //categoryList
        }
        urlBuilder.append("&page=" + (page - 1)); // 필수, 0~
        urlBuilder.append("&size=" + size); // 필수, 1~


        System.out.println("SEARCH_URL: " + urlBuilder);

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

		long total = (long) resultData.get("totalElements");
		System.out.println(total);


		listVO.setTotalCount((int) total);

		List list = new ArrayList<>();

		JSONArray contentList = (JSONArray) resultData.get("content");
		List<Map<String, Object>> contentListMap =  JsonUtil.getListMapFromJsonArray(contentList);
		for(Map<String, Object> content : contentListMap) {

			BokjiServiceVO bokjiServiceVO = new BokjiServiceVO();
			bokjiServiceVO.setBokjiId((int) content.get("bokjiId"));
			bokjiServiceVO.setBenefitName((String) content.get("benefitName"));
			bokjiServiceVO.setBeginDate((String)content.get("beginDate"));
			bokjiServiceVO.setEndDate((String)content.get("endDate"));
			bokjiServiceVO.setAvailableKeyword((Boolean) content.get("isAvailableKeyword"));
			bokjiServiceVO.setBokjiResource((String)content.get("bokjiResource"));
			bokjiServiceVO.setCategoryList((List<String>) content.get("category"));

			//System.out.println("bokjiServiceVO: " + bokjiServiceVO.toString());

			list.add(bokjiServiceVO);
		}
		listVO.setListObject(list);

		return listVO;

	}


	/**
	 * 복지서비스 상세
	 * @param bokjiId
	 * @return bokjiServiceVO
	 */
	public BokjiServiceVO getSrvcDtl(int bokjiId) throws Exception {

		String searchUrl = bokjiDomain + "/api/partner/v2/search/";
		String accessToken = getToken();
		//System.out.println("getToken : " + accessToken);

		StringBuilder urlBuilder = new StringBuilder(searchUrl);
        urlBuilder.append(bokjiId);

        System.out.println("SEARCH_URL: " + urlBuilder);

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

		BokjiServiceVO bokjiServiceVO = new BokjiServiceVO();

		bokjiServiceVO.setBokjiId((int)((long) resultData.get("id")));
		bokjiServiceVO.setBenefitName((String) resultData.get("benefitName"));
		bokjiServiceVO.setSupportContent(HtmlUtil.enterToBr((String) resultData.get("supportContent")));
		bokjiServiceVO.setEntitledCondition(HtmlUtil.enterToBr((String) resultData.get("entitledCondition")));
		bokjiServiceVO.setDueDate((String) resultData.get("dueDate"));

		JSONArray dueDateList = (JSONArray) resultData.get("dueDateList");
		List<Map<String, Object>> dueDateListMap = JsonUtil.getListMapFromJsonArray(dueDateList);
		for(Map<String, Object> due : dueDateListMap) {
			bokjiServiceVO.setBeginDate((String) due.get("beginDate"));
			bokjiServiceVO.setEndDate((String) due.get("endDate"));
		}

		bokjiServiceVO.setAvailableKeyword((boolean) resultData.get("isAvailableKeyword"));
		bokjiServiceVO.setCategoryList((List<String>) resultData.get("category"));

		bokjiServiceVO.setTotalSupportAmount((String) resultData.get("totalSupportAmount"));
		bokjiServiceVO.setRequiredDocuments(HtmlUtil.enterToBr((String) resultData.get("requiredDocuments")));
		bokjiServiceVO.setApplyMethod(HtmlUtil.enterToBr((String) resultData.get("applyMethod")));

		bokjiServiceVO.setBokjiResource((String) resultData.get("bokjiResource"));
		bokjiServiceVO.setRefUrl((String) resultData.get("refUrl"));
		bokjiServiceVO.setBokjiRefUrl((String) resultData.get("bokjiRefUrl"));
		//bokjiServiceVO.setVideoUrl((String) resultData.get("videoUrl"));
		//bokjiServiceVO.setThumbnailImageUrl((String) resultData.get("thumbnailImageUrl"));

		JSONObject provider = (JSONObject) resultData.get("provider");

		BokjiProviderVO providerVO = new BokjiProviderVO();
		providerVO.setInstitutionName((String) provider.get("institutionName")); // institutionName
		providerVO.setContactNumber((String) provider.get("contactNumber"));
		providerVO.setAddress((String) provider.get("address"));
		providerVO.setLat((double) provider.get("lat"));
		providerVO.setLng((double) provider.get("lng"));

		bokjiServiceVO.setProvider(providerVO);

		return bokjiServiceVO;
	}

	/**
	 * 복지시설 목록
	 * @param CommonListVO
	 * @return CommonListVO
	 */
	public CommonListVO getInstList(CommonListVO listVO) throws Exception {

		String instUrl = bokjiDomain + "/api/partner/v2/distance";

		String sprName = listVO.getParam("sprName");
		String cityName = listVO.getParam("cityName");

		String lat = listVO.getParam("lat");
		String lng = listVO.getParam("lng");
		String distance = listVO.getParam("distance");
		int page = listVO.getCurPage();
		int size = listVO.getCntPerPage();

		String accessToken = getToken();
		//System.out.println("getToken : " + accessToken);

		StringBuilder urlBuilder = new StringBuilder(instUrl);

		urlBuilder.append("?page=" + (page - 1));
		urlBuilder.append("&size=" + size);
		if(EgovStringUtil.isNotEmpty(sprName)) {
			urlBuilder.append("&sprName=" + sprName);
		}
		if(EgovStringUtil.isNotEmpty(cityName)) {
			urlBuilder.append("&cityName=" + cityName);
		}
		if(EgovStringUtil.isNotEmpty(lat) && EgovStringUtil.isNotEmpty(lng)) {
			urlBuilder.append("&lat=" + lat);
			urlBuilder.append("&lng=" + lng);
			urlBuilder.append("&distance=" + distance);
		}

		System.out.println("instUrl: " + urlBuilder);

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

		long total = (long) resultData.get("totalElements");
		listVO.setTotalCount((int) total);

		JSONArray instList = (JSONArray) resultData.get("content");

		List<Map<String, Object>> instListMap =  JsonUtil.getListMapFromJsonArray(instList);

		List list = new ArrayList<>();
		for(Map<String, Object> inst : instListMap) {

			BokjiProviderVO bokjiProviderVO = new BokjiProviderVO();
			bokjiProviderVO.setId((int) inst.get("id"));
			bokjiProviderVO.setInstitutionName((String) inst.get("institutionName"));
			bokjiProviderVO.setContactNumber((String) inst.get("contactNumber"));

			bokjiProviderVO.setCityName((String) inst.get("cityName"));
			bokjiProviderVO.setSprName((String) inst.get("sprName"));
			bokjiProviderVO.setAddress((String) inst.get("address"));

			Map location = (Map) inst.get("location");
			bokjiProviderVO.setLat((double) location.get("lat"));
			bokjiProviderVO.setLng((double) location.get("lng"));

			bokjiProviderVO.setDistance((double) inst.get("distance"));

			list.add(bokjiProviderVO);
		}
		listVO.setListObject(list);

		return listVO;

	}

	public int getInstCnt(String sprName, String cityName) throws Exception {

		String instCntUrl = bokjiDomain + "/api/partner/v2/distance";
		String accessToken = getToken();

		StringBuilder urlBuilder = new StringBuilder(instCntUrl);
		urlBuilder.append("?sprName=" + sprName);
		if(EgovStringUtil.isNotEmpty(cityName)) {
			urlBuilder.append("&cityName=" + cityName);
		}

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

		JSONObject resultData = (JSONObject) jsonObject.get("data");

		int total = (int) resultData.get("count");

		return total;
	}


	/**
	 * 토큰 발급
	 * @return accessToken
	 */
	public String getToken() throws Exception {

		String signInUrl = bokjiDomain + "/api/auth/partner/signIn";
		String accessToken = "";

		// 계정 정보
		JSONObject json = new JSONObject();
		json.put("username", bokjiId);
		json.put("password", bokjiPw);
		//System.out.println("SIGN_IN_URL: " + signInUrl);

		// API 호출
		OkHttpClient client = new OkHttpClient();
		Request request = new Request.Builder().url(signInUrl)
				.post(RequestBody.create(MediaType.get("application/json; charset=utf-8"), json.toJSONString()))
				.build();

		Response response = client.newCall(request).execute();
		String responseStr = response.body().string();
		//System.out.println("### responseStr ### " + responseStr);

		JSONParser jsonParser = new JSONParser();
		JSONObject jsonObject = (JSONObject) jsonParser.parse(responseStr);
		//System.out.println("### JSON ### " + jsonObject.toJSONString());

		String status = (String) jsonObject.get("state");
		// 토큰 발급
		if (EgovStringUtil.equals("OK", status)) {
			JSONObject dataObject = (JSONObject) jsonObject.get("data");
			accessToken = (String) dataObject.get("accessToken");
		}
		BOKJI_TOKEN = accessToken;

		return BOKJI_TOKEN;
	}


	// 전체 개수 조회
	public int getBokjisCnt(String apiUrl) throws Exception {

		String bokjisUrl = bokjiDomain + apiUrl;

		String token = this.getToken();

		StringBuilder urlBuilder = new StringBuilder(bokjisUrl);

		OkHttpClient client	= new OkHttpClient.Builder()
				.connectTimeout(30, TimeUnit.SECONDS)
				.readTimeout(30, TimeUnit.SECONDS)
				.writeTimeout(30, TimeUnit.SECONDS)
				.build();

		Request request	= new Request.Builder()
				.url(urlBuilder.toString())
				.addHeader("accept", "application/json")
				.addHeader("Authorization", "Bearer " + token)
				.build();

		Response response = client.newCall(request).execute();
		String responseStr = response.body().string();

		JSONParser jsonParser = new JSONParser();
		JSONObject jsonObject = (JSONObject) jsonParser.parse(responseStr);

		JSONObject resultData = (JSONObject) jsonObject.get("data");
		int count = Integer.parseInt(String.valueOf(resultData.get("count")));

		return count;
	}

}
