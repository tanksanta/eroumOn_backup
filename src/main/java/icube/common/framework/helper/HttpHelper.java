package icube.common.framework.helper;

import org.springframework.stereotype.Service;

import java.util.Map;
import java.util.concurrent.TimeUnit;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;

import okhttp3.MediaType;
import okhttp3.OkHttpClient;
import okhttp3.Request;
import okhttp3.RequestBody;
import okhttp3.Response;

@Service
public class HttpHelper {
    protected Log log = LogFactory.getLog(this.getClass());

    protected OkHttpClient _client = null;

    protected void initCls(){
        if (this._client == null) {
            this._client = new OkHttpClient.Builder()
				.connectTimeout(30, TimeUnit.SECONDS)
				.readTimeout(30, TimeUnit.SECONDS)
				.writeTimeout(30, TimeUnit.SECONDS)
				.build();
        }
    }

    public String postString(String sUrl, JSONObject postData, Map<String, String> headers) throws Exception {

        this.initCls();

        Request.Builder reqBuilder = new Request.Builder().url(sUrl);

        if (headers != null && headers.keySet().size() > 0){
            for( String strKey : headers.keySet() ){
                String strValue = headers.get(strKey);

                reqBuilder.addHeader(strKey, strValue);
            }
        }

        if (postData != null){// RequestBody 생성
            RequestBody requestBody = RequestBody.create(
                 MediaType.parse("application/json; charset=utf-8"), postData.toJSONString());
            reqBuilder.post(requestBody);
        }

		Response response = this._client.newCall(reqBuilder.build()).execute();

		return response.body().string();
    }

    public JSONObject postJson(String sUrl, JSONObject postData, Map<String, String> headers) throws Exception{
        this.initCls();
        
        String responseStr = this.postString(sUrl, postData, headers);

        JSONParser jsonParser;
		JSONObject jsonObject;
		
		try {
            jsonParser = new JSONParser();
			jsonObject = (JSONObject) jsonParser.parse(responseStr);
		}catch(Exception e) {
			e.printStackTrace();
			log.debug(e.getMessage());
			
			throw e;
		}

        return jsonObject;
    }

}
