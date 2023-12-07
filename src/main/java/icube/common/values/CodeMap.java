package icube.common.values;

import java.util.HashMap;
import java.util.LinkedHashMap;

public class CodeMap{

	/**
	 * 공통 코드
	 */
	// 사용여부
	public static HashMap<String, String> USE_YN = new LinkedHashMap<String, String>(){
		private static final long serialVersionUID = 1L;
		{
			put("Y", "사용");
			put("N", "미사용");
		}
	};

	public static HashMap<String, String> PUBLIC_YN = new LinkedHashMap<String, String>(){
		private static final long serialVersionUID = 1L;
		{
			put("Y", "공개");
			put("N", "비공개");
		}
	};
	

	// 전시(노출)여부 > TO-DO : 명칭 재확인
	public static final HashMap<String, String> DSPY_YN = new LinkedHashMap<String, String>(){
		private static final long serialVersionUID = 1L;
		{
			put("Y", 	"전시");
			put("N", 	"미전시");
		}
	};

	// 진행 상태
	public static final HashMap<String, String> PLAY_STTUS = new LinkedHashMap<String, String>(){
		private static final long serialVersionUID = 1L;
		{
			put("Y", 	"진행중");
			put("N", 	"종료");
		}
	};

	// YES/NO 코드*/
	public static final HashMap<String, String> YN = new LinkedHashMap<String, String>() {
		private static final long serialVersionUID = 1L;
		{
			put("Y", "예");
			put("N", "아니오");
		}
	};

	// 확장자 종류
	public static HashMap<String, String> EXTN_KIND = new LinkedHashMap<String, String>(){
		private static final long serialVersionUID = 1L;
		{
			put("jpg", 	"JPEG");
			put("gif",  "GIF");
			put("png",  "PNG");
			put("hwp",  "HWP");
			put("hwpx", "HWPX");
			put("xls",  "Excel[97-2003호환]");
			put("xlsx", "Excel");
			put("doc",  "Word[97-2003호환]");
			put("docx", "Word");
			put("ppt", 	"파워포인트[97-2003호환]");
			put("pptx", "파워포인트");
			put("zip", 	"압축파일[ZIP]");
			put("pdf", 	"PDF");
			put("txt", 	"TEXT");
			put("mp4", 	"MP4");
			put("wmv", 	"WMV");
			put("avi", 	"AVI");
			put("ogg", 	"OGG");
		}
	};

	/**
	 * 게시판 코드맵
	 */
	// 게시판 타입 코드
	public static final HashMap<String, String> BBS_TY = new LinkedHashMap<String, String>() {
		private static final long serialVersionUID = 1L;
		{
			put("1", "일반형");
			put("2", "답글형");
			put("3", "이미지");
			put("4", "동영상");
			put("5", "Q&A");
			put("6", "FAQ");
		}
	};

	/**
	 * 관리자 코드맵
	 */
	// 관리자 타입
	public static final HashMap<String, String> MNGR_AUTH_TY = new LinkedHashMap<String, String>() {
		private static final long serialVersionUID = -5324653792524470211L;
		{
			put("1", "최고관리자");
			put("2", "일반관리자");
		}
	};

	// 관리자 업무 구분
	public static final HashMap<String, String> MNGR_JOB_TY = new LinkedHashMap<String, String>() {
		private static final long serialVersionUID = 5995867866049487955L;

		{
			put("1", "CS");
			put("2", "정산");
			put("3", "영업");
			put("4", "마케팅");
		}
	};

	//관리자 권한변경 로그 타입
	public static final HashMap<String, String> MNGR_AUTH_LOG_TY = new LinkedHashMap<String, String>() {
		private static final long serialVersionUID = -4323401359653528264L;
		{
			put("CM", "계정생성");
			put("UM", "계정수정");
			put("DM", "계정삭제");

			put("UP", "비밀번호변경");
			put("UA", "권한변경");
		}
	};

	//관리자로그 타입
	public static final HashMap<String, String> MNG_LOG_TY = new LinkedHashMap<String, String>() {
		private static final long serialVersionUID = -6026583178682475028L;
		{
			put("LI", "로그인");
			put("LO", "로그아웃");
			put("C", "등록");
			put("LR", "리스트조회");
			put("VR", "상세조회");
			put("U", "수정");
			put("D", "삭제");
			put("DN", "다운로드");
		}
	};
	/** 관리자 메뉴 타입 */
	public static final HashMap<String, String> MNG_MENU_TY = new LinkedHashMap<String, String>() {
		private static final long serialVersionUID = -3859535837947345899L;
		{
			put("1", "기본 메뉴"); //삭제 불가
			put("2", "기본 기능"); //삭제 불가
			put("3", "추가 메뉴");
			put("4", "추가 기능");
		}
	};

