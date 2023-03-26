package icube.manage.sysmng.dlvy.biz;

import org.apache.ibatis.type.Alias;

import icube.common.vo.CommonBaseVO;
import lombok.Getter;
import lombok.Setter;

@Setter
@Getter
@Alias("dlvyCoMngVO")
public class DlvyCoMngVO extends CommonBaseVO {
	private int coNo;
	private String dlvyCoNm;
	private String telnoInfo;
	private String dlvyUrl;
	private String dlvyCoCd;

}