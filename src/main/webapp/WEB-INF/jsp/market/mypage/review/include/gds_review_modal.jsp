<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!-- 상품후기 모달 -->
<div class="modal fade" id="reviewModal" tabindex="-1" aria-hidden="true">
	<div class="modal-dialog modal-dialog-centered">
		<div class="modal-content">
			<div class="modal-header">
				<p class="text-title">상품후기 작성</p>
			</div>
			<div class="modal-close">
				<button data-bs-dismiss="modal">모달 닫기</button>
			</div>
			<form:form action="./action" id="reviewFrm" name="reviewFrm" method="post" modelAttribute="gdsReviewVO" enctype="multipart/form-data">
			<form:hidden path="gdsReivewNo" />
			<form:hidden path="crud" />
			<form:hidden path="gdsCd" />
			<form:hidden path="dspyYn" />
			<form:hidden path="ordrCd" />
			<form:hidden path="ordrDtlNo" />
			<form:hidden path="ordrNo" />
			<form:hidden path="gdsNo"/>
			<form:hidden path="imgUseYn" />

			<input type="hidden" id="delAttachFileNo" name="delAttachFileNo" value="" />
			<input type="hidden" id="starScore" name="starScore" value="${gdsReviewVO.dgstfn}" />

			<div class="modal-body">
				<div class="mypage-review-rating">
					<div class="rating-thumb">
					<c:forEach var="fileList" items="${gdsReviewVO.thumbnailFile}" varStatus="status">
						<img src="/comm/getImage?srvcId=GDS&amp;upNo=${gdsReviewVO.gdsNo}&amp;fileTy=THUMB&amp;fileNo=${fileList.fileNo}" alt="">
					</c:forEach>
					<c:if test="${gdsVO ne null}">
						<c:set var="img" value="${gdsVO.thumbnailFile}" />
						<img src="/comm/getImage?srvcId=GDS&amp;upNo=${gdsVO.gdsNo}&amp;fileTy=THUMB" alt="">
					</c:if>
					</div>
					<div class="rating-product">
					    <u>${gdsReviewVO.gdsCd}</u>
					    <strong>${gdsVO.gdsNm}</strong>
					</div>
					<strong class="block mb-1 md:mb-1.5">고객만족도</strong>
                    <div class="rating-control">
						<c:forEach var="i" begin="1" end="5">
							<c:set var="bool" value="${i eq gdsReviewVO.dgstfn ? 'true' : 'false'}" />
	                        <div class="rating <c:if test="${i <= gdsReviewVO.dgstfn}">active</c:if>" role="radio" aria-label="${i}점" aria-checked="${bool}" tabindex="0" data-rating="${i}"></div>
						</c:forEach>
						<div class="text">${gdsReviewVO.dgstfn}</div>
                    </div>
				</div>
				
                <div class="mypage-review-point2 mt-8 md:mt-10">
                    <dl>
                        <dt><strong>상품후기</strong> 작성시</dt>
                        <dd>200 포인트 적립</dd>
                    </dl>
                    <dl>
                        <dt><strong>포토후기</strong> 작성시</dt>
                        <dd>500 포인트 적립</dd>
                    </dl>
                </div>
                
				<table class="table-detail mt-3.5 md:mt-4.5">
					<colgroup>
						<col class="w-22">
						<col>
					</colgroup>
					<tbody>
						<tr>
							<th scope="row"><p><label for="review-item2">상품 후기</label></p></th>
							<td><form:textarea path="cn" cols="30" rows="10" id="review-item2" class="form-control w-full" placeholder="상품 후기를 1000자 이내로 남겨주세요" maxlength="1000" /></td>
						</tr>
						<tr>
							<th scope="row"><p><label for="uploadFile">사진 등록</label></p></th>
							<td>
								<div class="form-upload attachFile" <c:if test="${!empty gdsReviewVO.imgFile}">style="display:none;"</c:if>>
									<label for="uploadFile" class="form-upload-trigger">파일을 선택해주세요
									</label><input type="file" class="form-upload-control" id="uploadFile" name="uploadFile" >
								</div>
								<ul class="mypage-review-uploads">
									<c:if test="${!empty gdsReviewVO.imgFile}">
									<li>
										<p><img src="/comm/getImage?srvcId=REVIEW&amp;upNo=${gdsReviewVO.gdsReivewNo}&amp;fileNo=${gdsReviewVO.imgFile.fileNo}" alt=""></p>
										<button class="button" onclick="f_delFile('${gdsReviewVO.imgFile.fileNo}', 'ATTACH', '${status.index}',this); return false;">삭제</button>
									</li>
									</c:if>
								</ul>
								<p class="text-sm mt-1.5">파일 형식 : JPG, GIF, 용량 : 2MB이하</p>
							</td>
						</tr>
					</tbody>
				</table>
                        
                <ul class="mt-4 md:mt-5 space-y-1 md:space-y-1.5">
                    <li class="text-alert">구매한 상품과 관계가 없는 내용이나 비방성 글은 등록자에게 사전 동의 없이 임의로 삭제될 수 있습니다.</li>
                    <li class="text-alert">배송, 상품문의는 고객센터 <strong class="underline">1:1 문의</strong>를 이용해주세요.</li>
                </ul>
			</div>
			<div class="modal-footer">
				<button type="submit" class="btn btn-primary btn-submit">확인</button>
				<button type="button" class="btn btn-outline-primary btn-cancel" data-bs-dismiss="modal">취소</button>
			</div>
			</form:form>
		</div>
	</div>
