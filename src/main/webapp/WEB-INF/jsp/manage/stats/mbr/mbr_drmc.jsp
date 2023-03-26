<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<div id="content">

	<div id="page-content">
		<jsp:include page="../include/stats_navigation.jsp" />

	<form action="./drmc" class="mt-7.5" id="searchFrm" name="searchFrm">
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

		<p class="text-title2">현재 휴면회원 누계</p>
		<table class="table-list">
			<colgroup>
				<col>
				<col>
				<col>
			</colgroup>
			<thead>
				<tr>
					<th scope="col">전체</th>
					<th scope="col">휴면 회원</th>
					<th scope="col">전환 예상</th>
				</tr>
			</thead>
			<tbody>
				<tr>
					<td><fmt:formatNumber value="${resultMap.drmcTotal + resultMap.drmcEx}" pattern="###,###" /></td>
					<td><fmt:formatNumber value="${resultMap.drmcTotal}" pattern="###,###" /></td>
					<td><fmt:formatNumber value="${resultMap.drmcEx}" pattern="###,###" /></td>
				</tr>
			</tbody>
		</table>

		<p class="text-title2 mt-13">조회결과</p>
		<div class="scroll-table">
			<table class="table-list">
				<colgroup>
					<col class="min-w-35 w-35">
					<col>
					<col>
				</colgroup>
				<thead>
					<tr>
						<th scope="col">기간</th>
						<th scope="col">휴면회원 전환 수</th>
						<th scope="col">전환예상 수</th>
					</tr>
				</thead>
				<tbody>
					<c:if test="${empty resultList}">
						<tr>
							<td class="noresult" colspan="3">검색조건을 선택 하신 후, 검색해 주세요.</td>
						</tr>
					</c:if>

					<c:set var="sumDrmc" value="0" />
					<c:set var="sumWdrmc" value="0" />

					<c:forEach var="result" items="${resultList}">
						<c:set var="sumDrmc" value="${sumDrmc + result.drmc}" />
						<c:set var="sumWdrmc" value="${sumWdrmc +result.wdrmc}" />

						<tr>
							<td>	${result.date}</td>
							<td><fmt:formatNumber value="${result.drmc}" pattern="###,###" /></td>
							<td><fmt:formatNumber value="${result.wdrmc}" pattern="###,###" /></td>
						</tr>

					</c:forEach>

					<tr class="total">
						<td>합계</td>
						<td><fmt:formatNumber value="${sumDrmc}" pattern="###,###" /></td>
						<td><fmt:formatNumber value="${sumWdrmc}" pattern="###,###" /></td>
					</tr>
				</tbody>
			</table>
		</div>
	</div>
	<!-- //page content -->
</div>

<script>
$(function(){

	//엑셀
	$("#btn-excel").on("click",function(){
		$("#searchFrm").attr("action","drmcExcel");
		$("#searchFrm").submit();
		$("#searchFrm").attr("action","./drmc");
	});
});
</script>
