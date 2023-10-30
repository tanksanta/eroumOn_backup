package icube.manage.stats.mbr;

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
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import icube.common.framework.abst.CommonAbstractController;
import icube.common.values.CodeMap;
import icube.manage.stats.mbr.biz.StatsMbrService;
import icube.manage.stats.mbr.biz.StatsMbrVO;

@Controller
@RequestMapping(value="/_mng/stats/mbr")
public class MStatsMbrController extends CommonAbstractController {

	@Resource(name = "statsMbrService")
	private StatsMbrService statsMbrService;

	/**
	 * 가입/탈퇴현황
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "join")
	public String join(
			HttpServletRequest request
			, Model model
			, @RequestParam Map<String, Object> reqMap
			) throws Exception {

		Map<String, Object> resultMap = new HashMap<String, Object>();

		// 현재 회원 누계
		resultMap = statsMbrService.selectJoinMap(reqMap);

		// 리스트
		List<StatsMbrVO> resultList = statsMbrService.selectJoinList(reqMap);

		model.addAttribute("resultMap", resultMap);
		model.addAttribute("resultList", resultList);

		return "/manage/stats/mbr/mbr_join";
	}

	/**
	 * 가입/탈퇴현황 엑셀
	 * @param request
	 * @param paramMap
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="joinExcel")
	public void joinExcel(
			HttpServletRequest request
			, HttpServletResponse response
			, @RequestParam Map<String, Object> reqMap
			, Model model) throws Exception{

		// 현재 회원 누계
		Map<String, Object> resultMap = new HashMap<String, Object>();
		resultMap = statsMbrService.selectJoinMap(reqMap);

		List<StatsMbrVO> resultList = statsMbrService.selectJoinList(reqMap);

		Workbook workbook = new XSSFWorkbook();
        Sheet sheet = workbook.createSheet("DataSheet");

        // 첫 번째 행 (상위 헤더)
        Row row1 = sheet.createRow(0);
        row1.createCell(0).setCellValue("기간");
        sheet.addMergedRegion(new CellRangeAddress(0, 1, 0, 0));
        row1.createCell(1).setCellValue("일반회원");
        sheet.addMergedRegion(new CellRangeAddress(0, 0, 1, 2));
        row1.createCell(3).setCellValue("수급자 회원");
        sheet.addMergedRegion(new CellRangeAddress(0, 0, 3, 4));
        row1.createCell(5).setCellValue("전체");
        sheet.addMergedRegion(new CellRangeAddress(0, 0, 5, 6));

        // 두 번째 행 (하위 헤더)
        Row row2 = sheet.createRow(1);
        row2.createCell(1).setCellValue("가입");
        row2.createCell(2).setCellValue("탈퇴");
        row2.createCell(3).setCellValue("가입");
        row2.createCell(4).setCellValue("탈퇴");
        row2.createCell(5).setCellValue("가입");
        row2.createCell(6).setCellValue("탈퇴");

        // data
        int sumNjoin = 0, sumNexit = 0, sumRjoin = 0, sumRexit = 0, sumJtotal = 0, sumEtotal = 0;

        int i = 2; //2row부터
        for(StatsMbrVO statsMbrVO : resultList) {
        	Row dataRow = sheet.createRow(i);
        	dataRow.createCell(0).setCellValue(statsMbrVO.getDate());
        	dataRow.createCell(1).setCellValue(String.format("%,d", statsMbrVO.getNjoin()));
        	dataRow.createCell(2).setCellValue(String.format("%,d", statsMbrVO.getNexit()));
        	dataRow.createCell(3).setCellValue(String.format("%,d", statsMbrVO.getRjoin()));
        	dataRow.createCell(4).setCellValue(String.format("%,d", statsMbrVO.getRexit()));
        	dataRow.createCell(5).setCellValue(String.format("%,d", statsMbrVO.getJtotal()));
        	dataRow.createCell(6).setCellValue(String.format("%,d", statsMbrVO.getEtotal()));
        	i++;

        	//합계 ++
        	sumNjoin += statsMbrVO.getNjoin();
        	sumNexit += statsMbrVO.getNexit();
        	sumRjoin += statsMbrVO.getRjoin();
        	sumRexit += statsMbrVO.getRexit();
        	sumJtotal += statsMbrVO.getJtotal();
        	sumEtotal += statsMbrVO.getEtotal();

        }

        // 합계 > i row
        Row sumRow = sheet.createRow(i);
        sumRow.createCell(0).setCellValue("합계");
    	sumRow.createCell(1).setCellValue(String.format("%,d", sumNjoin));
    	sumRow.createCell(2).setCellValue(String.format("%,d", sumNexit));
    	sumRow.createCell(3).setCellValue(String.format("%,d", sumRjoin));
    	sumRow.createCell(4).setCellValue(String.format("%,d", sumRexit));
    	sumRow.createCell(5).setCellValue(String.format("%,d", sumJtotal));
    	sumRow.createCell(6).setCellValue(String.format("%,d", sumEtotal));

        // Excel 다운로드를 위한 응답 유형을 설정하고 데이터를 작성
        String fileName = URLEncoder.encode("회원가입탈퇴_현황", "UTF-8");
        response.setContentType("application/vnd.openxmlformats-officedocument.spreadsheetml.sheet");
        response.setHeader("Content-Disposition", "attachment; filename=" + fileName + "_" + EgovDateUtil.getCurrentDateAsString()  + ".xlsx");

        try (ServletOutputStream outputStream = response.getOutputStream()) {
            workbook.write(outputStream);
            workbook.close();
        }

	}

	/**
	 * 휴면회원 현황
	 * @param request
	 * @throws Exception
	 */
	@RequestMapping(value = "drmc")
	public String drmc(
			HttpServletRequest request
			, Model model
			, @RequestParam Map<String, Object> reqMap
			) throws Exception {

		List<StatsMbrVO> resultList = statsMbrService.selectDrmcList(reqMap);
		Map<String, Object> resultMap = statsMbrService.selectDrmcMap(reqMap);

		model.addAttribute("resultList", resultList);
		model.addAttribute("resultMap", resultMap);

		return "/manage/stats/mbr/mbr_drmc";
	}

