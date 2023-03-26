<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="x-ua-compatible" content="ie=edge">

    <title>login</title>
    
    <link id="favicon" rel="shortcut icon" href="/html/core/images/favicon.ico" sizes="16x16">

    <!-- plugin -->
    <link rel="stylesheet" href="/html/core/vendor/jstree/dist/themes/default/style.min.css">
    <link rel="stylesheet" href="/html/core/vendor/jquery/jquery-ui.min.css">

    <script src="/html/core/vendor/jquery/jquery-3.6.0.min.js"></script>
    <script src="/html/core/vendor/jquery/jquery-ui.min.js"></script>
    <script src="/html/core/vendor/jquery.validate/jquery.validate.min.js"></script>
    <script src="/html/core/vendor/rsa/RSA.min.js" /></script>

	<!-- common -->
    <script src="/html/core/script/utility.js"></script>

    <!-- admin -->
    <link rel="stylesheet" href="/html/page/admin/assets/style/style.min.css">
    <script src="/html/page/admin/assets/script/common.js"></script>
</head>
<body>
    <div class="login-wrapper">
        <div class="market-title">eroum market</div>

        <h1 class="system-title">
            Management<br> System
            <small>이로움마켓 관리 시스템</small>
        </h1>

        <form class="login-form" id="loginForm" method="post">
        <input type="hidden" id="rsaPublicKeyModulus" value="${publicKeyModulus}">
		<input type="hidden" id="rsaPublicKeyExponent" value="${publicKeyExponent}">
		<input type="hidden" id="encPw" name="encPw" value="">
            <fieldset>
                <legend>Manager Login</legend>
                <input type="text" class="form-control large" placeholder="Manager ID" name="loginId" id="loginId" maxlength="50">
                <input type="password" class="form-control large" placeholder="Password" name="loginPassword" id="loginPassword" maxlength="100">
                <button type="submit" class="btn-primary xlarge shadow">Login</button>

                <div class="form-check form-switch">
                    <input class="form-check-input" type="checkbox"  id="saveId" name="saveId" value="Y">
                    <label class="form-check-label" for="saveId">아이디 저장</label>
                </div>
            </fieldset>
        </form>

        <p class="text-copyright">Copyright ⓒEroumMarket All righs reserved.</p>
    </div>

    <script src="/html/core/vendor/twelements/index.min.js"></script>
    <script>
    $(function(){
    	const f_rsa_enc = function(v, rpkm, rpke) {
			let rsa = new RSAKey();
			rsa.setPublic(rpkm,rpke);
			return rsa.encrypt(v);
		}

    	$('#loginForm')
	    	.submit(function(e){e.preventDefault();})
			.validate({
			    onkeyup: false,
			    onclick: false,
				/*
			    onfocusout: false,
			    */
	            rules: {
	            	loginId: { required: true },
	                loginPassword: { required: true }
	            },
				showErrors: function(errorMap,errorList){
					$(".invalid-feedback").remove();
					if(this.numberOfInvalids()){ // 에러가 있으면 커스텀 메세지
						$("fieldset > legend").after('<div class="alert alert-danger fade show invalid-feedback"><p>아이디 비밀번호를 다시 확인해주세요</p><button type="button" data-bs-dismiss="alert">닫기</button></div>');
					}
				},
				success: function(lebel){
					$(".invalid-feedback").remove();
				},
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
</body>
</html>