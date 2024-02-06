<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

	<main class="mainContainer">
		<!-- 상단 뒤로가기 버튼 추가 -->
		<jsp:include page="/WEB-INF/jsp/app/matching/common/topButton.jsp">
			<jsp:param value="둘러보기" name="addButton" />
		</jsp:include>
		
	
		<h2>
			소중한 부모님과
			나를 위한 공간
		</h2>
		
		<h2>
			시니어 정보 플랫폼 <strong>‘이로움ON’</strong>
		</h2>
		
		<div>
			<dl class="member-social">
                <dd>
                    <a href="/matching/kakao/auth" class="btn btn-kakao w-full">
                    	<span>카카오로 계속하기</span>
                    </a>
                    <a href="/matching/naver/login" class="btn w-full">
                    	<span>다른 방법으로 계속하기</span>
                    </a>
                </dd>
            </dl>
		</div>
	</main>
	
	
	<script>
		
	</script>