package icube.manage.stats.sales;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.egovframe.rte.fdl.string.EgovStringUtil;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import icube.common.framework.abst.CommonAbstractController;
import icube.common.util.DateUtil;
import icube.common.values.CodeMap;
import icube.manage.gds.ctgry.biz.GdsCtgryService;
import icube.manage.gds.ctgry.biz.GdsCtgryVO;
import icube.manage.stats.sales.biz.StatsSalesService;
import icube.manage.stats.sales.biz.StatsSalesVO;

@Controller
@RequestMapping(value="/_mng/stats/sales")
public class MStatSalesController extends CommonAbstractController {

	@Resource(name = "statsSalesService")
	private StatsSalesService statsSalesService;

	@Resource(name = "gdsCtgryService")
	private GdsCtgryService gdsCtgryService;

	// 판매실적
	@RequestMapping(value = "prfmnc")
	public String prfmnc(
			@RequestParam Map<String, Object> reqMap
			, HttpServletRequest request
			, Model model) throws Exception {

		String srchOrdrYmdBgng = (String) reqMap.get("srchOrdrYmdBgng");
		if(EgovStringUtil.isEmpty(srchOrdrYmdBgng)) {
			srchOrdrYmdBgng = DateUtil.getCurrentDateTime("yyyy-MM-dd");
		}
		String srchOrdrYmdEnd = (String) reqMap.get("srchOrdrYmdEnd");
		if(EgovStringUtil.isEmpty(srchOrdrYmdEnd)) {
			srchOrdrYmdEnd = DateUtil.getCurrentDateTime("yyyy-MM-dd");
		}

		Map<String, Object> paramMap = new HashMap<String, Object>();
		paramMap.put("srchOrdrYmdBgng", srchOrdrYmdBgng);
		paramMap.put("srchOrdrYmdEnd", srchOrdrYmdEnd);

		List<StatsSalesVO> resultList = statsSalesService.selectPrfmncList(paramMap);
		model.addAttribute("resultList", resultList);

		model.addAttribute("srchOrdrYmdBgng", srchOrdrYmdBgng);
		model.addAttribute("srchOrdrYmdEnd", srchOrdrYmdEnd);

		return "/manage/stats/sales/prfmnc";
	}

	// 판매실적 엑셀
	@RequestMapping(value = "prfmncExcel")
	public String prfmncExcel(
			HttpServletRequest request
			, Model model
			, @RequestParam Map<String, Object> reqMap
			)throws Exception {

		String srchOrdrYmdBgng = (String) reqMap.get("srchOrdrYmdBgng");
		if(EgovStringUtil.isEmpty(srchOrdrYmdBgng)) {
			srchOrdrYmdBgng = DateUtil.getCurrentDateTime("yyyy-MM-dd");
		}
		String srchOrdrYmdEnd = (String) reqMap.get("srchOrdrYmdEnd");
		if(EgovStringUtil.isEmpty(srchOrdrYmdEnd)) {
			srchOrdrYmdEnd = DateUtil.getCurrentDateTime("yyyy-MM-dd");
		}

		Map<String, Object> paramMap = new HashMap<String, Object>();
		paramMap.put("srchOrdrYmdBgng", srchOrdrYmdBgng);
		paramMap.put("srchOrdrYmdEnd", srchOrdrYmdEnd);

		List<StatsSalesVO> resultList = statsSalesService.selectPrfmncList(paramMap);

		model.addAttribute("resultList", resultList);


		return "/manage/stats/include/sales_excel_prfmnc";
	}


