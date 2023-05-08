<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page trimDirectiveWhitespaces="true"%>
<%@ page import="org.egovframe.rte.fdl.string.EgovDateUtil"%>
<%@ page import="java.net.URLEncoder, java.io.UnsupportedEncodingException"%>
<%
// 엑셀 파일 정보 얻기
String header = request.getHeader("User-Agent");

// 엑셀 파일명 설정
String fileName = "멤버스 주문목록_" + EgovDateUtil.getCurrentDateAsString();
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
			<col class="min-w-28">
			<col class="min-w-25 w-25">
			<col class="min-w-23 w-23">
			<col class="min-w-23 w-23">
			<col class="min-w-20 w-20">
			<col class="min-w-30">
			<col class="min-w-30 w-30">
			<col class="min-w-20 w-20">
			<col class="min-w-25 w-25">
			<col class="min-w-25 w-25">
			<col class="min-w-25 w-25">
			<col class="min-w-25 w-25">
			<col class="min-w-25 w-25">
			<col class="min-w-30 w-30">
			<col class="min-w-30 w-30">
			<col class="min-w-32">
			<col class="min-w-32 w-30">
		</colgroup>
		<thead>
			<tr>
				<th scope="col" rowspan="2">주문일시</th>
				<th scope="col" rowspan="2">주문자</th>
				<th scope="col" rowspan="2">수령인</th>
				<th scope="col" rowspan="2">상품구분</th>
				<%-- loop area S --%>
				<th scope="col" rowspan="2">상품번호</th>
				<th scope="col" rowspan="2">상품명/옵션</th>
				<th scope="col" rowspan="2">상품가격</th>
				<th scope="col" rowspan="2">수량</th>
				<th scope="col" rowspan="2">주문금액</th>
				<th scope="colgroup" colspan="3">할인금액</th>
				<%-- loop area E --%>
				<th scope="col" rowspan="2">배송비</th>
				<th scope="col" rowspan="2">결제금액</th>
				<th scope="col" rowspan="2">결제수단</th>
				<th scope="col" rowspan="2">멤버스</th>
				<th scope="col" rowspan="2">주문상태</th>
			</tr>
			<tr>
				<th scope="col">쿠폰</th>
				<th scope="col">마일리지</th>
				<th scope="col" class="nolast">포인트</th>
			</tr>
		</thead>
		<tbody>
			<c:forEach items="${ordrDtlList}" var="resultList" varStatus="status">
				<tr>
					<td class="${resultList.ordrCd}"><fmt:formatDate value="${resultList.ordrDt}" pattern="yyyy-MM-dd" /><br> ${resultList.ordrCd}</td>
					<td class="${resultList.ordrCd}">${resultList.ordrrNm}<br> (${resultList.ordrrId})</td>
					<td class="${resultList.ordrCd}">${resultList.recptrNm}</td>
					<td class="${resultList.ordrDtlCd}">${gdsTyCode[resultList.ordrTy]}</td>
					<td class="${resultList.ordrDtlCd }">${resultList.gdsCd}</td>
					<td class="text-left"><c:if test="${resultList.ordrOptnTy eq 'ADIT' }">
							<%--추가상품--%>
							<i class="ico-reply"></i>
							<span class="badge">추가옵션</span>
                               		${resultList.ordrOptn }
                                    </c:if> <c:if test="${resultList.ordrOptnTy eq 'BASE' }">
							<%--주문상품--%>
                                    ${resultList.gdsNm}
                               		<c:if test="${!empty resultList.ordrOptn}">
								<br>(${resultList.ordrOptn })</c:if>
						</c:if></td>
					<td class="text-right">
						 <c:if test="${resultList.ordrOptnTy eq 'BASE'}">
							<fmt:formatNumber value="${resultList.gdsPc}" pattern="###,###" />
							<br>(+<fmt:formatNumber value="${resultList.ordrOptnPc}" pattern="###,###" />)
                                    </c:if> <c:if test="${resultList.ordrOptnTy eq 'ADIT'}">
							<span class="ordrOptnPc"> +<fmt:formatNumber value="${resultList.ordrOptnPc}" pattern="###,###" /></span>
						</c:if>
					</td>
					<td><fmt:formatNumber value="${resultList.ordrQy}" pattern="###,###" /></td>
					<td class="text-right"><fmt:formatNumber value="${resultList.ordrPc }" pattern="###,###" /></td>
					<td class="text-right ${resultList.ordrDtlCd}"><fmt:formatNumber value="${resultList.couponAmt }" pattern="###,###" /></td>
					<td class="text-right ${resultList.ordrCd}"><fmt:formatNumber value="${resultList.useMlg }" pattern="###,###" /></td>
					<td class="text-right ${resultList.ordrCd}"><fmt:formatNumber value="${resultList.usePoint }" pattern="###,###" /></td>

					<td class="text-right ${resultList.ordrDtlCd}">
						<%-- 배송비 TO-DO : 각각의 상품에 배송비가 붙는경우? 체크 --%> <fmt:formatNumber value="${resultList.dlvyBassAmt}" pattern="###,###" /> <c:if test="${resultList.dlvyAditAmt>0}">
							<br>(<fmt:formatNumber value="${resultList.dlvyAditAmt}" pattern="###,###" />)
                                	</c:if>
					</td>

					<td class="text-right ${resultList.ordrCd}"><fmt:formatNumber value="${resultList.stlmAmt}" pattern="###,###" /></td>
					<td class="${resultList.ordrCd}"><c:if test="${!empty resultList.stlmTy }">
                                	${bassStlmTyCode[resultList.stlmTy]}
                                	</c:if> <c:if test="${empty resultList.stlmTy }">미정</c:if></td>

					<td class="${resultList.ordrCd}"><c:choose>
							<c:when test="${!empty resultList.bplcUniqueId}">
								${resultList.bplcNm}
							</c:when>
							<c:otherwise>-</c:otherwise>
						</c:choose></td>
					<td class="${resultList.ordrDtlCd }"><c:choose>
							<c:when test="${(resultList.sttsTy eq 'RE03' || resultList.sttsTy eq 'RF01') && resultList.rfndYn eq 'N'}">
								<%--반품완료+환불미완료 --%>
								<span class="text-danger">환불접수</span>
								<br>(반품완료)
                                		</c:when>
							<c:when test="${(resultList.sttsTy eq 'RE03' || resultList.sttsTy eq 'RF02') && resultList.rfndYn eq 'Y'}">
								<%--반품완료+환불완료 --%>
								<span class="text-danger">환불완료</span>
								<br>(반품완료)
                                		</c:when>
							<c:otherwise>
                                    ${ordrSttsCode[resultList.sttsTy]}
                                		</c:otherwise>
						</c:choose> <%-- 배송중, 배송완료, 구매확정 --%> <c:if test="${resultList.sttsTy eq 'OR07' || resultList.sttsTy eq 'OR08'}">
							<br>
							<a href="#">${resultList.dlvyInvcNo }</a>
						</c:if></td>

				</tr>
			</c:forEach>
			<c:if test="${empty ordrDtlList}">
				<tr>
					<td class="noresult" colspan="17">주문내역이 없습니다.</td>
				</tr>
			</c:if>
		</tbody>
	</table>
</body>
</html>