	/**
	 * 상품 코드맵
	 */
	// 급여-비급여
	public static final HashMap<String, String> GDS_TY = new LinkedHashMap<String, String>() {
		private static final long serialVersionUID = -3340533651232280595L;
		{
			put("R", "급여상품(판매)"); // reimbursement > 보험관련용어
			put("L", "급여상품(대여)"); // 대여상품 추가
			put("N", "비급여상품"); // non-reimbursement
		}
	};

	// 상품태그
	public static final HashMap<String, String> GDS_TAG = new LinkedHashMap<String, String>() {
		private static final long serialVersionUID = 3248778213644085591L;
		{
			put("A", "품절");
			put("B", "일부옵션품절");
			put("C", "일시품절");
			put("D", "설치");
		}
	};

	// 배송비 유형
	public static final HashMap<String, String> DLVY_COST_TY = new LinkedHashMap<String, String>() {
		private static final long serialVersionUID = 3248778213644085591L;
		{
			put("FREE", "무료");
			put("PAY", "유료");
		}
	};

	// 배송비 결제 유형
	public static final HashMap<String, String> DLVY_PAY_TY = new LinkedHashMap<String, String>() {
		private static final long serialVersionUID = 3248778213644085591L;
		{
			put("PREPAID", "선불"); //PREPAID
			put("COLLECT", "착불"); //COLLECT
		}
	};

	// 전자상거래(상품) 고시 유형 - 추가 확인 필요
	public static final HashMap<String, String> GDS_ANCMNT_TY = new LinkedHashMap<String, String>() {
		private static final long serialVersionUID = 3248778213644085591L;
		{
			put("wear", "의류");
			put("shoes", "구두/신발");
			put("bag", "가방");
			put("fashion", "패션잡화(모자/벨트/액세서리)");
			put("bedding", "침구류/커튼");
			put("furniture", "가구(침대/소파/싱크대/DIY제품)");
			put("image", "영상가전 (TV류)");
			put("home", "가정용전기제품(냉장고/세탁기/식기세척기/전자레인지)");
			put("season", "계절가전(에어컨/온풍기)");
			put("office", "사무용기기(컴퓨터/노트북/프린터)");
			put("optics", "광학기기(디지털카메라/캠코더)");
			put("micro", "소형전자(MP3/전자사전등)");
			put("mobile", "휴대폰");
			put("navigation", "네비게이션");
			put("car", "자동차용품(자동차부품/기타자동차용품)");
			put("medical", "의료기기");
			put("kitchenware", "주방용품");
			put("cosmetics", "화장품");
			put("jewelry", "귀금속/보석/시계류");
			put("food", "식품(농수산물)");
			put("general_food", "가공식품");
			put("diet_food", "건강기능식품");
			put("kids", "영유아용품");
			put("instrument", "악기");
			put("sports", "스포츠용품");
			put("books", "서적");
			put("reserve", "호텔/펜션예약");
			put("travel", "여행패키지");
			put("airline", "항공권");
			put("rent_car", "자동차대여서비스(렌터카)");
			put("rental_water", "물품대여서비스(정수기,비데,공기청정기 등)");
			put("rental_etc", "물품대여서비스(서적,유아용품,행사용품 등)");
			put("digital", "디지털콘텐츠(음원,게임,인터넷강의 등)");
			put("gift_card", "상품권/쿠폰");
			put("etc", "기타");
		}
	};

	/**
	 * 사업장 코드맵
	 */
	// 사업장-휴무일
	public static final HashMap<String, String> BPLC_RSTDE = new LinkedHashMap<String, String>() {
		private static final long serialVersionUID = 58201944614019560L;
		{
			put("A", "주말");
			put("B", "공휴일");
			put("C", "연중무휴");
			put("D", "토요일");
			put("E", "일요일");
			put("Z", "기타");
		}
	};

	//사업장- 주차여부
	public static final HashMap<String, String> PARKNG_YN = new LinkedHashMap<String, String>() {
		private static final long serialVersionUID = 1L;
		{
			put("Y", "가능");
			put("N", "불가능");
		}
	};

	// 사업장-승인상태
	public static final HashMap<String, String> APRV_TY = new LinkedHashMap<String, String>() {
		private static final long serialVersionUID = 8854613069310010673L;
		{
			put("W", "대기"); // WAIT
			put("C", "승인"); // CONFIRM
			put("R", "미승인"); // REJECT
		}
	};

	/**
	 * 프로모션 > 이벤트
	 */
	//이벤트 형태
	public static final HashMap<String, String> EVENT_TY = new LinkedHashMap<String, String>() {
		private static final long serialVersionUID = 1L;
		{
			put("F", "자유형");
			put("A", "응모형");
			put("S", "설문형");
		}
	};

	//이벤트 대상
	public static final HashMap<String, String> EVENT_TRGT = new LinkedHashMap<String, String>() {
		private static final long serialVersionUID = -21324526557457L;
		{
			put("A", "전체회원");
			put("I", "개인회원");
			put("C", "기업회원");
		}
	};


