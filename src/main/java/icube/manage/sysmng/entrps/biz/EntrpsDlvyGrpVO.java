package icube.manage.sysmng.entrps.biz;

import org.apache.ibatis.type.Alias;

import icube.common.vo.CommonBaseVO;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
@Alias("entrpsDlvygrpVO")
public class EntrpsDlvygrpVO extends CommonBaseVO {
	private int entrpsDlvygrpNo;
	private int entrpsNo;
	private String entrpsDlvygrpNm;
	private int dlvyAditAmt;
	private String dlvyCalcTy;
	private String useYn;
}
