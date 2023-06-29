<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!-- header -->
<header id="header">
	<h1 id="logo" class="global-logo">
		<a href="${_mainPath}/index">
			<em>이로움ON</em>
		</a>
	</h1>
	<nav id="navigation">
		<ul>
			<c:choose>
				<c:when test="${!_mbrSession.loginCheck}">
					<li><a href="${_mainPath}/login">로그인</a></li>
					<li><a href="${_membershipPath}/registStep1" class="join">회원가입</a></li>
				</c:when>
				<c:otherwise>
					<li><a href="${_membershipPath}/logout">로그아웃</a></li>
				</c:otherwise>
			</c:choose>
			
			<li>
				<a href="#" class="cost">남은 금액보기</a>
			</li>
		</ul>
	</nav>
</header>
<!-- //header -->