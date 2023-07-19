<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<main id="container" class="is-product">
        <h2 id="page-title">아이디 찾기</h2>

        <div id="page-container">
            <div id="page-content">
                <div class="member-form is-noborder">
                    <picture class="block sm:mb-6">
                        <source srcset="/html/page/market/assets/images/txt-search-id.svg">
                        <img src="/html/page/market/assets/images/txt-search-id.svg" alt="회원님이 가입하신 아이디는 다음과 같습니다" class="mx-auto">
                    </picture>
                    <p class="search-result">
                        <strong>${mbrVO.mbrId}</strong>(${noMbrVO.recipterYn eq 'Y'?'수급자회원':'일반회원' })
                    </p>
                    <div class="search-button complate">
                        <a href="${_marketPath}/info/srchPswd" class="btn btn-outline-primary wide">비밀번호 찾기</a>
                        <a href="${_marketPath}/login" class="btn btn-primary wide">로그인하기</a>
                    </div>
                    <p class="text-alert mt-5.5">위에 제공된 방법으로 아이디 찾기가 어려우실 경우 help@thkc.co.kr로 문의 주시기 바랍니다.</p>
                </div>
            </div>
        </div>
    </main>

