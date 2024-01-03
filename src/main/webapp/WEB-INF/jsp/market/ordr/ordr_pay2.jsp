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
                            <dl class="totalOrdrPc-dl total-ordrpc-dl">
                                <dt>총 주문상품금액</dt>
                                <dd><strong class="total-ordrpc-txt"><fmt:formatNumber value="${totalOrdrPc}" pattern="###,###" /></strong> 원</dd>
                            </dl>
                            <dl class="total-coupon-dl">
                                <dt>쿠폰</dt>
                                <dd><strong class="text-danger total-coupon-txt">0</strong> 원</dd>
                            </dl>
                            <dl class="total-mlg-dl">
                                <dt>마일리지/포인트</dt>
                                <dd><strong class="text-danger total-mlg-txt">0</strong> 원</dd>
                            </dl>
                            
                            <dl class="total-dlvy-dl">
                                <dt>배송비</dt>
                                <dd><strong class="total-dlvy-txt">0</strong> 원</dd>
                            </dl>
                            <dl id="total-dlvyAdit-dl" class="result-price-item">
                                <dt>도서산간 추가 배송비</dt>
                                <dd><strong class="total-dlvyAdit-txt">0</strong> 원</dd>
                            </dl>
                        </div>
                        <dl class="last">
                            <dt>최종 결제금액</dt>
                            <dd><strong class="total-stlmAmt-txt">0</strong> 원</dd>
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
        <form:hidden path="stlmAmt" value="" /><%-- 전체 결제 금액 --%>
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
		<input type="hidden" name="ordrDtls" value="" >
		
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

    // 주소호출 콜백
    function f_findAdresCallback(){
    	jsMarketOrdrPay.f_findAdresCallback2();
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