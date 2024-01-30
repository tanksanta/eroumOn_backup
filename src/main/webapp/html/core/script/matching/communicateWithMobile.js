// 매칭앱 모바일쪽 통신 함수

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
		var jsonStr = event.data;
		var jsonData = JSON.parse(jsonStr);
	
		//이벤트 받고 데이터 alert
		if (jsonData.actionName && jsonData.actionName === 'redirect') {
			location.href = jsonData.url;
		} else {
			alert();
		}
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

$(function () {
	receiveDataFromMobileApp();
});