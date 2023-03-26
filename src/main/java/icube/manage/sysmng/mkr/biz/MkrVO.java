package icube.manage.sysmng.mkr.biz;

import org.apache.ibatis.type.Alias;

import icube.common.vo.CommonBaseVO;
import lombok.Getter;
import lombok.Setter;

@Setter
@Getter
@Alias("mkrVO")
public class MkrVO extends CommonBaseVO {
	private int mkrNo;
	private String mkrNm;

}