package icube.manage.promotion.coupon.biz;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import icube.common.framework.abst.CommonAbstractMapper;
import icube.common.vo.CommonListVO;

@Repository("couponLstDAO")
@SuppressWarnings("rawtypes")
public class CouponLstDAO extends CommonAbstractMapper {


	/**
	 * 쿠폰 발행
	 * @param couponLstVO
	 * @throws Exception
	 */
	public void insertCouponLst(CouponLstVO couponLstVO) throws Exception {
		insert("coupon.lst.insertCouponLst", couponLstVO);
	}

	/**
	 * 발행된 쿠폰 리스트
	 * @param listVO
	 * @return
	 * @throws Exception
	 */
	public CommonListVO selectLstListVO(CommonListVO listVO) throws Exception {
		return selectListVO("coupon.lst.selectCountLst","coupon.lst.selectLstListVO",listVO);
	}

	/**
	 * 해당 쿠폰 발행 내역
	 * @param paramMap
	 * @return
	 * @throws Exception
	 */

	public List<CouponLstVO> selectCouponIssuList(Map paramMap) throws Exception {
		return selectList("coupon.lst.selectCouponIssuList",paramMap);
	}

	/**
	 * 쿠폰 잔여수량 카운트
	 * @param paramMap
	 * @return
	 * @throws Exception
	 */
	public int selectCouponCnt(Map paramMap) throws Exception{
		return selectOne("coupon.lst.selectCouponCnt",paramMap);
	}

	/**
	 * 쿠폰 사용 처리
	 * @param paramMap
	 * @throws Exception
	 */
	public void updateCouponUseYn(Map paramMap) throws Exception {
		update("coupon.lst.updateCouponUseYn",paramMap);
	}

	/**
	 * 쿠폰 적용 대상 조회
	 * @param paramMap
	 * @return
	 * @throws Exception
	 */
	public int selectTrgtCnt(Map<String, Object> paramMap) throws Exception{
		return selectOne("coupon.lst.selectTrgtCnt", paramMap);
	}

	/**
	 * 쿠폰 발급 대상 조회 by Map
	 * @param paramMap
	 * @return
	 * @throws Exception
	 */
	public List<CouponLstVO> selectLstListByMap(Map<String, Object> paramMap) throws Exception{
		return selectList("coupon.lst.selectLstListByMap",paramMap);
	}

	public List<CouponLstVO> selectOwnCouponList(Map<String, Object> paramMap) throws Exception {
		return selectList("coupon.lst.selectOwnCouponList",paramMap);
	}

	public void updateCouponUseYnNull(Map<String, Object> paramMap) throws Exception {
		update("coupon.lst.updateCouponUseYnNull",paramMap);
	}

}