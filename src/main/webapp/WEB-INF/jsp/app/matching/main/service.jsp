<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

  <!-- swiper -->
  <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/swiper@11/swiper-bundle.min.css" />
  <style>
    /* swipe */
    .swiper-wrapper {
      margin: 20px 0 32px;
    }

    .swiper-slide {
      width: 280px;
      margin-left: 20px;
      /* width: calc(100% - 40px); */
    }
    
    .swiper-slide:last-child{
      margin-right: 20px;
    }
  </style>


  <div class="wrapper">

    <header>
      <nav class="top">
        <div class="btn_back">
          <div class="txt">
            
            <c:choose>
            	<c:when test="${ mainRecipient != null }">
            		<span class="txtEvt">${ mainRecipient.recipientsNm }</span>
            	</c:when>
            	<c:otherwise>
					<span class="txtEvt">어르신</span>            		
            	</c:otherwise>
            </c:choose>

			<c:if test="${ _matMbrSession.loginCheck }">
	            <div class="top_dropdown_area">
	              <a class="top_dropdown_btn modal-trigger" href="#modal_om_select"></a>
	            </div>
			</c:if>

            <span class="color_tp_s font_sbls marL4">님을 위한 서비스</span>

          </div>
        </div>
        <div class="icon_area waves-effect">
          <div class="icon_btn i_alarm"></div>
        </div>

      </nav>
    </header>


    <main>
      <section class="default back_gray">


        <!-- Swiper -->
        <div class="swiper service_Swiper marT-20W-20">
          <div class="swiper-wrapper">
            <div class="swiper-slide">

              <div class="card waves-effect w100p">

                <div class="service_img_area om_01">

                  <span class="title">인정등급 간편 테스트</span>

                </div>

                <div class="card-content">

                  <h4 class="title">
                    신체활동이 불편하다면?<br />
                    복지용구 지원받기
                  </h4>

                  <div class="tag_area">
                    <span class="tag">관심 복지용구</span>
                    <span class="tag">85% ~ 100% 지원</span>
                  </div>

                </div>
              </div>
              <!-- card -->

            </div>
            <!-- swiper-slide -->

            <div class="swiper-slide">

              <div class="card waves-effect w100p">

                <div class="service_img_area om_02">

                  <span class="title">관심복지용구</span>

                </div>

                <div class="card-content">

                  <h4 class="title">
                    장기요양보험 혜택 받을 수<br />
                    있는 지 30초만에 확인하기
                  </h4>

                  <div class="tag_area">
                    <span class="tag">인정등급 간편 테스트</span>
                    <span class="tag">최대 2600만원</span>
                  </div>

                </div>
              </div>
              <!-- card -->

            </div>
            <!-- swiper-slide -->

            <div class="swiper-slide">

              <div class="card waves-effect w100p">

                <div class="service_img_area om_03">

                  <span class="title">관심복지용구</span>

                </div>

                <div class="card-content">

                  <h4 class="title">
                    어르신에게 맞는 돌봄 서비스<br />
                    지원받기
                  </h4>

                  <div class="tag_area">
                    <span class="tag">정서케어</span>
                    <span class="tag">치매케어</span>
                  </div>

                </div>
              </div>
              <!-- card -->

            </div>
            <!-- swiper-slide -->

          </div>
        </div>



        <h4 class="title">어떤 도움을 받고 싶으세요?</h4>

        <div class="h24"></div>


        <div class="card waves-effect w100p">

          <div class="card-content d-flex justify-content-between align-items-center">

            <div>
              <span class="color_t_s font_sbsr">관심 복지용구</span>
              <h5 class="title">
                장기요양금액으로<br />관심있는 복지용구 지원받기
              </h5>
            </div> 
            <img src="/html/page/app/matching/assets/src/images/08etc/tool_40.svg" class="w80" alt="관심 복지용구">

          </div>
        </div>
        <!-- card -->

        <div class="h16"></div>

        <div class="card waves-effect w100p">

          <div class="card-content d-flex justify-content-between align-items-center">

            <div>
              <span class="color_t_s font_sbsr">간편 테스트</span>
              <h5 class="title">
                장기요양보험 혜택 받을 수<br />있는 지 빠르게 확인하기
              </h5>
            </div> 
            <img src="/html/page/app/matching/assets/src/images/08etc/test_80.svg" class="w80" alt="간편 테스트">

          </div>
        </div>
        <!-- card -->
        
        <div class="h16"></div>

        <div class="card waves-effect w100p">

          <div class="card-content d-flex justify-content-between align-items-center">

            <div>
              <span class="color_t_s font_sbsr">어르신 돌봄</span>
              <h5 class="title">
                필요한 시간에<br />돌봄 서비스 지원받기
              </h5>
            </div> 
            <img src="/html/page/app/matching/assets/src/images/08etc/time03_80.svg" class="w80" alt="어르신 돌봄">

          </div>
        </div>
        <!-- card -->


        <div class="h16"></div>

        <div class="card notice waves-effect w100p">

          <div class="card-content">
 
            <dl class="notice_dl">
              <dt>공지사항</dt>
              <dd>이용약관이 변경되었습니다.</dd>
            </dl>

          </div>
        </div>
        <!-- card -->



      </section>
    </main>

    <footer class="page-footer bottomNav">

      <ul class="bottomNav_menu">

        <li class="btn_om ">
          <a class="waves-effect">
            <span class="txt">어르신</span>
          </a>
        </li>
        <li class="btn_wel">
          <a class="waves-effect">
            <span class="txt">복지용구</span>
          </a>
        </li>
        <li class="btn_service active">
          <a class="waves-effect">
            <span class="txt">서비스</span>
          </a>
        </li>
        <li class="btn_guide">
          <a class="waves-effect">
            <span class="txt">길잡이</span>
          </a>
        </li>
        <li class="btn_entier">
          <a class="waves-effect">
            <span class="txt">전체</span>
          </a>
        </li>

      </ul>

    </footer>

  </div>
  <!-- wrapper -->
  
  
    <!-- 어르신 선택 모달 -->
    <c:if test="${ _matMbrSession.loginCheck }">
	    <div id="modal_om_select" class="modal bottom-sheet modal_om_select">
	
	      <div class="modal_header">
	        <h4 class="modal_title">어르신을 선택해주세요</h4>
	        <div class="close_x modal-close waves-effect"></div>
	      </div>
	
	      <div class="modal-content">
	
	
	        <ul class="broad_area om_select">
	          <c:forEach var="recipientInfo" items="${mbrRecipientsList}" varStatus="status">
		          <li class="modal-close<c:if test="${ recipientInfo.mainYn eq 'Y' }"> active</c:if>" recipientsNo="${ recipientInfo.recipientsNo }">
		            <div class="img_flower fl_0${status.index + 1}"></div>
		            <span>${recipientInfo.recipientsNm}</span>
		          </li>
	          </c:forEach>
	        </ul>
	        <div class="h20"></div>
	
	      </div>
	
	    </div>
  	</c:if>

	
	<script src="https://cdn.jsdelivr.net/npm/swiper@11/swiper-bundle.min.js"></script>
	<script>
		var mainRecipientsNo = '${mainRecipient.recipientsNo}';
	
		//로그아웃
		function clickLogoutBtn() {
			callPostAjaxIfFailOnlyMsg('/matching/membership/logoutAction', {}, function() {
				sendDataToMobileApp({actionName: 'removeToken'});
				deleteCookie('appMatToken');
				location.reload();
			});
		}
		
		
		$(function() {
			var swiper = new Swiper(".service_Swiper", {
		      autoHeight: true,
		      slidesPerView: "auto",
		      //centeredSlides: true,
		      spaceBetween: 0,
		      pagination: {
		        clickable: true,
		      },
		    });	
		
			
		  //어르신 선택시 상단 텍스트 변경
	      $('.broad_area.om_select li').click(function(){
	        var thisTxt = $(this).find('span').text();
	        $('.btn_back .txtEvt').text(thisTxt);
	        
	        //대표수급자 변경
	        var selectedNo = $(this).attr('recipientsNo');
	        if (mainRecipientsNo !== selectedNo) {
	        	callPostAjaxIfFailOnlyMsg(
	        		'/matching/membership/recipients/update/main.json',
	        		{ recipientsNo:Number(selectedNo), isMatching: 'Y' },
	        		function(result) {
	        			showToastMsg('대표 어르신으로 설정되었어요');
	        		}
       			);
	        }
	      });


	      //modal 오픈시 active 추가
	      var openEvt = function () {
	        $('.top_dropdown_btn').addClass('active');
	      };

	      //modal 닫을시 active 삭제
	      var closeEvt = function () {
	        $('.top_dropdown_btn').removeClass('active');

	      };

	     
	      $(".modal_om_select").modal({
	        onOpenStart: openEvt,
	        onCloseStart: closeEvt,
	      });
	      
		});
	</script>