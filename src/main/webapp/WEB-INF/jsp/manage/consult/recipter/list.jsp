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
						<th scope="row"><label for="srchMbrNm">성명</label></th>
						<td><input type="text" class="form-control w-100" id="srchMbrNm" name="srchMbrNm" value="${param.srchMbrNm}" maxlength="30"></td>
					</tr>
					<tr>
						<th scope="row"><label for="srchMbrTelno">연락처</label></th>
						<td><input type="text" class="form-control w-100" id="srchMbrTelno" name="srchMbrTelno" value="${param.srchMbrTelno}" maxlenth="15" /></td>
					</tr>
				</tbody>
			</table>
		</fieldset>

		<div class="btn-group mt-5">
			<button type="submit" class="btn-primary large shadow w-52">검색</button>
		</div>
	</form>

	<p class="text-right mb-3">
		<button type="button" class="btn btn-primary text-right" id="delConslt" name="delConslt">선택 삭제</button>
	</p>
	<legend class="text-title2">목록</legend>
	<table class="table-list">
		<colgroup>
			<col class="w-10">
			<col class="w-15">
			<col class="w-15">
			<col class="w-15">
			<col class="w-30">
			<col class="w-25">
			<col class="w-25">
			<col>
			<col class="w-40">
		</colgroup>
		<thead>
			<tr>
				<th scope="col">
					<div class="form-check">
						<input type="checkbox" name="conslt_check" id="checkAll" value="" class="form-check-input"/>
					</div>
				</th>
				<th scope="col">번호</th>
				<th scope="col">성명</th>
				<th scope="col">성별</th>
				<th scope="col">연락처</th>
				<th scope="col">만나이</th>
				<th scope="col">생년월일</th>
				<th scope="col">거주지주소</th>
				<th scope="col">등록일</th>
			</tr>
		</thead>
		<tbody>
		<c:forEach var="resultList" items="${listVO.listObject}" varStatus="status">
			<tr>
				<td>
					<div class="form-check">
						<input type="checkbox" name="check_child" value="${resultList.consltNo}" class="form-check-input" />
					</div>
				</td>
				<td>${listVO.startNo - status.index }</td>
				<td>${resultList.mbrNm}</td>
				<td>${genderCode[resultList.gender]}</td>
				<td>${resultList.mbrTelno}</td>
				<td>만 ${resultList.age} 세</td>
				<td>${fn:substring(resultList.brdt,0,4)}/${fn:substring(resultList.brdt,4,6)}/${fn:substring(resultList.brdt,6,8)}</td>
				<td>${resultList.zip}&nbsp;&nbsp;${resultList.addr}&nbsp;&nbsp; ${resultList.daddr}</td>
				<td><fmt:formatDate value="${resultList.regDt }" pattern="yyyy-MM-dd HH:mm:ss" /></td>
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
	let arrDelConslt = [];

	// 전체 선택
	$("#checkAll").on("click",function(){
		let checkFlag = false;
		arrDelConslt = [];

		if($(this).is(":checked")){
			checkFlag = true;

			$("input[name='check_child']").each(function(){
				arrDelConslt.push($(this).val());
			});
		}
		$("input[name='check_child']").prop("checked",checkFlag);
		console.log(arrDelConslt);
	});

	$("input[name='check_child']").on("click",function(){
		let total = $("input[name='check_child']").length;
		let checkCnt = $("input[name='check_child']:checked").length;

		if(total == checkCnt){
			$("#checkAll").prop("checked",true);
		}else{
			$("#checkAll").prop("checked",false);
		}

		if($(this).is(":checked")){
			arrDelConslt.push($(this).val());
		}else{
			arrDelConslt = arrDelConslt.filter((element) => element !== $(this).val());
		}
		console.log(arrDelConslt);
	});

	$("#delConslt").on("click",function(){
		$.ajax({
			type : "post",
			url  : "/_mng/consult/recipter/delConslt.json",
			data : {arrDelConslt : arrDelConslt},
			dataType : 'json'
		})
		.done(function(data) {
			if(data.result){
				alert("삭제되었습니다.");
			}else{
				alert("1:1 상담 삭제 도중 오류가 발생하였습니다. 잠시 후 다시 시도해주세요.");
			}
			location.reload();
		})
		.fail(function(data, status, err) {
			console.log("ERROR : " + err);
		});
	});

});
</script>


