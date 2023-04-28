<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
			<%-- 주문상세 내역 --%>

            <!-- 주문상세내역 -->
            <form:form name="frmOrdr" id="frmOrdr" modelAttribute="ordrVO" method="post" enctype="multipart/form-data">
			<form:hidden path="ordrNo" />

            <div class="modal" id="dtl-modal" tabindex="-1">
                <div class="modal-dialog modal-2xl modal-dialog-centered">
                    <div class="modal-content">
                        <div class="modal-header">
                            <p>주문상세내역
                            	<button type="button" class="btn-outline-primary btn-reload ml-1">새로고침</button>
                            </p>
                            <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="close"></button>
                        </div>
                        <div class="modal-body">
                            <p class="text-title2">주문자정보</p>
                            <table class="table-detail">
                                <colgroup>
                                    <col class="w-36">
                                    <col>
                                    <col class="w-36">
                                    <col>
                                </colgroup>
                                <tbody>
                                    <tr>
                                        <th scope="row">주문번호</th>
                                        <td>${ordrVO.ordrCd }</td>
                                        <th scope="row">주문일</th>
                                        <td><fmt:formatDate value="${ordrVO.ordrDt}" pattern="yyyy-MM-dd HH:mm" /></td>
                                    </tr>
                                    <tr>
                                        <th scope="row">주문자명/아이디</th>
                                        <td>${ordrVO.ordrrNm} / ${ordrVO.ordrrId}</td>
                                        <th scope="row">휴대전화</th>
                                        <td>${ordrVO.ordrrMblTelno}</td>
                                    </tr>
                                    <tr>
                                        <th scope="row">이메일</th>
                                        <td colspan="3">${ordrVO.ordrrEml}</td>
                                    </tr>
                                </tbody>
                            </table>

                            <p class="text-title2 mt-10">주문상품정보</p>
                            <table class="table-list ordr-dtl-list">
                                <colgroup>
                                    <col class="w-28">
                                    <col>
                                    <col class="w-28">
                                    <col class="w-26">
                                    <col class="w-15">
                                    <col class="w-25">
                                    <col class="w-32">
                                    <col class="w-32">
                                    <col class="w-31">
                                    <col class="w-25">
                                    <col class="w-24">
                                </colgroup>
                                <thead>
                                    <tr>
                                        <th scope="col">상품구분</th>
                                        <th scope="col">상품/옵션정보</th>
                                        <th scope="col">옵션/수량 변경</th>
                                        <th scope="col">상품가격</th>
                                        <th scope="col">수량</th>
                                        <th scope="col">배송비</th>
                                        <th scope="col">송장번호</th>
                                        <th scope="col">배송예정일</th>
                                        <!-- <th scope="col">전표번호</th> -->
                                        <th scope="col">멤버스</th>
                                        <th scope="col">주문상태</th>
                                        <th scope="col">처리</th>
                                    </tr>
                                </thead>
                                <tbody>
                                	<c:set var="ordrCancelBtn" value="false" />
                                	<c:set var="ordrConfirmBtn" value="false" />
                                	<c:set var="ordrConfirmCancelBtn" value="false" />
                                	<c:set var="ordrDvlyBtn" value="false" />
                                	<c:set var="ordrDoneBtn" value="false" />
                                	<c:set var="ordrRfndBtn" value="false" />

                                	<c:set var="totalDlvyBassAmt" value="0" />
                                    <c:set var="totalCouponAmt" value="0" />
                                    <c:set var="totalAccmlMlg" value="0" />
                                    <c:set var="totalOrdrPc" value="0" />

                                	<c:forEach items="${ordrVO.ordrDtlList}" var="ordrDtl" varStatus="status">

                                    <tr>
                                        <td class="${ordrDtl.ordrDtlCd}">
                                        	${gdsTyCode[ordrDtl.gdsTy]}
                                        </td>
                                        <td class="text-left">
                                        	<c:if test="${ordrDtl.ordrOptnTy eq 'ADIT' }"><%--추가상품--%>
                                        	<i class="ico-reply"></i>
                                        	<span class="badge">추가옵션</span>
                                        	<p class="ml-3" style="display:inline-flex;">
                                            ${ordrDtl.ordrOptn}
                                            </p>
                                        	</c:if>
                                        	<c:if test="${ordrDtl.ordrOptnTy eq 'BASE' }"><%--상품--%>
											<p>
											<span class="badge-outline-success">${ordrDtl.gdsCd}</span><br>
                                            ${ordrDtl.gdsNm}
                                            <c:if test="${!empty ordrDtl.ordrOptn}"><br>(${ordrDtl.ordrOptn})</c:if>
                                            </p>
                                        	</c:if>

                                        </td>
                                        <td class="${ordrDtl.ordrDtlCd}">
                                        	<%-- 옵션변경 : 주문승인대기,주문승인반려,결제대기--%>
                                            <%--<c:if test="${ordrDtl.sttsTy eq 'OR01' || ordrDtl.sttsTy eq 'OR04'}"> --%>
                                            <c:if test="${ordrDtl.sttsTy eq 'OR01'}">
                                            <button type="button" class="btn-primary shadow tiny mt-0.5 f_optn_chg" data-gds-no="${ordrDtl.gdsNo}" data-dtl-no="${ordrDtl.ordrDtlNo}" data-dtl-cd="${ordrDtl.ordrDtlCd}">옵션변경</button>
                                            </c:if>
                                        </td>
                                        <td>
                                        	<c:if test="${ordrDtl.ordrOptnTy eq 'BASE'}">
                                        	<fmt:formatNumber value="${ordrDtl.gdsPc}" pattern="###,###" />
                                        	<br>(+<fmt:formatNumber value="${ordrDtl.ordrOptnPc}" pattern="###,###" />)
                                        	</c:if>
                                        	<c:if test="${ordrDtl.ordrOptnTy eq 'ADIT'}"><span class="ordrOptnPc">
                                        	+<fmt:formatNumber value="${ordrDtl.ordrOptnPc}" pattern="###,###" /></span>
                                        	</c:if>
                                        </td>
                                        <td><fmt:formatNumber value="${ordrDtl.ordrQy}" pattern="###,###" /></td>
                                        <td>
                                        	<fmt:formatNumber value="${ordrDtl.dlvyBassAmt}" pattern="###,###" /><br>
                                        	(<fmt:formatNumber value="${ordrDtl.dlvyAditAmt}" pattern="###,###" />)
                                        </td>
                                        <td style="padding: 0.625rem 0.25rem" class="space-y-0.5 ${ordrDtl.ordrDtlCd}">
                                        	<%-- 택배사선택 : 배송준비중 --%>
                                        	<c:if test="${ordrDtl.sttsTy eq 'OR06' }">
                                            <select id="dlvyCo_${ordrDtl.ordrDtlNo}" name="dlvyCo_${ordrDtl.ordrDtlNo}" class="form-control small w-full">
                                                <option value="">택배사선택</option>
                                                <c:forEach items="${dlvyCoList}" var="dlvyCoInfo" varStatus="status">
                                                <option value="${dlvyCoInfo.coNo}|${dlvyCoInfo.dlvyCoNm}" ${dlvyCoInfo.coNo eq ordrDtl.dlvyCoNo?'selected="selected"':''}>${dlvyCoInfo.dlvyCoNm}</option>
                                                </c:forEach>
                                            </select>
                                            <input type="text" id="dlvyInvcNo_${ordrDtl.ordrDtlNo}" name="dlvyInvcNo_${ordrDtl.ordrDtlNo}" value="${ordrDtl.dlvyInvcNo}" class="form-control small w-full" maxlength="50">
                                            <button type="button" class="btn-primary shadow small w-full f_dlvyCo_save" data-dtl-No="${ordrDtl.ordrDtlNo}" data-dtl-cd="${ordrDtl.ordrDtlCd}" >저장</button>
                                            </c:if>
                                            <c:if test="${ordrDtl.sttsTy eq 'OR07' || ordrDtl.sttsTy eq 'OR08' || ordrDtl.sttsTy eq 'OR09' || fn:startsWith(ordrDtl.sttsTy, 'EX') || fn:startsWith(ordrDtl.sttsTy, 'CA') || fn:startsWith(ordrDtl.sttsTy, 'RE') || fn:startsWith(ordrDtl.sttsTy, 'RF') }">
                                            <c:set var="dlvyUrl" value="#" />
                                            <c:forEach items="${dlvyCoList}" var="dlvyCoInfo" varStatus="status">
                                            	<c:if test="${dlvyCoInfo.coNo eq ordrDtl.dlvyCoNo}">
                                            	<c:set var="dlvyUrl" value="${dlvyCoInfo.dlvyUrl}" />
                                            	</c:if>
                                            </c:forEach>
                                            <a href="${dlvyUrl}${ordrDtl.dlvyInvcNo}" target="_blank">${ordrDtl.dlvyCoNm}</a>
                                            <br>
                                            ${ordrDtl.dlvyInvcNo}
                                            </c:if>
                                        </td>
                                        <td class="${ordrDtl.ordrDtlCd}" style="padding: 0.625rem 0.25rem">
                                        	<%-- 주문확정시 > 배송일시 저장 && 결제완료시만 나옴 --%>
                                        	<c:if test="${ordrDtl.sttsTy eq 'OR05'}">
                                        	<input type="date" id="sndngDt_${ordrDtl.ordrDtlNo}" name="sndngDt" value="<fmt:formatDate value="${ordrDtl.sndngDt}" pattern="yyyy-MM-dd" />" class="form-control small w-full text-center ${ordrDtl.ordrOptnTy}" data-dtl-no="${ordrDtl.ordrDtlNo}" data-dtl-cd="${ordrDtl.ordrDtlCd}">
                                        	</c:if>
                                        	<c:if test="${ordrDtl.sttsTy ne 'OR05' && !empty ordrDtl.sndngDt}">
                                        	<input type="hidden" name="sndngDt" value="<fmt:formatDate value="${ordrDtl.sndngDt}" pattern="yyyy-MM-dd" />"  data-dtl-no="${ordrDtl.ordrDtlNo}" data-dtl-cd="${ordrDtl.ordrDtlCd}" >
                                        	<fmt:formatDate value="${ordrDtl.sndngDt}" pattern="yyyy-MM-dd" />
                                        	</c:if>
                                        </td>
                                        <%-- <td>TO-DO : ${ordrVO.delngNo}</td> --%>
                                        <td class="${ordrDtl.ordrDtlCd}"><%-- ${ordrVO.ordrTy} / ${ordrDtl.bplcUniqueId} / ${ordrDtl.bplcInfo.bplcNm} --%>
                                        	<c:if test="${ordrVO.ordrTy eq 'R' || ordrVO.ordrTy eq 'L'}"><%-- 급여구매일 경우만 경우만 멤버스(사업소) 있음 --%>
                                        	<c:choose>
		                                		<c:when test="${!empty ordrDtl.bplcUniqueId}">
		                                	<a class="btn shadow tiny" href="/_mng/members/bplc/view?uniqueId=${ordrDtl.bplcUniqueId}" target="_blank">${ordrDtl.bplcInfo.bplcNm}</a>
		                                		</c:when>
		                                		<c:otherwise>-</c:otherwise>
		                                	</c:choose>
                                        	</c:if>
                                        	<c:if test="${ordrVO.ordrTy eq 'N'}">-</c:if>

                                        </td>
                                        <td class="${ordrDtl.ordrDtlCd}">
                                        	<%-- 상태 --%>
                                        	<c:choose>
		                                		<c:when test="${ordrDtl.sttsTy eq 'RE03' && ordrDtl.rfndYn eq 'N'}"><%--반품완료+환불미완료 --%>
		                                	<span class="text-danger">환불접수</span><br>
		                                	(${ordrSttsCode[ordrDtl.sttsTy]})
		                                		</c:when>
		                                		<c:otherwise>
		                                    ${ordrSttsCode[ordrDtl.sttsTy]}
		                                		</c:otherwise>
		                                	</c:choose>

                                        	<c:if test="${ordrDtl.sttsTy ne 'OR01' }">
                                            <br><button type="button" class="btn-primary shadow tiny mt-0.5 f_ordr_stts_hist" data-dtl-no="${ordrDtl.ordrDtlNo}">진행내역</button>
                                            </c:if>
                                        </td>
                                        <td style="padding: 0.625rem 0.25rem" class="space-y-0.5 ${ordrDtl.ordrDtlCd}">

                                        	<c:choose>
                                        		<c:when test="${ordrDtl.sttsTy eq 'OR01'}"><%-- 승인대기 --%>
                                        		<button type="button" class="btn-primary shadow w-full px-0 f_ordr_dtl_confrm" data-dtl-no="${ordrDtl.ordrDtlNo}" >관리</button>
                                        		</c:when>
                                        		<c:when test="${ordrDtl.sttsTy eq 'CA01'}"><%-- 취소접수 --%>
                                        		<button class="btn-primary shadow w-full px-0 f_rtrcn_confm" data-dtl-cd="${ordrDtl.ordrDtlCd}" data-stts-ty="CA02" data-resn-ty="", data-resn="취소완료" data-coupon-amt = "${ordrDtl.couponAmt}" data-msg="취소완료 처리하시겠습니까?" >취소완료</button>
                                        		</c:when>
                                        		<c:when test="${ordrDtl.sttsTy eq 'OR07'}"><%-- 배송중 --%>
                                        		<button class="btn-primary shadow w-full px-0 f_dlvy_done" data-dtl-cd="${ordrDtl.ordrDtlCd}" data-stts-ty="OR08" data-resn-ty="", data-resn="배송완료 확인" data-msg="배송완료 상태로 변경됩니다. 처리하시겠습니까?" >배송완료 처리</button>
                                        		</c:when>
                                        		<c:when test="${ordrDtl.sttsTy eq 'OR08'}"><%-- 배송완료 --%>
                                        		<button type="button" class="btn-primary shadow w-full px-0 f_gds_exchng" data-dtl-cd="${ordrDtl.ordrDtlCd}" data-ordr-no="${ordrDtl.ordrNo}">교환</button>
                                        		<button type="button" class="btn-primary shadow w-full px-0 f_ordr_done" data-dtl-cd="${ordrDtl.ordrDtlCd}" data-stts-ty="OR09" data-resn-ty="", data-resn="상품 구매확정" data-msg="마일리지가 적립됩니다.구매확정 처리하시겠습니까?" >구매확정 처리</button>
                                        		</c:when>
                                        		<c:when test="${ordrDtl.sttsTy eq 'EX01'}"><%-- 교환접수 --%>
                                        		<button type="button" class="btn-primary shadow w-full px-0 f_exchng_confm" data-dtl-cd="${ordrDtl.ordrDtlCd}" data-stts-ty="EX02" data-resn-ty="", data-resn="교환접수 승인" data-msg="교환접수승인 처리하시겠습니까?" >교환접수 승인</button>
                                        		<button type="button" class="btn-primary shadow w-full px-0 f_dlvy_done" data-dtl-cd="${ordrDtl.ordrDtlCd}" data-stts-ty="OR08" data-resn-ty="", data-resn="교환접수 반려 > 배송완료 단계로 변경" data-msg="교환불가 처리하시면 배송완료 상태로 변경됩니다. 처리하시겠습니까?" >교환불가</button>
                                        		</c:when>
                                        		<c:when test="${ordrDtl.sttsTy eq 'EX02'}"><%-- 교환진행중 --%>
                                        		<button type="button" class="btn-primary shadow w-full px-0 f_exchng_done" data-dtl-cd="${ordrDtl.ordrDtlCd}" data-stts-ty="EX03" data-resn-ty="", data-resn="교환완료" data-msg="교환완료 처리하시겠습니까?" >교환완료</button>
                                        		<button type="button" class="btn-primary shadow w-full px-0 f_dlvy_done" data-dtl-cd="${ordrDtl.ordrDtlCd}" data-stts-ty="OR08" data-resn-ty="", data-resn="교환진행중 교환불가 처리 > 배송완료 단계로 변경" data-msg="교환불가 처리하시면 배송완료 상태로 변경됩니다. 처리하시겠습니까?" >교환불가</button>
                                        		</c:when>
                                        		<c:when test="${ordrDtl.sttsTy eq 'RE01'}"><%-- 반품접수 --%>
                                        		<button type="button" class="btn-primary shadow w-full px-0 f_return_confm" data-dtl-cd="${ordrDtl.ordrDtlCd}" data-stts-ty="RE02" data-resn-ty="", data-resn="반품접수 진행" data-msg="반품접수를 승인하시겠습니까?" >반품접수 승인</button>
                                        		<button type="button" class="btn-primary shadow w-full px-0 f_dlvy_done" data-dtl-cd="${ordrDtl.ordrDtlCd}" data-stts-ty="OR08" data-resn-ty="", data-resn="반품접수 > 배송완료 단계로 변경" data-msg="반품불가 처리하시면 배송완료 상태로 변경됩니다. 처리하시겠습니까?" >반품불가</button>
                                        		</c:when>
                                        		<c:when test="${ordrDtl.sttsTy eq 'RE02'}"><%-- 반품진행중 --%>
                                        		<button type="button" class="btn-primary shadow w-full px-0 f_return_done" data-dtl-cd="${ordrDtl.ordrDtlCd}" data-stts-ty="RE03" data-resn-ty="", data-resn="반품완료" data-msg="반품완료 처리하시겠습니까?" data-rfnd-bank="${ordrDtl.rfndBank}" data-rfnd-actno="${ordrDtl.rfndActno}" data-rfnd-dpstr="${ordrDtl.rfndDpstr }">반품완료</button>
                                        		<button type="button" class="btn-primary shadow w-full px-0 f_dlvy_done" data-dtl-cd="${ordrDtl.ordrDtlCd}" data-stts-ty="OR08" data-resn-ty="", data-resn="반품진행중 반려 > 배송완료 단계로 변경" data-msg="반품불가 처리하시면 배송완료 상태로 변경됩니다. 처리하시겠습니까?" >반품불가</button>
                                        		</c:when>
                                        		<c:when test="${(ordrDtl.sttsTy eq 'RE03' || ordrDtl.sttsTy eq 'RF01') && ordrDtl.rfndYn eq 'N'}"><%-- 반품완료 + 환불미완료 --%>
												<button type="button" class="btn-primary shadow w-full px-0 f_rfnd_done" data-dtl-cd="${ordrDtl.ordrDtlCd}" data-stts-ty="RF02" data-resn-ty="", data-resn="환불완료" data-msg="환불완료 처리하시겠습니까?" >환불완료</button>
                                        		</c:when>
                                        	</c:choose>
                                        </td>
                                    </tr>

                                    <%--<c:if test="${ordrDtl.sttsTy ne 'CA02'}"> --%> <%-- 취소완료일때 미적용 --%>
                                    	<%-- 배송비 + 추가배송비 --%>
	                                    <c:set var="totalDlvyBassAmt" value="${totalDlvyBassAmt + ordrDtl.dlvyBassAmt + ordrDtl.dlvyAditAmt}" />
	                                    <%-- 쿠폰금액 --%>
	                                    <c:set var="totalCouponAmt" value="${totalCouponAmt + ordrDtl.couponAmt}" />
	                                    <%-- 적립예정마일리지 --%>
	                                    <c:if test="${ordrDtl.gdsInfo.mlgPvsnYn eq 'Y' && (ordrDtl.sttsTy ne 'CA01' && ordrDtl.sttsTy ne 'CA02' && ordrDtl.sttsTy ne 'EX03')}">
	                                    <c:set var="totalAccmlMlg" value="${totalAccmlMlg + ordrDtl.accmlMlg}" />
	                                    </c:if>
	                                    <%-- 주문금액 + 옵션금액 --%>
	                                    <c:if test="${ordrDtl.sttsTy ne 'EX03'}">
	                                    <c:set var="totalOrdrPc" value="${totalOrdrPc + ordrDtl.ordrPc}" />
	                                </c:if>
                                    <%--</c:if> --%>



									<%-- 버튼 제어 S --%>

									<%-- 주문취소 : 결제완료, 주문승인대기, 주문승인완료, 결제대기, 배송준비중 --%>
                           			<c:if test="${(ordrDtl.sttsTy eq 'OR01' || ordrDtl.sttsTy eq 'OR02' || ordrDtl.sttsTy eq 'OR04' || ordrDtl.sttsTy eq 'OR05' || ordrDtl.sttsTy eq 'OR06')}">
                           				<c:set var="ordrCancelBtn" value="true" />
                           			</c:if>
                           			<%-- 주문확정 : 결제완료 --%>
                           			<c:if test="${ordrDtl.sttsTy eq 'OR05'}">
                           				<c:set var="ordrConfirmBtn" value="true" />
                           			</c:if>
                           			<%-- 주문확정 취소 : 배송준비중 --%>
                           			<c:if test="${ordrDtl.sttsTy eq 'OR06'}">
                           				<c:set var="ordrConfirmCancelBtn" value="true" />
                           			</c:if>
                           			<%-- 배송지 저장 버튼 : 주문 승인대기, 주문 승인완료, 결제대기, 결제완료, 배송준비중 --%>
                           			<c:if test="${ordrDtl.sttsTy eq 'OR01' || ordrDtl.sttsTy eq 'OR02' || ordrDtl.sttsTy eq 'OR04' || ordrDtl.sttsTy eq 'OR05' || ordrDtl.sttsTy eq 'OR06'}">
                           				<c:set var="ordrDvlyBtn" value="true" />
                           			</c:if>
                           			<%-- 배송완료 --%>
									<c:if test="${ordrDtl.sttsTy eq 'OR08'}">
										<c:set var="ordrDvlyDoneBtn" value="true" />
									</c:if>
									<%-- 환불정보 --%>
									<c:if test="${ordrDtl.sttsTy eq 'CA01' || ordrDtl.sttsTy eq 'CA02' || ordrDtl.sttsTy eq 'RF01' || ordrDtl.sttsTy eq 'RF02'}">
										<c:set var="ordrRfndBtn" value="true" />
									</c:if>
                                    </c:forEach>

                                </tbody>
                            </table>
                            <div class="text-right mt-2">
                            	<%-- 단계별 버튼 제어 --%>
                            	<c:if test="${ordrCancelBtn}">
                                <button type="button" class="btn-secondary f_ordr_rtrcn" data-ordr-cd="${ordrVO.ordrCd}">주문취소</button>
                            	</c:if>
                            	<c:if test="${ordrConfirmBtn}">
                            	<%-- 결제완료 -> 배송준비중 변경 버튼 --%>
                                <button type="button" class="btn-primary shadow f_ordr_confrm" data-stts-ty="OR06" data-ordr-cd="${ordrVO.ordrCd}">주문확정</button>
                            	</c:if>
                            	<c:if test="${ordrConfirmCancelBtn}">
                            	<%-- 배송준비중 -> 결제완료 버튼 --%>
                            	<button type="button" class="btn-primary shadow f_ordr_confrm" data-stts-ty="OR05" data-ordr-cd="${ordrVO.ordrCd}">주문확정취소</button>
                            	</c:if>
                            	<%-- 배송완료 -> 반품버튼 --%>
                            	<c:if test="${ordrDvlyDoneBtn}">
                            	<button type="button" class="btn-primary shadow w-22 f_gds_return" data-ordr-cd="${ordrVO.ordrCd}">반품</button>
                            	</c:if>

                            	<!-- <a href="#" class="btn-primary shadow w-22">반품</a> -->
                            </div>

                            <p class="text-title2 relative mt-10">
                                배송지정보
                                <span class="absolute left-full top-0.5 ml-1 whitespace-nowrap text-sm">
                                    (<span class="badge-require ml-1 mr-0.5 -translate-y-0.5"></span> 는 필수입력사항입니다.)
                                </span>
                            </p>
                            <table class="table-detail" id="dlvyTable">
                                <colgroup>
                                    <col class="w-36">
                                    <col>
                                    <col class="w-36">
                                    <col>
                                </colgroup>
                                <tbody>
                                    <tr>
                                        <th scope="row"><label for="recptrNm" class="require">수령인</label></th>
                                        <td colspan="3">
                                        	<form:input path="recptrNm" class="form-control w-90" maxlength="50" />
                                        </td>
                                    </tr>
                                    <tr>
                                        <th scope="row"><label for="recptrMblTelno" class="require">휴대폰 번호</label></th>
                                        <td>
                                            <form:input path="recptrMblTelno" class="form-control w-90" maxlength="15" />
                                        </td>
                                        <th scope="row"><label for="recptrTelno">전화번호</label></th>
                                        <td>
                                            <form:input path="recptrTelno" class="form-control w-90" maxlength="15" />
                                        </td>
                                    </tr>
                                    <tr>
                                        <th scope="row"><label for="form-item4" class="require">배송지 주소</label></th>
                                        <td colspan="3">
                                            <div class="form-group">
                                                <form:input path="recptrZip" class="form-control w-50" maxlength="5" />
                                                <button type="button" class="btn-primary shadow w-30" onclick="f_findAdres('recptrZip', 'recptrAddr', 'recptrDaddr'); return false;">우편번호 검색</button>
                                            </div>
                                            <form:input path="recptrAddr" class="form-control w-full mt-1" maxlength="255" />
                                            <form:input path="recptrDaddr" class="form-control w-full mt-1" maxlength="255" />
                                        </td>
                                    </tr>
                                    <tr>
                                        <th scope="row"><label for="ordrrMemo">배송 메시지</label></th>
                                        <td colspan="3"><form:input path="ordrrMemo" class="form-control w-full" maxlength="255" /></td>
                                    </tr>
                                </tbody>
                            </table>

							<c:if test="${ordrDvlyBtn}">
                            <div class="text-right mt-2">
                                <button type="button" class="btn-primary shadow f_dlvy_save">배송지 저장</button>
                            </div>
                            </c:if>

							<%-- 주문금액이 0인경우 --%>
							<c:if test="${ordrVO.stlmYn eq 'Y' || ordrVO.stlmTy eq 'VBANK'}">
                            <p class="text-title2 mt-10">결제정보</p>
                            <table class="table-list">
                                <colgroup>
                                    <col class="w-26">
                                    <col class="w-32">
                                    <col>
                                    <col class="w-28">
                                    <col class="w-28">
                                    <col class="w-28">
                                    <col class="w-28">
                                    <col class="w-32">
                                </colgroup>
                                <thead>
                                    <tr>
                                        <th scope="col">결제일시</th>
                                        <th scope="col">결제수단</th>
                                        <th scope="col">승인/계좌 번호</th>
                                        <th scope="col">주문금액</th>
                                        <th scope="col">할인금액</th>
                                        <th scope="col">배송비</th>
                                        <th scope="col">결제금액</th>
                                        <th scope="col">마일리지 적립예정</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <tr>
                                        <td>${ordrVO.stlmDt}</td>
                                        <td>${bassStlmTyCode[ordrVO.stlmTy]}</td>
                                        <td class="text-left">
                                        	<c:choose>
                                        		<c:when test="${ordrVO.stlmTy eq 'VBANK'}">
                                            <p>[${ordrVO.dpstBankNm}] ${ordrVO.vrActno} / ${ordrVO.dpstr}</p>
                                            <p class="text-danger">
                                            	<c:if test="${ordrVO.stlmTy eq 'N'}">
                                                결제만료일 : ${ordrVO.dpstTermDt}<br>
                                                </c:if>
                                                결제자명 : ${ordrVO.pyrNm}
                                            </p>
                                        		</c:when>
                                        		<c:when test="${ordrVO.stlmTy eq 'CARD'}">
                                        	<p>카드승인번호 : ${ordrVO.cardAprvno}<br>
                                        		카드회사 : ${ordrVO.cardCoNm}<br>
                                        		카드번호 : ${ordrVO.cardNo}</p>
                                        		</c:when>
                                        		<c:when test="${ordrVO.stlmTy eq 'BANK'}">
                                        	<p>이체은행 : ${ordrVO.dpstBankNm}</p>
                                        		</c:when>
                                        		<c:when test="${ordrVO.stlmTy eq 'REBILL'}">
                                        	<p>카드승인번호 : ${ordrVO.cardAprvno}<br>
                                        		카드회사 : ${ordrVO.cardCoNm}<br>
                                        		카드번호 : ${ordrVO.cardNo}</p>
                                        		</c:when>
                                        		<c:when test="${ordrVO.stlmTy eq 'FREE'}">
                                        		결제금액 없음
                                        		</c:when>
                                        		<c:otherwise>
                                        		신용카드 > ${bassStlmTyCode[ordrVO.stlmTy]}
                                        		</c:otherwise>
                                        	</c:choose>
                                        </td>
                                        <td>
                                        	<strong>
                                   				<fmt:formatNumber value="${totalOrdrPc}" pattern="###,###" />
                                        	</strong>
                                        </td>
                                        <td>
                                        	<%-- 마일리지 + 포인트 + 쿠폰할인가 --%>
                                        	<strong><fmt:formatNumber value="${ordrVO.useMlg + ordrVO.usePoint + totalCouponAmt}" pattern="###,###" /></strong>
                                        </td>
                                        <td><fmt:formatNumber value="${totalDlvyBassAmt}" pattern="###,###"  /></td>
                                        <td><strong><fmt:formatNumber value="${ordrVO.stlmAmt}" pattern="###,###" /></strong></td>
                                        <td><fmt:formatNumber value="${totalAccmlMlg}" pattern="###,###" /></td>
                                    </tr>
                                </tbody>
                            </table>

                            <%-- 20230118 : 대여상태(정기결제) 추가 --%>
                            <c:if test="${ordrVO.ordrTy eq 'L' && ordrVO.stlmYn eq 'Y' }">
                            <p class="text-right mt-10" style="margin-bottom: -20px;">
                            	<%--<c:if test="${ordrVO.billingYn eq 'Y' }">--%>
                            	<c:if test="${ordrVO.stlmTy eq 'REBILL'}">
								<button type="button" class="btn-primary f_rebillCancel">자동결제 해지</button>
								</c:if>
								<!-- <button type="button" class="btn f_rebillPayChg" data-ordr-cd="${ordrVO.ordrCd}">결제카드 변경</button> -->
							</p>
                            <p class="text-title2">정기결제 <span class="text-success">(${ordrVO.billingDay}일)</span></p>
                            <table class="table-list">
                                <colgroup>
                                    <col class="w-26">
                                    <col class="w-32">
                                    <col>
                                    <col class="w-32">
                                    <col class="w-32">
                                    <col class="w-32">
                                </colgroup>
                                <thead>
                                    <tr>
                                        <th scope="col">결제일시</th>
                                        <th scope="col">결제수단</th>
                                        <th scope="col">승인/계좌 번호</th>
                                        <th scope="col">결제금액</th>
                                        <th scope="col">회차</th>
                                        <th scope="col">상태</th>
                                    </tr>
                                </thead>
                                <tbody>
                                	<c:forEach items="${ordrVO.ordrRebillList }" var="rebill" varStatus="status">
                                    <tr>
                                    	<td>${rebill.stlmDt }</td>
                                    	<td>${bassStlmTyCode[ordrVO.stlmTy]}</td>
                                    	<td class="text-left">
                                    		<c:if test="${rebill.stlmYn eq 'Y'}">
											<p>카드승인번호 : ${rebill.cardAprvno}<br>
                                        		카드회사 : ${rebill.cardCoNm}<br>
                                        		카드번호 : ${rebill.cardNo}</p>
                                        	</c:if>
                                        	<c:if test="${rebill.stlmYn eq 'N'}">
                                        	<p>${rebill.memo}</p>
                                        	</c:if>
                                    	</td>
                                    	<td><strong><fmt:formatNumber value="${rebill.stlmAmt}" pattern="###,###" /></strong></td>
                                    	<td>${rebill.ordrCnt}회차</td>
                                    	<td>${rebill.stlmYn eq 'Y'?'결제완료':'결제실패'}</td>
                                    </tr>
                                    </c:forEach>
                                </tbody>
                            </table>
                            </c:if>

							<c:if test="${ordrVO.useMlg + ordrVO.usePoint + totalCouponAmt > 0}">
                            <p class="text-title2 mt-10">기타 - 할인정보</p>
                            <table class="table-list">
                                <colgroup>
                                    <col class="w-40">
                                    <col>
                                    <col>
                                </colgroup>
                                <thead>
                                    <tr>
                                        <th scope="col">구분</th>
                                        <th scope="col">번호 / 명</th>
                                        <th scope="col">금액</th>
                                    </tr>
                                </thead>
                                <tbody>
                                	<c:forEach items="${ordrVO.ordrDtlList}" var="ordrDtl" varStatus="status">
                                	<c:if test="${ordrDtl.couponAmt > 0}">
                                    <tr>
                                        <td>쿠폰</td>
                                        <td>${ordrDtl.couponCd}</td>
                                        <td><fmt:formatNumber value="${ordrDtl.couponAmt}" pattern="###,###" /></td>
                                    </tr>
                                    </c:if>
                                    </c:forEach>
                                    <c:if test="${ordrVO.useMlg > 0}">
                                    <tr>
                                        <td>마일리지</td>
                                        <td>적립 마일리지 사용</td>
                                        <td><fmt:formatNumber value="${ordrVO.useMlg}" pattern="###,###" /></td>
                                    </tr>
                                    </c:if>
                                    <c:if test="${ordrVO.usePoint > 0}">
                                    <tr>
                                        <td>포인트</td>
                                        <td>적립 포인트 사용</td>
                                        <td><fmt:formatNumber value="${ordrVO.usePoint}" pattern="###,###" /></td>
                                    </tr>
                                    </c:if>
                                </tbody>
                                <tfoot>
                                    <tr>
                                        <td colspan="2">합계</td>
                                        <td><fmt:formatNumber value="${ordrVO.useMlg + ordrVO.usePoint + totalCouponAmt}" pattern="###,###" /></td>
                                    </tr>
                                </tfoot>
                            </table>
                           		</c:if>

                           	<%-- 20230215 : 환불정보 추가 --%>
                            <c:if test="${ordrRfndBtn}">

							<c:set var="totalRfndAmt" value="0" />
							<c:set var="totalRfndCouponAmt" value="0" />
							<c:set var="totalOrdrrPc" value="0" />
							<c:set var="rowspanNumber" value="0" />

                            <p class="text-title2 mt-10">환불정보</p>
                            <table class="table-list">
                                <colgroup>
                                    <col class="w-26">
                                    <col >
                                    <col class="w-25">
                                    <col >
                                </colgroup>
                                <thead>
                                    <tr>
                                        <th scope="col">취소 일시</th>
                                        <th scope="col">취소 상품</th>
                                        <th scope="col">환불 금액</th>
                                        <th scope="col">환불 방법</th>
                                    </tr>
                                </thead>
                                <tbody>
	                                    	<!-- 각각의 건 -->
	                                    	<c:forEach var="cancleList" items="${ordrVO.ordrDtlList}" varStatus="status">
	                                    	<c:set var="totalOrdrrPc" value="${totalOrdrrPc + cancleList.ordrPc}" />
	                                    	<c:set var="plusRfndAmt" value="${cancleList.rfndAmt}" />
	                                    		<c:if test="${cancleList.ordrDtlCd eq  ordrVO.ordrDtlList[status.index+1].ordrDtlCd}" >
	                                    			<c:set var="plusRfndAmt" value="${plusRfndAmt + ordrVO.ordrDtlList[status.index+1].rfndAmt}" />
	                                    			<c:set var="rowspanNumber" value="${rowspanNumber + 1}" />
	                                    		</c:if>
	                                    		<c:if test="${(cancleList.sttsTy eq 'CA02' || cancleList.sttsTy eq 'RF02' || cancleList.sttsTy eq 'CA01' || cancleList.sttsTy eq 'RF01' )&& cancleList.ordrOptnTy eq 'BASE'}">

	                                    		<c:set var="totalRfndAmt" value="${totalRfndAmt + plusRfndAmt}" />
	                                    		<c:set var="totalRfndCouponAmt" value="${totalRfndCouponAmt + cancleList.couponAmt}" />


			                                    	<tr>
			                                    		<c:choose>
			                                    			<c:when test="${totalOrdrrPc - (ordrVO.usePoint+ordrVO.useMlg+totalRfndCouponAmt) eq totalRfndAmt && status.last && (ordrVO.usePoint+ordrVO.useMlg+cancleList.couponAmt > 0)}">
			                                    				<td rowspan="4"><fmt:formatDate value="${cancleList.rfndDt}" pattern="yyyy-MM-dd" /></br><fmt:formatDate value="${cancleList.rfndDt}" pattern="HH:mm:ss"/></td>
			                                    			</c:when>
			                                    			<c:when test="${totalOrdrrPc - (ordrVO.usePoint+ordrVO.useMlg+totalRfndCouponAmt) eq totalRfndAmt && status.last && fn:length(ordrVO.ordrDtlList) < 2 }">
			                                    					<td rowspan="${rowspanNumber+3}"><fmt:formatDate value="${cancleList.rfndDt}" pattern="yyyy-MM-dd" /></br><fmt:formatDate value="${cancleList.rfndDt}" pattern="HH:mm:ss"/></td>
			                                    			</c:when>
			                                    			<c:otherwise>
			                                    				<td><fmt:formatDate value="${cancleList.rfndDt}" pattern="yyyy-MM-dd" /></br><fmt:formatDate value="${cancleList.rfndDt}" pattern="HH:mm:ss"/></td>
			                                    			</c:otherwise>
			                                    		</c:choose>
			                                    		<td>${cancleList.gdsInfo.gdsNm}</td>
			                                    		<td>
	                                    					<fmt:formatNumber value="${plusRfndAmt}" pattern="###,###" />
			                                    		</td>
			                                    		<td class="text-left" >
			                                    			<c:choose>
			                                    				<%-- 가상계좌 --%>
			                                    				<c:when test="${ordrVO.stlmTy eq 'VBANK' || ordrVO.stlmTy eq 'BANK'}">
			                                    					계좌이체 환불</br>${cancleList.rfndBank}&nbsp;${cancleList.rfndActno}&nbsp;${cancleList.rfndDpstr}
			                                    				</c:when>
			                                    				<c:otherwise>
			                                    					신용카드 승인 취소
			                                    				</c:otherwise>
			                                    			</c:choose>
			                                    		</td>
			                                    	</tr>
			                                    	<!-- totalOrdrrPc - (ordrVO.usePoint+ordrVO.useMlg+cancleList.couponAmt) eq totalRfndAmt &&  -->
			                                    	<c:if test="${totalOrdrrPc - (ordrVO.usePoint+ordrVO.useMlg+totalRfndCouponAmt) eq totalRfndAmt && status.last && (ordrVO.usePoint+ordrVO.useMlg+cancleList.couponAmt > 0)}">
				                                    	<tr>
				                                    		<td>포인트</td>
				                                    		<td><fmt:formatNumber value="${ordrVO.usePoint}" pattern="###,###" /></td>
				                                    		<td class="text-left">포인트 환원</td>
				                                    	</tr>
				                                    	<tr>
				                                    		<td>마일리지</td>
				                                    		<td><fmt:formatNumber value="${ordrVO.useMlg}" pattern="###,###" /></td>
				                                    		<td class="text-left">마일리지 환원</td>
				                                    	</tr>
				                                    	<tr>
				                                    		<td>쿠폰</td>
				                                    		<td><fmt:formatNumber value="${totalRfndCouponAmt}" pattern="###,###" /></td>
				                                    		<td class="text-left">쿠폰 환원</td>
				                                    	</tr>
				                                    	<tr>
				                                    		<td colspan="2">합계</td>
				                                    		<td><fmt:formatNumber value="${totalRfndAmt}" pattern="###,###" /></td>
				                                    		<td ></td>
				                                    	</tr>
			                                    	</c:if>
		                                    	</c:if>
	                                    	</c:forEach>
                                </tbody>
                            </table>

                            </c:if>

                            </c:if>
                        </div>
                    </div>
                </div>
                <%-- 카드변경 모달 --%>
                <div id="rebillPayChg"></div>
            </div>
            </form:form>
            <!-- //주문상세내역 -->


            <script>
            async function f_pay(frm){
            	//async
           		Bootpay.requestSubscription({
           		    application_id: "${_bootpayScriptKey}",
           		    pg: '이니시스',
           		    price: "${ordrVO.stlmAmt}",
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
          	    		    "username": "${ordrVO.ordrrNm}",
          	    		    "phone": "${ordrVO.ordrrMblTelno}",
          	    		    "email": "${ordrVO.ordrrEml}"
          	    		},
           		    extra: {
           		        subscription_comment: '매월 '+ "${ordrVO.stlmAmt}" +'원이 결제됩니다',
           		        subscribe_test_payment: true
           		    }
           		}).then(
           		    function (response) {
           		        if (response.event === 'done') {
           		        	console.log(response);

       			            const cardAprvno = response.data.receipt_data.card_data.card_approve_no; //카드 승인번호 => CARD_APRVNO
       			            const cardCoNm = response.data.receipt_data.card_data.card_company; //카드회사 => CARD_CO_NM
       			            const cardNo = response.data.receipt_data.card_data.card_no; //카드번호 => CARD_NO
       			         	const delngNo = response.data.receipt_id; // : 거래번호 => DELNG_NO

       			         	if(confirm("결제 정보를 변경하시겠습니까?")){
	     						$.ajax({
	     		       				type : "post",
	     		       				url  : "/_mng/ordr/rebillPayChg.json",
	     		       				data : {
		     		       				cardAprvno : cardAprvno
	       			            		, cardCoNm : cardCoNm
	       			            		, cardNo : cardNo
	       			            		, delngNo : delngNo
	       			            		, ordrNo : "${ordrVO.ordrNo}"
	     		       				},
	     		       				dataType : 'json'
	     		       			})
	     		       			.done(function(data) {
	     		       				if(data.result){
	     		       					alert("결제정보가 변경되었습니다.");
	     		       					$(".btn-reload").click();
	     		       				}
	     		       			})
	     		       			.fail(function(data, status, err) {
	     		       				console.log('정보변경 : error forward : ' + data);
	     		       			});
	     					}
           		        }
           		    },
           		    function (error) {
           		        console.log(error.message)
           		    }
           		)
            }

            $(function(){
            	$("#dtl-modal").on("shown.bs.modal", function () {

            	});

            	// reload
            	$(".btn-reload").on("click", function(){
	            	$("#ordr-dtl").load("/_mng/ordr/include/ordrDtlView", {ordrCd:'${ordrVO.ordrCd}'}, function(){
	            		$(".modal-backdrop").remove();
	            		$("#dtl-modal").modal('show');
        			});

            	});

            	// 택배사+송장번호 저장 -> 배송중 변경
            	$(".f_dlvyCo_save").on("click", function(e){
            		e.preventDefault();
            		var obj = $(this);
            		var dtlNo = $(this).data("dtlNo");
            		var dtlCd = $(this).data("dtlCd");
            		var dlvyCo = $("#dlvyCo_" + dtlNo).val();
            		var dlvyInvcNo = $("#dlvyInvcNo_" + dtlNo).val();
            		//console.log(dtlNo, dlvyCo, dlvyInvcNo);
            		if(dlvyCo != "" && dlvyInvcNo != ""){
            			obj.removeClass('btn-primary').addClass('btn').html('<i class="ico-loader"></i>');
	            		$.ajax({
	        				type : "post",
	        				url  : "/_mng/ordr/dlvyCoSave.json",
	        				data : {
	        					ordrNo:'${ordrVO.ordrNo}'
	        					//, ordrDtlNo:dtlNo
	        					, ordrDtlCd:dtlCd
	        					, dlvyCo:dlvyCo
	        					, dlvyInvcNo:dlvyInvcNo
	        				},
	        				dataType : 'json'
	        			})
	        			.done(function(data) {
	        				if(data.result){
	        					console.log("f_dlvyCo_save : success");
	        					obj.removeClass('btn').addClass('btn-primary').html('저장 완료');
	        					$(".btn-reload").click();
	        				}
	        			})
	        			.fail(function(data, status, err) {
	        				console.log('f_dlvyCo_save : error forward : ' + data);
	        				obj.html('실패(재시도)');
	        				$(".btn-reload").click();
	        			});
            		} else {
						alert("택배사와 송장번호를 입력해주세요");
						return false;
            		}

            	});

            	// 결제완료(OR05) > 배송준비중(OR06)
            	// 배송준비중(OR06) > 결제완료(OR05)
            	$(".f_ordr_confrm").on("click", function(e){
            		e.preventDefault();
            		var ordrCd = $(this).data("ordrCd");
            		var sttsTy = $(this).data("sttsTy");
            		var bSndngDt = false;
            		var skip = true;

            		//

            		$("input[name='sndngDt'].BASE").each(function(index, item){
            		    //console.log($(item).val(), $(item).data("dtlNo"));
            		    if($(item).val() == ""){
            		    	bSndngDt = true;
            		    }
            		});

            		if(sttsTy == "OR06"){ // 배송준비
            			if(bSndngDt){
                			if(confirm("배송예정일을 전부 입력하지 않았습니다.\n배송예정일을 오늘("+ f_getToday() +") 날짜로 진행하시겠습니까?")){
                				$("input[name='sndngDt']").val(f_getToday());
                				skip = false;
                			}else{
    		            		alert("배송예정일을 전부 입력해야 주문확정이 가능합니다.");
                			}
                		}else{
                			skip = false;
                		}

            		} else if(sttsTy == "OR05") { // 결제완료
            			if(confirm("주문확정을 취소합니다.\n[배송준비중 > 결제완료]")){
            				skip = false;
            			}
            		}

            		if(!skip){
            			var sndngDtList = new Array();
            			var dtLNoList = new Array();
            			var dtLCdList = new Array();

            			if(sttsTy == "OR06"){ // 배송준비
	            			$("input[type!='hidden'][name='sndngDt'].BASE").each(function(index, item){//배송날짜입력은 결제완료시만 나옴
	                		     //console.log($(item).val(), $(item).data("dtlNo"));
	                		     sndngDtList.push($(item).val());
	                		     dtLNoList.push($(item).data("dtlNo"));
	                		     dtLCdList.push($(item).data("dtlCd"));
	                		});
            			} else if(sttsTy == "OR05") { // 결제완료
	            			$("button.f_dlvyCo_save").each(function(index, item){//송장번호 저장버튼은 주문확정시만 나옴
	                		     //console.log($(item).data("dtlNo"));
	                		     sndngDtList.push(null);
	                		     dtLNoList.push($(item).data("dtlNo"));
	                		     dtLCdList.push($(item).data("dtlCd"));
	                		});
            			}


            			$.ajax({
            				type : "post",
            				url  : "/_mng/ordr/ordrConfrm.json", //주문확인
            				data : {
            					ordrNo:'${ordrVO.ordrNo}'
            					, sttsTy:sttsTy
            					, sndngDtList:sndngDtList
            					, dtLNoList:dtLNoList
            					, dtLCdList:dtLCdList
            				},
            				dataType : 'json'
            			})
            			.done(function(data) {
            				if(data.result){
            					console.log("f_ordr_chg_stts : success");
            					$(".btn-reload").click();
            				}
            			})
            			.fail(function(data, status, err) {
            				console.log('f_ordr_chg_stts : error forward : ' + data);
            			});
            		}
            	});

            	// (공통) 상태변경용
				$(".f_stts_chg").on("click", function(e){
					e.preventDefault();
					var dtlNo = $(this).data("dtlNo");
					var sttsTy = $(this).data("sttsTy");
					var msg = $(this).data("msg");
					var resnTy = $(this).data("resnTy");
					var resn = $(this).data("resn");

					if(confirm(msg)){
						//var ordrDtlNos = new Array();
						//ordrDtlNos.push(dtlNo);

						$.ajax({
	        				type : "post",
	        				url  : "/_mng/ordr/ordrSttsChgSave.json", //주문확인
	        				data : {
	        					ordrNo:'${ordrVO.ordrNo}'
	        					, ordrDtlNo:dtlNo
	        					, ordrDtlNos:dtlNo
	        					, sttsTy:sttsTy
	        					, resnTy:resnTy
	        					, resn:resn
	        				},
	        				dataType : 'json'
	        			})
	        			.done(function(data) {
	        				if(data.result){
	        					console.log("상태변경 : success");
	        					$(".btn-reload").click();
	        				}
	        			})
	        			.fail(function(data, status, err) {
	        				console.log('상태변경 : error forward : ' + data);
	        			});
					}
				});

            	//취소 완료 > f_rtrcn_confm
				$(".f_rtrcn_confm").on("click", function(e){
					e.preventDefault();
					var dtlCd = $(this).data("dtlCd");
					var msg = $(this).data("msg");
					var resnTy = $(this).data("resnTy");
					var resn = $(this).data("resn");

					if(confirm(msg)){
						$.ajax({
	        				type : "post",
	        				url  : "/_mng/ordr/ordrRtrcnSave.json", //취소완료
	        				data : {
	        					ordrNo:'${ordrVO.ordrNo}'
	        					, ordrDtlCd:dtlCd
	        					, resnTy:resnTy
	        					, resn:resn
	        				},
	        				dataType : 'json'
	        			})
	        			.done(function(data) {
	        				if(data.result){
	        					console.log("상태변경 : success");
	        					$(".btn-reload").click();
	        				}
	        			})
	        			.fail(function(data, status, err) {
	        				console.log('상태변경 : error forward : ' + data);
	        			});
					}
				});

            	// 배송지 저장
            	$(".f_dlvy_save").on("click", function(e){
            		e.preventDefault();
            		var recptrNm = $("#recptrNm").val();
            		var recptrMblTelno = $("#recptrMblTelno").val();
            		var recptrTelno = $("#recptrTelno").val();
            		var recptrZip = $("#recptrZip").val();
            		var recptrAddr = $("#recptrAddr").val();
            		var recptrDaddr = $("#recptrDaddr").val();
            		var ordrrMemo = $("#ordrrMemo").val();

            		var successHtml = '<div class="alert alert-success fade show"><p class="moji">:)</p><p class="text">배송지 정보가 저장되었습니다.</p><button type="button" data-bs-dismiss="alert" aria-label="close">닫기</button></div>';
            		var failHtml = '<div class="alert alert-danger fade show"><p class="moji">:(</p><p class="text">배송지 정보변경에 실패하였습니다.(잠시후 다시 시도해주세요.)</p><button type="button" data-bs-dismiss="alert" aria-label="close">닫기</button></div>';

            		$.ajax({
        				type : "post",
        				url  : "/_mng/ordr/dlvySave.json",
        				data : {
        					ordrCd:'${ordrVO.ordrCd}'
        					, recptrNm:recptrNm
        					, recptrMblTelno:recptrMblTelno
        					, recptrTelno:recptrTelno
        					, recptrZip:recptrZip
        					, recptrAddr:recptrAddr
        					, recptrDaddr:recptrDaddr
        					, ordrrMemo:ordrrMemo
        				},
        				dataType : 'json'
        			})
        			.done(function(data) {
        				if(data.result){
        					console.log("f_dlvy_save : success");
        					$(successHtml).insertAfter("#dlvyTable").fadeOut(3000, function(){ $(this).remove();});
        				}

        			})
        			.fail(function(data, status, err) {
        				console.log('f_dlvy_save : error forward : ' + data);
        				$(failHtml).insertAfter("#dlvyTable").fadeOut(3000, function(){ $(this).remove();});
        			});
            	});

	            // 배송완료 처리
	            $(".f_dlvy_done").on("click", function(e){
					e.preventDefault();
					var dtlCd = $(this).data("dtlCd");
					var msg = $(this).data("msg");
					var resnTy = $(this).data("resnTy");
					var resn = $(this).data("resn");

					if(confirm(msg)){
						$.ajax({
	        				type : "post",
	        				url  : "/_mng/ordr/dlvyDone.json",
	        				data : {
	        					ordrNo:'${ordrVO.ordrNo}'
	        					, ordrDtlCd:dtlCd
	        					, resnTy:resnTy
	        					, resn:resn
	        				},
	        				dataType : 'json'
	        			})
	        			.done(function(data) {
	        				if(data.result){
	        					console.log("상태변경 : success");
	        					$(".btn-reload").click();
	        				}
	        			})
	        			.fail(function(data, status, err) {
	        				console.log('상태변경 : error forward : ' + data);
	        			});
					}
				});

	         	// 구매확정 처리
				$(".f_ordr_done").on("click", function(e){
					e.preventDefault();
					var dtlCd = $(this).data("dtlCd");
					var msg = $(this).data("msg");
					var resnTy = $(this).data("resnTy");
					var resn = $(this).data("resn");

					if(confirm(msg)){
						$.ajax({
		       				type : "post",
		       				url  : "/_mng/ordr/ordrDone.json",
		       				data : {
		       					ordrNo:'${ordrVO.ordrNo}'
		       					, ordrDtlCd:dtlCd
		       					, resnTy:resnTy
		       					, resn:resn
		       				},
		       				dataType : 'json'
		       			})
		       			.done(function(data) {
		       				if(data.result){
		       					console.log("상태변경 : success");
		       					$(".btn-reload").click();
		       				}
		       			})
		       			.fail(function(data, status, err) {
		       				console.log('상태변경 : error forward : ' + data);
		       			});
					}
				});


				// 교환접수 승인
				$(".f_exchng_confm").on("click", function(e){
					e.preventDefault();
					var dtlCd = $(this).data("dtlCd");
					var msg = $(this).data("msg");
					var resnTy = $(this).data("resnTy");
					var resn = $(this).data("resn");

					if(confirm(msg)){
						$.ajax({
		       				type : "post",
		       				url  : "/_mng/ordr/exchngConfm.json",
		       				data : {
		       					ordrNo:'${ordrVO.ordrNo}'
		       					, ordrDtlCd:dtlCd
		       					, resnTy:resnTy
		       					, resn:resn
		       				},
		       				dataType : 'json'
		       			})
		       			.done(function(data) {
		       				if(data.result){
		       					console.log("상태변경 : success");
		       					$(".btn-reload").click();
		       				}
		       			})
		       			.fail(function(data, status, err) {
		       				console.log('상태변경 : error forward : ' + data);
		       			});
					}
				});

				// 교환완료
				$(".f_exchng_done").on("click", function(e){
					e.preventDefault();
					var dtlCd = $(this).data("dtlCd");
					var msg = $(this).data("msg");
					var resnTy = $(this).data("resnTy");
					var resn = $(this).data("resn");

					if(confirm(msg)){
						$.ajax({
		       				type : "post",
		       				url  : "/_mng/ordr/exchngDone.json",
		       				data : {
		       					ordrNo:'${ordrVO.ordrNo}'
		       					, ordrDtlCd:dtlCd
		       					, resnTy:resnTy
		       					, resn:resn
		       				},
		       				dataType : 'json'
		       			})
		       			.done(function(data) {
		       				if(data.result){
		       					console.log("상태변경 : success");
		       					$(".btn-reload").click();
		       				}
		       			})
		       			.fail(function(data, status, err) {
		       				console.log('상태변경 : error forward : ' + data);
		       			});
					}
				});


				// 반품접수 승인
				$(".f_return_confm").on("click", function(e){
					e.preventDefault();
					var dtlCd = $(this).data("dtlCd");
					var msg = $(this).data("msg");
					var resnTy = $(this).data("resnTy");
					var resn = $(this).data("resn");

					if(confirm(msg)){
						$.ajax({
		       				type : "post",
		       				url  : "/_mng/ordr/returnConfm.json",
		       				data : {
		       					ordrNo:'${ordrVO.ordrNo}'
		       					, ordrDtlCd:dtlCd
		       					, resnTy:resnTy
		       					, resn:resn
		       				},
		       				dataType : 'json'
		       			})
		       			.done(function(data) {
		       				if(data.result){
		       					console.log("상태변경 : success");
		       					$(".btn-reload").click();
		       				}
		       			})
		       			.fail(function(data, status, err) {
		       				console.log('상태변경 : error forward : ' + data);
		       			});
					}
				});

				// 반품완료
				$(".f_return_done").on("click", function(e){
					e.preventDefault();
					var dtlCd = $(this).data("dtlCd");
					var msg = $(this).data("msg");
					var resnTy = $(this).data("resnTy");
					var resn = $(this).data("resn");
					var rfndBank = $(this).data("rfndBank");
					var rfndActno = $(this).data("rfndActno");
					var rfndDpstr = $(this).data("rfndDpstr");

					if(confirm(msg)){
						$.ajax({
		       				type : "post",
		       				url  : "/_mng/ordr/returnDone.json",
		       				data : {
		       					ordrNo:'${ordrVO.ordrNo}'
		       					, ordrDtlCd:dtlCd
		       					, resnTy:resnTy
		       					, resn:resn
		     					, rfndBank : rfndBank
		       					, rfndActno : rfndActno
		       					, rfndDpstr : rfndDpstr
		       				},
		       				dataType : 'json'
		       			})
		       			.done(function(data) {
		       				if(data.result){
		       					console.log("상태변경 : success");
		       					$(".btn-reload").click();
		       				}
		       			})
		       			.fail(function(data, status, err) {
		       				console.log('상태변경 : error forward : ' + data);
		       			});
					}
				});


				// 환불완료
				$(".f_rfnd_done").on("click", function(e){
					e.preventDefault();
					var dtlCd = $(this).data("dtlCd");
					var msg = $(this).data("msg");
					var resnTy = $(this).data("resnTy");
					var resn = $(this).data("resn");

					if(confirm(msg)){
						$.ajax({
		       				type : "post",
		       				url  : "/_mng/ordr/rfndDone.json",
		       				data : {
		       					ordrNo:'${ordrVO.ordrNo}'
		       					, ordrDtlCd:dtlCd
		       					, resnTy:resnTy
		       					, resn:resn
		       				},
		       				dataType : 'json'
		       			})
		       			.done(function(data) {
		       				if(data.result){
		       					console.log("상태변경 : success");
		       					$(".btn-reload").click();
		       				}
		       			})
		       			.fail(function(data, status, err) {
		       				console.log('상태변경 : error forward : ' + data);
		       			});
					}
				});


				// 자동결제 해지
				$(".f_rebillCancel").on("click", function(e){
					e.preventDefault();
					if(confirm("자동 결제를 해지하시겠습니까?\n해지 후 재등록은 불가합니다.")){
						$.ajax({
		       				type : "post",
		       				url  : "/_mng/ordr/billingCancel.json",
		       				data : {
		       					ordrNo:'${ordrVO.ordrNo}'
		       					, billingKey:'${ordrVO.billingKey}'
		       				},
		       				dataType : 'json'
		       			})
		       			.done(function(data) {
		       				if(data.result){
		       					console.log("상태변경 : success");
		       					$(".btn-reload").click();
		       				}
		       			})
		       			.fail(function(data, status, err) {
		       				console.log('상태변경 : error forward : ' + data);
		       			});
					}

				});

				// 결제카드 변경
				$(".f_rebillPayChg").on("click",function(){
					//f_pay();
					const ordrCd = $(this).data("ordrCd");

					$("#rebillPayChg").load("/_mng/ordr/include/rebillPayChg",
          				{ordrCd : ordrCd
               			}, function(){
               				$("#ordr-rebill-chg-modal").modal("show");
               			});
				});

				// rowspan
            	$('.ordr-dtl-list tbody').mergeClassRowspan(0);
            	$('.ordr-dtl-list tbody').mergeClassRowspan(2);
            	$('.ordr-dtl-list tbody').mergeClassRowspan(6);
            	$('.ordr-dtl-list tbody').mergeClassRowspan(7);
            	$('.ordr-dtl-list tbody').mergeClassRowspan(8);
            	$('.ordr-dtl-list tbody').mergeClassRowspan(9);
            	$('.ordr-dtl-list tbody').mergeClassRowspan(10);


            });
            </script>