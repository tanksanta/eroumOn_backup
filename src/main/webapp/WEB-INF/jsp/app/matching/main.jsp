<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

	<main style="padding:20px;">
		<br><br><br>
		<h2>Main</h2>
		<br><br>
		Hello World
		<br><br>
		<button class="btn btn-primary" onclick="clickLogoutBtn();">로그아웃</button>
	</main>


	<script>
		function clickLogoutBtn() {
			callPostAjaxIfFailOnlyMsg('/matching/logoutAction', {}, function() { location.reload(); });
		}
	</script>