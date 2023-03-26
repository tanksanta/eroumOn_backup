<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<main id="container">
	<jsp:include page="../../layout/page_header.jsp">
		<jsp:param value="주문결제" name="pageTitle" />
	</jsp:include>

	<div id="page-container">

		<jsp:include page="../../layout/page_sidenav.jsp" />

		<div id="page-content">
			<form:form name="frmOrdr" id="frmOrdr" modelAttribute="ordrVO" method="post" enctype="multipart/form-data" action="${_marketPath}/mypage/ordr/ordrPayAction">
				<form:hidden path="ordrTy" />
				<form:hidden path="ordrCd" />
				<form:hidden path="ordrNo" />

				<div class="order-status">
					<div class="status-base">
						<dl class="number">
							<dt>주문 번호</dt>
							<dd>${ordrVO.ordrCd }</dd>
						</dl>
						<dl>
							<dt>주문 일시</dt>
							<dd>
								<fmt:formatDate value="${ordrVO.ordrDt}" pattern="yyyy.MM.dd HH:mm:ss" />
							</dd>
						</dl>
					</div>
					<c:set var="ordrCancelBtn" value="false" />
					<c:set var="ordrConfirmBtn" value="false" />
					<c:set var="ordrConfirmCancelBtn" value="false" />
					<c:set var="ordrDvlyBtn" value="false" />
					<c:set var="ordrDoneBtn" value="false" />
					<c:set var="ordrDvlyDoneBtn" value="false" />

					<c:forEach items="${ordrVO.ordrDtlList}" var="ordrDtl" varStatus="status">

						<%-- 배송지 저장 버튼 : 주문 승인대기, 주문 승인완료, 결제대기, 결제완료, 배송준비중 --%>
						<c:if test="${ordrDtl.sttsTy eq 'OR01' || ordrDtl.sttsTy eq 'OR02' || ordrDtl.sttsTy eq 'OR04' || ordrDtl.sttsTy eq 'OR05'}">
							<c:set var="ordrDvlyBtn" value="true" />
						</c:if>

						<%-- 주문취소 : 결제완료, 주문승인대기, 주문승인완료료, 결제대기, 배송준비중 --%>
						<c:if test="${(ordrDtl.sttsTy eq 'OR01' || ordrDtl.sttsTy eq 'OR02' || ordrDtl.sttsTy eq 'OR04' || ordrDtl.sttsTy eq 'OR05' || ordrDtl.sttsTy eq 'OR06')}">
							<c:set var="ordrCancelBtn" value="true" />
						</c:if>

						<%--<c:if test="${ordrDtl.sttsTy eq 'OR01' || ordrDtl.sttsTy eq 'OR03'}">
							<c:set var="bplcDone" value="false" />
						</c:if> --%>
						<c:if test="${ordrDtl.sttsTy eq 'OR08'}">
							<c:set var="ordrDvlyDoneBtn" value="true" />
						</c:if>
					</c:forEach>


					<div class="text-right self-center mt-2 md:mt-0">
						<c:if test="${ordrDvlyDoneBtn}">
							<button type="button" class="btn btn-outline-primary w-30 md:w-36 f_ordr_return" data-ordr-cd="${ordrVO.ordrCd}">반품 신청</button>
						</c:if>
						<c:if test="${ordrCancelBtn}">
							<button type="button" class="btn btn-outline-primary w-30 md:w-36 f_ordr_rtrcn" data-ordr-cd="${ordrVO.ordrCd}" style="display: none;">주문 취소</button>
						</c:if>

					</div>
				</div>

				<h3 class="text-title mb-3 mt-8 md:mb-4 md:mt-10">상품 정보</h3>
				<div class="mb-9 space-y-6 md:mb-12 md:space-y-7.5">

					<c:set var="ordrCancelBtn" value="false" />
					<c:set var="ordrConfirmBtn" value="false" />
					<c:set var="ordrConfirmCancelBtn" value="false" />
					<c:set var="ordrDvlyBtn" value="false" />
					<c:set var="ordrDoneBtn" value="false" />

					<c:set var="ordrReturnInfo" value="false" />

					<!--<c:set var="bplcDone" value="true" />-->
					<%--멤버스 승인완료 --%>
					<c:set var="bplcDone" value="F" />

					<c:set var="totalDlvyBassAmt" value="0" />
					<c:set var="totalCouponAmt" value="0" />
					<c:set var="totalAccmlMlg" value="0" />
					<c:set var="totalOrdrPc" value="0" />
					<c:set var="dtlIndex" value="0" />
					<c:set var="recipterConfirmYn" value="" />

					<%-- 상품금액 --%>
					<c:set var="sumGdsPc" value="0" />
					<%-- 총 상품금액 --%>
					<c:set var="totalGdsPc" value="0" />

					<c:forEach items="${ordrVO.ordrDtlList}" var="ordrDtl" varStatus="status">

						<c:set var="spOrdrOptn" value="${fn:split(ordrDtl.ordrOptn, '*')}" />

						<c:if test="${ordrDtl.ordrOptnTy eq 'BASE'}">
							<c:set var="sumOrdrPc" value="${ordrDtl.ordrPc }" />
							<c:set var="totalGdsPc" value="${ordrDtl.gdsPc * ordrDtl.ordrQy}" />
							<c:set var="sumGdsPc" value="${totalGdsPc + sumGdsPc}" />

							<div class="order-product">

								<div class="order-header">
									<dl>
										<dt>주문번호</dt>
										<dd>
											<strong>${ordrDtl.ordrDtlCd}</strong>
										</dd>
									</dl>
									<c:if test="${ordrDtl.sttsTy eq 'CA02'}">
										<dl>
											<dt>취소일시</dt>
											<dd>
												<fmt:formatDate value="${ordrDtl.mdfcnDt}" pattern="yyyy.MM.dd HH:mm:ss" />
											</dd>
										</dl>
									</c:if>
								</div>

								<div class="order-body">

									<c:if test="${!empty ordrDtl.recipterUniqueId }">
										<%-- 베네핏 바이어 --%>
										<div class="order-buyer">
											<c:if test="${_mbrSession.uniqueId ne ordrDtl.regUniqueId}">
												<c:if test="${!empty ordrDtl.mbrVO.proflImg}">
													<img src="/comm/proflImg?fileName=${ordrDtl.recipterInfo.proflImg}" alt="">
												</c:if>
												<strong>${ordrDtl.recipterInfo.mbrNm}</strong>
											</c:if>
										</div>
									</c:if>

									<div class="order-item">
										<div class="order-item-thumb">
											<c:choose>
												<c:when test="${!empty ordrDtl.gdsInfo.thumbnailFile }">
													<img src="/comm/getImage?srvcId=GDS&amp;upNo=${ordrDtl.gdsInfo.thumbnailFile.upNo }&amp;fileTy=${ordrDtl.gdsInfo.thumbnailFile.fileTy }&amp;fileNo=${ordrDtl.gdsInfo.thumbnailFile.fileNo }&amp;thumbYn=Y" alt="">
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
														<span class="label-primary"> <span>${gdsTyCode[ordrDtl.gdsInfo.gdsTy]}</span> <i></i>
														</span> <u>${ordrDtl.gdsInfo.gdsCd }</u>
													</p>
													<div class="product">
														<p class="name">${ordrDtl.gdsInfo.gdsNm }</p>
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

						<c:if test="${ordrDtl.ordrOptnTy eq 'ADIT'}">
							<c:set var="sumOrdrPc" value="${sumOrdrPc + ordrDtl.ordrPc}" />
							<%-- sumOrdrPc : ${sumOrdrPc} / ${ordrDtl.ordrPc} --%>
							<c:set var="totalGdsPc" value="${totalGdsPc + (ordrDtl.ordrOptnPc * ordrDtl.ordrQy) }" />
							<c:set var="sumGdsPc" value="${(ordrDtl.ordrOptnPc * ordrDtl.ordrQy) + sumGdsPc}" />

							<div class="order-item-add">
								<span class="label-outline-primary"> <span>${spOrdrOptn[0]}</span> <i><img src="/html/page/market/assets/images/ico-plus-white.svg" alt=""></i>
								</span>
								<div class="name">
									<p>
										<strong>${spOrdrOptn[1]}</strong>
									</p>
									<p>
										수량 ${ordrDtl.ordrQy}개 (+
										<fmt:formatNumber value="${ordrDtl.ordrPc}" pattern="###,###" />
										원)
									</p>
								</div>
							</div>

						</c:if>

						<c:if test="${ordrVO.ordrDtlList[status.index+1].ordrOptnTy eq 'BASE' || status.last}">
				</div>

				<div class="order-item-count">
					<p>
						<strong>${ordrDtl.ordrQy}</strong>개
					</p>
					<%-- 배송 준비전 or 주문승인대기 --%>
					<c:if test="${ordrDtl.sttsTy eq 'OR01' || ordrDtl.sttsTy eq 'OR04'}">
						<button type="button" class="btn btn-primary btn-small f_optn_chg" data-gds-no="${ordrDtl.gdsNo}" data-dtl-no="${ordrDtl.ordrDtlNo}" data-dtl-cd="${ordrDtl.ordrDtlCd}">변경</button>
					</c:if>
				</div>
				<p class="order-item-price">
					<span class="text-primary"><fmt:formatNumber value="${totalGdsPc}" pattern="###,###" />원</span>
				</p>

				<div class="order-item-info">
					<div class="payment">
						<c:if test="${ordrVO.ordrTy eq 'R' || ordrVO.ordrTy eq 'L'}">
							<%-- 급여구매일 경우만 경우만 멤버스(사업소) 있음 --%>
							<%-- 멤버스 --%>
							<c:if test="${!empty ordrDtl.bplcInfo}">
								<dl>
									<dt>멤버스</dt>
									<dd>${ordrDtl.bplcInfo.bplcNm}</dd>
								</dl>
							</c:if>
						</c:if>
						<dl>
							<dt>배송비</dt>
							<dd>
								<c:if test="${ordrDtl.gdsInfo.dlvyCtTy eq 'FREE'}">
                                                	무료배송
                                                	</c:if>
								<c:if test="${ordrDtl.gdsInfo.dlvyCtTy ne 'FREE'}">
                                                	${ordrDtl.gdsInfo.dlvyBassAmt}원
                                                	</c:if>
							</dd>
						</dl>
						<c:if test="${ordrDtl.gdsInfo.dlvyAditAmt > 0}">
							<dl>
								<dt>추가 배송비</dt>
								<dd>${ordrDtl.gdsInfo.dlvyAditAmt}원</dd>
							</dl>
						</c:if>
					</div>
					<div class="status">
						<%-- TO-DO : 주문상태에 따라 다름 --%>
						<c:choose>
							<c:when test="${ordrDtl.sttsTy eq 'OR02'}">
								<%-- 멤버스 승인완료 --%>
								<div class="box-gradient">
									<div class="content">
										<p class="flex-1">
											멤버스<br> 승인완료
										</p>
										<div class="multibtn">
											<!-- <a href="./${ordrDtl.ordrCd}?${pageParam}" class="btn btn-primary btn-small">결제진행</a> -->
											<a href="#payment-start" class="btn btn-primary btn-small">결제진행</a>
											<%-- <button type="button" class="btn btn-outline-primary btn-small f_ordr_rtrcn" data-ordr-cd="${ordrDtl.ordrCd}">주문취소</button> --%>
										</div>
									</div>
								</div>
							</c:when>
							<c:when test="${ordrDtl.sttsTy eq 'OR03'}">
								<%-- 멤버스 승인반려 --%>
								<div class="box-gradient">
									<div class="content">
										<p class="flex-1">
											멤버스<br> 승인반려
										</p>
										<div class="multibtn">
											<button type="button" class="btn btn-primary btn-small f_partners_msg" data-ordr-no="${ordrDtl.ordrNo}" data-dtl-no="${ordrDtl.ordrDtlNo}">사유확인</button>
										</div>
									</div>
								</div>
							</c:when>
							<c:when test="${ordrDtl.sttsTy eq 'OR04'}">
								<%-- 결제대기 --%>
								<div class="box-gray">
									<p class="flex-1">결제대기</p>
								</div>
							</c:when>
							<c:when test="${ordrDtl.sttsTy eq 'OR05'}">
								<%-- 결제완료 --%>
								<div class="box-gray">
									<p class="flex-1">결제완료</p>
								</div>
							</c:when>
							<c:when test="${ordrDtl.sttsTy eq 'OR07'}">
								<dl>
									<dt>배송중</dt>
									<dd>
										<fmt:formatDate value="${ordrDtl.sndngDt}" pattern="yyyy-MM-dd" />
									</dd>
								</dl>
								<c:set var="dlvyUrl" value="#" />
								<c:forEach items="${dlvyCoList}" var="dlvyCoInfo" varStatus="status">
									<c:if test="${dlvyCoInfo.coNo eq ordrDtl.dlvyCoNo}">
										<c:set var="dlvyUrl" value="${dlvyCoInfo.dlvyUrl}" />
									</c:if>
								</c:forEach>

								<a href="${dlvyUrl}${ordrDtl.dlvyInvcNo}" target="_blank" class="btn btn-delivery"> <span class="name"> <img src="/html/page/market/assets/images/ico-delivery.svg" alt=""> ${ordrDtl.dlvyCoNm}
								</span> <span class="underline">${ordrDtl.dlvyInvcNo}</span>
								</a>
							</c:when>
							<c:when test="${ordrDtl.sttsTy eq 'OR08'}">
								<%-- 배송완료 --%>
								<div class="box-gray">
									<p class="flex-1">배송완료</p>
									<div class="multibtn">
										<button type="button" class="btn btn-primary btn-small f_ordr_done" data-ordr-no="${ordrDtl.ordrNo}" data-dtl-cd="${ordrDtl.ordrDtlCd}" data-stts-ty="OR09" data-resn-ty="" , data-resn="상품 구매확정" data-msg="마일리지가 적립됩니다.구매확정 처리하시겠습니까?">구매확정</button>
										<button type="button" class="btn btn-outline-primary btn-small f_gds_exchng" data-dtl-cd="${ordrDtl.ordrDtlCd}" data-ordr-no="${ordrDtl.ordrNo}">교환신청</button>
									</div>
								</div>
							</c:when>
							<c:when test="${ordrDtl.sttsTy eq 'CA01' || ordrDtl.sttsTy eq 'CA02'}">
								<%-- 취소접수 & 취소완료 --%>
								<div class="box-gray">
									<p class="flex-1">${ordrSttsCode[ordrDtl.sttsTy]}</p>
									<div class="multibtn">
										<button type="button" class="btn btn-primary btn-small f_rtrcn_msg" data-ordr-no="${ordrDtl.ordrNo}" data-dtl-no="${ordrDtl.ordrDtlNo}" data-dtl-cd="${ordrDtl.ordrDtlCd}">취소 상세정보</button>
									</div>
								</div>
							</c:when>
							<c:when test="${ordrDtl.sttsTy eq 'EX01' || ordrDtl.sttsTy eq 'EX02' || ordrDtl.sttsTy eq 'EX03'}">
								<%-- 교환 --%>
								<div class="box-gray">
									<p class="flex-1">${ordrSttsCode[ordrDtl.sttsTy]}</p>
									<div class="multibtn">
										<button type="button" class="btn btn-primary btn-small f_exchng_msg" data-ordr-no="${ordrDtl.ordrNo}" data-dtl-no="${ordrDtl.ordrDtlNo}" data-dtl-cd="${ordrDtl.ordrDtlCd}">교환 상세정보</button>
									</div>
								</div>
							</c:when>
							<c:when test="${ordrDtl.sttsTy eq 'RE01' || ordrDtl.sttsTy eq 'RE02' || ordrDtl.sttsTy eq 'RE03'}">
								<%-- 반품 --%>
								<div class="box-gray">
									<p class="flex-1">${ordrSttsCode[ordrDtl.sttsTy]}</p>
									<div class="multibtn">
										<button type="button" class="btn btn-primary btn-small f_return_msg" data-ordr-no="${ordrDtl.ordrNo}" data-dtl-no="${ordrDtl.ordrDtlNo}" data-dtl-cd="${ordrDtl.ordrDtlCd}">반품 상세정보</button>
									</div>
								</div>
							</c:when>
							<c:otherwise>
								<div class="box-gray">
									<p class="flex-1">${ordrSttsCode[ordrDtl.sttsTy]}</p>
								</div>
							</c:otherwise>
						</c:choose>
					</div>
				</div>
		</div>
	</div>
	</div>
	</div>

	</c:if>

	<%-- 배송비 + 추가배송비 --%>
	<c:set var="totalDlvyBassAmt" value="${totalDlvyBassAmt + (ordrDtl.ordrOptnTy eq 'BASE'?(ordrDtl.gdsInfo.dlvyBassAmt + ordrDtl.gdsInfo.dlvyAditAmt):0)}" />

	<c:if test="${ordrDtl.gdsInfo.mlgPvsnYn eq 'Y' && (ordrDtl.sttsTy ne 'CA01' && ordrDtl.sttsTy ne 'CA02' && ordrDtl.sttsTy ne 'EX03')}">
		<%-- 적립예정마일리지 --%>
		<c:set var="totalAccmlMlg" value="${totalAccmlMlg + ordrDtl.accmlMlg}" />
	</c:if>

	<%-- 주문금액 + 옵션금액 --%>
	<c:if test="${ordrDtl.sttsTy ne 'CA02' && ordrDtl.sttsTy ne 'EX03' && ordrDtl.sttsTy ne 'OR03'}">
		<c:set var="totalOrdrPc" value="${totalOrdrPc + ordrDtl.ordrPc}" />
	</c:if>

	<%-- 쿠폰 할인 금액--%>
	<c:set var="totalCouponAmt" value="${totalCouponAmt + ordrDtl.couponAmt}" />
	<%-- 적립 마일리지 --%>

	<%-- 배송지 저장 버튼 : 주문 승인대기, 주문 승인완료, 결제대기, 결제완료 --%>
	<c:if test="${ordrDtl.sttsTy eq 'OR01' || ordrDtl.sttsTy eq 'OR02' || ordrDtl.sttsTy eq 'OR04' || ordrDtl.sttsTy eq 'OR05'}">
		<c:set var="ordrDvlyBtn" value="true" />
	</c:if>

	<%-- 주문취소 : 결제완료, 주문승인대기, 주문승인완료료, 결제대기--%>
	<c:if test="${(ordrDtl.sttsTy eq 'OR01' || ordrDtl.sttsTy eq 'OR02' || ordrDtl.sttsTy eq 'OR04' || ordrDtl.sttsTy eq 'OR05')}">
		<c:set var="ordrCancelBtn" value="true" />
	</c:if>

	<%-- 반품완료/취소완료 건이 있으면 환불정보 노출 --%>
	<c:if test="${(ordrDtl.sttsTy eq 'RE03' || ordrDtl.sttsTy eq 'CA02') && !empty ordrVO.stlmTy}">
		<c:set var="ordrReturnInfo" value="true" />
		<c:set var="rfndBank" value="${ordrDtl.rfndBank}" />
		<c:set var="rfndActno" value="${ordrDtl.rfndActno}" />
		<c:set var="rfndDpstr" value="${ordrDtl.rfndDpstr}" />
	</c:if>

	<c:choose>
		<c:when test="${ordrDtl.sttsTy eq 'OR01' }">
			<c:set var="bplcDone" value="N" />
		</c:when>
		<c:when test="${bplcDone ne 'N' && ordrDtl.sttsTy eq 'OR02'}">
			<c:set var="bplcDone" value="T" />
		</c:when>
	</c:choose>

	</c:forEach>

	</div>


	<c:if test="${ordrReturnInfo && (!empty rfndBank && ordrVO.stlmTy eq 'VBANK')}">
		<h3 class="text-title mt-18 mb-3 md:mb-4 md:mt-23">환불 계좌 정보</h3>
		<div class="payment-refund">
			<dl class="refund-method">
				<dt>환불 방식</dt>
				<dd>${bassStlmTyCode[ordrVO.stlmTy]}</dd>
			</dl>
			<dl class="refund-account">
				<c:if test="${ordrVO.stlmTy eq 'CARD'}">
					<dt>환불 정보</dt>
					<dd>
						<p class="bank"></p>
						<p class="code">${ordrVO.cardCoNm} 결제 취소</p>
						<p class="name"></p>
					</dd>
				</c:if>
				<c:if test="${ordrVO.stlmTy eq 'VBANK'}">
					<dt>환불 정보</dt>
					<dd>
						<p class="bank">${bankTyCode[rfndBank]}</p>
						<p class="code">${rfndActno}</p>
						<p class="name">${rfndDpstr}</p>
					</dd>
				</c:if>
				<c:if test="${ordrVO.stlmTy eq 'BANK'}">
					<dt>환불 정보</dt>
					<dd>
						<p class="bank">${ordrVO.dpstBankNm}</p>
						<p class="code"></p>
						<p class="name"></p>
					</dd>
				</c:if>

			</dl>
		</div>
	</c:if>

	<!-- 결제 정보  -->
	<c:if test="${fn:indexOf(_curPath,'/mypage/ordr/view/') ne -1}">
		<c:if test="${(bplcDone eq 'T' && (ordrReturnInfo || ordrVO.stlmAmt > 0)) || (ordrVO.stlmTy eq 'FREE') }">
	</c:if>
		<h3 class="text-title mt-18 mb-3 md:mb-4 md:mt-23">결제 정보</h3>
		<div class="payment-amount">
			<div class="amount-section">
				<dl class="price">
					<dt>총 주문금액</dt>
					<dd>
						<strong><fmt:formatNumber value="${sumGdsPc + totalDlvyBassAmt}" pattern="###,###" /></strong> 원
					</dd>
				</dl>
				<div class="detail">
					<dl>
						<dt>상품금액</dt>
						<dd>
							<strong><fmt:formatNumber value="${sumGdsPc}" pattern="###,###" /></strong> 원
						</dd>
					</dl>
					<dl>
						<dt>배송비</dt>
						<dd>
							<strong><fmt:formatNumber value="${totalDlvyBassAmt}" pattern="###,###" /></strong> 원
						</dd>
					</dl>
				</div>
			</div>
			<!--<i class="amount-calculator is-plus">+</i> -->
			<i class="amount-calculator is-minus">-</i>
			<div class="amount-section">
				<dl class="price">
					<dt>총 할인금액</dt>
					<dd>
						<strong><fmt:formatNumber value="${totalCouponAmt + ordrVO.useMlg + ordrVO.usePoint}" pattern="###,###" /></strong> 원
					</dd>
				</dl>
				<div class="detail">
					<dl>
						<dt>쿠폰할인</dt>
						<dd>
							<strong><fmt:formatNumber value="${totalCouponAmt}" pattern="###,###" /></strong> 원
						</dd>
					</dl>
					<dl>
						<dt>마일리지 사용</dt>
						<dd>
							<strong><fmt:formatNumber value="${ordrVO.useMlg }" pattern="###,###" /></strong> 원
						</dd>
					</dl>
					<dl>
						<dt>포인트 사용</dt>
						<dd>
							<strong><fmt:formatNumber value="${ordrVO.usePoint }" pattern="###,###" /></strong> 원
						</dd>
					</dl>
				</div>
			</div>
			<i class="amount-calculator is-equal">=</i>
			<div class="amount-section is-latest">
				<dl class="price">
					<dt>총 결제금액</dt>
					<dd>
						<strong><fmt:formatNumber value="${sumGdsPc + totalDlvyBassAmt - (totalCouponAmt + ordrVO.useMlg + ordrVO.usePoint)}" pattern="###,###" /></strong> 원
					</dd>
				</dl>
				<div class="detail">
					<dl>
						<dt>결제 방법</dt>
						<dd>
							<strong>${bassStlmTyCode[ordrVO.stlmTy]}</strong>
						</dd>
					</dl>
					<p class="mt-1 mb-2.5 lg:mt-1.5 lg:mb-3 leading-tight text-right font-normal">
						<c:choose>
							<c:when test="${ordrVO.stlmTy eq 'CARD'}">
	                           		승인번호 : ${ordrVO.cardAprvno}<br>
	                           		${ordrVO.cardCoNm}&nbsp;${ordrVO.cardNo}
	                           		</c:when>
							<c:when test="${ordrVO.stlmTy eq 'VBANK'}">
										[${ordrVO.dpstBankNm}] ${ordrVO.vrActno}<br>
										예금주 : ${ordrVO.dpstr}<br>
								<c:if test="${ordrVO.stlmYn eq 'N'}">
										결제만료일 : ${fn:substring(ordrVO.dpstTermDt, 0, 16)}<br>
								</c:if>
										결제자명 : ${ordrVO.pyrNm}
	                           		</c:when>
							<c:when test="${ordrVO.stlmTy eq 'BANK'}">
	                           			${ordrVO.dpstBankNm}
	                           		</c:when>
							<c:when test="${ordrVO.stlmTy eq 'REBILL'}">
								<%-- 승인번호 : ${ordrVO.cardAprvno}<br> --%>
		                           		${ordrVO.cardCoNm}&nbsp;${ordrVO.cardNo}
	                           		</c:when>
							<c:when test="${ordrVO.stlmTy eq 'FREE'}">
	                           			결제금액 없음
	                           		</c:when>
							<c:otherwise>
	                           		신용카드 > ${bassStlmTyCode[ordrVO.stlmTy]}
	                           		</c:otherwise>
						</c:choose>
					</p>
					<dl>
						<dt>결제 일시</dt>
						<dd>${ordrVO.stlmDt}<br>
							<c:if test="${ordrVO.stlmYn eq 'Y' }">
								<strong class="text-red3">결제완료</strong>
							</c:if>

							<c:if test="${ordrVO.stlmYn eq 'N' }">
								<strong class="text-red3">결제대기</strong>
							</c:if>
						</dd>
					</dl>
				</div>
			</div>
			<c:if test="${totalAccmlMlg >0}">
				<dl class="amount-mileage">
					<dt>
						적립예정<br> 마일리지
					</dt>
					<dd>
						<p class="point">
							<fmt:formatNumber value="${totalAccmlMlg}" pattern="###,###" />
						</p>
						<p class="desc">구매확정 시 적립됩니다</p>
					</dd>
				</dl>
			</c:if>
		</div>
		<p class="text-alert mt-2.5 md:mt-3.5">
			<strong>무통장 입금</strong>으로 주문하신 경우, 입금 기한까지 입금하지 않으시면 주문이 자동으로 취소되오니 입금 기한까지 꼭 입금을 해주시기 바랍니다.
		</p>
	<c:if test="${fn:indexOf(_curPath,'/mypage/ordr/view/') ne -1}">
		</c:if>
	</c:if>

	<div class="md:flex md:space-x-6 lg:space-x-7.5" id="payment-start">
		<div class="flex-1 mt-18 md:mt-23">
			<h3 class="text-title mb-3 md:mb-4">배송지 정보</h3>
			<div class="payment-shipping">
				<dl class="shipping-name">
					<dt>받는사람</dt>
					<dd id="nwNm">${ordrVO.recptrNm}</dd>
				</dl>
				<dl class="shipping-call">
					<dt>연락처</dt>
					<dd>
						<p>
							<a href="tel:${ordrVO.recptrMblTelno}" id="nwMblTelno">${ordrVO.recptrMblTelno}</a>
						</p>
						<c:if test="${!empty ordrVO.recptrTelno}">
							<p class="text-lg">
								<a href="tel:${ordrVO.recptrTelno}" id="nwTelno">${ordrVO.recptrTelno}</a>
							</p>
						</c:if>
					</dd>
				</dl>
				<dl class="shipping-addr">
					<dt>주소</dt>
					<dd>
						<p id="nwZip">${ordrVO.recptrZip}</p>
						<p class="text-lg" id="nwAddr">${ordrVO.recptrAddr}</p>
						<div class="text-lg" id="nwDaddr">${ordrVO.recptrDaddr}</div>
					</dd>
				</dl>
				<dl class="shipping-msgs">
					<dt>배송메시지</dt>
					<dd id="nwMemo">${ordrVO.ordrrMemo}</dd>
				</dl>
				<c:if test="${ordrDvlyBtn}">
					<c:if test="${ordrVO.ordrTy eq 'N'}">
						<div class="mt-2.5 text-right">
							<button type="button" class="btn btn-primary btn-small" id="dlvyMngBtn" data-ordr-cd="${ordrVO.ordrCd}">배송지 정보 수정</button>
						</div>
					</c:if>
				</c:if>
			</div>
		</div>
		<div class="flex-1 mt-18 md:mt-23">
			<h3 class="text-title mb-3 md:mb-4">고객 정보</h3>
			<c:choose>
				<c:when test="${_mbrSession.mberGrade eq 'P'}">
					<div class="payment-customer customer-grade1">
				</c:when>
				<c:when test="${_mbrSession.mberGrade eq 'V'}">
					<div class="payment-customer customer-grade2">
				</c:when>
				<c:when test="${_mbrSession.mberGrade eq 'G'}">
					<div class="payment-customer customer-grade3">
				</c:when>
				<c:when test="${_mbrSession.mberGrade eq 'S'}">
					<div class="payment-customer customer-grade5">
				</c:when>
				<c:when test="${_mbrSession.mberGrade eq 'R'}">
					<div class="payment-customer customer-grade4">
				</c:when>
				<c:otherwise>
					<div class="payment-customer customer-grade4">
				</c:otherwise>
			</c:choose>
			<dl>
				<dt>이름</dt>
				<dd>${ordrVO.ordrrNm}</dd>
			</dl>
			<dl>
				<dt>휴대폰번호</dt>
				<dd>${ordrVO.ordrrMblTelno}</dd>
			</dl>
			<dl>
				<dt>이메일주소</dt>
				<dd>${ordrVO.ordrrEml}</dd>
			</dl>
		</div>
	</div>
	</div>


	<%-- 결제대기 : 급여상품 + 멤버스 승인/반려 완료 --%>
	<c:if test="${(ordrVO.ordrTy eq 'R' || ordrVO.ordrTy eq 'L' ) && bplcDone eq 'T' && (ordrVO.stlmYn eq 'N' && totalOrdrPc >= 0)}">
		<h3 class="text-title mt-18 mb-3 md:mb-4 md:mt-23">최종 결제금액 확인</h3>
		<div class="payment-result">
			<div class="result-price">
				<div class="container">
					<dl>
						<dt>총 주문상품금액</dt>
						<dd>
							<strong><fmt:formatNumber value="${totalOrdrPc}" pattern="###,###" /></strong> 원
						</dd>
					</dl>
					<%--비급여 상품일 경우만.. --%>
					<c:if test="${ordrVO.ordrTy eq 'N'}">
						<dl>
							<dt>쿠폰</dt>
							<dd>
								<strong class="text-danger total-coupon-txt">0</strong> 원
							</dd>
						</dl>
						<dl>
							<dt>마일리지/포인트</dt>
							<dd>
								<strong class="text-danger total-mlg-txt">0</strong> 원
							</dd>
						</dl>
					</c:if>
					<dl>
						<dt>배송비</dt>
						<dd>
							<strong class="total-dlvy-txt"><fmt:formatNumber value="${totalDlvyBassAmt}" pattern="###,###" /></strong> 원
						</dd>
					</dl>
				</div>
				<dl class="last">
					<dt>최종 결제금액</dt>
					<dd>
						<strong class="total-stlmAmt-txt"><fmt:formatNumber value="${totalOrdrPc + totalDlvyBassAmt}" pattern="###,###" /></strong> 원
					</dd>
				</dl>
			</div>
			<div class="result-agree">
				<dl>
					<dt>구매자 동의</dt>
					<dd>
						주문할 상품의 상품명, 상품가격, 배송정보를 확인하였으며, 구매에 동의 하시겠습니까?<br> (전자상거래법 제 8조 2항)
					</dd>
				</dl>
				<div class="form-check">
					<input class="form-check-input" type="checkbox" id="buyAgree" name="buyAgree" value="Y"> <label class="form-check-label" for="buyAgree">동의 합니다.</label>
				</div>
				<c:if test="${ordrVO.ordrDtlList[0].buyBtn > 0}">
					<button type="button" class="btn btn-payment btn-large" onclick="alert('취소 진행건이 있습니다. 취소완료 후 결제 가능합니다.'); return false;">결제하기</button>
				</c:if>
				<c:if test="${ordrVO.ordrDtlList[0].buyBtn < 1}">
					<button type="submit" class="btn btn-payment btn-large">결제하기</button>
				</c:if>
			</div>
		</div>
	</c:if>


	<form:hidden path="delngNo" />
	<form:hidden path="stlmYn" value="N" />
	<form:hidden path="stlmAmt" value="${totalOrdrPc + totalDlvyBassAmt}" />
	<%-- 상품금액+옵션+배송 > TO-DO 쿠폰&마일리지&포인트 작업 필요 --%>
	<form:hidden path="stlmTy" />
	<form:hidden path="stlmDt" />
	<form:hidden path="cardAprvno" />
	<form:hidden path="cardCoNm" />
	<form:hidden path="cardNo" />

	<form:hidden path="vrActno" />
	<form:hidden path="dpstBankCd" />
	<form:hidden path="dpstBankNm" />
	<form:hidden path="dpstr" />
	<form:hidden path="pyrNm" />
	<form:hidden path="dpstTermDt" />

	</form:form>

	<div class="mt-24 text-center md:mt-31">
		<c:set var="pageParam" value="curPage=${param.curPage}&amp;srchOrdrYmdBgng=${param.srchOrdrYmdBgng}&amp;srchOrdrYmdEnd=${param.srchOrdrYmdEnd}&amp;selPeriod=${param.selPeriod}" />
		<a href="../list?${pageParam}" class="btn btn-primary btn-large">주문/배송 조회 목록으로</a>
	</div>

	</div>

	</div>

	<!-- 배송지 -->
	<div id="dlvyView"></div>
	<!-- //배송지 -->

	<!-- 수량변경 -->
	<div id="ordr-optn-chg"></div>
	<!-- //수량변경 -->

	<!-- 주문취소 -->
	<div id="ordr-rtrcn"></div>
	<!-- //주문취소 -->

	<!-- 멤버스 반려 -->
	<div id="ordr-partners-msg"></div>
	<!-- //멤버스 반려 -->

	<!-- 교환신청 -->
	<div id="ordr-exchng"></div>
	<!-- //교환신청 -->

	<!-- 반품신청 -->
	<div id="ordr-return"></div>
	<!-- //반품신청 -->

	<!-- 취소/교환/반품 사유 -->
	<div id="ordr-rtrcn-msg"></div>
	<div id="ordr-exchng-msg"></div>
	<div id="ordr-return-msg"></div>


	<!-- 쿠폰사용 -->
	<div id="use-coupon"></div>
	<!-- //쿠폰사용 -->

	<!-- 포인트사용 -->
	<div id="use-point"></div>
	<!-- //포인트사용 -->

	<!-- 마일리지사용 -->
	<div id="use-mlg"></div>
	<!-- //마일리지사용 -->

