package icube.manage.gds.gds;

import java.util.HashMap;
import java.util.LinkedHashMap;

public class ReverseCodeMap{

	// 급여-비급여
	public static final HashMap<String, String> GDS_TY = new LinkedHashMap<String, String>() {
		private static final long serialVersionUID = -3340533651232280595L;
		{
			put("급여상품(판매)" , "R");
			put("급여상품(대여)", "L");
			put("비급여", "N");
		}
	};

	// 사용여부
	public static HashMap<String, String> USE_YN = new LinkedHashMap<String, String>(){
		private static final long serialVersionUID = 1L;
		{
			put("사용" , "Y");
			put("미사용", "N");
		}
	};

	// 상품태그
	public static final HashMap<String, String> GDS_TAG = new LinkedHashMap<String, String>() {
		private static final long serialVersionUID = 3248778213644085591L;
		{
			put("품절", "A");
			put("일부옵션품절", "B");
			put("일시품절", "C");
		}
	};

	public static final HashMap<String, String> GDS_ANCMNT_TY = new LinkedHashMap<String, String>() {
		private static final long serialVersionUID = 3248778213644085591L;
		{
			put("의류", "wear");
			put("구두/신발", "shoes");
			put("가방", "bag");
			put("패션잡화(모자/벨트/액세서리)", "fashion");
			put("침구류/커튼", "bedding");
			put("가구(침대/소파/싱크대/DIY제품)", "furniture");
			put("영상가전 (TV류)", "image");
			put("가정용전기제품(냉장고/세탁기/식기세척기/전자레인지)", "home");
			put("계절가전(에어컨/온풍기)", "season");
			put("사무용기기(컴퓨터/노트북/프린터)", "office");
			put("광학기기(디지털카메라/캠코더)", "optics");
			put("소형전자(MP3/전자사전등)", "micro");
			put("휴대폰", "mobile");
			put("네비게이션", "navigation");
			put("자동차용품(자동차부품/기타자동차용품)", "car");
			put("의료기기", "medical");
			put("주방용품", "kitchenware");
			put("화장품", "cosmetics");
			put("귀금속/보석/시계류", "jewelry");
			put("식품(농수산물)", "food");
			put("가공식품", "general_food");
			put("건강기능식품", "diet_food");
			put("영유아용품", "kids");
			put("악기", "instrument");
			put("스포츠용품", "sports");
			put("서적", "books");
			put("호텔/펜션예약", "reserve");
			put("여행패키지", "travel");
			put("항공권", "airline");
			put("자동차대여서비스(렌터카)" ,"rent_car");
			put("물품대여서비스(정수기,비데,공기청정기 등)", "rental_water");
			put("물품대여서비스(서적,유아용품,행사용품 등)", "rental_etc");
			put("디지털콘텐츠(음원,게임,인터넷강의 등)", "digital");
			put("상품권/쿠폰", "gift_card");
			put("기타", "etc");
		}
	};

	// 배송비 유형
	public static final HashMap<String, String> DLVY_COST_TY = new LinkedHashMap<String, String>() {
		private static final long serialVersionUID = 3248778213644085591L;
		{
			put("무료", "FREE");
			put("유료", "PAY");
		}
	};

	// 배송비 결제 유형
	public static final HashMap<String, String> DLVY_PAY_TY = new LinkedHashMap<String, String>() {
		private static final long serialVersionUID = 3248778213644085591L;
		{
			put("선불", "PREPAID"); //PREPAID
			put("착불", "COLLECT"); //COLLECT
		}
	};


}
