<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%-- 고령친화 우수식품 컨텐츠 --%>

        <!-- 본문 영역 -->
        <div id="content">
            <div class="content-market-link is-food">
                <a href="${_marketPath }"><strong>이로움온 마켓</strong> 시니어만을 위한 맞춤 식품은 따로 있습니다</a>
            </div>

            <h2 class="content-food1">
                고령친화 우수식품
                <small>Senior Friendly Foods</small>
            </h2>

            <div class="content-food2">
                <div class="background"><div class="images"></div></div>
                <div class="content">
                    <p>시니어 세대의 입맛을 지켜주는 음식으로 </p>
                    <p class="bigs">
                        <strong class="t1">고령자의</strong><br>
                        <strong class="t1">신체적 특성을</strong><br>
                        <strong class="t3">고려해 만든 식품</strong>을
                    </p>
                    <p><strong>고령친화 식품</strong>이라고 합니다</p>
                </div>
            </div>
            <script>
                $(function() {
                    $(window).on('scroll', function() {
                        if($('.content-food2').get(0).getClientRects()[0].y + $('.content-food2').get(0).getClientRects()[0].height > 0) {
                            $('.content-food2 .images').css({'transform': 'translateY(' + ($(window).scrollTop() * -0.1) + 'px)'});
                        }
                    });
                })
            </script>

            <div class="content-food3">
                <h3 class="title">
                    <img src="/html/page/planner/assets/images/txt-content-food3.png" alt="고령친화우수식품 로고">
                    <strong>고령친화우수식품</strong> 표시 (출처 : 농림출산식품부)
                </h3>
                <div class="content">
                    <p>
                        단순히 부드럽거나 영양 성분이 좋다고 해서 고령친화식품으로 분류되지 않고, <br>
                        <strong>식품안전관리인증기준(HACCP)</strong>에 적합하거나<br>
                        <strong>건강기능식품 품목제조신고를 완료한 업체</strong>에서 생산해야 신청이 가능합니다.
                    </p>
                    <p>
                        관련 업체가 지정 신청을 요청하면 농림축산식품부 산하 <br>
                        <strong>한국식품산업클러스터진흥원</strong>이 적합 여부를 검토합니다.
                    </p>
                    <ol>
                        <li>
                            노인이 쉽게 <br>
                            섭취할 수 있는지
                        </li>
                        <li>
                            소화를 편안히 <br>
                            할 수 있는지
                        </li>
                        <li>
                            영양 성분은 <br>
                            적절한 지
                        </li>
                        <li>
                            안전하게 <br>
                            개봉할 수 있는지
                        </li>
                        <li>
                            KS 품질 기준에 <br>
                            적합한지
                        </li>
                    </ol>
                    <p>
                        지정 절차에 맞춰 검토하여 심사를 통과하면 <br>
                        이후부터 <strong>고령친화 우수식품</strong>이란 표현을 쓸 수 있게 됩니다.
                    </p>
                    <p>2021년 5월부터 처음으로 시행하여 2022년 현재 <strong>113개의 제품이 지정</strong>됐습니다.</p>
                </div>
            </div>

            <div class="content-food4">
                <div class="container">
                    <div class="title">
                        <p class="text1">우수식품의 종류는</p>
                        <p class="text2"><strong>총 3단계</strong>로</p>
                        <p class="text3"><span class="color1">물성 <sub>식감을 주는 성분</sub></span>과 <span class="color2">점성 <sub>음식이 흐르는 정도</sub></span>에 따라</p>
                        <p class="text4">나뉘어집니다.</p>
                    </div>
                    <div class="card card1">
                        <div class="rear"></div>
                        <div class="front">
                            <p class="name">
								영양 성분을 강화하고<br> 
								부드럽고 무른 음식으로<br> 
								고령자 치아로도 섭취가 편한<br> 
                                <em>“연하식”</em>
                            </p>
                            <a href="${_marketPath}/gds/34/list#48" class="link" target="_blank"><strong>연하식 1단계 식품</strong> 바로가기</a>
                        </div>
                    </div>
                    <div class="card card2">
                        <div class="rear"></div>
                        <div class="front">
                            <p class="name">
                                틀니나 잇몸으로도 <br>
                                씹기 쉬운 <em>“연화반찬류”</em>
                            </p>
                            <a href="${_marketPath}/gds/34/list#48" class="link" target="_blank"><strong>연화반찬류 식품</strong> 바로가기</a>
                        </div>
                    </div>
                    <div class="card card3">
                        <div class="rear"></div>
                        <div class="front">
                            <p class="name">
								죽처럼 부드럽게 만들어<br>
								고령자 사래 걸림 위험을 줄이고<br> 
								혀로 식사가 가능한 
                                <em>“유동식”</em>
                            </p>
                            <a href="${_marketPath}/gds/34/list#48" class="link" target="_blank"><strong>유동식 식품</strong> 바로가기</a>
                        </div>
                    </div>
                </div>
            </div>

            <div class="content-food5">
                <h2>
                    품질기준
                    <small>고령친화식품 한국산업표준(KS) 품질규격</small>
                </h2>
                <div class="hidden md:block">
                    <table>
                        <colgroup>
                            <col class="min-w-25 w-[13.25%]">
                            <col>
                            <col>
                            <col>
                        </colgroup>
                        <thead>
                            <tr>
                                <th scope="col"></th>
                                <th scope="col" class="title1"><p><img src="/html/page/planner/assets/images/txt-content-food5.png" alt="1단계 치아섭취"></p></th>
                                <th scope="col" class="title2"><p><img src="/html/page/planner/assets/images/txt-content-food5-2.png" alt="2단계 잇몸섭취"></p></th>
                                <th scope="col" class="title3"><p><img src="/html/page/planner/assets/images/txt-content-food5-3.png" alt="3단계 혀로섭취"></p></th>
                            </tr>
                        </thead>
                        <tbody>
                            <tr>
                                <th scope="row">경도<br> (N/㎡)</th>
                                <td>
                                    <p class="count"><i>500,000</i> 이하</p>
                                    <p class="count"><i>~ 50,000</i> 초과</p>
                                </td>
                                <td>
                                    <p class="count"><i>50,000</i> 이하</p>
                                    <p class="count"><i>~ 20,000</i> 초과</p>
                                </td>
                                <td>
                                    <p class="count"><i>~ 20,000</i> 이하</p>
                                </td>
                            </tr>
                            <tr>
                                <td colspan="4" class="desc"><strong>* 경도</strong>(단단한 정도) - 경도 수치가 낮을 수록 식품이 연하고 부드럽습니다.</td>
                            </tr>
                            <tr>
                                <th scope="row">영양성분</th>
                                <td>
                                    <dl class="labels">
                                        <dt>단백질</dt>
                                        <dd><i>6g / 100g</i> 이상</dd>
                                    </dl>
                                    <dl class="labels is-color1">
                                        <dt>비타민D</dt>
                                        <dd><i>1.5 μg / 100 g</i> 이상</dd>
                                    </dl>
                                    <dl class="labels">
                                        <dt>칼륨</dt>
                                        <dd><i>80 mg / 100 g</i> 이상</dd>
                                    </dl>
                                </td>
                                <td>
                                    <dl class="labels is-color2">
                                        <dt>비타민A</dt>
                                        <dd><i>75 μg RAE / 100 g</i> 이상</dd>
                                    </dl>
                                    <dl class="labels is-color3">
                                        <dt>리보플라빈</dt>
                                        <dd><i>0.15 mg / 100 g</i> 이상</dd>
                                    </dl>
                                    <dl class="labels">
                                        <dt>칼슘</dt>
                                        <dd><i>0.35 g / 100 g</i> 이상</dd>
                                    </dl>
                                </td>
                                <td>
                                    <dl class="labels is-color4">
                                        <dt>비타민C</dt>
                                        <dd><i>10 mg / 100 g</i> 이상</dd>
                                    </dl>
                                    <dl class="labels is-color5">
                                        <dt>나이아신</dt>
                                        <dd><i>1.6 mg NE / 100 g</i> 이상</dd>
                                    </dl>
                                    <dl class="labels is-color6">
                                        <dt>식이섬유</dt>
                                        <dd><i>2.5 g / 100 g</i> 이상</dd>
                                    </dl>
                                </td>
                            </tr>
                        </tbody>
                    </table>
                </div>
                <div class="block md:hidden">
                    <table>
                        <colgroup>
                            <col class="w-25">
                            <col>
                        </colgroup>
                        <thead>
                            <tr>
                                <th colspan="2" scope="col" class="title1"><p><img src="/html/page/planner/assets/images/txt-content-food5.png" alt="1단계 치아섭취"></p></th>
                            </tr>
                        </thead>
                        <tbody>
                            <tr>
                                <th scope="row">경도<br> (N/㎡)</th>
                                <td>
                                    <p class="count"><i>500,000</i> 이하</p>
                                    <p class="count"><i>~ 50,000</i> 초과</p>
                                </td>
                            </tr>
                            <tr>
                                <th scope="row">영양성분</th>
                                <td>
                                    <dl class="labels">
                                        <dt>단백질</dt>
                                        <dd><i>6g / 100g</i> 이상</dd>
                                    </dl>
                                    <dl class="labels is-color1">
                                        <dt>비타민D</dt>
                                        <dd><i>1.5 μg / 100 g </i> 이상</dd>
                                    </dl>
                                    <dl class="labels">
                                        <dt>칼륨</dt>
                                        <dd><i>80 mg / 100 g</i> 이상</dd>
                                    </dl>
                                </td>
                            </tr>
                        </tbody>
                    </table>
                    <table>
                        <colgroup>
                            <col class="w-25">
                            <col>
                        </colgroup>
                        <thead>
                            <tr>
                                <th scope="col" colspan="2" class="title2"><p><img src="/html/page/planner/assets/images/txt-content-food5-2.png" alt="2단계 잇몸섭취"></p></th>
                            </tr>
                        </thead>
                        <tbody>
                            <tr>
                                <th scope="row">경도<br> (N/㎡)</th>
                                <td>
                                    <p class="count"><i>50,000</i> 이하</p>
                                    <p class="count"><i>~ 20,000</i> 초과</p>
                                </td>
                            </tr>
                            <tr>
                                <th scope="row">영양성분</th>
                                <td>
                                    <dl class="labels is-color2">
                                        <dt>비타민A</dt>
                                        <dd><i>75 μg RAE / 100 g</i> 이상</dd>
                                    </dl>
                                    <dl class="labels is-color3">
                                        <dt>리보플라빈</dt>
                                        <dd><i>0.15 mg / 100 g</i> 이상</dd>
                                    </dl>
                                    <dl class="labels">
                                        <dt>칼슘</dt>
                                        <dd><i>0.35 g / 100 g</i> 이상</dd>
                                    </dl>
                                </td>
                            </tr>
                        </tbody>
                    </table>
                    <table>
                        <colgroup>
                            <col class="w-25">
                            <col>
                        </colgroup>
                        <thead>
                            <tr>
                                <th scope="col" colspan="2" class="title3"><p><img src="/html/page/planner/assets/images/txt-content-food5-3.png" alt="3단계 혀로섭취"></p></th>
                            </tr>
                        </thead>
                        <tbody>
                            <tr>
                                <th scope="row">경도<br> (N/㎡)</th>
                                <td>
                                    <p class="count"><i>~ 50,000</i> 이하</p>
                                </td>
                            </tr>
                            <tr>
                                <th scope="row">영양성분</th>
                                <td>
                                    <dl class="labels is-color4">
                                        <dt>비타민C</dt>
                                        <dd><i>10 mg / 100 g</i> 이상</dd>
                                    </dl>
                                    <dl class="labels is-color5">
                                        <dt>나이아신</dt>
                                        <dd><i>1.6 mg NE / 100 g</i> 이상</dd>
                                    </dl>
                                    <dl class="labels is-color6">
                                        <dt>식이섬유</dt>
                                        <dd><i>2.5 g / 100 g</i> 이상</dd>
                                    </dl>
                                </td>
                            </tr>
                        </tbody>
                    </table>
                    <p class="desc mt-3"><strong>* 경도</strong>(단단한 정도) - 경도 수치가 낮을 수록 식품이 연하고 부드럽습니다.</p>
                </div>
            </div>

            <div class="content-golink">
                <!-- <a href="#" class="market">
                    <span class="base"></span>
                    <span class="expand">
                        이로움 마켓
                    </span>
                </a> -->
                <a href="https://silver.bokji24.com/find/step2-1" target="_blank" class="test">
                    <span class="front">
                        <small>E·ROUM</small>
                        <strong>TEST</strong>
                    </span>
                    <span class="rear">
                        <small>장기요양등급</small>
                        <strong>테스트</strong>
                    </span>
                </a>
                <a href="#page-container" class="gotop"><span class="sr-only">위로 이동</span></a>
            </div>
        </div>
        <!-- //본문 영역 -->