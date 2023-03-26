<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<div id="page-content">
	<%@include file="./include/header.jsp"%>

	<p class="text-title2 mt-13">상세정보</p>
	<table class="table-detail">
		<colgroup>
			<col class="w-43">
			<col>
		</colgroup>
		<tbody>
			<tr>
				<th scope="row">상품코드 / 상품명</th>
				<td>${gdsQaVO.gdsCd} / <a href="/market/gds/2/${gdsQaVO.gdsNo}/${gdsQaVO.gdsCd}" target="_blank">${gdsQaVO.gdsNm}</td>
			</tr>
			<tr>
				<th scope="row">작성자</th>
				<td>${gdsQaVO.rgtr}(${gdsQaVO.regId})</td>
			</tr>
			<tr>
				<th scope="row">등록일</th>
				<td><fmt:formatDate value="${gdsQaVO.regDt}" pattern="yyyy-MM-dd HH:mm:ss" /></td>
			</tr>
			<!--
			<tr>
				<th scope="row">제목</th>
				<td>${resultList.qestnCn}</td>
			</tr>
			 -->
			<tr>
				<th scope="row">내용</th>
				<td>${gdsQaVO.qestnCn}</td>
			</tr>
		</tbody>
	</table>

	<c:if test="${gdsQaVO.ansYn eq 'Y'}">
	<p class="text-title2 mt-13">답변</p>
	<table class="table-detail">
		<colgroup>
			<col class="w-43">
			<col>
		</colgroup>
		<tbody>
			<tr>
				<th scope="row">사용여부</th>
				<td>${useYnCode[gdsQaVO.useYn]}</td>
			</tr>
			<tr>
				<th scope="row">답변상태</th>
				<td>${ansYnCode[gdsQaVO.ansYn]}</td>
			</tr>
			<tr>
				<th scope="row">답변내용</th>
				<td>${gdsQaVO.ansCn}</td>
			</tr>
			<tr>
				<th scope="row">답변자</th>
				<td>${gdsQaVO.answr}(${gdsQaVO.ansId}) / <fmt:formatDate value="${gdsQaVO.ansDt}" pattern="yyyy-MM-dd HH:mm:ss" /></td>
			</tr>
		</tbody>
	</table>
	</c:if>

	<c:set var="pageParam" value="srchBgngDt=${param.srchBgngDt}&amp;srchEndDt=${param.srchEndDt}&amp;srchGdsCd=${param.srchGdsCd}&amp;srchGdsNm=${param.srchGdsNm}&amp;srchQestnCn=${param.srchQestnCn}&amp;srchAnsYn=${param.srchAnsYn}" />
	<div class="btn-group right mt-8">
		<a href="./qna?${pageParam}" class="btn-primary large shadow">목록</a>
	</div>
</div>
