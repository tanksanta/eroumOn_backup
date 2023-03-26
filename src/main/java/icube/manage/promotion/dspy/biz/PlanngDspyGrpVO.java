package icube.manage.promotion.dspy.biz;

import java.util.List;

import org.apache.ibatis.type.Alias;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
@Alias("planngDspyGrpVO")
public class PlanngDspyGrpVO {
	private int grpNo;
	private int planngDspyNo;
	private String grpNm;
	private int exhibiCo;
	private int sortNo;


	private List<PlanngDspyGrpGdsVO> grpGdsList;
}
