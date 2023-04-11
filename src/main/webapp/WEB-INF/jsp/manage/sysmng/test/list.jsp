<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<div id="page-content">
	
	<div>
		<p class="text-right">
			<button type="button" class="btn-primary btn-excel" data-bs-toggle="modal" data-bs-target="#fileModal">엑셀 업로드</button>
			<button type="button" class="btn-primary btn-excel" id="excelDownload">엑셀 다운로드</button>
		</p>
	</div>

	<p class="text-title2 mt-13">회원 목록(기본리스트)</p>
	<table class="table-list">
		<colgroup>
			<col class="w-20">
			<col class="w-30">
			<col class="w-28">
			<col class="w-20">
			<col class="w-28">
			<col>
			<col class="w-28">
			<!-- <col class="w-28"> -->
			<col class="w-25">
		</colgroup>
		<thead>
			<tr>
				<th scope="col">번호</th>
				<th scope="col">아이디</th>
				<th scope="col">회원이름</th>
				<th scope="col">성별</th>
				<th scope="col">생년월일</th>
				<th scope="col">회원분류(회원등급)</th>
				<th scope="col">가입일</th>
				<!-- <th scope="col">가입구분</th> -->
				<th scope="col">가입매체</th>
			</tr>
		</thead>
		<tbody>
		<c:forEach var="resultList" items="${listVO.listObject}" varStatus="status">
		<c:set var="pageParam" value="curPage=${param.curPage }&amp;cntPerPage=${param.cntPerPage }&amp;srchMbrId=${param.srchMbrId}&amp;srchNm=${param.srchNm}&amp;srchLastTelnoOfMbl=${param.srchLastTelnoOfMbl}&amp;srchBrdt=${param.srchBrdt}" />
			<tr>
				<td>${listVO.startNo - status.index }</td>
				<td><a href="./${resultList.uniqueId}/view?${pageParam}" class="btn shadow w-full" style="padding-right: 0.5rem; padding-left: 0.5rem;">${resultList.mbrId}</a></td>
				<td><a href="./${resultList.uniqueId}/view?${pageParam}" class="btn shadow w-full" style="padding-right: 0.5rem; padding-left: 0.5rem;">${resultList.mbrNm }</a></td>
				<td>${gender[resultList.gender]}</td>
				<td><fmt:formatDate value="${resultList.brdt}" pattern="yyyy-MM-dd" /></td>
				<td class="cateVal${status.index}">${recipterYn[resultList.recipterYn] }<span class="badge-primary ml-2 gradeVal">${grade[resultList.mberGrade]}</span></td>
				<td><fmt:formatDate value="${resultList.joinDt}" pattern="yyyy-MM-dd" /></td>
				<!-- <td>온라인회원</td> -->
				<td>${resultList.joinCours}</td>
			</tr>
			</c:forEach>
			   <c:if test="${empty listVO.listObject}">
				<tr>
					<td class="noresult" colspan="8">검색조건을 만족하는 결과가 없습니다.</td>
				</tr>
				</c:if>

		</tbody>
	</table>
	
	<!-- 엑셀 업로드 모달 추가 -->
	<c:import url="/_mng/sysmng/test/modalFileUpload" />
</div>

<script>
	$(function() {
		$('#excelDownload').on('click', function() {
			window.open('/_mng/sysmng/test/excelDownloadAction');
		});
	})
</script>