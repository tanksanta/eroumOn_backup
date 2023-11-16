package icube.manage.clcln;

import java.net.URLEncoder;
import java.text.SimpleDateFormat;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.poi.ss.usermodel.CellStyle;
import org.apache.poi.ss.usermodel.Font;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.ss.util.CellRangeAddress;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.egovframe.rte.fdl.string.EgovDateUtil;
import org.egovframe.rte.fdl.string.EgovStringUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import icube.common.framework.abst.CommonAbstractController;
import icube.common.util.DateUtil;
import icube.common.util.ExcelExporter;
import icube.common.util.StringUtil;
import icube.common.values.CodeMap;
import icube.manage.clcln.biz.ClclnService;
import icube.manage.ordr.chghist.biz.OrdrChgHistVO;
import icube.manage.ordr.dtl.biz.OrdrDtlVO;
import icube.manage.sysmng.entrps.biz.EntrpsService;
import icube.manage.sysmng.entrps.biz.EntrpsVO;
import icube.manage.sysmng.mngr.biz.MngrService;
import icube.manage.sysmng.mngr.biz.MngrSession;
import icube.manage.sysmng.mngr.biz.MngrVO;

@Controller
@RequestMapping(value="/_mng/clcln")
public class MClclnController extends CommonAbstractController {

	@Resource(name = "clclnService")
	private ClclnService clclnService;

	@Resource(name="mngrService")
	private MngrService mngrService;
	
	@Resource(name = "entrpsService")
	private EntrpsService entrpsService;
	
	@Autowired
	private MngrSession mngrSession;
	
	// Page Parameter Keys
	private static String[] targetParams = {"curPage", "cntPerPage", "srchTarget", "srchText", "sortBy"};

	private SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
	
	
	// 마켓정산
	@RequestMapping(value="/market/list")
	public String marketList(
			@RequestParam Map<String, Object> reqMap
			, HttpServletRequest request
			, Model model) throws Exception {
		
		// 마켓 정산 정보 조회
		srchMarketClcln(reqMap, model, true);

		return "/manage/clcln/market_list";
	}


