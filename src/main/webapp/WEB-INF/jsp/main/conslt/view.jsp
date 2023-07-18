<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<header id="subject">
	<nav class="breadcrumb">
		<ul>
			<li class="home"><a href="${_mainPath}">홈</a></li>
			<li>상담 신청 완료</li>
		</ul>
	</nav>
	<h2 class="subject">
		상담 신청 완료 <img src="/html/page/index/assets/images/ico-subject7.png" alt="">
	</h2>
</header>

<div id="content">
	<div class="mx-auto max-w-[800px]">

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
            <p class="mt-5 text-sm font-bold md:mt-6 md:text-base lg:mt-7 lg:text-lg">
                "영업일 기준, 2일 이내 해피콜 통해<br>
                안내받으실 수 있습니다."
            </p>
			<a href="${_mainPath}" class="btn btn-large btn-primary3 mt-15 w-57 md:mt-20 md:w-70 lg:mt-25">이로움ON 메인으로</a>
		</div>

        <script>
            $('.provide-complate').addClass('animate1');
            $('.provide-complate svg').one('animationend transitionend',function(){
                $('.provide-complate').removeClass('animate1').addClass('animate2');
            });
        </script>

		<div class="market-banner mt-28 md:mt-47">
	        <strong>
	            부모님 맞춤 상품이 필요하세요?​
	            <small>복지용구부터 시니어 생활용품까지 한 번에</small>
	        </strong>
			<a href="${_marketPath}">지금 둘러보기</a>
		</div>

		<div class="careinfo-content">
			<div class="content-item1">
				<dl>
					<dt>
						신청방법부터<br> 등급별 혜택까지
					</dt>
					<dd>
						노인장기요양보험,<br> 차근차근 배워보세요
					</dd>
				</dl>
				<div>
					<img src="/html/page/index/assets/images/img-careinfo-content1.png" alt="">
					<a href="${_mainPath}/cntnts/page1" class="btn btn-outline-primary2 btn-arrow"><strong>쉽게 알아보기</strong></a>
				</div>
			</div>
			<div class="content-item2">
				<dl>
					<dt>
						부모님의 생활을<br> 한층 편하게
					</dt>
					<dd>
						삶의 질을 높여주는<br> 복지용구, 소개해드릴게요
					</dd>
				</dl>
				<div>
					<img src="/html/page/index/assets/images/img-careinfo-content2.png" alt="">
					<a href="${_mainPath}/cntnts/page2" class="btn btn-outline-primary3 btn-arrow"><strong>복지용구 알아보기</strong></a>
				</div>
			</div>
			<div class="content-item3">
				<dl>
					<dt>
						똑똑하게<br> 복지용구 선택하기
					</dt>
					<dd>
						부모님을 위한 복지용구,<br> 아무거나 고를 순 없어요
					</dd>
				</dl>
				<div>
					<img src="/html/page/index/assets/images/img-careinfo-content3.png" alt="">
					<a href="${_mainPath}/cntnts/page3" class="btn btn-outline-primary2 btn-arrow"><strong>복지용구 선택하기</strong></a>
				</div>
			</div>
		</div>
	</div>
</div>
