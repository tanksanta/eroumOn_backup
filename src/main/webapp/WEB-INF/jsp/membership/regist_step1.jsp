<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<main id="container">
	<header id="page-title">
		<h2>
			<span>회원가입</span>
			<small>Member Join</small>
		</h2>
	</header>

	<div id="page-content">
		<div class="member-join">
			<div class="member-join-step1">
				<img src="/html/page/members/assets/images/txt-join-number1.svg" alt="STEP 1">
			</div>

			<form id="frmStep1" name="frmStep1" action="./registStep2" class="member-join-content" method="post" enctype="multipart/form-data">
				<ul class="member-tabs mb-5.5 sm:mb-11">
					<li><a href="./registStep1" class="active">약관동의 및 본인인증</a></li>
					<li><span>정보입력</span></li>
					<li><span>가입완료</span></li>
				</ul>

				<div class="form-check font-bold my-3.5">
					<input class="form-check-input" type="checkbox" id="check-all">
					<label class="form-check-label" for="check-all">전체 약관에 동의합니다</label>
				</div>

				<div class="content-accordion" id="accordionAgree">
					<div class="accordion-item">
						<div class="accordion-header">
							<div class="form-check">
								<input class="form-check-input" type="checkbox" id="firstChk">
										<label class="form-check-label" for="firstChk"> <span class="text-danger">필수</span> 회원약관에 동의합니다
								</label>
							</div>
							<button class="accordion-button" type="button" data-bs-target="#collapse-agree1" data-bs-toggle="collapse" aria-expanded="false">펼치기/접기</button>
						</div>
						<div id="collapse-agree1" class="accordion-collapse collapse" data-bs-parent="#accordionAgree">
							<div class="accordion-body py-3.5 px-4">
								<strong>This is the first item's accordion body.</strong> It is shown by default, until the collapse plugin adds the appropriate classes that we use to style each element. These classes control the overall appearance, as well as the showing and hiding via CSS transitions. You can modify any of this with custom CSS or overriding our default variables. It's also worth noting that just about any HTML can go within the
								<code>.accordion-body</code>
								, though the transition does limit overflow.
							</div>
						</div>
					</div>
					<div class="accordion-item">
						<div class="accordion-header">
							<div class="form-check">
								<input class="form-check-input" type="checkbox" id="secondChk">
								<label class="form-check-label" for="secondChk"> <span class="text-danger">필수</span> 개인정보 취급방침 약관에 동의합니다
								</label>
							</div>
							<button class="accordion-button" type="button" data-bs-target="#collapse-agree2" data-bs-toggle="collapse" aria-expanded="false">펼치기/접기</button>
						</div>
						<div id="collapse-agree2" class="accordion-collapse collapse" data-bs-parent="#accordionAgree">
							<div class="accordion-body py-3.5 px-4">
								<strong>This is the second item's accordion body.</strong> It is hidden by default, until the collapse plugin adds the appropriate classes that we use to style each element. These classes control the overall appearance, as well as the showing and hiding via CSS transitions. You can modify any of this with custom CSS or overriding our default variables. It's also worth noting that just about any HTML can go within the
								<code>.accordion-body</code>
								, though the transition does limit overflow.
							</div>
						</div>
					</div>
					<div class="accordion-item">
						<div class="accordion-header">
							<div class="form-check">
								<input class="form-check-input" type="checkbox" id="thirdChk"> <label class="form-check-label" for="thirdChk"> <span class="text-danger">필수</span> 맴버십 서비스 약관에 동의합니다
								</label>
							</div>
							<button class="accordion-button" type="button" data-bs-target="#collapse-agree3" data-bs-toggle="collapse" aria-expanded="false">펼치기/접기</button>
						</div>
						<div id="collapse-agree3" class="accordion-collapse collapse" data-bs-parent="#accordionAgree">
							<div class="accordion-body py-3.5 px-4">
								<strong>This is the third item's accordion body.</strong> It is hidden by default, until the collapse plugin adds the appropriate classes that we use to style each element. These classes control the overall appearance, as well as the showing and hiding via CSS transitions. You can modify any of this with custom CSS or overriding our default variables. It's also worth noting that just about any HTML can go within the
								<code>.accordion-body</code>
								, though the transition does limit overflow.
							</div>
						</div>
					</div>
				</div>

				<dl class="content-auth mt-15">
					<dt>실명인증</dt>
					<dd>
						고객님의 개인정보보호를 위해 본인인증이 필요합니다<br> 휴대폰 인증을 통해 실명인증을 완료해 주세요
					</dd>
				</dl>

				<div class="content-auth-phone mt-9">
					<img src="/html/page/members/assets/images/img-join-auth.svg" alt="">
					<dl>
						<dt>휴대폰 본인 인증</dt>
						<dd>본인 명의로 된 휴대폰 번호로만 인증이 가능합니다</dd>
					</dl>
				</div>

				<div class="content-button mt-5">
					<button type="button" class="btn btn-primary btn-large flex-1 selfBtn">본인 인증하기</button>
					<a href="./regist" class="btn btn-outline-primary btn-large w-[37.5%]">취소</a>
				</div>

				<input type="hidden" id="receiptId" name="receiptId" value="">
			</form>
			<div class="member-join-sidebar">
				<p class="text">
					<span>STEP 2</span>
				</p>
			</div>
			<div class="member-join-sidebar is-step2">
				<p class="text">
					<span>STEP 3</span>
				</p>
			</div>
		</div>
	</div>
</main>

<script>


async function f_cert(){
	try {
	    const response = await Bootpay.requestAuthentication({
	        application_id: "${_bootpayScriptKey}",
	        pg: '다날',
	        order_name: '본인인증',
	        authentication_id: 'CERT00000000001',
	        extra: { show_close_button: true }
	    })
	    switch (response.event) {
	        case 'done':
	            console.log("response.data", response.data);
	            $("#receiptId").val(response.data.receipt_id);
	            $("#frmStep1").submit();
	            break;
	    }
	} catch (e) {
	    switch (e.event) {
	        case 'cancel':
	            console.log(e.message);	// 사용자가 결제창을 닫을때 호출
	            break
	        case 'error':
	            console.log(e.error_code); // 결제 승인 중 오류 발생시 호출
	            break
	    }
	}
}

$(function(){
	$("#mbrBtn").click();

	//약관 동의 확인
	$(".selfBtn").on("click",function(){
		if(!$("#firstChk").is(":checked") || !$("#secondChk").is(":checked") || !$("#thirdChk").is(":checked")){
			alert("필수 약관에 동의 해주세요.");
			return false;
		}else{
			f_cert();
		}
	});

	// 전체 약관 동의
	$("#check-all").on("click",function(){
		if(!$("#check-all").is(":checked")){
			$("#firstChk, #secondChk, #thirdChk").prop("checked",false);
		}else{
			$("#firstChk, #secondChk, #thirdChk").prop("checked",true);
		}
	});
});
</script>