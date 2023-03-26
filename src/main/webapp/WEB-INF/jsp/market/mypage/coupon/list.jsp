<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<main id="container">
	<jsp:include page="../../layout/page_header.jsp">
		<jsp:param value="이로움 혜택" name="pageTitle" />
	</jsp:include>

	<div id="page-container">

		<jsp:include page="../../layout/page_sidenav.jsp" />

		<div id="page-content">
            <div class="mypage-profit is-coupon">
	            <div class="profit-infomation">
                	<div class="title">
	                    <picture>
							<img src="/html/page/market/assets/images/txt-mypage-grade-${_mbrSession.mberGrade}.svg" alt="">
	                    </picture>
						<p><strong>${_mbrSession.mbrNm}</strong> 님은<br> 현재 <strong>${mberGradeCode[_mbrSession.mberGrade]}</strong> 등급입니다</p>
                	</div>
                    <div class="number">
                        <dl>
                            <dt>보유한 쿠폰</dt>
                            <dd><strong>${resultList.size()}</strong> 장</dd>
                        </dl>
                    </div>
	            </div>
                <div class="profit-content">
	                <ul class="nav nav-tabs tabs" id="tabs-tab" role="tablist">
	                    <li class="nav-item"><a href="${_marketPath}/etc/dspy/list" class="nav-link tabs-link">진행중인 기획전</a></li>
	                    <li class="nav-item"><a href="${_marketPath}/etc/event/list?sortVal=play" class="nav-link tabs-link active">진행중인 이벤트</a></li>
	                </ul>
	                <div class="mt-6 md:mt-7">
	                    <table class="table-list order-coupon-list">
	                        <colgroup>
	                            <col class="w-37 md:min-w-48 xs:w-[48.5%]">
	                            <col>
	                        </colgroup>
	                        <thead>
	                            <tr>
	                                <th><p>쿠폰</p></th>
	                                <th><p>기간 / 혜택</p></th>
	                            </tr>
	                        </thead>
							<tbody>
								<c:forEach var="resultList" items="${resultList}" varStatus="status">
									<tr>
										<td>
											<jsp:include page="event_type.jsp">
												<jsp:param value="${resultList.couponInfo.couponTy}" name="eventType" />
												<jsp:param value="${resultList.couponInfo.mummOrdrAmt}" name="mummOrdrAmt" />
												<jsp:param value="${resultList.couponInfo.mxmmDscntAmt}" name="mxmmDscntAmt" />
												<jsp:param value="${resultList.couponInfo.dscntAmt}" name="dscntAmt" />
												<jsp:param value="${resultList.couponInfo.dscntTy}" name="dscntTy" />
											</jsp:include>
										</td>
										<td>
											<div class="coupon-item-name">
												${resultList.couponInfo.couponNm}
												<strong>
													<c:choose>
														<c:when test="${resultList.couponInfo.usePdTy eq 'FIX'}">
															<fmt:formatDate value="${resultList.couponInfo.useBgngYmd}" pattern="yyyy-MM-dd" />
																~
															<fmt:formatDate value="${resultList.couponInfo.useEndYmd}" pattern="yyyy-MM-dd" />
														</c:when>
														<c:otherwise>
															<fmt:formatDate value="${resultList.useLstBgngYmd}" pattern="yyyy-MM-dd" />
																~
															<fmt:formatDate value="${resultList.useLstEndYmd}" pattern="yyyy-MM-dd" />
														</c:otherwise>
													</c:choose>
												</strong>
											</div>
											<div class="coupon-item-desc">
												<fmt:formatNumber value="${resultList.couponInfo.mummOrdrAmt}" pattern="###,###" />원 이상 구매시
												<c:if test="${resultList.couponInfo.couponTy ne 'FREE' }">
													<br> 최대 <fmt:formatNumber value="${resultList.couponInfo.mxmmDscntAmt}" pattern="###,###" />원 할인
												</c:if>
												<c:if test="${resultList.couponInfo.couponTy eq 'FREE' }">
													<br> 배송비 할인
												</c:if>
											</div>
										</td>
									</tr>
								</c:forEach>
								<tr class="bot-border">
									<td></td>
									<td></td>
								</tr>
							</tbody>
                    	</table>
	                </div>
               	</div>
           	</div>
		</div>
	</div>
</main>