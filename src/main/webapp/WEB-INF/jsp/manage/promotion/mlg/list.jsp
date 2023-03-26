<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<div id="page-content">
	<form action="./list" id="searchFrm" name="searchFrm" method="get">
		<input type="hidden" name="cntPerPage" id="cntPerPage" value="${listVO.cntPerPage}" />
		<input type="hidden" name="sortBy" id="sortBy" value="${param.sortBy}" />

		<fieldset>
			<legend class="text-title2">마일리지 검색</legend>
			<table class="table-detail">
				<colgroup>
					<col class="w-43">
					<col>
				</colgroup>
				<tbody>
					<tr>
						<th scope="row"><label for="search-item1">기간</label></th>
						<td>
							<div class="form-group w-84">
								<input type="date" class="form-control flex-1 calendar" id="srchBgngDt" name="srchBgngDt" value="${param.srchBgngDt}" /> <i>~</i> <input type="date" class="form-control flex-1 calendar" id="srchEndDt" name="srchEndDt" value="${param.srchEndDt}" />
							</div>
						</td>
					</tr>
					<tr>
						<th scope="row"><label for="srchMngrId">관리자 아이디</label></th>
						<td><input type="text" class="form-control w-84" id="srchMngrId" name="srchMngrId" value="${param.srchMngrId}"></td>
					<tr>
					<tr>
						<th scope="row"><label for="search-item3">관리자 메모</label></th>
						<td><input type="text" class="form-control w-full" id="srchMngMemo" name="srchMngMemo" value="${param.srchMngMemo}" /></td>
					</tr>
					<tr>
						<th scope="row"><label for="srchMlgSe">포인트 구분</label></th>
						<td>
							<div class="form-group w-84">
								<select name="srchMlgSe" id="srchMlgSe" class="form-control w-30">
									<option value="">전체</option>
									<c:forEach var="mlgSe" items="${mlgSeCode}">
										<option value="${mlgSe.key}"<c:if test="${mlgSe.key eq param.srchMlgSe}">selected="selected"</c:if>>${mlgSe.value}</option>
									</c:forEach>
								</select>
								<select name="srchMlgCn" id="srchMlgCn" class="form-control flex-1">
									<option value="">선택</option>
									<c:forEach var="mlgCn" items="${mlgCnCode}">
										<option value="${mlgCn.key}"<c:if test="${mlgCn.key eq param.srchMlgCn}">selected="selected"</c:if>>${mlgCn.value}</option>
									</c:forEach>
								</select>
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

	<p class="text-right mt-13 mb-3">
		<button type="submit" class="btn-primary" id="excel-btn">엑셀 다운로드</button>
	</p>

	<p class="text-title2">마일리지 목록</p>
	<table class="table-list">
		<colgroup>
			<col class="w-22">
			<col class="w-22">
			<col class="min-w-20">
			<col>
			<col class="w-26">
			<col class="w-24">
			<col class="w-24">
			<col class="w-25">
			<col class="w-35">
		</colgroup>
		<thead>
			<tr>
				<th scope="col">번호</th>
				<th scope="col">구분</th>
				<th scope="col">내역</th>
				<th scope="col">관리자메모</th>
				<th scope="col">개별 마일리지</th>
				<th scope="col">대상 인원수</th>
				<th scope="col">총 마일리지</th>
				<th scope="col">처리자</th>
				<th scope="col">처리일</th>
			</tr>
		</thead>
		<tbody>
			<c:forEach var="resultList" items="${listVO.listObject}" varStatus="status">
			<c:set var="pageParam" value="" />
				<tr>
					<td>${listVO.startNo - status.index}</td>
					<td>${mlgSeCode[resultList.mlgSe]}</td>
					<td>${mlgCnCode[resultList.mlgCn]}</td>
					<td class="text-left whitespace-normal">${resultList.mngrMemo}</td>
					<td class="text-right"><fmt:formatNumber value="${resultList.mlg}" pattern="###,###" /></td>
					<td><button type="button" class="listModalBtn btn shadow w-full" data-mlg-no="${resultList.mlgMngNo}" data-cur-path="${_curPath}">${resultList.targetCnt}</button></td>
					<td>${resultList.mlg * resultList.targetCnt}</td>
					<td>${resultList.rgtr}</br>(${resultList.regId})</td>
					<td><fmt:formatDate value="${resultList.regDt}" pattern="yyyy-MM-dd HH:mm" /></td>
				</tr>
			</c:forEach>
			<c:if test="${empty listVO.listObject}">
				<tr>
					<td class="noresult" colspan="9">검색조건을 선택 하신 후, 검색해 주세요.</td>
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

	<div id="listView"></div>
</div>

<script>
$(function(){
	$("#excel-btn").on("click",function(){
		//엑셀 다운로드
		$("#searchFrm").attr("action","mlgExcel");
		$("#searchFrm").submit();
		$("#searchFrm").attr("action","./list");
	});
});
</script>