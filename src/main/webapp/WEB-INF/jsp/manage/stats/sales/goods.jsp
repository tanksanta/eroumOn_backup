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
                                <tr>
                                    <th scope="row"><label for="search-item2">상품 카테고리</label></th>
                                    <td>
                                        <div class="form-group w-84">
                                        <select name="srchUpCtgryNo" id="srchUpCtgryNo" class="form-control w-32">
                                            <option value="0">전체</option>
                                        <c:forEach items="${gdsCtgryList}" var="ctgryList" varStatus="status">
                                        	<option value="${ctgryList.ctgryNo}" ${param.srchUpCtgryNo eq ctgryList.ctgryNo?'selected="selected"':''}>${ctgryList.ctgryNm}</option>
                                        </c:forEach>
                                        </select>
                                        <select name="srchCtgryNo" id="srchCtgryNo" class="form-control flex-1">
                                            <option value="0">전체</option>
                                        </select>
                                    </div>
                                    </td>
                                </tr>
                                <tr>
                                    <th scope="row"><label for="srchGdsCd">상품코드</label></th>
                                    <td><input type="text" id="srchGdsCd" name="srchGdsCode" value="${param.srchGdsCode}" class="form-control w-84"></td>
                                </tr>
                                <tr>
                                    <th scope="row"><label for="srchGdsNm">상품명</label></th>
                                    <td><input type="text" id="srchGdsNm" name="srchGdsNm" value="${param.srchGdsNm }" class="form-control w-84"></td>
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
                            <col class="min-w-25 w-25">
                            <col class="min-w-40">
                            <col class="min-w-60">
                            <col class="min-w-25">
                            <col class="min-w-25">
                            <col class="min-w-25">
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
                                <th scope="col" rowspan="2">판매순위</th>
                                <th scope="col" rowspan="2">상품코드</th>
                                <th scope="col" rowspan="2">상품명</th>
                                <th scope="colgroup" colspan="2">주문</th>
                                <th scope="colgroup" colspan="2">취소</th>
                                <th scope="colgroup" colspan="2">판매</th>
                                <th scope="colgroup" colspan="2">반품</th>
                                <th scope="colgroup" colspan="2">매출</th>
                            </tr>
                            <tr>
                                <th scope="col">건수</th>
                                <th scope="col">금액</th>
                                <th scope="col">건수</th>
                                <th scope="col">금액</th>
                                <th scope="col">건수</th>
                                <th scope="col">금액</th>
                                <th scope="col">건수</th>
                                <th scope="col">금액</th>
                                <th scope="col">건수</th>
                                <th scope="col">금액</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach items="${resultList}" var="result" varStatus="status">
                            <tr>
                                <td>${status.index + 1}</td>
                                <td>${result.gdsCd}</td>
                                <td class="text-left">${result.gdsNm}</td>
                                <td class="text-right"><fmt:formatNumber value="${result.totalACnt}" pattern="###,###" /></td>
                                <td class="text-right"><fmt:formatNumber value="${result.totalASum}" pattern="###,###" /></td>
                                <td class="text-right"><fmt:formatNumber value="${result.totalCaCnt}" pattern="###,###" /></td>
                                <td class="text-right"><fmt:formatNumber value="${result.totalCaSum}" pattern="###,###" /></td>
                                <td class="text-right"><fmt:formatNumber value="${result.totalBCnt}" pattern="###,###" /></td>
                                <td class="text-right"><fmt:formatNumber value="${result.totalBSum}" pattern="###,###" /></td>
                                <td class="text-right"><fmt:formatNumber value="${result.totalReCnt}" pattern="###,###" /></td>
                                <td class="text-right"><fmt:formatNumber value="${result.totalReSum}" pattern="###,###" /></td>
                                <td class="text-right"><fmt:formatNumber value="${result.totalCCnt}" pattern="###,###" /></td>
                                <td class="text-right"><fmt:formatNumber value="${result.totalCSum}" pattern="###,###" /></td>
                            </tr>
                            </c:forEach>
                            <c:if test="${empty resultList}">
                            <tr>
                                <td class="noresult" colspan="13">검색조건을 만족하는 결과가 없습니다.</td>
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
            	$("#btn-excel").on("click",function(){
            		$("#searchFrm").attr("action","./goodsExcel");
            		$("#searchFrm").submit();
            		$("#searchFrm").attr("action","./goods");
            	});

            	//상품 카테고리
            	$("#srchUpCtgryNo").on("change", function(){

            		const ctgryNoVal = "${param.srchCtgryNo}";

            		$("#srchCtgryNo").empty();
            		$("#srchCtgryNo").append("<option value='0'>전체</option>");

            		let srchUpCtgryNoVal = $(this).val();
            		if(srchUpCtgryNoVal > 0){ //값이 있을경우만..
            			$.ajax({
            				type : "post",
            				url  : "/_mng/gds/ctgry/getGdsCtgryListByFilter.json",
            				data : {upCtgryNo:srchUpCtgryNoVal},
            				dataType : 'json'
            			})
            			.done(function(data) {
            				for(key in data){
            					if(ctgryNoVal == key){
									$("#srchCtgryNo").append("<option value='"+ key +"' selected='selected'>"+ data[key] +"</option>");
								}else{
									$("#srchCtgryNo").append("<option value='"+ key +"'>"+ data[key] +"</option>");
								}
            				}
            			})
            			.fail(function(data, status, err) {
            				alert("카테고리 호출중 오류가 발생했습니다.");
            				console.log('error forward : ' + data);
            			});
            		}
            	}).trigger("change");

            });
            </script>