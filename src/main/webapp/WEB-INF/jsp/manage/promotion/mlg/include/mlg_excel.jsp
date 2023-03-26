<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ page import="org.egovframe.rte.fdl.string.EgovDateUtil" %>
<%@ page import="java.net.URLEncoder, java.io.UnsupportedEncodingException" %>
<%
	// 엑셀 파일 정보 얻기
	String header = request.getHeader("User-Agent");

	// 엑셀 파일명 설정
	String fileName = "마일리지 목록_"+EgovDateUtil.getCurrentDateAsString();
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
				<th scope="col">구분</th>
				<th scope="col">내역</th>
				<th scope="col">관리자 메모</th>
				<th scope="col">개별 포인트</th>
				<th scope="col">대상 인원수</th>
				<th scope="col">총 포인트</th>
				<th scope="col">처리자</th>
				<th scope="col">처리일</th>
			</tr>
		</thead>
			<tbody>
				<c:forEach items="${itemList}" var="result" varStatus="status">
					<tr>
					<td>${status.index +1}</td>
					<td>${result.mlgSe eq 'A'?'적립':'차감'}</td>
					<td>${pointCnCode[result.mlgCn]}</td>
					<td>${result.mngrMemo}</td>
					<td>${result.mlg}</td>
					<td><fmt:formatNumber value="${result.targetCnt}" pattern="###,###" /></td>
					<td><fmt:formatNumber value="${result.mlg * result.targetCnt}" pattern="###,###" /></td>
					<td>${result.rgtr}</br>(${result.regId})
					</td>
					<td><fmt:formatDate value="${result.regDt}" pattern="yyyy-MM-dd" /></td>
				</tr>
				</c:forEach>
				<c:if test="${fn:length(itemList) < 1 }">
					<tr>
						<td colspan="2" style="height: 50px; text-align: center; vertical-align: middle;">데이터가 없습니다.</td>
					</tr>
				</c:if>
			</tbody>
		</table>
	</body>
</html>