package icube.common.api;

import java.io.BufferedReader;
import java.io.OutputStream;
import java.net.HttpURLConnection;
import java.net.URL;
import java.nio.charset.StandardCharsets;
import java.util.ArrayList;
import java.util.Enumeration;
import java.util.HashMap;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.apache.commons.io.IOUtils;
import org.egovframe.rte.fdl.string.EgovStringUtil;
import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import icube.common.api.biz.UpdateBplcInfoApiService;
import icube.common.framework.abst.CommonAbstractController;
import icube.common.util.Base64Util;
import icube.manage.gds.gds.biz.GdsService;

/**
 * 주문 데이터 수신 API
 * 이로움 DB -> icube DB
 * @author ogy
 * @params 주문 정보
 *
 */
@Controller
@RequestMapping(value = "/eroumcareApi/bplcRecv")
public class UpdateBplcInfoApiController extends CommonAbstractController{

	@Resource(name = "gdsService")
	private GdsService gdsService;

	@Resource(name = "updateBplcInfoApiService")
	private UpdateBplcInfoApiService updateBplcInfoApiService;

	@Value("#{props['Globals.EroumCare.PrivateKey']}")
	private String eroumKey;

	/**
	 * 1.0 -> 1.5 상품별 승인/반려 상태 전달
	 * order_ent_response
	 * @param JSON
	 * @return resultMap
	 */
	@ResponseBody
	@RequestMapping(value = "callback.json")
	public Map<String, Object> callback(
			HttpServletRequest request
			)throws Exception {

		Map<String, Object> resultMap = new HashMap<String, Object>();

		// header
		Enumeration<?> en1 = request.getHeaderNames();
		while (en1.hasMoreElements()) {
			String key = (String) en1.nextElement();
			String value = (String) request.getHeader(key);

			log.debug(" #### header name = '" + key + "', value = '" + value + "'");
		}

		// rquest body post data 읽을때 -> request.getReader() or request.getInputStream()
		BufferedReader br = request.getReader();
		String inputLine = null;
		StringBuilder sb = new StringBuilder();
		while((inputLine = br.readLine()) != null){
			System.out.println(inputLine);
			sb.append(inputLine);
		}

		String eroumApiKey = "";

		int resultCode = 00;
		String resultMsg = "success";
		String failMsg = "";

		JSONParser parser = new JSONParser();
		Object obj = parser.parse(sb.toString().replace(" ", ""));
		JSONObject jsonObj = (JSONObject) obj;
		//JSONArray jsonArray = new JSONArray();

		System.out.println(" ### jsonObj ### " + jsonObj);
		ArrayList<String> paramList = new ArrayList<String>();
		paramList.add("api_div");
		//paramList.add("order_business_id");
		paramList.add("order_send_id");
		paramList.add("_array_item");

		// 1. 이로움 키 검증
		if(EgovStringUtil.isEmpty((String) request.getHeader("eroum_api_key"))) {
			resultCode = 01; // 이로움 제공 키 같지 않음.
			resultMsg = "이로움 제공 키 없음";
			System.out.println("### Eroum_Private_Key NULL ###");
		}else {
			eroumApiKey = (String) request.getHeader("eroum_api_key");
			if(!eroumApiKey.equals(eroumKey)) {
				eroumApiKey = (String) request.getHeader("eroum_api_key");
				System.out.println(" eroum_api_key " + eroumApiKey);
				resultCode = 01; // 이로움 제공 키 같지 않음.
				resultMsg = "이로움 제공 키 불일치";
				System.out.println("### Eroum_Private_Key not Equals ###");
			}else {
				// 2. 필수 파라미터 검증
				for(String objNm : paramList) {
					String param = "";
					if(objNm.equals("_array_item")) {
						JSONArray array =(JSONArray)jsonObj.get("_array_item");
						if(array == null) {
							resultCode = 11; // 필수 요청 파라미터 없음.
							resultMsg = "필수 요청 파라미터 없음";
							resultMsg = resultMsg.concat(" DATA : ") + jsonObj.toString();
							System.out.println("### Request param is empty ###");
						}else {
							for(int i=0; i<array.size(); i++) {
								JSONObject item = (JSONObject)array.get(i);
								if(EgovStringUtil.isEmpty((String)item.get("order_send_dtl_id")) || EgovStringUtil.isEmpty((String)item.get("item_state"))) {
									resultCode = 11; // 필수 요청 파라미터 없음.
									resultMsg = "필수 요청 파라미터 없음";
									resultMsg = resultMsg.concat(" DATA : ") + item.toString();
								}
							}
						}
					}else {
						param = objNm;

						if(EgovStringUtil.isEmpty((String)jsonObj.get(param))) {
							resultCode = 11; // 필수 요청 파라미터 없음.
							resultMsg = "필수 요청 파라미터 없음";
							resultMsg = resultMsg.concat(" DATA : ") + jsonObj.toString();
							System.out.println("### Request param is empty ###");
						}
					}
				}

				if(resultCode != 11) {
					//3. api_div 검증
					String apiDiv = Base64Util.decoder((String)jsonObj.get("api_div"));
					if(!apiDiv.equals("order_ent_response")) {
						resultCode = 12;
						resultMsg = "API 구분자가 일치하지 않습니다";
					}else {
						Map<String, Object> returnMap = new HashMap<String, Object>();
						returnMap = updateBplcInfoApiService.getBplcSttusInfo(jsonObj);
						int updateTotal = (Integer)returnMap.get("updateTotal");
						int failTotal = (Integer)returnMap.get("failTotal");

						resultMsg = updateTotal + " 건 업데이트 완료";
						failMsg = failTotal + " 건은 주문취소된 건입니다.";
						System.out.println("####### 주문 취소 건 ###### : " + failMsg + " 건");
						resultMap.put("cancelMsg", failMsg);
					}
				}
			}
		}

		resultMap.put("resultMsg", resultMsg);
		resultMap.put("resultCode", resultCode);
		return resultMap;

	}

