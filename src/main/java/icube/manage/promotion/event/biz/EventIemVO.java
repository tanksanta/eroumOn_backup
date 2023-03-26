package icube.manage.promotion.event.biz;

import org.apache.ibatis.type.Alias;

import icube.common.vo.CommonBaseVO;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
@Alias("eventIemVO")
public class EventIemVO extends CommonBaseVO{

	private int iemNo;
	private String iemTy;
	private int eventNo;
	private String iemCn;
	private int sortNo;
	private int iemImgNo;


	//항목당 응모자 수
	private int applcnIemCount;
}
