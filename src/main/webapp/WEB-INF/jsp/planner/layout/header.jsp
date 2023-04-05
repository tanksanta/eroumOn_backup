<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

	<!-- 페이지 헤더 -->
    <div id="header">
        <div class="container">
            <h1 id="logo"><a href="${_plannerPath}">EROUM</a></h1>
            <nav id="navigation">
                <ul>
                    <li><a href="${_plannerPath}/index" ${isIndex?'class="is-active"':''}>복지 서비스</a></li>
                    <li><a href="${_plannerPath}/Senior-Long-Term-Care" ${fn:indexOf(_curPath, 'Senior-Long-Term-Care') > -1?'class="is-active"':'' }>노인장기요양보험</a></li>
                    <li><a href="${_plannerPath}/Senior-Friendly-Foods" ${fn:indexOf(_curPath, 'Senior-Friendly-Foods') > -1?'class="is-active"':'' }>고령친화 우수식품</a></li>
                </ul>
            </nav>

			<c:if test="${_mbrSession.loginCheck}">
            <!-- 회원 -->
            <div id="account" class="is-login">
                <p>
                    <strong>${_mbrSession.mbrNm}</strong>
                    ${_mbrAge}세, ${_mbrAddr}
                </p>
                <a href="${_membershipPath}/mypage/list" class="btn btn-outline-primary">설정</a>
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
                            <li><a href="${_plannerPath}/Senior-Long-Term-Care">장기요양 서비스</a></li>
                            <li><a href="${_plannerPath}/Senior-Friendly-Foods">고령친화 우수식품</a></li>
                        </ul>
                    </div>

                    <!-- 미로그인시 표출 -->
                    <div class="allmenu-join">
                        <dl>
                            <dt>아직 회원이 아니신가요?</dt>
                            <dd>이로움과 함께<br> 새 삶을 누리세요!</dd>
                        </dl>
                        <div class="button non_login" >
                            <%--<a href="#modal-login" class="btn btn-outline-primary f_login" data-bs-toggle="modal" data-bs-target="#modal-login">로그인</a> --%>
                            <button type=button class="btn btn-outline-primary f_login">로그인</button>
                            <a href="${_membershipPath}/registStep1" class="btn btn-outline-primary">회원가입</a>
                        </div>
                        <div class="button on_login" style="display:none;">
                        	<a href="${_membershipPath}/mypage/list" class="btn btn-outline-primary">회원정보 수정</a>
                           	<a href="${_membershipPath}/logout" class="btn btn-outline-primary">로그아웃</a>
                        </div>
                    </div>
                    <!-- //미로그인시 표출 -->

                    <a href="${_marketPath }" class="allmenu-market">
                        <strong>이로움 마켓</strong>
                        복지용구 사업소와 수급자 매칭부터<br>
                        주문, 계약 및 결제까지 한번에!
                    </a>
                </div>
            </div>
            <!-- //모바일 메뉴 -->
        </div>
    </div>
    <!-- //페이지 헤더 -->