package icube.manage.promotion.coupon.biz;

import java.util.Map;

import org.springframework.stereotype.Repository;

import icube.common.framework.abst.CommonAbstractMapper;
import icube.common.vo.CommonListVO;

@Repository("couponDAO")
public class CouponDAO extends CommonAbstractMapper {

	public CommonListVO couponListVO(CommonListVO listVO) throws Exception {
		return selectListVO("coupon.selectCouponCount", "coupon.selectCouponListVO", listVO);
	}

	public CouponVO selectCoupon(int couponNo) throws Exception {
		return (CouponVO)selectOne("coupon.selectCoupon", couponNo);
	}

	public void insertCoupon(CouponVO couponVO) throws Exception {
		insert("coupon.insertCoupon", couponVO);
	}

	public void updateCoupon(CouponVO couponVO) throws Exception {
		update("coupon.updateCoupon", couponVO);
	}

	public int selectCouponCount(Map<String, Object> paramMap) throws Exception {
		return selectOne("coupon.selectCouponCount",paramMap);
	}

	public CouponVO selectCoupon(Map<String, Object> paramMap) throws Exception {
		return selectOne("coupon.selectCouponInfo",paramMap);
	}

}