<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<header id="subject">
    <nav class="breadcrumb">
        <ul>
			<li class="home"><a href="${_mainPath}">홈</a></li>
			<li>이로움 서비스</li>
            <li>수급자 요양정보</li>
        </ul>
    </nav>

    <!--팝업작업 후 삭제-->
    <!--
    <div class="mt-6">
        <a href="#" class="btn" data-bs-toggle="modal" data-bs-target="#pop-consulting">
            <strong>알림</strong>
        </a>
        <a href="#" class="btn" data-bs-toggle="modal" data-bs-target="#pop-consulting-info">
            <strong>L번호가 있는 수급자의 경우 : 상담정보확인</strong>
        </a>
        <a href="#" class="btn" data-bs-toggle="modal" data-bs-target="#pop-consulting-complated">
            <strong>상담확인</strong>
        </a>
    </div>
    -->

	<h2 class="subject">
		수급자 요양정보
		<small>올해 남은 급여 금액을 확인 후 복지 혜택 상담을 신청해보세요</small>
	</h2>
</header>

<div id="content">
    <div class="mx-auto max-w-[800px]">
        <!--조회영역 삭제-->
        <!-- 
        <form class="careinfo-search">
            <fieldset>
                <legend class="sr-only">요양정보 검색</legend>
                <div class="field">
                    <dl>
                        <dt><label for="recipter">이름</label></dt>
                        <dd><input type="text" id="recipter" name="recipter" class="form-control" value="김한걸" disabled></dd>
                    </dl>
                    <dl>
                        <dt><label for="rcperRcognNo">요양인정번호</label></dt>
                        <strong>L</strong>&nbsp;<dd><input type="text" id="rcperRcognNo" name="rcperRcognNo" class="form-control" value="1604015680" maxlength="10"></dd>
                    </dl>
                </div>
                <button type="button" class="btn btn-large btn-primary3 f_recipterCheck">조회하기</button>
            </fieldset>
        </form>
         -->
         
        <input type="hidden" id="recipter" name="recipter" value="${recipientsNm}">
        <input type="hidden" id="rcperRcognNo" name="rcperRcognNo" value="${rcperRcognNo}">

        <div class="careinfo-mask <c:if test="${_mbrSession.loginCheck && !empty recipter && !empty rcperRcognNo}">is-active</c:if>">

			<c:if test="${_mbrSession.loginCheck == false}">
                <div class="careinfo-layer">
                    <strong>요양정보간편조회가 궁금하시다면</strong>
                    <a href="${_membershipPath}/login?returnUrl=/main/recipter/list&headerType=info" class="btn btn-large">간편 로그인/회원가입</a>
                </div>
			</c:if>

            <div class="careinfo-myinfo recipter_view">
                <div class="careinfo-myinfo-inner">
                    <p class="careinfo-title mb-0">
                        <span class="blurring"><span class="searchNm"><span class="mask"></span>이로미</span>
                        (<span class="searchNo">123456789</span>)</span> &nbsp;님의 요양정보
                    </p>
                    <div class="flex items-end justify-end gap-3">
                        <span class="text-sm text-black2/50" id="refleshDate">2000년 01월 01일 11:11:11</span>
                        
                        <!-- 요양정보 저장기능 구현전 까지 다시조회버튼 숨김 -->
                        <!-- <button class="btn-lightgrey" onclick="clickReSearchBtn();">다시 조회하기 <i class="icon-refresh"></i></button> -->
                    </div>
                </div>
                <div class="myinfo-wrapper">
                    <div class="myinfo-box1">
                        <p class="name" ><span class="blurring2"><span class="mask"></span><span class="searchNm">이로미</span></span>&nbsp; 님
                            <c:if test="${_mbrSession.loginCheck}">
                                <a href="/membership/info/recipients/view?recipientsNo=${recipientsNo}">정보수정</a>
                            </c:if>
                        </p>
                        <dl class="numb">
                            <dt class="desc">요양인정번호</dt>
                            <dd class="searchNo"><span class="blurring2"><span class="mask"></span>L123456789</span></dd>
                        </dl>
                        <dl class="date">
                            <dt class="desc">인정 유효기간</dt>
                            <dd id="searchRcgt">
                                <span class="blurring2"><span class="mask"></span>2023년 1월 1일 ~2023년 12월 31일</span>
                            </dd>
                        </dl>
                        <dl class="date">
                            <dt class="desc">적용기간</dt>
                            <dd id="searchBgngApdt">
                                <span class="blurring2"><span class="mask"></span>2023년 1월 1일 ~2023년 12월 31일</span>
                            </dd>
                        </dl>
                    </div>
                    <div class="myinfo-box2">
                        <p class="desc">잔여급여</p>
                        <p class="cost"><span class="blurring2"><span class="mask"></span><strong id="searchRemn">1,250,000</strong>원</span></p>
                        <dl class="used1">
                            <dt class="desc">사용</dt>
                            <dd class="percent">
                                <div class="track">
                                    <div class="bar" id="useAmtBar"></div>
                            </div>
                            <div class="won" id="searchUseAmt"><span class="blurring2"><span class="mask"></span>350,000원</span></div>
                        </dd>
	                    </dl>
	                    <dl class="used2">
	                        <dt class="desc">총 급여</dt>
	                        <dd class="percent">
	                            <div class="track">
	                                <div class="bar" id="setAmtBar"></div>
	                            </div>
	                            <div class="won" id="searchLimit"><span class="blurring2"><span class="mask"></span>1,600,000원</span></div>
	                        </dd>
	                    </dl>
	                </div>
	                <div class="myinfo-box3">
	                    <p class="desc">인정등급</p>
	                    <p class="cost"><span class="blurring"><span class="mask"></span><strong id="searchGrade">15</strong></span>등급</p>
	                    <p class="desc">제품가 최소 85% 지원</p>
	                </div>
	                <div class="myinfo-box4">
	                    <p class="name">본인부담율</p>
	                    <p class="cost"><span class="blurring"><span class="mask"></span><strong id="searchQlf">15</strong></span>%</p>
	                    <p class="desc">월 141만원내에서<br> 요양보호사 신청 가능</p>
	                </div>
	        	</div>
            </div>

            <div class="careinfo-status recipter_view">
                <h3 class="careinfo-title">나의 복지용구 현황</h3>
                <div class="status-swiper">
                    <div class="swiper">
                        <div class="swiper-wrapper own_view">
                            <div class="swiper-slide swiper-item1">
                                <strong>성인용 보행기</strong>
                                <i></i>
                                <dl>
                                    <dt>계약완료</dt>
                                    <dd class="finwalkerForAdults"><span class="blurring"><span class="mask"></span>0</span></dd>
                                </dl>
                                <dl>
                                    <dt>구매예상</dt>
                                    <dd class="buywalkerForAdults" ><span class="blurring2"><span class="mask"></span>${apiVO.walkerForAdults}</span></dd>
                                </dl>
                            </div>
                            <div class="swiper-slide swiper-item2">
                                <strong>수동휠체어</strong>
                                <i></i>
                                <dl>
                                    <dt>계약완료</dt>
                                    <dd class="finwheelchair"><span class="blurring2"><span class="mask"></span>0</span></dd>
                                </dl>
                                <dl>
                                    <dt>구매예상</dt>
                                    <dd class="buywheelchair"><span class="blurring2"><span class="mask"></span>${apiVO.wheelchair}</span></dd>
                                </dl>
                            </div>
                            <div class="swiper-slide swiper-item3">
                                <strong>지팡이</strong>
                                <i></i>
                                <dl>
                                    <dt>계약완료</dt>
                                    <dd class="fincane"><span class="blurring2"><span class="mask"></span>0</span></dd>
                                </dl>
                                <dl>
                                    <dt>구매예상</dt>
                                    <dd class="buycane"><span class="blurring2"><span class="mask"></span>${apiVO.cane}</span></dd>
                                </dl>
                            </div>
                            <div class="swiper-slide swiper-item4">
                                <strong>안전손잡이</strong>
                                <i></i>
                                <dl>
                                    <dt>계약완료</dt>
                                    <dd class="finsafetyHandle"><span class="blurring2"><span class="mask"></span>0</span></dd>
                                </dl>
                                <dl>
                                    <dt>구매예상</dt>
                                    <dd class="buysafetyHandle"><span class="blurring2"><span class="mask"></span>${apiVO.safetyHandle}</span></dd>
                                </dl>
                            </div>
                            <div class="swiper-slide swiper-item5">
                                <strong>미끄럼방지 용품</strong>
                                <i></i>
                                <dl>
                                    <dt>계약완료</dt>
                                    <dd class="finantiSlipProduct"><span class="blurring2"><span class="mask"></span>0</span></dd>
                                </dl>
                                <dl>
                                    <dt>구매예상</dt>
                                    <dd class="buyantiSlipProduct"><span class="blurring2"><span class="mask"></span>${apiVO.antiSlipProduct}</span></dd>
                                </dl>
                            </div>
                            <!-- <div class="swiper-slide swiper-item6">
                                <strong>미끄럼방지 양말</strong>
                                <i></i>
                                <dl>
                                    <dt>계약완료</dt>
                                    <dd>1</dd>
                                </dl>
                                <dl>
                                    <dt>구매예상</dt>
                                    <dd>0</dd>
                                </dl>
                            </div> -->
                            <div class="swiper-slide swiper-item7">
                                <strong>욕창예방 매트리스</strong>
                                <i></i>
                                <dl>
                                    <dt>계약완료</dt>
                                    <dd class="finmattress"><span class="blurring2"><span class="mask"></span>0</span></dd>
                                </dl>
                                <dl>
                                    <dt>구매예상</dt>
                                    <dd class="buymattress"><span class="blurring2"><span class="mask"></span>${apiVO.mattress}</span></dd>
                                </dl>
                            </div>
                            <div class="swiper-slide swiper-item8">
                                <strong>욕창예방 방석</strong>
                                <i></i>
                                <dl>
                                    <dt>계약완료</dt>
                                    <dd class="fincushion"><span class="blurring2"><span class="mask"></span>0</span></dd>
                                </dl>
                                <dl>
                                    <dt>구매예상</dt>
                                    <dd class="buycushion"><span class="blurring2"><span class="mask"></span>${apiVO.cushion}</span></dd>
                                </dl>
                            </div>
                            <div class="swiper-slide swiper-item9">
                                <strong>자세변환용구</strong>
                                <i></i>
                                <dl>
                                    <dt>계약완료</dt>
                                    <dd class="finchangeTool"><span class="blurring2"><span class="mask"></span>0</span></dd>
                                </dl>
                                <dl>
                                    <dt>구매예상</dt>
                                    <dd class="buychangeTool"><span class="blurring2"><span class="mask"></span>${apiVO.changeTool}</span></dd>
                                </dl>
                            </div>
                            <div class="swiper-slide swiper-item10">
                                <strong>요실금 팬티</strong>
                                <i></i>
                                <dl>
                                    <dt>계약완료</dt>
                                    <dd class="finpanties"><span class="blurring2"><span class="mask"></span>0</span></dd>
                                </dl>
                                <dl>
                                    <dt>구매예상</dt>
                                    <dd class="buypanties"><span class="blurring2"><span class="mask"></span>${apiVO.panties}</span></dd>
                                </dl>
                            </div>
                            <div class="swiper-slide swiper-item11">
                                <strong>목욕의자</strong>
                                <i></i>
                                <dl>
                                    <dt>계약완료</dt>
                                    <dd class="finbathChair"><span class="blurring2"><span class="mask"></span>0</span></dd>
                                </dl>
                                <dl>
                                    <dt>구매예상</dt>
                                    <dd class="buybathChair"><span class="blurring2"><span class="mask"></span>${apiVO.bathChair}</span></dd>
                                </dl>
                            </div>
                            <div class="swiper-slide swiper-item12">
                                <strong>이동변기</strong>
                                <i></i>
                                <dl>
                                    <dt>계약완료</dt>
                                    <dd class="finmobileToilet"><span class="blurring2"><span class="mask"></span>0</span></dd>
                                </dl>
                                <dl>
                                    <dt>구매예상</dt>
                                    <dd class="buymobileToilet"><span class="blurring2"><span class="mask"></span>${apiVO.mobileToilet}</span></dd>
                                </dl>
                            </div>
                            <div class="swiper-slide swiper-item13">
                                <strong>간이변기</strong>
                                <i></i>
                                <dl>
                                    <dt>계약완료</dt>
                                    <dd class="finportableToilet"><span class="blurring2"><span class="mask"></span>0</span></dd>
                                </dl>
                                <dl>
                                    <dt>구매예상</dt>
                                    <dd class="buyportableToilet"><span class="blurring2"><span class="mask"></span>${apiVO.portableToilet}</span></dd>
                                </dl>
                            </div>
                            <div class="swiper-slide swiper-item15">
                                <strong>경사로(실외용)</strong>
                                <i></i>
                                <dl>
                                    <dt>계약완료</dt>
                                    <dd class="finoutRunway"><span class="blurring2"><span class="mask"></span>0</span></dd>
                                </dl>
                                <dl>
                                    <dt>구매예상</dt>
                                    <dd class="buyoutRunway"><span class="blurring2"><span class="mask"></span>${apiVO.outRunway}</span></dd>
                                </dl>
                            </div>
                            <div class="swiper-slide swiper-item14">
                                <strong>경사로(실내용)</strong>
                                <i></i>
                                <dl>
                                    <dt>계약완료</dt>
                                    <dd class="fininRunway"><span class="blurring2"><span class="mask"></span>0</span></dd>
                                </dl>
                                <dl>
                                    <dt>구매예상</dt>
                                    <dd class="buyinRunway"><span class="blurring2"><span class="mask"></span>${apiVO.inRunway}</span></dd>
                                </dl>
                            </div>
                            <div class="swiper-slide swiper-item16">
                                <strong>전동침대</strong>
                                <i></i>
                                <dl>
                                    <dt>계약완료</dt>
                                    <dd class="finelectricBed"><span class="blurring2"><span class="mask"></span>0</span></dd>
                                </dl>
                                <dl>
                                    <dt>구매예상</dt>
                                    <dd class="buyelectricBed"><span class="blurring2"><span class="mask"></span>${apiVO.electricBed}</span></dd>
                                </dl>
                            </div>
                            <div class="swiper-slide swiper-item17">
                                <strong>수동침대</strong>
                                <i></i>
                                <dl>
                                    <dt>계약완료</dt>
                                    <dd class="finmanualBed"><span class="blurring2"><span class="mask"></span>0</span></dd>
                                </dl>
                                <dl>
                                    <dt>구매예상</dt>
                                    <dd class="buymanualBed"><span class="blurring2"><span class="mask"></span>${apiVO.manualBed}</span></dd>
                                </dl>
                            </div>
                            <div class="swiper-slide swiper-item18">
                                <strong>이동욕조</strong>
                                <i></i>
                                <dl>
                                    <dt>계약완료</dt>
                                    <dd class="finbathtub"><span class="blurring2"><span class="mask"></span>0</span></dd>
                                </dl>
                                <dl>
                                    <dt>구매예상</dt>
                                    <dd class="buybathtub"><span class="blurring2"><span class="mask"></span>${apiVO.bathtub}</span></dd>
                                </dl>
                            </div>
                            <div class="swiper-slide swiper-item19">
                                <strong>목욕리프트</strong>
                                <i></i>
                                <dl>
                                    <dt>계약완료</dt>
                                    <dd class="finbathLift"><span class="blurring2"><span class="mask"></span>0</span></dd>
                                </dl>
                                <dl>
                                    <dt>구매예상</dt>
                                    <dd class="buybathLift"><span class="blurring2"><span class="mask"></span>${apiVO.bathLift}</span></dd>
                                </dl>
                            </div>
                            <div class="swiper-slide swiper-item20">
                                <strong>배회감지기</strong>
                                <i></i>
                                <dl>
                                    <dt>계약완료</dt>
                                    <dd class="findetector"><span class="blurring2"><span class="mask"></span>0</span></dd>
                                </dl>
                                <dl>
                                    <dt>구매예상</dt>
                                    <dd class="buydetector"><span class="blurring2"><span class="mask"></span>${apiVO.detector}</span></dd>
                                </dl>
                            </div>
                        </div>
                    </div>
                    <div class="swiper-button-prev"></div>
                    <div class="swiper-button-next"></div>
                </div>

                <div class="collapse" id="collapse-agree1">
                    <h4 class="status-title">복지용구 상세 현황</h4>
                    <table class="status-table">
                        <caption class="hidden">복지용구 품목명, 계약완료상태, 구매예상 표입니다</caption>
                        <colgroup>
                            <col class="min-w-10 w-[15%]">
                            <col>
                            <col class="min-w-16 w-1/5">
                            <col class="min-w-16 w-1/5">
                        </colgroup>
                        <thead>
                            <tr>
                                <th scope="col">No</th>
                                <th scope="col">품목명</th>
                                <th scope="col">계약완료</th>
                                <th scope="col">구매예상</th>
                            </tr>
                        </thead>
                        <tbody class="sale_return">
                        </tbody>
                    </table>

                    <h4 class="status-title">대여 복지용구 상세 현황</h4>
                    <table class="status-table">
                        <caption class="hidden">대여 복지용구 품목명, 계약완료상태, 구매예상 표입니다</caption>
                        <colgroup>
                            <col class="min-w-10 w-[15%]">
                            <col>
                            <col class="min-w-16 w-1/5">
                            <col class="min-w-16 w-1/5">
                        </colgroup>
                        <thead>
                            <tr>
                                <th scope="col">No</th>
                                <th scope="col">품목명</th>
                                <th scope="col">계약완료</th>
                                <th scope="col">구매예상</th>
                            </tr>
                        </thead>
                        <tbody  class="lend_return">
                        </tbody>
                    </table>
                    <div style="text-align: center; margin-top: 5px;">※ 위 내용은 데이터 조회 시점에 따라 <strong style="text-decoration: underline;">실제와 다를 수 있으니 참고용</strong>으로만 사용해주세요.</div>
                </div>

                <button type="button" class="btn status-toggle" data-bs-target="#collapse-agree1" data-bs-toggle="collapse" aria-expanded="false">상세열기</button>
            </div>
        </div>

        <div class="market-banner">
            <strong>
                부모님 맞춤 상품이 필요하세요?​
                <small>복지용구부터 시니어 생활용품까지 한 번에</small>
            </strong>
			<a href="${_marketPath}">지금 둘러보기</a>
        </div>

        <div class="careinfo-content">
            <div class="content-item1">
                <dl>
                    <dt>신청방법부터<br> 등급별 혜택까지</dt>
                    <dd>노인장기요양보험,<br> 차근차근 배워보세요</dd>
                </dl>
                <div>
                    <img src="/html/page/index/assets/images/img-careinfo-content1.png" alt="">
					<a href="${_mainPath}/cntnts/page1" class="btn btn-outline-primary2 btn-arrow"><strong>쉽게 알아보기</strong></a>
                </div>
            </div>
            <div class="content-item2">
                <dl>
                    <dt>부모님의 생활을<br> 한층 편하게</dt>
                    <dd>삶의 질을 높여주는<br> 복지용구, 소개해드릴게요</dd>
                </dl>
                <div>
                    <img src="/html/page/index/assets/images/img-careinfo-content2.png" alt="">
					<a href="${_mainPath}/cntnts/page2" class="btn btn-outline-primary3 btn-arrow"><strong>복지용구 알아보기</strong></a>
                </div>
            </div>
            <div class="content-item3">
                <dl>
                    <dt>똑똑하게<br> 복지용구 선택하기</dt>
                    <dd>부모님을 위한 복지용구,<br> 아무거나 고를 순 없어요</dd>
                </dl>
                <div>
                    <img src="/html/page/index/assets/images/img-careinfo-content3.png" alt="">
					<a href="${_mainPath}/cntnts/page3" class="btn btn-outline-primary2 btn-arrow"><strong>복지용구 선택하기</strong></a>
                </div>
            </div>
        </div>

        <div class="text-center text-xl mt-12">
            <span class="text-hightlight-blue font-bold">올해 남은 급여 금액</span>을 확인 후 <br>
            복지 혜택 <span class="text-hightlight-blue font-bold">상담을 신청해보세요</span>
    	</div>

        <a href="#" class="grade-floating consulting" onclick="clickStartConsltBtn();">
            <strong>상담하기</strong>
        </a>

        <!--상담하기 팝업소스-->
        <div class="modal modal-index fade" id="modal-my-consulting" tabindex="-1" aria-hidden="true">
            <div class="modal-dialog modal-dialog-centered">
                <div class="modal-content">
                <div class="modal-header">
                    <h2 class="text-title">알림</h2>
                    <button data-bs-dismiss="modal" class="btn-close">모달 닫기</button>
                </div>
                <div class="modal-body">
                    <div class="modal-bg-wrap">
                        <div class="text-center text-xl">
                            진행중인 요양정보 상담이 있습니다.<br>
                            상담 내역을 확인하시겠습니까?
                        </div>
                    </div>
                </div>
                <div class="modal-footer gap-1">
                    <button type="button" class="btn btn-primary large w-[52.5%]" onclick="location.href='/membership/conslt/appl/list'">상담내역 확인하기</button>
                    <button type="button" class="btn btn-outline-primary large w-[47.5%] md:whitespace-nowrap" onclick="openNewConsltInfo();">새롭게 진행하기</button>
                </div>
                </div>
            </div>
        </div>

        <!--L번호가 있는 수급자의 경우 : 상담정보확인-->
        <div class="modal modal-index fade" id="modal-consulting-info" tabindex="-1" aria-hidden="true">
            <div class="modal-dialog modal-dialog-centered modal-lg">
                <div class="modal-content">
                <div class="modal-header">
                    <h2 class="text-title">상담 정보 확인</h2>
                    <button data-bs-dismiss="modal" class="btn-close">모달 닫기</button>
                </div>
                <div class="modal-body">
                    <div class="text-subtitle -mb-4">
                        <i class="icon-alert"></i>
                        <p>회원이 이용약관에 따라 수급자 등록과 관리하는 것에 동의합니다</p>
                    </div>
                    <table class="table-detail">
                        <caption class="hidden">상담정보확인 위한 수급자와의 관계(필수), 수급자성명(필수), 요양인정번호, 상담받을연락처(필수), 실거주지 주소(필수), 생년월일(필수),성별(필수), 상담유형 입력폼입니다 </caption>
                        <colgroup>
                            <col class="w-22 xs:w-32">
                            <col>
                        </colgroup>
                        <tbody>
                            <tr class="wrapRelation">
                                <tr class="top-border">
                                    <td></td>
                                    <td></td>
                                </tr>
                                <th scope="row">
                                    <p>
                                        <label for="recipter">수급자와의 관계<sup class="text-danger text-base md:text-lg">*</sup></label>
                                    </p>
                                </th>
                                <td>
                                    <select name="relationSelect" id="info-relationSelect" class="form-control w-full lg:w-8/12">
                                        <option value="">관계 선택</option>
										<c:forEach var="relation" items="${mbrRelationCode}" varStatus="status">
											<option value="${relation.key}">${relation.value}</option>	
										</c:forEach>
                                    </select>
                                </td>
                            </tr>
                            <tr class="wrapNm">
                                <th scope="row">
                                    <p>
                                        <label for="recipter">수급자 성명<sup class="text-danger text-base md:text-lg">*</sup></label>
                                    </p>
                                </th>
                                <td>
                                    <input type="text" class="form-control  lg:w-8/12" id="info-recipientsNm" name="info-recipientsNm" maxlength="50" value="">
                                </td>
                            </tr>
                            <tr class="wrapNo">
                                <th scope="row">
                                    <p>
                                        <label for="rcperRcognNo">요양인정번호</label>
                                    </p>
                                </th>
                                <td>
                                    <div class="flex flex-row gap-2.5 mb-1.5">
                                        <div class="form-check input-rcperRcognNo-yn">
                                            <input class="form-check-input" type="radio" name="info-rcperRcognNo-yn" id="info-rcperRcognNo-y" value="Y" checked onchange="changeRcperRcognNoYn();">
                                            <label class="form-check-label" for="info-rcperRcognNo-y">있음</label>
                                        </div>
                                        <div class="form-check input-rcperRcognNo-yn">
                                            <input class="form-check-input" type="radio" name="info-rcperRcognNo-yn" id="info-rcperRcognNo-n" value="N" onchange="changeRcperRcognNoYn();">
                                            <label class="form-check-label" for="info-rcperRcognNo-n">없음</label>
                                        </div>
                                    </div>
                                    <div class="form-group w-full lg:w-8/12" id="input-rcperRcognNo">
                                        <p class="px-1.5 font-serif text-[1.375rem] font-bold md:text-2xl">L</p>
                                        <input type="text" class="form-control " id="info-rcperRcognNo" name="info-rcperRcognNo" maxlength="13" value="">
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <th scope="row">
                                    <p><label for="search-item6">상담받을 연락처<sup class="text-danger text-base md:text-lg">*</sup></label></p>
                                </th>
                                <td><input type="text" class="form-control w-full lg:w-8/12" id="info-tel"></td>
                            </tr> 
                            <tr>
                                <th scope="row">
                                    <p><label for="search-item6">실거주지 주소<sup class="text-danger text-base md:text-lg">*</sup></label></p>
                                </th>
                                <td>
                                    <fieldset  class="addr-select">
                                        <select name="sido" id="sido" class="form-control" onchange="setSigugun();">
                                        </select>
                                        <select name="sigugun" id="sigugun" class="form-control" onchange="setDong();">
                                        	<option value="">시/군/구</option>
                                        </select>
                                        <select name="dong" id="dong" class="form-control md:col-span-2 lg:col-span-1">
                                            <option value="">동/읍/면</option>
                                        </select>
                                    </fieldset>
                                </td>
                            </tr>
                            <tr>
                                <th scope="row"><p><label for="search-item4">생년월일<sup class="text-danger text-base md:text-lg">*</sup></label></p></th>
                                <td><input type="text" class="form-control  lg:w-8/12" id="info-brdt" placeholder="1950/01/01"></td>
                            </tr>
                            <tr>
                            	<th scope="row"><p><label for="search-item4">성별<sup class="text-danger text-base md:text-lg">*</sup></label></p></th>
                            	<td>
                            		<div class="flex flex-row gap-2.5 mb-1.5">
                                        <div class="form-check">
                                            <input class="form-check-input" type="radio" name="info-gender" id="info-gender-m" value="M">
                                            <label class="form-check-label" for="info-gender-m">남성</label>
                                        </div>
                                        <div class="form-check">
                                            <input class="form-check-input" type="radio" name="info-gender" id="info-gender-w" value="W">
                                            <label class="form-check-label" for="info-gender-w">여성</label>
                                        </div>
                                    </div>
                            	</td>
                            </tr>
                            <tr>
                                <th scope="row"><p><label for="search-item4">상담유형</label></p></th>
                                <td>요양정보상담</td>
                            </tr>
                            <tr class="top-border">
                                <td></td>
                                <td></td>
                            </tr>
                        </tbody>
                    </table>
                    <ul class="list-style1">
                        <li>상기 정보는 장기요양등급 신청 및 상담이 가능한 장기요양기관에 제공되며 원활한 상담 진행 목적으로 상담 기관이 변경될 수도 있습니다.</li>
                        <li>제공되는 정보는 상기 목적으로만 활용하며 1년간 보관 후 폐기됩니다.</li>
                        <li>가입 시 동의받은 개인정보 제3자 제공동의에따라 위의 개인정보가 제공됩니다. 동의하지 않을 경우 서비스 이용이 제한될 수 있습니다.</li>
                    </ul>
                </div>
                <div class="modal-footer md:w-3/4 mx-auto mt-4">
                    <button type="button" class="btn btn-primary3 large w-[60%] md:w-[70%]" onclick="requestConslt();">상담신청하기</button>
                    <button type="button" class="btn btn-outline-primary large w-[40%] md:w-[30%] md:whitespace-nowrap" onclick="$('#modal-consulting-info').modal('hide');">취소하기</button>
                </div>
                </div>
            </div>
        </div>

        <!--상담신청완료-->
        <div class="modal modal-index fade" id="modal-consulting-complated" tabindex="-1" aria-hidden="true">
            <div class="modal-dialog">
                <div class="modal-content">
                <div class="modal-header">
                    <h2 class="text-title">알림</h2>
                    <button data-bs-dismiss="modal" class="btn-close">모달 닫기</button>
                </div>
                <div class="modal-body">
                    <div class="text-center">
                        <div class="provide-complate">
                            <div class="wrapper">
                                <svg width="45.1731884px" height="44.9930805px" viewBox="0 0 45.1731884 44.9930805">
                                    <g id="airplane" stroke="none" stroke-width="1" fill="none" fill-rule="evenodd">
                                        <g id="airplane" transform="translate(-836.3067, -384.1337)" fill="#FFFFFF">
                                            <g id="airplane" transform="translate(787, 329)">
                                                <path d="M49.8149249,79.6635069 L92.9878533,55.2632727 C93.4686607,54.9915327 94.078721,55.1610153 94.350461,55.6418227 C94.4586743,55.8332916 94.5007484,56.0550947 94.470169,56.2728912 L89.2316897,93.5830877 C89.0781107,94.6769283 88.0668774,95.439161 86.9730368,95.285582 C86.8468774,95.2678688 86.7226991,95.2381419 86.6021946,95.1968067 L75.5767429,91.4148747 C74.7376734,91.1270585 73.8092758,91.426319 73.2962443,92.1499725 L67.940117,99.7050262 C67.620703,100.155574 66.9965258,100.261879 66.5459782,99.9424645 C66.2814978,99.7549621 66.1243285,99.4508781 66.1243285,99.1266759 L66.1243285,89.5357494 C66.1243285,88.8171161 66.3822929,88.1223582 66.8512931,87.5778653 L81.6305995,70.4196045 C81.8108177,70.2103773 81.7873014,69.8946695 81.5780742,69.7144512 C81.3931938,69.555204 81.1203694,69.552664 80.9325561,69.7084415 L62.4817313,85.0120537 C61.6191487,85.727503 60.4297149,85.9025231 59.3976054,85.4658696 L49.9173201,81.4550557 C49.4086824,81.2398669 49.1707951,80.6530897 49.3859839,80.1444521 C49.4719751,79.9411962 49.6227902,79.7720965 49.8149249,79.6635069 Z" id="Path-4"></path>
                                            </g>
                                        </g>
                                    </g>
                                </svg>
                                <div class="object1"></div>
                                <div class="object2"></div>
                                <div class="object3"></div>
                            </div>
                        </div>
                        <p class="mt-5.5 text-lg font-bold md:mt-6 md:text-xl lg:mt-7 lg:text-2xl">상담 신청이 완료되었습니다.</p>
                        <p class="mt-2 mb-4 text-sm md:text-base tracking-tight">
                            "영업일 기준, 2일 이내 해피콜 통해 <span class="block md:inline-block">안내 받으실 수 있어요"</span>
                        </p>
                    </div>
    
                    <script>
                        $('.provide-complate').addClass('animate1');
                        $('.provide-complate svg').one('animationend transitionend',function(){
                            $('.provide-complate').removeClass('animate1').addClass('animate2');
                        });
                    </script>
                </div>
                <div class="modal-footer">
                    <a href="#" class="btn btn-large btn-primary3 w-57 md:w-70" onclick="location.href='/membership/conslt/appl/list'">신청 내역 보러가기</a>
                </div>
                </div>
            </div>
        </div>
        
    </div>
