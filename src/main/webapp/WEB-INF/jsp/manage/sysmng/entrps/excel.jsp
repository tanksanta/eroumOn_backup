<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page trimDirectiveWhitespaces="true"%>
<%@ page import="org.egovframe.rte.fdl.string.EgovDateUtil"%>
<%@ page import="java.net.URLEncoder, java.io.UnsupportedEncodingException"%>
<%
// 엑셀 파일 정보 얻기
String header = request.getHeader("User-Agent");

// 엑셀 파일명 설정
String fileName = "입점업체 목록_" + EgovDateUtil.getCurrentDateAsString();
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
			<col class="w-25">
			<col>
			<col class="w-30">
			<col class="w-40">
			<col class="w-30">
			<col class="w-40">
			<col class="w-25">
		</colgroup>
		<thead>
			<tr>
				<th scope="col">번호</th>
				<th scope="col">상호/법인명</th>
				<th scope="col">담당자</th>
				<th scope="col">사업자번호</th>
				<th scope="col">대표자</th>
				<th scope="col">등록일</th>
				<th scope="col">상태</th>
			</tr>
		</thead>
		<tbody>
			<c:forEach items="${entrpsList}" var="resultList" varStatus="status">
				<tr>
					<td>${status.index +1 }</td>
					<td>${resultList.entrpsNm}</td>
					<td>${resultList.picNm}</td>
					<td>${fn:substring(resultList.brno,0,3)}-${fn:substring(resultList.brno,3,5)}-${fn:substring(resultList.brno,5,10)}</td>
					<td>${resultList.rprsvNm}</td>
					<td><fmt:formatDate value="${resultList.regDt}" pattern="yyyy-MM-dd" /></td>
					<td>${useYn[resultList.useYn]}</td>
				</tr>
			</c:forEach>
			<c:if test="${empty entrpsList}">
				<tr>
					<td class="noresult" colspan="7">검색조건을 만족하는 결과가 없습니다.</td>
				</tr>
			</c:if>
		</tbody>
	</table>
</body>
</html>