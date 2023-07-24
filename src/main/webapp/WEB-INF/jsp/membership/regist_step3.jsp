<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<main id="container">
	<header id="page-title">
		<h2>
			<span>회원가입</span>
			<small>Member Join</small>
		</h2>
	</header>

	<div id="page-content">
		<div class="member-join">
			<div class="member-join-sidebar">
				<p class="text">
					<span>STEP 1</span>
				</p>
			</div>
			<div class="member-join-sidebar is-step2">
				<p class="text">
					<span>STEP 2</span>
				</p>
			</div>

			<div class="member-join-step3">
				<img src="/html/page/members/assets/images/txt-join-number3.svg" alt="STEP 3">
			</div>

			<div class="member-join-content">
				<ul class="member-tabs mb-5.5 xs:mb-11">
					<li><span>약관동의 및 본인인증</span></li>
					<li><span>정보입력</span></li>
					<li><a href="/membership/registStep3" class="active">가입완료</a></li>
				</ul>

				<p class="mx-auto -translate-x-3 max-w-82">
					<img src="/html/page/members/assets/images/img-join-complate.png" alt="">
				</p>

				<div class="content-complate mt-4">
					<dl>
						<dt>
							이로움ON 회원가입이 <strong>정상적으로 완료</strong>되었습니다
						</dt>
						<dd>
							${noMbrVO.mbrId } <small>(${noMbrVO.recipterYn eq 'Y'?'수급자회원':'일반회원' })</small>
						</dd>
					</dl>
					<p>
						자세한 회원정보는<br> 마이페이지 - 회원정보 - 회원정보수정에서 확인바랍니다.
					</p>
				</div>

				<div class="content-button mt-6 sm:mt-20">
					<a href="/membership/login" class="btn btn-primary btn-large flex-1">로그인</a>
				</div>

				<a href="/market/etc/bnft/list" target="_blank">
					<div class="content-benefit">
						<img src="/html/page/market/assets/images/img-join-complate2.png" alt="">
						<p>
							회원님을 특별하게 만들어주는<br> <strong>회원 혜택보기</strong>
						</p>
					</div>
				</a>
			</div>
		</div>
	</div>
</main>