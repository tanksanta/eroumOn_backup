<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<div class="page2-visual">
    <h2 class="title">
        <small>부모님의 생활을 한층 편하게</small>
        복지용구가 일상생활에서<br>
        <em>꼭</em>필요한 이유
    </h2>
    <p class="text-scroll is-white">아래에서 더 자세히 알아보세요</p>
</div>

<div class="page2-category">
    <div class="swiper">
        <div class="swiper-wrapper">
            <div class="swiper-slide"><img src="/html/page/index/assets/images/img-page2-category1.png" alt=""></div>
            <div class="swiper-slide"><img src="/html/page/index/assets/images/img-page2-category2.png" alt=""></div>
            <div class="swiper-slide"><img src="/html/page/index/assets/images/img-page2-category3.png" alt=""></div>
            <div class="swiper-slide"><img src="/html/page/index/assets/images/img-page2-category4.png" alt=""></div>
            <div class="swiper-slide"><img src="/html/page/index/assets/images/img-page2-category5.png" alt=""></div>
            <div class="swiper-slide"><img src="/html/page/index/assets/images/img-page2-category6.png" alt=""></div>
            <div class="swiper-slide"><img src="/html/page/index/assets/images/img-page2-category7.png" alt=""></div>
            <div class="swiper-slide"><img src="/html/page/index/assets/images/img-page2-category8.png" alt=""></div>
            <div class="swiper-slide"><img src="/html/page/index/assets/images/img-page2-category9.png" alt=""></div>
            <div class="swiper-slide"><img src="/html/page/index/assets/images/img-page2-category10.png" alt=""></div>
            <div class="swiper-slide"><img src="/html/page/index/assets/images/img-page2-category11.png" alt=""></div>
            <div class="swiper-slide"><img src="/html/page/index/assets/images/img-page2-category12.png" alt=""></div>
            <div class="swiper-slide"><img src="/html/page/index/assets/images/img-page2-category13.png" alt=""></div>
            <div class="swiper-slide"><img src="/html/page/index/assets/images/img-page2-category14.png" alt=""></div>
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

<div class="page2-content">
    <div class="content-item">
        <div class="image">
            <img src="/html/page/index/assets/images/img-page2-content1.png" alt="">
        </div>
        <div class="content">
            <dl>
                <dt>안전한 욕실생활</dt>
                <dd>
                    미끄러운 사고 위험이 높은 공간으로<br> 
                    안전사고를 예방하는 복지용구를 소개합니다. 
                </dd>
            </dl>
            <a href="/main/cntnts/page2-bath" class="btn btn-large btn-outline-primary is-arrow">복지용구 알아보기</a>
        </div>
    </div>
    
    <div class="content-item">
        <div class="image">
            <img src="/html/page/index/assets/images/img-page2-content2.png" alt="">
        </div>
        <div class="content">
            <dl>
                <dt>편안한 거실생활</dt>
                <dd>
                    일상생활에서 가장 많이 활동하는 공간으로<br>
                    이동에 편리함을 주는 복지용구를 소개합니다. 
                </dd>
            </dl>
            <a href="/main/cntnts/page2-living" class="btn btn-large btn-outline-primary is-arrow">복지용구 알아보기</a>
        </div>
    </div>
    
    <div class="content-item">
        <div class="image">
            <img src="/html/page/index/assets/images/img-page2-content3.png" alt="">
        </div>
        <div class="content">
            <dl>
                <dt>안락한 침실생활</dt>
                <dd>
                    수면과 휴식을 취하는 공간에서 필요한<br> 
                    복지용구를 소개합니다.
                </dd>
            </dl>
            <a href="/main/cntnts/page2-bed" class="btn btn-large btn-outline-primary is-arrow">복지용구 알아보기</a>
        </div>
    </div>
    
    <div class="content-item">
        <div class="image">
            <img src="/html/page/index/assets/images/img-page2-content4.png" alt="">
        </div>
        <div class="content">
            <dl>
                <dt>건강한 야외생활</dt>
                <dd>
                    많은 도움이 필요한 야외활동을 보조해주는<br>
                    복지용구를 소개합니다.
                </dd>
            </dl>
            <a href="/main/cntnts/page2-outdoor" class="btn btn-large btn-outline-primary is-arrow">복지용구 알아보기</a>
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