	// 판매상품
	@RequestMapping(value = "goods")
	public String goods(
			@RequestParam Map<String, Object> reqMap
			, HttpServletRequest request
			, Model model) throws Exception {


		String srchOrdrYmdBgng = (String) reqMap.get("srchOrdrYmdBgng");
		if(EgovStringUtil.isEmpty(srchOrdrYmdBgng)) {
			srchOrdrYmdBgng = DateUtil.getCurrentDateTime("yyyy-MM-dd");
		}
		String srchOrdrYmdEnd = (String) reqMap.get("srchOrdrYmdEnd");
		if(EgovStringUtil.isEmpty(srchOrdrYmdEnd)) {
			srchOrdrYmdEnd = DateUtil.getCurrentDateTime("yyyy-MM-dd");
		}

		Map<String, Object> paramMap = new HashMap<String, Object>();
		paramMap.put("srchOrdrYmdBgng", srchOrdrYmdBgng);
		paramMap.put("srchOrdrYmdEnd", srchOrdrYmdEnd);


		paramMap.put("srchUpCtgryNo", reqMap.get("srchUpCtgryNo"));
		paramMap.put("srchCtgryNo", reqMap.get("srchCtgryNo"));
		paramMap.put("srchGdsCd", reqMap.get("srchGdsCd"));
		paramMap.put("srchGdsNm", reqMap.get("srchGdsNm"));


		//카테고리 호출
		List<GdsCtgryVO> gdsCtgryList = gdsCtgryService.selectGdsCtgryList(1);
		model.addAttribute("gdsCtgryList", gdsCtgryList);


		List<StatsSalesVO> resultList = statsSalesService.selectGoodsList(paramMap);
		model.addAttribute("resultList", resultList);

		model.addAttribute("srchOrdrYmdBgng", srchOrdrYmdBgng);
		model.addAttribute("srchOrdrYmdEnd", srchOrdrYmdEnd);

		return "/manage/stats/sales/goods";
	}

	// 판매상품 엑셀
	@RequestMapping(value = "goodsExcel")
	public String goodsExcel(
			HttpServletRequest request
			, Model model
			, @RequestParam Map<String, Object> reqMap
			)throws Exception {

		String srchOrdrYmdBgng = (String) reqMap.get("srchOrdrYmdBgng");
		if(EgovStringUtil.isEmpty(srchOrdrYmdBgng)) {
			srchOrdrYmdBgng = DateUtil.getCurrentDateTime("yyyy-MM-dd");
		}
		String srchOrdrYmdEnd = (String) reqMap.get("srchOrdrYmdEnd");
		if(EgovStringUtil.isEmpty(srchOrdrYmdEnd)) {
			srchOrdrYmdEnd = DateUtil.getCurrentDateTime("yyyy-MM-dd");
		}

		Map<String, Object> paramMap = new HashMap<String, Object>();
		paramMap.put("srchOrdrYmdBgng", srchOrdrYmdBgng);
		paramMap.put("srchOrdrYmdEnd", srchOrdrYmdEnd);

		paramMap.put("srchUpCtgryNo", reqMap.get("srchUpCtgryNo"));
		paramMap.put("srchCtgryNo", reqMap.get("srchCtgryNo"));
		paramMap.put("srchGdsCd", reqMap.get("srchGdsCd"));
		paramMap.put("srchGdsNm", reqMap.get("srchGdsNm"));

		List<StatsSalesVO> resultList = statsSalesService.selectGoodsList(paramMap);
		model.addAttribute("resultList", resultList);

		return "/manage/stats/include/sales_excel_goods";
	}


	// 성별/연령별
	@RequestMapping(value = "trpr") // Target Person
	public String trpr(
			@RequestParam Map<String, Object> reqMap
			, HttpServletRequest request
			, Model model) throws Exception {

		String srchOrdrYmdBgng = (String) reqMap.get("srchOrdrYmdBgng");
		if(EgovStringUtil.isEmpty(srchOrdrYmdBgng)) {
			srchOrdrYmdBgng = DateUtil.getCurrentDateTime("yyyy-MM-dd");
		}
		String srchOrdrYmdEnd = (String) reqMap.get("srchOrdrYmdEnd");
		if(EgovStringUtil.isEmpty(srchOrdrYmdEnd)) {
			srchOrdrYmdEnd = DateUtil.getCurrentDateTime("yyyy-MM-dd");
		}

		Map<String, Object> paramMap = new HashMap<String, Object>();
		paramMap.put("srchOrdrYmdBgng", srchOrdrYmdBgng);
		paramMap.put("srchOrdrYmdEnd", srchOrdrYmdEnd);


		List<StatsSalesVO> resultList = statsSalesService.selectTrprList(paramMap);
		model.addAttribute("resultList", resultList);

		model.addAttribute("srchOrdrYmdBgng", srchOrdrYmdBgng);
		model.addAttribute("srchOrdrYmdEnd", srchOrdrYmdEnd);
		model.addAttribute("genderCode", CodeMap.GENDER);


		return "/manage/stats/sales/trpr";
	}

