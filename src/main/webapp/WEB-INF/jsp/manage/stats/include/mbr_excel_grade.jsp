<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ page import="org.egovframe.rte.fdl.string.EgovDateUtil" %>
<%@ page import="java.net.URLEncoder, java.io.UnsupportedEncodingException" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
	// 엑셀 파일 정보 얻기
	String header = request.getHeader("User-Agent");

	// 엑셀 파일명 설정
	String fileName = "회원등급_"+EgovDateUtil.getCurrentDateAsString();
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
		<p class="text-title2 mt-13">조회결과</p>
		<div class="scroll-table">
			<table class="table-list">
				<colgroup>
					<col class="min-w-30 w-30">
					<col class="min-w-25">
					<col class="min-w-25">
					<col class="min-w-25">
					<col class="min-w-25">
					<col class="min-w-25">
					<col class="min-w-25">
					<col class="min-w-25">
					<col class="min-w-25">
					<col class="min-w-25">
					<col class="min-w-25">
					<col class="min-w-25">
					<col class="min-w-25">
					<col class="min-w-25">
					<col class="min-w-25">
					<col class="min-w-25">
					<col class="min-w-25">
					<col class="min-w-25">
					<col class="min-w-25">
				</colgroup>
				<thead>
					<tr>
						<th scope="col" rowspan="2">가입경로</th>
						<th scope="col" rowspan="2">총합계</th>
						<th scope="colgroup" colspan="8">남성</th>
						<th scope="colgroup" colspan="8">여성</th>
					</tr>
					<tr>
						<th scope="col">~19</th>
						<th scope="col">20대</th>
						<th scope="col">30대</th>
						<th scope="col">40대</th>
						<th scope="col">50대</th>
						<th scope="col">60대</th>
						<th scope="col">70대~</th>
						<th scope="col">남성합계</th>
						<th scope="col">~19</th>
						<th scope="col">20대</th>
						<th scope="col">30대</th>
						<th scope="col">40대</th>
						<th scope="col">50대</th>
						<th scope="col">60대</th>
						<th scope="col">70대~</th>
						<th scope="col">여성합계</th>
					</tr>
				</thead>
				<!--
				<tfoot>
					<tr class="total">
						<td colspan="2">합계</td>
						<td class="text-right">1,234,567</td>
						<td class="text-right">1,234,567</td>
						<td class="text-right">1,234,567</td>
						<td class="text-right">1,234,567</td>
						<td class="text-right">1,234,567</td>
						<td class="text-right">1,234,567</td>
						<td class="text-right">1,234,567</td>
						<td class="text-right">1,234,567</td>
						<td class="text-right">1,234,567</td>
						<td class="text-right">1,234,567</td>
						<td class="text-right">1,234,567</td>
						<td class="text-right">1,234,567</td>
						<td class="text-right">1,234,567</td>
						<td class="text-right">1,234,567</td>
						<td class="text-right">1,234,567</td>
						<td class="text-right">1,234,567</td>
					</tr>
				</tfoot>
				 -->
				<tbody  class="view">
					<!--
					<c:if test="${empty resultList}">
						<tr>
							<td class="noresult" colspan="19">검색조건을 만족하는 결과가 없습니다.</td>
						</tr>
					</c:if> -->
					<c:set var="sumTotal" value="0" />
					<c:set var="sumMnChild" value="0" />
					<c:set var="sumMnTwenty" value="0" />
					<c:set var="sumMnThirty" value="0" />
					<c:set var="sumMnForty" value="0" />
					<c:set var="sumMnFifty" value="0" />
					<c:set var="sumMnSisTy" value="0" />
					<c:set var="sumMnSevenTy" value="0" />
					<c:set var="sumMnTotal" value="0" />
					<c:set var="sumWmChild" value="0" />
					<c:set var="sumWmTwenty" value="0" />
					<c:set var="sumWmThirty" value="0" />
					<c:set var="sumWmForty" value="0" />
					<c:set var="sumWmFifty" value="0" />
					<c:set var="sumWmSisTy" value="0" />
					<c:set var="sumWmSevenTy" value="0" />
					<c:set var="sumWmTotal" value="0" />

					<c:forEach var="result" items="${resultList}" varStatus="status">
						<c:set var="sumTotal" value="${sumTotal + result.total}" />
						<c:set var="sumMnChild" value="${sumMnChild +result.mnChild}" />
						<c:set var="sumMnTwenty" value="${sumMnTwenty + result.mnTwenty}" />
						<c:set var="sumMnThirty" value="${sumMnThirty + result.mnThirty}" />
						<c:set var="sumMnForty" value="${sumMnForty + result.mnForty}" />
						<c:set var="sumMnFifty" value="${sumMnFifty + result.mnFifty}" />
						<c:set var="sumMnSisTy" value="${sumMnSisTy + result.mnSixty}" />
						<c:set var="sumMnSevenTy" value="${sumMnSevenTy + result.mnSeventy}" />
						<c:set var="sumMnTotal" value="${sumMnTotal + result.mnTotal}" />
						<c:set var="sumWmChild" value="${sumWmChild + result.wmChild}" />
						<c:set var="sumWmTwenty" value="${sumWmTwenty + result.wmTwenty}" />
						<c:set var="sumWmThirty" value="${sumWmThirty + result.wmThirty}" />
						<c:set var="sumWmForty" value="${sumWmForty + result.wmForty}" />
						<c:set var="sumWmFifty" value="${sumWmFifty + result.wmFifty}" />
						<c:set var="sumWmSisTy" value="${sumWmSisTy + result.wmSixty}" />
						<c:set var="sumWmSevenTy" value="${sumWmSevenTy + result.wmSeventy}" />
						<c:set var="sumWmTotal" value="${sumWmTotal + result.wmTotal}" />

						<tr>
							<td class="gradeView${status.index} grades" data-mbr-grade="${result.mberGrade}">${gradeCode[result.mberGrade]}</td>
							<td class="text-right"><fmt:formatNumber value="${result.total}" pattern="###,###" /></td>
							<td class="text-right"><fmt:formatNumber value="${result.mnChild}" pattern="###,###" /></td>
							<td class="text-right"><fmt:formatNumber value="${result.mnTwenty}" pattern="###,###" /></td>
							<td class="text-right"><fmt:formatNumber value="${result.mnThirty}" pattern="###,###" /></td>
							<td class="text-right"><fmt:formatNumber value="${result.mnForty}" pattern="###,###" /></td>
							<td class="text-right"><fmt:formatNumber value="${result.mnFifty}" pattern="###,###" /></td>
							<td class="text-right"><fmt:formatNumber value="${result.mnSixty}" pattern="###,###" /></td>
							<td class="text-right"><fmt:formatNumber value="${result.mnSeventy}" pattern="###,###" /></td>
							<td class="text-right"><fmt:formatNumber value="${result.mnTotal}" pattern="###,###" /></td>
							<td class="text-right"><fmt:formatNumber value="${result.wmChild}" pattern="###,###" /></td>
							<td class="text-right"><fmt:formatNumber value="${result.wmTwenty}" pattern="###,###" /></td>
							<td class="text-right"><fmt:formatNumber value="${result.wmThirty}" pattern="###,###" /></td>
							<td class="text-right"><fmt:formatNumber value="${result.wmForty}" pattern="###,###" /></td>
							<td class="text-right"><fmt:formatNumber value="${result.wmFifty}" pattern="###,###" /></td>
							<td class="text-right"><fmt:formatNumber value="${result.wmSixty}" pattern="###,###" /></td>
							<td class="text-right"><fmt:formatNumber value="${result.wmSeventy}" pattern="###,###" /></td>
							<td class="text-right"><fmt:formatNumber value="${result.wmTotal}" pattern="###,###" /></td>
						</tr>
					</c:forEach>

					<script>
					const gradeCode = {
							<c:forEach var="grade" items="${gradeCode}">
								"${grade.key}" : "${grade.value}",
							</c:forEach>
						}
							var arrGrade = ['E','B','S','N','R'];
							var lengths = $(".grades").length;

						$(function(){


							//default
							for(var i=0; i < lengths; i++){
								var grd = $(".gradeView"+i).data("mbrGrade");
								if(arrGrade.includes(grd)){
									arrGrade = arrGrade.filter((element) => element !== grd);
								}
							}

							if(arrGrade.length > 0){
								for(var h=0; h<arrGrade.length; h++){
									var html = "";
							        html += '<tr>';
							        html += '        <td>'+gradeCode[arrGrade[h]]+'</td>';
							        html += '        <td class="text-right">0</td>';
							        html += '        <td class="text-right">0</td>';
							        html += '        <td class="text-right">0</td>';
							        html += '        <td class="text-right">0</td>';
							        html += '		  <td class="text-right">0</td>';
							        html += '        <td class="text-right">0</td>';
							        html += '        <td class="text-right">0</td>';
							        html += '        <td class="text-right">0</td>';
							        html += '        <td class="text-right">0</td>';
							        html += '        <td class="text-right">0</td>';
							        html += '        <td class="text-right">0</td>';
							        html += '        <td class="text-right">0</td>';
							        html += '        <td class="text-right">0</td>';
							        html += '        <td class="text-right">0</td>';
							        html += '        <td class="text-right">0</td>';
							        html += '        <td class="text-right">0</td>';
							        html += '        <td class="text-right">0</td>';
							        html += '	</tr>';

							        $(".view").prepend(html);
								}
							}
						});

					</script>

					<tr class="total">
						<td>총회원수</td>
						<td class="text-right"><fmt:formatNumber value="${sumTotal}" pattern="###,###" /></td>
						<td class="text-right"><fmt:formatNumber value="${sumMnChild}" pattern="###,###" /></td>
						<td class="text-right"><fmt:formatNumber value="${sumMnTwenty}" pattern="###,###" /></td>
						<td class="text-right"><fmt:formatNumber value="${sumMnThirty}" pattern="###,###" /></td>
						<td class="text-right"><fmt:formatNumber value="${sumMnForty}" pattern="###,###" /></td>
						<td class="text-right"><fmt:formatNumber value="${sumMnFifty}" pattern="###,###" /></td>
						<td class="text-right"><fmt:formatNumber value="${sumMnSisTy}" pattern="###,###" /></td>
						<td class="text-right"><fmt:formatNumber value="${sumMnSevenTy}" pattern="###,###" /></td>
						<td class="text-right"><fmt:formatNumber value="${sumMnTotal}" pattern="###,###" /></td>
						<td class="text-right"><fmt:formatNumber value="${sumWmChild}" pattern="###,###" /></td>
						<td class="text-right"><fmt:formatNumber value="${sumWmTwenty}" pattern="###,###" /></td>
						<td class="text-right"><fmt:formatNumber value="${sumWmThirty}" pattern="###,###" /></td>
						<td class="text-right"><fmt:formatNumber value="${sumWmForty}" pattern="###,###" /></td>
						<td class="text-right"><fmt:formatNumber value="${sumWmFifty}" pattern="###,###" /></td>
						<td class="text-right"><fmt:formatNumber value="${sumWmSisTy}" pattern="###,###" /></td>
						<td class="text-right"><fmt:formatNumber value="${sumWmSevenTy}" pattern="###,###" /></td>
						<td class="text-right"><fmt:formatNumber value="${sumWmTotal}" pattern="###,###" /></td>
					</tr>
				</tbody>
			</table>
		</div>
	</body>

</html>

