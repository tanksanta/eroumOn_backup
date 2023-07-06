<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<nav id="navigation">
	<div class="container">
		<button type="button" class="navigation-allmenu">
			<i></i> <span>전체 카테고리</span>
		</button>
		<div class="navigation-submenu">
			<ul>
				<c:forEach var="userMenu" items="${_userMenuList}" varStatus="status" begin="1">
					<li><a href="${userMenu.menuUrl}" <c:if test="${userMenu.linkTy eq 'S'}">target="_blank"</c:if>>${userMenu.menuNm}</a></li>
				</c:forEach>
				<!-- <li><a href="#">기획전</a></li>
				<li><a href="#">이벤트</a></li>
				<li><a href="#">고령친화 우수식품</a></li>
				<li><a href="#">스토리</a></li> -->
			</ul>
		</div>
		<!-- <div class="navigation-search">
			<button type="button" class="search-toggle">검색 펼치기 접기</button>
			<form action="" class="search-form">
				<div class="form-field">
					<legend>통합검색</legend>
					<input type="text" placeholder="검색어를 입력하세요">
					<button type="submit">검색</button>
				</div>
				<div class="form-current">
					<p class="current-title">
						최근 검색어 <a href="#">전체삭제</a>
					</p>
					<div class="current-items">
						<div class="current-item">
							<a href="#">실버카</a>
							<button type="button">삭제</button>
						</div>
						<div class="current-item">
							<a href="#">실버카</a>
							<button type="button">삭제</button>
						</div>
						<div class="current-item">
							<a href="#">실버카</a>
							<button type="button">삭제</button>
						</div>
						<div class="current-item">
							<a href="#">실버카</a>
							<button type="button">삭제</button>
						</div>
						<div class="current-item">
							<a href="#">실버카</a>
							<button type="button">삭제</button>
						</div>
						<div class="current-item">
							<a href="#">실버카</a>
							<button type="button">삭제</button>
						</div>
					</div>
					<div class="current-option">
						<div class="form-check form-switch option-switch">
							<input class="form-check-input" type="checkbox" id="search-save"> <label class="form-check-label" for="search-save">검색어 저장 끄기</label>
						</div>
						<button type="button" class="option-close">닫기</button>
					</div>
				</div>
			</form>
		</div> -->
		<ul class="navigation-util">
			<li><a href="${_marketPath }/mypage/index" class="util-item1">마이페이지</a></li>
			<li><a href="${_marketPath}/mypage/wish/list" class="util-item2">찜한상품</a></li>
			<li><a href="${_marketPath}/mypage/cart/list" class="util-item3">장바구니</a></li>
		</ul>
	</div>
	<%-- <div class="navigation-menu">
            <button type="button" class="allmenu" data-bs-toggle="offcanvas" data-bs-target="#allmenu">전체메뉴</button>
            <div class="container">
                <ul>
                	<c:forEach items="${_gdsCtgryList}" var="ctgry">
                	<c:if test="${ctgry.upCtgryNo == 1}">최상위
   					<c:set var="url" value="/gds/${ctgry.ctgryNo}/list"/>
                    <li<c:if test="${fn:indexOf(_curPath, url) > -1}"> class="active"</c:if>><a href="${_marketPath}/gds/${ctgry.ctgryNo}/list">${ctgry.ctgryNm}</a></li>
                    </c:if>
                	</c:forEach>
                    <li class="seperate"></li>
                    <li<c:if test="${fn:indexOf(_curPath, '/story/list') > -1}"> class="active"</c:if>><a href="${_marketPath}/etc/story/list">스토리</a></li>
                    <li<c:if test="${fn:indexOf(_curPath, '/dspy/list') > -1}"> class="active"</c:if>><a href="${_marketPath}/etc/dspy/list">기획전</a></li>
                    <li<c:if test="${fn:indexOf(_curPath, '/event/list') > -1}"> class="active"</c:if>><a href="${_marketPath}/etc/event/list?sortVal=all">이벤트</a></li>
                    <li<c:if test="${fn:indexOf(_curPath, '/coupon/list') > -1}"> class="active"</c:if>><a href="${_marketPath}/etc/coupon/list">쿠폰존</a></li>
                </ul>
            </div>
            <button type="button" class="toggle">메뉴 펼치기 접기</button>
        </div> --%>
	<%--
        <div class="navigation-search">
            <button type="button" class="navigation-search-toggle">검색 열기/닫기</button>
            <div class="navigation-search-layer">
                <form action="#" class="search">
                    <fieldset>
                        <legend>Search</legend>
                        <input type="search" class="input">
                        <button type="submit" class="submit">검색</button>
                        <button type="button" class="closed">닫기</button>
                    </fieldset>
                </form>
                <div class="keyword">
                    <div class="swiper">
                        <div class="swiper-wrapper">
                            <div class="swiper-slide recent">
                                <p class="title">최근 검색어</p>
                                <ul class="result">
                                    <li>
                                        <a href="#" class="name">수동휠체어 수동휠체어 수동휠체어 수동휠체어 수동휠체어 수동휠체어 수동휠체어 수동휠체어 수동휠체어 수동휠체어 수동휠체어 수동휠체어</a>
                                        <a href="#" class="delete">삭제</a>
                                    </li>
                                    <li>
                                        <a href="#" class="name">수동휠체어</a>
                                        <a href="#" class="delete">삭제</a>
                                    </li>
                                    <li>
                                        <a href="#" class="name">수동휠체어</a>
                                        <a href="#" class="delete">삭제</a>
                                    </li>
                                    <li>
                                        <a href="#" class="name">수동휠체어</a>
                                        <a href="#" class="delete">삭제</a>
                                    </li>
                                    <li>
                                        <a href="#" class="name">수동휠체어</a>
                                        <a href="#" class="delete">삭제</a>
                                    </li>
                                </ul>
                            </div>
                            <div class="swiper-slide best">
                                <p class="title">인기 검색어</p>
                                <ul class="result">
                                    <li>
                                        <span class="number">1</span>
                                        <a href="#" class="name">성인용 보행기 성인용 보행기 성인용 보행기 성인용 보행기 성인용 보행기 성인용 보행기 성인용 보행기 성인용 보행기 성인용 보행기</a>
                                    </li>
                                    <li>
                                        <span class="number">2</span>
                                        <a href="#" class="name">성인용 보행기</a>
                                    </li>
                                    <li>
                                        <span class="number">3</span>
                                        <a href="#" class="name">성인용 보행기</a>
                                    </li>
                                    <li>
                                        <span class="number">4</span>
                                        <a href="#" class="name">성인용 보행기</a>
                                    </li>
                                    <li>
                                        <span class="number">5</span>
                                        <a href="#" class="name">성인용 보행기</a>
                                    </li>
                                </ul>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>

         --%>

	<%--<div class="navigation-clock">
            <span class="hour">12</span>
            <span class="mins">00</span>
        </div> --%>
