<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<style>

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


<script type="text/javascript" src="/html/page/market/assets/script/JsMargetDrawItems.js?v=<spring:eval expression="@version['assets.version']"/>"></script>
<script type="text/javascript" src="/html/page/market/assets/script/JsMarketCartList.js?v=<spring:eval expression="@version['assets.version']"/>"></script>


<script>
	var jsMarketCartList = null;
		$(document).ready(function() {
			var path = {_membershipPath:"${_membershipPath}", _marketPath:"${_marketPath}"};
	
			jsMarketCartList = new JsMarketCartList(path
													, {
														"loginCheck":${_mbrSession.loginCheck}
														, "mbrId":"${_mbrSession.mbrId}"
														, "mbrNm":"${_mbrSession.mbrNm}"
														, "mblTelno":"${_mbrSession.mblTelno}"
														, "eml":"${_mbrSession.eml}"
													}
													, $("textarea.cartListWelfareJson").val()
													, $("textarea.cartListOrdrJson").val()
													, $("textarea.entrpsDlvyGrpVOListJson").val()
													, $("textarea.entrpsVOListJson").val()
													, $("textarea.codeMapJson").val()
												
											);
	
			
		});

//업체별 배송정책 정보리스트
const entrpsDlvyList = ${entrpsDlvyList};

function f_cartClick(params) {
	let cartTy = params.get("cartTy");
	let cartGrpNos = params.get("cartGrpNos");
	let selTy = params.get("selTy");

	if(cartTy == "R" && $(":checkbox[name=cartGrpNo]:checked.cart_ty_R[data-cart-ty='L']").length > 1){
		alert("대여상품은 한개씩만 주문 가능합니다.");
	}else{
		$("#cartGrpNos").val(cartGrpNos);
		$("#cartTy").val(cartTy);
		var actionUrl = "${_marketPath}/ordr/cartRqst"; //주문확인
		if (cartTy == "N") {
			actionUrl = "${_marketPath}/ordr/cartPay"; //주문진행
		}

		$("#frmCart").attr("action", actionUrl);
		$("#frmCart").submit();
	}
}

