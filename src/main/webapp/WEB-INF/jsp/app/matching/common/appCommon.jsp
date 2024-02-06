<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%-- 전역적으로 APP 관련 처리 스크립트 --%>
<script>
	function showAlertPopup(msg) {
		alert('앱 : ' + msg);
	}

	//App 토큰 처리
	function checkAppToken() {
		var appMatToken = '${appMatToken}';
		
		if (appMatToken) {
			sendDataToMobileApp({actionName: 'saveToken', token: appMatToken});
		}
	}
</script>