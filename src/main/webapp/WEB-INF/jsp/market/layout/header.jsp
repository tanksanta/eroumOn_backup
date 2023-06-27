<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

    <header id="header">
        <div class="container">
	        <h1 class="global-logo is-style2"><a href="${_mainPath}"><span>마켓</span></a></h1>
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
	<c:if test="${_mbrSession.loginCheck}">
	<%-- 로그인 케이스 --%>
    <!-- person -->
    <div id="personal" data-login-check="true">
        <div class="personal-layer">
            <div class="modal-content">
                <div class="modal-arrow"></div>
                <div class="modal-title">
                    <img src="/html/page/market/assets/images/txt-personal-link2.svg" alt="">
                    를 원하는 프로필을 선택하세요
                    <button type="button" id="clsLayer" data-unique-id="${_mbrSession.uniqueId}" data-prtcr-id="${_mbrSession.prtcrRecipterInfo.uniqueId}">닫기</button>
                </div>
            </div>
            <!-- <div class="modal-linkdesc">
                <img src="/html/page/market/assets/images/img-personal-link.png" alt="">
                <div>
                    <a href="#">
                        <small>이로움링크에 대해 알려드려요!</small>
                        <strong>링크가 뭐죠?</strong>
                    </a>
                    <a href="#">
                        <small>이렇게 활용해 보세요</small>
                        <strong>활용법 5가지</strong>
                    </a>
                </div>
            </div> -->
        </div>
    </div>
    <!-- //person -->
    </c:if>

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
