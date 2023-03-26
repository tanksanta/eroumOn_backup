<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<main id="container">
	<h2 class="text-title">
		이로움 멤버스 로그인 <span class="inline-block">정보 찾기</span> <small>이로움멤버스 관리자 아이디 / 비밀번호를 찾을 수 있습니다.</small>
	</h2>

	<ul class="tabs-list">
		<li><a href="./idSrch" class="active">아이디 찾기</a></li>
		<li><a href="./pswdSrch">비밀번호 찾기</a></li>
	</ul>

	<form class="form-container">
		<fieldset>
			<p class="text-[1.375rem] font-medium text-center leading-snug xs:text-[1.625rem]">가입하신 아이디는 다음과 같습니다.</p>

			<p class="mt-5.5 mb-14 text-center text-3xl font-bold xs:mt-6.5 xs:mb-17 xs:text-5xl text-[#6D42E6]">${bplcId}</p>
			<div class="btn-group">
				<a href="./login" class="btn-partner large shadow">로그인하기</a>
				<a href="./pswdSrch" class="btn-cancel large shadow">비밀번호찾기</a>
			</div>
			<p class="mt-8 leading-snug fond-medium text-center text-gray1 xs:mt-10">
				위에 제공된 방법으로 아이디 찾기가 어려우실 경우<br> <span class="text-success">고객센터 02-830-1301</span>로 문의 주시기 바랍니다.
			</p>
		</fieldset>
	</form>
</main>