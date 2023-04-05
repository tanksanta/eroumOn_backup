<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page trimDirectiveWhitespaces="true"%>
<%@ page import="org.egovframe.rte.fdl.string.EgovDateUtil"%>
<%@ page import="java.net.URLEncoder, java.io.UnsupportedEncodingException"%>
<%
// 엑셀 파일 정보 얻기
String header = request.getHeader("User-Agent");

// 엑셀 파일명 설정
String fileName = "회원목록_" + EgovDateUtil.getCurrentDateAsString();
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
	<table class="table-list">
		<colgroup>
			<col class="w-20">
			<col class="w-30">
			<col class="w-28">
			<col class="w-20">
			<col class="w-28">
			<col>
			<col class="w-28">
			<col class="w-25">
		</colgroup>
		<thead>
			<tr>
				<th scope="col">번호</th>
				<th scope="col">아이디</th>
				<th scope="col">회원이름</th>
				<th scope="col">성별</th>
				<th scope="col">생년월일</th>
				<th scope="col">회원분류(회원등급)</th>
				<th scope="col">가입일</th>
				<th scope="col">가입매체</th>
			</tr>
		</thead>
		<tbody>
			<c:forEach var="resultList" items="${mbrList}" varStatus="status">
				<tr>
					<td>${status.index+1}</td>
					<td>${resultList.mbrId}</td>
					<td>${resultList.mbrNm }</td>
					<td>${gender[resultList.gender]}</td>
					<td><fmt:formatDate value="${resultList.brdt}" pattern="yyyy-MM-dd" /></td>
					<td class="cateVal${status.index}">${recipterYn[resultList.recipterYn] }<span class="badge-primary ml-2 gradeVal">${grade[resultList.mberGrade]}</span></td>
					<td><fmt:formatDate value="${resultList.joinDt}" pattern="yyyy-MM-dd" /></td>
					<td>${resultList.joinCours}</td>
				</tr>
			</c:forEach>
			<c:if test="${empty mbrList}">
				<tr>
					<td class="noresult" colspan="8">검색조건을 만족하는 결과가 없습니다.</td>
				</tr>
			</c:if>

		</tbody>
	</table>
</body>
</html>