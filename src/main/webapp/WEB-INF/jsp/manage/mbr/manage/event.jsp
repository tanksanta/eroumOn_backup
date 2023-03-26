<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<div id="page-content">
	<%@include file="./include/header.jsp"%>

	<form action="./event" class="mt-13" id="searchFrm" name="searchFrm" method="get">
	<input type="hidden" id="cntPerPage" name="cntPerPage" value="${param.cntPerPage}" />
		<fieldset>
			<legend class="text-title2">이벤트 검색</legend>
			<table class="table-detail">
				<colgroup>
					<col class="w-43">
					<col>
				</colgroup>
				<tbody>
					<tr>
						<th scope="row"><label for="search-item6-1">응모기간</label></th>
						<td>
							<div class="form-group">
								<input type="date" class="form-control w-39 calendar" id="srchBgngDt" name="srchBgngDt" value="${param.srchBgngDt}">
								<i>~</i>
								 <input type="date" class="form-control w-39 calendar" id="srchEndDt" name="srchEndDt" value="${param.srchEndDt}">
								<button type="button" class="btn shadow" onclick="f_srchJoinSet('1'); return false;">오늘</button>
								<button type="button" class="btn shadow" onclick="f_srchJoinSet('2'); return false;">7일</button>
								<button type="button" class="btn shadow" onclick="f_srchJoinSet('3'); return false;">15일</button>
								<button type="button" class="btn shadow" onclick="f_srchJoinSet('4'); return false;">1개월</button>
							</div>
						</td>
					</tr>
					<tr>
						<th scope="row"><label for="srchEventNm">이벤트명</label></th>
						<td><input type="text" class="form-control w-full" id="srchEventNm" name="srchEventNm" value="${param.srchEventNm}"></td>
					</tr>
					<tr>
						<th scope="row"><label for="search-item6-3">상태</label></th>
						<td>
							<div class="form-check-group">
								<div class="form-check">
									<input class="form-check-input" type="radio" name="srchSttus" id="srchSttus" checked>
									<label class="form-check-label" for="srchSttus">전체</label>
								</div>
								<c:forEach var="sttus" items="${playSttusCode}" varStatus="status">
									<div class="form-check">
										<input class="form-check-input" type="radio" name="srchSttus" id="srchSttus${status.index}" value="${sttus.key}"<c:if test="${sttus.key eq param.srchSttus}">checked="checked"</c:if>>
										<label class="form-check-label" for="srchSttus${status.index}">${sttus.value}</label>
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

	<p class="text-title2 mt-13">이벤트 내역</p>
	<c:set var="getNow" value="<%=new java.util.Date()%>" />
	<table class="table-list">
		<colgroup>
			<col class="w-23">
			<col>
			<col class="w-28">
			<col class="w-28">
		</colgroup>
		<thead>
			<tr>
				<th scope="col">번호</th>
				<th scope="col">이벤트명</th>
				<th scope="col">상태</th>
				<th scope="col">응모일</th>
			</tr>
		</thead>
		<tbody>
			<c:forEach var="resultList" items="${listVO.listObject}" varStatus="status">
			<tr>
				<td>${listVO.startNo - status.index}</td>
				<td class="text-left"><a href="/market/etc/event/view?eventNo=${resultList.eventNo}" target="_blank">${resultList.eventNm}</a></td>
				<td><c:if test="${resultList.bgngDt  <= getNow && getNow <= resultList.endDt}">진행중</c:if>
						<c:if test="${resultList.bgngDt  > getNow || getNow > resultList.endDt}">종료</c:if></td>
				<td><fmt:formatDate value="${resultList.applctDt}" pattern="yyyy-MM-dd" /></td>
			</tr>
			</c:forEach>
			<c:if test="${empty listVO.listObject}">
			<tr>
				<td class="noresult" colspan="4">검색조건을 만족하는 결과가 없습니다.</td>
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

	<!-- 당첨내역 -->
	<div class="modal fade" id="modal1" tabindex="-1">
		<div class="modal-dialog modal-lg modal-dialog-centered">
			<div class="modal-content">
				<div class="modal-header">
					<p>스페셜 라이프 가이드 100회기념 퀴즈 3</p>
					<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="close"></button>
				</div>
				<div class="modal-body">
					<table class="table-list">
						<colgroup>
							<col class="w-25">
							<col>
							<col class="w-35">
						</colgroup>
						<thead>
							<tr>
								<th scope="col">번호</th>
								<th scope="col">경품명</th>
								<th scope="col">당첨여부</th>
							</tr>
						</thead>
						<tbody>
							<tr>
								<td>7</td>
								<td class="text-left">[세븐일레븐] 카페라떼 마일드 200ml</td>
								<td>당첨</td>
							</tr>
						</tbody>
					</table>
				</div>
			</div>
		</div>
	</div>
	<!-- //당첨내역 -->
</div>

<script>
function f_srchJoinSet(ty){
  	//srchJoinBgng, srchJoinEnd
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

});
</script>

