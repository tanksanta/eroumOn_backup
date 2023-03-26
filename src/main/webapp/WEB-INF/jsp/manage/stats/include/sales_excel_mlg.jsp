<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page trimDirectiveWhitespaces="true"%>
<%@ page import="org.egovframe.rte.fdl.string.EgovDateUtil"%>
<%@ page import="java.net.URLEncoder, java.io.UnsupportedEncodingException"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
// 엑셀 파일 정보 얻기
String header = request.getHeader("User-Agent");

// 엑셀 파일명 설정
String fileName = "마일리지_" + EgovDateUtil.getCurrentDateAsString();
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
table {
	border-collapse: collapse;
}

table th, td {
	border: 1px solid #cccccc;
}
</style>
</head>
<body>
	<div class="scroll-table">
		<table class="table-list">
			<colgroup>
				<col class="min-w-35 w-35">
				<col class="min-w-25">
				<col class="min-w-25">
				<col class="min-w-30">
				<col class="min-w-25">
				<col class="min-w-30">
				<col class="min-w-25">
			</colgroup>
			<thead>
				<tr>
					<th scope="col" rowspan="2">일자</th>
					<th scope="col" rowspan="2">판매건수</th>
					<th scope="col" rowspan="2">마일리지<br> 사용 주문건수
					</th>
					<th scope="colgroup" colspan="3">사용현황</th>
					<th scope="col" rowspan="2">적립마일리지</th>
				</tr>
				<tr>
					<th scope="col">판매금액</th>
					<th scope="col">사용 마일리지</th>
					<th scope="col" class="nolast">마일리지 사용 결제 금액</th>
				</tr>
			</thead>
			<tbody>

				<c:if test="${!empty resultList}">
					<c:set var="totalACnt" value="0" />
					<c:set var="totalBCnt" value="0" />
					<c:set var="totalBSum" value="0" />

					<c:set var="totalMlgSum" value="0" />
					<c:set var="totalStlmSum" value="0" />
					<c:set var="totalAccmlMlg" value="0" />


					<c:forEach items="${resultList}" var="result" varStatus="status">
						<c:set var="totalACnt" value="${totalACnt + result.totalACnt}" />
						<c:set var="totalBCnt" value="${totalBCnt + result.totalBCnt}" />
						<c:set var="totalBSum" value="${totalBSum + result.totalBSum}" />

						<c:set var="totalMlgSum" value="${totalMlgSum + result.totalMlgSum}" />
						<c:set var="totalStlmSum" value="${totalStlmSum + result.totalStlmSum}" />
						<c:set var="totalAccmlMlg" value="${totalAccmlMlg + result.totalAccmlMlg}" />
						<tr>
							<td>${result.ordrDt}</td>
							<td class="text-right"><fmt:formatNumber value="${result.totalACnt}" pattern="###,###" /></td>
							<td class="text-right"><fmt:formatNumber value="${result.totalBCnt}" pattern="###,###" /></td>
							<td class="text-right"><fmt:formatNumber value="${result.totalBSum}" pattern="###,###" /></td>
							<td class="text-right"><fmt:formatNumber value="${result.totalMlgSum}" pattern="###,###" /></td>
							<td class="text-right"><fmt:formatNumber value="${result.totalStlmSum}" pattern="###,###" /></td>
							<td class="text-right"><fmt:formatNumber value="${result.totalAccmlMlg}" pattern="###,###" /></td>
						</tr>
					</c:forEach>

					<tr class="total">
						<td>합계</td>
						<td class="text-right"><fmt:formatNumber value="${totalACnt}" pattern="###,###" /></td>
						<td class="text-right"><fmt:formatNumber value="${totalACnt}" pattern="###,###" /></td>
						<td class="text-right"><fmt:formatNumber value="${totalBSum}" pattern="###,###" /></td>
						<td class="text-right"><fmt:formatNumber value="${totalMlgSum}" pattern="###,###" /></td>
						<td class="text-right"><fmt:formatNumber value="${totalStlmSum}" pattern="###,###" /></td>
						<td class="text-right"><fmt:formatNumber value="${totalAccmlMlg}" pattern="###,###" /></td>
					</tr>
				</c:if>
				<c:if test="${empty resultList}">
					<tr>
						<td class="noresult" colspan="7">검색조건을 만족하는 결과가 없습니다.</td>
					</tr>
				</c:if>
			</tbody>
		</table>
	</div>
</body>
</html>