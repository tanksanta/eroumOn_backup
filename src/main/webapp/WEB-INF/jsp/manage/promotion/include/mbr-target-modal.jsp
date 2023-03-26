<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!-- 대상인원 -->
<div class="modal fade" id="targetListModal" tabindex="-1">
	<div class="modal-dialog modal-lg modal-dialog-centered">
		<div class="modal-content">
			<div class="modal-header">
				<p>포인트 적립/차감 대상확인</p>
				<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="close"></button>
			</div>
			<div class="modal-body">
				<table class="table-list">
					<colgroup>
						<col class="w-25">
						<col class="w-1/4">
						<col>
						<col class="w-32">
					</colgroup>
					<thead>
						<tr>
							<th scope="col">구분</th>
							<th scope="col">내역</th>
							<th scope="col">관리자메모</th>
							<th scope="col">개별포인트</th>
						</tr>
					</thead>
					<tbody>
						<c:set var="resultList" value="${resultMap.pointMng}" />
							<c:if test="${fn:indexOf(_curPath,'/point') > 0 }">
								<tr>
									<td>${pointSeCode[resultList.pointSe]}</td>
									<td>${pointCnCode[resultList.pointCn]}</td>
									<td>${resultList.mngrMemo}</td>
									<td class="text-right"><fmt:formatNumber value="${resultList.point}" pattern="###,###" /></td>
								</tr>
							</c:if>
							<c:if test="${fn:indexOf(_curPath,'/mlg') > 0 }">
									<tr>
									<td>${pointSeCode[resultList.mlgSe]}</td>
									<td>${pointCnCode[resultList.mlgCn]}</td>
									<td>${resultList.mngrMemo}</td>
									<td class="text-right"><fmt:formatNumber value="${resultList.mlg}" pattern="###,###" /></td>
								</tr>
							</c:if>
					</tbody>
				</table>

				<p class="text-title2 mt-10">대상인원</p>
				<table class="table-list">
					<colgroup>
						<col class="w-20">
						<col>
						<col>
						<col>
					</colgroup>
					<thead>
						<tr>
							<th scope="col">번호</th>
							<th scope="col">고객코드</th>
							<th scope="col">고객명</th>
							<th scope="col">아이디</th>
						</tr>
					</thead>
					<tbody>
						<c:forEach var="mbrList" items="${resultMap.mbrList}" varStatus="status">
							<c:forEach var="mbr" items="${mbrList.mbrList}" varStatus="stts">
								<tr>
									<td>${status.index + 1 }</td>
									<td>${mbr.uniqueId}</td>
									<td>${mbr.mbrNm}</td>
									<td>${mbr.mbrId}</td>
								</tr>
							</c:forEach>
						</c:forEach>
					</tbody>
				</table>
			</div>
			<div class="modal-footer">
				<button type="button" class="btn-secondary large shadow w-26" data-bs-dismiss="modal" aria-label="close">닫기</button>
			</div>
		</div>
	</div>
</div>
<!-- //대상인원 -->