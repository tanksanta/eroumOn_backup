package icube.manage.promotion.point.biz;

import java.util.Date;
import java.util.List;

import org.apache.ibatis.type.Alias;

import icube.common.vo.CommonBaseVO;
import icube.manage.mbr.mbr.biz.MbrVO;
import lombok.Getter;
import lombok.Setter;

@Setter
@Getter
@Alias("mbrPointVO")
public class MbrPointVO extends CommonBaseVO {
	private int pointNo;
	private int pointMngNo;
	private String uniqueId;
	private int ordrNo;
	private String ordrCd;
	private String ordrDtlCd;
	private String pointSe = "A";
	private String pointCn = "1";
	private int point = 0;
	private int pointAcmtl = 0;;
	private String giveMthd;
	private Date fmtDt;

	private String mngrMemo;

	private List<MbrVO> mbrList; // 회원별 포인트

}