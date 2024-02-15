<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

	<main class="mainContainer">
		<br><br><br>
		<h2>앱 접근 권한을 허용해주세요</h2>
		<br>
		선택 권한의 경우 허용하지 않아도 서비스를 이용할 수 있으나 일부 서비스 이용이 제한될 수 있습니다
		<br><br>
		선택 권한
		<br>
		<button class="btn btn-primary" type="button" onclick="sendDataToMobileApp({ actionName: 'requestPermissions', type: 'push' });">알림</button>
		<button class="btn btn-primary" type="button" onclick="sendDataToMobileApp({ actionName: 'requestPermissions', type: 'location' });">위치</button>
		<br>
		<br>
		<button class="btn btn-primary" type="button" onclick="location.href = '${redirectUrl}';">확인</button>
	</main>


	<script>
		$(function() {
			
		});
	</script>