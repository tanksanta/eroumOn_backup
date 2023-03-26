package icube.manage.gds.ctgry.biz;

import org.apache.ibatis.type.Alias;

import icube.common.vo.CommonBaseVO;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
@Alias("gdsCtgryVO")
public class GdsCtgryVO extends CommonBaseVO {

	private int ctgryNo;
	private String ctgryNm;
	private String ctgryImg;
	private String tag;
	private int upCtgryNo;
	private String upCtgryNm;
	private int levelNo = 1;
	private int sortNo = 1;
	private String orgCtgryNo; //업데이트시 사용

	private int childCnt = 0;

}
