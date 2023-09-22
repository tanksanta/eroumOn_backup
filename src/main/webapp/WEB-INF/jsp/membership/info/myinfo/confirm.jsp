<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%-- 간편로그인 인증 절차 추가 --%>



<main id="container" class="is-mypage-style">
	<header id="page-title">
		<h2>
			<span>회원정보수정</span>
			<small>Member Modify</small>
		</h2>
	</header>

	<jsp:include page="../../layout/page_nav.jsp" />

	<div id="page-content">

		<c:choose>
			<c:when test="${_mbrSession.joinTy eq 'K'}">
		<div class="items-center justify-between md:flex">
			<div class="space-y-1.5">
				<p class="text-alert">고객님의 개인정보를 안전하게 취급하며, 회원님의 동의 없이는 회원정보를 공개 및 변경하지 않습니다.</p>
				<p class="text-alert">회원님의 개인정보 보호를 위해 로그인 된 계정을 한번 더 인증해주세요</p>
			</div>
		</div>
		<div class="mt-8">
			<a href="${_membershipPath}/kakao/reAuth" class="btn btn-kakao w-full" target="_blank">
				<span>카카오 인증하기</span>
			</a>
		</div>
			</c:when>
			<c:when test="${_mbrSession.joinTy eq 'N'}">
		<div class="items-center justify-between md:flex">
			<div class="space-y-1.5">
				<p class="text-alert">고객님의 개인정보를 안전하게 취급하며, 회원님의 동의 없이는 회원정보를 공개 및 변경하지 않습니다.</p>
				<p class="text-alert">회원님의 개인정보 보호를 위해 로그인 된 계정을 한번 더 인증해주세요</p>
			</div>
		</div>
		<div class="mt-8">
			<a href="${_membershipPath}/naver/reAuth" class="btn btn-naver w-full" target="_blank">
				<span>네이버 인증하기</span>
			</a>
		</div>
			</c:when>
			<c:otherwise>
		<div class="items-center justify-between md:flex">
			<div class="space-y-1.5">
				<p class="text-alert">고객님의 개인정보를 안전하게 취급하며, 회원님의 동의 없이는 회원정보를 공개 및 변경하지 않습니다.</p>
				<p class="text-alert">회원님의 개인정보 보호를 위해 비밀번호를 다시 입력해 주세요.</p>
			</div>
		</div>
		<form id="pwdChkFrm" name="pwdChkFrm" method="post" action="./action" class="member-modify-password">
		<input type="hidden" id="rsaPublicKeyModulus" value="${publicKeyModulus}">
		<input type="hidden" id="rsaPublicKeyExponent" value="${publicKeyExponent}">
		<input type="hidden" id="encPw" name="encPw" value="" />

		<input type="hidden" name="returnUrl" value="${param.returnUrl}" />
			<fieldset>
				<div class="form-group">
					<label for="pswd" class="font-bold">비밀번호</label>
					<input type="password" class="form-control" name="pswd" id="pswd">
				</div>
			</fieldset>
			<button type="submit" class="btn-large btn-primary">확인</button>
		</form>

			</c:otherwise>
		</c:choose>
	</div>
</main>


<script src="/html/core/vendor/rsa/RSA.min.js" /></script>
<script>
$(function(){

	const pswdChk = /^.*(?=.*\d)(?=.*[a-zA-Z])(?=.*[!@#$%^&+=*]).*$/;

	var f_rsa_enc = function(v, rpkm, rpke) {
		let rsa = new RSAKey();
		rsa.setPublic(rpkm,rpke);
		return rsa.encrypt(v);
	}

	//유효성 검사
	$("form[name='pwdChkFrm']").validate({
	    ignore: "input[type='text']:hidden",
	    rules : {
	    	pswd : {required : true, regex : pswdChk}
	    },
	    messages : {
	    	pswd : {required : "비밀번호는 필수 입력 항목입니다.", regex : "8~16자 영문, 숫자, 특수문자를 조합하여 입력해 주세요."}
	    },
	    errorElement:"p",
	    errorPlacement: function(error, element) {
		    var group = element.closest('.form-group');
		    if (group.length) {
		        group.after(error.addClass('text-alert is-danger'));
		    } else {
		        element.after(error.addClass('text-alert is-danger'));
		    }
		},
	    submitHandler: function (frm) {
	    	var rsaPublicKeyModulus = $("#rsaPublicKeyModulus").val();
		    var rsaPublicKeyExponent = $("#rsaPublicKeyExponent").val();
		    var encPassword = f_rsa_enc($("#pswd").val().trim(), rsaPublicKeyModulus, rsaPublicKeyExponent);

	    	$("#encPw").val(encPassword);
    		frm.submit();
	    }
	});
});
</script>