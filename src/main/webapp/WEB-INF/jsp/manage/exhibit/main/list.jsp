<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<div id="page-content">
	<form action="./list" method="get" id="searchFrm" name="searchFrm">
			<input type="hidden" name="cntPerPage" id="cntPerPage" value="${listVO.cntPerPage}" />
           	<input type="hidden" name="sortBy" id="sortBy" value="${param.sortBy}" />
		<fieldset>
			<legend class="text-title2">메인 검색</legend>
			<table class="table-detail">
				<colgroup>
					<col class="w-43">
					<col>
				</colgroup>
				<tbody>
					<tr>
						<th scope="row"><label for="search-item1">테마구분</label></th>
						<td>
							<select id="srchThemaTy" name="srchThemaTy" class="form-control">
								<option value="">선택</option>
								<c:forEach var="mainTy" items="${mainTyCode}">
									<option value="${mainTy.key}">${mainTy.value}</option>
								</c:forEach>
							</select>
						</td>
					</tr>
					<tr>
						<th scope="row"><label for="search-item1">주제명</label></th>
						<td><input type="text" class="form-control w-84" id="srchText" name="srchText" value="${param.srchText}"></td>
					</tr>
					<tr>
						<th scope="row"><label for="search-item2">상태</label></th>
						<td>
							<div class="form-check-group">
								<div class="form-check">
									<input class="form-check-input" type="radio" name="srchUseYn" id="srchUseYn" value="" checked>
									<label class="form-check-label" for="srchUseYn">전체</label>
								</div>
								<c:forEach var="yn" items="${useYnCode}" varStatus="status">
									<div class="form-check">
										<input type="radio" value="${yn.key}" id="srchUseYn${status.index}" name="srchUseYn" class="form-check-input" <c:if test="${yn.key eq param.srchUseYn}">checked="checked"</c:if>>
										<label class="form-check-label" for="srchUseYn${status.index}">${yn.value}</label>
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

	<c:set var="pageParam" value="curPage=${listVO.curPage}&srchText=${param.srchText}&srchUseYn=${param.srchUseYn}&cntPerPage=${param.cntPerPage}&sortBy=${param.sortBy}" />
	<p class="text-title2 mt-13">메인 목록<br />
	<btn class="btn btn-library" type="button" id="choose_delete">선택 삭제</btn>
	<btn class="btn btn-library" type="button" id="sort_save">노출순서 저장</btn>
	</p>
	<table class="table-list">
		<colgroup>
			<col class="w-15">
			<col class="w-30">
			<col class="w-25">
			<col class="w-25">
			<col>
			<col class="w-25">
			<col class="w-20">
			<col class="w-15">
		</colgroup>
		<thead>
			<tr>
				<th scope="col">
					<div class="form-check">
						<input type="checkbox" id="check_all" name="check_all" value="Y" class="form-check-input">
					</div>
				</th>
				<th scope="col">번호</th>
				<th scope="col">메인 노출 순서</th>
				<th scope="col">테마 구분</th>
				<th scope="col">주제명</th>
				<th scope="col">등록일</th>
				<th scope="col">상태</th>
				<th scope="col">조회수</th>
			</tr>
		</thead>
		<tbody>
			<c:forEach var="resultList" items="${listVO.listObject}" varStatus="status">
				<tr>
					<td>
						<div class="form-check">
							<input type="checkbox" id="check${staus.index}" name="check_item" value="${resultList.mainNo}" class="form-check-input"/>
							<label for="check${staus.index}" class="form-input-label"></label>
						</div>
					</td>
					<td>${resultList.mainNo}</td>
					<td>
						<input type="text" class="form-control text-center" id="item${status.index}" name="item_child" value="${resultList.sortNo}" data-main-no="${resultList.mainNo}"/>
					</td>
					<td>${mainTyCode[resultList.themaTy]}</td>
					<td>
						<a href="./form?mainNo=${resultList.mainNo}">${resultList.sj}</a>
					</td>
					<td><fmt:formatDate value="${resultList.regDt}" pattern="yyyy-MM-dd HH:mm:ss" /></td>
					<td>${useYnCode[resultList.useYn]}</td>
					<td>${resultList.rdcnt}</td>
				</tr>
			</c:forEach>
			<c:if test="${empty listVO.listObject}">
				<tr>
					<td class="noresult" colspan="8">검색조건을 만족하는 결과가 없습니다.</td>
				</tr>
			</c:if>
		</tbody>
	</table>

	<p class="text-red-500">※ 노출순서 유의사항: ’배너 하프형’은 2개가 한쌍으로 함께 전시되어야 합니다.</p>
	<p class="text-red-500">※ 전시리스트는 최대 5열까지 사용하는 것을 권장합니다.</p>
	<p>※ 주제명을 클릭하면 상세/수정 페이지로 이동합니다.</p>
	<p>※ 메인 노출 순서에 숫자 입력후 노출 순서 저장 버튼을 눌러야 저장됩니다.</p>
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
</div>
<script>
$(function(){

	// 전체 선택
	$("#check_all").on("click",function(){
		let checkFlag = false;
		if($(this).is(":checked")){
			checkFlag = true;
		}

		$("input[name='check_item']").prop("checked",checkFlag);
	});

	// 선택 삭제
	$("#choose_delete").on("click",function(){
		let arrDel = [];
		if($("input[name='check_item']:checked").length < 1){
			alert("삭제할 게시물을 선택해주세요.");
		}else{
			if(confirm("삭제하시겠습니까?")){
				$("input[name='check_item']:checked").each(function(){
					arrDel.push($(this).val());
				});
				console.log(arrDel);

				$.ajax({
      				type : "post",
      				url  : "deleteMain.json",
      				data : {
      					mainNos : arrDel
      				},
      				traditional : true,
      				dataType : 'json'
      			})
      			.done(function(data) {
      				if(data.result){
						location.reload();
      				}else{
      					alert("메인 삭제 중 오류가 발생하였습니다. 잠시 후 다시 시도해주세요.");
      				}
      			})
      			.fail(function(data, status, err) {
      				console.log('error forward : ' + data);
      			});
			}else{
				return false;
			}
		}

	});

	// 노출 순서 저장
	$("#sort_save").on("click",function(){
		let arrSort = [];

		if(confirm("저장하시겠습니까?")){
			$("input[name='item_child']").each(function(){
				arrSort.push($(this).data("mainNo") + "/" + $(this).val());
			});
			console.log(arrSort);

			$.ajax({
  				type : "post",
  				url  : "sortSave.json",
  				data : {
  					sortNos : arrSort
  				},
  				traditional : true,
  				dataType : 'json'
  			})
  			.done(function(data) {
  				if(data.result){
  					alert("저장되었습니다.");
					location.reload();
  				}else{
  					alert("노출 순서 변경 중 오류가 발생하였습니다. 잠시 후 다시 시도해주세요.");
  				}
  			})
  			.fail(function(data, status, err) {
  				console.log('error forward : ' + data);
  			});
		}else{
			return false;
		}
	});

	$("input[name='item_child']").on("focusout",function(){
		if($(this).val() == ''){
			$(this).val(100);
		}
	});
});
</script>
