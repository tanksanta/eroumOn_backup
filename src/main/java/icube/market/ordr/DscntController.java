package icube.market.ordr;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import icube.common.framework.abst.CommonAbstractController;
import icube.common.values.CodeMap;
import icube.manage.gds.gds.biz.GdsService;
import icube.manage.gds.gds.biz.GdsVO;
import icube.manage.mbr.mbr.biz.MbrPrtcrService;
import icube.manage.mbr.mbr.biz.MbrPrtcrVO;
import icube.manage.mbr.mbr.biz.MbrService;
import icube.manage.promotion.coupon.biz.CouponLstService;
import icube.manage.promotion.coupon.biz.CouponLstVO;
import icube.market.mbr.biz.MbrSession;

/**
 * 결제 > 할인 수단 적용
 */

@Controller
@RequestMapping(value="/comm/dscnt")
public class DscntController extends CommonAbstractController {

	@Resource(name = "mbrService")
	private MbrService mbrService;

	@Resource(name="mbrPrtcrService")
	private MbrPrtcrService mbrPrtcrService;

	@Resource(name = "gdsService")
	private GdsService gdsService;

	@Resource(name = "couponLstService")
	private CouponLstService couponLstService;

	@Autowired
	private MbrSession mbrSession;

	@Value("#{props['Globals.Market.path']}")
	private String marketPath;


	// 마일리지
	@RequestMapping(value="mlg")
	public String mlg(
			@RequestParam Map<String,Object> reqMap
			, Model model) throws Exception {

		// 본인
		model.addAttribute("_mbrSession", mbrSession);
		Map<String, Object> mbrEtcInfoMap = new HashMap<String, Object>();
		if(mbrSession.isLoginCheck()) {
			// 급여잔액 & 마일리지 & 포인트 & 장바구니 & 위시리스트
			mbrEtcInfoMap = mbrService.selectMbrEtcInfo(mbrSession.getUniqueId());
		}
		model.addAttribute("_mbrEtcInfoMap", mbrEtcInfoMap);

		// 가족 회원 마일리지
		Map<String, Object> paramMap = new HashMap<String, Object>();
		paramMap.put("srchUniqueId", mbrSession.getUniqueId());
		paramMap.put("srchReqTy", "F");

		List<MbrPrtcrVO> prtcrList = mbrPrtcrService.selectPrtcrListByUniqueId(paramMap);
		model.addAttribute("prtcrList", prtcrList);

		// 기타
		model.addAttribute("prtcrRltCode", CodeMap.PRTCR_RLT);

		return "/market/ordr/include/modal_mlg";
	}


	// 포인트
	@RequestMapping(value="point")
	public String point(
			@RequestParam Map<String,Object> reqMap
			, Model model) throws Exception {


		// 본인
		model.addAttribute("_mbrSession", mbrSession);
		Map<String, Object> mbrEtcInfoMap = new HashMap<String, Object>();
		if(mbrSession.isLoginCheck()) {
			// 급여잔액 & 마일리지 & 포인트 & 장바구니 & 위시리스트
			mbrEtcInfoMap = mbrService.selectMbrEtcInfo(mbrSession.getUniqueId());
		}
		model.addAttribute("_mbrEtcInfoMap", mbrEtcInfoMap);

		// 가족 회원 마일리지
		Map<String, Object> paramMap = new HashMap<String, Object>();
		paramMap.put("srchUniqueId", mbrSession.getUniqueId());
		paramMap.put("srchReqTy", "F");

		List<MbrPrtcrVO> prtcrList = mbrPrtcrService.selectPrtcrListByUniqueId(paramMap);
		model.addAttribute("prtcrList", prtcrList);

		// 기타
		model.addAttribute("prtcrRltCode", CodeMap.PRTCR_RLT);

		return "/market/ordr/include/modal_point";
	}


	// 쿠폰
	@RequestMapping(value="coupon")
	public String coupon(
			@RequestParam(value = "arrGdsCd[]", required=false) String[] gdsCd // 상품코드
			, @RequestParam(value = "arrOrdrQy[]", required=false) String[] ordrQy // 주문수량
			, @RequestParam(value = "arrOrdrPc[]", required=false) List<String> arrOrdrPc // 각 주문 가격 텍스트
			, @RequestParam (value = "baseTotalAmt", required=true) int total
			, @RequestParam Map<String,Object> reqMap
			, Model model) throws Exception {

		// param GdsInfo
		Map<String, Object> paramMap = new HashMap<String, Object>();
		List<GdsVO> itemList = new ArrayList<>();

		for(int i=0; i  < gdsCd.length; i++) {
			paramMap.put("srchGdsCd", gdsCd[i]);
			GdsVO gdsVO = gdsService.selectGdsByFilter(paramMap) ;
			itemList.add(gdsVO);
		}

		// Own coupon
		paramMap.clear();
		paramMap.put("uniqueId", mbrSession.getUniqueId());
		paramMap.put("srchUseYn", "N");

		List<CouponLstVO> couponList =  couponLstService.selectOwnCouponList(paramMap);

		model.addAttribute("itemList", itemList);
		model.addAttribute("couponList", couponList);
		model.addAttribute("total", total);
		model.addAttribute("ordrQy", ordrQy);
		model.addAttribute("arrOrdrPc", arrOrdrPc);
		model.addAttribute("mbrSession", mbrSession);

		return "/market/ordr/include/modal_coupon";
	}

}
