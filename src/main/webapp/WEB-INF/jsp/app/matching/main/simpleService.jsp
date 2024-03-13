<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

  <div class="wrapper">

    <main>
      <section class="back_service_info">

        <div class="h40"></div>

        <div class="center">
            <img src="/html/page/app/matching/assets/src/images/08etc/help_80.svg" alt="">
        </div>

        <div class="h32"></div>
   
  
        <h3 class="title color_white">어떤 도움을 받고 싶으세요?</h3>

        <div class="h32"></div>


        <!-- 메뉴 리스트(관심 복지용구, 간편 테스트, 어르신 돌봄) -->
		<jsp:include page="/WEB-INF/jsp/app/matching/common/components/mainMenu.jsp">
			<jsp:param name="active" value="1" />
		</jsp:include>

      </section>
    </main>



  </div>
  <!-- wrapper -->
   
   
  <script>
	$(function() {
		//현재 페이지 history 저장 
		saveCurrentPageHistory();
	  	
		//body에 css class 추가
		$('body').addClass('back_gray');
	})
  </script>