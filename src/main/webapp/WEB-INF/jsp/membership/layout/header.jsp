<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

    <header id="header">
        <div class="container">
            <h1 id="header-logo">
                <a href="/membership/login"><span class="sr-only">이로움</span> 회원</a>
            </h1>
            <nav id="navigation">
            	<c:choose>
	            	<c:when test="${_mbrSession.loginCheck}">
		                <ul>
		                    <li><a href="${_membershipPath}/logout" class="navigation-link is-active">로그아웃</a></li>
		                    <li><a href="${_membershipPath}/mypage/list" class="navigation-link is-active">회원정보 수정</a></li>
		                    <li><a href="${_membershipPath}/whdwl/list" class="navigation-link is-active">회원탈퇴</a></li>
		                </ul>
	                </c:when>
	                <c:otherwise>
	                	<ul>
							<li><a href="/membership/login" class="navigation-link is-active">로그인</a></li>
		                    <li><a href="/membership/registStep1" class="navigation-link">회원가입</a></li>
		                </ul>
	                </c:otherwise>
                </c:choose>

            </nav>
            <ul id="family">
                <li>
                    <a href="${_plannerPath}/index" class="family-link1">
                        <div class="bubble">
                            <small>시니어 라이프 케어 플랫폼</small>
                            <strong>"이로움"</strong>
                        </div>
                    </a>
                </li>
                <li>
                    <a href="${_membersPath}" class="family-link2">
                        <div class="bubble">
                            <strong>이로움 멤버스</strong>
                            <small>전국 2,432개 업체와 함께합니다</small>
                        </div>
                    </a>
                </li>
                <li>
                    <a href="${_marketPath}" class="family-link3">
                        <div class="bubble">
                            <strong><img src="/html/page/members/assets/images/txt-family3.svg" alt="이로움마켓"></strong>
                            <small>
                                복지용구 사업소와 수급자 매칭부터<br>
                                주문, 계약 및 결제까지 한번에!
                            </small>
                        </div>
                    </a>
                </li>
            </ul>
        </div>
    </header>