	//발급 방식
	public static final HashMap<String, String> ISSU_TY = new LinkedHashMap<String, String>() {
		private static final long serialVersionUID = 8417147404015267574L;
		{
			put("AUTO", "자동발급");
			put("MNG", "운영자수동발급");
			put("DWLD", "다운로드발급"); // DOWNLOAD
		}
	};

	//쿠폰 종류
	public static final HashMap<String, String> COUPON_TY = new LinkedHashMap<String, String>() {
		private static final long serialVersionUID = 133507148448669305L;
		{
			put("NOR", "일반");
			put("GRADE", "회원등급");
			put("JOIN", "회원가입");
			put("FREE", "무료배송");
			put("BRDT", "생일축하");
		}
	};

	//상태 유형
	public static final HashMap<String, String> STTUS_TY = new LinkedHashMap<String, String>() {
		private static final long serialVersionUID = -4815197362551668220L;
		{
			put("USE", "사용");
			put("STOP", "중지");
		}
	};

	//할인구분
	public static final HashMap<String, String> DSCNT_TY = new LinkedHashMap<String, String>() {
		private static final long serialVersionUID = 355288246727886733L;
		{
			put("PRCS", "정율"); //precision
			put("SEMEN", "정액");
		}
	};

	//쿠폰 대상 정보 > 회원구분 / 회원등급
	public static final HashMap<String, String> ISSU_MBR = new LinkedHashMap<String, String>() {
		private static final long serialVersionUID = -4944107124886997120L;
		{
			put("D", "회원구분/회원등급"); //division
			put("I", "개별회원"); //individual
		}
	};

	//적용 상품 유형
	public static final HashMap<String, String> ISSU_GDS = new LinkedHashMap<String, String>() {
		private static final long serialVersionUID = -5211512645157307510L;
		{
			put("I", "개별상품"); //individual
			put("A", "전체상품"); //ALL
		}
	};

	//사용 기간 유형
	public static final HashMap<String, String> USE_PD_TY = new LinkedHashMap<String, String>() {
		private static final long serialVersionUID = -6800855150709202987L;
		{
			put("FIX", "고정기간"); //individual
			put("ADAY", "사용가능일수"); // Available days
		}
	};

	//포인트, 마일리지 구분 내역
	public static final HashMap<String, String> POINT_SE = new LinkedHashMap<String, String>() {
		private static final long serialVersionUID = 3318724390611433221L;
		{
			put("A", "적립");
			put("M", "차감");
			put("E", "소멸");
		}
	};

	/**
	 * 포인트, 마일리지 내역
	 * 2023-02-16 INSERT 하드코딩으로 변경
	 * 2자리로 변경 0> 관리자, 1> 차감, 2>적립
	 */
	public static final HashMap<String, String> POINT_CN = new LinkedHashMap<String, String>() {
		private static final long serialVersionUID = 6185912987117339822L;
		{
			// 관리자
			put("01", "특별 행사 적립");
			put("02", "이벤트");
			put("03", "추천인 포인트");

			// 차감
			put("11", "상품 주문");
			put("12", "적립 취소"); //적립금 취소
			put("13", "상품 반품");

			// 소멸
			put("15", "유효기간 만료");
			put("16", "휴면회원 소멸");
			put("17", "블랙회원 소멸");
			put("18", "탈퇴회원 소멸");

			// 적립
			put("32", "구매 확정");
			put("33", "상품 취소");
			put("34", "상품 반품");

			put("35", "상품후기");

			put("99", "기타");
		}
	};

	/**
	 * 전시관리 > 팝업관리
	 */
	//링크 유형
	public static final HashMap<String, String> POPUP_LINK_TY = new LinkedHashMap<String, String>() {
		private static final long serialVersionUID = 1L;
		{
			put("P", "현재창");
			put("S", "새창열림");
			put("N", "없음");
		}
	};

	//배너 관리 > 배너 유형
	public static final HashMap<String, String> BANNER_TY = new LinkedHashMap<String, String>() {
		private static final long serialVersionUID = 133507148448669305L;
		{
			put("M", "메인 배너"); //main
			put("S", "띠 배너"); // sub
		}
	};

	//배너 관리 > 배너 유형
	public static final HashMap<String, String> MAIN_TY = new LinkedHashMap<String, String>() {
		private static final long serialVersionUID = 1605787430187989116L;
		{
			put("G", "상품노출형"); //gds
			put("B", "배너형"); // banner
			put("H", "배너하프형"); // half
		}
	};

	/**
	 * 시스템관리 > 입점업체 관리
	 */
	//검색 키워드명
	public static final HashMap<String, String> ENTRPS_KEY_TY = new LinkedHashMap<String, String>() {
		private static final long serialVersionUID = 129831231723123123L;
		{
			put("C", "상호/법인명");
			put("N", "사업자번호");
			put("M", "담당자명");
		}
	};


