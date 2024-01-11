<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<style>
	& .order-item-box.hidden{
		display: none;
	}
	& .order-item-box .order-product-item{
		grid-template-columns: 14.5rem auto auto;
	}

	& .order-item-box .order-product-item .item-thumb .form-check {
		overflow: visible;
	}
	& .order-item-box .order-product-item .item-thumb .form-check .form-check-input{
		width: 25px;
		height: 25px;
	}
	
	& .order-item-box .order-delivery-total{
		padding-left: 70px;
	}

	& .order-item-box .order-product-item .item-option .item-add dd.disabled strong, 
	& .order-item-box .order-product-item .item-option .item-add dd.disabled span {
		opacity: .45;
	}
	& .order-item-box .order-product-item .item-option .item-add dd.disabled span.label-outline-primary,
	& .order-item-box .order-product-item .item-option .item-add dd.disabled span.label-outline-primary span{
		opacity: 1;
	}

	& .order-item-box .order-product-item .item-add-box .item-add .item-add-one{
		display: flex;
	}
	
</style>
<main id="container" class="is-mypage">
	<jsp:include page="../../layout/page_header.jsp">
		<jsp:param value="장바구니" name="pageTitle" />
	</jsp:include>

	<div id="page-container">

		<jsp:include page="../../layout/page_sidenav.jsp" />

		<div id="page-content">
			<jsp:include page="../../layout/mobile_userinfo.jsp" />

			<div id="cart-list-container-welfare" class="cart-list-container welfare hidden">
				<h3 class="text-title mb-3 lg:mb-4">급여 주문</h3>
				
				<div class="cart-list-box order-item-box">

				</div>

				<div class="flex justify-center mt-9 space-x-1 lg:mt-12 md:space-x-1.5">
					<button class="btn btn-primary md:px-8.5 f_bplc_All" >전체선택</button>
					<button class="btn btn-outline-primary md:px-8.5 f_delete" data-cart-ty="R" data-sel-ty="ALL">전체삭제</button>
					<button class="btn btn-outline-primary md:px-8.5 f_delete" data-cart-ty="R" data-sel-ty="SEL">선택상품 삭제</button>
				</div>
			</div>

			<div id="cart-list-container-ordr" class="cart-list-container ordr">
				<h3 class="text-title mb-3 lg:mb-4">바로 구매</h3>

				<div class="cart-list-none box-result is-large">장바구니에 담긴 상품이 없습니다</div>
				<div class="cart-list-box order-item-box hidden">
					<div class="order-product">
						<div class="order-body">
							<div class="order-buyer"></div>

							<dl class="order-item-business">
								<dd class="form-check">
									<input class="form-check-input" type="checkbox">
								</dd>
								<dt>사업소<span>행복한 시니어</span></dt>
							</dl>
							<div class="order-delivery-total">
								<strong>묶음배송</strong>
								<strong class="price2">3개</strong>
							</div>
							<div class="order-product-inner">
								<div class="order-product-item">
									
									<div class="item-thumb">
										<div class="form-check">
											<input class="form-check-input cart_ty_N" type="checkbox" name="cartGrpNo" value="74">
										</div>
										<div class="order-item-thumb">
											<img src="/comm/getImage?srvcId=GDS&amp;upNo=176&amp;fileTy=THUMB&amp;fileNo=1&amp;thumbYn=Y" alt="">
										</div>
									</div>
									<div class="item-name">
										<div class="order-item-base">
											<p class="code">
												<span class="label-primary">
													<span>급여상품</span>
													<i></i>
												</span>
												<u>24n29G38Y72a</u>
											</p>
											<div class="product">
												<p class="name">효반 10팩 무료배송 골라담기</p>
											</div>
										</div>
									</div>
									<div class="item-price">
										<div class="pay-info">
											<p class="pay-amount">주문수량<span>7</span>개</p>
											<div class="pay-price">
												<span class="original-price">49,720원</span>
												<strong class="price">11,448,400원</strong>
											</div>
										</div>
									</div>
									<div class="item-option">
										<dl class="option">
											<dd class="disabled">
												<span class="label-flat">분홍</span>
												<span class="label-flat">800g</span>
												<span>2개(+9,720원)</span>
												<button class="btn-delete2">삭제</button>
												<strong class="text-soldout">임시품절</strong>
											</dd>
											<dd>
												<span class="label-flat">삼계죽</span>
												<span class="label-flat">300g</span>
												<span>2개</span>
												<button class="btn-delete2">삭제</button>
											</dd>
											<dd>
												<span class="label-flat">클로렐라 계란죽</span>
												<span class="label-flat">300g</span>
												<span>2개</span>
												<button class="btn-delete2">삭제</button>
											</dd>
											<dd>
												<span class="label-flat">황태죽</span>
												<span class="label-flat">300g</span>
												<span>1개</span>
												<button class="btn-delete2">삭제</button>
											</dd>
										</dl>
										<div class="item-add">
											<span class="label-outline-primary">
												<span>추가</span>
												<i><img src="../../assets/images/ico-plus-white.svg" alt=""></i>
											</span>
											<div class="name">
												<strong>모던 스타일 스툴</strong>
												<strong>1개</strong>
												<span>(+80,000원)</span>
												<button class="btn-delete2">삭제</button>
											</div>
										</div>
									</div>
									<div class="item-btn"><button class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#countModal">주문 수정</button></div>
								</div>
							</div>
							<div class="order-product-inner">
								<div class="order-product-item">
									<div class="item-thumb">
										<div class="form-check">
											<input class="form-check-input cart_ty_N" type="checkbox" name="cartGrpNo" value="74">
										</div>
										<div class="order-item-thumb">
											<img src="/comm/getImage?srvcId=GDS&amp;upNo=176&amp;fileTy=THUMB&amp;fileNo=1&amp;thumbYn=Y" alt="">
										</div>
									</div>
									<div class="item-name">
										<div class="order-item-base">
											<p class="code">
												<span class="label-primary">
													<span>급여상품</span>
													<i></i>
												</span>
												<u>24n29G38Y72a</u>
											</p>
											<div class="product">
												<p class="name">효반 10팩 무료배송 골라담기</p>
											</div>
										</div>
									</div>
									<div class="item-price">
										<div class="pay-info">
											<p class="pay-amount">주문수량<span>7</span>개</p>
											<div class="pay-price">
												<span class="original-price">49,720원</span>
												<strong class="price">11,448,400원</strong>
											</div>
										</div>
									</div>
									<div class="item-option">
										<dl class="option">
											<dd>
												<span class="label-flat">분홍</span>
												<span class="label-flat">800g</span>
												<span>2개(+9,720원)</span>
												<button class="btn-delete2">삭제</button>
											</dd>
											<dd>
												<span class="label-flat">삼계죽</span>
												<span class="label-flat">300g</span>
												<span>2개</span>
												<button class="btn-delete2">삭제</button>
											</dd>
											<dd>
												<span class="label-flat">클로렐라 계란죽</span>
												<span class="label-flat">300g</span>
												<span>2개</span>
												<button class="btn-delete2">삭제</button>
											</dd>
											<dd>
												<span class="label-flat">황태죽</span>
												<span class="label-flat">300g</span>
												<span>1개</span>
												<button class="btn-delete2">삭제</button>
											</dd>
										</dl>
										<div class="item-add">
											<span class="label-outline-primary">
												<span>추가</span>
												<i><img src="../../assets/images/ico-plus-white.svg" alt=""></i>
											</span>
											<div class="name">
												<strong>모던 스타일 스툴</strong>
												<strong>1개</strong>
												<span>(+80,000원)</span>
												<button class="btn-delete2">삭제</button>
											</div>
										</div>
									</div>
									<div class="item-btn"><button class="btn btn-primary">주문 수정</button></div>
									<div class="order-disabled"><strong>일시품절 상품입니다</strong></div>
								</div>
							</div>
							<div class="order-product-inner">
								<div class="order-product-item">
									<div class="item-thumb">
										<div class="form-check">
											<input class="form-check-input cart_ty_N" type="checkbox" name="cartGrpNo" value="74">
										</div>
										<div class="order-item-thumb">
											<img src="/comm/getImage?srvcId=GDS&amp;upNo=176&amp;fileTy=THUMB&amp;fileNo=1&amp;thumbYn=Y" alt="">
										</div>
									</div>
									<div class="item-name">
										<div class="order-item-base">
											<p class="code">
												<span class="label-primary">
													<span>급여상품</span>
													<i></i>
												</span>
												<u>24n29G38Y72a</u>
											</p>
											<div class="product">
												<p class="name">효반 10팩 무료배송 골라담기</p>
											</div>
										</div>
									</div>
									<div class="item-price">
										<div class="pay-info">
											<p class="pay-amount">주문수량<span>7</span>개</p>
											<div class="pay-price">
												<span class="original-price">49,720원</span>
												<strong class="price">11,448,400원</strong>
											</div>
										</div>
									</div>
									<div class="item-option">
										<dl class="option">
											<dd>
												<span class="label-flat">분홍</span>
												<span class="label-flat">800g</span>
												<span>2개(+9,720원)</span>
												<button class="btn-delete2">삭제</button>
											</dd>
											<dd>
												<span class="label-flat">삼계죽</span>
												<span class="label-flat">300g</span>
												<span>2개</span>
												<button class="btn-delete2">삭제</button>
											</dd>
											<dd>
												<span class="label-flat">클로렐라 계란죽</span>
												<span class="label-flat">300g</span>
												<span>2개</span>
												<button class="btn-delete2">삭제</button>
											</dd>
											<dd>
												<span class="label-flat">황태죽</span>
												<span class="label-flat">300g</span>
												<span>1개</span>
												<button class="btn-delete2">삭제</button>
											</dd>
										</dl>
										<div class="item-add">
											<span class="label-outline-primary">
												<span>추가</span>
												<i><img src="../../assets/images/ico-plus-white.svg" alt=""></i>
											</span>
											<div class="name">
												<strong>모던 스타일 스툴</strong>
												<strong>1개</strong>
												<span>(+80,000원)</span>
												<button class="btn-delete2">삭제</button>
											</div>
										</div>
									</div>
									<div class="item-btn"><button class="btn btn-primary">주문 수정</button></div>
								</div>
							</div>
							<dl class="order-item-payment">
								<dt>배송비 위 <span>2</span>건 함께 주문 시</dt>
								<dd class="delivery-charge">무료</dd>
							</dl>

							<div class="order-delivery-total">
								<strong>개별배송</strong>
								<strong class="price2">1개</strong>
							</div>
							<div class="order-product-inner">
								<div class="order-product-item">
									<div class="item-thumb">
										<div class="form-check">
											<input class="form-check-input cart_ty_N" type="checkbox" name="cartGrpNo" value="74">
										</div>
										<div class="order-item-thumb">
											<img src="/comm/getImage?srvcId=GDS&amp;upNo=176&amp;fileTy=THUMB&amp;fileNo=1&amp;thumbYn=Y" alt="">
										</div>
									</div>
									<div class="item-name">
										<div class="order-item-base">
											<p class="code">
												<span class="label-primary">
													<span>급여상품</span>
													<i></i>
												</span>
												<u>24n29G38Y72a</u>
											</p>
											<div class="product">
												<p class="name">효반 10팩 무료배송 골라담기</p>
											</div>
										</div>
									</div>
									<div class="item-price">
										<div class="pay-info">
											<p class="pay-amount">주문수량<span>7</span>개</p>
											<div class="pay-price">
												<span class="original-price">49,720원</span>
												<strong class="price">11,448,400원</strong>
											</div>
										</div>
									</div>
									<div class="item-option">
										<dl class="option">
											<dd>
												<span class="label-flat">분홍</span>
												<span class="label-flat">800g</span>
												<span>2개(+9,720원)</span>
												<button class="btn-delete2">삭제</button>
											</dd>
											<dd>
												<span class="label-flat">삼계죽</span>
												<span class="label-flat">300g</span>
												<span>2개</span>
												<button class="btn-delete2">삭제</button>
											</dd>
											<dd>
												<span class="label-flat">클로렐라 계란죽</span>
												<span class="label-flat">300g</span>
												<span>2개</span>
												<button class="btn-delete2">삭제</button>
											</dd>
											<dd>
												<span class="label-flat">황태죽</span>
												<span class="label-flat">300g</span>
												<span>1개</span>
												<button class="btn-delete2">삭제</button>
											</dd>
										</dl>
										<div class="item-add">
											<span class="label-outline-primary">
												<span>추가</span>
												<i><img src="../../assets/images/ico-plus-white.svg" alt=""></i>
											</span>
											<div class="name">
												<strong>모던 스타일 스툴</strong>
												<strong>1개</strong>
												<span>(+80,000원)</span>
												<button class="btn-delete2">삭제</button>
											</div>
										</div>
									</div>
									<div class="item-btn"><button class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#countModal">주문 수정</button></div>
								</div>
							</div>
							
							<dl class="order-item-payment">
								<dt>배송비</dt>
								<dd class="delivery-charge">3000원</dd>
							</dl>
						</div>
					</div>
				</div>

				<div class="order-del-box flex justify-center mt-9 space-x-1 lg:mt-12 md:space-x-1.5 ">
					<button class="btn select all btn-primary md:px-8.5">전체선택</button>
					<button class="btn select delete whole btn-outline-primary md:px-8.5">전체삭제</button>
					<button class="btn select delete part btn-outline-primary md:px-8.5">선택상품 삭제</button>
				</div>

				<div class="order-amount mt-8 lg:mt-10">
                    <div class="container">
                        <div class="amount-section">
                            <dl class="total-ordrpc-dl">
                                <dt>총 상품 금액</dt>
                                <dd><strong class="total-ordrpc-txt">12,123,000</strong> 원</dd>
                            </dl>
                            <i class="is-plus">+</i>
                            <dl class="total-dlvyBase-dl">
                                <dt>배송비</dt>
                                <dd><strong class="total-dlvyBase-txt">12,000</strong> 원</dd>
                            </dl>
                        </div>
                        <div class="amount-section">
                            <i class="is-equal">=</i>
                            <dl class="text-danger">
                                <dt>최종 결제금액</dt>
                                <dd><strong class="total-stlmAmt-txt">12,123,000</strong> 원</dd>
                            </dl>
                        </div>
                    </div>
                </div>
				<div class="order-buy-box flex justify-end text-right mt-8.5 md:pr-6 lg:mt-11 space-x-1.5 md:space-x-2.5">
                    <a href="/market/gds/list" class="btn btn-large btn-outline-secondary xs-max:px-3">쇼핑 계속하기</a>
                    <a href="#" class="btn buy part btn-large btn-primary xs-max:px-3">선택상품 주문하기</a>
                    <a href="#" class="btn buy all btn-large btn-danger xs-max:px-3">전체상품 주문하기</a>
                </div>

			</div>

			

			<h3 class="text-title mt-10 md:mt-14 lg:mt-19">
				<strong class="text-danger">꼭</strong> 확인해 주세요
			</h3>
			<ul class="mt-4 lg:mt-5 space-y-1 md:space-y-1.5">
				<li class="text-alert">쿠폰적용 제외 상품은 모든 쿠폰이 적용되지 않습니다.</li>
				<li class="text-alert">무통장 입금일 경우 3일 이내 해당 계좌로 입금하셔야 주문이 완료됩니다.</li>
				<li class="text-alert">결제완료 이후에는 배송방법을 변경하실 수 없으므로, 주문 취소 후 새로 주문해 주시기 바랍니다.</li>
				<li class="text-alert">교환 및 반품은 배송완료 후 7일 이내만 신청 가능하며, 포장이 훼손되거나 사용하신 상품은 교환 및 환불 되지 않습니다.</li>
			</ul>
		</div>
	</div>

	<form id="frmCart" name="frmCart" method="post" enctype="multipart/form-data">
		<input type="hidden" id="cartGrpNos" name="cartGrpNos" value=""> <input type="hidden" id="cartTy" name="cartTy" value="">
	</form>

	<textarea class="cartListWelfareJson" style="display: none;">
		${cartListWelfareJson}
	</textarea>
	<textarea class="cartListOrdrJson" style="display: none;">
		${cartListOrdrJson}
	</textarea>
	<textarea class="entrpsDlvyGrpVOListJson" style="display: none;">
		${entrpsDlvyGrpVOListJson}
	</textarea>
	<textarea class="entrpsVOListJson" style="display: none;">
		${entrpsVOListJson}
	</textarea>
	<textarea class="codeMapJson" style="display: none;">
		${codeMapJson}
	</textarea>