</div>

<script>
var me = {};
var myRecipientInfo = {};
var mbrRecipients = {};

//숫자형 날짜 하이폰 삽입
function f_hiponFormat(value){
	var yyyy = value.substring(0,4);
	var mm = value.substring(4,6);
	var dd = value.substring(6,8);

	return yyyy+'-'+mm+'-'+dd;
}

//콤마 찍기 : ###,###
function comma(num){
    var len, point, str;
    str = "0";
	if(num != ''){
	    num = num + "";
	    point = num.length % 3 ;
	    len = num.length;

	    str = num.substring(0, point);
	    while (point < len) {
	        if (str != "") str += ",";
	        str += num.substring(point, point + 3);
	        point += 3;
	    }
    }
    return str;
}

//숫자형 날짜 -> yyyy-MM-dd
function f_dateFormat(value){
	var date = new Date(value);

	var yyyy = date.getFullYear();
	var mm = date.getMonth() + 1;
	mm = mm >= 10 ? mm : '0' + mm;
	var dd = date.getDate();
	dd = dd >= 10? dd: '0' + dd;
	return yyyy+'-'+mm+'-'+dd;
}

function f_replaceLink (str){
	let link = 0;

	switch(str){
	case "walkerForAdults":
		link = 1;
		break;
	case "wheelchair":
		link = 2;
		break;
	case "cane":
		link = 3;
		break;
	case "safetyHandle":
		link = 4;
		break;
	case "antiSlipProduct":
		link = 5;
		break;
	case "antiSlipProduct":
		link = 6;
		break;
	case "mattress":
		link = 7;
		break;
	case "cushion":
		link = 8;
		break;
	case "changeTool":
		link = 9;
		break;
	case "panties":
		link = 10;
		break;
	case "bathChair":
		link = 11;
		break;
	case "mobileToilet":
		link = 12;
		break;
	case "portableToilet":
		link = 13;
		break;
	case "outRunway":
		link = 14;
		break;
	case "inRunway":
		link = 14;
		break;
	default:
		link = 0;
		break;
	}


	return link;
}

