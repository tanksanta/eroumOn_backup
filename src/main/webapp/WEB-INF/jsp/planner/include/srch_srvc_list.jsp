<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

					<input type="hidden" id="srvcListCnt" name="srvcListCnt" value="${listVO.totalCount}">

					<div class="page-content-items" data-page-total="${listVO.totalPage}">
						<c:if test="${!empty listVO.listObject}">
                        <div class="content-items">
                            <div class="content-sizer"></div>
                            <div class="content-gutter"></div>

							<c:forEach items="${listVO.listObject}" var="resultList" varStatus="status">
							<c:set var="colorNumber"><%-- 카테고리 선택안했을 경우 default --%>
							<c:choose>
								<c:when test="${fn:contains(resultList.categoryList, '주거')}">1</c:when>
								<c:when test="${fn:contains(resultList.categoryList, '문화')}">2</c:when>
								<c:when test="${fn:contains(resultList.categoryList, '보건')}">3</c:when>
								<c:when test="${fn:contains(resultList.categoryList, '고용')}">4</c:when>
								<c:when test="${fn:contains(resultList.categoryList, '교육')}">5</c:when>
								<c:when test="${fn:contains(resultList.categoryList, '상담')}">6</c:when>
								<c:when test="${fn:contains(resultList.categoryList, '보호')}">8</c:when>
								<c:when test="${fn:contains(resultList.categoryList, '지원')}">7</c:when>
							</c:choose>
							</c:set>
                            <div class="content-item">
                            	<a href="#${resultList.bokjiId}" class="content-body is-color${colorNumber}">
                                    <div class="content">
                                        <p class="name">${resultList.benefitName}</p>
                                        <p class="type">
                                        	<c:forEach items="${resultList.categoryList}" var="cate" varStatus="s">
                                        	<%-- ${fn:replace(cate, '#', '')} ${s.last?'':' ∙ '} --%>
                                        	${cate} ${s.last?'':' ∙ '}
                                        	</c:forEach>
                                        </p>
                                        <p class="part">${resultList.bokjiResource}</p>
                                    </div>
                                    <div class="status"></div>
                                </a>
                            </div>
                            </c:forEach>
                        </div>
                        <div class="content-button">
                        	<c:if test="${listVO.curPage > 1}">
                            <button type="button" class="content-prev srvc-pager" data-page-no="${listVO.curPage - 1}" data-page-total="${listVO.totalPage}"><span>이전 페이지</span> <i></i></button>
                            </c:if>
                            <c:if test="${listVO.curPage < listVO.totalPage}">
                            <button type="button" class="content-next srvc-pager" data-page-no="${listVO.curPage + 1}" data-page-total="${listVO.totalPage}"><span>다음 페이지</span> <i></i></button>
                            </c:if>
                        </div>
                        </c:if>
                        <c:if test="${empty listVO.listObject}">
						데이터가 없습니다.
                        </c:if>
                    </div>