<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<div id="page-content">
	  <%@include file="./include/header.jsp"%>

	<p class="text-title2 mt-13">상세정보</p>
	<table class="table-detail">
		<colgroup>
			<col class="w-43">
			<col>
			<col class="w-43">
			<col>
		</colgroup>
		<tbody>
			<tr>
				<th scope="row">문의유형</th>
				<td colspan="3">${inqryTyCode1[mbrInqryVO.inqryTy]} > ${inqryTyCode2[mbrInqryVO.inqryDtlTy]}</td>
			</tr>
			<tr>
				<th scope="row">주문번호</th>
				<td>${mbrInqryVO.ordrCd}</td>
				<!-- <th scope="row">상품코드</th>
				<td>T150622L002332</td> -->
			</tr>
			<tr>
				<th scope="row">제목</th>
				<td colspan="3">${mbrInqryVO.ttl}</td>
			</tr>
			<tr>
				<th scope="row">내용</th>
				<td colspan="3">${mbrInqryVO.cn}</td>
			</tr>
			<tr>
				<th scope="row">답변 희망형태</th>
				<td colspan="3">${mbrInqryVO.smsAnsYn eq 'Y'?'SMS':''}&nbsp;${mbrInqryVO.emlAnsYn eq 'Y'?'이메일':''}</td>
			</tr>
			<tr>
				<th scope="row">첨부파일</th>
				<td colspan="3">
					<c:forEach var="fileList" items="${mbrInqryVO.fileList}">
						<a href="/comm/getFile?srvcId=INQRY&amp;upNo=${fileList.upNo}&amp;fileTy=${fileList.fileTy }&amp;fileNo=${fileList.fileNo }">${fileList.orgnlFileNm}</a>
					</c:forEach>
				</td>
			</tr>
			<tr>
				<th scope="row">등록일</th>
				<td colspan="3"><fmt:formatDate value="${mbrInqryVO.regDt}" pattern="yyyy-MM-dd" /></td>
			</tr>
		</tbody>
	</table>

	<c:if test="${mbrInqryVO.ansYn eq 'Y' }">
	<p class="text-title2 mt-13">답변</p>
		<table class="table-detail">
			<colgroup>
				<col class="w-43">
				<col>
			</colgroup>
			<tbody>
				<tr>
					<th scope="row">답변상태</th>
					<td>${ansYnCode[mbrInqryVO.ansYn]}</td>
				</tr>
				<tr>
					<th scope="row">답변내용</th>
					<td>${mbrInqryVO.ansCn}</td>
				</tr>
				<tr>
					<th scope="row">답변자</th>
					<td>${mbrInqryVO.answr}(${mbrInqryVO.ansId}) / <fmt:formatDate value="${mbrInqryVO.ansDt}" pattern="yyyy-MM-dd HH:mm:ss" /></td>
				</tr>
			</tbody>
		</table>
	</c:if>

	<c:set var="pageParam" value="srchBgngDt=${param.srchBgngDt}&amp;srchEndDt=${pararm.srchEndDt}&amp;srchInqryTy=${param.srchInqryTy}&amp;srchInqryTyNo2=${pararm.srchInqryTyNo2}&amp;srchTtl=${pararm.srchTtl}&amp;srchAns=${pararm.srchAns}" />
	<div class="btn-group right mt-8">
		<a href="./question?${pageParam}" class="btn-primary large shadow">목록</a>
	</div>
</div>
