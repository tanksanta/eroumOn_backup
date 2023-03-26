<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<form action="./list" id="searchFrm" name="searchFrm" method="get">
	<input type="hidden" name="cntPerPage" id="cntPerPage" value="${listVO.cntPerPage}" />
	<input type="hidden" name="sortBy" id="sortBy" value="${param.sortBy}" />

	<fieldset>
		<legend class="text-title2">광고 검색</legend>
		<table class="table-detail">
			<colgroup>
				<col class="w-43">
				<col>
			</colgroup>
			<tbody>
				<tr>
					<th scope="row"><label for="search-item1">노출기간</label></th>
					<td>
						<div class="form-group w-84">
							<input type="date" class="form-control flex-1 calendar" id="srchBgngDt" name="srchBgngDt" value="${param.srchBgngDt}">
							<i>~</i>
							<input type="date" class="form-control flex-1 calendar" id="srchEndDt" name="srchEndDt" value="${param.srchEndDt}">
						</div>
					</td>
				</tr>
				<tr>
					<th scope="row"><label for="search-item2">광고영역</label></th>
						<td>
							<select class="form-control w-39" id="srchArea" name="srchArea">
									<option value="">전체</option>
									<c:forEach var="area" items="${adverArea}">
										<option value="${area.key}">${area.value}</option>
									</c:forEach>
							</select>
						</td>
				</tr>
				<tr>
					<th scope="row"><label for="search-item3">광고명</label></th>
					<td><input type="text" class="form-control w-full" id="srchCn" name="srchCn" value="${param.srchCn}"></td>
				</tr>
				<tr>
					<th scope="row"><label for="search-item4">상태</label></th>
					<td>
						<div class="form-check-group">
							<div class="form-check">
								<input class="form-check-input" type="radio" name="srchYn" id="srchYn" value="" checked>
								<label class="form-check-label" for="srchYn">전체</label>
							</div>
							<c:forEach var="use" items="${useYn}" varStatus="status">
								<div class="form-check">
									<input class="form-check-input" type="radio" name="srchYn" id="srchYn${status.index}" value="${use.key}" <c:if test="${param.srchYn eq use.key}">checked="checked"</c:if>>
									<label class="form-check-label" for="srchYn${status.index}">${use.value}</label>
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

<p class="text-title2 mt-13">광고 목록</p>
<table class="table-list">
	<colgroup>
		<col class="w-25">
		<col class="w-[18%]">
		<col>
		<col class="w-72">
		<col class="w-35">
		<col class="w-25">
	</colgroup>
	<thead>
		<tr>
			<th scope="col">번호</th>
			<th scope="col">광고영역</th>
			<th scope="col">광고명</th>
			<th scope="col">노출기간</th>
			<th scope="col">등록일</th>
			<th scope="col">상태</th>
		</tr>
	</thead>
	<tbody>
		<c:forEach var="resultList" items="${listVO.listObject}" varStatus="status">
		<c:set var="pageParam" value="adverNo=${resultList.adverNo}&amp;curPage=${listVO.curPage}${!empty(listVO.urlParam)? '&amp;' : ''}${listVO.urlParam}" />
			<tr>
				<td>${listVO.startNo - status.index}</td>
				<td>${adverArea[resultList.adverArea]}</td>
				<td class="text-left"><a href="./form?adverNo=${resultList.adverNo}">${resultList.adverNm}</a></td>
				<td>
					<fmt:formatDate value="${resultList.bgngDt}" pattern="yyyy-MM-dd" />
					~
					 <fmt:formatDate value="${resultList.endDt}" pattern="yyyy-MM-dd" />
				</td>
				<td><fmt:formatDate value="${resultList.regDt}" pattern="yyyy-MM-dd" /></td>
				<td>${useYn[resultList.useYn]}</td>
			</tr>
		</c:forEach>
		<c:if test="${empty listVO.listObject}">
			<tr>
				<td class="noresult" colspan="6">검색조건을 만족하는 결과가 없습니다.</td>
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

<c:set var="pageParam" value="curPage=${param.curPage}&srchBgngDt=${param.srchBgngDt}&srchEndDt=${param.srchEndDt}&srchCn=${param.srchCn}&srchYn=${param.srchYn}&srchArea=${param.srchArea}" />
<div class="btn-group right mt-8">
	<a href="./form?${pageParam}" class="btn-primary large shadow">등록</a>
</div>