	@SuppressWarnings("unchecked")
	@RequestMapping(value="/market/excel")
	public void marketExcel(
			@RequestParam Map<String, Object> reqMap
			, HttpServletRequest request
			, HttpServletResponse response
			, Model model) throws Exception {

		// 마켓 정산 정보 조회
		srchMarketClcln(reqMap, model, false);
		
		List<OrdrDtlVO> ordrList = (List<OrdrDtlVO>) model.getAttribute("ordrList");
		
		
		//엑셀 처리
		Workbook workbook = new XSSFWorkbook();
        Sheet sheet = workbook.createSheet("DataSheet");
        
        Font font = workbook.createFont();
        font.setFontHeightInPoints((short) 10);	// 글자크기
        
        CellStyle style = workbook.createCellStyle();
        style.setFont(font);
        style.setWrapText(true); //줄바꿈처리 : \n
        
        // 첫 번째 행 (상위 헤더)
        Row row1 = sheet.createRow(0);
        row1.createCell(0).setCellValue("주문일시");
        sheet.addMergedRegion(new CellRangeAddress(0, 1, 0, 0));
        row1.createCell(1).setCellValue("주문번호");
        sheet.addMergedRegion(new CellRangeAddress(0, 1, 1, 1));
        row1.createCell(2).setCellValue("주문자");
        sheet.addMergedRegion(new CellRangeAddress(0, 1, 2, 2));
        row1.createCell(3).setCellValue("수령인");
        sheet.addMergedRegion(new CellRangeAddress(0, 1, 3, 3));
        row1.createCell(4).setCellValue("상품번호");
        sheet.addMergedRegion(new CellRangeAddress(0, 1, 4, 4));
        row1.createCell(5).setCellValue("이카운트\n품목코드");
        sheet.addMergedRegion(new CellRangeAddress(0, 1, 5, 5));
        row1.createCell(6).setCellValue("입점업체명");
        sheet.addMergedRegion(new CellRangeAddress(0, 1, 6, 6));
        row1.createCell(7).setCellValue("상품명");
        sheet.addMergedRegion(new CellRangeAddress(0, 1, 7, 7));
        row1.createCell(8).setCellValue("옵션명");
        sheet.addMergedRegion(new CellRangeAddress(0, 1, 8, 8));
        row1.createCell(9).setCellValue("결제수단");
        sheet.addMergedRegion(new CellRangeAddress(0, 1, 9, 9));
        row1.createCell(10).setCellValue("상품가격");
        sheet.addMergedRegion(new CellRangeAddress(0, 1, 10, 10));
        row1.createCell(11).setCellValue("수량");
        sheet.addMergedRegion(new CellRangeAddress(0, 1, 11, 11));
        row1.createCell(12).setCellValue("공급가");
        sheet.addMergedRegion(new CellRangeAddress(0, 1, 12, 12));
        row1.createCell(13).setCellValue("공급가합계");
        sheet.addMergedRegion(new CellRangeAddress(0, 1, 13, 13));
        row1.createCell(14).setCellValue("판매가");
        sheet.addMergedRegion(new CellRangeAddress(0, 1, 14, 14));
        row1.createCell(15).setCellValue("판매가합계");
        sheet.addMergedRegion(new CellRangeAddress(0, 1, 15, 15));
        row1.createCell(16).setCellValue("할인금액");
        sheet.addMergedRegion(new CellRangeAddress(0, 0, 16, 18));
        row1.createCell(19).setCellValue("배송비");
        sheet.addMergedRegion(new CellRangeAddress(0, 1, 19, 19));
        row1.createCell(20).setCellValue("실결제금액");
        sheet.addMergedRegion(new CellRangeAddress(0, 1, 20, 20));
        row1.createCell(21).setCellValue("발송처리일");
        sheet.addMergedRegion(new CellRangeAddress(0, 1, 21, 21));
        row1.createCell(22).setCellValue("송장번호");
        sheet.addMergedRegion(new CellRangeAddress(0, 1, 22, 22));
        row1.createCell(23).setCellValue("배송완료일");
        sheet.addMergedRegion(new CellRangeAddress(0, 1, 23, 23));
        row1.createCell(24).setCellValue("구매확정일");
        sheet.addMergedRegion(new CellRangeAddress(0, 1, 24, 24));
        row1.createCell(25).setCellValue("주문상태");
        sheet.addMergedRegion(new CellRangeAddress(0, 1, 25, 25));
        
        // 두 번째 행 (하위 헤더)
        Row row2 = sheet.createRow(1);
        row2.createCell(16).setCellValue("쿠폰");
        row2.createCell(17).setCellValue("마일리지");
        row2.createCell(18).setCellValue("포인트");
        
        // 스타일 적용하고 싶음
        ExcelExporter.setCellStyleForRow(row1, style);
        ExcelExporter.setCellStyleForRow(row2, style);
        
        
        //데이터 ROW
        int i = 2;
        int sumGdsSupPc = 0; //공급가합계
        int sumOrdrPc = 0;   //판매가합계
        for(OrdrDtlVO ordrDtlVO : ordrList) {
        	Row dataRow = sheet.createRow(i);
        	
        	dataRow.createCell(0).setCellValue(dateFormat.format(ordrDtlVO.getOrdrDt()));
        	dataRow.createCell(1).setCellValue(ordrDtlVO.getOrdrCd());
        	dataRow.createCell(2).setCellValue(ordrDtlVO.getOrdrrNm());
        	dataRow.createCell(3).setCellValue(ordrDtlVO.getRecptrNm());
        	dataRow.createCell(4).setCellValue(ordrDtlVO.getGdsCd());
        	
        	String itemCd = "";
        	if (EgovStringUtil.isNotEmpty(ordrDtlVO.getGdsItemCd())) {
        		itemCd = ordrDtlVO.getGdsItemCd(); 
        	} 
        	else if (EgovStringUtil.isNotEmpty(ordrDtlVO.getOptnItemCd())) {
        		itemCd = ordrDtlVO.getOptnItemCd();
        	}
        	dataRow.createCell(5).setCellValue(itemCd);
        	
        	dataRow.createCell(6).setCellValue(ordrDtlVO.getEntrpsNm());
        	dataRow.createCell(7).setCellValue(ordrDtlVO.getGdsNm());
        	
        	String optnNm = "";
        	if ("ADIT".equals(ordrDtlVO.getOrdrOptnTy())) {
        		optnNm = "(추가옵션) " + ordrDtlVO.getOrdrOptn();
        	} else if ("BASE".equals(ordrDtlVO.getOrdrOptnTy()) && EgovStringUtil.isNotEmpty(ordrDtlVO.getOrdrOptn())) {
        		optnNm = ordrDtlVO.getOrdrOptn();
        	}
        	dataRow.createCell(8).setCellValue(optnNm);
        	
        	String stlmTy = "미정";
        	if (EgovStringUtil.isNotEmpty(ordrDtlVO.getStlmTy())) {
        		stlmTy = CodeMap.BASS_STLM_TY.get(ordrDtlVO.getStlmTy());
        	}
        	dataRow.createCell(9).setCellValue(stlmTy);
        	
        	String ordrPc = "";
        	if ("BASE".equals(ordrDtlVO.getOrdrOptnTy())) {
        		ordrPc = String.format("%,d", ordrDtlVO.getGdsPc());
        		ordrPc += "\n(+" + String.format("%,d", ordrDtlVO.getOrdrOptnPc()) + ")";
        	}
        	if ("ADIT".equals(ordrDtlVO.getOrdrOptnTy())) {
        		ordrPc += "+" + String.format("%,d", ordrDtlVO.getGdsPc());
        	}
        	dataRow.createCell(10).setCellValue(ordrPc);
        	
        	dataRow.createCell(11).setCellValue(String.format("%,d", ordrDtlVO.getOrdrQy()));
        	dataRow.createCell(12).setCellValue(String.format("%,d", ordrDtlVO.getGdsSupPc()));
        	sumGdsSupPc += ordrDtlVO.getGdsSupPc();
        	dataRow.createCell(13).setCellValue(String.format("%,d", sumGdsSupPc));
        	dataRow.createCell(14).setCellValue(String.format("%,d", ordrDtlVO.getOrdrPc()));
        	sumOrdrPc += ordrDtlVO.getOrdrPc();
        	dataRow.createCell(15).setCellValue(String.format("%,d", sumOrdrPc));
        	dataRow.createCell(16).setCellValue(String.format("%,d", ordrDtlVO.getCouponAmt()));
        	dataRow.createCell(17).setCellValue(String.format("%,d", ordrDtlVO.getUseMlg()));
        	dataRow.createCell(18).setCellValue(String.format("%,d", ordrDtlVO.getUsePoint()));
        	
        	String dlvyAmt = String.format("%,d", ordrDtlVO.getDlvyBassAmt());
        	if (ordrDtlVO.getDlvyAditAmt() > 0) {
        		dlvyAmt += "\n(+" + String.format("%,d", ordrDtlVO.getDlvyAditAmt()) + ")";
        	}
        	dataRow.createCell(19).setCellValue(dlvyAmt);
        	
        	dataRow.createCell(20).setCellValue(String.format("%,d", ordrDtlVO.getStlmAmt()));
        	
        	String or07Date = "";
        	if (ordrDtlVO.getOrdrChgHist() != null) {
        		OrdrChgHistVO or07ChgHist = ordrDtlVO.getOrdrChgHist().stream().filter(f -> "OR07".equals(f.getChgStts())).findAny().orElse(null);
        		if (or07ChgHist != null) {
        			or07Date = dateFormat.format(or07ChgHist.getRegDt());
        		}
        	}
        	dataRow.createCell(21).setCellValue(or07Date);
        	
        	dataRow.createCell(22).setCellValue(ordrDtlVO.getDlvyInvcNo());
        	
        	String or08Date = "";
        	if (ordrDtlVO.getOrdrChgHist() != null) {
        		OrdrChgHistVO or08ChgHist = ordrDtlVO.getOrdrChgHist().stream().filter(f -> "OR08".equals(f.getChgStts())).findAny().orElse(null);
        		if (or08ChgHist != null) {
        			or08Date = dateFormat.format(or08ChgHist.getRegDt());
        		}
        	}
        	dataRow.createCell(23).setCellValue(or08Date);
        	
        	String or09Date = "";
        	if (ordrDtlVO.getOrdrChgHist() != null) {
        		OrdrChgHistVO or09ChgHist = ordrDtlVO.getOrdrChgHist().stream().filter(f -> "OR09".equals(f.getChgStts())).findAny().orElse(null);
        		if (or09ChgHist != null) {
        			or09Date = dateFormat.format(or09ChgHist.getRegDt());
        		}
        	}
        	dataRow.createCell(24).setCellValue(or09Date);
        	dataRow.createCell(25).setCellValue(CodeMap.ORDR_STTS.get(ordrDtlVO.getSttsTy()));
        	
        	i++;
        	ExcelExporter.setCellStyleForRow(dataRow, style);
        }
        
        
        for(int j=0; j<26; j++) {
        	sheet.autoSizeColumn(j);
        }
        
        // Excel 다운로드를 위한 응답 유형을 설정하고 데이터를 작성
        String fileName = "마켓정산_목록";
        fileName = URLEncoder.encode(fileName,  "UTF-8");
        response.setContentType("application/vnd.openxmlformats-officedocument.spreadsheetml.sheet");
        response.setHeader("Content-Disposition", "attachment; filename=" + fileName + "_" + EgovDateUtil.getCurrentDateAsString()  + ".xlsx");

        try (ServletOutputStream outputStream = response.getOutputStream()) {
            workbook.write(outputStream);
            workbook.close();
        }
        
		//return "/manage/clcln/include/market_excel";
	}



