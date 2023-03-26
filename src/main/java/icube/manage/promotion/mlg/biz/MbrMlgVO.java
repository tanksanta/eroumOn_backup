package icube.manage.promotion.mlg.biz;

import java.util.Date;
import java.util.List;

import org.apache.ibatis.type.Alias;

import icube.common.vo.CommonBaseVO;
import icube.manage.mbr.mbr.biz.MbrVO;
import lombok.Getter;
import lombok.Setter;

@Setter
@Getter
@Alias("mbrMlgVO")
public class MbrMlgVO extends CommonBaseVO {
	private int mlgNo;
	private int mlgMngNo;
	private String uniqueId;
	//private int ordrNo;
	private String ordrCd;
	private String ordrDtlCd;
	private String mlgSe ="A"; //A 증가, M 감소
	private String mlgCn = "1";
	private int mlg = 0;
	private int useMlg = 0;
	private int mlgAcmtl = 0;
	private String giveMthd;

	//회원별 마일리지
	private List<MbrVO> mbrList;

	// mbrVO
	private String mbrNm;
	private String mbrId;
	private String eml;
	private String mbrUniqueId;

	// mlgMngVO
	private String MngrMemo;
	private int dedMlg;
	private Date fmtDt;
	private Date now;
	private Date dedMlgDt;
	private int mlgTotal;

	// mbrPointVO
	private int mbrPoint;
	private int dedPoint;
	private Date dedDt;




}