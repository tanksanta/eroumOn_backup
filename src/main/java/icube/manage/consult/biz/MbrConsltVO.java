package icube.manage.consult.biz;

import org.apache.ibatis.type.Alias;

import icube.common.vo.CommonBaseVO;
import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@ToString
@Setter
@Getter
@Alias("mbrConsltVO")
public class MbrConsltVO extends CommonBaseVO {

	private int consltNo;
	private String mbrNm;
	private String mbrTelno;
	private String brdt;
	private String zip;
	private String addr;
	private String daddr;
	private String useYn = "Y";

}