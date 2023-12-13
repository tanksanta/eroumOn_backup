package icube.common.api.biz;


import org.json.simple.JSONObject;

import java.text.NumberFormat;

import org.egovframe.rte.fdl.string.EgovStringUtil;
import org.json.simple.JSONArray;
import org.json.simple.parser.JSONParser;
import org.springframework.stereotype.Service;

import icube.common.util.DateUtil;
import icube.manage.mbr.mbr.biz.MbrVO;
import icube.manage.ordr.ordr.biz.OrdrVO;

@SuppressWarnings("unchecked")
@Service("biztalkOrderService")
public class BiztalkOrderService extends BiztalkApiService {
	
	public boolean sendOrdr(String ordrMailTy, MbrVO mbrVO, OrdrVO ordrVO) throws Exception {
		boolean bResult = false;
		if (EgovStringUtil.equals(ordrMailTy, "BIZTALKSEND_ORDR_MARKET_PAYDONE_CARD")
			|| EgovStringUtil.equals(ordrMailTy, "BIZTALKSEND_ORDR_MARKET_PAYDONE_BANK")){
			this.sendOrdrMarketPaydoneCard(mbrVO, ordrVO);
		}else if (EgovStringUtil.equals(ordrMailTy, "BIZTALKSEND_ORDR_MARKET_PAYDONE_VBANK")){
			this.sendOrdrMarketPaydoneVBank(mbrVO, ordrVO);
		// }else if (EgovStringUtil.equals(ordrMailTy, "BIZTALKSEND_ORDR_MARKET_PAYDONE_FREE")){
		// 	this.sendOrdrMarketPaydoneVBank(mbrVO, ordrVO);
		}

		return bResult;
	}

	// Order_0005 주문완료(카드, 계좌이체)
	protected boolean sendOrdrMarketPaydoneCard(MbrVO mbrVO, OrdrVO ordrVO) throws Exception {
		String tmpltCode = "Order_0005";
		
		String sPhoneNo = this.changeDevPhoneNo(true, mbrVO.getMblTelno());
		
		JSONObject param = this.msgOrder0005(tmpltCode, mbrVO, ordrVO);
		
        boolean bResult = this.sendApiWithToken("/v2/kko/sendAlimTalk", sPhoneNo, param);
        
        this.getResultAll();
        
        return bResult;
	}

    // Order_0001 주문접수(가상계좌만 가능)
	protected boolean sendOrdrMarketPaydoneVBank(MbrVO mbrVO, OrdrVO ordrVO) throws Exception {
		String tmpltCode = "Order_0001";
		
		String sPhoneNo = this.changeDevPhoneNo(true, mbrVO.getMblTelno());
		
		JSONObject param = this.msgOrder0001(tmpltCode, mbrVO, ordrVO);
		
        boolean bResult = this.sendApiWithToken("/v2/kko/sendAlimTalk", sPhoneNo, param);
        
        this.getResultAll();
        
        return bResult;
	}

	// Order_0002 입금기한안내(가상계좌만 가능)
	public boolean sendOrdrSchVbankRequest(MbrVO mbrVO, OrdrVO ordrVO) throws Exception {
		String tmpltCode = "Order_0002";
		
		String sPhoneNo = this.changeDevPhoneNo(true, mbrVO.getMblTelno());
		
		JSONObject param = this.msgOrder0002(tmpltCode, mbrVO, ordrVO);
		
        boolean bResult = this.sendApiWithToken("/v2/kko/sendAlimTalk", sPhoneNo, param);
        
        this.getResultAll();
        
        return bResult;
	}

	// Order_0003 입금확인완료(가상계좌만 가능)
	public boolean sendOrdrBootpayVbankIncome(MbrVO mbrVO, OrdrVO ordrVO) throws Exception {
		String tmpltCode = "Order_0003";
		
		String sPhoneNo = this.changeDevPhoneNo(true, mbrVO.getMblTelno());
		
		JSONObject param = this.msgOrder0003(tmpltCode, mbrVO, ordrVO);
		
        boolean bResult = this.sendApiWithToken("/v2/kko/sendAlimTalk", sPhoneNo, param);
        
        this.getResultAll();
        
        return bResult;
	}

	// Order_0004 주문자동취소(가상계좌만 가능)
	public boolean sendOrdrSchVbankCancel(MbrVO mbrVO, OrdrVO ordrVO) throws Exception {
		String tmpltCode = "Order_0004";
		
		String sPhoneNo = this.changeDevPhoneNo(true, mbrVO.getMblTelno());
		
		JSONObject param = this.msgOrder0004(tmpltCode, mbrVO, ordrVO);
		
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

	// Order_0002 입금기한안내(가상계좌만 가능)
	private JSONObject msgOrder0002(String tmpltCode, MbrVO mbrVO, OrdrVO ordrVO) throws Exception {
		
		String jsonStr;
		
		JSONObject jsonObject;
		JSONParser jsonParser = new JSONParser();
		JSONArray btns = new JSONArray();
		JSONObject attach = new JSONObject();


		jsonStr = "{" + " \"name\":\"◼︎ 주문내역 확인\"," + " \"type\":\"WL\"" + " , \"url_mobile\":\"#{url}\", \"url_pc\":\"#{url}\"}" ;
		jsonStr = jsonStr.replace("#{url}", this.eroumOnHost + "/market/mypage/ordr/list");
		jsonObject= (JSONObject) jsonParser.parse(jsonStr);
		btns.add(jsonObject);

		attach.put("button", btns);
		
		String msg = "안녕하세요. #{회원이름}님!\r\n" + //
				"주문하신 상품에 대한 입금이 확인되지 않고 있습니다.\r\n" + //
				"\r\n" + //
				"주문일로부터 3일 이내에 입금이 되지 않으면 주문이 자동 취소됩니다.\r\n" + //
				"\r\n" + //
				"입금하실 금액 : #{입금 금액}\r\n" + //
				"입금 계좌번호 : #{은행명 가상계좌번호}\r\n" + //
				"예금주 : 티에이치케이컴퍼니\r\n" + //
				"입금 기한 : #{YYYY.MM.DD} 23시 59분\r\n" + //
				"\r\n" + //
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
		
		return param;
	}

	// Order_0003 입금확인완료(가상계좌만 가능)
	private JSONObject msgOrder0003(String tmpltCode, MbrVO mbrVO, OrdrVO ordrVO) throws Exception {
		
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

	// Order_0004 주문자동취소(가상계좌만 가능)
	private JSONObject msgOrder0004(String tmpltCode, MbrVO mbrVO, OrdrVO ordrVO) throws Exception {
		
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

    // Order_0005 주문완료(카드, 계좌이체)
	private JSONObject msgOrder0005(String tmpltCode, MbrVO mbrVO, OrdrVO ordrVO) throws Exception {
		
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
				"\r\n" + //
				"상품을 주문해 주셔서 감사합니다.\r\n" + //
				"빠른 배송이 될 수 있도록 노력하겠습니다.";
		
		
		msg = msg.replace("#{회원이름}", mbrVO.getMbrNm());
        
		
		JSONObject param = new JSONObject();
		
		param.put("tmpltCode", tmpltCode);
		param.put("senderKey", this.biztalkSenderKeyEroumOn);
		param.put("message", msg);
		param.put("attach", attach);
        param.put("header", "결제가 완료되었습니다.");
		
		return param;
	}

}
