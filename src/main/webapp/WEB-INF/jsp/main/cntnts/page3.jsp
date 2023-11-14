<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<header id="subject" class="is-white">
    <nav class="breadcrumb">
        <ul>
			<li class="home"><a href="${_mainPath}">홈</a></li>
            <li>시니어 길잡이</li>
            <li>복지용구 선택하기</li>
        </ul>
    </nav>
</header>

<div id="visual" class="is-page3">
    <div class="object1"></div>
    <div class="object2"></div>
    <div class="object3"></div>
    <div class="object4"></div>
    <h2 class="title">
		<span class="animate"><small>똑똑하게 복지용구 선택하기</small></span>
		<span class="animate2">복지용구,</span>
		<span class="animate3">어떻게 합리적으로 선택할까요?</span>
    </h2>
    <p class="text-scroll is-white"><i></i> 자세히 보기</p>
</div>

<div id="content">
    <div class="page3-content-container">
        <div class="page3-content1">
            <div class="box">
                <small>
                    <strong>복지용구는</strong><br> 
                    <strong class="text-primary2">노인장기요양보험</strong> <br class="md:hidden">
                    <strong>혜택 적용</strong>이 가능해요.
                </small>
                <h3>
                    <strong>연 160만원 한도액은</strong><br> 
                    인정등급 대상자라면 <br class="md:hidden">
                    <strong class="text-primary3">누구나 동일</strong>
                </h3>
                <p class="desc">예상 인정등급이 궁금하시면 지금 바로 해보세요!</p>
                <a href="${_mainPath}/cntnts/test" class="btn btn-large2 btn-primary3 btn-arrow"><strong>내 인정등급 확인하기</strong></a>
            </div>
            <img src="/html/page/index/assets/images/img-page3-content1.jpg" alt="" class="img">
        </div>
        
        <div class="page3-content2"> 
            <h3>단, <strong>100%</strong> 지원되지 않아요</h3>
            <small><strong>본인부담금</strong>과 <strong>본인부담율</strong>을 꼭 확인하세요.</small>
            <picture>
                <source srcset="/html/page/index/assets/images/img-page3-content4-m.jpg" media="(max-width: 768px)"> 
                <source srcset="/html/page/index/assets/images/img-page3-content4.jpg"> 
                <img src="/html/page/index/assets/images/img-page3-content4.jpg" alt="" />
            </picture>
        </div>

        <div class="page3-content3">
            <div>
                <h3>복지용구 FAQ</h3>
                <img src="/html/page/index/assets/images/img-page3-content3.jpg" alt="">
                <a href="${_mainPath}/cntnts/page3-faq" class="btn btn-large2 btn-outline-primary3 btn-arrow"><strong>바로가기</strong></a>
            </div>
            <div>
                <h3>복지용구 선택 방법</h3>
                <img src="/html/page/index/assets/images/img-page3-content3-2.jpg" alt="">
                <a href="${_mainPath}/cntnts/page3-checkpoint" class="btn btn-large2 btn-outline-primary2 btn-arrow"><strong>바로가기</strong></a>
            </div>
        </div>
    </div>
</div>