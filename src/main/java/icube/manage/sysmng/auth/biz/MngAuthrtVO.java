package icube.manage.sysmng.auth.biz;

import org.apache.ibatis.type.Alias;

import icube.common.vo.CommonBaseVO;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
@Alias("mngAuthrtVO")
public class MngAuthrtVO extends CommonBaseVO {

	private int authrtNo;
	private String authrtNm;
	private String authrtTy = "2";
	private String memo = "";

}
