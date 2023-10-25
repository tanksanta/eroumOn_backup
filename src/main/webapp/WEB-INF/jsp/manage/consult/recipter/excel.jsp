<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ page import="org.egovframe.rte.fdl.string.EgovDateUtil" %>
<%@ page import="java.net.URLEncoder, java.io.UnsupportedEncodingException" %>
<%
	// 엑셀 파일 정보 얻기
	String header = request.getHeader("User-Agent");

	// 엑셀 파일명 설정
	String fileName = "장기요양테스트_상담목록_"+EgovDateUtil.getCurrentDateAsString();
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
		<colgroup>
			 <col>
             <col>
             <col>
             <col>
             <col>
             <col>
             <col>
             <col>
             <col>
             <col>
		</colgroup>
		<thead>
			<tr>
				<th scope="col">번호</th>
				<th scope="col">상담진행상태</th>
				<th scope="col">사업소배정</th>
				<th scope="col">수급자 성명</th>
				<!--th scope="col">성별</th-->
				<th scope="col">상담받을 연락처</th>
				<!--th scope="col">만나이</th-->
				<!--th scope="col">생년월일</th-->
				<th scope="col">실거주지주소</th>
				<th scope="col">상담유형</th>
				<th scope="col">상담신청일</th>
				<th scope="col">회원이름</th>
				<th scope="col">회원아이디</th>
			</tr>
		</thead>
		<tbody>
		<c:forEach var="result" items="${resultList}" varStatus="status">
			<tr>
				<td>${status.index + 1}</td>
				<td>
					<c:choose>
						<c:when test="${result.consltSttus eq 'CS01'}">상담 신청 접수</c:when>
						<c:when test="${result.consltSttus eq 'CS02'}">장기요양기관 배정 완료</c:when>
						<c:when test="${result.consltSttus eq 'CS03'}">상담 취소 (신청자 상담거부)</c:when>
						<c:when test="${result.consltSttus eq 'CS04'}">상담 취소 (장기요양기관 상담거부)</c:when>
						<c:when test="${result.consltSttus eq 'CS05'}">상담 진행 중</c:when>
						<c:when test="${result.consltSttus eq 'CS06'}">상담 완료</c:when>
						<c:when test="${result.consltSttus eq 'CS07'}">재상담 신청 접수</c:when>
						<c:when test="${result.consltSttus eq 'CS08'}">장기요양기관 재배정 완료</c:when>
					</c:choose>
				</td>
				<td>
					<c:if test="${result.consltSttus ne 'CS01'}">
					<c:forEach items="${result.consltResultList}" var="consltResult" varStatus="status2">
					${status2.index+1}차 : ${consltResult.bplcNm } (<fmt:formatDate value="${consltResult.regDt }" pattern="yyyy-MM-dd HH:mm" />)<br>
					</c:forEach>
					</c:if>
					<c:if test="${result.consltSttus eq 'CS01' || empty result.consltSttus}">
					-
					</c:if>
				</td>
				<td>${result.mbrNm}</td>
				<!--td>${genderCode[result.gender]}</td-->
				<td>${result.mbrTelno}</td>
				<!--td>만 ${result.age} 세</td-->
				<!--td>${fn:substring(result.brdt,0,4)}/${fn:substring(result.brdt,4,6)}/${fn:substring(result.brdt,6,8)}</td-->
				<td>${result.zip}&nbsp;${result.addr}&nbsp;${result.daddr}</td>
				<td>${prevPath[result.prevPath]}</td>
				<td>
					<fmt:formatDate value="${result.regDt }" pattern="yyyy-MM-dd" />
					<c:if test="${result.consltSttus eq 'CS07' || result.consltSttus eq 'CS08'}">
					<br>(<fmt:formatDate value="${result.reConsltDt }" pattern="yyyy-MM-dd" />)
					</c:if>
				</td>
				<td>${result.rgtr }</td>
				<td>${result.regId }</td>
			</tr>
		</c:forEach>
		<c:if test="${fn:length(resultList) < 1}">
			<tr>
				<td style="height:50px; text-align:center; vertical-align:middle;"  colspan="11">검색조건을 만족하는 결과가 없습니다.</td>
			</tr>
		</c:if>
		</tbody>
	</table>
</body>
</html>