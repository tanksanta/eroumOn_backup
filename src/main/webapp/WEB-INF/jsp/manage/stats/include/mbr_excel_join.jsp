<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ page import="org.egovframe.rte.fdl.string.EgovDateUtil" %>
<%@ page import="java.net.URLEncoder, java.io.UnsupportedEncodingException" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
	// 엑셀 파일 정보 얻기
	String header = request.getHeader("User-Agent");

	// 엑셀 파일명 설정
	String fileName = "회원가입탈퇴_현황_"+EgovDateUtil.getCurrentDateAsString();
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
		<p>현재 회원 누계</p>
			<table class="table-list">
			<colgroup>
				<col>
				<col>
				<col>
			</colgroup>
			<thead>
				<tr>
					<th scope="col">일반 회원</th>
					<th scope="col">수급자 회원</th>
					<th scope="col">전체</th>
				</tr>
			</thead>
			<tbody>
				<tr>
					<td><fmt:formatNumber value="${resultMap.normal}" pattern="###,###" /></td>
					<td><fmt:formatNumber value="${resultMap.recipter}" pattern="###,###" /></td>
					<td><fmt:formatNumber value="${resultMap.total}" pattern="###,###" /></td>
			</tr>
			</tbody>
		</table>

		<p>조회 결과</p>
		<table class="table-list">
			<colgroup>
				<col class="min-w-35 w-35">
				<col class="min-w-25">
				<col class="min-w-25">
				<col class="min-w-25">
				<col class="min-w-25">
				<col class="min-w-25">
				<col class="min-w-25">
			</colgroup>
			<thead>
				<tr>
					<th scope="col" rowspan="2">기간</th>
					<th scope="colgroup" colspan="2">일반 회원</th>
					<th scope="colgroup" colspan="2">수급자 회원</th>
					<th scope="colgroup" colspan="2">전체</th>
				</tr>
				<tr>
					<th scope="col">가입</th>
					<th scope="col">탈퇴</th>
					<th scope="col">가입</th>
					<th scope="col">탈퇴</th>
					<th scope="col">가입</th>
					<th scope="col">탈퇴</th>
				</tr>
			</thead>
			<tbody>
				<c:if test="${empty resultList}">
					<tr>
						<td class="noresult" colspan="7">검색조건을 만족하는 결과가 없습니다.</td>
					</tr>
				</c:if>

					<c:set var="sumNjoin" value="0" />
					<c:set var="sumNexit" value="0" />
					<c:set var="sumRjoin" value="0" />
					<c:set var="sumRexit" value="0" />
					<c:set var="sumJtotal" value="0" />
					<c:set var="sumEtotal" value="0" />

				<c:forEach var="result" items="${resultList}">
					<c:set var="sumNjoin" value="${sumTotal + result.njoin}" />
					<c:set var="sumNexit" value="${sumMnChild +result.nexit}" />
					<c:set var="sumRjoin" value="${sumMnTwenty + result.rjoin}" />
					<c:set var="sumRexit" value="${sumMnThirty + result.rexit}" />
					<c:set var="sumJtotal" value="${sumMnForty + result.jtotal}" />
					<c:set var="sumEtotal" value="${sumMnFifty + result.etotal}" />
					<tr>
						<c:if test="${fn:length(result.date) eq 10 }"><fmt:parseDate value="${fn:replace(result.date,'-','')}" var="fmtDate" pattern="yyyyMMdd" /></c:if>
						<c:if test="${fn:length(result.date) eq 7 }"><fmt:parseDate value="${fn:replace(result.date,'-','')}" var="fmtDate" pattern="yyyyMM" /></c:if>
						<c:if test="${fn:length(result.date) eq 4 }"><fmt:parseDate value="${fn:replace(result.date,'-','')}" var="fmtDate" pattern="yyyy" /></c:if>
						<td>
							<c:if test="${fn:length(result.date) eq 10 }"><fmt:formatDate value="${fmtDate}" pattern="yyyy-MM-dd" /></c:if>
							<c:if test="${fn:length(result.date) eq 7 }"><fmt:formatDate value="${fmtDate}" pattern="yyyy-MM" /></c:if>
							<c:if test="${fn:length(result.date) eq 4 }"><fmt:formatDate value="${fmtDate}" pattern="yyyy" /></c:if>
						</td>
						<td class="text-right"><fmt:formatNumber value="${result.njoin}" pattern="###,###" /></td>
						<td class="text-right"><fmt:formatNumber value="${result.nexit}" pattern="###,###" /></td>
						<td class="text-right"><fmt:formatNumber value="${result.rjoin}" pattern="###,###" /></td>
						<td class="text-right"><fmt:formatNumber value="${result.rexit}" pattern="###,###" /></td>
						<td class="text-right"><fmt:formatNumber value="${result.jtotal}" pattern="###,###" /></td>
						<td class="text-right"><fmt:formatNumber value="${result.etotal}" pattern="###,###" /></td>
					</tr>
				</c:forEach>

				<tr class="total">
						<td>합계</td>
						<td class="text-right"><fmt:formatNumber value="${sumNjoin}" pattern="###,###" /></td>
						<td class="text-right"><fmt:formatNumber value="${sumNexit}" pattern="###,###" /></td>
						<td class="text-right"><fmt:formatNumber value="${sumRjoin}" pattern="###,###" /></td>
						<td class="text-right"><fmt:formatNumber value="${sumRexit}" pattern="###,###" /></td>
						<td class="text-right"><fmt:formatNumber value="${sumJtotal}" pattern="###,###" /></td>
						<td class="text-right"><fmt:formatNumber value="${sumEtotal}" pattern="###,###" /></td>
					</tr>

			</tbody>
		</table>
	</body>
</html>