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
                                    <dd class="finwalkerForAdults"><span class="blurring"><span class="mask"></span><span class="cnt">0</span></span></dd>
                                </dl>
                                <dl>
                                    <dt>구매예상</dt>
                                    <dd class="buywalkerForAdults" ><span class="blurring2"><span class="mask"></span><span class="cnt">0</span></span></dd>
                                </dl>
                            </div>
                            <div class="swiper-slide swiper-item2">
                                <strong>수동휠체어</strong>
                                <i></i>
                                <dl>
                                    <dt>계약완료</dt>
                                    <dd class="finwheelchair"><span class="blurring2"><span class="mask"></span><span class="cnt">0</span></span></dd>
                                </dl>
                                <dl>
                                    <dt>구매예상</dt>
                                    <dd class="buywheelchair"><span class="blurring2"><span class="mask"></span><span class="cnt">0</span></span></dd>
                                </dl>
                            </div>
                            <div class="swiper-slide swiper-item3">
                                <strong>지팡이</strong>
                                <i></i>
                                <dl>
                                    <dt>계약완료</dt>
                                    <dd class="fincane"><span class="blurring2"><span class="mask"></span><span class="cnt">0</span></span></dd>
                                </dl>
                                <dl>
                                    <dt>구매예상</dt>
                                    <dd class="buycane"><span class="blurring2"><span class="mask"></span><span class="cnt">0</span></span></dd>
                                </dl>
                            </div>
                            <div class="swiper-slide swiper-item4">
                                <strong>안전손잡이</strong>
                                <i></i>
                                <dl>
                                    <dt>계약완료</dt>
                                    <dd class="finsafetyHandle"><span class="blurring2"><span class="mask"></span><span class="cnt">0</span></span></dd>
                                </dl>
                                <dl>
                                    <dt>구매예상</dt>
                                    <dd class="buysafetyHandle"><span class="blurring2"><span class="mask"></span><span class="cnt">0</span></span></dd>
                                </dl>
                            </div>
                            <div class="swiper-slide swiper-item5">
                                <strong>미끄럼방지 매트/액</strong>
                                <i></i>
                                <dl>
                                    <dt>계약완료</dt>
                                    <dd class="finantiSlipProduct"><span class="blurring2"><span class="mask"></span><span class="cnt">0</span></span></dd>
                                </dl>
                                <dl>
                                    <dt>구매예상</dt>
                                    <dd class="buyantiSlipProduct"><span class="blurring2"><span class="mask"></span><span class="cnt">0</span></span></dd>
                                </dl>
                            </div>
                            <div class="swiper-slide swiper-item6">
                                <strong>미끄럼방지 양말</strong>
                                <i></i>
                                <dl>
                                    <dt>계약완료</dt>
                                    <dd class="finantiSlipSocks"><span class="blurring2"><span class="mask"></span><span class="cnt">0</span></span></dd>
                                </dl>
                                <dl>
                                    <dt>구매예상</dt>
                                    <dd class="buyantiSlipSocks"><span class="blurring2"><span class="mask"></span><span class="cnt">0</span></span></dd>
                                </dl>
                            </div>
                            <div class="swiper-slide swiper-item7">
                                <strong>욕창예방 매트리스</strong>
                                <i></i>
                                <dl>
                                    <dt>계약완료</dt>
                                    <dd class="finmattress"><span class="blurring2"><span class="mask"></span><span class="cnt">0</span></span></dd>
                                </dl>
                                <dl>
                                    <dt>구매예상</dt>
                                    <dd class="buymattress"><span class="blurring2"><span class="mask"></span><span class="cnt">0</span></span></dd>
                                </dl>
                            </div>
                            <div class="swiper-slide swiper-item8">
                                <strong>욕창예방 방석</strong>
                                <i></i>
                                <dl>
                                    <dt>계약완료</dt>
                                    <dd class="fincushion"><span class="blurring2"><span class="mask"></span><span class="cnt">0</span></span></dd>
                                </dl>
                                <dl>
                                    <dt>구매예상</dt>
                                    <dd class="buycushion"><span class="blurring2"><span class="mask"></span><span class="cnt">0</span></span></dd>
                                </dl>
                            </div>
                            <div class="swiper-slide swiper-item9">
                                <strong>자세변환용구</strong>
                                <i></i>
                                <dl>
                                    <dt>계약완료</dt>
                                    <dd class="finchangeTool"><span class="blurring2"><span class="mask"></span><span class="cnt">0</span></span></dd>
                                </dl>
                                <dl>
                                    <dt>구매예상</dt>
                                    <dd class="buychangeTool"><span class="blurring2"><span class="mask"></span><span class="cnt">0</span></span></dd>
                                </dl>
                            </div>
                            <div class="swiper-slide swiper-item10">
                                <strong>요실금 팬티</strong>
                                <i></i>
                                <dl>
                                    <dt>계약완료</dt>
                                    <dd class="finpanties"><span class="blurring2"><span class="mask"></span><span class="cnt">0</span></span></dd>
                                </dl>
                                <dl>
                                    <dt>구매예상</dt>
                                    <dd class="buypanties"><span class="blurring2"><span class="mask"></span><span class="cnt">0</span></span></dd>
                                </dl>
                            </div>
                            <div class="swiper-slide swiper-item11">
                                <strong>목욕의자</strong>
                                <i></i>
                                <dl>
                                    <dt>계약완료</dt>
                                    <dd class="finbathChair"><span class="blurring2"><span class="mask"></span><span class="cnt">0</span></span></dd>
                                </dl>
                                <dl>
                                    <dt>구매예상</dt>
                                    <dd class="buybathChair"><span class="blurring2"><span class="mask"></span><span class="cnt">0</span></span></dd>
                                </dl>
                            </div>
                            <div class="swiper-slide swiper-item12">
                                <strong>이동변기</strong>
                                <i></i>
                                <dl>
                                    <dt>계약완료</dt>
                                    <dd class="finmobileToilet"><span class="blurring2"><span class="mask"></span><span class="cnt">0</span></span></dd>
                                </dl>
                                <dl>
                                    <dt>구매예상</dt>
                                    <dd class="buymobileToilet"><span class="blurring2"><span class="mask"></span><span class="cnt">0</span></span></dd>
                                </dl>
                            </div>
                            <div class="swiper-slide swiper-item13">
                                <strong>간이변기</strong>
                                <i></i>
                                <dl>
                                    <dt>계약완료</dt>
                                    <dd class="finportableToilet"><span class="blurring2"><span class="mask"></span><span class="cnt">0</span></span></dd>
                                </dl>
                                <dl>
                                    <dt>구매예상</dt>
                                    <dd class="buyportableToilet"><span class="blurring2"><span class="mask"></span><span class="cnt">0</span></span></dd>
                                </dl>
                            </div>
                            <div class="swiper-slide swiper-item15">
                                <strong>경사로(실외용)</strong>
                                <i></i>
                                <dl>
                                    <dt>계약완료</dt>
                                    <dd class="finoutRunway"><span class="blurring2"><span class="mask"></span><span class="cnt">0</span></span></dd>
                                </dl>
                                <dl>
                                    <dt>구매예상</dt>
                                    <dd class="buyoutRunway"><span class="blurring2"><span class="mask"></span><span class="cnt">0</span></span></dd>
                                </dl>
                            </div>
                            <div class="swiper-slide swiper-item14">
                                <strong>경사로(실내용)</strong>
                                <i></i>
                                <dl>
                                    <dt>계약완료</dt>
                                    <dd class="fininRunway"><span class="blurring2"><span class="mask"></span><span class="cnt">0</span></span></dd>
                                </dl>
                                <dl>
                                    <dt>구매예상</dt>
                                    <dd class="buyinRunway"><span class="blurring2"><span class="mask"></span><span class="cnt">0</span></span></dd>
                                </dl>
                            </div>
                            <div class="swiper-slide swiper-item16">
                                <strong>전동침대</strong>
                                <i></i>
                                <dl>
                                    <dt>계약완료</dt>
                                    <dd class="finelectricBed"><span class="blurring2"><span class="mask"></span><span class="cnt">0</span></span></dd>
                                </dl>
                                <dl>
                                    <dt>구매예상</dt>
                                    <dd class="buyelectricBed"><span class="blurring2"><span class="mask"></span><span class="cnt">0</span></span></dd>
                                </dl>
                            </div>
                            <div class="swiper-slide swiper-item17">
                                <strong>수동침대</strong>
                                <i></i>
                                <dl>
                                    <dt>계약완료</dt>
                                    <dd class="finmanualBed"><span class="blurring2"><span class="mask"></span><span class="cnt">0</span></span></dd>
                                </dl>
                                <dl>
                                    <dt>구매예상</dt>
                                    <dd class="buymanualBed"><span class="blurring2"><span class="mask"></span><span class="cnt">0</span></span></dd>
                                </dl>
                            </div>
                            <div class="swiper-slide swiper-item18">
                                <strong>이동욕조</strong>
                                <i></i>
                                <dl>
                                    <dt>계약완료</dt>
                                    <dd class="finbathtub"><span class="blurring2"><span class="mask"></span><span class="cnt">0</span></span></dd>
                                </dl>
                                <dl>
                                    <dt>구매예상</dt>
                                    <dd class="buybathtub"><span class="blurring2"><span class="mask"></span><span class="cnt">0</span></span></dd>
                                </dl>
                            </div>
                            <div class="swiper-slide swiper-item19">
                                <strong>목욕리프트</strong>
                                <i></i>
                                <dl>
                                    <dt>계약완료</dt>
                                    <dd class="finbathLift"><span class="blurring2"><span class="mask"></span><span class="cnt">0</span></span></dd>
                                </dl>
                                <dl>
                                    <dt>구매예상</dt>
                                    <dd class="buybathLift"><span class="blurring2"><span class="mask"></span><span class="cnt">0</span></span></dd>
                                </dl>
                            </div>
                            <div class="swiper-slide swiper-item20">
                                <strong>배회감지기</strong>
                                <i></i>
                                <dl>
                                    <dt>계약완료</dt>
                                    <dd class="findetector"><span class="blurring2"><span class="mask"></span><span class="cnt">0</span></span></dd>
                                </dl>
                                <dl>
                                    <dt>구매예상</dt>
                                    <dd class="buydetector"><span class="blurring2"><span class="mask"></span><span class="cnt">0</span></span></dd>
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

        <a class="grade-floating consulting" onclick="clickStartConsltBtn();">
            <strong>상담하기</strong>
        </a>
        
         <!-- 상담 신청하기 지원 모달 -->
		<jsp:include page="/WEB-INF/jsp/common/modal/recipient_and_conslt_modal.jsp" />
    </div>
