package icube.manage.exhibit.popup.biz;

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
@Alias("popupVO")
public class PopupVO extends CommonBaseVO {

	private int popNo;
	private String popSj;
	@DateTimeFormat(pattern = "yyyy-MM-dd")
	private Date bgngDt;
	private String bgngTime;
	@DateTimeFormat(pattern = "yyyy-MM-dd")
	private Date endDt;
	private String endTime;
	private int popHeight;
	private int popWidth;
	private int popLeft;
	private int popTop;  // 팝업 유형
	private String popTy;
	private String oneViewTy = "N";
	private String linkUrl;
	private String linkTy;

	private List<FileVO> fileList;

}