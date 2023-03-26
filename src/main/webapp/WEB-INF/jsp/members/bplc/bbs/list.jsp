<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<main id="container">
	<form id="listFrm" name="listFrm" method="get" action="./list">
	<input type="hidden" name="cntPerPage" id="cntPerPage" value="${listVO.cntPerPage}" />
	<h2 class="page-title">${bplcSetupVO.bplcNm} 복지용구센터에서 알려드립니다.</h2>
	<ul class="board-list-notice">
		<c:forEach var="resultList" items="${listVO.listObject}" varStatus="status">
		<c:set var="pageParam" value="nttNo=${resultList.nttNo}&amp;curPage=${listVO.curPage}${!empty(listVO.urlParam)? '&amp;' : ''}${listVO.urlParam}" />
		<li>
			<a href="./view?${pageParam}">
				<p class="numb">
					<c:if test="${resultList.ntcYn eq 'N'}">${listVO.startNo - status.index}</c:if>
					<c:if test="${resultList.ntcYn eq 'Y'}"><img src="/html/page/office/assets/images/ico-pin.svg" alt="공지사항"></c:if>
				</p>
				<p class="name">${resultList.ttl}</p>
				<div class="time" style="position:absolute; right:11px;">
					<p>${resultList.wrtYmd}</p>
					<p>조회수 ${resultList.inqcnt}</p>
				</div>
			</a>
		</li>
		</c:forEach>
		<c:if test="${empty listVO.listObject}">
		<li style="padding: 50px 0 50px; width: 100%;">등록된 데이터가 없습니다.</li>
		</c:if>
	</ul>
	</form>

	<div class="pagination mt-7">
		<front:paging listVO="${listVO}" />
	</div>
</main>