	//정산주기
	public static final HashMap<String, String> CLCLN_CYCLE= new LinkedHashMap<String, String>() {
		private static final long serialVersionUID = -1732810681524659543L;
		{
			put("WE","주");
			put("MO","월");
		}
	};
	//은행 종류
	public static final HashMap<String, String> BANK_NM= new LinkedHashMap<String, String>() {
		private static final long serialVersionUID = -7152465940167672114L;
		{
			put("02", "한국산업은행");
			put("03", "기업은행");
			put("04", "국민은행");
			put("05", "하나은행");
			put("06", "국민은행");
			put("07", "수협중앙회");
			put("11", "농협중앙회");
			put("12", "단위농협");
			put("16", "축협중앙회");
			put("20", "우리은행");
			put("21", "조흥은행");
			put("22", "상업은행");
			put("23", "SC제일은행");
			put("24", "한일은행");
			put("25", "서울은행");
			put("26", "신한은행");
			put("27", "한국씨티은행");
			put("31", "대구은행");
			put("32", "부산은행");
			put("34", "광주은행");
			put("35", "제주은행");
			put("37", "전북은행");
			put("38", "강원은행");
			put("39", "경남은행");
			put("41", "비씨카드");
			put("45", "새마을금고");
			put("48", "신용협동조합중앙회");
			put("50", "상호저축은행");
			put("53", "한국씨티은행");
			put("54", "홍콩상하이은행");
			put("55", "도이치은행");
			put("56", "ABN암로");
			put("57", "JP모건");
			put("59", "미쓰비시도쿄은행");
			put("60", "BOA(Bank of America)");
			put("64", "산림조합");
			put("70", "신안상호저축은행");
			put("71", "우체국");
			put("81", "하나은행");
			put("83", "평화은행");
			put("87", "신세계");
			put("88", "신한(통합)은행");
			put("89", "케이뱅크");
			put("90", "카카오뱅크");
			put("91", "네이버포인트");
			put("92", "토스뱅크");
			put("93", "토스머니");
			put("94", "SSG머니");
			put("96", "엘포인트");
			put("97", "카카오머니");
			put("98", "페이코포인트");
			put("D1", "유안타증권");
			put("D2", "현대증권");
			put("D3", "미래에셋증권");
			put("D4", "한국투자증권");
			put("D5", "우리투자증권");
			put("D6", "하이투자증권");
			put("D7", "HMC투자증권");
			put("D8", "SK증권");
			put("D9", "대신증권");
			put("DA", "하나대투증권");
			put("DB", "굿모닝신한증권");
			put("DC", "동부증권");
			put("DD", "유진투자증권");
			put("DE", "메리츠증권");
			put("DF", "신영증권");
			put("DG", "대우증권");
			put("DH", "삼성증권");
			put("DI", "교보증권");
			put("DJ", "키움증권");
			put("DK", "이트레이드");
			put("DL", "솔로몬증권");
			put("DM", "한화증권");
			put("DN", "NH증권");
			put("DO", "부국증권");
			put("DP", "LIG증권");
			put("BW", "뱅크월렛");
			put("DQ", "디올투자증권");
			put("DR", "토스증권");
		}
	};

	//업무 구분
	public static final HashMap<String, String> PIC_JOB= new LinkedHashMap<String, String>() {
		private static final long serialVersionUID = -7152465940167672114L;
		{
			put("1","업무1");
			put("2","업무2");
		}
	};

	/**
	 * 회원관리 > 목록 > 회원구분
	 */
	public static final HashMap<String, String> RECIPTER_YN= new LinkedHashMap<String, String>() {
		private static final long serialVersionUID = -4607667632954312467L;
		{
			put("N","일반 회원"); //GENERAL
			put("Y","일반 회원"); //RECIPTER 수급자 회원이 없어지면서 모두 일반회원으로 표시
		}
	};

	//키워드 검색
	public static final HashMap<String, String> SRCH_MBR_KEYWORD= new LinkedHashMap<String, String>() {
		private static final long serialVersionUID = 114116588543090973L;
		{
			put("ID","아이디");
			put("NM","이름");
			put("CD","고객코드");
		}
	};

	//회원 등급
	public static final HashMap<String, String> GRADE= new LinkedHashMap<String, String>() {
		private static final long serialVersionUID = -6800855150709202987L;
		{
			put("E","이로움"); //이로움
			put("B","반가움"); //반가움
			put("S","새로움"); //새로움
			put("N","신규회원"); //신규회원
		}
	};

	//성별
	public static final HashMap<String, String> GENDER= new LinkedHashMap<String, String>() {
		private static final long serialVersionUID = 8417147404015267574L;
		{
			put("M","남성");
			put("W","여성");
		}
	};

	//기본 결제 유형
	public static final HashMap<String, String> BASS_STLM_TY= new LinkedHashMap<String, String>() {
		private static final long serialVersionUID = 133507148448669305L;
		{
			put("CARD","신용카드(ISP)");
			put("BANK","실시간계좌이체");
			put("VBANK","가상계좌(무통장)");
			put("REBILL","카드정기결제");
			put("KAKAOPAY","카카오페이");
			put("NAVERPAY","네이버페이");
			put("PAYCO","페이코");
			put("TOSS","토스");
			put("FREE","무료"); //0원일 경우

		}
	};

