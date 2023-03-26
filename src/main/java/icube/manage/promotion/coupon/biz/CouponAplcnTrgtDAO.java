package icube.manage.promotion.coupon.biz;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import icube.common.framework.abst.CommonAbstractMapper;

@Repository("couponAplcnTrgtDAO")
public class CouponAplcnTrgtDAO extends CommonAbstractMapper {

	public void insertAplcnTrgt(CouponAplcnTrgtVO couponAplcnTrgtVO) throws Exception {
		insert("coupon.aplcn.trgt.insertAplcnTrgt",couponAplcnTrgtVO);
	}

	public List<CouponVO> selectAplcnTrgtList(int couponNo) throws Exception {
		return selectList("coupon.aplcn.trgt.selectAplcnTrgtList",couponNo);
	}

	public CouponAplcnTrgtVO selectAplcnTrgtByMap(Map<String, Object> paramMap) throws Exception {
		return selectOne("coupon.aplcn.trgt.selectAplcnTrgtByMap",paramMap);
	}

}