package icube.manage.promotion.event.biz;

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
@Alias("eventVO")
public class EventVO extends CommonBaseVO {
	private int eventNo;
	private String eventTrgt;
	private String eventTy = "F";
	private String eventNm;
	private String eventCn;
	@DateTimeFormat(pattern = "yyyy-MM-dd")
	private Date bgngDt;
	private String bgngTime;
	@DateTimeFormat(pattern = "yyyy-MM-dd")
	private Date endDt;
	private String endTime;
	@DateTimeFormat(pattern = "yyyy-MM-dd")
	private Date prsntnYmd;
	private String dspyYn = "Y";

	private String surTy;  // 설문 형태

	private List<FileVO> fileList;

	private List<FileVO> iemList; // 이벤트 항목

	private int applcnCount;

	//event_przwinVO
	private int przwinNo;
	private int przwinCount;

	private EventPrzwinVO eventPrzwinVO;
}