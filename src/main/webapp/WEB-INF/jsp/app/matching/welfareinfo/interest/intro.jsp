<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<div class="wrapper">
	
    <!-- 상단 뒤로가기 버튼 추가 -->
    <jsp:include page="/WEB-INF/jsp/app/matching/common/topButton.jsp">
        <jsp:param value="" name="addButton" />
        <jsp:param value="관심복지용구" name="addTitle" />
    </jsp:include>

    <main>
        <section class="intro">


            <h2 class="title color_primary">
                관심 복지용구
            </h2>

            <h3 class="title marT4">
                신체활동이 불편하다면?<br>
                복지용구 지원받기
            </h3>

            <div class="h64"></div>

            <dotlottie-player src="https://lottie.host/0fd5df90-1dd6-4e92-8ed5-5c4657fb6983/CxBly8v4K1.json" background="transparent" speed="1" style="width: 100%; height: auto;" loop autoplay></dotlottie-player>


            <div class="box marW-20">
                <div class="img_area">
                    <img src="/html/page/app/matching/assets/src/images/08etc/money03_40_2.svg" alt="혜택">
                </div>
                <div class="ctn_area">
                    <h5 class="title">받을 수 있는 혜택 확인</h5>

                    <p class="color_t_s font_sbmr">
                        관심있는 복지용구를 바탕으로<br>
                        85%~100% 지원 혜택을 받을 수 있는 지 알려드려요
                    </p>
                </div>

            </div>
            <!-- box -->

            <div class="box marW-20">
                <div class="img_area">
                    <img src="/html/page/app/matching/assets/src/images/08etc/tool_40.svg" alt="추천">
                </div>
                <div class="ctn_area">
                    <h5 class="title">필요한 복지용구 추천</h5>

                    <p class="color_t_s font_sbmr">
                        다양한 복지용구 상품 중 어르신 상황에 적합한 상품을 추천해드려요
                    </p>
                </div>

            </div>
            <!-- box -->

            <div class="box marW-20">
                <div class="img_area">
                    <img src="/html/page/app/matching/assets/src/images/08etc/document_40.svg" alt="추천">
                </div>
                <div class="ctn_area">
                    <h5 class="title">간편한 구매 신청</h5>

                    <p class="color_t_s font_sbmr">
                        필요한 복지용구 상품을 간편하게 구매할 수 있도록 도와드려요
                    </p>
                </div>

            </div>
            <!-- box -->

        </section>
    </main>

    <footer class="page-footer">

        <div class="relative">
            <a class="waves-effect btn-large btn_primary w100p" onclick="fn_next_click(${noRecipient})">복지용구 지원받기 </a>
        </div>

    </footer>

</div>

<script>
    async function fn_next_click(noRecipient){
        if ("${isLogin}" == "false"){
            const asyncConfirm2 = await showConfirmPopup('로그인을 해 주세요', '관심복지용구를 등록하실려면 로그인이 필요해요.', '로그인하기');
            if (asyncConfirm2 != 'confirm'){
                return;
            } 

            return;
        }

        var url;
        
        if (noRecipient){
            const asyncConfirm2 = await showConfirmPopup('어르신을 등록해 주세요', '혜택을 받으려면 정확한 어르신 정보가 필요해요.', '등록하기');
            if (asyncConfirm2 != 'confirm'){
                return;
            }else{
                url = '/matching/membership/recipients/regist/relation?redirectUrl=' + encodeURIComponent(location.pathname + location.search)
            }
        }else{
            url = 'choice';
        }
        
        location.href = url + location.search;
    }
</script>