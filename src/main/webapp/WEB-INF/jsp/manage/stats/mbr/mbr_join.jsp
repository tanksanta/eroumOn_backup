<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<div id="page-content">
	<jsp:include page="../include/stats_navigation.jsp" />

	<form action="./join" class="mt-7.5" id="searchFrm" name="searchFrm">
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
								<select name="srchRegDt" id="srchRegDt" class="form-control w-32">
									<option value="DAY"<c:if test="${param.srchRegDt eq 'DAY'}">selected=selected</c:if>>일별조회</option>
									<option value="MONTH" <c:if test="${param.srchRegDt eq 'MONTH'}">selected=selected</c:if>>월별조회</option>
									<option value="YEAR" <c:if test="${param.srchRegDt eq 'YEAR'}">selected=selected</c:if>>연별조회</option>
								</select>
								<input type="date" class="form-control w-39 calendar" id="srchBgngDt" name="srchBgngDt" value="${param.srchBgngDt}">
									<i>~</i>
								<input type="date" class="form-control w-39 calendar" id="srchEngDt" name="srchEndDt" value="${param.srchEndDt}">
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
		<button type="submit" class="btn-primary" id="btn-excel">엑셀 다운로드</button>
	</div>

	<p class="text-title2">현재 회원 누계</p>
	<table class="table-list">
		<colgroup>
			<col>
			<col>
			<col>
		</colgroup>
		<thead>
			<tr>
				<th scope="col">전체</th>
				<th scope="col">일반 회원</th>
				<th scope="col">수급자 회원</th>
			</tr>
		</thead>
		<tbody>
			<tr>
				<td><fmt:formatNumber value="${resultMap.total}" pattern="###,###" /></td>
				<td><fmt:formatNumber value="${resultMap.normal}" pattern="###,###" /></td>
				<td><fmt:formatNumber value="${resultMap.recipter}" pattern="###,###" /></td>
			</tr>
		</tbody>
	</table>

	<p class="text-title2 mt-13">조회결과</p>
	<div class="scroll-table">
		<table class="table-list">
			<colgroup>
				<col class="min-w-35 w-35">
				<col class="min-w-25">
				<col class="min-w-25">
				<col class="min-w-25">
				<col class="min-w-25">
				<col class="min-w-25">
				<col class="min-w-25">
			</colgroup>
			<thead>
				<tr>
					<th scope="col" rowspan="2">기간</th>
					<th scope="colgroup" colspan="2">일반 회원</th>
					<th scope="colgroup" colspan="2">수급자 회원</th>
					<th scope="colgroup" colspan="2">전체</th>
				</tr>
				<tr>
					<th scope="col">가입</th>
					<th scope="col">탈퇴</th>
					<th scope="col">가입</th>
					<th scope="col">탈퇴</th>
					<th scope="col">가입</th>
					<th scope="col">탈퇴</th>
				</tr>
			</thead>
			<tbody>
				<c:if test="${empty resultList}">
					<tr>
						<td class="noresult" colspan="7">검색조건을 만족하는 결과가 없습니다.</td>
					</tr>
				</c:if>

					<c:set var="sumNjoin" value="0" />
					<c:set var="sumNexit" value="0" />
					<c:set var="sumRjoin" value="0" />
					<c:set var="sumRexit" value="0" />
					<c:set var="sumJtotal" value="0" />
					<c:set var="sumEtotal" value="0" />

				<c:forEach var="result" items="${resultList}">
					<c:set var="sumNjoin" value="${sumTotal + result.njoin}" />
					<c:set var="sumNexit" value="${sumMnChild +result.nexit}" />
					<c:set var="sumRjoin" value="${sumMnTwenty + result.rjoin}" />
					<c:set var="sumRexit" value="${sumMnThirty + result.rexit}" />
					<c:set var="sumJtotal" value="${sumMnForty + result.jtotal}" />
					<c:set var="sumEtotal" value="${sumMnFifty + result.etotal}" />

					<tr>
						<td>	${result.date}</td>
						<td class="text-right"><fmt:formatNumber value="${result.njoin}" pattern="###,###" /></td>
						<td class="text-right"><fmt:formatNumber value="${result.nexit}" pattern="###,###" /></td>
						<td class="text-right"><fmt:formatNumber value="${result.rjoin}" pattern="###,###" /></td>
						<td class="text-right"><fmt:formatNumber value="${result.rexit}" pattern="###,###" /></td>
						<td class="text-right"><fmt:formatNumber value="${result.jtotal}" pattern="###,###" /></td>
						<td class="text-right"><fmt:formatNumber value="${result.etotal}" pattern="###,###" /></td>
					</tr>
				</c:forEach>

				<tr class="total">
						<td>합계</td>
						<td class="text-right"><fmt:formatNumber value="${sumNjoin}" pattern="###,###" /></td>
						<td class="text-right"><fmt:formatNumber value="${sumNexit}" pattern="###,###" /></td>
						<td class="text-right"><fmt:formatNumber value="${sumRjoin}" pattern="###,###" /></td>
						<td class="text-right"><fmt:formatNumber value="${sumRexit}" pattern="###,###" /></td>
						<td class="text-right"><fmt:formatNumber value="${sumJtotal}" pattern="###,###" /></td>
						<td class="text-right"><fmt:formatNumber value="${sumEtotal}" pattern="###,###" /></td>
					</tr>

			</tbody>
		</table>
	</div>
</div>
<script>
$(function(){

	//엑셀
	$("#btn-excel").on("click",function(){
		$("#searchFrm").attr("action","joinExcel");
		$("#searchFrm").submit();
		$("#searchFrm").attr("action","./join");
	});
});
</script>