function f_onlyNumber (str){
	let regExp = /[^0-9]/g;
	let regExp2 = /[a-zA-z]/g;
	str = str.replace(regExp, "").replace(regExp2,"");
	return str;
}

//수급자 정보 조회
function getRecipterInfo(){
	$(".careinfo-mask").removeClass("is-active");
	$("#collapse-agree1").removeClass("show");
	const name = '${recipientsNm}';
	const no = '${rcperRcognNo}';

	if (name == '') {
		alert("로그인 이후 조회가 가능합니다.");
		return;
	}
	
	if(no == '' ){
		alert("요양인정번호는 필수 입력 항목입니다.");
		return;
	}
	
	$.ajax({
		type : "post",
		url  : "/common/recipter/getRecipterInfo.json",
		data : {
			mbrNm : name
			, rcperRcognNo : no
		},
		dataType : 'json'
	})
	.done(function(json) {
		if(!json.isSearch) {
			alert(json.msg);
			return;
		}
		
		if(json.result){
			//갱신일 입력
			$(refleshDate).text(json.refleshDate);
			
			let usePercent = 0;
			let setPercent = 100;
			if(Number(json.infoMap.USE_AMT) != 0){
				let total = Number(json.infoMap.LMT_AMT);
				let use = Number(json.infoMap.USE_AMT);
				usePercent = ((use / total) * 100);
				setPercent = (((total-use) / total) * 100);
			}

			let penPayRate = json.infoMap.REDUCE_NM == '일반' ? '15': json.infoMap.REDUCE_NM == '기초' ? '0' : json.infoMap.REDUCE_NM == '의료급여' ? '6': (json.infoMap.SBA_CD.split('(')[1].substr(0, json.infoMap.SBA_CD.split('(')[1].length-1).replaceAll("%",""));
			$("#searchQlf").text(penPayRate);

			$(".searchNm").text($("#recipter").val());
			$(".searchNo").text("L"+$("#rcperRcognNo").val());
			$("#searchGrade").text(json.infoMap.LTC_RCGT_GRADE_CD);
			$("#searchRcgt").html(json.infoMap.RCGT_EDA_DT);
			$("#searchBgngApdt").html(f_hiponFormat((json.infoMap.APDT_FR_DT)) + " ~ " + f_hiponFormat((json.infoMap.APDT_TO_DT)));
			//$("#searchEndApdt").html("~ " + f_hiponFormat((json.infoMap.APDT_TO_DT)));
			$("#searchRemn").text(comma(json.infoMap.LMT_AMT - json.infoMap.USE_AMT));
			$("#searchUseAmt").html(comma(json.infoMap.USE_AMT) + ' <span class="won">원</span>');
			$("#searchLimit").text(comma(json.infoMap.LMT_AMT)+"원");



			$("#useAmtBar").attr("style", 'width: '+usePercent+'%');
			$("#setAmtBar").attr("style", 'width: '+setPercent+'%');

			let allList = new Array();

			let saleList = new Array();
			let saleNonList = new Array();
			let lendList = new Array();
			let lendNonList = new Array();

			let ownSaleList = new Array();
			let ownLendList = new Array();

			if(json.infoMap.saleList != '' && json.infoMap.saleList != null){
				saleList = json.infoMap.saleList
			}
			if(json.infoMap.saleNonList != '' && json.infoMap.saleNonList != null){
				saleNonList = json.infoMap.saleNonList
			}
			if(json.infoMap.lendList != '' && json.infoMap.lendList != null){
				lendList = json.infoMap.lendList
			}
			if(json.infoMap.lendNonList != '' && json.infoMap.lendNonList != null){
				lendNonList = json.infoMap.lendNonList
			}
			if(json.infoMap.ownSaleList != '' && json.infoMap.ownSaleList != null){
				ownSaleList = json.infoMap.ownSaleList
			}
			if(json.infoMap.ownLendList != '' && json.infoMap.ownLendList != null){
				ownLendList = json.infoMap.ownLendList
			}
			if(json.infoMap.allList != '' && json.infoMap.allList != null){
				allList = json.infoMap.allList;
			}

			// 고유 보유 개수
			let apiMap = new Map();

			let vo = "${apiVO}";
			vo = vo.replaceAll("TilkoApiVO(","").replaceAll(")","").replaceAll(" ","").split(",");

			for(let v=0; v<vo.length; v++){
				let obj = vo[v].split("=");
				apiMap.set(obj[0],obj[1]);
			}

			// 전체 고유 개수
			if(allList.length > 0){
				for(let i=0; i<allList.length; i++){
					$(".fin"+allList[i]).text(0);
					$(".buy"+allList[i]).text(apiMap.get(allList[i]));
				}
			}

			let CodeMap = new Map();
			let code = "${apiCode}";
			code = code.replaceAll("{","").replaceAll("}","").replaceAll(" ","").split(",");

			for(let v=0; v<code.length; v++){
				let str = code[v];
				str = str.split("=");
				CodeMap.set(str[1], str[0]);
			}

			// 판매 급여 품목
			$(".sale_return").empty();
			if(saleList.length > 0){
				for(let i=0; i<saleList.length; i++){
					let uniqueCnt = Number($(".own_view .buy"+saleList[i]).text());
					let html = "";
					html +='   <tr>';
					html +='    <td class="sale_index">'+(i+1)+'</td>';
					html +=' <td class="subject"><a href="${_mainPath}/cntnts/page3-checkpoint#check-cont'+f_replaceLink(saleList[i])+'" target=_blank>'+CodeMap.get(saleList[i])+'</a></td>';
					html +=' <td class="fin'+saleList[i]+'">0</td>';
					html +='<td class="buy'+saleList[i]+'">'+uniqueCnt+'</td>';
					html +='</tr>';
					$(".sale_return").append(html);
				}

				for(let i=0; i<saleNonList.length; i++){
					let html = "";
					html +='   <tr>';
					html +='    <td class="sale_index">'+($(".sale_index").length+1)+'</td>';
					html +=' <td class="subject"><a href="${_mainPath}/cntnts/page3-checkpoint#check-cont'+f_replaceLink(saleNonList[i])+'" target=_blank>'+CodeMap.get(saleNonList[i])+'(판매 불가)</a></td>';
					html +=' <td class="fin'+saleNonList[i]+'">해당없음</td>';
					html +='<td class="buy'+saleNonList[i]+'">해당없음</td>';
					html +='</tr>';
					$(".sale_return").append(html);
					$("dd.buy"+saleNonList[i]).text(0);
					$("dd.fin"+saleNonList[i]).text(0);
				}
			}else{
				let html = "";
				html +='   <tr>';
				html +='    <td colspan="4">검색된 데이터가 없습니다.</td>';
				html +='</tr>';
				$(".sale_return").append(html);
			}



			// 대여 급여 품목
			$(".lend_return").empty();
			if(lendList.length > 0){
				for(let i=0; i<lendList.length; i++){
					let uniqueCnt = Number($(".own_view .buy"+lendList[i]).text());
					let html = "";
					html +='   <tr>';
					html +='    <td class="lend_index">'+($(".lend_index").length+1)+'</td>';
					if(f_replaceLink(lendList[i]) == 0){
						html +=' <td class="subject">'+CodeMap.get(lendList[i])+'</td>';
					}else{
						html +=' <td class="subject"><a href="${_mainPath}/cntnts/page3-checkpoint#check-cont'+f_replaceLink(lendList[i])+'" target=_blank>'+CodeMap.get(lendList[i])+'</a></td>';
					}


					html +=' <td class="fin'+lendList[i]+'">0</td>';
					html +='<td class="buy'+lendList[i]+'">'+uniqueCnt+'</td>';
					html +='</tr>';
					$(".lend_return").append(html);
				}
				for(let i=0; i<lendNonList.length; i++){
					let html = "";
					html +='   <tr>';
					html +='    <td class="lend_index">'+(i+1)+'</td>';
					if(f_replaceLink(lendNonList[i]) == 0){
						html +=' <td class="subject">'+CodeMap.get(lendNonList[i])+'(대여 불가)</td>';
					}else{
						html +=' <td class="subject"><a href="${_mainPath}/cntnts/page3-checkpoint#check-cont'+f_replaceLink(lendNonList[i])+'" target=_blank>'+CodeMap.get(lendNonList[i])+'(대여 불가)</a></td>';
					}

					html +=' <td class="fin'+lendNonList[i]+'">해당없음</td>';
					html +='<td class="buy'+lendNonList[i]+'">해당없음</td>';
					html +='</tr>';
					$(".lend_return").append(html);
					$("dd.buy"+lendNonList[i]).text(0);
					$("dd.fin"+lendNonList[i]).text(0);
				}
			}else{
				let html = "";
				html +='   <tr>';
				html +='    <td colspan="4">검색된 데이터가 없습니다.</td>';
				html +='   </tr>';
				$(".lend_return").append(html);
			}


			// 보유 현황 카운트 - 판매
			if(ownSaleList.length > 0){
				for(let i=0; i<ownSaleList.length; i++){
					let finCnt = 0;
					let buyCnt = 0;

					if($(".sale_return .fin"+ownSaleList[i]).text() != '해당없음'){
						finCnt = Number($(".sale_return .fin"+ownSaleList[i]).text());
						buyCnt = Number($(".own_view .buy"+ownSaleList[i]).text());
						$(".fin"+ownSaleList[i]).text(finCnt+1);
					}else{
						$(".fin"+ownSaleList[i]).text(1);
					}

					if(buyCnt > 0){
						$(".buy"+ownSaleList[i]).text(buyCnt-1);
					}else{
						$(".buy"+ownSaleList[i]).text(0);
					}
				}
			}

			// 보유 현황 카운트 - 대여
			if(ownLendList.length > 0){
				for(let i=0; i<ownLendList.length; i++){
					let finCnt = 0;
					let buyCnt = 0;

					if($(".lend_return .fin"+ownLendList[i]).text() != '해당없음'){
						finCnt = Number($(".lend_return .fin"+ownLendList[i]).text());
						buyCnt = Number($("own_view .buy"+ownLendList[i]).text());
						$(".fin"+ownLendList[i]).text(finCnt + 1);
					}else{
						$(".fin"+ownLendList[i]).text(1);
					}

					if(buyCnt > 0){
						$(".buy"+ownLendList[i]).text(buyCnt -1);
					}else{
						$(".buy"+ownLendList[i]).text(0);
					}
				}
			}
            $('.careinfo-mask').addClass('is-active');
            
            
            //채널톡 이벤트 처리
            eventChannelTalk('view_infocheck_success');
		}else{
			alert("조회된 데이터가 없습니다.");
		}
	})
	.fail(function(data, status, err) {
		console.log('error forward : ' + data);
	});
}

