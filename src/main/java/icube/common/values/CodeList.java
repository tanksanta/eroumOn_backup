package icube.common.values;

import java.util.ArrayList;
import java.util.List;


public class CodeList {

	/** 첨부파일 제한 확장자 */
	public static final List<String> BAD_FILE_EXTENSION = new ArrayList<String>() {
		private static final long serialVersionUID = 1L;
		{
			add("bat");
			add("sh");
			add("exe");
			add("jsp");
			add("asp");
			add("php");
			add("html");
			add("perl");
			add("java");
			add("bash");
			add("app");
			add("pkg");
			add("rpm");
			add("deb");
		}
	};

	public static final List<String> MAIL_SEND_TY = new ArrayList<String>() {
		private static final long serialVersionUID = 2L;
		{
			add("MAILSEND_ORDR_CARD");//,"주문접수 카드"
			add("MAILSEND_ORDR_ACCOUNT");//,"주문접수 실시간계좌이체"
			add("MAILSEND_ORDR_VBANK");//,"주문접수 가상계좌"
			add("MAILSEND_ORDR_VBANK_RETRY");//,"주문확인 입금 독촉"
			add("MAILSEND_ORDR_VBANK_CANCEL");//,"주문확인 취소"
			add("MAILSEND_ORDR_VBANK_INCOME");//,"주문확인 입금완료"
		}
	};

	/*복지용구 그룹별 계산 로직 persistPeriodKind*/
	public static final List<String> WELTOOLS_ITEMGRP_PERSISTPERIODKIND = new ArrayList<String>() {
		private static final long serialVersionUID = 2L;
		{
			add("dayOne");
			add("dayCnt");
			add("period");
			add("rent");
		}
	};


	/*복지용구 그룹코드 리스트*/
	public static final List<String> WELTOOLS_ITEMGRP_CDS = new ArrayList<String>() {
		private static final long serialVersionUID = 2L;
		{
			add("mobileToilet");
			add("bathChair");
			add("walkerForAdults");
			add("safetyHandle");
			add("antiSlipProduct");
			add("antiSlipSocks");
			add("portableToilet");
			add("cane");
			add("cushion");
			add("changeTool");
			add("panties");
			add("inRunway");
			add("wheelchair");
			add("electricBed");
			add("manualBed");
			add("bathtub");
			add("bathLift");
			add("detector");
			add("outRunway");
			add("mattress");
			add("mattressS");
			add("mattressR");
		}
	};

	/*복지용구 그룹코드 명(롱텀에서 온 데이터와 맞추기 위해서)*/
	public static final List<String> WELTOOLS_ITEMGRP_NMS = new ArrayList<String>() {
		private static final long serialVersionUID = 3L;
		{
			add("이동변기");
			add("목욕의자");
			add("성인용보행기");
			add("안전손잡이");
			add("미끄럼 방지용품");
			add("미끄럼 방지양말");/* 롱텀에서는 미끄럼 방지용품으로 넘어오면 WELTOOLS_ITEM_SOCKS 에 있는 항목만 양말로 대체함 */
			add("간이변기");
			add("지팡이");
			add("욕창예방방석");
			add("자세변환용구");
			add("요실금팬티");
			add("경사로(실내용)");
			add("수동휠체어");
			add("전동침대");
			add("수동침대");
			add("이동욕조");
			add("목욕리프트");
			add("배회감지기");
			add("경사로(실외용)");
			add("욕창예방 매트리스");
			add("욕창예방 매트리스(판매)");
			add("욕창예방 매트리스(대여)");
		}
	};
	
	/*복지용구 그룹코드 명(롱텀에서 온 데이터와 맞추기 위해서) 복지용구 가능, 불가능은 이 이름으로 온다*/
	public static final List<String> WELTOOLS_ITEMGRP_NM_DISP = new ArrayList<String>() {
		private static final long serialVersionUID = 3L;
		{
			add("이동변기");
			add("목욕의자");
			add("성인용보행기");
			add("안전손잡이");
			add("미끄럼 방지매트/액");
			add("미끄럼 방지양말");
			add("간이변기");
			add("지팡이");
			add("욕창예방방석");
			add("자세변환용구");
			add("요실금팬티");
			add("경사로(실내용)");/*api에서 롱텀이랑 명칭 확인함*/
			add("수동휠체어");
			add("전동침대");
			add("수동침대");
			add("이동욕조");
			add("목욕리프트");
			add("배회감지기");
			add("경사로(실외용)");/*api에서 롱텀이랑 명칭 확인함*/
			add("욕창예방 매트리스");
			add("욕창예방 매트리스(판매)");
			add("욕창예방 매트리스(대여)");
		}
	};

	/*복지용구 양말 품목코드 리스트(현재 양말코드를 가지고 올 곳이 없어서 여기에 넣는다)*/
	public static final List<String> WELTOOLS_ITEM_SOCKS = new ArrayList<String>() {
		private static final long serialVersionUID = 4L;
		{
			add("F30091079105");
			add("F30091039113");
			add("F30091081101");
			add("F30091003106");
			add("F30091003101");
			add("F30091092103");
			add("F30091039108");
			add("H30090074001");
			add("H30090084004");
			add("F30091039101");
			add("F30091079103");
			add("F30091039103");
			add("F30091081103");
			add("H30090074002");
			add("F30091039111");
			add("F30091092101");
			add("F30091010106");
			add("F30091079102");
			add("F30091039106");
			add("F30091010104");
			add("F30091039102");
			add("F30091039110");
			add("F30091010103");
			add("F30091079104");
			add("F30091039115");
			add("F30091039107");
			add("F30091079101");
			add("F30091039105");
			add("F30091039114");
			add("F30091039109");
			add("F30091010102");
			add("F30091039112");
			add("F30091092102");
			add("F30090084101");
			add("F30091003107");
			add("F30091081102");
			add("F30091003104");
			add("H30090074004");
			add("F30091010105");
			add("F30091010101");
			add("H30090084003");
			add("F30091079107");
			add("H30090074003");
			add("F30091079106");
			add("F30091079108");
			add("F30090120106");
			add("F30090120104");
			add("H30090084002");
			add("F30090120105");
			add("H30090038003");
			add("F30091066104");
			add("F30091066101");
			add("F30090022002");
			add("F30091003103");
			add("H30090025007");
			add("F30090120108");
			add("H30090025008");
			add("H30090040002");
			add("F30091066102");
			add("F30090120109");
			add("F30091066103");
			add("F30091005104");
			add("H30090025004");
			add("F30090120103");
			add("F30091005105");
			add("F30091066105");
			add("F30090025103");
			add("F30090025101");
			add("H30090040001");
			add("H30090025003");
			add("F30091023102");
			add("F30091120101");
			add("F30091120104");
			add("F30091120103");
			add("F30091120102");
			add("F30091079109");
			add("F30091120107");
			add("F30091120105");
			add("F30091120106");
			add("F30090197001");
			add("F30090197002");
			add("F30090197003");
			add("F30090197004");
			add("F30090204001");
			add("F30090204002");
		}
	};
}