	// 성별/연령별 엑셀
	@RequestMapping(value = "trprExcel")
	public String trprExcel(
			HttpServletRequest request
			, Model model
			, @RequestParam Map<String, Object> reqMap
			)throws Exception {

		String srchOrdrYmdBgng = (String) reqMap.get("srchOrdrYmdBgng");
		if(EgovStringUtil.isEmpty(srchOrdrYmdBgng)) {
			srchOrdrYmdBgng = DateUtil.getCurrentDateTime("yyyy-MM-dd");
		}
		String srchOrdrYmdEnd = (String) reqMap.get("srchOrdrYmdEnd");
		if(EgovStringUtil.isEmpty(srchOrdrYmdEnd)) {
			srchOrdrYmdEnd = DateUtil.getCurrentDateTime("yyyy-MM-dd");
		}

		Map<String, Object> paramMap = new HashMap<String, Object>();
		paramMap.put("srchOrdrYmdBgng", srchOrdrYmdBgng);
		paramMap.put("srchOrdrYmdEnd", srchOrdrYmdEnd);


		List<StatsSalesVO> resultList = statsSalesService.selectTrprList(paramMap);
		model.addAttribute("resultList", resultList);

		model.addAttribute("genderCode", CodeMap.GENDER);

		return "/manage/stats/include/sales_excel_trpr";
	}


	// 파트너별
	@RequestMapping(value = "partner")
	public String partner(
			@RequestParam Map<String, Object> reqMap
			, HttpServletRequest request
			, Model model) throws Exception {

		String srchOrdrYmdBgng = (String) reqMap.get("srchOrdrYmdBgng");
		if(EgovStringUtil.isEmpty(srchOrdrYmdBgng)) {
			srchOrdrYmdBgng = DateUtil.getCurrentDateTime("yyyy-MM-dd");
		}
		String srchOrdrYmdEnd = (String) reqMap.get("srchOrdrYmdEnd");
		if(EgovStringUtil.isEmpty(srchOrdrYmdEnd)) {
			srchOrdrYmdEnd = DateUtil.getCurrentDateTime("yyyy-MM-dd");
		}

		Map<String, Object> paramMap = new HashMap<String, Object>();
		paramMap.put("srchOrdrYmdBgng", srchOrdrYmdBgng);
		paramMap.put("srchOrdrYmdEnd", srchOrdrYmdEnd);


		List<StatsSalesVO> resultList = statsSalesService.selectPartnerList(paramMap);
		model.addAttribute("resultList", resultList);

		model.addAttribute("srchOrdrYmdBgng", srchOrdrYmdBgng);
		model.addAttribute("srchOrdrYmdEnd", srchOrdrYmdEnd);

		return "/manage/stats/sales/partner";
	}

	// 파트너별 엑셀
	@RequestMapping(value = "partnerExcel")
	public String partnerExcel(
			HttpServletRequest request
			, Model model
			, @RequestParam Map<String, Object> reqMap
			)throws Exception {


		String srchOrdrYmdBgng = (String) reqMap.get("srchOrdrYmdBgng");
		if(EgovStringUtil.isEmpty(srchOrdrYmdBgng)) {
			srchOrdrYmdBgng = DateUtil.getCurrentDateTime("yyyy-MM-dd");
		}
		String srchOrdrYmdEnd = (String) reqMap.get("srchOrdrYmdEnd");
		if(EgovStringUtil.isEmpty(srchOrdrYmdEnd)) {
			srchOrdrYmdEnd = DateUtil.getCurrentDateTime("yyyy-MM-dd");
		}

		Map<String, Object> paramMap = new HashMap<String, Object>();
		paramMap.put("srchOrdrYmdBgng", srchOrdrYmdBgng);
		paramMap.put("srchOrdrYmdEnd", srchOrdrYmdEnd);


		List<StatsSalesVO> resultList = statsSalesService.selectPartnerList(paramMap);

		model.addAttribute("resultList", resultList);

		return "/manage/stats/include/sales_excel_partner";
	}


