package icube.common.api.biz;

import org.json.simple.JSONObject;
import org.json.simple.JSONArray;
import org.json.simple.parser.JSONParser;
import org.springframework.stereotype.Service;

import icube.common.util.DateUtil;
import icube.common.values.CodeMap;
import icube.manage.mbr.mbr.biz.MbrVO;
import icube.manage.mbr.recipients.biz.MbrRecipientsVO;
import icube.manage.members.bplc.biz.BplcVO;

@SuppressWarnings("unchecked")
@Service("biztalkConsultService")
public class BiztalkConsultService extends BiztalkApiService {


	// ON_0001 이로움ON회원_가입완료 biztalkApiService.sendJoinComleted("이동열", "010-2808-9178");
	public boolean sendOnJoinComleted(MbrVO mbrVO) throws Exception {
		String tmpltCode = "ON_0001";
		
		String sPhoneNo = this.changeDevPhoneNo(false, mbrVO.getMblTelno());
				
		JSONObject param = this.msgOn0001(tmpltCode, mbrVO.getMbrNm());

		return this.sendApiWithToken("/v2/kko/sendAlimTalk", sPhoneNo, param);
	}

	// ON_0004 이로움ON회원_상담신청취소 biztalkApiService.sendTalkCancel("이동열", "010-2808-9178");
	public boolean sendOnTalkCancel(MbrVO mbrVO, MbrRecipientsVO mbrRecipientsVO, int consltID) throws Exception {
		String tmpltCode = "ON_0004";
		
		String sPhoneNo = this.changeDevPhoneNo(false, mbrVO.getMblTelno());
				
		JSONObject param = this.msgOn0004(tmpltCode, mbrVO, mbrRecipientsVO);
		
        boolean bResult = this.sendApiWithToken("/v2/kko/sendAlimTalk", sPhoneNo, param);
        
        this.getResultAll();
        
        return bResult;
	}
	
	// ON_0002 이로움ON회원_상담접수완료 biztalkApiService.sendTalkCreated("이동열", "010-2808-9178");
	public boolean sendOnTalkCreated(MbrVO mbrVO, MbrRecipientsVO mbrRecipientsVO, int consltID) throws Exception {
		String tmpltCode = "ON_0002";
		
		String sPhoneNo = this.changeDevPhoneNo(false, mbrVO.getMblTelno());
				
		JSONObject param = this.msgOn0002(tmpltCode, mbrVO, mbrRecipientsVO);
		
        boolean bResult = this.sendApiWithToken("/v2/kko/sendAlimTalk", sPhoneNo, param);
        
        // this.getResultAll();
        
        return bResult;
	}

	// ON_0003 이로움ON회원_재상담접수완료 biztalkApiService.sendTalkMatchAgain("이동열", "010-2808-9178");
	public boolean sendOnTalkMatchAgain(MbrVO mbrVO, MbrRecipientsVO mbrRecipientsVO, int consltID, int consltCompletedCnt) throws Exception {
		String tmpltCode = "ON_0003";
		
		String sPhoneNo = this.changeDevPhoneNo(false, mbrVO.getMblTelno());
				
		JSONObject param = this.msgOn0003(tmpltCode, mbrVO, mbrRecipientsVO, consltCompletedCnt);
		
        boolean bResult = this.sendApiWithToken("/v2/kko/sendAlimTalk", sPhoneNo, param);
        
        // this.getResultAll();
        
        return bResult;
	}
	
	// ON_0005 이로움ON회원_매칭완료(공통) biztalkApiService.sendTalkMatchAgain("이동열", "010-2808-9178");
	public boolean sendOnTalkMatched(MbrVO mbrVO, MbrRecipientsVO mbrRecipientsVO, BplcVO bplcVO, int consltID) throws Exception {
		String tmpltCode = "ON_0005";
		
		String sPhoneNo = this.changeDevPhoneNo(false, mbrVO.getMblTelno());
		
		JSONObject param = this.msgOn0005(tmpltCode, mbrVO, mbrRecipientsVO, bplcVO);
		
        boolean bResult = this.sendApiWithToken("/v2/kko/sendAlimTalk", sPhoneNo, param);
        
        // this.getResultAll();
        
        return bResult;
	}

