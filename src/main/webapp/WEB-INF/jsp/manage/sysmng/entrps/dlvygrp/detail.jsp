<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<div id="page-content">
	<form:form name="frmEntrps" id="frmEntrps" modelAttribute="entrpsVO" method="post" action="./action">
		<form:hidden path="entrpsNo" />
		<form:hidden path="crud" />

		<input type="hidden" name="srchTarget" id="srchTarget" value="${param.srchTarget}" />
		<input type="hidden" name="srchText" id="srchText" value="${param.srchText}" />
		<input type="hidden" name="srchYn" id="srchYn" value="${param.srchYn}" />
		<input type="hidden" name="cntPerPage" id="cntPerPage" value="${param.cntPerPage}" />
		<input type="hidden" name="curPage" id="curPage" value="${param.curPage}" />
		<input type="hidden" name="sortBy" id="sortBy" value="${param.sortBy}" />
		<input type="hidden" name="entrpsDlvygrpNo" id="entrpsDlvygrpNo" value="${param.entrpsDlvygrpNo}" />

		<fieldset>
			<legend class="text-title2">그룹 상세정보</legend>
			<table class="table-detail">
				<colgroup>
					<col class="w-43">
					<col>
					<col class="w-43">
					<col>
				</colgroup>
				<tbody>
					<tr>
						<th scope="row"><label for="search-item1">그룹명</label></th>
						<td>
							<div class="form-group w-84">
								${entrpsDlvygrpVO.entrpsDlvygrpNm}
							</div>
						</td>
						<th scope="row"><label for="srchGdsCd">사용여부</label></th>
						<td>
							${useYn[entrpsDlvygrpVO.useYn]}
						</td>
					</tr>
					<tr>
						<th scope="row"><label for="search-item1">배송비 계산방식</label></th>
						<td>
							<div class="form-group w-84">
								${dlvyCalcTyList[entrpsDlvygrpVO.dlvyCalcTy]}
							</div>
						</td>
						<th scope="row"><label for="srchGdsCd">제주/도서산간 추가비용</label></th>
						<td>
							<fmt:formatNumber value="${entrpsDlvygrpVO.dlvyAditAmt}" pattern="###,###" /> 원
						</td>
					</tr>
				</tbody>
			</table>
		</fieldset>
		<div class="btn-group right save_btn_grp">
			<button type="button" class="btn-success large shadow btn update">수정</button>
			<button type="button" class="btn-primary large shadow btn delete">삭제</button>
		</div>

		
		<h2 class="text-title2 mt-13">그룹내 상품목록</h2>
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
					<th scope="col">상품구분</th>
					<th scope="col">이미지</th>
					<th scope="col">상품코드</th>
					<th scope="col">상품명</th>
					<th scope="col">품목코드</th>
					<th scope="col">판매가</th>
					<th scope="col">급여가</th>
					<th scope="col">전시여부</th>
					<th scope="col">임시여부</th>
					<th scope="col">상품태그</th>
				</tr>
			</thead>
			<tbody>
				<c:forEach items="${listVO.listObject}" var="resultList" varStatus="status">
					<tr>
						<td>${listVO.startNo - status.index }</td>
					</tr>
				</c:forEach>
				<c:if test="${empty gdsList.listObject}">
					<tr>
						<td class="noresult" colspan="11">검색조건을 만족하는 결과가 없습니다.</td>
					</tr>
				</c:if>
			</tbody>
		</table>


		<c:set var="pageParam" value="curPage=${param.curPage}${!empty(listVO.urlParam)? '&amp;' : ''}${listVO.urlParam}&srchText=${param.srchText}&srchYn=${param.srchYn}&srchTarget=${param.srchTarget }" />
		<div class="btn-group mt-8 right">
			<button type="submit" class="btn-primary large shadow">저장</button>
			<a href="./list?${pageParam}" class="btn-secondary large shadow btn list">목록</a>
		</div>
	</form:form>
</div>
<!-- //page content -->

<script type="text/javascript" src="/html/page/admin/assets/script/_mng/sysmng/entrps/dlvygrp/JsPopupEntrpsDlvyGrpModal.js?v=<spring:eval expression="@version['assets.version']"/>"></script>

<script>
	var jsPopup;
	$(document).ready(function() {
		$(".btn.update").on("click",function(){
			if (jsPopup == undefined){
				jsPopup = new JsPopupEntrpsDlvyGrpModal(this, ".modal2-con .dlvygrp_add_modal", "dlvygrp_add_modal", 1, "/_mng/sysmng/entrps/dlvygrp/modalform", "/_mng/sysmng/entrps/dlvygrp/dlvygrpno.json", {})
			}

			var data = {"entrpsNo":$("#srchTarget").val()
						, "entrpsDlvygrpNo":$("#entrpsDlvygrpNo").val()
						}
		
			jsPopup.fn_loading_form_data_call( data , true , data );
		});

		$(".btn.delete").on("click",function(){
			
			if (!confirm("삭제하시겠습니까?")){
				return;
			}
		
			var data = {"entrpsNo":$("#srchTarget").val()
						, "entrpsDlvygrpNo":$("#entrpsDlvygrpNo").val()
						}

			jsCallApi.call_api_post_json(window,  '/_mng/sysmng/entrps/dlvygrp/dlvygrpmodaldelete.json', 'fn_entrpsDlvygrpNo_deleted', data, null ); 
		
		});
	
	});

	function fn_entrpsDlvygrpNo_deleted(result, fail, data, param){
		if (result != undefined && result.success){
            if (result.sucmsg != undefined && result.sucmsg.length > 0){
                alert(result.sucmsg)
            }
        }

		window.location.href = $('.btn.list').attr('href');
	}
</script>