	/**
	 * 휴면회원 엑셀
	 * @param request
	 * @param paramMap
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="drmcExcel")
	public void drmcExcel(
			HttpServletRequest request
			, HttpServletResponse response
			, @RequestParam Map<String, Object> reqMap
			, Model model) throws Exception{

		// 휴면 회원 누계
		List<StatsMbrVO> resultList = statsMbrService.selectDrmcList(reqMap);
		Map<String, Object> resultMap = statsMbrService.selectDrmcMap(reqMap);


		Workbook workbook = new XSSFWorkbook();
        Sheet sheet = workbook.createSheet("DataSheet");

        // 첫 번째 행 (상위 헤더)
        Row row1 = sheet.createRow(0);
        row1.createCell(0).setCellValue("기간");
        row1.createCell(1).setCellValue("휴면회원 전환 수");
        row1.createCell(2).setCellValue("전환예상 수");

        // data
        int sumDrmc = 0, sumWdrmc = 0;

        int i = 1; //1row부터
        for(StatsMbrVO statsMbrVO : resultList) {
        	Row dataRow = sheet.createRow(i);
        	dataRow.createCell(0).setCellValue(statsMbrVO.getDate());
        	dataRow.createCell(1).setCellValue(String.format("%,d", statsMbrVO.getDrmc()));
        	dataRow.createCell(2).setCellValue(String.format("%,d", statsMbrVO.getWdrmc()));
        	i++;

        	//합계 ++
        	sumDrmc += statsMbrVO.getDrmc();
        	sumWdrmc += statsMbrVO.getWdrmc();

        }

        // 합계 > i row
        Row sumRow = sheet.createRow(i);
        sumRow.createCell(0).setCellValue("합계");
    	sumRow.createCell(1).setCellValue(String.format("%,d", sumDrmc));
    	sumRow.createCell(2).setCellValue(String.format("%,d", sumWdrmc));

        // Excel 다운로드를 위한 응답 유형을 설정하고 데이터를 작성
        String fileName = URLEncoder.encode("휴면회원_현황", "UTF-8");
        response.setContentType("application/vnd.openxmlformats-officedocument.spreadsheetml.sheet");
        response.setHeader("Content-Disposition", "attachment; filename=" + fileName + "_" + EgovDateUtil.getCurrentDateAsString()  + ".xlsx");

        try (ServletOutputStream outputStream = response.getOutputStream()) {
            workbook.write(outputStream);
            workbook.close();
        }


		//model.addAttribute("resultList", resultList);
		//model.addAttribute("resultMap", resultMap);

		//return "/manage/stats/include/mbr_excel_drmc";
	}

	/**
	 * 성별/연령별 현황
	 * @param request
	 * @throws Exception
	 */
	@RequestMapping(value = "gender")
	public String gender(
			HttpServletRequest request
			, Model model
			, @RequestParam Map<String, Object> reqMap
			) throws Exception {

		List<StatsMbrVO> resultList = statsMbrService.selectGenderList(reqMap);
		Map<String, Object> resultMap = statsMbrService.selectGenderMap(reqMap);

		model.addAttribute("resultList", resultList);
		model.addAttribute("resultMap", resultMap);

		return "/manage/stats/mbr/mbr_gender";
	}

