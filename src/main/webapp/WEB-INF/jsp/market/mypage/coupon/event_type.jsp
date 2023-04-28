<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<c:if test="${!empty param.eventType}">
	<c:choose>

		<%-- 무료배송 --%>
		<c:when test="${param.eventType eq 'FREE'}">
			<div class="coupon-item is-delivery sm-max:coupon-item-small xl:coupon-item-large">
				<div class="itembox">
					<div class="info">무료배송</div>
					<p class="desc">FREE Shipping</p>
				</div>
			</div>
		</c:when>

		<%-- 일반 정액 --%>
		<c:when test="${(param.eventType eq 'NOR' || param.eventType eq 'GRADE') && param.dscntTy eq 'SEMEN'}">
			<div class="coupon-item is-discount sm-max:coupon-item-small xl:coupon-item-large">
				<div class="itembox">
					<div class="info">
						<fmt:formatNumber value="${param.dscntAmt}" pattern="###,###" />
						<small>원</small>
					</div>
					<p class="desc">할인</p>
				</div>
			</div>
		</c:when>

		<%-- 일반 정율 --%>
		<c:when test="${(param.eventType eq 'NOR' || param.eventType eq 'GRADE') && param.dscntTy eq 'PRCS'}">
			<div class="coupon-item is-discount sm-max:coupon-item-small xl:coupon-item-large">
				<div class="itembox">
					<div class="info">
						<img src="/html/page/market/assets/images/img-coupon-discount.svg" alt=""> ${param.dscntAmt}<small>%</small>
					</div>
					<p class="desc">Discount coupon</p>
				</div>
			</div>
		</c:when>

		<%-- 생일 정율 --%>
		<%--<c:when test="${param.eventType eq 'BIRTH' && param.dscntTy eq 'PRCS'}">
			<div class="coupon-item is-event sm-max:coupon-item-small xl:coupon-item-large">
				<div class="itembox">
					<div class="info">
						<img src="/html/page/market/assets/images/img-coupon-birthday.svg" alt=""> ${param.dscntAmt} <small>%</small>
					</div>
					<p class="desc">Happy Birthday!</p>
				</div>
			</div>
		</c:when> --%>

		<%-- 생일 정액 --%>
		<%--<c:when test="${param.eventType eq 'BIRTH' && param.dscntTy eq 'SEMEN'}">
			<div class="coupon-item is-event sm-max:coupon-item-small xl:coupon-item-large">
				<div class="itembox">
					<div class="info">
						<fmt:formatNumber value="${param.dscntAmt}" pattern="###,###" />
						<small>원</small>
					</div>
					<p class="desc">Happy Birthday!</p>
				</div>
			</div>
		</c:when> --%>

		<%-- 회원 가입 정율 --%>
		<c:when test="${param.eventType eq 'JOIN' && param.dscntTy eq 'PRCS'}">
			<div class="coupon-item is-event sm-max:coupon-item-small xl:coupon-item-large">
				<div class="itembox">
					<div class="info">
						<img src="/html/page/market/assets/images/img-coupon-join.svg" alt=""> ${param.dscntAmt} <small>%</small>
					</div>
					<p class="desc">가입을 환영합니다</p>
				</div>
			</div>
		</c:when>

		<%-- 회원 가입 정액 --%>
		<c:when test="${param.eventType eq 'JOIN' && param.dscntTy eq 'SEMEN'}">
			<div class="coupon-item is-event sm-max:coupon-item-small xl:coupon-item-large">
				<div class="itembox">
					<div class="info">
						<fmt:formatNumber value="${param.dscntAmt}" pattern="###,###" /><small>원</small>
					</div>
					<p class="desc">가입을 환영합니다</p>
				</div>
			</div>
		</c:when>

		<%-- 첫구매 정율 --%>
		<%--<c:when test="${param.eventType eq 'FIRST' && param.dscntTy eq 'PRCS'}">
			<div class="coupon-item is-event sm-max:coupon-item-small xl:coupon-item-large">
				<div class="itembox">
					<div class="info">
						<img src="/html/page/market/assets/images/img-coupon-first.svg" alt="">${param.dscntAmt} <small>%</small>
					</div>
					<p class="desc">첫구매 감사쿠폰</p>
				</div>
			</div>
		</c:when> --%>

		<%-- 첫구매 정액 --%>
		<%--<c:when test="${param.eventType eq 'FIRST' && param.dscntTy eq 'SEMEN'}">
			<div class="coupon-item is-event sm-max:coupon-item-small xl:coupon-item-large">
				<div class="itembox">
					<div class="info">
						${param.dscntAmt} <small>원</small>
					</div>
					<p class="desc">첫구매 감사쿠폰</p>
				</div>
			</div>
		</c:when> --%>



	</c:choose>


</c:if>