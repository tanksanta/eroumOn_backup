<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

	<div class="wrapper">
		<style>
			.wel_detail_card iframe {
				width: 100%;
				height: 180px;
			}
		</style>

		<!-- 상단 뒤로가기 버튼 추가 -->
	    <jsp:include page="/WEB-INF/jsp/app/matching/common/topButton.jsp">
	        <jsp:param value="복지용구" name="addTitle" />
	    </jsp:include>
	    

		<main>
            <section class="default noPad">

                <div class="wel_scroll_area">

                    <div class="btn_accord_area">

                        <div class="btn_accord waves-effect">
                            <span></span>
                        </div>

                    </div>

                    <div class="wel_scroll">

                        <ul class="chip_area02">
                            <li class="waves-effect">워커</li>
                            <li class="waves-effect active">실버카</li>
                            <li class="waves-effect">롤레이터</li>
                            <li class="waves-effect">수동휠체어</li>
                            <li class="waves-effect">지팡이</li>
                            <li class="waves-effect">안전손잡이 기둥형</li>
                            <li class="waves-effect">안전손잡이 변기형</li>
                            <li class="waves-effect">안전손잡이 벽걸이형</li>
                            <li class="waves-effect">미끄럼방지 매트</li>
                            <li class="waves-effect">미끄럼방지 양말</li>
                            <li class="waves-effect">욕창예방 매트리스</li>
                            <li class="waves-effect">욕창예방 방석</li>
                            <li class="waves-effect">자세변환용구</li>
     
                        </ul>


                        
                    </div>
                </div>


                <div class="pad020">
                    
                    <div class="card wel_detail_card">
                        <iframe src="https://www.youtube-nocookie.com/embed/t2_Op-DpmBU?si=ihL8jQ3JVmeKYgIP&amp;controls=0" title="YouTube video player" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture; web-share" allowfullscreen></iframe>
                        
                        <div class="card-content">
                            
                            <div class="title_area">
                                <div>
                                    <div class="color_t_s font_ssr">성인용 보행기</div>
                                    <h4 class="title">실버카</h4>
                                </div>
                                <div class="waves-effect btn_share">공유하기</div>
                            </div>

                            <div class="h20"></div>

                            <div class="font_sbms">앉을 수 있고 수납이 가능하여 야외에서 편하게 이동할 수 있어요</div>

                            <div class="h08"></div>

                            <div class="color_t_s font_sbsr">
                                 #보행이 불편한 어르신 #이동보조 #실내 #야외
                            </div>
                        
                        </div>

                        <div class="card-action">
                           
                            <a class="waves-effect btn btn-middle btn_primary w100p">관심 설정하기</a>
                            
                        </div>

                    </div>
                    <!-- wel_detail_card end -->

                    
                    <div class="card wel_detail_card">
                        <iframe src="https://www.youtube-nocookie.com/embed/F_fRNP-fC2k?si=qULuRU1AyFSM2M3V&amp;controls=0" title="YouTube video player" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture; web-share" allowfullscreen></iframe>
                        
                        <div class="card-content">
                            
                            <div class="title_area">
                                <div>
                                    <div class="color_t_s font_ssr">성인용 보행기</div>
                                    <h4 class="title">롤레이터</h4>
                                </div>
                                <div class="waves-effect btn_share">공유하기</div>
                            </div>

                            <div class="h20"></div>

                            <div class="font_sbms">방향 전환이 쉬워 다른 성인용 보행기보다 자유롭게 이동할 수 있어요</div>

                            <div class="h08"></div>

                            <div class="color_t_s font_sbsr">
                                 #보행이 불편한 어르신 #이동보조 #실내 #야외
                            </div>
                        
                        </div>

                        <div class="card-action">
                           
                            <a class="waves-effect btn btn-middle btn_primary w100p">관심 설정하기</a>
                            
                        </div>

                    </div>
                    <!-- wel_detail_card end -->
                   

                    <div class="card wel_detail_card">
                        <iframe src="https://www.youtube-nocookie.com/embed/F_fRNP-fC2k?si=qULuRU1AyFSM2M3V&amp;controls=0" title="YouTube video player" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture; web-share" allowfullscreen></iframe>
                        
                        <div class="card-content">
                            
                            <div class="title_area">
                                <div>
                                    <div class="color_t_s font_ssr">성인용 보행기</div>
                                    <h4 class="title">워커</h4>
                                </div>
                                <div class="waves-effect btn_share">공유하기</div>
                            </div>

                            <div class="h20"></div>

                            <div class="font_sbms">수술 전·후에 재활 목적으로 이용할 수 있어요</div>

                            <div class="h08"></div>

                            <div class="color_t_s font_sbsr">
                                #보행이 불편한 어르신 #이동보조 #실내 #야외
                            </div>
                        
                        </div>

                        <div class="card-action">
                           
                            <a class="waves-effect btn btn-middle btn_primary w100p">관심 설정하기</a>
                            
                        </div>

                    </div>
                    <!-- wel_detail_card end -->
                   


                </div>
                <!-- pad020 -->
            </section>
        </main>



		<!-- 하단 네이비게이션 -->
		<jsp:include page="/WEB-INF/jsp/app/matching/common/bottomNavigation.jsp">
			<jsp:param value="welfare" name="menuName" />
		</jsp:include>

	</div>
	<!-- wrapper -->
	
	
	<script>
		

        $(function () {

            //chip toggle
            $('.chip_area02 li').on('click', function () {

                if ($(this).hasClass('active') == true) {

                    $(this).removeClass('active');

                }

                else {
                    $(this).addClass('active');
                }

            });

            //btn toggle
            $('.btn_accord').on('click', function () {

                if ($(this).parents('.wel_scroll_area').hasClass('active') == true) {
                 
                    $(this).parents('.wel_scroll_area').removeClass('active');

                }

                else {
                    $(this).parents('.wel_scroll_area').addClass('active');
                }

            });


			$('.card-action .btn').on('click', function () {
				var jobjTarget = $(this).closest("div.card.wel_detail_card");
				var ctgryCd = "10a0";

				location.href = "/matching/welfareinfo/interest/choice?recipientsNo=124&careCtgryList=" + ctgryCd;
			});

        });

	</script>