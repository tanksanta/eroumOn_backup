package icube.common.api.biz;


import org.json.simple.JSONObject;

import java.text.NumberFormat;

import org.json.simple.JSONArray;
import org.json.simple.parser.JSONParser;
import org.springframework.stereotype.Service;

import icube.common.util.DateUtil;
import icube.common.util.StringUtil;
import icube.manage.mbr.mbr.biz.MbrVO;
import icube.manage.ordr.ordr.biz.OrdrVO;

@SuppressWarnings("unchecked")
@Service("biztalkOrderService")
public class BiztalkOrderService extends BiztalkApiService {
    // Order_0001 주문접수(가상계좌만 가능)
	public boolean sendOrdrReceipt(MbrVO mbrVO, OrdrVO ordrVO) throws Exception {
		String tmpltCode = "Order_0001";
		
		String sPhoneNo = this.changeDevPhoneNo(true, mbrVO.getMblTelno());
		
		JSONObject param = this.msgOrder0001(tmpltCode, mbrVO, ordrVO);
		
        boolean bResult = this.sendApiWithToken("/v2/kko/sendAlimTalk", sPhoneNo, param);
        
        this.getResultAll();
        
        return bResult;
	}

    // Order_0001 주문접수(가상계좌만 가능)
	private JSONObject msgOrder0001(String tmpltCode, MbrVO mbrVO, OrdrVO ordrVO) throws Exception {
		
		String jsonStr;
		
		JSONObject jsonObject;
		JSONParser jsonParser = new JSONParser();
		JSONArray btns = new JSONArray();
		JSONObject attach = new JSONObject();
        JSONObject item = new JSONObject();
		JSONObject jtemp;


		jsonStr = "{" + " \"name\":\"◼︎ 주문내역 확인\"," + " \"type\":\"WL\"" + " , \"url_mobile\":\"#{url}\", \"url_pc\":\"#{url}\"}" ;
		jsonStr = jsonStr.replace("#{url}", this.eroumOnHost + "/market/mypage/ordr/list");
		jsonObject= (JSONObject) jsonParser.parse(jsonStr);
		btns.add(jsonObject);

		attach.put("button", btns);

        JSONArray itemList = new JSONArray();
		jtemp = new JSONObject();
		jtemp.put("title", "주문번호");
		jtemp.put("description", ordrVO.getOrdrCd());
        itemList.add(jtemp);
        item.put("list", itemList);
        attach.put("item", item);

		jtemp = new JSONObject();
		jtemp.put("title", "접수일자");
		jtemp.put("description", DateUtil.getDateTime(ordrVO.getOrdrDt(), "yyyy-MM-dd"));
		attach.put("item_highlight", jtemp);
		
		String msg = "안녕하세요. #{회원이름}님!\r\n" + //
		        "요청하신 주문이 접수되어 입금계좌 안내드립니다.\r\n" + //
		        "\r\n" + //
		        "입금하실 금액 : #{입금 금액}\r\n" + //
		        "입금 계좌번호 : #{은행명 가상계좌번호}\r\n" + //
		        "예금주 : 티에이치케이컴퍼니\r\n" + //
		        "입금 기한 : #{YYYY.MM.DD} 23시 59분\r\n" + //
		        "\r\n" + //
		        "기한 내 미입금 시 주문이 자동 취소됩니다.\r\n" + //
		        "감사합니다.";
		
		
		msg = msg.replace("#{회원이름}", mbrVO.getMbrNm());
        msg = msg.replace("#{입금 금액}", NumberFormat.getInstance().format(ordrVO.getStlmAmt()));
        msg = msg.replace("#{은행명 가상계좌번호}", ordrVO.getDpstBankNm() + " " + ordrVO.getVrActno());

        msg = msg.replace("#{YYYY.MM.DD}", DateUtil.getDateTime(ordrVO.getOrdrDt(), "yyyy-MM-dd"));
        
		
		JSONObject param = new JSONObject();
		
		param.put("tmpltCode", tmpltCode);
		param.put("senderKey", this.biztalkSenderKeyEroumOn);
		param.put("message", msg);
		param.put("attach", attach);
        param.put("header", "주문이 접수되었습니다.");
		
		return param;
	}
}
