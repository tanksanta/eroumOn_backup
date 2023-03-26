<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<form:form name="frmBplc" id="frmBplc" modelAttribute="bplcVO" method="post" action="./action">
	<!-- 검색조건 -->
	<input type="hidden" name="cntPerPage" id="cntPerPage" value="${param.cntPerPage}" />
	<input type="hidden" name="curPage" id="curPage" value="${param.curPage}" />
	<input type="hidden" name="sortBy" id="sortBy" value="${param.sortBy}" />
	<input type="hidden" name="srchBgngDt" id="srchBgngDt" value="${param.srchBgngDt}" />
	<input type="hidden" name="srchEndDt" id="srchEndDt" value="${param.srchEndDt}" />
	<input type="hidden" name="srchBplcId" id="srchBplcId" value="${param.srchBplcId}" />
	<input type="hidden" name="srchBplcNm" id="srchBplcNm" value="${param.srchBplcNm }" />
	<input type="hidden" name="srchRprsvNm" id="srchRprsvNm" value="${param.srchRprsvNm }" />
	<input type="hidden" name="srchBrno" id="srchBrno" value="${param.srchBrno }" />
	<input type="hidden" name="srchPicNm" id="srchPicNm" value="${param.srchPicNm }" />
	<input type="hidden" name="srchPicTelno" id="srchPicTelno" value="${param.srchPicTelno }" />
	<input type="hidden" name="srchAprvTy" id="srchAprvTy" value="${param.srchAprvTy }" />

	<form:hidden path="crud" value="UPDATE" />
	<form:hidden path="uniqueId" value="${bplcVO.uniqueId}" />

	<fieldset>
		<legend class="text-title2 relative">기본정보</legend>
		<table class="table-detail">
			<colgroup>
				<col class="w-43">
				<col>
			</colgroup>
			<tbody>
				<tr>
					<th scope="row">아이디<span class="require"></span></th>
					<td>${bplcVO.bplcId}</td>
				</tr>
				<tr>
					<th scope="row">기업명<span class="require"></span></th>
					<td>${bplcVO.bplcNm}</td>
				</tr>
				<tr>
					<th scope="row">전화번호<span class="require"></span></th>
					<td>${bplcVO.telno}</td>
				</tr>
				<tr>
					<th scope="row">팩스번호</th>
					<td>${bplcVO.fxno}</td>
				</tr>
				<tr>
					<th>대표 이미지</th>
					<td><c:if test="${!empty bplcVO.proflImg}">
							<div class="form-group" style="display: flex;">
								<a href="/comm/PROFL/getFile?fileName=${bplcVO.proflImg}">${bplcVO.proflImg}</a>&nbsp;&nbsp;
							</div>
						</c:if>
					</td>
					</td>
				</tr>
			</tbody>
		</table>
	</fieldset>

	<fieldset class="mt-13">
		<legend class="text-title2 relative"> 업체정보 </legend>
		<table class="table-detail">
			<colgroup>
				<col class="w-43">
				<col>
			</colgroup>
			<tbody>
				<tr>
					<th scope="row">사업자등록번호<span class="require"></span></th>
					<td>${bplcVO.brno}</td>
				</tr>
				<tr>
					<th scope="row">장기요양기관번호<span class="require"></span></th>
					<td>${bplcVO.rcperInstNo}</td>
				</tr>
				<tr>
					<th scope="row">대표자명<span class="require"></span></th>
					<td>${bplcVO.rprsvNm}</td>
				</tr>
				<tr>
					<th scope="row">업태<span class="require"></span></th>
					<td>${bplcVO.bizcnd}</td>
				</tr>
				<tr>
					<th scope="row">종목<span class="require"></span></th>
					<td>${bplcVO.iem}</td>
				</tr>
				<tr>
					<th scope="row">사업장주소<span class="require"></span></th>
					<td>
							${bplcVO.zip} ${bplcVO.addr } ${bplcVO.daddr }
					</td>
				</tr>
				<tr>
					<th scope="row">배송지주소<span class="require"></span></th>
					<td>
					${bplcVO.dlvyZip} ${bplcVO.dlvyAddr } ${bplcVO.dlvyDaddr }
					</td>
				</tr>
				<tr>
					<th scope="row">세금계산서 수신메일<span class="require"></span></th>
					<td>${bplcVO.taxbilEml}</td>
				</tr>
				<tr>
					<th scope="row"><label for="bsnmCeregrt" class="require">사업자 등록증</th>
					<td><c:if test="${!empty bplcVO.bsnmCeregrt}">
							<div class="form-group" style="display: flex;">
								<a href="/comm/CEREGRT/getFile?fileName=${bplcVO.bsnmCeregrt}">${bplcVO.bsnmCeregrt}</a>&nbsp;&nbsp;
							</div>
						</c:if>
					</td>
				</tr>
				<tr>
					<th scope="row"><label for="bsnmOffcs" class="require">사업자 직인</th>
					<td><c:if test="${!empty bplcVO.bsnmOffcs}">
							<div class="form-group" style="display: flex;">
								<a href="/comm/OFFCS/getFile?fileName=${bplcVO.bsnmOffcs}">${bplcVO.bsnmOffcs}</a>&nbsp;&nbsp;
							</div>
						</c:if>
					</td>
				</tr>
			</tbody>
		</table>
	</fieldset>

	<fieldset class="mt-13">
		<legend class="text-title2 relative"> 담당자정보 </legend>
		<table class="table-detail">
			<colgroup>
				<col class="w-43">
				<col>
			</colgroup>
			<tbody>
				<tr>
					<th scope="row">담당자명<span class="require"></span></th>
					<td>${bplcVO.picNm}</td>
				</tr>
				<tr>
					<th scope="row">담당자 연락처<span class="require"></span></th>
					<td>${bplcVO.picTelno}</td>
				</tr>
				<tr>
					<th scope="row">담당자 이메일<span class="require"></span></th>
					<td>${bplcVO.picEml}</td>
				</tr>
			</tbody>
		</table>
	</fieldset>

	<fieldset class="mt-13">
		<legend class="text-title2 relative"> 정산정보 </legend>
		<table class="table-detail">
			<colgroup>
				<col class="w-43">
				<col>
			</colgroup>
			<tbody>
				<tr>
					<th scope="row">은행<span class="require"></span></th>
					<td>${bankTyCode[bplcVO.clclnBank]}</td>
				</tr>
				<tr>
					<th scope="row">계좌번호<span class="require"></span></th>
					<td>${bplcVO.clclnActno}</td>
				</tr>
				<tr>
					<th scope="row">예금주<span class="require"></span></th>
					<td>${bplcVO.clclnDpstr}</td>
				</tr>
			</tbody>
		</table>
	</fieldset>

	<fieldset class="mt-13">
		<legend class="text-title2 relative"> 승인관리 </legend>
		<table class="table-detail">
			<colgroup>
				<col class="w-43">
				<col>
			</colgroup>
			<tbody>
				<tr>
					<th scope="row">승인여부<span class="require"></span></th>
					<td>
						<c:if test="${bplcVO.aprvTy eq 'W'}">
							<div class="form-check-group">
								<c:forEach items="${aprvTyCode}" var="aprvTy" varStatus="status">
									<div class="form-check">
										<form:radiobutton class="form-check-input" path="aprvTy" id="aprvTy${status.index}" value="${aprvTy.key}" />
										<label class="form-check-label" for="aprvTy${status.index}">${aprvTy.value}</label>
									</div>
								</c:forEach>
							</div>
						</c:if>
						<c:if test="${bplcVO.aprvTy ne 'W'}">${aprvTyCode[bplcVO.aprvTy]}</c:if>
					</td>
				</tr>
				<tr class="resnView" style="display:none;">
					<th scope="row">미승인 사유<span class="require"></span></th>
					<td>
						<c:if test="${bplcVO.aprvTy eq 'R' }">${bplcVO.rejectResn}</c:if>
						<c:if test="${bplcVO.aprvTy ne 'R' }"><form:input class="form-control w-90" maxlength="100" path="rejectResn" value="${bplcVO.rejectResn}" /></c:if>
					</td>
				</tr>
				<c:if test="${bplcVO.aprvTy eq 'R'}">
					<tr>
						<th scope="row">처리자 / 처리일</th>
						<td>${bplcVO.mdfr} / <fmt:formatDate value="${bplcVO.mdfcnDt}" pattern="yyyy-MM-dd HH:mm" /></td>
					</tr>
				</c:if>
			</tbody>
		</table>
	</fieldset>


	<div class="btn-group right mt-8">
		<c:if test="${bplcVO.aprvTy eq 'W' }">
			<button type="submit" class="btn-primary large shadow">저장</button>
		</c:if>

		<c:set var="pageParam" value="uniqueId=${bplcVO.uniqueId}&amp;curPage=${param.curPage}&amp;cntPerPage=${param.cntPerPage}&amp;srchBgngDt=${param.srchBgngDt}&amp;srchEndDt=${param.srchEndDt}&amp;sortBy=${param.sortBy}&amp;srchBplcId=${param.srchBplcId}
		&amp;srchBplcNm=${param.srchBplcNm}&amp;srchRprsvNm=${param.srchRprsvNm}&amp;srchBrno=${param.srchBrno}&amp;srchPicNm=${param.sortsrchPicNm}&amp;srchPicTelno=${param.srchPicTelno}&amp;srchAprvTy=${param.srchAprvTy}" />
		<a href="./list?${pageParam}" class="btn-secondary large shadow">목록</a>
	</div>