	/**
	 * 성별/연령별 엑셀
	 * @param request
	 * @param paramMap
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="genderExcel")
	public void genderExcel(
			HttpServletRequest request
			, HttpServletResponse response
			, @RequestParam Map<String, Object> reqMap
			, Model model) throws Exception{

		List<StatsMbrVO> resultList = statsMbrService.selectGenderList(reqMap);
		Map<String, Object> resultMap = statsMbrService.selectGenderMap(reqMap);

		model.addAttribute("resultList", resultList);
		model.addAttribute("resultMap", resultMap);

		Workbook workbook = new XSSFWorkbook();
        Sheet sheet = workbook.createSheet("DataSheet");

        // 첫 번째 행 (상위 헤더)
        Row row1 = sheet.createRow(0);
        row1.createCell(0).setCellValue("일자");
        sheet.addMergedRegion(new CellRangeAddress(0, 1, 0, 0));
        row1.createCell(1).setCellValue("총합계");
        sheet.addMergedRegion(new CellRangeAddress(0, 1, 1, 1));

        row1.createCell(2).setCellValue("남성");
        sheet.addMergedRegion(new CellRangeAddress(0, 0, 2, 9));
        row1.createCell(10).setCellValue("여성");
        sheet.addMergedRegion(new CellRangeAddress(0, 0, 10, 17));

        // 두 번째 행 (하위 헤더)
        Row row2 = sheet.createRow(1);
        row2.createCell(2).setCellValue("~19세");
        row2.createCell(3).setCellValue("20대");
        row2.createCell(4).setCellValue("30대");
        row2.createCell(5).setCellValue("40대");
        row2.createCell(6).setCellValue("50대");
        row2.createCell(7).setCellValue("60대");
        row2.createCell(8).setCellValue("70대");
        row2.createCell(9).setCellValue("남성합계");
        row2.createCell(10).setCellValue("~19세");
        row2.createCell(11).setCellValue("20대");
        row2.createCell(12).setCellValue("30대");
        row2.createCell(13).setCellValue("40대");
        row2.createCell(14).setCellValue("50대");
        row2.createCell(15).setCellValue("60대");
        row2.createCell(16).setCellValue("70대");
        row2.createCell(17).setCellValue("여성합계");

        // data
        int sumTotal = 0;
        int sumMnChild = 0, sumMnTwenty = 0, sumMnThirty = 0, sumMnForty = 0, sumMnFifty = 0, sumMnSixty = 0, sumMnSeventy = 0, sumMnTotal = 0;
        int sumWmChild = 0, sumWmTwenty = 0, sumWmThirty = 0, sumWmForty = 0, sumWmFifty = 0, sumWmSixty = 0, sumWmSeventy = 0, sumWmTotal = 0;

        int i = 2; //2row부터
        for(StatsMbrVO statsMbrVO : resultList) {
        	Row dataRow = sheet.createRow(i);
        	dataRow.createCell(0).setCellValue(statsMbrVO.getDate());
        	dataRow.createCell(1).setCellValue(String.format("%,d", statsMbrVO.getTotal()));

        	dataRow.createCell(2).setCellValue(String.format("%,d", statsMbrVO.getMnChild()));
        	dataRow.createCell(3).setCellValue(String.format("%,d", statsMbrVO.getMnTwenty()));
        	dataRow.createCell(4).setCellValue(String.format("%,d", statsMbrVO.getMnThirty()));
        	dataRow.createCell(5).setCellValue(String.format("%,d", statsMbrVO.getMnForty()));
        	dataRow.createCell(6).setCellValue(String.format("%,d", statsMbrVO.getMnFifty()));
        	dataRow.createCell(7).setCellValue(String.format("%,d", statsMbrVO.getMnSixty()));
        	dataRow.createCell(8).setCellValue(String.format("%,d", statsMbrVO.getMnSeventy()));
        	dataRow.createCell(9).setCellValue(String.format("%,d", statsMbrVO.getMnTotal()));

        	dataRow.createCell(10).setCellValue(String.format("%,d", statsMbrVO.getWmChild()));
        	dataRow.createCell(11).setCellValue(String.format("%,d", statsMbrVO.getWmTwenty()));
        	dataRow.createCell(12).setCellValue(String.format("%,d", statsMbrVO.getWmThirty()));
        	dataRow.createCell(13).setCellValue(String.format("%,d", statsMbrVO.getWmForty()));
        	dataRow.createCell(14).setCellValue(String.format("%,d", statsMbrVO.getWmFifty()));
        	dataRow.createCell(15).setCellValue(String.format("%,d", statsMbrVO.getWmSixty()));
        	dataRow.createCell(16).setCellValue(String.format("%,d", statsMbrVO.getWmSeventy()));
        	dataRow.createCell(17).setCellValue(String.format("%,d", statsMbrVO.getWmTotal()));
        	i++;

        	//합계 ++
        	sumTotal += statsMbrVO.getTotal();

        	sumMnChild += statsMbrVO.getMnChild();
        	sumMnTwenty += statsMbrVO.getMnTwenty();
        	sumMnThirty += statsMbrVO.getMnThirty();
        	sumMnForty += statsMbrVO.getMnForty();
        	sumMnFifty += statsMbrVO.getMnFifty();
        	sumMnSixty += statsMbrVO.getMnSixty();
        	sumMnSeventy += statsMbrVO.getMnSeventy();
        	sumMnTotal += statsMbrVO.getMnTotal();

        	sumWmChild += statsMbrVO.getWmChild();
        	sumWmTwenty += statsMbrVO.getWmTwenty();
        	sumWmThirty += statsMbrVO.getWmThirty();
        	sumWmForty += statsMbrVO.getWmForty();
        	sumWmFifty += statsMbrVO.getWmFifty();
        	sumWmSixty += statsMbrVO.getWmSixty();
        	sumWmSeventy += statsMbrVO.getWmSeventy();
        	sumWmTotal += statsMbrVO.getWmTotal();
        }

        // 합계 > i row
        Row sumRow = sheet.createRow(i);
        sumRow.createCell(0).setCellValue("합계");
    	sumRow.createCell(1).setCellValue(String.format("%,d", sumTotal));
    	sumRow.createCell(2).setCellValue(String.format("%,d", sumMnChild));
    	sumRow.createCell(3).setCellValue(String.format("%,d", sumMnTwenty));
    	sumRow.createCell(4).setCellValue(String.format("%,d", sumMnThirty));
    	sumRow.createCell(5).setCellValue(String.format("%,d", sumMnForty));
    	sumRow.createCell(6).setCellValue(String.format("%,d", sumMnFifty));
    	sumRow.createCell(7).setCellValue(String.format("%,d", sumMnSixty));
    	sumRow.createCell(8).setCellValue(String.format("%,d", sumMnSeventy));
    	sumRow.createCell(9).setCellValue(String.format("%,d", sumMnTotal));

    	sumRow.createCell(10).setCellValue(String.format("%,d", sumWmChild));
    	sumRow.createCell(11).setCellValue(String.format("%,d", sumWmTwenty));
    	sumRow.createCell(12).setCellValue(String.format("%,d", sumWmThirty));
    	sumRow.createCell(13).setCellValue(String.format("%,d", sumWmForty));
    	sumRow.createCell(14).setCellValue(String.format("%,d", sumWmFifty));
    	sumRow.createCell(15).setCellValue(String.format("%,d", sumWmSixty));
    	sumRow.createCell(16).setCellValue(String.format("%,d", sumWmSeventy));
    	sumRow.createCell(17).setCellValue(String.format("%,d", sumWmTotal));

        // Excel 다운로드를 위한 응답 유형을 설정하고 데이터를 작성
        String fileName = URLEncoder.encode("성별연령별", "UTF-8");
        response.setContentType("application/vnd.openxmlformats-officedocument.spreadsheetml.sheet");
        response.setHeader("Content-Disposition", "attachment; filename=" + fileName + "_" + EgovDateUtil.getCurrentDateAsString()  + ".xlsx");

        try (ServletOutputStream outputStream = response.getOutputStream()) {
            workbook.write(outputStream);
            workbook.close();
        }
		//return "/manage/stats/include/mbr_excel_gender";
	}

	/**
	 * 가입경로 현황
	 * @param request
	 * @throws Exception
	 */
	@RequestMapping(value = "cours")
	public String cours(
			HttpServletRequest request
			, Model model
			, @RequestParam Map<String, Object> reqMap
			) throws Exception {

		List<StatsMbrVO> resultList = statsMbrService.selectCoursList(reqMap);

		model.addAttribute("resultList", resultList);

		return "/manage/stats/mbr/mbr_cours";
	}

