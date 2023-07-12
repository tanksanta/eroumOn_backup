<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

    <header id="header">
        <div class="container">
	        <h1 class="global-logo is-style2"><a href="${_marketPath}"><span>마켓</span></a></h1>
	        <ul class="header-menu">
	        	<c:if test="${!_mbrSession.loginCheck}">
	            <li><a href="${_membershipPath }/login?returnUrl=${_curPath}">로그인</a></li>
	            <li><a href="${_membershipPath }/registStep1">회원가입</a></li>
	            </c:if>
	            <c:if test="${_mbrSession.loginCheck}">
	            <li><a href="${_marketPath}/logout">로그아웃</a></li>
	            <li><a href="${_marketPath }/mypage/index">마이페이지</a></li>
	            </c:if>
	            <li><a href="${_marketPath}/etc/faq/list">고객센터</a></li>
	        </ul>
        </div>
    </header>

	<c:if test="${fn:indexOf(_curPath, '/gds/') > -1}"><%-- 회원선택창은 상품*에서만 --%>

	<c:if test="${!_mbrSession.loginCheck}">
    <%-- 로그아웃 케이스 --%>
	<%--
	<!-- person -->
    <div id="personal" data-login-check="false">
        <div class="personal-info">
            <div class="personal-user">
                <img src="/html/page/market/assets/images/img-shopbag.png" alt="" class="bags">
                <span class="logout">Easy Equity Eroum Market</span>
            </div>
            <div class="personal-detail personal-onbase is-active">
                <div class="personal-container">

                    <div class="personal-cart">
                        <a href="#" class="interest">0</a>
                        <a href="#" class="mycart">0</a>
                        <a href="#" class="recent">0</a>
                    </div>
                </div>
            </div>
            <div class="personal-detail personal-oncart">
                <div class="personal-container">
                    <div class="personal-cart">
                        <a href="#" class="interest">0</a>
                        <a href="#" class="mycart">0</a>
                        <a href="#" class="recent">0</a>
                    </div>
                </div>
                <a href="#" class="personal-toggle">개인화 메뉴 펼치기/접기</a>
            </div>
        </div>
    </div>
    <!-- //person -->
    --%>
    </c:if>
	</c:if>
