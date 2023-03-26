package icube.common.api;

import java.io.BufferedReader;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.egovframe.rte.fdl.string.EgovStringUtil;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import icube.common.api.biz.BootpayApiService;
import icube.common.api.biz.BootpayVO;
import icube.manage.ordr.ordr.biz.OrdrService;

/**
 * 웹훅
 * 부트페이에서 결제완료/취소
 * 가상계좌 발급/입금완료
 * 카드 자동결제
 */
@Controller
@RequestMapping(value = "/common/bootpay")
public class BootpayApiController {

	@Resource(name= "bootpayApiService")
	private BootpayApiService bootpayApiService;

	@Resource(name = "ordrService")
	private OrdrService ordrService;

	@ResponseBody
	@RequestMapping("callback.json")
	public Map<String, Object> callback(
			HttpServletRequest request) throws Exception {

		boolean result = false;

		try {
			BufferedReader br = request.getReader();
			String inputLine = null;

			StringBuilder sb = new StringBuilder();
			System.out.println("==============================");
			while((inputLine = br.readLine()) != null){
				System.out.println(inputLine);
				sb.append(inputLine);
			}
			System.out.println("==============================");

			JSONParser parser = new JSONParser();
			Object obj = parser.parse(sb.toString());

			JSONObject jsonObj = (JSONObject) obj;

			BootpayVO bootpayVO = new BootpayVO();
			bootpayVO.setReceiptId((String) jsonObj.get("receipt_id")); // 6389b6cecf9f6d001e6459d8
			bootpayVO.setOrderId((String) jsonObj.get("order_id")); // O21202172643424
			bootpayVO.setMethodSymbol(((String) jsonObj.get("method_symbol")).toUpperCase()); // vbank, card, bank, auth
			bootpayVO.setStatus(EgovStringUtil.long2string((Long) jsonObj.get("status"))); // status
			bootpayVO.setStatusLocale((String) jsonObj.get("status_locale"));

			Map<String, Object> paramMap = new HashMap<String, Object>();

			if("VBANK".equals(bootpayVO.getMethodSymbol())) {
				bootpayVO.setTid((String) jsonObj.get("tid"));
				Object vdata = parser.parse(jsonObj.get("vbank_data").toString());
				JSONObject vdataObj = (JSONObject) vdata;
				System.out.println("VBANK ==============================");
				System.out.println("tid: " + vdataObj.get("tid"));
				bootpayVO.setTid((String) vdataObj.get("tid"));

				// status = 1 결제완료
				if("1".equals(bootpayVO.getStatus())) {

					SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd'T'HH:mm:ss");
					SimpleDateFormat output = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
					Date parseDt = format.parse((String) jsonObj.get("purchased_at"));
					String convertDt =  output.format(parseDt);
					bootpayVO.setPurchasedAt(convertDt);

					//System.out.println("bootpayVO: " + bootpayVO.toString());

					paramMap.put("stlmYn", "Y");
					paramMap.put("stlmDt", bootpayVO.getPurchasedAt());
					paramMap.put("ordrCd", bootpayVO.getOrderId());
					paramMap.put("delngNo", bootpayVO.getReceiptId());

					//System.out.println("paramMap: " + paramMap.toString());

					ordrService.updateStlmYn(paramMap);
				}

			}else if("CARD".equals(bootpayVO.getMethodSymbol())) {

				Object vdata = parser.parse(jsonObj.get("card_data").toString());
				JSONObject vdataObj = (JSONObject) vdata;

				System.out.println("CARD ==============================");
				System.out.println("tid: " + vdataObj.get("tid"));

				bootpayVO.setTid((String) vdataObj.get("tid"));

			}else if("BANK".equals(bootpayVO.getMethodSymbol())) {

				Object vdata = parser.parse(jsonObj.get("bank_data").toString());
				JSONObject vdataObj = (JSONObject) vdata;

				System.out.println("BANK ==============================");
				System.out.println("tid: " + vdataObj.get("tid"));

				bootpayVO.setTid((String) vdataObj.get("tid"));

			}else if("AUTH".equals(bootpayVO.getMethodSymbol())) {

				System.out.println("AUTH ==============================");

			}

			result = true;

		} catch (Exception e) {
			//System.out.println(e.getStackTrace());
			// TO-DO : 에러기록
			result = false;
		}

		Map<String, Object> resultMap = new HashMap<String, Object>();
		resultMap.put("success", result);
		return resultMap;
	}


}
