package icube.manage.stats.sales;

import java.net.URLEncoder;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.ss.util.CellRangeAddress;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.egovframe.rte.fdl.string.EgovDateUtil;
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
	public void prfmncExcel(
			HttpServletRequest request
			, HttpServletResponse response
			, @RequestParam Map<String, Object> reqMap
			, Model model )throws Exception {

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

		Workbook workbook = new XSSFWorkbook();
        Sheet sheet = workbook.createSheet("DataSheet");

        // 첫 번째 행 (상위 헤더)
        Row row1 = sheet.createRow(0);
        row1.createCell(0).setCellValue("일자");
        sheet.addMergedRegion(new CellRangeAddress(0, 1, 0, 0));
        row1.createCell(1).setCellValue("주문");
        sheet.addMergedRegion(new CellRangeAddress(0, 0, 1, 2));
        row1.createCell(3).setCellValue("취소");
        sheet.addMergedRegion(new CellRangeAddress(0, 0, 3, 4));
        row1.createCell(5).setCellValue("판매");
        sheet.addMergedRegion(new CellRangeAddress(0, 0, 5, 6));
        row1.createCell(7).setCellValue("반품");
        sheet.addMergedRegion(new CellRangeAddress(0, 0, 7, 8));
        row1.createCell(9).setCellValue("매출");
        sheet.addMergedRegion(new CellRangeAddress(0, 0, 9, 10));

        // 두 번째 행 (하위 헤더)
        Row row2 = sheet.createRow(1);
        row2.createCell(1).setCellValue("건수");
        row2.createCell(2).setCellValue("금액");
        row2.createCell(3).setCellValue("건수");
        row2.createCell(4).setCellValue("금액");
        row2.createCell(5).setCellValue("건수");
        row2.createCell(6).setCellValue("금액");
        row2.createCell(7).setCellValue("건수");
        row2.createCell(8).setCellValue("금액");
        row2.createCell(9).setCellValue("건수");
        row2.createCell(10).setCellValue("금액");

        // data
        int totalACnt = 0, totalBCnt = 0, totalCCnt = 0;
        int totalASum = 0, totalBSum = 0, totalCSum = 0;
        int totalCaCnt = 0, totalReCnt = 0;
        int totalCaSum = 0, totalReSum= 0;


        int i = 2; //2row부터
        for(StatsSalesVO statsSalesVO : resultList) {
        	Row dataRow = sheet.createRow(i);
        	dataRow.createCell(0).setCellValue(statsSalesVO.getOrdrDt());
        	dataRow.createCell(1).setCellValue(String.format("%,d", statsSalesVO.getTotalACnt()));
        	dataRow.createCell(2).setCellValue(String.format("%,d", statsSalesVO.getTotalASum()));
        	dataRow.createCell(3).setCellValue(String.format("%,d", statsSalesVO.getTotalCaCnt()));
        	dataRow.createCell(4).setCellValue(String.format("%,d", statsSalesVO.getTotalCaSum()));
        	dataRow.createCell(5).setCellValue(String.format("%,d", statsSalesVO.getTotalBCnt()));
        	dataRow.createCell(6).setCellValue(String.format("%,d", statsSalesVO.getTotalBSum()));
        	dataRow.createCell(7).setCellValue(String.format("%,d", statsSalesVO.getTotalReCnt()));
        	dataRow.createCell(8).setCellValue(String.format("%,d", statsSalesVO.getTotalReSum()));
        	dataRow.createCell(9).setCellValue(String.format("%,d", statsSalesVO.getTotalCCnt()));
        	dataRow.createCell(10).setCellValue(String.format("%,d", statsSalesVO.getTotalCSum()));
        	i++;

        	//합계 ++
        	totalACnt += statsSalesVO.getTotalACnt();
        	totalBCnt += statsSalesVO.getTotalBCnt();
        	totalCCnt += statsSalesVO.getTotalCCnt();
        	totalASum += statsSalesVO.getTotalASum();
        	totalBSum += statsSalesVO.getTotalBSum();
        	totalCSum += statsSalesVO.getTotalCSum();
        	totalCaCnt += statsSalesVO.getTotalCaCnt();
        	totalReCnt += statsSalesVO.getTotalReCnt();
        	totalCaSum += statsSalesVO.getTotalCaSum();
        	totalReSum += statsSalesVO.getTotalReSum();

        }

        // 합계 > i row
        Row sumRow = sheet.createRow(i);
        sumRow.createCell(0).setCellValue("합계");
    	sumRow.createCell(1).setCellValue(String.format("%,d", totalACnt));
    	sumRow.createCell(2).setCellValue(String.format("%,d", totalASum));
    	sumRow.createCell(3).setCellValue(String.format("%,d", totalCaCnt));
    	sumRow.createCell(4).setCellValue(String.format("%,d", totalCaSum));
    	sumRow.createCell(5).setCellValue(String.format("%,d", totalBCnt));
    	sumRow.createCell(6).setCellValue(String.format("%,d", totalBSum));
    	sumRow.createCell(7).setCellValue(String.format("%,d", totalReCnt));
    	sumRow.createCell(8).setCellValue(String.format("%,d", totalReSum));
    	sumRow.createCell(9).setCellValue(String.format("%,d", totalCCnt));
    	sumRow.createCell(10).setCellValue(String.format("%,d", totalCSum));

        // Excel 다운로드를 위한 응답 유형을 설정하고 데이터를 작성
        String fileName = URLEncoder.encode("판매실적", "UTF-8");
        response.setContentType("application/vnd.openxmlformats-officedocument.spreadsheetml.sheet");
        response.setHeader("Content-Disposition", "attachment; filename=" + fileName + "_" + EgovDateUtil.getCurrentDateAsString()  + ".xlsx");

        try (ServletOutputStream outputStream = response.getOutputStream()) {
            workbook.write(outputStream);
            workbook.close();
        }

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
	public void goodsExcel(
			HttpServletRequest request
			, HttpServletResponse response
			, @RequestParam Map<String, Object> reqMap
			, Model model)throws Exception {

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


		Workbook workbook = new XSSFWorkbook();
        Sheet sheet = workbook.createSheet("DataSheet");

        // 첫 번째 행 (상위 헤더)
        Row row1 = sheet.createRow(0);
        row1.createCell(0).setCellValue("판매순위");
        sheet.addMergedRegion(new CellRangeAddress(0, 1, 0, 0));
        row1.createCell(1).setCellValue("상품코드");
        sheet.addMergedRegion(new CellRangeAddress(0, 1, 1, 1));
        row1.createCell(2).setCellValue("상품명");
        sheet.addMergedRegion(new CellRangeAddress(0, 1, 2, 2));

        row1.createCell(3).setCellValue("주문");
        sheet.addMergedRegion(new CellRangeAddress(0, 0, 3, 4));
        row1.createCell(5).setCellValue("취소");
        sheet.addMergedRegion(new CellRangeAddress(0, 0, 5, 6));
        row1.createCell(7).setCellValue("판매");
        sheet.addMergedRegion(new CellRangeAddress(0, 0, 7, 8));
        row1.createCell(9).setCellValue("반품");
        sheet.addMergedRegion(new CellRangeAddress(0, 0, 9, 10));
        row1.createCell(11).setCellValue("매출");
        sheet.addMergedRegion(new CellRangeAddress(0, 0, 11, 12));

        // 두 번째 행 (하위 헤더)
        Row row2 = sheet.createRow(1);
        row2.createCell(3).setCellValue("건수");
        row2.createCell(4).setCellValue("금액");
        row2.createCell(5).setCellValue("건수");
        row2.createCell(6).setCellValue("금액");
        row2.createCell(7).setCellValue("건수");
        row2.createCell(8).setCellValue("금액");
        row2.createCell(9).setCellValue("건수");
        row2.createCell(10).setCellValue("금액");
        row2.createCell(11).setCellValue("건수");
        row2.createCell(12).setCellValue("금액");

        // data
        int i = 2; //2row부터
        for(StatsSalesVO statsSalesVO : resultList) {
        	Row dataRow = sheet.createRow(i);
        	dataRow.createCell(0).setCellValue(i - 1);
        	dataRow.createCell(1).setCellValue(statsSalesVO.getGdsCd());
        	dataRow.createCell(2).setCellValue(statsSalesVO.getGdsNm());

        	dataRow.createCell(3).setCellValue(String.format("%,d", statsSalesVO.getTotalACnt()));
        	dataRow.createCell(4).setCellValue(String.format("%,d", statsSalesVO.getTotalASum()));
        	dataRow.createCell(5).setCellValue(String.format("%,d", statsSalesVO.getTotalCaCnt()));
        	dataRow.createCell(6).setCellValue(String.format("%,d", statsSalesVO.getTotalCaSum()));
        	dataRow.createCell(7).setCellValue(String.format("%,d", statsSalesVO.getTotalBCnt()));
        	dataRow.createCell(8).setCellValue(String.format("%,d", statsSalesVO.getTotalBSum()));
        	dataRow.createCell(9).setCellValue(String.format("%,d", statsSalesVO.getTotalReCnt()));
        	dataRow.createCell(10).setCellValue(String.format("%,d", statsSalesVO.getTotalReSum()));
        	dataRow.createCell(11).setCellValue(String.format("%,d", statsSalesVO.getTotalCCnt()));
        	dataRow.createCell(12).setCellValue(String.format("%,d", statsSalesVO.getTotalCSum()));
        	i++;
        }
        sheet.autoSizeColumn(2);

        // Excel 다운로드를 위한 응답 유형을 설정하고 데이터를 작성
        String fileName = URLEncoder.encode("판매상품", "UTF-8");
        response.setContentType("application/vnd.openxmlformats-officedocument.spreadsheetml.sheet");
        response.setHeader("Content-Disposition", "attachment; filename=" + fileName + "_" + EgovDateUtil.getCurrentDateAsString()  + ".xlsx");

        try (ServletOutputStream outputStream = response.getOutputStream()) {
            workbook.write(outputStream);
            workbook.close();
        }
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
	public void trprExcel(
			HttpServletRequest request
			, HttpServletResponse response
			, @RequestParam Map<String, Object> reqMap
			, Model model)throws Exception {

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

		Workbook workbook = new XSSFWorkbook();
        Sheet sheet = workbook.createSheet("DataSheet");

        // 첫 번째 행 (상위 헤더)
        Row row1 = sheet.createRow(0);
        row1.createCell(0).setCellValue("성별");
        row1.createCell(1).setCellValue("연령대");
        row1.createCell(2).setCellValue("고객수");
        row1.createCell(3).setCellValue("주문건수");
        row1.createCell(4).setCellValue("주문실적");
        row1.createCell(5).setCellValue("매출건수");
        row1.createCell(6).setCellValue("매출실적");
        row1.createCell(7).setCellValue("상품단가");
        row1.createCell(8).setCellValue("주문단가");

        // data
        int totalACnt = 0, totalBCnt = 0, totalCCnt = 0;
        int totalASum = 0, totalBSum = 0, totalCSum = 0;
        int totalCaCnt = 0, totalReCnt = 0;
        int totalCaSum = 0, totalReSum= 0;
        int totalBuyerCnt = 0;

        int i = 1; //2row부터
        for(StatsSalesVO statsSalesVO : resultList) {
        	Row dataRow = sheet.createRow(i);
        	dataRow.createCell(0).setCellValue(CodeMap.GENDER.get(statsSalesVO.getGender()));
        	dataRow.createCell(1).setCellValue(statsSalesVO.getAgeGrp());
        	dataRow.createCell(2).setCellValue(String.format("%,d", statsSalesVO.getBuyerCnt()));
        	dataRow.createCell(3).setCellValue(String.format("%,d", statsSalesVO.getTotalACnt()));
        	dataRow.createCell(4).setCellValue(String.format("%,d", statsSalesVO.getTotalASum()));
        	dataRow.createCell(5).setCellValue(String.format("%,d", statsSalesVO.getTotalCCnt()));
        	dataRow.createCell(6).setCellValue(String.format("%,d", statsSalesVO.getTotalCSum()));
        	dataRow.createCell(7).setCellValue(String.format("%,d", statsSalesVO.getTotalCSum() / statsSalesVO.getTotalOrdrQy() ));
        	dataRow.createCell(8).setCellValue(String.format("%,d", statsSalesVO.getTotalCSum() / statsSalesVO.getTotalACnt() ));

        	i++;

        	//합계 ++
        	totalACnt += statsSalesVO.getTotalACnt();
        	totalBCnt += statsSalesVO.getTotalBCnt();
        	totalCCnt += statsSalesVO.getTotalCCnt();
        	totalASum += statsSalesVO.getTotalASum();
        	totalBSum += statsSalesVO.getTotalBSum();
        	totalCSum += statsSalesVO.getTotalCSum();
        	totalCaCnt += statsSalesVO.getTotalCaCnt();
        	totalReCnt += statsSalesVO.getTotalReCnt();
        	totalCaSum += statsSalesVO.getTotalCaSum();
        	totalReSum += statsSalesVO.getTotalReSum();
        	totalBuyerCnt += statsSalesVO.getBuyerCnt();
        }

        // 합계 > i row
        Row sumRow = sheet.createRow(i);
        sumRow.createCell(0).setCellValue("소계");
        sheet.addMergedRegion(new CellRangeAddress(0, 0, 0, 1));
        sumRow.createCell(2).setCellValue(totalBuyerCnt);
        sumRow.createCell(3).setCellValue(totalACnt);
        sumRow.createCell(4).setCellValue(totalASum);
        sumRow.createCell(5).setCellValue(totalCCnt);
        sumRow.createCell(6).setCellValue(totalCSum);
        sumRow.createCell(7).setCellValue("-");
        sumRow.createCell(8).setCellValue("-");

        // Excel 다운로드를 위한 응답 유형을 설정하고 데이터를 작성
        String fileName = URLEncoder.encode("성별연령별", "UTF-8");
        response.setContentType("application/vnd.openxmlformats-officedocument.spreadsheetml.sheet");
        response.setHeader("Content-Disposition", "attachment; filename=" + fileName + "_" + EgovDateUtil.getCurrentDateAsString()  + ".xlsx");

        try (ServletOutputStream outputStream = response.getOutputStream()) {
            workbook.write(outputStream);
            workbook.close();
        }

		//model.addAttribute("resultList", resultList);
		//model.addAttribute("genderCode", CodeMap.GENDER);
		//return "/manage/stats/include/sales_excel_trpr";
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
	public void partnerExcel(
			HttpServletRequest request
			, HttpServletResponse response
			, @RequestParam Map<String, Object> reqMap
			, Model model )throws Exception {


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

		Workbook workbook = new XSSFWorkbook();
        Sheet sheet = workbook.createSheet("DataSheet");

        // 첫 번째 행 (상위 헤더)
        Row row1 = sheet.createRow(0);
        row1.createCell(0).setCellValue("멤버스명");
        sheet.addMergedRegion(new CellRangeAddress(0, 1, 0, 0));
        row1.createCell(1).setCellValue("주문");
        sheet.addMergedRegion(new CellRangeAddress(0, 0, 1, 2));
        row1.createCell(3).setCellValue("취소");
        sheet.addMergedRegion(new CellRangeAddress(0, 0, 3, 4));
        row1.createCell(5).setCellValue("판매");
        sheet.addMergedRegion(new CellRangeAddress(0, 0, 5, 6));
        row1.createCell(7).setCellValue("반품");
        sheet.addMergedRegion(new CellRangeAddress(0, 0, 7, 8));
        row1.createCell(9).setCellValue("매출");
        sheet.addMergedRegion(new CellRangeAddress(0, 0, 9, 10));

        // 두 번째 행 (하위 헤더)
        Row row2 = sheet.createRow(1);
        row2.createCell(1).setCellValue("건수");
        row2.createCell(2).setCellValue("금액");
        row2.createCell(3).setCellValue("건수");
        row2.createCell(4).setCellValue("금액");
        row2.createCell(5).setCellValue("건수");
        row2.createCell(6).setCellValue("금액");
        row2.createCell(7).setCellValue("건수");
        row2.createCell(8).setCellValue("금액");
        row2.createCell(9).setCellValue("건수");
        row2.createCell(10).setCellValue("금액");

        int i = 2; //2row부터
        for(StatsSalesVO statsSalesVO : resultList) {
        	Row dataRow = sheet.createRow(i);
        	dataRow.createCell(0).setCellValue(statsSalesVO.getBplcNm());
        	dataRow.createCell(1).setCellValue(String.format("%,d", statsSalesVO.getTotalACnt()));
        	dataRow.createCell(2).setCellValue(String.format("%,d", statsSalesVO.getTotalASum()));
        	dataRow.createCell(3).setCellValue(String.format("%,d", statsSalesVO.getTotalCaCnt()));
        	dataRow.createCell(4).setCellValue(String.format("%,d", statsSalesVO.getTotalCaSum()));
        	dataRow.createCell(5).setCellValue(String.format("%,d", statsSalesVO.getTotalBCnt()));
        	dataRow.createCell(6).setCellValue(String.format("%,d", statsSalesVO.getTotalBSum()));
        	dataRow.createCell(7).setCellValue(String.format("%,d", statsSalesVO.getTotalReCnt()));
        	dataRow.createCell(8).setCellValue(String.format("%,d", statsSalesVO.getTotalReSum()));
        	dataRow.createCell(9).setCellValue(String.format("%,d", statsSalesVO.getTotalCCnt()));
        	dataRow.createCell(10).setCellValue(String.format("%,d", statsSalesVO.getTotalCSum()));
        	i++;


        }


        // Excel 다운로드를 위한 응답 유형을 설정하고 데이터를 작성
        String fileName = URLEncoder.encode("멤버스별", "UTF-8");
        response.setContentType("application/vnd.openxmlformats-officedocument.spreadsheetml.sheet");
        response.setHeader("Content-Disposition", "attachment; filename=" + fileName + "_" + EgovDateUtil.getCurrentDateAsString()  + ".xlsx");

        try (ServletOutputStream outputStream = response.getOutputStream()) {
            workbook.write(outputStream);
            workbook.close();
        }

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
	public void mlgExcel(
			HttpServletRequest request
			, HttpServletResponse response
			, @RequestParam Map<String, Object> reqMap
			, Model model )throws Exception {

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

		Workbook workbook = new XSSFWorkbook();
        Sheet sheet = workbook.createSheet("DataSheet");

        // 첫 번째 행 (상위 헤더)
        Row row1 = sheet.createRow(0);
        row1.createCell(0).setCellValue("일자");
        sheet.addMergedRegion(new CellRangeAddress(0, 1, 0, 0));
        row1.createCell(1).setCellValue("판매건수");
        sheet.addMergedRegion(new CellRangeAddress(0, 1, 1, 1));
        row1.createCell(2).setCellValue("마일리지 사용 주문건수");
        sheet.addMergedRegion(new CellRangeAddress(0, 1, 2, 2));
        row1.createCell(3).setCellValue("사용현황");
        sheet.addMergedRegion(new CellRangeAddress(0, 0, 3, 5));
        row1.createCell(6).setCellValue("적립마일리지");
        sheet.addMergedRegion(new CellRangeAddress(0, 1, 6, 6));

        // 두 번째 행 (하위 헤더)
        Row row2 = sheet.createRow(1);
        row2.createCell(3).setCellValue("판매금액");
        row2.createCell(4).setCellValue("사용 마일리지");
        row2.createCell(5).setCellValue("마일리지 사용 결제 금액");

        // data
        int totalACnt = 0, totalBCnt = 0;
        int totalBSum = 0;
        int totalMlgSum = 0, totalStlmSum = 0, totalAccmlMlg = 0;

        int i = 2; //2row부터
        for(StatsSalesVO statsSalesVO : resultList) {
        	Row dataRow = sheet.createRow(i);
        	dataRow.createCell(0).setCellValue(statsSalesVO.getOrdrDt());
        	dataRow.createCell(1).setCellValue(String.format("%,d", statsSalesVO.getTotalACnt()));
        	dataRow.createCell(2).setCellValue(String.format("%,d", statsSalesVO.getTotalBCnt()));
        	dataRow.createCell(3).setCellValue(String.format("%,d", statsSalesVO.getTotalBSum()));
        	dataRow.createCell(4).setCellValue(String.format("%,d", statsSalesVO.getTotalMlgSum()));
        	dataRow.createCell(5).setCellValue(String.format("%,d", statsSalesVO.getTotalStlmSum()));
        	dataRow.createCell(6).setCellValue(String.format("%,d", statsSalesVO.getTotalAccmlMlg()));
        	i++;

        	//합계 ++
        	totalACnt += statsSalesVO.getTotalACnt();
        	totalBCnt += statsSalesVO.getTotalBCnt();
        	totalBSum += statsSalesVO.getTotalBSum();
        	totalMlgSum += statsSalesVO.getTotalMlgSum();
        	totalStlmSum += statsSalesVO.getTotalStlmSum();
        	totalAccmlMlg += statsSalesVO.getTotalAccmlMlg();
        }

        // 합계 > i row
        Row sumRow = sheet.createRow(i);
        sumRow.createCell(0).setCellValue("합계");
    	sumRow.createCell(1).setCellValue(String.format("%,d", totalACnt));
    	sumRow.createCell(2).setCellValue(String.format("%,d", totalBCnt));
    	sumRow.createCell(3).setCellValue(String.format("%,d", totalBSum));
    	sumRow.createCell(4).setCellValue(String.format("%,d", totalMlgSum));
    	sumRow.createCell(5).setCellValue(String.format("%,d", totalStlmSum));
    	sumRow.createCell(6).setCellValue(String.format("%,d", totalAccmlMlg));

        // Excel 다운로드를 위한 응답 유형을 설정하고 데이터를 작성
        String fileName = URLEncoder.encode("마일리지", "UTF-8");
        response.setContentType("application/vnd.openxmlformats-officedocument.spreadsheetml.sheet");
        response.setHeader("Content-Disposition", "attachment; filename=" + fileName + "_" + EgovDateUtil.getCurrentDateAsString()  + ".xlsx");

        try (ServletOutputStream outputStream = response.getOutputStream()) {
            workbook.write(outputStream);
            workbook.close();
        }

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
	public void pointExcel(
			HttpServletRequest request
			, HttpServletResponse response
			, @RequestParam Map<String, Object> reqMap
			, Model model)throws Exception {

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

		Workbook workbook = new XSSFWorkbook();
        Sheet sheet = workbook.createSheet("DataSheet");

        // 첫 번째 행 (상위 헤더)
        Row row1 = sheet.createRow(0);
        row1.createCell(0).setCellValue("일자");
        sheet.addMergedRegion(new CellRangeAddress(0, 1, 0, 0));
        row1.createCell(1).setCellValue("판매건수");
        sheet.addMergedRegion(new CellRangeAddress(0, 1, 1, 1));
        row1.createCell(2).setCellValue("사용현황");
        sheet.addMergedRegion(new CellRangeAddress(0, 0, 2, 4));
        row1.createCell(5).setCellValue("적립포인트");
        sheet.addMergedRegion(new CellRangeAddress(0, 1, 5, 5));

        // 두 번째 행 (하위 헤더)
        Row row2 = sheet.createRow(1);
        row2.createCell(2).setCellValue("포인트 사용 주문건수");
        row2.createCell(3).setCellValue("사용 포인트");
        row2.createCell(4).setCellValue("포인트 사용 결제 금액");

        // data
        int totalACnt = 0, totalBCnt = 0;
        int totalBSum = 0;
        int totalPointSum = 0, totalStlmSum = 0;

        int i = 2; //2row부터
        for(StatsSalesVO statsSalesVO : resultList) {
        	Row dataRow = sheet.createRow(i);
        	dataRow.createCell(0).setCellValue(statsSalesVO.getOrdrDt());
        	dataRow.createCell(1).setCellValue(String.format("%,d", statsSalesVO.getTotalACnt()));
        	dataRow.createCell(2).setCellValue(String.format("%,d", statsSalesVO.getTotalBCnt()));
        	dataRow.createCell(3).setCellValue(String.format("%,d", statsSalesVO.getTotalBSum()));
        	dataRow.createCell(4).setCellValue(String.format("%,d", statsSalesVO.getTotalPointSum()));
        	dataRow.createCell(5).setCellValue(String.format("%,d", statsSalesVO.getTotalStlmSum()));
        	i++;

        	//합계 ++
        	totalACnt += statsSalesVO.getTotalACnt();
        	totalBCnt += statsSalesVO.getTotalBCnt();
        	totalBSum += statsSalesVO.getTotalBSum();
        	totalPointSum += statsSalesVO.getTotalPointSum();
        	totalStlmSum += statsSalesVO.getTotalStlmSum();
        }

        // 합계 > i row
        Row sumRow = sheet.createRow(i);
        sumRow.createCell(0).setCellValue("합계");
    	sumRow.createCell(1).setCellValue(String.format("%,d", totalACnt));
    	sumRow.createCell(2).setCellValue(String.format("%,d", totalBCnt));
    	sumRow.createCell(3).setCellValue(String.format("%,d", totalBSum));
    	sumRow.createCell(4).setCellValue(String.format("%,d", totalPointSum));
    	sumRow.createCell(5).setCellValue(String.format("%,d", totalStlmSum));

        // Excel 다운로드를 위한 응답 유형을 설정하고 데이터를 작성
        String fileName = URLEncoder.encode("포인트", "UTF-8");
        response.setContentType("application/vnd.openxmlformats-officedocument.spreadsheetml.sheet");
        response.setHeader("Content-Disposition", "attachment; filename=" + fileName + "_" + EgovDateUtil.getCurrentDateAsString()  + ".xlsx");

        try (ServletOutputStream outputStream = response.getOutputStream()) {
            workbook.write(outputStream);
            workbook.close();
        }
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
	public void stlmTyExcel(
			HttpServletRequest request
			, HttpServletResponse response
			, @RequestParam Map<String, Object> reqMap
			, Model model)throws Exception {

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

		Workbook workbook = new XSSFWorkbook();
        Sheet sheet = workbook.createSheet("DataSheet");

        // 첫 번째 행 (상위 헤더)
        Row row1 = sheet.createRow(0);
        row1.createCell(0).setCellValue("일자");
        sheet.addMergedRegion(new CellRangeAddress(0, 1, 0, 0));

        row1.createCell(1).setCellValue("판매실적");
        sheet.addMergedRegion(new CellRangeAddress(0, 0, 1, 2));
        row1.createCell(3).setCellValue("신용카드");
        sheet.addMergedRegion(new CellRangeAddress(0, 0, 3, 4));
        row1.createCell(5).setCellValue("실시간계좌이체");
        sheet.addMergedRegion(new CellRangeAddress(0, 0, 5, 6));
        row1.createCell(7).setCellValue("가상계좌(무통장)");
        sheet.addMergedRegion(new CellRangeAddress(0, 0, 7, 8));
        row1.createCell(9).setCellValue("마일리지");
        sheet.addMergedRegion(new CellRangeAddress(0, 0, 9, 10));
        row1.createCell(11).setCellValue("포인트");
        sheet.addMergedRegion(new CellRangeAddress(0, 0, 11, 12));
        row1.createCell(13).setCellValue("매출실적");
        sheet.addMergedRegion(new CellRangeAddress(0, 0, 13, 14));

        // 두 번째 행 (하위 헤더)
        Row row2 = sheet.createRow(1);
        row2.createCell(1).setCellValue("건수");
        row2.createCell(2).setCellValue("금액");
        row2.createCell(3).setCellValue("건수");
        row2.createCell(4).setCellValue("금액");
        row2.createCell(5).setCellValue("건수");
        row2.createCell(6).setCellValue("금액");
        row2.createCell(7).setCellValue("건수");
        row2.createCell(8).setCellValue("금액");
        row2.createCell(9).setCellValue("건수");
        row2.createCell(10).setCellValue("금액");
        row2.createCell(11).setCellValue("건수");
        row2.createCell(12).setCellValue("금액");
        row2.createCell(13).setCellValue("건수");
        row2.createCell(14).setCellValue("금액");

        // data
        int totalBCnt = 0, totalCCnt = 0;
        int totalBSum = 0, totalCSum = 0;
        int totalCardCnt = 0, totalVbankCnt = 0, totalBankCnt = 0, totalMlgCnt = 0, totalPointCnt = 0;
        int totalCardSum = 0, totalVbankSum = 0, totalBankSum = 0, totalMlgSum = 0, totalPointSum = 0;


        int i = 2; //2row부터
        for(StatsSalesVO statsSalesVO : resultList) {
        	Row dataRow = sheet.createRow(i);
        	dataRow.createCell(0).setCellValue(statsSalesVO.getOrdrDt());
        	dataRow.createCell(1).setCellValue(String.format("%,d", statsSalesVO.getTotalBCnt()));
        	dataRow.createCell(2).setCellValue(String.format("%,d", statsSalesVO.getTotalBSum()));
        	dataRow.createCell(3).setCellValue(String.format("%,d", statsSalesVO.getTotalCardCnt()));
        	dataRow.createCell(4).setCellValue(String.format("%,d", statsSalesVO.getTotalCardSum()));
        	dataRow.createCell(5).setCellValue(String.format("%,d", statsSalesVO.getTotalVbankCnt()));
        	dataRow.createCell(6).setCellValue(String.format("%,d", statsSalesVO.getTotalVbankSum()));
        	dataRow.createCell(7).setCellValue(String.format("%,d", statsSalesVO.getTotalBankCnt()));
        	dataRow.createCell(8).setCellValue(String.format("%,d", statsSalesVO.getTotalBankSum()));
        	dataRow.createCell(9).setCellValue(String.format("%,d", statsSalesVO.getTotalMlgCnt()));
        	dataRow.createCell(10).setCellValue(String.format("%,d", statsSalesVO.getTotalMlgSum()));
        	dataRow.createCell(11).setCellValue(String.format("%,d", statsSalesVO.getTotalPointCnt()));
        	dataRow.createCell(12).setCellValue(String.format("%,d", statsSalesVO.getTotalPointSum()));
        	dataRow.createCell(13).setCellValue(String.format("%,d", statsSalesVO.getTotalCCnt()));
        	dataRow.createCell(14).setCellValue(String.format("%,d", statsSalesVO.getTotalCSum()));
        	i++;

        	//합계 ++
        	totalBCnt += statsSalesVO.getTotalBCnt();
        	totalCCnt += statsSalesVO.getTotalCCnt();
        	totalBSum += statsSalesVO.getTotalBSum();
        	totalCSum += statsSalesVO.getTotalCSum();

        	totalCardCnt += statsSalesVO.getTotalCardCnt();
        	totalVbankCnt += statsSalesVO.getTotalVbankCnt();
        	totalBankCnt += statsSalesVO.getTotalBankCnt();
        	totalMlgCnt += statsSalesVO.getTotalMlgCnt();
        	totalPointCnt += statsSalesVO.getTotalPointCnt();

        	totalCardSum += statsSalesVO.getTotalCardSum();
        	totalVbankSum += statsSalesVO.getTotalVbankSum();
        	totalBankSum += statsSalesVO.getTotalBankSum();
        	totalMlgSum += statsSalesVO.getTotalMlgSum();
        	totalPointSum += statsSalesVO.getTotalPointSum();

        }

        // 합계 > i row
        Row sumRow = sheet.createRow(i);
        sumRow.createCell(0).setCellValue("합계");
    	sumRow.createCell(1).setCellValue(String.format("%,d", totalBCnt));
    	sumRow.createCell(2).setCellValue(String.format("%,d", totalBSum));
    	sumRow.createCell(3).setCellValue(String.format("%,d", totalCardCnt));
    	sumRow.createCell(4).setCellValue(String.format("%,d", totalCardSum));
    	sumRow.createCell(5).setCellValue(String.format("%,d", totalVbankCnt));
    	sumRow.createCell(6).setCellValue(String.format("%,d", totalVbankSum));
    	sumRow.createCell(7).setCellValue(String.format("%,d", totalBankCnt));
    	sumRow.createCell(8).setCellValue(String.format("%,d", totalBankSum));
    	sumRow.createCell(9).setCellValue(String.format("%,d", totalMlgCnt));
    	sumRow.createCell(10).setCellValue(String.format("%,d", totalMlgSum));
    	sumRow.createCell(11).setCellValue(String.format("%,d", totalPointCnt));
    	sumRow.createCell(12).setCellValue(String.format("%,d", totalPointSum));
    	sumRow.createCell(13).setCellValue(String.format("%,d", totalCCnt));
    	sumRow.createCell(14).setCellValue(String.format("%,d", totalCSum));

        // Excel 다운로드를 위한 응답 유형을 설정하고 데이터를 작성
        String fileName = URLEncoder.encode("결제수단별", "UTF-8");
        response.setContentType("application/vnd.openxmlformats-officedocument.spreadsheetml.sheet");
        response.setHeader("Content-Disposition", "attachment; filename=" + fileName + "_" + EgovDateUtil.getCurrentDateAsString()  + ".xlsx");

        try (ServletOutputStream outputStream = response.getOutputStream()) {
            workbook.write(outputStream);
            workbook.close();
        }

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
			, HttpServletResponse response
			, @RequestParam Map<String, Object> reqMap
			, Model model)throws Exception {

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

		Workbook workbook = new XSSFWorkbook();
        Sheet sheet = workbook.createSheet("DataSheet");

        // 첫 번째 행 (상위 헤더)
        Row row1 = sheet.createRow(0);
        row1.createCell(0).setCellValue("카드사명");
        sheet.addMergedRegion(new CellRangeAddress(0, 1, 0, 0));
        row1.createCell(1).setCellValue("주문");
        sheet.addMergedRegion(new CellRangeAddress(0, 0, 1, 2));
        row1.createCell(3).setCellValue("취소");
        sheet.addMergedRegion(new CellRangeAddress(0, 0, 3, 4));
        row1.createCell(5).setCellValue("판매");
        sheet.addMergedRegion(new CellRangeAddress(0, 0, 5, 6));
        row1.createCell(7).setCellValue("반품");
        sheet.addMergedRegion(new CellRangeAddress(0, 0, 7, 8));
        row1.createCell(9).setCellValue("매출");
        sheet.addMergedRegion(new CellRangeAddress(0, 0, 9, 10));

        // 두 번째 행 (하위 헤더)
        Row row2 = sheet.createRow(1);
        row2.createCell(1).setCellValue("건수");
        row2.createCell(2).setCellValue("금액");
        row2.createCell(3).setCellValue("건수");
        row2.createCell(4).setCellValue("금액");
        row2.createCell(5).setCellValue("건수");
        row2.createCell(6).setCellValue("금액");
        row2.createCell(7).setCellValue("건수");
        row2.createCell(8).setCellValue("금액");
        row2.createCell(9).setCellValue("건수");
        row2.createCell(10).setCellValue("금액");

        // data
        int totalACnt = 0, totalBCnt = 0, totalCCnt = 0;
        int totalASum = 0, totalBSum = 0, totalCSum = 0;
        int totalCaCnt = 0, totalReCnt = 0;
        int totalCaSum = 0, totalReSum= 0;


        int i = 2; //2row부터
        for(StatsSalesVO statsSalesVO : resultList) {
        	Row dataRow = sheet.createRow(i);

        	String cardCoNm = statsSalesVO.getCardCoNm();
        	if(EgovStringUtil.isEmpty(cardCoNm)) {
        		cardCoNm = statsSalesVO.getStlmTy();
        	}

        	dataRow.createCell(0).setCellValue(cardCoNm);
        	dataRow.createCell(1).setCellValue(String.format("%,d", statsSalesVO.getTotalACnt()));
        	dataRow.createCell(2).setCellValue(String.format("%,d", statsSalesVO.getTotalASum()));
        	dataRow.createCell(3).setCellValue(String.format("%,d", statsSalesVO.getTotalCaCnt()));
        	dataRow.createCell(4).setCellValue(String.format("%,d", statsSalesVO.getTotalCaSum()));
        	dataRow.createCell(5).setCellValue(String.format("%,d", statsSalesVO.getTotalBCnt()));
        	dataRow.createCell(6).setCellValue(String.format("%,d", statsSalesVO.getTotalBSum()));
        	dataRow.createCell(7).setCellValue(String.format("%,d", statsSalesVO.getTotalReCnt()));
        	dataRow.createCell(8).setCellValue(String.format("%,d", statsSalesVO.getTotalReSum()));
        	dataRow.createCell(9).setCellValue(String.format("%,d", statsSalesVO.getTotalCCnt()));
        	dataRow.createCell(10).setCellValue(String.format("%,d", statsSalesVO.getTotalCSum()));
        	i++;

        	//합계 ++
        	totalACnt += statsSalesVO.getTotalACnt();
        	totalBCnt += statsSalesVO.getTotalBCnt();
        	totalCCnt += statsSalesVO.getTotalCCnt();
        	totalASum += statsSalesVO.getTotalASum();
        	totalBSum += statsSalesVO.getTotalBSum();
        	totalCSum += statsSalesVO.getTotalCSum();
        	totalCaCnt += statsSalesVO.getTotalCaCnt();
        	totalReCnt += statsSalesVO.getTotalReCnt();
        	totalCaSum += statsSalesVO.getTotalCaSum();
        	totalReSum += statsSalesVO.getTotalReSum();

        }

        // 합계 > i row
        Row sumRow = sheet.createRow(i);
        sumRow.createCell(0).setCellValue("합계");
    	sumRow.createCell(1).setCellValue(String.format("%,d", totalACnt));
    	sumRow.createCell(2).setCellValue(String.format("%,d", totalASum));
    	sumRow.createCell(3).setCellValue(String.format("%,d", totalCaCnt));
    	sumRow.createCell(4).setCellValue(String.format("%,d", totalCaSum));
    	sumRow.createCell(5).setCellValue(String.format("%,d", totalBCnt));
    	sumRow.createCell(6).setCellValue(String.format("%,d", totalBSum));
    	sumRow.createCell(7).setCellValue(String.format("%,d", totalReCnt));
    	sumRow.createCell(8).setCellValue(String.format("%,d", totalReSum));
    	sumRow.createCell(9).setCellValue(String.format("%,d", totalCCnt));
    	sumRow.createCell(10).setCellValue(String.format("%,d", totalCSum));

        // Excel 다운로드를 위한 응답 유형을 설정하고 데이터를 작성
        String fileName = URLEncoder.encode("카드사별", "UTF-8");
        response.setContentType("application/vnd.openxmlformats-officedocument.spreadsheetml.sheet");
        response.setHeader("Content-Disposition", "attachment; filename=" + fileName + "_" + EgovDateUtil.getCurrentDateAsString()  + ".xlsx");

        try (ServletOutputStream outputStream = response.getOutputStream()) {
            workbook.write(outputStream);
            workbook.close();
        }


		return "/manage/stats/include/sales_excel_cardCo";
	}


}
