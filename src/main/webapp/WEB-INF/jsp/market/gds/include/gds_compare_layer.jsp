<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>



            <div class="header">
                <p>상품비교</p>
                <ul>
                    <li>${_gdsCtgryListMap[ctgryNo]}</li>
                </ul>
            </div>
            <div class="container">
                <div class="content">
                    <div class="select"></div>
                    <table>
                        <tr>
                            <th scope="row" class="title">
                                <div class="header">
                                    <p>상품<br>비교</p>
                                    <ul>
                                        <li>${_gdsCtgryListMap[ctgryNo]}</li>
                                    </ul>
                                </div>
                            </th>
                            <c:forEach items="${listVO.listObject}" var="resultList" varStatus="status">
                            <td class="items">
                                <div class="delete">
                                    <button type="button" class="f_compare_item_del" data-gds-info="${resultList.gdsNo}|${resultList.gdsCd}|${resultList.thumbnailFile.fileNo }">삭제</button>
                                </div>
                                <div class="thumb">
                                <c:choose>
									<c:when test="${!empty resultList.thumbnailFile }">
								<img src="/comm/getImage?srvcId=GDS&amp;upNo=${resultList.thumbnailFile.upNo }&amp;fileTy=${resultList.thumbnailFile.fileTy }&amp;fileNo=${resultList.thumbnailFile.fileNo }&amp;thumbYn=Y" alt="">
									</c:when>
									<c:otherwise>
								<img src="/html/page/market/assets/images/noimg.jpg" alt="">
									</c:otherwise>
								</c:choose>
                                </div>
                            </td>
                            </c:forEach>
                            <c:forEach begin="1" end="${4 - listVO.totalCount}">
                            <td class="items">
                                <div class="delete"></div>
                                <div class="thumb is-empty"></div>
                            </td>
                            </c:forEach>
                        </tr>

                        <tr>
                            <th scope="row" class="title"><div class="sheader">상품명</div></th>
                            <c:forEach items="${listVO.listObject}" var="resultList" varStatus="status">
                            <td class="items name">${resultList.gdsNm}</td>
                            </c:forEach>
                            <c:forEach begin="1" end="${4 - listVO.totalCount}" varStatus="status">
                            <td class="items" rowspan="7">
                                <div class="empty">
                                    <img src="/html/page/market/assets/images/img-compare-number${listVO.totalCount + status.index}.svg" alt="">
                                    <p>
                                    	<c:if test="${status.last}">
                                        상품비교는<br>
                                        같은 카테고리내에서<br>
                                        최대 4개까지<br>
                                        가능합니다.
                                    	</c:if>
                                    </p>
                                </div>
                            </td>
                            </c:forEach>
                        </tr>
                        <tr>
                            <th scope="row" class="title"><div class="sheader">판매가</div></th>
                            <c:forEach items="${listVO.listObject}" var="resultList" varStatus="status">
                            <td class="items cost1"><fmt:formatNumber value="${resultList.pc}" pattern="###,###" /> <small>원</small></td>
                            </c:forEach>
                        </tr>
                        <tr>
                            <th scope="row" class="title"><div class="sheader">급여가</div></th>
                            <c:forEach items="${listVO.listObject}" var="resultList" varStatus="status">
                            <td class="items cost2">
                              	<c:choose>
                              		<c:when test="${_mbrSession.prtcrRecipterInfo.selfBndRt == 15 }">
                              	<fmt:formatNumber value="${resultList.bnefPc15}" pattern="###,###" /> <small>원</small>
                              		</c:when>
                              		<c:when test="${_mbrSession.prtcrRecipterInfo.selfBndRt == 9 }">
                              	<fmt:formatNumber value="${resultList.bnefPc9}" pattern="###,###" /> <small>원</small>
                              		</c:when>
                              		<c:when test="${_mbrSession.prtcrRecipterInfo.selfBndRt == 6 }">
                              	<fmt:formatNumber value="${resultList.bnefPc6}" pattern="###,###" /> <small>원</small>
                              		</c:when>
                              		<c:when test="${_mbrSession.prtcrRecipterInfo.selfBndRt == 0 }">
                              	0 <small>원</small>
                              		</c:when>
                              	</c:choose>
                            </td>
                            </c:forEach>
                        </tr>
                        <tr>
                            <th scope="row" class="title"><div class="sheader">재질</div></th>
                            <c:forEach items="${listVO.listObject}" var="resultList" varStatus="status">
                            <td class="items material">${resultList.mtrqlt}</td>
                            </c:forEach>
                        </tr>
                        <tr>
                            <th scope="row" class="title"><div class="sheader">중량</div></th>
                            <c:forEach items="${listVO.listObject}" var="resultList" varStatus="status">
                            <td class="items size">${resultList.wt}</td>
                            </c:forEach>
                        </tr>
                        <tr>
                            <th scope="row" class="title"><div class="sheader">사이즈</div></th>
                            <c:forEach items="${listVO.listObject}" var="resultList" varStatus="status">
                            <td class="items size">${resultList.size}</td>
                            </c:forEach>
                        </tr>
                        <tr>
                            <th scope="row" class="title"><div class="sheader">규격</div></th>
                            <c:forEach items="${listVO.listObject}" var="resultList" varStatus="status">
                            <td class="items rule">${resultList.stndrd}</td>
                            </c:forEach>
                        </tr>
                        <tr>
                            <th scope="row" class="title"></th>
                            <c:forEach items="${listVO.listObject}" var="resultList" varStatus="status">
                            <td class="items">
                            	<c:if test="${_mbrSession.loginCheck}">
                                <div class="button">
                                    <!-- <a href="#" class="cart ">장바구니 담기</a> -->
                                    <a href="#" class="btn btn-love f_wish ${resultList.wishYn>0?'is-active':''}" data-gds-no="${resultList.gdsNo}" data-wish-yn="${resultList.wishYn>0?'Y':'N'}">찜하기</a>
                                </div>
                                </c:if>
                            </td>
                            </c:forEach>
                        </tr>
                    </table>
                </div>
            </div>
            <button type="button" class="closed">상품 비교 접기</button>
