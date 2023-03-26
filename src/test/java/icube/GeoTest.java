package icube;

import java.io.OutputStream;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.io.IOUtils;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.annotation.IfProfileValue;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit.jupiter.SpringExtension;

import com.google.gson.Gson;
import com.google.gson.JsonArray;
import com.google.gson.JsonElement;
import com.google.gson.JsonObject;

import icube.manage.members.bplc.biz.BplcService;
import icube.manage.members.bplc.biz.BplcVO;

@ExtendWith(SpringExtension.class)
@ContextConfiguration(locations = {"classpath:icube/spring/context-*.xml"})
@IfProfileValue(name = "spring.profiles.active", value = "local")
public class GeoTest {

	@Autowired
	BplcService bplcService;

	@Test
	void getGeoUpdate() throws Exception {



		Map<String, Object> paramMap = new HashMap<String, Object>();
		paramMap.put("srchAprvTy", "C");
		paramMap.put("srchUseYn", "Y");
		List<BplcVO> resultList = bplcService.selectBplcListAll(paramMap);

		for(BplcVO bplcVO : resultList) {

			try {
				String location = URLEncoder.encode(bplcVO.getAddr(), "UTF-8");

				StringBuilder urlBuilder = new StringBuilder("http://dapi.kakao.com/v2/local/search/address.json"); /*URL*/
				urlBuilder.append("?analyze_type=similar");
		        urlBuilder.append("&query=" + location);

				URL url = new URL(urlBuilder.toString());
		        HttpURLConnection conn = (HttpURLConnection) url.openConnection();
		        conn.setRequestMethod("GET");
				conn.setRequestProperty("Authorization", "KakaoAK b55d03b83f3b64e075f8d93258c24def");
		        conn.setRequestProperty("Content-type", "application/json");
		        conn.setDoOutput(true);
		        conn.setUseCaches(false);
		        conn.setDefaultUseCaches(false);

		        OutputStream out = conn.getOutputStream();
				out.flush();
				out.close();

				System.out.println(" ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ stream to string ~~~~~~~~~~~~~~~~~~~~~~~~~~");
				String json = IOUtils.toString(conn.getInputStream(), StandardCharsets.UTF_8);
				System.out.println(" ~~~~~ " + json);
				System.out.println(" ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ //stream to string ~~~~~~~~~~~~~~~~~~~~~~~~~~");


				Gson gson = new Gson();
				/*
				Map map = gson.fromJson(json, Map.class);
				System.out.println("------------------------------------- data -------------------------------------");
				for(Object key : map.keySet()) {
					System.out.println("-------------------- key :: " + key);
					System.out.println("------------------- data :: " + map.get(key));
				}
				System.out.println("----------------------------------- //data -------------------------------------");
				 */
				JsonObject jsonObject = gson.fromJson( json.toString(), JsonObject.class);
				System.out.println("jsonObject: " + jsonObject);
				JsonArray arr = (JsonArray) jsonObject.get("documents");

				String lat = "";
				String lot = "";
				for(JsonElement element : arr){
					System.out.println("element x: " + (element.getAsJsonObject()).get("x"));
					System.out.println("element y: " + (element.getAsJsonObject()).get("y"));

					// x경도(longitude), y위도(latitude)
					lat = (element.getAsJsonObject()).get("y").getAsString();
					lot = (element.getAsJsonObject()).get("x").getAsString();

				}

				bplcService.updateBplcGeocode(bplcVO.getUniqueId(), lat, lot);
				//Thread.sleep(100);

			} catch (Exception e) {
				// TODO: handle exception
			}



		}

	}



	//@Test
	void getGeoTest() throws Exception {

		String location = URLEncoder.encode("서울시 중랑구", "UTF-8");

		StringBuilder urlBuilder = new StringBuilder("http://dapi.kakao.com/v2/local/search/address.json"); /*URL*/
		urlBuilder.append("?analyze_type=similar");
        urlBuilder.append("&query=" + location);

		URL url = new URL(urlBuilder.toString());
        HttpURLConnection conn = (HttpURLConnection) url.openConnection();
        conn.setRequestMethod("GET");
		conn.setRequestProperty("Authorization", "KakaoAK b55d03b83f3b64e075f8d93258c24def");
        conn.setRequestProperty("Content-type", "application/json");
        conn.setDoOutput(true);
        conn.setUseCaches(false);
        conn.setDefaultUseCaches(false);

        OutputStream out = conn.getOutputStream();
		out.flush();
		out.close();

		System.out.println(" ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ stream to string ~~~~~~~~~~~~~~~~~~~~~~~~~~");
		String json = IOUtils.toString(conn.getInputStream(), StandardCharsets.UTF_8);
		System.out.println(" ~~~~~ " + json);
		System.out.println(" ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ //stream to string ~~~~~~~~~~~~~~~~~~~~~~~~~~");


		Gson gson = new Gson();
		JsonObject jsonObject = gson.fromJson( json.toString(), JsonObject.class);
		System.out.println("jsonObject: " + jsonObject);
		JsonArray arr = (JsonArray) jsonObject.get("documents");

		for(JsonElement element : arr){
			System.out.println("element x: " + (element.getAsJsonObject()).get("x"));
			System.out.println("element y: " + (element.getAsJsonObject()).get("y"));
			// x경도(longitude), y위도(latitude)
		}
	}

}
