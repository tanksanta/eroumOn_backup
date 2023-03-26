package icube.manage.promotion.coupon.biz;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.egovframe.rte.fdl.string.EgovStringUtil;
import org.springframework.stereotype.Service;

import icube.common.framework.abst.CommonAbstractServiceImpl;
import icube.common.vo.CommonListVO;
import icube.manage.mbr.mbr.biz.MbrService;
import icube.manage.mbr.mbr.biz.MbrVO;



@Service("couponService")
public class CouponService extends CommonAbstractServiceImpl {

	@Resource(name="couponDAO")
	private CouponDAO couponDAO;

	@Resource(name = "mbrService")
	private MbrService mbrService;

	@Resource(name = "couponLstService")
	private CouponLstService couponLstService;

	@Resource(name="couponAplcnTrgtService")
	private CouponAplcnTrgtService couponAplcnTrgtService;

	public CommonListVO couponListVO(CommonListVO listVO) throws Exception {
		return couponDAO.couponListVO(listVO);
	}

	public CouponVO selectCoupon(int couponNo) throws Exception {
		return couponDAO.selectCoupon(couponNo);
	}

	/**
	 * 쿠폰 생성
	 * @param couponVO
	 * @param request
	 * @throws Exception
	 */
	@SuppressWarnings({"unchecked","rawtypes"})
	public void insertCoupon(CouponVO couponVO, HttpServletRequest request) throws Exception {

		//배송비 무료 > 할인구분 x
		if(couponVO.getCouponTy().equals("FREE")) {
			couponVO.setDscntTy(null);
		}


		//쿠폰 등록
		couponDAO.insertCoupon(couponVO);

		//발급 방식 구분 : 자동발급 먼저 판별
		if (couponVO.getIssuTy().equals("AUTO")) {

			if(couponVO.getCouponTy().equals("NOR") || couponVO.getCouponTy().equals("FREE")) {

				// 대상 구분 (개별회원, 단체 회원) : 단체 일때만 바로 발급
				if (couponVO.getIssuMbr().equals("D")) {
					Map paramMap = new HashMap();

					// 회원 등급 체크
					if (EgovStringUtil.isNotEmpty(couponVO.getIssuMbrGrad())) {
						paramMap.put("srchMbrGrade", couponVO.getIssuMbrGrad());
					}

					// 대상 회원 구분
					if (EgovStringUtil.isNotEmpty(couponVO.getIssuMbrTy())) {
						String[] arrMbrTy = couponVO.getIssuMbrTy().split(",");
						if (arrMbrTy.length == 2) {
							paramMap.put("srchRecipterYn", "Y");
						} else {
							paramMap.put("srchRecipter", arrMbrTy[0]);
						}
					}

					List<MbrVO> mbrList = mbrService.selectMbrListAll(paramMap);

					CouponLstVO couponLstVO = new CouponLstVO();

					// 사용 기간 구분
					if(couponVO.getUsePdTy().equals("ADAY")) {
						couponLstVO.setUseDay(couponVO.getUsePsbltyDaycnt());
					}

					couponLstVO.setCouponNo(couponVO.getCouponNo());

					for (int i = 0; i < mbrList.size(); i++) {
						couponLstVO.setUniqueId(mbrList.get(i).getUniqueId());
						couponLstService.insertCouponLst(couponLstVO);
					}
				}
			}
		}


		//적용 상품
		if(couponVO.getIssuGds().equals("I")) {
			String[] gdsNoList = request.getParameterValues("gdsNo");
			String[] gdsCdList = request.getParameterValues("gdsCd");

			//쿠폰번호, 상품 번호, 상품 코드
			CouponAplcnTrgtVO couponAplcnTrgtVO = new CouponAplcnTrgtVO();
			couponAplcnTrgtVO.setCouponNo(couponVO.getCouponNo());

			for(int i=0; i<gdsNoList.length; i++) {
				couponAplcnTrgtVO.setGdsNo(EgovStringUtil.string2integer(gdsNoList[i]));
				couponAplcnTrgtVO.setGdsCd(gdsCdList[i]);

				couponAplcnTrgtService.insertAplcnTrgt(couponAplcnTrgtVO);
			}
		}
	}

	public void updateCoupon(CouponVO couponVO) throws Exception {
		couponDAO.updateCoupon(couponVO);
	}

	public int selectCouponCount(Map<String, Object> paramMap) throws Exception{
		return couponDAO.selectCouponCount(paramMap);
	}

	public CouponVO selectCoupon(Map<String, Object> paramMap) throws Exception {
		return couponDAO.selectCoupon(paramMap);
	}

}