//다시조회하기 버튼 클릭
function clickReSearchBtn() {
	getRecipterInfo();
}


//상담하기 버튼 클릭
function clickStartConsltBtn() {
	$.ajax({
		type : "post",
		url  : "/membership/info/myinfo/getMbrInfo.json",
		dataType : 'json'
	})
	.done(function(data) {
		//로그인 한 경우
		if (data.isLogin) {
			var recipientsNo = ${recipientsNo};
			me = data.mbrVO;
			myRecipientInfo = data.mbrRecipients.filter(f => f.recipientsNo === recipientsNo)[0];
			mbrRecipients = data.mbrRecipients;
			
			//진행중인 상담이 있는 경우
			if (data.isExistConsltInProcess) {
				$('#modal-my-consulting').modal('show');
				return;
			}
			
			openNewConsltInfo();
		}
		//로그인 안한 경우
		else {
			alert('로그인 이후 이용가능합니다')
		}
	})
	.fail(function(data, status, err) {
		alert('서버와 연결이 좋지 않습니다');
	});
}


//상담신청 모달창 띄우기(또는 진행중인 상담존재 모달에서 새롭게 진행하기 클릭)
function openNewConsltInfo() {
	$('#info-relationSelect').val(myRecipientInfo.relationCd);
	$('#info-recipientsNm').val(myRecipientInfo.recipientsNm);
	
	if(myRecipientInfo.rcperRcognNo) {
		//L번호가 있는 경우 이름, L번호 수정 불가
		$('#info-recipientsNm').prop('readonly', true);
		
		$('.input-rcperRcognNo-yn').css('display', 'none');
		$('#info-rcperRcognNo-y').prop('disabled', true);
		$('#info-rcperRcognNo-n').prop('disabled', true);
		
		$('#info-rcperRcognNo-y').prop('checked', true); 
		$('#info-rcperRcognNo').val(myRecipientInfo.rcperRcognNo);
		$('#input-rcperRcognNo').css('display', 'inline-flex');
		$('#info-rcperRcognNo').prop('readonly', true);
	} else {
		$('#info-recipientsNm').prop('readonly', false);
		
		$('.input-rcperRcognNo-yn').css('display', 'inline-block');
		$('#info-rcperRcognNo-y').prop('disabled', false);
		$('#info-rcperRcognNo-n').prop('disabled', false);
		
		$('#info-rcperRcognNo-n').prop('checked', true);
		$('#info-rcperRcognNo').val('');
		$('#input-rcperRcognNo').css('display', 'none');
	}
	
	$('#info-tel').val(myRecipientInfo.tel);
	
	if (myRecipientInfo.sido) {
		var options = $('#sido option');
		for(var i = 0; i < options.length; i++) {
			if ($('#sido option')[i].text === myRecipientInfo.sido) {
				$('#sido option')[i].selected = true;
			}
		}
		setSigugun();
	}
	if (myRecipientInfo.sigugun) {
		var options = $('#sigugun option');
		for(var i = 0; i < options.length; i++) {
			if ($('#sigugun option')[i].text === myRecipientInfo.sigugun) {
				$('#sigugun option')[i].selected = true;
			}
		}
		setDong();
	}
	if (myRecipientInfo.dong) {
		var options = $('#dong option');
		for(var i = 0; i < options.length; i++) {
			if ($('#dong option')[i].text === myRecipientInfo.dong) {
				$('#dong option')[i].selected = true;
			}
		}
	}
	
	if(myRecipientInfo.brdt) {
		$('#info-brdt').val(myRecipientInfo.brdt.substring(0, 4) + '/' + myRecipientInfo.brdt.substring(4, 6) + '/' + myRecipientInfo.brdt.substring(6, 8));	
	}else {
		$('#info-brdt').val('');    			
	}
	
	if (myRecipientInfo.gender === 'M') {
		$('#info-gender-m').prop('checked', true);
	} else if (myRecipientInfo.gender === 'W') {
		$('#info-gender-w').prop('checked', true);
	} else {
		$('#info-gender-m').prop('checked', false);
		$('#info-gender-w').prop('checked', false);
	}
	
	
	$('#modal-consulting-info').modal('show');
}

