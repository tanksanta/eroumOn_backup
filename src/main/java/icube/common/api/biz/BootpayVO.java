package icube.common.api.biz;

import java.util.Date;

import org.apache.ibatis.type.Alias;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@ToString
@Setter
@Getter
@Alias("bootpayVO")
public class BootpayVO {

	private String receiptId;
	private String orderId;

	private String pg;
	private String methodSymbol;
	private String status;
	private String statusLocale;
	private String receiptUrl;
	private String purchasedAt; //DATE -> STRING

	//카드, 계좌이체, 가상계좌
	private String tid; //PG에서 발급한 결제 고유 식별 ID

	private int logSeq;/*callback string*/
	private String callbackTxt;/*callback string*/
	private Date regDt;			// 등록 일시
}
