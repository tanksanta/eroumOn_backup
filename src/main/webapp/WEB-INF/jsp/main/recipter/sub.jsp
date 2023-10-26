<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<header id="subject">
    <nav class="breadcrumb">
        <ul>
			<li class="home"><a href="${_mainPath}">홈</a></li>
			<li>이로움 서비스</li>
            <li>요양정보간편조회</li>
        </ul>
    </nav>
</header>

<div id="content">
<!-- 
   요양정보간편조회 서브 메인 페이지<br>
   <button onclick="searchRecipients();">요양정보 조회하기</button>
   -->
   
       <div class="grade-content1 simple-inquiry">
        <h2 class="grade-title2">요양정보 간편조회</h2>
        <p class="grade-text2 mt-10">
            <strong class="text-hightlight-blue font-bold">올해 남은 급여 금액</strong>을 확인 후<br>
            복지 혜택 <strong class="text-hightlight-blue font-bold">상담을 신청해보세요</strong>
        </p>
        <div class="grade-start mt-11 md:mt-15">
            <div class="picture">
                <img src="/html/page/index/assets/images/img-inquiry-start.png" class="hidden md:block" alt="요양정보간편조회이미지">
                <img src="/html/page/index/assets/images/img-inquiry-start-m.png" class="md:hidden" alt="요양정보간편조회모바일이미지">
                <div class="msg1" aria-hidden="true">
                    <div class="box">
                        부모님의 올해 남은<br>
                        <strong>장기요양금액</strong>을 이용하고 싶어요
                    </div>
                    <svg xmlns="http://www.w3.org/2000/svg" width="46" height="25" viewBox="0 0 46 25" fill="none">
                        <g filter="url(#filter0_d_518_4641)">
                        <path d="M37.6807 13.7944C24.8807 14.1944 18.4047 4.52527 14.9047 1.02527C6.57133 -0.808059 -7.31903 -1.20563 4.68097 8.79437C16.681 18.7944 30.514 16.961 37.6807 13.7944Z" fill="#333333"/>
                        </g>
                        <defs>
                        <filter id="filter0_d_518_4641" x="0" y="0" width="45.6807" height="24.3057" filterUnits="userSpaceOnUse" color-interpolation-filters="sRGB">
                        <feFlood flood-opacity="0" result="BackgroundImageFix"/>
                        <feColorMatrix in="SourceAlpha" type="matrix" values="0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 127 0" result="hardAlpha"/>
                        <feOffset dx="4" dy="4"/>
                        <feGaussianBlur stdDeviation="2"/>
                        <feComposite in2="hardAlpha" operator="out"/>
                        <feColorMatrix type="matrix" values="0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0.1 0"/>
                        <feBlend mode="normal" in2="BackgroundImageFix" result="effect1_dropShadow_518_4641"/>
                        <feBlend mode="normal" in="SourceGraphic" in2="effect1_dropShadow_518_4641" result="shape"/>
                        </filter>
                        </defs>
                    </svg>
                </div>
                <div class="msg2" aria-hidden="true">
                    <div class="box">
                        지팡이, 보행기가 필요한데<br>
                        받을 수 있는 <strong>복지용구를 알고 싶어요</strong>
                    </div>
                    <svg xmlns="http://www.w3.org/2000/svg" width="46" height="25" viewBox="0 0 46 25" fill="none">
                        <g filter="url(#filter0_d_518_4641)">
                        <path d="M37.6807 13.7944C24.8807 14.1944 18.4047 4.52527 14.9047 1.02527C6.57133 -0.808059 -7.31903 -1.20563 4.68097 8.79437C16.681 18.7944 30.514 16.961 37.6807 13.7944Z" fill="#333333"/>
                        </g>
                        <defs>
                        <filter id="filter0_d_518_4641" x="0" y="0" width="45.6807" height="24.3057" filterUnits="userSpaceOnUse" color-interpolation-filters="sRGB">
                        <feFlood flood-opacity="0" result="BackgroundImageFix"/>
                        <feColorMatrix in="SourceAlpha" type="matrix" values="0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 127 0" result="hardAlpha"/>
                        <feOffset dx="4" dy="4"/>
                        <feGaussianBlur stdDeviation="2"/>
                        <feComposite in2="hardAlpha" operator="out"/>
                        <feColorMatrix type="matrix" values="0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0.1 0"/>
                        <feBlend mode="normal" in2="BackgroundImageFix" result="effect1_dropShadow_518_4641"/>
                        <feBlend mode="normal" in="SourceGraphic" in2="effect1_dropShadow_518_4641" result="shape"/>
                        </filter>
                        </defs>
                    </svg>
                </div>
                <a href="#" target="_blank" title="새창열림" class="btn-inquiry btn btn-large2 btn-primary3 btn-arrow">
                    <strong>요양정보 조회하기</strong>
                </a>
                <img src="/html/page/index/assets/images/img-hand.png" class="img-hand hidden md:block" alt="손모양 이미지" />
            </div>

        </div>
        <ul class="grade-taps simple-inquiry mt-19 md:mt-24">
            <li class="taps-item is-active">
                <a href="#slide-item1">
                    <i><img src="/html/page/index/assets/images/ico-grade-info6.svg" alt="사람 아이콘"></i>
                    <span>요양정보 확인</span>
                </a>
            </li>
            <li class="taps-spacer"></li>
            <li class="taps-item">
                <a href="#slide-item2">
                    <i><img src="/html/page/index/assets/images/ico-grade-info2.svg" alt="금액 아이콘"></i>
                    <span>남은 장기요양금액</span>
                </a>
            </li>
            <li class="taps-spacer"></li>
            <li class="taps-item">
                <a href="#slide-item3">
                    <i><img src="/html/page/index/assets/images/ico-grade-info3.svg" alt="복지용구 아이콘"></i>
                    <span>보유 중인 복지용구</span>
                </a>
            </li>
            <li class="taps-spacer"></li>
            <li class="taps-item">
                <a href="#slide-item4">
                    <i><img src="/html/page/index/assets/images/ico-grade-info11.svg" alt="지팡이 아이콘"></i>
                    <span>구매 예상 복지용구</span>
                </a>
            </li>
            <li class="taps-spacer"></li>
            <li class="taps-item">
                <a href="#slide-item5">
                    <i><img src="/html/page/index/assets/images/ico-grade-info4.svg" alt="헤드셋 아이콘"></i>
                    <span>전문가 상담과 혜택신청</span>
                </a>
            </li>
        </ul>
        <a href="#" class="text-link">
            요양인정번호가 없으세요?
        </a>
    </div>

    <div class="grade-content2 simple-inquiry">
        <h2 class="grade-title">
            <small>요양정보 간편조회</small>
            <span class="font-normal">장기요양금액</span> 확인부터<br> <span class="font-normal">복지용구</span> 신청까지 한번에
        </h2>
        <div class="grade-rolling mt-13 md:mt-23">
            <div class="container">
                <div class="rolling-item1 is-active">
                    <div class="grade-rolling-inner">
                        <div class="item-thumb">
                            <img src="/html/page/index/assets/images/img-grade-rolling1.svg" alt="여자얼굴 이미지" />
                        </div>
                        <div class="item-content">
                            부모님의 올해 남은<br>
                            <strong>장기요양금액을 이용하고 싶어요</strong>
                        </div>
                    </div>
                    <img src="/html/page/index/assets/images/img-inquiry1-1.svg" alt="장기요양금액 이미지" />
                    
                </div>
                <div class="rolling-item2">
                    <div class="grade-rolling-inner">
                        <div class="item-thumb">
                            <img src="/html/page/index/assets/images/img-grade-rolling2.svg" alt="할머니얼굴 이미지" />
                        </div>
                        <div class="item-content">
                            지팡이, 보행기가 필요한데<br>
                            <strong>받을 수 있는 복지용구를 알고 싶어요</strong>
                        </div>
                    </div>
                    <img src="/html/page/index/assets/images/img-inquiry1-2.svg" alt="복지용구표현이미지" />
                </div>
                <div class="rolling-item3">
                    <div class="grade-rolling-inner">
                        <div class="item-thumb">
                            <img src="/html/page/index/assets/images/img-grade-rolling4.svg" alt="남자얼굴 이미지" />
                        </div>
                        <div class="item-content">
                            어머니 상태에 도움이 되는<br>
                            <strong>복지용구를 신청하고 싶어요</strong>
                        </div>
                    </div>
                    <img src="/html/page/index/assets/images/img-inquiry1-3.svg" alt="복지용구를 신청 표현 이미지" />
                </div>
            </div>
        </div>
    </div>

    <div class="grade-content3 simple-inquiry">
        <h2 class="grade-title">
            <small>노인장기요양보험 인정 등급 예상 테스트</small>
            이렇게 제공받아요
        </h2>
        <ul class="grade-taps simple-inquiry mt-16 md:mt-23 md-max:!hidden">
            <li class="taps-item is-active">
                <a href="#slide-item1">
                    <i><img src="/html/page/index/assets/images/ico-grade-info2.svg" alt="금액 아이콘"></i>
                    <span>남은 장기요양금액</span>
                </a>
            </li>
            <li class="taps-spacer"></li>
            <li class="taps-item">
                <a href="#slide-item2">
                    <i><img src="/html/page/index/assets/images/ico-grade-info3.svg" alt="복지용구 아이콘"></i>
                    <span>나의 복지용구 현황</span>
                </a>
            </li>
            <li class="taps-spacer"></li>
            <li class="taps-item">
                <a href="#slide-item3">
                    <i><img src="/html/page/index/assets/images/ico-grade-info5.svg" alt="서류 아이콘"></i>
                    <span>복지용구 상세 현황</span>
                </a>
            </li>
        </ul>
        <div class="grade-slider mt-15 md:mt-20">
            <div class="container">
                <div class="swiper">
                    <div class="swiper-wrapper">
                        <div id="slide-item1" class="swiper-slide">
                            <p class="text-2xl font-bold tracking-normal">남은 장기요양금액</p>
                            <p class="mt-2.5">남은 장기요양금액을 알려드려요</p>
                            <img src="/html/page/index/assets/images/img-inquiry3-1.svg" alt="장기요양금액 표현이미지" class="mt-9">
                        </div>
                        <div id="slide-item2" class="swiper-slide">
                            <p class="text-2xl font-bold tracking-normal">나의 복지용구 현황</p>
                            <p class="mt-2.5">계약완료, 구매예상 복지용구 현황을 알려드려요</p>
                            <img src="/html/page/index/assets/images/img-inquiry3-2.svg" alt="구매예상 복지용구 현황 표현이미지" class="mt-9">
                        </div>
                        <div id="slide-item3" class="swiper-slide">
                            <p class="text-2xl font-bold tracking-normal">복지용구 상세 현황</p>
                            <p class="mt-2.5">내가 구매한 복지용구 현황을 알려드려요</p>
                            <img src="/html/page/index/assets/images/img-inquiry3-3.svg" alt="구매한 복지용구 현황 표현이미지" class="mt-9">
                        </div>
                    </div>
                </div>
                <div class="swiper-button-prev"></div>
                <div class="swiper-button-next"></div>
                <div class="swiper-pagination"></div>
            </div>
        </div>
    </div>

    <div class="grade-content4 simple-inquiry">
        <h2 class="grade-title">
            <small>요양정보 간편조회</small>
            이렇게 활용해요
        </h2>
        <ul class="grade-taps simple-inquiry mt-1 6 md:mt-23 md-max:!hidden">
            <li class="taps-item is-active">
                <a href="#slide-item6">
                    <i><img src="/html/page/index/assets/images/ico-grade-info6.svg" alt="사람 아이콘"></i>
                    <span>요양정보 확인</span>
                </a>
            </li>
            <li class="taps-spacer"></li>
            <li class="taps-item">
                <a href="#slide-item7">
                    <i><img src="/html/page/index/assets/images/ico-grade-info2.svg" alt="금액 아이콘"></i>
                    <span>남은 장기요양금액</span>
                </a>
            </li>
            <li class="taps-spacer"></li>
            <li class="taps-item">
                <a href="#slide-item8">
                    <i><img src="/html/page/index/assets/images/ico-grade-info3.svg" alt="복지용구 아이콘"></i>
                    <span>보유 중인 복지용구</span>
                </a>
            </li>
            <li class="taps-spacer"></li>
            <li class="taps-item">
                <a href="#slide-item9">
                    <i><img src="/html/page/index/assets/images/ico-grade-info11.svg" alt="지팡이 아이콘"></i>
                    <span>구매 예상 복지용구</span>
                </a>
            </li>
            <li class="taps-spacer"></li>
            <li class="taps-item">
                <a href="#slide-item10">
                    <i><img src="/html/page/index/assets/images/ico-grade-info4.svg" alt="헤드셋 아이콘" class="-mt-2.5"></i>
                    <span>전문가 상담과 혜택 신청</span>
                </a>
            </li>
        </ul>
        <div class="grade-slider mt-15 md:mt-20">
            <div class="swiper">
                <div class="swiper-wrapper">
                    <div id="slide-item6" class="swiper-slide">
                        <div class="swiper-slide-text">
                            <p class="text-2xl font-bold tracking-normal">요양정보 확인</p>
                            <p class="text-center">어르신의 요양정보를 알려드려요</p>
                        </div>
                        <img src="/html/page/index/assets/images/img-inquiry4-1.jpg" alt="요양정보 표현이미지">
                    </div>
                    <div id="slide-item7" class="swiper-slide">
                        <div class="swiper-slide-text">
                            <p class="text-2xl font-bold tracking-normal">남은 장기요양 금액</p>
                            <p class="text-center">올해 남은 장기요양금액을 확인해요</p>
                        </div>
                        <img src="/html/page/index/assets/images/img-inquiry4-2.jpg" alt="장기요양금액 표현이미지">
                    </div>
                    <div id="slide-item8" class="swiper-slide">
                        <div class="swiper-slide-text">
                            <p class="text-2xl font-bold tracking-normal">보유 중인 복지용구</p>
                            <p class="text-center">보유하고 있는 복지용구를 확인해요</p>
                        </div>
                        <img src="/html/page/index/assets/images/img-inquiry4-3.jpg" alt="보유하고 있는 복지용구 표현이미지">
                    </div>
                    <div id="slide-item9" class="swiper-slide">
                        <div class="swiper-slide-text">
                            <p class="text-2xl font-bold tracking-normal">구매 예상 복지용구</p>
                            <p class="text-center">구매 가능할 것으로 예상되는 복지용구를 확인해요</p>
                        </div>
                        <img src="/html/page/index/assets/images/img-inquiry4-4.jpg" alt="예상되는 복지용구 표현이미지">
                    </div>
                    <div id="slide-item10" class="swiper-slide">
                        <div class="swiper-slide-text">
                            <p class="text-2xl font-bold tracking-normal">남은 장기요양 금액</p>
                            <p class="text-center">올해 남은 장기요양금액을 확인해요</p>
                        </div>
                        <img src="/html/page/index/assets/images/img-inquiry4-5.jpg" alt="장기요양금액 표현이미지">
                    </div>
                </div>
            </div>
            <div class="swiper-button-prev"></div>
            <div class="swiper-button-next"></div>
            <div class="swiper-pagination"></div>
        </div>
        <div class="grade-text1 mt-9">
            <p>위 내용은 데이터 조회 시점에 따라 <strong class="underline">실제와 다를 수 있으니 참고용</strong>으로만 사용해주세요.</p>
        </div>
    </div>

    <div class="text-center text-xl md:text-4xl mt-22">
        <span class="text-hightlight-blue font-bold">올해 남은 급여 금액</span>을 확인 후 <br>
        복지 혜택 <span class="text-hightlight-blue font-bold">상담을 신청해보세요</span>
    </div>

    <button onclick="searchRecipients();" class="grade-floating consulting">요양정보 조회하기</button>


	<!--로그인사용자 : 등록된 수급자 없는 경우-->
	<div class="modal modal-index fade" id="login-no-rcpt" tabindex="-1" aria-hidden="true">
	    <div class="modal-dialog">
	        <div class="modal-content">
	            <div class="modal-header">
	                <h2 class="text-title">수급자 선택</h2>
	                <button data-bs-dismiss="modal" class="btn-close">모달 닫기</button>
	            </div>
	            <div class="modal-body">
	                <div class="flex flex-col justify-center items-end gap-1">
	                    <select name="no-rcpt-relation" id="no-rcpt-relation" class="form-control w-full">
	                    	<option value="">관계 선택</option>
							<c:forEach var="relation" items="${mbrRelationCode}" varStatus="status">
								<option value="${relation.key}">${relation.value}</option>	
							</c:forEach>
	                    </select>
	                    <input type="text" name="no-rcpt-nm" id="no-rcpt-nm" placeholder="수급자 성명" class="form-control w-full">
	                    <div class="flex">
	                    	<p class="px-1.5 font-serif text-[1.375rem] font-bold md:text-2xl">L</p>
	                    	<input type="text" name="no-rcpt-nm" id="no-rcpt-lno" placeholder="요양인정번호" class="form-control w-full">
	                    </div>
	                </div>
	            </div>
	            <div class="modal-footer">
	                <button type="button" class="btn btn-primary large flex-1 md:flex-none md:w-70" onclick="startLoginNoRcpt();">시작하기</button>
	            </div>
	        </div>
	    </div>
	</div>
	
	<!--로그인사용자 : 등록 수급자 n명이상인 경우-->
	<div class="modal modal-index fade" id="login-rcpts" tabindex="-1" aria-hidden="true">
	    <div class="modal-dialog">
	    <div class="modal-content">
	        <div class="modal-header">
	        <h2 class="text-title">수급자 선택</h2>
	        <button data-bs-dismiss="modal" class="btn-close">모달 닫기</button>
	        </div>
	        <div class="modal-body  items-end">
	         <div class="form-radio-button-group" id="recipient-list">
	             
	         </div>
	         <a href="#"class="underline text-blue3 text-sm">수급자 관리</a>
	         
	         
	         <!--추가 등록-->
	         <div id="registRecipientForm" style="display: block; width: 100%;">
	             
	         </div>
	        </div>
	        <div class="modal-footer">
	        <button type="button" class="btn btn-primary large flex-1 md:flex-none md:w-70" onclick="startloginRcpts();">시작하기</button>
	        </div>
	    </div>
	    </div>
	</div>
	
	<!-- 수급자정보등록 팝업소스 -->
	<div class="modal modal-index fade" id="regist-rcpt" tabindex="-1" aria-hidden="true">
	    <div class="modal-dialog">
	        <div class="modal-content">
	            <div class="modal-header">
	                <h2 class="text-title">수급자 정보 등록</h2>
	                <button data-bs-dismiss="modal" class="btn-close">모달 닫기</button>
	            </div>
	            <div class="modal-body">
	            <div class="flex flex-col">
	                <div class="text-subtitle">
	                    <i class="icon-alert"></i>
	                    <p>테스트를 하려면 수급자 등록이 필요해요</p>
	                </div>
	                <div class="text-subtitle">
	                    <i class="icon-alert"></i>
	                    <p>등록하려는 수급자 정보를 확인하세요</p>
	                </div>
	                <div class="text-subtitle">
	                    <i class="icon-alert"></i>
	                    <p>회원이 이용약관에 따라 수급자 등록과 관리하는 것에 동의합니다</p>
	                </div>
	            </div>
	            <div class="modal-bg-wrap">
	                <ul class="modal-list-box">
	                	<input id="modal-recipient-relation-cd" type="hidden" value="">
	                    <li>
	                        <span class="modal-list-label">수급자와의 관계</span>
	                        <span class="modal-list-value" id="modal-recipient-relation">본인</span>
	                    </li>
	                    <li>
	                        <span class="modal-list-label">수급자 성명</span>
	                        <span class="modal-list-value" id="modal-recipient-nm">홍길동</span>
	                    </li>
	                    <li>
	                        <span class="modal-list-label">요양인정번호</span>
	                        <span class="modal-list-value" id="modal-recipient-lno">L1234512345</span>
	                    </li>
	                </ul>
	            </div>
	            <div class="text-subtitle">
	                <i class="icon-alert"></i>
	                <p>요양인정번호는 마이페이지에서 등록하실 수 있어요</p>
	            </div>
	            </div>
	            <div class="modal-footer">
	                <button type="button" class="btn btn-primary w-full" onclick="clickRegistRecipient();">확인</button>
	            </div>
	        </div>
	    </div>
	</div>

	<script>
		var mbrNm = null;
		var recipients = null;
	
		//펼치기 접기
	    function toggleText() {
	        const el = document.querySelector(".btn-toggle-box");
	        const icon = document.querySelector(".icon-collapse");
	        const text = document.querySelector(".btn-collapse > span")
	        
	        if (el.classList.contains("collapsed") ) {
	            icon.classList.remove("expand")
	            text.textContent = "펼치기";
	        } else {
	            icon.classList.add("expand")
	            text.textContent =  "접기";
	        }
	    }
		
	  	//요양정보 조회하기 버튼 클릭
        function searchRecipients() {
        	$.ajax({
        		type : "post",
				url  : "/membership/info/myinfo/getMbrInfo.json",
				dataType : 'json'
        	})
        	.done(function(data) {
        		//로그인 한 경우
        		if (data.isLogin) {
        			//ajax 받아온 데이터 저장
        			mbrNm = data.mbrVO.mbrNm;
        	    	recipients = data.mbrRecipients;
        			
        	    	modalRecipient();
        		}
        		//로그인 안한 경우
        		else {
        			location.href='/membership/login?returnUrl=/main/recipter/sub'
        		}
        	})
        	.fail(function(data, status, err) {
        		alert('서버와 연결이 좋지 않습니다.');
			});
        }
	  	
      	//수급자 없는 모달 또는 등록된 수급자 있는 모달 띄우기
        function modalRecipient() {
        	$('#notified-consulting').modal('hide');
        	
        	//등록된 수급자가 없는 경우
			if(!recipients || recipients.length === 0) {
				$('#login-no-rcpt').modal('show');
			}
			//기존에 등록한 수급자가 있는 경우
			else {
				var template = '';
				
				//수급자 선택 박스 생성
				for (var i = 0; i < recipients.length; i++) {
					template += `<div  class="form-check">
	                    <input class="form-check-input" type="radio" name="rcpts" id="rcpt` + i + `" value="` + recipients[i].recipientsNo + `"` + (recipients[i].mainYn === 'Y' ? `checked` : ``) + `>
	                    <label class="form-check-label" for="rcpt` + i + `">` + recipients[i].recipientsNm + `</label>
	                </div>`;
				}
				$('#recipient-list').html(template);
				
				//직접입력하기 폼 추가(등록된 수급자가 4명 미만인 경우)
				if (recipients.length < 4) {
					template = getRegistRecipientForm();
					
					$('#registRecipientForm').html(template);
				} else {
					$('#registRecipientForm').html('');
				}
				
				$('#login-rcpts').modal('show');
			}
        }
      	
      	//수급자가 없는 모달 시작하기
        function startLoginNoRcpt() {
        	var relationCd = $('#no-rcpt-relation option:selected').val();
        	var relationText = $('#no-rcpt-relation option:selected').text();
        	var recipientsNm = $('#no-rcpt-nm').val();
        	var recipientsLno = $('#no-rcpt-lno').val();
        	
        	if (!relationCd || !recipientsNm || !recipientsLno) {
        		alert('모두 입력해주세요');
        		return;
        	}
        	if (relationCd === '007' && mbrNm !== recipientsNm) {
        		alert('수급자와의 관계를 확인해주세요');
        		return;
        	}
        	
        	recipientsLno = 'L' + recipientsLno;
        	mappingRecipientModal(relationCd, relationText, recipientsNm, recipientsLno);
        }
      	
      	//등록된 수급자가 있는 모달 시작하기
        function startloginRcpts() {
        	var el = document.querySelector(".btn-toggle-box");
        	var isRegist = !el ? true : el.classList.contains("collapsed");
        	  
        	//수급자 선택인 경우
        	if (isRegist) {
        		//등록된 수급자 선택값 가져오기
            	var radioRecipientsNo =  $('input[name=rcpts]:checked').val();
            	if (!radioRecipientsNo) {
        			alert('수급자를 선택하세요');
        			return;
        		}
            	
            	var recipientInfo = recipients.filter(f => f.recipientsNo === Number(radioRecipientsNo))[0];
            	if (!recipientInfo.rcperRcognNo) {
            		alert('마이페이지 수급자 관리에서 요양인정번호를 등록해주세요');
            		return;
            	}
        		
            	location.href = '/main/recipter/list?recipientsNo=' + radioRecipientsNo;
        	}
        	//직접입력하기인 경우
        	else {
        		//직접 입력하기 수급자 정보
            	var relationCd = $('#login-rcpts-relation option:selected').val();
            	var relationText = $('#login-rcpts-relation option:selected').text();
            	var recipientsNm = $('#login-rcpts-nm').val();
            	var recipientsLno = $('#login-rcpts-lno').val();
            	
            	if (!relationCd || !recipientsNm || !recipientsLno) {
            		alert('모두 입력해주세요');
            		return;
            	}
            	
            	//본인과 배우자는 한명만 등록이 가능하다.
            	if (relationCd === '007' && recipients.findIndex(f => f.relationCd === '007') !== -1) {
            		alert('본인은 한명만 등록이 가능합니다.')
            		return;
            	}
            	else if (relationCd === '001' && recipients.findIndex(f => f.relationCd === '001') !== -1) {
            		alert('배우자는 한명만 등록이 가능합니다.')
            		return;
            	}
            	
            	recipientsLno = 'L' + recipientsLno;
            	mappingRecipientModal(relationCd, relationText, recipientsNm, recipientsLno);
        	}
        }
      	
      	//새로 등록할 수급자 확인
        function clickRegistRecipient() {
        	var relationCd = $('#modal-recipient-relation-cd').val();
        	var recipientsNm = $('#modal-recipient-nm').text();
        	var rcperRcognNo = $('#modal-recipient-lno').text();
        	var rcperRcognNo = rcperRcognNo.replace('L', '');
        	
        	$.ajax({
        		type : "post",
				url  : "/membership/info/myinfo/addMbrRecipient.json",
				data : {
					relationCd
					, recipientsNm
					, rcperRcognNo
				},
				dataType : 'json'
        	})
        	.done(function(data) {
        		if(data.success) {
        			alert('수급자 정보 등록에 동의했습니다.');
        			
        			location.href = '/main/recipter/list?recipientsNo=' + data.createdRecipientsNo;
        		}else{
        			alert(data.msg);
        		}
        	})
        	.fail(function(data, status, err) {
        		alert('서버와 연결이 좋지 않습니다.');
			});
        }

        
        //등록하려는 수급자 확인 모달값 매핑
        function mappingRecipientModal(relationCd, relationText, recipientsNm, recipientsLno) {
        	$('#modal-recipient-relation-cd').val(relationCd);
        	$('#modal-recipient-relation').text(relationText);
        	$('#modal-recipient-nm').text(recipientsNm);
        	$('#modal-recipient-lno').text(recipientsLno);
        	$('#regist-rcpt').modal('show');
        }
        
        //직접입력하기(수급자 등록) 폼 반환
        function getRegistRecipientForm() {
        	return `
        	<div class="flex flex-col gap-2">
	            <a href="#direct-rcpt" data-bs-toggle="collapse" aria-expanded="false" class="btn-toggle-box collapsed">
	                <p class="text-gray5">추가 등록</p>
	                <div class="btn-collapse" onclick="toggleText()">
	                    <span>펼치기</span>
	                    <i class="icon-collapse">펼치기/접기</i> 
	                </div>
	            </a>
	            <div id="direct-rcpt" class="collapse">
	            <div class="flex flex-col justify-center items-start gap-2">
	                <label for="rcpt-related" class="w-full">
	                    <select name="login-rcpts-relation" id="login-rcpts-relation" class="form-control w-full is-invalid"  aria-required="true" aria-describedby="rcpt-related-error" aria-invalid="true" onchange="validateRequiredField();">
	                    	<option value="">관계 선택</option>
							<c:forEach var="relation" items="${mbrRelationCode}" varStatus="status">
								<option value="${relation.key}">${relation.value}</option>	
							</c:forEach>
	                    </select>
	                    <p id="rcpt-related-error" class="error text-danger">! 필수로 선택해 주세요</p>
	                </label>
	                <label for="rcpt-name" class="w-full">
	                    <input type="text" id="login-rcpts-nm" aria-required="true" aria-describedby="rcpt-name-error" 
	                    aria-invalid="true" placeholder="수급자 성명" class="form-control w-full is-invalid" oninput="validateRequiredField();">
	                    <p id="rcpt-name-error" class="error text-danger">! 필수로 입력해 주세요</p>
	                </label>
	                <label for="rcpt-lno" class="w-full">
	                	<div class="flex">
		                	<p class="px-1.5 font-serif text-[1.375rem] font-bold md:text-2xl">L</p>
		                    <input type="text" id="login-rcpts-lno" aria-required="true" aria-describedby="rcpt-lno-error" 
		                    aria-invalid="true" placeholder="요양인정번호" class="form-control w-full is-invalid" oninput="validateRequiredField();">
	                	</div>
	                    <p id="rcpt-lno-error" class="error text-danger">! 필수로 입력해 주세요</p>
	                </label>
	               </div>
	           </div>
	        </div>
        	`
        }
        
        //직접입력하기 필수체크
        function validateRequiredField() {
        	//직접 입력하기 수급자 정보
        	var relationCd = $('#login-rcpts-relation option:selected').val();
        	var relationText = $('#login-rcpts-relation option:selected').text();
        	var recipientsNm = $('#login-rcpts-nm').val();
        	var recipientsLno = $('#login-rcpts-lno').val();
        	
        	if (relationCd) {
        		$('#login-rcpts-relation').removeClass('is-invalid');
        		$('#rcpt-related-error').css('display', 'none');
        	} else {
        		$('#login-rcpts-relation').addClass('is-invalid');
        		$('#rcpt-related-error').css('display', 'block');
        	}
        	
        	if (recipientsNm) {
        		$('#login-rcpts-nm').removeClass('is-invalid');
        		$('#rcpt-name-error').css('display', 'none');
        	} else {
        		$('#login-rcpts-nm').addClass('is-invalid');
        		$('#rcpt-name-error').css('display', 'block');
        	}
        	
        	if (recipientsLno) {
        		$('#login-rcpts-lno').removeClass('is-invalid');
        		$('#rcpt-lno-error').css('display', 'none');
        	} else {
        		$('#login-rcpts-lno').addClass('is-invalid');
        		$('#rcpt-lno-error').css('display', 'block');
        	}
        }
        
        
        const rolling1 = null;
        const rolling2 = null;

        $('.grade-slider').each(function () {
            var slider = $(this);

            new Swiper(slider.find('.swiper').get(0), {
                loop: true,
                speed: 1000,
                // autoplay: {
                //     speed: 5000,
                //     disableOnInteraction: false,
                // },
                navigation: {
                    prevEl: slider.find('.swiper-button-prev').get(0),
                    nextEl: slider.find('.swiper-button-next').get(0)
                },
                pagination: {
                    el: slider.find('.swiper-pagination').get(0),
                },
                on: {
                    slideChange: function (swiper) {
                        var el = $(swiper.slides[swiper.activeIndex]);
                        el.closest('[class*="grade-content"]').find('.grade-taps a[href="#' + el.attr('id') + '"]').parent().addClass('is-active').siblings().removeClass('is-active');
                    }
                }
            });
        })

        $('.grade-taps a').on('click', function () {
            var target = $($(this).attr('href'));
            var slider = $(target).closest('.swiper').get(0).swiper;

            $(this).parent().addClass('is-active').siblings().removeClass('is-active');

            slider.slideTo(target.index())

            $(window).scrollTop(target.closest('[class*="grade-content"]').find('.grade-taps').offset().top - ($('#header').outerHeight() + 20))

            return false;
        });

        rolling1 = setInterval(function () {
            var taps = $('.grade-content1 .taps-item');
            var active = $('.grade-content1 .taps-item.is-active');
            taps.each(function (index, element) {
                if (active.get(0) === element) {
                    if (taps[index + 1] === undefined) {
                        $('.grade-content1 .taps-item:eq(0)').addClass('is-active').siblings().removeClass('is-active')
                    } else {
                        $(taps[index + 1]).addClass('is-active').siblings().removeClass('is-active');
                    }
                    return false;
                }
            })
        }, 5000);

        rolling2 = setInterval(function () {
            var items = $('[class*="rolling-item"]');
            var active = items.filter('.is-active');
            var margin = -active.next().outerHeight(true);

            active.clone().removeClass('is-active').appendTo(items.closest('.container'));

            active.removeClass('is-active').css({ 'margin-top': margin }).next().addClass('is-active').one('transitionend animationend', function () {
                active.remove();
            });
        }, 6000);  
	</script>
</div>