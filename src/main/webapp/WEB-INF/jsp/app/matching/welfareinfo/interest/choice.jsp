<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<div class="wrapper">
	
    <!-- 상단 뒤로가기 버튼 추가 -->
    <jsp:include page="/WEB-INF/jsp/app/matching/common/topButton.jsp" flush="true">
        <jsp:param value="" name="addButton" />
        <jsp:param value="true" name="addCustom1" />
        <jsp:param value="복지용구소개" name="addCustom1Text" />
    </jsp:include> 

    <main>
        <section class="intro">

            <h3 class="title">
                필요한 복지용구를<br>
                선택하세요
            </h3>

            <div class="h40"></div>
            ${careCtgryList}

            <ul class="wel_select_area">
                
                <li class="walkerForAdults 10a0 <c:if test='${fn:indexOf(careCtgryList,"10a0") >= 0}'>active</c:if>">
                    <div class="img_area">
                        <img src="/html/page/app/matching/assets/src/images/02tool/tool02_01.svg" alt="성인용 보행기">
                    </div>
                    <span class="txt">성인용 보행기</span>
                </li>
                <li class="wheelchair 2080 <c:if test='${fn:indexOf(careCtgryList,"2080") >= 0}'>active</c:if>">
                    <div class="img_area">
                        <img src="/html/page/app/matching/assets/src/images/02tool/tool02_02.svg" alt="수동휠체어">
                    </div>
                    <span class="txt">수동휠체어</span>
                </li>
                <li class="cane 1050 <c:if test='${fn:indexOf(careCtgryList,"1050") >= 0}'>active</c:if>">
                    <div class="img_area ">
                        <img src="/html/page/app/matching/assets/src/images/02tool/tool02_03.svg" alt="지팡이">
                    </div>
                    <span class="txt">지팡이</span>
                </li>

                <li class="safetyHandle 1090 <c:if test='${fn:indexOf(careCtgryList,"1090") >= 0}'>active</c:if>">
                    <div class="img_area">
                        <img src="/html/page/app/matching/assets/src/images/02tool/tool02_04.svg" alt="안전손잡이">
                    </div>
                    <span class="txt">안전손잡이</span>
                </li>
                <li class="antiSlipProduct 1080 <c:if test='${fn:indexOf(careCtgryList,"1080") >= 0}'>active</c:if>">
                    <div class="img_area">
                        <img src="/html/page/app/matching/assets/src/images/02tool/tool02_05.svg" alt="미끄럼방지 매트">
                    </div>
                    <span class="txt">미끄럼방지<br>매트</span>
                </li>
                <li class="antiSlipSocks 1070 <c:if test='${fn:indexOf(careCtgryList,"1070") >= 0}'>active</c:if>">
                    <div class="img_area">
                        <img src="/html/page/app/matching/assets/src/images/02tool/tool02_06.svg" alt="미끄럼방지 양말">
                    </div>
                    <span class="txt">미끄럼방지<br>양말</span>
                </li>

                <li class="mattress 1010 <c:if test='${fn:indexOf(careCtgryList,"1010") >= 0}'>active</c:if>">
                    <div class="img_area">
                        <img src="/html/page/app/matching/assets/src/images/02tool/tool02_07.svg" alt="욕창예방 매트리스">
                    </div>
                    <span class="txt">욕창예방<br>매트리스</span>
                </li>
                <li class="cushion 1040 <c:if test='${fn:indexOf(careCtgryList,"1040") >= 0}'>active</c:if>">
                    <div class="img_area">
                        <img src="/html/page/app/matching/assets/src/images/02tool/tool02_08.svg" alt="욕창예방 방석">
                    </div>
                    <span class="txt">욕창예방 방석</span>
                </li>
                <li class="changeTool 1030 <c:if test='${fn:indexOf(careCtgryList,"1030") >= 0}'>active</c:if>">
                    <div class="img_area">
                        <img src="/html/page/app/matching/assets/src/images/02tool/tool02_09.svg" alt="자세변환용구">
                    </div>
                    <span class="txt">자세변환용구</span>
                </li>

                <li class="panties 1020 <c:if test='${fn:indexOf(careCtgryList,"1020") >= 0}'>active</c:if>">
                    <div class="img_area">
                        <img src="/html/page/app/matching/assets/src/images/02tool/tool02_10.svg" alt="요실금 팬티">
                    </div>
                    <span class="txt">요실금 팬티</span>
                </li>
                <li class="bathChair 10b0 <c:if test='${fn:indexOf(careCtgryList,"10b0") >= 0}'>active</c:if>">
                    <div class="img_area">
                        <img src="/html/page/app/matching/assets/src/images/02tool/tool02_11.svg" alt="목욕의자">
                    </div>
                    <span class="txt">목욕의자</span>
                </li>
                <li class="mobileToilet 10c0 <c:if test='${fn:indexOf(careCtgryList,"10c0") >= 0}'>active</c:if>">
                    <div class="img_area">
                        <img src="/html/page/app/matching/assets/src/images/02tool/tool02_12.svg" alt="이동변기">
                    </div>
                    <span class="txt">이동변기</span>
                </li>

                <li class="portableToilet 1060 <c:if test='${fn:indexOf(careCtgryList,"1060") >= 0}'>active</c:if>">
                    <div class="img_area">
                        <img src="/html/page/app/matching/assets/src/images/02tool/tool02_13.svg" alt="간이변기">
                    </div>
                    <span class="txt">간이변기</span>
                </li>
                <li class="inRunway 10d0 <c:if test='${fn:indexOf(careCtgryList,"10d0") >= 0}'>active</c:if>">
                    <div class="img_area">
                        <img src="/html/page/app/matching/assets/src/images/02tool/tool02_14.svg" alt="경사로">
                    </div>
                    <span class="txt">경사로</span>
                </li>
            </ul>


        </section>
    </main>

    <footer class="page-footer">

        <div class="relative">
            <c:if test="${isExistRecipientConslt}">
                <a class="waves-effect btn-large btn_primary w100p">상담내역 보기</a>
            </c:if>
            <c:if test="${!isExistRecipientConslt}">
                <a class="waves-effect btn-large btn_primary w100p">혜택 상담받기</a>
            </c:if>
            
        </div>

    </footer>


