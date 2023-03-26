<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

			<jsp:include page="../layout/page_header.jsp">
				<jsp:param value="주문관리" name="pageTitle"/>
			</jsp:include>

			<div id="page-content">
				<!-- 검색영역 -->
				<form id="searchFrm" name="searchFrm" method="get" action="${_curPath }">
				<input type="hidden" name="cntPerPage" id="cntPerPage" value="${listVO.cntPerPage}" />
				<input type="hidden" name="sortBy" id="sortBy" value="${param.sortBy}" />

                <fieldset>
                    <legend class="text-title2">주문 검색</legend>
                    <table class="table-detail">
                        <colgroup>
                            <col class="w-43">
                            <col>
                            <col class="w-43">
                            <col>
                        </colgroup>
                        <tbody>
                            <tr>
                                <th scope="row"><label for="srchSttsTy">주문상태</label></th>
                                <td colspan="3">
                                <c:choose>
                                	<c:when test="${ordrSttsTy eq 'ALL' }">
                                	<select name="srchSttsTy" id="srchSttsTy" class="form-control w-84">
                                        <option value="">주문상태 선택</option>
                                        <c:forEach items="${ordrSttsCode}" var="iem">
                                        <option value="${iem.key}" ${iem.key eq param.srchSttsTy?'selected="selected"':'' }>${iem.value}</option>
                                        </c:forEach>
                                    </select>
                                	</c:when>
                                	<c:when test="${ordrSttsTy eq 'OR06' }">
                                	<select name="srchSttsTy" id="srchSttsTy" class="form-control w-84">
                                        <c:forEach items="${ordrSttsCode}" var="iem">
                                        <c:if test="${iem.key eq 'OR06' || iem.key eq 'OR07' || iem.key eq 'OR08'}">
                                        <option value="${iem.key}" ${iem.key eq param.srchSttsTy?'selected="selected"':'' }>${iem.value}</option>
                                        </c:if>
                                        </c:forEach>
                                    </select>
                                	</c:when>
                                	<c:when test="${ordrSttsTy eq 'EX01' }">
                                	<select name="srchSttsTy" id="srchSttsTy" class="form-control w-84">
                                        <c:forEach items="${ordrSttsCode}" var="iem">
                                        <c:if test="${fn:startsWith(iem.key, 'EX')}">
                                        <option value="${iem.key}" ${iem.key eq param.srchSttsTy?'selected="selected"':'' }>${iem.value}</option>
                                        </c:if>
                                        </c:forEach>
                                    </select>
                                	</c:when>
                                	<c:when test="${ordrSttsTy eq 'OR09'}">
                                		<select name="srchSttsTy" id="srchSttsTy" class="form-control w-84" disabled=true>
                                		<c:forEach items="${ordrSttsCode}" var="iem">
                                		<c:if test="${iem.key eq 'OR09'}">
                                        <option value="${iem.key}" ${iem.key eq param.srchSttsTy?'selected="selected"':'' }>${iem.value}</option>
                                        </c:if>
                                        </c:forEach>
                                		</select>
                                	</c:when>
                                	<c:when test="${ordrSttsTy eq 'OR05' || ordrSttsTy eq 'OR04' || ordrSttsTy eq 'OR03' || ordrSttsTy eq 'OR02' || ordrSttsTy eq 'OR01'}">
                                		<select name="srchSttsTy" id="srchSttsTy" class="form-control w-84" disabled=true>
                                		 <c:forEach items="${ordrSttsCode}" var="iem">
                                		<option value="${iem.key}" ${iem.key eq ordrSttsTy?'selected="selected"':'' }>${iem.value}</option>
                                        </c:forEach>
                                        </select>
                                	</c:when>
                                	<c:when test="${fn:startsWith(ordrSttsTy, 'CA')}">
                                		<select name="srchSttsTy" id="srchSttsTy" class="form-control w-84">
                                		 <c:forEach items="${ordrSttsCode}" var="iem" begin="09" end="11">
                                		<option value="${iem.key}" ${iem.key eq param.srchSttsTy?'selected="selected"':'' }>${iem.value}</option>
                                        </c:forEach>
                                        </select>
                                	</c:when>
                                	<c:when test="${fn:startsWith(ordrSttsTy, 'RE')}">
                                		<select name="srchSttsTy" id="srchSttsTy" class="form-control w-84">
                                		 <c:forEach items="${ordrSttsCode}" var="iem" begin="15" end="17">
                                		<option value="${iem.key}" ${iem.key eq param.srchSttsTy?'selected="selected"':'' }>${iem.value}</option>
                                        </c:forEach>
                                        </select>
                                	</c:when>
                                	<c:when test="${fn:startsWith(ordrSttsTy, 'RF')}">
                                		<select name="srchSttsTy" id="srchSttsTy" class="form-control w-84">
                                		 <c:forEach items="${ordrSttsCode}" var="iem" begin="18" end="19">
                                		<option value="${iem.key}" ${iem.key eq param.srchSttsTy?'selected="selected"':'' }>${iem.value}</option>
                                        </c:forEach>
                                        </select>
                                	</c:when>
                                	<c:otherwise>
                                	<select name="srchSttsTy" id="srchSttsTy" class="form-control w-84">
                                        <c:forEach items="${ordrSttsCode}" var="iem">
                                        <option value="${iem.key}" ${iem.key eq ordrSttsTy?'selected="selected"':'' }>${iem.value}</option>
                                        </c:forEach>
                                    </select>
                                	</c:otherwise>
                                </c:choose>
                                </td>
                            </tr>
                            <tr>
                                <th scope="row"><label for="srchOrdrYmdBgng">주문일자</label></th>
                                <td colspan="3">
                                    <div class="form-group">
                                        <input type="date" class="form-control w-39 calendar" id="srchOrdrYmdBgng" name="srchOrdrYmdBgng" value="${param.srchOrdrYmdBgng}">
                                        <i>~</i>
                                        <input type="date" class="form-control w-39 calendar" id="srchOrdrYmdEnd" name="srchOrdrYmdEnd" value="${param.srchOrdrYmdEnd}">
                                        <button type="button" class="btn shadow" onclick="f_srchOrdrYmdSet('1'); return false;">오늘</button>
                                        <button type="button" class="btn shadow" onclick="f_srchOrdrYmdSet('2'); return false;">7일</button>
                                        <button type="button" class="btn shadow" onclick="f_srchOrdrYmdSet('3'); return false;">15일</button>
                                        <button type="button" class="btn shadow" onclick="f_srchOrdrYmdSet('4'); return false;">1개월</button>
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <th scope="row"><label for="srchOrdrrNm">주문자 / 수령인</label></th>
                                <td>
                                    <div class="form-group w-84">
                                        <input type="text" class="form-control flex-1" id="srchOrdrrNm" name="srchOrdrrNm" value="${param.srchOrdrrNm}">
                                        <i>/</i>
                                        <input type="text" class="form-control flex-1" id="srchRecptrNm" name="srchRecptrNm" value="${param.srchRecptrNm}">
                                    </div>
                                </td>
                                <th scope="row"><label for="srchOrdrrId">아이디</label></th>
                                <td><input type="text" class="form-control w-84" id="srchOrdrrId" name="srchOrdrrId" value="${param.srchOrdrrId}"></td>
                            </tr>
                            <tr>
                                <th scope="row"><label for="srchGdsCd">상품번호</label></th>
                                <td><input type="text" class="form-control w-84" id="srchGdsCd" name="srchGdsCd" value="${param.srchGdsCd }"></td>
                                <th scope="row"><label for="srchOrdrrTelno">연락처</label></th>
                                <td><input type="text" class="form-control w-84" id="srchOrdrrTelno" name="srchOrdrrTelno" value="${param.srchOrdrrTelno}"></td>
                            </tr>
                            <tr>
                                <th scope="row"><label for="srchOrdrTy">상품구분</label></th>
                                <td>
                                    <select name="srchOrdrTy" id="srchOrdrTy" class="form-control w-84">
                                        <option value="">상품구분 선택</option>
                                        <c:forEach items="${gdsTyCode}" var="iem">
                                        <option value="${iem.key}" ${param.srchOrdrTy eq iem.key?'selected="selected"':'' }>${iem.value}</option>
                                        </c:forEach>
                                    </select>
                                </td>
                                <th scope="row"><label for="srchStlmTy">결제수단</label></th>
                                <td>
                                    <select name="srchStlmTy" id="srchStlmTy" class="form-control w-84">
                                        <option value="">결제수단 선택</option>
                                        <c:forEach items="${bassStlmTyCode}" var="iem">
                                        <option value="${iem.key}" ${param.srchStlmTy eq iem.key?'selected="selected"':'' }>${iem.value}</option>
                                        </c:forEach>
                                    </select>
                                </td>
                            </tr>
                            <tr>
                                <th scope="row"><label for="srchGdsNm">상품명</label></th>
                                <td colspan="3"><input type="text" class="form-control w-full" id="srchGdsNm" name="srchGdsNm" value="${param.srchGdsNm}"></td>
                            </tr>
                        </tbody>
                    </table>
                </fieldset>

                <div class="btn-group mt-5">
                    <button type="submit" class="btn-primary large shadow w-52">검색</button>
                </div>
                </form>

				<c:if test="${ordrSttsTy eq 'OR01' }">
				<p class="mt-7 text-gray1">
                    * 주문 승인대기는 급여 상품만 적용됩니다.<br>
                    * 멤버스 승인 후 결제가 진행된 주문은 <strong class="text-primary">결제대기 또는 결제완료 목록으로 이동</strong>합니다.
                </p>
                </c:if>

				<c:if test="${ordrSttsTy eq 'OR04' }">
				<p class="mt-7 text-gray1">
                    * 결제대기 주문만 확인 가능하며, 결제 완료된 주문은 자동으로 <strong class="text-primary">결제완료 목록으로 이동</strong>합니다.<br>
                    * 결제기한(주문일 +3일) 내 결제되지 않은 주문은 자동 주문 취소되어 <strong class="text-primary">취소관리 목록으로 이동</strong>합니다.
                </p>
                </c:if>
				<c:if test="${ordrSttsTy eq 'OR05' }">
				<p class="mt-7 text-gray1">
                    * 결제완료 주문만 확인 가능하며, <strong class="text-primary">주문확정 처리</strong>해 주세요<br>
                    * 주문확정 처리된 주문은 <strong class="text-primary">배송준비중 상태로 변경되며, 배송관리 목록으로 이동됩니다.</strong>
                </p>
                </c:if>
                <c:if test="${ordrSttsTy eq 'OR06' }">
                <p class="mt-7 text-gray1">
                    * 배송준비중, 배송중, 배송완료 상태의 주문을 확인할 수 있습니다.<br>
                    * 구매확정 처리된 주문은 <strong class="text-primary">구매확정 목록으로 이동</strong>합니다.
                </p>
                </c:if>
				<c:if test="${ordrSttsTy eq 'CA01' }">
				<p class="mt-7 text-gray1">
                    * 승인 즉시 취소(환불)가 불가능한 주문에 대한 결제 완료 후, 취소완료  처리를 위한 관리 목록입니다<br>
                    * 주문취소, 취소접수, 취소완료  상태의 주문을 확인할 수 있습니다.
                </p>
                </c:if>
                <c:if test="${ordrSttsTy eq 'RE01' }">
                <p class="mt-7 text-gray1">
                    * 반품접수, 반품접수승인, 반품대기중, 반품완료 상태의 주문을 확인할 수 있습니다.<br>
                    * 신용카드, 계좌이체/가상계좌 일부는  반품완료 시 즉시 결제취소됩니다.<br>
                    * <strong class="text-danger">즉시 결제취소(환불)가 불가능한 주문은 반품완료 시 환불접수 처리</strong>되며, <strong class="text-primary">환불관리 목록</strong>으로 이동됩니다.
                </p>
                </c:if>
                <c:if test="${fn:startsWith(ordrSttsTy, 'RF')}">
                <p class="mt-7 text-gray1">
                    * 환불접수, 환불완료 상태의 주문을 확인할 수 있으며, 환불처리 상태만 변경됩니다.<br>
                </p>
                </c:if>

                <div class="mt-13 text-right mb-2">
                    <button type="button" class="btn-primary">엑셀 다운로드</button>
                </div>

                <p class="text-title2">주문 목록</p>
                <div class="scroll-table">
                    <table class="table-list">
                        <colgroup>
                            <col class="min-w-28">
                            <col class="min-w-25 w-25">
                            <col class="min-w-23 w-23">
                            <col class="min-w-23 w-23">
                            <col class="min-w-20 w-20">
                            <col class="min-w-30">
                            <col class="min-w-30 w-30">
                            <col class="min-w-20 w-20">
                            <col class="min-w-25 w-25">
                            <col class="min-w-25 w-25">
                            <col class="min-w-25 w-25">
                            <col class="min-w-25 w-25">
                            <col class="min-w-25 w-25">
                            <col class="min-w-30 w-30">
                            <col class="min-w-30 w-30">
                            <col class="min-w-32">
                            <col class="min-w-32 w-30">
                        </colgroup>
                        <thead>
                            <tr>
                                <th scope="col" rowspan="2">주문일시</th>
                                <th scope="col" rowspan="2">주문자</th>
                                <th scope="col" rowspan="2">수령인</th>
                                <th scope="col" rowspan="2">상품구분</th>
                                <%-- loop area S --%>
                                <th scope="col" rowspan="2">상품번호</th>
                                <th scope="col" rowspan="2">상품명/옵션</th>
                                <th scope="col" rowspan="2">상품가격</th>
                                <th scope="col" rowspan="2">수량</th>
                                <th scope="col" rowspan="2">주문금액</th>
                                <th scope="colgroup" colspan="3">할인금액</th>
                                <%-- loop area E --%>
                                <th scope="col" rowspan="2">배송비</th>
                                <th scope="col" rowspan="2">결제금액</th>
                                <th scope="col" rowspan="2">결제수단</th>
                                <th scope="col" rowspan="2">멤버스</th>
                                <th scope="col" rowspan="2">주문상태</th>
                            </tr>
                            <tr>
                                <th scope="col">쿠폰</th>
                                <th scope="col">마일리지</th>
                                <th scope="col" class="nolast">포인트</th>
                            </tr>
                        </thead>
                        <tbody>
                        	<c:forEach items="${listVO.listObject}" var="resultList" varStatus="status">
                        	<tr>
                                <td class="${resultList.ordrCd}">
                                    <a href="#dtl-modal1" class="btn shadow w-full f_gds_dtl" data-ordr-cd="${resultList.ordrCd}" style="height:auto;">
                                        <fmt:formatDate value="${resultList.ordrDt}" pattern="yyyy-MM-dd" /><br>
                                        ${resultList.ordrCd}
                                    </a>
                                </td>
                                <td class="${resultList.ordrCd}">

                                    <%-- <a href="/_mng/mbr/mbr/view?uniqueId=${resultList.uniqueId }" target="_blank" class="btn shadow w-full" style="height:auto;">
                                        ${resultList.ordrrNm}<br>
                                        (${resultList.ordrrId})
                                    </a> --%>
                                    ${resultList.ordrrNm}<br>
                                    (${resultList.ordrrId})
                                </td>
                                <td class="${resultList.ordrCd}">${resultList.recptrNm}</td>
                                <td class="${resultList.ordrDtlCd}">${gdsTyCode[resultList.ordrTy]}</td>

                                <td class="${resultList.ordrDtlCd }">
                                	<%-- <a href="/_mng/gds/gds/form?gdsNo=${resultList.gdsNo}" target="_blank" class="btn-outline-success shadow w-full">
                                		${resultList.gdsCd}
                                	</a> --%>

                                	<a href="#" class="btn-outline-success shadow w-full">
                                		${resultList.gdsCd}
                                	</a>
                                </td>
                                <td class="text-left">
                                	<c:if test="${resultList.ordrOptnTy eq 'ADIT' }"><%--추가상품--%>
                                    <i class="ico-reply"></i>
                                    <span class="badge">추가옵션</span>
                               		${resultList.ordrOptn }
                                    </c:if>
                                    <c:if test="${resultList.ordrOptnTy eq 'BASE' }"><%--주문상품--%>
                                    ${resultList.gdsNm}
                               		<c:if test="${!empty resultList.ordrOptn}"><br>(${resultList.ordrOptn })</c:if>
                                    </c:if>
                                </td>
                                <td class="text-right">
                                	<%-- <fmt:formatNumber value="${resultList.gdsPc}" pattern="###,###" />
                                	<c:if test="${resultList.ordrOptnPc>0}">
                                	<br>(<fmt:formatNumber value="${resultList.ordrOptnPc}" pattern="###,###" />)
                                	</c:if> --%>
                                	<c:if test="${resultList.ordrOptnTy eq 'BASE'}">
                                    <fmt:formatNumber value="${resultList.gdsPc}" pattern="###,###" />
                                    <br>(+<fmt:formatNumber value="${resultList.ordrOptnPc}" pattern="###,###" />)
                                    </c:if>
                                    <c:if test="${resultList.ordrOptnTy eq 'ADIT'}"><span class="ordrOptnPc">
                                    +<fmt:formatNumber value="${resultList.ordrOptnPc}" pattern="###,###" /></span>
                                    </c:if>
                                </td>
                                <td><fmt:formatNumber value="${resultList.ordrQy}" pattern="###,###" /></td>
                                <td class="text-right"><fmt:formatNumber value="${resultList.ordrPc }" pattern="###,###" /></td>
                                <td class="text-right ${resultList.ordrDtlCd}"><fmt:formatNumber value="${resultList.couponAmt }" pattern="###,###" /></td>
                                <td class="text-right ${resultList.ordrCd}"><fmt:formatNumber value="${resultList.useMlg }" pattern="###,###" /></td>
                                <td class="text-right ${resultList.ordrCd}"><fmt:formatNumber value="${resultList.usePoint }" pattern="###,###" /></td>

                                <td class="text-right ${resultList.ordrDtlCd}">
                                	<%-- 배송비 TO-DO : 각각의 상품에 배송비가 붙는경우? 체크 --%>
                                	<fmt:formatNumber value="${resultList.dlvyBassAmt}" pattern="###,###" />
                                	<c:if test="${resultList.dlvyAditAmt>0}">
                                	<br>(<fmt:formatNumber value="${resultList.dlvyAditAmt}" pattern="###,###" />)
                                	</c:if>
                                </td>

                                <td class="text-right ${resultList.ordrCd}">
                                	<fmt:formatNumber value="${resultList.stlmAmt}" pattern="###,###" />
                                </td>
                                <td class="${resultList.ordrCd}">
                                	<c:if test="${!empty resultList.stlmTy }">
                                	${bassStlmTyCode[resultList.stlmTy]}
                                	</c:if>
                                	<c:if test="${empty resultList.stlmTy }">미정</c:if>
                                </td>

                                <td class="${resultList.ordrCd}">
                                	<c:choose>
                                		<c:when test="${!empty resultList.bplcUniqueId}">
                                		${resultList.bplcInfo.bplcNm}
                                		</c:when>
                                		<c:otherwise>-</c:otherwise>
                                	</c:choose>
                                </td>
                                <td class="${resultList.ordrDtlCd }">
                                	<c:choose>
                                		<c:when test="${(resultList.sttsTy eq 'RE03' || resultList.sttsTy eq 'RF01') && resultList.rfndYn eq 'N'}"><%--반품완료+환불미완료 --%>
                                	<span class="text-danger">환불접수</span><br>(반품완료)
                                		</c:when>
                                		<c:when test="${(resultList.sttsTy eq 'RE03' || resultList.sttsTy eq 'RF02') && resultList.rfndYn eq 'Y'}"><%--반품완료+환불완료 --%>
                                	<span class="text-danger">환불완료</span><br>(반품완료)
                                		</c:when>
                                		<c:otherwise>
                                    ${ordrSttsCode[resultList.sttsTy]}
                                		</c:otherwise>
                                	</c:choose>

                                    <%-- 배송중, 배송완료, 구매확정 --%>
                                    <c:if test="${resultList.sttsTy eq 'OR07' || resultList.sttsTy eq 'OR08'}">
                                    <br><a href="#">${resultList.dlvyInvcNo }</a>
                                    </c:if>
                                </td>

                            </tr>
                            </c:forEach>
                            <c:if test="${empty listVO.listObject}">
	                        <tr>
	                            <td class="noresult" colspan="17">주문내역이 없습니다.</td>
	                        </tr>
	                        </c:if>
                        </tbody>
                    </table>
                </div>

                <div class="pagination mt-7">
                    <mngr:mngrPaging listVO="${listVO}"/>

    				<div class="sorting2">
                        <label for="countPerPage">출력</label>
                        <select name="countPerPage" id="countPerPage" class="form-control">
                            <option value="10" ${listVO.cntPerPage eq '10' ? 'selected' : '' }>10개</option>
							<option value="20" ${listVO.cntPerPage eq '20' ? 'selected' : '' }>20개</option>
							<option value="30" ${listVO.cntPerPage eq '30' ? 'selected' : '' }>30개</option>
                        </select>
                    </div>

                    <div class="counter">총 <strong>${listVO.totalCount}</strong>건, <strong>${listVO.curPage}</strong>/${listVO.totalPage} 페이지</div>
                </div>
			</div>

				<%-- TO-DO : code refactoring --%>
				<%-- 주문상세 모달 --%>
				<div id="ordr-dtl"></div>

				<%-- 주문상세 > 옵션변경 모달 --%>
				<div id="ordr-optn"></div>

				<%-- 주문상세 > 주문취소 모달 --%>
				<div id="ordr-rtrcn"></div>

				<%-- 주문상세 > 진행내역 --%>
				<div id="ordr-stts-hist"></div>

				<%-- 주문상세 > 교환 --%>
				<div id="ordr-exchng"></div>

				<%-- 주문상세 > 반품 모달 --%>
				<div id="ordr-return"></div>

				<%-- 주문상세 > 승인관리 모달 --%>
				<div id="ordr-confm"></div>

				<script>
                function f_srchOrdrYmdSet(ty){
                	//srchOrdrYmdBgng, srchOrdrYmdEnd
                	$("#srchOrdrYmdEnd").val(f_getToday());
                	if(ty == "1"){//오늘
                   		$("#srchOrdrYmdBgng").val(f_getToday());
                	}else if(ty == "2"){//일주일
                		$("#srchOrdrYmdBgng").val(f_getDate(-7));
                	}else if(ty == "3"){//15일
                		$("#srchOrdrYmdBgng").val(f_getDate(-15));
                	}else if(ty == "4"){//한달
                		$("#srchOrdrYmdBgng").val(f_getDate(-30));
                	}
                }

                $(function(){
                	//상품상세
                	$(".f_gds_dtl").on("click", function(e){
                		e.preventDefault();
                		var ordrCd = $(this).data("ordrCd");
                		$("#ordr-dtl").load("./include/ordrDtlView"
                			, {ordrCd:ordrCd}
                			, function(){
		                		$("#dtl-modal").addClass('fade').modal('show');
                			});
                	});


                	//TO-DO : DTL로 이동 필요
                	//모달+모달창 닫힘
                    $(document).on('click', '.modal-inner [data-bs-dismiss]', function(e) {
                        $(this).closest('.modal').removeClass('show').delay(100).hide(0);
                        return false;
                    });

                	//옵션변경 모달
                	$(document).on("click", ".f_optn_chg", function(){
                		const gdsNo = $(this).data("gdsNo");
                		const ordrDtlNo = $(this).data("dtlNo");
                		const ordrDtlCd = $(this).data("dtlCd");
                		$("#ordr-optn").load("./include/optnChg",
               				{ordrDtlNo:ordrDtlNo
	                			, gdsNo:gdsNo
	                			, ordrDtlCd:ordrDtlCd
                			}, function(){
	                			//$("#optn-chg-modal").show(0).addClass('show');
	                			$("#optn-chg-modal").modal('show');
                			});
                	});

                	//주문취소 모달
                	$(document).on("click", ".f_ordr_rtrcn", function(){
                		const ordrCd = $(this).data("ordrCd");
                		$("#ordr-rtrcn").load("./include/ordrRtrcn",
               				{ordrCd:ordrCd
                			}, function(){

                				$("#ordr-rtrcn-modal").modal('show');
                			});
                	});

                	//교환 모달
	            	$(document).on("click", ".f_gds_exchng", function(e){
	            		const ordrNo = $(this).data("ordrNo");
	            		const ordrDtlCd = $(this).data("dtlCd");
                		$("#ordr-exchng").load("./include/ordrExchng",
               				{ordrNo:ordrNo, ordrDtlCd:ordrDtlCd
                			}, function(){
                				$("#ordr-exchng-modal").modal("show");
                			});
	            	});

	            	// 반품 모달
	            	$(document).on("click", ".f_gds_return", function(e){
	            		const ordrCd = $(this).data("ordrCd");
                		$("#ordr-return").load("./include/ordrReturn",
               				{ordrCd:ordrCd
                			}, function(){

                				$("#ordr-return-modal").modal('show');
                			});
	            	});

                	// 주문상세 > 진행내역
                	$(document).on("click", ".f_ordr_stts_hist", function(){
                		const ordrDtlNo = $(this).data("dtlNo");
                		$("#ordr-stts-hist").load("./include/ordrSttsHist",
               				{ordrDtlNo:ordrDtlNo
                			}, function(){

                				$("#ordr-stts-hist-modal").modal('show');
                			});

                	});

                	$(document).on("click", ".f_ordr_dtl_confrm", function(){
                		const ordrDtlNo = $(this).data("dtlNo");
                		$("#ordr-stts-hist").load("./include/ordrConfm",
               				{ordrDtlNo:ordrDtlNo
                			}, function(){

                				$("#ordr-confm-modal").modal('show');
                			});

                	});

                	$(".btn-excel").on("click", function(){
	            		$("#searchFrm").attr("action","excel").submit();
	            		$("#searchFrm").attr("action","list");
	            	});

                	// rowspan
                	$('.table-list tbody').mergeClassRowspan(0);
                	$('.table-list tbody').mergeClassRowspan(1);
                	$('.table-list tbody').mergeClassRowspan(2);
                	$('.table-list tbody').mergeClassRowspan(3);
                	$('.table-list tbody').mergeClassRowspan(4);
					$('.table-list tbody').mergeClassRowspan(9);
                	$('.table-list tbody').mergeClassRowspan(10);
                	$('.table-list tbody').mergeClassRowspan(11);
                	$('.table-list tbody').mergeClassRowspan(12);
                	$('.table-list tbody').mergeClassRowspan(13);
                	$('.table-list tbody').mergeClassRowspan(14);
                	$('.table-list tbody').mergeClassRowspan(15);
                	$('.table-list tbody').mergeClassRowspan(16);

                	// 출력 갯수
	                $("#countPerPage").on("change", function(){
						var cntperpage = $("#countPerPage option:selected").val();
						$("#cntPerPage").val(cntperpage);
						$("#searchFrm").submit();
					});

                });
                </script>