	// Care_0001 사업소_수급자매칭 biztalkApiService.sendCareTalkMatched("사업소", "010-2808-9178");
	public boolean sendCareTalkMatched(BplcVO bplcVO, int consltID, int bplcConsltNo) throws Exception {
		String tmpltCode = "Care_0001";
		
		String sPhoneNo = this.changeDevPhoneNo(true, bplcVO.getPicTelno());
		
		JSONObject param = this.msgCare0001(tmpltCode, bplcVO.getBplcNm(), bplcConsltNo);
		
        boolean bResult = this.sendApiWithToken("/v2/kko/sendAlimTalk", sPhoneNo, param);
        
        // this.getResultAll();
        
        return bResult;
	}
	
	// Care_0002 사업소_수급자매칭 biztalkApiService.sendCareTalkCancel("사업소", "010-2808-9178");
	public boolean sendCareTalkCancel(BplcVO bplcVO, int consltID) throws Exception {
		String tmpltCode = "Care_0002";
		
		String sPhoneNo = this.changeDevPhoneNo(true, bplcVO.getPicTelno());

		JSONObject param = this.msgCare0002(tmpltCode, bplcVO.getBplcNm());
		
        boolean bResult = this.sendApiWithToken("/v2/kko/sendAlimTalk", sPhoneNo, param);
        
        // this.getResultAll();
        
        return bResult;
	}

	// Care_0003 대기 중 상담 안내
	public boolean sendCareTalkDelayed(BplcVO bplcVO, int consltID, int bplcConsltNo) throws Exception {
		String tmpltCode = "Care_0003";
		
		String sPhoneNo = this.changeDevPhoneNo(true, bplcVO.getPicTelno());
		
		JSONObject param = this.msgCare0003(tmpltCode, bplcVO.getBplcNm(), bplcConsltNo);
		
        boolean bResult = this.sendApiWithToken("/v2/kko/sendAlimTalk", sPhoneNo, param);
        
        // this.getResultAll();
        
        return bResult;
	}

	// Care_0004 상담 완료 요청
	public boolean sendCareTalkAttention(BplcVO bplcVO, int consltID, int bplcConsltNo) throws Exception {
		String tmpltCode = "Care_0004";
		
		String sPhoneNo = this.changeDevPhoneNo(true, bplcVO.getPicTelno());
		
		JSONObject param = this.msgCare0004(tmpltCode, bplcVO.getBplcNm(), bplcConsltNo);
		
        boolean bResult = this.sendApiWithToken("/v2/kko/sendAlimTalk", sPhoneNo, param);
        
        // this.getResultAll();
        
        return bResult;
	}
	

	// ON_0001 이로움ON 회원가입이 완료되었습니다
	private JSONObject msgOn0001(String tmpltCode, String mbrNm) throws Exception {
		
		String jsonStr;
		
		
		JSONObject jsonObject;
		JSONParser jsonParser = new JSONParser();
		JSONArray list = new JSONArray();
		
		jsonStr = "{" + " \"name\":\"채널 추가\"," + " \"type\":\"AC\"" + "}" ;
		jsonObject= (JSONObject) jsonParser.parse(jsonStr);
		list.add(jsonObject);
		
		jsonStr = "{" + " \"name\":\"◼︎ 이로움ON 바로가기\"," + " \"type\":\"WL\"" + " , \"url_mobile\":\"#{url}/\", \"url_pc\":\"#{url}/\"}" ;
		jsonStr = jsonStr.replace("#{url}", "https://eroum.co.kr");//URL 고정
		jsonObject= (JSONObject) jsonParser.parse(jsonStr);
		list.add(jsonObject);
		
		
		JSONObject btn = new JSONObject();
		btn.put("button", list);
		
		String msg = "안녕하세요, #{회원이름}님\n"
				+ "이로움ON 회원가입이 완료되었습니다.\n"
				+ "\n"
				+ "이로움ON을 통해 시니어들을 위한 다양한 생활용품과 노인장기요양보험 지원 혜택 및 복지 정보를 확인해 보세요!";
		
		
		msg = msg.replace("#{회원이름}", mbrNm);
		
		JSONObject param = new JSONObject();
		
		param.put("tmpltCode", tmpltCode);
		param.put("senderKey", this.biztalkSenderKeyEroumOn);
		param.put("message", msg);
		param.put("title", "회원가입 완료");
		param.put("attach", btn);
		
		return param;
	}