</main>


<script>

    function f_calStlmAmt(){
    	let stlmAmt = 0; $("input[name='ordrPc']").each(function(){ stlmAmt += Number($(this).val()) });
    	let dlvyBassAmt = 0; $("input[name='dlvyBassAmt']").each(function(){ dlvyBassAmt += Number($(this).val()) });
    	let dlvyAditAmt = 0; $("input[name='dlvyAditAmt']").each(function(){ dlvyAditAmt += Number($(this).val()) });
    	let useMlg = $("#frmOrdr #useMlg").val();
    	let usePoint = $("#frmOrdr #usePoint").val();
    	let totalCouponAmt = $("#frmOrdr #usePoint").val();
    	let calStlmAmt = 0;

    	calStlmAmt = (Number(stlmAmt) + Number(dlvyBassAmt) + Number(dlvyAditAmt)) - Number(useMlg) - Number(usePoint) - Number(totalCouponAmt);


    	$("input[name='mbrMlg']").remove();
    	mlgMap.forEach(function(value, key){
    		let v = key +"|"+ value;
    		$("#frmOrdr").append('<input type="hidden" name="mbrMlg" value="'+ v +'" >'); // 회원마일리지
    	})

    	$("#frmOrdr #stlmAmt").val(calStlmAmt);
    	$("#frmOrdr .total-stlmAmt-txt").text(comma(calStlmAmt));
    }

    async function f_pay(frm){
    	let stlmAmt = $("#stlmAmt").val(); //쿠폰, 마일리지, 포인트 추가 작업 필요

    	if(stlmAmt > 0){


    	//async
    	<c:choose>
    		<c:when test="${ordrVO.ordrTy eq 'L'}">
    		Bootpay.requestSubscription({
    		    application_id: "${_bootpayScriptKey}",
    		    pg: '이니시스',
    		    price: stlmAmt,
    		    tax_free: 0,
    		    <c:choose>
	    			<c:when test="${ordrVO.ordrDtlList.size()>1}">
	    			"order_name": "${ordrVO.ordrDtlList[0].gdsInfo.gdsNm} 외 ${ordrDtlList.size()-1}건",
	    			</c:when>
	    			<c:otherwise>
	    			"order_name": "${ordrVO.ordrDtlList[0].gdsInfo.gdsNm}",
	    			</c:otherwise>
	    		</c:choose>
    		    subscription_id: "${ordrVO.ordrCd}",
    		    user: {
   	    		    "username": "${_mbrSession.mbrNm}",
   	    		    "phone": "${_mbrSession.mblTelno}",
   	    		    "email": "${_mbrSession.eml}"
   	    		},
    		    extra: {
    		        subscription_comment: '매월 '+ stlmAmt +'원이 결제됩니다',
    		        subscribe_test_payment: true
    		    }
    		}).then(
    		    function (response) {
    		        if (response.event === 'done') {
    		        	const stlmDt = response.data.receipt_data.purchased_at;
						const delngNo = response.data.receipt_id; // : 거래번호 => DELNG_NO
						const stlmTy = "REBILL";

			            const cardAprvno = response.data.receipt_data.card_data.card_approve_no; //카드 승인번호 => CARD_APRVNO
			            const cardCoNm = response.data.receipt_data.card_data.card_company; //카드회사 => CARD_CO_NM
			            const cardNo = response.data.receipt_data.card_data.card_no; //카드번호 => CARD_NO

						$("#delngNo").val(delngNo);
			            $("#stlmTy").val(stlmTy);
			            $("#stlmDt").val(stlmDt);
		            	$("#stlmYn").val("N");

			            $("#cardAprvno").val(cardAprvno);
			            $("#cardCoNm").val(cardCoNm);
			            $("#cardNo").val(cardNo);

    		        	frm.submit();
    		        }
    		    },
    		    function (error) {
    		        console.log(error.message)
    		    }
    		)
    		</c:when>
    		<c:otherwise>
    	try {
   	    	//결제요청
   	    	<c:set var="gdsCnt" value="0" />
   	    	<c:forEach items="${ordrVO.ordrDtlList}" var="ordrDtl" varStatus="status">
				<c:if test="${ordrDtl.sttsTy ne 'CA02'}">
				<c:set var="gdsCnt" value="${gdsCnt+1}" />
				</c:if>
			</c:forEach>
   	    	const response = await Bootpay.requestPayment({
   	    		  "application_id": "${_bootpayScriptKey}",
   	    		  "price": stlmAmt,
   	    		  <c:if test="${gdsCnt>1}">
				  "order_name": "${ordrVO.ordrDtlList[0].gdsInfo.gdsNm} 외 ${gdsCnt-1}건",
				  </c:if>
				  <c:if test="${gdsCnt<2}">
				  "order_name": "${ordrVO.ordrDtlList[0].gdsInfo.gdsNm}",
				  </c:if>
   	    		  "order_id": "${ordrVO.ordrCd}",
   	    		  "pg": "이니시스",
   	    		  "method": "",
   	    		  "tax_free": 0,
   	    		  "user": {
   	    		    "id": "${_mbrSession.mbrId}",
   	    		    "username": "${_mbrSession.mbrNm}",
   	    		    "phone": "${_mbrSession.mblTelno}",
   	    		    "email": "${_mbrSession.eml}"
   	    		  },
   	    		  /*
   	    		  "items": [
					<c:forEach items="${ordrVO.ordrDtlList}" var="ordrDtl" varStatus="status">
					<c:if test="${ordrDtl.sttsTy ne 'CA02'}">
   	    		    {
   	    		      "id": "${ordrDtl.gdsInfo.gdsCd}",
   	    		      "name": "${ordrDtl.gdsInfo.gdsNm}",
   	    		      "qty": ${ordrDtl.ordrQy},
   	    		      "price": ${ordrDtl.gdsPc + ordrDtl.ordrOptnPc}
   	    		    }
   	    		    </c:if>
   	    		    <c:if test="${!status.last}">,</c:if>
   	    		    </c:forEach>
   	    		  ], */
   	    		  "extra": {
   	    		    "open_type": "iframe",
   	    		    //"card_quota": "0,2,3",
   	    		    "escrow": false,
   	    		 	"separately_confirmed":true,
   	    		 	"deposit_expiration":f_getDate(2)+" 23:59:00"
   	    		 	<c:if test="${_activeMode ne 'REAL'}">
 	    		 	, "test_deposit":true
 	    		 	</c:if>
   	    		  }
   	    		});

   	    	//응답처리
			switch (response.event) {
		        case 'issued':
		            break
		        case 'done':
		            console.log("done: ", response);
		            // 결제 완료 처리
		            break
		        case 'confirm':
		            const confirmedData = await Bootpay.confirm() //결제를 승인한다

		            //console.log("confirmedData: ", confirmedData);

		            if(confirmedData.event === 'done') {
						const stlmDt = confirmedData.data.purchased_at;
						const delngNo = confirmedData.data.receipt_id; // : 거래번호 => DELNG_NO
						const stlmTy = confirmedData.data.method_origin_symbol; // 결테타입 : CARD  => STLM_TY

						$("#delngNo").val(delngNo);
			            $("#stlmTy").val(stlmTy);
			            $("#stlmDt").val(stlmDt);

			            if(stlmTy.toUpperCase() === "CARD"){ //CARD
			            	const cardAprvno = confirmedData.data.card_data.card_approve_no; //카드 승인번호 => CARD_APRVNO
				            const cardCoNm = confirmedData.data.card_data.card_company; //카드회사 => CARD_CO_NM
				            const cardNo = confirmedData.data.card_data.card_no; //카드번호 => CARD_NO

			            	$("#stlmYn").val("Y");
				            $("#cardAprvno").val(cardAprvno);
				            $("#cardCoNm").val(cardCoNm);
				            $("#cardNo").val(cardNo);

			            }else if(stlmTy.toUpperCase() === "BANK"){ //BANK
				        	const dpstBankCd = confirmedData.data.bank_data.bank_code;
				        	const dpstBankNm = confirmedData.data.bank_data.bank_name;
			            	$("#stlmYn").val("Y");
				            $("#dpstBankCd").val(dpstBankCd);
				            $("#dpstBankNm").val(dpstBankNm);
			            }

		            	frm.submit();
		            } else if(confirmedData.event === 'issued') {
		            	const stlmDt = confirmedData.data.purchased_at;
						const delngNo = confirmedData.data.receipt_id; // : 거래번호 => DELNG_NO
						const stlmTy = confirmedData.data.method_origin_symbol; // 결테타입 : CARD  => STLM_TY

						$("#delngNo").val(delngNo);
			            $("#stlmTy").val(stlmTy);
			            $("#stlmDt").val(stlmDt);

			            if(stlmTy.toUpperCase() === "VBANK"){ //VBANK
			            	const vrActno = confirmedData.data.vbank_data.bank_account;
				        	const dpstBankCd = confirmedData.data.vbank_data.bank_code;
				        	const dpstBankNm = confirmedData.data.vbank_data.bank_name;
				        	const dpstr = confirmedData.data.vbank_data.bank_username;
				        	const pyrNm = confirmedData.data.vbank_data.sender_name;
				        	const dpstTermDt = confirmedData.data.vbank_data.expired_at;

				            $("#stlmYn").val("N");
				            $("#vrActno").val(vrActno);
				            $("#dpstBankCd").val(dpstBankCd);
				            $("#dpstBankNm").val(dpstBankNm);
				            $("#dpstr").val(dpstr);
				            $("#pyrNm").val(pyrNm);
				            $("#dpstTermDt").val(dpstTermDt);
			            }
			            frm.submit();

		            } else if(confirmedData.event === 'error') {
		                //결제 승인 실패
		                alert("결제에 실패하였습니다.");

		            }
		            break
		        default:
		            break
		    }


	    } catch (e) {
	        switch (e.event) {
	            case 'cancel':
	                console.log(e.message);	// 사용자가 결제창을 닫을때 호출
	                break
	            case 'error':
	                console.log(e.error_code); // 결제 승인 중 오류 발생시 호출
	                if(e.error_code === 'RC_PRICE_LEAST_LT'){
	                	alert("결제금액이 너무 작습니다.")
	                }
	                break
	        }
	    }
		</c:otherwise>
    </c:choose>

    	} else {
    		$("#stlmYn").val("Y");
    		$("#stlmTy").val("FREE");
    		frm.submit();
    	}

    }


    $(function(){
    	//옵션변경 모달
    	$(document).on("click", ".f_optn_chg", function(){
    		const gdsNo = $(this).data("gdsNo");
    		const ordrDtlNo = $(this).data("dtlNo");
    		const ordrDtlCd = $(this).data("dtlCd");
    		$("#ordr-optn-chg").load("${_marketPath}/mypage/ordr/optnChg",
   				{ordrDtlNo:ordrDtlNo
        			, gdsNo:gdsNo
        			, ordrDtlCd:ordrDtlCd
    			}, function(){
        			//$("#optn-chg-modal").show(0).addClass('show');
        			$("#optn-chg-modal").modal('show');
    			});
    	});

    	// 배송지 모달
    	$("#dlvyMngBtn").on("click",function(){
    		var path = "${_curPath}";
    		var ordrCd = $(this).data("ordrCd");
    		console.log(ordrCd);
    		$("#dlvyView").load("/comm/dlvy/dlvyUseByOrder"
    				, {path : path, ordrCd : ordrCd}
    				, function(){
    					$("#deliModal").addClass("fade").modal("show");
    		});
    	});


    	<c:if test="${ordrCancelBtn}">
    	$(".f_ordr_rtrcn").css({"display":""})
    	</c:if>

		// 주문취소 모달
		$(document).on("click", ".f_ordr_rtrcn", function(){
			const ordrCd = $(this).data("ordrCd");
    		$("#ordr-rtrcn").load("${_marketPath}/mypage/ordr/ordrRtrcn",
   				{ordrCd:ordrCd
    			}, function(){
        			$("#ordr-rtrcn-modal").modal('show');
    			});
    	});


		// 구매확정 처리
		$(".f_ordr_done").on("click", function(e){
			e.preventDefault();
			var ordrNo = $(this).data("ordrNo");
			var dtlCd = $(this).data("dtlCd");
			var msg = $(this).data("msg");
			var resn = $(this).data("resn");

			if(confirm("구매확정 처리하시겠습니까?")){
				$.ajax({
       				type : "post",
       				url  : "${_marketPath}/mypage/ordr/ordrDone.json",
       				data : {
       					ordrNo:ordrNo
       					, ordrDtlCd:dtlCd
       					, resn:resn
       				},
       				dataType : 'json'
       			})
       			.done(function(data) {
       				if(data.result){
       					console.log("상태변경 : success");
       					location.reload();
       				}
       			})
       			.fail(function(data, status, err) {
       				console.log('상태변경 : error forward : ' + data);
       			});
			}
		});

		// 교환신청
		$(document).on("click", ".f_gds_exchng", function(){
			const ordrNo = $(this).data("ordrNo");
    		const ordrDtlCd = $(this).data("dtlCd");
    		$("#ordr-exchng").load("${_marketPath}/mypage/ordr/ordrExchng",
    			{ordrNo:ordrNo, ordrDtlCd:ordrDtlCd
    			}, function(){
        			$("#ordr-exchng-modal").modal('show');
    			});
    	});


		// 반품신청
		$(document).on("click", ".f_ordr_return", function(){
			const ordrCd = $(this).data("ordrCd");
    		$("#ordr-return").load("${_marketPath}/mypage/ordr/ordrReturn",
   				{ordrCd:ordrCd
    			}, function(){
        			$("#ordr-return-modal").modal('show');
    			});
    	});

		// 승인반려 메세지
		$(document).on("click", ".f_partners_msg", function(){
			const ordrNo = $(this).data("ordrNo");
    		const ordrDtlNo = $(this).data("dtlNo");
    		$("#ordr-partners-msg").load("${_marketPath}/mypage/ordr/partnersMsg",
    			{ordrNo:ordrNo, ordrDtlNo:ordrDtlNo
    			}, function(){
        			$("#partners-msg").modal('show');
    			});
    	});

		// 취소사유 메세지
		$(document).on("click", ".f_rtrcn_msg", function(){
			const ordrNo = $(this).data("ordrNo");
    		const ordrDtlNo = $(this).data("dtlNo");
    		const ordrDtlCd = $(this).data("dtlCd");
    		$("#ordr-rtrcn-msg").load("${_marketPath}/mypage/ordr/rtrcnMsg",
    			{ordrNo:ordrNo, ordrDtlNo:ordrDtlNo, ordrDtlCd:ordrDtlCd
    			}, function(){
        			$("#rtrcn-msg").modal('show');
    			});
    	});

		// 교환사유 메세지
		$(document).on("click", ".f_exchng_msg", function(){
			const ordrNo = $(this).data("ordrNo");
    		const ordrDtlNo = $(this).data("dtlNo");
    		const ordrDtlCd = $(this).data("dtlCd");
    		$("#ordr-exchng-msg").load("${_marketPath}/mypage/ordr/exchngMsg",
    			{ordrNo:ordrNo, ordrDtlNo:ordrDtlNo, ordrDtlCd:ordrDtlCd
    			}, function(){
        			$("#exchng-msg").modal('show');
    			});
    	});

		// 반품사유 메세지
		$(document).on("click", ".f_return_msg", function(){
			const ordrNo = $(this).data("ordrNo");
    		const ordrDtlNo = $(this).data("dtlNo");
    		const ordrDtlCd = $(this).data("dtlCd");
    		$("#ordr-return-msg").load("${_marketPath}/mypage/ordr/returnMsg",
    			{ordrNo:ordrNo, ordrDtlNo:ordrDtlNo, ordrDtlCd:ordrDtlCd
    			}, function(){
        			$("#return-msg").modal('show');
    			});
    	});



    	$("form[name='frmOrdr']").validate({
    	    ignore: "input[type='text']:hidden, [contenteditable='true']:not([name])",
    	    rules : {
    	    	buyAgree			: { required : true}
    	    },
    	    messages : {
		    	buyAgree			: { required : "구매자 동의사항에 체크해야 합니다."}
    	    },
    	    errorPlacement: function(error, element) {
    		    var group = element.closest('.form-group, .form-check');
    		    if (group.length) {
    		        group.after(error.addClass('text-danger'));
    		    } else {
    		        element.after(error.addClass('text-danger'));
    		    }
    		},
    	    submitHandler: function (frm) {
    	    	f_pay(frm);
    	    	return false;
    	    }
    	});
    });

    </script>