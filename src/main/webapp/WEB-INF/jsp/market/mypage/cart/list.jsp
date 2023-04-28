<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>


<main id="container">
	<jsp:include page="../../layout/page_header.jsp">
		<jsp:param value="장바구니" name="pageTitle" />
	</jsp:include>

	<jsp:include page="../../ordr/include/personal_info.jsp" />

	<div id="page-container">
		<div id="page-content">
			<c:if test="${_mbrSession.recipterYn eq 'Y' || _mbrSession.prtcrRecipterYn eq 'Y'}">

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



							<c:if test="${status.first}">
								<div class="order-product order-partners">
									<div class="order-header">
										<div class="form-check order-check">
											<!-- <input class="form-check-input cart_ty_R" type="checkbox" name="cartGrpNo" value="${cart.cartGrpNo}" data-cart-ty="${cart.cartTy}"> -->
											<input class="form-check-input cart_ty_R" type="checkbox" name="bplc_all" value="${cart.bplcInfo.uniqueId}">
										</div>
										<dl class="large">
											<dt>사업소</dt>
											<dd>${cart.bplcInfo.bplcNm}</dd>
										</dl>
										<!-- <button type="button">삭제</button> -->
									</div>

									<div class="order-body">
										<!-- <button type="button" class="f_deleteSel order-close" data-cart-ty="R" data-grp-no="${cart.cartGrpNo}">삭제</button> -->
											<c:if test="${!empty cart.recipterUniqueId }">

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


							<div class="order-item">
								<div class="form-check order-check">
                                    <input class="form-check-input cart_ty_R bplc_${cart.bplcInfo.uniqueId}" type="checkbox" name="bplc_item" value="${cart.bplcInfo.uniqueId}" data-cart-grp="${cart.cartGrpNo}" data-cart-ty="${cart.cartTy}">
                                    <input type="hidden" name="${cart.bplcInfo.uniqueId}_gdsPc" value="${cart.ordrPc}" />
									<input type="hidden" name="${cart.bplcInfo.uniqueId}_dlvyPc" value="${cart.gdsInfo.dlvyAditAmt + cart.gdsInfo.dlvyBassAmt}" />
									<input type="hidden" name="${cart.bplcInfo.uniqueId}_stlmPc" value="${cart.ordrPc + cart.gdsInfo.dlvyAditAmt + cart.gdsInfo.dlvyBassAmt}" />
									<input type="hidden" name="gdsTag" value="${cart.gdsInfo.gdsTagVal}" />
									<input type="hidden" name="bnefCd" value="${cart.gdsInfo.bnefCd}" />
                                </div>
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
					<button type="button" class="btn btn-primary btn-small f_optn_chg" data-cart-grp="${cart.cartGrpNo}">변경</button>
				</div>
				<p class="order-item-price">
					<fmt:formatNumber value="${sumOrdrPc}" pattern="###,###" />
					원
				</p>
				<div class="order-item-info">
					<div class="payment">
						<!--<c:if test="${cart.cartTy eq 'R'}">

							<c:if test="${!empty cart.bplcInfo}">
								<dl>
									<dt>멤버스</dt>
									<dd>${cart.bplcInfo.bplcNm }</dd>
								</dl>
							</c:if>
						</c:if>-->
						<dl>
							<dt>배송비</dt>
							<dd>
								<c:if test="${cart.gdsInfo.dlvyCtTy eq 'FREE'}">
	                                                	무료배송
	                                                	</c:if>
								<c:if test="${cart.gdsInfo.dlvyCtTy ne 'FREE'}">
	                                                	<fmt:formatNumber pattern="###,###" value="${cart.gdsInfo.dlvyBassAmt}" /> 원
	                                                	</c:if>
							</dd>
						</dl>
						<c:if test="${cart.gdsInfo.dlvyAditAmt > 0}">
							<dl>
								<dt>추가 배송비</dt>
								<dd><fmt:formatNumber pattern="###,###" value="${cart.gdsInfo.dlvyAditAmt}" />원</dd>

							</dl>
						</c:if>
					</div>
				</div>
		</div>


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

	</c:if>

	<c:if test="${!status.last && cart.bplcUniqueId ne rResultList[status.index+1].bplcUniqueId}">
	</div>
	</div>
	<div class="flex justify-center mt-9 space-x-1 lg:mt-12 md:space-x-1.5">
		<button class="btn btn-primary md:px-8.5 f_bplc_All" data-bplc-unique="${cart.bplcUniqueId}" >전체선택</button>
		<button class="btn btn-outline-primary md:px-8.5 f_delete" data-bplc-unique="${cart.bplcUniqueId}" data-cart-ty="R" data-sel-ty="ALL">전체삭제</button>
		<button class="btn btn-outline-primary md:px-8.5 f_delete" data-bplc-unique="${cart.bplcUniqueId}" data-cart-ty="R" data-sel-ty="SEL">선택상품 삭제</button>
	</div>
	<%-- 배송비 + 추가배송비 --%>
	<c:set var="totalDlvyBassAmt" value="${totalDlvyBassAmt + (cart.ordrOptnTy eq 'BASE'?(cart.gdsInfo.dlvyBassAmt + cart.gdsInfo.dlvyAditAmt):0)}" />

	<%-- 주문금액 + 옵션금액 --%>
	<c:set var="totalOrdrPc" value="${totalOrdrPc + cart.ordrPc}" />

	<%--금액정보 START --%>
	<div class="order-amount mt-8 lg:mt-10">
		<div class="container">
			<div class="amount-section">
				<dl>
					<dt>상품금액</dt>
					<dd>
						<!-- <strong class="${cart.bplcUniqueId}_totalGdsPc"><fmt:formatNumber value="${totalOrdrPc}" pattern="###,###" /></strong> 원 -->
						<strong class="${cart.bplcUniqueId}_totalGdsPc"><fmt:formatNumber value="0" pattern="###,###" /></strong> 원
					</dd>
				</dl>
				<i class="is-plus">+</i>
				<dl>
					<dt>배송비</dt>
					<dd>
						<!-- <strong class="${cart.bplcUniqueId}_totalDlvyPc"><fmt:formatNumber value="${totalDlvyBassAmt}" pattern="###,###" /></strong> 원 -->
						<strong class="${cart.bplcUniqueId}_totalDlvyPc"><fmt:formatNumber value="0" pattern="###,###" /></strong> 원
					</dd>
				</dl>
			</div>
			<div class="amount-section">
				<i class="is-equal">=</i>
				<dl class="text-danger">
					<dt>총 결제예정금액</dt>
					<dd>
						<!-- <strong class="${cart.bplcUniqueId}_totalStlmPc"><fmt:formatNumber value="${totalOrdrPc + totalDlvyBassAmt}" pattern="###,###" /></strong> 원 -->
						<strong class="${cart.bplcUniqueId}_totalStlmPc"><fmt:formatNumber value="0" pattern="###,###" /></strong> 원
					</dd>
				</dl>
			</div>
		</div>
	</div>

	<c:if test="${_mbrSession.recipterYn eq 'Y' || _mbrSession.prtcrRecipterYn eq 'Y'}">
		<div class="flex justify-end text-right mt-8.5 md:pr-6 lg:mt-11 space-x-1.5 md:space-x-2.5">
			<a href="${_marketPath}/gds/list" class="btn btn-large btn-outline-secondary xs-max:px-3">쇼핑 계속하기</a>
			<button type="button" class="btn btn-large btn-primary xs-max:px-3 f_ordr_R" data-bplc-unique="${cart.bplcUniqueId}" data-sel-ty="SEL" data-cart-ty="R">선택상품 주문하기</button>
			<button type="button" class="btn btn-large btn-danger xs-max:px-3 f_ordr_R" data-bplc-unique="${cart.bplcUniqueId}"  data-sel-ty="ALL" data-cart-ty="R">전체상품 주문하기</button>
		</div>
	</c:if>

		<div class="order-product order-partners">
			<div class="order-header">
				<div class="form-check order-check">
					<!-- <input class="form-check-input cart_ty_R" type="checkbox" name="cartGrpNo" value="${rResultList[status.index+1].cartGrpNo}" data-cart-ty="${rResultList[status.index+1].cartTy}"> -->
					<input class="form-check-input cart_ty_R" type="checkbox" name="bplc_all" value="${rResultList[status.index+1].bplcInfo.uniqueId}">
				</div>
				<dl class="large">
					<dt>사업소</dt>
					<dd>${rResultList[status.index+1].bplcInfo.bplcNm}</dd>
				</dl>
				<!-- <button type="button">삭제</button> -->
			</div>

			<div class="order-body">
				<!-- <button type="button" class="f_deleteSel order-close" data-cart-ty="R" data-grp-no="${rResultList[status.index+1].cartGrpNo}">삭제</button> -->
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
	<c:if test="${status.last}">
	<c:set var="last_bplc" value="${cart.bplcInfo.uniqueId }" />
	<c:set var="totalDlvyBassAmt" value="0" />
	<c:set var="totalCouponAmt" value="0" />
	<c:set var="totalAccmlMlg" value="0" />
	<c:set var="totalOrdrPc" value="0" />
		</div>
		</div>
	</c:if>
	<%-- 통합 주문 번호 --%>
	</c:if>

	<%-- 배송비 + 추가배송비 --%>
	<c:set var="totalDlvyBassAmt" value="${totalDlvyBassAmt + (cart.ordrOptnTy eq 'BASE'?(cart.gdsInfo.dlvyBassAmt + cart.gdsInfo.dlvyAditAmt):0)}" />

	<%-- 주문금액 + 옵션금액 --%>
	<c:set var="totalOrdrPc" value="${totalOrdrPc + cart.ordrPc}" />

	</c:forEach>

	<div class="flex justify-center mt-9 space-x-1 lg:mt-12 md:space-x-1.5">
		<button class="btn btn-primary md:px-8.5 f_bplc_All" data-bplc-unique="${last_bplc}">전체선택</button>
		<button class="btn btn-outline-primary md:px-8.5 f_delete" data-bplc-unique="${last_bplc}" data-cart-ty="R" data-sel-ty="ALL">전체삭제</button>
		<button class="btn btn-outline-primary md:px-8.5 f_delete" data-bplc-unique="${last_bplc}" data-cart-ty="R" data-sel-ty="SEL">선택상품 삭제</button>
	</div>

	<%--금액정보 START --%>
	<div class="order-amount mt-8 lg:mt-10">
		<div class="container">
			<div class="amount-section">
				<dl>
					<dt>상품금액</dt>
					<dd>
						<!-- <strong class="${last_bplc}_totalGdsPc"><fmt:formatNumber value="${totalOrdrPc}" pattern="###,###" /></strong> 원 -->
						<strong class="${last_bplc}_totalGdsPc"><fmt:formatNumber value="0" pattern="###,###" /></strong> 원
					</dd>
				</dl>
				<i class="is-plus">+</i>
				<dl>
					<dt>배송비</dt>
					<dd>
						<!-- <strong class="${last_bplc}_totalDlvyPc"><fmt:formatNumber value="${totalDlvyBassAmt}" pattern="###,###" /></strong> 원 -->
						<strong class="${last_bplc}_totalDlvyPc"><fmt:formatNumber value="0" pattern="###,###" /></strong> 원
					</dd>
				</dl>
			</div>
			<div class="amount-section">
				<i class="is-equal">=</i>
				<dl class="text-danger">
					<dt>총 결제예정금액</dt>
					<dd>
						<!-- <strong class="${last_bplc}_totalStlmPc"><fmt:formatNumber value="${totalOrdrPc + totalDlvyBassAmt}" pattern="###,###" /></strong> 원 -->
						<strong class="${last_bplc}_totalStlmPc"><fmt:formatNumber value="0" pattern="###,###" /></strong> 원
					</dd>
				</dl>
			</div>
		</div>
	</div>
	<%--금액정보 END --%>
	</c:if>


	<c:if test="${_mbrSession.recipterYn eq 'Y' || _mbrSession.prtcrRecipterYn eq 'Y'}">
		<div class="flex justify-end text-right mt-8.5 md:pr-6 lg:mt-11 space-x-1.5 md:space-x-2.5">
			<a href="${_marketPath}/gds/list" class="btn btn-large btn-outline-secondary xs-max:px-3">쇼핑 계속하기</a>
			<button type="button" class="btn btn-large btn-primary xs-max:px-3 f_ordr_R" data-bplc-unique="${last_bplc}" data-sel-ty="SEL" data-cart-ty="R">선택상품 주문하기</button>
			<button type="button" href="#" class="btn btn-large btn-danger xs-max:px-3 f_ordr_R" data-bplc-unique="${last_bplc}" data-sel-ty="ALL" data-cart-ty="R">전체상품 주문하기</button>
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
			<button type="button" class="btn btn-primary btn-small f_optn_chg" data-cart-grp="${cart.cartGrpNo}">변경</button>
		</div>
		<p class="order-item-price">
			<fmt:formatNumber value="${sumOrdrPc}" pattern="###,###" />
			원
		</p>
		<div class="order-item-info">
			<div class="payment">
				<!--<c:if test="${cart.cartTy eq 'R'}">
					<%-- 급여구매일 경우만 경우만 멤버스(사업소) 있음 --%>
					<c:if test="${!empty cart.bplcInfo}">
						<dl>
							<dt>멤버스</dt>
							<dd>${cart.bplcInfo.bplcNm }</dd>
						</dl>
					</c:if>
				</c:if>-->
				<dl>
					<dt>배송비</dt>
					<dd>
						<c:if test="${cart.gdsInfo.dlvyCtTy eq 'FREE'}">
	                                                	무료배송
	                                                	</c:if>
						<c:if test="${cart.gdsInfo.dlvyCtTy ne 'FREE'}">
	                                                	<fmt:formatNumber pattern="##,###" value="${cart.gdsInfo.dlvyBassAmt}" />원
	                                                	</c:if>
					</dd>
				</dl>
				<c:if test="${cart.gdsInfo.dlvyAditAmt > 0}">
					<dl>
						<dt>추가 배송비</dt>
						<dd><fmt:formatNumber pattern="##,###" value="${cart.gdsInfo.dlvyAditAmt}" />원</dd>
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
		<button class="btn btn-outline-primary md:px-8.5 f_delete_N" data-cart-ty="N" data-sel-ty="ALL">전체삭제</button>
		<button class="btn btn-outline-primary md:px-8.5 f_delete_N" data-cart-ty="N" data-sel-ty="SEL">선택상품 삭제</button>
	</div>

	<div class="order-amount mt-8 lg:mt-10">
		<div class="container">
			<div class="amount-section">
				<dl>
					<dt>상품금액</dt>
					<dd>
						<!-- <strong class="L_totalGdsPc"><fmt:formatNumber value="${totalOrdrPc}" pattern="###,###" /></strong> 원 -->
						<strong class="L_totalGdsPc"><fmt:formatNumber value="0" pattern="###,###" /></strong> 원
					</dd>
				</dl>
				<i class="is-plus">+</i>
				<dl>
					<dt>배송비</dt>
					<dd>
						<!-- <strong class="L_totalDlvyPc"><fmt:formatNumber value="${totalDlvyBassAmt}" pattern="###,###" /></strong> 원 -->
						<strong class="L_totalDlvyPc"><fmt:formatNumber value="0" pattern="###,###" /></strong> 원
					</dd>
				</dl>
			</div>
			<div class="amount-section">
				<i class="is-equal">=</i>
				<dl class="text-danger">
					<dt>총 결제예정금액</dt>
					<dd>
						<!-- <strong class="L_totalStlmPc"><fmt:formatNumber value="${totalOrdrPc + totalDlvyBassAmt}" pattern="###,###" /></strong> 원 -->
						<strong class="L_totalStlmPc"><fmt:formatNumber value="0" pattern="###,###" /></strong> 원
					</dd>
				</dl>
			</div>
		</div>
	</div>
	</c:if>

	<div class="flex justify-end text-right mt-8.5 md:pr-6 lg:mt-11 space-x-1.5 md:space-x-2.5">
		<a href="${_marketPath}/gds/list" class="btn btn-large btn-outline-secondary xs-max:px-3">쇼핑 계속하기</a>
		<button type="button" class="btn btn-large btn-primary xs-max:px-3 f_ordr_N" data-cart-ty="N" data-sel-ty="SEL">선택상품 주문하기</button>
		<button type="button" href="#" class="btn btn-large btn-danger xs-max:px-3 f_ordr_N" data-cart-ty="N" data-sel-ty="ALL">전체상품 주문하기</button>
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

