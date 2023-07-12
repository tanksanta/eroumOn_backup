<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

				<!-- 검색영역 -->
				<form id="searchFrm" name="searchFrm" method="get" action="./list">
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
                                <th scope="row"><label for="srchOrdrYmdBgng">조회기간</label></th>
                                <td colspan="3">
                                    <div class="form-group">
                                        <input type="date" class="form-control w-39 calendar" id="srchOrdrYmdBgng" name="srchOrdrYmdBgng" value="${srchOrdrYmdBgng}">
                                        <i>~</i>
                                        <input type="date" class="form-control w-39 calendar" id="srchOrdrYmdEnd" name="srchOrdrYmdEnd" value="${srchOrdrYmdEnd}">
                                        <button type="button" class="btn shadow" onclick="f_srchOrdrYmdSet('1'); return false;">오늘</button>
                                        <button type="button" class="btn shadow" onclick="f_srchOrdrYmdSet('2'); return false;">7일</button>
                                        <button type="button" class="btn shadow" onclick="f_srchOrdrYmdSet('3'); return false;">15일</button>
                                        <button type="button" class="btn shadow" onclick="f_srchOrdrYmdSet('4'); return false;">1개월</button>
                                    </div>
                                </td>
                            </tr>
                        </tbody>
                    </table>
                </fieldset>

                <div class="btn-group mt-5">
                    <button type="submit" class="btn-primary large shadow w-52">검색</button>
                </div>
                </form>

                <div class="mt-13 text-right mb-2">
                    <button type="button" class="btn-primary btn-excel">엑셀 다운로드</button>
                </div>

                <p class="text-title2">조회 결과 <span class="text-blue1">(${ordrList[0].bplcInfo.bplcNm} )</span> [기간 : ${srchOrdrYmdBgng} ~ ${srchOrdrYmdEnd}]</p>
                <div class="scroll-table">
                    <table class="table-list">
                        <colgroup>
                            <col class="min-w-28 w-28">
                            <col class="min-w-32 w-32">
                            <col class="min-w-25 w-25">
                            <col class="min-w-23 w-23">
                            
                            <col class="min-w-23 w-23">
                            <col class="min-w-20 w-20">
                            <col class="min-w-30">
                            <col class="min-w-23 w-23">
                            <col class="min-w-20 w-20">
                            <col class="min-w-30 w-30">
                            
                            <col class="min-w-20 w-20">
                            <col class="min-w-25 w-25">
                            <col class="min-w-20 w-20">
                            <col class="min-w-20 w-20">
                            <col class="min-w-30 w-30">
                            <col class="min-w-30 w-30">
                            <col class="min-w-30 w-30">
                        </colgroup>
                        <thead>
                            <tr>
                                <th scope="col" >주문일시</th>
                                <th scope="col" >주문번호</th>
                                <th scope="col" >결제수단</th>
                                <th scope="col" >사업소명</th>
                                <%-- loop area S --%>
                                <th scope="col" >상품번호</th>
                                <th scope="col" >이카운트<br/> 품목코드</th>
                                <th scope="col" >상품명/옵션</th>
                                <th scope="col" >상품가격</th>
                                <th scope="col" >수량</th>
                                <th scope="col" >본인부담금</th>
                                <%-- loop area E --%>
                                <th scope="col" >배송비</th>
                                <th scope="col" >정산금액</th>
                                <th scope="col" >주문자</th>
                                <th scope="col" >수령인</th>
                                <th scope="col" >발송처리일</th>
                                <th scope="col" >배송완료일</th>
                                <th scope="col" >구매확정일</th>
                            </tr>
                        </thead>
                        <tbody>

                        	<c:if test="${!empty ordrList}">
                        	<c:set var="totalStlmAmt" value="0" />
                        	<c:forEach items="${ordrList}" var="resultList" varStatus="status">
                        	<tr>
                                <td class="${resultList.ordrCd}">
									<fmt:formatDate value="${resultList.ordrDt}" pattern="yyyy-MM-dd" />
                                </td>
                                <td class="${resultList.ordrCd}">
									${resultList.ordrCd}
                                </td>
                                <td class="${resultList.ordrCd}">
                                	<c:if test="${!empty resultList.stlmTy }">
                                	${bassStlmTyCode[resultList.stlmTy]}
                                	</c:if>
                                	<c:if test="${empty resultList.stlmTy }">미정</c:if>
                                </td>
                                <td class="${resultList.ordrCd}">
                                	${ordrList[0].bplcInfo.bplcNm}
                                </td>

                                <td class="${resultList.ordrDtlCd }">
                                	${resultList.gdsCd}
                                </td>
                                <td class="${resultList.ordrDtlCd }">
                                	<c:if test="${!empty resultList.gdsItemCd}">${resultList.gdsItemCd}</c:if>
                                	<c:if test="${!empty resultList.optnItemCd}">${resultList.optnItemCd}</c:if>
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
                                	<c:if test="${resultList.ordrOptnTy eq 'BASE'}">
                                    <fmt:formatNumber value="${resultList.gdsPc}" pattern="###,###" />
                                    <br>(+<fmt:formatNumber value="${resultList.ordrOptnPc}" pattern="###,###" />)
                                    </c:if>
                                    <c:if test="${resultList.ordrOptnTy eq 'ADIT'}"><span class="ordrOptnPc">
                                    +<fmt:formatNumber value="${resultList.ordrOptnPc}" pattern="###,###" /></span>
                                    </c:if>
                                </td>

                                <td><fmt:formatNumber value="${resultList.ordrQy}" pattern="###,###" /></td>
                                <td class="text-right">
                                	<%-- <fmt:formatNumber value="${resultList.ordrPc }" pattern="###,###" /> --%>
                                	<fmt:formatNumber value="${resultList.ordrPc + resultList.couponAmt}" pattern="###,###" />
                                </td>

                                <td class="text-right ${resultList.ordrDtlCd}">
                                	<fmt:formatNumber value="${resultList.dlvyBassAmt}" pattern="###,###" />
                                	<c:if test="${resultList.dlvyAditAmt>0}">
                                	<br>(+<fmt:formatNumber value="${resultList.dlvyAditAmt}" pattern="###,###" />)
                                	</c:if>
                                </td>

                                <td class="text-right ${resultList.ordrCd}">
                                	<%-- 할인혜택은 이로움에서 제공하는 항목이니 멤버스는 전체금액 : 결제금액 + 쿠폰금액 + 마일리지 + 포인트 --%>
									<fmt:formatNumber value="${resultList.stlmAmt + resultList.couponAmt + resultList.useMlg + resultList.usePoint}" pattern="###,###" />
                                </td>
                                <td class="${resultList.ordrCd}">
									${resultList.ordrrNm}
                                </td>
                                <td class="${resultList.ordrCd}">
									${resultList.recptrNm}
                                </td>
                                 <td class="${resultList.ordrCd}">
									<c:set var="chk" value="true" />
									<c:forEach items="${resultList.ordrChgHist}" var="chgHist" varStatus="s">
									<c:if test="${chgHist.chgStts eq 'OR07' && chk }">
										<fmt:formatDate value="${chgHist.regDt}" pattern="yyyy-MM-dd" />
										<c:set var="chk" value="false" />
									</c:if>
									</c:forEach>
                                </td>
								<td class="${resultList.ordrCd}">
									<c:set var="chk" value="true" />
									<c:forEach items="${resultList.ordrChgHist}" var="chgHist" varStatus="s">
									<c:if test="${chgHist.chgStts eq 'OR08' && chk }">
										<fmt:formatDate value="${chgHist.regDt}" pattern="yyyy-MM-dd" />
										<c:set var="chk" value="false" />
									</c:if>
									</c:forEach>

                                </td>
                                <td class="${resultList.ordrCd}">
                                	<c:set var="chk" value="true" />
									<c:forEach items="${resultList.ordrChgHist}" var="chgHist" varStatus="s">
									<c:if test="${chgHist.chgStts eq 'OR09' && chk }">
										<fmt:formatDate value="${chgHist.regDt}" pattern="yyyy-MM-dd" />
										<c:set var="chk" value="false" />
									</c:if>
									</c:forEach>
                                </td>
                            </tr>

							<c:if test="${resultList.ordrCd ne ordrList[status.index + 1].ordrCd}">
                            <c:set var="totalStlmAmt" value="${totalStlmAmt + resultList.stlmAmt}" />
                            </c:if>

                            </c:forEach>
	                        <tr class="total">
	                        	<td colspan="11">총 합계</td>
	                        	<td colspan="6"><fmt:formatNumber value="${totalStlmAmt}" pattern="###,###" /></td>
	                        </tr>
	                        </c:if>

                            <c:if test="${empty ordrList}">
	                        <tr>
	                            <td class="noresult" colspan="17">검색조건을 선택하신 후 검색버튼을 클릭하셔야 조회가 진행됩니다</td>
	                        </tr>
	                        </c:if>

                        </tbody>
                    </table>
                </div>


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

        		function tableToExcel(title) {
        		    var data_type = 'data:application/vnd.ms-excel;charset=utf-8';

        		    console.log($(".table-list").parent().html());

        		    $(".table-list th, td").css("border", "1px solid #cccccc");
        		    var table_html = encodeURIComponent($(".table-list").parent().html());

        		    var a = document.createElement('a');
        		    a.href = data_type + ',%EF%BB%BF' + table_html;
        		    a.download = title+'.xls';
        		    a.click();
        		    $(".table-list th, td").css("border", "");
        		}

                $(function(){
                	$(".btn-excel").on("click", function(){
                		tableToExcel("${ordrList[0].bplcInfo.bplcNm}_정산_"+f_getToday().replaceAll("-",""));
	            	});

                	// rowspan
                	$('.table-list tbody').mergeClassRowspan(0);
                	$('.table-list tbody').mergeClassRowspan(1);
                	$('.table-list tbody').mergeClassRowspan(2);
                	$('.table-list tbody').mergeClassRowspan(4);

                	$('.table-list tbody').mergeClassRowspan(11);
                	//$('.table-list tbody').mergeClassRowspan(10);
                	//$('.table-list tbody').mergeClassRowspan(11);
                	//$('.table-list tbody').mergeClassRowspan(12);

                	$(".table-list tbody tr td:hidden").remove();

                });
                </script>