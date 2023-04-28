<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<div id="page-content">
	<%@include file="./include/header.jsp"%>

	<form action="./ordr" class="mt-13" id="searchFrm" name="searchFrm" method="get">
		<input type="hidden" id="cntPerPage" name="cntPerPage" value="${param.cntPerPage}" />

		<fieldset>
			<legend class="text-title2">주문 검색</legend>
			<table class="table-detail">
				<colgroup>
					<col class="w-43">
					<col>
				</colgroup>
				<tbody>
					<tr>
						<th scope="row"><label for="search-item2-1">주문기간</label></th>
						<td>
							<div class="form-group">
								<input type="date" class="form-control w-39 calendar" id="srchBgngDt" name="srchBgngDt" value="${param.srchBgngDt}"> <i>~</i> <input type="date" class="form-control w-39 calendar" id="srchEndDt" name="srchEndDt" value="${param.srchEndDt}">
								<button type="button" class="btn shadow" onclick="f_srchJoinSet('1'); return false;">오늘</button>
								<button type="button" class="btn shadow" onclick="f_srchJoinSet('2'); return false;">7일</button>
								<button type="button" class="btn shadow" onclick="f_srchJoinSet('3'); return false;">15일</button>
								<button type="button" class="btn shadow" onclick="f_srchJoinSet('4'); return false;">1개월</button>
							</div>
						</td>
					</tr>
					<tr>
						<th scope="row"><label for="srchOrdrCd">주문번호</label></th>
						<td><input type="text" class="form-control w-84" id="srchOrdrCd" name="srchOrdrCd" value="${param.srchOrdrCd}"></td>
					</tr>
					<tr>
						<th scope="row"><label for="search-item2-3">주문상태</label></th>
						<td>
							<select name="srchSttsTy" id="srchSttsTy" class="form-control w-84">
								<option value="">전체</option>
								<c:forEach var="sttsTy" items="${sttsTyCode}">
									<option value="${sttsTy.key}"<c:if test="${sttsTy.key eq  param.srchSttsTy}">selected="selected"</c:if>>${sttsTy.value}</option>
								</c:forEach>
							</select>
						</td>
					</tr>
					<tr>
						<th scope="row"><label for="search-item2-4">주문매체</label></th>
						<td>
							<div class="form-check-group">
								<div class="form-check">
									<input class="form-check-input" type="radio" name="srchStlmDevice" id="srchStlmDevice" value="" checked>
									<label class="form-check-label" for="srchStlmDevice">전체</label>
								</div>
								<c:forEach var="ordrDevice" items="${ordrCoursCode}" varStatus="status">
									<div class="form-check">
										<input class="form-check-input" type="radio" name="srchStlmDevice" id="srchStlmDevice${status.index}" value="${ordrDevice.key}"<c:if test="${ordrDevice.key eq param.srchStlmDevice}">checked="checked"</c:if>>
										<label class="form-check-label" for="srchStlmDevice${status.index}">${ordrDevice.value}</label>
									</div>
								</c:forEach>
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

	<p class="text-title2 mt-13">주문 내역</p>
	<div class="scroll-table">
		<table class="table-list">
			<colgroup>
				<col class="min-w-31">
				<col class="min-w-31">
				<col class="min-w-35">
				<col class="min-w-35">
				<col class="min-w-23">
				<col class="min-w-28">
				<col class="min-w-30">
				<col class="min-w-28">
				<col class="min-w-28">
				<col class="min-w-38">
			</colgroup>
			<thead>
				<tr>
					<th scope="col">주문일시<br>(주문번호)
					</th>
					<th scope="col">주문자</th>
					<th scope="col">상품코드</th>
					<th scope="col">상품명</th>
					<th scope="col">수량</th>
					<th scope="col">결제금액</th>
					<th scope="col">주문상태</th>
					<th scope="col">주문매체</th>
					<th scope="col">결제수단</th>
					<th scope="col">택배사</th>
				</tr>
			</thead>
			<tbody>
				<c:forEach var="resultList" items="${listVO.listObject}" varStatus="status">
				<tr>
					<td><fmt:formatDate value="${resultList.regDt}" pattern="yyyy-MM-dd" /><br>
						<button type="button" class="btn shadow f_gds_dtl" data-ordr-cd="${resultList.ordrCd}">(${resultList.ordrCd })</button>
					</td>
					<td>${resultList.ordrrNm}<br>(${resultList.ordrrId})
					</td>
					<td>${resultList.gdsInfo.gdsCd}</td>
					<td>${resultList.gdsInfo.gdsNm}</td>
					<td><fmt:formatNumber value="${resultList.ordrQy}" pattern="###,###" /></td>
					<td><fmt:formatNumber value="${resultList.stlmAmt}" pattern="###,###" /></td>
					<td>${sttsTyCode[resultList.sttsTy]}<!--<a href="#"> (000) </a>--></td>
					<td>${ordrCoursCode[resultList.stlmDevice]}</td>
					<td>${stlmTyCode[resultList.stlmTy]}</td>
					<td>${resultList.dlvyCoNm}</td>
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


	<div id="ordr-dtl"></div>
</div>

<script>
	function f_srchJoinSet(ty) {
		//srchJoinBgng, srchJoinEnd
		$("#srchEndDt").val(f_getToday());
		if (ty == "1") {//오늘
			$("#srchBgngDt").val(f_getToday());
		} else if (ty == "2") {//일주일
			$("#srchBgngDt").val(f_getDate(-7));
		} else if (ty == "3") {//15일
			$("#srchBgngDt").val(f_getDate(-15));
		} else if (ty == "4") {//한달
			$("#srchBgngDt").val(f_getDate(-30));
		}
	}

	$(function() {

		// 회원 포인트, 마일리지 클릭시 이동
		if("${param.mbrOrdrCd}" != null && "${param.mbrOrdrCd}" != ''){
			var ordrCd = "${param.mbrOrdrCd}";
			$("#ordr-dtl").load("/_mng/ordr/include/ordrDtlView"
	    			, {ordrCd:ordrCd}
	    			, function(){
	            		$("#dtl-modal").addClass('fade').modal('show');
	    			});
		}

    	//상품상세
    	$(".f_gds_dtl").on("click", function(e){
    		e.preventDefault();
    		console.log("실행");
    		var ordrCd = $(this).data("ordrCd");
    		$("#ordr-dtl").load("/_mng/ordr/include/ordrDtlView"
    			, {ordrCd:ordrCd}
    			, function(){
            		$("#dtl-modal").addClass('fade').modal('show');
    			});
    	});


	});
</script>