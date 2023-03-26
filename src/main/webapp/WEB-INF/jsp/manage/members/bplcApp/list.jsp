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
					<th scope="row"><label for="srchBplcNm">대표자명</label></th>
					<td><input type="text" class="form-control w-84" id="srchRprsvNm" name="srchRprsvNm" value="${param.srchRprsvNm}"></td>
				</tr>
				<tr>
					<th scope="row"><label for="srchRprsvNm">기업명</label></th>
					<td><input type="text" class="form-control w-84" id="srchBplcNm" name="srchBplcNm" value="${param.srchBplcNm}"></td>
					<th scope="row"><label for="srchBrno">사업자등록번호</label></th>
					<td><input type="text" class="form-control w-84" id="srchBrno" name="srchBrno" value="${param.srchBrno}" maxlength="12"></td>
				</tr>
				<tr>
					<th scope="row"><label for="srchPicNm">담당자명</label></th>
					<td><input type="text" class="form-control w-84" id="srchPicNm" name="srchPicNm" value="${param.srchPicNm}"></td>
					<th scope="row"><label for="srchPicTelno">담당자연락처</label></th>
					<td><input type="text" class="form-control w-84" id="srchPicTelno" name="srchPicTelno" value="${param.srchPicTelno}"></td>
				</tr>
				<tr>
					<th scope="row"><label for="search-item1">상태</label></th>
					<td colspan="3">
						<div class="form-check-group">
							<div class="form-check">
								<input class="form-check-input" type="radio" name="srchAprvTy" id="srchAprvTy" value="" checked>
								 <label class="form-check-label" for="srchAprvTy">전체</label>
							</div>
							<div class="form-check">
								<input class="form-check-input" type="radio" name="srchAprvTy" id="srchAprvTy1" value="W" <c:if test="${'W' eq param.srchAprvTy }" >checked="checked"</c:if>>
								 <label class="form-check-label" for="srchAprvTy1">대기</label>
							</div>
							<div class="form-check">
								<input class="form-check-input" type="radio" name="srchAprvTy" id="srchAprvTy2" value="R" <c:if test="${'R' eq param.srchAprvTy }" >checked="checked"</c:if>>
								 <label class="form-check-label" for="srchAprvTy2">미승인</label>
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

<p class="text-title2 mt-13">멤버스 신청 목록</p>
<table class="table-list">
	<colgroup>
		<col class="w-20">
		<col class="w-30">
		<col>
		<col class="w-45">
		<col class="w-45">
		<col class="w-45">
		<col class="w-45">
	</colgroup>
	<thead>
		<tr>
			<th scope="col">번호</th>
			<th scope="col">상태</th>
			<th scope="col">기업명</th>
			<th scope="col">대표자명</th>
			<th scope="col">담당자명</th>
			<th scope="col">사업자등록번호</th>
			<th scope="col">신청일</th>
		</tr>
	</thead>
	<tbody>
		<c:forEach items="${listVO.listObject}" var="resultList" varStatus="status">
			<c:set var="pageParam" value="curPage=${listVO.curPage}&amp;cntPerPage=${param.cntPerPage}&amp;srchBgngDt=${param.srchBgngDt}&amp;srchEndDt=${param.srchEndDt}&amp;srchBplcId=${param.srchBplcId}&amp;srchRprsvNm=${param.srchRprsvNm}&amp;srchBplcNm=${param.srchBplcNm}&amp;srchBrno=${param.srchBrno}&amp;srchPicNm=${param.srchPicNm}&amp;srchPicTelno=${param.srchPicTelno}&amp;srchAprvTy=${param.srchAprvTy}" />
			<tr>
				<td>${listVO.startNo - status.index}</td>
				<td>${aprvTy[resultList.aprvTy]}</td>
				<td><a href="./view?uniqueId=${resultList.uniqueId}&amp;${pageParam}">${resultList.bplcNm}</a></td>
				<td>${resultList.rprsvNm}</td>
				<td>${resultList.picNm}</td>
				<td>${resultList.brno}</td>
				<td><fmt:formatDate value="${resultList.joinDt}" pattern="yyyy-MM-dd" /></td>
			</tr>
		</c:forEach>
		<c:if test="${empty listVO.listObject}">
			<tr>
				<td class="noresult" colspan="7">등록된 데이터가 없습니다.</td>
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
<!--
<div class="btn-group right mt-8">
	<a href="./form" class="btn-primary large shadow">임시등록</a>
</div>
 -->

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