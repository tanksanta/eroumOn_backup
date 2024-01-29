<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<link rel="stylesheet" href="/html/page/market/assets/style/content/ordred-list.css?v=<spring:eval expression="@version['assets.version']"/>">

	<main id="container" class="is-mypage">
		<jsp:include page="../layout/page_header.jsp">
			<jsp:param value="마이페이지" name="pageTitle"/>
		</jsp:include>

        <div id="page-container">

            <jsp:include page="../layout/page_sidenav.jsp" />

            <div id="page-content">
				<jsp:include page="../layout/mobile_userinfo.jsp" />

				<c:if test="${prtcrRecipterYn eq 'N'}">
                <!-- 진행 주문 현황 -->
                <div class="mypage-myinfo-order mb-12 md:mb-25">
                    <div class="order-title">
                        <h2>진행중인 주문 현황</h2>
                        <ul>
                            <li>취소 <strong>${ordrSttsTyCntMap.ca01 + ordrSttsTyCntMap.ca02}</strong></li>
                            <li>교환 <strong>${ordrSttsTyCntMap.ex01 + ordrSttsTyCntMap.ex02 + ordrSttsTyCntMap.ex03}</strong></li>
                            <li>반품 <strong>${ordrSttsTyCntMap.re01 + ordrSttsTyCntMap.re02 + ordrSttsTyCntMap.re03}</strong></li>
                        </ul>
                    </div>
                    <div class="order-steps">
                        <div class="seq3">
                            <div class="content">
                                <p>결제<strong>대기</strong></p>
                                <p class="number">${ordrSttsTyCntMap.or04}</p>
                            </div>
                        </div>
                        <div class="seq4">
                            <div class="content">
                                <p>결제<strong>완료</strong></p>
                                <p class="number">${ordrSttsTyCntMap.or05}</p>
                            </div>
                        </div>
                        <div class="seq5">
                            <div class="content">
                                <p>배송<strong>준비중</strong></p>
                                <p class="number">${ordrSttsTyCntMap.or06}</p>
                            </div>
                        </div>
                        <div class="seq6">
                            <div class="content">
                                <p>상품<strong>준비완료</strong></p>
                                <p><strong>배송중</strong></p>
                                <p class="number">${ordrSttsTyCntMap.or07}</p>
                            </div>
                        </div>
                        <div class="seq7">
                            <div class="content">
                                <p><strong>배송</strong>완료</p>
                                <p class="number">${ordrSttsTyCntMap.or08}</p>
                            </div>
                        </div>
                    </div>
                </div>
                <!-- //진행 주문 현황 -->
                </c:if>


				<%-- 가족회원(나포함) 수급자 있으면 --%>
				<c:if test="${prtcrRecipterYn eq 'Y'}">
                <!-- 수급자 진행 주문 현황 -->
                <div class="mypage-myinfo-order is-recipient mb-12 md:mb-25">
                    <div class="order-title">
                        <h2>진행중인 주문 현황</h2>
                        <ul>
                            <li>취소 <strong>${ordrSttsTyCntMap.ca01 + ordrSttsTyCntMap.ca02}</strong></li>
                            <li>교환 <strong>${ordrSttsTyCntMap.ex01 + ordrSttsTyCntMap.ex02 + ordrSttsTyCntMap.ex03}</strong></li>
                            <li>반품 <strong>${ordrSttsTyCntMap.re01 + ordrSttsTyCntMap.re02 + ordrSttsTyCntMap.re03}</strong></li>
                        </ul>
                    </div>

                    <!-- 수급자회원 -->
                    <div class="order-steps">
                        <div class="steps1">
                            <p class="title">EROUM MARKET</p>
                            <div class="seq1">
                                <div class="content">
                                    <p>멤버스</p>
                                    <p><strong>승인대기</strong></p>
                                    <p class="number" id="seq1" data-seq-number="${ordrSttsTyCntMap.or01}">${ordrSttsTyCntMap.or01}</p>
                                </div>
                            </div>
                            <div class="seq2">
                                <div class="content">
                                    <p>멤버스</p>
                                    <p><strong>승인완료/반려</strong></p>
                                    <p class="number" id="seq2" data-seq-number="${ordrSttsTyCntMap.or02 + ordrSttsTyCntMap.or03}">${ordrSttsTyCntMap.or02 + ordrSttsTyCntMap.or03}</p>
                                </div>
                            </div>
                            <div class="text-alert font-bold">
                                <p>급여상품 구매에 필요한 단계로</p>
                                <p>급여상품을 보유한 멤버스의 승인 후에 구매가 이루어집니다</p>
                            </div>
                        </div>
                        <div class="steps2">
                            <div class="seq3">
                                <div class="content">
                                    <p>결제<strong>대기</strong></p>
                                    <p class="number" id="seq3" data-seq-number="${ordrSttsTyCntMap.or03 + ordrSttsTyCntMap.or04}">${ordrSttsTyCntMap.or03 + ordrSttsTyCntMap.or04}</p>
                                </div>
                            </div>
                            <div class="seq4">
                                <div class="content">
                                    <p>결제<strong>완료</strong></p>
                                    <p class="number" id="seq4" data-seq-number="${ordrSttsTyCntMap.or05}">${ordrSttsTyCntMap.or05}</p>
                                </div>
                            </div>
                            <div class="seq5">
                                <div class="content">
                                    <p>배송<strong>준비중</strong></p>
                                    <p class="number" id="seq5" data-seq-number="${ordrSttsTyCntMap.or06}">${ordrSttsTyCntMap.or06}</p>
                                </div>
                            </div>
                            <div class="seq6">
                                <div class="content">
                                    <p>상품<strong>준비완료</strong></p>
                                    <p><strong>배송중</strong></p>
                                    <p class="number" id="seq6" data-seq-number="${ordrSttsTyCntMap.or07}">${ordrSttsTyCntMap.or07}</p>
                                </div>
                            </div>
                            <div class="seq7">
                                <div class="content">
                                    <p><strong>배송</strong>완료</p>
                                    <p class="number" id="seq7" data-seq-number="${ordrSttsTyCntMap.or08}">${ordrSttsTyCntMap.or08}</p>
                                </div>
                            </div>
                        </div>
                    </div>
                    <!-- //수급자회원 -->

					<c:if test="${!empty reciptersOrdrList.listObject}">

                    <div class="order-title mt-8 md:mt-18">
                        <h2>가족회원 급여 상품 멤버스 승인 현황</h2>
                        <!-- <a href="#" class="btn btn-more">전체보기</a> -->
                    </div>

					<c:forEach items="${reciptersOrdrList.listObject}" var="ordrDtl" varStatus="status">
						<c:set var="pageParam" value="curPage=${reciptersOrdrList.curPage}${!empty(reciptersOrdrList.urlParam)? '&amp;' : ''}${reciptersOrdrList.urlParam}" />

						<c:set var="spOrdrOptn" value="${fn:split(ordrDtl.ordrOptn, '*')}" />

					<c:if test="${ordrDtl.ordrOptnTy eq 'BASE'}">

						<c:set var="sumOrdrPc" value="${ordrDtl.ordrPc }" />
						<c:set var="ordrQy" value="${ordrDtl.ordrQy }" />

						<%-- 통합 주문 번호 --%>
						<c:if test="${status.first}">

							<div class="order-product mt-3 md:mt-4">
								<div class="order-header">
									<div class="flex flex-col w-full gap-3">
										<%-- 2023-12-27:사업소명 --%>
										<dl class="order-item-business">
											<dt><span>사업소</span> <span>${ordrDtl.entrpsVO.entrpsNm}</span></dt>
										</dl>
										<%-- 2023-12-27:사업소명 --%>

										<c:if test="${ordrDtl.ordrTy eq 'R' || ordrDtl.ordrTy eq 'L'}">
											<%-- 급여구매일 경우만 경우만 멤버스(사업소) 있음 --%>
											<c:if test="${!empty ordrDtl.bplcInfo}">
												<dl class="large">
													<dt>멤버스</dt>
													<dd>${ordrDtl.bplcInfo.bplcNm}</dd>
												</dl>
											</c:if>
										</c:if>
										<div class="flex items-center w-full">
											<dl>
												<dt>주문번호</dt>
												<dd><strong><a href="./ordr/view/${ordrDtl.ordrCd}?${pageParam}">${ordrDtl.ordrCd}</a></strong></dd>
											</dl>
											<dl>
												<dt>주문일시</dt><%--주문/취소 --%>
												<dd><fmt:formatDate value="${ordrDtl.ordrDt}" pattern="yyyy.MM.dd HH:mm:ss" /></dd>
											</dl>
										</div>
									</div>
									<!-- <button type="button" class="f_all_rtrcn">전체취소</button> -->
								</div>
								<div class="order-body">
									<c:if test="${!empty ordrDtl.recipterUniqueId }">
									<%-- 베네핏 바이어 --%>
									<div class="order-buyer">
										<c:if test="${!empty ordrDtl.recipterInfo.proflImg}">
										<img src="/comm/proflImg?fileName=${ordrDtl.recipterInfo.proflImg}" alt="">
										</c:if>
										<strong>${ordrDtl.recipterInfo.mbrNm}</strong>
									</div>
									</c:if>
								</div>
							</div>
						</c:if>
						<%-- 통합 주문 번호 --%>


                            <div class="order-item order-item-mypage">
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
								 <div class="flex items-start w-full">
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

					<c:if test="${reciptersOrdrList.listObject[status.index+1].ordrOptnTy eq 'BASE' || status.last}">

                                    </div>
                                    <div class="order-item-count">
                                        <p><strong>${ordrQy}</strong>개</p>
                                        <%-- 배송 준비전 --%>
                                        <c:if test="${ordrDtl.sttsTy eq 'OR01'}"><!-- || ordrDtl.sttsTy eq 'OR04' -->
                                        <button type="button" class="btn btn-primary btn-small f_optn_chg" data-gds-no="${ordrDtl.gdsNo}" data-dtl-no="${ordrDtl.ordrDtlNo}" data-dtl-cd="${ordrDtl.ordrDtlCd}">변경</button>
                                        </c:if>
                                    </div>
                                    <p class="order-item-price"><span class="text-primary"><fmt:formatNumber value="${sumOrdrPc}" pattern="###,###" />원</span></p>
                                </div>

								<%-- 2023.12.27 :옵션추가 --%>
								<div class="item-option mb-4">
									<dl class="option">
										<dd>
											<span class="label-flat">분홍</span>
											<%-- <span class="label-flat">800g</span>
											<span>2개(+9,720원)</span>
											<button class="btn-delete2">삭제</button> --%>
										</dd>
										<dd>
											<span class="label-flat">삼계죽</span>
											<%-- <span class="label-flat">300g</span>
											<span >2개</span>
											<button class="btn-delete2">삭제</button> --%>
										</dd>
									</dl>
								</div>

									<div class="order-item-info">
                                        <div class="payment">
                                        	<c:if test="${ordrDtl.ordrTy eq 'R' || ordrDtl.ordrTy eq 'L'}"><%-- 급여구매일 경우만 경우만 멤버스(사업소) 있음 --%>
                                        	<c:if test="${!empty ordrDtl.bplcInfo}">
                                            <dl>
                                                <dt>멤버스</dt>
                                                <dd>${ordrDtl.bplcInfo.bplcNm }</dd>
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
                                       	<c:choose>
											<c:when test="${ordrDtl.sttsTy eq 'OR02'}"> <%-- 멤버스 승인완료 --%>
                                       		<div class="box-gradient">
                                                <div class="content">
                                                    <p class="flex-1">멤버스<br> 승인완료</p>
                                                    <div class="multibtn">
                                                        <a href="./ordr/view/${ordrDtl.ordrCd}?${pageParam}" class="btn btn-primary btn-small">결제진행</a>
                                                        <%-- <button type="button" class="btn btn-outline-primary btn-small f_ordr_rtrcn" data-ordr-cd="${ordrDtl.ordrCd}">주문취소</button> --%>
                                                    </div>
                                                </div>
                                            </div>
                                       		</c:when>
                                       		<c:when test="${ordrDtl.sttsTy eq 'OR03'}"> <%-- 멤버스 승인반려 --%>
                                       		<div class="box-gradient">
                                                <div class="content">
                                                    <p class="flex-1">멤버스<br> 승인반려</p>
                                                    <div class="multibtn">
                                                    	<button type="button" class="btn btn-primary btn-small f_partners_msg" data-ordr-no="${ordrDtl.ordrNo}" data-dtl-no="${ordrDtl.ordrDtlNo}">사유확인</button>
                                                    </div>
                                                </div>
                                            </div>
                                       		</c:when>
                                       		<c:when test="${ordrDtl.sttsTy eq 'OR04'}"> <%-- 결제대기 --%>
                                       		<div class="box-gray">
                                                <p class="flex-1">결제대기</p>
                                                <c:if test="${ordrTy eq 'R'}"><%-- 급여주문 --%>
                                                <div class="multibtn">
                                                    <a href="./ordr/view/${ordrDtl.ordrCd}?${pageParam}" class="btn btn-primary btn-small">결제진행</a>
                                                    <%-- <button type="button" class="btn btn-outline-primary btn-small f_ordr_rtrcn" data-ordr-cd="${ordrDtl.ordrCd}">주문취소</button> --%>
                                                </div>
                                                </c:if>
                                            </div>
                                       		</c:when>
                                       		<c:when test="${ordrDtl.sttsTy eq 'OR05'}"> <%-- 결제완료 --%>
												<div class="box-gray">
													<p class="flex-1">결제완료</p>
													<%-- <div class="multibtn">
														<button type="button" class="btn btn-outline-primary btn-small f_ordr_rtrcn" data-ordr-cd="${ordrDtl.ordrCd}">주문취소</button>
													</div> --%>
												</div>
                                       		</c:when>
                                       		<c:when test="${ordrDtl.sttsTy eq 'OR07'}"> <%-- 배송중 --%>
												<dl>
													<dt>배송중</dt>
													<dd><fmt:formatDate value="${ordrDtl.sndngDt}" pattern="yyyy-MM-dd" /></dd>
												</dl>

											<c:set var="dlvyUrl" value="#" />
                                            <c:forEach items="${dlvyCoList}" var="dlvyCoInfo" >
                                            	<c:if test="${dlvyCoInfo.coNo eq ordrDtl.dlvyCoNo}">
                                            	<c:set var="dlvyUrl" value="${dlvyCoInfo.dlvyUrl}" />
                                            	</c:if>
                                            </c:forEach>

                                            <a href="${dlvyUrl}${ordrDtl.dlvyInvcNo}" target="_blank" class="btn btn-delivery">
                                                <span class="name">
                                                    <img src="/html/page/market/assets/images/ico-delivery.svg" alt="">
                                                    ${ordrDtl.dlvyCoNm}
                                                </span>
                                                <span class="underline">${ordrDtl.dlvyInvcNo}</span>
                                            </a>
                                       		</c:when>
                                       		<c:when test="${ordrDtl.sttsTy eq 'OR08'}"> <%-- 배송완료 --%>
                                       		<div class="box-gray">
                                                <p class="flex-1">배송완료</p>
                                                <div class="multibtn">
                                                	<button type="button" class="btn btn-primary btn-small f_ordr_done" data-ordr-no="${ordrDtl.ordrNo}" data-dtl-cd="${ordrDtl.ordrDtlCd}" data-stts-ty="OR09" data-resn-ty="", data-resn="상품 구매확정" data-msg="마일리지가 적립됩니다.구매확정 처리하시겠습니까?">구매확정</button>
                                                    <button type="button" class="btn btn-outline-primary btn-small f_gds_exchng" data-dtl-cd="${ordrDtl.ordrDtlCd}" data-ordr-no="${ordrDtl.ordrNo}" >교환신청</button>
                                                </div>
                                            </div>
                                       		</c:when>
                                       		<c:when test="${ordrDtl.sttsTy eq 'CA01' || ordrDtl.sttsTy eq 'CA02'}"> <%-- 취소접수 & 취소완료 --%>
                                       		<div class="box-gray">
                                                <p class="flex-1">${ordrSttsCode[ordrDtl.sttsTy]}</p>
                                                <div class="multibtn">
                                                	<button type="button" class="btn btn-primary btn-small f_rtrcn_msg" data-ordr-no="${ordrDtl.ordrNo}" data-dtl-no="${ordrDtl.ordrDtlNo}" data-dtl-cd="${ordrDtl.ordrDtlCd}">취소 상세정보</button>
                                                </div>
                                            </div>
                                       		</c:when>
                                       		<c:when test="${ordrDtl.sttsTy eq 'EX01' || ordrDtl.sttsTy eq 'EX02' || ordrDtl.sttsTy eq 'EX03'}"> <%-- 교환 --%>
                                       		<div class="box-gray">
                                                <p class="flex-1">${ordrSttsCode[ordrDtl.sttsTy]}</p>
                                                <div class="multibtn">
                                                	<button type="button" class="btn btn-primary btn-small f_exchng_msg" data-ordr-no="${ordrDtl.ordrNo}" data-dtl-no="${ordrDtl.ordrDtlNo}" data-dtl-cd="${ordrDtl.ordrDtlCd}">교환 상세정보</button>
                                                </div>
                                            </div>
                                       		</c:when>
                                       		<c:when test="${ordrDtl.sttsTy eq 'RE01' || ordrDtl.sttsTy eq 'RE02' || ordrDtl.sttsTy eq 'RE03'}"> <%-- 반품 --%>
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

                    <%-- 통합 주문 번호 --%>
					<c:if test="${status.last || (ordrDtl.ordrCd ne reciptersOrdrList.listObject[status.index+1].ordrCd )}">
                        </div>

						<c:set var="ordrCancelBtn" value="false" />
						<c:if test="${ordrDtl.cancelBtn > 0}">
						<c:set var="ordrCancelBtn" value="true" />
						</c:if>
                        <c:if test="${(ordrCancelBtn || ordrDtl.returnBtn > 0)}">
                        <div class="order-footer">
                        	<c:if test="${ordrCancelBtn}">
                        	<button type="button" class="btn btn-outline-primary btn-small f_ordr_rtrcn" data-ordr-cd="${ordrDtl.ordrCd}">주문취소</button>
                        	</c:if>
                        	<c:if test="${ordrDtl.sttsTy eq 'OR08'}">
                            <button type="button" class="btn btn-outline-primary btn-small f_ordr_return" data-ordr-cd="${ordrDtl.ordrCd}">반품신청</button>
                            </c:if>
                        </div>
                        </c:if>

                    </div>
                    </c:if>
                    <c:if test="${!status.last && ordrDtl.ordrCd ne reciptersOrdrList.listObject[status.index+1].ordrCd}">

                    <div class="order-product mt-3 md:mt-4">
                        <div class="order-header">
								<c:if test="${reciptersOrdrList.listObject[status.index+1].ordrTy eq 'R' || reciptersOrdrList.listObject[status.index+1].ordrTy eq 'L'}">
									<%-- 급여구매일 경우만 경우만 멤버스(사업소) 있음 --%>
									<c:if test="${!empty reciptersOrdrList.listObject[status.index+1].bplcInfo}">
										<dl class="large">
											<dt>멤버스</dt>
											<dd>${reciptersOrdrList.listObject[status.index+1].bplcInfo.bplcNm}</dd>
										</dl>
									</c:if>
								</c:if>
								<dl>
                                <dt>주문번호</dt>
                                <dd><strong><a href="./ordr/view/${reciptersOrdrList.listObject[status.index+1].ordrCd}?${pageParam}">${reciptersOrdrList.listObject[status.index+1].ordrCd}</a></strong></dd>
                            </dl>
                            <dl>
                                <dt>주문일시</dt><%--주문/취소 --%>
                                <dd><fmt:formatDate value="${reciptersOrdrList.listObject[status.index+1].ordrDt}" pattern="yyyy.MM.dd HH:mm:ss" /><br></dd>
                            </dl>
                            <!-- <button type="button" class="f_all_rtrcn">전체취소</button> -->
                        </div>
                        <div class="order-body">
                        	<c:if test="${!empty reciptersOrdrList.listObject[status.index+1].recipterUniqueId }">
                        	<%-- 베네핏 바이어 --%>
                            <div class="order-buyer">
                                <c:if test="${!empty reciptersOrdrList.listObject[status.index+1].recipterInfo.proflImg}">
	                            <img src="/comm/proflImg?fileName=${reciptersOrdrList.listObject[status.index+1].recipterInfo.proflImg}" alt="">
	                            </c:if>
                                <strong>${reciptersOrdrList.listObject[status.index+1].recipterInfo.mbrNm}</strong>
                            </div>
                            </c:if>
					</c:if>
                    <%-- 통합 주문 번호 --%>
                    </c:if>

					</c:forEach>

					</c:if>


                </div>

                </c:if>
                <!-- //수급자 진행 주문 현황 -->

                <div class="space-y-12 md:space-y-25">
					<!-- 최근 구매 내역 -->
	                <div class="mypage-myinfo-recent">
	                    <div class="recent-title">
	                        <h2>최근 구매 내역</h2>
	                        <a href="./ordr/list" class="btn btn-more2">전체보기</a>
	                    </div>

	                    <div class="order-container space-y-5.5 md:space-y-7.5">
	                    	<c:if test="${empty ordrListVO.listObject }">
	                        <p class="box-result is-large">최근 6개월간 주문 내역이 없습니다</p>
	                        </c:if>

							<div class=""></div>

							<c:forEach items="${ordrListVO.listObject}" var="ordrDtl" varStatus="status">
							<c:set var="pageParam" value="curPage=${ordrListVO.curPage}${!empty(ordrListVO.urlParam)? '&amp;' : ''}${ordrListVO.urlParam}" />

							<c:set var="spOrdrOptn" value="${fn:split(ordrDtl.ordrOptn, '*')}" />

							<c:if test="${ordrDtl.ordrOptnTy eq 'BASE'}">

							<c:set var="sumOrdrPc" value="${ordrDtl.ordrPc }" />
							<c:set var="ordrQy" value="${ordrDtl.ordrQy }" />

							<%-- 통합 주문 번호 --%>
							<c:if test="${status.first}">

		                    <div class="order-product">
		                        <div class="order-header">
									<div class="flex flex-col w-full gap-3">
										<%-- 2023-12-27:사업소명 --%>
										<dl class="order-item-business">
											<dt><span>사업소</span> <span>${ordrDtl.entrpsVO.entrpsNm}</span></dt>
										</dl>
										<%-- 2023-12-27:사업소명 --%>
										<c:if test="${ordrDtl.ordrTy eq 'R' || ordrDtl.ordrTy eq 'L'}">
											<%-- 급여구매일 경우만 경우만 멤버스(사업소) 있음 --%>
											<c:if test="${!empty ordrDtl.bplcInfo}">
												<dl class="large">
													<dt>멤버스</dt>
													<dd>${ordrDtl.bplcInfo.bplcNm}</dd>
												</dl>
											</c:if>
										</c:if>
										<div class="flex items-center w-full">
											<dl>
												<dt>주문번호</dt>
												<dd><strong><a href="./ordr/view/${ordrDtl.ordrCd}?${pageParam}">${ordrDtl.ordrCd}</a></strong></dd>
											</dl>
											<dl>
												<dt>주문일시</dt><%--주문/취소 --%>
												<dd><fmt:formatDate value="${ordrDtl.ordrDt}" pattern="yyyy.MM.dd HH:mm:ss" /></dd>
											</dl>
										</div>
									</div>
		                            <!-- <button type="button" class="f_all_rtrcn">전체취소</button> -->
		                        </div>
		                        <div class="order-body">
		                        	<c:if test="${!empty ordrDtl.recipterUniqueId }">
									<%-- 베네핏 바이어 --%>
		                            <div class="order-buyer">
		                            	<c:if test="${!empty ordrDtl.recipterInfo.proflImg}">
			                            <img src="/comm/proflImg?fileName=${ordrDtl.recipterInfo.proflImg}" alt="">
			                            </c:if>
		                                <strong>${ordrDtl.recipterInfo.mbrNm}</strong>
		                            </div>
		                            </c:if>
									
							</c:if>
							<%-- 통합 주문 번호 --%>


		                            <div class="order-item order-item-mypage">
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
										<div class="flex items-start w-full">
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

							<c:if test="${ordrListVO.listObject[status.index+1].ordrOptnTy eq 'BASE' || status.last}">

		                                    </div>
		                                    <div class="order-item-count">
		                                        <p><strong>${ordrQy}</strong>개</p>
		                                        <%-- 배송 준비전 --%>
		                                        <c:if test="${ordrDtl.sttsTy eq 'OR01'}"><!-- || ordrDtl.sttsTy eq 'OR04' -->
		                                        <button type="button" class="btn btn-primary btn-small f_optn_chg" data-gds-no="${ordrDtl.gdsNo}" data-dtl-no="${ordrDtl.ordrDtlNo}" data-dtl-cd="${ordrDtl.ordrDtlCd}">변경</button>
		                                        </c:if>
		                                    </div>
		                                    <p class="order-item-price"><span class="text-primary"><fmt:formatNumber value="${sumOrdrPc}" pattern="###,###" />원</span></p>
		                                </div>

										<%-- 2023-12-27: 옵션디자인추가 --%>
										<div class="item-option mb-4">
											<dl class="option">
												<c:choose>
													<c:when test="${!empty ordrDtl.gdsOptnVO }"> <dd class="disabled"> </c:when>
													<c:otherwise>	<dd> </c:otherwise>
												</c:choose>
												<c:if test="${!empty spOrdrOptn[0]}">
													<c:forEach items="${spOrdrOptn}" var="ordrOptn">
													<span class="label-flat">${ordrOptn}</span>
													</c:forEach>
												</c:if>
													
													<span >2개(+9,720원)</span>
												</dd>
											</dl>
										</div>

											<div class="order-item-info">
		                                        <div class="payment">
		                                        	<c:if test="${ordrDtl.ordrTy eq 'R' || ordrDtl.ordrTy eq 'L'}"><%-- 급여구매일 경우만 경우만 멤버스(사업소) 있음 --%>
		                                        	<c:if test="${!empty ordrDtl.bplcInfo}">
		                                            <dl>
		                                                <dt>멤버스</dt>
		                                                <dd>${ordrDtl.bplcInfo.bplcNm }</dd>
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
		                                       	<c:choose>
													<c:when test="${ordrDtl.sttsTy eq 'OR02'}"> <%-- 멤버스 승인완료 --%>
		                                       		<div class="box-gradient">
		                                                <div class="content">
		                                                    <p class="flex-1">멤버스<br> 승인완료</p>
		                                                    <div class="multibtn">
		                                                        <a href="./ordr/view/${ordrDtl.ordrCd}?${pageParam}" class="btn btn-primary btn-small">결제진행</a>
		                                                        <%-- <button type="button" class="btn btn-outline-primary btn-small f_ordr_rtrcn" data-ordr-cd="${ordrDtl.ordrCd}">주문취소</button> --%>
		                                                    </div>
		                                                </div>
		                                            </div>
		                                       		</c:when>
		                                       		<c:when test="${ordrDtl.sttsTy eq 'OR03'}"> <%-- 멤버스 승인반려 --%>
		                                       		<div class="box-gradient">
		                                                <div class="content">
		                                                    <p class="flex-1">멤버스<br> 승인반려</p>
		                                                    <div class="multibtn">
		                                                    	<button type="button" class="btn btn-primary btn-small f_partners_msg" data-ordr-no="${ordrDtl.ordrNo}" data-dtl-no="${ordrDtl.ordrDtlNo}">사유확인</button>
		                                                    </div>
		                                                </div>
		                                            </div>
		                                       		</c:when>
		                                       		<c:when test="${ordrDtl.sttsTy eq 'OR04'}"> <%-- 결제대기 --%>
		                                       		<div class="box-gray">
		                                                <p class="flex-1">결제대기</p>
		                                                <c:if test="${ordrTy eq 'R'}"><%-- 급여주문 --%>
		                                                <div class="multibtn">
		                                                    <a href="./ordr/view/${ordrDtl.ordrCd}?${pageParam}" class="btn btn-primary btn-small">결제진행</a>
		                                                    <%-- <button type="button" class="btn btn-outline-primary btn-small f_ordr_rtrcn" data-ordr-cd="${ordrDtl.ordrCd}">주문취소</button> --%>
		                                                </div>
		                                                </c:if>
		                                            </div>
		                                       		</c:when>
		                                       		<c:when test="${ordrDtl.sttsTy eq 'OR05'}"> <%-- 결제완료 --%>
		                                       		<div class="box-gray">
		                                                <p class="flex-1">결제완료</p>
		                                                <%-- <div class="multibtn">
		                                                    <button type="button" class="btn btn-outline-primary btn-small f_ordr_rtrcn" data-ordr-cd="${ordrDtl.ordrCd}">주문취소</button>
		                                                </div> --%>
		                                            </div>
		                                       		</c:when>
		                                       		<c:when test="${ordrDtl.sttsTy eq 'OR07'}"> <%-- 배송중 --%>
		                                            <dl>
		                                                <dt>배송중</dt>
		                                                <dd><fmt:formatDate value="${ordrDtl.sndngDt}" pattern="yyyy-MM-dd" /></dd>
		                                            </dl>

													<c:set var="dlvyUrl" value="#" />
		                                            <c:forEach items="${dlvyCoList}" var="dlvyCoInfo" >
		                                            	<c:if test="${dlvyCoInfo.coNo eq ordrDtl.dlvyCoNo}">
		                                            	<c:set var="dlvyUrl" value="${dlvyCoInfo.dlvyUrl}" />
		                                            	</c:if>
		                                            </c:forEach>

		                                            <a href="${dlvyUrl}${ordrDtl.dlvyInvcNo}" target="_blank" class="btn btn-delivery">
		                                                <span class="name">
		                                                    <img src="/html/page/market/assets/images/ico-delivery.svg" alt="">
		                                                    ${ordrDtl.dlvyCoNm}
		                                                </span>
		                                                <span class="underline">${ordrDtl.dlvyInvcNo}</span>
		                                            </a>
		                                       		</c:when>
		                                       		<c:when test="${ordrDtl.sttsTy eq 'OR08'}"> <%-- 배송완료 --%>
		                                       		<div class="box-gray">
		                                                <p class="flex-1">배송완료</p>
		                                                <div class="multibtn">
		                                                	<button type="button" class="btn btn-primary btn-small f_ordr_done" data-ordr-no="${ordrDtl.ordrNo}" data-dtl-cd="${ordrDtl.ordrDtlCd}" data-stts-ty="OR09" data-resn-ty="", data-resn="상품 구매확정" data-msg="마일리지가 적립됩니다.구매확정 처리하시겠습니까?">구매확정</button>
		                                                    <button type="button" class="btn btn-outline-primary btn-small f_gds_exchng" data-dtl-cd="${ordrDtl.ordrDtlCd}" data-ordr-no="${ordrDtl.ordrNo}" >교환신청</button>
		                                                </div>
		                                            </div>
		                                       		</c:when>
		                                       		<c:when test="${ordrDtl.sttsTy eq 'CA01' || ordrDtl.sttsTy eq 'CA02'}"> <%-- 취소접수 & 취소완료 --%>
		                                       		<div class="box-gray">
		                                                <p class="flex-1">${ordrSttsCode[ordrDtl.sttsTy]}</p>
		                                                <div class="multibtn">
		                                                	<button type="button" class="btn btn-primary btn-small f_rtrcn_msg" data-ordr-no="${ordrDtl.ordrNo}" data-dtl-no="${ordrDtl.ordrDtlNo}" data-dtl-cd="${ordrDtl.ordrDtlCd}">취소 상세정보</button>
		                                                </div>
		                                            </div>
		                                       		</c:when>
		                                       		<c:when test="${ordrDtl.sttsTy eq 'EX01' || ordrDtl.sttsTy eq 'EX02' || ordrDtl.sttsTy eq 'EX03'}"> <%-- 교환 --%>
		                                       		<div class="box-gray">
		                                                <p class="flex-1">${ordrSttsCode[ordrDtl.sttsTy]}</p>
		                                                <div class="multibtn">
		                                                	<button type="button" class="btn btn-primary btn-small f_exchng_msg" data-ordr-no="${ordrDtl.ordrNo}" data-dtl-no="${ordrDtl.ordrDtlNo}" data-dtl-cd="${ordrDtl.ordrDtlCd}">교환 상세정보</button>
		                                                </div>
		                                            </div>
		                                       		</c:when>
		                                       		<c:when test="${ordrDtl.sttsTy eq 'RE01' || ordrDtl.sttsTy eq 'RE02' || ordrDtl.sttsTy eq 'RE03'}"> <%-- 반품 --%>
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

								<!--20231227:배송비 이동 : 기획안 확인해야 함 -->
								<div class="payment">
									<dl class="order-item-payment">
										<dd>배송비</dd>
										<dt class="delivery-charge">
											<c:if test="${ordrDtl.gdsInfo.dlvyCtTy eq 'FREE'}">
											무료배송
											</c:if>
											<c:if test="${ordrDtl.gdsInfo.dlvyCtTy ne 'FREE'}">
											<fmt:formatNumber value="${ordrDtl.gdsInfo.dlvyBassAmt}" pattern="###,###" />원
											</c:if>
										</dt>
									</dl>
								</div>

		                    <%-- 통합 주문 번호 --%>
							<c:if test="${status.last || (ordrDtl.ordrCd ne ordrListVO.listObject[status.index+1].ordrCd )}">
		                        </div>

								<c:set var="ordrCancelBtn" value="false" />
								<c:if test="${ordrDtl.cancelBtn > 0}">
								<c:set var="ordrCancelBtn" value="true" />
								</c:if>
		                        <c:if test="${(ordrCancelBtn || ordrDtl.sttsTy eq 'OR08')}">
		                        <div class="order-footer">
		                        	<c:if test="${ordrCancelBtn}">
		                        	<button type="button" class="btn btn-outline-primary btn-small f_ordr_rtrcn" data-ordr-cd="${ordrDtl.ordrCd}">주문취소</button>
		                        	</c:if>
		                        	<c:if test="${ordrDtl.sttsTy eq 'OR08'}">
		                            <button type="button" class="btn btn-outline-primary btn-small f_ordr_return" data-ordr-cd="${ordrDtl.ordrCd}">반품신청</button>
		                            </c:if>
		                        </div>
		                        </c:if>

		                    </div>
		                    </c:if>
		                    <c:if test="${!status.last && ordrDtl.ordrCd ne ordrListVO.listObject[status.index+1].ordrCd}">

		                    <div class="order-product">
		                        <div class="order-header">
								 <div class="flex flex-col w-full gap-3">

									<%-- 2023-12-27:사업소명 --%>
									<dl class="order-item-business">
										<dt><span>사업소</span> <span>${ordrDtl.entrpsVO.entrpsNm}</span></dt>
									</dl>
									<%-- 2023-12-27:사업소명 --%>

		                        <c:if test="${listVO.listObject[status.index+1].ordrTy eq 'R' || listVO.listObject[status.index+1].ordrTy eq 'L'}">
										<%-- 급여구매일 경우만 경우만 멤버스(사업소) 있음 --%>
										<c:if test="${!empty listVO.listObject[status.index+1].bplcInfo}">
											<dl class="large">
												<dt>멤버스</dt>
												<dd>${listVO.listObject[status.index+1].bplcInfo.bplcNm}</dd>
											</dl>
										</c:if>
									</c:if>
									<div class="flex items-center w-full">
										<dl>
											<dt>주문번호</dt>
											<dd><strong><a href="./ordr/view/${ordrListVO.listObject[status.index+1].ordrCd}?${pageParam}">${ordrListVO.listObject[status.index+1].ordrCd}</a></strong></dd>
										</dl>
										<dl>
											<dt>주문일시</dt><%--주문/취소 --%>
											<dd><fmt:formatDate value="${ordrListVO.listObject[status.index+1].ordrDt}" pattern="yyyy.MM.dd HH:mm:ss" /><br></dd>
										</dl>
									</div>
								</div>
		                            <!-- <button type="button" class="f_all_rtrcn">전체취소</button> -->
		                        </div>
		                        <div class="order-body">
		                        	<c:if test="${!empty ordrListVO.listObject[status.index+1].recipterUniqueId }">
		                        	<%-- 베네핏 바이어 --%>
		                            <div class="order-buyer">
		                                <c:if test="${!empty ordrListVO.listObject[status.index+1].recipterInfo.proflImg}">
			                            <img src="/comm/proflImg?fileName=${ordrListVO.listObject[status.index+1].recipterInfo.proflImg}" alt="">
			                            </c:if>
		                                <strong>${ordrListVO.listObject[status.index+1].recipterInfo.mbrNm}</strong>
		                            </div>
		                            </c:if>
							</c:if>
		                    <%-- 통합 주문 번호 --%>
		                    </c:if>

							</c:forEach>
	                    </div>
	                </div>
	                <!-- //최근 구매 내역 -->

	                <!--  나의 상품 후기 -->
	                <!-- <div class="mypage-myinfo-recent">
	                    <div class="recent-title">
	                        <h2>나의 상품 후기</h2>
	                        <a href="${_marketPath}/mypage/review/list" class="btn btn-more">전체보기</a>
	                        <p class="count">작성한 상품 후기 <strong>${reviewList.totalCount}</strong> 건</p>
	                    </div>
	                    <c:if test="${empty reviewList.listObject}"><p class="box-result is-large">최근 작성한 상품 후기가 없습니다</p></c:if>
						<c:forEach var="reviewList" items="${reviewList.listObject}">
		                    <div class="mypage-myinfo-review-item">
		                    	<c:if test="${reviewList.imgUseYn eq 'Y'}">
			                        <button type="button"  class="item-thumb photoReview" data-rv-no="${reviewList.gdsReivewNo}">
			                        	<c:set var="imgFile" value="${reviewList.imgFile}" />
			                        	<img src="/comm/getImage?srvcId=REVIEW&amp;upNo=${reviewList.gdsReivewNo}&amp;fileNo=${imgFile.fileNo}" alt="" >
			                        </button>
		                        </c:if>
		                        <div class="item-content">
		                            <p class="code">${reviewList.gdsCd}</p>
		                            <p class="name">${reviewList.ttl}</p>
		                            <p class="cont">${reviewList.cn}</p>
		                            <p class="date"><fmt:formatDate value="${reviewList.regDt}" pattern="yyyy-MM-dd" /></p>
		                        </div>
		                    </div>
	                    </c:forEach>
	                </div> -->
	                <!-- //나의 상품 후기 -->

	                <!-- 나의 상품 Q&A -->
	                <div class="mypage-myinfo-recent">
	                    <div class="recent-title">
	                        <h2>나의 상품 Q&amp;A</h2>
	                        <a href="${_marketPath}/mypage/gdsQna/list" class="btn btn-more">전체보기</a>
	                        <p class="count">답변 처리중인 질문 <strong>${qaList.totalCount}</strong> 건</p>
	                    </div>

						<c:if test="${empty qaList.listObject}"><p class="box-result is-large">최근 작성한 상품 Q&A가 없습니다</p></c:if>
	                    <c:forEach var="qaList" items="${qaList.listObject}">
		                    <div class="mypage-myinfo-qna-item">
		                        <div class="item-thumb">
		                        	<c:forEach var="fileList" items="${qaList.gdsImgList}">
		                            	<img src="/comm/getImage?srvcId=GDS&amp;upNo=${fileList.upNo}&amp;fileTy=THUMB&amp;fileNo=${fileList.fileNo}" alt="">
		                            </c:forEach>
		                        </div>
		                        <div class="item-product">
		                            <p class="code">${qaList.gdsCd}</p>
		                            <p class="name">${qaList.gdsNm}</p>
		                        </div>
		                        <div class="product-qnaitem">
		                            <div class="question">
		                                <span class="label-primary">
		                                    <span>${ansYnCode[qaList.ansYn]}</span>
		                                    <i></i>
		                                </span>
		                                <p class="subject">${qaList.qestnCn}</p>
		                                <p class="datetime"><fmt:formatDate value="${qaList.regDt}" pattern="yyyy-MM-dd" /></p>
		                            </div>
		                            <%--
		                            <div class="answer">
		                                <div class="context">${qaList.ansCn }</div>
		                                <button class="btn btn-fold">펼처보기</button>
		                            </div>
		                             --%>
		                        </div>
		                    </div>
	                    </c:forEach>


	                    <script>
	                        $('.product-qnaitem .answer .btn').on('click', function() {
	                            $(this).closest('.product-qnaitem').toggleClass('is-active');
	                        });
	                    </script>
	                </div>
	                <!-- //나의 상품 Q&A -->

	                <!-- 이벤트 응모 현황 -->
	                <div class="mypage-myinfo-recent">
	                    <div class="recent-title">
	                        <h2>이벤트 응모 현황</h2>
	                        <a href="${_marketPath}/mypage/event/list" class="btn btn-more">전체보기</a>
	                    </div>

						<c:if test="${empty eventList.listObject}"><p class="box-result is-large">최근 응모한 이벤트가 없습니다</p></c:if>
	                    <c:set var="getNow" value="<%=new java.util.Date()%>" />
						<div class="overflow-hidden space-y-5.5 md:space-y-7.5">
	                    <c:forEach var="eventList" items="${eventList.listObject}" varStatus="status">
							<div class="mypage-myinfo-event-item">
								<div class="item-thumb">
									<c:forEach var="fileList" items="${eventList.fileList}">
										<img src="/comm/getImage?srvcId=EVENT&amp;upNo=${eventList.eventNo}&amp;fileTy=THUMB&amp;fileNo=${fileList.fileNo}">
									</c:forEach>
								</div>
								<div class="item-content">
									<span class="label-outline-primary">
										<c:if test="${eventList.bgngDt <= getNow && getNow <= eventList.endDt}"><span>진행중</span></c:if>
										<c:if test="${getNow > eventList.endDt}"><span>종료</span></c:if>
										<i></i>
									</span>
									<p class="name"><a href="${_marketPath}/etc/event/view?eventNo=${eventList.eventNo}">${eventList.eventNm}</a></p>
									<p class="date"><fmt:formatDate value="${eventList.bgngDt}" pattern="yyyy-MM-dd" /> ~ <fmt:formatDate value="${eventList.endDt}" pattern="yyyy-MM-dd" /></p>
								</div>
								<div class="item-infomation">
									<dl>
										<dt>응모일</dt>
										<dd><fmt:formatDate value="${eventList.applctDt}" pattern="yyyy-MM-dd HH:mm:ss" /></dd>
									</dl>
									<dl>
										<dt>당첨자 발표</dt>
										<dd><fmt:formatDate value="${eventList.prsntnYmd}" pattern="yyyy-MM-dd HH:mm" /></dd>
									</dl>
								</div>
								<div class="item-status">
									<c:if test="${eventList.prsntnYmd <= getNow && eventList.przwinCount > 0}">
										<a href="${_marketPath}/etc/event/przwin_view?eventNo=${eventList.eventNo}" class="status2">당첨자 보기</a>
									</c:if>
								</div>
							</div>
	                    </c:forEach>
					</div>
	                </div>
	                <!-- //이벤트 응모 현황 -->
	        	</div>
            </div>

		</div>
		<div id="photoView"></div>


  		<!-- 주문취소 -->
        <div id="ordr-rtrcn"></div>
        <!-- 멤버스 반려 -->
        <div id="ordr-partners-msg"></div>
        <!-- 교환신청 -->
        <div id="ordr-exchng"></div>
        <!-- 반품신청 -->
        <div id="ordr-return"></div>
        <!-- 수량변경 -->
        <div id="ordr-optn-chg"></div>
        <!-- 취소/교환/반품 사유 -->
        <div id="ordr-rtrcn-msg"></div>
        <div id="ordr-exchng-msg"></div>
        <div id="ordr-return-msg"></div>

        <textarea class="ordredListJson" style="display: none;">
			${ordredListJson}
		</textarea>
        <textarea class="entrpsVOListJson" style="display: none;">
			${entrpsVOListJson}
		</textarea>
        <textarea class="codeMapJson" style="display: none;">
			${codeMapJson}
		</textarea>

    </main>

    <script>

    $("#viewFormat").text(viewKorean("${mbrVO.recipterInfo.bnefBlce}"));

	// 프로필 이미지 실시간 변경
	function setImageFromFile(input, expression) {
		    if (input.files && input.files[0]) {
		    var reader = new FileReader();
		    reader.onload = function (e) {
		    $(expression).attr('src', e.target.result);
		  }
		  reader.readAsDataURL(input.files[0]);
		  }
	}


    $(function(){

		// 프로필 사진
		$("#proflImg").change(function(e){
			var img = "${mbrVO.proflImg}";
			var imageFile = e.target.files[0];
			var imgFrm = $("#upfile");
			var formData = new FormData(imgFrm[0]);

			formData.append("imgFile",imageFile);

			setImageFromFile(this, "#uploadFile");

			$.ajax({
				type: 'post',
				url : '/market/mypage/proflImgChange.json',
				data: formData,
				dataType: 'json' ,
				processData: false,
				contentType: false,

			})
			.done(function(data){
				if(data.result==true){
					if(img == ''){
						location.reload();
					}
				}else{
					alert("프로필 편집 중 오류가 발생하였습니다. \n 관리자에게 문의바랍니다.");
					//console.log("요양번호, 수급자 성명 불일치 ERROR");
					//console.log(false);
				}
			})
			.fail(function(){
				alert("프로필 편집 중 오류가 발생하였습니다. \n 관리자에게 문의바랍니다.");
			})
		});

    	//포토 상품 후기
    	$(".photoReview").on("click",function(){
    		var no = $(this).data("rvNo");
    		//console.log(no);

    		$("#photoView").load("./photoReviewModal"
    				, {gdsReivewNo : no}
    				, function(){
    					$("#modal-photo").addClass("fade").modal("show");
    		});
    	});

    	// 수급자정보 펼치기
    	$(".showRecipter").on("click",function(){
    		if($(".mypage-myinfo").hasClass("is-active")){
    			$(".mypage-myinfo").removeClass("is-active");
    		}else{
    			$(".mypage-myinfo").addClass("is-active");
    		}
    	});

    	// 닫기
    	$(".f_display_recipter").on("click",function(){
    		$(".mypage-myinfo").removeClass("is-recipient is-active");
    	});

    	// 요양정보 업데이트
   		$("#updReBtn").on("click",function(){
			$.ajax({
				type: 'post',
				url : '/market/mypage/updateRecipter.json',
				dataType: 'json' ,
			})
			.done(function(data){
				if(data.result==true){
					location.reload();
				}else{
					console.log(data.result);
				}
			})
			.fail(function(){
				alert("요양정보 업데이트 중 오류가 발생하였습니다. \n 관리자에게 문의바랍니다.");
			})
   		});


   	// 주문취소 모달
		$(document).on("click", ".f_ordr_rtrcn", function(){
			const ordrCd = $(this).data("ordrCd");
    		$("#ordr-rtrcn").load("${_marketPath}/mypage/ordr/ordrRtrcn",
   				{ordrCd:ordrCd
    			}, function(){
        			$("#ordr-rtrcn-modal").modal('show');
    			});
    	});

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
        			$("#optn-chg-modal").modal('show');
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

		// 반품 메세지
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


		// 주문현황 진행중 > 무지개 테두리
		for(var z=1; z < 8; z++){
			if($("#seq"+z).data("seqNumber") > 0){
				$(".seq"+z).addClass("is-gradient");
			}
		}

		// 수급자 회원정보 열기
		$('.mypage-myinfo.is-recipient .myinfo-user .desc .btn-primary').on('click', function() {
			$('.mypage-myinfo.is-recipient').toggleClass('is-active');
			return false;
		});
    });
    </script>

	<script type="text/javascript" src="/html/page/market/assets/script/JsMarketOrdredDrawItems.js?v=<spring:eval expression="@version['assets.version']"/>"></script>
	<script type="text/javascript" src="/html/page/market/assets/script/JsMarketMypageIndex.js?v=<spring:eval expression="@version['assets.version']"/>"></script>
    <script>
        var jsMarketMain = null;
		$(document).ready(function() {
            jsMarketMain = new JsMarketMypageIndex(' .order-container', $("textarea.ordredListJson").val(), $("textarea.entrpsVOListJson").val(), $("textarea.codeMapJson").val());
        });
    </script>