	// 마일리지
	@RequestMapping(value = "mlg")
	public String mlg(
			@RequestParam Map<String, Object> reqMap
			, HttpServletRequest request
			, Model model) throws Exception {

		String srchOrdrYmdBgng = (String) reqMap.get("srchOrdrYmdBgng");
		if(EgovStringUtil.isEmpty(srchOrdrYmdBgng)) {
			srchOrdrYmdBgng = DateUtil.getCurrentDateTime("yyyy-MM-dd");
		}
		String srchOrdrYmdEnd = (String) reqMap.get("srchOrdrYmdEnd");
		if(EgovStringUtil.isEmpty(srchOrdrYmdEnd)) {
			srchOrdrYmdEnd = DateUtil.getCurrentDateTime("yyyy-MM-dd");
		}

		Map<String, Object> paramMap = new HashMap<String, Object>();
		paramMap.put("srchOrdrYmdBgng", srchOrdrYmdBgng);
		paramMap.put("srchOrdrYmdEnd", srchOrdrYmdEnd);


		List<StatsSalesVO> resultList = statsSalesService.selectMlgList(paramMap);
		model.addAttribute("resultList", resultList);

		model.addAttribute("srchOrdrYmdBgng", srchOrdrYmdBgng);
		model.addAttribute("srchOrdrYmdEnd", srchOrdrYmdEnd);

		return "/manage/stats/sales/mlg";
	}

	// 마일리지 엑셀
	@RequestMapping(value = "mlgExcel")
	public String mlgExcel(
			HttpServletRequest request
			, Model model
			, @RequestParam Map<String, Object> reqMap
			)throws Exception {

		String srchOrdrYmdBgng = (String) reqMap.get("srchOrdrYmdBgng");
		if(EgovStringUtil.isEmpty(srchOrdrYmdBgng)) {
			srchOrdrYmdBgng = DateUtil.getCurrentDateTime("yyyy-MM-dd");
		}
		String srchOrdrYmdEnd = (String) reqMap.get("srchOrdrYmdEnd");
		if(EgovStringUtil.isEmpty(srchOrdrYmdEnd)) {
			srchOrdrYmdEnd = DateUtil.getCurrentDateTime("yyyy-MM-dd");
		}

		Map<String, Object> paramMap = new HashMap<String, Object>();
		paramMap.put("srchOrdrYmdBgng", srchOrdrYmdBgng);
		paramMap.put("srchOrdrYmdEnd", srchOrdrYmdEnd);


		List<StatsSalesVO> resultList = statsSalesService.selectMlgList(paramMap);

		model.addAttribute("resultList", resultList);

		return "/manage/stats/include/sales_excel_mlg";
	}

	// 포인트
	@RequestMapping(value = "point")
	public String point(
			@RequestParam Map<String, Object> reqMap
			, HttpServletRequest request
			, Model model) throws Exception {

		String srchOrdrYmdBgng = (String) reqMap.get("srchOrdrYmdBgng");
		if(EgovStringUtil.isEmpty(srchOrdrYmdBgng)) {
			srchOrdrYmdBgng = DateUtil.getCurrentDateTime("yyyy-MM-dd");
		}
		String srchOrdrYmdEnd = (String) reqMap.get("srchOrdrYmdEnd");
		if(EgovStringUtil.isEmpty(srchOrdrYmdEnd)) {
			srchOrdrYmdEnd = DateUtil.getCurrentDateTime("yyyy-MM-dd");
		}

		Map<String, Object> paramMap = new HashMap<String, Object>();
		paramMap.put("srchOrdrYmdBgng", srchOrdrYmdBgng);
		paramMap.put("srchOrdrYmdEnd", srchOrdrYmdEnd);


		List<StatsSalesVO> resultList = statsSalesService.selectPointList(paramMap);
		model.addAttribute("resultList", resultList);

		model.addAttribute("srchOrdrYmdBgng", srchOrdrYmdBgng);
		model.addAttribute("srchOrdrYmdEnd", srchOrdrYmdEnd);

		return "/manage/stats/sales/point";
	}

