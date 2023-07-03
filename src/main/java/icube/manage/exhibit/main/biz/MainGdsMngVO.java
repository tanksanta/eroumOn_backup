package icube.manage.exhibit.main.biz;

import org.apache.ibatis.type.Alias;

import icube.common.vo.CommonBaseVO;
import lombok.Getter;
import lombok.Setter;

@Setter
@Getter
@Alias("mainGdsMngVO")
public class MainGdsMngVO extends CommonBaseVO {

	private int mainNo;
	private int gdsNo;
	private int sortNo;
	private String gdsCd;

}