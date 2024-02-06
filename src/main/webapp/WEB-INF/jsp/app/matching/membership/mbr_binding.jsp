<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

	<main class="mainContainer">
		<!-- 상단 뒤로가기 버튼 추가 -->
		<jsp:include page="/WEB-INF/jsp/app/matching/common/topButton.jsp" />
		
	
		<h2>
			홍길동님 계정에<br>
			네이버를 연결할까요?
		</h2>
		
		<br>
		아이디<br><br>
		
		현재 연결된 계정<br><br>
		
		<button class="btn btn-primary" type="button" onclick="bindMbrSns();">연결하기</button>
		
	</main>
	
	
	<script>
		function bindMbrSns() {
			callPostAjaxIfFailOnlyMsg(
				'/matching/membership/sns/binding.json',
				{},
				function(result) {
					location.href = '/matching';					
				}
			);
		}
	</script>