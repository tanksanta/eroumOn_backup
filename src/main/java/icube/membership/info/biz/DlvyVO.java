package icube.membership.info.biz;

import org.apache.ibatis.type.Alias;

import icube.common.vo.CommonBaseVO;
import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Setter
@Getter
@Alias("dlvyVO")
@ToString
public class DlvyVO extends CommonBaseVO {
	private int dlvyMngNo;
	private String uniqueId;
	private String dlvyNm;
	private String nm;
	private String zip;
	private String addr;
	private String daddr;
	private String telno;
	private String mblTelno;
	private String bassDlvyYn = "N";
	private String memo;
	private String useYn = "Y";

}