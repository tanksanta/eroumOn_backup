<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ page import="org.egovframe.rte.fdl.string.EgovDateUtil" %>
<%@ page import="java.net.URLEncoder, java.io.UnsupportedEncodingException" %>
<%
	// 엑셀 파일 정보 얻기
	String header = request.getHeader("User-Agent");

	// 엑셀 파일명 설정
	String fileName = "상품재고 관리목록_"+EgovDateUtil.getCurrentDateAsString();
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
	<table class="table-list">
		<colgroup>
			<col class="w-20">
			<col class="w-80">
			<col class="w-30">
			<col class="w-15">
			<col class="w-15">
			<col class="w-15">
			<col class="w-15">
		</colgroup>
		<thead>
			<tr>
				<th scope="col">상품구분</th>
				<th scope="col">상품명</th>
				<th scope="col">옵션항목</th>
				<th scope="col">판매가</th>
				<th scope="col">급여가</th>
				<th scope="col">재고 수량</th>
				<th scope="col">판매 여부</th>
			</tr>
		</thead>
		<tbody>
			<c:forEach var="resultList" items="${itemList}" varStatus="status">
			<tr>
				<td>${gdsTyCode[resultList.gdsTy]}</td>
				<td>${resultList.gdsNm}</td>
				<td>
					<c:set var="listOptns" value="${fn:split(fn:replace(resultList.optnNm,' ',''),'*')}" />
					${listOptns[fn:length(listOptns)-1]}
				</td>
				<td><fmt:formatNumber value="${resultList.pc}" pattern="###,###" /></td>
				<td><fmt:formatNumber value="${resultList.bnefPc}" pattern="###,###" /></td>
				<td class="qy">
					<c:choose>
						<c:when test="${resultList.optnTy ne null}"><fmt:formatNumber value="${resultList.optnStockQy}" pattern="###,###"/></c:when>
						<c:otherwise><fmt:formatNumber value="${resultList.stockQy}" pattern="###,###"/></c:otherwise>
					</c:choose>
				</td>
				<td class="yn">
					<c:choose>
						<c:when test="${resultList.optnTy eq null}">
							${dspyYnCode[resultList.dspyYn]}
						</c:when>
						<c:otherwise>
							${useYnCode[resultList.useYn]}
						</c:otherwise>
					</c:choose>
				</td>
			</tr>
			</c:forEach>
			<c:if test="${fn:length(itemList) < 1}">
				<td colspan="8" style="height:50px; text-align:center; vertical-align:middle;">데이터가 없습니다.</td>
			</c:if>
		</tbody>
	</table>
	</body>
</html>