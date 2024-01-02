<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

	<main id="container">
		<jsp:include page="../layout/page_header.jsp">
			<jsp:param value="주문 결제" name="pageTitle"/>
		</jsp:include>

		<form:form modelAttribute="ordrVO" name="frmOrdr" id="frmOrdr" method="post" action="./ordrPayAction" enctype="multipart/form-data">
		<form:hidden path="ordrTy" />
		<form:hidden path="ordrCd" />

		<%--2023-03-23 더블 서브밋 방지 추가 --%>
        <double-submit:preventer tokenKey="preventTokenKey" />

		<div id="page-container">
			
            <div id="page-content">
                <h3 class="text-title mb-3 md:mb-4">상품 정보</h3>

				<div id="cart-content" class="order-item-box">

				</div>

                <div class="mb-9 space-y-6 md:mb-12 md:space-y-7.5">

            	<c:set var="totalDlvyBassAmt" value="0" />
                <c:set var="totalCouponAmt" value="0" />
                <c:set var="totalAccmlMlg" value="0" />
                <c:set var="totalOrdrPc" value="0" />
				<c:set var="dtlIndex" value="0" />
				<c:forEach items="${ordrDtlList}" var="ordrDtl" varStatus="status">
					<c:set var="spOrdrOptn" value="${fn:split(ordrDtl.ordrOptn, '*')}" />

					<c:if test="${ordrDtl.ordrOptnTy eq 'BASE'}">
					<c:set var="dtlIndex" value="${dtlIndex+1}" />
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


					<c:if test="${ordrDtlList[status.index+1].ordrOptnTy eq 'BASE' || status.last}">
									</div>

									<div class="order-item-count">
		                                <p><strong>${ordrDtl.ordrQy}</strong>개</p>
		                            </div>
		                            <p class="order-item-price pcList${dtlIndex}"><span class="text-primary"><fmt:formatNumber value="${sumOrdrPc}" pattern="###,###" />원</span></p>

									<div class="order-item-info">
                                        <div class="payment">
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
                                            <%-- 추가 배송비 -> 도서산간비용, 노출x
                                            <c:if test="${ordrDtl.gdsInfo.dlvyAditAmt > 0}">
                                            <dl>
                                                <dt>추가 배송비</dt>
                                                <dd><fmt:formatNumber value="${ordrDtl.gdsInfo.dlvyAditAmt}" pattern="###,###" />원</dd>
                                            </dl>
                                            </c:if>
                                            --%>

                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>

                	</c:if>

					<%-- 주문정보 ALL START --%>
					<div class="${ordrVO.ordrCd}_${dtlIndex}">
						<%-- 배송비 + 추가배송비 --%>

						<%-- <c:set var="totalDlvyBassAmt" value="${totalDlvyBassAmt + (ordrDtl.ordrOptnTy eq 'BASE'?(ordrDtl.gdsInfo.dlvyBassAmt + ordrDtl.gdsInfo.dlvyAditAmt):0)}" /> --%>
						<c:set var="totalDlvyBassAmt" value="${totalDlvyBassAmt + (ordrDtl.ordrOptnTy eq 'BASE'?ordrDtl.gdsInfo.dlvyBassAmt:0)}" />
						<c:set var="totalDlvyAditAmt" value="${totalDlvyAditAmt + (ordrDtl.ordrOptnTy eq 'BASE'?ordrDtl.gdsInfo.dlvyAditAmt:0)}" />


						<%-- 적립예정마일리지 --%>
	                    <c:set var="totalAccmlMlg" value="${totalAccmlMlg + ordrDtl.accmlMlg}" />
	                    <%-- 주문금액 + 옵션금액 --%>
	                    <c:set var="totalOrdrPc" value="${totalOrdrPc + ordrDtl.ordrPc}" />


						<%-- 배열 --%>
						<input type="hidden" name="ordrDtlCd" value="${ordrVO.ordrCd}_${dtlIndex}">
						<input type="hidden" name="gdsNo" value="${ordrDtl.gdsNo }">
						<input type="hidden" name="gdsCd" id="gdsCd_${ordrDtl.ordrOptnTy}_${dtlIndex}" value="${ordrDtl.gdsCd }">
						<input type="hidden" name="gdsNm" value="${ordrDtl.gdsNm }">
						<input type="hidden" name="gdsPc" value="${ordrDtl.gdsPc }">
						<input type="hidden" name="bnefCd" value="${ordrDtl.bnefCd }">

						<input type="hidden" name="gdsOptnNo" value="${ordrDtl.gdsOptnNo }">
						<input type="hidden" name="ordrOptnTy" value="${ordrDtl.ordrOptnTy }">
						<input type="hidden" name="ordrOptn" value="${ordrDtl.ordrOptn }">
						<input type="hidden" name="ordrOptnPc" value="${ordrDtl.ordrOptnPc }">
						<input type="hidden" name="ordrQy" id = "ordrQy_${ordrDtl.ordrOptnTy}_${dtlIndex}" value="${ordrDtl.ordrQy }">
						<input type="hidden" name="dlvyBassAmt" id="dlvyBassAmt_${ordrDtl.ordrOptnTy}_${ordrDtl.gdsNo}_${dtlIndex}" value="${ordrDtl.ordrOptnTy eq 'BASE'?ordrDtl.gdsInfo.dlvyBassAmt:0}"> <%--배송비 > 추가옵션일경우 제외 --%>
						<input type="hidden" name="plusDlvyBassAmt" id="plusDlvyBassAmt_${ordrDtl.ordrOptnTy}_${ordrDtl.gdsNo}_${dtlIndex}" value="${ordrDtl.ordrOptnTy eq 'BASE'?ordrDtl.gdsInfo.dlvyBassAmt:0}"> <%--배송비 > 할인초기화를 위한 여분 --%>

						<%--추가 배송비 > 추가옵션일경우 제외 --%>
						<%-- <input type="hidden" name="dlvyAditAmt" value="${ordrDtl.ordrOptnTy eq 'BASE'?ordrDtl.gdsInfo.dlvyAditAmt:0}"> --%>
						<input type="hidden" name="dlvyAditAmt" value="${ordrDtl.gdsInfo.dlvyAditAmt}"><%--기본 0원--%>

						<input type="hidden" name="ordrPc" id="ordrPc_${ordrDtl.ordrOptnTy}_${ordrDtl.gdsNo}_${dtlIndex}" value="${ordrDtl.ordrPc}"> <%--건별 주문금액--%>
						<input type="hidden" name="plusOrdrPc" id="plusOrdrPc_${ordrDtl.ordrOptnTy}_${ordrDtl.gdsNo}_${dtlIndex}" value="${ordrDtl.ordrPc }"> <%--건별 주문금액 초기화를 위한 여분--%>

						<input type="hidden" name="couponNo" id="couponNo_${ordrDtl.ordrOptnTy}_${ordrDtl.gdsNo}_${dtlIndex}" value=""> <%--쿠폰번호 > 쿠폰선택 시점에서 채워줌 --%>
	                    <input type="hidden" name="couponCd" id="couponCd_${ordrDtl.ordrOptnTy}_${ordrDtl.gdsNo}_${dtlIndex}" value=""> <%--쿠폰코드 > 쿠폰선택 시점에서 채워줌 --%>
	                    <input type="hidden" name="couponAmt" id="couponAmt_${ordrDtl.ordrOptnTy}_${ordrDtl.gdsNo}_${dtlIndex}" value="0"> <%--쿠폰적용 금액 > 쿠폰선택 시점에서 채워줌 --%>

	                    <input type="hidden" name="recipterUniqueId" value="${ordrDtl.recipterUniqueId}">
	                    <input type="hidden" name="bplcUniqueId" value="${ordrDtl.bplcUniqueId}">

	                    <c:if test="${ordrDtl.gdsInfo.mlgPvsnYn eq 'Y' && ordrVO.ordrTy eq 'N'}">
	                    <input type="hidden" name="accmlMlg" value="<fmt:formatNumber type="number" maxFractionDigits="0"  value="${(ordrDtl.gdsInfo.pc * ordrDtl.ordrQy) * (_mileagePercent / 100)}" />"> <%--마일리지 > 비급여제품 + 마일리지 제공 제품--%>
	                    </c:if>

	                    <%--묶음체크--%>
	                    <input type="hidden" name="dlvyGroupYn" value="${ordrDtl.gdsInfo.dlvyGroupYn}" />
	                    <input type="hidden" name="entrpsNo" value="${ordrDtl.gdsInfo.entrpsNo}" />
					</div>
				</c:forEach>
				</div>

                <h3 class="text-title mt-18 mb-3 md:mb-4 md:mt-23">고객 정보</h3>
                <div class="md:flex md:space-x-6 lg:space-x-7.5">
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
                            <dd>${_mbrSession.mbrNm }</dd>
                        </dl>
                        <dl>
                            <dt>휴대폰번호</dt>
                            <dd>${_mbrSession.mblTelno }</dd>
                        </dl>
                        <dl>
                            <dt>이메일주소</dt>
                            <dd>${_mbrSession.eml}</dd>
                        </dl>
                    </div>
                    <div class="flex-1 pt-2 space-y-2 md:space-y-3.5">
                        <p class="text-alert">
                            고객정보로 주문과 관련된 이메일이 발송됩니다.<br>
                            정확한 정보인지 확인해 주세요.
                        </p>
                        <p class="text-alert">회원정보 수정은 마이페이지에서 가능합니다.</p>
                    </div>
                </div>

                <div class="flex items-center mt-18 mb-3 md:mb-4 md:mt-23">
                    <h3 class="text-title">배송지 정보</h3>
                    <div class="form-check mt-0.5 ml-3 md:ml-4">
                        <input class="form-check-input" type="checkbox" id="newDvly">
                        <label class="form-check-label" for="newDvly">신규 배송지</label>
                    </div>
                </div>
                <table class="table-detail">
                    <colgroup>
                        <col class="w-25 md:w-40">
                        <col>
                    </colgroup>
                    <tbody>
                        <tr class="top-border">
                            <td></td>
                            <td></td>
                        </tr>
                        <tr>
                            <th scope="row"><p><label for="deli-item1">배송지 선택</label></p></th>
                            <td>
                                <div class="form-group w-76">
                                    <button type="button" class="btn btn-primary" id="dlvyMngBtn">배송지 목록</button>
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <th scope="row"><p><label for="recptrNm"></label>받는 사람 <sup class="text-danger text-base md:text-lg">*</sup></p></th>
                            <td>
                                <form:input class="form-control w-57" path="recptrNm" value="${bassDlvyVO.nm}"/>
                            </td>
                        </tr>
                        <tr>
                            <th scope="row"><p><label for="recptrMblTelno"></label>휴대폰번호 <sup class="text-danger text-base md:text-lg">*</sup></p></th>
                            <td>
                                <form:input class="form-control w-57" path="recptrMblTelno" value="${bassDlvyVO.mblTelno}" oninput="autoHyphen(this);" maxlength="13"/>
                            </td>
                        </tr>
                        <tr>
                            <th scope="row"><p><label for="recptrTelno"></label>전화번호</p></th>
                            <td>
                                <form:input class="form-control w-57" path="recptrTelno" value="${bassDlvyVO.telno}" oninput="autoHyphen(this);" maxlength="13"/>
                            </td>
                        </tr>
                        <tr>
                            <th scope="row"><p><label for="findAdres"></label>주소<sup class="text-danger text-base md:text-lg">*</sup></p></th>
                            <td>
                                <div class="form-group w-76">
                                    <form:input class="form-control" path="recptrZip" value="${bassDlvyVO.zip}" />
                                    <button type="button" class="btn btn-primary" id="findAdres" onclick="f_findAdres('recptrZip', 'recptrAddr', 'recptrDaddr'); return false;">우편번호 검색</button>
                                </div>
                                <form:input class="form-control mt-1.5 w-full lg:mt-2" path="recptrAddr" value="${bassDlvyVO.addr}" />
                                <form:input class="form-control mt-1.5 w-full lg:mt-2" path="recptrDaddr" value="${bassDlvyVO.daddr}" />
                            </td>
                        </tr>
                        <tr>
                            <th scope="row"><p><label for="deli-item7"></label>배송 메시지</p></th>
                            <td>
							<div class="flex flex-wrap">
								<select id="selMemo" name="selMemo" class="form-control w-60">
									<option value="">배송메세지</option>
									<option value="문 앞에 놓아주세요">문 앞에 놓아주세요</option>
									<option value="직접 받겠습니다 (부재시 문 앞)">직접 받겠습니다 (부재시 문 앞)</option>
									<option value="경비실에 보관해 주세요">경비실에 보관해 주세요</option>
									<option value="택배함에 넣어주세요">택배함에 넣어주세요</option>
									<option value="직접입력">직접입력</option>
								</select>
								<form:input class="form-control w-full sm:flex-1 mt-1.5 sm:mt-0 sm:ml-2 sm:w-auto" path="ordrrMemo" maxlength="25" style="display:none;" placeholder="배송 요청 사항 입력(25자 이내)" />
							</div>
					</td>
                        </tr>
                        <tr class="bot-border">
                            <td></td>
                            <td></td>
                        </tr>
                    </tbody>
                </table>


				<c:if test="${ordrVO.ordrTy eq 'N' }"> <%-- 비급여 주문일 경우만 할인 적용 --%>


                <div class="flex items-center justify-between mt-18 mb-3 md:mb-4 md:mt-23">
                    <h3 class="text-title">할인혜택</h3>
                    <button type="button" class="btn btn-refresh2 is-reverse f_reset">할인혜택 초기화</button>
                </div>
                <table class="table-detail">
                    <colgroup>
                        <col class="w-25 md:w-40">
                        <col>
                    </colgroup>
                    <tbody>
                        <tr class="top-border">
                            <td></td>
                            <td></td>
                        </tr>
                        <tr>
                            <th scope="row"><p><label for="discount-item1">상품할인쿠폰</label></p></th>
                            <td>
                                <div class="form-group w-78">
                                    <input type="text" class="form-control" id="totalCouponAmt" name="totalCouponAmt" value="0" readonly="true">
                                    <span>원</span>
                                    <button type="button" class="btn btn-primary ml-1 w-25 md:ml-4 md:w-30 f_use_coupon" >쿠폰사용</button>
                                </div>
                                &nbsp;&nbsp;
                                <span>잔여 쿠폰 : <fmt:formatNumber value="${remindCouponCount}" pattern="###,###" /> 장</span>
                            </td>
                        </tr>
                        <tr>
                            <th scope="row"><p><label for="discount-item2">포인트</label></p></th>
                            <td>
                                <div class="form-group w-78">
                                    <form:input class="form-control" path="usePoint" readonly="true" />
                                    <span>원</span>
                                    <button type="button" class="btn btn-primary ml-1 w-25 md:ml-4 md:w-30 f_use_point">포인트사용</button>
                                </div>
                                &nbsp;&nbsp;
                                <span>잔여 포인트 : <fmt:formatNumber value="${remindPoint}" pattern="###,###" /> 원</span>
                            </td>
                        </tr>
                        <tr>
                            <th scope="row"><p><label for="discount-item3">마일리지</label></p></th>
                            <td>
                                <div class="form-group w-78">
                                    <form:input class="form-control" path="useMlg" readonly="true" />
                                    <span>원</span>
                                    <button type="button" class="btn btn-primary ml-1 w-25 md:ml-4 md:w-30 f_use_mlg">마일리지사용</button>
                                </div>
                                &nbsp;&nbsp;
                                <span>잔여 마일리지 : <fmt:formatNumber value="${remindMlg}" pattern="###,###" /> 원</span>
                            </td>
                        </tr>
                        <tr class="bot-border">
                            <td></td>
                            <td></td>
                        </tr>
                    </tbody>
                </table>
                </c:if>


                <h3 class="text-title mt-18 mb-3 md:mb-4 md:mt-23">최종 결제금액 확인</h3>
                <div class="payment-result">
                    <div class="result-price">
                        <div class="container">
                            <dl>
                                <dt>총 주문상품금액</dt>
                                <dd><strong><fmt:formatNumber value="${totalOrdrPc}" pattern="###,###" /></strong> 원</dd>
                            </dl>
                            <c:if test="${ordrVO.ordrTy eq 'N'}">
                            <dl>
                                <dt>쿠폰</dt>
                                <dd><strong class="text-danger total-coupon-txt">0</strong> 원</dd>
                            </dl>
                            <dl>
                                <dt>마일리지/포인트</dt>
                                <dd><strong class="text-danger total-mlg-txt">0</strong> 원</dd>
                            </dl>
                            </c:if>
                            <dl>
                                <dt>배송비</dt>
                                <dd><strong class="total-dlvy-txt"><fmt:formatNumber value="${totalDlvyBassAmt}" pattern="###,###" /></strong> 원</dd>
                            </dl>
                            <dl id="total-dlvyAdit-dl" ${totalDlvyAditAmt>0?'':'style="display:none"'}>
                                <dt>도서산간 추가 배송비</dt>
                                <dd><strong class="total-dlvyAdit-txt"><fmt:formatNumber value="${totalDlvyAditAmt}" pattern="###,###" /></strong> 원</dd>
                            </dl>
                        </div>
                        <dl class="last">
                            <dt>최종 결제금액</dt>
                            <dd><strong class="total-stlmAmt-txt"><fmt:formatNumber value="${totalOrdrPc + totalDlvyBassAmt + totalDlvyAditAmt}" pattern="###,###" /></strong> 원</dd>
                        </dl>
                    </div>
                    <div class="result-agree">
                        <dl>
                            <dt>구매자 동의</dt>
                            <dd>
                                주문할 상품의 상품명, 상품가격, 배송정보를 확인하였으며, 구매에 동의 하시겠습니까?<br>
                                (전자상거래법 제 8조 2항)
                            </dd>
                        </dl>
                        <div class="form-check">
                            <input class="form-check-input" type="checkbox" id="buyAgree" name="buyAgree" value="Y">
                            <label class="form-check-label" for="buyAgree">동의 합니다.</label>
                        </div>

                        <button type="submit" class="btn btn-payment btn-large">결제하기</button>
                    </div>
                </div>
            </div>
		</div>

        <form:hidden path="delngNo" />
        <form:hidden path="stlmYn" value="N" />
        <form:hidden path="stlmAmt" value="${totalOrdrPc + totalDlvyBassAmt + totalDlvyAditAmt}" /><%-- 도서산간지역 배송비 추가 --%>
        <form:hidden path="stlmKnd" />
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
       	<form:hidden path="cartGrpNos" value="${cartGrpNos}" />

		</form:form>


		<!-- 배송지 -->
		<div id="dlvyView"></div>
        <!-- //배송지 -->


        <!-- 쿠폰사용 -->
		<div id="use-coupon"></div>
        <!-- //쿠폰사용 -->

        <!-- 포인트사용 -->
		<div id="use-point"></div>
        <!-- //포인트사용 -->

        <!-- 마일리지사용 -->
		<div id="use-mlg"></div>
        <!-- //마일리지사용 -->


		<textarea class="cartListJson" style="display: none;">
			${cartListJson}
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

	<script type="text/javascript" src="/html/page/market/assets/script/JsMarketOrdrPay.js?v=<spring:eval expression="@version['assets.version']"/>"></script>

    <script>
		var jsMarketOrdrPay = null;
		$(document).ready(function() {
			var path = {_membershipPath:"${_membershipPath}", _marketPath:"${_marketPath}"};
	
			jsMarketOrdrPay = new JsMarketOrdrPay($("form#frmOrdr input#ordrTy").val()
												, path
												, {
													  "loginCheck":${_mbrSession.loginCheck}
													, "mbrId":"${_mbrSession.mbrId}"
													, "mbrNm":"${_mbrSession.mbrNm}"
													, "mblTelno":"${_mbrSession.mblTelno}"
													, "eml":"${_mbrSession.eml}"
												}
												, $("textarea.cartListJson").val()
												, $("textarea.entrpsDlvyGrpVOListJson").val()
												, $("textarea.entrpsVOListJson").val()
												, $("textarea.codeMapJson").val()
												
											);
	
			
		});
	function f_heartbeat() {
		console.log(new Date)
		$.ajax({
			type : "post",
			url  : "${_mainPath}/heartbeat.json",
			dataType : 'json'
		}).done(function(json) {
		});
	}
		
	let timerId = setTimeout(f_heartbeat, 10 * 60 * 1000);
		
    var ordrQy = [];

    function f_calStlmAmt(){
    	let stlmAmt = 0; $("input[name='ordrPc']").each(function(){ stlmAmt += Number($(this).val()) });
    	let dlvyBassAmt = 0; $("input[name='dlvyBassAmt']").each(function(){ dlvyBassAmt += Number($(this).val()) });
    	let plusDlvyBassAmt = 0; $("input[name='plusDlvyBassAmt']").each(function(){ plusDlvyBassAmt += Number($(this).val()) });
    	let dlvyAditAmt = 0; $("input[name='dlvyAditAmt']").each(function(){ dlvyAditAmt += Number($(this).val()) });
    	let useMlg = uncomma($("#frmOrdr #useMlg").val());
    	let usePoint = uncomma($("#frmOrdr #usePoint").val());
    	let totalCouponAmt = $("#frmOrdr #totalCouponAmt").val();
    	let calStlmAmt = 0;

    	/*console.log("totalCouponAmt> ", totalCouponAmt, useMlg, usePoint, stlmAmt);
    	console.log("배송비 : " + dlvyBassAmt);
    	console.log("쿠폰비 : " + totalCouponAmt.toString().replace(",",""));*/

    	if(totalCouponAmt != null){
    		totalCouponAmt = totalCouponAmt.toString().replace(",","");
    	}

    	calStlmAmt = (Number(stlmAmt) + Number(plusDlvyBassAmt) + Number(dlvyAditAmt)) - Number(useMlg) - Number(usePoint) - Number(totalCouponAmt);

    	//console.log("calStlmAmt> ", calStlmAmt);


    	$("input[name='mbrMlg']").remove();
    	mlgMap.forEach(function(value, key){
    		let v = key +"|"+ value;
    		$("#frmOrdr").append('<input type="hidden" name="mbrMlg" value="'+ v +'" >'); // 회원마일리지
    	});

    	$("input[name='mbrPoint']").remove();
    	pointMap.forEach(function(value, key){
    		let v = key +"|"+ value;
    		$("#frmOrdr").append('<input type="hidden" name="mbrPoint" value="'+ v +'" >'); // 회원포인트
    	});

    	$("#frmOrdr #stlmAmt").val(calStlmAmt);
    	$("#frmOrdr .total-stlmAmt-txt").text(comma(calStlmAmt));
    }


    async function f_pay(frm){
    	let stlmAmt = $("#stlmAmt").val();
    	//console.log('결제금액: ', stlmAmt);

    	if(stlmAmt > 0){
	    	//async
	    	try {
	   	    	//결제요청
	   	    	const response = await Bootpay.requestPayment({
	   	    		  "application_id": "${_bootpayScriptKey}",
	   	    		  "price": stlmAmt,
	   	    		<c:choose>
	   	    			<c:when test="${ordrDtlList.size()>1}">
	   	    			"order_name": "${ordrDtlList[0].gdsInfo.gdsNm} 외 ${ordrDtlList.size()-1}건",
	   	    			</c:when>
	   	    			<c:otherwise>
	   	    			"order_name": "${ordrDtlList[0].gdsInfo.gdsNm}",
	   	    			</c:otherwise>
	   	    		</c:choose>
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
	   	    		  /* "items": [
						<c:forEach items="${ordrDtlList}" var="ordrDtl" varStatus="status">
	   	    		    {
	   	    		      "id": "${ordrDtl.gdsInfo.gdsCd}",
	   	    		      "name": "${ordrDtl.gdsInfo.gdsNm}",
	   	    		      "qty": ${ordrDtl.ordrQy},
	   	    		      "price": ${ordrDtl.gdsPc + ordrDtl.ordrOptnPc}
	   	    		    }
	   	    		    <c:if test="${!status.last}">,</c:if>
	   	    		    </c:forEach>
	   	    		  ], */
	   	    		  "extra": {
	   	    		    "open_type": "iframe",
	   	    		   // "card_quota": "0,2,3",
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

			            if(confirmedData.event === 'done') {
							const stlmDt = confirmedData.data.purchased_at;
							const delngNo = confirmedData.data.receipt_id; // : 거래번호 => DELNG_NO
							const stlmKnd = confirmedData.data.method_symbol.toUpperCase(); // 결테타입 : CARD  => stlmKnd
							const stlmTy = confirmedData.data.method_origin_symbol; // 결테타입 : CARD  => STLM_TY

							$("#delngNo").val(delngNo);
				            $("#stlmKnd").val(stlmKnd);
							$("#stlmTy").val(stlmTy);
				            $("#stlmDt").val(stlmDt);

				            if(stlmKnd === "CARD"){ //CARD
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
							const stlmKnd = confirmedData.data.method_symbol.toUpperCase(); // 결테타입 : CARD  => stlmKnd

							$("#delngNo").val(delngNo);
							$("#stlmKnd").val(stlmKnd);
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

    	} else {

    		$("#stlmYn").val("Y");
			$("#stlmKnd").val("FREE");
    		$("#stlmTy").val("FREE");
    		frm.submit();
    	}
    }

    // 주소호출 콜백
    function f_findAdresCallback(){
    	let zipcode = $("#recptrZip").val();
    	$.ajax({
			type : "post",
			url  : "/comm/dlvyCt/chkRgn.json",
			data : {
				zip : zipcode
			},
			dataType : 'json'
		})
		.done(function(data) {
			if(data.result){
				let entrpsMap = new Map();
				$("input[name='entrpsNo']").each(function(i,o){

					if($(this).val() > 0){
						const dlvyGroupYn = $(this).siblings("input[name='dlvyGroupYn']").val();
						if(!entrpsMap.get("chkEntrps"+$(this).val()) || dlvyGroupYn === "N"){//묶음x or 동일업체x
							entrpsMap.set("chkEntrps"+$(this).val(), true);
							$(this).siblings("input[name='dlvyAditAmt']").val(5000);
						}
					}else{ //0이면 업체지정x
						$(this).siblings("input[name='dlvyAditAmt']").val(5000);
					}
				});
				let dlvyAditAmt = 0;
				$("input[name='dlvyAditAmt']").each(function(){
					dlvyAditAmt += Number($(this).val());
				});
				$(".total-dlvyAdit-txt").text(comma(dlvyAditAmt));
				$("#total-dlvyAdit-dl").css({"display":"flex"});
			}else{
				$("input[name='dlvyAditAmt']").val(0);
				$(".total-dlvyAdit-txt").text(0);
				$("#total-dlvyAdit-dl").css({"display":"none"});
			}
			f_calStlmAmt();
	    })
		.fail(function(data, status, err) {
			console.log('error forward : 산간지역 체크 실패');
		});
    }


    const mlgMap = new Map();
    const pointMap = new Map();
    $(function(){

       	// 상품 가격 배열
    	var arrOrdrPc = [];
    	for(var i=0; i < $(".order-product").length; i++){
    		arrOrdrPc.push($(".pcList"+(i+1)).text().replaceAll(',',''));
    	}

    	// 신규배송지
    	$("#newDvly").on("click", function(){
    		let isChecked = $(this).is(":checked");
    		if(isChecked){
	    		$("input[name^='recptr']").val("");
    		}
    	});

    	// 배송지 모달
    	$("#dlvyMngBtn").on("click",function(){
    		var path = "${_curPath}";
    		$("#dlvyView").load("/comm/dlvy/dlvyUseByOrder"
    				, {path : path}
    				, function(){
    					$("#deliModal").addClass("fade").modal("show");
    		});
    	});


    	// 마일리지 모달
    	$(".f_use_mlg").on("click", function(){

    		f_calStlmAmt();

	   		$("#use-mlg").load("/comm/dscnt/mlg"
	   			, function(){
	   				$("#mlg-modal").modal('show');
	   			});
    	});

    	// 포인트 모달
    	$(".f_use_point").on("click", function(){
    		f_calStlmAmt();

    		$("#use-point").load("/comm/dscnt/point"
    			, function(){
    				$("#point-modal").modal('show');
    			});
    	});

    	// 쿠폰 모달
    	$(".f_use_coupon").on("click",function(){
    		if($("#use-coupon").html() == '' ){
    			var gdsCd = [];
    			var total = 0;
    			total = "${totalOrdrPc + totalDlvyBassAmt}";

    			if($("#usePoint").val() > 0){
    				total += $("#usePoint").val();
    			}

    			if($("#useMlg").val() > 0){
    				total += $("#useMlg").val();
    			}

        		for(var i=1; i<$("input[name='gdsCd']").length+1; i++){
        			gdsCd.push($("#gdsCd_BASE_"+i).val());
        		}

        		for(var i=1; i<$("input[name='ordrQy']").length+1; i++){
        			ordrQy.push($("#ordrQy_BASE_"+i).val());
        		}

        		$("#use-coupon").load("/comm/dscnt/coupon"
        				, {arrGdsCd : gdsCd
        					, baseTotalAmt : total
        					, arrOrdrQy : ordrQy
        					, arrOrdrPc : arrOrdrPc}
    	    			, function(){
    	    				$("#coupon-modal").modal('show');
    	    				actFlag = false;
    	    			});
    			}else{
    				$("#coupon-modal").modal('show');
    			}
    	});



      	$("#selMemo").on("change", function(){
    		if($(this).val() != ""){
    			if($(this).val() != "직접입력"){
    				$("#ordrrMemo").val($(this).val());
    				$("#ordrrMemo").hide();
    			}else{
    				$("#ordrrMemo").show();
    				$("#ordrrMemo").val('');
    			}
    		}
    	});

		// 할인혜택 초기화
	    $(".f_reset").on("click",function(){
      		$("#totalCouponAmt, #usePoint, #useMlg").val(0);
      		$(".total-mlg-txt").text(0);
      		$("#btn-reset").click();
      		$(".f_point_reset").click();
      		$(".f_mlg_reset").click();
      		$("#frmMlg input[name='useMlg']").val(0);
      		$("#frmPoint input[name='usePoint']").val(0);
      		f_calStlmAmt();
      	});

    	// 정규식
		//<div id="recptrDaddr-error" class="error text-danger">! 상세 주소를 입력해 주세요</div>

    	$("form[name='frmOrdr']").validate({
    	    ignore: "input[type='text']:hidden, [contenteditable='true']:not([name])",
    	    rules : {
    	    	recptrNm			: { required : true}
    	    	, recptrMblTelno	: { required : true}
    	    	, recptrZip			: { required : true}
    	    	, recptrAddr		: { required : true}
    	    	, recptrDaddr		: { required : true}
    	    	, buyAgree			: { required : true}
    	    },
    	    messages : {
    	    	recptrNm			: { required : "! 받는 사람을 입력해 주세요"}
		    	, recptrMblTelno	: { required : "! 휴대폰 번호를 입력해 주세요"}
		    	, recptrZip			: { required : "! 우편번호 검색을 해 주세요"}
		    	, recptrAddr		: { required : "! 주소를 입력해 주세요"}
		    	, recptrDaddr		: { required : "! 상세 주소를 입력해 주세요"}
		    	, buyAgree			: { required : "! 구매자 동의사항에 체크해야 합니다."}
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
    	    	$("#usePoint").val(uncomma($("#usePoint").val()));
    	    	$("#useMlg").val(uncomma($("#useMlg").val()));
				$("#accmlMlg").val(uncomma($("#accmlMlg").val()));

    	    	jsMarketOrdrPay.f_pay(frm);
    	    	return false;
    	    }
    	});
    })
    </script>