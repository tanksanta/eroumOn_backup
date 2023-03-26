package icube.market.mypage.bnef;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import icube.common.framework.abst.CommonAbstractController;
import icube.common.values.CodeMap;
import icube.manage.promotion.coupon.biz.CouponLstService;
import icube.manage.promotion.coupon.biz.CouponLstVO;
import icube.market.mbr.biz.MbrSession;

/**
 * 마이페이지 > 쇼핑혜택 > 쿠폰
 */
@Controller
@RequestMapping(value="#{props['Globals.Market.path']}/mypage/coupon")
public class MyCouponController extends CommonAbstractController {

	@Resource(name="couponLstService")
	private CouponLstService couponLstService;

	@Autowired
	private MbrSession mbrSession;

	/**
	 * 쿠폰 목록
	 * @implNote 쿠폰이 사용중지 상태가 되었을 때 : 이미 발급받은 것은 사용 가능하게 처리 상태
	 */
	@RequestMapping(value="list")
	public String list(
			HttpServletRequest request
			, Model model
			) throws Exception{

		Map<String, Object> paramMap = new HashMap<String, Object>();
		paramMap.put("uniqueId", mbrSession.getUniqueId());
		paramMap.put("srchUseYn", "N");
		paramMap.put("srchUseCoupon", 1); // 1 의미 x

		List<CouponLstVO> resultList = couponLstService.selectOwnCouponList(paramMap);

		model.addAttribute("resultList", resultList);
		model.addAttribute("mberGradeCode", CodeMap.GRADE);

		return "/market/mypage/coupon/list";
	}
}