	// ON_0002 상담을 신청해 주셔서 감사합니다.
	private JSONObject msgOn0002(String tmpltCode, MbrVO mbrVO, MbrRecipientsVO mbrRecipientsVO) throws Exception {
		
		String jsonStr;
		
		JSONObject jsonObject;
		JSONParser jsonParser = new JSONParser();
		JSONArray list = new JSONArray();
		
		jsonStr = "{" + " \"name\":\"◼︎ 상담내역 바로가기\"," + " \"type\":\"WL\"" + " , \"url_mobile\":\"#{url}\", \"url_pc\":\"#{url}\"}" ;
		jsonStr = jsonStr.replace("#{url}", this.eroumOnHost + "/membership/conslt/appl/list");
		jsonObject= (JSONObject) jsonParser.parse(jsonStr);
		list.add(jsonObject);
		
		
		JSONObject btn = new JSONObject();
		btn.put("button", list);
		
		String timeInFormat = DateUtil.getCurrentDateTime("yyyy-MM-dd");
		
		String msg = "#{회원이름}님, 상담을 신청해 주셔서 감사합니다.\r\n" + //
				"\r\n" + //
				"[수급자 정보]\r\n" + //
				"성명: #{수급자 성명} 님\r\n" + //
				"회원님과의 관계 : #{가족 관계}\r\n" + //
				"상담 신청일 : #{YYYY-MM-DD}\r\n" + //
				"\r\n" + //
				"장기요양기관과 상담 매칭 완료 시 안내드리겠습니다. 감사합니다.";
		
		
		msg = msg.replace("#{회원이름}", mbrVO.getMbrNm());
		msg = msg.replace("#{YYYY-MM-DD}", timeInFormat);

		msg = msg.replace("#{수급자 성명}", mbrRecipientsVO.getRecipientsNm());
		msg = msg.replace("#{가족 관계}", CodeMap.MBR_RELATION_CD.get(mbrRecipientsVO.getRelationCd()));
		
		JSONObject param = new JSONObject();
		
		param.put("tmpltCode", tmpltCode);
		param.put("senderKey", this.biztalkSenderKeyEroumOn);
		param.put("message", msg);
		param.put("title", "상담 접수 완료");
		param.put("attach", btn);
		
		return param;
	}

	// ON_0003 #{회원이름}님, 재상담을 신청해 주셔서 감사합니다.
	private JSONObject msgOn0003(String tmpltCode, MbrVO mbrVO, MbrRecipientsVO mbrRecipientsVO, int consltCompletedCnt) throws Exception {
		
		String jsonStr;
		
		JSONObject jsonObject;
		JSONParser jsonParser = new JSONParser();
		JSONArray list = new JSONArray();
		
		jsonStr = "{" + " \"name\":\"◼︎ 상담내역 바로가기\"," + " \"type\":\"WL\"" + " , \"url_mobile\":\"#{url}\", \"url_pc\":\"#{url}\"}" ;
		jsonStr = jsonStr.replace("#{url}", this.eroumOnHost + "/membership/conslt/appl/list");
		jsonObject= (JSONObject) jsonParser.parse(jsonStr);
		list.add(jsonObject);
		
		String timeInFormat = DateUtil.getCurrentDateTime("yyyy-MM-dd");
		
		JSONObject btn = new JSONObject();
		btn.put("button", list);
		
		String msg = "#{회원이름}님, 재상담을 신청해 주셔서 감사합니다.\r\n" + //
				"\r\n" + //
				"[수급자 정보]\r\n" + //
				"성명: #{수급자 성명} 님\r\n" + //
				"회원님과의 관계 : #{가족 관계}\r\n" + //
				"상담 신청일 : #{YYYY-MM-DD}\r\n" + //
				"\r\n" + //
				"재상담은 총 2회 가능합니다.\r\n" + //
				"- 현재 재상담 #{n}회 신청 중\r\n" + //
				"\r\n" + //
				"장기요양기관과 상담 매칭 완료 시 안내드리겠습니다. 감사합니다.";
		
		
		msg = msg.replace("#{회원이름}", mbrVO.getMbrNm());

		msg = msg.replace("#{YYYY-MM-DD}", timeInFormat);

		msg = msg.replace("#{n}", String.valueOf(consltCompletedCnt));

		msg = msg.replace("#{수급자 성명}", mbrRecipientsVO.getRecipientsNm());
		msg = msg.replace("#{가족 관계}", CodeMap.MBR_RELATION_CD.get(mbrRecipientsVO.getRelationCd()));
		
		JSONObject param = new JSONObject();
		
		param.put("tmpltCode", tmpltCode);
		param.put("senderKey", this.biztalkSenderKeyEroumOn);
		param.put("message", msg);
		param.put("title", "재상담 접수 완료");
		param.put("attach", btn);
		
		return param;
	}

