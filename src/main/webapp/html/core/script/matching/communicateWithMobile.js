//모바일로 데이터 전송
function sendDataToMobileApp(data) {
	if (window.ReactNativeWebView) {
		window.ReactNativeWebView.postMessage(
			JSON.stringify(data)
		);
	} else {
		//location.href = "/";
	}
}

//모바일에서 데이터 받기
function receiveDataFromMobileApp() {
	const listener = event => {
		var jsonStr = event.data;
		var jsonData = JSON.parse(jsonStr);
	
		//리다이렉트 처리
		if (jsonData.actionName && jsonData.actionName === 'redirect') {
			location.href = jsonData.url;
		}
		//App Location 정보 Cookie에 저장
		if (jsonData.actionName && jsonData.actionName === 'location') {
			setCookie('location', jsonData.location.lat + 'AND' + jsonData.location.lot, 1);
		}
		//이벤트 받고 데이터 alert		
		else {
			alert(jsonStr);
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