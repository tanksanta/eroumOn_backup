<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

	<main class="mainContainer">
		<!-- 상단 뒤로가기 버튼 추가 -->
		<jsp:include page="/WEB-INF/jsp/app/matching/common/topButton.jsp" />
		
		<h2>이로움ON 로그인</h2>
		
		<div>
			아이디<br>
			<input type="text" class="form-control" id="mbrId">
			<br>
			비밀번호<br>
			<input type="password" class="form-control" id="mbrPw">
			<br>
			<a href="#">아이디 찾기</a>
			<a href="#">비밀번호 찾기</a>
			
			
			<br>
			<br>
			<button class="btn btn-primary" type="button" onclick="clickLoginBtn();">로그인하기</button>
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
					location.href = '/matching/membership/loginAfterAction';
				}
			);
		}
	
		function f_rsa_enc(v, rpkm, rpke) {
			let rsa = new RSAKey();
			rsa.setPublic(rpkm,rpke);
			return rsa.encrypt(v);
		}
	</script>