<!-- 옵션변경 모달 -->
<div id="cart-optn-chg"></div>



<script>
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
		$(this).prop("checked",false);6
	});

	//(비급여) 전체선택
	let totalGdsPc = 0;
	let totalDlvyPc = 0;
	let totalStlmPc = 0;
	const nTotalCnt = $(":checkbox[name=cartGrpNo].cart_ty_N").length;
	$(".f_checkAll")	.on("click",function() {
		let isChecked = true;

		if (nTotalCnt == $(":checkbox[name=cartGrpNo].cart_ty_N:checked").length) {
			isChecked = false;
			totalGdsPc = 0;
			totalDlvyPc = 0;
			totalStlmPc = 0;
		} else {
			isChecked = true;
			$("input[name='L_gdsPc']").each(function(){totalGdsPc += Number($(this).val());});
			$("input[name='L_dlvyPc']").each(function(){totalDlvyPc += Number($(this).val());});
			$("input[name='L_stlmPc']").each(function(){totalStlmPc += Number($(this).val());});
		}

		$(":checkbox[name=cartGrpNo].cart_ty_N").prop("checked", isChecked);
		$(":checkbox[name=cartGrpNo].cart_ty_N").parents(".order-checkitem").find(".order-product").removeClass("is-active");
		$(":checkbox[name=cartGrpNo].cart_ty_N:checked").parents(".order-checkitem").find(".order-product").addClass("is-active");

		$(".L_totalGdsPc").text(comma(totalGdsPc));
		$(".L_totalDlvyPc").text(comma(totalDlvyPc));
		$(".L_totalStlmPc").text(comma(totalStlmPc));
	});




	//체크박스(비급여)
	$(".cart_ty_N")	.on("click",function() {
		let isChecked = $(this).is(":checked");
		let gdsPc = $(this).siblings("input[name='L_gdsPc']").val();
		let dlvyPc = $(this).siblings("input[name='L_dlvyPc']").val();
		let stlmPc = $(this).siblings("input[name='L_stlmPc']").val();

		$(this).prop("checked", isChecked);

		$(".cart_ty_R").each(function(){
			$(this).prop("checked",false);
		});

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
			/*let oriGdsPc = 0;
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
			});*/
			$(".L_totalGdsPc").text(0);
			$(".L_totalDlvyPc").text(0);
			$(".L_totalStlmPc").text(0);
		} else {
			$(".L_totalGdsPc").text(comma(totalGdsPc));
			$(".L_totalDlvyPc").text(comma(totalDlvyPc));
			$(".L_totalStlmPc").text(comma(totalStlmPc));
			}
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