<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<div id="page-content">
	<form action="./list" method="get" id="searchFrm" name="searchFrm">
		<input type="hidden" name="cntPerPage" id="cntPerPage" value="${listVO.cntPerPage}" />
		<input type="hidden" name="sortBy" id="sortBy" value="${param.sortBy}" />
		<fieldset>
			<legend class="text-title2">휴면회원 검색</legend>
			<table class="table-detail">
				<colgroup>
					<col class="w-43">
					<col>
					<col class="w-43">
					<col>
				</colgroup>
				<tbody>
					<tr>
						<th scope="row"><label for="srchId">회원아이디</label></th>
						<td><input type="text" class="form-control w-84" id="srchId" name="srchId" value="${param.srchId}"></td>
						<th scope="row"><label for="srchName">회원이름</label></th>
						<td><input type="text" class="form-control w-84" id="srchName" name="srchName" value="${param.srchName }"></td>
					</tr>
					<tr>
						<th scope="row"><label for="srchLastTelnoOfMbl">휴대폰 (4자리)</label></th>
						<td><input type="text" class="form-control w-84" id="srchLastTelnoOfMbl" name="srchLastTelnoOfMbl" value="${param.srchLastTelnoOfMbl }"></td>
						<th scope="row"><label for="srchEmail">이메일</label></th>
						<td><input type="text" class="form-control w-84" id="srchEmail" name="srchEmail" value="${param.srchEmail }"></td>
					</tr>
					<tr>
						<th scope="row"><label for="">성별</label></th>
						<td colspan="3">
							<div class="form-check-group">
								<div class="form-check">
									<input class="form-check-input" type="radio" name="srchGender" id="search-item1" value="" checked>
									 <label class="form-check-label" for="search-item1">전체</label>
								 </div>
								<c:forEach var="gen" items="${gender}" varStatus="status">
									<div class="form-check">
										<input class="form-check-input" type="radio" name="srchGender" id="srchGender${status.index }" value="${gen.key }" <c:if test="${gen.key eq param.srchGender }" >checked="checked"</c:if>>
										 <label class="form-check-label" for="srchGender${status.index}">${gen.value }</label>
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
		<p class="text-right">
			<button type="button" class="btn-primary btn-excel">엑셀 다운로드</button>
		</p>
	</form>

	<p class="text-title2 mt-13">휴면회원 목록</p>
	<table class="table-list">
		<colgroup>
			<col class="w-20">
			<col class="w-[15%]">
			<col class="w-[15%]">
			<col class="w-24">
			<col>
			<col class="w-36">
			<col class="w-44">
		</colgroup>
		<thead>
			<tr>
				<th scope="col">번호</th>
				<th scope="col">회원아이디</th>
				<th scope="col">회원이름</th>
				<th scope="col">성별</th>
				<th scope="col">이메일</th>
				<th scope="col">휴대폰번호</th>
				<th scope="col">휴면처리일</th>
			</tr>
		</thead>
		<tbody>
		<c:forEach var="resultList" items="${listVO.listObject}" varStatus="status">
			<tr>
				<td>${listVO.startNo - status.index }</td>
				<td><a href="/_mng/mbr/${resultList.uniqueId}/view" class="btn shadow w-full">${resultList.joinTy == "E" ? resultList.mbrId : mbrJoinTy[resultList.joinTy]}</a></td>
				<td><a href="/_mng/mbr/${resultList.uniqueId}/view" class="btn shadow w-full">${resultList.mbrNm }</a></td>
				<td>${gender[resultList.gender]}</td>
				<td>${resultList.eml}</td>
				<td>${resultList.mblTelno}</td>
				<td><fmt:formatDate value="${resultList.mdfcnDt}" pattern="yyyy-MM-dd HH:mm:ss" /></td>
			</tr>
			</c:forEach>
			<c:if test="${empty listVO.listObject}">
				<tr>
					<td class="noresult" colspan="7">검색조건을 만족하는 결과가 없습니다.</td>
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
$(function(){
	$(".btn-excel").on("click", function(){
		$("#searchFrm").attr("action","excel").submit();
		$("#searchFrm").attr("action","list");
	});
});
</script>
