<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>


    <main id="container">
        <jsp:include page="../layout/page_header.jsp">
			<jsp:param value="주문 결제완료" name="pageTitle"/>
		</jsp:include>

        <div id="page-container">
            <div id="page-content">
                <div class="order-complate3">
                    <div class="container">
                        <p class="text-alerm">배송 진행 사항은 <strong>알림서비스</strong>로 받으세요</p>
                        <picture class="status">
                            <source srcset="/html/page/market/assets/images/txt-order-complate3-mo.svg" media="(max-width: 768px)">
                            <source srcset="/html/page/market/assets/images/txt-order-complate3.svg">
                            <img src="/html/page/market/assets/images/txt-order-complate3.svg" alt="결제가 정상적으로 완료되었습니다.">
                        </picture>
                        <p class="order">
                            <strong>${ordrVO.ordrrNm}</strong> 님의 주문번호는 <span class="inline-block"><i>${ordrVO.ordrCd}</i> 입니다</span>
                        </p>
                        <p class="text-alert">주문내역은 마이페이지 - 쇼핑내역 - 주문/배송조회에서도 확인 가능합니다</p>
                    </div>
                </div>
                <h3 class="text-title mt-10 mb-3 md:mb-4 md:mt-13">상품 정보</h3>

                <div class="order-container mb-9 space-y-6 md:mb-12 md:space-y-7.5">

                    <div class=""></div>
                <c:set var="totalDlvyBassAmt" value="0" />
                <c:set var="totalDlvyAditAmt" value="0" />
                <c:set var="totalCouponAmt" value="0" />
                <c:set var="totalAccmlMlg" value="0" />
                <c:set var="totalOrdrPc" value="0" />
                <c:set var="totalGdsPc" value="0" />
                <c:set var="totalAccmlMlg" value="0" />
                <c:set var="totalCouponAmt" value="0" />
                <c:set var="sumGdsPc" value="0" />


				<c:forEach items="${ordrVO.ordrDtlList}" var="ordrDtl" varStatus="status">
				<c:set var="spOrdrOptn" value="${fn:split(ordrDtl.ordrOptn, '*')}" />

					<c:if test="${ordrDtl.ordrOptnTy eq 'BASE'}">
					<c:set var="sumOrdrPc" value="${ordrDtl.ordrPc }" />
					<%--총 상품 가격 --%>
					<c:set var="totalGdsPc" value="${ordrDtl.ordrQy * ordrDtl.gdsPc}" />

                    <div class="order-product">
                        <div class="order-body">


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
		                                        <span class="label-primary">
		                                            <span>${gdsTyCode[ordrDtl.gdsInfo.gdsTy]}</span>
		                                            <i></i>
		                                        </span>
		                                        <u>${ordrDtl.gdsInfo.gdsCd }</u>
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
						<c:set var="sumGdsPc" value="${sumGdsPc + totalAditGdsPc}" />
						<%--총 상품 가격 --%>
						<c:set var="totalGdsPc" value="${totalGdsPc + (ordrDtl.ordrOptnPc * ordrDtl.ordrQy )}" />
	                                    <div class="order-item-add">
	                                        <span class="label-outline-primary">
	                                            <span>${spOrdrOptn[0]}</span>
	                                            <i><img src="/html/page/market/assets/images/ico-plus-white.svg" alt=""></i>
	                                        </span>
	                                        <div class="name">
	                                            <p><strong>${spOrdrOptn[1]}</strong></p>
	                                            <p>수량 ${ordrDtl.ordrQy}개 (+<fmt:formatNumber value="${ordrDtl.ordrPc}" pattern="###,###" />원)</p>
	                                        </div>
	                                    </div>

					</c:if>

					<c:if test="${ordrVO.ordrDtlList[status.index+1].ordrOptnTy eq 'BASE' || status.last}">
							<c:set var="sumGdsPc" value="${sumGdsPc + totalGdsPc}" />
									</div>

									<div class="order-item-count">
		                                <p><strong>${ordrDtl.ordrQy}</strong>개</p>
		                            </div>
		                            <p class="order-item-price"><span class="text-primary"><fmt:formatNumber value="${totalGdsPc}" pattern="###,###" />원</span></p>

									<div class="order-item-info">
                                        <div class="payment">
                                        	<c:if test="${!empty ordrDtl.bplcInfo}">
                                            <dl>
                                                <dt>멤버스</dt>
                                                <dd>${ordrDtl.bplcInfo.bplcNm }</dd>
                                            </dl>
                                            </c:if>
                                            <dl>
                                                <dt>배송비</dt>
                                                <dd>
                                                	<c:if test="${ordrDtl.gdsInfo.dlvyCtTy eq 'FREE'}">
                                                	무료배송
                                                	</c:if>
                                                	<c:if test="${ordrDtl.gdsInfo.dlvyCtTy ne 'FREE'}">
                                                	<fmt:formatNumber value="${ordrDtl.gdsInfo.dlvyBassAmt}" pattern="###,###" />원
                                                	</c:if>
                                                </dd>
                                            </dl>

                                            <%-- <c:if test="${ordrDtl.gdsInfo.dlvyAditAmt > 0}">
                                            <dl>
                                                <dt>추가 배송비</dt>
                                                <dd><fmt:formatNumber value="${ordrDtl.gdsInfo.dlvyAditAmt}" pattern="###,###" />원</dd>
                                            </dl>
                                            </c:if> --%>

                                        </div>
										<div class="status">
                                            <div class="box-gray">
                                                <p class="flex-1">${ordrSttsCode[ordrDtl.sttsTy]}</p>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>

                	</c:if>

					<%-- 배송비 + 추가배송비 --%>
					<c:set var="totalDlvyBassAmt" value="${totalDlvyBassAmt + ordrDtl.dlvyBassAmt}" />
					<c:set var="totalDlvyAditAmt" value="${totalDlvyAditAmt + ordrDtl.dlvyAditAmt}" />
					<%-- 적립예정마일리지 --%>
                    <c:set var="totalAccmlMlg" value="${totalAccmlMlg + ordrDtl.accmlMlg}" />
                    <%-- 주문금액 + 옵션금액 --%>
                    <c:set var="totalOrdrPc" value="${totalOrdrPc + ordrDtl.ordrPc}" />
                    <%-- 쿠폰 할인 금액--%>
                    <c:set var="totalCouponAmt" value="${totalCouponAmt + ordrDtl.couponAmt}" />

                </c:forEach>
                </div>

                <div class="md:flex md:space-x-6 lg:space-x-7.5">
                    <div class="flex-1 mt-18 md:mt-23">
                        <h3 class="text-title mb-3 md:mb-4">배송지 정보</h3>
                        <div class="payment-shipping">
                            <dl class="shipping-name">
                                <dt>받는사람</dt>
                                <dd>${ordrVO.recptrNm}</dd>
                            </dl>
                            <dl class="shipping-call">
                                <dt>연락처</dt>
                                <dd>
                                    <p><a href="tel:${ordrVO.recptrMblTelno}">${ordrVO.recptrMblTelno}</a></p>
                                    <c:if test="${!empty ordrVO.recptrTelno}">
                                    <p class="text-lg"><a href="tel:${ordrVO.recptrTelno}">${ordrVO.recptrTelno}</a></p>
                                    </c:if>
                                </dd>
                            </dl>
                            <dl class="shipping-addr">
                                <dt>주소</dt>
                                <dd>
                                    <p>${ordrVO.recptrZip}</p>
                                    <p class="text-lg">${ordrVO.recptrAddr}&nbsp;${ordrVO.recptrDaddr}</p>
                                </dd>
                            </dl>
                            <dl class="shipping-msgs">
                                <dt>배송메시지</dt>
                                <dd>${ordrVO.ordrrMemo}</dd>
                            </dl>
                            <%--
                            <div class="mt-2.5 text-right">
                                <!-- <a href="#" class="btn btn-primary btn-small" data-bs-toggle="modal" data-bs-target="#deliModal">배송지 정보 수정</a> -->
                                <button type="button" class="btn btn-primary btn-small" data-bs-toggle="modal" data-bs-target="#deliModal">배송지 정보 수정</button>
                            </div>
                             --%>
                        </div>
                    </div>
                    <div class="flex-1 mt-18 lg:mt-23">
                        <h3 class="text-title mb-3 lg:mb-4">고객 정보</h3>
                        <c:choose>
							<c:when test="${_mbrSession.mberGrade eq 'E'}">
								<div class="payment-customer customer-grade1 flex-1">
							</c:when>
							<c:when test="${_mbrSession.mberGrade eq 'B'}">
								<div class="payment-customer customer-grade2 flex-1">
							</c:when>
							<c:when test="${_mbrSession.mberGrade eq 'S'}">
								<div class="payment-customer customer-grade3 flex-1">
							</c:when>
							<c:when test="${_mbrSession.mberGrade eq 'N'}">
								<div class="payment-customer customer-grade4 flex-1">
							</c:when>
							<c:otherwise>
								<div class="payment-customer customer-grade4 flex-1">
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

                <h3 class="text-title mt-18 mb-3 md:mb-4 md:mt-23">결제 정보</h3>
                <div class="payment-amount">
                    <div class="amount-section">
                        <dl class="price">
                            <dt>총 주문금액</dt>
                            <dd><strong><fmt:formatNumber value="${sumGdsPc + totalDlvyBassAmt}" pattern="###,###" /></strong> 원</dd>
                        </dl>
                        <div class="detail">
                            <dl>
                                <dt>상품금액</dt>
                                <dd><strong><fmt:formatNumber value="${sumGdsPc}" pattern="###,###" /></strong> 원</dd>
                            </dl>
                            <dl>
                                <dt>배송비</dt>
                                <dd><strong><fmt:formatNumber value="${totalDlvyBassAmt}" pattern="###,###" /></strong> 원</dd>
                            </dl>
                            <c:if test="${totalDlvyAditAmt > 0}">
                            <dl>
                                <dt>도서산간 추가 배송비</dt>
                                <dd><strong><fmt:formatNumber value="${totalDlvyAditAmt}" pattern="###,###" /></strong> 원</dd>
                            </dl>
                            </c:if>
                        </div>
                    </div>
                    <!-- <i class="amount-calculator is-plus">+</i> -->
                    <i class="amount-calculator is-minus">-</i>
                    <div class="amount-section">
                        <dl class="price">
                            <dt>총 할인금액</dt>
                            <dd><strong><fmt:formatNumber value="${totalCouponAmt + ordrVO.useMlg + ordrVO.usePoint}" pattern="###,###" /></strong> 원</dd>
                        </dl>
                        <div class="detail">
                            <dl>
                                <dt>쿠폰할인</dt>
                                <dd><strong><fmt:formatNumber value="${totalCouponAmt}" pattern="###,###" /></strong> 원</dd>
                            </dl>

                            <dl>
                                <dt>마일리지 사용</dt>
                                <dd><strong><fmt:formatNumber value="${ordrVO.useMlg }" pattern="###,###" /></strong> 원</dd>
                            </dl>
                            <dl>
                                <dt>포인트 사용</dt>
                                <dd><strong><fmt:formatNumber value="${ordrVO.usePoint }" pattern="###,###" /></strong> 원</dd>
                            </dl>
                        </div>
                    </div>
                    <i class="amount-calculator is-equal">=</i>
                    <div class="amount-section is-latest">
                        <dl class="price">
                            <dt>총 결제금액</dt>
                            <dd><strong><fmt:formatNumber value="${ordrVO.stlmAmt}" pattern="###,###" /></strong> 원</dd>
                        </dl>
                        <div class="detail">
                            <dl>
                                <dt>결제 방법</dt>
                                <dd><strong>${bassStlmTyCode[ordrVO.stlmTy]}</strong></dd>
                            </dl>
                            <p class="mt-1 mb-2.5 lg:mt-1.5 lg:mb-3 leading-tight text-right font-normal">
                            	<c:choose>
	                           		<c:when test="${ordrVO.stlmTy eq 'VBANK'}">
										[${ordrVO.dpstBankNm}] ${ordrVO.vrActno}<br>
										예금주 : ${ordrVO.dpstr}<br>
										<c:if test="${ordrVO.stlmYn eq 'N'}">
										결제만료일 : ${fn:substring(ordrVO.dpstTermDt, 0, 16)}<br>
										</c:if>
										결제자명 : ${ordrVO.pyrNm}
	                           		</c:when>
	                           		<c:when test="${ordrVO.stlmTy eq 'CARD'}">
	                           		승인번호 : ${ordrVO.cardAprvno}<br>
	                           		${ordrVO.cardCoNm}&nbsp;${ordrVO.cardNo}
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
	                           			PG
	                           		</c:otherwise>
	                           	</c:choose>
                            </p>
                            <dl>
                                <dt>결제 일시</dt>
                                <dd>${ordrVO.stlmDt}<br>
                                	<strong class="text-red3">${ordrVO.stlmYn eq 'Y'?'결제완료':'결제대기'}</strong>
                                </dd>
                            </dl>
                        </div>
                    </div>
                    <c:if test="${totalAccmlMlg > 0 }">
                    <dl class="amount-mileage">
                        <dt>적립예정<br> 마일리지</dt>
                        <dd>
                            <p class="point"><fmt:formatNumber value="${totalAccmlMlg}" pattern="###,###" /></p>
                            <p class="desc">구매확정 시 적립됩니다</p>
                        </dd>
                    </dl>
                    </c:if>

                </div>
                <p class="text-alert mt-2.5 md:mt-3.5"><strong>무통장 입금</strong>으로 주문하신 경우, 입금 기한까지 입금하지 않으시면 주문이 자동으로 취소되오니 입금 기한까지 꼭 입금을 해주시기 바랍니다.</p>

                <div class="flex justify-center space-x-1.5 mt-18 md:space-x-2.5 md:mt-23">
                    <a href="${_marketPath}/gds/list" class="btn btn-large btn-outline-secondary w-37 md:w-45 lg:w-51">쇼핑 계속하기</a>
                    <a href="${_marketPath}/mypage/ordr/list" class="btn btn-large btn-primary w-37 md:w-45 lg:w-51">주문내역 조회</a>
                </div>
            </div>
        </div>

        
        <textarea class="ordredListJson" style="display: none;">
			${ordredListJson}
		</textarea>
        <textarea class="entrpsVOListJson" style="display: none;">
			${entrpsVOListJson}
		</textarea>
        <textarea class="codeMapJson" style="display: none;">
			${codeMapJson}
		</textarea>

        <!-- 배송지 -->
        <%-- <jsp:include page="./include/modal_dlvy.jsp" /> --%>
        <!-- //배송지 -->
    </main>

    <script type="text/javascript" src="/html/page/market/assets/script/JsMarketOrdredDrawItems.js?v=<spring:eval expression="@version['assets.version']"/>"></script>
	<script type="text/javascript" src="/html/page/market/assets/script/JsMarketOrdredDone.js?v=<spring:eval expression="@version['assets.version']"/>"></script>

    <script>
        var jsMarketMain = null;
		$(document).ready(function() {
            jsMarketMain = new JsMarketOrdredDone(' .order-container', $("textarea.ordredListJson").val(), $("textarea.entrpsVOListJson").val(), $("textarea.codeMapJson").val());
        });
    </script>