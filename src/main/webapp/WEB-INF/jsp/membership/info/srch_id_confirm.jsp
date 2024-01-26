<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<main id="container">
	<header id="page-title">
		<h2>
			<span>아이디 찾기</span>
			<small>Id Search</small>
		</h2>
	</header>

	<div id="page-content">
		<div class="search-form">
			<picture class="block sm:mb-6">
			<source srcset="/html/page/members/assets/images/txt-search-id.svg">
			<img src="/html/page/members/assets/images/txt-search-id.svg" alt="회원님이 가입하신 아이디는 다음과 같습니다" class="mx-auto"> </picture>
			<div class="form-result" style="margin-top:2.5rem; margin-bottom:2.5rem; margin-left:auto; margin-right:auto; width:350px;">
				<c:if test="${ !empty eroumAuthInfo }">
					<div class="flex w-full mb-4">
						<img style="margin-right:15px; border-radius:100%; width:30px; max-width:30px; height:30px;" src="/html/core/images/ico-eroum2.png">
						<div style="line-height:30px;">이로움ON <span style="color:gray; opacity:0.6;">&nbsp;|&nbsp;</span> ${ eroumAuthInfo.mbrId }</div>
					</div>
				</c:if>
			
				<%--
				<c:if test="${ !empty kakaoAuthInfo }">
					<div class="flex w-full mb-4">
						<img style="margin-right:15px; border-radius:100%; width:30px; max-width:30px; height:30px;" src="/html/core/images/ico-kakao.png">
						<div style="line-height:30px;">카카오 <span style="color:gray; opacity:0.6;">&nbsp;|&nbsp;</span> ${ !empty kakaoAuthInfo.eml ? kakaoAuthInfo.eml : kakaoAuthInfo.mblTelno }</div>
					</div>
				</c:if>
				
				<c:if test="${ !empty naverAuthInfo }">
					<div class="flex w-full mb-4">
						<img style="margin-right:15px; border-radius:100%; width:30px; max-width:30px; height:30px;" src="/html/core/images/ico-naver.png">
						<div style="line-height:30px;">네이버 <span style="color:gray; opacity:0.6;">&nbsp;|&nbsp;</span> ${ naverAuthInfo.eml }</div>
					</div>
				</c:if>
				--%>
			</div>
			<div class="form-button complate">
				<a href="/membership/srchPswd" class="btn btn-outline-primary">비밀번호 찾기</a>
				<a href="/membership/login" class="btn btn-primary">로그인하기</a>
			</div>
			<!--
			<p class="text-alert mt-5.5">간편가입 회원은 비밀번호 재설정이 제공되지 않습니다. 각 소셜 서비스를 통해 확인 부탁드립니다.</p>
			-->
		</div>
	</div>
</main>