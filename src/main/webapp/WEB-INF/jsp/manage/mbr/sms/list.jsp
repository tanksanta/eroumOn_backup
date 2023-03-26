<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<div id="page-content">
	<form action="./list" name="searchFrm" id="searchFrm" method="get">
		<input type="hidden" name="cntPerPage" id="cntPerPage" value="${listVO.cntPerPage}" />
		<input type="hidden" name="sortBy" id="sortBy" value="${param.sortBy}" />
		<fieldset>
			<legend class="text-title2">전송이력 검색</legend>
			<table class="table-detail">
				<colgroup>
					<col class="w-43">
					<col>
				</colgroup>
				<tbody>
					<tr>
						<th scope="row"><label for="search-item1">발송기간</label></th>
						<td>
							<div class="form-group">
								<input type="date" class="form-control w-39 calendar" id="srchAnsBgng" name="srchAnsBgng" value="${param.srchAnsBgng}">
								<i>~</i>
								<input type="date" class="form-control w-39 calendar" id="srchAnsEnd" name="srchAnsEnd" value="${param.srchAnsEnd}">
								<button type="button" class="btn shadow" onclick="f_srchAnsSet('1'); return false;">오늘</button>
								<button type="button" class="btn shadow" onclick="f_srchAnsSet('2'); return false;">7일</button>
								<button type="button" class="btn shadow" onclick="f_srchAnsSet('3'); return false;">15일</button>
								<button type="button" class="btn shadow" onclick="f_srchAnsSet('4'); return false;">1개월</button>
							</div>
						</td>
					</tr>
					<tr>
						<th scope="row"><label for="search-item2">제목</label></th>
						<td><input type="text" class="form-control w-100" id="srchTtl" name="srchTtl" value="${param.srchTtl}"></td>
					</tr>
					<tr>
						<th scope="row"><label for="search-item3">내용</label></th>
						<td><input type="text" class="form-control w-100" id="srchCn" name="srchCn" value="${param.srchCn }"></td>
					</tr>
				</tbody>
			</table>
		</fieldset>

		<div class="btn-group mt-5">
			<button type="submit" class="btn-primary large shadow w-52">검색</button>
		</div>
	</form>

	<p class="text-title2 mt-13">전송이력 목록</p>
	<table class="table-list">
		<colgroup>
			<col class="w-20">
			<col class="w-35">
			<col class="w-[20%]">
			<col>
			<col class="w-30">
			<col class="w-44">
		</colgroup>
		<thead>
			<tr>
				<th scope="col">번호</th>
				<th scope="col">휴대폰번호</th>
				<th scope="col">제목</th>
				<th scope="col">내용</th>
				<th scope="col">처리자명</th>
				<th scope="col">발송일시</th>
			</tr>
		</thead>
		<tbody>
			<c:forEach var="resultList" items="${listVO.listObject}" varStatus="status">
				<tr>
					<td>${listVO.startNo - status.index }</td>
					<td></td>
					<td class="text-left">[상담답변]</td>
					<td class="text-left">[상담답변]</td>
					<td></td>
					<td></td>
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
</div>

<script>
function f_srchAnsSet(ty){
	$("#srchAnsEnd").val(f_getToday());
	if(ty == "1"){//오늘
   		$("#srchAnsBgng").val(f_getToday());
	}else if(ty == "2"){//일주일
		$("#srchAnsBgng").val(f_getDate(-7));
	}else if(ty == "3"){//15일
		$("#srchAnsBgng").val(f_getDate(-15));
	}else if(ty == "4"){//한달
		$("#srchAnsBgng").val(f_getDate(-30));
	}
}
</script>