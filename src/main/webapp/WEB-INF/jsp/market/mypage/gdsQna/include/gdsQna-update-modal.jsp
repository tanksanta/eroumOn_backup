<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!-- qna 모달 -->
<form:form action="./action" id="qaFrm" name="qaFrm" method="post" modelAttribute="gdsQaVO">
<form:hidden path="qaNo" />
<input type="hidden" id="secret" name="secret"  value="N" />
	<div class="modal fade" id="qnaModal" tabindex="-1" aria-hidden="true">
		<div class="modal-dialog modal-dialog-centered">
			<div class="modal-content">
				<div class="modal-header">
					<p class="text-title">상품문의 수정</p>
				</div>
				<div class="modal-close">
					<button type="button" data-bs-dismiss="modal">모달 닫기</button>
				</div>
				<div class="modal-body">
					<div class="content">
	                    <div class="flex items-center">
							<div class="flex items-center justify-center w-25 h-25 overflow-hidden bg-gray2 rounded md:w-30 md:h-30">
								<c:forEach var="fileList" items="${gdsQaVO.gdsImgList}" varStatus="status">
									<img alt="" class="w-full h-full object-cover" src="/comm/getImage?srvcId=GDS&amp;upNo=${fileList.upNo}&amp;fileTy=THUMB&amp;fileNo=${fileList.fileNo}" alt="">
								</c:forEach>
	                        </div>
	                        <dl class="ml-3 flex-1 md:ml-4">
	                            <dt class="font-serif">${gdsQaVO.gdsCd}</dt>
	                            <dd>${gdsQaVO.gdsNm}</dd>
	                        </dl>
	                    </div>

						<p class="text-alert mt-4 md:mt-5">본 게시판과 관련이 없거나 광고성, 단순반복성, 저작권침해 등 불건전한 내용을 올리실 경우 통보 없이 임의로 삭제 처리될 수 있습니다.</p>

						<table class="table-detail mt-4 md:mt-5">
							<colgroup>
								<col class="w-25 md:w-32">
								<col>
							</colgroup>
							<tbody>
								<tr>
									<th><p>문의내용</p></th>
									<td>
										<form:textarea path="qestnCn" class="change-textarea" />
										<div>
                                               <div class="form-check form-switch text-sm">
												<input type="checkbox" class="form-check-input" id="secretYn" name="secretYn" />
												<label class="form-check-label" for="secretYn">공개</label>
                                               </div>
										</div>
									</td>
								</tr>
							</tbody>
						</table>
					</div>
				</div>
				<div class="modal-footer">
                    <button type="submit" class="btn btn-primary btn-submit">저장</button>
                    <button type="button" class="btn btn-outline-primary btn-cancel" data-bs-dismiss="modal">취소</button>
				</div>
			</div>
		</div>
	</div>
</form:form>
<!-- //qna 모달 -->
<script>
$(function(){

	// 비공개 여부
	$("#secretYn").on("click",function(){
		if($("#secretYn").is(":checked")){
			$("#secret").val("N");
		}else{
			$("#secret").val("Y");
		}
		console.log($("#secret").val());
	});

	// 비공개 체크
	if("${gdsQaVO.secretYn}" == "Y"){
		$("#secretYn").prop("checked",false);
		$("#secret").val("Y");
	}else{
		$("#secretYn").prop("checked",true);
		$("#secret").val("N");
	}

	//유효성
	$("form#qaFrm").validate({
	    ignore: "input[type='text']:hidden",
	    rules : {
	    	qestnCn : {required : true}
	    },
	    messages : {
	    	qestnCn : {required : "! 문의내용은 필수 입력 항목입니다."}
	    },
	    errorElement:"p",
	    errorPlacement: function(error, element) {
		    var group = element.closest('.change-textarea');
		    if (group.length) {
		        group.after(error.addClass('text-danger'));
		    } else {
		        element.after(error.addClass('text-danger'));
		    }
		},
	    submitHandler: function (frm) {
   	   		if(confirm("수정하시겠습니까?")){
	   			frm.submit();
	   		}else{
	   			return false;
	   		}
	    }
	});

});
</script>