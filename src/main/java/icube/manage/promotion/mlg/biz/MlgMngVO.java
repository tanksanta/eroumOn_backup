package icube.manage.promotion.mlg.biz;

import java.util.Date;

import org.apache.ibatis.type.Alias;

import icube.common.vo.CommonBaseVO;
import lombok.Getter;
import lombok.Setter;

@Setter
@Getter
@Alias("mlgMngVO")
public class MlgMngVO extends CommonBaseVO {
	private int mlgMngNo;
	private String mlgSe ="A";
	private String mlgCn = "1";
	private int mlg;
	private String mngrMemo;
	private String regUniqueId;
	private Date regDt;
	private String regId;
	private String rgtr;

	private int targetCnt;

}