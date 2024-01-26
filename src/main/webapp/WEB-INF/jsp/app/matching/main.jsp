<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

	<main style="padding:20px;">
		<br><br><br>
		<h2>Main</h2>
		<br><br>
		Hello World
		<br><br>
		<button class="btn btn-primary" onclick="clickLogoutBtn();">로그아웃</button>
		<br><br>
		<button class="btn btn-primary" onclick="location.reload();">새로고침</button>
		<br><br><br>
		카메라 테스트
		<br></br>
		<input type="file" id="camera" name="camera" accept="image/*"/>
		<br />
    	<img id="pic" style="width:100%;" />
	</main>


	<script>
		function clickLogoutBtn() {
			callPostAjaxIfFailOnlyMsg('/matching/membership/logoutAction', {}, function() { location.reload(); });
		}
		
		$(function() {
			if (!('url' in window) && ('webkitURL' in window)) {
		        window.URL = window.webkitURL;
		    }
			
			$('#camera').change(function(e){
		        $('#pic').attr('src', URL.createObjectURL(e.target.files[0]));
		    });
		});
	</script>