</div>
<!-- //상품후기 모달 -->

<script>

//첨부파일 변경
function setImageFromFile(input, expression) {
	if (input.files && input.files[0]) {
		var reader = new FileReader();
		reader.onload = function (e) {
			$(expression).attr('src', e.target.result);
		}
		reader.readAsDataURL(input.files[0]);
	}
}

//첨부파일 삭제
function f_delFile(fileNo, type, spanNo, obj) {
	if (confirm("삭제하시겠습니까?")) {
		if (type == "ATTACH") {
			$(obj).closest("li").remove();
			if($("#delAttachFileNo").val() == "") {
				$("#delAttachFileNo").val(fileNo);
			} else {
				$("#delAttachFileNo").val(
				$("#delAttachFileNo").val() + "," + fileNo);
			}
			$(".attachFile").css("display", "");
			$(".uploadFile").val('');
		}
	}
}

$(function(){
	$(document).on("click keydown", ".rating-control .rating", function(e) {
        e.stopPropagation();

        var target = $(this);
        
        if(e.type === 'click' || (e.keyCode === 13 || e.keyCode === 32)) {
            if($.parseJSON(target.attr('aria-checked'))) {
                target.removeClass('active').attr('aria-checked', false);
            } else {
                target.addClass('active').attr('aria-checked', true);
            }
        }

        target.prevAll('.rating').each(function() {
            $(this).attr('class', (target.hasClass('active')) ? 'rating active' : 'rating').attr('aria-checked', false);
        });
        
        target.nextAll('.rating').each(function() {
            $(this).removeClass('active').attr('aria-checked', false);
        });

        target.siblings('.text').text(target.attr('data-rating'));
        
        $('#starScore').val(target.attr('data-rating'))
	});
	
	// 첨부파일
	$("#uploadFile").on("change",function(){
		var img_html = '';
		img_html += '<li>';
		img_html += '<img src="" alt="" class="addAttach">';
		img_html += '</li>';
		setImageFromFile(this, ".addAttach");

		$(".mypage-review-uploads *").remove();
		$(".mypage-review-uploads").append(img_html);
	});

	//유효성
	$("form#reviewFrm").validate({
	    ignore: "input[type='text']:hidden",
	    rules : {
			cn : {required : true}
	    },
	    messages : {
			cn : {required : "! 내용은 필수 입력 항목입니다."}
	    },
	    submitHandler: function (frm) {
	    	var cmt = "";
	    	if($("#crud").val() == "CREATE"){
	    		cmt = "등록";
	    	}else{
	    		cmt = "수정";
	    	}

   	   		if(confirm(cmt + "하시겠습니까?")){
   	   			frm.submit();
   	   		}else{
   	   			return false;
   	   		}
	    }
	});

});
</script>