package icube.manage.promotion.coupon.biz;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.egovframe.rte.fdl.string.EgovStringUtil;
import org.springframework.stereotype.Service;

import icube.common.framework.abst.CommonAbstractServiceImpl;
import icube.common.util.RandomUtil;
import icube.common.vo.CommonListVO;



@Service("couponLstService")
@SuppressWarnings({"unchecked", "rawtypes"})
public class CouponLstService extends CommonAbstractServiceImpl {

	@Resource(name="couponLstDAO")
	private CouponLstDAO couponLstDAO;

	/**
	 * 쿠폰 발행
	 * @param SET uniqueId
	 * @param couponLstVO
	 * @throws Exception
	 */
	public void insertCouponLst(CouponLstVO couponLstVO) throws Exception {

		//쿠폰 번호 등록
		String couponCd = RandomUtil.ranNum();
		couponLstVO.setCouponCd(couponCd);

		couponLstDAO.insertCouponLst(couponLstVO);
	}

	/**
	 * 발행된 쿠폰 리스트
	 * @param listVO
	 * @return
	 * @throws Exception
	 */
	public CommonListVO couponLstListVO(CommonListVO listVO) throws Exception {
		return couponLstDAO.selectLstListVO(listVO);
	}

	/**
	 * 해당 쿠폰 발행 내역
	 * @param reqMap
	 * @return
	 * @throws Exception
	 */

	public List<CouponLstVO> selectCouponIssuList(Map<String, Object> reqMap) throws Exception {
		Map paramMap = new HashMap();
		paramMap.put("couponNo", EgovStringUtil.string2integer((String)reqMap.get("couponNo")));
		paramMap.put("couponNm", (String)reqMap.get("couponNm"));
		return couponLstDAO.selectCouponIssuList(paramMap);
	}

	/**
	 * 쿠폰 잔여수량 카운트
	 * @param paramMap
	 * @return
	 * @throws Exception
	 */
	public int selectCouponCnt(Map paramMap) throws Exception {
		return couponLstDAO.selectCouponCnt(paramMap);
	}

	/**
	 * 쿠폰 사용 처리
	 * @param couponNo, uniqueId > Map
	 * @throws Exception
	 */
	public void updateCouponUseYn(Map paramMap) throws Exception {
		paramMap.put("useYn", "Y");
		couponLstDAO.updateCouponUseYn(paramMap);
	}

	/**
	 * 쿠폰 적용 대상 조회
	 * @param paramMap
	 * @return
	 * @throws Exception
	 */
	public int selectCouponTrgtCnt(Map<String, Object> paramMap) throws Exception{
		return couponLstDAO.selectTrgtCnt(paramMap);
	}

	/**
	 * 쿠폰 발급 대상 조회 by Map
	 * @param paramMap
	 * @return
	 * @throws Exception
	 */
	public List<CouponLstVO> selectLstListByMap(Map<String, Object> paramMap) throws Exception {
		return couponLstDAO.selectLstListByMap(paramMap);
	}

	/**
	 * 쿠폰 상태별 카운트 Map
	 * @param request
	 * @return 사용가능한 쿠폰, 사용한 쿠폰, 만료된 쿠폰 개수 Map
	 * @throws Exception
	 */
	public Map<String, Integer> selectAllTypeCoupon(String uniqueId) throws Exception {
		Map<String, Integer> resultMap = new HashMap();
		Map<String, Object> paramMap = new HashMap();
		paramMap.put("uniqueId", uniqueId);

		// 사용 가능한 쿠폰
		paramMap.put("srchUseYn", "N");
		paramMap.put("srchUseCoupon", 1); // 1 의미 없음.
		int availCount = this.selectCouponCnt(paramMap);

		// 사용한 쿠폰
		paramMap.put("srchUseYn", "Y");
		int usedCount = this.selectCouponCnt(paramMap);;

		// 사용 만료된 쿠폰
		paramMap.put("srchUseYn", null);
		paramMap.put("srchUseCoupon", null); // 1 의미 없음.
		paramMap.put("srchExpiry", "1"); // 1 의미 없음.
		int exitCount = this.selectCouponCnt(paramMap);;

		resultMap.put("avail", availCount);
		resultMap.put("used", usedCount);
		resultMap.put("exit", exitCount);

		return resultMap;
	}

	public List<CouponLstVO> selectOwnCouponList(Map<String, Object> paramMap) throws Exception {
		return couponLstDAO.selectOwnCouponList(paramMap);
	}

	public void updateCouponUseYnNull(Map<String, Object> paramMap) throws Exception {
		couponLstDAO.updateCouponUseYnNull(paramMap);
	}
}