package icube.manage.sysmng.mngr.biz;

import org.apache.ibatis.type.Alias;

import icube.common.vo.CommonBaseVO;
import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@ToString
@Getter
@Setter
@Alias("mngrDetailLogVO")
public class MngrDetailLogVO extends CommonBaseVO {
	private int logNo;
	private String uniqueId;
	private String mngrId;
	private String mngrNm;
	private String url;
	private String dmndIp;
	private String useHist;
	private String resn;
}