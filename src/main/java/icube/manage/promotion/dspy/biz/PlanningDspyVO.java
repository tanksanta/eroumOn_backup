package icube.manage.promotion.dspy.biz;

import java.util.Date;
import java.util.List;

import org.apache.ibatis.type.Alias;
import org.springframework.format.annotation.DateTimeFormat;

import icube.common.file.biz.FileVO;
import icube.common.vo.CommonBaseVO;
import lombok.Getter;
import lombok.Setter;

@Setter
@Getter
@Alias("planningDspyVO")
public class PlanningDspyVO extends CommonBaseVO{


	private int planngDspyNo;
	private String planngDspyNm;
	private String cn;
	@DateTimeFormat(pattern = "yyyy-MM-dd")
	private Date bgngDt;
	private String bgngTime;
	@DateTimeFormat(pattern = "yyyy-MM-dd")
	private Date endDt;
	private String endTime;
	private String dspyYn = "Y";

	private List<FileVO> fileList;

	//상품구성

	private String grpNm;
	private int exhibiCo;
	private String sortNo;
	private int grpNo;


	//기획 상품수
	private int gdsCount;

	//등록 기획전 수
	private int regCount;


}