	//회원 상태
	public static final HashMap<String, String> MBER_STTUS= new LinkedHashMap<String, String>() {
		private static final long serialVersionUID = -4815197362551668220L;
		{
			put("NORMAL","일반");
			put("BLACK","블랙리스트");
			put("HUMAN","휴면");
			put("EXIT","탈퇴");
		}
	};

	//가입 경로
	public static final HashMap<String, String> JOIN_COURS= new LinkedHashMap<String, String>() {
		private static final long serialVersionUID = 355288246727886733L;
		{
			put("PC","PC");
			put("MOBILE","모바일");
		}
	};
	//답변 상태
	public static final HashMap<String, String> ANS_YN= new LinkedHashMap<String, String>() {
		private static final long serialVersionUID = -4944107124886997120L;
		{
			put("Y","답변완료");
			put("N","답변미완료");
		}
	};
	//유효기간
	public static final HashMap<String, String> EXPIRATION= new LinkedHashMap<String, String>() {
		private static final long serialVersionUID = 1605787430187989116L;
		{
			put("OUT","회원 탈퇴시까지");
			put("3Y","3년");
			put("1Y","1년");
		}
	};
	//경고 구분
	public static final HashMap<String, String> MNG_SE_WARNING= new LinkedHashMap<String, String>() {
		private static final long serialVersionUID = -2838666820118270714L;
		{
			put("FIRST","1차 경고");
			put("TWICE","2차 경고");
			put("THIRD","3차 경고");
			put("NONE","해제");
		}
	};

	//블랙리스트 구분
	public static final HashMap<String, String> MNG_SE_BLACK= new LinkedHashMap<String, String>() {
		private static final long serialVersionUID = 5045970347033574329L;
		{
			put("PAUSE","일시정지");
			put("UNLIMIT","영구정지");
			put("NONE","해제");
		}
	};
	//경고 사유
	// ++ 고객요청 하드코딩  value="CS"
	public static final HashMap<String, String> RESN_CD= new LinkedHashMap<String, String>() {
		private static final long serialVersionUID = 5045970347033574329L;
		{
			put("OCANCLE","상습 주문취소 고객");
			put("DELAY","상습 결제지연 고객");
			put("EXCHANGE","상습 주문교환 고객");
			put("REFUND","상습 반품 고객");
			put("MAXFUND","30일 이내 사용 후 반품 고객");
			put("NSTOCK","미입고 반품/교환 강성 고객");
			put("FREE","상습 사은품 미반품고객");
			put("RELEASE","출고누락건의 강성고객");
			put("EMBEZZ","타인카드 도용고객");
			put("DAMAGE","무리한 손해배상 요청고객");
			put("ETC","기타");
		}
	};
	// 블랙리스트 사유
	// ++ 고객요청 하드코딩  value="CS"
	public static final HashMap<String, String> BLACK_RESN_CD= new LinkedHashMap<String, String>() {
		private static final long serialVersionUID = 114116588543090973L;
		{
			put("HCANCLE","상습적인 취소/반품"); // habitual cancle
			put("DLBRT","고의적인 물품훼손"); //deliberate
			put("GIFT","사은품 미반품");
			put("WORD","심한 욕설/비방");
			put("OPER","이벤트 조작 의심"); //operation
			put("HACK","해킹 의심");
			put("ETC","기타");
		}
	};
	// 직권 탈퇴 사유
	public static final HashMap<String, String> AUTH_RESN_CD= new LinkedHashMap<String, String>() {
		private static final long serialVersionUID = 945133742598477693L;
		{
			put("EMBEZZ","타인카드 도용 고객");
			put("ETC","기타");
			put("SELF","직접입력");
		}
	};
	// 일반 탈퇴 사유
	public static final HashMap<String, String> NOR_RESN_CD= new LinkedHashMap<String, String>() {
		private static final long serialVersionUID = 3678269337053606763L;
		{
			put("SERVICE","서비스 불만족");
			put("DLVY","배송 지연");
			put("SPEED","사이트 속도 느림");
			put("QUALITY","상품 품질 저하");
			put("FRQNCY","이용 빈도 저조"); // frequency
			put("ETC","기타");
		}
	};
	// 탈퇴 유형
	public static final HashMap<String, String> EXIT_TY= new LinkedHashMap<String, String>() {
		private static final long serialVersionUID = 3678269337053606763L;
		{
			put("NORMAL","일반탈퇴");
			put("AUTHEXIT","직권탈퇴");
		}
	};
	/**
	 * 고객 관리
	 */
	//문의유형 1차
	public static final HashMap<String, String> INQRY_TY_NO1= new LinkedHashMap<String, String>() {
		private static final long serialVersionUID = -5211512645157307510L;
		{
			put("0","교환/반품/환불");
			put("1","주문/결제");
			put("2","이벤트/혜택");
			put("3","상품문의");
			put("4","회원안내");
			put("6","장기요양 인정등급");
			put("5","기타");

		}
	};


