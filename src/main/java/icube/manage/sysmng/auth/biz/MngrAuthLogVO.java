package icube.manage.sysmng.auth.biz;

import org.apache.ibatis.type.Alias;

import icube.common.vo.CommonBaseVO;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
@Alias("mngrAuthLogVO")
public class MngrAuthLogVO extends CommonBaseVO {

	private int logNo;
	private String uniqueId;
	private String mngrId;
	private String mngrNm;
	private String logTy; // CodeMap(MNGR_AUTH_LOG_TY)
	private String logCn;
	private String dmndIp;

}