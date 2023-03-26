<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<main id="container">
	<jsp:include page="../layout/page_header.jsp">
		<jsp:param value="회원가입" name="pageTitle"/>
	</jsp:include>

	<div id="page-container">
		<div id="page-content">
			<div class="member-join">
				<div class="member-join-container">
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
						<img src="/html/page/market/assets/images/txt-join-number3.svg" alt="STEP 3">
					</div>
					<div class="member-join-content">
						<ul class="member-tabs">
							<li><span>약관동의 및 본인인증</span></li>
							<li><span">정보입력</span></li>
							<li><a href="#" class="active">가입완료</a></li>
						</ul>

						<p class="mx-auto -translate-x-3 max-w-82">
							<img src="/html/page/market/assets/images/img-join-complate.png" alt="">
						</p>

						<div class="content-complate mt-4">
							<dl>
								<dt>
									이로움 마켓 회원가입이 <strong>정상적으로 완료</strong>되었습니다
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
							<a href="${_marketPath}/login" class="btn btn-primary btn-large flex-1">로그인</a>
							<a href="${_marketPath}/fml/app?sortBy=none&amp;returnUrl=${_marketPath}/fml/app?sortBy=none" class="btn btn-outline-primary btn-large flex-1">가족회원 등록</a>
						</div>

						<a href="${_marketPath}/etc/bnft/list">
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
		</div>
	</div>
</main>