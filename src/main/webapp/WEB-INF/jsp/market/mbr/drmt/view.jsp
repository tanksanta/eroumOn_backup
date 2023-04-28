<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<main id="container">
	<h2 id="page-title">휴면계정 안내</h2>

	<div id="page-container">
		<div id="page-content">
			<div class="member-release-title is-glass">
				<img src="/html/page/market/assets/images/txt-sleep2.svg" alt="회원님의 계정은 휴면상태 입니다.">
				<p>
					<span class="text-lg md:text-xl">안녕하세요, <strong class="text-xl md:text-2xl">${mbrVO.mbrNm}</strong> 회원님!
					</span><br> 이로움ON 마켓을 1년 이상 로그인하지 않아,<br class="md:hidden"> 계정이 휴면 상태로 전환되었습니다.
				</p>
			</div>
			<div class="member-release-data mt-3 md:mt-4">
				<dl>
					<dt>마지막 접속일</dt>
					<dd><fmt:formatDate value="${mbrVO.recentCntnDt}" pattern="yyyy-MM-dd" /></dd>
				</dl>
				<dl>
					<dt>휴면 계정 전환일</dt>
					<dd><fmt:formatDate value="${mbrVO.mdfcnDt}" pattern="yyyy-MM-dd" /></dd>
				</dl>
			</div>
			<div class="mt-11 flex flex-col items-center md:mt-15">
				<p class="text-alert">
					이로움ON 마켓을 계속 이용하시려면 <strong>[휴면 해제하기]</strong>를 클릭하여 본인인증을 진행해 주세요.
				</p>
				<div class="flex justify-center gap-2 mt-5 w-full text-center md:gap-2.5 md:mt-6">
					<a href="${_marketPath}/index" class="btn btn-large btn-outline-primary w-51 md:w-62">취소</a>
					<!-- TO-DO 본인인증 -->
					<a href="${_marketPath}/drmt/action" class="btn btn-large btn-primary w-51 md:w-62">휴면 해제하기</a>
				</div>
			</div>
		</div>
	</div>
</main>