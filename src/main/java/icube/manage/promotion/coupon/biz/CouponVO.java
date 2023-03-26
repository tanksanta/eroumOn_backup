package icube.manage.promotion.coupon.biz;

import java.util.Date;

import org.apache.ibatis.type.Alias;
import org.springframework.format.annotation.DateTimeFormat;

import icube.common.vo.CommonBaseVO;
import lombok.Getter;
import lombok.Setter;

@Setter
@Getter
@Alias("couponVO")
public class CouponVO extends CommonBaseVO {
	private int couponNo;
	private String couponCd;
	private String couponNm;
	private String couponTy = "NOR";
	@DateTimeFormat(pattern = "yyyy-MM-dd")
	private Date issuBgngDt;
	private Date issuBgngTime;
	@DateTimeFormat(pattern = "yyyy-MM-dd")
	private Date issuEndDt;
	private Date issuEndTime;
	private int issuQy;
	private String usePdTy;
	private int usePsbltyDaycnt;
	@DateTimeFormat(pattern = "yyyy-MM-dd")
	private Date useBgngYmd;
	@DateTimeFormat(pattern = "yyyy-MM-dd")
	private Date useEndYmd;
	private String dscntTy = "PRCS" ;
	private int dscntAmt;
	private int mummOrdrAmt;
	private int mxmmDscntAmt;
	private String issuMbr;
	private String issuMbrTy;
	private String issuMbrGrad;
	private String issuGds = "A";
	private String issuTy = "MNG";
	private String mngrMemo;
	private String sttsTy = "USE";


	//couponLstVO
	private int trgtCount;


}