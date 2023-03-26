package icube.manage.ordr.rebill.biz;

import org.apache.ibatis.type.Alias;

import icube.common.vo.CommonBaseVO;
import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@ToString
@Setter
@Getter
@Alias("ordrRebillVO")
public class OrdrRebillVO extends CommonBaseVO {

	private int rebillNo;
	private String billingKey;

	private int ordrNo;
	private String ordrCd;
	private int ordrCnt = 1; // 주문햇수

	private String gdsNm; // 상품명

	private int stlmAmt;
	private String stlmYn = "N";
	private String stlmDt;

	private String delngNo;
	private String cardCoNm;
	private String cardNo;
	private String cardAprvno;

	private String memo;

	private String ordrrNm;
	private String ordrrEml;
    private String ordrrTelno;
    private String ordrrMblTelno;

}
