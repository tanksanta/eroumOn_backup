<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<div class="wrapper">
	
    <!-- 상단 뒤로가기 버튼 추가 -->
    <jsp:include page="/WEB-INF/jsp/app/matching/common/topButton.jsp">
        <jsp:param value="" name="addButton" />
        <jsp:param value="어르신 돌봄" name="addTitle" />
    </jsp:include>



    <main>
        <section class="intro">

            <h2 class="title color_tp_pp ">
                어르신 돌봄
            </h2>
            <h3 class="title marT4">
                요양기관 이용 가능한 지<br>
                확인하기
            </h3>

            <div class="h64"></div>

            <div class="align_center">
                <dotlottie-player src="https://lottie.host/ac99e2a2-35f7-4cac-b2c7-ed578d93a590/E42FDGRKfP.json" background="transparent" speed="1" style="width: 320px; height: 200px;" loop autoplay></dotlottie-player>
            </div>

            <div class="h64"></div>

            <div class="font_sblb">필요한 시간에 돌봄 신청</div>

            <div class="h08"></div>


            <p class="font_sbmr">
                돌봄이 필요한 시간을 선택하세요. 어르신에게 맞는 돌봄 서비스를 장기요양금액을 지원받고 이용할 수 있어요.
            </p>
            <div class="h40"></div>

            <div class="box_normal padH24W20 marW-20">

                <div class="font_sblb">다양한 돌봄 혜택</div>

                <div class="h20"></div>

                <div class="card bder">

                    <div class="box pad20">
                        <div class="img_area">
                            <img src="/html/page/app/matching/assets/src/images/08etc/emotion_40.svg" alt="정서케어">
                        </div>
                        <div class="ctn_area">
                            <h5 class="title">정서케어</h5>
    
                            <p class="color_t_s font_sbmr">
                                어르신들의 말벗이 되어 친구처럼, 자녀처럼 지내며 정서적 안정을 도와드려요.
                            </p>
                        </div>
                    </div>

                </div>
                <!-- card -->

                <div class="h16"> </div>

                <div class="card bder">

                    <div class="box pad20">
                        <div class="img_area">
                            <img src="/html/page/app/matching/assets/src/images/08etc/accompany_40.svg" alt="외출동행">
                        </div>
                        <div class="ctn_area">
                            <h5 class="title">외출동행(병원동행)</h5>
    
                            <p class="color_t_s font_sbmr">
                                병원 외래가 필요하시다면 스케줄에 맞춰 동행해드려요
                            </p>
                        </div>
                    </div>

                </div>
                <!-- card -->

                <div class="h16"> </div>

                <div class="card bder">

                    <div class="box pad20">
                        <div class="img_area">
                            <img src="/html/page/app/matching/assets/src/images/08etc/bokji09_40.svg" alt="치매케어">
                        </div>
                        <div class="ctn_area">
                            <h5 class="title">치매케어</h5>
    
                            <p class="color_t_s font_sbmr">
                                국가 공인 치매 교육을 받은 요양보호사님과 치매에 대한 교육 및 케어를 진행해요.
                            </p>
                        </div>
                    </div>

                </div>
                <!-- card -->

                <div class="h20"></div>

                <div class="font_sbmr">이 외에도 신체활동, 인지활동 등 어르신 상황에 따라 받을 수 있는 혜택이 있으니 상담을 통해 확인해보세요.</div>
                
            </div>
            <!-- box -->


        </section>
    </main>

    
		<footer class="page-footer">

            <div class="relative">
                <a class="waves-effect btn-large btn_primary w100p" onclick="fn_next_click()">다음</a>
            </div>

        </footer>
</div>

<script>
    async function fn_next_click(){
        var recipientsCnt = "${recipientsCnt}";

        if ("${isLogin}" == "false"){
            const asyncConfirm2 = await showConfirmPopup('로그인을 해 주세요', '관심복지용구를 등록하실려면 로그인이 필요해요.', '로그인하기');
            if (asyncConfirm2 != 'confirm'){
                return;
            } 

            location.href = "/matching/kakao/login";
            return;
        }

        if (recipientsCnt == "" || parseInt(recipientsCnt) == 0){
            const asyncConfirm = await showConfirmPopup('어르신을 등록해 주세요', '혜택을 받으려면 정확한 어르신 정보가 필요해요.', '등록하기');
            if (asyncConfirm != 'confirm'){
                return;
            }
        }else{
            var url = 'time';
            location.href = url + location.search;
        }
    }
</script>