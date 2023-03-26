<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<script>
	var starCount = "${gdsReviewVO.dgstfn}";

	var active_html = "";
	active_html += '<button type="button">';
	active_html += '<img src="/html/page/market/assets/images/content2/star_active.png" alt="" class="acstar stars">';
	active_html += '</button>';

	var normal_html = "";
	normal_html += '<button type="button">';
	normal_html += '<img src="/html/page/market/assets/images/content2/star_normal.png" alt="" class="nonstar stars">';
	normal_html += '</button>';

</script>
<!-- 상품후기 모달 -->
<div class="modal fade layer-popup layer-cancel layer-review" id="reviewModal" tabindex="-1" aria-hidden="true">
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
				<div class="content">
					<div class="pd">
						<div class="order-product">
							<div class="order-body">
								<div class="order-item">
									<div class="order-item-thumb">
										<c:forEach var="fileList" items="${gdsReviewVO.thumbnailFile}" varStatus="status">
											<img src="/comm/getImage?srvcId=GDS&amp;upNo=${gdsReviewVO.gdsNo}&amp;fileTy=THUMB&amp;fileNo=${fileList.fileNo}" alt="">
										</c:forEach>
										<if test="${gdsVO ne null}">
											<c:set var="img" value="${gdsVO.thumbnailFile}" />
											<img src="/comm/getImage?srvcId=GDS&amp;upNo=${gdsVO.gdsNo}&amp;fileTy=THUMB" alt="">
										</if>
									</div>
									<div class="order-item-content">
										<div class="order-item-base">
											<p class="code">
												<u>${gdsReviewVO.gdsCd}</u>
											</p>
											<div class="product">
												<p class="name">${gdsVO.gdsNm}</p>
											</div>
										</div>
										<div class="order-item-add">
											<div class="score">
												<span class="satisfied">고객만족도</span>
												<div class="star-score starview">
													<script language="JavaScript">
													if($("#crud").val() == "CREATE"){
														for (var i = 0; i < 4-starCount; i++) {
															$(".starview").prepend(normal_html);
														}
														for (var i = 0; i < starCount; i++) {
															$(".starview").prepend(active_html);
														}
														var one_html = "";
														one_html += '<button type="button">';
														one_html += '<img src="/html/page/market/assets/images/content2/star_active.png" alt="" class="acstar stars">';
														one_html += '</button>';
														$(".starview").prepend(one_html);
													}else{
														for (var i = 0; i < 5-starCount; i++) {
															$(".starview").prepend(normal_html);
														}
														for (var i = 0; i < starCount; i++) {
															$(".starview").prepend(active_html);
														}
													}

													</script>
													<span class="score-text scoreTotal">${gdsReviewVO.dgstfn}.0</span>
												</div>
											</div>
										</div>
									</div>
								</div>
							</div>
						</div>
					</div>
					<div class="expected-point">
						<div class="box">
							<div class="right">
								<dl>
									<dt>
										<strong class="red">상품후기</strong> 작성시
									</dt>
									<dd>200 포인트 적립</dd>
								</dl>
								<dl>
									<dt>
										<strong class="blue">포토후기</strong> 작성시
									</dt>
									<dd>500 포인트 적립</dd>
								</dl>
							</div>
						</div>
					</div>
					<div class="pd">
						<table class="table-detail mt17">
							<colgroup>
								<col width="87px">
								<col>
							</colgroup>
							<tbody>
								<tr>
									<th><p class="center">상품 후기</p></th>
									<td><form:textarea path="cn" class="change-textarea" placeholder="상품 후기를 1000자 이내로 남겨주세요" maxlength="1000" /></td>
								</tr>
								<tr>
									<th><p class="center">사진 등록</p></th>
									<td>
										<div class="form-upload attachFile" <c:if test="${!empty gdsReviewVO.imgFile}">style="display:none;"</c:if>>
											<label for="uploadFile" class="form-upload-trigger">파일을 선택해주세요
											</label><input type="file" class="form-upload-control" id="uploadFile" name="uploadFile" >
										</div>
										<div class="image-upload">
											<ul class="imgview">
											<c:if test="${!empty gdsReviewVO.imgFile}">
												<li class="order-item-thumb">
													<a href="#f_delFile" onclick="f_delFile('${gdsReviewVO.imgFile.fileNo}', 'ATTACH', '${status.index}',this); return false;" class="img-delete">
														<img src="/html/page/market/assets/images/content2/upload_cencel.png" alt="">
													</a>
													<img src="/comm/getImage?srvcId=REVIEW&amp;upNo=${gdsReviewVO.gdsReivewNo}&amp;fileNo=${gdsReviewVO.imgFile.fileNo}" alt="">
												</li>
											</c:if>

											</ul>
												<p>파일 형식 : JPG, GIF, 용량 : 2MB이하</p>
										</div>
									</td>
								</tr>
							</tbody>
						</table>
						<p class="text-alert mt17">구매한 상품과 관계가 없는 내용이나 비방성 글은 등록자에게 사전 동의 없이 임의로 삭제될 수 있습니다.</p>
						<p class="text-alert">
							배송, 상품문의는 고객센터 <strong class="line">1:1 문의</strong>를 이용해주세요.
						</p>
						<div class="modal-footer">
							<button type="subtmit" class="btn btn-primary w-46 flex-1 xs:flex-none">확인</button>
							<button type="button" class="btn btn-outline-primary flex-none" data-bs-dismiss="modal">취소</button>
						</div>
					</div>
				</div>
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
	console.log(obj);
	if (confirm("삭제하시겠습니까?")) {
		if (type == "ATTACH") {
			$(obj).closest("li").remove();
			if ($("#delAttachFileNo").val() == "") {
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
	$("#starScore").val(1);

	//별점
	$(".scoreTotal").text($(".acstar").length+".0");
	$(document).on("click", ".acstar", function(){
		//$(this).closest("button").prevUntil().children().addClass("nonstar").removeClass("acstar").attr("src","/html/page/market/assets/images/content2/star_normal.png");
		$(this).closest("button").nextAll().children().addClass("nonstar").removeClass("acstar").attr("src","/html/page/market/assets/images/content2/star_normal.png");
		$(this).removeClass("nonstar").addClass("acstar");
		$(".scoreTotal").text($(".acstar").length+".0");
		$("#starScore").val($(".acstar").length);
		//$(this).attr("src","/html/page/market/assets/images/content2/star_normal.png");
	});

	$(document).on("click", ".nonstar", function(){
		$(this).closest("button").prevUntil().children().addClass("acstar").removeClass("nonstar").attr("src","/html/page/market/assets/images/content2/star_active.png");
		$(this).closest("button").nextAll().children().addClass("nonstar").removeClass("acstar").attr("src","/html/page/market/assets/images/content2/star_normal.png");
		$(this).removeClass("nonstar").addClass("acstar");
		$(".scoreTotal").text($(".acstar").length+".0");
		$("#starScore").val($(".acstar").length);
		$(this).attr("src","/html/page/market/assets/images/content2/star_active.png");
	});

	// 첨부파일
	$("#uploadFile").on("change",function(){

		var img_html = '';
		img_html += '<li class="order-item-thumb addFile">';
		img_html += '<img src="/html/page/market/assets/images/content2/upload_cencel.png" alt="" class="addAttach">';
		img_html += '</li>';
		setImageFromFile(this, ".addAttach");

		$(".addFile").remove();
		$(".imgview").append(img_html);
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
