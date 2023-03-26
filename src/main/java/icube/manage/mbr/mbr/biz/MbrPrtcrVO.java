package icube.manage.mbr.mbr.biz;

import java.util.Date;

import org.apache.ibatis.type.Alias;

import icube.common.vo.CommonBaseVO;
import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@ToString
@Setter
@Getter
@Alias("mbrPrtcrVO")
public class MbrPrtcrVO extends CommonBaseVO{

	private int prtcrMbrNo;
	private String uniqueId;
	private String  prtcrUniqueId;
	private Date dmndDt;
	private Date aprvDt;
	private String reqTy;
	private String prtcrRlt;
	private String rltEtc;

	//mbrVO
	private String mbrUniqueId;
	private String mbrId;
	private String mblTelno;
	private String mbrNm;
	private Date brdt;
	private String proflImg;
	private String recipterYn = "N";

	private String appTy; // 발신/수신 구분

	// mbrPoint, mlg
	private int mbrPoint;
	private int mbrMlg;


}
