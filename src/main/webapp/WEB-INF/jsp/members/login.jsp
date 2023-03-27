<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<main id="container">
	<h2 class="text-title mb-15 md:mb-23 lg:mb-30">
		이로움 멤버스 관리자 로그인 <small>이로움 멤버스를 위한 로그인 화면입니다.</small>
	</h2>

	<form class="form-container" id="loginForm" name="loginForm" method="post">
        <input type="hidden" id="rsaPublicKeyModulus" value="${publicKeyModulus}">
		<input type="hidden" id="rsaPublicKeyExponent" value="${publicKeyExponent}">
		<input type="hidden" id="encPw" name="encPw" value="">
		<fieldset>
			<div class="form-rows">
				<label for="loginId" class="form-label">아이디 <i>*</i></label>
				<input type="text" placeholder="아이디 입력" class="form-control" name="loginId" id="loginId" autocomplete="off" maxlength="100">
			</div>
			<div class="form-rows">
				<label for="loginPassword" class="form-label">비밀번호 <i>*</i></label>
				<input type="password" placeholder="비밀번호 입력" class="form-control" name="loginPassword" id="loginPassword" autocomplete="off" maxlength="100">
			</div>
			<div class="flex space-x-3 xs:space-x-3.5">
				<div class="form-check mr-auto">
					<input class="form-check-input" type="checkbox" id="saveId" name="saveId" value="Y"> <label class="form-check-label" for="saveId" >아이디 저장</label>
				</div>
				<p class="text-gray6">
					<a href="./idSrch">아이디 찾기</a>
				</p>
				<p class="text-gray6">
					<a href="./pswdSrch">비밀번호 찾기</a>
				</p>
			</div>
		</fieldset>
		<div class="btn-group">
			<button type="submit" class="btn-partner large shadow">로그인</button>
		</div>
	</form>
</main>

<script src="/html/core/vendor/rsa/RSA.min.js" /></script>
 <script>
    $(function(){
    	var ssoResultMsg = '${ssoResultMsg}';
    	
    	if (ssoResultMsg) {
    		alert(ssoResultMsg);
    	}
    	
    	const f_rsa_enc = function(v, rpkm, rpke) {
			let rsa = new RSAKey();
			rsa.setPublic(rpkm,rpke);
			return rsa.encrypt(v);
		}

    	$('#loginForm')
	    	.submit(function(e){e.preventDefault();})
			.validate({
				onkeyup: false,
	            rules: {
	            	loginId: { required: true }
	                , loginPassword: { required: true }
	            },
	            messages : {
	            	loginId : {required : "아이디를 입력해 주세요."}
	            	, loginPassword : {required : "비밀번호를 입력해 주세요."}
				},
	            errorElement: 'p',
	            errorClass: 'error form-desc',
	            /*
				errorPlacement: function(error, element) {
				    var group = element.closest('.form-group');
				    if (group.length) {
				        group.after(error.addClass('form-desc'));
				    } else {
				        element.after(error.addClass('form-desc'));
				    }
				},
				*/
				highlight:function(element, errorClass, validClass) {
				    $(element).addClass('is-invalid');
				},
				unhighlight: function(element, errorClass, validClass) {
				    $(element).removeClass('is-invalid');
				},
			    submitHandler: function (frm) {
					var rsaPublicKeyModulus = document.getElementById("rsaPublicKeyModulus").value;
				    var rsaPublicKeyExponent = document.getElementById("rsaPublicKeyExponent").value;
				    var encPassword = f_rsa_enc(document.getElementById("loginPassword").value, rsaPublicKeyModulus, rsaPublicKeyExponent);

					$('<form>', {
						'action': 'loginAction',
						'method': 'post'
					}).append($('<input>',{
						'name': 'loginId',
						'value': frm.loginId.value,
						'type': 'hidden'
					})).append($('<input>',{
						'name': 'encPw',
						'value': encPassword,
						'type': 'hidden'
					})).append($('<input>',{
						'name': 'saveId',
						'value': frm.saveId.checked ? "Y" : "N",
						'type': 'hidden'
					})).appendTo('body').submit();

					return false;
			    }
	        });

		<c:if test="${!empty saveId}">
		$("#loginId").val("${saveId}");
		$("#saveId").prop("checked", true);
		</c:if>

    });
    </script>