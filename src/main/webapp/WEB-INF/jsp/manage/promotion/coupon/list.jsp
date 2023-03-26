<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery-modal/0.9.1/jquery.modal.min.js"></script>
<form action="./list" id="searchFrm" name="searchFrm" method="get">
	<input type="hidden" name="cntPerPage" id="cntPerPage" value="${listVO.cntPerPage}" />
	<input type="hidden" name="sortBy" id="sortBy" value="${param.sortBy}" />

	<fieldset>
		<legend class="text-title2">쿠폰 검색</legend>
		<table class="table-detail">
			<colgroup>
				<col class="w-43">
				<col>
			</colgroup>
			<tbody>
				<tr>
					<th scope="row"><label for="srchCouponTy">쿠폰종류</label></th>
					<td>
						<select name="srchCouponTy" id="srchCouponTy" class="form-control w-60">
								<option value="" selected>전체</option>
								<c:forEach var="couponTy" items="${couponTy}">
									<option value="${couponTy.key}" <c:if test="${couponTy.key eq param.srchCouponTy }">selected="selected"</c:if>>${couponTy.value}</option>
								</c:forEach>
						</select>
					</td>
				</tr>
				<tr>
					<th scope="row"><label for="srchCouponNm">고객쿠폰명</label></th>
					<td><input type="text" class="form-control w-84" id="srchCouponNm" name="srchCouponNm" value="${param.srchCouponNm }"></td>
				</tr>
				<tr>
					<th scope="row"><label for="srchCouponCd">쿠폰번호</label></th>
					<td><input type="text" class="form-control w-84" id="srchCouponCd" name="srchCouponCd" value="${param.srchCouponCd}"></td>
				</tr>
				<tr>
					<th scope="row"><label for="srchIssuTy">발급방식</label></th>
					<td>
						<select name="srchIssuTy" id="srchIssuTy" class="form-control w-60">
								<option value="">전체</option>
								<c:forEach var="issuTy" items="${issuTy}">
									<option value="${issuTy.key}"<c:if test="${issuTy.key eq param.srchIssuTy }">selected="selected"</c:if>>${issuTy.value}</option>
								</c:forEach>
						</select>
					</td>
				</tr>
				<tr>
					<th scope="row"><label for="">상태</label></th>
					<td>
						<div class="form-check-group w-60">
							<div class="form-check">
								<input class="form-check-input" type="radio" name="srchSttusTy" id="srchSttusTy" value="" checked>
								<label class="form-check-label" for="srchSttusTy">전체</label>
							</div>
							<c:forEach var="sttusTy" items="${sttusTy}" varStatus="status">
								<div class="form-check">
									<input class="form-check-input" type="radio" name="srchSttusTy" id="srchSttusTy${status.index}" value="${sttusTy.key}" <c:if test="${param.srchSttusTy eq sttusTy.key}">checked="checked"</c:if>>
									<label class="form-check-label" for="srchSttusTy${status.index}">${sttusTy.value }</label>
								</div>
							</c:forEach>
						</div>
					</td>
				</tr>
				<tr>
					<th scope="row"><label for="srchDt">기간</label></th>
					<td>
						<div class="form-group w-100">
							<select class="form-control w-25" id="srchDt" name="srchDt">
								<option value="regDt" selected>등록일</option>
								<option value="issuDy">발급기간</option>
							</select>
								<input type="date" class="form-control flex-1 calendar" id="srchBgngDt" name="srchBgngDt" value="${param.srchBgngDt}">
								<i>~</i>
								<input type="date" class="form-control flex-1 calendar" id="srchEndDt" name="srchEndDt" value="${param.srchEndDt}">
						</div>
					</td>
				</tr>
			</tbody>
		</table>
	</fieldset>

	<div class="btn-group mt-5">
		<button type="submit" class="btn-primary large shadow w-52">검색</button>
	</div>
</form>


