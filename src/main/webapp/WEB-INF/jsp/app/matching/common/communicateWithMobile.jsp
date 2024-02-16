<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%-- 전역적으로 APP과 통신 스크립트 처리 --%>
<script>
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
			else if (jsonData.actionName && jsonData.actionName === 'location') {
				setCookie('location', jsonData.location.lat + 'AND' + jsonData.location.lot, 1);
			}
			//앱 접근 권한 정보 가져와서 저장
			else if (jsonData.actionName === 'getPermissionsInfo') {
				callPostAjaxIfFailOnlyMsg(
					'/matching/membership/info/updatePermissionInfo', 
					{ permissionInfoJson: JSON.stringify(jsonData.permissions) },
					function(result) {
						
					}
				);
			}
			//App 로그인 토큰 정보 Cookie에 저장
			else if (jsonData.actionName && jsonData.actionName === 'saveAppMatToken') {
				setCookie('appMatToken', jsonData.appMatToken, 365);
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
</script>