package icube.common.values;

public class StaticValues {

	//session info for stat
	public static String STAT_SESSION = "uniqueUser";
	public static String STAT_SESSION_VAL = "Y";


	//gds form Dc
	public static String DLVY_DC = "<ul class='list-normal'><li>주문 마감 시간 이전 결제완료 건에 한해 당일 출고 됩니다.</li>\n"
			+ "				<li>(주말, 공휴일 제외) 주문마감시간 : 오전 11시 전 결제건 배송준비중 상태일 경우, 포장 및 발송 작업이 완료되어 주문 취소가 불가능합니다.</li>\n"
			+ "				<li>출고일 다음날로부터 1~3일 이내 수령 가능하지만 택배사 사정으로 지연될 수 있어 수령일 지정은 불가능합니다.</li>\n"
			+ "				<li>주소 및 전화번호를 잘 못 기재한 경우 반송비는 구매자 부담이니 한번 더 확인해주세요.</li>\n"
			+ "				<li>1:1 문의를 통한 주문 상품 변경, 취소, 반품, 교환은 불가능합니다.</li></ul>";

	public static String DC_CMMN = "<ul class='list-normal'><li>수령 후 7일 이내에만 교환, 반품, 환불이 가능합니다.</li>\n"
			+ "				<li>제품 불량 및 오배송 등 판매자 과실로 인한 반품 및 교환은 판매자가 배송비를 부담합니다.</li></ul>";

	public static String DC_FREE_SALARY = "<ul class='list-normal'><li>물품의 내용이 표시/광고의 내용과 다르거나 계약 내용과 차이가 있는 경우</li>\n"
			+ "				<li>물품을 수령한 날로부터 3개월 이내, 그 사실을 안 날 또는 알 수 있었던 날부터 30일 이내에 교환 및 반품이 가능합니다.</li>";

	public static String DC_PCHRG_SALARY  = "<ul class='list-normal'><li>구매자 단순 변심은 상품 수령 후 7일 이내 가능 합니다. (구매자 반품 배송비 부담)</li></ul>";
	public static String DC_PCHRG_SALARY_GNRL = "<ul class='list-normal'><li>구매자 단순 변심은 상품 수령 후 7일 이내 가능 합니다. (구매자 반품 배송비 부담)</li></ul>";
	public static String DC_PCHRG_GNRL = "<ul class='list-normal'><li>구매자 단순 변심은 상품 수령 후 7일 이내 가능 합니다. (구매자 반품 배송비 부담)</li></ul>";
}