	// ON_0004 #{회원이름}님, 요청하신 1:1 상담이 취소되었습니다
	private JSONObject msgOn0004(String tmpltCode, MbrVO mbrVO, MbrRecipientsVO mbrRecipientsVO) throws Exception {
		
		String jsonStr;
		
		JSONObject jsonObject;
		JSONParser jsonParser = new JSONParser();
		JSONArray list = new JSONArray();
		
		jsonStr = "{" + " \"name\":\"◼︎ 요양정보 간편조회\"," + " \"type\":\"WL\"" + " , \"url_mobile\":\"#{url}\", \"url_pc\":\"#{url}\"}" ;
		jsonStr = jsonStr.replace("#{url}", this.eroumOnHost + "/main/recipter/sub");
		jsonObject= (JSONObject) jsonParser.parse(jsonStr);
		list.add(jsonObject);
		
		jsonStr = "{" + " \"name\":\"◼︎ 인정등급 예상 테스트\"," + " \"type\":\"WL\"" + " , \"url_mobile\":\"#{url}\", \"url_pc\":\"#{url}\"}" ;
		jsonStr = jsonStr.replace("#{url}", this.eroumOnHost + "/main/cntnts/test");
		jsonObject= (JSONObject) jsonParser.parse(jsonStr);
		list.add(jsonObject);
		
		
		JSONObject btn = new JSONObject();
		btn.put("button", list);
		
		String timeInFormat = DateUtil.getCurrentDateTime("yyyy-MM-dd");
		
		String msg = "#{회원이름}님, 요청하신 1:1 상담이 취소되었습니다.\r\n" + //
				"\r\n" + //
				"[수급자 정보]\r\n" + //
				"성명: #{수급자 성명} 님\r\n" + //
				"회원님과의 관계 : #{가족 관계}\r\n" + //
				"상담 취소일 : #{YYYY-MM-DD}\r\n" + //
				"\r\n" + //
				"상담을 원하시는 경우 이로움ON에서 다시 상담을 요청해 주세요.";
		
		
		msg = msg.replace("#{회원이름}", mbrVO.getMbrNm());
		msg = msg.replace("#{YYYY-MM-DD}", timeInFormat);

		msg = msg.replace("#{수급자 성명}", mbrRecipientsVO.getRecipientsNm());
		msg = msg.replace("#{가족 관계}", CodeMap.MBR_RELATION_CD.get(mbrRecipientsVO.getRelationCd()));
		
		JSONObject param = new JSONObject();
		
		param.put("tmpltCode", tmpltCode);
		param.put("senderKey", this.biztalkSenderKeyEroumOn);
		param.put("message", msg);
		param.put("title", "상담 취소 안내");
		param.put("attach", btn);
		
		return param;
	}

