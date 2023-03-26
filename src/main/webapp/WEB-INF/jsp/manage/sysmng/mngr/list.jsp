<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>


				<form id="searchFrm" name="searchFrm" method="get" action="./list">
				<input type="hidden" name="cntPerPage" id="cntPerPage" value="${listVO.cntPerPage}" />
				<input type="hidden" name="sortBy" id="sortBy" value="${param.sortBy}" />

                    <fieldset>
                        <legend class="text-title2">관리자 검색</legend>
                        <table class="table-detail">
                            <colgroup>
                                <col class="w-43">
                                <col>
                            </colgroup>
                            <tbody>
                                <tr>
                                    <th scope="row"><label for="search-item1">키워드검색</label></th>
                                    <td>
                                        <div class="form-group w-84">
                                            <select name="srchTarget" id="srchTarget" class="form-control w-25">
                                                <option value="">전체</option>
                                                <option value="srchMngrNm" ${param.srchTarget eq 'srchMngrNm'?'selected="selected"':''}>관리자명</option>
                                                <option value="srchMngrId" ${param.srchTarget eq 'srchMngrId'?'selected="selected"':''}>아이디</option>
                                            </select>
                                            <input type="text" class="form-control flex-1" name="srchText" id="srchText" value="${param.srchText}">
                                        </div>
                                    </td>
                                </tr>
                                <tr>
                                    <th scope="row"><label for="search-item2">관리자권한</label></th>
                                    <td>
                                        <select name="srchAuthTy" id="srchAuthTy" class="form-control w-84">
                                            <option value="">권한 전체</option>
                                            <c:forEach var="item" items="${authrtTyCode}">
											<option value="${item.key}" ${item.key eq param.srchAuthTy ? ' selected=\"selected\"' : '' }>${item.value}</option>
											</c:forEach>
                                        </select>
                                    </td>
                                </tr>
                                <tr>
                                    <th scope="row"><label for="search-item3">상태</label></th>
                                    <td>
                                        <div class="form-check-group">
                                            <div class="form-check">
                                                <input class="form-check-input" type="radio" name="srchUseYn" id="srchUseYn1" value="" ${empty param.srchUseYn?'checked':''}>
                                                <label class="form-check-label" for="srchUseYn2">전체</label>
                                            </div>
                                            <div class="form-check">
                                                <input class="form-check-input" type="radio" name="srchUseYn" id="srchUseYn2" value="Y" ${param.srchUseYn eq 'Y'?'checked':''}>
                                                <label class="form-check-label" for="srchUseYn2">사용</label>
                                            </div>
                                            <div class="form-check">
                                                <input class="form-check-input" type="radio" name="srchUseYn" id="srchUseYn3" value="N" ${param.srchUseYn eq 'N'?'checked':''}>
                                                <label class="form-check-label" for="srchUseYn3">미사용</label>
                                            </div>
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

                <p class="text-title2 mt-13">관리자 목록</p>
                <table class="table-list">
                    <colgroup>
                        <col class="w-25">
                        <col class="w-[18%]">
                        <col>
                        <col class="w-28">
                        <col class="w-36">
                        <col class="w-44">
                        <col class="w-25">
                    </colgroup>
                    <thead>
                        <tr>
                            <th scope="col">번호</th>
                            <th scope="col">아이디</th>
                            <th scope="col">이름</th>
                            <th scope="col">권한</th>
                            <th scope="col">휴대폰</th>
                            <th scope="col">등록일</th>
                            <th scope="col">상태</th>
                        </tr>
                    </thead>
                    <tbody>
                    	<c:forEach items="${listVO.listObject}" var="resultList" varStatus="status">
                    	<c:set var="pageParam" value="uniqueId=${resultList.uniqueId}&amp;curPage=${listVO.curPage}${!empty(listVO.urlParam)? '&amp;' : ''}${listVO.urlParam}" />
                        <tr>
                            <td>${listVO.startNo - status.index }</td>
                            <td><a href="./form?${pageParam}">${resultList.mngrId }</a></td>
                            <td>${resultList.mngrNm }</td>
                            <td>${authrtTyCode[resultList.authrtTy]}</td>
                            <td>${resultList.telno }</td>
                            <td><fmt:formatDate value="${resultList.regDt}" pattern="yyyy-MM-dd HH:mm:ss"/></td>
                            <td>${useYnCode[resultList.useYn] }</td>
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