//상담신청정보 모달창안에 L번호 있음, 없음 체크로 readonly 처리
function changeRcperRcognNoYn() {
	var checkedVal = $('input[name=info-rcperRcognNo-yn]:checked').val();
	if (checkedVal === 'Y') {
		$('#info-rcperRcognNo').prop('readonly', false);
		$('#input-rcperRcognNo').css('display', 'inline-flex');
	} else {
		$('#info-rcperRcognNo').prop('readonly', true);
		$('#input-rcperRcognNo').css('display', 'none');
	}
}


//상담신청하기
var telchk = /^([0-9]{2,3})?-([0-9]{3,4})?-([0-9]{3,4})$/;
var datechk = /^([1-2][0-9]{3})\/([0-1][0-9])\/([0-3][0-9])$/;
function requestConslt() {
	var relationCd = $('#info-relationSelect').val();
	var recipientsNm = $('#info-recipientsNm').val();
	var rcperRcognNoYn = $('input[name=info-rcperRcognNo-yn]:checked').val();
	var rcperRcognNo = $('#info-rcperRcognNo').val();
	var tel = $('#info-tel').val();
	var sidoCode = $('#sido option:selected').val();
	var sido = $('#sido option:selected').text();
	var sigugunCode = $('#sigugun option:selected').val();
	var sigugun = $('#sigugun option:selected').text();
	var dongCode = $('#dong option:selected').val();
	var dong = $('#dong option:selected').text();
	var brdt = $('#info-brdt').val();
	var gender = $('input[name=info-gender]:checked').val();
	
	//필수항목 입력검사
	if (!relationCd) {
		alert('수급자와의 관계를 선택하세요');
		return;
	}
	if (!recipientsNm) {
		alert('수급자 성명을 입력하세요');
		return;
	}
	if (rcperRcognNoYn === 'Y' && !rcperRcognNo) {
		alert('요양인정번호를 입력하세요');
		return;
	}
	//요양번호 10자리 검사
	if (rcperRcognNoYn === 'Y' && rcperRcognNo.length != 10) {
		alert('요양인정번호 숫자 10자리를 입력하세요 (예: 1234567890)');
		return;
	}
	if (!tel) {
		alert('상담받을 연락처를 입력하세요');
		return;
	}
	if (!sidoCode || !sigugunCode || !dongCode) {
		alert('실거주지 주소를 모두 선택하세요');
		return;
	}
	if (!brdt) {
		alert('생년월일를 입력하세요');
		return;
	}
	if (!gender) {
		alert('성별을 입력하세요');
		return;
	}
	
	//본인인지 체크
	if (relationCd === '007' && recipientsNm !== me.mbrNm) {
		alert('수급자와의 관계를 확인해주세요');
		return;
	}
	//본인과 배우자는 한명만 등록
	var meCount = mbrRecipients.filter(f => f.recipientsNo !== myRecipientInfo.recipientsNo && f.relationCd === '007').length; //내 수급자가 아닌 다른수급자도 본인인지 확인
	var spouseCount = mbrRecipients.filter(f => f.recipientsNo !== myRecipientInfo.recipientsNo && f.relationCd === '001').length; //내 수급자가 아닌 다른수급자도 배우자인지 확인
	if ((relationCd === '007' && meCount > 0) ||
		(relationCd === '001' && spouseCount > 0)) {
		alert('수급자와의 관계를 확인해주세요');
		return;
	}
	
		
	//연락처 형식 검사
	if (telchk.test(tel) === false) {
		alert('연락처 형식이 올바르지 않습니다 (예시: 010-0000-0000)');
		return;
	}
	
	//생년월일 형식 검사
	if (datechk.test(brdt) === false) {
		alert('생년월일 형식이 올바르지 않습니다 (예시: 1950/01/01)');
		return;
	}
	
    if (rcperRcognNoYn === 'N') {
        rcperRcognNo = '';
    }
	
	var saveRecipientInfo = confirm('입력하신 수급자 정보를 마이페이지에도 저장하시겠습니까?');
	
	$.ajax({
		type : "post",
		url  : "/main/conslt/addMbrConslt.json",
		data : {
			relationCd
			, mbrNm: recipientsNm
			, rcperRcognNo
			, mbrTelno: tel
			, zip: sido
			, addr: sigugun
			, daddr: dong
			, brdt
			, gender
			, recipientsNo: myRecipientInfo.recipientsNo
			, prevPath: 'simpleSearch'
			, saveRecipientInfo
		},
		dataType : 'json'
	})
	.done(function(data) {
		if(data.success) {
			$('#modal-consulting-info').modal('hide');
			$('#modal-consulting-complated').modal('show');
			
			
			//채널톡 이벤트 처리
		    eventChannelTalk('click_infocheck_matching');
		}else{
			alert(data.msg);
		}
	})
	.fail(function(data, status, err) {
		alert('서버와 연결이 좋지 않습니다.');
	});
}


