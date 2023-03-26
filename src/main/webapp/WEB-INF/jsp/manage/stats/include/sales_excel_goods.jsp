<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page trimDirectiveWhitespaces="true"%>
<%@ page import="org.egovframe.rte.fdl.string.EgovDateUtil"%>
<%@ page import="java.net.URLEncoder, java.io.UnsupportedEncodingException"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
	// 엑셀 파일 정보 얻기
	String header = request.getHeader("User-Agent");

	// 엑셀 파일명 설정
	String fileName = "판매상품_"+EgovDateUtil.getCurrentDateAsString();
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
				<col class="min-w-25 w-25">
				<col class="min-w-40">
				<col class="min-w-60">
				<col class="min-w-25">
				<col class="min-w-25">
				<col class="min-w-25">
				<col class="min-w-25">
				<col class="min-w-25">
				<col class="min-w-25">
				<col class="min-w-25">
				<col class="min-w-25">
				<col class="min-w-25">
				<col class="min-w-25">
			</colgroup>
			<thead>
				<tr>
					<th scope="col" rowspan="2">판매순위</th>
					<th scope="col" rowspan="2">상품코드</th>
					<th scope="col" rowspan="2">상품명</th>
					<th scope="colgroup" colspan="2">주문</th>
					<th scope="colgroup" colspan="2">취소</th>
					<th scope="colgroup" colspan="2">판매</th>
					<th scope="colgroup" colspan="2">반품</th>
					<th scope="colgroup" colspan="2">매출</th>
				</tr>
				<tr>
					<th scope="col">건수</th>
					<th scope="col">금액</th>
					<th scope="col">건수</th>
					<th scope="col">금액</th>
					<th scope="col">건수</th>
					<th scope="col">금액</th>
					<th scope="col">건수</th>
					<th scope="col">금액</th>
					<th scope="col">건수</th>
					<th scope="col">금액</th>
				</tr>
			</thead>
			<tbody>
				<c:forEach items="${resultList}" var="result" varStatus="status">
					<tr>
						<td>${status.index + 1}</td>
						<td>${result.gdsCd}</td>
						<td class="text-left">${result.gdsNm}</td>
						<td class="text-right"><fmt:formatNumber value="${result.totalACnt}" pattern="###,###" /></td>
						<td class="text-right"><fmt:formatNumber value="${result.totalASum}" pattern="###,###" /></td>
						<td class="text-right"><fmt:formatNumber value="${result.totalCaCnt}" pattern="###,###" /></td>
						<td class="text-right"><fmt:formatNumber value="${result.totalCaSum}" pattern="###,###" /></td>
						<td class="text-right"><fmt:formatNumber value="${result.totalBCnt}" pattern="###,###" /></td>
						<td class="text-right"><fmt:formatNumber value="${result.totalBSum}" pattern="###,###" /></td>
						<td class="text-right"><fmt:formatNumber value="${result.totalReCnt}" pattern="###,###" /></td>
						<td class="text-right"><fmt:formatNumber value="${result.totalReSum}" pattern="###,###" /></td>
						<td class="text-right"><fmt:formatNumber value="${result.totalCCnt}" pattern="###,###" /></td>
						<td class="text-right"><fmt:formatNumber value="${result.totalCSum}" pattern="###,###" /></td>
					</tr>
				</c:forEach>
				<c:if test="${empty resultList}">
					<tr>
						<td class="noresult" colspan="13">검색조건을 만족하는 결과가 없습니다.</td>
					</tr>
				</c:if>
			</tbody>
		</table>
	</div>
</body>
</html>