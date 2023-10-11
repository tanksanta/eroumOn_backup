package icube.manage.consult.biz;

import java.util.Date;

import org.apache.ibatis.type.Alias;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@ToString
@Setter
@Getter
@Alias("mbrConsltMemoVO")
public class MbrConsltMemoVO {
	private int memoConsltNo;
	private int consltNo;
	private String mngMemo;
	private Date regDt;
	private String mngrUniqueId;
	private String mngrId;
	private String mngrNm;
}