	/**
	 * 주문
	 */
	public static final HashMap<String, String> ORDR_STTS = new LinkedHashMap<String, String>() {
		private static final long serialVersionUID = 5045970347033574329L;
		{
			//주문승인대기, 주문승인완료, 주문승인반려, 결제대기, 결제완료, 배송준비중, 배송중, 배송완료, 구매확정, 취소접수, 취소완료, 주문취소, 교환접수, 교환접수승인, 교환회수지시, 교환회수완료, 교환대기중, 교환완료, 반품접수, 반품접수승인, 반품회수지시, 반품회수완료, 반품대기중, 반품완료, 환불접수, 환불완료
			put("OR01","주문승인대기"); // order (급여제품의 경우 승인대기 단계부터 진행)
			put("OR02","주문승인완료");
			put("OR03","주문승인반려");

			put("OR04","결제대기");
			put("OR05","결제완료");
			put("OR06","배송준비중");
			put("OR07","배송중");
			put("OR08","배송완료");
			put("OR09","구매확정");

			put("CA01","취소접수"); // cancel
			put("CA02","취소완료");
			put("CA03","주문취소");

			put("EX01","교환접수"); // exchange
			put("EX02","교환진행중");
			put("EX03","교환완료");

			put("RE01","반품접수");  // return
			put("RE02","반품진행중");
			put("RE03","반품완료");

			put("RF01","환불접수"); // refund
			put("RF02","환불완료");
		}
	};

	/**
	 * 은행코드
	 */
	public static final HashMap<String, String> BANK_TY = new LinkedHashMap<String, String>() {
		private static final long serialVersionUID = 7279164911113594958L;
		{
			put("KB","KDB산업은행");
			put("3","기업은행");
			put("4","국민은행");
			put("6","국민은행 (구 주택)");
			put("5","하나은행 (구 외환)");
			put("7","수협중앙회");
			put("11","농협중앙회");
			put("13","지역농축협");
			put("20","우리은행");
			put("26","구)신한은행");
			put("88","신한(통합)은행");
			put("23","SC제일은행");
			put("27","한국씨티은행 (구 한미)");
			put("53","한국씨티은행");
			put("31","대구은행");
			put("32","부산은행");
			put("34","광주은행");
			put("35","제주은행");
			put("37","전북은행");
			put("39","경남은행");
			put("45","새마을금고");
			put("SH","신협중앙회");
			put("64","산림조합");
			put("71","우체국");
			put("89","케이뱅크");
			put("90","카카오뱅크");
			put("92","토스뱅크");
			put("12","단위농협");
			put("16","축협중앙회");
			put("21","구)조흥은행");
			put("22","상업은행");
			put("24","한일은행");
			put("25","서울은행");
			put("38","강원은행");
			put("41","비씨카드");
			put("48","신용협동조합중앙회");
			put("50","상호저축은행");
			put("54","홍콩상하이은행");
			put("2","한국산업은행");
			put("55","도이치은행");
			put("56","ABN암로");
			put("57","JP모건");
			put("59","미쓰비시도쿄은행");
			put("60","BOA(Bank of America)");
			put("70","신안상호저축은행");
			put("81","하나은행");
			put("83","평화은행");
			put("87","신세계");
			put("91","네이버포인트");
			put("93","토스머니");
			put("94","SSG머니");
			put("96","엘포인트");
			put("97","카카오머니");
			put("98","페이코포인트");
			put("D1","유안타증권");
			put("D2","현대증권");
			put("D3","미래에셋증권");
			put("D4","한국투자증권");
			put("D5","우리투자증권");
			put("D6","하이투자증권");
			put("D7","HMC투자증권");
			put("D8","SK증권");
			put("D9","대신증권");
			put("DA","하나대투증권");
			put("DB","굿모닝신한증권");
			put("DC","동부증권");
			put("DD","유진투자증권");
			put("DE","메리츠증권");
			put("DF","신영증권");
			put("DG","대우증권");
			put("DH","삼성증권");
			put("DI","교보증권");
			put("DJ","키움증권");
			put("DK","이트레이드");
			put("DL","솔로몬증권");
			put("DM","한화증권");
			put("DN","NH증권");
			put("DO","부국증권");
			put("DP","LIG증권");
			put("BW","뱅크월렛");

		}
	};

	// 취소사유
	public static final HashMap<String, String> ORDR_CANCEL_TY = new LinkedHashMap<String, String>() {
		private static final long serialVersionUID = 5722375410228917601L;
		{
			put("1","구매의사 없음");
			put("2","옵션변경");
			put("3","서비스 불만족");
			put("4","상품/가격 불만족");
			put("5","배송지연/누락");
			put("6","다른 상품 잘못 주문");
			put("7","상품 불량/파손");
			put("8","주문서와 다른 상품배송");
			put("9","품절");
			put("10","자동취소");
			put("11","기타");
		}
	};

