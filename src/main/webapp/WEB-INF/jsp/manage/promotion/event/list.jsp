<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
            <div id="page-content">
                <form action="./list" method="get" id="searchFrm" name="searchFrm">
				<input type="hidden" name="cntPerPage" id="cntPerPage" value="${listVO.cntPerPage}" />
				<input type="hidden" name="sortBy" id="sortBy" value="${param.sortBy}" />
				<fieldset>
                        <legend class="text-title2">이벤트 검색</legend>
                        <table class="table-detail">
                            <colgroup>
                                <col class="w-43">
                                <col>
                            </colgroup>
                            <tbody>
                                <tr>
                                    <th scope="row"><label for="search-item1">기간</label></th>
                                    <td>
                                        <div class="form-group w-84">
                                            <input type="date" class="form-control flex-1 calendar" name="srchBgngDt" value="${param.srchBgngDt}">
                                            <i>~</i>
                                            <input type="date" class="form-control flex-1 calendar" name="srchEndDt" value="${param.srchEndDt}">
                                        </div>
                                    </td>
                                </tr>
                                <tr>
                                    <th scope="row"><label for="srchEventTy">이벤트 형태</label></th>
                                    <td>
                                        <select name="srchEventTy" id="srchEventTy" name="srchEventTy" class="form-control w-84">
                                            <option value="">전체</option>
                                        	<c:forEach var="event" items="${eventTy}">
                                            	<option value="${event.key}"  <c:if test="${event.key eq param.srchEventTy}"> selected="selected" </c:if>>${event.value}</option>
                                            </c:forEach>
                                        </select>
                                    </td>
                                </tr>
                                <tr>
                                    <th scope="row"><label for="srchText">이벤트명</label></th>
                                    <td><input type="text" class="form-control w-84" id="srchText" name="srchText" value="${param.srchText}"></td>
                                </tr>
                                <tr>
                                    <th scope="row">
                                    	<label >상태</label>
                                    </th>
                                    <td>
                                        <div class="form-check-group">
                                            <div class="form-check">
                                                <input class="form-check-input" type="radio" name="srchDspyYn" id="all" value="" checked>
                                                <label class="form-check-label" for="all">전체</label>
                                            </div>
                                            <c:forEach var="dspy" items="${dspyYn}">
	                                            <div class="form-check">
	                                               	<input class="form-check-input" type="radio" name="srchDspyYn" id="${dspy.key}" value="${dspy.key}"<c:if test="${dspy.key eq param.srchDspyYn}"> checked="checked"</c:if>>
	                                               	<label class="form-check-label" for="${dspy.key}">${dspy.value}</label>
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

                <p class="text-title2 mt-13">이벤트 목록</p>
                <table class="table-list">
                    <colgroup>
                        <col class="w-25">
                        <col>
                        <col class="w-80">
                        <col class="w-35">
                        <col class="w-22">
                        <col class="w-25">
                        <col class="w-25">
                        <col class="w-22">
                    </colgroup>
                    <thead>
                        <tr>
                            <th scope="col">번호</th>
                            <th scope="col">이벤트 명</th>
                            <th scope="col">이벤트 기간</th>
                            <th scope="col">당첨자 발표일</th>
                            <th scope="col">형태</th>
                            <th scope="col">응모자 수</th>
                            <th scope="col">진행 상태</th>
                            <th scope="col">상태</th>
                        </tr>
                    </thead>
                    <tbody>
                    	<c:forEach var="resultList" items="${listVO.listObject}" varStatus="status">
                    	<c:set var="pageParam" value="eventNo=${resultList.eventNo}&amp;przwinNo=${resultList.przwinNo}&amp;curPage=${listVO.curPage}&amp;srchBgngDt=${param.srchBgngDt}&amp;srchEndDt=${param.srchEndDt}&amp;srchText=${param.srchText}&amp;srchYn=${param.srchYn}&amp;cntPerPage=${listVO.cntPerPage}&amp;cntPerPageEvent=10&amp;sortBy=${param.sortBy}&amp;eventTy=${param.srchEventTy }" />
                        <tr>
                            <td>${listVO.startNo - status.index }</td>
                            <td><a href="/_mng/promotion/event/form?${pageParam}">${resultList.eventNm}</a></td>
                            <td>
                            	<fmt:formatDate value="${resultList.bgngDt}" pattern="yyyy-MM-dd HH:mm" /> ~ <fmt:formatDate value="${resultList.endDt}" pattern="yyyy-MM-dd HH:mm" />
                            </td>
                            <td><fmt:formatDate value="${resultList.prsntnYmd}" pattern="yyyy-MM-dd" /></td>
                            <td>${eventTy[resultList.eventTy]}</td>
                            <td>${resultList.applcnCount}</td>
                            	<c:set var="now" value="<%=new java.util.Date()%>" />
                            	<td>
                            		<c:choose>
                            			<c:when test="${now gt resultList.endDt}">종료</c:when>
										<c:when test="${resultList.bgngDt le now and now le resultList.endDt}">진행중</c:when>
                            			<c:otherwise>대기</c:otherwise>
									</c:choose>
                            	</td>
                            <td>${dspyYn[resultList.dspyYn]}</td>
                        </tr>
                        </c:forEach>
						<c:if test="${empty listVO.listObject}">
                        <tr>
                            <td class="noresult" colspan="8">검색조건을 만족하는 결과가 없습니다.</td>
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

				<c:set var="pageParam" value="curPage=${listVO.curPage}&amp;srchBgngDt=${param.srchBgngDt}&amp;srchEndDt=${param.srchEndDt}&amp;srchText=${param.srchText}&amp;srchYn=${param.srchYn}&amp;cntPerPageEvent=${param.cntPerPage}&amp;sortBy=${param.sortBy}&amp;eventTy=${param.srchEventTy }" />
                <div class="btn-group right mt-8">
                    <a href="/_mng/promotion/event/form?" class="btn-primary large shadow">등록</a>
                </div>
            </div>

            <script>
            </script>