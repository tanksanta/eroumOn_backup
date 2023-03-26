<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<div id="page-content">
	<%@include file="../include/header.jsp" %>

	<form action="./list" class="mt-13" method="get" id="searchFrm" name="searchFrm">
		<input type="hidden" name="cntPerPage" id="cntPerPage" value="${listVO.cntPerPage}" />
		<input type="hidden" name="sortBy" id="sortBy" value="${param.sortBy}" />
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
								<input type="date" class="form-control w-39 calendar" id="srchOrderBgng" name="srchOrderBgng" value="${param.srchOrderBgng}">
								<i>~</i>
								<input type="date" class="form-control w-39 calendar" id="srchOrderEnd" name="srchOrderEnd" value="${param.srchOrderEnd}">
								<button type="button" class="btn shadow" onclick="f_srchOrderSet('1'); return false;">오늘</button>
								<button type="button" class="btn shadow" onclick="f_srchOrderSet('2'); return false;">일주일</button>
								<button type="button" class="btn shadow" onclick="f_srchOrderSet('3'); return false;">15일</button>
								<button type="button" class="btn shadow" onclick="f_srchOrderSet('4'); return false;">한달</button>
							</div>
						</td>
					</tr>
					<tr>
						<th scope="row"><label for="search-item2-2">주문번호</label></th>
						<td><input type="text" class="form-control w-84" id="srchOrdrCd" name="srchOrdrCd" value="${param.srchOrdrCd }"></td>
					</tr>
					<tr>
						<th scope="row"><label for="search-item2-3">주문상태</label></th>
						<td><select name="srchDlvyStts" id="srchDlvyStts" class="form-control w-84">
								<option value="">전체</option>
						</select></td>
					</tr>
					<tr>
						<th scope="row"><label for="search-item2-4">답변상태</label></th>
						<td>
							<div class="form-check-group">
								<div class="form-check">
									<input class="form-check-input" type="radio" name="aaa" id="search-item2-4" checked> <label class="form-check-label" for="search-item2-4">전체</label>
								</div>
								<div class="form-check">
									<input class="form-check-input" type="radio" name="aaa" id="search-item2-4-2"> <label class="form-check-label" for="search-item2-4-2">PC</label>
								</div>
								<div class="form-check">
									<input class="form-check-input" type="radio" name="aaa" id="search-item2-4-3"> <label class="form-check-label" for="search-item2-4-3">MOBILE</label>
								</div>
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
					<td><%--<fmt:formatDate value="${resultList.ordrDt}" pattern="yyyy-MM-dd" /><br> <a href="#">${resultList.ordrCd }</a>--%>
					</td>
					<td><%-- ${resultList.ordrrNm} --%><br>(EROUM2022)
					</td>
					<td>M18030043001</td>
					<td>MIRAGE7(22D)</td>
					<td>100</td>
					<td>1,999,000</td>
					<td>배송중<a href="#">(000)</a></td>
					<td>MOBILE</td>
					<td>신용카드</td>
					<td>에이씨티앤코아물류</td>
				</tr>
				<c:if test="${empty listVO.listObject}">
				<tr>
					<td class="noresult" colspan="10">검색조건을 만족하는 결과가 없습니다.</td>
				</tr>
				</c:if>
				</c:forEach>
			</tbody>
		</table>
	</div>

	<div class="pagination mt-7">
		<mngr:mngrPaging listVO="${listVO}" />
			<div class="sorting2">
				<label for="countPerPage">출력</label>
				 <select name="countPerPage" id="countPerPage" class="form-control">
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
function f_srchOrderSet(ty){
	$("#srchOrderEnd").val(f_getToday());
	if(ty == "1"){//오늘
   		$("#srchOrderBgng").val(f_getToday());
	}else if(ty == "2"){//일주일
		$("#srchOrderBgng").val(f_getDate(-7));
	}else if(ty == "3"){//15일
		$("#srchOrderBgng").val(f_getDate(-15));
	}else if(ty == "4"){//한달
		$("#srchOrderBgng").val(f_getDate(-30));
	}
}
</script>
