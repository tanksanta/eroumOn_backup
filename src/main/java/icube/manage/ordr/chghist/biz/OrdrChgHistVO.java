package icube.manage.ordr.chghist.biz;

import org.apache.ibatis.type.Alias;

import icube.common.vo.CommonBaseVO;
import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@ToString
@Setter
@Getter
@Alias("ordrChgHistVO")
public class OrdrChgHistVO extends CommonBaseVO {

	private int chgNo;
	private int ordrNo;
	private int ordrDtlNo;
	private String chgStts; // <= sttsTy
	private String resnTy;
	private String resn;

	private String[] ordrDtlNos; // 일괄 처리용
}
