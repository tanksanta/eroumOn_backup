<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!-- header -->
<header id="header">
	<h1 id="logo" class="global-logo">
		<a href="${_mainPath}/index">
			<em>이로움ON</em>
		</a>
	</h1>
    <nav id="navigation">
        <ul class="nav-items">
            <li class="nav-item">
                <a href="${_mainPath}/recipter/list">이로움 서비스</a>
                <div class="nav-sub-items">
                    <ul>
                        <li class="nav-sub-item"><a href="${_mainPath}/recipter/list">요양정보 간편조회</a></li>
                        <li class="nav-sub-item"><a href="/find/step2-1" target="_blank">인정 등급 예상 테스트</a></li>
                        <li class="nav-sub-item"><a href="${_mainPath}/searchBokji">복지정보 서비스</a></li>
                    </ul>
                </div>
            </li>
            <li class="nav-item">
                <a href="${_mainPath}/cntnts/page1">시니어 길잡이</a>
                <div class="nav-sub-items">
                    <ul>
                        <li class="nav-sub-item"><a href="${_mainPath}/cntnts/page1">노인장기요양보험제도</a></li>
                        <li class="nav-sub-item"><a href="${_mainPath}/cntnts/page2">복지용구 알아보기</a></li>
                        <li class="nav-sub-item"><a href="${_mainPath}/cntnts/page3">복지용구 선택하기</a></li>
                    </ul>
                </div>
            </li>
        </ul>
    </nav>
	<div id="utility">
		<ul>
			<c:choose>
				<c:when test="${!_mbrSession.loginCheck}">
					<li><a href="${_membershipPath}/login?returnUrl=/main">로그인</a></li>
					<li><a href="${_membershipPath}/regist" class="join">회원가입</a></li>
				</c:when>
				<c:otherwise>
					<li><a href="${_membershipPath}/index">마이페이지</a></li>
					<li><a href="${_membershipPath}/logout">로그아웃</a></li>
				</c:otherwise>
			</c:choose>

			<li>
				<a href="${_mainPath}/recipter/list" class="cost">남은 혜택보기​</a>
			</li>
		</ul>
	</div>
	<button type="button" id="allmenu-toggle" data-bs-toggle="offcanvas" data-bs-target="#allmenu">전체 메뉴 열기/닫기</button>
</header>

<div id="allmenu" tabindex="-1" class="offcanvas offcanvas-end">
	<c:if test="${!_mbrSession.loginCheck}">
	    <div class="offcanvas-header">
	        <ul>
	            <li><a href="${_membershipPath}/login?returnUrl=/main">로그인</a></li>
	            <li><a href="${_membershipPath}/regist">회원가입</a></li>
	        </ul>
	        <button class="closed" type="button" data-bs-toggle="offcanvas" data-bs-target="#allmenu-layer">레이어 닫기</button>
	    </div>
    </c:if>
    <div class="offcanvas-body">
    	<c:if test="${_mbrSession.loginCheck}">
	        <div class="user-info">
	            <div class="thumb"></div>
	            <div class="name">
	                ${_mbrSession.mbrNm}
	                <small>님</small>
	                <c:choose>
	                	<c:when test="${_mbrSession.joinTy eq 'K'}">
	                		<img src="/html/core/images/ico-kakao.png" alt="">
	                	</c:when>
	                	<c:when test="${_mbrSession.joinTy eq 'N' }">
	                		<img src="/html/core/images/ico-naver.png" alt="">
	                	</c:when>
	                	<c:otherwise>

	                	</c:otherwise>
	                </c:choose>
	            </div>
	            <a href="${_membershipPath}/logout" class="logout">로그아웃</a>
	        </div>
        </c:if>

        <dl class="menu-item1">
            <dt><a href="${_mainPath}/recipter/list"><img src="/html/page/index/assets/images/ico-allmenu1.png" alt=""> 이로움 서비스</a></dt>
            <dd>
                <ul>
                    <li><a href="${_mainPath}/recipter/list">요양정보 간편조회</a></li>
                    <li><a href="/find/step2-1" target="_blank">인정 등급 예상 테스트</a></li>
                    <li><a href="${_mainPath}/searchBokji">복지정보 서비스</a></li>
                </ul>
            </dd>
        </dl>
        <dl class="menu-item2">
            <dt><a href="${_mainPath}/cntnts/page1"><img src="/html/page/index/assets/images/ico-allmenu1.png" alt=""> 시니어 길잡이</a></dt>
            <dd>
                <ul>
                    <li><a href="${_mainPath}/cntnts/page1">노인장기요양보험제도</a></li>
                    <li><a href="${_mainPath}/cntnts/page2">복지용구 알아보기</a></li>
                    <li><a href="${_mainPath}/cntnts/page3">복지용구 선택하기</a></li>
                </ul>
            </dd>
        </dl>
    </div>
</div>
<!-- //header -->