	// ON_0005 #{회원이름}님, 장기요양기관이 매칭되었습니다
	private JSONObject msgOn0005(String tmpltCode, MbrVO mbrVO, MbrRecipientsVO mbrRecipientsVO, BplcVO bplcVO) throws Exception {
		
		String jsonStr;
		
		JSONObject jsonObject;
		JSONParser jsonParser = new JSONParser();
		JSONArray list = new JSONArray();
		
		jsonStr = "{" + " \"name\":\"◼︎ 상담내역 바로가기\"," + " \"type\":\"WL\"" + " , \"url_mobile\":\"#{url}\", \"url_pc\":\"#{url}\"}" ;
		jsonStr = jsonStr.replace("#{url}", this.eroumOnHost + "/membership/conslt/appl/list");
		jsonObject= (JSONObject) jsonParser.parse(jsonStr);
		list.add(jsonObject);
		
		
		JSONObject btn = new JSONObject();
		btn.put("button", list);
		
		String msg = "#{회원이름}님, 장기요양기관이 매칭되었습니다.\r\n" + //
				"\r\n" + //
				"[수급자 정보]\r\n" + //
				"성명: #{수급자 성명} 님\r\n" + //
				"회원님과의 관계 : #{가족 관계}\r\n" + //
				"\r\n" + //
				"48시간(2일/영업일 기준) 이내에 #{장기요양기관명}에서 연락드릴 예정입니다.\r\n" + //
				"감사합니다.\r\n" + //
				"\r\n" + //
				"◼︎ 장기요양기관명 : #{장기요양기관명}";
		
		
		msg = msg.replace("#{회원이름}", mbrVO.getMbrNm());
		msg = msg.replace("#{장기요양기관명}", bplcVO.getBplcNm());

		msg = msg.replace("#{수급자 성명}", mbrRecipientsVO.getRecipientsNm());
		msg = msg.replace("#{가족 관계}", CodeMap.MBR_RELATION_CD.get(mbrRecipientsVO.getRelationCd()));
		
		JSONObject param = new JSONObject();
		
		param.put("tmpltCode", tmpltCode);
		param.put("senderKey", this.biztalkSenderKeyEroumOn);
		param.put("message", msg);
		param.put("title", "1:1상담 매칭 완료");
		param.put("attach", btn);
		
		return param;
	}

	// Care_0001 사업소_수급자매칭 사업소님, 1:1 상담이 매칭되었습니다.
	private JSONObject msgCare0001(String tmpltCode, String bplcNm, int bplcConsltNo) throws Exception {
		
		String jsonStr;
		
		JSONObject jsonObject;
		JSONParser jsonParser = new JSONParser();
		JSONArray list = new JSONArray();
		jsonStr = "{" + " \"name\":\"◼︎ 매칭된 상담 확인하기\"," + " \"type\":\"WL\"" + " , \"url_mobile\":\"#{url}\", \"url_pc\":\"#{url}\"}" ;
		jsonStr = jsonStr.replace("#{url}", this.careHost + "/shop/eroumon_members_conslt_view.php?consltID=" + bplcConsltNo);
		jsonObject= (JSONObject) jsonParser.parse(jsonStr);
		list.add(jsonObject);
		
		
		JSONObject btn = new JSONObject();
		btn.put("button", list);
		
		String msg = "[1:1 상담 매칭 완료]\n" + //
				"\n" + //
				"#{장기요양기관명} 사업소님, 1:1 상담이 매칭되었습니다.\n" + //
				"아래 버튼을 눌러 상담 요청자 정보 확인 후, 상담진행 요청드립니다.\n" + //
				"\n" + //
				"상담 완료 후, 상담 완료 버튼을 꼭 눌러주세요.\n" + //
				"상담 완료 전에 상담 내용도 자유롭게 작성하실 수 있습니다.\n" + //
				"\n" + //
				"사업소의 상담 내용을 반영하여 더욱 만족하실 수 있는 이로움이 되겠습니다. 감사합니다.";
		
		
		msg = msg.replace("#{장기요양기관명}", bplcNm);
		
		JSONObject param = new JSONObject();
		
		param.put("tmpltCode", tmpltCode);
		param.put("senderKey", this.biztalkSenderKeyEroumcare);
		param.put("message", msg);
		param.put("attach", btn);
		
		return param;
	}
	
	// Care_0002 사업소_상담취소 사업소님, 1:1 상담 매칭 취소.
	private JSONObject msgCare0002(String tmpltCode, String bplcNm) throws Exception {
		
		String jsonStr;
		
		JSONObject jsonObject;
		JSONParser jsonParser = new JSONParser();
		JSONArray list = new JSONArray();
		
		jsonStr = "{" + " \"name\":\"◼︎ 상담관리 바로가기\"," + " \"type\":\"WL\"" + " , \"url_mobile\":\"#{url}\", \"url_pc\":\"#{url}\"}" ;
		jsonStr = jsonStr.replace("#{url}", this.careHost + "/shop/eroumon_members_conslt_list.php");
		jsonObject= (JSONObject) jsonParser.parse(jsonStr);
		list.add(jsonObject);
		
		
		JSONObject btn = new JSONObject();
		btn.put("button", list);
		
		String msg = "[1:1 상담 매칭 취소]\r\n"
				+ "\r\n"
				+ "#{장기요양기관명} 사업소님, 상담 요청자에 의해 1:1 상담 매칭이 취소되었습니다.\r\n"
				+ "\r\n"
				+ "아래 버튼을 누르면 수급자 상담관리 페이지로 바로 이동됩니다.";
		
		
		msg = msg.replace("#{장기요양기관명}", bplcNm);
		
		JSONObject param = new JSONObject();
		
		param.put("tmpltCode", tmpltCode);
		param.put("senderKey", this.biztalkSenderKeyEroumcare);
		param.put("message", msg);
		param.put("attach", btn);
		
		return param;
	}