</div>

    <!-- modal_coun -->
    <div id="modal_coun" class="modal bottom-sheet">
 
        <div class="modal_header">
            <h4 class="modal_title">복지용구 소개</h4>
            <div class="close_x modal-close waves-effect"></div>
        </div>

        <div class="modal-content">

            <div class="scrollBox heightAuto" style="max-height: 75vh;">
                <div class="box_sub01">
                    <div class="img_area">
                        <img src="/html/page/app/matching/assets/src/images/01tool/tool01_01.svg" alt="보행기">
                    </div>
                    <div class="ctn_area">
                        <div class="font_sblb">성인용 보행기</div>

                        <p class="color_t_p font_sbmr">
                            걸어 다니기 불편하신 경우 실내·외에서 혼자서 이동할 수 있도록 도와드려요
                        </p>
                    </div>
                </div>
                <!-- box_sub01 -->

                <div class="box_sub01">
                    <div class="img_area">
                        <img src="/html/page/app/matching/assets/src/images/01tool/tool01_02.svg" alt="휠체어">
                    </div>
                    <div class="ctn_area">
                        <div class="font_sblb">수동휠체어</div>

                        <p class="color_t_p font_sbmr">
                            걸으실 수 없거나 장시간 걷기가 곤란한 경우 이동할 수 있도록 도와드려요
                        </p>
                    </div>
                </div>
                <!-- box_sub01 -->

                <div class="box_sub01">
                    <div class="img_area">
                        <img src="/html/page/app/matching/assets/src/images/01tool/tool01_03.svg" alt="지팡이">
                    </div>
                    <div class="ctn_area">
                        <div class="font_sblb">지팡이</div>

                        <p class="color_t_p font_sbmr">
                            걸어 다니기 불편한 경우 이동할 수 있도록 도와드려요
                        </p>
                    </div>
                </div>
                <!-- box_sub01 -->

                <div class="box_sub01">
                    <div class="img_area">
                        <img src="/html/page/app/matching/assets/src/images/01tool/tool01_04.svg" alt="안전손잡이">
                    </div>
                    <div class="ctn_area">
                        <div class="font_sblb">안전손잡이</div>

                        <p class="color_t_p font_sbmr">
                            앉거나 일어설 때 손잡이를 잡으면 안전하게 움직일 수 있어요
                        </p>
                    </div>
                </div>
                <!-- box_sub01 -->

                <div class="box_sub01">
                    <div class="img_area">
                        <img src="/html/page/app/matching/assets/src/images/01tool/tool01_05.svg" alt="미끄럼방지 매트">
                    </div>
                    <div class="ctn_area">
                        <div class="font_sblb">미끄럼방지 매트</div>

                        <p class="color_t_p font_sbmr">
                            미끄러지지 않도록 하여 미끄럼 사고를 예방해요
                        </p>
                    </div>
                </div>
                <!-- box_sub01 -->

                <div class="box_sub01">
                    <div class="img_area">
                        <img src="/html/page/app/matching/assets/src/images/01tool/tool01_06.svg" alt="미끄럼방지 양말">
                    </div>
                    <div class="ctn_area">
                        <div class="font_sblb">미끄럼방지 양말</div>

                        <p class="color_t_p font_sbmr">
                            실내에서 미끄러지지 않도록 도와드려요
                        </p>
                    </div>
                </div>
                <!-- box_sub01 -->

                <div class="box_sub01">
                    <div class="img_area">
                        <img src="/html/page/app/matching/assets/src/images/01tool/tool01_07.svg" alt="욕창예방매트리스">
                    </div>
                    <div class="ctn_area">
                        <div class="font_sblb">욕창예방매트리스</div>

                        <p class="color_t_p font_sbmr">
                            누워서 생활하는 어르신의 욕창 예방을 위해 체중을 분산 시키고 통풍을 원활하게 해요
                        </p>
                    </div>
                </div>
                <!-- box_sub01 -->

                <div class="box_sub01">
                    <div class="img_area">
                        <img src="/html/page/app/matching/assets/src/images/01tool/tool01_08.svg" alt="욕창예방방석">
                    </div>
                    <div class="ctn_area">
                        <div class="font_sblb">욕창예방방석</div>

                        <p class="color_t_p font_sbmr">
                            장시간 앉아 생활하는 어르신의 욕창 예방을 위해 체중을 분산 시키고 통풍을 원활하게 해요
                        </p>
                    </div>
                </div>
                <!-- box_sub01 -->

                <div class="box_sub01">
                    <div class="img_area">
                        <img src="/html/page/app/matching/assets/src/images/01tool/tool01_09.svg" alt="자세변환용구">
                    </div>
                    <div class="ctn_area">
                        <div class="font_sblb">자세변환용구</div>

                        <p class="color_t_p font_sbmr">
                            장시간 앉아 생활하는 어르신의 자세와 위치를 바꾸기 쉽도록 도와드려요
                        </p>
                    </div>
                </div>
                <!-- box_sub01 -->

                <div class="box_sub01">
                    <div class="img_area">
                        <img src="/html/page/app/matching/assets/src/images/01tool/tool01_10.svg" alt="요실금팬티">
                    </div>
                    <div class="ctn_area">
                        <div class="font_sblb">요실금팬티</div>

                        <p class="color_t_p font_sbmr">
                            요실금 증상이 있는 어르신이 쾌적한 일상생활을 할 수 있도록 도와드려요
                        </p>
                    </div>
                </div>
                <!-- box_sub01 -->

                <div class="box_sub01">
                    <div class="img_area">
                        <img src="/html/page/app/matching/assets/src/images/01tool/tool01_11.svg" alt="목욕의자">
                    </div>
                    <div class="ctn_area">
                        <div class="font_sblb">목욕의자</div>

                        <p class="color_t_p font_sbmr">
                            자세를 유지하도록 하여 편안하게 목욕을 할 수 있어요
                        </p>
                    </div>
                </div>
                <!-- box_sub01 -->

                <div class="box_sub01">
                    <div class="img_area">
                        <img src="/html/page/app/matching/assets/src/images/01tool/tool01_12.svg" alt="이동변기">
                    </div>
                    <div class="ctn_area">
                        <div class="font_sblb">이동변기</div>

                        <p class="color_t_p font_sbmr">
                            화장실로 이동하기 어려운 어르신이 용변을 쉽고 안전하게 볼 수 있도록 도와드려요
                        </p>
                    </div>
                </div>
                <!-- box_sub01 -->

                <div class="box_sub01">
                    <div class="img_area">
                        <img src="/html/page/app/matching/assets/src/images/01tool/tool01_13.svg" alt="간이변기">
                    </div>
                    <div class="ctn_area">
                        <div class="font_sblb">간이변기</div>

                        <p class="color_t_p font_sbmr">
                            누워서 생활하시거나 소변 조절이 어려운 어르신이 용변을 쉽고 안전하게 볼 수 있도록 도와드려요
                        </p>
                    </div>
                </div>
                <!-- box_sub01 -->

                <div class="box_sub01">
                    <div class="img_area">
                        <img src="/html/page/app/matching/assets/src/images/01tool/tool01_14.svg" alt="경사로">
                    </div>
                    <div class="ctn_area">
                        <div class="font_sblb">경사로</div>

                        <p class="color_t_p font_sbmr">
                            실·내외에서 수동휠체어 또는 성인용보행기 이용 시 편하고 안전하게 이동할 수 있어요
                        </p>
                    </div>
                </div>
                <!-- box_sub01 -->




            </div>
            <!-- scrollbox -->



            <div class="h32"></div>


        </div>
        <!-- modal-content -->

    </div>


<script>
    $(function () {

        //복지용구 선택
        $('.wel_select_area li').on('click', function () {

            if ($(this).hasClass('active') == true) {
                $(this).removeClass('active');
            }

            else {
                $(this).addClass('active');
            }

        });


        var popModal;
        $(".top .top_txt.addCustom1").on('click', function () {
            if (popModal == undefined){
                var elems = document.querySelectorAll("#modal_coun");
                var instances = M.Modal.init(elems, {
                        endingTop:'20%',
                        opacity: 0.6
                });
                popModal = instances[0];    
            }
            
            popModal.open();
        });
    });
</script>