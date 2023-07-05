<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<div id="visual" class="is-page2">
    <div class="object1"></div>
    <div class="object2"></div>
    <div class="object3"></div>
    <div class="object4"></div>
    <div class="object5"></div>
    <h2 class="title">
        <small>부모님의 생활을 한층 편하게</small>
        복지용구가 일상생활에서<br>
        <img src="/html/page/index/assets/images/txt-page2-visual.png" alt="꼭"> 필요한 이유
    </h2>
    <p class="text-scroll is-white">아래에서 더 자세히 알아보세요</p>
</div>

<div id="content">
	<div class="page2-slider">
	    <div class="swiper">
	        <div class="swiper-wrapper">
	            <div class="swiper-slide"><img src="/html/page/index/assets/images/img-page2-category1.png" alt="성인용보행기"></div>
	            <div class="swiper-slide"><img src="/html/page/index/assets/images/img-page2-category2.png" alt="수동휠체어"></div>
	            <div class="swiper-slide"><img src="/html/page/index/assets/images/img-page2-category3.png" alt="지팡이"></div>
	            <div class="swiper-slide"><img src="/html/page/index/assets/images/img-page2-category4.png" alt="안전손잡이"></div>
	            <div class="swiper-slide"><img src="/html/page/index/assets/images/img-page2-category5.png" alt="미끄럼방지 매트"></div>
	            <div class="swiper-slide"><img src="/html/page/index/assets/images/img-page2-category6.png" alt="미끄럼방지 양말"></div>
	            <div class="swiper-slide"><img src="/html/page/index/assets/images/img-page2-category7.png" alt="욕창예방 매트리스"></div>
	            <div class="swiper-slide"><img src="/html/page/index/assets/images/img-page2-category8.png" alt="욕창예방 방석"></div>
	            <div class="swiper-slide"><img src="/html/page/index/assets/images/img-page2-category9.png" alt="자세변환용구"></div>
	            <div class="swiper-slide"><img src="/html/page/index/assets/images/img-page2-category10.png" alt="요실금 팬티"></div>
	            <div class="swiper-slide"><img src="/html/page/index/assets/images/img-page2-category11.png" alt="목욕의자"></div>
	            <div class="swiper-slide"><img src="/html/page/index/assets/images/img-page2-category12.png" alt="이동변기"></div>
	            <div class="swiper-slide"><img src="/html/page/index/assets/images/img-page2-category13.png" alt="간이변기"></div>
	            <div class="swiper-slide"><img src="/html/page/index/assets/images/img-page2-category14.png" alt="경사로"></div>
	        </div>
	    </div>
	</div>

	<div class="page2-title">
	    <h2><em class="img">욕실</em><span class="out">에서도</span> <em class="text-primary2">안전하게</em></h2>
	    <p>
	        집안에서도, 집밖에서도<br>
	        불편함을 편함으로 해결해 드릴게요
	    </p>
	</div>

    <div class="page2-content1">
        <img src="/html/page/index/assets/images/img-page2-content1.png" alt="" class="img">
        <div class="box">
            <dl>
                <dt>안전한 욕실생활</dt>
                <dd>
                    미끄러운 사고 위험이 높은 공간으로<br> 
                    안전사고를 예방하는 복지용구를 소개합니다. 
                </dd>
            </dl>
            <a href="${_mainPath}/cntnts/page2-bath" class="btn btn-large btn-outline-primary is-arrow">복지용구 알아보기</a>
        </div>
    </div>

    <div class="page2-content2">
        <img src="/html/page/index/assets/images/img-page2-content2.png" alt="" class="img">
        <div class="box">
            <dl>
                <dt>편안한 거실생활</dt>
                <dd>
                    일상생활에서 가장 많이 활동하는 공간으로<br>
                    이동에 편리함을 주는 복지용구를 소개합니다. 
                </dd>
            </dl>
            <a href="${_mainPath}/cntnts/page2-living" class="btn btn-large btn-outline-primary is-arrow">복지용구 알아보기</a>
        </div>
    </div>

    <div class="page2-content3">
        <img src="/html/page/index/assets/images/img-page2-content3.png" alt="" class="img">
        <div class="box">
            <dl>
                <dt>안락한 침실생활</dt>
                <dd>
                    수면과 휴식을 취하는 공간에서 필요한<br>
                    복지용구를 소개합니다.
                </dd>
            </dl>
            <a href="${_mainPath}/cntnts/page2-bed" class="btn btn-large btn-outline-primary is-arrow">복지용구 알아보기</a>
        </div>
    </div>
    
    <div class="page2-content4">
        <img src="/html/page/index/assets/images/img-page2-content4.png" alt="" class="img">
        <div class="box">
            <dl>
                <dt>건강한 야외생활</dt>
                <dd>
                    많은 도움이 필요한 야외활동을 보조해주는<br>
                    복지용구를 소개합니다.
                </dd>
            </dl>
            <a href="${_mainPath}/cntnts/page2-outdoor" class="btn btn-large btn-outline-primary is-arrow">복지용구 알아보기</a>
        </div>
    </div>
</div>

<script>
    $(function() {
        var swiper = new Swiper(".swiper", {
            loop: true,
            slidesPerView: 'auto',
            spaceBetween: 12,
            speed: 5000,
            autoplay: {
                delay: 0,
                disableOnInteraction: false,
            },
            768: {
                spaceBetween: 16,
            },
            1024: {
                spaceBetween: 20,
            },
        });
    });
</script>