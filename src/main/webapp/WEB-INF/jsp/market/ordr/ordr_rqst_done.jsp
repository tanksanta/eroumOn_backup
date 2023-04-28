<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

    <main id="container">

        <jsp:include page="../layout/page_header.jsp">
			<jsp:param value="주문 완료" name="pageTitle"/>
		</jsp:include>

		<jsp:include page="./include/personal_info.jsp" />

        <div id="page-container">
            <div id="page-content">
                <!-- div class="order-complate">
                    <div class="container">
                        <p class="text-alerm">배송 진행 사항은 <strong>알림서비스</strong>로 받으세요</p>
                        <picture class="status">
                            <source srcset="/html/page/market/assets/images/txt-order-complate-mo.svg" media="(max-width: 768px)">
                            <source srcset="/html/page/market/assets/images/txt-order-complate.svg">
                            <img src="/html/page/market/assets/images/txt-order-complate.svg" alt="주문이 정상적으로 완료되었습니다.">
                        </picture>
                    </div>
                </div>
                <br><br -->
                <div class="order-complate2">
                    <div class="container">
                    	<c:set var="bplcCheck" value="" />
                    	<c:forEach items="${ordrVO.ordrDtlList}" var="ordrDtl" varStatus="status">
                    	<c:if test="${status.first || (fn:indexOf(bplcCheck, ordrDtl.bplcInfo.uniqueId) < 0)}">
                    	<c:set var="bplcCheck" value="${bplcCheck}|${ordrDtl.bplcInfo.uniqueId}" />

                        <div class="product-partners">
                        	<c:if test="${ordrDtl.bplcInfo.proflImg eq null}">
                            	<img src="/html/page/market/assets/images/partners_default.png" alt="">
                            </c:if>
                            <c:if test="${ordrDtl.bplcInfo.proflImg ne null}">
                            	<img src="/comm/PROFL/getFile?fileName=${ordrDtl.bplcInfo.proflImg}">
                            </c:if>
                            <dl>
                                <dt>${ordrDtl.bplcInfo.bplcNm}</dt>
                                <dd class="info">
                                    <p class="addr">${ordrDtl.bplcInfo.addr}&nbsp;${ordrDtl.bplcInfo.daddr}</p>
                                    <p class="call"><a href="tel:${ordrDtl.bplcInfo.telno}">${ordrDtl.bplcInfo.telno}</a></p>
                                </dd>
                            </dl>
                        </div>
                        </c:if>
                        </c:forEach>
                        <picture class="status">
                            <source srcset="/html/page/market/assets/images/txt-order-complate2-mo.svg" media="(max-width: 768px)">
                            <source srcset="/html/page/market/assets/images/txt-order-complate2.svg">
                            <img src="/html/page/market/assets/images/txt-order-complate2.svg" alt="멤버스 승인을 대기중입니다.">
                        </picture>
                        <div class="desc">
                            결제는 멤버스 승인 완료 후 진행이 가능하며<br>
                            멤버스 승인 완료 시 문자 또는 카카오톡 으로 알려드립니다.<br>
                            마이페이지 - 쇼핑내역 - 주문/배송조회에서도 확인 가능합니다
                        </div>
                    </div>
                </div>

                <h3 class="text-title mt-10 mb-3 md:mb-4 md:mt-13">주문상품 정보</h3>

                <div class="mb-9 space-y-6 md:mb-12 md:space-y-7.5">

				<c:set var="totalDlvyBassAmt" value="0" />
                <c:set var="totalCouponAmt" value="0" />
                <c:set var="totalAccmlMlg" value="0" />
                <c:set var="totalOrdrPc" value="0" />
                <c:set var="totalAccmlMlg" value="0" />
                <c:set var="totalCouponAmt" value="0" />

					<c:forEach items="${ordrVO.ordrDtlList}" var="ordrDtl" varStatus="status">
					<c:set var="spOrdrOptn" value="${fn:split(ordrDtl.ordrOptn, '*')}" />

					<c:if test="${ordrDtl.ordrOptnTy eq 'BASE'}">
					<c:set var="sumOrdrPc" value="${ordrDtl.ordrPc }" />
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
									</div>

									<div class="order-item-count">
		                                <p><strong>${ordrDtl.ordrQy}</strong>개</p>
		                            </div>
		                            <p class="order-item-price"><fmt:formatNumber value="${sumOrdrPc}" pattern="###,###" />원</p>

									<div class="order-item-info">
                                        <div class="payment">
                                        	<%-- 멤버스 --%>
                                        	<dl>
                                                <dt>멤버스</dt>
                                                <dd>${ordrDtl.bplcInfo.bplcNm}</dd>
                                            </dl>
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
                                            <c:if test="${ordrDtl.gdsInfo.dlvyAditAmt > 0}">
                                            <dl>
                                                <dt>추가 배송비</dt>
                                                <dd><fmt:formatNumber value="${ordrDtl.gdsInfo.dlvyAditAmt}" pattern="###,###" />원</dd>
                                            </dl>
                                            </c:if>
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
					<c:set var="totalDlvyBassAmt" value="${totalDlvyBassAmt + (ordrDtl.ordrOptnTy eq 'BASE'?(ordrDtl.gdsInfo.dlvyBassAmt + ordrDtl.gdsInfo.dlvyAditAmt):0)}" />
					<%-- 적립예정마일리지 --%>
                    <c:set var="totalAccmlMlg" value="${totalAccmlMlg + ordrDtl.accmlMlg}" />
                    <%-- 주문금액 + 옵션금액 --%>
                    <c:set var="totalOrdrPc" value="${totalOrdrPc + ordrDtl.ordrPc}" />
                    <%-- 쿠폰 할인 금액--%>
                    <c:set var="totalCouponAmt" value="${totalCouponAmt + ordrDtl.couponAmt}" />
                    <%-- 적립 마일리지 --%>
                    <c:if test="${ordrDtl.gdsInfo.mlgPvsnYn eq 'Y' && ordrDtl.gdsInfo.gdsTy eq 'N'}">
                    <c:set var="totalAccmlMlg" value="${totalAccmlMlg + ordrDtl.gdsInfo.pc * (_mileagePercent/100)}" />
                    </c:if>

                </c:forEach>

                </div>

                <div class="flex justify-center space-x-1.5 mt-18 md:space-x-2.5 md:mt-23">
                    <a href="${_marketPath}/gds/list" class="btn btn-large btn-outline-secondary w-37 md:w-45 lg:w-51">쇼핑 계속하기</a>
                    <a href="${_marketPath}/mypage/ordr/list" class="btn btn-large btn-primary w-37 md:w-45 lg:w-51">주문내역 조회</a>
                </div>
            </div>
        </div>
    </main>