<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page trimDirectiveWhitespaces="true"%>
<%@ page import="org.egovframe.rte.fdl.string.EgovDateUtil"%>
<%@ page import="java.net.URLEncoder, java.io.UnsupportedEncodingException"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
	// 엑셀 파일 정보 얻기
	String header = request.getHeader("User-Agent");

	// 엑셀 파일명 설정
	String fileName = "결제수단별_"+EgovDateUtil.getCurrentDateAsString();
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
				<col class="min-w-25">
				<col class="min-w-25">
			</colgroup>
			<thead>
				<tr>
					<th scope="col" rowspan="2">일자</th>
					<th scope="colgroup" colspan="2">판매실적</th>
					<th scope="colgroup" colspan="2">신용카드</th>
					<th scope="colgroup" colspan="2">실시간계좌이체</th>
					<th scope="colgroup" colspan="2">가상계좌(무통장)</th>
					<th scope="colgroup" colspan="2">마일리지</th>
					<th scope="colgroup" colspan="2">포인트</th>
					<th scope="colgroup" colspan="2">매출실적</th>
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
					<th scope="col">건수</th>
					<th scope="col">금액</th>
					<th scope="col">건수</th>
					<th scope="col">금액</th>
				</tr>
			</thead>
			<tbody>

				<c:if test="${!empty resultList}">
					<c:set var="totalBCnt" value="0" />
					<c:set var="totalCCnt" value="0" />
					<c:set var="totalCardCnt" value="0" />
					<c:set var="totalVbankCnt" value="0" />
					<c:set var="totalBankCnt" value="0" />
					<c:set var="totalMlgCnt" value="0" />
					<c:set var="totalPointCnt" value="0" />

					<c:set var="totalBSum" value="0" />
					<c:set var="totalCSum" value="0" />
					<c:set var="totalCardSum" value="0" />
					<c:set var="totalVbankSum" value="0" />
					<c:set var="totalBankSum" value="0" />
					<c:set var="totalMlgSum" value="0" />
					<c:set var="totalPointSum" value="0" />

					<c:forEach items="${resultList}" var="result" varStatus="status">
						<c:set var="totalBCnt" value="${totalBCnt + result.totalBCnt}" />
						<c:set var="totalCCnt" value="${totalCCnt + result.totalCCnt}" />
						<c:set var="totalBSum" value="${totalBSum + result.totalBSum}" />
						<c:set var="totalCSum" value="${totalCSum + result.totalCSum}" />

						<c:set var="totalCardCnt" value="${totalCardCnt + result.totalCardCnt}" />
						<c:set var="totalCardSum" value="${totalCardSum + result.totalCardSum}" />
						<c:set var="totalVbankCnt" value="${totalVbankCnt + result.totalVbankCnt}" />
						<c:set var="totalVbankSum" value="${totalVbankSum + result.totalVbankSum}" />
						<c:set var="totalBankCnt" value="${totalBankCnt + result.totalBankCnt}" />
						<c:set var="totalBankSum" value="${totalBankSum + result.totalBankSum}" />
						<c:set var="totalMlgCnt" value="${totalMlgCnt + result.totalMlgCnt}" />
						<c:set var="totalMlgSum" value="${totalMlgSum + result.totalMlgSum}" />
						<c:set var="totalPointCnt" value="${totalPointCnt + result.totalPointCnt}" />
						<c:set var="totalPointSum" value="${totalPointSum + result.totalPointSum}" />
						<tr>
							<td>${result.ordrDt}</td>
							<td class="text-right"><fmt:formatNumber value="${result.totalBCnt}" pattern="###,###" /></td>
							<td class="text-right"><fmt:formatNumber value="${result.totalBSum}" pattern="###,###" /></td>
							<td class="text-right"><fmt:formatNumber value="${result.totalCardCnt}" pattern="###,###" /></td>
							<td class="text-right"><fmt:formatNumber value="${result.totalCardSum}" pattern="###,###" /></td>
							<td class="text-right"><fmt:formatNumber value="${result.totalVbankCnt}" pattern="###,###" /></td>
							<td class="text-right"><fmt:formatNumber value="${result.totalVbankSum}" pattern="###,###" /></td>
							<td class="text-right"><fmt:formatNumber value="${result.totalBankCnt}" pattern="###,###" /></td>
							<td class="text-right"><fmt:formatNumber value="${result.totalBankSum}" pattern="###,###" /></td>
							<td class="text-right"><fmt:formatNumber value="${result.totalMlgCnt}" pattern="###,###" /></td>
							<td class="text-right"><fmt:formatNumber value="${result.totalMlgSum}" pattern="###,###" /></td>
							<td class="text-right"><fmt:formatNumber value="${result.totalPointCnt}" pattern="###,###" /></td>
							<td class="text-right"><fmt:formatNumber value="${result.totalPointSum}" pattern="###,###" /></td>
							<td class="text-right"><fmt:formatNumber value="${result.totalCCnt}" pattern="###,###" /></td>
							<td class="text-right"><fmt:formatNumber value="${result.totalCSum}" pattern="###,###" /></td>
						</tr>
					</c:forEach>

					<tr class="total">
						<td>합계</td>
						<td class="text-right"><fmt:formatNumber value="${totalBCnt}" pattern="###,###" /></td>
						<td class="text-right"><fmt:formatNumber value="${totalBSum}" pattern="###,###" /></td>
						<td class="text-right"><fmt:formatNumber value="${totalCardCnt}" pattern="###,###" /></td>
						<td class="text-right"><fmt:formatNumber value="${totalCardSum}" pattern="###,###" /></td>
						<td class="text-right"><fmt:formatNumber value="${totalVbankCnt}" pattern="###,###" /></td>
						<td class="text-right"><fmt:formatNumber value="${totalVbankSum}" pattern="###,###" /></td>
						<td class="text-right"><fmt:formatNumber value="${totalBankCnt}" pattern="###,###" /></td>
						<td class="text-right"><fmt:formatNumber value="${totalBankSum}" pattern="###,###" /></td>
						<td class="text-right"><fmt:formatNumber value="${totalMlgCnt}" pattern="###,###" /></td>
						<td class="text-right"><fmt:formatNumber value="${totalMlgSum}" pattern="###,###" /></td>
						<td class="text-right"><fmt:formatNumber value="${totalPointCnt}" pattern="###,###" /></td>
						<td class="text-right"><fmt:formatNumber value="${totalPointSum}" pattern="###,###" /></td>
						<td class="text-right"><fmt:formatNumber value="${totalCCnt}" pattern="###,###" /></td>
						<td class="text-right"><fmt:formatNumber value="${totalCSum}" pattern="###,###" /></td>
					</tr>
				</c:if>

				<c:if test="${empty resultList}">
					<tr>
						<td class="noresult" colspan="15">검색조건을 만족하는 결과가 없습니다.</td>
					</tr>
				</c:if>

			</tbody>
		</table>
	</div>
</body>
</html>