	/**
	 * 가입경로 엑셀
	 * @param request
	 * @param paramMap
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="coursExcel")
	public void coursExcel(
			HttpServletRequest request
			, HttpServletResponse response
			, @RequestParam Map<String, Object> reqMap
			, Model model) throws Exception{

		List<StatsMbrVO> resultList = statsMbrService.selectCoursList(reqMap);

		Workbook workbook = new XSSFWorkbook();
        Sheet sheet = workbook.createSheet("DataSheet");

        // 첫 번째 행 (상위 헤더)
        Row row1 = sheet.createRow(0);
        row1.createCell(0).setCellValue("가입경로");
        sheet.addMergedRegion(new CellRangeAddress(0, 1, 0, 0));
        row1.createCell(1).setCellValue("총합계");
        sheet.addMergedRegion(new CellRangeAddress(0, 1, 1, 1));

        row1.createCell(2).setCellValue("남성");
        sheet.addMergedRegion(new CellRangeAddress(0, 0, 2, 9));
        row1.createCell(10).setCellValue("여성");
        sheet.addMergedRegion(new CellRangeAddress(0, 0, 10, 17));

        // 두 번째 행 (하위 헤더)
        Row row2 = sheet.createRow(1);
        row2.createCell(2).setCellValue("~19세");
        row2.createCell(3).setCellValue("20대");
        row2.createCell(4).setCellValue("30대");
        row2.createCell(5).setCellValue("40대");
        row2.createCell(6).setCellValue("50대");
        row2.createCell(7).setCellValue("60대");
        row2.createCell(8).setCellValue("70대");
        row2.createCell(9).setCellValue("남성합계");
        row2.createCell(10).setCellValue("~19세");
        row2.createCell(11).setCellValue("20대");
        row2.createCell(12).setCellValue("30대");
        row2.createCell(13).setCellValue("40대");
        row2.createCell(14).setCellValue("50대");
        row2.createCell(15).setCellValue("60대");
        row2.createCell(16).setCellValue("70대");
        row2.createCell(17).setCellValue("여성합계");

        // data
        int sumTotal = 0;
        int sumMnChild = 0, sumMnTwenty = 0, sumMnThirty = 0, sumMnForty = 0, sumMnFifty = 0, sumMnSixty = 0, sumMnSeventy = 0, sumMnTotal = 0;
        int sumWmChild = 0, sumWmTwenty = 0, sumWmThirty = 0, sumWmForty = 0, sumWmFifty = 0, sumWmSixty = 0, sumWmSeventy = 0, sumWmTotal = 0;

        int i = 2; //2row부터
        for(StatsMbrVO statsMbrVO : resultList) {
        	Row dataRow = sheet.createRow(i);
        	dataRow.createCell(0).setCellValue(statsMbrVO.getJoinCours());
        	dataRow.createCell(1).setCellValue(String.format("%,d", statsMbrVO.getTotal()));

        	dataRow.createCell(2).setCellValue(String.format("%,d", statsMbrVO.getMnChild()));
        	dataRow.createCell(3).setCellValue(String.format("%,d", statsMbrVO.getMnTwenty()));
        	dataRow.createCell(4).setCellValue(String.format("%,d", statsMbrVO.getMnThirty()));
        	dataRow.createCell(5).setCellValue(String.format("%,d", statsMbrVO.getMnForty()));
        	dataRow.createCell(6).setCellValue(String.format("%,d", statsMbrVO.getMnFifty()));
        	dataRow.createCell(7).setCellValue(String.format("%,d", statsMbrVO.getMnSixty()));
        	dataRow.createCell(8).setCellValue(String.format("%,d", statsMbrVO.getMnSeventy()));
        	dataRow.createCell(9).setCellValue(String.format("%,d", statsMbrVO.getMnTotal()));

        	dataRow.createCell(10).setCellValue(String.format("%,d", statsMbrVO.getWmChild()));
        	dataRow.createCell(11).setCellValue(String.format("%,d", statsMbrVO.getWmTwenty()));
        	dataRow.createCell(12).setCellValue(String.format("%,d", statsMbrVO.getWmThirty()));
        	dataRow.createCell(13).setCellValue(String.format("%,d", statsMbrVO.getWmForty()));
        	dataRow.createCell(14).setCellValue(String.format("%,d", statsMbrVO.getWmFifty()));
        	dataRow.createCell(15).setCellValue(String.format("%,d", statsMbrVO.getWmSixty()));
        	dataRow.createCell(16).setCellValue(String.format("%,d", statsMbrVO.getWmSeventy()));
        	dataRow.createCell(17).setCellValue(String.format("%,d", statsMbrVO.getWmTotal()));
        	i++;

        	//합계 ++
        	sumTotal += statsMbrVO.getTotal();

        	sumMnChild += statsMbrVO.getMnChild();
        	sumMnTwenty += statsMbrVO.getMnTwenty();
        	sumMnThirty += statsMbrVO.getMnThirty();
        	sumMnForty += statsMbrVO.getMnForty();
        	sumMnFifty += statsMbrVO.getMnFifty();
        	sumMnSixty += statsMbrVO.getMnSixty();
        	sumMnSeventy += statsMbrVO.getMnSeventy();
        	sumMnTotal += statsMbrVO.getMnTotal();

        	sumWmChild += statsMbrVO.getWmChild();
        	sumWmTwenty += statsMbrVO.getWmTwenty();
        	sumWmThirty += statsMbrVO.getWmThirty();
        	sumWmForty += statsMbrVO.getWmForty();
        	sumWmFifty += statsMbrVO.getWmFifty();
        	sumWmSixty += statsMbrVO.getWmSixty();
        	sumWmSeventy += statsMbrVO.getWmSeventy();
        	sumWmTotal += statsMbrVO.getWmTotal();
        }

        // 합계 > i row
        Row sumRow = sheet.createRow(i);
        sumRow.createCell(0).setCellValue("합계");
    	sumRow.createCell(1).setCellValue(String.format("%,d", sumTotal));
    	sumRow.createCell(2).setCellValue(String.format("%,d", sumMnChild));
    	sumRow.createCell(3).setCellValue(String.format("%,d", sumMnTwenty));
    	sumRow.createCell(4).setCellValue(String.format("%,d", sumMnThirty));
    	sumRow.createCell(5).setCellValue(String.format("%,d", sumMnForty));
    	sumRow.createCell(6).setCellValue(String.format("%,d", sumMnFifty));
    	sumRow.createCell(7).setCellValue(String.format("%,d", sumMnSixty));
    	sumRow.createCell(8).setCellValue(String.format("%,d", sumMnSeventy));
    	sumRow.createCell(9).setCellValue(String.format("%,d", sumMnTotal));

    	sumRow.createCell(10).setCellValue(String.format("%,d", sumWmChild));
    	sumRow.createCell(11).setCellValue(String.format("%,d", sumWmTwenty));
    	sumRow.createCell(12).setCellValue(String.format("%,d", sumWmThirty));
    	sumRow.createCell(13).setCellValue(String.format("%,d", sumWmForty));
    	sumRow.createCell(14).setCellValue(String.format("%,d", sumWmFifty));
    	sumRow.createCell(15).setCellValue(String.format("%,d", sumWmSixty));
    	sumRow.createCell(16).setCellValue(String.format("%,d", sumWmSeventy));
    	sumRow.createCell(17).setCellValue(String.format("%,d", sumWmTotal));

        // Excel 다운로드를 위한 응답 유형을 설정하고 데이터를 작성
        String fileName = URLEncoder.encode("가입경로", "UTF-8");
        response.setContentType("application/vnd.openxmlformats-officedocument.spreadsheetml.sheet");
        response.setHeader("Content-Disposition", "attachment; filename=" + fileName + "_" + EgovDateUtil.getCurrentDateAsString()  + ".xlsx");

        try (ServletOutputStream outputStream = response.getOutputStream()) {
            workbook.write(outputStream);
            workbook.close();
        }

	}

	/**
	 * 등급별 현황
	 * @param request
	 * @throws Exception
	 */
	@RequestMapping(value = "grade")
	public String grade(
			HttpServletRequest request
			, Model model
			, @RequestParam Map<String, Object> reqMap
			) throws Exception {

		List<StatsMbrVO> resultList = statsMbrService.selectGradeList(reqMap);

		model.addAttribute("resultList", resultList);
		model.addAttribute("gradeCode", CodeMap.GRADE);

		return "/manage/stats/mbr/mbr_grade";
	}

