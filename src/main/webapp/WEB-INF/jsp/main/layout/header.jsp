<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!-- notice -->
<aside id="notice">
	<div class="notice-banner1">
		<dl>
			<dt><em>장기요양인정등급</em>을 이미 받으셨나요?</dt>
			<dd>올해 남은 복지 혜택을 <em>여기에서 확인</em>하세요</dd>
		</dl>
		<a href="${_mainPath}/recipter/list?pageType=money">남은 금액보기</a>
	</div>
	<div class="notice-banner2">
		<dl>
			<dt>부모님 맞춤 제품이 필요하세요?</dt>
			<dd>편안한 일상생활 &amp; 미식을 책임지는 쇼핑몰</dd>
		</dl>
        <a href="${_marketPath}/index" target="_blank">지금 둘러보기</a>
	</div>
</aside>
<!-- //notice -->

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
					<li><a href="${_membershipPath}/login?returnUrl=/main">로그인</a></li>
					<li><a href="${_membershipPath}/registStep1" class="join">회원가입</a></li>
				</c:when>
				<c:otherwise>
					<li><a href="${_membershipPath}/logout">로그아웃</a></li>
				</c:otherwise>
			</c:choose>
			
			<li>
				<a href="${_mainPath}/recipter/list?pageType=money" class="cost">남은 금액보기</a>
			</li>
		</ul>
	</nav>
</header>
<!-- //header -->