package icube.manage.promotion.event.biz;

import java.util.Date;
import java.util.List;

import org.apache.ibatis.type.Alias;

import icube.common.file.biz.FileVO;
import icube.common.vo.CommonBaseVO;
import lombok.Getter;
import lombok.Setter;

@Setter
@Getter
@Alias("eventApplcnVO")
public class EventApplcnVO extends CommonBaseVO {

	private int applcnNo;
	private int eventNo;
	private int chcIemNo;
	private String applctId;
	private String applctNm;
	private String applctUniqueId;
	private String applctTelno;
	private Date applctDt;
	private String ip;

	//eventVO
	private String eventNm;
	private Date bgngDt;
	private Date endDt;
	private Date prsntnYmd;

	private int przwinCount;

	private List<FileVO> fileList;
}