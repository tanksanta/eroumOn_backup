<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

        <!-- 취소 상세정보 -->
        <div class="modal fade" id="rtrcn-msg" tabindex="-1" aria-hidden="true">
            <div class="modal-dialog modal-dialog-centered">
                <div class="modal-content">
                    <div class="modal-header">
                        <p class="text-title">취소 상세정보</p>
                    </div>
                    <div class="modal-close">
                        <button type="button" data-bs-dismiss="modal">모달 닫기</button>
                    </div>
                    <div class="modal-body">
                        <div class="order-status-layer">
                            <dl class="status-info status-number">
                                <dt>주문 번호</dt>
                                <dd>${ordrDtlList[0].ordrCd}</dd>
                            </dl>
                            <dl class="status-info mt-3 md:mt-4">
                                <dt>주문 일시</dt>
                                <dd><fmt:formatDate value="${ordrDtlList[0].regDt}" pattern="yyyy.MM.dd HH:mm:ss" /></dd> <%--ordrDt = regDt --%>
                            </dl>
                            <p class="status-cancel mt-4 md:mt-5.5">주문 취소</p>
                            <div class="order-product mt-6 md:mt-7.5">

							<c:forEach items="${ordrDtlList}" var="ordrDtl" varStatus="status">
			                	<c:set var="spOrdrOptn" value="${fn:split(ordrDtl.ordrOptn, '*')}" />
			                	<c:set var="sumGdsPc" value="0" />

			                    <c:if test="${ordrDtl.ordrOptnTy eq 'BASE'}">
								<c:set var="sumOrdrPc" value="${ordrDtl.ordrPc }" />
								<c:set var="sumGdsPc" value="${sumGdsPc + (ordrDtl.gdsPc * ordrDtl.ordrQy) }" />


			                        <div class="order-body">

										<c:if test="${!empty ordrDtl.recipterUniqueId }">
										<%-- 베네핏 바이어 --%>
										<div class="order-buyer">
											<c:if test="${ordrDtl.recipterInfo.uniqueId ne _mbrSession.uniqueId}">
				                                <c:if test="${!empty ordrDtl.recipterInfo.proflImg}">
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
									<c:set var="sumGdsPc" value="${sumGdsPc + (ordrDtl.gdsPc * ordrDtl.ordrQy) }" />
									<%-- sumOrdrPc : ${sumOrdrPc} / ${ordrDtl.ordrPc} --%>

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

								<c:if test="${ordrDtlList[status.index+1].ordrOptnTy eq 'BASE' || status.last}">
												</div>

												<div class="order-item-count">
					                                <p><strong>${ordrDtl.ordrQy}</strong>개</p>
					                                <%-- 배송 준비전 or 주문승인대기 --%>
					                                <c:if test="${ordrDtl.sttsTy eq 'OR01' || ordrDtl.sttsTy eq 'OR04'}">
			                                        <button type="button" class="btn btn-primary btn-small f_optn_chg" data-gds-no="${ordrDtl.gdsNo}" data-dtl-no="${ordrDtl.ordrDtlNo}" data-dtl-cd="${ordrDtl.ordrDtlCd}">변경</button>
			                                        </c:if>
					                            </div>
					                            <p class="order-item-price"><fmt:formatNumber value="${sumOrdrPc}" pattern="###,###" />원</p>

												<div class="order-item-info">
			                                        <div class="payment">
			                                        	<c:if test="${ordrVO.ordrTy eq 'R' || ordrVO.ordrTy eq 'L'}"><%-- 급여구매일 경우만 경우만 멤버스(사업소) 있음 --%>
			                                        	<%-- 멤버스 --%>
			                                        	<c:if test="${!empty ordrDtl.bplcInfo}">
			                                        	<dl>
			                                                <dt>멤버스</dt>
			                                                <dd>${ordrDtl.bplcInfo.bplcNm}</dd>
			                                            </dl>
			                                            </c:if>
														</c:if>
			                                        	<c:if test="${ordrDtl.gdsInfo.dlvyCtTy ne 'FREE'}">
			                                            <dl>
			                                                <dt>배송비</dt>
			                                                <dd><fmt:formatNumber value="${ordrDtl.gdsInfo.dlvyBassAmt}" pattern="###,###" />원</dd>
			                                            </dl>
			                                            </c:if>
			                                            <c:if test="${ordrDtl.gdsInfo.dlvyAditAmt > 0}">
			                                            <dl>
			                                                <dt>추가 배송비</dt>
			                                                <dd><fmt:formatNumber value="${ordrDtl.gdsInfo.dlvyAditAmt}" pattern="###,###" />원</dd>
			                                            </dl>
			                                            </c:if>
			                                        </div>
			                                    </div>
			                                </div>
			                            </div>
			                        </div>

			                	</c:if>


			                    </c:forEach>

                            </div>
                            <dl class="status-info mt-3.5 md:mt-5">
                                <dt>취소 일시</dt>
                                <dd><fmt:formatDate value="${ordrChgHistVO.regDt}" pattern="yyyy.MM.dd HH:mm:ss" /></dd>
                            </dl>
                            <dl class="status-info mt-2 md:mt-3">
                                <dt>취소 사유</dt>
                                <dd>
                                    ${ordrCancelTyCode[ordrChgHistVO.resnTy]}
                                    <p class="desc">${ordrChgHistVO.resn}</p>
                                </dd>
                            </dl>
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-primary" data-bs-dismiss="modal">확인</button>
                    </div>
                </div>
            </div>
        </div>
        <!-- //취소 상세정보 -->