</nav>

<%-- <div id="allmenu" tabindex="-1" class="offcanvas offcanvas-start">
        <div class="offcanvas-header">
            <button class="closed" type="button" data-bs-toggle="offcanvas" data-bs-target="#allmenu">레이어 닫기</button>
            <!-- <div class="logout">
                로그인 하시고<br>
                혜택을 받으세요
            </div> -->
            <div class="login">
            	<c:if test="${!_mbrSession.loginCheck}">
                <p class="name"><strong>환영합니다</strong></p>
                </c:if>
                <c:if test="${_mbrSession.loginCheck}">
				<p class="name"><strong>${_mbrSession.mbrNm }</strong>님</p>
                <img src="/html/page/market/assets/images/img-shopbag.png" alt="" class="bags">
                <p class="rank">
                    <small>${_mbrSession.recipterYn eq 'Y'?'수급자회원':'일반회원'}</small>
                    <strong ${_mbrSession.mberGrade eq 'E' ? ' class="text-grade1"' : _mbrSession.mberGrade eq 'B' ? ' class="text-grade2"' : _mbrSession.mberGrade eq 'S' ? ' class="text-grade3"' : _mbrSession.mberGrade eq 'N' ? '' : ''}>
               			${gradeCode[_mbrSession.mberGrade]}
                	</strong>
                </p>
                </c:if>
            </div>
        </div>
        <div class="offcanvas-body">
            <div class="button">
                <picture>
                    <source srcset="/html/page/market/assets/images/txt-header-nav-mobile.svg" media="(max-width: 1024px)">
                    <source srcset="/html/page/market/assets/images/txt-header-nav.svg">
                    <img src="/html/page/market/assets/images/txt-header-nav.svg" alt="" />
                </picture>
                <c:if test="${!_mbrSession.loginCheck}">
				<a href="${_membershipPath }/login?returnUrl=${_curPath}">로그인</a>
				<a href="${_membershipPath }/registStep1">회원가입</a>
                </c:if>
                <c:if test="${_mbrSession.loginCheck}">
                <a href="${_marketPath}/logout">로그아웃</a>
				<a href="${_marketPath }/mypage/index">마이페이지</a>
                </c:if>
            </div>
            <ul class="menu-items">
            	<c:forEach items="${_gdsCtgryList}" var="ctgry" begin="1" varStatus="status">
            	<c:if test="${ctgry.levelNo == 2}">
                <li class="menu-item">
                    <a href="${_marketPath}/gds/${ctgry.ctgryNo}/list">
                        <strong>${ctgry.ctgryNm}</strong>
                        <!-- <small>welfare<br> equipment</small> -->
                    </a>
                    <div class="sub-items">
                        <!-- <p><img src="/html/page/market/assets/images/txt-header-nav-menu1.svg" alt="welfare equipment"></p> -->
                        <ul>
                </c:if>

                	<c:if test="${ctgry.levelNo == 3}">
						<li class="sub-item ${ctgryNo eq ctgry.ctgryNo?'is-active':''}"><a href="${_marketPath}/gds/${ctgry.upCtgryNo}/${ctgry.ctgryNo}/list">${ctgry.ctgryNm}</a></li>
                	</c:if>

                <c:if test="${status.last || _gdsCtgryList[status.index + 1].levelNo == 2}">
                        </ul>
                    </div>
                </li>
                </c:if>
                </c:forEach>
            </ul>
            <ul class="list-items">
                <li class="list-item"><a href="${_marketPath}/etc/story/list">스토리</a></li>
                <li class="list-item"><a href="${_marketPath}/etc/dspy/list">기획전</a></li>
                <li class="list-item"><a href="${_marketPath}/etc/event/list?sortVal=all">이벤트</a></li>
                <li class="list-item"><a href="${_marketPath}/etc/coupon/list">쿠폰존</a></li>
                <li class="list-item"><a href="${_marketPath}/etc/faq/list">고객센터</a></li>
            </ul>
        </div>
         --%>
    </div>