	/**
	 * 송신 API
	 * @param ordrCd
	 * @return resultMap
	 * @throws Exception
	 */
	@ResponseBody
	@RequestMapping(value = "call.json")
	public void call(
			HttpServletRequest request
			)throws Exception {

		Map<String, Object> itemMap = new HashMap<String, Object>();
		Map<String, Object> restMap = new HashMap<String, Object>();
		ArrayList<JSONObject> tagList = new ArrayList<JSONObject>();

		itemMap.put("order_send_dtl_id", Base64Util.encoder("O30323214318403_1"));
		itemMap.put("item_state", Base64Util.encoder("0"));
		itemMap.put("item_memo", Base64Util.encoder("사업소 물품 부족."));

		JSONObject item_json1 = new JSONObject(itemMap);

		tagList.add(item_json1);

		/*itemMap.put("order_send_dtl_id", Base64Util.encoder("O30314094332935_2"));
		itemMap.put("item_state", Base64Util.encoder("1"));
		itemMap.put("item_memo", null);
		JSONObject item_json2 = new JSONObject(itemMap);
		tagList.add(item_json2);*/

		restMap.put("order_send_id", null);
		restMap.put("order_send_id", Base64Util.encoder("O30323214318403"));
		restMap.put("order_business_id", Base64Util.encoder("466-87-00410"));
		restMap.put("api_div", Base64Util.encoder("order_ent_response"));
		restMap.put("_array_item", tagList);

		JSONObject json = new JSONObject(restMap);
		String jsonData = json.toJSONString();
		StringBuilder urlBuilder = new StringBuilder("http://localhost:80/eroumcareApi/bplcRecv/callback.json");

		URL url = new URL(urlBuilder.toString()); // url화
        HttpURLConnection conn = (HttpURLConnection) url.openConnection(); // url 연결 객체 생성
        conn.setRequestMethod("POST"); 		// 요청 방식
        conn.setRequestProperty("Content-type", "application/json"); // data를 json으로 전달
        conn.setRequestProperty("Accept", "application/json"); // data를 json으로 수신
        conn.setRequestProperty("eroum_api_key", "f9793511dea35edee3181513b640a928644025a66e5bccdac8836cfadb875856");

        conn.setDoOutput(true); 			// output으로 stream으로 전달
        conn.setUseCaches(false); 			// 캐싱데이터 수신x
        conn.setDefaultUseCaches(false); 	// 캐싱데이터 디폴트 값 설정x


        System.out.println("post jsonData: " + jsonData);

        try(OutputStream os = conn.getOutputStream()) {
            byte[] input = jsonData.getBytes("utf-8");
            os.write(input, 0, input.length);
        }

        String jsons2 = IOUtils.toString(conn.getInputStream(), StandardCharsets.UTF_8);
		System.out.println(" ### 수신 데이터 ### " + jsons2);

	}
}
