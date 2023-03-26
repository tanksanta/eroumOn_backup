package icube.manage.sysmng.entrps.biz;

import java.util.Date;

import org.apache.ibatis.type.Alias;
import org.springframework.format.annotation.DateTimeFormat;

import icube.common.vo.CommonBaseVO;
import lombok.Getter;
import lombok.Setter;

@Setter
@Getter
@Alias("entrpsVO")
public class EntrpsVO extends CommonBaseVO {
	private int entrpsNo;
	private String entrpsNm;
	private String brno;
	private String rprsvNm;
	private String induty;
	private String bizcnd;
	private String zip;
	private String addr;
	private String daddr;

	private String telno;
	private String fxno;


	private String eml;
	private String tkcgMd;
	private int dlvyCtCnd;
	private String clclnCycle;
	private String bankNm;
	private String actno;
	private String dpstr;

	@DateTimeFormat(pattern = "yyyy-MM-dd")
	private Date ctrtBgngYmd;
	@DateTimeFormat(pattern = "yyyy-MM-dd")
	private Date ctrtEndYmd;
	@DateTimeFormat(pattern = "yyyy-MM-dd")
	private Date ctrtYmd;
	private int fee;
	private String picNm;
	private String picTelno;
	private String picTelnoHp;
	private String picEml;
	private String picJob;
}