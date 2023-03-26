<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<main id="container">

	<jsp:include page="../layout/page_header.jsp">
		<jsp:param value="이로움 혜택" name="pageTitle" />
	</jsp:include>
	<div id="page-container">

		<jsp:include page="../layout/page_sidenav.jsp" />

		<div id="page-content">
			<ul class="nav nav-tabs tabs" id="tabs-tab" role="tablist">
				<li class="nav-item" role="presentation"><a href="#tabs-benefit1" class="nav-link tabs-link active" data-bs-toggle="pill" data-bs-target="#tabs-benefit1" role="tab" aria-selected="true">회원혜택</a></li>
				<li class="nav-item" role="presentation"><a href="#tabs-benefit2" class="nav-link tabs-link" data-bs-toggle="pill" data-bs-target="#tabs-benefit2" role="tab" aria-selected="false">마일리지/포인트 혜택</a></li>
			</ul>

			<div class="benefit-infomation mt-3 md:mt-5">
				<div class="benefit-title">
					<img src="/html/page/market/assets/images/txt-benefit-mobile.svg" alt="">
				</div>
				<div class="tab-content benefit-container">
					<div class="tab-pane show active" id="tabs-benefit1" role="tabpanel">
						<div class="benefit-grade">
							<img src="/html/page/market/assets/images/txt-benefit2.svg" alt="이로움에 가입하면 다양한 혜택을 누릴수 있습니다.">
							<p>회원가입시 3,000원 할인 쿠폰 지급 / 3,000마일리지 적립 / 300포인트 적립</p>
							<p>첫 구매시 5,000원 할인쿠폰 / 생일축하 5,000원 할인쿠폰</p>
						</div>
                        <div class="px-4 md:px-5">
                            <div class="benefit-grade-item">
                                <dl>
                                    <dt>PLATINUM</dt>
                                    <dd>전월 누적 결제금액<br> 500만원 이상</dd>
                                </dl>
                                <p>
                                    <span><strong>2.5%</strong> 할인</span>
                                    <i>/</i>
                                    <span><strong>0.5%</strong> 적립</span>
                                    
                                </p>
                            </div>
                            <div class="benefit-grade-item">
                                <dl>
                                    <dt class="text-[#098A0C]">VIP</dt>
                                    <dd>전월 누적 결제금액<br> 300만원 이상</dd>
                                </dl>
                                <p>
                                    <span><strong>2.0%</strong> 할인</span>
                                    <i>/</i>
                                    <span><strong>0.4%</strong> 적립</span>
                                </p>
                            </div>
                            <div class="benefit-grade-item">
                                <dl>
                                    <dt class="text-[#DDB842]">GOLD</dt>
                                    <dd>전월 누적 결제금액<br> 150만원 이상</dd>
                                </dl>
                                <p>
                                    <span><strong>1.5%</strong> 할인</span>
                                    <i>/</i>
                                    <span><strong>0.3%</strong> 적립</span>
                                </p>
                            </div>
                            <div class="benefit-grade-item">
                                <dl>
                                    <dt class="text-[#97989C]">SILVER</dt>
                                    <dd>전월 누적 결제금액<br> 50만원 이상</dd>
                                </dl>
                                <p>
                                    <span><strong>1.0%</strong> 할인</span>
                                    <i>/</i>
                                    <span><strong>0.2%</strong> 적립</span>
                                </p>
                            </div>
                            <div class="benefit-grade-item">
                                <dl>
                                    <dt class="text-[#BF1209]">RED</dt>
                                    <dd>전월 누적 결제금액<br> 50만원 미만</dd>
                                </dl>
                                <p>
                                    <span><strong>0.5%</strong> 할인</span>
                                    <i>/</i>
                                    <span><strong>0.1%</strong> 적립</span>
                                </p>
                            </div>
                        </div>
                        <div class="py-6 mx-4 md:mx-5 md:py-8 md:px-5 lg:px-9">
                            <dl class="text-alert is-danger">
                                <dt><strong>이로움혜택 참고사항</strong></dt>
                                <dd class="text-black2 mt-1.5">
                                    <ul class="list-normal">
                                        <li>할인, 적립 혜택은 비급여제품만(급여제품 제외) 배송비를 제외한 결제총액에서 적용됩니다.</li>
                                        <li>전월 누적 결제금액은 매월 1일, 오전2시 직전 월 총 결제 누적 금액을 반영하여 새로운 회원등급이 부여됩니다.</li>
                                        <li>회원가입, 첫 구매 감사, 생일축하 쿠폰 및 마일리지는 전 등급 지급됩니다.</li>
                                        <li>첫 구매 감사쿠폰은 첫 구매상품 ‘구매확정’ 시 5,000원 할인쿠폰이 지급됩니다.</li>
                                        <li>생일축하쿠폰은 회원정보 등록 생년월일을 기준으로 년 1회 5,000원 할인 쿠폰 지급됩니다.</li>
                                    </ul>
                                </dd>
                            </dl>
                        </div>
					</div>
					<div class="tab-pane" id="tabs-benefit2" role="tabpanel">
						<div class="px-4 pt-6 pb-12 md:px-5 md:pt-10 md:pb-15">
							<div class="md:px-5 lg:px-9">
								<p class="text-xl font-black md:text-2xl">마일리지</p>
                                <ul class="benefit-grade-item2">
                                    <li>
                                        <dl>
                                            <dt>PLATINUM</dt>
                                            <dd>0.5% <small>적립</small></dd>
                                        </dl>
                                    </li>
                                    <li>
                                        <dl>
                                            <dt class="text-[#098A0C]">VIP</dt>
                                            <dd>0.4% <small>적립</small></dd>
                                        </dl>
                                    </li>
                                    <li>
                                        <dl>
                                            <dt class="text-[#DDB842]">GOLD</dt>
                                            <dd>0.3% <small>적립</small></dd>
                                        </dl>
                                    </li>
                                    <li>
                                        <dl>
                                            <dt class="text-[#97989C]">SILVER</dt>
                                            <dd>0.2% <small>적립</small></dd>
                                        </dl>
                                    </li>
                                    <li>
                                        <dl>
                                            <dt class="text-[#BF1209]">RED</dt>
                                            <dd>0.1% <small>적립</small></dd>
                                        </dl>
                                    </li>
                                </ul>
								<dl class="text-alert is-danger mt-5 md:mt-7.5">
									<dt>
										<strong>마일리지 참고사항</strong>
									</dt>
									<dd class="text-black2 mt-1.5">
										<ul class="list-normal">
											<li>적립한 마일리지는 비급여 제품 결제 시에 사용 가능합니다. (포인트와 중복 사용 불가)</li>
											<li>보유한 마일리지는 5,000M부터 사용 가능합니다. (최대 50,000M)</li>
											<li>마일리지 유효기간은 1년이며 기간이 경과된 마일리지는 매월 말일 자정에 자동 소멸됩니다.<br> (미사용 및 기한 경과 포인트의 기한 연장, 현금성 환불 불가)
											</li>
											<li>마일리지를 사용하여 결제한 후 부분 환불 요청 시 해당 상품의 판매가 비중에 따른 마일리지가 환불금액에 포함되어 환불됩니다.</li>
											<li>미사용 마일리지의 사용 기한 연장 또는 쿠폰/현금 환불 요청은 불가합니다.</li>
											<li>상품 구매 마일리지는 실 결제가에 회원 등급별 요율을 적용하여 적립됩니다.(배송 완료 후 익일 적립)</li>
										</ul>
									</dd>
								</dl>
							</div>

							<div class="mt-10 mb-6 h-0.5 bg-gray2 rounded-md md:mt-17 md:mb-9"></div>

							<div class="md:px-5 lg:px-9">
								<p class="text-xl font-black md:text-2xl">포인트</p>
								<p class="mt-3 leading-snug md:mt-4.5">
									회원가입 시 - 신규가입 300P / 추천인 ID 입력 500P<br> 상품후기 작성 시 - 일반후기 200P / 포토후기 500P
								</p>
								<dl class="text-alert is-danger mt-5 md:mt-7.5">
									<dt>
										<strong>포인트 참고사항</strong>
									</dt>
									<dd class="text-black2 mt-1.5">
										<ul class="list-normal">
											<li>적립한 포인트는 비급여 제품 결제 시에 사용 가능합니다. (마일리지와 중복 사용 불가)</li>
											<li>보유한 포인트는 5,000P부터 사용 가능합니다. (최대 50,000P)</li>
											<li>포인트 유효기간은 1년이며 기간이 경과된 포인트는 매월 말일 자정에 자동 소멸됩니다.<br> (미사용 및 기한 경과 포인트의 기한 연장, 현금성 환불 불가)
											</li>
											<li>포인트를 사용하여 결제한 후 부분 환불 요청 시 해당 상품의 판매가 비중에 따른 포인트가 환불금액에 포함되어 환불됩니다.</li>
											<li>미사용 포인트의 사용 기한 연장 또는 쿠폰/현금 환불 요청은 불가합니다.</li>
										</ul>
									</dd>
								</dl>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
</main>