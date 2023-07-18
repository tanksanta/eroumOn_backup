package icube.manage.exhibit.main.biz;

import java.util.List;

import org.apache.ibatis.type.Alias;

import icube.common.file.biz.FileVO;
import icube.common.vo.CommonBaseVO;
import lombok.Getter;
import lombok.Setter;

@Setter
@Getter
@Alias("mainMngVO")
public class MainMngVO extends CommonBaseVO {

	private int mainNo;
	private int sortNo = 100;
	private String themaTy = "G";
	private String sj;
	private int rdcnt = 0;;
	private String icon;
	private String linkUrl = "#";

	private List<FileVO> pcImgFileList;
	private List<FileVO> mobileImgFileList;
	private List<FileVO> halfFileList;
	private List<FileVO> fileList;

	private List<MainGdsMngVO> gdsList;
}