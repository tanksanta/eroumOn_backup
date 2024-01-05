<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<header id="subject">
    <nav class="breadcrumb">
        <ul>
			<li class="home"><a href="${_mainPath}">홈</a></li>
			<li>이로움 서비스</li>
            <li>관심 복지용구 상담</li>
        </ul>
    </nav>

</header>

<div id="content">
	<div class="grade-content1 welfare-equip">
        <h2 class="grade-title2">관심 복지용구 상담</h2>
        <p class="grade-text2 mt-10">
            <strong class="text-hightlight-orange font-bold">필요한 복지용구</strong>를 선택하고 상담하면<br>
            <strong class="text-hightlight-orange font-bold">받을 수 있는 혜택</strong>을 알려드려요
        </p>
        <div class="grade-start mt-11 md:mt-15">
            <div class="picture">
                <img src="/html/page/index/assets/images/img-welfare-start.png" class="hidden md:block" alt="관심 복지용구 상담 이미지">
                <img src="/html/page/index/assets/images/img-welfare-start-m.png" class="md:hidden" alt="관심 복지용구 상담 모바일 이미지">
                <div class="msg1" aria-hidden="true">
                    <div class="box">
                        어머니 상태에 도움이 되는<br>
                        <strong class="text-blue">복지용구</strong>를 신청하고 싶어요
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
                <button onclick="selectWelfareEquipment();" class="btn-welfare btn btn-large2 btn-primary2 btn-arrow">
					<strong>복지용구 선택하기</strong>
				</button>
            </div>

        </div>
    
        <a href="/main/cntnts/test" class="text-link">
            요양인정번호가 없으세요?
        </a>
    </div>

    <div class="grade-content2 welfare-equip">
        <h2 class="grade-title">
            <small>관심 복지용구 상담</small>
            <span class="font-normal">필요한 복지용구 </span>상담부터<br> 
            <span class="font-normal">복지용구</span> 구매 신청까지 한번에
        </h2>
        <div class="grade-rolling mt-13 md:mt-23">
            <div class="container">
                <div class="rolling-item1 is-active">
                    <div class="grade-rolling-inner">
                        <div class="item-thumb">
                            <img src="/html/page/index/assets/images/img-grade-rolling1.svg" alt="여자얼굴 이미지">
                        </div>
                        <div class="item-content">
                            복지용구를 고르기 어려워서<br>
                            <strong>추천 받고 싶어요</strong>
                        </div>
                    </div>
                </div>
                <div class="rolling-item2">
                    <div class="grade-rolling-inner">
                        <div class="item-thumb">
                            <img src="/html/page/index/assets/images/img-grade-rolling2.svg" alt="할머니얼굴 이미지">
                        </div>
                        <div class="item-content">
                            지팡이, 보행기가 필요한데<br>
                            <strong>받을 수 있는 복지용구를 알고 싶어요</strong>
                        </div>
                    </div>
                </div>
                <div class="rolling-item3">
                    <div class="grade-rolling-inner">
                        <div class="item-thumb">
                            <img src="/html/page/index/assets/images/img-grade-rolling4.svg" alt="남자얼굴 이미지">
                        </div>
                        <div class="item-content">
                            어머니 상태에 도움이 되는<br>
                            <strong>복지용구를 신청하고 싶어요</strong>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <div class="grade-content3 welfare-equip">
        <h2 class="grade-title">
            <small>관심 복지용구 상담</small>
            받을 수 있는 혜택 확인
        </h2>
        
        <div class="content-box">
            <div class="text-center text-2xl">
                <p class="tracking-normal">관심있는 <strong>복지용구</strong>를 바탕으로</p>
                <p><strong class="text-indexKey1">85%~100% 지원 혜택</strong>을 받을 수 있는 지 알려드려요</p>
            </div>
            <img src="/html/page/index/assets/images/img-welfare-content3.png" class="sm:w-100" alt="관심있는 복지용구를 바탕으로 85%~100%지원 혜택을 받을 수 있는 지 알려드려요">
        </div>
    </div>

    <div class="grade-content4 welfare-equip">
        <h2 class="grade-title">
            <small>관심 복지용구 상담</small>
            필요한 복지용구 추천
        </h2>
        
        <div class="content-box">
            <div class="text-center text-2xl">
                <p class="tracking-normal">다양한 복지용구 상품 중</p>
                <p><strong class="text-indexKey1">어르신 상황</strong>에 적합한 <strong class="text-indexKey1">상품을 추천해드려요</strong></p>
            </div>
            <img src="/html/page/index/assets/images/img-welfare-content4.png" class="sm:w-100" alt="다양한 복지용구 상품 중 어르신 상태에 도움이 되는 상품을 추천해드려요">
        </div>
    </div>

    <div class="grade-content3 welfare-equip">
        <h2 class="grade-title">
            <small>관심 복지용구 상담</small>
            간편한 구매 신청
        </h2>
        
        <div class="content-box">
            <div class="text-center text-2xl">
                <p class="tracking-normal">필요한 복지용구 상품을</p>
                <p><strong class="text-indexKey1">간편하게 구매</strong>할 수 있도록 도와드려요</p>
            </div>
            <img src="/html/page/index/assets/images/img-welfare-content5.png" class="sm:w-100" alt="복지용구 상담 도와드려요">
        </div>
    </div>

    <div class="text-center text-xl md:text-4xl">
        <span class="text-hightlight-orange font-bold">필요한 복지용구</span>를 선택한 후<br>
        <span class="text-hightlight-orange font-bold">받을 수 있는 혜택</span>을 알려드려요
    </div>

	<div class="grade-floating">
		<button id="search-recipients"  onclick="selectWelfareEquipment()">
			<strong>복지용구 선택하기</strong>
		</button>
	</div>
	
	<!-- 수급자 선택 모달 -->
    <jsp:include page="/WEB-INF/jsp/common/modal/select_recipient_modal.jsp" />
	

	<script>
	    var rolling1 = null;
	    var rolling2 = null;
	
	    $('.grade-slider').each(function () {
	        var slider = $(this);
	
	        new Swiper(slider.find('.swiper').get(0), {
	            loop: true,
	            speed: 1000,
	            autoplay: {
	                speed: 5000,
	                disableOnInteraction: false,
	            },
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

	    rolling2 = setInterval(function () {
	        var items = $('[class*="rolling-item"]');
	        var active = items.filter('.is-active');
	        var margin = -active.next().outerHeight(true);
	
	        active.clone().removeClass('is-active').appendTo(items.closest('.container'));
	
	        active.removeClass('is-active').css({ 'margin-top': margin }).next().addClass('is-active').one('transitionend animationend', function () {
	            active.remove();
	        });
	    }, 3000);
	</script>
	
	
	<script>
		//복지용구 선택하기 클릭
	    function selectWelfareEquipment() {
	    	openSelectRecipientModal('equip_ctgry');
	    }
	</script>
</div>
