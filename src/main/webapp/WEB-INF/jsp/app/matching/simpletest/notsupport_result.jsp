<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<div class="wrapper">
	
    <!-- 상단 뒤로가기 버튼 추가 -->
    <jsp:include page="/WEB-INF/jsp/app/matching/common/topButton.jsp">
        <jsp:param value="true" name="noBackButtion" />
        <jsp:param value="" name="addButton" />
        <jsp:param value="${addTitle}" name="addTitle" />
    </jsp:include>

    <main>
        <section class="intro">

            <h2 class="title02">
                꽃분이님,<br>
                돌봄 혜택을 받지 못할 것으로 예상돼요
            </h2>

            <div class="h12"></div>

            <div class="color_t_s font_sbmr">다른 혜택을 받을 수 있는 지 확인해보세요</div>

            <div class="h48"></div>

            <div class="center">
                <img src="/html/page/app/matching/assets/src/images/11easy/easy_11.svg" al t="테스트 결과">
            </div>

            <div class="h12"></div>

            <p class="color_t_s font_scx">
                ※ 보건복지부에서 고시한 장기 요양 등급 판정 기준을 근거로 만들어진 테스트로, 실제 판정 결과와 상이할 수 있어요
            </p>
            <div class="h40"></div>

            <div class="box_normal marW-20">

                <div class="card">

                    <div class="card-content"> 

                        <div class="box noPad w56">
                            <div class="img_area w56">
                              <img src="/html/page/app/matching/assets/src/images/08etc/money01_40.svg" alt="혜택">
                            </div>
                            <div class="ctn_area">
                              <div class="font_sbmb">어르신 상황에 따라 이러한 혜택을 받을 수 있어요</div>
                            </div>
                        </div>
                        
                        <div class="h20"></div>

                        <div class="padL8">
                            <div class="waves-effect list_link bbs_link bder_bottom font_sbmr" bbs_link="">보청기 구매비 지원</div>
                            <div class="waves-effect list_link bbs_link bder_bottom font_sbmr" bbs_link="">임플란트 이용 지원</div>
                            <div class="waves-effect list_link bbs_link bder_bottom font_sbmr" bbs_link="">틀니 비용 지원</div>
                            <div class="waves-effect list_link bbs_link bder_bottom font_sbmr" bbs_link="">인공관절 수술비 지원</div>
                            <div class="waves-effect list_link bbs_link bder_bottom font_sbmr" bbs_link="">노인개안 수술비 지원</div>
                            <div class="waves-effect list_link bbs_link bder_bottom font_sbmr" bbs_link="">치매 검사비 지원</div>
                            <div class="waves-effect list_link bbs_link font_sbmr" bbs_link="">치매 치료비 지원</div>
                        </div>

                    </div>
                </div>

                <div class="h20"></div>
                
            </div>
            <!-- box -->


        </section>
    </main>

    <footer class="page-footer">

        <div class="relative">
            <a class="waves-effect btn-large btn_primary w100p" onclick="fn_next_click()">다른 혜택 알아보기</a>
        </div>

    </footer>

</div>
<script>
    $(function () {
        $("body").addClass("back_gray");

        $(".card-content .bbs_link").off('click').on('click', function(){
            location.href = "/matching/bbs/guide/linkview/"+"linkdfaffda";
        });
    });

    function fn_next_click(){
        location.href = "/matching/bbs/guide/list";
    }
</script>    