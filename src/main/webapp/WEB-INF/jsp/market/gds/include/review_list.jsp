<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

						<c:set var="sumDgstfn" value="0"/>
						<p class="text-base font-bold mt-22 md:mt-28 md:text-lg">
							일반 상품후기 (${listVO.totalCount})
							<input type="hidden" id="reviewListCnt" name="reviewListCnt" value="${listVO.totalCount}">
						</p>
						<c:if test="${!empty listVO.listObject}">
                        <div class="mt-2.5 border-t border-gray3">
                        	<c:forEach items="${listVO.listObject}" var="resultList" varStatus="status">
                        	<c:set var="sumDgstfn" value="${sumDgstfn + resultList.dgstfn}" />
                            <div class="article-item2">
                                <p class="context">
                                	<a href="#review" class="f_review_show" data-review-no="${resultList.gdsReivewNo}">${resultList.ttl}</a>
                                </p>
                                <p class="datetime">
                                    <strong>${resultList.regId.replaceAll("(?<=.{3}).", "*")}</strong>
                                    <span><fmt:formatDate value="${resultList.regDt}" pattern="yyyy-MM-dd"/></span>
                                </p>
                            </div>
                            </c:forEach>
                        </div>
                        </c:if>

                        <c:if test="${empty listVO.listObject}">
                        <div class="mt-2.5">
		                    <p class="box-result">등록된 상품 후기가 없습니다.</p>
		                </div>
		                </c:if>
		                <input type="hidden" id="sumDgstfn" name="sumDgstfn" value="${sumDgstfn}">
                        <div class="pagination">
                            <front:jsPaging listVO="${listVO}" targetObject="review-pager" />
                        </div>