<p class="text-title2 mt-13">쿠폰 목록</p>
<div class="scroll-table">
	<table class="table-list">
		<colgroup>
			<col class="min-w-20 w-20">
			<col class="min-w-25 w-25">
			<col class="min-w-60">
			<col class="min-w-30 w-30">
			<col class="min-w-45 w-45">
			<col class="min-w-45 w-45">
			<col class="min-w-25 w-25">
			<col class="min-w-20 w-20">
			<col class="min-w-25 w-25">
			<col class="min-w-35 w-35">
		</colgroup>
		<thead>
			<tr>
				<th scope="col">번호</th>
				<th scope="col">쿠폰종류</th>
				<th scope="col">고객쿠폰명</th>
				<th scope="col">할인금액/율<br> (최대할인금액)
				</th>
				<th scope="col">발급기간</th>
				<th scope="col">사용기간</th>
				<th scope="col">발급수량</th>
				<th scope="col">상태</th>
				<th scope="col">등록자</th>
				<th scope="col">등록일</th>
			</tr>
		</thead>
		<tbody>
			<c:forEach var="resultList" items="${listVO.listObject}" varStatus="status">
			<c:set var="pageParam" value="curPage=${listVO.curPage}&amp;cntPerPage=${param.cntPerPage}&amp;sortBy=${param.sortBy}&amp;srchCouponTy=${param.srchCouponTy}&amp;srchCouponNm=${param.srchCouponNm}&amp;srchCouponCd=${param.srchCouponCd}
			&amp;srchIssuTy=${param.srchIssuTy}&amp;srchSttusTy=${param.srchSttusTy}&amp;srchDt=${param.srchDt}&amp;srchBgngDt=${param.srchBgngDt}&amp;srchEndDt=${param.srchEndDt}" />
			<tr>
				<td>${listVO.startNo - status.index}</td>
				<td>${couponTy[resultList.couponTy]}</td>
				<td class="text-left whitespace-normal" ><a href="./view?couponNo=${resultList.couponNo}&${pageParam}">
					<c:if test="${resultList.issuMbrGrad ne '' && resultList.issuMbrGrad ne NULL}">[</c:if>
						${grade[resultList.issuMbrGrad]}
					<c:if test="${resultList.issuMbrGrad ne '' && resultList.issuMbrGrad ne NULL }">]</c:if>
						&nbsp;&nbsp; ${resultList.couponNm}</a></td>
				<c:if test="${resultList.couponTy ne 'FREE' }">
					<td>${resultList.dscntAmt}<c:if test="${resultList.dscntTy eq 'PRCS'}">%</c:if><c:if test="${resultList.dscntTy eq 'SEMEN'}">원</c:if><br>
						(<fmt:formatNumber value="${resultList.mummOrdrAmt}" pattern="###,###" />)
					</td>
				</c:if>
				<c:if test="${resultList.couponTy eq 'FREE' }"><td>-</td></c:if>
				</td>
				<td><fmt:formatDate value="${resultList.issuBgngDt}" pattern="yyyy-MM-dd"/>
						~
						<fmt:formatDate value="${resultList.issuEndDt}" pattern="yyyy-MM-dd" />
				</td>
				<td>
					<c:if test="${resultList.usePdTy eq 'FIX'}"><fmt:formatDate value="${resultList.useBgngYmd}" pattern="yyyy-MM-dd" /> ~ <fmt:formatDate value="${resultList.useEndYmd}" pattern="yyyy-MM-dd" /></c:if>
					<c:if test="${resultList.usePdTy eq 'ADAY'}">발급일로 부터 ${resultList.usePsbltyDaycnt}일</c:if>
				</td>
				<td>
					<button type="button" class="cntList btn shadow w-full" data-cpn-no="${resultList.couponNo}" data-cpn-nm="${resultList.couponNm}">
						<c:if test="${resultList.issuQy eq '9999'}">무제한</c:if>
						<c:if test="${resultList.issuQy ne '9999'}">${resultList.issuQy}</c:if>
					</button>
				</td>
				<td>${sttusTy[resultList.sttsTy]}</td>
				<td>${resultList.rgtr}
				</td>
				<td><fmt:formatDate value="${resultList.regDt}" pattern="yyyy-MM-dd HH:mm" /></td>
			</tr>

			</c:forEach>
			<c:if test="${empty listVO.listObject}">
				<tr>
					<td class="noresult" colspan="10">검색조건을 만족하는 결과가 없습니다.</td>
				</tr>
			</c:if>
		</tbody>
	</table>
</div>

<div id="CountListZn">

</div>


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
<div class="btn-group right mt-8">
	<a href="./form?${pageParam}" class="btn-primary large shadow">등록</a>
</div>


<script>
	$(function(){

		$(".cntList").on("click",function(){
			console.log($(this).data("cpnNo"));
			var param = {couponNo : $(this).data("cpnNo")
								, couponNm : $(this).data("cpnNm")};

				$("#CountListZn")	.load(
						"/_mng/promotion/coupon/couponCntList"
						, param
						, function(obj){
							$("#listModal").modal("show");
					});
		});

	});
</script>
