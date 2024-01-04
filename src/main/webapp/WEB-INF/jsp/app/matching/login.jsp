<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

	<main style="padding:20px;">
		<br>
		<br>
		로그인 <br><br>
		
		<form>
			ID : <input type="text" class="form-control" id="mbrId">
			<br>
			PW : <input type="password" class="form-control" id="mbrPw">
			<br>
			<button class="btn btn-primary" type="button" onclick="clickLoginBtn();">로그인</button>
		</form>
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
				'/matching/loginAction', 
				{mbrId, encPw},
				function(result) {
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