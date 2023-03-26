<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<main id="container">
	<header id="page-title">
		<h2>
			<span>휴면계정 해제</span>
			<small>Member Hibernate</small>
		</h2>
	</header>

	<div id="page-content">
		<div class="member-release-title">
			<img src="/html/page/members/assets/images/txt-sleep3.svg" alt="회원님의 계정이 휴면해제 되었습니다.">
			<p>이제 로그인 후 서비스를 정상적으로 이용할 수 있습니다.</p>
		</div>
		<div class="member-release-data mt-3 md:mt-4 md:mx-auto md:w-1/2">
			<dl>
				<dt>휴면 계정 해제일</dt>
				<dd><fmt:formatDate value="${mbrVO.mdfcnDt}" pattern="yyyy-MM-dd" /></dd>
			</dl>
		</div>
		<div class="text-center mt-12 md:mt-16">
			<a href="/membership/login" class="btn btn-large btn-primary w-62 md:w-75">로그인 하기</a>
		</div>
	</div>
</main>