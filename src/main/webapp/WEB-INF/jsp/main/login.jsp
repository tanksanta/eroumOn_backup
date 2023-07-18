<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<header id="subject">
	<nav class="breadcrumb">
		<ul>
			<li class="home"><a href="${_mainPath}">홈</a></li>
			<c:choose>
				<c:when test="${param.headerType eq 'money'}"><li>내 남은 금액 확인</li></c:when>
				<c:when test="${param.headerType eq 'info' }"><li>요양정보 간편조회</li></c:when>
				<c:otherwise><li>로그인</li></c:otherwise>
			</c:choose>
		</ul>
	</nav>
	<h2 class="subject">
		<c:choose>
				<c:when test="${param.headerType eq 'money'}">내 남은 금액 확인 <img src="/html/page/index/assets/images/ico-subject3.png" alt=""></c:when>
				<c:when test="${param.headerType eq 'info' }">요양정보 간편조회 <img src="/html/page/index/assets/images/ico-subject8.png" alt=""></c:when>
				<c:otherwise>로그인</c:otherwise>
			</c:choose>
		<small> 3초만에 빠른 회원가입으로<br> 남은 혜택을 확인하세요
		</small>
	</h2>
</header>

<div id="content">
	<div class="flex flex-col items-center gap-3.5 mx-auto my-20 max-w-88 md:my-26 lg:my-33">
		<a href="${_membershipPath}/kakao/auth" class="btn btn-kakao w-full">카카오 로그인</a>
		<a href="${_membershipPath}/naver/get" class="btn btn-naver w-full">네이버 로그인</a>
		
		<c:choose>
			<c:when test="${empty param.returnUrl}">
				<a href="${_membershipPath}/login?returnUrl=/main" class="btn btn-eroum w-full">이로움 로그인</a>
			</c:when>
			<c:otherwise>
				<a href="${_membershipPath}/login?returnUrl=${param.returnUrl}" class="btn btn-eroum w-full">이로움 로그인</a>
			</c:otherwise>
		</c:choose>
		
		<a href="${_mainPath}" class="btn btn-large w-[56.81%] mt-17 md:mt-21">취소</a>
	</div>
</div>