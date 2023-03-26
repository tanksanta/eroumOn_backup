<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<form id="searchFrm" name="searchFrm" method="get" action="./list">
	<input type="hidden" name="cntPerPage" id="cntPerPage" value="${listVO.cntPerPage}" />
	<input type="hidden" name="sortBy" id="sortBy" value="${param.sortBy}" />

	<fieldset>
		<legend class="text-title2">검색</legend>
		<table class="table-detail">
			<colgroup>
				<col class="w-43">
				<col>
				<col class="w-43">
				<col>
			</colgroup>
			<tbody>
				<tr>
					<th scope="row"><label for="search-item1">신청일</label></th>
					<td colspan="3">
						<div class="form-group">
							<input type="date" class="form-control w-39 calendar" id="srchBgngDt" name="srchBgngDt" value="${param.srchBgngDt}">
							<i>~</i>
							<input type="date" class="form-control w-39 calendar" id="srchEndDt" name="srchEndDt" value="${param.srchEndDt}">
							<button type="button" class="btn shadow" onclick="f_srchRegDtSet('1'); return false;">오늘</button>
							<button type="button" class="btn shadow" onclick="f_srchRegDtSet('2'); return false;">7일</button>
							<button type="button" class="btn shadow" onclick="f_srchRegDtSet('3'); return false;">15일</button>
							<button type="button" class="btn shadow" onclick="f_srchRegDtSet('4'); return false;">1개월</button>
						</div>
					</td>
				</tr>
				<tr>
					<th scope="row"><label for="srchBplcId">아이디</label></th>
					<td><input type="text" class="form-control w-84" id="srchBplcId" name="srchBplcId" value="${param.srchBplcId}"></td>
					<th scope="row"><label for="srchRprsvNm">대표자명</label></th>
					<td><input type="text" class="form-control w-84" id="srchRprsvNm" name="srchRprsvNm" value="${param.srchRprsvNm}"></td>
				</tr>
				<tr>
					<th scope="row"><label for="srchRprsvNm">기업명</label></th>
					<td><input type="text" class="form-control w-84" id="srchBplcNm" name="srchBplcNm" value="${param.srchBplcNm}"></td>
					<th scope="row"><label for="srchBrno">사업자등록번호</label></th>
					<td><input type="text" class="form-control w-84" id="srchBrno" name="srchBrno" value="${param.srchBrno}"></td>
				</tr>
				<tr>
					<th scope="row"><label for="search-item1">추천멤버스</label></th>
					<td colspan="3">
						<div class="form-check-group">
							<div class="form-check">
								<input class="form-check-input" type="radio" name="srchDspyYn" id="srchDspyYn" value="" checked>
								 <label class="form-check-label" for="srchDspyYn">전체</label>
							</div>
						<c:forEach var="dspyYn" items="${dspyYn}" varStatus="status">
							<div class="form-check">
								<input class="form-check-input" type="radio" name="srchDspyYn" id="srchDspyYn${status.index}" value="${dspyYn.key }" <c:if test="${dspyYn.key eq param.srchDspyYn }" >checked="checked"</c:if>>
								 <label class="form-check-label" for="srchDspyYn${status.index}">${dspyYn.value}</label>
							</div>
						</c:forEach>
						</div>
					</td>
				</tr>
				<tr>
					<th scope="row"><label for="search-item1">상태</label></th>
					<td colspan="3">
						<div class="form-check-group">
							<div class="form-check">
								<input class="form-check-input" type="radio" name="srchUseYn" id="srchUseYn" value="" checked>
								 <label class="form-check-label" for="srchUseYn">전체</label>
							</div>
						<c:forEach var="useYn" items="${useYn}" varStatus="status">
							<div class="form-check">
								<input class="form-check-input" type="radio" name="srchUseYn" id="srchUseYn${status.index }" value="${useYn.key }" <c:if test="${useYn.key eq param.srchUseYn }" >checked="checked"</c:if>>
								 <label class="form-check-label" for="srchUseYn${status.index}">${useYn.value }</label>
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

<p class="text-title2 mt-13">멤버스 목록</p>
<table class="table-list">
	<colgroup>
		<col class="w-20">
		<col>
		<col class="w-30">
		<col class="w-30">
		<col class="w-50">
		<col class="w-40">
		<col class="w-30">
		<col class="w-30">
	</colgroup>
	<thead>
		<tr>
			<th scope="col">번호</th>
			<th scope="col">기업명</th>
			<th scope="col">대표자명</th>
			<th scope="col">담당자명</th>
			<th scope="col">사업자등록번호</th>
			<th scope="col">등록일</th>
			<th scope="col">추천</th>
			<th scope="col">상태</th>
		</tr>
	</thead>
	<tbody>
		<c:forEach items="${listVO.listObject}" var="resultList" varStatus="status">
			<c:set var="pageParam" value="uniqueId=${resultList.uniqueId}&amp;curPage=${listVO.curPage}${!empty(listVO.urlParam)? '&amp;' : ''}${listVO.urlParam}" />
			<tr>
				<td>${listVO.startNo - status.index}</td>
				<td><a href="./view?${pageParam}">${resultList.bplcNm}</a></td>
				<td>${resultList.rprsvNm}</td>
				<td>${resultList.picNm}</td>
				<td>${resultList.brno}</td>
				<td><fmt:formatDate value="${resultList.joinDt}" pattern="yyyy-MM-dd" /></td>
				<td>${dspyYn[resultList.rcmdtnYn]}</td>
				<td>${useYn[resultList.useYn]}</td>
			</tr>
		</c:forEach>
		<c:if test="${empty listVO.listObject}">
			<tr>
				<td class="noresult" colspan="8">등록된 데이터가 없습니다.</td>
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

<script>
function f_srchRegDtSet(ty){
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
	// 출력 갯수
	$("#countPerPage").on("change", function(){
		var cntperpage = $("#countPerPage option:selected").val();
		$("#cntPerPage").val(cntperpage);
		$("#searchFrm").submit();
	});
});

</script>