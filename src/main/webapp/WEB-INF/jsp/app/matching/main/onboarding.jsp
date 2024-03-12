<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

	<!-- swiper -->
  	<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/swiper@11/swiper-bundle.min.css" />
  	
  	<style>
    /* lottie 결합 */
    .lottie_comb_img{width: 360px; height: auto; justify-content: flex-end; align-items: flex-start; display: inline-flex;}
    .lottie_comb_img .clock{top:30px; left:90px; position: relative; z-index:10;}
    .lottie_comb_img .people{position: relative}

    .touch_lock {
      position: absolute;
      width: 100%;
      display: block;
      z-index: 10;
      background: #ff000000;
    }
  	</style>
  	

    <div class="wrapper">

	    <header>
	      <nav class="top">
	        <div></div>
	        <a class="waves-effect top_txt" href="#" onclick="skipEvt()">건너뛰기</a>
	      </nav>
	    </header>
	
	    <main>
	      <section class="noPad">
	
	        <div class="h40"></div>
	
	        <div class="swiper swiper_onboard">
	
	          <!-- 1 -->
	          <div class="swiper-wrapper">
	
	            <div class="swiper-slide">
	
	              <h3 class="title">
	                장기요양 테스트부터 상담까지
	              </h3>
	
	              <div class="h12"></div>
	
	              <div class="color_t_s font_sbmr">간단한 테스트로 예상되는 등급의 지원 금액과 혜택을 확인하세요</div>
	
	              <div class="align_center">
	                <dotlottie-player src="https://lottie.host/28d4e3c1-8668-4cef-b9b0-deb5f5273fa2/gcx3otpy1D.json"
	                  background="transparent" speed="1" style="width: 360px; height: 320px;" loop
	                  autoplay></dotlottie-player>
	              </div>
	
	            </div>
	            <!-- swiper-slide -->
	
	            <!-- 2 -->
	            <div class="swiper-slide">
	
	              <h3 class="title">
	                복지용구 상담과 구매를 한번에
	              </h3>
	
	              <div class="h12"></div>
	
	              <div class="color_t_s font_sbmr">관심있는 복지용구를 바탕으로 85%~100% 지원 혜택을 받을 수 있는 지 알려드려요</div>
	
	              <div class="align_center">
	                <dotlottie-player src="https://lottie.host/78a6f252-b178-4aa1-838b-ee445aa83697/ZgJx9l3vtp.json"
	                  background="transparent" speed="1" style="width: 360px; height: 320px;" loop
	                  autoplay></dotlottie-player>
	              </div>
	
	            </div>
	            <!-- swiper-slide -->
	
	            <!-- 3 -->
	            <div class="swiper-slide">
	
	              <h3 class="title">
	                필요한 시간에 돌봄 신청
	              </h3>
	
	              <div class="h12"></div>
	
	              <div class="color_t_s font_sbmr">어르신에게 맞는 돌봄 서비스를 장기요양금액을 지원받고 이용할 수 있어요</div>
	
	              <div class="align_center">
	
	                <div class="lottie_comb_img">
	
	                  <!-- 시계-->
	
	                  <div class="clock">
	                    <dotlottie-player src="https://lottie.host/41870c02-5168-42e6-8f35-1ee1fd56e768/cHOeVP8giP.json"
	                      background="transparent" speed="1" style="width: 58px; height: 58px;" loop
	                      autoplay></dotlottie-player>
	                  </div>
	
	                  <!-- 사람 -->
	                  <div class="people">
	                    <dotlottie-player src="https://lottie.host/acb42cc7-2106-457d-8859-cb06124e5a2b/CRs6ukgCFA.json"
	                      background="transparent" speed="1" style="width: 360px; height: 320px;" loop
	                      autoplay></dotlottie-player>
	                  </div>
	
	                </div>
	              </div>
	
	            </div>
	            <!-- swiper-slide -->
	
	
	            <!-- 4 -->
	            <div class="swiper-slide">
	
	              <h3 class="title">
	                어르신 길잡이
	              </h3>
	
	              <div class="h12"></div>
	
	              <div class="color_t_s font_sbmr">
	                어르신에게 유익한 콘텐츠를 확인하세요<br>
	                받을 수 있는 복지 혜택을 이용해보세요
	              </div>
	
	              <div class="align_center">
	                <dotlottie-player src="https://lottie.host/edb4340d-cc73-4642-8c5c-bb9bbfa64ac0/AQWJ4T2t5B.json" background="transparent" speed="1" style="width: 360px; height: 320px;" loop autoplay></dotlottie-player>
	              </div>
	
	            </div>
	            <!-- swiper-slide -->
	
	          </div>
	          <div class="swiper-pagination"></div>
	
	        </div>
	
	      </section>
	    </main>
	
	
	    <footer class="page-footer">
	
	      <div class="btn_area d-flex f-column">
	
	        <a class="waves-effect btn-large btn_primary w100p evt_nextBtn" onclick="clickNextBtn();">다음</a>
	
	      </div>
	
	    </footer>

    </div>
    <!-- wrapper -->


	<script src="https://cdn.jsdelivr.net/npm/swiper@11/swiper-bundle.min.js"></script>
	<script>
	
    	var swiper = new Swiper(".swiper_onboard", {
	        navigation: {
	          nextEl: ".evt_nextBtn",
	        },
	        pagination: {
	          el: ".swiper-pagination",
	        },
	
	        //마지막 슬라이드일때 버튼 텍스트 변경
	        on: {
	          activeIndexChange: function () {
	            if(this.realIndex == 3){
	              $('.evt_nextBtn').text('시작하기');
	            }
	            else{
	              $('.evt_nextBtn').text('다음');
	            }
		      }
	        }
        });

        //건너뛰기 버튼 마지막 슬라이드
        function skipEvt() {
        	swiper.slideTo(3, 500, false);
        	location.href = '/matching/appAccessSetting?redirectUrl=${redirectUrl}';
        }
        
        //시작하기 버튼 클릭
        function clickNextBtn() {
        	if ($('.evt_nextBtn').text() === '시작하기') {
        		skipEvt();
        	}
        }
        
        
        $(function () {

            //슬라이드 제스쳐 방지
            var swiper_onboard = $('.swiper_onboard').height();

            $('.touch_lock').height(swiper_onboard);
            
        });
	</script>