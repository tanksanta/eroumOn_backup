<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

	<main>
		<br>
		<br>
		로그인 <br><br>
		
		<form action="/matching/loginAction" method="post" id="loginFrm">
			<input type="hidden" id="rsaPublicKeyModulus" value="${publicKeyModulus}">
			<input type="hidden" id="rsaPublicKeyExponent" value="${publicKeyExponent}">
			<input type="hidden" id="encPw" name="encPw" value="">
			
			ID : <input type="text">
			<br>
			PW : <input type="password">
			<br>
			<button type="button">로그인</button>
		</form>
	</main>
	
	
	<script src="/html/core/vendor/rsa/RSA.min.js" /></script>
	<script>
		$(function() {
			const f_rsa_enc = function(v, rpkm, rpke) {
				let rsa = new RSAKey();
				rsa.setPublic(rpkm,rpke);
				return rsa.encrypt(v);
			}
			
			
		});
	</script>