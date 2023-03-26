<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

			<!-- page content -->
            <div id="page-content">
                <jsp:include page="./include/tab.jsp" />

                <form action="#" class="mt-7.5" id="searchFrm">
                    <fieldset>
                        <legend class="text-title2">검색</legend>
                        <table class="table-detail">
                            <colgroup>
                                <col class="w-43">
                                <col>
                            </colgroup>
                            <tbody>
                                <tr>
                                    <th scope="row"><label for="search-item1">조회기간</label></th>
                                    <td>
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
                    <button type="button" class="btn-primary" id="btn-excel">엑셀 다운로드</button>
                </div>

                <p class="text-title2 mt-13">조회결과</p>
                <div class="scroll-table">
                    <table class="table-list">
                        <colgroup>
                            <col class="min-w-20">
                            <col class="min-w-20">
                            <col class="min-w-25">
                            <col class="min-w-25">
                            <col class="min-w-25">
                            <col class="min-w-25">
                            <col class="min-w-25">
                            <col class="min-w-25">
                            <col class="min-w-25">
                        </colgroup>
                        <thead>
                            <tr>
                                <th scope="col">성별</th>
                                <th scope="col">연령대</th>
                                <th scope="col">고객수</th>
                                <th scope="col">주문건수</th>
                                <th scope="col">주문실적</th>
                                <th scope="col">매출건수</th>
                                <th scope="col">매출실적</th>
                                <th scope="col">상품단가</th>
                                <th scope="col">주문단가</th>
                            </tr>
                        </thead>
                        <tbody>
                        	<c:if test="${!empty resultList}">
                        	<c:set var="totalACnt" value="0" />
                        	<c:set var="totalBCnt" value="0" />
                        	<c:set var="totalCCnt" value="0" />
                        	<c:set var="totalCaCnt" value="0" />
                        	<c:set var="totalReCnt" value="0" />

                        	<c:set var="totalASum" value="0" />
                        	<c:set var="totalBSum" value="0" />
                        	<c:set var="totalCSum" value="0" />
                        	<c:set var="totalCaSum" value="0" />
                        	<c:set var="totalReSum" value="0" />

                        	<c:set var="totalBuyerCnt" value="0" />

                        	<c:forEach items="${resultList}" var="result" varStatus="status">
                        	<c:set var="totalACnt" value="${totalACnt + result.totalACnt}" />
                            <c:set var="totalBCnt" value="${totalBCnt + result.totalBCnt}" />
                            <c:set var="totalCCnt" value="${totalCCnt + result.totalCCnt}" />
                            <c:set var="totalASum" value="${totalASum + result.totalASum}" />
                            <c:set var="totalBSum" value="${totalBSum + result.totalBSum}" />
                            <c:set var="totalCSum" value="${totalCSum + result.totalCSum}" />

                            <c:set var="totalCaCnt" value="${totalCaCnt + result.totalCaCnt}" />
                        	<c:set var="totalCaSum" value="${totalCaSum + result.totalCaSum}" />
                        	<c:set var="totalReCnt" value="${totalReCnt + result.totalReCnt}" />
                        	<c:set var="totalReSum" value="${totalReSum + result.totalReSum}" />

							<c:set var="totalBuyerCnt" value="${totalBuyerCnt + result.buyerCnt }" />

                            <tr>
                                <td class="border-right ${result.gender}">${genderCode[result.gender]}</td>
                                <td class="text-right">${result.ageGrp}</td>
                                <td class="text-right"><fmt:formatNumber value="${result.buyerCnt}" pattern="###,###" /></td>
                                <td class="text-right"><fmt:formatNumber value="${result.totalACnt}" pattern="###,###" /></td>
                                <td class="text-right"><fmt:formatNumber value="${result.totalASum}" pattern="###,###" /></td>
                                <td class="text-right"><fmt:formatNumber value="${result.totalCCnt}" pattern="###,###" /></td>
                                <td class="text-right"><fmt:formatNumber value="${result.totalCSum}" pattern="###,###" /></td>
                                <td class="text-right"><fmt:formatNumber value="${result.totalCSum / result.totalOrdrQy}" pattern="###,###" /></td>
                                <td class="text-right"><fmt:formatNumber value="${result.totalCSum / result.totalACnt}" pattern="###,###" /></td>
                            </tr>
                            </c:forEach>
                            <tr class="total">
                                <td colspan="2">소계</td>
                                <td class="text-right"><fmt:formatNumber value="${totalBuyerCnt}" pattern="###,###" /></td>
                                <td class="text-right"><fmt:formatNumber value="${totalACnt}" pattern="###,###" /></td>
                                <td class="text-right"><fmt:formatNumber value="${totalASum}" pattern="###,###" /></td>
                                <td class="text-right"><fmt:formatNumber value="${totalCCnt}" pattern="###,###" /></td>
                                <td class="text-right"><fmt:formatNumber value="${totalCSum}" pattern="###,###" /></td>
                                <td class="text-right">-</td>
                                <td class="text-right">-</td>
                            </tr>
                            </c:if>
                            <c:if test="${empty resultList}">
                            <tr>
                                <td class="noresult" colspan="9">검색조건을 만족하는 결과가 없습니다.</td>
                            </tr>
                            </c:if>
                        </tbody>
                    </table>
                </div>
            </div>
            <!-- //page content -->

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
            	$('.table-list tbody').mergeClassRowspan(0);

            	$("#btn-excel").on("click",function(){
            		$("#searchFrm").attr("action","./trprExcel");
            		$("#searchFrm").submit();
            		$("#searchFrm").attr("action","./trpr");
            	});
            });
            </script>