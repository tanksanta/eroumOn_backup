// 매칭앱 전용 본인인증 함수

async function f_cert(callback){
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
	            
	            //콜백 호출
	            callback(receiptId);
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