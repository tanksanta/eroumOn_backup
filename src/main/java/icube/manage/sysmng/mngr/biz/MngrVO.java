package icube.manage.sysmng.mngr.biz;

import java.util.Date;

import org.apache.ibatis.type.Alias;

import icube.common.vo.CommonBaseVO;
import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@ToString
@Getter
@Setter
@Alias("mngrVO")
public class MngrVO extends CommonBaseVO {

	private String uniqueId;
	private String mngrId;
	private String mngrPswd;
	private String newPswd;
	private String mngrNm;
	private String authrtTy = "2";
	private String authrtTyNm;
	private int authrtNo;
	private String authrtNm;
	private String useYn = "Y";
	private String dpcnIdntyCd;

	private String nowPswd;

	private String proflImg;
	private String delProfileImg;

	private String jobTy;

	private String telno;
	private String eml;

	private Date recentLgnDt;

}