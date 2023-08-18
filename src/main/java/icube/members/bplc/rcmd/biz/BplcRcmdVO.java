package icube.members.bplc.rcmd.biz;

import org.apache.ibatis.type.Alias;

import icube.common.vo.CommonBaseVO;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
@Alias("bplcRcmdVO")
public class BplcRcmdVO extends CommonBaseVO {

	private String bplcUniqueId;
	private String rcmdYn = "Y"; // Y:추천, N:비추천
}
