package icube.manage.promotion.coupon.biz;

import org.apache.ibatis.type.Alias;

import icube.common.vo.CommonBaseVO;
import lombok.Getter;
import lombok.Setter;

@Setter
@Getter
@Alias("couponAplcnTrgtVO")
public class CouponAplcnTrgtVO extends CommonBaseVO {

	private int aplcnNo;
	private int couponNo;
	private int gdsNo;
	private String gdsCd;


	//gdsVO
	private String gdsNm;
	private int pc;

}