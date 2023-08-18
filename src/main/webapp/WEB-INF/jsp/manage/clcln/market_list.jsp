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
                            <tr>
                            	<th>입점업체명</th>
                            	<td><input type="text" id="srchEntrpsNm" name="srchEntrpsNm" <c:if test="${empty mngrEntrpsNm}">value="${param.srchEntrpsNm}"</c:if> class="form-control" <c:if test="${!empty mngrEntrpsNm}">value="${mngrEntrpsNm}" readonly</c:if>></td>
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

                <p class="text-title2">조회 결과 [기간 : ${srchOrdrYmdBgng} ~ ${srchOrdrYmdEnd}]</p>
                <div class="scroll-table">
                    <table class="table-list">
                        <colgroup>
                            <col class="min-w-28 w-28">
                            <col class="min-w-32 w-32">
                            <col class="min-w-25 w-25">
                            <col class="min-w-25 w-25">
                            
                            <col class="min-w-23 w-23">
                            <col class="min-w-20 w-20">
                            <col class="min-w-23 w-23">
                            <col class="min-w-30">
                            <col class="min-w-30 w-30">
                            <col class="min-w-25 w-25">
                            <col class="min-w-23 w-23">
                            <col class="min-w-20 w-20"> 
                            <col class="min-w-25 w-25"> <!-- 공급가 -->
                            <col class="min-w-25 w-25"> 
                            <col class="min-w-30 w-25">
                            <col class="min-w-30 w-25">
                            <col class="min-w-20 w-20">
                            <col class="min-w-25 w-25">
                            <col class="min-w-25 w-25">
                            
                            <col class="min-w-25 w-25">
                            <col class="min-w-25 w-25">
                            <col class="min-w-30 w-30">
                            <col class="min-w-25 w-25">
                            <col class="min-w-30 w-30">
                            <col class="min-w-30 w-30">
                            <col class="min-w-20 w-20">
                        </colgroup>
                        <thead>
                            <tr>
                                <th scope="col" rowspan="2">주문일시</th>
                                <th scope="col" rowspan="2">주문번호</th>
                                <th scope="col" rowspan="2">주문자</th>
                                <th scope="col" rowspan="2">수령인</th>
                                <%-- loop area S --%>
                                <th scope="col" rowspan="2">상품번호</th>
                                <th scope="col" rowspan="2">이카운트<br/> 품목코드</th>
                                <th scope="col" rowspan="2">입점업체명</th>
                                <th scope="col" rowspan="2">상품명</th>
                                <th scope="col" rowspan="2">옵션명</th>
                                <th scope="col" rowspan="2">결제수단</th>
                                <th scope="col" rowspan="2">상품가격</th>
                                <th scope="col" rowspan="2">수량</th>
                                <th scope="col" rowspan="2">공급가</th>
                                <th scope="col" rowspan="2">공급가합계</th>
                                <th scope="col" rowspan="2">판매가</th>
                                <th scope="col" rowspan="2">판매가합계</th>
                                <th scope="colgroup" colspan="3">할인금액</th>
                                <%-- loop area E --%>
                                <th scope="col" rowspan="2">배송비</th>
                                <th scope="col" rowspan="2">실결제금액</th>
                                <th scope="col" rowspan="2">발송처리일</th>
                                <th scope="col" rowspan="2">송장번호</th>
                                <th scope="col" rowspan="2">배송완료일</th>
                                <th scope="col" rowspan="2">구매확정일</th>
                                <th scope="col" rowspan="2">주문상태</th>
                            </tr>
                            <tr>
                                <th scope="col">쿠폰</th>
                                <th scope="col">마일리지</th>
                                <th scope="col">포인트</th>
                            </tr>
                        </thead>
                        <tbody>

                        	<c:if test="${!empty ordrList}">
                        	<c:set var="totalStlmAmt" value="0" />
                        	<c:set var="accGdsSupPc" value="0" />
                        	<c:set var="accOrdrPc" value="0" />
                        	<c:forEach items="${ordrList}" var="resultList" varStatus="status">
                        	<tr>
                                <td class="${resultList.ordrCd}">
									<fmt:formatDate value="${resultList.ordrDt}" pattern="yyyy-MM-dd" />
                                </td>
                                <td class="${resultList.ordrCd}">
									${resultList.ordrCd}
                                </td>
                                <td class="${resultList.ordrCd}">
									${resultList.ordrrNm}
                                </td>
                                <td class="${resultList.ordrCd}">
									${resultList.recptrNm}
                                </td>


                                <td class="${resultList.ordrDtlCd }">
                                	${resultList.gdsCd}
                                </td>
                                 <td class="excel_data_value_string">
                                	<c:if test="${!empty resultList.gdsItemCd}">${resultList.gdsItemCd}</c:if>
                                	<c:if test="${!empty resultList.optnItemCd}">${resultList.optnItemCd}</c:if>
                                </td>
                                <td class="${resultList.ordrDtlCd }">
                                	${resultList.entrpsNm}
                                </td>
                                <td class="${resultList.ordrDtlCd }">
                                	${resultList.gdsNm}
                                </td>
                                <td class="${resultList.ordrDtlCd }">
                                	<c:if test="${resultList.ordrOptnTy eq 'ADIT' }"><%--추가상품--%>
	                                    <i class="ico-reply"></i>
	                                    <span class="badge">추가옵션</span>
	                               		${resultList.ordrOptn}
                                    </c:if>
                                    <c:if test="${resultList.ordrOptnTy eq 'BASE' }"><%--주문상품--%>
                               			<c:if test="${!empty resultList.ordrOptn}">${resultList.ordrOptn }</c:if>
                                    </c:if>
                                </td>
                                <td class="${resultList.ordrCd}">
                                	<c:if test="${!empty resultList.stlmTy }">
                                	${bassStlmTyCode[resultList.stlmTy]}
                                	</c:if>
                                	<c:if test="${empty resultList.stlmTy }">미정</c:if>
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
                                <td class="text-right"><fmt:formatNumber value="${resultList.gdsSupPc }" pattern="###,###" /></td>
                                <td class="text-right">
                                	<c:set var="accGdsSupPc" value="${accGdsSupPc + resultList.gdsSupPc}" />
                                	<fmt:formatNumber value="${accGdsSupPc }" pattern="###,###" />
                                </td>
                                <td class="text-right"><fmt:formatNumber value="${resultList.ordrPc }" pattern="###,###" /></td>
                                <td class="text-right">
                                	<c:set var="accOrdrPc" value="${accOrdrPc + resultList.ordrPc }" />
                                	<fmt:formatNumber value="${accOrdrPc }" pattern="###,###" />
                                </td>
                                <td class="text-right ${resultList.ordrDtlCd}"><fmt:formatNumber value="${resultList.couponAmt }" pattern="###,###" /></td>
                                <td class="text-right ${resultList.ordrCd}"><fmt:formatNumber value="${resultList.useMlg }" pattern="###,###" /></td>
                                <td class="text-right ${resultList.ordrCd}"><fmt:formatNumber value="${resultList.usePoint }" pattern="###,###" /></td>


                                <td class="text-right ${resultList.ordrDtlCd}">
                                	<fmt:formatNumber value="${resultList.dlvyBassAmt}" pattern="###,###" />
                                	<c:if test="${resultList.dlvyAditAmt>0}">
                                	<br>(+<fmt:formatNumber value="${resultList.dlvyAditAmt}" pattern="###,###" />)
                                	</c:if>
                                </td>
                                <td class="text-right ${resultList.ordrCd}">
									<fmt:formatNumber value="${resultList.stlmAmt}" pattern="###,###" />
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
                                <td class="${resultList.ordrDtlCd }">
                                	${resultList.dlvyInvcNo}
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
                                <td class="${resultList.ordrDtlCd }">
                                	${ordrSttsCode[resultList.sttsTy]}
                                </td>
                            </tr>

							<c:if test="${resultList.ordrCd ne ordrList[status.index + 1].ordrCd}">
                            <c:set var="totalStlmAmt" value="${totalStlmAmt + resultList.stlmAmt}" />
                            </c:if>

                            </c:forEach>
	                        <tr class="total">
	                        	<td colspan="20">총 합계</td>
	                        	<td colspan="6"><fmt:formatNumber value="${totalStlmAmt}" pattern="###,###" /></td>
	                        </tr>
	                        </c:if>

                            <c:if test="${empty ordrList}">
	                        <tr>
	                            <td class="noresult" colspan="16">검색조건을 선택하신 후 검색버튼을 클릭하셔야 조회가 진행됩니다</td>
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

        		    $(".table-list th, td").css("border", "1px solid #cccccc");
        		    
        		    var template = `
        		    	<!DOCTYPE html>
        		        <html lang="en">
        		        <head>
        		          <meta charset="UTF-8">
        		          <style>
	        		          .excel_data_value_string{ mso-number-format:"\@"; }
	        		      </style>
        		        </head>
        		        <body>
        		          <table>
        		    `;
        		    
        		    template = template + $(".table-list").html();
        		    
        		    template = template + '</table></body></html>';
        		    
        		    var table_html = encodeURIComponent(template);

        		    var a = document.createElement('a');
        		    a.href = data_type + ',%EF%BB%BF' + table_html;
        		    a.download = title+'.xls';
        		    a.click();
        		    $(".table-list th, td").css("border", "");
        		}

                $(function(){
                	$(".btn-excel").on("click", function(){
                		tableToExcel("마켓정산_"+f_getToday().replaceAll("-",""));
	            	});

                	// rowspan
                	$('.table-list tbody').mergeClassRowspan(0);
                	$('.table-list tbody').mergeClassRowspan(1);
                	$('.table-list tbody').mergeClassRowspan(4);
                	$('.table-list tbody').mergeClassRowspan(9);

                	$('.table-list tbody').mergeClassRowspan(17);
                	$('.table-list tbody').mergeClassRowspan(18);
                	$('.table-list tbody').mergeClassRowspan(19);
                	$('.table-list tbody').mergeClassRowspan(20);

                	$(".table-list tbody tr td:hidden").remove();

                });
                </script>