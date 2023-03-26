<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<div id="page-content">
	<form action="./list" method="get" id="searchFrm" name="searchFrm">
		<input type="hidden" name="cntPerPage" id="cntPerPage" value="${listVO.cntPerPage}" />
		<input type="hidden" name="sortBy" id="sortBy" value="${param.sortBy}" />
		<fieldset>
			<legend class="text-title2">탈퇴회원 검색</legend>
			<table class="table-detail">
				<colgroup>
					<col class="w-43">
					<col>
					<col class="w-43">
					<col>
				</colgroup>
				<tbody>
					<tr>
						<th scope="row"><label for="srchWhdwlBgng">탈퇴일</label></th>
						<td colspan="3">
							<div class="form-group">
								<input type="date" class="form-control w-39 calendar" id="srchWhdwlBgng" name="srchWhdwlBgng" value="${param.srchWhdwlBgng}">
								<i>~</i>
								<input type="date" class="form-control w-39 calendar" id="srchWhdwlEnd" name="srchWhdwlEnd" value="${param.srchWhdwlEnd}">
								<button type="button" class="btn shadow" onclick="f_srchWhdwlSet('0'); return false;">초기화</button>
								<button type="button" class="btn shadow" onclick="f_srchWhdwlSet('1'); return false;">오늘</button>
								<button type="button" class="btn shadow" onclick="f_srchWhdwlSet('2'); return false;">7일</button>
								<button type="button" class="btn shadow" onclick="f_srchWhdwlSet('3'); return false;">15일</button>
								<button type="button" class="btn shadow" onclick="f_srchWhdwlSet('4'); return false;">1개월</button>
							</div>
						</td>
					</tr>
					<tr>
						<th scope="row"><label for="srchId">아이디</label></th>
						<td><input type="text" class="form-control w-84" id="srchMbrId" name=srchMbrId value="${param.srchMbrId }"></td>
						<th scope="row"><label for="srchName">이름</label></th>
						<td><input type="text" class="form-control w-84" id="srchMbrNm" name="srchMbrNm" value="${param.srchMbrNm}"></td>
					</tr>
					<tr>
						<th scope="row"><label for="search-item4">탈퇴유형</label></th>
						<td colspan="3">
							<div class="form-check-group">
								<div class="form-check">
									<input class="form-check-input" type="radio" name="srchWhdwlTy" id="srchWhdwlTy" value="" checked>
									<label class="form-check-label" for="srchWhdwlTy">전체</label>
								</div>
								<c:forEach var="ty" items="${exitTyCode}" varStatus="status">
									<div class="form-check">
										<input class="form-check-input" type="radio" name="srchWhdwlTy" id="srchWhdwlTy${status.index }" value="${ty.key }" <c:if test="${param.srchWhdwlTy eq ty.key }">checked="checked"</c:if>>
										<label class="form-check-label" for="srchWhdwlTy${status.index }">${ty.value }</label>
									</div>
								</c:forEach>
							</div>
						</td>
					</tr>
					<tr>
						<th scope="row"><label for="srchWhdwlResn">탈퇴사유</label></th>
						<td colspan="3">
							<select name="srchWhdwlResn" class="form-control w-100" id="srchWhdwlResn">
								<option value="">전체</option>
								<c:forEach var="resn" items="${authResnCode}" varStatus="status">
									<option value="${resn.key }"<c:if test="${param.srchWhdwlResn eq resn.key }">selected="selected"</c:if>>${resn.value }</option>
								</c:forEach>
							</select></td>
					</tr>
				</tbody>
			</table>
		</fieldset>

		<div class="btn-group mt-5">
			<button type="submit" class="btn-primary large shadow w-52">검색</button>
		</div>
	</form>

	<p class="text-title2 mt-13">탈퇴회원 목록</p>
	<table class="table-list">
		<colgroup>
			<col class="w-20">
			<col class="w-[18%]">
			<col class="w-[18%]">
			<col class="w-44">
			<col class="w-30">
			<col>
		</colgroup>
		<thead>
			<tr>
				<th scope="col">번호</th>
				<th scope="col">아이디</th>
				<th scope="col">회원이름</th>
				<th scope="col">탈퇴일</th>
				<th scope="col">탈퇴유형</th>
				<th scope="col">탈퇴사유</th>
			</tr>
		</thead>
		<tbody>
			<c:forEach var="resultList" items="${listVO.listObject}" varStatus="status">
				<tr>
					<td>${listVO.startNo - status.index }</td>
					<td>${resultList.mbrId }</td>
					<td>${resultList.mbrNm }</td>
					<td><fmt:formatDate value="${resultList.whdwlDt }" pattern="yyyy-MM-dd HH:mm:ss" /></td>
					<td>${exitTyCode[resultList.whdwlTy]}</td>
					<td><c:if test="${resultList.whdwlTy eq 'AUTHEXIT' && resultList.whdwlEtc eq null}">${authResnCode[resultList.whdwlResn]}</c:if>
					<c:if test="${resultList.whdwlTy eq 'AUTHEXIT' && resultList.whdwlEtc ne null}">${resultList.whdwlEtc}</c:if>
							<c:if test="${resultList.whdwlTy eq 'NORMAL' }">${norResnCode[resultList.whdwlResn]}</c:if></td>
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
function f_srchWhdwlSet(ty){
	$("#srchWhdwlEnd").val(f_getToday());
	if(ty == "0"){
		$("#srchWhdwlEnd").val('');
		$("#srchWhdwlBgng").val('');
	}else if(ty == "1"){//오늘
   		$("#srchWhdwlBgng").val(f_getToday());
	}else if(ty == "2"){//일주일
		$("#srchWhdwlBgng").val(f_getDate(-7));
	}else if(ty == "3"){//15일
		$("#srchWhdwlBgng").val(f_getDate(-15));
	}else if(ty == "4"){//한달
		$("#srchWhdwlBgng").val(f_getDate(-30));
	}
}
</script>
