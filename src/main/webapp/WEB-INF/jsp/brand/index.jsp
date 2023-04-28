<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%--
kkm : 브랜드 구성이 어떻게 되는지 몰라 레이아웃 작업안함
 --%>
<!DOCTYPE html>
<html lang="ko">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <c:set var="naverSiteVerification"><spring:eval expression="@props['Naver.Site.Verification']"/></c:set>
        <c:if test="${!empty naverSiteVerification}">
		<meta name="naver-site-verification" content="${naverSiteVerification}" />
		</c:if>

    	<link id="favicon" rel="shortcut icon" href="/html/core/images/favicon.ico" sizes="16x16">

        <title>이로움 브랜드</title>

        <link rel="stylesheet" href="/html/page/brand/assets/style/style.min.css">

        <link rel="stylesheet" href="/html/core/vendor/swiperjs/swiper-bundle.css">

        <script src="/html/core/vendor/jquery/jquery-3.6.0.min.js"></script>
        <script src="/html/core/vendor/swiperjs/swiper-bundle.min.js"></script>

        <script src="/html/page/brand/assets/script/index.js"></script>
    </head>
    <body>
        <header id="header">
            <h1>이로움</h1>
        </header>

        <main id="container">
            <nav id="navigation">
                <ul>
                    <li>
                        <a href="/market" class="nav-item">
                            <div class="icon">
                                <i class="base"></i>
                                <i class="hover"></i>
                            </div>
                            <div class="name">
                                <span class="base">이로움ON 마켓</span>
                                <span class="hover">바로가기</span>
                            </div>
                            <div class="bubble">
                                <dl>
                                    <dt><img src="/html/page/brand/assets/images/txt-navigation-item1.svg" alt="이로움ON 마켓"></dt>
                                    <dd>
                                        복지용구 멤버스와 수급자 매칭부터<br>
                                        주문, 계약 및 결제까지 한번에!
                                    </dd>
                                </dl>
                            </div>
                        </a>
                    </li>
                    <li>
                        <a href="/members" class="nav-item">
                            <div class="icon">
                                <i class="base"></i>
                                <i class="hover"></i>
                            </div>
                            <div class="name">
                                <span class="base">멤버스</span>
                                <span class="hover">지도로 보기</span>
                            </div>
                            <div class="bubble">
                                <dl>
                                    <dt>이로움 멤버스</dt>
                                    <dd>전국 2,000여개 업체와 함께합니다</dd>
                                </dl>
                            </div>
                        </a>
                    </li>
                </ul>
            </nav>
            <div class="swiper">
                <div class="swiper-wrapper">
                    <div class="swiper-slide slide-visual1">
                        <p>
                            <small>사람을 먼저 생각합니다</small>
                            시니어 세대의 <strong>삶의 가치를 높이고</strong><br>
                            건강하고 능동적인 <strong>노년을 위한 공간</strong>
                        </p>
                    </div>
                    <div class="swiper-slide slide-visual2">
                        <p>
                            <small>사람을 먼저 생각합니다</small>
                            노인장기요양보험을 시작으로<br>
                            <strong>시니어를 위한 제품과 정보</strong>를<br>
                            편리하고 신속하게 <strong>찾아주는</strong> 서비스
                        </p>
                    </div>
                    <div class="swiper-slide slide-visual3">
                        <p>
                            <small>사람을 먼저 생각합니다</small>
                            A~Z 세대와 장기 요양기관 등<br>
                            <strong>모든 사용자가 혜택</strong>을 누릴 수 있는<br>
                            <strong>유일한</strong> 시니어 라이프 케어 플랫폼
                        </p>
                    </div>
                    <div class="swiper-slide slide-visual4">
                        <img src="/html/page/brand/assets/images/txt-visual4.svg" alt="eroum for senior life care">
                    </div>
                </div>
                <div class="swiper-custom-progress">
                    <ul class="progress-link">
                        <li><a href="#"><sup>01</sup> <i></i> <span>for<br> Senior</span></a></li>
                        <li><a href="#"><sup>02</sup> <i></i> <span>so<br> Easy</span></a></li>
                        <li><a href="#"><sup>03</sup> <i></i> <span>onlyone<br> Platform</span></a></li>
                        <li><a href="#"><sup>04</sup> <i></i> <span>Senior<br> Life Care</span></a></li>
                    </ul>
                    <div class="progress-bar">
                        <div class="steps"></div>
                    </div>
                </div>
            </div>
        </main>

        <aside id="description">시니어 라이프 케어 플랫폼 <strong>"이로움"</strong></aside>

        <footer id="footer">
            <p>COPYRIGHT ⓒ <strong>eroum</strong>. ALL RIGHTS RESERVED.</p>
        </footer>

        <script src="/html/page/brand/assets/vendor/twelements/index.min.js"></script>
        <script src="/html/page/brand/assets/vendor/twelements/popper.min.js"></script>

        <c:set var="naverAnalytics"><spring:eval expression="@props['Naver.Analytics']"/></c:set>
		<c:if test="${!empty naverAnalytics}">
        <script type="text/javascript" src="//wcs.naver.net/wcslog.js"></script>
		<script type="text/javascript">
		if(!wcs_add) var wcs_add = {};
		wcs_add["wa"] = "${naverAnalytics}";
		if(window.wcs) {
			wcs_do();
		}
		</script>
		</c:if>
    </body>
</html>