</main>

<!-- 옵션변경 모달 -->
<div id="cart-optn-chg"></div>

<script src="/html/core/script/JsHouse2309Popups.js?v=<spring:eval expression="@version['assets.version']"/>"></script>
<script type="text/javascript" src="/html/page/market/assets/script/JsMarketCartModalOptnChg2.js?v=<spring:eval expression="@version['assets.version']"/>"></script>
<script type="text/javascript" src="/html/page/market/assets/script/JsMargetCartDrawItems.js?v=<spring:eval expression="@version['assets.version']"/>"></script>
<script type="text/javascript" src="/html/page/market/assets/script/JsMarketCartList.js?v=<spring:eval expression="@version['assets.version']"/>"></script>


<script>
	var jsMarketCartModalOptnChg2 = null;
	var jsMarketCartList = null;
		$(document).ready(function() {
			var path = {_membershipPath:"${_membershipPath}", _marketPath:"${_marketPath}"};

			jsMarketCartModalOptnChg2 = new JsMarketCartModalOptnChg2();
	
			jsMarketCartList = new JsMarketCartList(path
													, {
														"loginCheck":${_mbrSession.loginCheck}
														, "mbrId":"${_mbrSession.mbrId}"
														, "mbrNm":"${_mbrSession.mbrNm}"
														, "mblTelno":"${_mbrSession.mblTelno}"
														, "eml":"${_mbrSession.eml}"
													}
													, $("#container textarea.cartListWelfareJson").val()
													, $("#container textarea.cartListOrdrJson").val()
													, $("#container textarea.entrpsDlvyGrpVOListJson").val()
													, $("#container textarea.entrpsVOListJson").val()
													, $("#container textarea.codeMapJson").val()
												
											);
	
			jsMarketCartList.fn_popup_set("jsMarketCartModalOptnChg2", jsMarketCartModalOptnChg2);
		});
</script>