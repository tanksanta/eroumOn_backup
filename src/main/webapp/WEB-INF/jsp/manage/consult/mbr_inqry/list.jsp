<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<div id="page-content">
	<form action="./list" method="get" id="searchFrm" name="searchFrm">
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
						<th scope="row"><label for="search-item1">등록일</label></th>
						<td colspan="3">
							<div class="form-group">
								<input type="date" class="form-control w-39 calendar" id="srchRegBgng" name="srchRegBgng" value="${param.srchRegBgng}">
								<i>~</i>
								<input type="date" class="form-control w-39 calendar" id="srchRegEnd" name="srchRegEnd" value="${param.srchRegEnd}">&nbsp;
								<button type="button" class="btn shadow" onclick="f_srchJoinSet('1'); return false;">오늘</button>
								<button type="button" class="btn shadow" onclick="f_srchJoinSet('2'); return false;">7일</button>
								<button type="button" class="btn shadow" onclick="f_srchJoinSet('3'); return false;">15일</button>
								<button type="button" class="btn shadow" onclick="f_srchJoinSet('4'); return false;">1개월</button>
							</div>
						</td>
					</tr>
					<tr>
						<th scope="row"><label for="srchId">작성자 / ID</label></th>
						<td><input type="text" class="form-control" id="srchId" name="srchId" value="${param.srchId}" maxlength="30">&nbsp;
						/&nbsp; <input type="text" class="form-control" id="srchName" name="srchName" value="${param.srchName}" maxlength="30"></td>
						<th scope="row"><label for="srchTel">휴대폰번호(뒷자리)</label>
						<td>
							<input type="text" class="form-control" id="srchTel" name="srchTel" value="${param.srchTel}" maxlength="4">
						</td>
					</tr>
					<tr>
						<th scope="row"><label for="srchInqryTy">문의 유형</label></th>
						<td>
							<select class="form-control w-40" id="srchInqryTyNo1" name="srchInqryTyNo1">
								<option value="">선택</option>
								<c:forEach var="inqry" items="${inqryTyNo1}" varStatus="status">
									<option value="${inqry.key}"<c:if test="${inqry.key eq param.srchInqryTyNo1}">selected="selected"</c:if>>${inqry.value}</option>
								</c:forEach>
							</select>
							<select class="form-control w-40" id="srchInqryTyNo2" name="srchInqryTyNo2">
								<option value="">선택</option>
								<c:forEach var="inqry" items="${inqryTyNo2}" varStatus="status">
									<option value="${inqry.key}"<c:if test="${inqry.key eq param.srchInqryTyNo2}">selected="selected"</c:if> class="selectVal${status.index}" style="display:"";">${inqry.value}</option>
								</c:forEach>
							</select>
						</td>
					</tr>
					<tr>
						<th scope="row">답변 상태</th>
						<td>
							<div class="form-check-group">
								<div class="form-check">
									<input class="form-check-input" type="radio" name="srchAns" id="search-item3" value="" checked>
									<label class="form-check-label" for="search-item3">전체</label>
								</div>
								<c:forEach var="ans" items="${ansYn}" varStatus="status">
									<div class="form-check">
										<input type="radio" value="${ans.key}" id="ansYn${status.index }" name="srchAns" class="form-check-input" <c:if test="${ans.key eq param.srchAns}">checked="checked"</c:if>>
										<label class="form-check-label" for="ansYn${status.index }">${ans.value}</label>
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

	<p class="text-title2 mt-13">목록</p>
	<table class="table-list">
		<colgroup>
			<col class="w-20">
			<col class="w-30">
			<col class="w-30">
			<col class="w-70">
			<col class="w-30">
			<col class="w-30">
			<col class="w-30">
		</colgroup>
		<thead>
			<tr>
				<th scope="col">번호</th>
				<th scope="col">구분</th>
				<th scope="col">문의유형</th>
				<th scope="col">제목</th>
				<th scope="col">작성자</th>
				<th scope="col">등록일</th>
				<th scope="col">답변상태</th>
			</tr>
		</thead>
		<tbody>
		<c:forEach var="resultList" items="${listVO.listObject}" varStatus="status">
		<c:set var="pageParam" value="inqryNo=${resultList.inqryNo}&amp;ansYn=${resultList.ansYn}&amp;curPage=${listVO.curPage }&amp;cntPerPage=${param.cntPerPage }&amp;srchRegBgng=${param.srchRegBgng}&amp;srchRegEnd=${param.srchRegEnd}
			&amp;srchId=${param.srchId}	&amp;srchName=${param.srchName}&amp;srchInqryTy=${param.srchInqryTy}&amp;srchAns=${param.srchAns}" />
			<tr>
				<td>${listVO.startNo - status.index }</td>
				<td>${inqryTyNo1[resultList.inqryTy]}</td>
				<td>${inqryTyNo2[resultList.inqryDtlTy]}</td>
				<td><a href="./form?${pageParam}"  class="changeFrm">${resultList.ttl}</a></td>
				<td>${resultList.regId}</td>
				<td><fmt:formatDate value="${resultList.regDt }" pattern="yyyy-MM-dd" /></td>
				<td>${ansYn[resultList.ansYn]}</td>
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
				<label for="countPerPage">출력</label>
				 <select name="countPerPage" id="countPerPage" class="form-control">
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
function f_srchJoinSet(ty){
	$("#srchRegEnd").val(f_getToday());
	if(ty == "1"){//오늘
   		$("#srchRegBgng").val(f_getToday());
	}else if(ty == "2"){//일주일
		$("#srchRegBgng").val(f_getDate(-7));
	}else if(ty == "3"){//15일
		$("#srchRegBgng").val(f_getDate(-15));
	}else if(ty == "4"){//한달
		$("#srchRegBgng").val(f_getDate(-30));
	}
}

