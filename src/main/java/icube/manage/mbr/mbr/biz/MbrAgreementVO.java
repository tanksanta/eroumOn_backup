package icube.manage.mbr.mbr.biz;

import java.util.Date;

import org.apache.ibatis.type.Alias;

import lombok.Getter;
import lombok.Setter;

@Setter
@Getter
@Alias("mbrAgreementVO")
public class MbrAgreementVO {
	private int agreementNo;
	private String mbrUniqueId;
	private String termsYn;
	private String privacyYn;
	private String provisionYn;
	private String thirdPartiesYn;
	private Date regDt;
	private Date mdfcnDt;
}
