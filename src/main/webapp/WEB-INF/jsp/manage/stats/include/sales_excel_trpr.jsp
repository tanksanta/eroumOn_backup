<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page trimDirectiveWhitespaces="true"%>
<%@ page import="org.egovframe.rte.fdl.string.EgovDateUtil"%>
<%@ page import="java.net.URLEncoder, java.io.UnsupportedEncodingException"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
	// 엑셀 파일 정보 얻기
	String header = request.getHeader("User-Agent");

	// 엑셀 파일명 설정
	String fileName = "성별연령별_"+EgovDateUtil.getCurrentDateAsString();
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
				<col class="min-w-20">
				<col class="min-w-20">
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
					<th scope="col">성별</th>
					<th scope="col">연령대</th>
					<th scope="col">고객수</th>
					<th scope="col">주문건수</th>
					<th scope="col">주문실적</th>
					<th scope="col">매출건수</th>
					<th scope="col">매출실적</th>
					<th scope="col">상품단가</th>
					<th scope="col">주문단가</th>
				</tr>
			</thead>
			<tbody>
				<c:if test="${!empty resultList}">
					<c:set var="totalACnt" value="0" />
					<c:set var="totalBCnt" value="0" />
					<c:set var="totalCCnt" value="0" />
					<c:set var="totalCaCnt" value="0" />
					<c:set var="totalReCnt" value="0" />

					<c:set var="totalASum" value="0" />
					<c:set var="totalBSum" value="0" />
					<c:set var="totalCSum" value="0" />
					<c:set var="totalCaSum" value="0" />
					<c:set var="totalReSum" value="0" />

					<c:set var="totalBuyerCnt" value="0" />

					<c:forEach items="${resultList}" var="result" varStatus="status">
						<c:set var="totalACnt" value="${totalACnt + result.totalACnt}" />
						<c:set var="totalBCnt" value="${totalBCnt + result.totalBCnt}" />
						<c:set var="totalCCnt" value="${totalCCnt + result.totalCCnt}" />
						<c:set var="totalASum" value="${totalASum + result.totalASum}" />
						<c:set var="totalBSum" value="${totalBSum + result.totalBSum}" />
						<c:set var="totalCSum" value="${totalCSum + result.totalCSum}" />

						<c:set var="totalCaCnt" value="${totalCaCnt + result.totalCaCnt}" />
						<c:set var="totalCaSum" value="${totalCaSum + result.totalCaSum}" />
						<c:set var="totalReCnt" value="${totalReCnt + result.totalReCnt}" />
						<c:set var="totalReSum" value="${totalReSum + result.totalReSum}" />

						<c:set var="totalBuyerCnt" value="${totalBuyerCnt + result.buyerCnt }" />

						<tr>
							<td class="border-right ${result.gender}">${genderCode[result.gender]}</td>
							<td class="text-right">${result.ageGrp}</td>
							<td class="text-right"><fmt:formatNumber value="${result.buyerCnt}" pattern="###,###" /></td>
							<td class="text-right"><fmt:formatNumber value="${result.totalACnt}" pattern="###,###" /></td>
							<td class="text-right"><fmt:formatNumber value="${result.totalASum}" pattern="###,###" /></td>
							<td class="text-right"><fmt:formatNumber value="${result.totalCCnt}" pattern="###,###" /></td>
							<td class="text-right"><fmt:formatNumber value="${result.totalCSum}" pattern="###,###" /></td>
							<td class="text-right"><fmt:formatNumber value="${result.totalCSum / result.totalOrdrQy}" pattern="###,###" /></td>
							<td class="text-right"><fmt:formatNumber value="${result.totalCSum / result.totalACnt}" pattern="###,###" /></td>
						</tr>
					</c:forEach>
					<tr class="total">
						<td colspan="2">소계</td>
						<td class="text-right"><fmt:formatNumber value="${totalBuyerCnt}" pattern="###,###" /></td>
						<td class="text-right"><fmt:formatNumber value="${totalACnt}" pattern="###,###" /></td>
						<td class="text-right"><fmt:formatNumber value="${totalASum}" pattern="###,###" /></td>
						<td class="text-right"><fmt:formatNumber value="${totalCCnt}" pattern="###,###" /></td>
						<td class="text-right"><fmt:formatNumber value="${totalCSum}" pattern="###,###" /></td>
						<td class="text-right">-</td>
						<td class="text-right">-</td>
					</tr>
				</c:if>
				<c:if test="${empty resultList}">
					<tr>
						<td class="noresult" colspan="9">검색조건을 만족하는 결과가 없습니다.</td>
					</tr>
				</c:if>
			</tbody>
		</table>
	</div>
</body>
</html>