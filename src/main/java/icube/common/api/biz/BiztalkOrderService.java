package icube.common.api.biz;


import org.json.simple.JSONObject;

import java.text.NumberFormat;
import java.util.Date;

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
		String tmpltCode;
		
		JSONObject param = null;
		String sPhoneNo = this.changeDevPhoneNo(true, mbrVO.getMblTelno());

		if (EgovStringUtil.equals(ordrMailTy, "BIZTALKSEND_ORDR_MARKET_PAYDONE_CARD")
			|| EgovStringUtil.equals(ordrMailTy, "BIZTALKSEND_ORDR_MARKET_PAYDONE_BANK")){
			//주문완료
			tmpltCode = "Order_0005";
			param = this.msgOrder0005(tmpltCode, mbrVO, ordrVO);
		}else if (EgovStringUtil.equals(ordrMailTy, "BIZTALKSEND_ORDR_MARKET_PAYDONE_VBANK")){
			//주문접수
			tmpltCode = "Order_0001";
			param = this.msgOrder0001(tmpltCode, mbrVO, ordrVO);
		}else if (EgovStringUtil.equals(ordrMailTy, "BIZTALKSEND_ORDR_MARKET_PAYDONE_FREE")){
			//주문완료(무료)
			tmpltCode = "Order_0017";
			param = this.msgOrder0017(tmpltCode, mbrVO, ordrVO);
		}else if (EgovStringUtil.equals(ordrMailTy, "BIZTALKSEND_ORDR_SCHEDULE_VBANK_REQUEST")){
			// 입금기한안내(가상계좌만 가능)
			tmpltCode = "Order_0002";
			param = this.msgOrder0002(tmpltCode, mbrVO, ordrVO);
		}else if (EgovStringUtil.equals(ordrMailTy, "BIZTALKSEND_ORDR_BOOTPAY_VBANK_INCOME")){
			//입금확인완료(가상계좌만 가능)
			tmpltCode = "Order_0003";
			param = this.msgOrder0003(tmpltCode, mbrVO, ordrVO);
		}else if (EgovStringUtil.equals(ordrMailTy, "BIZTALKSEND_ORDR_SCHEDULE_VBANK_CANCEL")){
			//주문자동취소(가상계좌만 가능)
			tmpltCode = "Order_0004";
			param = this.msgOrder0004(tmpltCode, mbrVO, ordrVO);
		}else if (EgovStringUtil.equals(ordrMailTy, "BIZTALKSEND_ORDR_SCHEDULE_CONFIRM_NOTICE")){
			//자동구매확정예정
			tmpltCode = "Order_0014";
			param = this.msgOrder0014(tmpltCode, mbrVO, ordrVO);
		}else if (EgovStringUtil.equals(ordrMailTy, "BIZTALKSEND_ORDR_SCHEDULE_CONFIRM_ACTION")){
			//	자동구매확정완료
			tmpltCode = "Order_0015";
			param = this.msgOrder0015(tmpltCode, mbrVO, ordrVO);
		}else if (EgovStringUtil.equals(ordrMailTy, "BIZTALKSEND_ORDR_MYPAGE_CONFIRM_ACTION")){
			//	구매확정완료
			tmpltCode = "Order_0016";
			param = this.msgOrder0016(tmpltCode, mbrVO, ordrVO);
		}else{
			throw new Exception("Not support type["+ordrMailTy+"]");
		}

		boolean bResult = this.sendApiWithToken("/v2/kko/sendAlimTalk", sPhoneNo, param);

		this.getResultAll();

		return bResult;
	}



	// Order_0014 자동구매확정예정
	public boolean sendOrdrSchConfirmNotice(MbrVO mbrVO, OrdrVO ordrVO) throws Exception {
		String tmpltCode = "Order_0014";
		
		String sPhoneNo = this.changeDevPhoneNo(true, mbrVO.getMblTelno());
		
		JSONObject param = this.msgOrder0014(tmpltCode, mbrVO, ordrVO);
		
        boolean bResult = this.sendApiWithToken("/v2/kko/sendAlimTalk", sPhoneNo, param);
        
        this.getResultAll();
        
        return bResult;
	}

	// Order_0015 자동구매확정완료
	public boolean sendOrdrSchConfirmAction(MbrVO mbrVO, OrdrVO ordrVO) throws Exception {
		String tmpltCode = "Order_0015";
		
		String sPhoneNo = this.changeDevPhoneNo(true, mbrVO.getMblTelno());
		
		JSONObject param = this.msgOrder0015(tmpltCode, mbrVO, ordrVO);
		
        boolean bResult = this.sendApiWithToken("/v2/kko/sendAlimTalk", sPhoneNo, param);
        
        this.getResultAll();
        
        return bResult;
	}

	// Order_0016 사용자-구매확정완료
	public boolean sendOrdrMypageConfirmAction(MbrVO mbrVO, OrdrVO ordrVO) throws Exception {
		String tmpltCode = "Order_0016";
		
		String sPhoneNo = this.changeDevPhoneNo(true, mbrVO.getMblTelno());
		
		JSONObject param = this.msgOrder0016(tmpltCode, mbrVO, ordrVO);
		
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


		jsonStr = "{" + " \"name\":\"주문내역 확인\"," + " \"type\":\"WL\"" + " , \"url_mobile\":\"#{url}\", \"url_pc\":\"#{url}\"}" ;
		jsonStr = jsonStr.replace("#{url}", this.eroumOnHost + "/market/mypage/ordr/list");
		jsonObject= (JSONObject) jsonParser.parse(jsonStr);
		btns.add(jsonObject);

		attach.put("button", btns);

        JSONArray itemList = new JSONArray();
		jtemp = new JSONObject();
		jtemp.put("title", "접수일자");
		jtemp.put("description", DateUtil.getDateTime(ordrVO.getOrdrDt(), "yyyy-MM-dd"));
        itemList.add(jtemp);
		jtemp = new JSONObject();
		jtemp.put("title", "주문번호");
		jtemp.put("description", ordrVO.getOrdrCd());
        itemList.add(jtemp);
        item.put("list", itemList);

        attach.put("item", item);


		jtemp = new JSONObject();
		jtemp.put("title", this.getHighlightTitle(ordrVO));
		jtemp.put("description", "주문상품");
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


		jsonStr = "{" + " \"name\":\"주문내역 확인\"," + " \"type\":\"WL\"" + " , \"url_mobile\":\"#{url}\", \"url_pc\":\"#{url}\"}" ;
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
		param.put("title", "입금 기한 안내");

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


		jsonStr = "{" + " \"name\":\"주문내역 확인\"," + " \"type\":\"WL\"" + " , \"url_mobile\":\"#{url}\", \"url_pc\":\"#{url}\"}" ;
		jsonStr = jsonStr.replace("#{url}", this.eroumOnHost + "/market/mypage/ordr/list");
		jsonObject= (JSONObject) jsonParser.parse(jsonStr);
		btns.add(jsonObject);

		attach.put("button", btns);

        JSONArray itemList = new JSONArray();
		jtemp = new JSONObject();
		jtemp.put("title", "주문일자");
		jtemp.put("description", DateUtil.getDateTime(ordrVO.getOrdrDt(), "yyyy-MM-dd"));
        itemList.add(jtemp);
		jtemp = new JSONObject();
		jtemp.put("title", "주문번호");
		jtemp.put("description", ordrVO.getOrdrCd());
        itemList.add(jtemp);
		jtemp = new JSONObject();
		jtemp.put("title", "입금 완료");
		jtemp.put("description", NumberFormat.getInstance().format(ordrVO.getStlmAmt()));
        itemList.add(jtemp);
        item.put("list", itemList);

        attach.put("item", item);


		jtemp = new JSONObject();
		jtemp.put("title", this.getHighlightTitle(ordrVO));
		jtemp.put("description", "주문상품");
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
        param.put("header", "입금이 확인되었습니다.");
		
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


		jsonStr = "{" + " \"name\":\"주문내역 확인\"," + " \"type\":\"WL\"" + " , \"url_mobile\":\"#{url}\", \"url_pc\":\"#{url}\"}" ;
		jsonStr = jsonStr.replace("#{url}", this.eroumOnHost + "/market/mypage/ordr/list");
		jsonObject= (JSONObject) jsonParser.parse(jsonStr);
		btns.add(jsonObject);

		attach.put("button", btns);

        JSONArray itemList = new JSONArray();
		jtemp = new JSONObject();
		jtemp.put("title", "취소일자");
		jtemp.put("description", DateUtil.getDateTime(new Date(), "yyyy-MM-dd"));
        itemList.add(jtemp);
		jtemp = new JSONObject();
		jtemp.put("title", "주문번호");
		jtemp.put("description", ordrVO.getOrdrCd());
        itemList.add(jtemp);
        item.put("list", itemList);

        attach.put("item", item);


		jtemp = new JSONObject();
		jtemp.put("title", this.getHighlightTitle(ordrVO));
		jtemp.put("description", "주문상품");
		attach.put("item_highlight", jtemp);
		
		String msg = "안녕하세요. #{회원이름}님!\r\n" + //
				"입금이 기한 내 이루어지지 않아 주문이 취소되었습니다.\r\n" + //
				"\r\n" + //
				"감사합니다.";
		
		
		msg = msg.replace("#{회원이름}", mbrVO.getMbrNm());
        
		
		JSONObject param = new JSONObject();
		
		param.put("tmpltCode", tmpltCode);
		param.put("senderKey", this.biztalkSenderKeyEroumOn);
		param.put("message", msg);
		param.put("attach", attach);
        param.put("header", "주문이 자동 취소되었습니다.");
		
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


		jsonStr = "{" + " \"name\":\"주문내역 확인\"," + " \"type\":\"WL\"" + " , \"url_mobile\":\"#{url}\", \"url_pc\":\"#{url}\"}" ;
		jsonStr = jsonStr.replace("#{url}", this.eroumOnHost + "/market/mypage/ordr/list");
		jsonObject= (JSONObject) jsonParser.parse(jsonStr);
		btns.add(jsonObject);

		attach.put("button", btns);

        JSONArray itemList = new JSONArray();
		jtemp = new JSONObject();
		jtemp.put("title", "주문일자");
		jtemp.put("description", DateUtil.getDateTime(ordrVO.getOrdrDt(), "yyyy-MM-dd"));
        itemList.add(jtemp);
		jtemp = new JSONObject();
		jtemp.put("title", "주문번호");
		jtemp.put("description", ordrVO.getOrdrCd());
        itemList.add(jtemp);
		jtemp = new JSONObject();
		jtemp.put("title", "결제 완료");
		jtemp.put("description", NumberFormat.getInstance().format(ordrVO.getStlmAmt()));
        itemList.add(jtemp);
        item.put("list", itemList);

        attach.put("item", item);

		jtemp = new JSONObject();
		jtemp.put("title", this.getHighlightTitle(ordrVO));
		jtemp.put("description", "주문상품");
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

	// Order_0017 주문완료(무료)
	private JSONObject msgOrder0017(String tmpltCode, MbrVO mbrVO, OrdrVO ordrVO) throws Exception {
		
		return null;
	}

	// Order_0014 자동구매확정예정
	private JSONObject msgOrder0014(String tmpltCode, MbrVO mbrVO, OrdrVO ordrVO) throws Exception {
		String jsonStr;
		
		JSONObject jsonObject;
		JSONParser jsonParser = new JSONParser();
		JSONArray btns = new JSONArray();
		JSONObject attach = new JSONObject();


		jsonStr = "{" + " \"name\":\"구매확정하기\"," + " \"type\":\"WL\"" + " , \"url_mobile\":\"#{url}\", \"url_pc\":\"#{url}\"}" ;
		jsonStr = jsonStr.replace("#{url}", this.eroumOnHost + "/market");
		jsonObject= (JSONObject) jsonParser.parse(jsonStr);
		btns.add(jsonObject);

		attach.put("button", btns);
		
		String msg = "안녕하세요. #{회원이름}님!\r\n" + //
				"\r\n" + //
				"주문하신 상품은 잘 받으셨나요?\r\n" + //
				"상품을 받으신 후 만족하셨다면 구매확정 부탁드립니다.\r\n" + //
				"\r\n" + //
				"구매확정을 하지 않으실 경우 #{YYYY년 MM월 DD일}에 자동으로 구매가 확정될 예정입니다.\r\n" + //
				"\r\n" + //
				"구매확정 이후에는 교환 및 반품이 불가능하니 신중하게 결정해 주세요.\r\n" + //
				"\r\n" + //
				"감사합니다.";
		
		msg = msg.replace("#{회원이름}", mbrVO.getMbrNm());
		msg = msg.replace("#{YYYY년 MM월 DD일}", DateUtil.getDateTime(DateUtil.getDateAdd(new Date(), "date", 2), "yyyy-MM-dd"));
        
		
		JSONObject param = new JSONObject();
		
		param.put("tmpltCode", tmpltCode);
		param.put("senderKey", this.biztalkSenderKeyEroumOn);
		param.put("message", msg);
		param.put("attach", attach);
		param.put("title", "자동 구매확정 예정 안내");

		return param;
	}

	// Order_0015 자동구매확정완료
	private JSONObject msgOrder0015(String tmpltCode, MbrVO mbrVO, OrdrVO ordrVO) throws Exception {
		String jsonStr;
		
		JSONObject jsonObject;
		JSONParser jsonParser = new JSONParser();
		JSONArray btns = new JSONArray();
		JSONObject attach = new JSONObject();


		jsonStr = "{" + " \"name\":\"다른 상품도 구경하기\"," + " \"type\":\"WL\"" + " , \"url_mobile\":\"#{url}\", \"url_pc\":\"#{url}\"}" ;
		jsonStr = jsonStr.replace("#{url}", this.eroumOnHost + "/market");
		jsonObject= (JSONObject) jsonParser.parse(jsonStr);
		btns.add(jsonObject);

		attach.put("button", btns);
		
		String msg = "안녕하세요. #{회원이름}님!\r\n" + //
				"\r\n" + //
				"주문하신 상품이 자동으로 구매확정되었습니다.\r\n" + //
				"구매확정 이후에는 교환 및 반품 신청이 불가능합니다.\r\n" + //
				"\r\n" + //
				"이용해 주셔서 감사합니다.";
		
		msg = msg.replace("#{회원이름}", mbrVO.getMbrNm());
        
		
		JSONObject param = new JSONObject();
		
		param.put("tmpltCode", tmpltCode);
		param.put("senderKey", this.biztalkSenderKeyEroumOn);
		param.put("message", msg);
		param.put("attach", attach);
		param.put("title", "자동 구매확정 안내");

		return param;
	}

	// Order_0016 구매확정완료
	private JSONObject msgOrder0016(String tmpltCode, MbrVO mbrVO, OrdrVO ordrVO) throws Exception {
		String jsonStr;
		
		JSONObject jsonObject;
		JSONParser jsonParser = new JSONParser();
		JSONArray btns = new JSONArray();
		JSONObject attach = new JSONObject();


		jsonStr = "{" + " \"name\":\"다른 상품도 구경하기\"," + " \"type\":\"WL\"" + " , \"url_mobile\":\"#{url}\", \"url_pc\":\"#{url}\"}" ;
		jsonStr = jsonStr.replace("#{url}", this.eroumOnHost + "/market");
		jsonObject= (JSONObject) jsonParser.parse(jsonStr);
		btns.add(jsonObject);

		attach.put("button", btns);
		
		String msg = "안녕하세요. #{회원이름}님!\r\n" + //
				"\r\n" + //
				"주문하신 상품이 구매확정되었습니다.\r\n" + //
				"구매확정 이후에는 교환 및 반품 신청이 불가능합니다.\r\n" + //
				"\r\n" + //
				"이용해 주셔서 감사합니다.";
		
		msg = msg.replace("#{회원이름}", mbrVO.getMbrNm());
        
		
		JSONObject param = new JSONObject();
		
		param.put("tmpltCode", tmpltCode);
		param.put("senderKey", this.biztalkSenderKeyEroumOn);
		param.put("message", msg);
		param.put("attach", attach);
		param.put("title", "구매확정 완료");

		return param;
	}

	private String getHighlightTitle(OrdrVO ordrVO){
		String title = ordrVO.getOrdrDtlList().get(0).getGdsNm();
		if (title.length() > 15) title = title.substring(0, 14) + "...";
		if (ordrVO.getOrdrDtlList().size() > 1){
			title += " 외 "+ (ordrVO.getOrdrDtlList().size()-1) +" 건";
		}

		return title;
	}
}
