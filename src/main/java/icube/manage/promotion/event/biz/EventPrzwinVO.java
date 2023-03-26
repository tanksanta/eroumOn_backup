package icube.manage.promotion.event.biz;

import java.util.List;

import org.apache.ibatis.type.Alias;

import icube.common.file.biz.FileVO;
import icube.common.vo.CommonBaseVO;
import lombok.Getter;
import lombok.Setter;

@Setter
@Getter
@Alias("eventPrzwinVO")
public class EventPrzwinVO extends CommonBaseVO {

	private int przwinNo;
	private int eventNo;
	private String cn;
	private String dspyYn="Y";

	private List<FileVO> fileList;

}