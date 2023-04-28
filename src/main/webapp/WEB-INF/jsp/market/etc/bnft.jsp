<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<main id="container">

	<jsp:include page="../layout/page_header.jsp">
		<jsp:param value="이로움ON 혜택" name="pageTitle" />
	</jsp:include>
	<div id="page-container">

		<jsp:include page="../layout/page_sidenav.jsp" />

		<div id="page-content">
	        <div class="benefit-infomation">
	            <div class="benefit-title">
	                <img src="/html/page/market/assets/images/txt-benefit.svg" alt="">
	            </div>
	            <div class="benefit-container">
	                <div class="benefit-grade">
	                    <img src="/html/page/market/assets/images/txt-benefit2.svg" alt="이로움ON에 가입하시고 평생 다양한 혜택과 서비스를 만나보세요">
	                </div>
	                <div class="px-4 md:px-5">
	                    <div class="benefit-grade-item">
	                        <dl>
                                <dt class="text-grade1">이로움</dt>
	                            <dd>누적 결제금액 360만원 이상</dd>
	                        </dl>
	                        <p><strong>2.5%</strong> 적립</p>
	                    </div>
	                    <div class="benefit-grade-item">
	                        <dl>
                                <dt class="text-grade2">반가움</dt>
	                            <dd>누적 결제금액 90만원 이상</dd>
	                        </dl>
	                        <p><strong>1.5%</strong> 적립</p>
	                    </div>
	                    <div class="benefit-grade-item">
	                        <dl>
                                <dt class="text-grade3">새로움</dt>
	                            <dd>누적 결제금액 30만원 이상</dd>
	                        </dl>
	                        <p><strong>0.5%</strong> 적립</p>
	                    </div>
	                    <div class="benefit-grade-item is-new">
	                        <dl>
                                <dt>신규회원</dt>
	                            <dd>할인쿠폰 5,000원 (3만원 이상 구입)</dd>
	                        </dl>
	                    </div>
	                </div>
	                <div class="py-6 mx-4 md:mx-5 md:py-8 md:px-5 lg:px-9">
	                    <dl class="text-alert is-danger">
	                        <dt><strong>이로움ON 마일리지 참고사항</strong></dt>
	                        <dd class="text-black2 mt-1.5">
	                            <ul class="list-normal">
	                                <li>할인쿠폰 및 적립혜택은 일반상품 (급여상품 제외) 에서 배송비를 제외한 결제금액만 적용됩니다.</li>
	                                <li>마일리지는 3,000M(가족회원 합산) 부터 10원 단위 사용 가능합니다.(최대 50,000M, 포인트와 중복 사용 가능)</li>
	                                <li>마일리지 유효기한은 적립일 기준 2년이며, 기준일 초과시 소멸됩니다.</li>
	                                <li>미사용 마일리지의 기한 연장 및 현금 환불 요청은 불가합니다.</li>
	                                <li>신규회원 할인쿠폰은 30,000원 이상시 사용 가능합니다.(회원가입 후 3개월 내 사용)</li>
	                            </ul>
	                        </dd>
	                    </dl>
	                    <dl class="text-alert is-danger mt-6 md:mt-7">
	                        <dt><strong>이로움ON 포인트 참고사항</strong></dt>
	                        <dd class="text-black2 mt-1.5">
	                            <ul class="list-normal">
	                                <li>적립한 포인트는 일반상품 구매시 사용 가능합니다. (마일리지와 중복 사용 가능)</li>
	                                <li>포인트는 3,000P(가족회원 합산) 부터 10원 단위 사용 가능합니다. (최대 50,000P)</li>
	                                <li>
	                                    포인트 유효기간은 적립년도 기준 매년 말일이며 12월 31일 24시 00분 소멸됩니다.<br>
	                                    (이벤트를 통해 부여된 포인트는 각 이벤트의 유효기간에 따릅니다)
	                                </li>
	                                <li>미사용 포인트의 기한 연장 및 현금 환불 요청은 불가합니다.</li>
	                            </ul>
	                        </dd>
	                    </dl>
	                </div>
	            </div>
	        </div>
		</div>
	</div>
</main>