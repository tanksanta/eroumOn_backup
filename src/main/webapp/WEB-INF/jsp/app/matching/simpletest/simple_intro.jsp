<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<div class="wrapper">
	
    <!-- 상단 뒤로가기 버튼 추가 -->
    <jsp:include page="/WEB-INF/jsp/app/matching/common/topButton.jsp">
        <jsp:param value="" name="addButton" />
        <jsp:param value="간편테스트" name="addTitle" />
    </jsp:include>

    <main>
        <section class="intro">

            <h2 class="title color_primary">
                간편 테스트
            </h2>

            <h3 class="title">
                장기요양보험 혜택 받을 수 있는 지<br>
                30초 만에 확인해보세요
            </h3>

            <div class="h64"></div>

            <dotlottie-player src="https://lottie.host/9c28e62d-0b08-40db-a4b2-4ca95263d388/ZlPHMMdI75.json" background="transparent" speed="1" style="width: 100%; height: 274px;" loop autoplay></dotlottie-player>

            <div class="h64"></div>

            <h4 class="title">빠른 장기요양 인정등급 판정</h4>
            
            <div class="h08"></div>

            <p class="font_sbmr">
                국민건강보험공단에서 제공하는 장기요양금액을 받으려면 장기요양 인정등급이 필요해요<br>
                간단한 테스트를 통해 장기요양보험 대상자인지 빠르게 확인해보세요
            </p>

            <div class="h16"></div>

            <p class="color_t_s font_scx">
                ※ 보건복지부에서 고시한 장기 요양 등급 판정 기준을 근거로 만들어진 테스트로, 실제 판정 결과와 상이할 수 있어요
            </p>

            <div class="h40"></div>

            <div class="box marW-20">
                <div class="img_area">
                    <img src="/html/page/app/matching/assets/src/images/08etc/money03_40.svg" alt="혜택">
                </div>
                <div class="ctn_area">
                    <h5 class="title">어떤 혜택을 받을 수 있나요?</h5>

                    <p class="color_t_p font_sbmr">
                        복지용구, 요양시설 등 여러가지 혜택이 있지만 어르신 상황에 따라 받을 수 있는 혜택이 달라요<br>
                        상담을 하면 전문가가 어르신이 어떠한 도움을 받을 수 있는 지 알려드려요
                    </p>
                </div>

            </div>
            <!-- box -->

            <div class="box marW-20">
                <div class="img_area">
                    <img src="/html/page/app/matching/assets/src/images/08etc/benefit_40.svg" alt="혜택">
                </div>
                <div class="ctn_area">
                    <h5 class="title">혜택은 어떻게 받을 수 있나요?</h5>

                    <p class="color_t_p font_sbmr">
                        상담을 하면 전문가가 어떻게 장기요양보험 혜택을 받을 수 있을 지 알려드려요<br>
                        어르신 상황을 파악하고 필요한 경우 인정등급 신청을 도와드려요
                    </p>
                </div>

            </div>
            <!-- box -->

        </section>
    </main>

    
    <footer class="page-footer">

        <div class="relative">
            <a class="waves-effect btn-large btn_primary w100p btn next">빠르게 확인하기</a>
        </div>

    </footer>

</div>
<script>
    $(function() {
        $("body").addClass("back_gray");

        $(".btn.next").off('click').on('click', function(){
            fn_next_click();
        });
    });

    async function fn_next_click(){
        
        if ("${_matMbrSession.loginCheck}" != "true"){
            const asyncConfirm2 = await showConfirmPopup('로그인을 해 주세요', '간편테스트를 진행하실려면 로그인이 필요해요.', '로그인하기');
            if (asyncConfirm2 != 'confirm'){
                return;
            } 

        }

        location.href = "start" + location.search;
    }
</script>