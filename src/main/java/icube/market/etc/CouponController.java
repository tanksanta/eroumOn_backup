package icube.market.etc;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.egovframe.rte.fdl.string.EgovStringUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import icube.common.framework.abst.CommonAbstractController;
import icube.common.util.RandomUtil;
import icube.common.values.CodeMap;
import icube.common.vo.CommonListVO;
import icube.manage.mbr.mbr.biz.MbrService;
import icube.manage.mbr.mbr.biz.MbrVO;
import icube.manage.promotion.coupon.biz.CouponAplcnTrgtService;
import icube.manage.promotion.coupon.biz.CouponAplcnTrgtVO;
import icube.manage.promotion.coupon.biz.CouponLstService;
import icube.manage.promotion.coupon.biz.CouponLstVO;
import icube.manage.promotion.coupon.biz.CouponService;
import icube.manage.promotion.coupon.biz.CouponVO;
import icube.market.mbr.biz.MbrSession;

/**
 * 마켓 > 쿠폰존
 * @author ogy
 *
 */
@Controller
@RequestMapping(value="#{props['Globals.Market.path']}/etc/coupon")
public class CouponController extends CommonAbstractController{

	@Resource(name="couponService")
	private CouponService couponService;

	@Resource(name="couponLstService")
	private CouponLstService couponLstService;

	@Resource(name = "couponAplcnTrgtService")
	private CouponAplcnTrgtService couponAplcnTrgtService;

	@Resource(name="mbrService")
	private MbrService mbrService;

	@Autowired
	private MbrSession mbrSession;

	@Value("#{props['Globals.Market.path']}")
	private String marketPath;

