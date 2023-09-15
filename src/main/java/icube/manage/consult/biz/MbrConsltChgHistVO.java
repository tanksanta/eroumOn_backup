package icube.manage.consult.biz;

import java.util.Date;

import org.apache.ibatis.type.Alias;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@ToString
@Setter
@Getter
@Alias("mbrConsltChgHistVO")
public class MbrConsltChgHistVO {
	private int chgNo;
	private int consltNo;
	private String consltSttusChg;      //상담 변경 상태
	private Integer bplcConsltNo;
	private String bplcConsltSttusChg;  //사업소 상담 변경 상태
	private String resn;
	private Date regDt;
	private String mbrUniqueId;
	private String mbrId;
	private String mbrNm;
	private String mngrUniqueId;
	private String mngrId;
	private String mngrNm;
	private String bplcUniqueId;
	private String bplcId;
	private String bplcNm;
}