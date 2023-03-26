package icube.manage.exhibit.theme.biz;

import org.apache.ibatis.type.Alias;

import icube.common.file.biz.FileVO;
import icube.common.vo.CommonBaseVO;
import lombok.Getter;
import lombok.Setter;

@Setter
@Getter
@Alias("themeDspyGdsVO")
public class ThemeDspyGdsVO extends CommonBaseVO {
	private int themeGdsNo;
	private int themeDspyNo;
	private int gdsNo;
	private int sortNo;


	//gdsVO
	private String gdsCd;
	private String gdsNm;
	private String ctgryNm;
	private String upCtgryNm;
	private String ntslSttsCd;
	private int pc;
	private String soldoutYn;

	//gdsImg
	private FileVO thumbnailFile; //대표(썸네일) 이미지
}