$(function() {
	$(":checkbox").each(function(){
		$(this).prop("checked",false);
	});

	//(비급여) 전체선택
	let totalGdsPc = 0;
	let totalDlvyPc = 0;
	let totalStlmPc = 0;

	function priceCalculation() {
		totalGdsPc = 0;
		totalDlvyPc = 0;
		totalStlmPc = 0;

		$("input[name='L_gdsPc']").each(function(){
			const checkBox = $(this).siblings('.cart_ty_N')[0];

			if (checkBox.checked) {
				const gdsPc = Number($(this).val());  //상품 가격
				totalGdsPc += gdsPc;

				//상품의 입점업체 정보
				const entrpsNoInput = $(this).siblings('input[name=entrpsNo]');
				//상품의 묶음배송 여부
				const dlvyGroupYn = $(this).siblings('input[name=dlvyGroupYn]');

				const entrpsNo = Number(entrpsNoInput[0].value); //상품의 입점업체
				//상품의 입점업체 정보가 없으면 바로 배송비 계산
				if (entrpsNo == 0) {
					const L_dlvyPcInput = $(this).siblings('input[name=L_dlvyPc]')[0];
					const dlvyCt = Number(L_dlvyPcInput.value);  //해당 상품의 배송비
					totalDlvyPc += Number(dlvyCt);
					return;
				}
				
				
				//배송비 무료조건에 부합하는지 검사
				const entrpsInfo = entrpsDlvyList.find(f => f.entrpsNo === entrpsNo);  //입점업체 배송정보가져오기
				const dlvyCtCnd = entrpsInfo.dlvyCtCnd;  //무료배송 조건 가격
				const checkedGdsPrice = getSumPriceInEntrps(entrpsNo);  //선택된 상품중 같은 입점업체 상품 가격 합
				if (checkedGdsPrice >= dlvyCtCnd) {
					return;
				}
				
				
				//배송비 계산(묶음배송 고려하여)
				if (entrpsNoInput[0] && dlvyGroupYn[0].value) {
					const dlvyBaseCt = entrpsInfo.dlvyBaseCt;  //입점업체의 기본 배송비
					const L_dlvyPcInput = $(this).siblings('input[name=L_dlvyPc]')[0];
					const dlvyCt = Number(L_dlvyPcInput.value);  //해당 상품의 배송비

					//입점업체에 기본 배송비가 아니면 부과(묶음상품 제외)
					if (dlvyBaseCt != dlvyCt) {
						totalDlvyPc += dlvyCt;
					}
					//묶음상품이여도 최초에 한번 배송비 부과
					else if (!entrpsInfo.firstCheck) {
						totalDlvyPc += dlvyCt;
						entrpsInfo.firstCheck = true;
					}
				} else {
					const L_dlvyPcInput = $(this).siblings('input[name=L_dlvyPc]')[0];
					const dlvyCt = Number(L_dlvyPcInput.value);  //해당 상품의 배송비
					totalDlvyPc += Number(dlvyCt);
				}
			}
		});
	}
	
	//선택된 특정 입점업체의 상품가격합 가져오기
	function getSumPriceInEntrps(srchEntrpsNo) {
		var gdsPcInputs = $("input[name='L_gdsPc']");
		var totalPrice = 0;
		
		for(var i = 0; i < gdsPcInputs.length; i++) {
			var gdsPcInput = gdsPcInputs[i];
			
			const checkBox = $(gdsPcInput).siblings('.cart_ty_N')[0];
			if (checkBox.checked) {
				const entrpsNoInput = $(gdsPcInput).siblings('input[name=entrpsNo]');
				const entrpsNo = Number(entrpsNoInput[0].value); //상품의 입점업체
				const gdsPc = Number($(gdsPcInput).val());  //상품 가격
				
				if(entrpsNo === srchEntrpsNo) {
					totalPrice += gdsPc;	
				}
			}
		}
		return totalPrice;
	}
	

	//전체 체크박스
	let isFullChecked = false;
	$(".f_checkAll").on("click", function() {
		isFullChecked = !isFullChecked;
        $(":checkbox[name=cartGrpNo].cart_ty_N").prop("checked", isFullChecked);
		$(":checkbox[name=cartGrpNo].cart_ty_N").parents(".order-checkitem").find(".order-product").removeClass("is-active");
		$(":checkbox[name=cartGrpNo].cart_ty_N:checked").parents(".order-checkitem").find(".order-product").addClass("is-active");

		priceCalculation();

		$(".L_totalGdsPc").text(comma(totalGdsPc));
		$(".L_totalDlvyPc").text(comma(totalDlvyPc));
        $(".L_totalStlmPc").text(comma(totalGdsPc + totalDlvyPc));
        entrpsDlvyList.forEach(e => e.firstCheck = null);
	});


	//체크박스(비급여)
	$(".cart_ty_N").on("click", function() {
		priceCalculation();

		$(".L_totalGdsPc").text(comma(totalGdsPc));
		$(".L_totalDlvyPc").text(comma(totalDlvyPc));
        $(".L_totalStlmPc").text(comma(totalGdsPc + totalDlvyPc));
        entrpsDlvyList.forEach(e => e.firstCheck = null);
	});

	// 단일 삭제 버튼
	/*$(".f_deleteSel").on(	"click",function() {
		let cartGrpNos = [ $(this).data("grpNo") ];
		let cartTy = $(this).data("cartTy"); // 급여/비급여
		let confirmMsg = "선택한 상품을 삭제 하시겠습니까?";

		if (confirm(confirmMsg)) {
			$.ajax({
				type : "post",
				url : "./removeCart.json",
				data : {
					cartTy : cartTy,
					cartGrpNos : cartGrpNos,
					recipterUniqueId : "${_mbrSession.prtcrRecipterInfo.uniqueId}"
					},
				dataType : 'json'}
			)
			.done(function(data) {
			if (data.result) {
				location.reload();
				} else {
					alert("삭제에 실패하였습니다.");
					}
			})
			.fail(function(data, status, err) {
				alert("삭제 과정에 오류가 발생했습니다.");
				console.log('error forward : '+ data);
			});
			}
		});*/



	// 급여 사업소 전체 체크박스
	let gdsPc = 0;
	let dlvyPc = 0;
	let stlmPc = 0;
	$("input[name='bplc_all']").on("click",function(){
		gdsPc = 0;
		dlvyPc = 0;
		stlmPc = 0;
		let bplcUniqueId = $(this).val();
		let bplcFlag = true;
		let isChecked = false;
		$(".cart_ty_N").each(function(){$(this).prop("checked",false);});
		$(".bplc_"+bplcUniqueId).each(function(){
			console.log($(this).siblings("input[name='"+bplcUniqueId+"_gdsPc']").val())
			gdsPc += Number($(this).siblings("input[name='"+bplcUniqueId+"_gdsPc']").val());
			dlvyPc += Number($(this).siblings("input[name='"+bplcUniqueId+"_dlvyPc']").val());
			stlmPc += Number($(this).siblings("input[name='"+bplcUniqueId+"_stlmPc']").val());
		});

		if(!$(this).is(":checked")){
			gdsPc = 0;
			dlvyPc = 0;
			stlmPc = 0;
		}

		$("."+bplcUniqueId+"_totalGdsPc").text(comma(gdsPc));
		$("."+bplcUniqueId+"_totalDlvyPc").text(comma(dlvyPc));
		$("."+bplcUniqueId+"_totalStlmPc").text(comma(stlmPc));

		console.log(bplcUniqueId);
		// 다른 사업소 구분
		$(".cart_ty_R:checked").each(function(){
			console.log($(this).val());
			if($(this).val() != bplcUniqueId){
				bplcFlag = false;
			}
		});

		if(bplcFlag){
			if($(this).is(":checked")){
				isChecked = true;
			}else{
				isChecked = false;
			}

			$("input[name='bplc_item']").each(function(){
				if($(this).val() == bplcUniqueId){
					$(this).prop("checked",isChecked);
				}
			});
		}else{
			alert("서로 다른 사업소는 선택하실 수 없습니다.");
			$(this).prop("checked",false);
			return false;
		}
	});

	// 급여 전체 선택
	$(".f_bplc_All").on("click",function(){
		let bplcUniqueId = $(this).data("bplcUnique");

		$(".cart_ty_N").each(function(){
			$(this).prop("checked",false);
		});

		$("input[name='bplc_all']").each(function(){
			if($(this).val() == bplcUniqueId){
				$(this).click();
			}
		});
	});

	// 체크박스 단일 구분
	$("input[name='bplc_item']").on("click",function(){
		let bplcUniqueId = $(this).val();
		let bplcFlag = true;
		console.log($(".bplc_"+bplcUniqueId+":checked").length);

		$(".cart_ty_N").each(function(){
			$(this).prop("checked",false);
		});
		console.log($(this).is(":checked"));
		if($(this).is(":checked")){
			gdsPc += Number($(this).siblings("input[name='"+bplcUniqueId+"_gdsPc']").val() );
			dlvyPc += Number($(this).siblings("input[name='"+bplcUniqueId+"_dlvyPc']").val());
			stlmPc += Number($(this).siblings("input[name='"+bplcUniqueId+"_stlmPc']").val());
		}else{
			$("input[name='bplc_all']").prop("checked",false);
			gdsPc -= Number($(this).siblings("input[name='"+bplcUniqueId+"_gdsPc']").val() );
			dlvyPc -= Number($(this).siblings("input[name='"+bplcUniqueId+"_dlvyPc']").val());
			stlmPc -= Number($(this).siblings("input[name='"+bplcUniqueId+"_stlmPc']").val());
		}

		$("."+bplcUniqueId+"_totalGdsPc").text(comma(Number(gdsPc)));
		$("."+bplcUniqueId+"_totalDlvyPc").text(comma(dlvyPc));
		$("."+bplcUniqueId+"_totalStlmPc").text(comma(stlmPc));

		$(".cart_ty_R:checked").each(function(){
			if($(this).val() != bplcUniqueId){
				bplcFlag = false;
			}
		});

		if(!bplcFlag){
			alert("서로 다른 사업소는 선택하실 수 없습니다.");
			return false;
		}
	});

	// 급여 삭제
	$(".f_delete").on("click",function() {
		let cartGrpNos;
		let cartTy = $(this).data("cartTy"); // 급여/비급여
		let selTy = $(this).data("selTy"); // 전체/선택
		let bplcUniqueId = $(this).data("bplcUnique"); //사업소
		let confirmMsg = "선택한 상품을 삭제 하시겠습니까?";

		if (selTy == "ALL") {
			$(":checkbox[name=bplc_item]").prop("checked",true);
			cartGrpNos = $(":checkbox[name=bplc_item]:checked").map(function() {
				if($(this).val() == bplcUniqueId){
					return $(this).data("cartGrp");
				}
			}).get();

			console.log(cartGrpNos);
			confirmMsg = "전체 상품을 삭제 하시겠습니까?"
		}else{
			cartGrpNos = $("input[name=bplc_item]:checked").map(function() {
				if($(this).val() == bplcUniqueId){
					return $(this).data("cartGrp");
				}
			}).get();
			console.log(cartGrpNos);
		}

		if (cartGrpNos == null || cartGrpNos.length == 0) {
			alert("삭제하실 상품을 먼저 선택해주세요.");
		} else if (confirm(confirmMsg)) {
			$.ajax({
				type : "post",
				url : "./removeCart.json",
				data : {
					cartTy : cartTy,
					cartGrpNos : cartGrpNos,
					recipterUniqueId : "${_mbrSession.prtcrRecipterInfo.uniqueId}"
				},
				dataType : 'json'
				})
				.done(function(data) {
					if (data.result) {
						location.reload();
					} else {
						alert("삭제에 실패하였습니다.");
						}
				})
				.fail(function(data, status, err) {
					alert("삭제 과정에 오류가 발생했습니다.");
					console.log('error forward : '+ data);
				});
		}
	});


	// 비급여 삭제
	$(".f_delete_N").on("click",function() {
		let cartGrpNos;
		let selTy = $(this).data("selTy"); // 전체/선택
		let confirmMsg = "선택한 상품을 삭제 하시겠습니까?";

		if (selTy == "ALL") {
			cartGrpNos = $(":checkbox[name=cartGrpNo].cart_ty_N").map(function() {return $(this).val();}).get();
			confirmMsg = "전체 상품을 삭제 하시겠습니까?"
		}else {
			cartGrpNos = $(":checkbox[name=cartGrpNo]:checked.cart_ty_N").map(function() {return $(this).val();}).get();
		}
		if (cartGrpNos == null || cartGrpNos.length == 0) {
			alert("삭제하실 상품을 먼저 선택해주세요.");
		} else if (confirm(confirmMsg)) {
			$.ajax({
			type : "post",
			url : "./removeCart.json",
			data : {
				cartTy : 'N',
				cartGrpNos : cartGrpNos,
				recipterUniqueId : "${_mbrSession.prtcrRecipterInfo.uniqueId}"
			},
			dataType : 'json'
			})
			.done(function(data) {
				if (data.result) {
					location.reload();
				} else {
					alert("삭제에 실패하였습니다.");
					}
			})
			.fail(function(data, status, err) {
				alert("삭제 과정에 오류가 발생했습니다.");
				console.log('error forward : '+ data);
			});
		}
	});

	// 옵션변경 모달
	$(document).on("click", ".f_optn_chg", function(){
		let cartGrpNo = $(this).data("cartGrp");

		$("#cart-optn-chg").load("${_marketPath}/mypage/cart/cartOptnModal",
				{
			cartGrpNo : cartGrpNo
			}, function(){
    			$("#countModal").modal('show');
			});
	});

	// 주문
	$(".f_ordr_R").on("click",function(){
		let cartGrpNos;
		let selTy = $(this).data("selTy");
		let cartTy = $(this).data("cartTy");
		let bplcUniqueId = $(this).data("bplcUnique");
		let soldFlag = true;
		let actFlag = true;
		let selectFlag = true;
		let confirmMsg = "전체 상품을 주문 하시겠습니까?";

		if(selTy == "ALL"){
			if($(".bplc_"+bplcUniqueId).length < 1){
				alert("담겨있는 상품이 없습니다.");
				selectFlag = false;
			}else{
				$(".bplc_"+bplcUniqueId).each(function(){
					if($(this).val() == bplcUniqueId){
						$(this).prop("checked",true);
					}else{
						actFlag = false;
					}
				});
			}
		}else{
			confirmMsg = "선택 상품을 주문 하시겠습니까?";

			if($("input[name='bplc_item']:checked").length < 1){
				alert("주문하실 상품을 선택해주세요.");
				selectFlag = false;
			}else {
				$("input[name='bplc_item']:checked").each(function(){
					if($(this).val() != bplcUniqueId){
						actFlag = false;
					}
				});
			}
		}


		if(!actFlag){
			alert("해당 사업소란의 주문하기를 눌러주세요.");
		}else{
			if(selectFlag){
				cartGrpNos = $("input[name='bplc_item']:checked").map(function(){
					return $(this).data("cartGrp");
				}).get();
				console.log(cartGrpNos);

				var tagList = [ 'A', 'C' ];

				// 태그 검사
				$(".bplc_"+bplcUniqueId).each(function(){
					if($(this).is(":checked")){
						if(tagList.includes($(this).siblings("input[name='gdsTag']").val()) && $(this).is(":checked")){
							$(this).prop("checked",false);
							soldFlag = false;
						}
					}
				});

				if(soldFlag){
					if(confirm(confirmMsg)){
						let params = new Map();
						params.set("cartTy", cartTy);
						params.set("selTy", selTy);
						params.set("cartGrpNos", cartGrpNos);

						var bnefList = [];
						$("input[name='bplc_item']:checked").each(function(){
							var bnefCd = $(this).siblings("input[name='bnefCd']").val();
							if(bnefCd != null && bnefCd != '' ){
								bnefList.push($(this).siblings("input[name='bnefCd']").val());
							}
						});

						if ($("input[name='bnefCd']").length > 0) {
							params.set("bnefList", bnefList);
							params.set("method", f_cartClick);
							console.log(params);

							f_itemChk(params);
						}
					}
				}else{
					alert("품절된 상품이 존재합니다.");
				}
			}
		}
	});

	// 비급여 주문
	$(".f_ordr_N").on("click",function(){
		let cartGrpNos;
		let soldFlag = false;
		let actFlag = true;
		let selTy = $(this).data("selTy");
		let cartTy = $(this).data("cartTy");
		let confirmMsg = "전체 상품을 주문하시겠습니까?";
		var bnefCd = [];

		var tagList = [ 'A', 'C' ];
		if(selTy == "ALL"){
			if($(".cart_ty_N").length < 1){
				alert("담겨있는 상품이 없습니다.");
				actFlag = false;
			}else{
				$(".cart_ty_N").prop("checked",true);
			}
		}else{
			confirmMsg = "선택 상품을 주문하시겠습니까?";

			if($(".cart_ty_N:checked").length < 1){
				alert("주문 하실 상품을 선택해주세요.");
				actFlag = false;
			}
		}

		$(".cart_ty_N:checked").each(function(){
			if(tagList.includes($(this).siblings("gdsTag").val())){
				soldFlag = true;
			}
		});

		if(soldFlag){
			alert("품절된 상품이 존재합니다.");
		}else{
			if(actFlag){
				if(confirm(confirmMsg)){
					$(".cart_ty_N:checked").each(function(){
						if($(this).siblings("input[name='bnefCd']").val() != ''){
							bnefCd.push($(this).siblings("input[name='bnefCd']").val());
						}
					});

					cartGrpNos = $(".cart_ty_N:checked").map(function(){
						return $(this).val();
					}).get();

					let params = new Map();
					params.set("cartTy", cartTy);
					params.set("selTy", selTy);
					params.set("cartGrpNos", cartGrpNos);

					console.log(bnefCd);
					if(bnefCd.length > 0){
						params.set("bnefList", bnefCd);
						params.set("method", f_cartClick);

						f_itemChk(params);
					}else{
						f_cartClick(params);
					}
					console.log(params);
				}
			}
		}

	});

});
</script>