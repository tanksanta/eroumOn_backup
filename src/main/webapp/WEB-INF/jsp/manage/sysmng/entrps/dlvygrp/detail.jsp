<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<div id="page-content">
	<form:form name="frmEntrpsDlvygrp" id="frmEntrpsDlvygrp" modelAttribute="entrpsDlvygrpVO" method="post" action="./action">
		<form:hidden path="entrpsNo" />
		<form:hidden path="entrpsDlvygrpNo" />
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
							${useYnCode[entrpsDlvygrpVO.useYn]}
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
		<div class="btn-group right save_btn_grp mt-5">
			<button type="button" class="btn-success large shadow btn dlvygrp update">수정</button>
			<button type="button" class="btn-primary large shadow btn dlvygrp delete">삭제</button>
		</div>

		
		<h2 class="text-title2 mt-13">그룹내 상품목록</h2>
		<table class="table-list">
			<colgroup>
				<col class="w-25">
				<col class="w-25">
				<col class="w-30">
				<col class="w-40">
				<col >
				<col class="w-60">
				<col class="w-25">
				<col class="w-25">
				<col class="w-25">
				<col class="w-25">
				<col class="w-25">
			</colgroup>
			<thead>
				<tr>
					<th scope="col">
						<div class="form-check">
							<input class="form-check-input" type="checkbox" id="check_all" name="check_all">
						</div>
					</th>
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
				<c:forEach items="${gdsList.listObject}" var="resultList" varStatus="status">
					<tr>
						<td>
							<div class="form-check">
								<input class="form-check-input"  type="checkbox" name="arrGdsNo" value="${resultList.gdsNo}">
							</div>
						</td>
						<td>${gdsTyCode[resultList.gdsTy]}</td>
						<td>
							<c:choose>
								<c:when test="${!empty resultList.thumbnailFile }">
									<%--기본 썸네일--%>
							<img src="/comm/getImage?srvcId=GDS&amp;upNo=${resultList.thumbnailFile.upNo }&amp;fileTy=${resultList.thumbnailFile.fileTy }&amp;fileNo=${resultList.thumbnailFile.fileNo }&amp;thumbYn=Y" alt="" class="rounded-md">
								</c:when>
								<c:otherwise>
									<%--default > 교체 필요 --%>
							<img src="/html/page/admin/assets/images/noimg.jpg" alt="">
								</c:otherwise>
							</c:choose>
						</td>
						<td>
							<a href="/_mng/gds/gds/form?gdsNo=${resultList.gdsNo}" target="_blank">${resultList.gdsCd}</a>
						</td>
						<td class="text-left"><a href="/_mng/gds/gds/form?gdsNo=${resultList.gdsNo}" target="_blank">${resultList.gdsNm}</a></td>
						<td>
							<c:choose>
								<c:when test="${empty resultList.itemCd}" >-</c:when>
								<c:otherwise>${resultList.itemCd}</c:otherwise>
							</c:choose>
						</td>
						<td><fmt:formatNumber value="${resultList.pc}" pattern="###,###" /></td>
						<td><fmt:formatNumber value="${resultList.bnefPc}" pattern="###,###" /></td>
						<td>${dspyYnCode[resultList.dspyYn]}</td>
						<td>${useYnCode[resultList.tempYn]}</td>
						<td>
							<c:if test="${!empty resultList.gdsTagVal}">
								<c:forEach var="tagList" items="${fn:split(fn:replace(resultList.gdsTagVal,' ',''),',')}">
									${gdsTagCode[tagList]}
								</c:forEach>
							</c:if>
							<c:if test="${empty resultList.gdsTagVal}">
								-
							</c:if>
						</td>
					</tr>
				</c:forEach>
				<c:if test="${empty gdsList.listObject}">
					<tr>
						<td class="noresult" colspan="11">검색조건을 만족하는 결과가 없습니다.</td>
					</tr>
				</c:if>
			</tbody>
		</table>

		<div class="pagination mt-7">
			<mngr:mngrPaging listVO="${gdsList}"/>

			<div class="sorting2">
				<label for="countPerPage">출력</label>
				<select name="countPerPage" id="countPerPage" class="form-control">
					<option value="10" ${gdsList.cntPerPage eq '10' ? 'selected' : '' }>10개</option>
					<option value="20" ${gdsList.cntPerPage eq '20' ? 'selected' : '' }>20개</option>
					<option value="30" ${gdsList.cntPerPage eq '30' ? 'selected' : '' }>30개</option>
				</select>
			</div>

			<div class="counter">총 <strong>${gdsList.totalCount}</strong>건, <strong>${gdsList.curPage}</strong>/${gdsList.totalPage} 페이지</div>
		</div>


		<c:set var="pageParam" value="curPage=${param.curPage}${!empty(listVO.urlParam)? '&amp;' : ''}${listVO.urlParam}&srchText=${param.srchText}&srchYn=${param.srchYn}&srchTarget=${param.srchTarget }" />
		<div class="btn-group mt-8 right">
			<button type="button" class="btn-primary large shadow float-left f_useYn btn gds selected reset ">선택삭제</button>
			<!--button type="submit" class="btn-primary large shadow">저장</button-->
			<a href="./list?${pageParam}" class="btn-secondary large shadow btn list">목록</a>
		</div>
	</form:form>
