<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<main id="container">
	<div class="style-guide-bathroom">
	    <div class="bathroom-visual">
	        <div class="images"></div>
	        <small class="slogan"><strong>Senior Life Style</strong> by Eroum <i></i> <strong>BATHROOM</strong></small>
	        <h2 class="title">안전한 <em>욕실생활</em></h2>
	        <p class="desc">미끄러운 사고 위험이 높은 공간으로 안전사고를 예방하는 복지용구를 소개해드립니다.</p>
	    </div>
        <div class="bathroom-card">
            <div class="card-item is-card1">
                <div class="item-front">
                    <p class="name">안전손잡이_변기형</p>
                    <p class="part">(변기형, 벽걸이형, 기둥형)</p>
                    <p class="desc">신체가 불편하거나, 일어서거나 앉을 때 혈압이 떨어지는 상황에 도움되는 복지용구</p>
                    <a href="${_marketPath}/cntnts/checkpoint#checkpoint-content4" class="link">구매 전 체크사항을 꼭! 확인하세요 <i></i></a>
                    <img src="/html/page/market/assets/images/img-content-bathroom1.png" alt="" class="image">
                    <a href="${_marketPath}/gds/2/list#6" class="btn btn-large btn-primary">복지용구 상품 바로보기</a>
                </div>
            </div>
            <div class="card-item is-card2">
                <div class="item-front">
                    <p class="name">목욕의자</p>
                    <p class="desc">씻기 불편한 고객의 자세 유지 및 편안한 목욕에 도움되는 복지용구</p>
                    <a href="${_marketPath}/cntnts/checkpoint#checkpoint-content2" class="link">구매 전 체크사항을 꼭! 확인하세요 <i></i></a>
                    <img src="/html/page/market/assets/images/img-content-bathroom2.png" alt="" class="image">
                    <a href="${_marketPath}/gds/2/list#11" class="btn btn-large btn-primary">복지용구 상품 바로보기</a>
                </div>
            </div>
            <div class="card-item is-card3">
                <div class="item-front">
                    <p class="name">경사로(실내)</p>
                    <p class="desc">문턱에 발이 걸리는 안전사고를 예방하는 복지용구</p>
                    <a href="${_marketPath}/cntnts/checkpoint#checkpoint-content14" class="link">구매 전 체크사항을 꼭! 확인하세요 <i></i></a>
                    <img src="/html/page/market/assets/images/img-content-bathroom3.png" alt="" class="image">
                    <a href="${_marketPath}/gds/2/list#40" class="btn btn-large btn-primary">복지용구 상품 바로보기</a>
                </div>
            </div>
            <div class="card-item is-card4">
                <div class="item-front">
                    <p class="name">미끄럼방지 매트</p>
                    <p class="desc">하체 근력이 없거나, 신체기능이 떨어진 고객의 낙상사고 위험을 예방하는 복지용구</p>
                    <a href="${_marketPath}/cntnts/checkpoint#checkpoint-content5" class="link">구매 전 체크사항을 꼭! 확인하세요 <i></i></a>
                    <img src="/html/page/market/assets/images/img-content-bathroom4.png" alt="" class="image">
                    <a href="${_marketPath}/gds/2/list#38" class="btn btn-large btn-primary">복지용구 상품 바로보기</a>
                </div>
            </div>
        </div>
	</div>
	<script>
	    $(function() {
	        $(window).on('scroll', function() {
	            if($('.bathroom-visual').get(0).getClientRects()[0].y + $('.bathroom-visual').get(0).getClientRects()[0].height > 0) {
	                $('.bathroom-visual .images').css({'transform': 'translateY(' + ($(window).scrollTop() * -0.2)+ 'px)'});
	            }
	        });
	
	        $('.card-item a').on('click', function(e) {
	            e.stopPropagation();
	        });
	    })
	</script>
</main>