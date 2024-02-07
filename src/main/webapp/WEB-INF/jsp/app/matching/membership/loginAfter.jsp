<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

	<main class="mainContainer">
		
	</main>
	
	
	<script>
		$(function() {
			debugger;
			var appMatToken = '${appMatToken}';
			if (appMatToken) {
				sendDataToMobileApp({actionName: 'saveToken', token: appMatToken});	
			}
			
			var redirectUrl = '${returnUrl}';
			if (redirectUrl) {
				location.href = redirectUrl;
			} else {
				location.href = '/matching';
			}
		})
	</script>