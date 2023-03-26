<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ page import="org.egovframe.rte.fdl.string.EgovDateUtil" %>
<%@ page import="java.net.URLEncoder, java.io.UnsupportedEncodingException" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
	// 엑셀 파일 정보 얻기
	String header = request.getHeader("User-Agent");

	// 엑셀 파일명 설정
	String fileName = "마켓정산_"+EgovDateUtil.getCurrentDateAsString();
	try {
		fileName = URLEncoder.encode(fileName.toString(), "UTF-8").replaceAll("\\+", "%20");
	} catch (UnsupportedEncodingException e) {
		fileName = "_naming_error";
	}

	/*
	response.setHeader("Content-Disposition", "attachment; filename=" + fileName + ".xls;");
    response.setHeader("Content-Description", "JSP Generated Data");
    response.setHeader("Content-Transfer-Encoding", "binary;");
    response.setHeader("Pragma", "no-cache;");
    response.setHeader("Expires", "-1;");
    */
%>

<!DOCTYPE html>
<html>
	<meta charset="utf-8">
	<head>
	<script src="/html/core/vendor/jquery/jquery-3.6.0.min.js"></script>
	<style>
		table { border-collapse:collapse; }
		table th,  td { border:1px solid #cccccc; }
	</style>
	</head>
	<body>
		<div class="scroll-table">
			<table class="table-list">
                        <colgroup>
                            <col class="min-w-28 w-28">
                            <col class="min-w-32 w-32">
                            <col class="min-w-25 w-25">
                            <col class="min-w-23 w-23">
                            <col class="min-w-30">
                            <col class="min-w-23 w-23">
                            <col class="min-w-20 w-20">
                            <col class="min-w-30 w-30">
                            <col class="min-w-20 w-20">
                            <col class="min-w-25 w-25">
                            <col class="min-w-25 w-25">
                            <col class="min-w-25 w-25">
                            <col class="min-w-25 w-25">
                            <col class="min-w-30 w-30">
                            <col class="min-w-30 w-30">
                        </colgroup>
                        <thead>
                            <tr>
                                <th scope="col" rowspan="2">주문일시</th>
                                <th scope="col" rowspan="2">주문번호</th>
                                <th scope="col" rowspan="2">결제수단</th>
                                <%-- loop area S --%>
                                <th scope="col" rowspan="2">상품번호</th>
                                <th scope="col" rowspan="2">상품명/옵션</th>
                                <th scope="col" rowspan="2">상품가격</th>
                                <th scope="col" rowspan="2">수량</th>
                                <th scope="col" rowspan="2">주문금액</th>
                                <th scope="colgroup" colspan="3">할인금액</th>
                                <%-- loop area E --%>
                                <th scope="col" rowspan="2">배송비</th>
                                <th scope="col" rowspan="2">정산대상 금액</th>
                                <th scope="col" rowspan="2">배송완료일</th>
                                <th scope="col" rowspan="2">구매확정일</th>
                            </tr>
                            <tr>
                                <th scope="col">쿠폰</th>
                                <th scope="col">마일리지</th>
                                <th scope="col">포인트</th>
                            </tr>
                        </thead>
                        <tbody>

                        	<c:if test="${!empty ordrList}">
                        	<c:set var="totalStlmAmt" value="0" />
                        	<c:forEach items="${ordrList}" var="resultList" varStatus="status">
                        	<tr>
                                <td class="${resultList.ordrCd}">
									<fmt:formatDate value="${resultList.ordrDt}" pattern="yyyy-MM-dd" />
                                </td>
                                <td class="${resultList.ordrCd}">
									${resultList.ordrCd}
                                </td>
                                <td class="${resultList.ordrCd}">
                                	<c:if test="${!empty resultList.stlmTy }">
                                	${bassStlmTyCode[resultList.stlmTy]}
                                	</c:if>
                                	<c:if test="${empty resultList.stlmTy }">미정</c:if>
                                </td>

                                <td class="${resultList.ordrDtlCd }">
                                	${resultList.gdsCd}
                                </td>
                                <td class="text-left">
                                	<c:if test="${resultList.ordrOptnTy eq 'ADIT' }"><%--추가상품--%>
                                    <i class="ico-reply"></i>
                                    <span class="badge">추가옵션</span>
                               		${resultList.ordrOptn }
                                    </c:if>
                                    <c:if test="${resultList.ordrOptnTy eq 'BASE' }"><%--주문상품--%>
                                    ${resultList.gdsNm}
                               		<c:if test="${!empty resultList.ordrOptn}"><br>(${resultList.ordrOptn })</c:if>
                                    </c:if>
                                </td>
                                <td class="text-right">
                                	<c:if test="${resultList.ordrOptnTy eq 'BASE'}">
                                    <fmt:formatNumber value="${resultList.gdsPc}" pattern="###,###" />
                                    <br>(+<fmt:formatNumber value="${resultList.ordrOptnPc}" pattern="###,###" />)
                                    </c:if>
                                    <c:if test="${resultList.ordrOptnTy eq 'ADIT'}"><span class="ordrOptnPc">
                                    +<fmt:formatNumber value="${resultList.ordrOptnPc}" pattern="###,###" /></span>
                                    </c:if>
                                </td>

                                <td><fmt:formatNumber value="${resultList.ordrQy}" pattern="###,###" /></td>
                                <td class="text-right"><fmt:formatNumber value="${resultList.ordrPc }" pattern="###,###" /></td>
                                <td class="text-right ${resultList.ordrDtlCd}"><fmt:formatNumber value="${resultList.couponAmt }" pattern="###,###" /></td>
                                <td class="text-right ${resultList.ordrCd}"><fmt:formatNumber value="${resultList.useMlg }" pattern="###,###" /></td>
                                <td class="text-right ${resultList.ordrCd}"><fmt:formatNumber value="${resultList.usePoint }" pattern="###,###" /></td>

                                <td class="text-right ${resultList.ordrDtlCd}">
                                	<fmt:formatNumber value="${resultList.dlvyBassAmt}" pattern="###,###" />
                                	<c:if test="${resultList.dlvyAditAmt>0}">
                                	<br>(+<fmt:formatNumber value="${resultList.dlvyAditAmt}" pattern="###,###" />)
                                	</c:if>
                                </td>

                                <td class="text-right ${resultList.ordrCd}">
									<fmt:formatNumber value="${resultList.stlmAmt}" pattern="###,###" />
                                </td>
								<td class="${resultList.ordrCd}">
									<c:set var="chk" value="true" />
									<c:forEach items="${resultList.ordrChgHist}" var="chgHist" varStatus="s">
									<c:if test="${chgHist.chgStts eq 'OR08' && chk }">
										<fmt:formatDate value="${chgHist.regDt}" pattern="yyyy-MM-dd" />
										<c:set var="chk" value="false" />
									</c:if>
									</c:forEach>

                                </td>
                                <td class="${resultList.ordrCd}">
                                	<c:set var="chk" value="true" />
									<c:forEach items="${resultList.ordrChgHist}" var="chgHist" varStatus="s">
									<c:if test="${chgHist.chgStts eq 'OR09' && chk }">
										<fmt:formatDate value="${chgHist.regDt}" pattern="yyyy-MM-dd" />
										<c:set var="chk" value="false" />
									</c:if>
									</c:forEach>
                                </td>
                            </tr>

							<c:if test="${resultList.ordrCd ne ordrList[status.index + 1].ordrCd}">
                            <c:set var="totalStlmAmt" value="${totalStlmAmt + resultList.stlmAmt}" />
                            </c:if>

                            </c:forEach>
	                        <tr class="total">
	                        	<td colspan="12">총 합계</td>
	                        	<td colspan="3"><fmt:formatNumber value="${totalStlmAmt}" pattern="###,###" /></td>
	                        </tr>
	                        </c:if>

                            <c:if test="${empty ordrList}">
	                        <tr>
	                            <td class="noresult" colspan="16">검색조건을 선택하신 후 검색버튼을 클릭하셔야 조회가 진행됩니다</td>
	                        </tr>
	                        </c:if>

                        </tbody>
                    </table>
		</div>

		<script>
        $(function(){

        	/* rowspan function */
        	$.fn.mergeClassRowspan = function (colIdx) {
        	    return this.each(function () {
        	        var that;
        	        $('tr', this).each(function (row) {
        	            //$('td:eq(' + colIdx + ')', this).filter(':visible').each(function (col) {
        	            $('td:eq(' + colIdx + ')', this).each(function (col) {
        	                if ($(this).attr('class') == $(that).attr('class')) {
        	                    rowspan = $(that).attr("rowspan") || 1;
        	                    rowspan = Number(rowspan) + 1;
        	                    $(that).attr("rowspan", rowspan);
        	                    $(this).hide();
        	                } else {
        	                    that = this;
        	                }

        	                that = (that == null) ? this : that;
        	            });
        	        });
        	    });
        	};

        	// rowspan
        	$('.table-list tbody').mergeClassRowspan(0);
        	$('.table-list tbody').mergeClassRowspan(1);
        	$('.table-list tbody').mergeClassRowspan(2);
        	$('.table-list tbody').mergeClassRowspan(3);

        	$('.table-list tbody').mergeClassRowspan(9);
        	$('.table-list tbody').mergeClassRowspan(10);
        	$('.table-list tbody').mergeClassRowspan(11);
        	$('.table-list tbody').mergeClassRowspan(12);

        });

		</script>
	</body>
</html>