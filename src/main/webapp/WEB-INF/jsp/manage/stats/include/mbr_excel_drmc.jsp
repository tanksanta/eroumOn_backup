<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ page import="org.egovframe.rte.fdl.string.EgovDateUtil" %>
<%@ page import="java.net.URLEncoder, java.io.UnsupportedEncodingException" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
	// 엑셀 파일 정보 얻기
	String header = request.getHeader("User-Agent");

	// 엑셀 파일명 설정
	String fileName = "휴면회원_현황_"+EgovDateUtil.getCurrentDateAsString();
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
		<p>현재 휴면회원 누계</p>
			<table class="table-list">
			<colgroup>
				<col>
				<col>
				<col>
			</colgroup>
			<thead>
				<tr>
					<th scope="col">전체</th>
					<th scope="col">휴면 회원</th>
					<th scope="col">전환 예상</th>
				</tr>
			</thead>
			<tbody>
				<tr>
					<td><fmt:formatNumber value="${resultMap.drmcTotal + resultMap.drmcEx}" pattern="###,###" /></td>
					<td><fmt:formatNumber value="${resultMap.drmcTotal}" pattern="###,###" /></td>
					<td><fmt:formatNumber value="${resultMap.drmcEx}" pattern="###,###" /></td>
				</tr>
			</tbody>
		</table>

		<p class="text-title2 mt-13">조회결과</p>
		<div class="scroll-table">
			<table class="table-list">
				<colgroup>
					<col class="min-w-35 w-35">
					<col>
					<col>
				</colgroup>
				<thead>
					<tr>
						<th scope="col">기간</th>
						<th scope="col">휴면회원 전환 수</th>
						<th scope="col">전환예상 수</th>
					</tr>
				</thead>
				<tbody>
					<c:if test="${empty resultList}">
						<tr>
							<td class="noresult" colspan="3">검색조건을 선택 하신 후, 검색해 주세요.</td>
						</tr>
					</c:if>

					<c:set var="sumDrmc" value="0" />
					<c:set var="sumWdrmc" value="0" />

					<c:forEach var="result" items="${resultList}">
						<c:set var="sumDrmc" value="${sumDrmc + result.drmc}" />
						<c:set var="sumWdrmc" value="${sumWdrmc +result.wdrmc}" />

						<tr>
						<c:if test="${fn:length(result.date) eq 10 }">
							<fmt:parseDate value="${fn:replace(result.date,'-','')}" var="fmtDate" pattern="yyyyMMdd" />
						</c:if>
						<c:if test="${fn:length(result.date) eq 7 }">
							<fmt:parseDate value="${fn:replace(result.date,'-','')}" var="fmtDate" pattern="yyyyMM" />
						</c:if>
						<c:if test="${fn:length(result.date) eq 4 }">
							<fmt:parseDate value="${fn:replace(result.date,'-','')}" var="fmtDate" pattern="yyyy" />
						</c:if>
						<td><c:if test="${fn:length(result.date) eq 10 }">
								<fmt:formatDate value="${fmtDate}" pattern="yyyy-MM-dd" />
							</c:if> <c:if test="${fn:length(result.date) eq 7 }">
								<fmt:formatDate value="${fmtDate}" pattern="yyyy-MM" />
							</c:if> <c:if test="${fn:length(result.date) eq 4 }">
								<fmt:formatDate value="${fmtDate}" pattern="yyyy" />
							</c:if></td>
						<td><fmt:formatNumber value="${result.drmc}" pattern="###,###" /></td>
							<td><fmt:formatNumber value="${result.wdrmc}" pattern="###,###" /></td>
						</tr>

					</c:forEach>

					<tr class="total">
						<td>합계</td>
						<td><fmt:formatNumber value="${sumDrmc}" pattern="###,###" /></td>
						<td><fmt:formatNumber value="${sumWdrmc}" pattern="###,###" /></td>
					</tr>
				</tbody>
			</table>
		</div>
	</body>
</html>