	// 교환사유 = 일단 취소사유와 동일하게 작업
	public static final HashMap<String, String> ORDR_EXCHNG_TY = new LinkedHashMap<String, String>() {
		private static final long serialVersionUID = 5722375410228917601L;
		{
			//put("1","구매의사 없음");
			put("2","옵션변경");
			put("3","서비스 불만족");
			put("4","상품/가격 불만족");
			put("5","배송지연/누락");
			put("6","다른 상품 잘못 주문");
			put("7","상품 불량/파손");
			put("8","주문서와 다른 상품배송");
			//put("9","품절");
			//put("10","자동취소");
			put("11","기타");
		}
	};

	// 반품사유 = 일단 취소사유와 동일하게 작업
	public static final HashMap<String, String> ORDR_RETURN_TY = new LinkedHashMap<String, String>() {
		private static final long serialVersionUID = 5722375410228917601L;
		{
			put("1","구매의사 없음");
			put("2","옵션변경");
			put("3","서비스 불만족");
			put("4","상품/가격 불만족");
			put("5","배송지연/누락");
			put("6","다른 상품 잘못 주문");
			put("7","상품 불량/파손");
			put("8","주문서와 다른 상품배송");
			//put("9","품절");
			//put("10","자동취소");
			put("11","기타");
		}
	};

	// 환불사유 = 일단 취소사유와 동일하게 작업
	public static final HashMap<String, String> ORDR_REFUND_TY = new LinkedHashMap<String, String>() {
		private static final long serialVersionUID = 5722375410228917601L;
		{
			put("1","구매의사 없음");
			put("2","옵션변경");
			put("3","서비스 불만족");
			put("4","상품/가격 불만족");
			put("5","배송지연/누락");
			put("6","다른 상품 잘못 주문");
			put("7","상품 불량/파손");
			put("8","주문서와 다른 상품배송");
			//put("9","품절");
			//put("10","자동취소");
			put("11","기타");
		}
	};


	//문의유형 2차
	public static final HashMap<String, String> INQRY_TY_NO2= new LinkedHashMap<String, String>() {
		private static final long serialVersionUID = 5045970347033574329L;
		{
			// 0:교환/반품/환불
			put("EXCHANGE","교환");
			put("RETURN","반품");
			put("REFUND","환불");
			// 1:주문/결제
			put("OCONFIRM","주문확인"); //ORDER CONFIRM
			put("CANCLE","주문취소");
			put("OCHANGE","주문변경"); //ORDER CHANGE
			put("INQUIRY","결제문의");
			// 2:이벤트/혜택
			put("ECONFIRM","이벤트당첨확인"); // EVENT CONFIRM
			put("EXTINC","마일리지/포인트 사용소멸문의");
			put("EETC","이벤트 기타 문의"); // EVENT ETC
			// 3:상품문의
			put("GDSINFO","상품상세정보"); //GOODS INFORMATION
			put("GDSPRICE","상품가격문의");
			put("GDSTOCK","상품재고문의");
			// 4:회원안내
			put("SIGNUP","회원가입문의");
			put("MCHANGE","회원정보변경문의"); //MBR CHANGE
			put("SECES","회원탈퇴문의"); //SECESSION
			// 5:기타
			put("SYSTEM","시스템오류"); //SYSTEM
			// 6:장기요양 인정등급
			put("CONSLIT","상담신청문의/기타");
		}
	};

	// 회원 관심 분야
	public static final HashMap<String, String> ITRST_FIELD= new LinkedHashMap<String, String>() {
		private static final long serialVersionUID = -8253406184254457029L;
		{
			put("1","지원");
			put("2","보호");
			put("3","상담");
			put("4","보건");
			put("5","고용");
			put("6","문화");
			put("7","주거");
			put("8","교육");
		}
	};

	// 1:1상담(장기요양 상담신청) 상태값 > 사용자/멤버스/관리자 사용하는 명칭이 다름
	public static final HashMap<String, String> CONSLT_STTUS = new LinkedHashMap<String, String>() {
		private static final long serialVersionUID = 7437138482747478940L;
		{
			put("CS01", "접수");
			put("CS02", "배정");
			put("CS03", "상담자 취소");	//취소
			put("CS04", "사업소 취소");	//취소
			put("CS05", "진행");
			put("CS06", "완료");
			put("CS07", "재접수"); 		//재상담
			put("CS08", "재배정");
			put("CS09", "THKC 취소");	//취소(요청에 의한 추가)
		}
	};
	
