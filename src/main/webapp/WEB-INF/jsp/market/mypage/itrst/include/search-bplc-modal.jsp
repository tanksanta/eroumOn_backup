<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!-- 멤버스 모달 -->
<div class="modal fade layer-popup layer-cancel layer-office" id="partnerModal" tabindex="-1" aria-hidden="false">
	<div class="modal-dialog modal-dialog-centered">
		<div class="modal-content">
			<div class="modal-header">
				<p class="text-title">멤버스 찾기</p>
			</div>
			<div class="modal-close">
				<button type="button" data-bs-dismiss="modal" id="clsModal">모달 닫기</button>
			</div>
			<div class="modal-body">
                <form class="product-partners-layer">
	                <fieldset class="layer-search">
						<select name="sido" id="sido" class="form-control">
	                        <option value="">시/도 선택</option>
					      	<c:forEach items="${stdgCdList}" var="stdg">
                            	<option value="${stdg.stdgCd}">${stdg.ctpvNm }</option>
                            </c:forEach>
	                    </select>
	                    <select name="gugun" id="gugun" class="form-control">
	                        <option value="">시/군/구 선택</option>
	                    </select>
	                    <input type="text" id="srchText" name="srchText" class="form-control" placeholder="기본">
	                    <input type="text" id="none" name="none" class="form-control" style="display:none;">
						<button type="button" class="btn btn-primary" id="searchBplc">검색</button>
	                </fieldset>

					<div class="pd">

					</div>

			        <div id="pages">
			        </div>
                </form>
			</div>
			<div class="modal-footer">
				<buttton type="button" class="btn btn-primary" id="bplcBtn">확인</buttton>
				<buttton type="button" class="btn btn-outline-primary" data-bs-dismiss="modal">취소</buttton>
			</div>
		</div>
	</div>
</div>
<!-- //멤버스 모달-->

<script>
var uniqueIds = [];


function f_bplcSrchNm(){
	if($("#sido").val() != ""){
		$.ajax({
			type : "post",
			url  : "/members/stdgCd/stdgCdList.json",
			data : {stdgCd:$("#sido").val()},
			dataType : 'json'
		})
		.done(function(data) {
			if(data.result){
					$.each(data.result, function(index, item){
						if(gugun == item.sggNm){
							$("#gugun").append("<option value='"+ item.sggNm +"' selected='selected'>"+ item.sggNm +"</option>");
						}else{
							$("#gugun").append("<option value='"+ item.sggNm +"'>"+ item.sggNm +"</option>");
						}

	                });
			}
		})
		.fail(function(data, status, err) {
			console.log('지역호출 error forward : ' + data);
		});
	}
}




$(function(){

	//시/군/구 검색
	$("#sido").on("change", function(){
		$("#gugun").empty();
		$("#gugun").append("<option value=''>시/군/구</option>");
		f_bplcSrchNm();

	});


	// 멤버스 추가
	$("#bplcBtn").on("click",function(){
		if(uniqueIds.length > 0){
			if(confirm("관심 멤버스로 등록하시겠습니까?")){
				$.ajax({
					type : "post",
					url  : "${_marketPath}/mypage/itrst/insertItrstBplc.json",
					data : {
						arrUniqueId : uniqueIds
					},
					traditional: true,
					dataType : 'json'
				})
				.done(function(data) {
					if(data.result == 0){
						alert("관심 멤버스 등록에 실패했습니다. /n 관리자에게 문의바랍니다.");
						return false;
					}else if(data.result == 1){
						alert("등록되었습니다.");
						location.reload();
					}else{
						alert("관심 멤버스는 최대 5개 입니다.");
						return false;
					}

				})
				.fail(function(data, status, err) {
					console.log(data);
					return false;
				});
			}else{
				return false;
			}
		}else{
			$("#clsModal").click();
		}

	});

	$("#srchText").on("keyup",function(e){
		if(e.code == "Enter"){
			$("#searchBplc").click();
		}
	});

});
</script>