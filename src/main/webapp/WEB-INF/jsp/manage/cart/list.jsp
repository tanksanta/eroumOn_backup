<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

				<!-- 검색영역 -->
				<form id="searchFrm" name="searchFrm" method="get" action="./list">
				<input type="hidden" name="srchTarget" id="srchTarget" value="${param.srchTarget}" />
				<input type="hidden" name="srchUseAt" id="srchUseAt" value="${param.srchUseAt }" />
				<input type="hidden" name="cntPerPage" id="cntPerPage" value="${listVO.cntPerPage}" />
				<input type="hidden" name="sortBy" id="sortBy" value="${param.sortBy}" />
					
    <input type="hidden" name="cartNo" />
				<fieldset>
                    <legend class="text-title2">검색</legend>
                    <table class="table-detail">
                        <colgroup>
                            <col class="w-43">
                            <col>
                            <col class="w-43">
                            <col>
                        </colgroup>
                        <tbody>
                            <tr>
                                <th scope="row"><label for="search-item1">검색</label></th>
                                <td colspan="3">
                                    <input type="text" class="form-control w-84" id="search-item1">
                                </td>
                            </tr>
                        </tbody>
                    </table>
                </fieldset>

                <div class="btn-group mt-5">
                    <button type="submit" class="btn-primary large shadow w-52">검색</button>
                </div>
				</form>
					
				<p class="text-title2 mt-13">Cart 목록</p>
                <table class="table-list">
                    <colgroup>
                        						<col/>				
												<col/>				
												<col/>				
												<col/>				
												<col/>				
												<col/>				
												<col/>				
												<col/>				
												<col/>				
												<col/>				
												<col/>				
												<col/>				
												<col/>				
						                    </colgroup>
                    <thead>
                        <tr>
                        								<th scope="col">CartNo</th>
														<th scope="col">GdsNo</th>
														<th scope="col">GdsCd</th>
														<th scope="col">BnefCd</th>
														<th scope="col">GdsNm</th>
														<th scope="col">OrdrPc</th>
														<th scope="col">OrdrOptn</th>
														<th scope="col">OrdrOptnPc</th>
														<th scope="col">OrdrQy</th>
														<th scope="col">RegUniqueId</th>
														<th scope="col">RegDt</th>
														<th scope="col">RegId</th>
														<th scope="col">Rgtr</th>
							                        </tr>
                    </thead>
                    <tbody>
                    	<c:forEach items="${listVO.listObject}" var="resultList" varStatus="status">
                    	<c:set var="pageParam" value="curPage=${listVO.curPage}${!empty(listVO.urlParam)? '&amp;' : ''}${listVO.urlParam}" />
                        <tr>
		 				<td><a href="./form?cartNo=<c:out value="${resultList.cartNo}"/>"><c:out value="${resultList.cartNo}"/></a>&nbsp;</td>
								<td><c:out value="${resultList.gdsNo}"/></td>
								<td><c:out value="${resultList.gdsCd}"/></td>
								<td><c:out value="${resultList.bnefCd}"/></td>
								<td><c:out value="${resultList.gdsNm}"/></td>
								<td><c:out value="${resultList.ordrPc}"/></td>
								<td><c:out value="${resultList.ordrOptn}"/></td>
								<td><c:out value="${resultList.ordrOptnPc}"/></td>
								<td><c:out value="${resultList.ordrQy}"/></td>
								<td><c:out value="${resultList.regUniqueId}"/></td>
								<td><c:out value="${resultList.regDt}"/></td>
								<td><c:out value="${resultList.regId}"/></td>
								<td><c:out value="${resultList.rgtr}"/></td>
						                        </tr>
                        </c:forEach>
                        <c:if test="${empty listVO.listObject}">
                        <tr>
                            <td class="noresult" colspan="10">등록된 데이터가 없습니다.</td>
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
    
    				<!--
                    <div class="sorting">
                        <a href="#" ${listVO.cntPerPage eq '10' ? 'class="active"' : '' }>10</a>
                        <a href="#" ${listVO.cntPerPage eq '20' ? 'class="active"' : '' }>20</a>
                        <a href="#" ${listVO.cntPerPage eq '30' ? 'class="active"' : '' }>30</a>
                    </div>
                    -->
    
                    <div class="counter">총 <strong>${listVO.totalCount}</strong>건, <strong>${listVO.curPage}</strong>/${listVO.totalPage} 페이지</div>
                </div>
                
                <!-- button -->
                <div class="btn-group right mt-8">
                    <a href="./form" class="btn-primary large shadow">등록</a>
                </div>
                

                <script>
                $(function(){
                
                
                
                	// 출력 갯수
	                $("#countPerPage").on("change", function(){
						var cntperpage = $("#countPerPage option:selected").val();
						$("#cntPerPage").val(cntperpage);
						$("#searchFrm").submit();
					});
                });
                </script>