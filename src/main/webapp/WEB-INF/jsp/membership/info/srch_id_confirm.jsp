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
			<p class="form-result">
				<strong>${mbrVO.mbrId}</strong> (${noMbrVO.recipterYn eq 'Y'?'수급자회원':'일반회원' })
			</p>
			<div class="form-button complate">
				<a href="/membership/srchPswd" class="btn btn-outline-primary">비밀번호 찾기</a>
				<a href="/membership/login" class="btn btn-primary">로그인하기</a>
			</div>
			<p class="text-alert mt-5.5">위에 제공된 방법으로 아이디 찾기가 어려우실 경우 고객센터 02-830-1301로 문의 주시기 바랍니다.</p>
		</div>
	</div>
</main>