// 시/도 Select 박스 셋팅
function initSido() {
	var template = '<option value="">시/도</option>';
	
	for(var i = 0; i < hangjungdong.sido.length; i++) {
		template += '<option value="' + hangjungdong.sido[i].sido + '">' + hangjungdong.sido[i].codeNm + '</option>';
	}
	
	$('#sido').html(template);
}
// 시/구/군 Select 박스 셋팅
function setSigugun() {
	var sidoCode = $('#sido option:selected').val();
	
	if (sidoCode) {
		var sigugunArray = hangjungdong.sigugun.filter(f => f.sido === sidoCode);
		var template = '<option value="">시/군/구</option>';
		
		for(var i = 0; i < sigugunArray.length; i++) {
			template += '<option value="' + sigugunArray[i].sigugun + '">' + sigugunArray[i].codeNm + '</option>';
		}
		
		$('#sigugun').html(template);
	}
}
// 동/읍/면 Select 박스 셋팅
function setDong() {
	var sigugunCode = $('#sigugun option:selected').val();
	
	if (sigugunCode) {
		var dongArray = hangjungdong.dong.filter(f => f.sigugun === sigugunCode);
		var template = '<option value="">동/읍/면</option>';
		
		for(var i = 0; i < dongArray.length; i++) {
			template += '<option value="' + dongArray[i].dong + '">' + dongArray[i].codeNm + '</option>';
		}
		
		$('#dong').html(template);
	}
}


