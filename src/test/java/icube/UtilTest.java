package icube;

import java.lang.reflect.Type;
import java.util.HashMap;

import org.egovframe.rte.fdl.string.EgovStringUtil;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;

import com.google.gson.Gson;
import com.google.gson.reflect.TypeToken;

import icube.common.util.DateUtil;

public class UtilTest {

	public static void main(String[] args) throws Exception {


		HashMap<String, Object> res = new HashMap<String, Object>();
		res.put("authenticate_data", "{phone=01092488798, unique=a8UgrRPwx+4gKwHBsQRkVeQhcmSTR1ufXSisMZb4fDWli25nTTZKL4QToSFQuKxoE1iTb/NJ4y083IVB0YKC/Q==, di=MC0GCCqGSIb3DQIJAyEAJ5Po3ZFQDUPCC7i9crXYlMubzVlaWg30fHWK61anJgE=, name=구균모, birth=19820624, gender=1.0, foreigner=null, carrier=null, tid=202301251136255227077011}");

		System.out.println(res.toString());


		String test = (String) res.get("authenticate_data");

		String[] a1 = test.substring(1, test.length()-1).split(",");


		HashMap<String, String> authMap = new HashMap<String, String>();

		for(String a:a1) {
			System.out.println("a: " + a.trim());
			String[] b1 = a.trim().split("=", 2);
			authMap.put(b1[0], b1[1]);

			/*
			for(String b:b1) {
				System.out.println("b: " + b.trim());

			}
			*/

			//for(int i=0;i < b1.length; i++) {

			//}
		}

		System.out.println("authMap: " + authMap.toString());

		//JsonReader reader = new JsonReader(new StringReader(res.toString()));
		//reader.setLenient(true);
		//System.out.println("reader:" + reader);


		System.out.println("@@1");
        //Type resType = new TypeToken<HashMap<String, Object>>(){}.getType();
        //HashMap<String, Object> result = new Gson().fromJson(String.valueOf(res.get("authenticate_data")), resType);


        System.out.println("@@2" + res.get("authenticate_data"));

        //Type resType = new TypeToken<HashMap<String, Object>>(){}.getType();
        //HashMap<String, Object> result = new Gson().fromJson(res.get("authenticate_data").toString(), resType);


        //String diKey = (String) result.get("unique");

		//System.out.println("authMap di: "+ diKey);
		System.out.println(DateUtil.formatDate("20230119", "yyyy-MM-dd"));


		String phone = "01092488798";
		System.out.println("phone : "+ phone.substring(0, 3) + "-" + phone.substring(3, 7) +"-"+ phone.substring(7, 11));

		double gender = 1.0;
		System.out.println("gender : " + EgovStringUtil.double2string(gender));

	}
}
