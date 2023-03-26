<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!-- page content -->
<div id="page-content">
	<jsp:include page="./include/tab.jsp" />

	<form action="#" class="mt-7.5" id="searchFrm">
		<fieldset>
			<legend class="text-title2">검색</legend>
			<table class="table-detail">
				<colgroup>
					<col class="w-43">
					<col>
				</colgroup>
				<tbody>
					<tr>
						<th scope="row"><label for="search-item1">조회기간</label></th>
						<td>
							<div class="form-group">
                               <input type="date" class="form-control w-39 calendar" id="srchOrdrYmdBgng" name="srchOrdrYmdBgng" value="${srchOrdrYmdBgng}">
                               <i>~</i>
                               <input type="date" class="form-control w-39 calendar" id="srchOrdrYmdEnd" name="srchOrdrYmdEnd" value="${srchOrdrYmdEnd}">
                               <button type="button" class="btn shadow" onclick="f_srchOrdrYmdSet('1'); return false;">오늘</button>
	                            <button type="button" class="btn shadow" onclick="f_srchOrdrYmdSet('2'); return false;">7일</button>
	                            <button type="button" class="btn shadow" onclick="f_srchOrdrYmdSet('3'); return false;">15일</button>
	                            <button type="button" class="btn shadow" onclick="f_srchOrdrYmdSet('4'); return false;">1개월</button>
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

	<div class="mt-13 text-right mb-2">
		<button type="button" class="btn-primary" id="btn-excel">엑셀 다운로드</button>
	</div>

	<p class="text-title2 mt-13">조회결과</p>
	<div class="scroll-table">
		<table class="table-list">
			<colgroup>
				<col class="min-w-35 w-35">
				<col class="min-w-25">
				<col class="min-w-25">
				<col class="min-w-30">
				<col class="min-w-25">
				<col class="min-w-30">
				<col class="min-w-25">
			</colgroup>
			<thead>
				<tr>
					<th scope="col" rowspan="2">일자</th>
					<th scope="col" rowspan="2">판매건수</th>
					<th scope="col" rowspan="2">마일리지<br> 사용 주문건수
					</th>
					<th scope="colgroup" colspan="3">사용현황</th>
					<th scope="col" rowspan="2">적립마일리지</th>
				</tr>
				<tr>
					<th scope="col">판매금액</th>
					<th scope="col">사용 마일리지</th>
					<th scope="col" class="nolast">마일리지 사용 결제 금액</th>
				</tr>
			</thead>
			<tbody>

				<c:if test="${!empty resultList}">
					<c:set var="totalACnt" value="0" />
					<c:set var="totalBCnt" value="0" />
					<c:set var="totalBSum" value="0" />

					<c:set var="totalMlgSum" value="0" />
					<c:set var="totalStlmSum" value="0" />
					<c:set var="totalAccmlMlg" value="0" />


					<c:forEach items="${resultList}" var="result" varStatus="status">
						<c:set var="totalACnt" value="${totalACnt + result.totalACnt}" />
						<c:set var="totalBCnt" value="${totalBCnt + result.totalBCnt}" />
						<c:set var="totalBSum" value="${totalBSum + result.totalBSum}" />

						<c:set var="totalMlgSum" value="${totalMlgSum + result.totalMlgSum}" />
						<c:set var="totalStlmSum" value="${totalStlmSum + result.totalStlmSum}" />
						<c:set var="totalAccmlMlg" value="${totalAccmlMlg + result.totalAccmlMlg}" />
						<tr>
							<td>${result.ordrDt}</td>
							<td class="text-right"><fmt:formatNumber value="${result.totalACnt}" pattern="###,###" /></td>
							<td class="text-right"><fmt:formatNumber value="${result.totalBCnt}" pattern="###,###" /></td>
							<td class="text-right"><fmt:formatNumber value="${result.totalBSum}" pattern="###,###" /></td>
							<td class="text-right"><fmt:formatNumber value="${result.totalMlgSum}" pattern="###,###" /></td>
							<td class="text-right"><fmt:formatNumber value="${result.totalStlmSum}" pattern="###,###" /></td>
							<td class="text-right"><fmt:formatNumber value="${result.totalAccmlMlg}" pattern="###,###" /></td>
						</tr>
					</c:forEach>

					<tr class="total">
						<td>합계</td>
						<td class="text-right"><fmt:formatNumber value="${totalACnt}" pattern="###,###" /></td>
						<td class="text-right"><fmt:formatNumber value="${totalACnt}" pattern="###,###" /></td>
						<td class="text-right"><fmt:formatNumber value="${totalBSum}" pattern="###,###" /></td>
						<td class="text-right"><fmt:formatNumber value="${totalMlgSum}" pattern="###,###" /></td>
						<td class="text-right"><fmt:formatNumber value="${totalStlmSum}" pattern="###,###" /></td>
						<td class="text-right"><fmt:formatNumber value="${totalAccmlMlg}" pattern="###,###" /></td>
					</tr>
				</c:if>
				<c:if test="${empty resultList}">
					<tr>
						<td class="noresult" colspan="7">검색조건을 만족하는 결과가 없습니다.</td>
					</tr>
				</c:if>
			</tbody>
		</table>
	</div>
</div>
<!-- //page content -->

<script>

function f_srchOrdrYmdSet(ty){
	//srchOrdrYmdBgng, srchOrdrYmdEnd
	$("#srchOrdrYmdEnd").val(f_getToday());
	if(ty == "1"){//오늘
   		$("#srchOrdrYmdBgng").val(f_getToday());
	}else if(ty == "2"){//일주일
		$("#srchOrdrYmdBgng").val(f_getDate(-7));
	}else if(ty == "3"){//15일
		$("#srchOrdrYmdBgng").val(f_getDate(-15));
	}else if(ty == "4"){//한달
		$("#srchOrdrYmdBgng").val(f_getDate(-30));
	}
}

	$(function(){
		$("#btn-excel").on("click",function(){
			$("#searchFrm").attr("action","./mlgExcel");
			$("#searchFrm").submit();
			$("#searchFrm").attr("action","./mlg");
		});
	});
 </script>