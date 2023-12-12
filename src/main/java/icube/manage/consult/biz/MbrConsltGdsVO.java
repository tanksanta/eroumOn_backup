package icube.manage.consult.biz;

import java.util.Date;

import org.apache.ibatis.type.Alias;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@ToString
@Setter
@Getter
@Alias("mbrConsltGdsVO")
public class MbrConsltGdsVO {
	private int consltGdsNo;
	private int consltNo;
	private String consltGdsTy;
	private String ctgryNm;
	private String careCtgryCd;
	private int gdsNo;
	private String mbrUniqueId;
	private String mbrId;
	private String mbrNm;
	private Date regDt;
}