$(function(){
	<%--
	$(".changeFrm").on("click",function(){
		var val = $(this).attr("href");
		if(val.indexOf("ansYn=Y") == -1){
			var fromVal = val.replace("view","form");
			$(this).attr("href",fromVal);
		}
	});--%>

	if($("#srchInqryTyNo1").val() == 0){
		for(var i =3; i < 17; i++ ){
			$(".selectVal"+i).css("display","none");
		}
	}else if($("#srchInqryTyNo1").val() == 1){
		for(var i =0; i < 3; i++ ){
			$(".selectVal"+i).css("display","none");
		}
		for(var i =7; i < 18; i++ ){
			$(".selectVal"+i).css("display","none");
		}
	}else if($("#srchInqryTyNo1").val() == 2){
		for(var i =0; i < 7; i++ ){
			$(".selectVal"+i).css("display","none");
		}
		for(var i =10; i < 17; i++ ){
			$(".selectVal"+i).css("display","none");
		}
	}else if($("#srchInqryTyNo1").val() == 3){
		for(var i=0; i < 10; i++){
			$(".selectVal"+i).css("display","none");
		}
		for(var i=13; i < 17; i++){
			$(".selectVal"+i).css("display","none");
		}
	}else if($("#srchInqryTyNo1").val() == 4){
		for(var i=0; i < 13; i++){
			$(".selectVal"+i).css("display","none");
		}
		for(var i=16; i < 17; i++){
			$(".selectVal"+i).css("display","none");
		}

	}else if($("#srchInqryTyNo1").val() == 5){
		for(var i=0; i < 16; i++){
			$(".selectVal"+i).css("display","none");
		}
	}

	$("#srchInqryTyNo1").on("click",function(){
		for(var i=0; i < 17; i++){
			$(".selectVal"+i).css("display","");
		}
		if($("#srchInqryTyNo1").val() == 0){
			for(var i =3; i < 17; i++ ){
				$(".selectVal"+i).css("display","none");
			}
		}else if($("#srchInqryTyNo1").val() == 1){
			for(var i =0; i < 3; i++ ){
				$(".selectVal"+i).css("display","none");
			}
			for(var i =7; i < 18; i++ ){
				$(".selectVal"+i).css("display","none");
			}
		}else if($("#srchInqryTyNo1").val() == 2){
			for(var i =0; i < 7; i++ ){
				$(".selectVal"+i).css("display","none");
			}
			for(var i =10; i < 17; i++ ){
				$(".selectVal"+i).css("display","none");
			}
		}else if($("#srchInqryTyNo1").val() == 3){
			for(var i=0; i < 10; i++){
				$(".selectVal"+i).css("display","none");
			}
			for(var i=13; i < 17; i++){
				$(".selectVal"+i).css("display","none");
			}
		}else if($("#srchInqryTyNo1").val() == 4){
			for(var i=0; i < 13; i++){
				$(".selectVal"+i).css("display","none");
			}
			for(var i=16; i < 17; i++){
				$(".selectVal"+i).css("display","none");
			}

		}else if($("#srchInqryTyNo1").val() == 5){
			for(var i=0; i < 16; i++){
				$(".selectVal"+i).css("display","none");
			}
		}


	});

});
</script>


