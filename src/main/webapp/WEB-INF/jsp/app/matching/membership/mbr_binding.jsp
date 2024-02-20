<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

    <div class="wrapper">

        <header>
            <nav class="top">
                <a class="btn_back waves-effect" href="#">
                    <span class="icon"></span>
                    <!-- <span class="txt">상담 신청 완료</span> -->
                </a>


            </nav>
        </header>

        <main>
            <section class="intro">

                <h3 class="title">
                    홍길동님 계정에<br />
                    네이버를 연결할까요?
                </h3>

                <div class="h32"></div>

				<!--
                <div class="color_t_s font_sbsr">이메일</div>
				-->

                <div class="h08"></div>

                <div class="btn-large btn_primary_light w100p d-flex align-items-center">
                	<c:choose>
                		<c:when test="${tempMbrVO.joinTy eq 'K'}">
                			<img class="icon_img" src="/html/page/app/matching/assets/src/images/08etc/social_kakao_40.svg">
                    		<span>${tempMbrVO.eml}</span>
                		</c:when>
                		<c:when test="${tempMbrVO.joinTy eq 'N'}">
                			<img class="icon_img" src="/html/page/app/matching/assets/src/images/08etc/icon_naver02.svg">
                    		<span>${tempMbrVO.eml}</span>	
                		</c:when>
                	</c:choose>
                </div>

                <div class="h32"></div>

                <div class="color_t_s font_sbsr">현재 연결된 계정</div>

                <div class="h08"></div>
				
				<c:if test="${ !empty kakaoAuthInfo }">
	                <div class="btn-large btn_white w100p d-flex align-items-center">
	                    <img class="icon_img" src="/html/page/app/matching/assets/src/images/08etc/social_kakao_40.svg">
	                    <span>${kakaoAuthInfo.eml}</span>
	                </div>
                </c:if>
                
                <c:if test="${ !empty naverAuthInfo }">
	                <div class="btn-large btn_white w100p d-flex align-items-center">
	                    <img class="icon_img" src="/html/page/app/matching/assets/src/images/08etc/icon_naver02.svg">
	                    <span>${naverAuthInfo.eml}</span>
	                </div>
                </c:if>
                
                <c:if test="${ !empty eroumAuthInfo }">
	                <div class="btn-large btn_white w100p d-flex align-items-center">
	                    <img class="icon_img" src="/html/page/app/matching/assets/src/images/08etc/icon_naver02.svg">
	                    <span>${eroumAuthInfo.mbrId}</span>
	                </div>
                </c:if>

            </section>
        </main>

        <footer class="page-footer">

            <div class="relative">
                <a class="waves-effect btn-large btn_primary w100p" onclick="bindMbrSns();">연결하기</a>
            </div>

        </footer>

    </div>
    <!-- wrapper -->
	
	
	<script>
		function bindMbrSns() {
			callPostAjaxIfFailOnlyMsg(
				'/matching/membership/sns/binding.json',
				{},
				function(result) {
					showToastMsg('계정이 연결되었어요', function() {
						location.replace('/matching');
					});					
				}
			);
		}
	</script>