<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
			<%-- 반품접수 --%>

			<!-- 반품 접수 -->
			<form:form name="frmOrdrReturn" id="frmOrdrReturn" modelAttribute="ordrVO" method="post" enctype="multipart/form-data">
			<form:hidden path="ordrNo" />

            <div class="modal fade modal-inner" id="ordr-return-modal" tabindex="-1">
                <div class="modal-dialog modal-xl modal-dialog-centered">
                    <div class="modal-content">
                        <div class="modal-header">
                            <p>반품접수</p>
                            <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="close"></button>
                        </div>
                        <div class="modal-body">
                            <p class="text-title2 relative">
                                반품상품 선택
                                <span class="absolute left-full top-0.5 ml-1 whitespace-nowrap text-sm">
                                    (<span class="badge-require ml-1 mr-0.5 -translate-y-0.5"></span> 는 필수선택사항입니다.)
                                </span>
                            </p>
                            <table class="table-list" id="ordrReturnTable">
                                <colgroup>
                                	<col class="w-15">
                                    <col class="w-22">
                                    <col>
                                    <col class="w-28">
                                    <col class="w-20">
                                    <col class="w-25">
                                    <col class="w-28">
                                    <col class="w-30">
                                    <col class="w-28">
                                </colgroup>
                                <thead>
                                    <tr>
                                    	<th scope="col">
											<div class="form-check">
                                            	<input class="form-check-input" type="checkbox">
                                            </div>
                                    	</th>
                                        <th scope="col">상품구분</th>
                                        <th scope="col">상품/옵션정보</th>
                                        <th scope="col">상품가격</th>
                                        <th scope="col">수량</th>
                                        <th scope="col">배송비</th>
                                        <th scope="col">전표번호</th>
                                        <th scope="col">멤버스</th>
                                        <th scope="col">주문상태</th>
                                    </tr>
                                </thead>
                                <tbody>
                                	<c:forEach items="${ordrVO.ordrDtlList}" var="ordrDtl" varStatus="status">
                                    <tr>
                                    	<td class="${ordrDtl.ordrDtlCd}">
                                    		<c:if test="${fn:startsWith(ordrDtl.sttsTy, 'OR') && !fn:startsWith(ordrDtl.sttsTy, 'OR09')}">
                                    		<div class="form-check">
												<input class="form-check-input" type="checkbox" name="ordrDtlCds" value="${ordrDtl.ordrDtlCd}" data-ordr-pc="${ordrDtl.ordrPc}">
											</div>
											</c:if>
                                    	</td>
                                        <td class="${ordrDtl.ordrDtlCd}">${gdsTyCode[ordrVO.ordrTy]}</td>
                                        <td class="text-left">
                                            <span class="badge-outline-success">${ordrDtl.gdsCd}</span><br>
                                            ${ordrDtl.gdsNm}<br>
                                            (${ordrDtl.ordrOptn})<br>
                                        </td>
                                        <td>
											<fmt:formatNumber value="${ordrDtl.gdsPc}" pattern="###,###" /><br>
                                        	(<fmt:formatNumber value="${ordrDtl.ordrOptnPc}" pattern="###,###" />)
										</td>
                                        <td><fmt:formatNumber value="${ordrDtl.ordrQy}" pattern="###,###" /></td>
                                        <td class="${ordrDtl.ordrDtlCd}">
                                        	<fmt:formatNumber value="${ordrDtl.dlvyBassAmt}" pattern="###,###" /><br>
                                        	(<fmt:formatNumber value="${ordrDtl.dlvyAditAmt}" pattern="###,###" />)
                                        </td>
                                        <td class="${ordrDtl.ordrDtlCd}" style="word-break:break-all;">
                                        	${ordrVO.delngNo}
                                        </td>
                                        <td class="${ordrDtl.ordrDtlCd}">
                                        	<c:if test="${ordrVO.ordrTy eq 'R' || ordrVO.ordrTy eq 'L'}"><%-- 급여타입 주문일 경우만 멤버스(사업소) 있음 --%>
                                        	<a class="btn shadow tiny" href="/_mng/members/bplc/view?uniqueId=${ordrDtl.bplcUniqueId}" target="_blank">${ordrDtl.bplcInfo.bplcNm}</a>
                                        	</c:if>
                                        	<c:if test="${ordrVO.ordrTy eq 'N'}">-</c:if>
                                        </td>
                                        <td class="${ordrDtl.ordrDtlCd}">
                                        	${ordrSttsCode[ordrDtl.sttsTy]}
                                        </td>
                                    </tr>

                                    <%-- 배송비 + 추가배송비 --%>
                                    <c:set var="totalDlvyBassAmt" value="${totalDlvyBassAmt + ordrDtl.dlvyBassAmt + ordrDtl.dlvyAditAmt}" />
                                    <%-- 쿠폰금액 --%>
                                    <c:set var="totalCouponAmt" value="${totalCouponAmt + ordrDtl.couponAmt}" />
                                    <%-- 적립예정마일리지 --%>
                                    <c:set var="totalAccmlMlg" value="${totalAccmlMlg + ordrDtl.accmlMlg}" />
                                    <%-- 주문금액 + 옵션금액 --%>
                                    <c:set var="totalOrdrPc" value="${totalOrdrPc + ordrDtl.ordrPc}" />

                                    </c:forEach>
                                </tbody>
                            </table>


                            <p class="text-title2 relative mt-10">
                                반품사유
                                <span class="absolute left-full top-0.5 ml-1 whitespace-nowrap text-sm">
                                    (<span class="badge-require ml-1 mr-0.5 -translate-y-0.5"></span> 는 필수입력사항입니다.)
                                </span>
                            </p>
                            <table class="table-detail">
                                <colgroup>
                                    <col class="w-36">
                                    <col>
                                </colgroup>
                                <tbody>
                                    <tr>
                                        <th scope="row"><label for="resnTy" class="require">사유</label></th>
                                        <td>
                                        	<select id="resnTy" name="resnTy" class="form-control w-full">
                                        		<option value="">사유를 선택해주세요.</option>
                                        		<c:forEach items="${ordrReturnTyCode}" var="iem">
                                        		<option value="${iem.key}">${iem.value}</option>
                                        		</c:forEach>
                                        	</select>
                                        </td>
                                    </tr>
                                    <tr>
                                        <th scope="row"><label for="resn">상세사유</label></th>
                                        <td>
                                        	<textarea id="resn" name="resn" cols="10" rows="6" class="form-control w-full"></textarea>
                                        </td>
                                    </tr>
                                </tbody>
                            </table>

                            <%-- 환불정보 : 결제이후 --%>
							<c:if test="${ordrVO.stlmYn eq 'Y'}">
                            <p class="text-title2 mt-10">환불정보</p>
                            <table class="table-list">
                                <colgroup>
                                	<c:choose>
                                		<c:when test="${ordrVO.stlmTy eq 'VBANK'}">
		                                    <col class="w-30">
		                                    <col>
	                                    </c:when>
	                                    <c:otherwise>
	                                    	<col class="w-30">
			                                <col class="w-35">
			                                <col>
                                    </c:otherwise>
                                    </c:choose>
                                </colgroup>
                                <thead>
                                	<c:choose>
                                		<c:when test="${ordrVO.stlmTy eq 'VBANK'}">
                                			<tr>
                                				<tr>
			                                        <th scope="col">환불방식</th>
			                                        <td class="text-left"><span>계좌이체</span></td>
			                                    </tr>
			                                    <tr>
			                                        <th scope="col">환불은행</th>
			                                        <td class="text-left">
			                                        	<select name="rfndBank" id="rfndBank" class="form-control w-45">
			                                        		<option value="">은행 선택</option>
			                                        		<c:forEach var="bankTy" items="${bankTyCode}">
			                                        			<option value="${bankTy.key}">${bankTy.value}</option>
			                                        		</c:forEach>
			                                        	</select>
			                                        </td>
			                                    </tr>
			                                    <tr>
			                                        <th scope="col">계좌번호</th>
			                                        <td class="text-left">
			                                        	<input type="text" id="rfndActno" name="rfndActno" class="form-control w-86" maxlength="50">
			                                        </td>
			                                    </tr>
			                                    <tr>
			                                        <th scope="col">예금주명</th>
			                                        <td class="text-left">
			                                    	<input type="text" id="rfndDpstr" name="rfndDpstr" value="${ordrVO.ordrrNm}" class="form-control w-45" maxlength="10" />
			                                    </td>
			                                    </tr>
                                			</tr>
                                		</c:when>
                                		<c:otherwise>
		                                    <tr>
		                                        <th scope="col">결제수단</th>
		                                        <th scope="col">환불받을금액</th>
		                                        <th scope="col">환불방법</th>
		                                    </tr>
		                                </c:otherwise>
                                    </c:choose>
                                </thead>
                                <tbody>
                               	<c:choose>
	                           		<c:when test="${ordrVO.stlmTy eq 'BANK'}">
	                           		<tr>
                                        <td>계좌이체</br>(PG입금 계좌)</td>
                                        <td class="text-right"><span class="totalCancelAmt">${totalOrdrPc + totalDlvyBassAmt}</span>원</td>
	                                    <td class="text-left">실시간 계좌이체 환불 (${ordrDtl.rfndBank} / ${ordrDtl.rfndActno} / ${ordrVO.ordrrNm })</td>
                                    </tr>
                                    </c:when>
                                    <c:when test="${ordrVO.stlmTy eq 'CARD'}">
									<tr>
                                        <td>신용카드(ISP)</td>
                                        <td class="text-right"><span class="totalCancelAmt">0</span>원</td>
                                        <td class="text-left">신용카드 승인취소 (${ordrVO.cardCoNm})</td>
                                    </tr>
                                    </c:when>
                                    <c:otherwise>
                                    </c:otherwise>
                                </c:choose>
                                	<c:if test="${ordrVO.useMlg > 0}">
                                    <tr>
                                        <td>마일리지</td>
                                        <td class="text-right">${ordrVO.useMlg}</td>
                                        <td class="text-left">마일리지 환원</td>
                                    </tr>
                                    </c:if>
									<c:if test="${ordrVO.usePoint > 0}">
                                    <tr>
                                        <td>마일리지</td>
                                        <td class="text-right">${ordrVO.usePoint}</td>
                                        <td class="text-left">포인트 환원</td>
                                    </tr>
                                    </c:if>
                                </tbody>
                            </table>
                        	</c:if>
                        </div>
                        <div class="modal-footer">
                            <div class="btn-group">
                                <button type="button" class="btn-primary large shadow f_ordr_return_save">확인</button>
                                <button type="button" class="btn-secondary large shadow" data-bs-dismiss="modal">취소</button>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            </form:form>
            <!-- //반품 접수 -->


            <script>
          //은행
            var bankTyCode = {
            <c:forEach items="${bankTyCode}" var="bank">
            ${bank.key} : '${bank.value}',
            </c:forEach>
            };

            $(function(){

            	// rowspan
            	$('#ordrReturnTable tbody').mergeClassRowspan(0);
            	$('#ordrReturnTable tbody').mergeClassRowspan(1);
            	$('#ordrReturnTable tbody').mergeClassRowspan(5);
            	$('#ordrReturnTable tbody').mergeClassRowspan(6);
            	$('#ordrReturnTable tbody').mergeClassRowspan(7);
            	$('#ordrReturnTable tbody').mergeClassRowspan(8);

            	// foucs
            	$("#ordr-return-modal").on("shown.bs.modal", function () {
            		$("#resnTy").focus();
            	});

            	let totalCancelAmt = 0;
            	$("#ordrReturnTable th :checkbox").click(function(){
    				let isChecked = $(this).is(":checked");
    				$("#ordrReturnTable td :checkbox").prop("checked",isChecked);
    				if(isChecked){
    					$("#ordrReturnTable td :checkbox").each(function(){
    						var ordrPcs = $(this).data("ordrPc");
    						//$("#rfndAmt").val(parseInt($(this).data("ordrPc")) );
    						totalCancelAmt = Number(totalCancelAmt) + Number(ordrPcs);
    					});
    				}else{
    					totalCancelAmt = 0;
    					$(".totalCancelAmt").text(totalCancelAmt);
    				}
    				if(isChecked){
    					$(".totalCancelAmt").text(totalCancelAmt);
    				}
    			});

            	/*$("#ordrReturnTable td :checkbox").click(function(){
            		if($(this).is(":checked")){
						$("#rfndAmt").val( parseInt($("#rfndAmt").val()) + parseInt($(this).data("ordrPc")) );
            		}else{
            			$("#rfndAmt").val( parseInt($("#rfndAmt").val()) - parseInt($(this).data("ordrPc")) );
            		}
            	});*/


            	/*let totalCancelAmt = 0;
            	$("#ordrReturnTable th :checkbox").click(function(){
    				let isChecked = $(this).is(":checked");
    				$("#ordrRtrcnTable td :checkbox").prop("checked",isChecked);
    				if(isChecked){
    					$("#ordrRtrcnTable td :checkbox:checked").each(function(){
    						let ordrPc = $(this).data("ordrPc");
    						totalCancelAmt = Number(totalCancelAmt) + Number(ordrPc);
    					});
    				}else{
    					totalCancelAmt = 0;
    				}
    				if(isChecked){
    					$(".totalCancelAmt").text(totalCancelAmt);
    				}

    			});*/

            	$("#ordrReturnTable td :checkbox").click(function(){
            		let isChecked = $(this).is(":checked");
            		let ordrPc = $(this).data("ordrPc");
            		if(isChecked){
            			totalCancelAmt = Number(totalCancelAmt) + Number(ordrPc);
            		}else{
            			totalCancelAmt = Number(totalCancelAmt) - Number(ordrPc);
            		}
            		console.log("totalCancelAmt: ", totalCancelAmt);
					$(".totalCancelAmt").text(totalCancelAmt);
            	});

    			$(".f_ordr_return_save").on("click", function(){
    				let ordrDtlCds = $("#ordrReturnTable td :checkbox:checked").map(function(){return $(this).val();}).get();
    				if(ordrDtlCds==null||ordrDtlCds.length==0) {
    					alert("선택된 상품이 없습니다.");
    				}else if($("#resnTy").val() == ""){
    					alert("반품사유를 선택하세요");
    				}else{
    					if(confirm("선택하신 상품을 반품처리 하시겠습니까?")) {
							$.ajax({
								type: 'post',
								url : '/_mng/ordr/ordrReturnSave.json',
								data: {
									ordrNo:'${ordrVO.ordrNo}'
									, ordrDtlCds:ordrDtlCds
									, resnTy:$("#resnTy").val()
									, resn:$("#resn").val()
									, rfndBank : bankTyCode[$("#rfndBank").val()]
									, rfndActno:$("#rfndActno").val()
									, rfndDpstr:$("#rfndDpstr").val()
									//, rfndAmt:$("#rfndAmt").val()
								},
								dataType: 'json'
							})
							.done(function(json){
								if(json.result) {
									console.log("success");
									$(".btn-reload, .modal-inner .btn-close").click();
								} else {
									alert("선택하신 상품의 주문반품이 실패하였습니다.\n잠시 후 다시 시도해주세요.");
								}
							})
							.fail(function(){
								alert("작업이 실패하였습니다.\n계속해서 에러가 발생할 경우\n운영자에게 문의바랍니다.");
							});

						}
    				}
    			});

            });

            </script>