	/**
	 * 회원등급 엑셀
	 * @param request
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="gradeExcel")
	public void gradeExcel(
			HttpServletRequest request
			, HttpServletResponse response
			, @RequestParam Map<String, Object> reqMap
			, Model model) throws Exception{

		List<StatsMbrVO> resultList = statsMbrService.selectGradeList(reqMap);


		Workbook workbook = new XSSFWorkbook();
        Sheet sheet = workbook.createSheet("DataSheet");

        // 첫 번째 행 (상위 헤더)
        Row row1 = sheet.createRow(0);
        row1.createCell(0).setCellValue("회원등급");
        sheet.addMergedRegion(new CellRangeAddress(0, 1, 0, 0));
        row1.createCell(1).setCellValue("총합계");
        sheet.addMergedRegion(new CellRangeAddress(0, 1, 1, 1));

        row1.createCell(2).setCellValue("남성");
        sheet.addMergedRegion(new CellRangeAddress(0, 0, 2, 9));
        row1.createCell(10).setCellValue("여성");
        sheet.addMergedRegion(new CellRangeAddress(0, 0, 10, 17));

        // 두 번째 행 (하위 헤더)
        Row row2 = sheet.createRow(1);
        row2.createCell(2).setCellValue("~19세");
        row2.createCell(3).setCellValue("20대");
        row2.createCell(4).setCellValue("30대");
        row2.createCell(5).setCellValue("40대");
        row2.createCell(6).setCellValue("50대");
        row2.createCell(7).setCellValue("60대");
        row2.createCell(8).setCellValue("70대");
        row2.createCell(9).setCellValue("남성합계");
        row2.createCell(10).setCellValue("~19세");
        row2.createCell(11).setCellValue("20대");
        row2.createCell(12).setCellValue("30대");
        row2.createCell(13).setCellValue("40대");
        row2.createCell(14).setCellValue("50대");
        row2.createCell(15).setCellValue("60대");
        row2.createCell(16).setCellValue("70대");
        row2.createCell(17).setCellValue("여성합계");

        // data
        int sumTotal = 0;
        int sumMnChild = 0, sumMnTwenty = 0, sumMnThirty = 0, sumMnForty = 0, sumMnFifty = 0, sumMnSixty = 0, sumMnSeventy = 0, sumMnTotal = 0;
        int sumWmChild = 0, sumWmTwenty = 0, sumWmThirty = 0, sumWmForty = 0, sumWmFifty = 0, sumWmSixty = 0, sumWmSeventy = 0, sumWmTotal = 0;

        int i = 2; //2row부터
        for(StatsMbrVO statsMbrVO : resultList) {
        	Row dataRow = sheet.createRow(i);
        	dataRow.createCell(0).setCellValue(CodeMap.GRADE.get( statsMbrVO.getMberGrade() ));
        	dataRow.createCell(1).setCellValue(String.format("%,d", statsMbrVO.getTotal()));

        	dataRow.createCell(2).setCellValue(String.format("%,d", statsMbrVO.getMnChild()));
        	dataRow.createCell(3).setCellValue(String.format("%,d", statsMbrVO.getMnTwenty()));
        	dataRow.createCell(4).setCellValue(String.format("%,d", statsMbrVO.getMnThirty()));
        	dataRow.createCell(5).setCellValue(String.format("%,d", statsMbrVO.getMnForty()));
        	dataRow.createCell(6).setCellValue(String.format("%,d", statsMbrVO.getMnFifty()));
        	dataRow.createCell(7).setCellValue(String.format("%,d", statsMbrVO.getMnSixty()));
        	dataRow.createCell(8).setCellValue(String.format("%,d", statsMbrVO.getMnSeventy()));
        	dataRow.createCell(9).setCellValue(String.format("%,d", statsMbrVO.getMnTotal()));

        	dataRow.createCell(10).setCellValue(String.format("%,d", statsMbrVO.getWmChild()));
        	dataRow.createCell(11).setCellValue(String.format("%,d", statsMbrVO.getWmTwenty()));
        	dataRow.createCell(12).setCellValue(String.format("%,d", statsMbrVO.getWmThirty()));
        	dataRow.createCell(13).setCellValue(String.format("%,d", statsMbrVO.getWmForty()));
        	dataRow.createCell(14).setCellValue(String.format("%,d", statsMbrVO.getWmFifty()));
        	dataRow.createCell(15).setCellValue(String.format("%,d", statsMbrVO.getWmSixty()));
        	dataRow.createCell(16).setCellValue(String.format("%,d", statsMbrVO.getWmSeventy()));
        	dataRow.createCell(17).setCellValue(String.format("%,d", statsMbrVO.getWmTotal()));
        	i++;

        	//합계 ++
        	sumTotal += statsMbrVO.getTotal();

        	sumMnChild += statsMbrVO.getMnChild();
        	sumMnTwenty += statsMbrVO.getMnTwenty();
        	sumMnThirty += statsMbrVO.getMnThirty();
        	sumMnForty += statsMbrVO.getMnForty();
        	sumMnFifty += statsMbrVO.getMnFifty();
        	sumMnSixty += statsMbrVO.getMnSixty();
        	sumMnSeventy += statsMbrVO.getMnSeventy();
        	sumMnTotal += statsMbrVO.getMnTotal();

        	sumWmChild += statsMbrVO.getWmChild();
        	sumWmTwenty += statsMbrVO.getWmTwenty();
        	sumWmThirty += statsMbrVO.getWmThirty();
        	sumWmForty += statsMbrVO.getWmForty();
        	sumWmFifty += statsMbrVO.getWmFifty();
        	sumWmSixty += statsMbrVO.getWmSixty();
        	sumWmSeventy += statsMbrVO.getWmSeventy();
        	sumWmTotal += statsMbrVO.getWmTotal();
        }

        // 합계 > i row
        Row sumRow = sheet.createRow(i);
        sumRow.createCell(0).setCellValue("합계");
    	sumRow.createCell(1).setCellValue(String.format("%,d", sumTotal));
    	sumRow.createCell(2).setCellValue(String.format("%,d", sumMnChild));
    	sumRow.createCell(3).setCellValue(String.format("%,d", sumMnTwenty));
    	sumRow.createCell(4).setCellValue(String.format("%,d", sumMnThirty));
    	sumRow.createCell(5).setCellValue(String.format("%,d", sumMnForty));
    	sumRow.createCell(6).setCellValue(String.format("%,d", sumMnFifty));
    	sumRow.createCell(7).setCellValue(String.format("%,d", sumMnSixty));
    	sumRow.createCell(8).setCellValue(String.format("%,d", sumMnSeventy));
    	sumRow.createCell(9).setCellValue(String.format("%,d", sumMnTotal));

    	sumRow.createCell(10).setCellValue(String.format("%,d", sumWmChild));
    	sumRow.createCell(11).setCellValue(String.format("%,d", sumWmTwenty));
    	sumRow.createCell(12).setCellValue(String.format("%,d", sumWmThirty));
    	sumRow.createCell(13).setCellValue(String.format("%,d", sumWmForty));
    	sumRow.createCell(14).setCellValue(String.format("%,d", sumWmFifty));
    	sumRow.createCell(15).setCellValue(String.format("%,d", sumWmSixty));
    	sumRow.createCell(16).setCellValue(String.format("%,d", sumWmSeventy));
    	sumRow.createCell(17).setCellValue(String.format("%,d", sumWmTotal));

        // Excel 다운로드를 위한 응답 유형을 설정하고 데이터를 작성
        String fileName = URLEncoder.encode("회원등급", "UTF-8");
        response.setContentType("application/vnd.openxmlformats-officedocument.spreadsheetml.sheet");
        response.setHeader("Content-Disposition", "attachment; filename=" + fileName + "_" + EgovDateUtil.getCurrentDateAsString()  + ".xlsx");

        try (ServletOutputStream outputStream = response.getOutputStream()) {
            workbook.write(outputStream);
            workbook.close();
        }
	}

}
