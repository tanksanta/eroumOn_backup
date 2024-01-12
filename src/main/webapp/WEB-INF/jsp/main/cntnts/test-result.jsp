<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<header id="subject">
    <nav class="breadcrumb">
        <ul>
            <li class="home"><a href="#">홈</a></li>
            <li>이로움 서비스</li>
            <li>인정 등급 예상 테스트</li>
        </ul>
    </nav>
</header>

<div id="content">
    <div class="result-content1">
        <h2 class="grade-title2">
            <small>노인장기요양보험</small>
            인정등급 예상 테스트
        </h2>
        <p class="warning">※ 보건복지부에서 고시한 장기 요양 등급 판정 기준을 근거로 만들어진 테스트로, <strong>실제 등급 판정 결과와 상이할 수 있어요.</strong></p>
        <div class="result">
            <div class="container">
                
            </div>
        </div>
        <div class="explan">
            <li>
                <dl>
                    <dt><strong>1</strong>등급</dt>
                    <dd>
                        95점~<br>
                        <em>전적 도움</em>
                    </dd>
                </dl>
            </li>
            <li>
                <dl>
                    <dt><strong>2</strong>등급</dt>
                    <dd>
                        94점~75점<br>
                        <em>상당부분 도움</em>
                    </dd>
                </dl>
            </li>
            <li>
                <dl>
                    <dt><strong>3</strong>등급</dt>
                    <dd>
                        74점~60점<br>
                        <em>부분적 도움</em>
                    </dd>
                </dl>
            </li>
            <li>
                <dl>
                    <dt><strong>4</strong>등급</dt>
                    <dd>
                        59점~51점<br>
                        <em>일정부분 도움</em>
                    </dd>
                </dl>
            </li>
            <li>
                <dl>
                    <dt><strong>5</strong>등급</dt>
                    <dd>
                        50점~ 45점<br>
                        <em>노인성질병 치매</em>
                    </dd>
                </dl>
            </li>
            <li>
                <dl>
                    <dt><strong>인지지원</strong> 등급</dt>
                    <dd>
                        45점 이하<br>
                        <em>노인성질병 치매</em>
                    </dd>
                </dl>
            </li>
        </div>
        
        <c:choose>
            <c:when test="${_mbrSession.loginCheck}">
                <div class="mainSend">
                    <form class="provide-form">
                        <div class="form-agree">                                    
                            <div class="flex gap-3 items-center py-2 justify-center">
                            <input class="rounded-md border-2 relative" style="width: 1.4rem; height: 1.4rem;" type="checkbox" name="chk-email" id="chk-email">
                            <label class="form-check-label text-1xl" for="chk-email">나에게 예상 테스트 결과 보내기</label>
                            </div>
                        </div>                        
                        <ul>
                            <li> 예상 테스트 결과를 메일로 보내고 1:1상담을 신청하세요.</li>
                            <li> 이 페이지를 벗어나면 더 이상 결과를 확인할 수 없어요.</li>
                        </ul>                   
                    </form>
                </div>
            </c:when>
            <c:otherwise>
                <%-- <button type="button" class="btn btn-primary large w-[52.5%]" onclick="location.href='/membership/conslt/appl/list'">메일보내기</button> --%> 
            </c:otherwise>
        </c:choose>
        
    </div>

    <div class="result-content2">
        <h2 class="grade-title">
            전문가 상담
            <small>무료 전문가 상담으로 등급 신청까지 의뢰 가능해요.</small>
            <c:if test="${_mbrSession.loginCheck}">
            	<small>아래 1:1 상담하기 버튼을 눌러주세요.</small>	
            </c:if>
        </h2>
        
        <c:if test="${_mbrSession.loginCheck}">
        	<div class="images" onclick="clickStartConsltBtn();" style="cursor:pointer;">
	            <img src="/html/page/index/assets/images/img-grade-result1.svg" alt="전문가 상담 이미지">
	        </div>
        </c:if>
        <c:if test="${!_mbrSession.loginCheck}">
        	<div class="images">
	            <img src="/html/page/index/assets/images/img-grade-result1.svg" alt="전문가 상담 이미지">
	        </div>
        </c:if>
    </div>
    
    <div class="result-content3">
        <h2 class="grade-title">
            예상 복지용구 확인
            <small>
                내가 신청할 수 있는 예상 복지용구를 확인해보세요.<br>
                실제 수령하는 복지용구와는 다를 수 있어요.
            </small>
        </h2>
        <div class="grade-slider mt-9 md:mt-7.5">
            <div class="swiper">
                <div class="swiper-wrapper">
                    
                </div>
            </div>
            <div class="swiper-button-prev"></div>
            <div class="swiper-button-next"></div>
        </div>
    </div>
    
    <div class="result-content4">
        <h2 class="grade-title">
            상세 결과 확인
            <small>테스트 문항과 내가 선택한 답변을 확인하세요.</small>
        </h2>

		<!-- 
        <div class="text-right mt-4 mb-5 md:mt-35 md:-mb-35">
            <button type="button" class="result-share">공유하기</button>
        </div>
         -->

        <h3 class="result-question">
            <img src="/html/page/index/assets/images/img-grade-result2.svg" alt="" class="w-6 md:w-12">
            신체기능
        </h3>

        <div id="physical-select" class="mt-5 space-y-1 md:mt-5.5 md:space-y-1.5">
            <dl class="result-answer">
                <dt>옷 벗고 입기가 가능하십니까?</dt>
                <dd></dd>
            </dl>
            <dl class="result-answer">
                <dt>세수하기가 가능하십니까?</dt>
                <dd></dd>
            </dl>
            <dl class="result-answer">
                <dt>양치질하기가 가능하십니까?</dt>
                <dd></dd>
            </dl>
            <dl class="result-answer">
                <dt>목욕하기가 가능하십니까?</dt>
                <dd></dd>
            </dl>
            <dl class="result-answer">
                <dt>식사하기가 가능하십니까?</dt>
                <dd></dd>
            </dl>
            <dl class="result-answer">
                <dt>체위 변경하기가 가능하십니까?</dt>
                <dd></dd>
            </dl>
            <dl class="result-answer">
                <dt>일어나 앉기가 가능하십니까?</dt>
                <dd></dd>
            </dl>
            <dl class="result-answer">
                <dt>옮겨앉기가 가능하십니까?</dt>
                <dd></dd>
            </dl>
            <dl class="result-answer">
                <dt>방 밖으로 나오기가 가능하십니까?</dt>
                <dd></dd>
            </dl>
            <dl class="result-answer">
                <dt>화장실 사용하기가 가능하십니까?</dt>
                <dd></dd>
            </dl>
            <dl class="result-answer">
                <dt>대변 조절하기가 가능하십니까?</dt>
                <dd></dd>
            </dl>
            <dl class="result-answer">
                <dt>소변 조절하기가 가능하십니까?</dt>
                <dd></dd>
            </dl>
        </div>

        <h3 class="result-question mt-21 md:mt-42">
            <img src="/html/page/index/assets/images/img-grade-result3.svg" alt="" class="w-7.5 md:w-15">
            인지기능
        </h3>
        <div class="mt-7.5 space-y-7.5 md:mt-6 md:space-y-15">
            <div class="space-y-1 md:space-y-1.5">
                <dl id="cognitive-select" class="result-answer3">
                </dl>
            </div>
        </div>
        
        <h3 class="result-question mt-21 md:mt-42">
            <img src="/html/page/index/assets/images/img-grade-result4.svg" alt="" class="w-11 md:w-22">
            행동변화
        </h3>
        <div class="mt-7.5 space-y-7.5 md:mt-6 md:space-y-15">
            <div class="space-y-1 md:space-y-1.5">
                <dl id="behavior-select" class="result-answer3">
                </dl>
            </div>
        </div>
        
        <h3 class="result-question mt-21 md:mt-42">
            <img src="/html/page/index/assets/images/img-grade-result5.svg" alt="" class="w-10 md:w-[4.875rem]">
            간호처치
        </h3>
        <div class="mt-7.5 space-y-7.5 md:mt-6 md:space-y-15">
            <div class="space-y-1 md:space-y-1.5">
                <dl id="nurse-select" class="result-answer3">
                </dl>
            </div>
        </div>
        
        <h3 class="result-question mt-21 md:mt-42">
            <img src="/html/page/index/assets/images/img-grade-result6.svg" alt="" class="w-[2.8125rem] md:w-[5.625rem]">
            재활
        </h3>
        <div id="rehabilitate-select" class="mt-7.5 space-y-7.5 md:mt-6 md:space-y-15">
            <div class="space-y-1 md:space-y-1.5">
                <h4 class="text-xl font-bold md:mb-2.5 md:text-2xl">운동장애 정도</h4>
                <dl class="result-answer">
                    <dt>오른쪽 상지(손, 팔, 어깨)가 의지대로 움직이시나요?</dt>
                    <dd></dd>
                </dl>
                <dl class="result-answer">
                    <dt>오른쪽 하지(발, 다리)가 의지대로 움직이시나요?</dt>
                    <dd></dd>
                </dl>
                <dl class="result-answer">
                    <dt>왼쪽 상지(손, 팔, 어깨)가 의지대로 움직이시나요?</dt>
                    <dd></dd>
                </dl>
                <dl class="result-answer">
                    <dt>왼쪽 하지(발, 다리)가 의지대로 움직이시나요?</dt>
                    <dd></dd>
                </dl>
            </div>
            <div class="space-y-1 md:space-y-1.5">
                <h4 class="text-xl font-bold md:mb-2.5 md:text-2xl">운동제한 정도</h4>
                <dl class="result-answer">
                    <dt>어깨관절이 자유롭게 움직이시나요?</dt>
                    <dd></dd>
                </dl>
                <dl class="result-answer">
                    <dt>팔꿈치관절이 자유롭게 움직이시나요?</dt>
                    <dd></dd>
                </dl>
                <dl class="result-answer">
                    <dt>손목 및 손관절이 자유롭게 움직이시나요?</dt>
                    <dd></dd>
                </dl>
                <dl class="result-answer">
                    <dt>고관절(엉덩이관절)이 자유롭게 움직이시나요?</dt>
                    <dd></dd>
                </dl>
                <dl class="result-answer">
                    <dt>무릎관절이 자유롭게 움직이시나요?</dt>
                    <dd></dd>
                </dl>
                <dl class="result-answer">
                    <dt>발목관절이 자유롭게 움직이시나요?</dt>
                    <dd></dd>
                </dl>
            </div>
        </div>
        
        <h3 class="result-question mt-21 md:mt-42">
            <img src="/html/page/index/assets/images/img-grade-result7.svg" alt="" class="w-10 md:w-20">
            질병
        </h3>
        <div class="mt-7.5 space-y-7.5 md:mt-6 md:space-y-15">
            <dl id="disease-select-1" class="result-answer2">
            </dl>
            <dl id="disease-select-2" class="result-answer2">
            </dl>
        </div>
    </div>

	<!--
    <div class="text-right mt-6">
        <button type="button" class="result-share">공유하기</button>
    </div>
    -->

    <div class="result-content5">
        다른 결과를 확인하고 싶으시다면? <a href="#" onclick="restartTest();">테스트 다시하기</a>
    </div>
    <div class="grade-floating">
        <button id="go-consult">다른 혜택 확인하기</button>
    </div>
    
    
    <!-- 공유하기 모달 start-->
    <button href="#modal-email" data-bs-toggle="modal" data-bs-target="#modal-email" type="button" class="result-share" style="display: none;">공유하기</button>
    <div class="modal fade" id="modal-email" tabindex="-1">
        <div class="modal-dialog modal-dialog-centered">
            <div class="modal-content-email">
                <div class="modal-header">
                    <p>테스트 결과 메일로 보내기</p>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="close"></button>
                </div>
                <div class="modal-bod">
                    <form class="provide-form" >                            
                        <fieldset class="form-fieldset" style="background-color: transparent;">   
                            <div class="md:flex gap-1 items-center">                                        
                                <label for="form-item5" style="display: none;">이메일</label>
                                <div>
                                    <div class="md:flex gap-1 items-center">
                                        <input id="email-front" type="text" placeholder="이메일주소" class="form-control w-full xs:max-w-40">
                                        <i>@</i>
                                        <input id="email-back" type="text" placeholder="직접입력"  class="form-control w-full xs:max-w-40">
                                        <select id="select-email" name="select-email" class="form-control w-full xs:max-w-40">
                                            <option value="">선택해 주세요</option>
                                            <option value="naver.com">naver.com</option>
                                            <option value="hanmail.net">hanmail.net</option>
                                            <option value="daum.net">daum.net</option>
                                            <option value="gmail.com">gmail.com</option>
                                            <option value="kakao.com">kakao.com</option>
                                            <option value="nate.com">nate.com</option>
                                            <option value="hotmail.com">hotmail.com</option>                                                   
                                        </select>
                                    </div>
                                </div>
                            </div>                                   
                        </fieldset>                            
                     </form>            
                </div>
                <div class="modal-footer">
                    <a id='sendEmailBtn'  href="#" class="btn large btn-primary w-36">전송하기</a>
                </div>
            </div>
        </div>
    </div>
    <!-- 공유하기 모달 end-->
    
    <!-- 예상치 못한 오류 팝업 -->
    <div class="modal modal-default fade" id="modalError" tabindex="-1" aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered ">
            <div class="modal-content">
                <div class="modal-header">
                </div>
                <div class="modal-body md:min-w-[26rem]">
                    <!-- 예상치 못한 오류로 결과를 확인할 수 없는 상황에 호출되는 모달(팝업) -->
                    <div class="flex flex-col items-center text-xl">
                        <i class="ico-alert orange mb-8"></i>
                        <p>죄송합니다</p>
                        <p><strong>일시적 오류</strong>가 발생했습니다</p>
                        <p>잠시후 다시 시도해 주세요</p>
                    </div>
                    <!--// 예상치 못한 오류로 결과를 확인할 수 없는 상황에 호출되는 모달(팝업) -->
                </div>
                <div class="modal-footer">
                    <a href="/main/cntnts/test" class="btn btn-primary">테스트 시작하기</a>
                </div>
            </div>
        </div>
    </div>
    
    <!-- 상담 신청하기 지원 모달 -->
	<jsp:include page="/WEB-INF/jsp/common/modal/add_recip_or_conslt_modal.jsp" />
    
    
    <script>
    	var testResult = {};
    	
    	//상담하기 버튼 클릭
    	function clickStartConsltBtn() {
    		var testData = JSON.parse(sessionStorage.getItem('testData'));
        	//테스트 결과가 없을 시
        	if (!testData) {
        		$('#modalError').modal('show');
        		return;
        	}
    		
    		var recipientsNo = testData.recipientsNo;
            openRecipientOrConsltModal('requestConslt', Number(recipientsNo), 'test');
    	}


    	//채널톡 event 처리 (테스트 결과보기 페이지 실행)
		function eventChannelTalk(eventName) {
		    //예상결과 등급
		    var grade = testResult.grade;
		    
		    var propertyObj = {
		   		 grade
		   	}
		    
		    //테스트 완료 일자(현재시간)
		    if (eventName === 'view_testresult') {
		    	//테스트 완료 일자
		    	var now = new Date();
		    	propertyObj.testEndDate = now.getFullYear() + '년 ' + String(now.getMonth() + 1).padStart(2, "0") + '월 ' + String(now.getDate()).padStart(2, "0") + '일';
		    }
		    
		    ChannelIO('track', eventName, propertyObj);
		     
		     
		    //GA 이벤트 처리
		    var gaProp = {
		        grade,
		    };
		    
			gtag('event', eventName, gaProp);
		}
    	
    	
        $(function() {
        	loadTestResult();
    		
        	
            var swiper = new Swiper(".swiper", {
                loop: true,
                slidesPerView: 2,
                spaceBetween : 0,
                grid: {
                    rows: 2,
                },
                speed: 1000,
                autoplay: {
                    delay: 5000,
                    disableOnInteraction: false,
                },
                breakpoints: {
                    480: {
                        grid: {
                            rows: 1,
                        },
                        slidesPerView: 3,
                    },
                    768: {
                        grid: {
                            rows: 1,
                        },
                        slidesPerView: 4
                    },
                    1024: {
                        grid: {
                            rows: 1,
                        },
                        slidesPerView: 6
                    }
                },
                navigation: {
                    prevEl: '.swiper-button-prev',
                    nextEl: '.swiper-button-next'
                },
            });
            
            //테스트 결과 조회 ajax
            function getTestResultAjax(recipientsNo) {
            	var result = null;
            	$.ajax({
            		type: "get",
            		url: "/test/result.json",
            		data: {recipientsNo},
            		dataType : 'json',
            		async: false
            	})
            	.done(function(res) {
            		if (res.success) {
            			result = JSON.parse(res.mbrTestResult);
            		}
            	})
            	.fail(function(data, status, err) {
            		alert('통신중 오류가 발생하였습니다.');
            	});
            	return result;
            }
            
            //로딩시 테스트 결과 조회
            function loadTestResult() {
            	var testData = JSON.parse(sessionStorage.getItem('testData'));
            	//테스트 결과가 없을 시
            	if (!testData) {
            		$('#modalError').modal('show');
            		return;
            	}
            	
            	if (testData.isLogin) {
            		//api 방식으로 테스트결과 가져오기
            		testResult = getTestResultAjax(testData.recipientsNo);
            		//api 요청 후 테스트 결과가 없을 시
                	if (!testResult) {
                		$('#modalError').modal('show');
                		return;
                	}
            		
            		$('#go-consult').css({'display':'flex', 'cursor':'pointer'});
            	}
            	else {
            		var finalTestResult = JSON.parse(sessionStorage.getItem('finalTestResult'));
            		//세션 방식으로 테스트결과 가져오기
            		testResult = {
            			...testData,
            			...finalTestResult,
            		};
            		
            		$('#go-consult').css('display', 'none');
            	}
            	
            	
            	//등급 문구 표시
            	drawTestResultGradeAndScore(testResult.grade, testResult.score);
            	//복지용구 표시
            	drawWelfareEquipment();
            	//내가 선택한 문항결과 확인
            	drawMbrTestSelectResult();
            	
            	
            	//채널톡 이벤트 처리
            	eventChannelTalk('view_testresult');
            }
            
            //등급 문구 표시
            function drawTestResultGradeAndScore(grade, score) {
            	$('.explan li').each(function (index, item) { $(item).removeClass('is-active') });
            	
            	let templete = `
            		<div class="grade">
	                    <strong>((grade))</strong>
	                    <small>등급</small>
	                </div>
	                <p class="point">장기요양인정 예상점수 : <strong>((score))점</strong></p>
	                <p class="desc">보건복지부에서 고시한 장기 요양 등급 판정 기준을 근거로 만들어진 테스트로, <strong class="underline">실제 등급 판정 결과와 상이할 수 있어요.</strong></p>
            	`;
            	
            	switch (grade) {
            		case 1 : {
            			templete += `
                            <p class="cost"><strong>월 188만원</strong>의 한도액 내에서 재가급여 또는 주야간센터를 이용할 수 있어요.</p>
                            <p class="cost"><strong>연 160만원</strong>의 한도액 내에서 복지용구 대여 또는 구입할 수 있어요.</p>
                            <ul class="alert">
                                <li><strong>6~15%의 본인부담금이 발생(기초생활수급자는 전액 지원)</strong></li>
                                <li>1~2등급 어르신은 재가급여 대신 시설급여 선택 가능(시설급여 선택 시 복지용구 신청 불가)</li>
                            </ul>
                        `
                        $('.explan li:nth-child(1)').addClass('is-active');
            			break;
            		}
            		case 2 : {
            			templete += `
                            <p class="cost"><strong>월 186만원</strong>의 한도액 내에서 재가급여 또는 주야간센터를 이용할 수 있어요.</p>
                            <p class="cost"><strong>연 160만원</strong>의 한도액 내에서 복지용구 대여 또는 구입할 수 있어요.</p>
                            <ul class="alert">
                                <li><strong>6~15%의 본인부담금이 발생(기초생활수급자는 전액 지원)</strong></li>
                                <li>1~2등급 어르신은 재가급여 대신 시설급여 선택 가능(시설급여 선택 시 복지용구 신청 불가)</li>
                            </ul>
                        `
                        $('.explan li:nth-child(2)').addClass('is-active');
            			break;
            		}
            		case 3 : {
            			templete += `
                            <p class="cost"><strong>월 145만원</strong>의 한도액 내에서 재가급여 또는 주야간센터를 이용할 수 있어요.</p>
                            <p class="cost"><strong>연 160만원</strong>의 한도액 내에서 복지용구 대여 또는 구입할 수 있어요.</p>
                            <ul class="alert">
                                <li><strong>6~15%의 본인부담금이 발생(기초생활수급자는 전액 지원)</strong></li>
                                <li>조건 부합 시, 재가급여 대신 시설 급여 선택 가능(시설급여 선택 시 복지용구 신청 불가)</li>
                            </ul>
                        `
                        $('.explan li:nth-child(3)').addClass('is-active');
            			break;
            		}
            		case 4 : {
            			templete += `
                            <p class="cost"><strong>월 134만원</strong>의 한도액 내에서 재가급여 또는 주야간센터를 이용할 수 있어요.</p>
                            <p class="cost"><strong>연 160만원</strong>의 한도액 내에서 복지용구 대여 또는 구입할 수 있어요.</p>
                            <ul class="alert">
                                <li><strong>6~15%의 본인부담금이 발생(기초생활수급자는 전액 지원)</strong></li>
                                <li>조건 부합 시, 재가급여 대신 시설 급여 선택 가능(시설급여 선택 시 복지용구 신청 불가)</li>
                            </ul>
                        `
                        $('.explan li:nth-child(4)').addClass('is-active');
            			break;
            		}
            		case 5 : {
            			templete += `
                            <p class="cost"><strong>월 115만원</strong>의 한도액 내에서 재가급여 또는 주야간센터를 이용할 수 있어요.</p>
                            <p class="cost"><strong>연 160만원</strong>의 한도액 내에서 복지용구 대여 또는 구입할 수 있어요.</p>
                            <ul class="alert">
                                <li><strong>6~15%의 본인부담금이 발생(기초생활수급자는 전액 지원)</strong></li>
                                <li>조건 부합 시, 재가급여 대신 시설 급여 선택 가능(시설급여 선택 시 복지용구 신청 불가)</li>
                            </ul>
                        `
                        $('.explan li:nth-child(5)').addClass('is-active');
            			break;
            		}
            		default: {
            			//5등급 미만인 경우는 등급 및 점수 표시 HTML 재정의
            			templete = `
                    		<div class="grade">
        	                    <strong class="!text-2xl md:!text-4xl">((grade))</strong>
        	                </div>
        	                <p class="point">장기요양인정 예상점수 : <strong>((score))점</strong></p>
        	                <p class="desc">보건복지부에서 고시한 장기 요양 등급 판정 기준을 근거로 만들어진 테스트로, <strong class="underline">실제 등급 판정 결과와 상이할 수 있어요.</strong></p>
                    	`;
            			
            			//치매환자 인경우
            			if (testResult.diseaseSelect1 && testResult.diseaseSelect1[0] 
            				|| testResult.diseaseSelect2 && testResult.diseaseSelect2[0]) {
            				grade = '인지지원';
            				
            				templete += `
                                <p class="cost"><strong>월 64만원</strong>의 한도액 내에서 재가급여 또는 주야간센터를 이용할 수 있어요.</p>
                                <p class="cost"><strong>연 160만원</strong>의 한도액 내에서 복지용구 대여 또는 구입할 수 있어요.</p>
                                <ul class="alert">
                                    <li><strong>6~15%의 본인부담금이 발생(기초생활수급자는 전액 지원)</strong></li>
                                </ul>
                            `
            				$('.explan li:nth-child(6)').addClass('is-active');
            			} else {
            				grade = '등급 외';
            				
            				templete += `
                                <p class="cost">장기요양보험 <strong>혜택 불가</strong></p>
                                <ul class="alert">
                                    <li>등급판정은 "건강이 매우 안좋다", "큰 병에 걸렸다." 등과 같은 주관적인 개념이 아닌 
                                    "심신의 기능에 따라 일상생활에서 도움이 얼마나 필요한가?"를 기준으로 판단해요.</li>
                                </ul>
                            `
            			}
            			break;
            		}
            	}
            	
            	//등급, 점수값 넣기
            	templete = templete.replace('((grade))', grade);
            	templete = templete.replace('((score))', score);
            	
            	$('.result .container').html(templete);
            }
            
            //복지용구 표시
            function drawWelfareEquipment() {
            	const walfareEquipments = {
            		'성인용보행기': true,
            		'수동휠체어': true,
            		'지팡이': true,
            		'안전손잡이': true,
            		'미끄럼방지 매트': true,
            		'미끄럼방지 양말': true,
            		'욕창예방 매트리스': true,
            		'욕창예방 방석': true,
            		'자세변환용구': true,
            		'요실금 팬티': true,
            		'목욕의자': true,
            		'이동변기': true,
            		'간이변기': true,
            		'경사로': true,
            	};
            	
                //문서 1페이지
                if (testResult && testResult.physicalSelect
                    && testResult.physicalSelect[10] == 3    //대변변조절하기 [완전도움]
                    && testResult.physicalSelect[11] == 3)   //소변조절하기 [완전도움] 
                { 
                    //이동변기 품목제외
                	walfareEquipments['이동변기'] = false;
                }
                if (testResult && testResult.physicalSelect
                    && testResult.physicalSelect[5] == 3    //체위변경하기 [완전도움]
                    && testResult.physicalSelect[6] == 3)   //일어나 앉기 [완전도움] 
                {
                    //목욕의자 품목제외
                	walfareEquipments['목욕의자'] = false;
                }
                if (testResult && testResult.rehabilitateSelect
                    && 
                    ((testResult.rehabilitateSelect[0] == 3 && testResult.rehabilitateSelect[2] == 3)       //우측, 좌측상지 모두 [완전운동장애]
                    || (testResult.rehabilitateSelect[1] == 3 && testResult.rehabilitateSelect[3] == 3)))   //우측, 좌측하지 모두 [완전운동장애] 
                { 
                    //보행차 품목제외(보행차 -> 성인용 보행기)
                	walfareEquipments['성인용보행기'] = false;
                }
                if (testResult && testResult.physicalSelect &&
                    testResult && testResult.rehabilitateSelect
                    && 
                    ((testResult.physicalSelect[8] == 3)  //방 밖으로나가기 [완전도움]
                    || (testResult.rehabilitateSelect[0] == 3 && testResult.rehabilitateSelect[2] == 3)     //우측, 좌측상지 모두 [완전운동장애]
                    || (testResult.rehabilitateSelect[1] == 3 && testResult.rehabilitateSelect[3] == 3)))   //우측, 좌측하지 모두 [완전운동장애]
                { 
                    //보행 보조차 품목제외(보행보조차 -> 성인용 보행기)
                	walfareEquipments['성인용보행기'] = false;
                }
                if (testResult && testResult.rehabilitateSelect
                    && (testResult.rehabilitateSelect[0] == 3 && testResult.rehabilitateSelect[2] == 3))   //우측, 좌측상지 모두 [완전운동장애]
                {
                    //안전 손잡이 품목제외
                	walfareEquipments['안전손잡이'] = false;
                }
                if (testResult && testResult.rehabilitateSelect
                    && (testResult.rehabilitateSelect[1] == 3 && testResult.rehabilitateSelect[3] == 3))   //우측, 좌측하지 모두 [완전운동장애]
                {
                    //미끄럼 방지용품 품목제외(미끄럼 방지용품 -> 미끄럼방지 매트, 미끄럼방지 양말)
                	walfareEquipments['미끄럼방지 매트'] = false;
                	walfareEquipments['미끄럼방지 양말'] = false;
                }
                if (testResult && testResult.rehabilitateSelect
                    && 
                    ((testResult.rehabilitateSelect[0] == 3 && testResult.rehabilitateSelect[2] == 3)       //우측, 좌측상지 모두 [완전운동장애]
                    || (testResult.rehabilitateSelect[1] == 3 && testResult.rehabilitateSelect[3] == 3)))   //우측, 좌측하지 모두 [완전운동장애]
                {
                    //지팡이 품목제외
                	walfareEquipments['지팡이'] = false;
                }
                
                //문서 2페이지
                if (testResult && testResult.physicalSelect
                    && testResult.physicalSelect[5] == 1    //체위변경하기   [완전자립]
                    && testResult.physicalSelect[7] == 1    //옮겨 앉기     [완전자립]
                    && testResult.physicalSelect[8] == 1)   //방밖으로 나가기 [완전자립]
                {
                    //욕창 예방 방석 품목제외
                	walfareEquipments['욕창예방 방석'] = false;
                }
                if (testResult && testResult.physicalSelect
                    && testResult.physicalSelect[5] == 1    //체위변경하기  [완전자립]
                    && testResult.physicalSelect[6] == 1)   //일어나 앉기  [완전자립]
                {
                    //자세 변환 용구 품목제외
                	walfareEquipments['자세변환용구'] = false;
                }
                if (testResult && testResult.physicalSelect
                    && testResult.physicalSelect[8] == 1)   //방밖으로 나가기 [완전자립]
                {
                    //전동 침대 품목제외(이로움온 품목이 없어서 코드는 없음)
                    //수동 침대 품목제외(이로움온 품목이 없어서 코드는 없음)
                }
                if (testResult && testResult.physicalSelect &&
                    testResult && testResult.nurseSelect
                    && 
                    (testResult.physicalSelect[5] == 1     //체위변경하기 [완전자립]
                     && testResult.physicalSelect[6] == 1  //일어나 앉기  [완전자립]
                     && testResult.physicalSelect[7] == 1  //옮겨 앉기   [완전자립]
                     && testResult.nurseSelect[3] == 0))    //욕창간호   [없음]
                { 
                    //욕창 예방 매트리스 품목제외
                	walfareEquipments['욕창예방 매트리스'] = false;
                }
                if (testResult && testResult.physicalSelect
                    && testResult.physicalSelect[8] == 1)   //방밖으로 나가기 [완전자립]
                {
                    //이동 욕조 품목제외(이로움온 품목이 없어서 코드는 없음)
                    //목욕리프트 품목제외(이로움온 품목이 없어서 코드는 없음)
                }
            	
                let templete = '';
                if(walfareEquipments['성인용보행기']) {
                	templete += '<div class="swiper-slide"><a><img src="/html/page/index/assets/images/img-page2-category1.png" alt="성인용보행기"></a></div>';
                }
                if(walfareEquipments['수동휠체어']) {
                	templete += '<div class="swiper-slide"><a><img src="/html/page/index/assets/images/img-page2-category2.png" alt="수동휠체어"></a></div>';
                }
                if(walfareEquipments['지팡이']) {
                	templete += '<div class="swiper-slide"><a><img src="/html/page/index/assets/images/img-page2-category3.png" alt="지팡이"></a></div>';
                }
                if(walfareEquipments['안전손잡이']) {
                	templete += '<div class="swiper-slide"><a><img src="/html/page/index/assets/images/img-page2-category4.png" alt="안전손잡이"></a></div>';
                }
                if(walfareEquipments['미끄럼방지 매트']) {
                	templete += '<div class="swiper-slide"><a><img src="/html/page/index/assets/images/img-page2-category5.png" alt="미끄럼방지 매트"></a></div>';
                }
                if(walfareEquipments['미끄럼방지 양말']) {
                	templete += '<div class="swiper-slide"><a><img src="/html/page/index/assets/images/img-page2-category6.png" alt="미끄럼방지 양말"></a></div>';
                }
                if(walfareEquipments['욕창예방 매트리스']) {
                	templete += '<div class="swiper-slide"><a><img src="/html/page/index/assets/images/img-page2-category7.png" alt="욕창예방 매트리스"></a></div>';
                }
                if(walfareEquipments['욕창예방 방석']) {
                	templete += '<div class="swiper-slide"><a><img src="/html/page/index/assets/images/img-page2-category8.png" alt="욕창예방 방석"></a></div>';
                }
                if(walfareEquipments['자세변환용구']) {
                	templete += '<div class="swiper-slide"><a><img src="/html/page/index/assets/images/img-page2-category9.png" alt="자세변환용구"></a></div>';
                }
                if(walfareEquipments['요실금 팬티']) {
                	templete += '<div class="swiper-slide"><a><img src="/html/page/index/assets/images/img-page2-category10.png" alt="요실금 팬티"></a></div>';
                }
                if(walfareEquipments['목욕의자']) {
                	templete += '<div class="swiper-slide"><a><img src="/html/page/index/assets/images/img-page2-category11.png" alt="목욕의자"></a></div>';
                }
                if(walfareEquipments['이동변기']) {
                	templete += '<div class="swiper-slide"><a><img src="/html/page/index/assets/images/img-page2-category12.png" alt="이동변기"></a></div>';
                }
                if(walfareEquipments['간이변기']) {
                	templete += '<div class="swiper-slide"><a><img src="/html/page/index/assets/images/img-page2-category13.png" alt="간이변기"></a></div>';
                }
                if(walfareEquipments['경사로']) {
                	templete += '<div class="swiper-slide"><a><img src="/html/page/index/assets/images/img-page2-category14.png" alt="경사로"></a></div>';
                }
                
                $('.swiper-wrapper').html(templete);
            }
            
          	//내가 선택한 문항결과 확인
          	function drawMbrTestSelectResult() {
          		//신체기능 문항
          		if (testResult && testResult.physicalSelect) {
          			$('#physical-select .result-answer dd').each(function (index, item) {
             			 $(item).html(testResult.physicalSelect[index] == 1 ? '혼자서 가능' :
             			   			  testResult.physicalSelect[index] == 2 ? '일부 도움 필요' :
             			   			  testResult.physicalSelect[index] == 3 ? '완전히 도움 필요' : '')
             		});	
          		}
          		
          		//인지기능 문항
          		if (testResult && testResult.cognitiveSelect) {
          			const cognitiveQuestion = [
              			'방금 전에 들었던 이야기나 일을 잊는다.',
              			'오늘이 몇 년, 몇 월, 몇 일인지 모른다.',
              			'자신이 있는 장소를 알지 못한다.',
              			'자신의 나이와 생일을 모른다.',
              			'지시를 이해하지 못한다.',
              			'주어진 상황에 대한 판단력이 떨어져 있다.',
              			'의사소통이나 전달에 장애가 있다.',
              		];
              		
              		let cognitiveTemplete = '<dt>최근 한 달간의 상황을 종합하여 아래 항목 중 해당하는 모든 증상을 선택해 주세요.</dt>';
              		
              		//선택한 문항이 없는 경우
              		if (testResult.cognitiveSelect.findIndex(select => select === 1) === -1) {
              			cognitiveTemplete += '<dd>해당하는 증상이 없다.</dd>'
              		} else {
              			for (var i = 0; i < testResult.cognitiveSelect.length; i++) {
                  			if (testResult.cognitiveSelect[i]) {
                  				cognitiveTemplete += '<dd>' + cognitiveQuestion[i] + '</dd>';
                  			}
                  		}
              		}
              		
              		$('#cognitive-select').html(cognitiveTemplete);
          		}
          		
          		//행동변화
          		if (testResult && testResult.behaviorSelect) {
          			const behaviorQuestion = [
          				'사람들이 무엇을 훔쳤다고 믿거나, 자기를 해하려 한다고 잘못 믿고 있다.',
          				'헛것을 보거나 환청을 듣는다.',
          				'슬퍼 보이거나 기분이 처져 있으며 때로 울기도 한다.',
          				'밤에 자다가 일어나 주위 사람을 깨우거나 아침에 너무 일찍 일어난다. 또는 낮에는 지나치게 잠을 자고 밤에는 잠을 이루지 못한다.',
          				'주위사람이 도와주려 할 때 도와주는 것에 저항한다.',
          				'한군데 가만히 있지 못하고 서성거리거나 왔다 갔다 하며 안절부절 못한다.',
          				'길을 잃거나 헤맨 적이 있다. 외출하면 집이나 병원, 시설로 혼자 들어올 수 없다.',
          				'화를 내며 폭언이나 폭행을 하는 등 위협적인 행동을 보인다.',
          				'혼자서 밖으로 나가려고 해서 눈을 뗄 수가 없다.',
          				'물건을 망가뜨리거나 부순다.',
          				'의미 없거나 부적절한 행동을 자주 보인다.',
          				'돈이나 물건을 장롱같이 찾기 어려운 곳에 감춘다.',
          				'옷을 부적절하게 입는다.',
          				'대소변을 벽이나 옷에 바르는 등의 행위를 한다.',
          			];
          			
          			let behaviorTemplete = '<dt>최근 한 달간의 상황을 종합하여 아래 항목 중해당하는 모든 증상을 선택해 주세요.</dt>';
          			
          			//선택한 문항이 없는 경우
              		if (testResult.behaviorSelect.findIndex(select => select === 1) === -1) {
              			behaviorTemplete += '<dd>해당하는 증상이 없다.</dd>'
              		} else {
              			for (var i = 0; i < testResult.behaviorSelect.length; i++) {
                  			if (testResult.behaviorSelect[i]) {
                  				behaviorTemplete += '<dd>' + behaviorQuestion[i] + '</dd>';
                  			}
                  		}
              		}
              		
              		$('#behavior-select').html(behaviorTemplete);
          		}
          		
          		//간호처치
          		if (testResult && testResult.nurseSelect) {
          			const nurseQuestion = [
          				'<strong>기관지 절개관</strong><br>기관지를 절개하여 인공기도를 확보하는 간호',
              			'<strong>흡인</strong><br>카테터 등으로 인위적으로 분비물을 제거하여 기도유지',
              			'<strong>산소요법</strong><br>저산소증이나 저산소혈증을 치료, 감소 시키기 위해 산소공급장치를 통해 추가적인 산소 공급',
              			'<strong>욕창간호</strong><br>장기적인 고정체위로 인해 압박 부위의 피부와 하부조직 손상되어 지속적인 드레싱과 체위변경 처치',
              			'<strong>경관 영양</strong><br>구강으로 음식섭취가 어려워 관을 통해서 위, 십이지장 등에 직접 영양을 공급해야 하는 경우',
              			'<strong>암성통증</strong><br>암의 진행을 억제하지 못하여 극심한 통증에 발생',
              			'<strong>도뇨관리</strong><br>배뇨가 자율적으로 관리가 불가능하여 인위적으로 방광을 비우거나 관리',
              			'<strong>장루</strong><br>인공항문을 통해 체외로 대변을 배설 시킴으로 부착장치의 지속적인 관리',
              			'<strong>투석</strong><br>장기적인 신부전증으로 인해 혈액 투석이 필요한 경우',
              		];
              		
              		let nurseTemplete = '<dt>최근 2주간의 상황을 종합하여 필요하거나 제공 받고 있는 의료처리를 아래 항목 중 선택해 주세요.</dt>';
              		
              		//선택한 문항이 없는 경우
              		if (testResult.nurseSelect.findIndex(select => select === 1) === -1) {
              			nurseTemplete += '<dd>해당하는 증상이 없다.</dd>'
              		} else {
              			for (var i = 0; i < testResult.nurseSelect.length; i++) {
                  			if (testResult.nurseSelect[i]) {
                  				nurseTemplete += '<dd>' + nurseQuestion[i] + '</dd>';
                  			}
                  		}
              		}
              		
              		$('#nurse-select').html(nurseTemplete);
          		}
          		
          		//재활
          		if (testResult && testResult.rehabilitateSelect) {
          			$('#rehabilitate-select .result-answer dd').each(function (index, item) {
             			 if (index < 4) {
             				$(item).html(testResult.rehabilitateSelect[index] == 1 ? '운동장애 없음' :
       			   			  			 testResult.rehabilitateSelect[index] == 2 ? '불완전 운동장애' :
       			   			  			 testResult.rehabilitateSelect[index] == 3 ? '완전 운동장애' : '');
             			 } else {
             				$(item).html(testResult.rehabilitateSelect[index] == 1 ? '제한 없음' :
			   			  			 	 testResult.rehabilitateSelect[index] == 2 ? '한쪽관절 제한' :
			   			  			 	 testResult.rehabilitateSelect[index] == 3 ? '양쪽관절 제한' : '');
             			 }
             		});	
          		}
          		
          		//질병1
          		const diseaseQuestion = [
       				'치매',
       				'중풍(뇌졸증)',
       				'고혈압',
       				'당뇨병',
       				'관절염(퇴행성,류마티스)',
       				'요통,좌골통(디스크)',
       				'심부전,폐질환,천식 등',
       				'난청',
       				'백내장,녹내장',
       				'골절,탈골,사고 후유증',
       				'암',
       				'신부전',
       				'욕창',
           		];
          		if (testResult && testResult.diseaseSelect1) {
              		let diseaseTemplete = '<dt>현재 앓고 있는 질병 또는 증상을 모두 선택해 주세요.</dt>';
              		
              		for (var i = 0; i < testResult.diseaseSelect1.length; i++) {
              			if (testResult.diseaseSelect1[i]) {
              				diseaseTemplete += '<dd>' + diseaseQuestion[i] + '</dd>';
              			}
              		}
              		
              		$('#disease-select-1').html(diseaseTemplete);
          		}
          		//질병2
          		if (testResult && testResult.diseaseSelect2) {
              		let diseaseTemplete = '<dt>위에 선택한 질병 중,어르신의 현재 기능저하에 가장 직접적이고 중요한 원인이 되고 비중이 높은 항목 하나를 선택 하세요.</dt>';
              		
              		for (var i = 0; i < testResult.diseaseSelect2.length; i++) {
              			if (testResult.diseaseSelect2[i]) {
              				diseaseTemplete += '<dd>' + diseaseQuestion[i] + '</dd>';
              			}
              		}
              		
              		$('#disease-select-2').html(diseaseTemplete);
          		}
          		
          		
          		//등급에 따라서 버튼명 결정(다른 혜택 확인하기, 상담하기)
          		if (testResult.grade !== 0) {
          			$('#go-consult').text('1:1 상담하기');
          		} else if (testResult.grade === 0) {
          			$('.mainSend').css('display', 'none');
          		}
          	}
          	
          	//이메일 SELECT Event
          	$('#select-email').change(function() {
          		var emailBack = $('#select-email')[0].value;
          		$('#email-back')[0].value = emailBack;
          	});
          	
          	//이메일 전송 버튼 클릭
          	$('#sendEmailBtn').click(function() {
          		var emailFront = $('#email-front')[0].value;
          		var emailBack = $('#email-back')[0].value;
          		var email = emailFront + '@' + emailBack;
          		
          		if (!email || !emailFront || !emailBack || email.length < 3) {
          			alert('이메일을 입력하세요.');
          			return;
          		}
          		
          		var testData = JSON.parse(sessionStorage.getItem('testData'));
          		
          		$.ajax({
          			type: "post",
          			url: "/test/send/email.json",
          			data: {
          				email,
          				recipientsNo: testData.recipientsNo
          			},
          			dataType: 'json'
          		})
          		.done(function(res) {
          			if (res.success) {
          				alert('전송이 완료되었어요.');				
          				
          				$('#modal-email').modal('hide');
          				clickStartConsltBtn();
          			} else {
          				alert('다시 시도해주세요.');
          			}
          		})
          		.fail(function(data, status, err) {
          			alert('통신중 오류가 발생하였습니다.');
          		});
          	});
          	
          	//모달 닫기 버튼 클릭
          	$('#sendModalClose').click(function() {
          		$('#sendModal').fadeOut();
          	});
          	
          	
          	//다른 혜택 확인하기 또는 1:1 상담하기 버튼 클릭
          	$('#go-consult').click(function() {
          		//0등급인 경우 다른 혜택 확인하기
          		if (testResult.grade === 0) {
          			location.href="/main/searchBokji"
          			return;
          		}
          		
          		
          		const isCheckedEmail = $('#chk-email')[0].checked;
          		
          		//이메일 전송 폼 띄우기
          		if (isCheckedEmail) {
          			var email = '${mbrEml}';
          			if (email) {
          				const splitStr = email.split('@');
          				if (splitStr.length === 2) {
          					$('#email-front')[0].value = splitStr[0];
              				$('#email-back')[0].value = splitStr[1];
          				}
          			}
          			
          			$('.result-share').click();
          		} else {
          			clickStartConsltBtn();
          		}
          	});	    	
        });
        
      	//테스트 다시하기 버튼 클릭
	   	function restartTest() {
	   		var testData = JSON.parse(sessionStorage.getItem('testData'));
	   		if (testData.isLogin) {
	   			location.href = '/test/physical?recipientsNo=' + testData.recipientsNo;	
	   		} else {
	   			location.href = '/test/physical';	   			
	   		}
	   	}
    </script>
</div>
