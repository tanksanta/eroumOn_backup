<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%--옵션변경--%>
<style>
	.modal.cartOptnModal .modal-content .modal-body .product-option + .product-option{
		padding-top: 10px;
	}
</style>
<form name="frmOrdrChg" id="frmOrdrChg" method="post" enctype="multipart/form-data">
<div class="modal fade cartOptnModal" id="cartOptnModal" tabindex="-1" aria-hidden="true">
	<div class="modal-dialog modal-dialog-centered">
		<div class="modal-content">
			<div class="modal-header">
				<p class="text-title">옵션/수량 변경</p>
			</div>
			<div class="modal-close">
				<button data-bs-dismiss="modal">모달 닫기</button>
			</div>
			<div class="modal-body">
				<div class="order-quantity-layer">
					<div class="order-thumb">
						<c:if test="${not empty cartList[0].gdsInfo.thumbnailFile.fileNo}">
							<img src="/comm/getImage?srvcId=GDS&amp;upNo=${cartList[0].gdsInfo.thumbnailFile.upNo}&amp;fileTy=${cartList[0].gdsInfo.thumbnailFile.fileTy }&amp;fileNo=${cartList[0].gdsInfo.thumbnailFile.fileNo}&amp;thumbYn=Y" alt="썸네일 이미지" class="w-50" />
						</c:if>
						<c:if test="${empty cartList[0].gdsInfo.thumbnailFile.fileNo}">
							<img src="/html/page/market/assets/images/noimg.jpg" alt="">
						</c:if>
					</div>
					<div class="order-content">
						<dl class="code">
							<dt>${gdsTyCode[cartList[0].cartTy]}</dt>
							<dd>${cartList[0].gdsCd}</dd>
						</dl>
						<p class="name">${cartList[0].gdsNm}</p>
						<p class="price">
							판매가 : <strong><fmt:formatNumber value="${cartList[0].gdsInfo.pc}" pattern="###,###" /></strong> 원
							<c:if test="${cartList[0].cartTy eq 'R' }">
								<%-- 베네핏 바이어의 %로 노출 --%>
								<br>급여가 :
                               	<c:choose>
									<c:when test="${_mbrSession.prtcrRecipterInfo.selfBndRt == 15 }">
										<strong><fmt:formatNumber value="${cartList[0].gdsInfo.bnefPc15}" pattern="###,###" /></strong>
									</c:when>
									<c:when test="${_mbrSession.prtcrRecipterInfo.selfBndRt == 9 }">
										<strong><fmt:formatNumber value="${cartList[0].gdsInfo.bnefPc9}" pattern="###,###" /></strong>
									</c:when>
									<c:when test="${_mbrSession.prtcrRecipterInfo.selfBndRt == 6 }">
										<strong><fmt:formatNumber value="${cartList[0].gdsInfo.bnefPc6}" pattern="###,###" /></strong>
									</c:when>
									<c:when test="${_mbrSession.prtcrRecipterInfo.selfBndRt == 0 }">
										<strong>0</strong>
									</c:when>
								</c:choose> 원
                               	</c:if>
							<c:if test="${cartList[0].gdsInfo.gdsTy eq 'L' }">
								<br>대여가 : <strong><fmt:formatNumber value="${cartList[0].gdsInfo.lendPc}" pattern="###,###" /></strong> 원
                               	</c:if>
						</p>
						</div>
					<div class="order-option">

						<p class="option-title">필수옵션</p>
						<c:set var="optnTtl" value="${fn:split(cartList[0].gdsInfo.optnTtl, '|')}" />
						<c:set var="optnVal" value="${fn:split(cartList[0].gdsInfo.optnVal, '|')}" />

						<div class="product-option">
							<c:if test="${!empty optnTtl[0]}">
								<div class="product-option" id="optnVal1">
									<button type="button" class="option-toggle" disabled="true">
										<small>필수</small> <strong>${optnTtl[0]} 선택</strong>
									</button>
									<ul class="option-items">
									</ul>
								</div>
							</c:if>
							<c:if test="${!empty optnTtl[1]}">
								<div class="product-option" id="optnVal2">
									<button type="button" class="option-toggle" disabled="true">
										<small>필수</small> <strong>${optnTtl[1]} 선택</strong>
									</button>
									<ul class="option-items">
									</ul>
								</div>
							</c:if>
							<c:if test="${!empty optnTtl[2]}">
								<div class="product-option" id="optnVal3">
									<button type="button" class="option-toggle" disabled="true">
										<small>필수</small> <strong>${optnTtl[2]} 선택</strong>
									</button>
									<ul class="option-items">
									</ul>
								</div>
							</c:if>

							<c:if test="${!empty cartList[0].gdsInfo.aditOptnTtl}">
								<c:set var="aditOptnTtl" value="${fn:split(cartList[0].gdsInfo.aditOptnTtl, '|')}" />
								<p class="option-title">추가옵션</p>
								<c:forEach var="aditOptn" items="${aditOptnTtl}" varStatus="status">
									<div class="product-option" id="aditOptnVal${status.index }">
										<button type="button" class="option-toggle">
											<small>추가</small> <strong>추가 ${aditOptn} 선택</strong>
										</button>
										<ul class="option-items">
											<c:forEach var="aditOptnList" items="${cartList[0].gdsInfo.aditOptnList}" varStatus="status">
												<c:set var="spAditOptnTtl" value="${fn:split(aditOptnList.optnNm, '*')}" />
												
												<c:if test="${fn:trim(aditOptn) eq fn:trim(spAditOptnTtl[0])}">
													<c:set var="optnSoldoutYn" 	value="" />
													<c:set var="optnSoldoutTxt" value="" />
													<c:if test="${aditOptnList.soldOutYn eq 'Y' or aditOptnList.optnStockQy < 1}">
														<c:set var="optnSoldoutTxt" value=" [품절]" />
														<c:set var="optnSoldoutYn" 	value="Y" />
													</c:if>

													<li><a href="#" data-optn-ty="ADIT" optnSoldoutYn="${optnSoldoutYn}"  data-opt-val="${aditOptnList.optnNm}|${aditOptnList.optnPc}|${aditOptnList.optnStockQy}|ADIT|${aditOptnList.gdsOptnNo}">${spAditOptnTtl[1]}${optnSoldoutTxt}</a></li>
												</c:if>
											</c:forEach>
										</ul>
									</div>
								</c:forEach>
							</c:if>
						</div>
					</div>
					<table class="table-list order-list cart-chg-list">
						<colgroup>
							<col>
							<col class="w-1/4">
							<col class="md:w-43">
						</colgroup>
						<thead>
							<tr>
								<th scope="col"><p>상품/옵션 정보</p></th>
								<th scope="col"><p>상품가격</p></th>
								<th scope="col"><p>수량</p></th>
							</tr>
						</thead>
						<tbody>
							<input type="hidden" name="cartGrpNo" value="${cartList[0].cartGrpNo}">
							<input type="hidden" name="cartTy" id="_cartTy" value="${cartList[0].cartTy}">
							<input type="hidden" name="gdsNo" value="${cartList[0].gdsNo}">
							<input type="hidden" name="gdsCd" value="${cartList[0].gdsCd}">
							<input type="hidden" name="gdsNm" value="${cartList[0].gdsNm}">
							<input type="hidden" name="gdsPc" value="${cartList[0].gdsPc}">
							<input type="hidden" name="gdsDscntRt" value="${cartList[0].gdsInfo.dscntRt}">
							<input type="hidden" name="gdsDscntPc" value="${cartList[0].gdsInfo.dscntPc}">
							<input type="hidden" name="gdsBnefPc" value="${cartList[0].gdsInfo.bnefPc}">
							<input type="hidden" name="gdsBnefPc15" value="${cartList[0].gdsInfo.bnefPc15}">
							<input type="hidden" name="gdsBnefPc9" value="${cartList[0].gdsInfo.bnefPc9}">
							<input type="hidden" name="gdsBnefPc6" value="${cartList[0].gdsInfo.bnefPc6}">
							<input type="hidden" name="gdsLendPc" value="${cartList[0].gdsInfo.lendPc}">
							<input type="hidden" name="recipterUniqueId" value="${cartList[0].recipterUniqueId}">
							<input type="hidden" name="bplcUniqueId" value="${cartList[0].bplcUniqueId}">

							<c:set var="ttlQy" value="0" />
							<c:set var="ttlPc" value="0" />
							<c:forEach items="${cartList}" var="cart" varStatus="status">
								<c:set var="spOrdrOptn" value="${fn:split(cart.ordrOptn, '*')}" />
								<tr class="tr_${cart.cartNo} optn_${cart.ordrOptnTy}">
									<td>
										<input type="hidden" name="cartNo" value="${cart.cartNo}">
										<input type="hidden" name="bnefCd" value="${cart.bnefCd}">
										<input type="hidden" name="gdsOptnNo" value="${cart.gdsOptnNo}" />
										<input type="hidden" name="ordrOptnTy" value="${cart.ordrOptnTy}">
										<input type="hidden" name="ordrOptn" value="${cart.ordrOptn}">
										<input type="hidden" name="ordrOptnPc" value="${cart.ordrOptnPc}">
										<!-- <input type="hidden" name="ordrQy" value="${cart.ordrQy}"> -->
										<input type="hidden" name="recipterUniqueId" value="${cart.recipterUniqueId}">
										<input type="hidden" name="bplcUniqueId" value="${cart.bplcUniqueId}" >
										<c:if test="${cart.ordrOptnTy eq 'BASE' }">
											<%--상품--%>
											<div class="baseitem">
												<div class="content">
													<c:if test="${empty spOrdrOptn[0] }">
														<p class="name">${cart.gdsNm}</p>
													</c:if>
													<c:if test="${!empty spOrdrOptn[0] }">
														<dl class="option">
															<dd class="ordrOptn">
																<c:forEach items="${spOrdrOptn}" var="ordrOptn">
																	<span class="label-flat">${ordrOptn}</span>
																</c:forEach>
															</dd>
														</dl>
													</c:if>
												</div>
											</div>
										</c:if> 

										<c:if test="${cart.ordrOptnTy eq 'ADIT' }">
											<%--추가상품--%>
											<div class="additem">
												<span class="label-outline-primary"> <span>${spOrdrOptn[0]}</span> <i><img src="/html/page/market/assets/images/ico-plus-white.svg" alt=""></i>
												</span>
												<div class="content">
													<p class="name">${spOrdrOptn[1]}</p>
												</div>
											</div>
										</c:if>
									</td>
									<td class="price !text-right">
										<c:if test="${cart.ordrOptnTy eq 'BASE'}">
											<strong class="ordrOptnPc"><fmt:formatNumber value="${cart.ordrPc}" pattern="###,###" /></strong> 원
											<c:set var="ttlPc" value="${ttlPc + (cart.ordrPc + cart.ordrOptnPc ) }" />
                                       	</c:if>
										<c:if test="${cart.ordrOptnTy eq 'ADIT'}">
											<strong><fmt:formatNumber value="${cart.ordrOptnPc}" pattern="###,###" /></strong> 원
											<c:set var="ttlPc" value="${ttlPc + (cart.ordrOptnPc ) * cart.ordrQy}" />
                                       	</c:if></td>
									<td class="count">
										<p>
											<c:set var="ttlQy" value="${ttlQy + cart.ordrQy}" />
											
											<input type="number" name="ordrQy" class="form-control numbercheck" value="${cart.ordrQy}" min="1" <c:if test="${cart.cartTy eq 'R'}">max="15"</c:if> <c:if test="${cart.cartTy eq 'N'}">max="9999"</c:if>>
										</p>
										<button type="button" class="btn cart del btn-small btn-outline-primary" data-cart-no="${cart.cartNo}">삭제</button>
									</td>
								</tr>
							</c:forEach>
						</tbody>
					</table>

					<%-- 2023-12-27:총상품금액, 배송비 영역 --%>
					<div class="pay-order-wrap">
						<dl class="pay-order-price">
							<dt class="title">총 상품금액</dt>
							<dd class="price-box">
								<span class="amount">주문수량<span class="txt"> <fmt:formatNumber value="${ttlQy}" pattern="###,###" /></span>개 |</span>
								<div class="total">
									<strong class="txt"><fmt:formatNumber value="${ttlPc}" pattern="###,###" /></strong>
									<strong>원</strong>
								</div>
								
							</dd>
						</dl>
						<dl class="pay-order-price">
							<dt class="font-bold">배송비</dt>
							<c:if test="${cartList[0].gdsInfo.dlvyCtTy eq 'FREE'}">
								<dd>무료</dd>
							</c:if>
							<c:if test="${cartList[0].gdsInfo.dlvyCtTy ne 'FREE'}">
								<dd class="flex flex-col gap-2">
									<p>
										<strong><fmt:formatNumber value="${cartList[0].gdsInfo.dlvyBassAmt}" pattern="###,###" />원</strong>
										
										<c:if test="${dlvyPayTyCode2[cartList[0].gdsInfo.dlvyCtStlm] ne null}">
											<!--(${dlvyPayTyCode2[cartList[0].gdsInfo.dlvyCtStlm]}) -->
										</c:if>
									
										<c:choose>
											<c:when test="${cartList[0].gdsInfo.dlvyCtTy eq 'PERCOUNT'}"><span>(상품 <fmt:formatNumber value="${cartList[0].gdsInfo.dlvyCtCnd}" pattern="###,###" />개마다 배송비 부과)</span></c:when>
											<c:when test="${cartList[0].gdsInfo.dlvyCtTy eq 'OVERMONEY'}"><span>(<fmt:formatNumber value="${cartList[0].gdsInfo.dlvyCtCnd}" pattern="###,###" />원 이상 구매 시 무료)</span></c:when>
										</c:choose>
									</p>
	
									<%-- 추가 배송비 -> 도서산간비용, 노출x--%>
									<c:if test="${cartList[0].gdsInfo.dlvyAditAmt > 0}">
									<!--p class="icon-child">제주/도서산간지역 <fmt:formatNumber value="${cartList[0].gdsInfo.dlvyAditAmt}" pattern="###,###" />원 추가</p-->
									</c:if>
									
								</dd>
							</c:if>
							
						</dl>
					</div>
					<%-- 2023-12-27:총상품금액, 배송비 영역 --%>

				</div>
			</div>
			<div class="modal-footer">
                <button type="button" class="btn btn-primary btn-submit f_cart_optn_chg">확인</button>
                <button type="button" class="btn btn-outline-primary btn-cancel" data-bs-dismiss="modal">닫기</button>
            </div>
		</div>
	</div>

	<textarea class="cartListJson" style="display: none;">
		${cartListJson}
	</textarea>
