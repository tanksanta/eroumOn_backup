<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<form action="./list" id="searchFrm" name="searchFrm" method="get">
	<input type="hidden" name="cntPerPage" id="cntPerPage" value="${listVO.cntPerPage}" />
	<input type="hidden" name="sortBy" id="sortBy" value="${param.sortBy}" />

	<fieldset>
		<legend class="text-title2">배너 검색</legend>
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
					<th scope="row"><label for=srchBannerTy>배너구분</label></th>
						<td>
							<select class="form-control w-39" id="srchBannerTy" name="srchBannerTy">
									<option value="">전체</option>
									<c:forEach var="banner" items="${bannerTyCode}">
										<option value="${banner.key}" <c:if test="${banner.key eq param.srchBannerTy}">selected="selected"</c:if>>${banner.value}</option>
									</c:forEach>
							</select>
						</td>
				</tr>
				<tr>
					<th scope="row"><label for="search-item3">배너명</label></th>
					<td><input type="text" class="form-control w-full" id="srchBannerNm" name="srchBannerNm" value="${param.srchBannerNm}"></td>
				</tr>
				<tr>
					<th scope="row"><label for="search-item4">노출 여부</label></th>
					<td>
						<div class="form-check-group">
							<div class="form-check">
								<input class="form-check-input" type="radio" name="srchUseYn" id="srchUseYn" value="" checked>
								<label class="form-check-label" for="srchUseYn">전체</label>
							</div>
							<c:forEach var="use" items="${useYnCode}" varStatus="status">
								<div class="form-check">
									<input class="form-check-input" type="radio" name="srchUseYn" id="srchUseYn${status.index}" value="${use.key}" <c:if test="${param.srchUseYn eq use.key}">checked="checked"</c:if>>
									<label class="form-check-label" for="srchUseYn${status.index}">${use.value}</label>
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

<p class="text-title2 mt-13">배너 목록<br />
<button type="button" class="btn btn-light" id="choose_delete">선택 삭제</button>
<button type="button" class="btn btn-light" id="sort_reload">노출 순서 저장</button>
</p>

<table class="table-list">
	<colgroup>
		<col class="w-15">
		<col class="w-15">
		<col class="w-35">
		<col class="w-35">
		<col>
		<col class="w-45">
		<col class="w-30">
		<col class="w-20">
		<col class="w-15">
	</colgroup>
	<thead>
		<tr>
			<th scope="col">
				<div class="form-check">
					<input type="checkbox" id="check_all" name="check_all" value="Y" class="form-check-input"/>
					<label for="check_all" class="form-check-label"></label>
				</div>
			</th>
			<th scope="col">번호</th>
			<th scope="col">메인 노출 순서</th>
			<th scope="col">배너 구분</th>
			<th scope="col">배너명</th>
			<th scope="col">노출기간</th>
			<th scope="col">등록일</th>
			<th scope="col">노출여부</th>
			<th scope="col">조회수</th>
		</tr>
	</thead>
	<tbody>
		<c:forEach var="resultList" items="${listVO.listObject}" varStatus="status">

		<c:set var="pageParam" value="bannerNo=${resultList.bannerNo}&amp;curPage=${listVO.curPage}${!empty(listVO.urlParam)? '&amp;' : ''}${listVO.urlParam}" />
			<tr>
				<td>
					<div class="form-check">
						<input type="checkbox" id="check${status.index}" name="check-input" value="Y" class="form-check-input" data-banner-no="${resultList.bannerNo}"/>
						<label for="check${status.index}" class="form-input-label"></label>
					</div>
				</td>
				<td>${listVO.startNo - status.index}</td>
				<td>
					<input type="text" id="sortNo${status.index}" name="item_sort" class="form-control text-center" value="${resultList.sortNo}" data-banner-no="${resultList.bannerNo}" />
				</td>
				<td>${bannerTyCode[resultList.bannerTy]}</td>
				<td class="text-left"><a href="./form?${pageParam}">${resultList.bannerNm}</a></td>
				<td>
					<fmt:formatDate value="${resultList.bgngDt}" pattern="yyyy-MM-dd" />
					~
					 <fmt:formatDate value="${resultList.endDt}" pattern="yyyy-MM-dd" />
				</td>
				<td><fmt:formatDate value="${resultList.regDt}" pattern="yyyy-MM-dd" /></td>
				<td>${useYnCode[resultList.useYn]}</td>
				<td>${resultList.rdcnt}</td>
			</tr>
		</c:forEach>
		<c:if test="${empty listVO.listObject}">
			<tr>
				<td class="noresult" colspan="9">검색조건을 만족하는 결과가 없습니다.</td>
			</tr>
		</c:if>
	</tbody>
</table>

<p>※ 배너명을 클릭하면 상세/수정 페이지로 이동합니다.</p><br />
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

<c:set var="pageParam" value="curPage=${param.curPage}&srchBgngDt=${param.srchBgngDt}&srchEndDt=${param.srchEndDt}&srchBannerNm=${param.srchBannerNm}&srchUseYn=${param.srchUseYn}&srchBannerTy=${param.srchBannerTy}" />
<div class="btn-group right mt-8">
	<a href="./form?${pageParam}" class="btn-primary large shadow">등록</a>
</div>

<script>
$(function(){

	// 선택 삭제
	$("#choose_delete").on("click",function(){
		if(confirm("삭제하시겠습니까?")){
			let arrDelBanner = [];

			if($("input[name='check-input']:checked").length > 0){
				$("input[name='check-input']:checked").each(function(){
					arrDelBanner.push($(this).data("bannerNo"));
				});
				console.log(arrDelBanner);

				$.ajax({
      				type : "post",
      				url  : "deleteBanner.json",
      				data : {
      					bannerNos : arrDelBanner
      				},
      				traditional : true,
      				dataType : 'json'
      			})
      			.done(function(data) {
      				if(data.result){
						location.reload();
      				}else{
      					alert("배너 삭제 중 오류가 발생하였습니다. 잠시 후 다시 시도해주세요.");
      				}
      			})
      			.fail(function(data, status, err) {
      				console.log('error forward : ' + data);
      			});

			}else{
				alert("삭제할 배너를 선택해주세요");
				return false;
			}
		}else{
			return false;
		}


	});

	// 체크박스 전체선택
	$("#check_all").on("click",function(){
		let checkFlag = false;
		if($(this).is(":checked")){
			checkFlag = true;
		}
		$("input[name='check-input']").prop("checked",checkFlag);
	});

	// 정렬 순서 저장
	$("#sort_reload").on("click",function(){
		if(confirm("저장하시겠습니까?")){
			let arrSortNo = [];

			$("input[name='item_sort']").each(function(){
				arrSortNo.push($(this).data("bannerNo")+"/"+$(this).val());
			});

			$.ajax({
  				type : "post",
  				url  : "updateSortNo.json",
  				data : {
  					arrSortNo : arrSortNo
  				},
  				traditional : true,
  				dataType : 'json'
  			})
  			.done(function(data) {
  				if(data.result){
  					alert("저장되었습니다.");
					location.reload();
  				}else{
  					alert("순서 업데이트 중 오류가 발생하였습니다. 잠시 후 다시 시도해주세요.");
  				}
  			})
  			.fail(function(data, status, err) {
  				console.log('error forward : ' + data);
  			});
		}else{
			return false;
		}

	});



});
</script>
