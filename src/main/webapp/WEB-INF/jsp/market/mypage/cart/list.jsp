<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<main id="container">
	<jsp:include page="../../layout/page_header.jsp">
		<jsp:param value="장바구니" name="pageTitle" />
	</jsp:include>

	<jsp:include page="../../ordr/include/personal_info.jsp" />

	<div id="page-container">
		<div id="page-content">
			<c:if test="${_mbrSession.recipterYn eq 'Y' || _mbrSession.prtcrRecipterYn eq 'Y'}">
				<%-- 급여주문 S --%>
				<h3 class="text-title mb-3 lg:mb-4">급여 주문</h3>
				<c:if test="${rResultList.size() < 1 }">
					<div class="box-result is-large">장바구니에 담긴 상품이 없습니다</div>
				</c:if>
			</c:if>

			<c:if test="${rResultList.size() > 0 }">
				<div class="mb-9 space-y-6 lg:mb-12 md:space-y-7.5">

					<c:set var="totalDlvyBassAmt" value="0" />
					<c:set var="totalCouponAmt" value="0" />
					<c:set var="totalAccmlMlg" value="0" />
					<c:set var="totalOrdrPc" value="0" />

					<c:forEach items="${rResultList}" var="cart" varStatus="status">

						<c:set var="spOrdrOptn" value="${fn:split(cart.ordrOptn, '*')}" />

						<c:if test="${cart.ordrOptnTy eq 'BASE'}">
							<c:set var="sumOrdrPc" value="${cart.ordrPc }" />
							<c:set var="ordrQy" value="${cart.ordrQy }" />


							<%-- 통합 주문 번호 --%>
							<c:if test="${status.first}">
								<div class="order-checkitem">
									<div class="form-check">
										<input class="form-check-input cart_ty_R" type="checkbox" name="cartGrpNo" value="${cart.cartGrpNo}" data-cart-ty="${cart.cartTy}">
										<input type="hidden" name="R_gdsPc" value="${cart.ordrPc}" /> <input type="hidden" name="R_dlvyPc" value="${cart.gdsInfo.dlvyAditAmt + cart.gdsInfo.dlvyBassAmt}" />
										<input type="hidden" name="R_stlmPc" value="${cart.ordrPc + cart.gdsInfo.dlvyAditAmt + cart.gdsInfo.dlvyBassAmt}" />
										<input type="hidden" name="gdsTag" value="${cart.gdsInfo.gdsTagVal}" />
										<input type="hidden" name="bnefCd" value="${cart.gdsInfo.bnefCd}" />
									</div>

									<div class="order-product">
										<!-- <button type="button" class="f_deleteSel order-close" data-cart-ty="R" data-grp-no="${cart.cartGrpNo}">삭제</button> -->
										<div class="order-body">
											<c:if test="${!empty cart.recipterUniqueId }">
												<%-- 베네핏 바이어 --%>
												<div class="order-buyer">
													<c:if test="${_mbrSession.uniqueId ne cart.recipterUniqueId}">
														<c:if test="${!empty cart.mbrVO.proflImg}">
															<img src="/comm/proflImg?fileName=${cart.mbrVO.proflImg}" alt="">
														</c:if>
														<strong>${cart.recipterInfo.mbrNm}</strong>
													</c:if>
												</div>
											</c:if>
							</c:if>
							<%-- 통합 주문 번호 --%>

							<div class="order-item">
								<div class="order-item-thumb">
									<c:choose>
										<c:when test="${!empty cart.gdsInfo.thumbnailFile }">
											<img src="/comm/getImage?srvcId=GDS&amp;upNo=${cart.gdsInfo.thumbnailFile.upNo }&amp;fileTy=${cart.gdsInfo.thumbnailFile.fileTy }&amp;fileNo=${cart.gdsInfo.thumbnailFile.fileNo }&amp;thumbYn=Y" alt="">
										</c:when>
										<c:otherwise>
											<img src="/html/page/market/assets/images/noimg.jpg" alt="">
										</c:otherwise>
									</c:choose>
								</div>
								<div class="order-item-content">
									<div class="order-item-group">
										<div class="order-item-base">
											<p class="code">
												</span>
												<c:if test="${!empty cart.gdsInfo.gdsTagVal}">
													<span class="label-outline-danger"> <span>${gdsTagCode[cart.gdsInfo.gdsTagVal]}</span>
													</span>
												</c:if>
												<u>${cart.gdsInfo.gdsCd }</u>
											</p>
											<div class="product">
												<p class="name">${cart.gdsInfo.gdsNm }</p>
												<c:if test="${!empty spOrdrOptn[0]}">
													<dl class="option">
														<dt>옵션</dt>
														<dd>
															<c:forEach items="${spOrdrOptn}" var="ordrOptn">
																<span class="label-flat">${ordrOptn}</span>
															</c:forEach>
														</dd>
													</dl>
												</c:if>
											</div>
										</div>
						</c:if>
						<c:if test="${cart.ordrOptnTy eq 'ADIT'}">
							<c:set var="sumOrdrPc" value="${sumOrdrPc + cart.ordrPc}" />
							<div class="order-item-add">
								<span class="label-outline-primary"> <span>${spOrdrOptn[0]}</span> <i><img src="/html/page/market/assets/images/ico-plus-white.svg" alt=""></i>
								</span>
								<div class="name">
									<p>
										<strong>${spOrdrOptn[1]}</strong>
									</p>
									<p>
										수량 ${cart.ordrQy}개 (+
										<fmt:formatNumber value="${cart.ordrPc}" pattern="###,###" />
										원)
									</p>
								</div>
							</div>
						</c:if>

						<c:if test="${rResultList[status.index+1].ordrOptnTy eq 'BASE' || status.last}">
				</div>
				<div class="order-item-count">
					<p>
						<strong>${ordrQy}</strong>개
					</p>
				</div>
				<p class="order-item-price">
					<fmt:formatNumber value="${sumOrdrPc}" pattern="###,###" />
					원
				</p>
				<div class="order-item-info">
					<div class="payment">
						<c:if test="${cart.cartTy eq 'R'}">
							<%-- 급여구매일 경우만 경우만 멤버스(사업소) 있음 --%>
							<c:if test="${!empty cart.bplcInfo}">
								<dl>
									<dt>멤버스</dt>
									<dd>${cart.bplcInfo.bplcNm }</dd>
								</dl>
							</c:if>
						</c:if>
						<dl>
							<dt>배송비</dt>
							<dd>
								<c:if test="${cart.gdsInfo.dlvyCtTy eq 'FREE'}">
	                                                	무료배송
	                                                	</c:if>
								<c:if test="${cart.gdsInfo.dlvyCtTy ne 'FREE'}">
	                                                	${cart.gdsInfo.dlvyBassAmt}원
	                                                	</c:if>
							</dd>
						</dl>
						<c:if test="${cart.gdsInfo.dlvyAditAmt > 0}">
							<dl>
								<dt>추가 배송비</dt>
								<dd>${cart.gdsInfo.dlvyAditAmt}원</dd>
							</dl>
						</c:if>
					</div>
				</div>
		</div>
	</div>

	<%-- 통합 주문 번호 --%>
	<c:if test="${status.last || (cart.cartGrpNo ne rResultList[status.index+1].cartGrpNo )}">
		</div>
		<c:if test="${cart.gdsInfo.stockQy < 1}">
			<div class="order-disable">
				<p>
					일시품절<br> 상품입니다
				</p>
			</div>
		</c:if>
		<c:if test="${cart.gdsInfo.useYn eq 'N'}">
			<div class="order-disable">
				<p>
					판매중지<br> 상품입니다
				</p>
			</div>
		</c:if>

		</div>
		</div>
	</c:if>
	<c:if test="${!status.last && cart.cartGrpNo ne rResultList[status.index+1].cartGrpNo}">

		<div class="order-checkitem">
			<div class="form-check">
				<input class="form-check-input cart_ty_R" type="checkbox" name="cartGrpNo" value="${rResultList[status.index+1].cartGrpNo}" data-cart-ty="${rResultList[status.index+1].cartTy}">
				<input type="hidden" name="R_gdsPc" value="${rResultList[status.index+1].ordrPc}" />
				<input type="hidden" name="R_dlvyPc" value="${rResultList[status.index+1].gdsInfo.dlvyAditAmt + rResultList[status.index+1].gdsInfo.dlvyBassAmt}" />
				<input type="hidden" name="R_stlmPc" value="${rResultList[status.index+1].ordrPc + rResultList[status.index+1].gdsInfo.dlvyAditAmt + rResultList[status.index+1].gdsInfo.dlvyBassAmt}" />
				<input type="hidden" name="gdsTag" value="${rResultList[status.index+1].gdsInfo.gdsTagVal}" />
				<input type="hidden" name="bnefCd" value="${rResultList[status.index+1].gdsInfo.bnefCd}" />
			</div>

			<div class="order-product">
				<!-- <button type="button" class="f_deleteSel order-close" data-cart-ty="R" data-grp-no="${rResultList[status.index+1].cartGrpNo}">삭제</button> -->
				<div class="order-body">
					<c:if test="${!empty rResultList[status.index+1].recipterUniqueId }">
						<%-- 베네핏 바이어 --%>
						<div class="order-buyer">
							<c:if test="${_mbrSession.uniqueId ne  rResultList[status.index+1].recipterUniqueId}">
								<c:if test="${!empty rResultList[status.index+1].mbrVO.proflImg}">
									<img src="/comm/proflImg?fileName=${rResultList[status.index+1].mbrVO.proflImg}" alt="">
								</c:if>
								<strong>${rResultList[status.index+1].recipterInfo.mbrNm}</strong>
							</c:if>
						</div>
					</c:if>
	</c:if>
	<%-- 통합 주문 번호 --%>
	</c:if>

	<%-- 배송비 + 추가배송비 --%>
	<c:set var="totalDlvyBassAmt" value="${totalDlvyBassAmt + (cart.ordrOptnTy eq 'BASE'?(cart.gdsInfo.dlvyBassAmt + cart.gdsInfo.dlvyAditAmt):0)}" />

	<%-- 주문금액 + 옵션금액 --%>
	<c:set var="totalOrdrPc" value="${totalOrdrPc + cart.ordrPc}" />

	</c:forEach>

	</div>

	<div class="flex justify-center mt-9 space-x-1 lg:mt-12 md:space-x-1.5">
		<button class="btn btn-primary md:px-8.5 f_checkAll" data-cart-ty="R">전체선택</button>
		<button class="btn btn-outline-primary md:px-8.5 f_delete" data-cart-ty="R" data-sel-ty="ALL">전체삭제</button>
		<button class="btn btn-outline-primary md:px-8.5 f_delete" data-cart-ty="R" data-sel-ty="SEL">선택상품 삭제</button>
	</div>


	<div class="order-amount mt-8 lg:mt-10">
		<div class="container">
			<div class="amount-section">
				<dl>
					<dt>상품금액</dt>
					<dd>
						<strong class="R_totalGdsPc"><fmt:formatNumber value="${totalOrdrPc}" pattern="###,###" /></strong> 원
					</dd>
				</dl>
				<i class="is-plus">+</i>
				<dl>
					<dt>배송비</dt>
					<dd>
						<strong class="R_totalDlvyPc"><fmt:formatNumber value="${totalDlvyBassAmt}" pattern="###,###" /></strong> 원
					</dd>
				</dl>
			</div>
			<div class="amount-section">
				<i class="is-equal">=</i>
				<dl class="text-danger">
					<dt>총 결제예정금액</dt>
					<dd>
						<strong class="R_totalStlmPc"><fmt:formatNumber value="${totalOrdrPc + totalDlvyBassAmt}" pattern="###,###" /></strong> 원
					</dd>
				</dl>
			</div>
		</div>
	</div>
	</c:if>


	<c:if test="${_mbrSession.recipterYn eq 'Y' || _mbrSession.prtcrRecipterYn eq 'Y'}">
		<div class="flex justify-end text-right mt-8.5 md:pr-6 lg:mt-11 space-x-1.5 md:space-x-2.5">
			<a href="${_marketPath}/gds/list" class="btn btn-large btn-outline-secondary xs-max:px-3">쇼핑 계속하기</a>
			<button type="button" class="btn btn-large btn-primary xs-max:px-3 f_ordr" data-cart-ty="R" data-sel-ty="SEL">선택상품 주문하기</button>
			<button type="button" href="#" class="btn btn-large btn-danger xs-max:px-3 f_ordr" data-cart-ty="R" data-sel-ty="ALL">전체상품 주문하기</button>
		</div>
		<%-- 급여주문 E --%>
	</c:if>

	<%-- 비급여 상품 --%>
	<h3 class="text-title mb-3 lg:mb-4 <c:if test="${_mbrSession.prtcrRecipterYn eq 'Y'}">mt-20</c:if>">바로 구매</h3>

	<c:if test="${nResultList.size() < 1 }">
		<div class="box-result is-large">장바구니에 담긴 상품이 없습니다</div>
	</c:if>
	<c:if test="${nResultList.size() > 0 }">
		<div class="mb-9 space-y-6 lg:mb-12 md:space-y-7.5">

			<c:set var="totalDlvyBassAmt" value="0" />
			<c:set var="totalCouponAmt" value="0" />
			<c:set var="totalAccmlMlg" value="0" />
			<c:set var="totalOrdrPc" value="0" />

			<c:forEach items="${nResultList}" var="cart" varStatus="status">

				<c:set var="spOrdrOptn" value="${fn:split(cart.ordrOptn, '*')}" />

				<c:if test="${cart.ordrOptnTy eq 'BASE'}">
					<c:set var="sumOrdrPc" value="${cart.ordrPc }" />
					<c:set var="ordrQy" value="${cart.ordrQy }" />


					<%-- 통합 주문 번호 --%>
					<c:if test="${status.first}">
						<div class="order-checkitem">
							<div class="form-check">
								<input class="form-check-input cart_ty_N" type="checkbox" name="cartGrpNo" value="${cart.cartGrpNo}">
								<input type="hidden" name="L_gdsPc" value="${cart.ordrPc}" />
								<input type="hidden" name="L_dlvyPc" value="${cart.gdsInfo.dlvyAditAmt + cart.gdsInfo.dlvyBassAmt}" />
								<input type="hidden" name="L_stlmPc" value="${cart.ordrPc + cart.gdsInfo.dlvyAditAmt + cart.gdsInfo.dlvyBassAmt}" />
								<input type="hidden" name="gdsTag" value="${cart.gdsInfo.gdsTagVal}" />
								<input type="hidden" name="bnefCd" value="${cart.gdsInfo.bnefCd}" />
							</div>

							<div class="order-product">
								<!-- <button type="button" class="f_deleteSel order-close" data-cart-ty="N" data-grp-no="${cart.cartGrpNo}">삭제</button> -->
								<div class="order-body">
									<c:if test="${!empty cart.recipterUniqueId }">
										<%-- 베네핏 바이어 --%>
										<div class="order-buyer">
											<c:if test="${cart.recipterUniqueId ne _mbrSession.uniqueId}">
												<c:if test="${!empty cart.mbrVO.proflImg}">
													<img src="/comm/proflImg?fileName=${cart.mbrVO.proflImg}" alt="">
												</c:if>
												<strong>${cart.recipterInfo.mbrNm}</strong>
											</c:if>
										</div>
									</c:if>
					</c:if>
					<%-- 통합 주문 번호 --%>

					<div class="order-item">
						<div class="order-item-thumb">
							<c:choose>
								<c:when test="${!empty cart.gdsInfo.thumbnailFile }">
									<img src="/comm/getImage?srvcId=GDS&amp;upNo=${cart.gdsInfo.thumbnailFile.upNo }&amp;fileTy=${cart.gdsInfo.thumbnailFile.fileTy }&amp;fileNo=${cart.gdsInfo.thumbnailFile.fileNo }&amp;thumbYn=Y" alt="">
								</c:when>
								<c:otherwise>
									<img src="/html/page/market/assets/images/noimg.jpg" alt="">
								</c:otherwise>
							</c:choose>
						</div>
						<div class="order-item-content">
							<div class="order-item-group">
								<div class="order-item-base">
									<p class="code">
										<span class="label-primary"> <span>${gdsTyCode[cart.gdsInfo.gdsTy]}</span> <i></i>
										</span>
										<c:if test="${!empty cart.gdsInfo.gdsTagVal}">
											<span class="label-outline-danger"> <span>${gdsTagCode[cart.gdsInfo.gdsTagVal]}</span>
											</span>
										</c:if>
										<u>${cart.gdsInfo.gdsCd }</u>
									</p>
									<div class="product">
										<p class="name">${cart.gdsInfo.gdsNm }</p>
										<c:if test="${!empty spOrdrOptn[0]}">
											<dl class="option">
												<dt>옵션</dt>
												<dd>
													<c:forEach items="${spOrdrOptn}" var="ordrOptn">
														<span class="label-flat">${ordrOptn}</span>
													</c:forEach>
												</dd>
											</dl>
										</c:if>
									</div>
								</div>
				</c:if>
				<c:if test="${cart.ordrOptnTy eq 'ADIT'}">
					<c:set var="sumOrdrPc" value="${sumOrdrPc + cart.ordrPc}" />
					<div class="order-item-add">
						<span class="label-outline-primary"> <span>${spOrdrOptn[0]}</span> <i><img src="/html/page/market/assets/images/ico-plus-white.svg" alt=""></i>
						</span>
						<div class="name">
							<p>
								<strong>${spOrdrOptn[1]}</strong>
							</p>
							<p>
								수량 ${cart.ordrQy}개 (+
								<fmt:formatNumber value="${cart.ordrPc}" pattern="###,###" />
								원)
							</p>
						</div>
					</div>
				</c:if>

				<c:if test="${nResultList[status.index+1].ordrOptnTy eq 'BASE' || status.last}">
		</div>
		<div class="order-item-count">
			<p>
				<strong>${ordrQy}</strong>개
			</p>
		</div>
		<p class="order-item-price">
			<fmt:formatNumber value="${sumOrdrPc}" pattern="###,###" />
			원
		</p>
		<div class="order-item-info">
			<div class="payment">
				<c:if test="${cart.cartTy eq 'R'}">
					<%-- 급여구매일 경우만 경우만 멤버스(사업소) 있음 --%>
					<c:if test="${!empty cart.bplcInfo}">
						<dl>
							<dt>멤버스</dt>
							<dd>${cart.bplcInfo.bplcNm }</dd>
						</dl>
					</c:if>
				</c:if>
				<dl>
					<dt>배송비</dt>
					<dd>
						<c:if test="${cart.gdsInfo.dlvyCtTy eq 'FREE'}">
	                                                	무료배송
	                                                	</c:if>
						<c:if test="${cart.gdsInfo.dlvyCtTy ne 'FREE'}">
	                                                	${cart.gdsInfo.dlvyBassAmt}원
	                                                	</c:if>
					</dd>
				</dl>
				<c:if test="${cart.gdsInfo.dlvyAditAmt > 0}">
					<dl>
						<dt>추가 배송비</dt>
						<dd>${cart.gdsInfo.dlvyAditAmt}원</dd>
					</dl>
				</c:if>
			</div>
		</div>
		</div>
		</div>

		<%-- 통합 주문 번호 --%>
		<c:if test="${status.last || (cart.cartGrpNo ne nResultList[status.index+1].cartGrpNo )}">
			</div>
			<c:if test="${cart.gdsInfo.stockQy < 1}">
				<div class="order-disable">
					<p>
						일시품절<br> 상품입니다
					</p>
				</div>
			</c:if>
			<c:if test="${cart.gdsInfo.useYn eq 'N'}">
				<div class="order-disable">
					<p>
						판매중지<br> 상품입니다
					</p>
				</div>
			</c:if>

			</div>
			</div>
		</c:if>
		<c:if test="${!status.last && cart.cartGrpNo ne nResultList[status.index+1].cartGrpNo}">

			<div class="order-checkitem">
				<div class="form-check">
					<input class="form-check-input cart_ty_N" type="checkbox" name="cartGrpNo" value="${nResultList[status.index+1].cartGrpNo}">
					<input type="hidden" name="L_gdsPc" value="${nResultList[status.index+1].ordrPc}" />
					<input type="hidden" name="L_dlvyPc" value="${nResultList[status.index+1].gdsInfo.dlvyAditAmt + nResultList[status.index+1].gdsInfo.dlvyBassAmt}" />
					<input type="hidden" name="L_stlmPc" value="${nResultList[status.index+1].ordrPc + nResultList[status.index+1].gdsInfo.dlvyAditAmt + nResultList[status.index+1].gdsInfo.dlvyBassAmt}" />
					<input type="hidden" name="gdsTag" value="${nResultList[status.index+1].gdsInfo.gdsTagVal}" />
					<input type="hidden" name="bnefCd" value="${nResultList[status.index+1].gdsInfo.bnefCd}" />
				</div>

				<div class="order-product">
					<!-- <button type="button" class="f_deleteSel order-close" data-cart-ty="N" data-grp-no="${nResultList[status.index+1].cartGrpNo}">삭제</button> -->
					<div class="order-body">
						<c:if test="${!empty nResultList[status.index+1].recipterUniqueId }">
							<%-- 베네핏 바이어 --%>
							<div class="order-buyer">
								<c:if test="${nResultList[status.index+1].recipterUniqueId ne _mbrSession.uniqueId}">
									<c:if test="${!empty nResultList[status.index+1].mbrVO.proflImg}">
										<img src="/comm/proflImg?fileName=${nResultList[status.index+1].mbrVO.proflImg}" alt="">
									</c:if>
									<strong>${nResultList[status.index+1].recipterInfo.mbrNm}</strong>
								</c:if>
							</div>
						</c:if>
		</c:if>
		<%-- 통합 주문 번호 --%>
	</c:if>

	<%-- 배송비 + 추가배송비 --%>
	<c:set var="totalDlvyBassAmt" value="${totalDlvyBassAmt + (cart.ordrOptnTy eq 'BASE'?(cart.gdsInfo.dlvyBassAmt + cart.gdsInfo.dlvyAditAmt):0)}" />

	<%-- 주문금액 + 옵션금액 --%>
	<c:set var="totalOrdrPc" value="${totalOrdrPc + cart.ordrPc}" />

	</c:forEach>

	</div>

	<div class="flex justify-center mt-9 space-x-1 lg:mt-12 md:space-x-1.5">
		<button class="btn btn-primary md:px-8.5 f_checkAll" data-cart-ty="N">전체선택</button>
		<button class="btn btn-outline-primary md:px-8.5 f_delete" data-cart-ty="N" data-sel-ty="ALL">전체삭제</button>
		<button class="btn btn-outline-primary md:px-8.5 f_delete" data-cart-ty="N" data-sel-ty="SEL">선택상품 삭제</button>
	</div>

	<div class="order-amount mt-8 lg:mt-10">
		<div class="container">
			<div class="amount-section">
				<dl>
					<dt>상품금액</dt>
					<dd>
						<strong class="L_totalGdsPc"><fmt:formatNumber value="${totalOrdrPc}" pattern="###,###" /></strong> 원
					</dd>
				</dl>
				<i class="is-plus">+</i>
				<dl>
					<dt>배송비</dt>
					<dd>
						<strong class="L_totalDlvyPc"><fmt:formatNumber value="${totalDlvyBassAmt}" pattern="###,###" /></strong> 원
					</dd>
				</dl>
			</div>
			<div class="amount-section">
				<i class="is-equal">=</i>
				<dl class="text-danger">
					<dt>총 결제예정금액</dt>
					<dd>
						<strong class="L_totalStlmPc"><fmt:formatNumber value="${totalOrdrPc + totalDlvyBassAmt}" pattern="###,###" /></strong> 원
					</dd>
				</dl>
			</div>
		</div>
	</div>
	</c:if>

	<div class="flex justify-end text-right mt-8.5 md:pr-6 lg:mt-11 space-x-1.5 md:space-x-2.5">
		<a href="${_marketPath}/gds/list" class="btn btn-large btn-outline-secondary xs-max:px-3">쇼핑 계속하기</a>
		<button type="button" class="btn btn-large btn-primary xs-max:px-3 f_ordr" data-cart-ty="N" data-sel-ty="SEL">선택상품 주문하기</button>
		<button type="button" href="#" class="btn btn-large btn-danger xs-max:px-3 f_ordr" data-cart-ty="N" data-sel-ty="ALL">전체상품 주문하기</button>
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
</main>



