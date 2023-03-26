<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<main id="container" class="is-product">
	<h2 id="page-title">가족회원 신청완료</h2>

	<div id="page-container">
		<div id="page-content">
			<div class="member-family-complate">
				<div class="complate-container">
					<div class="complate-user">
						<div class="thumb">
							<img src="/comm/proflImg?fileName=${mbrVO.proflImg}" />
						</div>
						<div class="content">
							<p class="id">${mbrVO.mbrId}</p>
							<p class="name">
								${mbrVO.mbrNm} <small><fmt:formatDate value="${mbrVO.brdt}" pattern="yyyy-MM-dd" /></small>
							</p>
						</div>
					</div>
					<div class="complate-title">
						<img src="/html/page/market/assets/images/img-family-complate.svg" class="deco" alt="">
						<img src="/html/page/market/assets/images/txt-family-complate.svg" class="name" alt="가족회원 초대장이 정상적으로 발송되었습니다.">
					</div>
					<p class="complate-desc">초대한 회원님의 수락 절차를 거친 후 가족회원 등록이 완료됩니다.</p>
					<div class="complate-button">
						<a href="${_marketPath}/" class="btn btn-primary btn-large w-29 md:w-47">확인</a>
						<a href="${_marketPath}/fml/app?sortBy=none" class="btn btn-outline-primary btn-large flex-1 lg:max-w-62">가족회원 신청 더하기</a>
					</div>
				</div>
			</div>
		</div>
	</div>
</main>