package icube.manage.sysmng.brand.biz;

import java.util.List;

import org.apache.ibatis.type.Alias;

import icube.common.file.biz.FileVO;
import icube.common.vo.CommonBaseVO;
import lombok.Getter;
import lombok.Setter;

@Setter
@Getter
@Alias("brandVO")
public class BrandVO extends CommonBaseVO {
	private int brandNo;
	private String brandNm;
	private String qlityGrnte;
	private String telno;
	private String intrcn;

	private List<FileVO> fileList;
}