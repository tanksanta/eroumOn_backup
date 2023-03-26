package icube.manage.promotion.coupon.biz;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import icube.common.framework.abst.CommonAbstractServiceImpl;



@Service("couponAplcnTrgtService")
public class CouponAplcnTrgtService extends CommonAbstractServiceImpl {

	@Resource(name="couponAplcnTrgtDAO")
	private CouponAplcnTrgtDAO couponAplcnTrgtDAO;

	public void insertAplcnTrgt(CouponAplcnTrgtVO couponAplcnTrgtVO) throws Exception {
		couponAplcnTrgtDAO.insertAplcnTrgt(couponAplcnTrgtVO);
	}

	public List<CouponVO> selectAplcnTrgtList(int couponNo) throws Exception {
		return couponAplcnTrgtDAO.selectAplcnTrgtList(couponNo);
	}

	public CouponAplcnTrgtVO selectAplcnTrgtByMap(Map<String, Object> paramMap) throws Exception{
		return couponAplcnTrgtDAO.selectAplcnTrgtByMap(paramMap);
	}





}