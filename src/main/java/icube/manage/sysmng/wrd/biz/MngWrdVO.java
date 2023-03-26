package icube.manage.sysmng.wrd.biz;

import java.util.Date;

import org.apache.ibatis.type.Alias;

import icube.common.vo.CommonBaseVO;
import lombok.Getter;
import lombok.Setter;



@Setter
@Getter
@Alias("mngWrdVO")
public class MngWrdVO extends CommonBaseVO {
	private int wrdNo;
	private String prhibtWrd;
}