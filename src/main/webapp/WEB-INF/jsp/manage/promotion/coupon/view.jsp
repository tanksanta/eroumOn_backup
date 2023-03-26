<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<form:form action="./action" id="couponFrm" name="couponFrm" method="post" modelAttribute="couponVO">
<form:hidden path="crud" value="UPDATE" />
<form:hidden path="couponNo" value="${couponVO.couponNo}"/>

	<fieldset>
		<legend class="text-title2">기본정보</legend>
		<table class="table-detail">
			<colgroup>
				<col class="w-43">
				<col>
				<col class="w-43">
				<col>
			</colgroup>
			<tbody>
				<tr>
					<th scope="row"><span class="require">쿠폰번호</span></th>
					<td colspan="3" class="text-danger">${couponVO.couponNo}</td>
				</tr>
				<tr>
					<th scope="row"><span class="require">쿠폰종류</span></th>
					<td colspan="3">${couponTy[couponVO.couponTy]}</td>
				</tr>
				<tr>
					<th scope="row"><label for="couponNm">고객쿠폰명</label></th>
					<td colspan="3"><form:input class="form-control w-full" path="couponNm" value="${couponVO.couponNm}" maxlnegth="50"/>
				</tr>
				<tr>
					<th scope="row"><label for="mngrMemo">관리자설명</label></th>
					<td colspan="3"><form:input class="form-control w-full" path="mngrMemo" value="${couponVO.mngrMemo}" maxlength="100"  />
				</tr>
				<tr>
					<th scope="row"><span class="require">할인구분</span></th>
					<td>${dscntTy[couponVO.dscntTy]}</td>
					<th scope="row"><span class="require">할인금액/율</span></th>
					<td>${couponVO.dscntAmt}&nbsp; <c:if test="${couponVO.dscntTy eq 'PRCS'}">%</c:if>
					<c:if test="${couponVO.dscntTy eq 'SEMEN'}">원</c:if>
					</td>
				</tr>
				<tr>
					<th scope="row"><span class="require">최소구매금액</span></th>
					<td>${couponVO.mummOrdrAmt} <c:if test="${couponVO.mummOrdrAmt ne 0}">원 이상 구매 시 사용가능</c:if></td>
					<th scope="row">최대할인금액</th>
					<td>${couponVO.mxmmDscntAmt} <c:if test="${couponVO.mxmmDscntAmt ne 0}">원</c:if></td>
				</tr>
				<tr>
					<th scope="row"><label for="form-item3" class="require">발급기간</label></th>
					<td colspan="3">
						<div class="form-group">
							<fmt:formatDate value="${couponVO.issuBgngDt}" pattern="yyyy-MM-dd" />&nbsp;
							<fmt:formatDate value="${couponVO.issuBgngDt}" pattern="HH:mm" />
							<i>~</i>
							<fmt:formatDate value="${couponVO.issuEndDt}" pattern="yyyy-MM-dd" />&nbsp;
							<fmt:formatDate value="${couponVO.issuEndDt}" pattern="HH:mm" />
						</div>
					</td>
				</tr>
				<tr>
					<th scope="row">발급수량</th>
					<td colspan="3">
						<c:if test="${couponVO.issuQy ne '9999'}"><fmt:formatNumber value="${couponVO.issuQy}" /></c:if>
						<c:if test="${couponVO.issuQy eq '9999'}">무제한</c:if>
					</td>
				</tr>
				<tr>
					<th scope="row"><span class="require">발급방식</span></th>
					<td colspan="3">${issuTy[couponVO.issuTy]}</td>
				</tr>
				<tr>
					<th scope="row"><span class="require">사용기간/일수</span></th>
					<td colspan="3">
						<c:if test="${couponVO.usePdTy eq 'FIX'}">
							<fmt:formatDate value="${couponVO.useBgngYmd}" pattern="yyyy-MM-dd" />
							~
							<fmt:formatDate value="${couponVO.useEndYmd}" pattern="yyyy-MM-dd" />
						</c:if>
						<c:if test="${couponVO.usePdTy ne 'FIX'}">발행일로부터 ${couponVO.usePsbltyDaycnt}일</c:if>
					</td>
				</tr>
				<tr>
					<th scope="row"><label for="" class="require">상태</label></th>
					<td>
						<div class="form-check-group">
							<c:forEach var="useYn" items="${sttusTy}" varStatus="status">
								<div class="form-check">
									<form:radiobutton class="form-check-input" path="sttsTy" id="useYn${status.index}" value="${useYn.key}"  />
									<label class="form-check-label" for="useYn${status.index}">${useYn.value}</label>
								</div>
							</c:forEach>
						</div>
					</td>
				</tr>
				<tr>
					<th scope="row">최초등록일</th>
					<td>${couponVO.rgtr} (<fmt:formatDate value="${couponVO.regDt}" pattern="yyyy-MM-dd HH:mm" />)</td>
					<th scope="row">수정일</th>
					<td>${couponVO.mdfr}
							 <c:if test="${couponVO.mdfr ne NULL}">(</c:if>
							 <fmt:formatDate value="${couponVO.mdfcnDt}" pattern="yyyy-MM-dd HH:mm" />
							 <c:if test="${couponVO.mdfr ne NULL}">)</c:if>
					</td>
				</tr>
			</tbody>
		</table>
	</fieldset>

	<fieldset class="mt-13">
		<legend class="text-title2">쿠폰대상정보</legend>
		<table class="table-detail">
			<colgroup>
				<col class="w-43">
				<col>
			</colgroup>
			<tbody>
				<tr>
					<th scope="row"><span class="require">회원</span></th>
					<td>${issuMbr[couponVO.issuMbr]}</td>
				</tr>
			</tbody>
		</table>
	</fieldset>

	<fieldset class="mt-13">
		<legend class="text-title2">쿠폰적용상품</legend>
		<table class="table-detail">
			<colgroup>
				<col class="w-43">
				<col>
			</colgroup>
			<tbody>
				<tr>
					<th scope="row"><span class="require">상품</span></th>
					<td>${issuGds[couponVO.issuGds]}</td>
				</tr>
				<tr id="gdsView">
					<th scope="row"><span class="require">대상</span></th>
					<td>
						<table class="table-list">
							<colgroup>
								<col class="w-22">
								<col class="w-40">
								<col class="w-70">
								<col class="w-35">
								<col class="w-30">
							</colgroup>
							<thead>
								<tr>
									<th scope="col">NO</th>
									<th scope="col">상품코드</th>
									<th scope="col">상품명</th>
									<th scope="col">판매가</th>
									<th scope="col">판매여부</th>
								</tr>
							</thead>
							<tbody>
								<c:forEach var="gdsList" items="${itemList}" varStatus="status">
									<tr>
										<td>${gdsList.gdsNo}</td>
										<td><a href="#">${gdsList.gdsCd}</a></td>
										<td><a href="#" class="text-left block">${gdsList.gdsNm}</a></td>
										<td>${gdsList.pc}</td>
										<td>${useYn[gdsList.useYn]}</td>
									</tr>
								</c:forEach>
							</tbody>
						</table>
					</td>
				</tr>
			</tbody>
		</table>
	</fieldset>

	<c:set var="pageParam" value="curPage=${listVO.curPage}&amp;cntPerPage=${param.cntPerPage}&amp;sortBy=${param.sortBy}&amp;srchCouponTy=${param.srchCouponTy}&amp;srchCouponNm=${param.srchCouponNm}&amp;srchCouponCd=${param.srchCouponCd}
	&amp;srchIssuTy=${param.srchIssuTy}&amp;srchSttusTy=${param.srchSttusTy}&amp;srchDt=${param.srchDt}&amp;srchBgngDt=${param.srchBgngDt}&amp;srchEndDt=${param.srchEndDt}" />
	<div class="btn-group right mt-8">
		<button type="button" class="btn-primary large shadow" onclick="f_update();">저장</button>
		<a href="./list?${pageParam}" class="btn-secondary large shadow">목록</a>
	</div>
</form:form>

<script>

function f_update(frm){
	if(confirm("저장하시겠습니까?")){
		$("#couponFrm").submit();
	}else{
		return false;
	}
}

$(function(){

	//발급된 상태 일때 수정 불가
	if("${cnt}" > 0){
		$("#couponNm").attr("readonly",true);
		$("#mngrMemo").attr("readonly",true);
		$("#issuBgngDt").attr("readonly",true);
		$("#issuBgngTm").attr("readonly",true);
		$("#issuEndDt").attr("readonly",true);
		$("#issuEndTm").attr("readonly",true);
	}

	//개별 상품
	if("${couponVO.issuGds}" != "I"){
		$("#gdsView").hide();
	}
});
</script>
