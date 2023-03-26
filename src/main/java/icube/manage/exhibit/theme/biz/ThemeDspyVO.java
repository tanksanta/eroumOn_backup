package icube.manage.exhibit.theme.biz;

import java.util.List;

import org.apache.ibatis.type.Alias;

import icube.common.file.biz.FileVO;
import icube.common.vo.CommonBaseVO;
import lombok.Getter;
import lombok.Setter;

@Setter
@Getter
@Alias("themeDspyVO")
public class ThemeDspyVO extends CommonBaseVO {
	private int themeDspyNo;
	private String themeDspyNm;
	private String cn;
	private String dspyYn ="Y";
	private String relYn = "N";


	//attach
	private List<FileVO> fileList;

	//등록 상품수
	private int gdsCount;


}