<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

                        <c:set var="sumDgstfn" value="0"/>
						<p class="text-base font-bold mt-8 md:mt-10 md:text-lg">
							포토 상품후기 (${listVO.totalCount})
							<input type="hidden" id="photoReviewListCnt" name="photoReviewListCnt" value="${listVO.totalCount}">
						</p>
						<c:if test="${!empty listVO.listObject}">
                        <div class="mt-2.5 border-t border-gray3">
                        	<c:forEach items="${listVO.listObject}" var="resultList" varStatus="status">
                        	<c:set var="sumDgstfn" value="${sumDgstfn + resultList.dgstfn}" />
                            <div class="article-item">
                                <a href="#modal-review" class="thumb f_review_show" data-review-no="${resultList.gdsReivewNo}">
                                    <img src="/comm/getImage?srvcId=REVIEW&amp;upNo=${resultList.imgFile.upNo }&amp;fileTy=${resultList.imgFile.fileTy }&amp;fileNo=${resultList.imgFile.fileNo}" alt="">
                                </a>
                                <div class="content">
                                    <p class="context">
                                        ${resultList.cn}
                                    </p>
                                    <p class="datetime">
                                        <strong>${resultList.regId.replaceAll("(?<=.{3}).", "*")}</strong>
                                        <span><fmt:formatDate value="${resultList.regDt}" pattern="yyyy-MM-dd"/></span>
                                    </p>
                                </div>
                            </div>
                            </c:forEach>
                        </div>
                        </c:if>

                        <c:if test="${empty listVO.listObject}">
                        <div class="mt-2.5">
		                    <p class="box-result">등록된 상품 후기가 없습니다.</p>
		                </div>
		                </c:if>
		                <input type="hidden" id="sumPhotoDgstfn" name="sumPhotoDgstfn" value="${sumDgstfn}">
                        <div class="pagination">
                            <front:jsPaging listVO="${listVO}" targetObject="photo-review-pager" />
                        </div>