	// partners > 사업소 전체
	@RequestMapping(value="/partners/list")
	public String partnersList(
			@RequestParam Map<String, Object> reqMap
			, HttpServletRequest request
			, Model model) throws Exception {

		String srchBplcNm = (String) reqMap.get("srchBplcNm");

		String srchOrdrYmdBgng = (String) reqMap.get("srchOrdrYmdBgng");
		if(EgovStringUtil.isEmpty(srchOrdrYmdBgng)) {
			srchOrdrYmdBgng = DateUtil.getCurrentDateTime("yyyy-MM-dd");
		}
		String srchOrdrYmdEnd = (String) reqMap.get("srchOrdrYmdEnd");
		if(EgovStringUtil.isEmpty(srchOrdrYmdEnd)) {
			srchOrdrYmdEnd = DateUtil.getCurrentDateTime("yyyy-MM-dd");
		}

		Map<String, Object> paramMap = new HashMap<String, Object>();
		paramMap.put("srchBplcNm", srchBplcNm);
		paramMap.put("srchOrdrYmdBgng", srchOrdrYmdBgng);
		paramMap.put("srchOrdrYmdEnd", srchOrdrYmdEnd);

		List<Map<String, Object>> resultList = clclnService.selectPartnerList(paramMap);

		model.addAttribute("ordrList", resultList);

		model.addAttribute("srchOrdrYmdBgng", srchOrdrYmdBgng);
		model.addAttribute("srchOrdrYmdEnd", srchOrdrYmdEnd);

		return "/manage/clcln/partner_list";
	}

