package icube.manage.mbr.recipients.biz;

import java.util.Date;

import org.apache.ibatis.type.Alias;
import org.springframework.format.annotation.DateTimeFormat;

import lombok.Getter;
import lombok.Setter;

@Setter
@Getter
@Alias("mbrRecipientsVO")
public class MbrRecipientsVO {
	private int recipientsNo;
	private String mbrUniqueId;
	private String recipientsNm;
	private String recipientsYn;  //수급자 여부
	private String rcperRcognNo;  //요양인정 번호
	private String tel;
	private String sido;
	private String sigugun;
	private String dong;
	private String gender;
	@DateTimeFormat(pattern = "yyyy-MM-dd")
	private String brdt;
	private String relationCd;  //관계 코드
	private String mainYn;      //대표 수급자
	private Date regDt;
	private Date mdfcnDt;
	private String delYn;
	private Date delDt;
	private String delMbrUniqueId;
	private String delMngrUniqueId;
}
