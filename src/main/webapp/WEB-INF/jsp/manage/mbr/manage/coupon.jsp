<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<div id="page-content">
	<%@include file="./include/header.jsp"%>

	<table class="table-detail mt-13">
		<colgroup>
			<col class="w-43">
			<col>
			<col class="w-43">
			<col>
		</colgroup>
		<tbody>
			<tr>
				<th scope="row" rowspan="2">사용가능한 쿠폰</th>
				<td rowspan="2">${resultMap.avail} 개</td>
				<th scope="row">사용한 쿠폰</th>
				<td>${resultMap.used} 개</td>
			</tr>
			<tr>
				<th scope="row">만료된 쿠폰</th>
				<td rowspan="2">${resultMap.exit} 개</td>
			</tr>
		</tbody>
	</table>

	<form action="./coupon" class="mt-13" id="searchFrm" name="searchFrm" method="get">
	<input type="hidden" id="cntPerPage" name="cntPerPage" value="${param.cntPerPage}" />
		<fieldset>
			<legend class="text-title2">쿠폰 검색</legend>
			<table class="table-detail">
				<colgroup>
					<col class="w-43">
					<col>
				</colgroup>
				<tbody>
					<tr>
						<th scope="row"><label for="search-item4-1">유효기간</label></th>
						<td>
								<div class="form-group">
								<input type="date" class="form-control w-39 calendar" id="srchBgngDt" name="srchBgngDt" value="${param.srchBgngDt}">
								<i>~</i>
								 <input type="date" class="form-control w-39 calendar" id="srchEndDt" name="srchEndDt" value="${param.srchEndDt}">
								<button type="button" class="btn shadow" onclick="f_srchJoinSet('1'); return false;">오늘</button>
								<button type="button" class="btn shadow" onclick="f_srchJoinSet('2'); return false;">7일</button>
								<button type="button" class="btn shadow" onclick="f_srchJoinSet('3'); return false;">15일</button>
								<button type="button" class="btn shadow" onclick="f_srchJoinSet('4'); return false;">1개월</button>
							</div>
						</td>
					</tr>
					<tr>
						<th scope="row"><label for="search-item4-2">쿠폰종류</label></th>
						<td>
							<select name="srchCouponTy" id="srchCouponTy" class="form-control w-84">
								<option value="">전체</option>
								<c:forEach var="couponTy" items="${couponTyCode}">
									<option value="${couponTy.key}"<c:if test="${couponTy.key eq param.srchCouponTy}">selected="selected"</c:if>>${couponTy.value}</option>
								</c:forEach>
							</select>
						</td>
					</tr>
					<tr>
						<th scope="row"><label for="srchCouponNm">쿠폰명</label></th>
						<td><input type="text" class="form-control w-84" id="srchCouponNm" name="srchCouponNm" value="${param.srchCouponNm}"></td>
					</tr>
					<tr>
						<th scope="row"><label for="srchCouponCd">쿠폰번호</label></th>
						<td><input type="text" class="form-control w-84" id="srchCouponCd" name="srchCouponCd" value="${param.srchCouponCd}"></td>
					</tr>
				</tbody>
			</table>
		</fieldset>

		<div class="btn-group mt-5">
			<button type="submit" class="btn-primary large shadow w-52">검색</button>
		</div>
	</form>

	<p class="text-title2 mt-13">쿠폰 내역</p>
	<table class="table-list">
		<colgroup>
			<col class="w-23">
			<col class="w-33">
			<col class="w-[13%]">
			<col>
			<col class="w-31">
			<col class="w-32">
			<col class="w-32">
			<col class="w-35">
		</colgroup>
		<thead>
			<tr>
				<th scope="col">번호</th>
				<th scope="col">쿠폰번호</th>
				<th scope="col">쿠폰종류</th>
				<th scope="col">쿠폰명</th>
				<th scope="col">할인금액/율<br>(최대할인금액)
				</th>
				<th scope="col">유효기간</th>
				<th scope="col">사용일</th>
				<th scope="col">주문번호</th>
			</tr>
		</thead>
		<tbody>
			<c:set var="getNow" value="<%=new java.util.Date()%>" />
			<c:forEach var="resultList" items="${listVO.listObject}" varStatus="status">
			<tr>
				<td>${listVO.startNo - status.index}</td>
				<td>${resultList.couponCd}</td>
				<td>${couponTyCode[resultList.couponTy]}</td>
				<td>${resultList.couponNm }</td>
				<td><c:if test="${resultList.couponTy ne 'FREE'}">${resultList.dscntAmt}${resultList.dscntTy eq 'PRCS' ? '%' : '원'}<c:if test="${resultList.mxmmDscntAmt ne 0}"><br>(<fmt:formatNumber value="${resultList.mxmmDscntAmt}" pattern="###,###" />)</c:if></c:if>
						<c:if test="${resultList.couponTy eq 'FREE'}">배송비</c:if>
				</td>
				<td><c:if test="${resultList.usePdTy eq 'FIX' }"><fmt:formatDate value="${resultList.useBgngYmd}" pattern="yyyy-MM-dd" /> ~<br><fmt:formatDate value="${resultList.useEndYmd}" pattern="yyyy-MM-dd" /></c:if>
						<c:if test="${resultList.usePdTy eq 'ADAY'}"><fmt:formatDate value="${resultList.issuBgngDt}" pattern="yyyy-MM-dd" /> <br> 로 부터 ${resultList.usePsbltyDaycnt} 일</c:if>
				</td>
				<td><c:if test="${resultList.useBgngYmd < getNow && resultList.useEndYmd >= getNow }">
						<c:if test="${resultList.useYn eq 'Y'}"><fmt:formatDate value="${resultList.useDt}" pattern="yyyy-MM-dd HH:mm:ss" /></c:if>
						<c:if test="${resultList.useYn eq 'N'}">미사용</c:if></c:if>
						<c:if test="${resultList.useEndYmd < getNow}">소멸</c:if>
						</td>
				<td>
						<c:if test="${resultList.useBgngYmd < getNow && resultList.useEndYmd >= getNow }">
						<c:if test="${resultList.useYn eq 'Y'}">${resultList.ordrCd}</c:if>
						<c:if test="${resultList.useYn eq 'N'}">미사용</c:if></c:if>
						<c:if test="${resultList.useEndYmd < getNow}">소멸</c:if>
						</td>
			</tr>
			</c:forEach>
			<c:if test="${empty listVO.listObject}">
			<tr>
				<td class="noresult" colspan="8">검색조건을 만족하는 결과가 없습니다.</td>
			</tr>
			</c:if>
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


<script>
function f_srchJoinSet(ty){
  	//srchJoinBgng, srchJoinEnd
	$("#srchEndDt").val(f_getToday());
	if(ty == "1"){//오늘
   		$("#srchBgngDt").val(f_getToday());
	}else if(ty == "2"){//일주일
		$("#srchBgngDt").val(f_getDate(-7));
	}else if(ty == "3"){//15일
		$("#srchBgngDt").val(f_getDate(-15));
	}else if(ty == "4"){//한달
		$("#srchBgngDt").val(f_getDate(-30));
	}
}

$(function(){

});
</script>

