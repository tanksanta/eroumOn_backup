<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ page import="org.egovframe.rte.fdl.string.EgovDateUtil" %>
<%@ page import="java.net.URLEncoder, java.io.UnsupportedEncodingException" %>
<%
	// 엑셀 파일 정보 얻기
	String header = request.getHeader("User-Agent");

	// 엑셀 파일명 설정
	String fileName = "응모자 명단_"+EgovDateUtil.getCurrentDateAsString();
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
					<th scope="col">번호</th>
					<th scope="col">아이디</th>
					<th scope="col">회원 이름</th>
					<th scope="col">휴대폰 번호</th>
					<th scope="col">답변</th>
					<th scope="col">IP</th>
					<th scope="col">응모일</th>
				</tr>
			</thead>
			<tbody>
				<c:forEach items="${itemList}" var="result" varStatus="status">
					<tr>
						<td>${status.index +1}</td>
						<td>${result.applctId}</td>
						<td>${result.applctNm}</td>
						<td>${result.applctTelno}</td>
						<td>${result.chcIemCn}</td>
						<td>${result.ip}</td>
						<td><fmt:formatDate value="${result.applctDt}" pattern="yyyy-MM-dd" /></td>
					</tr>
				</c:forEach>
				<c:if test="${fn:length(itemList) < 1 }">
					<tr>
						<td colspan="7" style="height: 50px; text-align: center; vertical-align: middle;">데이터가 없습니다.</td>
					</tr>
				</c:if>
			</tbody>
		</table>
	</body>
</html>