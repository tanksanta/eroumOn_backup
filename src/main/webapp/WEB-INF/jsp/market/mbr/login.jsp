<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>


	<main id="container">
		<jsp:include page="../layout/page_header.jsp">
			<jsp:param value="회원 로그인" name="pageTitle"/>
		</jsp:include>

        <div id="page-container">
            <div id="page-content">
                <form class="member-form" id="loginForm" name="loginForm" method="post">
                <input type="hidden" id="rsaPublicKeyModulus" value="${publicKeyModulus}">
				<input type="hidden" id="rsaPublicKeyExponent" value="${publicKeyExponent}">
				<input type="hidden" id="encPw" name="encPw" value="">
                    <fieldset>
                        <legend>이로움 계정 로그인</legend>
                        <div class="login-group">
                            <label class="form-label" for="loginId">아이디</label>
                            <input class="form-control" type="text" id="loginId" name="loginId">
                            <label class="form-label" for="loginPassword">비밀번호</label>
                            <input class="form-control" type="password" id="loginPassword" name="loginPassword">
                            <button class="btn btn-primary login-submit" type="submit">로그인</button>
                        </div>
                        <div class="form-check form-switch">
                            <input class="form-check-input" type="checkbox"id="saveId" name="saveId" value="Y">
                            <label class="form-check-label" for="saveId">아이디 저장</label>
                        </div>
                        <div class="login-button">
                        	<%-- 멤버스와 URL 맞춤 --%>
                            <%-- <a href="${_marketPath}/mbr/regist" class="btn btn-outline-secondary">회원 가입</a> --%>
                            <a href="${_marketPath}/info/srchId" class="btn btn-outline-secondary">아이디 찾기</a>
                            <a href="${_marketPath}/info/srchPswd" class="btn btn-outline-secondary">비밀번호 찾기</a>
                        </div>
                    </fieldset>
                </form>

                <div class="member-login-desc">
                    <img src="/html/page/market/assets/images/img-login-desc.png" alt="" class="img">
                    <div class="cont">
                        <p>
                            이로움만의<br>
                            특별함을<br>
                            누리세요
                        </p>
                        <a href="${_marketPath}/mbr/regist" class="btn btn-outline-secondary">회원가입하기</a>
                    </div>
                </div>
            </div>
        </div>
    </main>

    <script src="/html/core/vendor/rsa/RSA.min.js" /></script>
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
	            rules: {
	            	loginId: { required: true }
	                , loginPassword: { required: true }
	            },
	            messages : {
	            	loginId : {required : "! 아이디를 입력해 주세요."}
	            	, loginPassword : {required : "! 비밀번호를 입력해 주세요."}
				},
				onfocusout: function(el) { // 추가
		            if (!this.checkable(el)){this.element(el); }
		        },
			    errorPlacement: function(error, element) {
				    var group = element.closest('.form-group, .form-check');
				    if (group.length) {
				        group.after(error.addClass('text-danger'));
				    } else {
				        element.after(error.addClass('text-danger'));
				    }
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
					})).append($('<input>',{
						'name': 'returnUrl',
						'value': '${returnUrl}',
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