//채널톡 event 처리 (요양정보 조회 페이지 실행, 1:1 상담하기 버튼 실행)
function eventChannelTalk(eventName) {
	//인정 등급
	var grade = $('#searchGrade').text();
	//총 급여액
	var limitAmt = $('#searchLimit').text().replaceAll('원', '').replaceAll(',', '');
	//사용 금액
	var useAmt = $('#searchUseAmt').text().replaceAll('원', '').replaceAll(',', '').replaceAll(' ', '');
	//잔여 금액
	var remainingAmt = comma(Number(limitAmt) - Number(useAmt)) + '원';
	
	var propertyObj = {
		 grade,
		 remainingAmt
	}
	
	if (eventName === 'view_infocheck_success') {
		//조회 완료 일자
		var searchDate = $('#refleshDate').text();
		if (searchDate) {
			searchDate = searchDate.substr(0, 13);
			propertyObj.searchDate = searchDate;
		}
	} else {
		//상담 신청 일자
		var now = new Date();
		propertyObj.consltDate = now.getFullYear() + '년 ' + String(now.getMonth() + 1).padStart(2, "0") + '월 ' + String(now.getDate()).padStart(2, "0") + '일'; 
	}
	
	 ChannelIO('track', eventName, propertyObj);
}


$(function() {
	//바로 조회하기
	getRecipterInfo();
	initSido();
	

    //연락처 형식 - 자동작성
    const telKeyInputRegex = /^(45|48|49|50|51|52|53|54|55|56|57|58|59)$/;
    $("#info-tel").keypress(function(e) {
        //숫자와 /만 입력받도록 추가
        if (!telKeyInputRegex.test(e.keyCode)) {
            return false;
        }
    });
    $("#info-tel").on("keydown",function(e){
        //백스페이스는 무시
        if (e.keyCode !== 8) {
            if($(this).val().length == 3){
                $(this).val($(this).val() + "-");
            }

            if($(this).val().length == 8){
                $(this).val($(this).val() + "-");
            }
            
            if($(this).val().length == 13){
                $(this).val($(this).val() + "-");
            }
        }
    });
    $("#info-tel").on("keyup",function(){
        if($(this).val().length > 13){
            $(this).val($(this).val().substr(0,13));
        }
    });
    
    
    //생년월일 형식 / 자동작성
    const brdtKeyInputRegex = /^(48|49|50|51|52|53|54|55|56|57|58|59|191)$/;
    $("#info-brdt").keypress(function(e) {
        //숫자와 /만 입력받도록 추가
        if (!brdtKeyInputRegex.test(e.keyCode)) {
            return false;
        }
    });
    $("#info-brdt").on("keydown",function(e){
        //백스페이스는 무시
        if (e.keyCode !== 8) {
            if($(this).val().length == 4){
                $(this).val($(this).val() + "/");
            }

            if($(this).val().length == 7){
                $(this).val($(this).val() + "/");
            }
        }
    });
    $("#info-brdt").on("keyup",function(){
        if($(this).val().length > 10){
            $(this).val($(this).val().substr(0,10));
        }
    });


	let regExp = /[^0-9 a-zA-Z!@#$%^&*()-_]/g;
	
    var swiper = new Swiper(".swiper", {
        slidesPerView : 'auto',
        spaceBetween : 10,
        navigation: {
            nextEl: ".swiper-button-next",
            prevEl: ".swiper-button-prev",
        },
        breakpoints: {
            spaceBetween : 12,
        },
    });

    $('.status-toggle').on('click', function() {
        $(this).toggleClass('is-active').text(($(this).hasClass('is-active')) ? '상세닫기' : '상세열기').prev('.status-list').toggleClass('hidden');
    })

    $("#rcperRcognNo").on("keyup",function(){
		if(!regExp.test($(this).val())){
			$(this).val(f_onlyNumber($(this).val()));

		}
    });

   	// 기능
    $(".f_recipterCheck").on("click", getRecipterInfo);
   	
    if("${recipter}" != '' && "${rcperRcognNo}" != '' && $(".careinfo-mask").hasClass("is-active")){
		$(".f_recipterCheck").click();
	}
});
</script>
</div>