	// blpc > 사업소 별
	@RequestMapping(value="/partners/{bplcUniqueId}/list")
	public String bplcList(
			@PathVariable String bplcUniqueId
			, @RequestParam Map<String, Object> reqMap
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
		paramMap.put("srchBplcUniqueId", bplcUniqueId);
		paramMap.put("srchOrdrYmdBgng", srchOrdrYmdBgng);
		paramMap.put("srchOrdrYmdEnd", srchOrdrYmdEnd);


		List<OrdrDtlVO> resultList = clclnService.selectOrdrList(paramMap);

		model.addAttribute("gdsTyCode", CodeMap.GDS_TY);
		model.addAttribute("bassStlmTyCode", CodeMap.BASS_STLM_TY);
		model.addAttribute("ordrSttsCode", CodeMap.ORDR_STTS);

		model.addAttribute("ordrList", resultList);

		model.addAttribute("srchOrdrYmdBgng", srchOrdrYmdBgng);
		model.addAttribute("srchOrdrYmdEnd", srchOrdrYmdEnd);


		return "/manage/clcln/bplc_list";
	}

	/**
	 * 마켓 정산 조회가 엑셀다운로드 로직이 같으므로 별도 함수 구현
	 */
	private void srchMarketClcln(Map<String, Object> reqMap, Model model, boolean masking) throws Exception {
		Map<String, String> mbgrReqMap = new HashMap<>();
		mbgrReqMap.put("mngrId", mngrSession.getMngrId());
		MngrVO curMngrVO = mngrService.selectMngrById(mbgrReqMap);
		
		Map<String, Object> paramMap = new HashMap<String, Object>();
		
		String srchOrdrYmdBgng = (String) reqMap.get("srchOrdrYmdBgng");
		if(EgovStringUtil.isEmpty(srchOrdrYmdBgng)) {
			srchOrdrYmdBgng = DateUtil.getCurrentDateTime("yyyy-MM-dd");
		}
		String srchOrdrYmdEnd = (String) reqMap.get("srchOrdrYmdEnd");
		if(EgovStringUtil.isEmpty(srchOrdrYmdEnd)) {
			srchOrdrYmdEnd = DateUtil.getCurrentDateTime("yyyy-MM-dd");
		}
		String srchEntrpsNm = (String) reqMap.get("srchEntrpsNm");
		if(EgovStringUtil.isNotEmpty(srchEntrpsNm)) {
			paramMap.put("srchEntrpsNm", srchEntrpsNm);
		}
		
		//현재관리자에 입점업체 정보가 있으면 해당 입점업체만 조회되도록 구현
		if (curMngrVO.getEntrpsNo() > 0) {
			EntrpsVO entrpsVO = entrpsService.selectEntrps(curMngrVO.getEntrpsNo());
			paramMap.put("srchEntrpsNm", entrpsVO.getEntrpsNm());
			model.addAttribute("mngrEntrpsNm", entrpsVO.getEntrpsNm());
		}
		
		paramMap.put("srchOrdrYmdBgng", srchOrdrYmdBgng);
		paramMap.put("srchOrdrYmdEnd", srchOrdrYmdEnd);

		List<OrdrDtlVO> resultList = clclnService.selectOrdrList(paramMap);

		
		if (masking) {
			//개인정보 마스킹
			for(OrdrDtlVO vo : resultList) {
				vo.setOrdrrNm(StringUtil.nameMasking(vo.getOrdrrNm()));
				vo.setRecptrNm(StringUtil.nameMasking(vo.getRecptrNm()));
			}
		}
		
		
		model.addAttribute("gdsTyCode", CodeMap.GDS_TY);
		model.addAttribute("bassStlmTyCode", CodeMap.BASS_STLM_TY);
		model.addAttribute("ordrSttsCode", CodeMap.ORDR_STTS);

		model.addAttribute("ordrList", resultList);

		model.addAttribute("srchOrdrYmdBgng", srchOrdrYmdBgng);
		model.addAttribute("srchOrdrYmdEnd", srchOrdrYmdEnd);
	}
}
