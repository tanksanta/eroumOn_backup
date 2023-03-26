<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

				<form id="searchFrm" name="searchFrm" method="get" action="./list">
				<input type="hidden" name="cntPerPage" id="cntPerPage" value="${listVO.cntPerPage}" />
				<input type="hidden" name="srchBbsNo" id="srchBbsNo" value="${!empty param.srchBbsNo?param.srchBbsNo:bbsSetupVO.bbsNo}" />
                    <fieldset>
                        <legend class="text-title2">[${bbsSetupVO.bbsNm}] 검색</legend>
                        <table class="table-detail">
                            <colgroup>
                                <col class="w-43">
                                <col>
                                <col class="w-48">
                                <col>
                            </colgroup>
                            <tbody>
                                <tr>
                                    <th scope="row"><label for="search-item1">등록일</label></th>
                                    <td colspan="3">
                                        <div class="form-group">
                                            <input type="date" class="form-control w-39 calendar" id="srchWrtYmdBgng" name="srchWrtYmdBgng" value="${param.srchWrtYmdBgng}">
                                            <i>~</i>
                                            <input type="date" class="form-control w-39 calendar" id="srchWrtYmdEnd" name="srchWrtYmdEnd" value="${param.srchWrtYmdEnd}">
                                            <button type="button" class="btn shadow" onclick="f_srchWrtYmdSet('1'); return false;">오늘</button>
                                            <button type="button" class="btn shadow" onclick="f_srchWrtYmdSet('2'); return false;">7일</button>
                                            <button type="button" class="btn shadow" onclick="f_srchWrtYmdSet('3'); return false;">15일</button>
                                            <button type="button" class="btn shadow" onclick="f_srchWrtYmdSet('4'); return false;">1개월</button>
                                        </div>
                                    </td>
                                </tr>
                                <tr>
                                    <th scope="row"><label for="srchTarget">키워드검색</label></th>
                                    <td>
                                        <select name="srchTarget" id="srchTarget" class="form-control w-25">
                                            <option value="" ${empty param.srchTarget?'selected':'' }>전체</option>
                                            <option value="srchTtl" ${param.srchTarget eq 'srchTtl'?'selected':'' }>제목</option>
                                            <option value="srchWrtr" ${param.srchTarget eq 'srchWrtr'?'selected':'' }>작성자</option>
                                            <option value="srchWrtId" ${param.srchTarget eq 'srchWrtId'?'selected':'' }>작성자ID</option>
                                        </select>
                                        <input type="text" class="form-control flex-1" name="srchText" id="srchText" value="${param.srchText}">
                                    </td>
                                </tr>
                            </tbody>
                        </table>
                    </fieldset>

                    <div class="btn-group mt-5">
                        <button type="submit" class="btn-primary large shadow w-52">검색</button>
                    </div>
                </form>

                <c:if test="${bbsSetupVO.bbsNo == 1 }">
                <!--
				<p class="mt-7 text-gray1">
                    * 이로움마켓 공지사항은 이로움마켓에서 멤버스(사업소)로 전달하는 공지사항입니다.
                </p>
				-->
                </c:if>

                <p class="text-title2 mt-13">[${bbsSetupVO.bbsNm}] 목록</p>
                <table class="table-list">
                    <colgroup>
                        <col class="w-20">
                        <col>
                        <col class="w-30">
                        <col class="w-30">
                        <col class="w-30">
                        <col class="w-17">
                        <col class="w-30">
                    </colgroup>
                    <thead>
                        <tr>
                            <th scope="col">번호</th>
                            <th scope="col">제목</th>
                            <th scope="col">아이디</th>
                            <th scope="col">작성자</th>
                            <th scope="col">등록일</th>
                            <th scope="col">조회수</th>
                            <th scope="col">관리</th>
                        </tr>
                    </thead>
                    <tbody>
                    	<c:forEach items="${listVO.listObject}" var="resultList" varStatus="status">
						<c:set var="pageParam" value="bbsNo=${resultList.bbsNo}&amp;nttNo=${resultList.nttNo}&amp;curPage=${listVO.curPage}${!empty(listVO.urlParam)? '&amp;' : ''}${listVO.urlParam}" />
                        <tr>
                            <td>${listVO.startNo - status.index}</td>
                            <td class="text-left">
                            	<c:forEach begin="1" end="${resultList.nttLevel}">&nbsp;&nbsp;&nbsp;&nbsp;</c:forEach>
								<c:if test="${resultList.nttOrdr > 1 }"><i class="ico-reply">RE:</i> </c:if>
								<c:choose>
									<c:when test="${resultList.sttsTy eq 'C' }">
								<a href="./view?${pageParam}"><spring:message code='board.blind' /></a>
									</c:when>
									<c:otherwise>
								<a href="./view?${pageParam}"><c:if test="${!empty resultList.ctgryNm}">[${resultList.ctgryNm}] </c:if>${resultList.ttl}</a>
								<c:if test="${bbsSetupVO.secretUseYn eq 'Y'}">
									<c:if test="${resultList.secretYn eq 'Y'}"><i class="fa fa-lock text-red1"></i></c:if>
									<c:if test="${resultList.secretYn eq 'N'}"><i class="fa fa-lock-open text-blue1"></i></c:if>
								</c:if>
									</c:otherwise>
								</c:choose>
                            </td>
                            <td>${resultList.wrtId}</td>
                            <td>${resultList.wrtr}</td>
                            <td>${resultList.wrtYmd}</td>
                            <td>${resultList.inqcnt}</td>
                            <td>
                            	<c:choose>
									<c:when test="${resultList.sttsTy eq 'C' }">
										<a href="#" onclick="f_blindChg('${resultList.bbsNo}', '${resultList.nttNo}', 'P'); return false;" class="btn-danger">해제</a>
									</c:when>
									<c:otherwise>
										<a href="#" onclick="f_blindChg('${resultList.bbsNo}', '${resultList.nttNo}', 'C'); return false;" class="btn-success shadow">블라인드</a>
									</c:otherwise>
								</c:choose>
                            </td>
                        </tr>
                        </c:forEach>
                        <c:if test="${empty listVO.listObject}">
                        <tr>
                            <td class="noresult" colspan="7">등록된 데이터가 없습니다.</td>
                        </tr>
                        </c:if>
                    </tbody>
                </table>

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

                <div class="btn-group right mt-8">
                    <a href="./form?srchBbsNo=${!empty param.srchBbsNo?param.srchBbsNo:bbsSetupVO.bbsNo}" class="btn-primary large shadow">등록</a>
                </div>


                <script>

                function f_srchWrtYmdSet(ty){
                	//srchWrtYmdBgng, srchWrtYmdEnd
                	$("#srchWrtYmdEnd").val(f_getToday());
                	if(ty == "1"){//오늘
                   		$("#srchWrtYmdBgng").val(f_getToday());
                	}else if(ty == "2"){//일주일
                		$("#srchWrtYmdBgng").val(f_getDate(-7));
                	}else if(ty == "3"){//15일
                		$("#srchWrtYmdBgng").val(f_getDate(-15));
                	}else if(ty == "4"){//한달
                		$("#srchWrtYmdBgng").val(f_getDate(-30));
                	}
                }

                function f_blindChg(bbs, ntt, val){
                	$.ajax({
                		type : "post",
                		url: './blindChg.json',
                		data: 'bbsNo='+ bbs +'&nttNo='+ ntt +'&sttsTy='+val,
                		dataType: 'json'
                	}).done(function(json) {
               			if(json.result){
               				alert("상태 변경되었습니다.");
               				location.reload();
               			}else{
               				alert("상태 변경에 실패하였습니다\n\n잠시후 다시 시도해 주시기 바랍니다.");
               			}
                	}).fail(function(xhr,status,errorThrown){
                		console.log(xhr, status, errorThrown);
                	});
                }

                $(function(){

                	// 출력 갯수
	                $("#countPerPage").on("change", function(){
						var cntperpage = $("#countPerPage option:selected").val();
						$("#cntPerPage").val(cntperpage);
						$("#searchFrm").submit();
					});
                });
                </script>