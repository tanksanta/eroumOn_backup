<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ page import="org.egovframe.rte.fdl.string.EgovDateUtil" %>
<%@ page import="java.net.URLEncoder, java.io.UnsupportedEncodingException" %>
<%
	// 엑셀 파일 정보 얻기
	String header = request.getHeader("User-Agent");

	// 엑셀 파일명 설정
	String fileName = "멤버스_상담목록_"+EgovDateUtil.getCurrentDateAsString();
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
                        </colgroup>
                        <thead>
                            <tr>
                                <th scope="col">번호</th>
                                <th scope="col">상담진행상태</th>
                                <th scope="col">성명</th>
                                <th scope="col">성별</th>
                                <th scope="col">연락처</th>
                                <th scope="col">만나이</th>
                                <th scope="col">생년월일</th>
                                <th scope="col">거주지주소</th>
                                <th scope="col">상담배정일시</th>
                                <th scope="col">상담신청일</th>
                            </tr>
                        </thead>
                        <tbody>
						<c:forEach items="${resultList}" var="result" varStatus="status">
							<tr>
								<td>${status.index+1}</td>
								<td>
									<c:choose>
										<c:when test="${result.consltSttus eq 'CS01'}">상담 신청 접수</c:when>
										<c:when test="${result.consltSttus eq 'CS02'}">상담 신청 접수</c:when>
										<c:when test="${result.consltSttus eq 'CS03'}">상담 취소</c:when>
										<c:when test="${result.consltSttus eq 'CS04'}">상담 취소</c:when>
										<c:when test="${result.consltSttus eq 'CS09'}">상담 취소</c:when>
										<c:when test="${result.consltSttus eq 'CS05'}">상담 진행 중</c:when>
										<c:when test="${result.consltSttus eq 'CS06'}">상담 완료</c:when>
										<c:when test="${result.consltSttus eq 'CS07'}">상담 신청 접수</c:when>
										<c:when test="${result.consltSttus eq 'CS08'}">상담 신청 접수</c:when>
									</c:choose>
								</td>
								<td>${result.mbrConsltInfo.mbrNm}</td>

								<c:choose>
									<c:when test="${result.consltSttus eq 'CS03' || result.consltSttus eq 'CS04' || result.consltSttus eq 'CS09'}"><%--상담취소--%>
										<td>-</td>
										<td>-</td>
										<td>-</td>
										<td>-</td>
										<td>-</td>
										<td>-</td>
									</c:when>
									<c:otherwise>
										<td>${genderCode[result.mbrConsltInfo.gender]}</td>
										<td>${result.mbrConsltInfo.mbrTelno}</td>
										<td>만 ${result.mbrConsltInfo.age} 세</td>
										<td>${fn:substring(result.mbrConsltInfo.brdt,0,4)}/${fn:substring(result.mbrConsltInfo.brdt,4,6)}/${fn:substring(result.mbrConsltInfo.brdt,6,8)}</td>
										<td>(${result.mbrConsltInfo.zip})&nbsp;${result.mbrConsltInfo.addr}<br>${result.mbrConsltInfo.daddr}</td>
									</c:otherwise>
								</c:choose>
								<td><fmt:formatDate value="${result.regDt }" pattern="yyyy-MM-dd HH:mm" /></td>
								<td><fmt:formatDate value="${result.mbrConsltInfo.regDt }" pattern="yyyy-MM-dd HH:mm" /></td>
							</tr>
						</c:forEach>
						<c:if test="${fn:length(resultList) < 1}">
							<tr>
								<td style="height:50px; text-align:center; vertical-align:middle;" colspan="10">검색조건을 만족하는 결과가 없습니다.</td>
							</tr>
						</c:if>
						</tbody>
                    </table>
	</body>
</html>