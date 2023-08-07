<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
    <header id="header">
        <h1 id="logo" class="global-logo">
            <a href="${_mainPath}/index"><em>이로움ON 회원</em></a>
        </h1>
        
        <nav id="navigation">
		<c:choose>
			<c:when test="${_mbrSession.loginCheck}">
				<ul>
					<li><a href="${_membershipPath}/logout" class="navigation-link">로그아웃</a></li>
					<li class="lg-max:hidden"><a href="${_membershipPath}/mypage/list" class="navigation-link is-join <c:if test="${fn:indexOf(_curPath, '/mypage/') > -1}">is-active</c:if>">회원정보 수정</a></li>
					<li class="lg-max:hidden"><a href="${_membershipPath}/whdwl/list" class="navigation-link <c:if test="${fn:indexOf(_curPath, '/whdwl/list') > -1}">is-active</c:if>">회원탈퇴</a></li>
				</ul>
			</c:when>
			<c:otherwise>
				<ul>
					<li><a href="${_membershipPath}/login" class="navigation-link <c:if test="${fn:indexOf(_curPath, '/login') > -1}">is-active</c:if>">로그인</a></li>
					<li><a href="${_membershipPath}/regist" class="navigation-link <c:if test="${fn:indexOf(_curPath, '/registStep') > -1}">is-active</c:if>">회원가입</a></li>
					<!-- li><a href="${_membershipPath}/mypage/form" class="navigation-link <c:if test="${fn:indexOf(_curPath, '/mypage/') > -1}">is-active</c:if>">내 정보 관리</a></li -->
				</ul>
			</c:otherwise>
		</c:choose>
       	</nav>
        
        <ul id="family" class="global-link is-bottom">
			<!-- li><a href="//www.youtube.com/@Super_Senior" target="_blank" class="link-item4"><span class="sr-only">슈퍼시니어</span></a></li -->
            <!--li>
                <a href="${_mainPath}" class="link-item1" target="_blank" title="새창열림">
                    <div class="bubble">
                        <small>시니어 라이프 케어 플랫폼</small>
                        <strong>"이로움ON"</strong>
                    </div>
                </a>
            </li>
            <li>
                <a href="${_mainPath}" class="link-item2" target="_blank" title="새창열림">
                    <div class="bubble">
                        <strong>이로움ON 멤버스</strong>
                        <small>전국 1,600개 업체와 함께합니다</small>
                    </div>
                </a>
            </li -->
            <li>
                <a href="${_marketPath}" class="link-item3" target="_blank" title="새창열림">
                    <div class="bubble">
                        <strong><img src="/html/core/images/txt-brand-link3.svg" alt="이로움ON 마켓"></strong>
                        <small>복지용구부터 시니어 생활용품까지 한번에!</small>
                    </div>
                </a>
            </li>
        </ul>
        
   		<c:if test="${_mbrSession.loginCheck}">
        <button type="button" id="allmenu-toggle" data-bs-toggle="offcanvas" data-bs-target="#allmenu">전체 메뉴 열기/닫기</button>
        </c:if>
    </header>

    <nav id="allmenu" tabindex="-1" class="offcanvas offcanvas-end">
        <div class="offcanvas-header">
			<c:if test="${!_mbrSession.loginCheck}">
	            <ul>
					<li><a href="${_membershipPath}/login">로그인</a></li>
					<li><a href="${_membershipPath}/regist">회원가입</a></li>
	            </ul>
			</c:if>
            <button class="closed" type="button" data-bs-toggle="offcanvas" data-bs-target="#allmenu-layer">레이어 닫기</button>
        </div>
        <div class="offcanvas-body">
		<c:choose>
			<c:when test="${_mbrSession.loginCheck}">
			<!-- 
			is-grade1 -- 이로움
			is-grade2 -- 반가움
			is-grade3 -- 새로움
			-->
            <div class="global-user">
                <div class="user-name">
                    <strong>${_mbrSession.mbrNm} <small>님</small></strong>
                    <span>수급자 회원</span>
                </div>
                <div class="user-info">
                    <div class="grade">
                        <strong>신규회원</strong>
                        <a href="${_marketPath}/etc/bnft/list">등급별혜택</a>
                    </div>
                    <div class="point">
                        <dl>
                            <dt>쿠폰</dt>
                            <dd><a href="#"><strong>5</strong> 장</a></dd>
                        </dl>
                        <dl>
                            <dt>포인트</dt>
                            <dd><a href="#"><strong>512</strong> <img src="/html/page/members/assets/images/txt-point-white.svg" alt="포인트"></a></dd>
                        </dl>
                        <dl>
                            <dt>마일리지</dt>
                            <dd><a href="#"><strong>5123</strong> <img src="/html/page/members/assets/images/txt-mileage-white.svg" alt="마일리지"></a></dd>
                        </dl>
                    </div>
                </div>
            </div>
            <dl class="menu-item1">
                <dt><a href="#">나의 상담 관리</a></dt>
                <dd>
                    <ul>
                        <li><a href="#">장기요양 상담신청</a></li>
                        <li><a href="#">관심 멤버스 설정</a></li>
                    </ul>
                </dd>
            </dl>
            <dl class="menu-item2">
                <dt><a href="${_membershipPath}/mypage/list">나의 정보 관리</a></dt>
                <dd>
                    <ul>
                        <li><a href="${_membershipPath}/mypage/list">내 정보수정</a></li>
                        <li><a href="#">배송지 관리</a></li>
                        <li><a href="${_membershipPath}/whdwl/list">회원탈퇴</a></li>
                    </ul>
                </dd>
            </dl>
            <dl class="menu-item3">
                <dt><a href="${_marketPath}/mypage/index">나의 쇼핑 관리</a></dt>
            </dl>
			</c:when>
			<c:otherwise>
            <div class="user-info">
                <div class="thumb"></div>
                <div class="name"><a href="${_membershipPath}/login">로그인이 필요한 서비스입니다.</a></div>
            </div>
			</c:otherwise>
		</c:choose>
        </div>
	</nav>