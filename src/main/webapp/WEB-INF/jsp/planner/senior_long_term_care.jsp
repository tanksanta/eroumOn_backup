<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%-- 장기요양보험 컨텐츠 --%>

		<!-- 본문 영역 -->
        <div id="content">
            <div class="content-market-link">
                <a href="${_marketPath}"><strong>이로움온 마켓</strong> 복지용구부터 시니어 생활용품까지 한번에!</a>
            </div>

            <h2 class="content-insurance1">
                <span class="background"><span class="images"></span></span>
                노인장기요양보험
                <small>Senior Long Term Care</small>
            </h2>
            <script>
                $(function() {
                    $(window).on('scroll', function() {
                        if($('.content-insurance1').get(0).getClientRects()[0].y + $('.content-insurance1').get(0).getClientRects()[0].height > 0) {
                            $('.content-insurance1 .images').css({'transform': 'translateY(' + ($(window).scrollTop() * -0.1) + 'px)'});
                        }
                    });
                })
            </script>

            <div class="content-insurance2">
                <h2 class="title">
                    <small>노인장기요양보험을 통해서</small>
                    누릴 수 있는 혜택은
                </h2>
                <div class="card">
                    <div class="card-item is-card1">
                        <div class="item-front">
                            <div class="front-content">
                                <p class="benefit">
                                    <span>지원혜택</span>
                                    <em>01</em>
                                </p>
                                <p class="name">복지용구 구매/대여 비용 지원</p>
                                <p class="desc">"연간 1,600,000원"</p>
                                <a href="${_marketPath}" class="market">
                                    <strong>이로움 마켓</strong>
                                    복지용구부터 시니어 생활용품까지 한번에!
                                </a>
                            </div>
                        </div>
                        <div class="item-rear">
                            <p>
                                거동이 불편한 어르신의 생활에<br>
                                도움드리는 <strong><span>복지용구 지원</span></strong>
                            </p>
                            <p class="img1"><img src="/html/page/planner/assets/images/img-content-insurance2.png" alt=""></p>
                        </div>
                        <div class="item-toggle">
                            <button type="button"><span class="sr-only">펼치기/접기</span></button>
                        </div>
                    </div>
                    <div class="card-item is-card2">
                        <div class="item-front">
                            <div class="front-content">
                                <p class="benefit">
                                    <span>지원혜택</span>
                                    <em>02</em>
                                </p>
                                <p class="name">돌봄/주야간 보호 서비스 비용 지원</p>
                                <p class="desc">"최대 1,885,000원"</p>
                            </div>
                        </div>
                        <div class="item-rear">
                            <p>
                                요양보호사가 생활공간에서<br>
                                다양한 도움드리는 <strong><span>재가돌봄 지원</span></strong>
                            </p>
                            <p class="img1"><img src="/html/page/planner/assets/images/img-content-insurance2-2.png" alt=""></p>
                            <p>
                                또래 사람들과 다양한 활동을 통해<br>
                                신체 재활을 도와드리는 <strong><span>주야간 보호 돌봄 지원</span></strong>
                            </p>
                            <p class="img2"><img src="/html/page/planner/assets/images/img-content-insurance2-3.png" alt=""></p>
                        </div>
                        <div class="item-toggle">
                            <button type="button"><span class="sr-only">펼치기/접기</span></button>
                        </div>
                    </div>
                    <div class="card-item is-card3">
                        <div class="item-front">
                            <div class="front-content">
                                <p class="benefit">
                                    <span>지원혜택</span>
                                    <em>03</em>
                                </p>
                                <p class="name">시설/요양원 입소 비용 지원</p>
                                <p class="desc">"1일 81,750원"</p>
                                <p class="summary">* 입원 목적에 따라 요양병원(의료기관, 치료적 의료서비스)과 요양원(돌봄)의 차이가 다릅니다.</p>
                            </div>
                        </div>
                        <div class="item-rear">
                            <p>
                                상당한 장애가 발생하여 도움이 필요한<br>
                                어르신에게 가정집과 같은 주거여건을 갖춘<br>
                                <strong><span>노인요양공동생활가정 지원</span></strong>
                            </p>
                            <p class="img1"><img src="/html/page/planner/assets/images/img-content-insurance2-4.png" alt=""></p>
                            <p>
                                거동이 불편한 어르신의 식사 관리부터<br>
                                상시 옆에서 케어가 필요한 서비스를 갖춘<br>
                                <strong><span>요양원 지원</span></strong>
                            </p>
                            <p class="img2"><img src="/html/page/planner/assets/images/img-content-insurance2-5.png" alt=""></p>
                        </div>
                        <div class="item-toggle">
                            <button type="button"><span class="sr-only">펼치기/접기</span></button>
                        </div>
                    </div>
                    <div class="card-item is-card4">
                        <div class="item-front">
                            <div class="front-content">
                                <p class="benefit">
                                    <span>지원혜택</span>
                                    <em>04</em>
                                </p>
                                <p class="name">수급자 보호자를 위한 비용 지원</p>
                                <p class="desc">"치매 가족 휴가제로 연간 최대 8일"</p>
                            </div>
                        </div>
                        <div class="item-rear">
                            <p>
                                치매 등 어르신 보호에 지친 보호자를 위해<br>
                                치매 가족 휴가제로 한도액 상관없이<br>
                                <strong><span>연간 8일간 주야간 센터 단기보호,</span></strong><br>
                                <strong><span>종일 방문요양(생활공간) 지원</span></strong>
                            </p>
                            <p class="img1"><img src="/html/page/planner/assets/images/img-content-insurance2-6.png" alt=""></p>
                        </div>
                        <div class="item-toggle">
                            <button type="button"><span class="sr-only">펼치기/접기</span></button>
                        </div>
                    </div>
                </div>
                <a href="${_marketPath}" class="link">
                    <strong>이로움 마켓</strong>
                    복지용구부터 시니어 생활용품까지 한번에!
                </a>
            </div>

            <div class="content-insurance3">
                <div class="container">
                    <h2 class="title">
                        노인 장기요양보험은
                        <img src="/html/page/planner/assets/images/img-content-insurance3.png" alt="">
                    </h2>
                    <div class="content">
                        4대 보험 외에 정부에서 지원해주는 사회보장제도로<br>
                        거동이 불편한 65세 이상 노인이거나 치매, 뇌혈관성 질환 등<br>
                        노인성 질환을 가지고 있는 사람들에게 제공되는 사회보험 서비스로서<br>
                        대부분의 국가에서는 경제발전과 보건의료의 발달로 인한<br>
                        평균수명의 연장, 자녀에 대한 가치관의 변화, 보육 및 교육 등으로<br>
                        출산율이 급격히 저하되어 인구구조의 급격한 고령화 문제에 직면하고 있으며,<br>
                        이러한 사회변화에 따른 새로운 복지 수요를 충족하기 위한 것입니다.
                        <br><br>
                        인구 고령화, 노인성 질병 증가로 인해<br>
                        <strong>부양가족들의 부담으로 인식되던 장기 요양 문제</strong>가<br>
                        더 이상 개인과 가게의 부담이 아닌 국가적인 책무로 인식되어 도입된<br>
                        사회보험제도로 <strong>가족과 국민의 삶의 질을 향상시키고</strong><br>
                        노인 장기요양보험 관련 <strong>일자리를 창출시켜 경제 전반에 도움</strong>이 되고 있습니다.
                    </div>
                </div>
                <p class="summary">이러한 혜택을 받기 위해서는 인정절차를 받으셔야 합니다.</p>
            </div>

            <div class="content-insurance4">
                <h2 class="title">
                    <strong>노인장기요양보험<br>인정 절차</strong>
                    <small>
                        간략하게 살펴보면<br>
                        6단계를 통해 등급을 받으시면<br>
                        노인장기요양보험 지원을 받으실 수 있습니다.
                    </small>
                </h2>
                <ol class="step">
                    <li>인정신청</li>
                    <li>인정조사</li>
                    <li>의사소견서 제출</li>
                    <li>등급판정</li>
                    <li>결과통보</li>
                    <li>이용상담</li>
                </ol>
                <div class="notice">
                    신청대상은 <strong>만65세이상</strong> 또는 <strong>만65세 미만이라도 노인성질병( 치매, 뇌혈관 질환, 파킨슨 병 등 )을 가진 분</strong>들입니다.<br>
                    인정신청은 가족, 친족 또는 이해관계인, 사회 복지 관련자 모두에게 열려 있습니다.<br>
                    신청을 하면 건강보험공단 직원이 방문하여 <strong>일상생활활동, 인지기능, 행동변화, 간호 처치,</strong><br>
                    <strong>재활영역 각항목</strong>에 대한 신청인의 상태를 조사하게 됩니다.<br>
                    또한 신청인에 대한 의사소견서를 요청하게 되며, 의사소견서가 제출되면 등급판정위원회에서 등급판정을 합니다.<br>
                    이러한 과정을 통하여 등급이 나오면 혜택을 받을 수 있는 수급자가 됩니다.
                    <br><br>
                    인정조사시 사용하는 점검표에 의한 등급 산정 예시를 아래와 같이 사전 점검해 볼 수 있습니다.
                </div>
            </div>

            <div class="content-insurance5">
                <p class="cont1">
                    지금 <strong>이로움테스트</strong>를 통해<br>
                    인정 등급의 사전 점검을 해 보시고 신청하십시오.
                </p>
                <div class="cont2">
                    <div class="box">
                        <img src="/html/page/planner/assets/images/img-content-insurance5.png" alt="장기요양예상등급 이로움테스트">
                        <a href="/find/step2-1" target="_blank"><span class="sr-only">테스트 바로시작</span></a>
                    </div>
                </div>
                <p class="cont3">장기요양보험 인정 신청은 아래 대표 번호에 자세한 내용을 문의해보시고 지금 바로 신청해보세요.</p>
                <dl class="cont4">
                    <dt>접수기관 및 <br> 문의처</dt>
                    <dd>
                        <ol>
                            <li>1. 국민건강보험공단 장기요양보험 운영센터 <a href="tel:1577-1000">1577-1000</a> 이나 가까운 건강보험공단</li>
                            <li>2. 복지용구사업소나 가까운 장기요양기관</li>
                        </ol>
                    </dd>
                </dl>
            </div>

            <script>
                $(function() {
                    if(Math.round(Math.random()) > 0) {
                        $('.content-market-link').addClass('is-insurance');
                        $('.content-insurance1').addClass('is-subvisual');
                    }

                    $('.card-item').on('click', function() {
                        $(this).addClass('is-active');
                    })

                    $('.item-toggle button').on('click', function(e) {
                        e.stopPropagation();
                        $(this).closest('.card-item').toggleClass('is-active');
                    })
                })
            </script>
        </div>
        <!-- //본문 영역 -->