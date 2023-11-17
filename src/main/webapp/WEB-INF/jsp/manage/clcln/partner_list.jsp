<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

				<!-- 검색영역 -->
				<form id="searchFrm" name="searchFrm" method="get" action="./list">
                <fieldset>
                    <legend class="text-title2">주문 검색</legend>
                    <table class="table-detail">
                        <colgroup>
                            <col class="w-43">
                            <col>
                        </colgroup>
                        <tbody>
                            <tr>
                                <th scope="row"><label for="srchOrdrYmdBgng">조회기간</label></th>
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
                            	<th>멤버스명</th>
                            	<td><input type="text" id="srchBplcNm" name="srchBplcNm" value="${param.srchBplcNm }" class="form-control"></td>
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
                            <col>
                            <col class="w-45">
                            <col class="w-45">
                            <col class="w-45">
                            <col class="w-45">
                            <col class="w-55">
                        </colgroup>
                        <thead>
                            <tr>
                                <th scope="col">업체명</th>
                                <th scope="col">배송처리 건수</th>
                                <th scope="col">주문금액</th>
                                <th scope="col">배송비</th>
                                <th scope="col">정산금액</th>
                                <th scope="col">업체담당자</th>
                            </tr>
                        </thead>
                        <tbody>
                        	<c:forEach items="${ordrList}" var="resultList" varStatus="status">
                        	<tr>
                                <td>
                                	<a href="./${resultList.bplcUniqueId}/list">
									${resultList.bplcNm}
									</a>
                                </td>
                                <td>
									${resultList.buyCnt}
                                </td>
                                <td>
                                	<fmt:formatNumber value="${resultList.ordrPc}" pattern="###,###" />
                                </td>
                                <td>
                                	<fmt:formatNumber value="${resultList.dlvyBassAmt + resultList.dlvyAditAmt}" pattern="###,###" />
                                </td>
                                <td>
                                	<fmt:formatNumber value="${resultList.ordrPc + resultList.dlvyBassAmt + resultList.dlvyAditAmt}" pattern="###,###" />
                                </td>
                                <td>
									${resultList.picNm}
                                </td>
                            </tr>
                            </c:forEach>

                            <c:if test="${empty ordrList}">
	                        <tr>
	                            <td class="noresult" colspan="6">검색조건을 선택하신 후 검색버튼을 클릭하셔야 조회가 진행됩니다</td>
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

                $(function(){
                	$(".btn-excel").on("click", function(){
                        $("#searchFrm").attr("action","excel").submit();
                        $("#searchFrm").attr("action","list");
	            	});
                });
                </script>