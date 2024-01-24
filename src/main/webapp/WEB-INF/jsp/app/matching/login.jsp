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
			
			
			<br><br><br>
			<button class="btn btn-primary" type="button" onclick="sendDataToMobileApp({msg: '심심해서 보내봄'});">모바일에 데이터 전송</button>
			<br><br>
			<button class="btn btn-primary" type="button" onclick="sendDataToMobileApp({actionName: 'sendToWebView'});">모바일에서 데이터 받기</button>
			<br><br>
			<button class="btn btn-primary" type="button" onclick="sendDataToMobileApp({actionName: 'saveLocal'});">로컬 저장</button>
			<br><br>
			<button class="btn btn-primary" type="button" onclick="sendDataToMobileApp({actionName: 'loadLocal'});">로컬 불러오기</button>
			<br><br>
			<button class="btn btn-primary" type="button" onclick="f_cert();">본인 인증</button>
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
				//location.href = "/";
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
				//location.href = "/";
			}
		}
		
		async function f_cert(){
			//alert 기능 잠시 사용못하도록 처리(웹뷰 본인인증창에서 무분별하게 alert됨)
			var tempAlert = window.alert;
			window.alert = function() {};
			
			try {
			    var requestAuthentication = Bootpay.requestAuthentication({
			        application_id: "${_bootpayScriptKey}",
			        pg: '다날',
			        order_name: '본인인증',
			        authentication_id: 'CERT00000000001',
			        extra: { show_close_button: true }
			    })
			    
			    //모바일 창 문제로 width 사이즈 줄임
			    if (window.ReactNativeWebView) {
				    $('#bootpay-payment-window-id').css('width', '100%');
				    $('#bootpay-payment-window-id').css('margin', '0 auto');
			    }
			    
			    //결제창 사이즈 체크용
			  	//setTimeout(function() {
			    //	  alert('밖 window width : ' + $('#bootpay-window-id').css('width'));
				//    alert('안 window width : ' + $('#bootpay-payment-window-id').css('width'));
			    //}, 2000);
			    
			    const response = await requestAuthentication;
			    
			    switch (response.event) {
			        case 'done':
			            console.log("response.data", response.data);
			            var receiptId = response.data.receipt_id;
			            
			          	//alert 기능 되돌리기
			            window.alert = tempAlert;
			            break;
			    }
			} catch (e) {
			    switch (e.event) {
			        case 'cancel':
			            console.log(e.message);	// 사용자가 결제창을 닫을때 호출
			            break
			        case 'error':
			            console.log(e.error_code); // 결제 승인 중 오류 발생시 호출
			            break
			    }
			    
			    //alert 기능 되돌리기
			    window.alert = tempAlert;
			}
		} 
		
		$(function () {
			receiveDataFromMobileApp();
		});
	</script>