</form:form>

<script>

//미승인 시 사유 체크
$(function(){

	$("input[name='aprvTy']").on("click",function(){
		if($("#aprvTy1, #aprvTy0").is(":checked")){
			$(".resnView").hide();
		}else{
			$(".resnView").show();
		}
	});

	$.validator.addMethod("resnChk", function(value,element){
		if($("#aprvTy2").is(":checked")){
			if($("#rejectResn").val() == ''){
				return false;
			}else{
				return true;
			}
		}else{
			return true;
		}
	}, "미승인 사유를 입력해주세요.");

	//유효성
	$("form#frmBplc").validate({
	    ignore: "input[type='text']:hidden",
	    rules : {
	    	rejectResn : {resnChk : true},
	    	aprvTy : {required : true}
	    },
	    messages : {
	    	aprvTy : {required : "승인 여부는 필수 선택 항목입니다."}
	    },
	    submitHandler: function (frm) {
	    	if($("#aprvTy0").is(":checked")){
	    		if(confirm("저장하시겠습니까?")){
	    			frm.submit();
	    		}else{
	    			return false;
	    		}
	    	}else if($("#aprvTy1").is(":checked")){
	    		if(confirm("승인하시겠습니까?")){
	    			frm.submit();
	    		}else{
	    			return false;
	    		}
	    	}else if($("#aprvTy2").is(":checked")){
	    		if(confirm("미승인 하시겠습니까?")){
	    			frm.submit();
	    		}else{
	    			return false;
	    		}
	    	}else{
	    		return false;
	    	}
	    }
	});

});
</script>