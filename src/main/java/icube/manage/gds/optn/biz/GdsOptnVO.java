package icube.manage.gds.optn.biz;

import org.apache.ibatis.type.Alias;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Setter
@Getter
@ToString
@Alias("gdsOptnVO")
public class GdsOptnVO {

	private int gdsOptnNo;
	private int gdsNo;
	private String optnTy; // 기본/추가
	//private String optnVal; // 옵션항목값
	private String optnNm;  // 옵션명
	private String optnItemCd; // 옵션 품목코드
	private int optnPc = 0;
	private int optnStockQy = 9999; // 0 입력시 품절
	private String useYn;
	private String soldOutYn;
}
