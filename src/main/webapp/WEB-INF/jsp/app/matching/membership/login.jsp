<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

	<main style="padding:20px;">
		<br>
		<br>
		로그인 <br><br>
		
		<div>
			ID : <input type="text" class="form-control" id="mbrId">
			<br>
			PW : <input type="password" class="form-control" id="mbrPw">
			<br>
			<button class="btn btn-primary" type="button" onclick="clickLoginBtn();">로그인</button>
			<dl class="member-social">
                <dt>간편 로그인</dt>
                <dd>
                    <a href="/${_matchingPath}/kakao/auth" class="btn btn-kakao w-full">
                    	<span>카카오 로그인</span>
                    </a>
                    <a href="/${_matchingPath}/naver/get" class="btn btn-naver w-full">
                    	<span>네이버 로그인</span>
                    </a>
                </dd>
            </dl>
			<br>
			<button class="btn btn-primary" type="button" onclick="location.href = '/${_matchingPath}/membership/regist'">회원가입</button>
			
			<br><br><br>
			<button class="btn btn-primary" type="button" onclick="sendDataToMobileApp({actionName: 'callOpenUrl', url: 'tel:01029682073'});">전화 걸기</button>
		</div>
	</main>
	
	
	<script src="/html/core/vendor/rsa/RSA.min.js" /></script>
	<script>
		function clickLoginBtn() {
			var rsaPublicKeyModulus = '${publicKeyModulus}';
			var rsaPublicKeyExponent = '${publicKeyExponent}';
			
			var mbrId = $('#mbrId').val();
			var mbrPw = $('#mbrPw').val();
			var encPw = f_rsa_enc(mbrPw, rsaPublicKeyModulus, rsaPublicKeyExponent);
			
			callPostAjaxIfFailOnlyMsg(
				'/matching/membership/loginAction', 
				{mbrId, encPw},
				function(result) {
					var appMatToken = result.appMatToken;
					sendDataToMobileApp({actionName: 'saveToken', token: appMatToken});
					
					location.href = '/matching';
				}
			);
		}
	
		function f_rsa_enc(v, rpkm, rpke) {
			let rsa = new RSAKey();
			rsa.setPublic(rpkm,rpke);
			return rsa.encrypt(v);
		}
	</script>