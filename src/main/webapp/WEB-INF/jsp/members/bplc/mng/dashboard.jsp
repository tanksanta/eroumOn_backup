<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<jsp:include page="./layout/page_header.jsp">
	<jsp:param value="TODAY REPORT" name="pageTitle" />
</jsp:include>
<div id="page-content">
	<h2 class="text-title2">마켓 공지사항</h2>
	<table class="table-list">
		<colgroup>
			<col class="w-20">
			<col>
			<col class="w-35">
			<col class="w-32">
		</colgroup>
		<thead>
			<tr>
				<th scope="col">번호</th>
				<th scope="col">제목</th>
				<th scope="col">작성자</th>
				<th scope="col">등록일</th>
			</tr>
		</thead>
		<tbody>
			<c:forEach var="resultList" items="${listVO.listObject}" varStatus="status" end="5">
				<tr>
					<td>${listVO.startNo - status.index}</td>
					<td><a href="./mng/mNotice/view?noticeNo=${resultList.noticeNo}" class="subject">${resultList.ttl}</a></td>
					<td>${resultList.rgtr}</td>
					<td><fmt:formatDate value="${resultList.regDt}" pattern="yyyy-MM-dd" /></td>
				</tr>
			</c:forEach>
		</tbody>
	</table>

	<div class="grid grid-cols-2 mt-13 gap-13">
		<div>
			<h2 class="flex items-end justify-between">
				<a href="${_bplcPath}/mng/ordr/all" class="text-title2">주문/배송 현황</a> <span class="text-sm text-gray1 mb-1">(최근30일 기준)</span>
			</h2>
			<table class="table-detail">
				<colgroup>
					<col class="w-43">
					<col>
				</colgroup>
				<tbody>
					<tr>
						<th scope="row">승인대기</th>
						<td><fmt:formatNumber value="${ordrSttsTyCntMap.or01}" pattern="###,###" /></td>
					</tr>
					<tr>
						<th scope="row">승인반려</th>
						<td><fmt:formatNumber value="${ordrSttsTyCntMap.or03}" pattern="###,###" /></td>
					</tr>
					<tr>
						<th scope="row">입금대기</th>
						<td><fmt:formatNumber value="${ordrSttsTyCntMap.or04}" pattern="###,###" /></td>
					</tr>
					<tr>
						<th scope="row">결제완료</th>
						<td><fmt:formatNumber value="${ordrSttsTyCntMap.or05}" pattern="###,###" /></td>
					</tr>
					<tr>
						<th scope="row">배송준비중</th>
						<td><fmt:formatNumber value="${ordrSttsTyCntMap.or06}" pattern="###,###" /></td>
					</tr>
					<tr>
						<th scope="row">배송중</th>
						<td><fmt:formatNumber value="${ordrSttsTyCntMap.or07}" pattern="###,###" /></td>
					</tr>
					<tr>
						<th scope="row">배송완료</th>
						<td><fmt:formatNumber value="${ordrSttsTyCntMap.or08}" pattern="###,###" /></td>
					</tr>
				</tbody>
			</table>
		</div>
		<div>
			<h2 class="flex items-end justify-between">
				<a href="${_bplcPath}/mng/ordr/all" class="text-title2">클레임 현황</a> <span class="text-sm text-gray1 mb-1">(최근30일 기준)</span>
			</h2>
			<table class="table-detail">
				<colgroup>
					<col class="w-43">
					<col>
				</colgroup>
				<tbody>
					<tr>
						<th scope="row">취소접수</th>
						<td><fmt:formatNumber value="${ordrSttsTyCntMap.ca01}" pattern="###,###" /></td>
					</tr>
					<tr>
						<th scope="row">반품접수</th>
						<td><fmt:formatNumber value="${ordrSttsTyCntMap.re01}" pattern="###,###" /></td>
					</tr>
					<tr>
						<th scope="row">교환접수</th>
						<td><fmt:formatNumber value="${ordrSttsTyCntMap.ex01}" pattern="###,###" /></td>
					</tr>
				</tbody>
			</table>
		</div>
	</div>
</div>
<!-- //page content -->