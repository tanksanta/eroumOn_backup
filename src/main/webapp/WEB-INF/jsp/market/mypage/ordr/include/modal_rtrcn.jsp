<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%--주문취소--%>

        <!-- 주문취소 -->
        <form:form name="frmOrdrRtrcn" id="frmOrdrRtrcn" modelAttribute="ordrVO" method="post" enctype="multipart/form-data">
		<form:hidden path="ordrNo" />
        <div class="modal fade" id="ordr-rtrcn-modal" tabindex="-1" aria-hidden="true">
            <div class="modal-dialog modal-dialog-centered">
                <div class="modal-content">
                    <div class="modal-header">
                        <p class="text-title">주문취소</p>
                    </div>
                    <div class="modal-close">
                        <button type="button" data-bs-dismiss="modal">모달 닫기</button>
                    </div>
                    <div class="modal-body" id="ordrRtrcnDiv">
                        <c:set var="totalDlvyBassAmt" value="0" />
                        <c:set var="sumGdsPc" value="0" />
 						<c:set var="totalGdsPc" value="0" />
		                <c:set var="totalCouponAmt" value="0" />
		                <c:set var="totalAccmlMlg" value="0" />
	                      <c:set var="totalUseMlg" value="${ordrVO.useMlg}" />
		                <c:set var="totalUsePoint" value="${ordrVO.usePoint}" />
		                <c:set var="totalOrdrPc" value="0" />
		                <c:set var="totalGdsPc" value="0" />
						<c:set var="dtlIndex" value="0" />
						<c:set var="viewCount" value="0" />

						<div class="space-y-2.5 md:space-y-5">
	                	<c:forEach items="${ordrVO.ordrDtlList}" var="ordrDtl" varStatus="status">
	                	<c:set var="spOrdrOptn" value="${fn:split(ordrDtl.ordrOptn, '*')}" />

	                    <c:if test="${ordrDtl.ordrOptnTy eq 'BASE'}">
	                    <c:set var="sumOrdrPc" value="${ordrDtl.ordrPc }" />
	                	<c:set var="totalGdsPc" value="${ordrDtl.gdsPc * ordrDtl.ordrQy}" />
						<c:set var="sumGdsPc" value="${sumGdsPc + totalGdsPc}" />
						<c:set var="ordrQy" value="${ordrDtl.ordrQy }" />
						<c:set var="totalCouponAmt" value="${ordrDtl.couponAmt}" />
	                    <div class="order-product" ${(ordrDtl.sttsTy eq 'CA02' || ordrDtl.sttsTy eq 'CA01') ? 'style="display:none;"':''}>
	                    <c:if test="${ordrDtl.sttsTy ne 'CA02' && ordrDtl.sttsTy ne 'CA01'}">
	                    	<c:set var="viewCount" value="${viewCount + 1}" />
	                    </c:if>

	                    	<div class="order-header">
	                            <dl>
	                                <dt>주문번호</dt>
	                                <dd><strong>${ordrDtl.ordrDtlCd}</strong></dd>
	                            </dl>
	                        </div>

	                        <div class="order-body">

								<%-- 베네핏 바이어 --%>
								<c:if test="${!empty ordrDtl.recipterUniqueId}">
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
							<c:set var="totalGdsPc" value="${totalGdsPc + (ordrDtl.ordrOptnPc * ordrDtl.ordrQy) }" />
							<c:set var="sumGdsPc" value="${sumGdsPc + totalGdsPc}" />
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

						<c:if test="${ordrVO.ordrDtlList[status.index+1].ordrOptnTy eq 'BASE' || status.last}">
										</div>

										<div class="order-item-count">
			                                <p><strong>${ordrQy}</strong>개</p>
			                            </div>
			                            <div class="order-item-price"><span class="text-primary"><fmt:formatNumber value="${totalGdsPc}" pattern="###,###" />원</span></div>

										<div class="order-item-info">
	                                        <div class="payment">
	                                        	<%-- 멤버스 --%>
	                                        	<c:if test="${!empty ordrDtl.bplcInfo}">
	                                        	<dl>
	                                                <dt>멤버스</dt>
	                                                <dd>${ordrDtl.bplcInfo.bplcNm}</dd>
	                                            </dl>
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
											<div class="status">
	                                            <%-- TO-DO : 주문상태에 따라 다름 --%>
	                                       	<c:choose>
	                                       		<c:when test="${ordrDtl.sttsTy eq 'OR07'}">
	                                            <dl>
	                                                <dt>배송중</dt>
	                                                <dd><fmt:formatDate value="${ordrDtl.sndngDt}" pattern="yyyy-MM-dd" /></dd>
	                                            </dl>
	                                            <c:set var="dlvyUrl" value="#" />
	                                            <c:forEach items="${dlvyCoList}" var="dlvyCoInfo" varStatus="status">
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
	                                                    <button type="button" class="btn btn-outline-primary btn-small f_gds_exchng" data-dtl-no="${ordrDtl.ordrDtlNo}" data-gds-no="${ordrDtl.gdsNo}" >교환신청</button>
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
	                        <label class="order-select">
                                <input type="checkbox" name="ordrDtlCd" value="${ordrDtl.ordrDtlCd}" data-ordr-pc="${sumOrdrPc}" data-dlvy-amt="${ordrDtl.dlvyBassAmt + ordrDtl.dlvyAditAmt}" data-gds-pc="${totalGdsPc}" data-use-mlg="${totalUseMlg}" data-use-point="${totalUsePoint}" data-coupon-amt="${ordrDtl.couponAmt }">
                                <span>선택</span>
                            </label>
	                    </div>

	                	</c:if>

						<%-- 배송비 + 추가배송비 --%>
						<c:set var="totalDlvyBassAmt" value="${totalDlvyBassAmt + (ordrDtl.ordrOptnTy eq 'BASE'?(ordrDtl.gdsInfo.dlvyBassAmt + ordrDtl.gdsInfo.dlvyAditAmt):0)}" />
						<%-- 적립예정마일리지 --%>
	                    <c:set var="totalAccmlMlg" value="${totalAccmlMlg + ordrDtl.accmlMlg}" />
	                    <%-- 주문금액 + 옵션금액 --%>
	                    <c:set var="totalOrdrPc" value="${totalOrdrPc + ordrDtl.ordrPc}" />
	                    <%-- 쿠폰 할인 금액
	                    <c:set var="totalCouponAmt" value="${totalCouponAmt + ordrDtl.couponAmt}" />--%>

	                    </c:forEach>
	                    </div>

                        <p class="text-lg font-bold mt-8 mb-2.5 md:mb-3 md:mt-10 md:text-xl">취소사유</p>
                        <div class="order-reason">
                        	<select id="resnTy" name="resnTy" class="form-control w-75">
                           		<option value="">취소사유를 알려주세요.</option>
                          		<c:forEach items="${ordrCancelTyCode}" var="iem">
                          		<option value="${iem.key}">${iem.value}</option>
                          		</c:forEach>
                          	</select>
                            <textarea id="resn" name="resn" cols="30" rows="5" placeholder="상세사유를 200자 이내로 입력해주세요" class="form-control w-full mt-2.5"></textarea>
                        </div>

						<%--
							1. 결제전 주문취소는 취소 예정금액은 없음 > 마일리지 or 포인트 반환, 쿠폰 반환?
						--%>
						<c:if test="${ordrVO.stlmYn eq 'Y' }">
                        <p class="text-lg font-bold mb-2.5 mt-9 md:mt-12 md:mb-3 md:text-xl">취소 예정 금액 확인</p>
                        <div class="payment-amount">
                            <div class="amount-section">
                                <dl class="price">
                                    <dt>취소 상품 총 금액 합계</dt>
                                    <dd><strong class="totalSumPc">0</strong> 원</dd>
                                </dl>
                                <div class="detail">
                                    <dl>
                                        <dt>취소 상품 합계</dt>
                                        <dd><strong class="totalGdsPc">0</strong> 원</dd>
                                    </dl>
                                    <dl>
                                        <dt>배송비</dt>
                                        <dd><strong class="totalDlvyBassAmt">0</strong> 원</dd>
                                    </dl>
                                     <dl>
                                        <dt>쿠폰할인</dt>
                                        <dd><strong class="totalCouponAmt">0</strong> 원</dd>
                                    </dl>
									<dl class="useMlgView" style="display:none;">
                                        <dt>마일리지 사용</dt>
                                        <dd><strong class="totalMlgAmt">0</strong> 원</dd>
                                    </dl>
                                    <dl class="usePointView" style="display:none;">
                                        <dt>포인트 사용</dt>
                                        <dd><strong class="totalPointAmt">0</strong> 원</dd>
                                    </dl>
                                </div>
                            </div>
                            <!-- <i class="amount-calculator is-plus">+</i> -->
                            <i class="amount-calculator is-minus">-</i>
                            <div class="amount-section">
                                <dl class="price">
                                    <dt>환불금액 차감내역</dt>
                                    <dd><strong class="totalAmt">0</strong> 원</dd>
                                </dl>
                                <div class="detail">
                                  <dl class="dlvyView">
                                        <dt>배송비 차감 합계</dt>
                                        <!-- <dd><strong class="totalDlvyBassAmt">0</strong> 원</dd> -->
                                        <dd><strong>0</strong> 원</dd>
                                    </dl>
                                </div>
                            </div>
                            <i class="amount-calculator is-equal">=</i>
                            <div class="amount-section is-latest">
                                <dl class="price">
                                    <dt>활불 예정금액</dt>
                                    <dd><strong class="totalRefundAmt">0</strong> 원</dd>
                                </dl>
                                <div class="detail">
                                    <dl>
                                        <c:choose>
                                    		<c:when test="${ordrVO.stlmTy eq 'CARD'}">
                                        <dt>${bassStlmTyCode[ordrVO.stlmTy]} 취소금액</dt>
                                    		</c:when>
                                    		<c:when test="${ordrVO.stlmTy eq 'VBANK'}">
                                        <dt>${bassStlmTyCode[ordrVO.stlmTy]} 환불금액</dt>
                                    		</c:when>
                                    		<c:otherwise>
                                    	<dt>환불금액</dt>
                                    		</c:otherwise>
                                    	</c:choose>
                                        <dd><strong class="totalRefundAmt">0</strong> 원</dd>
                                    </dl>
                                </div>
                            </div>
                        </div>

                        <c:if test="${ordrVO.stlmYn eq 'Y' &&  ordrVO.stlmTy eq 'VBANK'}"> <%--가상계좌 환불시 --%>
                        <p class="text-lg font-bold mt-8 md:mt-10 md:text-xl">
                            환불계좌
                            <span class="text-sm text-red3 md:text-base">필수</span>
                        </p>
                        <table class="table-detail">
                            <colgroup>
                                <col class="w-30 md:w-40">
                                <col >
                            </colgroup>
                            <tbody>
                                <tr class="top-border">
                                    <td></td>
                                    <td></td>
                                </tr>
                                <tr>
                                    <th scope="row"><p>환불방식</p></th>
                                    <td><strong>무통장입금</strong></td>
                                </tr>
                                <tr>
                                    <th scope="row"><p><label for="rfndBank">환불은행</label></p></th>
                                    <td>
                                        <select name="rfndBank" id="rfndBank" class="form-control w-45">
                                        	<option value="">은행 선택</option>
                                        	<c:forEach items="${bankTyCode}" var="iem">
                                            <option value="${iem.value}">${iem.value}</option>
                                            </c:forEach>
                                        </select>
                                    </td>
                                </tr>
                                <tr>
                                    <th scope="row"><p><label for="refund-item2">계좌번호</label></p></th>
                                    <td><input type="text" id="rfndActno" name="rfndActno" class="form-control w-86" maxlength="50"></td>
                                </tr>
                                <tr>
                                    <th scope="row"><p>예금주명</p></th>
                                    <td><input type="text" id="rfndDpstr" name="rfndDpstr" value="${ordrVO.ordrrNm }" class="form-control w-45" maxlength="10"></td>
                                </tr>
                                <tr class="bot-border">
                                    <td></td>
                                    <td></td>
                                </tr>
                            </tbody>
                        </table>
                        </c:if>

                        <p class="text-lg font-bold mt-18 md:mt-24 md:text-xl">결제수단별 환불안내</p>
                        <table class="table-detail">
                            <colgroup>
                                <col class="w-30 md:w-40">
                                <col >
                            </colgroup>
                            <tbody>
                                <tr class="top-border">
                                    <td></td>
                                    <td></td>
                                </tr>
                                <tr>
                                    <th scope="row"><p>신용카드</p></th>
                                    <td>
                                        <div class="p-2 leading-relaxed space-y-1.5">
                                            <p>
                                            	<strong>승인취소</strong> : 신용카드 승인취소는 매입(카드사로 결제정보가 넘어가기 전)인 경우에는 취소 승인한 당일 취소됩니다.
                                            </p>
                                            <p>
                                                <strong>매입취소</strong> : 카드사로 결제정보가 넘어간 후에는 카드사에서 취소처리를 하는데 1~2주 정도 소요 됩니다.<br>
                                                (카드사별 취소 반영이 차이가 있습니다. 각 카드사 홈페이지에서 확인 가능합니다.)
                                            </p>
                                        </div>
                                    </td>
                                </tr>
                                <tr>
                                    <th scope="row"><p>실시간계좌이체</p></th>
                                    <td>
                                        <div class="p-2 leading-relaxed space-y-1.5">
                                            <p>취소신청 완료 후 익일에 실시간 계좌이체가 진행된 고객님의 계좌로 직접 환불됩니다.</p>
                                        </div>
                                    </td>
                                </tr>
                                <tr>
                                    <th scope="row"><p>가상계좌(무통장) 입금</p></th>
                                    <td>
                                        <div class="p-2 leading-relaxed space-y-1.5">고객님의 취소신청 시 입력된 환불계좌로 2~3일 이내 환불됩니다.</div>
                                    </td>
                                </tr>
                                <tr class="bot-border">
                                    <td></td>
                                    <td></td>
                                </tr>
                            </tbody>
                        </table>
                        </c:if>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-primary btn-submit f_ordr_rtrcn_save">확인</button>
                        <button type="button" class="btn btn-outline-primary btn-cancel" data-bs-dismiss="modal">닫기</button>
                    </div>
                </div>
            </div>
        </div>
        </form:form>
        <!-- //주문취소 -->


        <script>
        $(function(){

         	let totalSumPc = 0; //취소 상품 총 금액
            let sumGdsPc = 0; // 취소 상품 금액 합계
            let sumDlvyAmt = 0; // 취소 배송비 합계
            let sumCouponAmt = 0; // 쿠폰 할인비 합계
            let sumRfdDlvyAmt = 0; // 배송비 차감 합계

            $('.order-product').on('click', function() {
                if($(this).find('.order-select').length > 0) {
                	let ordrPc = $(this).find('.order-select input').data("ordrPc"); // 해당 상품 주문 금액
                	let gdsPc = $(this).find('.order-select input').data("gdsPc"); // 해당 상품 금액
                    let dlvyBassAmt = $(this).find('.order-select input').data("dlvyAmt"); // 해당 상품 배송비
                    let couponAmt = $(this).find('.order-select input').data("couponAmt"); // 해당 상품 쿠폰 할인비
                    let usedMlg = "${ordrVO.useMlg}"; // 사용한 마일리지
                    let usedPoint = "${ordrVO.usePoint}"; // 사용한 포인트
                    let useMlg = 0;
                    let usePoint = 0;

                    console.log(couponAmt);

                    <%--  @@@@ 선택 해제 시 이벤트 @@@@   --%>
                    if($(this).hasClass('is-active')) {
                        $(this).removeClass('is-active').find('.order-select input').prop('checked', false);
                        sumGdsPc = sumGdsPc - gdsPc;
                        sumDlvyAmt = sumDlvyAmt - dlvyBassAmt;
                        sumCouponAmt = sumCouponAmt - couponAmt;

                        // 상품 클릭시 마일리지, 포인트 숨김
                        // is-active 아무것도 없을시 1 부터 시작임.
                        if($(".itemList").length != ($(".is-active").length-1)){
                           	$(".useMlgView").hide();
                        	$(".usePointView").hide();
                        }

                        totalSumPc = (sumGdsPc + sumDlvyAmt) - (usePoint + useMlg + sumCouponAmt); // 반품 상품 총 금액

                        $(".totalSumPc").text(comma(totalSumPc));
                        $(".totalGdsPc").text(comma(sumGdsPc));

                        // 쿠폰 할인
                        if(sumCouponAmt > 0){
                        	$(".totalCouponAmt").text("- "+comma(sumCouponAmt));
                        }else{
                        	$(".totalCouponAmt").text(0);
                        }

                        $(".totalMlgAmt").text(0);
                        $(".totalPointAmt").text(0);
                        $(".totalAmt").text(comma(sumDlvyAmt));
                        $(".totalDlvyBassAmt").text(comma(sumDlvyAmt));
                        $(".totalRefundAmt").text(comma(totalSumPc - sumDlvyAmt));


                    } else {

                    	<%--  @@@@ 선택 시 이벤트 @@@@   --%>
                        $(this).removeClass('is-disable').addClass('is-active').find('.order-select input').prop('checked', true);

                       	<%-- 결제 완료 : 배송전이므로 배송비 까지 다 돌려줌 --%>
                       	<c:if test="${ordrDtl.sttsTy eq 'OR05'}">
                       	</c:if>

                        sumGdsPc = sumGdsPc + gdsPc; // 반품 상품 합계
                        sumDlvyAmt = sumDlvyAmt + dlvyBassAmt; // 반품 배송비 합계
                        sumCouponAmt = sumCouponAmt + couponAmt; // 쿠폰 할인 합계
                        console.log("상품 합계 : " + sumGdsPc);
                        console.log("배송비 합계 : " + sumDlvyAmt);
                        console.log("쿠폰비 합계 : " + sumCouponAmt);

                        // 상품 전체 클릭시 마일리지, 포인트 보임
                        // is-active 아무것도 없을시 1 부터 시작임.
                        if($(".modal-body .is-active").length == "${viewCount}"){

                          	// 마일리지
                            if(usedMlg > 0){
                            	useMlg = usedMlg;
                            	$(".totalMlgAmt").text("- "+comma(useMlg));
                            }else{
                            	$(".totalMlgAmt").text(0);
                            }

                         	// 포인트
                            if(usedPoint > 0){
                            	usePoint = usedPoint;
                            	console.log(usePoint);
                            	$(".totalPointAmt").text("- "+comma(usePoint));
                            }else{
                            	$(".totalPointAmt").text(0);
                            }


                        	if(usedMlg > 0){
                        		$(".useMlgView").show();
                        	}
                        	if(usedPoint > 0){
                        		$(".usePointView").show();
                        	}
                        }

                        totalSumPc = (Number(sumGdsPc) + Number(sumDlvyAmt)) - (Number(usePoint) + Number(useMlg) + Number(sumCouponAmt)); // 반품 상품 총 금액

                        $(".totalSumPc").text(comma(String(totalSumPc)));
                        $(".totalGdsPc").text(comma(sumGdsPc));

                     	// 쿠폰 할인
                        if(sumCouponAmt > 0){
                        	$(".totalCouponAmt").text("- "+comma(sumCouponAmt));
                        }else{
                        	$(".totalCouponAmt").text(0);
                        }

                        $(".totalMlgAmt").text("- "+comma(useMlg));
                        $(".totalPointAmt").text("- "+comma(usePoint));
                        $(".totalAmt").text(0); // 환불 금액 차감 내역
                        $(".totalDlvyBassAmt").text(comma(sumDlvyAmt)); // 반품 배송비 합계
                        $(".totalRefundAmt").text(comma(totalSumPc)); // 환불 예정 금액
                    }
                }

            });

			$(".f_ordr_rtrcn_save").on("click", function(){
				let ordrDtlCds = $("#ordrRtrcnDiv :checkbox:checked").map(function(){return $(this).val();}).get();
				if(ordrDtlCds==null||ordrDtlCds.length==0) {
					alert("선택된 상품이 없습니다.");
				}else if($("#resnTy").val() == ""){
					alert("취소사유를 선택하세요");
					$("#resnTy").focus();
				<c:if test="${ordrVO.stlmYn eq 'Y' &&  ordrVO.stlmTy eq 'VBANK'}"> <%--가상계좌 환불시 --%>
				}else if($("#rfndBank").val() == ""){
					alert("환불은행을  선택하세요");
					$("#rfndBank").focus();
				}else if($("#rfndActno").val() == ""){
					alert("환불받으실 계좌번호를 입력하세요");
					$("#rfndActno").focus();
				}else if($("#rfndDpstr").val() == ""){
					alert("예금주명을 입력하세요");
					$("#rfndDpstr").focus();
				</c:if>
				}else{
					if(confirm("선택하신 상품을 취소처리 하시겠습니까?")) {
						$.ajax({
							type: 'post',
							url : '${_marketPath}/mypage/ordr/ordrRtrcnSave.json',
							data: {
								ordrNo:'${ordrVO.ordrNo}'
								, ordrDtlCds:ordrDtlCds
								, resnTy:$("#resnTy").val()
								, resn:$("#resn").val()
								, rfndBank:$("#rfndBank").val()
								, rfndActno:$("#rfndActno").val()
								, rfndDpstr:$("#rfndDpstr").val()
							},
							dataType: 'json'
						})
						.done(function(json){
							if(json.result) {
								console.log("success");
								$("#ordr-rtrcn-modal .btn-cancel").click();
								console.log("success");
								location.reload();
							} else {
								alert("선택하신 상품의 주문취소가 실패하였습니다.\n잠시 후 다시 시도해주세요.");
								$("#ordr-rtrcn-modal .btn-cancel").click();
							}
						})
						.fail(function(){
							alert("작업이 실패하였습니다.\n계속해서 에러가 발생할 경우\n운영자에게 문의바랍니다.");
							$("#ordr-rtrcn-modal .btn-cancel").click();
						});

					}
				}
			});
        });
        </script>