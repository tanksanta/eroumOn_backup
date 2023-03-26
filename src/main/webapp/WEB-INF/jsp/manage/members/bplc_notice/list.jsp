<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<form id="searchFrm" name="searchFrm" method="get" action="./list">
	<input type="hidden" name="cntPerPage" id="cntPerPage" value="${listVO.cntPerPage}" />
	<input type="hidden" name="sortBy" id="sortBy" value="${param.sortBy}" />
	<input type="hidden" name="srchTarget" id="srchTarget" value="${param.srchTarget}" />

	<fieldset>
		<legend class="text-title2">검색</legend>
		<table class="table-detail">
			<colgroup>
				<col class="w-43">
				<col>
				<col class="w-43">
			</colgroup>
			<tbody>
				<tr>
					<th scope="row"><label for="search-item1">등록일</label></th>
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
					<th scope="row"><label for="search-item1">키워드검색</label></th>
					<td>
						<div class="form-group w-full">
							<select name="srchTarget" id="selectTarget" class="form-control w-30">
								<option value="">전체</option>
								<option value="ttl" <c:if test="${'ttl' eq param.srchTarget}">selected="selected"</c:if>>제목</option>
								<option value="cn" <c:if test="${param.srchTarget eq 'cn' }">selected="selected"</c:if>>내용</option>
							</select>
							<input type="text" class="form-control flex-1" id="srchText" name="srchText" value="${param.srchText}">
						</div>
					</td>
				</tr>
				<tr>
					<th scope="row"><label for="search-item1">사용여부</label></th>
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

<c:set var="pageParam" value="curPage=${listVO.curPage}&amp;sortBy=${param.sortBy}&amp;srchTarget=${param.srchTarget}&amp;cntPerPage=${param.cntPerPage}&amp;srchText=${param.srchText}&amp;srchUseYn=${param.srchUseYn}&amp;srchBgngDt=${param.srchBgngDt}&amp;srchEndDt=${param.srchEndDt}" />
<p class="text-title2 mt-13">공지사항 목록</p>
<table class="table-list">
	<colgroup>
		<col class="w-20">
		<col>
		<col class="w-30">
		<col class="w-30">
		<col class="w-30">
		<col class="w-30">
	</colgroup>
	<thead>
		<tr>
			<th scope="col">번호</th>
			<th scope="col">제목</th>
			<th scope="col">등록일</th>
			<th scope="col">등록자</th>
			<th scope="col">상태</th>
			<th scope="col">조회수</th>
		</tr>
	</thead>
	<tbody>
		<c:forEach items="${listVO.listObject}" var="resultList" varStatus="status">
			<tr>
				<td>${listVO.startNo - status.index}</td>
				<td><a href="./form?noticeNo=${resultList.noticeNo}&amp;${pageParam}">${resultList.ttl}</a></td>
				<td><fmt:formatDate value="${resultList.regDt}" pattern="yyyy-MM-dd" /></td>
				<td>${resultList.rgtr}</td>
				<td>${useYn[resultList.useYn]}</td>
				<td>${resultList.inqcnt}</td>
			</tr>
		</c:forEach>
		<c:if test="${empty listVO.listObject}">
			<tr>
				<td class="noresult" colspan="6">등록된 데이터가 없습니다.</td>
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

<div class="btn-group right mt-8">
	<a href="./form?${pageParam}" class="btn-primary large shadow">등록</a>
</div>
<script>
	function f_srchRegDtSet(ty) {
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
		// 출력 갯수
		$("#countPerPage").on("change", function() {
			var cntperpage = $("#countPerPage option:selected").val();
			$("#cntPerPage").val(cntperpage);
			$("#searchFrm").submit();
		});

		$("#selectTarget").on("change", function() {
			$("#srchTarget").val($(this).val());
		});
	});
</script>