<script>
	function f_cartClick(params) {
		let cartTy = params.get("cartTy");
		let cartGrpNos = params.get("cartGrpNos");
		let selTy = params.get("selTy");
		let confirmMsg = "선택한 상품을 주문 하시겠습니까?";

		if (cartGrpNos == null || cartGrpNos.length == 0) {
			alert("주문하실 상품을 먼저 선택해주세요.");
		} else if (cartTy == "R"
				&& $(":checkbox[name=cartGrpNo]:checked.cart_ty_R[data-cart-ty='L']").length > 1) {
			alert("대여상품은 한개씩만 주문 가능합니다.");
		} else if (confirm(confirmMsg)) {
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
		//전체선택
		const rTotalCnt = $(":checkbox[name=cartGrpNo].cart_ty_R").length;
		const nTotalCnt = $(":checkbox[name=cartGrpNo].cart_ty_N").length;
		$(".f_checkAll")
				.on(
						"click",
						function() {
							let cartTy = $(this).data("cartTy"); // 급여/비급여
							let isChecked = true;
							if (cartTy == "R") {
								if (rTotalCnt == $(":checkbox[name=cartGrpNo].cart_ty_R:checked").length) {
									isChecked = false;
								} else {
									isChecked = true;
								}
							} else {
								if (nTotalCnt == $(":checkbox[name=cartGrpNo].cart_ty_N:checked").length) {
									isChecked = false;
								} else {
									isChecked = true;
								}
							}
							$(":checkbox[name=cartGrpNo].cart_ty_" + cartTy)
									.prop("checked", isChecked);
							$(":checkbox[name=cartGrpNo].cart_ty_" + cartTy)
									.parents(".order-checkitem").find(
											".order-product").removeClass(
											"is-active");
							$(
									":checkbox[name=cartGrpNo].cart_ty_"
											+ cartTy + ":checked").parents(
									".order-checkitem").find(".order-product")
									.addClass("is-active");
						})

		//체크박스(급여)
		let totalsGdsPc = 0;
		let totalsDlvyPc = 0;
		let totalsStlmPc = 0;
		$(".cart_ty_R")
				.on(
						"click",
						function() {
							let isChecked = $(this).is(":checked");
							let gdsPcs = $(this).siblings(
									"input[name='R_gdsPc']").val();
							let dlvyPcs = $(this).siblings(
									"input[name='R_dlvyPc']").val();
							let stlmPcs = $(this).siblings(
									"input[name='R_stlmPc']").val();
							$(this).prop("checked", isChecked);
							if (isChecked) {
								$(this).parents(".order-checkitem").find(
										".order-product").addClass("is-active");
								totalsGdsPc = Number(totalsGdsPc)
										+ Number(gdsPcs);
								totalsDlvyPc = Number(totalsDlvyPc)
										+ Number(dlvyPcs);
								totalsStlmPc = Number(totalsStlmPc)
										+ Number(stlmPcs);
							} else {
								$(this).parents(".order-checkitem").find(
										".order-product").removeClass(
										"is-active");
								totalsGdsPc = Number(totalsGdsPc)
										- Number(gdsPcs);
								totalsDlvyPc = Number(totalsDlvyPc)
										- Number(dlvyPcs);
								totalsStlmPc = Number(totalsStlmPc)
										- Number(stlmPcs);
							}
							if ($(":checkbox[name='cartGrpNo'].cart_ty_R:checked").length < 1) {
								let orisGdsPc = 0;
								let orisDlvyPc = 0;
								let orisStlmPc = 0;
								$("input[name='R_gdsPc']").each(
										function() {
											orisGdsPc = Number(orisGdsPc)
													+ Number($(this).val());
										});
								$("input[name='R_dlvyPc']").each(
										function() {
											orisDlvyPc = Number(orisDlvyPc)
													+ Number($(this).val());
										});
								$("input[name='R_stlmPc']").each(
										function() {
											orisStlmPc = Number(orisStlmPc)
													+ Number($(this).val());
										});
								$(".R_totalGdsPc").text(comma(orisGdsPc));
								$(".R_totalDlvyPc").text(comma(orisDlvyPc));
								$(".R_totalStlmPc").text(comma(orisStlmPc));
							} else {
								$(".R_totalGdsPc").text(comma(totalsGdsPc));
								$(".R_totalDlvyPc").text(comma(totalsDlvyPc));
								$(".R_totalStlmPc").text(comma(totalsStlmPc));
							}

						});
		//체크박스(비급여)
		let totalGdsPc = 0;
		let totalDlvyPc = 0;
		let totalStlmPc = 0;
		$(".cart_ty_N")	.on("click",function() {
			let isChecked = $(this).is(":checked");
			let gdsPc = $(this).siblings("input[name='L_gdsPc']").val();
			let dlvyPc = $(this).siblings("input[name='L_dlvyPc']").val();
			let stlmPc = $(this).siblings("input[name='L_stlmPc']").val();

			$(this).prop("checked", isChecked);

			if (isChecked) {
				$(this).parents(".order-checkitem").find(".order-product").addClass("is-active");
				totalGdsPc = Number(totalGdsPc) + Number(gdsPc);
				totalDlvyPc = Number(totalDlvyPc)+ Number(dlvyPc);
				totalStlmPc = Number(totalStlmPc)+ Number(stlmPc);
				} else {
					$(this).parents(".order-checkitem").find(".order-product").removeClass("is-active");
					totalGdsPc = Number(totalGdsPc) - Number(gdsPc);
					totalDlvyPc = Number(totalDlvyPc) - Number(dlvyPc);
					totalStlmPc = Number(totalStlmPc) - Number(stlmPc);
					}
			if ($(":checkbox[name='cartGrpNo'].cart_ty_N:checked").length < 1) {
				let oriGdsPc = 0;
				let oriDlvyPc = 0;
				let oriStlmPc = 0;
				$("input[name='L_gdsPc']").each(	function() {
					oriGdsPc = Number(oriGdsPc)+ Number($(this).val());
				});
				$("input[name='L_dlvyPc']").each(function() {
					oriDlvyPc = Number(oriDlvyPc) + Number($(this).val());
				});
				$("input[name='L_stlmPc']").each(function() {
					oriStlmPc = Number(oriStlmPc) + Number($(this).val());
				});
				$(".L_totalGdsPc").text(comma(oriGdsPc));
				$(".L_totalDlvyPc").text(comma(oriDlvyPc));
				$(".L_totalStlmPc").text(comma(oriStlmPc));
				} else {
					$(".L_totalGdsPc").text(comma(totalGdsPc));
					$(".L_totalDlvyPc").text(comma(totalDlvyPc));
					$(".L_totalStlmPc").text(comma(totalStlmPc));
					}
				});

		// 단일 삭제 버튼
		$(".f_deleteSel").on(	"click",function() {
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
			});

		// 선택/전체 삭제 버튼
		$(".f_delete").on("click",function() {
			let cartGrpNos;
			let cartTy = $(this).data("cartTy"); // 급여/비급여
			let selTy = $(this).data("selTy"); // 전체/선택
			let confirmMsg = "선택한 상품을 삭제 하시겠습니까?";


			if (selTy == "ALL") {
				cartGrpNos = $(":checkbox[name=cartGrpNo].cart_ty_"+ cartTy).map(function() {return $(this).val();}).get();
				confirmMsg = "전체 상품을 삭제 하시겠습니까?"
						} else {
							cartGrpNos = $(":checkbox[name=cartGrpNo]:checked.cart_ty_"+ cartTy).map(function() {return $(this).val();}).get();
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

		// 주문
		$(".f_ordr").on("click",function() {
					let cartGrpNos;
					let cartTy = $(this).data("cartTy"); // 급여/비급여
					let selTy = $(this).data("selTy"); // 전체/선택
					let soldFlag = false;

					// 품절 검사
					var tagList = [ 'A', 'B', 'C' ];

					if (selTy == "ALL") {
						$(":checkbox[name=cartGrpNo].cart_ty_" + cartTy)	.prop("checked", true);
						$(	":checkbox[name=cartGrpNo].cart_ty_" + cartTy + ":checked").parents(".order-checkitem").find(".order-product").addClass("is-active");
						cartGrpNos = $(":checkbox[name=cartGrpNo].cart_ty_"+ cartTy).map(function() {	return $(this).val();}).get();

						$("input[name='gdsTag']").each(function() {
							if (tagList.includes($(this).val())) {
								soldFlag = true;
							}
						});

						//console.log(cartGrpNos);

						confirmMsg = "전체 상품을 주문 하시겠습니까?"
					} else {
						cartGrpNos = $(":checkbox[name=cartGrpNo]:checked.cart_ty_"	+ cartTy).map(function() {return $(this).val();}).get();

						$("input[name='cartGrpNo']:checked").each(function(){
							var gdsTag = $(this).siblings("input[name='gdsTag']").val();

							if(tagList.includes(gdsTag)){
								soldFlag = true;
							}
						});

					}

					console.log("cartTy : " + cartTy);

					if (soldFlag) {
						alert("품절된 상품이 존재합니다.");
						$("input[name='cartGrpNo']").prop("checked",false);
						$(".order-product").removeClass("is-active");
						return false;
					} else {
						let params = new Map();
						params.set("cartTy", cartTy);
						params.set("selTy", selTy);
						params.set("cartGrpNos", cartGrpNos);

						var bnefList = [];
						$("input[name='cartGrpNo']:checked").each(function(){
							//console.log($(this).siblings("input[name='bnefCd']").val());
							var bnefCd = $(this).siblings("input[name='bnefCd']").val();
							if(bnefCd != null && bnefCd != '' ){
								bnefList.push($(this).siblings("input[name='bnefCd']").val());
							}
						});

						if ($("input[name='bnefCd']").length > 0) {
							params.set("bnefList", bnefList);
							params.set("method", f_cartClick);

							f_itemChk(params);
							cnt = 0;

						}
					}

				});

	});
</script>