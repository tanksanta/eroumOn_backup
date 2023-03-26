<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
			<%-- 승인관리 --%>


			<form:form name="frmOrdrConfm" id="frmOrdrConfm" modelAttribute="ordrDtlVO" method="post" enctype="multipart/form-data">
            <div class="modal fade modal-inner" id="ordr-confm-modal" tabindex="-1">
                <div class="modal-dialog modal-lg modal-dialog-centered">
                    <div class="modal-content">
                        <div class="modal-header">
                            <p>승인관리</p>
                            <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="close"></button>
                        </div>
                        <div class="modal-body">
                            <table class="table-detail">
                                <colgroup>
                                    <col>
                                </colgroup>
                                <tbody>

                                    <tr>
                                        <td>
                                        	<div class="form-check">
                                                <input class="form-check-input" type="radio" name="sttsTy" id="sttsTy1" value="OR02" checked="checked">
                                                <label class="form-check-label" for="sttsTy1">주문승인</label>
                                            </div>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                        	<div class="form-group w-full">
	                             				<div class="form-check">
	                                                <input class="form-check-input" type="radio" name="sttsTy" id="sttsTy2" value="OR03">
	                                                <label class="form-check-label" for="sttsTy2">주문반려</label>
	                                            </div>
	                                            <input type="text" id="resn" name="resn" value="" class="form-control flex-1 ml-5" placeHolder="반려사유를 입력하세요" readonly="readonly" maxlength="250">
                                            </div>
                                        </td>
                                    </tr>

                                </tbody>
                            </table>
                        </div>
                        <div class="modal-footer">
	                        <button type="button" class="btn-primary large shadow f_ordr_confm_save">확인</button>
	                        <button type="button" class="btn-secondary large shadow" data-bs-dismiss="modal">취소</button>
                        </div>
                    </div>
                </div>
            </div>
            </form:form>

            <script>
            $(function(){
            	// foucs
            	$("#ordr-confm-modal").on("shown.bs.modal", function () {
            		$(".btn-close").focus();
            	});

            	$("#ordr-confm-modal input[name='sttsTy']").on("change", function(){
            		if($(this).val() == "OR03"){
            			$("#ordr-confm-modal input[name='resn']").prop("readonly", false);
            		}else{
            			$("#ordr-confm-modal input[name='resn']").prop("readonly", true);
            			$("#ordr-confm-modal input[name='resn']").val("");
            		}
            	});

            	$(".f_ordr_confm_save").on("click", function(){
					var sttsTy = $("#ordr-confm-modal input[name='sttsTy']:checked").val();
					var msg = "주문을 승인하시겠습니까?";
					//var resnTy = "";
					var resn = $("#ordr-confm-modal input[name='resn']").val();

					if(sttsTy == "OR03"){
						msg = "주문을 반려하시겠습니까?";
						if(resn == ""){
							alert("반려사유를 입력해주세요");
							return;
						}
					}else{
						resn = "급여상품 주문승인";
					}

					if(confirm(msg)){
						$.ajax({
	        				type : "post",
	        				url  : "/_mng/ordr/ordrConfmSave.json", //주문확인
	        				data : {
	        					ordrNo:'${ordrDtlVO.ordrNo}'
	        					, ordrDtlCd:'${ordrDtlVO.ordrDtlCd}'
	        					, sttsTy:sttsTy
	        					//, resnTy:resnTy
	        					, resn:resn
	        				},
	        				dataType : 'json'
	        			})
	        			.done(function(data) {
	        				if(data.result){
	        					console.log("상태변경 : success");
	        					$(".btn-reload, .modal-inner .btn-close").click();
	        				}
	        			})
	        			.fail(function(data, status, err) {
	        				console.log('상태변경 : error forward : ' + data);
	        			});
					}

            	});

            });

            </script>