<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<main id="container">
	<div class="style-guide-content is-white">
		<div class="content-title">
	        <div class="images" style="background-image: url(/html/page/market/assets/images/img-main-visual4.jpg); background-position:center bottom;"></div>
	        <small class="slogan"><strong>Senior Life Style</strong> by Eroum <i></i> <strong>OUTDOOR</strong></small>
	        <h2 class="title">건강한 <em>아외생활</em></h2>
                <p class="desc">많은 사람들과 함께 불편할 수 있는 야외활동을 보조해주는 복지용구를 소개합니다.</p>
            <div class="back">
                <a href="${_marketPath}" class="is-main">뒤로가기</a>
                <a href="${_marketPath}/cntnts/style-guide-bathroom">욕실</a>
                <a href="${_marketPath}/cntnts/style-guide-livingroom">거실</a>
                <a href="${_marketPath}/cntnts/style-guide-bedroom">침실</a>
                <a href="${_marketPath}/cntnts/style-guide-outdoor" class="is-active">야외</a>
            </div>
	    </div>
		<div class="content-cards">
            <div class="card-item is-card5">
                <p class="name">성인용보행기</p>
                <p class="part">(실버카 / 롤레이터 / 워커)</p>
                <p class="desc">방향전환이 쉬워 활동적인 고객에게 맞춤인 복지용구</p>
	            <a href="${_marketPath}/cntnts/checkpoint#checkpoint-content3" class="link">구매 전 체크사항을 꼭! 확인하세요 <i></i></a>
	            <img src="/html/page/market/assets/images/img-content-bathroom5.png" alt="" class="image">
	            <a href="${_marketPath}/gds/2/list#37" class="btn btn-large btn-primary">복지용구 상품 바로보기</a>
            </div>
            <div class="card-item is-card6">
                <p class="name">지팡이</p>
                <p class="desc">보행을 도와줄 휴대성 좋은 복지용구</p>
	            <a href="${_marketPath}/cntnts/checkpoint#checkpoint-content7" class="link">구매 전 체크사항을 꼭! 확인하세요 <i></i></a>
	            <img src="/html/page/market/assets/images/img-content-bathroom6.png" alt="" class="image">
	            <a href="${_marketPath}/gds/2/list#39" class="btn btn-large btn-primary">복지용구 상품 바로보기</a>
            </div>
            <div class="card-item is-card7">
                <p class="name">요실금팬티</p>
                <p class="desc">기저귀착용보다 쾌적하고 편안한 복지용구</p>
				<a href="${_marketPath}/cntnts/checkpoint#checkpoint-content9" class="link">구매 전 체크사항을 꼭! 확인하세요 <i></i></a>
				<img src="/html/page/market/assets/images/img-content-bathroom7.png" alt="" class="image">
				<a href="${_marketPath}/gds/2/list#44" class="btn btn-large btn-primary">복지용구 상품 바로보기</a>
            </div>
            <div class="card-item is-card8">
                <p class="name">경사로(야외용)</p>
                <p class="desc">하체 근력이 없는 분들이 미끄러지거나 낙상사고 예방을 위한 복지용구</p>
	            <a href="${_marketPath}/cntnts/checkpoint#checkpoint-content14" class="link">구매 전 체크사항을 꼭! 확인하세요 <i></i></a>
	            <img src="/html/page/market/assets/images/img-content-bathroom8.png" alt="" class="image">
	            <a href="${_marketPath}/gds/2/list#40" class="btn btn-large btn-primary">복지용구 상품 바로보기</a>
            </div>
        </div>
	</div>
	<script>
	    $(function() {
	        $(window).on('scroll', function() {
	            if($('.style-guide-content').get(0).getClientRects()[0].y + $('.style-guide-content').get(0).getClientRects()[0].height > 0) {
	                $('.style-guide-content .images').css({'transform': 'translateY(' + ($(window).scrollTop() * -0.2)+ 'px)'});
	            }
	        });
	
	        $('.card-item a').on('click', function(e) {
	            e.stopPropagation();
	        });
	    })
	</script>
</main>