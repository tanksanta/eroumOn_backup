package icube.manage.mbr.mbr.biz;

import java.util.Date;

import org.apache.ibatis.type.Alias;
import org.springframework.format.annotation.DateTimeFormat;

import lombok.Getter;
import lombok.Setter;

@Setter
@Getter
@Alias("mbrAgreementVO")
public class MbrAgreementVO {
	private int agreementNo;
	private String mbrUniqueId;
	private String termsYn;
	@DateTimeFormat(pattern = "yyyy-MM-dd HH:mm:ss")
	private Date termsDt;
	private String privacyYn;
	@DateTimeFormat(pattern = "yyyy-MM-dd HH:mm:ss")
	private Date privacyDt;
	private String provisionYn;
	@DateTimeFormat(pattern = "yyyy-MM-dd HH:mm:ss")
	private Date provisionDt;
	private String thirdPartiesYn;
	@DateTimeFormat(pattern = "yyyy-MM-dd HH:mm:ss")
	private Date thirdPartiesDt;
	private Date regDt;
	private Date mdfcnDt;
}
