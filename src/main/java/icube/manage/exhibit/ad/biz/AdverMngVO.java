package icube.manage.exhibit.ad.biz;

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
@Alias("adverMngVO")
public class AdverMngVO extends CommonBaseVO {
	private int adverNo;
	private String adverNm;
	private String adverArea;
	private String linkTy;
	private String linkUrl;
	@DateTimeFormat(pattern = "yyyy-MM-dd")
	private Date bgngDt;
	@DateTimeFormat(pattern = "yyyy-MM-dd")
	private Date endDt;
	private String bgngTime;
	private String endTime;


	//fileVO
	private List<FileVO> fileList;
}