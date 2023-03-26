<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<jsp:include page="../layout/page_header.jsp">
	<jsp:param value="공지사항" name="pageTitle" />
</jsp:include>
<div id="page-content">
	<p class="text-title2">공지사항 목록</p>
	<form id="searchFrm" name="searchFrm" method="get" action="./ntceList">
	<input type="hidden" name="cntPerPage" id="cntPerPage" value="${listVO.cntPerPage}" />
	<table class="table-list">
		<colgroup>
			<col class="w-20">
			<col>
			<col class="w-32">
		</colgroup>
		<thead>
			<tr>
				<th scope="col">번호</th>
				<th scope="col">제목</th>
				<th scope="col">등록일</th>
			</tr>
		</thead>
		<tbody>
			<c:forEach var="resultList" items="${listVO.listObject}" varStatus="status">
			<c:set var="pageParam" value="nttNo=${resultList.nttNo}&amp;curPage=${listVO.curPage}&amp;cntPerPage=${param.cntPerPage}" />
			<tr>
				<td>${listVO.startNo - status.index}</td>
				<td><a href="./ntceForm?${pageParam}" class="subject">${resultList.ttl}</a></td>
				<td>${resultList.wrtYmd}</td>
			</tr>
			</c:forEach>
			<c:if test="${empty listVO.listObject}">
			<tr>
				<td colspan="3">등록된 데이터가 없습니다.</td>
			</tr>
			</c:if>
		</tbody>
	</table>
	</form>

	<div class="pagination mt-7">
		<front:paging listVO="${listVO}" />

		<div class="sorting2">
			<label for="countPerPage">출력</label> <select name="countPerPage" id="countPerPage" class="form-control">
				<option value="10" ${listVO.cntPerPage eq '10' ? 'selected' : '' }>10개</option>
				<option value="20" ${listVO.cntPerPage eq '20' ? 'selected' : '' }>20개</option>
				<option value="30" ${listVO.cntPerPage eq '30' ? 'selected' : '' }>30개</option>
			</select>
		</div>

		<div class="counter">
			총 <strong>${listVO.totalCount}</strong>건, <strong>${listVO.curPage}</strong>/${listVO.totalPage} 페이지
		</div>
	</div>


	<div class="btn-group right mt-8">
		<a href="./ntceForm?curPage=${param.curPage}&amp;cntPerPage=${param.cntPerPage}" class="btn-save shadow large">등록</a>
	</div>
	<div class="mt-8"></div>
</div>