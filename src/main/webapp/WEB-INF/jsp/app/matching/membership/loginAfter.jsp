<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

	<main class="mainContainer">
		
	</main>
	
	
	<script>
		$(function() {
			//앱에 토큰 정보 저장
			var appMatToken = '${appMatToken}';
			if (appMatToken) {
				sendDataToMobileApp({actionName: 'saveToken', token: appMatToken});	
			}
			
			//앱에서 접근 권한 정보 가져오기 
			sendDataToMobileApp({actionName: 'getPermissionsInfo'});
			
			
			var redirectUrl = '${returnUrl}';
			if (redirectUrl) {
				location.href = redirectUrl;
			} else {
				location.href = '/matching';
			}
		})
	</script>