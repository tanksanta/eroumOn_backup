<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

	<div class="wrapper">
	
		<!-- 상단 뒤로가기 버튼 추가 -->
		<jsp:include page="/WEB-INF/jsp/app/matching/common/topButton.jsp">
			<jsp:param value="둘러보기" name="addButton" />
		</jsp:include>
	
		<main>
	      <section class="intro">
	
	        <h2 class="title">
	          소중한 부모님과<br />
	          나를 위한 공간
	        </h2>
	
	        <div class="txt">
	          <span>시니어 정보 플랫폼</span>
	          <span class="fw600">'이로움ON'</span>
	        </div>
	
	
	
	      </section>
	    </main>
	    
	    <footer class="page-footer">

	      <div class="btn_area d-flex f-column">
	        <div class="relative">
	          <!-- <span class="tool_tip">최근로그인</span> -->
	          <a href="/matching/naver/get" class="waves-effect btn-large btn_naver w100p d-flex" style="align-items: center;justify-content: center;">
	            <img class="icon_img" src="/html/page/app/matching/assets/src/images/08etc/icon_naver.svg">
	            <span><span class="fw700">네이버</span><span class="fw400">로 계속하기</span></span>
	          </a>
	        </div>
	        <div class="relative">
	          <a href="/matching/membership/login" class="waves-effect btn-large btn_disable w100p">이로움ON회원으로 계속하기</a>
	        </div>
	      </div>
	
	
	    </footer>
	    
	</div>
	<!-- wrapper -->
	
	
	<script>
		
	</script>