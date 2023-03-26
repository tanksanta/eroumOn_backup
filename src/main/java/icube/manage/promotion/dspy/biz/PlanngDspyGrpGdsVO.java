package icube.manage.promotion.dspy.biz;

import java.util.List;

import org.apache.ibatis.type.Alias;

import icube.common.file.biz.FileVO;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
@Alias("planngDspyGrpGdsVO")
public class PlanngDspyGrpGdsVO {

	private int planngDspyNo;
	private int grpNo;
	private int gdsNo;
	private int sortNo;

	//gdsVO

	private String gdsCd;
	private String gdsNm;
	private String ntslSttsCd;
	private String useYn;
	private String ctgryNm;
	private String upCtgryNm;
	private int pc;
	private String soldoutYn;



	private List<PlanngDspyGrpGdsVO> regCount;

	//gds
	private FileVO thumbnailFile; //대표(썸네일) 이미지
}
