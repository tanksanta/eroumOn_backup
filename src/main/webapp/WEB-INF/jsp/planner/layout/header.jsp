<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

	<!-- 페이지 헤더 -->
    <div id="header">
        <div class="container">
            <h1 id="logo"><a href="${_plannerPath}">EROUM</a></h1>
            <nav id="navigation">
                <ul>
                    <li><a href="${_plannerPath}/index" ${isIndex?'class="is-active"':''}>복지 서비스</a></li>
                    <li><a href="${_plannerPath}/cntnts/senior-long-term-care" ${fn:indexOf(_curPath, 'senior-long-term-care') > -1?'class="is-active"':'' }>노인장기요양보험</a></li>
                    <li><a href="${_plannerPath}/cntnts/senior-friendly-foods" ${fn:indexOf(_curPath, 'senior-friendly-foods') > -1?'class="is-active"':'' }>고령친화 우수식품</a></li>
                </ul>
            </nav>

			<c:if test="${_mbrSession.loginCheck}">
            <!-- 회원 -->
            <div id="account" class="is-login">
                <p>
                    <strong>${_mbrSession.mbrNm}</strong>
                    ${_mbrAge}세, ${_mbrAddr}
                </p>
                <a href="${_membershipPath}/mypage/list?returnUrl=/planner" class="btn btn-outline-primary">설정</a>
                <a href="${_membershipPath}/logout" class="btn btn-primary">로그아웃</a>
            </div>
            <!-- //회원 -->
            </c:if>

			<c:if test="${!_mbrSession.loginCheck}">
            <!-- 비회원 -->
            <div id="account" class="is-nologin">
                <a href="#modal-login" class="btn btn-primary f_login">로그인</a>
                <a href="${_membershipPath}/registStep1" class="btn btn-outline-primary">회원가입</a>
            </div>
            <!-- //비회원 -->
            </c:if>

            <!-- 모바일 메뉴 -->
            <button id="allmenu-trigger" data-bs-toggle="offcanvas" data-bs-target="#allmenu" aria-controls="allmenu">메뉴</button>
            <div id="allmenu" tabindex="-1" class="offcanvas offcanvas-end">
                <div class="offcanvas-header">
                    <button type="button" data-bs-dismiss="offcanvas" id="mobileClsBtn">닫기</button>
                </div>
                <div class="offcanvas-body">
                	<%--
                    <!-- 로그인시 표출 -->
                    <div class="allmenu-user">
                        <div class="wrapper">
                            <p class="name">회원명</p>
                            <p class="info">64세, 서울 용산구</p>
                            <p class="button">
                                <a href="#" class="btn btn-small btn-outline-primary">회원정보수정</a>
                                <a href="#" class="btn btn-small btn-primary">로그아웃</a>
                            </p>
                        </div>
                    </div>
                    <!-- //로그인시 표출 -->
                     --%>

                    <div class="allmenu-list">
                        <ul>
                            <li><a href="${_plannerPath}/index">복지 서비스</a></li>
                            <li><a href="${_plannerPath}/cntnts/senior-long-term-care">노인장기요양보험</a></li>
                            <li><a href="${_plannerPath}/cntnts/senior-friendly-foods">고령친화 우수식품</a></li>
                        </ul>
                    </div>

                    <!-- 미로그인시 표출 -->
                    <div class="allmenu-join">
                        <dl>
                            <dt>
                            	<c:if test="${_mbrSession.loginCheck}">이로움ON과 함께하세요</c:if>
                            	<c:if test="${!_mbrSession.loginCheck}">아직 회원이 아니신가요?</c:if>
                            </dt>
                            <dd>이로움ON과 함께<br> 새 삶을 누리세요!</dd>
                        </dl>

                        <%-- 로그인 전 --%>
                        <div class="button non_login" <c:if test="${_mbrSession.loginCheck}">style="display:none;"</c:if>>
                            <button type=button class="btn btn-outline-primary f_login">로그인</button>
                            <a href="${_membershipPath}/registStep1" class="btn btn-outline-primary">회원가입</a>
                        </div>
                        <%-- 로그인 후 --%>
                        <div class="button on_login" <c:if test="${!_mbrSession.loginCheck}">style="display:none;"</c:if>>
                        	<a href="${_membershipPath}/mypage/list" class="btn btn-outline-primary">회원정보 수정</a>
                           	<a href="${_membershipPath}/logout" class="btn btn-outline-primary">로그아웃</a>
                        </div>


                    </div>
                    <!-- //미로그인시 표출 -->

                    <a href="${_marketPath }" class="allmenu-market" target="_blank">
	                    <strong>이로움ON 마켓</strong>
	                    복지용구부터 시니어 생활용품까지 한번에!
                    </a>
                </div>
            </div>
            <!-- //모바일 메뉴 -->
        </div>
    </div>
    <!-- //페이지 헤더 -->