	// 1:1상담 상태 변경 이력 사유
	public static final HashMap<String, String> CONSLT_STTUS_CHG_RESN = new LinkedHashMap<String, String>() {
		private static final long serialVersionUID = -8253406184254457029L;
		{
//			put("접수", "이로움회원 상담을 신청하였습니다.");
//			put("배정", "관리자가 상담 사업소 배정하였습니다.");
//			put("상담자 취소", "이로움 상담자(회원)이 상담을 취소하였습니다.");
//			put("사업소 취소", "사업소가 상담을 취소하였습니다.");
//			put("진행", "사업소가 상담을 수락하였습니다.");
//			put("완료", "사업소 상담이 완료되었습니다.");
//			put("재접수", "이로움회원 재 상담을 신청하였습니다.");
			
			put("접수", "접수상태로 변경되었습니다.");
			put("배정", "배정상태로 변경되었습니다.");
			put("상담자 취소", "상담자 취소상태로 변경되었습니다.");
			put("사업소 취소", "사업소 취소상태로 변경되었습니다.");
			put("진행", "진행상태로 변경되었습니다.");
			put("완료", "완료상태로 변경되었습니다.");
			put("재접수", "재접수상태로 변경되었습니다.");
			put("재배정", "재배정상태로 변경되었습니다.");
			put("THKC 취소", "THKC 취소상태로 변경되었습니다.");
		}
	};
	
	//회원가입 경로(직접가입, 카카오간편가입, 네이버 간편가입) 
	public static final HashMap<String, String> MBR_JOIN_TY = new LinkedHashMap<String, String>() {
		private static final long serialVersionUID = 7437138482747478940L;
		{
			put("E", "직접가입");
			put("K", "카카오");
			put("N", "네이버");
		}
	};
	public static final HashMap<String, String> MBR_JOIN_TY2 = new LinkedHashMap<String, String>() {
		private static final long serialVersionUID = 7437138482747478940L;
		{
			put("E", "직접가입");
			put("K", "카카오 간편가입");
			put("N", "네이버 간편가입");
		}
	};
	public static final HashMap<String, String> MBR_JOIN_TY3 = new LinkedHashMap<String, String>() {
		private static final long serialVersionUID = 7437138482747478940L;
		{
			put("E", "일반");
			put("K", "간편카카오");
			put("N", "간편네이버");
		}
	};
	
	// 회원 - 수급자 관계 코드
	public static final HashMap<String, String> MBR_RELATION_CD = new LinkedHashMap<String, String>() {
		private static final long serialVersionUID = -5623502462808019347L;
		{
			put("001", "배우자");
			put("002", "자녀");
			put("003", "부모");
			put("004", "형제");
			put("005", "자손");
			put("006", "자부");
			put("007", "본인");
			put("100", "기타(친척등)");
		}
	};
	
	// 상담 요청 경로
	public static final HashMap<String, String> PREV_PATH = new LinkedHashMap<String, String>() {
		private static final long serialVersionUID = -4615344482467031481L;
		{
			put("simpleSearch", "요양정보상담");
			put("test", "인정등급상담");
		}
	};

	// 보낸사람 이름
	public static final HashMap<String, String> MAIL_SENDER_NAME = new LinkedHashMap<String, String>() {
		private static final long serialVersionUID = -4615344482467031482L;
		{
			put("noreply@thkc.co.kr", "이로움ON");
		}
	};

	public static final HashMap<String, String> MAIL_SEND_TY = new LinkedHashMap<String, String>() {
		private static final long serialVersionUID = -4615344482467031482L;
		{
			put("MAILSEND_ORDR_MARKET_PAYDONE_CARD", "주문접수 카드");//,
			put("MAILSEND_ORDR_MARKET_PAYDONE_BANK","주문접수 실시간계좌이체");//
			put("MAILSEND_ORDR_MARKET_PAYDONE_VBANK", "주문접수 가상계좌");//,
			put("MAILSEND_ORDR_MARKET_PAYDONE_FREE", "주문접수 무료");//,
			put("MAILSEND_ORDR_SCHEDULE_VBANK_REQUEST","가상계좌 입금 요청");//
			put("MAILSEND_ORDR_SCHEDULE_VBANK_CANCEL","가상계좌 취소");//
			put("MAILSEND_ORDR_BOOTPAY_VBANK_INCOME","가상계좌 입금완료");//

			put("MAILSEND_ORDR_MNG_CONFIRM","배송준비중");//

			put("MAILSEND_ORDR_MNG_REFUND","주문 취소");//환불 // 결제 완료 후 배송준비중 이전 단계
			put("MAILSEND_ORDR_MNG_RETURN","반품");//

			put("MAILSEND_ORDR_SCHEDULE_CONFIRM_NOTICE","구매확정-예정");//
			put("MAILSEND_ORDR_SCHEDULE_CONFIRM_ACTION","구매확정-처리");//

		}
	};

	/*이용약관 종류*/
	public static final HashMap<String, String> TERMS_KIND = new LinkedHashMap<String, String>() {
		private static final long serialVersionUID = -4615344482467031481L;
		{
			put("TERMS", "이용약관");
			put("PRIVACY", "개인정보 처리방침");
			/*
			put("PROVISION", "개인정보 제공");
			put("THIRD_PARTIES", "개인정보 제3자 제공");
			*/
		}
	};
}
