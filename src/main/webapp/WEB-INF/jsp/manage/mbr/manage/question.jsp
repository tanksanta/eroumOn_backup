<%@page import="javax.servlet.annotation.WebServlet"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<script src="/html/page/admin/assets/script/_mng/mbr/JsHouseMngMbrDetail.js"></script>

            <div id="page-content">
               <%@include file="./include/header.jsp"%>

                <form action="./question" class="mt-13" id="searchFrm" name="searchFrm">
                <input type="hidden" id="cntPerPage" name="cntPerPage" value="${param.cntPerPage}" />

                    <fieldset>
                        <legend class="text-title2">1:1문의 검색</legend>
                        <table class="table-detail">
                            <colgroup>
                                <col class="w-43">
                                <col>
                                <col class="w-43">
                                <col>
                            </colgroup>
                            <tbody>
                                <tr>
                                    <th scope="row"><label for="search-item9-1">등록일자</label></th>
                                    <td colspan="3">
										<div class="form-group">
								<input type="date" class="form-control w-39 calendar" id="srchBgngDt" name="srchBgngDt" value="${param.srchBgngDt}">
								<i>~</i>
								 <input type="date" class="form-control w-39 calendar" id="srchEndDt" name="srchEndDt" value="${param.srchEndDt}">
								<button type="button" class="btn shadow" onclick="f_srchJoinSet('1'); return false;">오늘</button>
								<button type="button" class="btn shadow" onclick="f_srchJoinSet('2'); return false;">7일</button>
								<button type="button" class="btn shadow" onclick="f_srchJoinSet('3'); return false;">15일</button>
								<button type="button" class="btn shadow" onclick="f_srchJoinSet('4'); return false;">1개월</button>
							</div>
									</td>
                                </tr>
                                <tr>
                                    <th scope="row"><label for="search-item9-2">구분</label></th>
                                    <td colspan="3">
                                        <div class="form-group w-84">
                                            <select name="srchInqryTy" class="form-control w-35" id="srchInqryTy">
                                                <option value="">전체</option>
                                                <c:forEach var="inqryTy" items="${inqryTyCode1}">
                                                	<option value="${inqryTy.key}"<c:if test="${inqryTy.key eq param.srchInqryTy}">selected="selected"</c:if>>${inqryTy.value}</option>
                                                </c:forEach>
                                            </select>
                                            <select name="srchInqryTyNo2" class="form-control flex-1" id="srchInqryTyNo2">
                                                <option value="">전체</option>
                                                <c:forEach var="inqryDtlTy" items="${inqryTyCode2}" varStatus="status">
                                                	<option value="${inqryDtlTy.key}"<c:if test="${inqryDtlTy.key eq param.srchInqryTyNo2}">selected="selected"</c:if> class="optVal${status.index}" style="display:none;">${inqryDtlTy.value}</option>
                                                </c:forEach>
                                            </select>
                                        </div>
                                    </td>
                                </tr>
                                <!--
                                <tr>
                                    <th scope="row"><label for="search-item9-3">상품코드</label></th>
                                    <td><input type="text" class="form-control w-84" id="srchCode" name="srchCode" value="${param.srchCode}"></td>
                                    <th scope="row"><label for="search-item9-4">상품명</label></th>
                                    <td><input type="text" class="form-control w-full" id="srchName" name="srchName" value="${param.srchName }"></td>
                                </tr>
                                 -->
                                <tr>
                                    <th scope="row"><label for="srchTtl">제목</label></th>
                                    <td colspan="3"><input type="text" class="form-control w-full" id="srchTtl" name="srchTtl" value="${param.srchTtl}"></td>
                                </tr>
                                <tr>
                                    <th scope="row"><label for="search-item9-6">답변상태</label></th>
                                    <td colspan="3">
                                        <div class="form-check-group">
                                            <div class="form-check">
                                                <input class="form-check-input" type="radio" name="srchAns" id="search-item9-6" value="" checked>
                                                <label class="form-check-label" for="search-item9-6">전체</label>
                                            </div>
                                            <c:forEach var="ans" items="${ansYn}" varStatus="status">
	                                            <div class="form-check">
	                                                <input class="form-check-input" type="radio" name="srchAns" id="srchAns${status.index}" value="${ans.key}" <c:if test="${ans.key eq param.srchAns }">checked="checked"</c:if>>
	                                                <label class="form-check-label" for="srchAns${status.index}">${ans.value }</label>
	                                            </div>
                                            </c:forEach>
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

                <p class="text-title2 mt-13">1:1문의 목록</p>
                <table class="table-list">
                    <colgroup>
                        <col class="w-23">
                        <col class="w-[15%]">
                        <col>
                        <col class="w-32">
                        <col class="w-30">
                        <col class="w-32">
                        <col class="w-30">
                    </colgroup>
                    <thead>
                        <tr>
                            <th scope="col">번호</th>
                            <th scope="col">문의유형</th>
                            <th scope="col">제목</th>
                            <th scope="col">등록일</th>
                            <th scope="col">답변상태</th>
                            <th scope="col">답변일</th>
                            <th scope="col">답변자명</th>
                        </tr>
                    </thead>
                    <tbody>
                    	<c:forEach var="resultList" items="${listVO.listObject}" varStatus="status">
                    	<c:set var="pageParam" value="inqryNo=${resultList.inqryNo}&amp;srchBgngDt=${param.srchBgngDt}&amp;srchEndDt=${pararm.srchEndDt}&amp;srchInqryTy=${param.srchInqryTy}&amp;srchInqryTyNo2=${pararm.srchInqryTyNo2}&amp;srchTtl=${pararm.srchTtl}&amp;srchAns=${pararm.srchAns}" />
                        <tr>
                            <td>${listVO.startNo - status.index }</td>
                            <td>${inqryTyCode1[resultList.inqryTy]}</td>
                            <td class="text-left"><a href="/_mng/mbr/${resultList.regUniqueId}/questionView?${pageParam}">${resultList.ttl}</a></td>
                            <td><fmt:formatDate value="${resultList.regDt}" pattern="yyyy-MM-dd" /><br><fmt:formatDate value="${resultList.regDt}" pattern="HH:mm:ss" /></td>
                            <td>${ansYn[resultList.ansYn] }</td>
                            <td>
                            	<c:if test="${resultList.ansYn eq 'Y'}"><fmt:formatDate value="${resultList.ansDt}" pattern="yyyy-MM-dd" /><br><fmt:formatDate value="${resultList.ansDt}" pattern="HH:mm:ss" /></c:if>
                            	<c:if test="${resultList.ansYn eq 'N'}">-</c:if>
                            </td>
                            <td>
                            	<c:if test="${resultList.ansYn eq 'Y'}">${resultList.answr}</br>	${resultList.ansId}</c:if>
                            	<c:if test="${resultList.ansYn eq 'N'}">-</c:if>
                            </td>
                        </tr>
                        </c:forEach>
						<c:if test="${empty listVO.listObject}">
							<tr>
								<td class="noresult" colspan="7">검색조건을 만족하는 결과가 없습니다.</td>
							</tr>
						</c:if>
                    </tbody>
                </table>

				<div class="pagination mt-7">
				<mngr:mngrPaging listVO="${listVO}" />
					<div class="sorting2">
						<label for="countPerPage">출력</label>
						 <select name="countPerPage" id="countPerPage" class="form-control">
							<option value="10" ${listVO.cntPerPage eq '10' ? 'selected' : '' }>10개</option>
							<option value="20" ${listVO.cntPerPage eq '20' ? 'selected' : '' }>20개</option>
							<option value="30" ${listVO.cntPerPage eq '30' ? 'selected' : '' }>30개</option>
						</select>
					</div>

					<div class="counter">
						총 <strong>${listVO.totalCount}</strong>건, <strong>${listVO.curPage}</strong>/${listVO.totalPage} 페이지
					</div>
				</div>


            <script>
                var ctlMaster;
                $(document).ready(function(){
                    ctlMaster = new JsHouseMngMbrQuestion();
                    ctlMaster.fn_searched_data(`<%= request.getParameter("searched_data") != null ? request.getParameter("searched_data") : "" %>`);
                    ctlMaster.fn_page_init();
                });

            	$(function(){
            		if("${mbrVO.joinCours}" == "MOBILE"){
            			$("#coursPattern").attr("class","ico-member-mo type");
            		}

            	});

            	function f_srchJoinSet(ty){
            	  	//srchJoinBgng, srchJoinEnd
            		$("#srchEndDt").val(f_getToday());
            		if(ty == "1"){//오늘
            	   		$("#srchBgngDt").val(f_getToday());
            		}else if(ty == "2"){//일주일
            			$("#srchBgngDt").val(f_getDate(-7));
            		}else if(ty == "3"){//15일
            			$("#srchBgngDt").val(f_getDate(-15));
            		}else if(ty == "4"){//한달
            			$("#srchBgngDt").val(f_getDate(-30));
            		}
            	}

                //문의 유형
                function f_inqryTyChg(idx){
                	console.log(idx);
                	$(".allVal").css("display","none");
                	for(var i=0; i<7;  i++){
                		if(idx == i){
                			//2번째 그룹 예외
                			if(idx == 1){
                				$(".optVal"+(i*3)).css("display","");
                    			$(".optVal"+(i*3+1)).css("display","");
                    			$(".optVal"+(i*3+2)).css("display","");
                    			$(".optVal"+(i*3+3)).css("display","");
                			}else if(idx ==0){
            	    			$(".optVal"+(i)).css("display","");
            	    			$(".optVal"+(i+1)).css("display","");
            	    			$(".optVal"+(i+2)).css("display","");
                			}else{
                				$(".optVal"+(i*3+1)).css("display","");
                				$(".optVal"+(i*3+2)).css("display","");
                				$(".optVal"+(i*3+3)).css("display","");
                			}
                		}
                	}
                }

                $(function(){

                	//문의유형
                	$("#srchInqryTy").on("change",function(){
                		f_inqryTyChg($(this).val());
                	});
                });
            </script>