package icube.manage.exhibit.main.biz;

import org.apache.ibatis.type.Alias;

import icube.common.vo.CommonBaseVO;
import lombok.Getter;
import lombok.Setter;

@Setter
@Getter
@Alias("mainMngVO")
public class MainMngVO extends CommonBaseVO {

	private int mainNo;
	private int sortNo;
	private String themaTy;
	private String sj;
	private int rdcnt;
	private String icon;
	private String linkUrl;

}