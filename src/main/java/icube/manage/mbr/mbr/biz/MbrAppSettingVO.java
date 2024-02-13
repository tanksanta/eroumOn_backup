package icube.manage.mbr.mbr.biz;

import java.util.Date;

import org.apache.ibatis.type.Alias;
import org.springframework.format.annotation.DateTimeFormat;

import lombok.Getter;
import lombok.Setter;

@Setter
@Getter
@Alias("mbrAppSettingVO")
public class MbrAppSettingVO {
	private int appSettingNo;
	private String mbrUniqueId;
	
	//알림 권한
	private String pushToken;
	private String allowPushYn;
	@DateTimeFormat(pattern = "yyyy-MM-dd HH:mm:ss")
	private Date allowPushDt;
	
	//위치 권한
	private String allowLocationYn;
	@DateTimeFormat(pattern = "yyyy-MM-dd HH:mm:ss")
	private Date allowLocationDt;
	
	//전화 권한
	private String allowTelYn;
	@DateTimeFormat(pattern = "yyyy-MM-dd HH:mm:ss")
	private Date allowTelDt;
	
	//자동로그인
	private String autoLgnYn;
	@DateTimeFormat(pattern = "yyyy-MM-dd HH:mm:ss")
	private Date autoLgnDt;
	
	private Date regDt;
	private Date mdfcnDt;
}