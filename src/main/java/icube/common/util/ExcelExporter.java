package icube.common.util;

import java.io.IOException;
import java.net.URLEncoder;
import java.util.ArrayList;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;
import java.util.function.Function;

import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletResponse;

import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.CellStyle;
import org.apache.poi.ss.usermodel.FillPatternType;
import org.apache.poi.ss.usermodel.Font;
import org.apache.poi.ss.usermodel.IndexedColors;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.egovframe.rte.fdl.string.EgovDateUtil;

/**
 * 데이터를 Excel 형식으로 내보내는 유틸리티 클래스
 * 공통으로 사용할 수 있도록 제작하였으나 여러 케이스에서 사용하려면 보완이 필요할 수 있습니다.
 *
 * + 출력순서 변경방지를 위해 LinkedHashMap 사용
 * + rowNum 추가 -> value로 rowNum을 넣으면 순번이 출력되도록 추가
 *
 * @author kyunmo
 */
public class ExcelExporter {

	/**
     * 데이터를 Excel형식으로 내보내기
     * @param response    응답 객체
	 * @param fileName    Excel 파일의 이름
	 * @param dataList    데이터의 목록. 각 맵의 키는 컬럼 헤더로 사용되며, 값은 해당 셀의 데이터로 사용
	 * @param mapping     각 데이터 행을 변환하기 위한 매핑 함수의 목록
	 * @throws IOException
     */
	 public void export(
			 HttpServletResponse response
			 , String fileName
			 , List<LinkedHashMap<String, Object>> dataList
			 , Map<String, Function<Object, Object>> mapping) throws IOException {


        Workbook workbook = new XSSFWorkbook();
        Sheet sheet = workbook.createSheet("DataSheet");

        Font font = workbook.createFont();
        font.setFontHeightInPoints((short) 10);	// 글자크기

        CellStyle headerStyle = workbook.createCellStyle();
        headerStyle.setFillForegroundColor(IndexedColors.GREY_25_PERCENT.getIndex());
        headerStyle.setFillPattern(FillPatternType.SOLID_FOREGROUND);
        headerStyle.setFont(font);

        CellStyle style = workbook.createCellStyle();
        style.setFont(font);
        style.setWrapText(true); //줄바꿈처리 : \n

        // Header 생성
        Row headerRow = sheet.createRow(0);
        List<String> headers = new ArrayList<>(mapping.keySet());
        for (int i = 0; i < headers.size(); i++) {
            Cell headerCell = headerRow.createCell(i);
            headerCell.setCellValue(headers.get(i));
            headerCell.setCellStyle(headerStyle);
        }

        // Data rows 생성
        for (int i = 0; i < dataList.size(); i++) {
            Row row = sheet.createRow(i + 1);
            LinkedHashMap<String, Object> dataMap = dataList.get(i);
            for (int j = 0; j < headers.size(); j++) {
                Cell cell = row.createCell(j);
                Object value = dataMap.get(headers.get(j));
                if (value != null) {
                	if(value.toString().equals("rowNum")) {
                		cell.setCellValue(row.getRowNum());
                	} else {
                		cell.setCellValue(value.toString());
                	}
                    cell.setCellStyle(style);
                }
                sheet.autoSizeColumn(j); // width auto
            }
        }

        // Excel 다운로드를 위한 응답 유형을 설정하고 데이터를 작성
        fileName = URLEncoder.encode(fileName, "UTF-8").replaceAll("\\+", "%20");
        response.setContentType("application/vnd.openxmlformats-officedocument.spreadsheetml.sheet");
        response.setHeader("Content-Disposition", "attachment; filename=" + fileName + "_" + EgovDateUtil.getCurrentDateAsString()  + ".xlsx");

        try (ServletOutputStream outputStream = response.getOutputStream()) {
            workbook.write(outputStream);
            workbook.close();
        }
    }

}
