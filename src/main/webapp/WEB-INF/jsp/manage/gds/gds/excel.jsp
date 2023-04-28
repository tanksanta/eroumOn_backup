<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ page import="org.egovframe.rte.fdl.string.EgovDateUtil" %>
<%@ page import="java.net.URLEncoder, java.io.UnsupportedEncodingException" %>
<%
	// 엑셀 파일 정보 얻기
	String header = request.getHeader("User-Agent");

	// 엑셀 파일명 설정
	String fileName = "상품목록_"+EgovDateUtil.getCurrentDateAsString();
	try {
		fileName = URLEncoder.encode(fileName.toString(), "UTF-8").replaceAll("\\+", "%20");
	} catch (UnsupportedEncodingException e) {
		fileName = "_naming_error";
	}

	response.setHeader("Content-Disposition", "attachment; filename=" + fileName + ".xls;");
    response.setHeader("Content-Description", "JSP Generated Data");
    response.setHeader("Content-Transfer-Encoding", "binary;");
    response.setHeader("Pragma", "no-cache;");
    response.setHeader("Expires", "-1;");
%>
<!DOCTYPE html>
<html>
	<meta charset="utf-8">
	<head>
	<style>
		table { border-collapse:collapse; }
		table th,  td { border:1px solid #cccccc; }
	</style>
	</head>
<body>
	<table class="table">
		<thead>
			<tr>
				<th scope="col">상품구분</th>
				<th scope="col">카테고리1</th>
				<th scope="col">카테고리2</th>
                <th scope="col">상품코드</th>
                <th scope="col">급여코드</th>
                <th scope="col">품목코드</th>
                <th scope="col">상품명</th>
                <th scope="col">관리자메모</th>
                <th scope="col">기본설명</th>
                <th scope="col">재질</th>
                <th scope="col">중량</th>
                <th scope="col">사이즈상세</th>
                <th scope="col">규격</th>
                <th scope="col">제조사</th>
                <th scope="col">원산지</th>
                <th scope="col">브랜드</th>
                <th scope="col">모델</th>
                <th scope="col">노출여부</th>

                <th scope="col">판매가</th>
                <th scope="col">할인율</th>
                <th scope="col">할인가</th>
                <th scope="col">급여가</th>
                <th scope="col">대여가능</th>
                <th scope="col">재고수량</th>

                <th scope="col">배송비유형</th>
                <th scope="col">배송비결제</th>
                <th scope="col">기본배송료</th>
                <th scope="col">추가배송비</th>

                <th scope="col">등록일</th>
			</tr>
		</thead>
		<tbody>
			<c:forEach items="${resultList}" var="result" varStatus="status">
			<tr>
                <td>${gdsTyCode[result.gdsTy]}</td>
                <td>${result.upCtgryNm}</td>
                <td>${result.ctgryNm}</td>
                <td>${result.gdsCd}</td>
                <td>${result.bnefCd}</td>
                <td>${result.itemCd}</td>
                <td>${result.gdsNm}</td>
                <td>${result.mngrMemo}</td>
                <td>${result.bassDc}</td>
                <td>${result.mtrqlt}</td>
                <td>${result.wt}</td>
                <td>${result.size}</td>
                <td>${result.stndrd}</td>
                <td>${result.mkr}</td>
                <td>${result.plor}</td>
                <td>${result.brand}</td>
                <td>${result.modl}</td>
                <td>${dspyYnCode[result.dspyYn]}</td>

                <td><fmt:formatNumber value="${result.pc}" pattern="###,###" /></td>
                <td>${result.dscntRt}%</td>
                <td><fmt:formatNumber value="${result.dscntPc}" pattern="###,###" /></td>
                <td><fmt:formatNumber value="${result.bnefPc}" pattern="###,###" /></td>
                <td>${result.lendDuraYn eq 'Y'?'사용':'미사용'}</td>
                <td>${result.stockQy}</td>

                <td>${dlvyCostTyCode[result.dlvyCtTy]}</td>
                <td>${dlvyPayTyCode[result.dlvyCtStlm]}</td>
                <td><fmt:formatNumber value="${result.dlvyBassAmt}" pattern="###,###" /></td>
                <td><fmt:formatNumber value="${result.dlvyAditAmt}" pattern="###,###" /></td>

                <td><fmt:formatDate value="${result.regDt}" pattern="yyyy-MM-dd HH:mm:ss"/></td>
            </tr>
			</c:forEach>
			<c:if test="${fn:length(resultList) < 1}">
			<tr>
				<td colspan="29" style="height:50px; text-align:center; vertical-align:middle;">데이터가 없습니다.</td>
			</tr>
			</c:if>
		</tbody>
	</table>
	</body>
</html>