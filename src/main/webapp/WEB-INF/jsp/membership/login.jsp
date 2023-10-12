<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

	<%-- 로그인 --%>
    <main id="container">
        <header id="page-title">
            <h2>
                <span>로그인</span>
                <small>Login</small>
            </h2>
        </header>

        <div id="page-content">
            <form action="/membership/loginAction" method="post" id="loginFrm" name="loginFrm" class="login-form">
	            <input type="hidden" id="rsaPublicKeyModulus" value="${publicKeyModulus}">
				<input type="hidden" id="rsaPublicKeyExponent" value="${publicKeyExponent}">
				<input type="hidden" id="encPw" name="encPw" value="">
                <fieldset>
                    <legend>이로움ON 계정 로그인</legend>
                    <div class="form-group">
                        <label class="form-label" for="login-item1">아이디</label>
                        <input class="form-control" type="text" id="mbrId" name="mbrId">
                        <!-- <div id="loginId-error" class="error text-danger">! 아이디를 입력해 주세요.</div> -->

                        <label class="form-label" for="login-item2">비밀번호</label>
                        <input class="form-control" type="password" id="mbrPw" name="mbrPw">

                        <button class="btn btn-primary form-submit" type="submit">로그인</button>
                    </div>
                    <div class="form-check form-switch">
                        <input class="form-check-input" type="checkbox" id="saveId" name="saveId" value="Y">
                        <label class="form-check-label" for="saveId">아이디 저장</label>
                    </div>
                    <div class="form-link">
                        <a href="${_membershipPath}/srchId" class="link">아이디 찾기</a>
                        <a href="${_membershipPath}/srchPswd" class="link">비밀번호 찾기</a>
                        <a href="${_membershipPath}/regist" class="btn btn-small">회원가입</a>
                    </div>
                </fieldset>
            </form>

            <dl class="member-social">
                <dt>간편 로그인</dt>
                <dd>
                    <a href="${_membershipPath}/kakao/auth" class="btn btn-kakao w-full">
                    	<span>카카오 로그인</span>
                    </a>
                    <a href="${_membershipPath}/naver/get" class="btn btn-naver w-full">
                    	<span>네이버 로그인</span>
                    </a>
                </dd>
            </dl>
            
            <div style="text-align: center;">
            	<a href="<c:choose><c:when test="${returnUrl eq '/test/physical'}">/main/cntnts/test</c:when> <c:when test="${!empty returnUrl}">${returnUrl}</c:when> <c:otherwise>/</c:otherwise></c:choose>" 
            	   class="btn btn-large" 
            	   style="margin-top: 50px;width: 270px;height: 60px;">취소
            	</a>
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

    	$('#loginFrm')
	    	.submit(function(e){e.preventDefault();})
			.validate({
				onkeyup: false,
	            rules: {
	            	mbrId: { required: true }
	                , mbrPw: { required: true }
	            },
	            messages : {
	            	mbrId : {required : "! 아이디를 입력해 주세요."}
	            	, mbrPw : {required : "! 비밀번호를 입력해 주세요."}
				},
		  	    onfocusout: function(el) { // 추가
	                if (!this.checkable(el)){this.element(el); }
	            },
	    	    errorPlacement: function(error, element) {
	    		    var group = element.closest('.search-group');
	    		    if (group.length) {
	    		        group.after(error.addClass('text-danger'));
	    		    } else {
	    		        element.after(error.addClass('text-danger'));
	    		    }
	    		},
			    submitHandler: function (frm) {
					var rsaPublicKeyModulus = document.getElementById("rsaPublicKeyModulus").value;
				    var rsaPublicKeyExponent = document.getElementById("rsaPublicKeyExponent").value;
				    var encPassword = f_rsa_enc(document.getElementById("mbrPw").value, rsaPublicKeyModulus, rsaPublicKeyExponent);

					$('<form>', {
						'action': 'loginAction',
						'method': 'post'
					}).append($('<input>',{
						'name': 'mbrId',
						'value': frm.mbrId.value,
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
					})).append($('<input>',{
						'name': 'loginRedirectUrl',
						'value': '${loginRedirectUrl}',
						'type': 'hidden'
					})).append($('<input>',{
						'name': 'loginRedirectMethod',
						'value': '${loginRedirectMethod}',
						'type': 'hidden'
					})).append($('<input>',{
						'name': 'loginRedirectParam',
						'value': '${loginRedirectParam}',
						'type': 'hidden'
					})).append($('<input>',{
						'name': 'loginRedirectDoubleSubmit',
						'value': '${loginRedirectDoubleSubmit}',
						'type': 'hidden'
					})).appendTo('body').submit();
					return false;
			    }
	        });

		<c:if test="${!empty saveId}">
		$("#mbrId").val("${saveId}");
		$("#saveId").prop("checked", true);
		</c:if>

    });
    </script>