<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<main id="container">
	<header id="page-title">
		<h2>
			<span>회원가입</span>
			<small>Member Join</small>
		</h2>
	</header>

	<div id="page-content">
		<div class="member-join-introduce">
			<div class="title">
				<img src="/html/page/members/assets/images/txt-join-white.svg" alt="이로움ON과 함께 삶을 누리세요">
			</div>
			<dl class="join1">
				<dt>본인인증</dt>
				<dd>
					<a href="/membership/registStep1" class="btn btn-large btn-outline-primary">
					<strong>회원 가입하기</strong></a>
				</dd>
			</dl>
			<!-- <dl class="join2">
				<dt>간편 가입</dt>
				<dd>
					<a href="#" class="btn btn-large btn-kakao btn-outline-primary">
					<strong>카카오</strong>로 회원가입</a>
					<a href="#" class="btn btn-large btn-naver btn-outline-primary">
					<strong>네이버</strong>로 회원가입</a>
				</dd>
			</dl> -->
		</div>
	</div>
</main>

<script>
$(function(){

	$("body").addClass("is-background is-join");
});
</script>