<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<jsp:include page="../layout/page_header.jsp">
	<jsp:param value="공지사항" name="pageTitle" />
</jsp:include>
<div id="page-content">
	<form action="./list" id="searchFrm" name="searchFrm" method="get" >
		<input type="hidden" id="cntPerPage" name="cntPerPage" value="${param.cntPerPage}" />
	</form>
	<p class="p-3 rounded-md bg-gray2">* 이로움마켓 공지사항은 이로움마켓에서 멤버스(사업소)로 전달하는 공지사항입니다.</p>

	<p class="text-title2 mt-13">공지사항 목록</p>
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
			<c:set var="pageParam" value="noticeNo=${resultList.noticeNo}&amp;curPage=${listVO.curPage}&amp;cntPerPage=${param.cntPerPage}" />
				<tr>
					<td>${listVO.startNo - status.index}</td>
					<td><a href="./view?${pageParam}" class="subject">${resultList.ttl}</a></td>
					<td><fmt:formatDate value="${resultList.regDt}" pattern="yyyy-MM-dd" /></td>
				</tr>
			</c:forEach>
		</tbody>
	</table>

	<div class="pagination mt-7">
		<mngr:mngrPaging listVO="${listVO}" />

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
</div>