</div>

<input type="hidden" id="delCartNos" name="delCartNos" value="" />
</form>

<script>
var gdsPc = ${cartList[0].gdsInfo.pc};// 중요함
var cartTy = "${cartList[0].cartTy}"
if(cartTy === "R"){
	<c:choose>
		<c:when test="${cartList[0].recipterInfo.selfBndRt == 15 }">
		gdsPc = ${cartList[0].gdsInfo.bnefPc15};
		</c:when>
		<c:when test="${cartList[0].recipterInfo.selfBndRt  == 9 }">
		gdsPc = ${cartList[0].gdsInfo.bnefPc9};
		</c:when>
		<c:when test="${cartList[0].recipterInfo.selfBndRt  == 6 }">
		gdsPc = ${cartList[0].gdsInfo.bnefPc6};
		</c:when>
		<c:when test="${cartList[0].recipterInfo.selfBndRt  == 0 }">
		gdsPc = 0;
		</c:when>
	</c:choose>
}else if(cartTy === "L"){
	gdsPc = ${cartList[0].gdsInfo.lendPc};
}



$(function(){

	<c:if test="${empty optnTtl[0]}">
    // 옵션이 없는 경우 //|0|10
    //f_baseOptnChg("|0|${gdsVO.stockQy}");
    jsMarketCartModalOptnChg2.f_baseOptnChg(null, "|0|${gdsVO.stockQy}|BASE"); //R * 10 * DEF|1000|0|BASE
    $(".btn-delete").remove();
    </c:if>

    <c:if test="${!empty optnTtl[0]}">
		// 기본 옵션 1번
		jsMarketCartModalOptnChg2.f_optnVal1('', 'BASE');
		<c:if test="${empty optnTtl[1]}">
		$(document).on("click", "#optnVal1 ul.option-items li a", function(e){
			e.preventDefault();
			const optnVal1 = $(this).data("optVal");
			console.log(optnVal1);
			if(optnVal1 != ""){
				jsMarketCartModalOptnChg2.f_baseOptnChg($(this), optnVal1);
			}
		});
		</c:if>
	</c:if>

	<c:if test="${!empty optnTtl[1]}">
	// 기본 옵션 2번
	$(document).on("click", "#optnVal1 ul.option-items li a", function(e){
		e.preventDefault();
		const optnVal1 = $(this).data("optVal").split("*");
		const optnTy = $(this).data("optnTy");

		console.log("optnVal1 :", optnVal1, optnTy);

		jsMarketCartModalOptnChg2.f_optnVal2(optnVal1[0].trim(), optnTy);
	});

	<c:if test="${empty optnTtl[2]}">
	$(document).on("click", "#optnVal2 ul.option-items li a", function(e){
		e.preventDefault();

		const optnVal2 = $(this).data("optVal");//.split("*");
		const optnTy = $(this).data("optnTy");

		console.log("optnVal2 :", optnVal2, optnTy);

		if(optnVal2 != ""){
			jsMarketCartModalOptnChg2.f_baseOptnChg($(this), optnVal2);
		}



	});
	</c:if>

	</c:if>

	<c:if test="${!empty optnTtl[2]}">
	// 기본 옵션 3번
	$(document).on("click", "#optnVal2 ul.option-items li a", function(e){
		e.preventDefault();
		const optnVal2 = $(this).data("optVal").split("*");
		const optnTy = $(this).data("optnTy");
		console.log("optnVal2 :", optnVal2, optnTy);
		jsMarketCartModalOptnChg2.f_optnVal3(optnVal2[0].trim() +" * " +optnVal2[1].trim(), optnTy);

	});


	$(document).on("click", "#optnVal3 ul.option-items li a", function(e){
		e.preventDefault();
		const optnVal3 = $(this).data("optVal");//.split("*");
		const optnTy = $(this).data("optnTy");
		console.log("optnVal3 :", optnVal3, optnTy);
		if(optnVal3 != ""){
			jsMarketCartModalOptnChg2.f_baseOptnChg($(this), optnVal3);
		}
	});
	</c:if>


	<%--추가옵션--%>
	$(document).on("click", "[id^=aditOptnVal] ul.option-items li a", function(e){
		e.preventDefault();
		const optnVal = $(this).data("optVal");
		//기본상품이 있는지 먼저 체크해야함
		if($(".cart-chg-list tbody input[name='ordrOptnTy'][value='BASE']").length > 0 && optnVal != ""){
			jsMarketCartModalOptnChg2.f_aditOptnChg($(this), optnVal);
		}else{
			alert("기본 옵션을 먼저 선택해야 합니다.");
			$('.product-option').removeClass('is-active');
		}
	});


	


});
</script>