</div>
<!-- //page content -->

<script type="text/javascript" src="/html/page/admin/assets/script/_mng/sysmng/entrps/dlvygrp/JsPopupEntrpsDlvyGrpModal.js?v=<spring:eval expression="@version['assets.version']"/>"></script>

<script>
	var jsPopup;
	$(document).ready(function() {

		jsCommon.fn_checkbox_ctl_all_list("input[type='checkbox'][name='check_all']", "input[type='checkbox'][name='arrGdsNo']")

		$(".btn.dlvygrp.update").on("click",function(){
			if (jsPopup == undefined){
				jsPopup = new JsPopupEntrpsDlvyGrpModal(window, ".modal2-con .dlvygrp_add_modal", "dlvygrp_add_modal", 1, "/_mng/sysmng/entrps/dlvygrp/modalform", "/_mng/sysmng/entrps/dlvygrp/dlvygrpno.json", {})
			}

			var data = {"entrpsNo":$("#srchTarget").val()
						, "entrpsDlvygrpNo":$("#entrpsDlvygrpNo").val()
						}
		
			jsPopup.fn_loading_form_data_call( data , true , data );
		});

		$(".btn.dlvygrp.delete").on("click",function(){
			
			if (!confirm("삭제하시겠습니까?")){
				return;
			}
		
			var data = {"entrpsNo":$("#srchTarget").val()
						, "entrpsDlvygrpNo":$("#entrpsDlvygrpNo").val()
						}

			jsCallApi.call_api_post_json(window,  '/_mng/sysmng/entrps/dlvygrp/dlvygrpmodaldelete.json', 'fn_entrpsDlvygrpNo_msg_tomove_list', data, null ); 
		
		});
	
		$(".btn.gds.selected.reset").on("click",function(){
			let arrGdsNo = $(":checkbox[name=arrGdsNo]:checked").map(function(){return $(this).val();}).get();
			if (arrGdsNo.length < 1){
				alert("체크박스를 선택하여 주십시오.")
				return;
			}
		
			if (!confirm("선택하신 상품을 묶음그룹에서 삭제하시겠습니까?\n삭제시 해당 상품의 묶음배송이 해지 됩니다.")){
				return
			}

			var data = {"entrpsNo":$("#srchTarget").val()
						, "entrpsDlvygrpNo":$("#entrpsDlvygrpNo").val()
						, arrGdsNo
						}

			jsCallApi.call_api_post_json(window,  '/_mng/sysmng/entrps/dlvygrp/dlvygrpgdsreset.json', 'fn_entrpsDlvygrpNo_msg_reload', data, null ); 
		});
	});

	function fn_entrpsDlvygrpNo_msg_tomove_list(result, fail, data, param){
		if (result != undefined && result.success){
            if (result.sucmsg != undefined && result.sucmsg.length > 0){
                alert(result.sucmsg)
            }
        }

		window.location.href = $('.btn.list').attr('href');
	}
	function fn_entrpsDlvygrpNo_msg_reload(result, fail, data, param){
		if (result != undefined && result.success){
            if (result.sucmsg != undefined && result.sucmsg.length > 0){
                alert(result.sucmsg)
            }
        }

		location.reload();
	}

	function fn_popup_selected(alert_val, popKind, popup_param, data, extra){
		$(".btn.search").click();
	}
</script>
