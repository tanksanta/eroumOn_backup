<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<div class="wrapper">
	
    <!-- 상단 뒤로가기 버튼 추가 -->
    <jsp:include page="/WEB-INF/jsp/app/matching/common/topButton.jsp">
        <jsp:param value="어르신 돌봄" name="addTitle" />
    </jsp:include>

    <main>
        <section class="intro">

            <h2 class="font_h2">
                인정등급<br>
                간편 테스트
            </h2>

            <div class="h32"></div>

            <div class="center">
                <img src="/html/page/app/matching/assets/src/images/11easy/easy_01.svg" alt="인정등급 간편테스트">
            </div>

            <div class="h32"></div>

            <p class="color_t_s font_scx">
                ※ 보건복지부에서 고시한 장기 요양 등급 판정 기준을 근거로 만들어진 테스트로, 실제 판정 결과와 상이할 수 있어요
            </p>


        </section>
    </main>
    
    <footer class="page-footer">

        <div class="relative">
            <a class="waves-effect btn-large btn_primary w100p btn next">시작하기</a>
        </div>

    </footer>

</div>
<script>
    $(function() {
        $(".btn.next").off('click').on('click', function(){
            fn_move_test();
        });
    });

    function fn_move_test(){
        location.href = "/matching/simpletest/test/100?testTy=simple&recipientsNo=${recipientsNo}";
    }
</script>