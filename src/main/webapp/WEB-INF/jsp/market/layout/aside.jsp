<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<c:choose>
	<%--aside : 상품 목록/상세만 노출 --%>
	<c:when test="${fn:indexOf(_curPath, '/gds/') > -1 }">
	<aside id="service">
        <div class="container">
            <div class="service-slogan">
                <div class="word"><p><span>SENIOR LIFE STYLE</span> <small>by E·ROUM</small></p></div>
                <div class="word"><p><span>시니어 라이프 스타일</span> <small>by E·ROUM</small></p></div>
            </div>
            <c:if test="${_mbrSession.loginCheck}">
            <a href="${_marketPath}/mypage/wish/list" class="service-interest"><span>관심상품</span> <i>${_mbrEtcInfoMap.totalWish}</i></a>
            <a href="${_marketPath}/mypage/cart/list" class="service-mycart"><span>장바구니</span> <i>${_mbrEtcInfoMap.totalCart}</i></a>
            </c:if>
            <!-- <a href="#" class="service-recent"><span>최근본상품</span> <i>0</i></a> -->
            <%--<div class="service-compare">
                <div class="container">
                    <button type="button" class="service-compare-toggle" data-bs-toggle="tooltip" title="상품비교">최근본상품</button>--%>
                    <%-- 최근본상품 리스트업 script 확인 --%>
                <%--</div>
            </div> --%>
            <p class="service-join">
                <strong>회원 가입</strong>하고<br>
                <em>제품가의 <span>15% ~ 0%</span></em> <strong>본인부담금</strong>만 <strong>결제</strong>하세요
            </p>
        </div>
        <div class="service-compare-layer">
        </div>
    </aside>
    </c:when>
</c:choose>