	// Care_0003 대기 중 상담 안내
	private JSONObject msgCare0003(String tmpltCode, String bplcNm, int bplcConsltNo) throws Exception {
		
		String jsonStr;
		
		JSONObject jsonObject;
		JSONParser jsonParser = new JSONParser();
		JSONArray list = new JSONArray();
		
		jsonStr = "{" + " \"name\":\"◼︎ 상담 수락하기\"," + " \"type\":\"WL\"" + " , \"url_mobile\":\"#{url}\", \"url_pc\":\"#{url}\"}" ;
		jsonStr = jsonStr.replace("#{url}", this.careHost + "/shop/eroumon_members_conslt_view.php?consltID=" + bplcConsltNo);
		jsonObject= (JSONObject) jsonParser.parse(jsonStr);
		list.add(jsonObject);
		
		
		JSONObject btn = new JSONObject();
		btn.put("button", list);
		
		String msg = "[대기 중 상담 안내]\r\n" 
				+"\r\n"
				+"#{장기요양기관명} 사업소님,\r\n"
				+ "대기 중인 1:1 상담이 있습니다.\r\n"
				+ "상담을 수락해 주세요.\r\n"
				+ "\r\n"
				+ "상담 완료 후 상담 내용을 자유롭게 작성 후 상담 완료 버튼을 꼭 눌러주세요.";
		
		
		msg = msg.replace("#{장기요양기관명}", bplcNm);
		
		JSONObject param = new JSONObject();
		
		param.put("tmpltCode", tmpltCode);
		param.put("senderKey", this.biztalkSenderKeyEroumcare);
		param.put("message", msg);
		param.put("attach", btn);
		
		return param;
	}

	// Care_0004 상담 완료 요청
	private JSONObject msgCare0004(String tmpltCode, String bplcNm, int bplcConsltNo) throws Exception {
		
		String jsonStr;
		
		JSONObject jsonObject;
		JSONParser jsonParser = new JSONParser();
		JSONArray list = new JSONArray();
		
		jsonStr = "{" + " \"name\":\"◼︎ 상담 수락하기\"," + " \"type\":\"WL\"" + " , \"url_mobile\":\"#{url}\", \"url_pc\":\"#{url}\"}" ;
		jsonStr = jsonStr.replace("#{url}", this.careHost + "/shop/eroumon_members_conslt_view.php?consltID=" + bplcConsltNo);
		jsonObject= (JSONObject) jsonParser.parse(jsonStr);
		list.add(jsonObject);
		
		
		JSONObject btn = new JSONObject();
		btn.put("button", list);
		
		String msg = "[상담 완료 요청]\r\n" 
				+"\r\n"
				+"#{장기요양기관명} 사업소님,\r\n"
				+ "완료되지 않은 1:1 상담이 있습니다.\r\n"
				+ "상담이 완료되었다면 상담완료 버튼을 꼭 눌러주세요.\r\n"
				+ "\r\n"
				+ "상담 완료 버튼을 누르기 전에 상담 내용도 자유롭게 작성하실 수 있습니다.\r\n"
				+ "\r\n"
				+ "사업소의 상담 내용을 반영하여 더욱 만족하실 수 있는 이로움이 되겠습니다. 감사합니다.";
		
		
		msg = msg.replace("#{장기요양기관명}", bplcNm);
		
		JSONObject param = new JSONObject();
		
		param.put("tmpltCode", tmpltCode);
		param.put("senderKey", this.biztalkSenderKeyEroumcare);
		param.put("message", msg);
		param.put("attach", btn);
		
		return param;
	}

}
