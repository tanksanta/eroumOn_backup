package icube.manage.promotion.coupon.biz;

import java.util.Date;

import org.apache.ibatis.type.Alias;

import icube.common.vo.CommonBaseVO;
import lombok.Getter;
import lombok.Setter;

@Setter
@Getter
@Alias("couponLstVO")
public class CouponLstVO extends CommonBaseVO {
	private String uniqueId;
	private int couponNo;
	private String ultYn = "N";
	private String useYn ="N";
	private Date useLstBgngYmd;
	private Date useLstEndYmd;
	private Date useDt;

	private int useDay;

	//회원
	private String mbrId;
	private String mbrNm;
	private String couponTy;
	private String couponNm;

	//쿠폰
	private String couponCd;
	private int usePsbltyDaycnt;
	private String usePdTy;
	private Date issuBgngDt;
	private Date issuEndDt;
	private Date useBgngYmd;
	private Date useEndYmd;
	private int issuQy;
	private int mummOrdrAmt;
	private int mxmmDscntAmt;
	private String dscntTy;
	private int dscntAmt;

	//TODO couponInfo 통합
	//couponInfo
	private CouponVO couponInfo;

	// 주문 번호
	private String ordrCd;

}