	// 포인트 엑셀
	@RequestMapping(value = "pointExcel")
	public String pointExcel(
			HttpServletRequest request
			, Model model
			, @RequestParam Map<String, Object> reqMap
			)throws Exception {

		String srchOrdrYmdBgng = (String) reqMap.get("srchOrdrYmdBgng");
		if(EgovStringUtil.isEmpty(srchOrdrYmdBgng)) {
			srchOrdrYmdBgng = DateUtil.getCurrentDateTime("yyyy-MM-dd");
		}
		String srchOrdrYmdEnd = (String) reqMap.get("srchOrdrYmdEnd");
		if(EgovStringUtil.isEmpty(srchOrdrYmdEnd)) {
			srchOrdrYmdEnd = DateUtil.getCurrentDateTime("yyyy-MM-dd");
		}

		Map<String, Object> paramMap = new HashMap<String, Object>();
		paramMap.put("srchOrdrYmdBgng", srchOrdrYmdBgng);
		paramMap.put("srchOrdrYmdEnd", srchOrdrYmdEnd);


		List<StatsSalesVO> resultList = statsSalesService.selectPointList(paramMap);

		model.addAttribute("resultList", resultList);

		return "/manage/stats/include/sales_excel_point";
	}

	// 쿠폰
	@RequestMapping(value = "coupon")
	public String coupon(
			@RequestParam Map<String, Object> reqMap
			, HttpServletRequest request
			, Model model) throws Exception {


		return "/manage/stats/sales/coupon";
	}

	// 결제수단별
	@RequestMapping(value = "stlmTy")
	public String stlmTy(
			@RequestParam Map<String, Object> reqMap
			, HttpServletRequest request
			, Model model) throws Exception {

		String srchOrdrYmdBgng = (String) reqMap.get("srchOrdrYmdBgng");
		if(EgovStringUtil.isEmpty(srchOrdrYmdBgng)) {
			srchOrdrYmdBgng = DateUtil.getCurrentDateTime("yyyy-MM-dd");
		}
		String srchOrdrYmdEnd = (String) reqMap.get("srchOrdrYmdEnd");
		if(EgovStringUtil.isEmpty(srchOrdrYmdEnd)) {
			srchOrdrYmdEnd = DateUtil.getCurrentDateTime("yyyy-MM-dd");
		}

		Map<String, Object> paramMap = new HashMap<String, Object>();
		paramMap.put("srchOrdrYmdBgng", srchOrdrYmdBgng);
		paramMap.put("srchOrdrYmdEnd", srchOrdrYmdEnd);


		List<StatsSalesVO> resultList = statsSalesService.selectStlmTyList(paramMap);
		model.addAttribute("resultList", resultList);

		model.addAttribute("srchOrdrYmdBgng", srchOrdrYmdBgng);
		model.addAttribute("srchOrdrYmdEnd", srchOrdrYmdEnd);

		return "/manage/stats/sales/stlm_ty";
	}

