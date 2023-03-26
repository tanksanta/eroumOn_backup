<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<main id="container">

	<jsp:include page="../../layout/page_header.jsp" >
		<jsp:param value="공지사항" name="pageTitle"/>
	</jsp:include>

	<div id="page-container">

		<jsp:include page="../../layout/page_sidenav.jsp" />

		<div id="page-content">
			<p class="text-lg mb-2 md:mb-3 md:text-xl">
				공지사항 <strong class="font-serif"> <span class="text-danger">${listVO.totalCount}</span>건
				</strong>
			</p>

			<c:if test="${empty listVO.listObject}"><div class="box-result is-large mt-3 md:mt-5">공지사항이 없습니다</div></c:if>

			<c:if test="${!empty listVO.listObject}">
				<table class="board-list">
					<colgroup>
						<col class="w-17 md:w-19">
						<col>
					</colgroup>
					<thead>
						<tr>
							<th scope="col"><p>번호</p></th>
							<th scope="col"><p>제목 / 등록일</p></th>
						</tr>
					</thead>
					<tbody>
						<c:forEach var="resultList" items="${listVO.listObject}" varStatus="status">
						<c:set var="pageParam" value="nttNo=${resultList.nttNo}&amp;curPage=${listVO.curPage}" />
							<tr>
								<c:if test="${resultList.ntcYn ne 'Y'}"><td>${listVO.startNo - status.index}</td></c:if>
								<c:if test="${resultList.ntcYn eq 'Y'}"><td>공지</td></c:if>

								<td><a href="./view?${pageParam}" class="block">
										<p class="name">${resultList.ttl}</p>
										<p class="date"><fmt:formatDate value="${resultList.regDt}" pattern="yyyy-MM-dd" /></p>
										<c:if test="${resultList.ntcYn eq 'Y'}"><p class="desc">${resultList.cn}</p></c:if>
								</a></td>
							</tr>
						</c:forEach>
					</tbody>
				</table>
			</c:if>

			<div class="pagination">
				<front:paging listVO="${listVO}" />
			</div>
		</div>
	</div>
</main>