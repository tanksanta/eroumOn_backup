<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

    <header id="header">
        <div class="container">
            <h1 id="logo" class="global-logo"><a href="${_mainPath}/index"><em>회원</em></a></h1>
            <nav id="navigation">
            	<c:choose>
	            	<c:when test="${_mbrSession.loginCheck}">
		                <ul>
		                    <li><a href="${_membershipPath}/logout" class="navigation-link">로그아웃</a></li>
		                    <li><a href="${_membershipPath}/mypage/list" class="navigation-link <c:if test="${fn:indexOf(_curPath, '/mypage/list') > -1}">is-active</c:if>">회원정보 수정</a></li>
		                    <li><a href="${_membershipPath}/whdwl/list" class="navigation-link <c:if test="${fn:indexOf(_curPath, '/whdwl/list') > -1}">is-active</c:if>">회원탈퇴</a></li>
		                </ul>
	                </c:when>
	                <c:otherwise>
	                	<ul>
							<li><a href="${_membershipPath}/login" class="navigation-link <c:if test="${fn:indexOf(_curPath, '/login') > -1}">is-active</c:if>">로그인</a></li>
		                    <li><a href="${_membershipPath}/registStep1" class="navigation-link <c:if test="${fn:indexOf(_curPath, '/registStep') > -1}">is-active</c:if>">회원가입</a></li>
		                </ul>
	                </c:otherwise>
                </c:choose>

            </nav>
            <ul id="family" class="global-link is-bottom">
				<li><a href="//www.youtube.com/@Super_Senior" target="_blank" class="link-item4"><span class="sr-only">슈퍼시니어</span></a></li>
                <!--li>
                    <a href="${_plannerPath}" class="link-item1" target="_blank" title="새창열림">
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
        </div>
    </header>
