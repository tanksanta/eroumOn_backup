package icube.common.util;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.poi.hssf.usermodel.HSSFDateUtil;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.springframework.web.multipart.MultipartFile;

public class ExcelUtil {
	private static SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd");
	
	/**
	 * 엑셀데이터 읽기
	 * @return Map<시트명, rowsList<cellList>>
	 */
	public static Map<String, List<List<String>>> readExcel(MultipartFile excelFile) {
		
		Workbook workbook = null;
		
		try {
			if(excelFile.getOriginalFilename().toUpperCase().endsWith("XLSX")) {
				workbook = new XSSFWorkbook(excelFile.getInputStream());
			} else {
				workbook = new HSSFWorkbook(excelFile.getInputStream());
			}
			
			int sheetCnt = workbook.getNumberOfSheets();
			if (sheetCnt <= 0) {
				return null;
			}
			
			Map<String, List<List<String>>> result = new HashMap<String, List<List<String>>>();
			
			//시트 순회
			for(int sheetNum = 0; sheetNum < sheetCnt; sheetNum++) {
				Sheet sheet = workbook.getSheetAt(sheetNum);
				String sheetName = workbook.getSheetName(sheetNum);
				
				List<List<String>> rowsData = new ArrayList<List<String>>();
				int rowsCnt = sheet.getPhysicalNumberOfRows();
				//row 순회
				for(int rowNum = 0; rowNum < rowsCnt; rowNum++) {
					Row row = sheet.getRow(rowNum);
					if (row != null) {
						List<String> cellsData = new ArrayList<String>();
						int cellsCnt = row.getLastCellNum();
						
						//cell 순회
						for (int cellNum = 0; cellNum < cellsCnt; cellNum++) {
							Cell cell = row.getCell(cellNum);
							
							String cellValue = getCellValue(cell);
							cellsData.add(cellValue);
						}
						
						rowsData.add(cellsData);
					}
					
					result.put(sheetName, rowsData);
				} 
			}
			
			return result;
			
		} catch (Exception e) {
			return null;
		}
	}
	
	private static String getCellValue(Cell cell) {
		String value = "";
		
		if (cell != null) {
			switch (cell.getCellTypeEnum()) {
				case BLANK: value = ""; break;
				case BOOLEAN: value = "" + cell.getBooleanCellValue(); break;
				case ERROR: value = "" + cell.getErrorCellValue(); break;
				case FORMULA: value = cell.getCellFormula(); break;
				case NUMERIC: {
					if(HSSFDateUtil.isInternalDateFormat(cell.getCellStyle().getDataFormat())) {
						value = sdf.format(cell.getDateCellValue());
					}
					else {
						value = String.valueOf(cell.getNumericCellValue());
					}
					break;
				}
				case STRING: value = cell.getStringCellValue(); break;
				default: value = "";
			}
		}
		return value;
	}
}
