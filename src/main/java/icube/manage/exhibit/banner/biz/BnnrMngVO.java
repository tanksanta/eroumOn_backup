package icube.manage.exhibit.banner.biz;

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
@Alias("bnnrMngVO")
public class BnnrMngVO extends CommonBaseVO {
	private int bannerNo;
	private String bannerNm;
	private String bannerTy = "M";
	private String linkTy = "P";
	private String linkUrl = "#";
	@DateTimeFormat(pattern = "yyyy-MM-dd")
	private Date bgngDt;
	@DateTimeFormat(pattern = "yyyy-MM-dd")
	private Date endDt;
	private String bgngTime;
	private String endTime;
	private int sortNo = 100;
	private int rdcnt = 0;
	private String color;

	// fileVO
	private List<FileVO> mobileFileList;
	private List<FileVO> pcFileList;
}