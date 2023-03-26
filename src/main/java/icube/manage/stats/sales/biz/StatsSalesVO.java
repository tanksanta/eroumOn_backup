package icube.manage.stats.sales.biz;

import org.apache.ibatis.type.Alias;

import icube.common.vo.CommonBaseVO;
import lombok.Getter;
import lombok.Setter;


@Getter
@Setter
@Alias("statsSalesVO")
public class StatsSalesVO extends CommonBaseVO {

	private int totalACnt;
	private int totalASum;

	private int totalBCnt;
	private int totalBSum;

	private int totalCCnt;
	private int totalCSum;

	private int totalCaCnt;
	private int totalCaSum;

	private int totalReCnt;
	private int totalReSum;

	private int totalOrdrQy; // 상품갯수

	private int totalStlmSum; // 결제금액
	private int totalMlgSum; // 사용 마일리지
	private int totalAccmlMlg; // 적립 마일리지(OR08, OR09)

	private int totalPointSum; // 사용 포인트

	private String ordrDt; // 주문일자

	private String gdsCd; // 상품코드
	private String gdsNm; // 상품명

	private String gender; //성별
	private String ageGrp; // 연령대
	private int buyerCnt; // 구매자 수

	private String bplcUniqueId;
	private String bplcNm;

	private int totalCardCnt;
	private int totalCardSum;
	private int totalBankCnt;
	private int totalBankSum;
	private int totalVbankCnt;
	private int totalVbankSum;
	private int totalMlgCnt;
	private int totalPointCnt;

	private String stlmTy;
	private String cardCoNm;



}
