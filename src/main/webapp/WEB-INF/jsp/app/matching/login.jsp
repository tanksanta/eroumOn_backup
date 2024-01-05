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
			<br><br><br>
			<button class="btn btn-primary" type="button" onclick="sendDataToMobileApp({msg: '심심해서 보내봄'});">모바일에 데이터 전송</button>
			<br><br>
			<button class="btn btn-primary" type="button" onclick="sendDataToMobileApp({actionName: 'sendToWebView'});">모바일에서 데이터 받기</button>
			<br><br>
			<button class="btn btn-primary" type="button" onclick="sendDataToMobileApp({actionName: 'saveLocal'});">로컬 저장</button>
			<br><br>
			<button class="btn btn-primary" type="button" onclick="sendDataToMobileApp({actionName: 'loadLocal'});">로컬 불러오기</button>
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
		
		function sendDataToMobileApp(data) {
			if (window.ReactNativeWebView) {
				window.ReactNativeWebView.postMessage(
					JSON.stringify(data)
				);
			} else {
				alert('모바일이 아닙니다');
			}
		}
		
		
		function receiveDataFromMobileApp() {
			const listener = event => {
				alert(event.data);
			}
			
			if (window.ReactNativeWebView) {
				// android
				document.addEventListener("message", listener);
				
				// ios
				window.addEventListener("message", listener);
			} else {
				alert('모바일이 아닙니다');
			}
		}
		
		$(function () {
			receiveDataFromMobileApp();
		});
	</script>