	// 결제수단별 엑셀
	@RequestMapping(value = "stlmTyExcel")
	public String stlmTyExcel(
			HttpServletRequest request
			, Model model
			, @RequestParam Map<String, Object> reqMap
			)throws Exception {

		String srchOrdrYmdBgng = (String) reqMap.get("srchOrdrYmdBgng");
		if(EgovStringUtil.isEmpty(srchOrdrYmdBgng)) {
			srchOrdrYmdBgng = DateUtil.getCurrentDateTime("yyyy-MM-dd");
		}
		String srchOrdrYmdEnd = (String) reqMap.get("srchOrdrYmdEnd");
		if(EgovStringUtil.isEmpty(srchOrdrYmdEnd)) {
			srchOrdrYmdEnd = DateUtil.getCurrentDateTime("yyyy-MM-dd");
		}

		Map<String, Object> paramMap = new HashMap<String, Object>();
		paramMap.put("srchOrdrYmdBgng", srchOrdrYmdBgng);
		paramMap.put("srchOrdrYmdEnd", srchOrdrYmdEnd);


		List<StatsSalesVO> resultList = statsSalesService.selectStlmTyList(paramMap);

		model.addAttribute("resultList", resultList);

		return "/manage/stats/include/sales_excel_stlmTy";
	}


	// 카드사별
	@RequestMapping(value = "cardCo")
	public String cardCo(
			@RequestParam Map<String, Object> reqMap
			, HttpServletRequest request
			, Model model) throws Exception {

		String srchOrdrYmdBgng = (String) reqMap.get("srchOrdrYmdBgng");
		if(EgovStringUtil.isEmpty(srchOrdrYmdBgng)) {
			srchOrdrYmdBgng = DateUtil.getCurrentDateTime("yyyy-MM-dd");
		}
		String srchOrdrYmdEnd = (String) reqMap.get("srchOrdrYmdEnd");
		if(EgovStringUtil.isEmpty(srchOrdrYmdEnd)) {
			srchOrdrYmdEnd = DateUtil.getCurrentDateTime("yyyy-MM-dd");
		}

		Map<String, Object> paramMap = new HashMap<String, Object>();
		paramMap.put("srchOrdrYmdBgng", srchOrdrYmdBgng);
		paramMap.put("srchOrdrYmdEnd", srchOrdrYmdEnd);

		paramMap.put("srchCardCoNm", reqMap.get("srchCardCoNm"));

		List<StatsSalesVO> resultList = statsSalesService.selectCardCoList(paramMap);
		model.addAttribute("resultList", resultList);

		List<Map<String, Object>> cardCoNmList = statsSalesService.selectCardCoNmList();
		model.addAttribute("cardCoNmList", cardCoNmList);

		model.addAttribute("srchOrdrYmdBgng", srchOrdrYmdBgng);
		model.addAttribute("srchOrdrYmdEnd", srchOrdrYmdEnd);

		return "/manage/stats/sales/card_co";
	}


	// 카드사별 엑셀
	@RequestMapping(value = "cardCoExcel")
	public String cardCoExcel(
			HttpServletRequest request
			, Model model
			, @RequestParam Map<String, Object> reqMap
			)throws Exception {

		String srchOrdrYmdBgng = (String) reqMap.get("srchOrdrYmdBgng");
		if(EgovStringUtil.isEmpty(srchOrdrYmdBgng)) {
			srchOrdrYmdBgng = DateUtil.getCurrentDateTime("yyyy-MM-dd");
		}
		String srchOrdrYmdEnd = (String) reqMap.get("srchOrdrYmdEnd");
		if(EgovStringUtil.isEmpty(srchOrdrYmdEnd)) {
			srchOrdrYmdEnd = DateUtil.getCurrentDateTime("yyyy-MM-dd");
		}

		Map<String, Object> paramMap = new HashMap<String, Object>();
		paramMap.put("srchOrdrYmdBgng", srchOrdrYmdBgng);
		paramMap.put("srchOrdrYmdEnd", srchOrdrYmdEnd);

		paramMap.put("srchCardCoNm", reqMap.get("srchCardCoNm"));

		List<StatsSalesVO> resultList = statsSalesService.selectCardCoList(paramMap);
		model.addAttribute("resultList", resultList);

		List<Map<String, Object>> cardCoNmList = statsSalesService.selectCardCoNmList();
		model.addAttribute("cardCoNmList", cardCoNmList);


		return "/manage/stats/include/sales_excel_cardCo";
	}


}
