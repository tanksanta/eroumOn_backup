package icube.manage.promotion.point.biz;

import org.apache.ibatis.type.Alias;

import icube.common.vo.CommonBaseVO;
import lombok.Getter;
import lombok.Setter;

@Setter
@Getter
@Alias("pointMngVO")
public class PointMngVO extends CommonBaseVO {
	private int pointMngNo;
	private String pointSe = "A";
	private String pointCn = "N";
	private int point;
	private String mngrMemo;

	//대상 인원수
	private int targetCnt;

}