<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

	<main id="container">

		<jsp:include page="../layout/page_header.jsp">
			<jsp:param value="상품 주문" name="pageTitle"/>
		</jsp:include>

		<form:form modelAttribute="ordrVO"  name="frmOrdr" id="frmOrdr" method="post" action="./ordrRqstAction" enctype="multipart/form-data">
		<form:hidden path="ordrTy" />
		<form:hidden path="ordrCd" />

		<%--2023-03-23 더블 서브밋 방지 추가 --%>
        <double-submit:preventer tokenKey="preventTokenKey" />

		<div id="page-container">

			<div id="page-content">
                <h3 class="text-title mb-3 md:mb-4">주문 상품</h3>

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
		                            <p class="order-item-price"><fmt:formatNumber value="${sumOrdrPc}" pattern="###,###" />원</p>

									<div class="order-item-info">
                                        <div class="payment">
                                        	<%-- 멤버스 --%>
                                        	<c:if test="${ordrVO.ordrTy eq 'R' || ordrVO.ordrTy eq 'L'}"><%-- 급여구매일 경우만 경우만 멤버스(사업소) 있음 --%>
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
                    </div>

                	</c:if>

					<%-- 주문정보 ALL START --%>
					<div>
						<%-- 배송비 + 추가배송비 --%>
						<c:set var="totalDlvyBassAmt" value="${totalDlvyBassAmt + (ordrDtl.ordrOptnTy eq 'BASE'?(ordrDtl.gdsInfo.dlvyBassAmt + ordrDtl.gdsInfo.dlvyAditAmt):0)}" />
						<%-- 적립예정마일리지 --%>
	                    <c:set var="totalAccmlMlg" value="${totalAccmlMlg + ordrDtl.accmlMlg}" />
	                    <%-- 주문금액 + 옵션금액 --%>
	                    <c:set var="totalOrdrPc" value="${totalOrdrPc + ordrDtl.ordrPc}" />


						<%-- 배열 --%>
						<input type="hidden" name="ordrDtlCd" value="${ordrVO.ordrCd}_${dtlIndex}">
						<input type="hidden" name="gdsNo" value="${ordrDtl.gdsNo }">
						<input type="hidden" name="gdsCd" value="${ordrDtl.gdsCd }">
						<input type="hidden" name="gdsNm" value="${ordrDtl.gdsNm }">
						<input type="hidden" name="gdsPc" value="${ordrDtl.gdsPc }">
						<input type="hidden" name="bnefCd" value="${ordrDtl.bnefCd }">

						<input type="hidden" name="ordrOptnTy" value="${ordrDtl.ordrOptnTy }">
						<input type="hidden" name="ordrOptn" value="${ordrDtl.ordrOptn }">
						<input type="hidden" name="ordrOptnPc" value="${ordrDtl.ordrOptnPc }">
						<input type="hidden" name="ordrQy" value="${ordrDtl.ordrQy }">
						<input type="hidden" name="dlvyBassAmt" value="${ordrDtl.ordrOptnTy eq 'BASE'?ordrDtl.gdsInfo.dlvyBassAmt:0}"> <%--배송비 > 추가옵션일경우 제외 --%>
						<input type="hidden" name="dlvyAditAmt" value="${ordrDtl.ordrOptnTy eq 'BASE'?ordrDtl.gdsInfo.dlvyAditAmt:0}"> <%--추가 배송비 > 추가옵션일경우 제외 --%>

						<input type="hidden" name="ordrPc" value="${ordrDtl.ordrPc }"> <%--건별 주문금액--%>

						<input type="hidden" name="couponNo" value=""> <%--쿠폰번호 > 쿠폰선택 시점에서 채워줌 --%>
	                    <input type="hidden" name="couponCd" value=""> <%--쿠폰코드 > 쿠폰선택 시점에서 채워줌 --%>
	                    <input type="hidden" name="couponAmt" value="0"> <%--쿠폰적용 금액 > 쿠폰선택 시점에서 채워줌 --%>

						<input type="hidden" name="recipterUniqueId" value="${ordrDtl.recipterUniqueId}">
	                    <input type="hidden" name="bplcUniqueId" value="${ordrDtl.bplcUniqueId}">

	                    <c:if test="${ordrDtl.gdsInfo.mlgPvsnYn eq 'Y' && ordrDtl.gdsInfo.gdsTy eq 'N'}">
	                    <input type="hidden" name="accmlMlg" value="${ordrDtl.gdsInfo.pc * (_mileagePercent/100)}"> <%--마일리지 > 비급여제품 + 마일리지 제공 제품--%>
	                    </c:if>
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

				<%-- 기본 배송정보 call --%>
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
                                    <select name="selMemo" id="selMemo" class="form-control w-full sm:w-57">
                                        <option value="">배송 메시지</option>
                                        <option value="문 앞에 놓아주세요">문 앞에 놓아주세요</option>
                                        <option value="직접 받겠습니다 (부재시 문 앞)">직접 받겠습니다 (부재시 문 앞)</option>
                                        <option value="경비실에 보관해 주세요">경비실에 보관해 주세요</option>
                                        <option value="택배함에 넣어주세요">택배함에 넣어주세요</option>
                                        <option value="직접입력">직접입력</option>
                                    </select>
                                    <form:input path="ordrrMemo" class="form-control w-full sm:flex-1 mt-1.5 sm:mt-0 sm:ml-2 sm:w-auto" value="${bassDlvyVO.memo }" maxlength="25" placeholder="배송 요청사항 입력(25자 이내)" style="display:none;"/>
                                </div>
                            </td>
                        </tr>
                        <tr class="bot-border">
                            <td></td>
                            <td></td>
                        </tr>
                    </tbody>
                </table>

                <div class="flex justify-center space-x-1.5 mt-18 md:space-x-2.5 md:mt-23">
                    <button type="submit" class="btn btn-large btn-primary w-40 md:w-51 lg:w-62">주문하기</button>
                </div>
            </div>

		</div>

        <!-- 배송지 -->
		<div id="dlvyView"></div>
        <!-- //배송지 -->

		<form:hidden path="stlmAmt" value="0" />
		<form:hidden path="cartGrpNos" value="${cartGrpNos}" />
        </form:form>

	</main>

	<script>
    $(function(){

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

    	$("#selMemo").on("change", function(){
    		if($(this).val() != ""){
    			if($(this).val() != "직접입력"){
    				$("#ordrrMemo").val($(this).val());
    				$("#ordrrMemo").hide();
    			}else{
    				$("#ordrrMemo").val('');
    				$("#ordrrMemo").show();
    			}
    		}
    	});

    	// 정규식

    	$("form[name='frmOrdr']").validate({
    	    ignore: "input[type='text']:hidden, [contenteditable='true']:not([name])",
    	    rules : {
    	    	recptrNm			: { required : true}
    	    	, recptrMblTelno	: { required : true}
    	    	, recptrZip			: { required : true}
    	    	, recptrAddr		: { required : true}
    	    	, recptrDaddr		: { required : true}
    	    },
    	    messages : {
    	    	recptrNm			: { required : "받는 사람을 입력해 주세요"}
		    	, recptrMblTelno	: { required : "휴대폰 번호를 입력해 주세요"}
		    	, recptrZip			: { required : "우편번호 검색을 해 주세요"}
		    	, recptrAddr		: { required : "주소를 입력해 주세요"}
		    	, recptrDaddr		: { required : "상세 주소를 입력해 주세요"}
    	    },
    	    errorPlacement: function(error, element) {
    		    var group = element.closest('.form-group, .form-check');
    		    if (group.length) {
    		        group.after(error.addClass('text-danger').prepend("! "));
    		    } else {
    		        element.after(error.addClass('text-danger').prepend("! "));
    		    }
    		},
    	    submitHandler: function (frm) {
   	            if (confirm("해당 상품을 주문하시겠습니까?")) {
   	            	frm.submit();
   	        	}else{
   	        		return false;
   	        	}
    	    }
    	});

    })
    </script>