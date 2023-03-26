package icube.manage.sysmng.auth.biz;

import org.apache.ibatis.type.Alias;

import icube.common.vo.CommonBaseVO;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
@Alias("mngAuthrtMenuVO")
public class MngAuthrtMenuVO extends CommonBaseVO {

	private int authrtNo;
	private String authrtNm;
	private String authrtTy;
	private int menuNo;

	private String authrtYn = "N"; // 통합 권한

	private String inqYn = "N"; // 조회 권한
	private String wrtYn = "N"; // CRD 권한

	private String memo;

}
