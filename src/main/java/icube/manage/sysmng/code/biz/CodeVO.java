package icube.manage.sysmng.code.biz;

import org.apache.ibatis.type.Alias;

import icube.common.vo.CommonBaseVO;
import lombok.Getter;
import lombok.Setter;


@Getter
@Setter
@Alias("codeVO")
public class CodeVO extends CommonBaseVO {

	private String cdTy = "USR";
	private String cdId;
	private String upCdId;
	private String upCdNm;
	private String cdNm;
	private String cdDc;
	private int levelNo = 1;
	private int sortNo = 1;
	private String useYn = "Y";
	private String orgCodeId;//코드 업데이트시 사용

	private int childCount = 0;
	
}
