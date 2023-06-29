<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<header id="subject">
	<nav class="breadcrumb">
		<ul>
			<li class="home"><a href="${_mainPath}">홈</a></li>
			<li>로그인</li>
		</ul>
	</nav>
	<h2 class="subject">
		로그인 <small> 3초만에 빠른 회원가입으로<br> 남은 혜택을 확인하세요
		</small>
	</h2>
</header>

<div id="content">
	<div class="flex flex-col items-center gap-3.5 mx-auto my-20 max-w-88 md:my-26 lg:my-33">
		<a href="${_membershipPath}/kakao/auth" class="btn btn-large btn-kakao w-full">카카오 로그인</a>
		<a href="${_membershipPath}/naver/get" class="btn btn-large btn-naver w-full">네이버 로그인</a>
		
		<c:choose>
			<c:when test="${empty param.returnUrl}">
				<a href="${_membershipPath}/login?returnUrl=/main" class="btn btn-large btn-outline-primary w-full">이로움 로그인</a>
			</c:when>
			<c:otherwise>
				<a href="${_membershipPath}/login?returnUrl=${param.returnUrl}" class="btn btn-large btn-outline-primary w-full">이로움 로그인</a>
			</c:otherwise>
		</c:choose>
		
		<a href="${_mainPath}" class="btn btn-large w-[56.81%] mt-17 md:mt-21">취소</a>
	</div>
</div>