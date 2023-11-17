package icube.manage.mbr.mbr.biz;

import java.util.Date;
import java.util.List;

import org.apache.ibatis.type.Alias;

import icube.common.vo.CommonBaseVO;
import lombok.Getter;
import lombok.Setter;

@Setter
@Getter
@Alias("mbrMngInfoVO")
public class MbrMngInfoVO extends CommonBaseVO {
	private int mngInfoNo;
	private String uniqueId;
	private String mngTy;
	private String mngSe;
	private Date stopBgngYmd;
	private Date stopEndYmd;
	private String resnCd;
	private String mngrMemo;

	//add mbrVO column
	private String mbrId;
	private String mbrNm;
	private String gender;
	private String mblTelno;
	private String eml;
	private String joinTy;

	private List<MbrMngInfoVO> idList;

	private MbrVO mbrVO;
}