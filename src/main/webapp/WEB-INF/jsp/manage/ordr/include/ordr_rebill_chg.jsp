<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%-- 정기결제 카드정보 --%>

<%-- 정기결제 카드정보 --%>
<form name="frmOrdrRebillChg" id="frmOrdrRebillChg" method="post" action="">

	<div class="modal fade modal-inner" id="ordr-rebill-chg-modal" tabindex="-1">
		<div class="modal-dialog modal-xl modal-dialog-centered">
			<div class="modal-content">
				<div class="modal-header">
					<p>카드정보 변경</p>
					<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="close"></button>
				</div>
				<div class="modal-body">

					<p class="text-title2 relative mt-10">등록 정보</p>
					<table class="table-detail">
						<colgroup>
							<col class="w-36">
							<col>
						</colgroup>
						<tbody>
							<tr>
								<th scope="row">은행</th>
								<td>${ordrVO.cardCoNm}</td>
							</tr>
							<tr>
								<th scope="row">카드번호</th>
								<td>${ordrVO.cardNo}</td>
							</tr>
						</tbody>
					</table>

					<p class="text-title2 relative mt-10">변경정보 등록</p>
					<table class="table-detail">
						<colgroup>
							<col class="w-36">
						</colgroup>
						<tbody>
							<tr>
								<th scope="row">카드번호</th>
								<td>
									<div class="form-group">
									<input type="text" class="form-control w-20 card-no" name="first_cart_no" maxlength="4"/>
									-
									<input type="password" class="form-control w-20 card-no" name="second_cart_no" maxlength="4"/>
									-
									<input type="password" class="form-control w-20 card-no" name="third_cart_no" maxlength="4"/>
									-
									<input type="text" class="form-control w-20 card-no" name="fourth_cart_no" maxlength="4"/>
									</div>
								</td>
							</tr>
							<tr>
								<th scope="row">생년월일</th>
								<td>
									<div class="form-group">
										<input type="text" class="form-control w-25 birth" name="birth" maxlength="6" placeholder="- 없이 입력"/>
									</div>
								</td>
							</tr>
							<tr>
								<th scope="row">월/년</th>
								<td>
									<div class="form-group">
										<input type="text" class="form-control w-15 expire-no" name="expire_month" maxlength="2" />
										&nbsp;/&nbsp;
										<input type="text" class="form-control w-15 expire-no" name="expire_year" maxlength="2" />
									</div>
								</td>
							</tr>
							<tr>
								<th scope="row">비밀번호</th>
								<td>
									<div class="form-group">
										<input type="password" class="form-control w-15 card-pw" name="card_pw" maxlength="2" />**
									</div>
								</td>
							</tr>
						</tbody>
					</table>

				</div>
				<div class="modal-footer">
					<div class="btn-group">
						<button type="submit" class="btn-primary large shadow">확인</button>
						<button type="button" class="btn-secondary large shadow" data-bs-dismiss="modal">취소</button>
					</div>
				</div>
			</div>
		</div>
	</div>
</form>
<%-- 정기결제 카드정보 --%>
<script>
function f_card_concat(){
	var cardNo = "";
	$(".card-no").each(function(){
		cardNo += $(this).val();
	});
	return cardNo;
}

$(function(){

	// 카드번호 체크
	$.validator.addMethod("cardNoChk", function(value, element, regexpr) {
		let emptyFlag = true;
		$(".card-no").each(function(){
			if($(this).val() == '' || $(this).val() == null){
				emptyFlag = false;
			}
		});
		return emptyFlag;
	}, "카드번호는 필수 입력 항목입니다.");

	// 년 월 체크
	$.validator.addMethod("expireChk", function(value, element, regexpr) {
		let expireFlag = true;
		$(".expire-no").each(function(){
			if($(this).val() == '' || $(this).val() == null){
				expireFlag = false;
			}
		});
		return expireFlag;
	}, "년/월은 필수 입력 항목입니다.");

	$(".card-no, .expire-no, .card-pw, .birth").on("keyup", function(){
		$(this).val( $(this).val().replace(/[^0-9]/gi,"") );
	});


	//유효성
	$("form#frmOrdrRebillChg").validate({
	    ignore: "input[type='text']:hidden",
	    rules : {
	    	fourth_cart_no : {cardNoChk : true}
	    	, expire_month: {expireChk : true}
	    	, card_pw : {required : true}
	    	, birth : {required : true}
	    },
	    messages : {
	    	card_pw : {required : "카드 비밀번호 앞 두자리는 필수 입력 항목입니다."}
	    	, birth : {required : "생년월일은 필수 입력 항목입니다."}
	    },
	    submitHandler: function (frm) {
	    	// 카드번호 concat
	    	let cardNo = f_card_concat();

	   		if(confirm("카드정보를 변경 하시겠습니까?")){
	   			var params = {
	   				ordrNo : "${ordrVO.ordrNo}"
	   				, cardNo : cardNo
	   				, cardPw : $("input[name='card_pw']").val()
	   				, expireMonth : $("input[name='expire_month']").val()
	   				, expireYear : $("input[name='expire_year']").val()
	   				, birth : $("input[name='birth']").val()
	   			}

	   			$.ajax({
       				type : "post",
       				url  : "/_mng/ordr/rebillPayChg.json",
       				data : params ,
       				dataType : 'json'
       			})
       			.done(function(data) {
       				if(data.result){
       					alert("카드정보가 변경되었습니다.");
       					$(".btn-close").click();
       					$(".btn-reload").click();
       				}else{
       					console.log("카드정보 변경 실패");
       					return false;
       				}
       			})
       			.fail(function(data, status, err) {
       				console.log('카드정보 변경 : error forward : ' + data);
       			});
	   		}else{
	   			return false;
	   		}
	    }
	});
})
</script>