</div>

<script src="/html/core/script/formatter.js"></script>
<script src="/html/page/index/assets/script/JsRecipterLongtermDisp.js"></script>
<script>
    let grdMaster ;
    $(document).ready(function() {
        grdMaster = new JsRecipterLongtermDisp();
        grdMaster.fn_init_page('${_mainPath}');
        
    });

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

			let CodeMap = new Map();
			let code = "${apiCode}";
			code = code.replaceAll("{","").replaceAll("}","").replaceAll(" ","").split(",");

			for(let v=0; v<code.length; v++){
				let str = code[v];
				str = str.split("=");
				CodeMap.set(str[1], str[0]);
			}

            grdMaster.fn_data_CodeMap(CodeMap);
	        grdMaster.fn_data_received_getRecipterInfo(json);

            $('.careinfo-mask').addClass('is-active');
            
            
            //채널톡 이벤트 처리
            eventChannelTalk('view_infocheck_success', json.infoMap.ownList);
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
	var recipientsNo = '${recipientsNo}';
	openModal('requestConslt', Number(recipientsNo), 'simpleSearch');
}


//채널톡 event 처리 (요양정보 조회 페이지 실행, 1:1 상담하기 버튼 실행)
function eventChannelTalk(eventName, ownList) {
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
	}
	
	ChannelIO('track', eventName, propertyObj);
	 
	 
	//GA 이벤트 처리
	var gaProp = {
		grade,
	};
	
	if (eventName === 'view_infocheck_success' && ownList) {
		var ableCtgList = [];
		var ownListKeys = Object.keys(ownList);
		for(var i = 0; i < ownListKeys.length; i++) {
			var ctgInfo = ownList[ownListKeys[i]];
			if (ctgInfo.ableYn === "Y" && ctgInfo.ableCnt > 0) {
				ableCtgList.push(ctgInfo.itemGrpNm);
			}
		}
		
		gaProp.remainingAmt = remainingAmt;
		gaProp.ableCtgList = ableCtgList.join(', ');
	}
	
	gtag('event', eventName, gaProp);
}


$(function() {
	//바로 조회하기
	getRecipterInfo();
	

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