	/**
	 * 쿠폰 목록 (다운로드 발급)
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="list")
	@SuppressWarnings({"rawtypes","unchecked"})
	public String list(
			HttpServletRequest request
			, Model model
			)throws Exception {

		CommonListVO listVO = new CommonListVO(request);

		// 다운로드 쿠폰
		listVO.setParam("srchIssuTy", "DWLD");
		listVO.setParam("srchDt", "issuDy");
		listVO.setParam("srchIssuDt", "issu");
		listVO.setParam("srchSttusTy", "USE");
		listVO.setParam("uniqueId", mbrSession.getUniqueId());
		listVO = couponService.couponListVO(listVO);

		//발급내역
		Map paramMap = new HashMap();
		paramMap.put("uniqueId", mbrSession.getUniqueId());
		List<CouponLstVO> cpnList = couponLstService.selectLstListByMap(paramMap);

		model.addAttribute("listVO", listVO);
		model.addAttribute("cpnList", cpnList);
		model.addAttribute("gradCode", CodeMap.GRADE);

		return "/market/etc/coupon";
	}

	/**
	 * 쿠폰 대상 조회
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="srchCouponTarget.json")
	@SuppressWarnings({"rawtypes","unchecked"})
	@ResponseBody
	public int couponDwld(
			HttpServletRequest request
			, @RequestParam(value = "couponNo", required = true) String couponNo
			, Model model) throws Exception {

		// 대상 x
		int cnt = 0;

		// 로그인 체크
		if (!mbrSession.isLoginCheck()) {
			// 로그인 msg
			cnt = 1;
		} else {

			Map paramMap = new HashMap();
			paramMap.put("srchUniqueId", mbrSession.getUniqueId());

			// 회원 정보 조회
			MbrVO mbrVO = mbrService.selectMbr(paramMap);

			// 쿠폰 정보 조회
			CouponVO couponVO = couponService.selectCoupon(EgovStringUtil.string2integer(couponNo));

			// 쿠폰 대상 조회

			// 0. 발급 여부 조회
			paramMap.put("couponNo", couponNo);
			paramMap.put("uniqueId", mbrSession.getUniqueId());

			int result = couponLstService.selectCouponTrgtCnt(paramMap);

			if (result != 0) {
				// 이미 발급
				cnt = 3;
			} else {

				// 1. 개별 회원
				if ((couponVO.getIssuMbr()).equals("I")) {
					if (result == 0) {
						// 성공 msg
						cnt = 2;
					}
				} else {
					// 2. 회원 구분 / 회원 등급
					switch (couponVO.getIssuMbrTy()) {
					// 일반회원
					case "G":
						if ((mbrVO.getRecipterYn()).equals("N")) {
							// 성공 msg
							cnt = 2;
						}
						break;

					// 수급자 회원
					case "R":
						if ((mbrVO.getRecipterYn()).equals("Y")) {
							// 성공 msg
							cnt = 2;
						}
						break;

					// 전체
					case "G,R":
						cnt = 2;
						break;

					default:
						break;

					}

					// 3. 회원 등급
					if (!EgovStringUtil.isNull(couponVO.getIssuMbrGrad())) {
						if (!(mbrVO.getMberGrade()).equals(couponVO.getIssuMbrGrad())) {
							// 실패 msg
							cnt = 0;
						}
					}
				}
			}

		}

		return cnt;
	}

	/**
	 * 쿠폰 다운로드 발급 처리
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="couponDwld.json")
	@ResponseBody
	@SuppressWarnings({"rawtypes","unchecked"})
	public boolean couponDwld(
			HttpServletRequest request
			, Model model
			, @RequestParam (value="couponNo", required=true) String couponNo
			) throws Exception{

		boolean result = false;

		if(EgovStringUtil.isNotEmpty(mbrSession.getUniqueId())) {

			Map paramMap = new HashMap();
			paramMap.put("uniqueId", mbrSession.getUniqueId());
			paramMap.put("couponNo", couponNo);

			//등록 수량
			int rmnQnt = couponLstService.selectCouponCnt(paramMap);

			CouponVO couponVO = couponService.selectCoupon(EgovStringUtil.string2integer(couponNo));

			if((couponVO.getIssuQy() - rmnQnt) > 0) {
				CouponLstVO couponLstVO = new CouponLstVO();
				couponLstVO.setCouponNo(EgovStringUtil.string2integer(couponNo));
				couponLstVO.setUniqueId(mbrSession.getUniqueId());
				couponLstVO.setCouponCd(RandomUtil.ranNum());
				if(couponVO.getIssuQy() == 9999){
					couponLstVO.setUltYn("Y");
				}
				// 사용 가능 기간 구분
				if(couponVO.getUsePdTy().equals("ADAY")) {
					couponLstVO.setUseDay(couponVO.getUsePsbltyDaycnt());
				}
				else if (couponVO.getUsePdTy().equals("FIX")) {
					couponLstVO.setUseLstBgngYmd(couponVO.getUseBgngYmd());
					couponLstVO.setUseLstEndYmd(couponVO.getUseEndYmd());
				}
				couponLstService.insertCouponLst(couponLstVO);

				result = true;
			}
		}

		return result;
	}

	/**
	 * 사용자 적용 상품 체크
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "ChkGdsInfo.json")
	@ResponseBody
	public Map<String, Object> resultMap(
			@RequestParam(value = "gdsNo", required=true) int gdsNo
			, @RequestParam(value = "couponNo", required=true) int couponNo
			, HttpServletRequest request
			, Model model
			)throws Exception {

		Map<String, Object> resultMap = new HashMap<String, Object>();
		Map<String, Object> paramMap = new HashMap<String, Object>();
		boolean result = false;

		//쿠폰 적용 상품
		paramMap.put("srchCouponNo", couponNo);
		CouponVO couponVO = couponService.selectCoupon(couponNo);

		if(couponVO != null) {
			if(couponVO.getIssuGds().equals("I")) {
				paramMap.clear();
				paramMap.put("srchGdsNo", gdsNo);
				paramMap.put("srchCouponNo", couponNo);
				CouponAplcnTrgtVO couponAplcnTrgtVO = couponAplcnTrgtService.selectAplcnTrgtByMap(paramMap);

				if(couponAplcnTrgtVO != null) {
					result = true;
				}
			}else {
				result = true;
			}
		}

		resultMap.put("result", result);

		return resultMap;
	}


}
