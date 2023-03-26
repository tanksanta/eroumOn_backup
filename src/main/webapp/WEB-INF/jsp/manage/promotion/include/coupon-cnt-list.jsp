<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<form id="srchFrm" name="srchFrm" method="post" action="./list">
	<input type="hidden" id="couponNo" name="couponNo" value="${couponVO.couponNo}">
	<input type="hidden" id="couponNm" name="couponNm" value="${couponVO.couponNm}">
</form>
<!-- 발급된 쿠폰 번호 -->
<div class="modal fade" id="listModal" tabindex="-1">
	<div class="modal-dialog modal-lg modal-dialog-centered">
		<div class="modal-content">
			<div class="modal-header">
				<p>발급된 쿠폰 번호</p>
				<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="close"></button>
			</div>
			<div class="modal-body">
				<table class="table-detail">
					<colgroup>
						<col class="w-34">
						<col>
					</colgroup>
					<tbody>
						<tr>
							<th scope="row">쿠폰번호</th>
							<td>${couponVO.couponNo}</td>
						</tr>
						<tr>
							<th scope="row">고객쿠폰명</th>
							<td>${couponVO.couponNm}</td>
						</tr>
						<tr>
							<th scope="row">유효기간</th>
								<c:if test="${couponVO.usePdTy eq 'FIX'}">
									<td><fmt:formatDate value="${couponVO.useBgngYmd}" pattern="yyyy-MM-dd" /> ~ <fmt:formatDate value="${couponVO.useEndYmd}" pattern="yyyy-MM-dd" /></td>
								</c:if>
								<c:if test="${couponVO.usePdTy eq 'ADAY'}">
									<td>발행일로부터 : ${couponVO.usePsbltyDaycnt} 일</td>
								</c:if>
						</tr>
					</tbody>
				</table>

				<p class="text-title2 mt-13">쿠폰번호</p>
				<table class="table-list">
					<colgroup>
						<col class="w-1/3">
						<col>
					</colgroup>
					<thead>
						<tr>
							<th scope="col">번호</th>
							<th scope="col">쿠폰번호</th>
						</tr>
					</thead>
					<tbody>
						<c:forEach var="result" items="${itemList}" varStatus="status">
							<tr>
								<td>${status.index +1}</td>
								<td>${result.couponCd}</td>
							</tr>
						</c:forEach>
					</tbody>
				</table>
			</div>
			<div class="modal-footer">
				<button type="button" class="btn-primary large shadow btn-excel">액셀 다운로드</button>
			</div>
		</div>
	</div>
</div>

<script>
	$(function(){
		//엑셀 다운로드
		$(".btn-excel").on("click",function(){
			$("#srchFrm").attr("action","/_mng/promotion/coupon/excel").submit();
			$("#srchFrm").attr("action","list");
		});

	});
</script>