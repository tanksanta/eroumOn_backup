<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<div id="page-content">
	<form action="./list" method="get" id="searchFrm" name="searchFrm">
		<input type="hidden" name="srchTarget" id="srchTarget" value="${param.srchTarget}" />
		<input type="hidden" name="cntPerPage" id="cntPerPage" value="${listVO.cntPerPage}" />
		<input type="hidden" name="sortBy" id="sortBy" value="${param.sortBy}" />

		<legend class="text-title2">묶음배송 그룹 검색</legend>
		<table class="table-detail">
			<colgroup>
				<col class="w-43">
				<col>
				<col class="w-43">
				<col>
			</colgroup>
			<tbody>
				<tr>
					<th scope="row"><label for="srchGdsNm">입점업체</label></th>
					<td>
						<div class="form-group w-84">
							<select id="selectTarget" class="form-control w-full">
								<c:forEach items="${entrpsList.listObject}" var="resultList" varStatus="status">
									<option value="${resultList.entrpsNo}" <c:if test="${resultList.entrpsNo eq param.srchTarget}">selected="true"</c:if>>${resultList.entrpsNm}</option>
								</c:forEach>
							</select> 
						</div>
						
					</td>
					
				</tr>

				<tr>
					<th scope="row"><label for="search-item1">그룹명</label></th>
					<td>
						<div class="form-group w-84">
							<input type="text" class="form-control flex-1" id="srchText" name="srchText" value="${param.srchText}">
						</div>
					</td>
					<th scope="row"><label for="srchGdsCd">사용여부</label></th>
					<td>
						<div class="form-check-group">
							<div class="form-check">
								<input class="form-check-input" type="radio" name="srchYn" id="search-item3" value="" checked> <label class="form-check-label" for="search-item3">전체</label>
							</div>
							<c:forEach var="yn" items="${useYn}">
								<div class="form-check">
									<input type="radio" value="${yn.key}" id="${yn.value}" name="srchYn" class="form-check-input" <c:if test="${yn.key eq param.srchYn}">checked="checked"</c:if>> <label class="form-check-label" for="${yn.value}">${yn.value}</label>
								</div>
							</c:forEach>
						</div>
					</td>
				</tr>
				
			</tbody>
		</table>
		<div class="btn-group mt-5">
			<button type="submit" class="btn-primary large shadow w-52 btn search">검색</button>
			<p class="modal show">모달 </p>
		</div>
		
	</form>

	<div class="mt-13 text-right mb-2">
		<button type="button" class="btn-primary btn add" >그룹 생성</button>
	</div>

	<c:set var="pageParam" value="curPage=${listVO.curPage}&srchText=${param.srchText}&srchYn=${param.srchYn}&srchTarget=${param.srchTarget}&cntPerPage=${param.cntPerPage}&sortBy=${param.sortBy}" />

	<h2 class="text-title2 mt-13">묶음배송 목록</h2>
	<table class="table-list">
		<colgroup>
			<col class="w-25">
			<col>
			<col class="w-30">
			<col class="w-40">
			<col class="w-30">
			<col class="w-40">
			<col class="w-25">
		</colgroup>
		<thead>
			<tr>
				<th scope="col">번호</th>
				<th scope="col">그룹명</th>
				<th scope="col">배송비 계산방식</th>
				<th scope="col">제주/도서산간 추가비용</th>
				<th scope="col">사용여부</th>
				<th scope="col">등록일</th>
				<th scope="col">수정일</th>
			</tr>
		</thead>
		<tbody>
			<c:forEach items="${listVO.listObject}" var="resultList" varStatus="status">
				<tr>
					<td>${listVO.startNo - status.index }</td>
					<td><a href="./detail?entrpsDlvygrpNo=${resultList.entrpsDlvygrpNo}&${pageParam}">${resultList.entrpsDlvygrpNm}</a></td>
					<td>${dlvyCalcTyList[resultList.dlvyCalcTy]}</td>
					<td><fmt:formatNumber value="${resultList.dlvyAditAmt}" pattern="###,###" /></td>
					<td>${useYn[resultList.useYn]}</td>
					<td><fmt:formatDate value="${resultList.regDt}" pattern="yyyy-MM-dd" /></td>
					<td><fmt:formatDate value="${resultList.mdfcnDt}" pattern="yyyy-MM-dd" /></td>
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
	<!--div class="btn-group right mt-8">
		<a href="./form?${pageParam}" class="btn-primary large shadow">등록</a>
	</div-->
</div>

<script type="text/javascript" src="/html/page/admin/assets/script/_mng/sysmng/entrps/dlvygrp/JsPopupEntrpsDlvyGrpModal.js?v=<spring:eval expression="@version['assets.version']"/>"></script>

<script>
$(function(){
	$("#selectTarget").on("change",function(){
		$("#srchTarget").val($(this).val());
		$("#srchText").val('');

		$(".btn.search").click();
	});

	$(".btn.add").on("click",function(){
		// $("#searchFrm").attr("action","./excel");
		// $("#searchFrm").submit();
		// $("#searchFrm").attr("action","./list");

		var aaa = new JsPopupEntrpsDlvyGrpModal(window, ".modal2-con .dlvygrp_add_modal", "dlvygrp_add_modal", 1, "/_mng/sysmng/entrps/dlvygrp/modalform", "/_mng/sysmng/entrps/dlvygrp/modal.json", {})
	
		aaa.fn_loading_form_data_call({"entrpsNo":$("#srchTarget").val()}, false, {})
	});

	
});

function fn_popup_selected(alert_val, popKind, popup_param, data, extra){
	$(".btn.search").click();
}
</script>