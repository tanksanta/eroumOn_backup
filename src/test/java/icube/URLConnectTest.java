package icube;

import java.io.OutputStream;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;
import java.util.Base64;

import org.apache.commons.io.IOUtils;

public class URLConnectTest {

	public static void main(String[] args) throws Exception {

		String jsonData = "{\"API_Div\": \"aXRlbV9pbmZv\""
				+ ", \"_array_item\" : [{\"ProdPayCode\": \"RjMwMDkwMjA0MDAy\"}]"
				+ "}";

		//String sendData = URLEncoder.encode(jsonData, "UTF-8");
		//urlBuilder.append("?orderData=" + sendData);

		//StringBuilder urlBuilder = new StringBuilder("https://dev.eroumcare.com/api/v1_order_send.php");
		StringBuilder urlBuilder = new StringBuilder("http://localhost/eroumcareApi/bplcRecv/callback.json");

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

        System.out.println(" stream to string ~~~~~~~~~~~~~~~~~~~~~~~~~~");
		String json = IOUtils.toString(conn.getInputStream(), StandardCharsets.UTF_8);
		System.out.println(" ~ " + json);
		System.out.println(" //stream to string ~~~~~~~~~~~~~~~~~~~~~~~~~~");


		//https://dev.eroumcare.com/api/v1_order_send.php?eroumAPI_Key=f9793511dea35edee3181513b640a928644025a66e5bccdac8836cfadb875856&API_Div=aXRlbV9pbmZv&ProdPayCode=VDA5MDYxMDg5MTA5

	}

}
