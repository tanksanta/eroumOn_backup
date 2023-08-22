<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<main id="container">
	<header id="page-title">
		<h2>
			<span>회원가입</span>
			<small>Member Join</small>
		</h2>
	</header>

	<div id="page-content">
	    <dl class="member-type">
	        <dt>이로움ON 회원가입</dt>
	        <dd>
	            <a href="${_membershipPath}/registStep1" class="btn btn-eroum w-full">
	                <span>회원가입</span>
	            </a>
	        </dd>
	    </dl>
	    <dl class="member-type">
	        <dt>간편 회원가입</dt>
	        <dd>
                <a href="${_membershipPath}/kakao/auth" class="btn btn-kakao w-full">
	                <span>카카오 로그인</span>
	            </a>
                <a href="${_membershipPath}/naver/get" class="btn btn-naver w-full">
	                <span>네이버 로그인</span>
	            </a>
	        </dd>
	    </dl>
	</div>
</main>