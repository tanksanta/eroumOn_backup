package icube.membership;

import java.util.HashMap;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.View;

import icube.common.framework.abst.CommonAbstractController;
import icube.common.framework.view.JavaScript;
import icube.common.framework.view.JavaScriptView;
import icube.common.values.CodeMap;
import icube.manage.mbr.mbr.biz.MbrPrtcrService;
import icube.manage.mbr.mbr.biz.MbrService;
import icube.manage.ordr.dtl.biz.OrdrDtlService;
import icube.manage.promotion.coupon.biz.CouponLstService;
import icube.manage.promotion.mlg.biz.MbrMlgService;
import icube.manage.promotion.mlg.biz.MbrMlgVO;
import icube.manage.promotion.point.biz.MbrPointService;
import icube.manage.promotion.point.biz.MbrPointVO;
import icube.market.mbr.biz.MbrSession;

/**
 * 마이페이지 > 회원정보 > 회원 탈퇴
 */
@Controller
@RequestMapping(value = "#{props['Globals.Membership.path']}/whdwl")
public class MbrsWhdwlController extends CommonAbstractController{

	@Resource(name="mbrService")
	private MbrService mbrService;

	@Resource(name="ordrDtlService")
	private OrdrDtlService ordrDtlService;

	@Resource(name = "mbrPointService")
	private MbrPointService mbrPointService;

	@Resource(name = "mbrMlgService")
	private MbrMlgService mbrMlgService;

	@Resource(name = "couponLstService")
	private CouponLstService couponLstService;

	@Resource(name = "mbrPrtcrService")
	private MbrPrtcrService mbrPrtcrService;

	@Value("#{props['Globals.Planner.path']}")
	private String plannerPath;

	@Value("#{props['Globals.Market.path']}")
	private String marketPath;

	@Autowired
	private MbrSession mbrSession;

	/**
	 * 회원 탈퇴
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
			) throws Exception{

		Map<String, Integer> resultMap = new HashMap();
		Map<String, Object> paramMap = new HashMap();
		paramMap.put("srchUniqueId", mbrSession.getUniqueId());

		int point = 0;
		int mlg = 0;
		int coupon = 0;

		int pointCount = mbrPointService.selectMbrPointCount(paramMap);
		int mlgCount = mbrMlgService.selectMbrMlgCount(paramMap);

		// 포인트
		if(pointCount > 0) {
			MbrPointVO mbrPointVO = mbrPointService.selectMbrPoint(paramMap);
			point = mbrPointVO.getPointAcmtl();
		}

		// 마일리지
		if(mlgCount > 0) {
			MbrMlgVO mbrMlgVO = mbrMlgService.selectMbrMlg(paramMap);
			mlg = mbrMlgVO.getMlgAcmtl();
		}


		// 쿠폰
		paramMap.put("srchUseYn", "N");
		paramMap.put("srchUseCoupon", 1); // 1 의미 x
		paramMap.put("uniqueId", mbrSession.getUniqueId());
		coupon = couponLstService.selectCouponCnt(paramMap);

		resultMap.put("point", point);
		resultMap.put("mlg", mlg);
		resultMap.put("coupon", coupon);


		model.addAttribute("resultMap", resultMap);
		model.addAttribute("norResnCdCode", CodeMap.NOR_RESN_CD);
		model.addAttribute("ordrSttsCode", CodeMap.ORDR_STTS);

		return "/membership/whdwl/list";
	}

	/**
	 * 회원 탈퇴 처리
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="action")
	@SuppressWarnings({"rawtypes","unchecked"})
	public View action(
			HttpServletRequest request
			, HttpSession session
			, Model model
			, @RequestParam(value="resnCn", required=true) String resnCn
			)throws Exception {

		JavaScript javaScript = new JavaScript();

		Map paramMap = new HashMap();
		paramMap.put("srchMyUniqueId", mbrSession.getUniqueId());

		mbrPrtcrService.deleteFml(paramMap);

		paramMap.clear();
		paramMap.put("srchUniqueId", mbrSession.getUniqueId());
		paramMap.put("whdwlResn", resnCn);
		paramMap.put("whdwlTy", "NORMAL");

		mbrService.updateExitMbr(paramMap);

		session.invalidate();

		javaScript.setMessage("탈퇴처리 되었습니다.");
		javaScript.setLocation("/"+plannerPath+"/index");

		return new JavaScriptView(javaScript);

	}

	/**
	 * 특정 단계 제외 카운트 체크
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="exDlvySttsCnt.json")
	@ResponseBody
	@SuppressWarnings({"rawtypes","unchecked"})
	public Map dlvyCount(
			HttpServletRequest request
			, Model model
			) throws Exception{

		boolean result = false;


		Map paramMap = new HashMap();
		paramMap.put("srchRegUniqueId", mbrSession.getUniqueId());
		paramMap.put("srchExSttsTy", "OR08");

		paramMap.put("srchOrdrOptnTy", "BASE");

		//특정 단계 제외 카운트
		int dlvyCount = ordrDtlService.selectExSttsTyCnt(paramMap);

		if(dlvyCount < 1) {
			result = true;
		}

		//return map
		Map resultMap = new HashMap();
		resultMap.put("sttsTy", paramMap.get("srchExSttsTy"));
		resultMap.put("result", result);


		return resultMap;
	}
}
