<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
						<%-- 상품문의 리스트 --%>

						<div class="p-4 border border-gray1 rounded-md bg-neutral-100 space-y-1.5 md:p-5">
                            <p class="text-alert">상품에 관련된 문의가 아닌 배송 및 주문관련 문의는 고객센터의 FAQ나 1:1 문의를 이용하여 주십시오.</p>
                            <p class="text-alert">먼저 질문하신 고객님들의 내용을 확인하시면, 보다 유용한 정보를 빠르게 확인하실 수 있습니다.</p>
                        </div>
                        <div class="mt-8 flex items-center justify-between md:mt-10">
                            <p>총 <strong class="text-danger font-serif">${listVO.totalCount}개</strong>의 상품문의
                            	<input type="hidden" id="qaListCnt" name="qaListCnt" value="${listVO.totalCount}">
                            </p>
                            <c:if test="${_mbrSession.loginCheck}">
                            <button type="button" class="btn btn-primary w-31 md:w-39" data-bs-toggle="modal" data-bs-target="#modal-request">상품문의</button>
                            </c:if>
                            <c:if test="${!_mbrSession.loginCheck}">
                            <button type="button" class="btn btn-primary w-31 md:w-39" onclick="alert('로그인 후 상품문의 내용을 작성해 주세요.'); return false;">상품문의</button>
                            </c:if>
                        </div>
                        <c:if test="${!empty listVO.listObject}">
                        <div class="mt-2.5 border-t border-gray3">
                        	<c:forEach items="${listVO.listObject}" var="resultList" varStatus="status">
                            <div class="product-qnaitem">
                                <div class="question">
                                	<c:if test="${resultList.ansYn eq 'Y'}">
                                    <span class="label-primary">
                                        <span>답변완료</span>
                                        <i></i>
                                    </span>
                                    </c:if>
                                    <c:if test="${resultList.ansYn eq 'N'}">
                                	<span class="label-outline-primary">
                                        <span>답변대기</span>
                                        <i></i>
                                    </span>
                                    </c:if>
                                    <p class="subject">
                                    	<c:choose>
                                    		<c:when test="${resultList.secretYn eq 'Y' && resultList.regUniqueId ne _mbrSession.uniqueId}">
                                    	비밀글입니다.
                                    	<img src="/html/page/market/assets/images/ico-lock.svg"  data-bs-toggle="tooltip" title="비밀글" alt="비밀글">
                                    		</c:when>
                                    		<c:when test="${resultList.secretYn eq 'Y' && resultList.regUniqueId eq _mbrSession.uniqueId}">
                                    		${resultList.qestnCn}
                                    		</c:when>
                                    		<c:otherwise>
                                    	${resultList.qestnCn}
                                    		</c:otherwise>
                                    	</c:choose>
                                    </p>
                                    <p class="datetime"><fmt:formatDate value="${resultList.regDt}" pattern="yyyy-MM-dd HH:mm:ss"/></p>
                                </div>
                                <c:if test="${resultList.ansYn eq 'Y' && !empty resultList.ansCn}">
                                <div class="answer"><%-- ${resultList.enterCnt} --%>
									<c:choose>
										<c:when test="${resultList.enterCnt > 2}">
									<div class="context">
										<c:if test="${resultList.regUniqueId ne _mbrSession.uniqueId && resultList.secretYn eq 'Y'}">
										비밀글입니다.
										</c:if>
										<c:if test="${resultList.regUniqueId eq _mbrSession.uniqueId && resultList.secretYn eq 'Y'}">
                                    	${resultList.ansCn}
                                    	</c:if>
                                    	<c:if test="${resultList.secretYn eq 'N'}">
                                    	${resultList.ansCn}
                                    	</c:if>
                                    </div>
                                    <button type="button" class="btn btn-fold">펼쳐보기</button>
										</c:when>
										<c:otherwise>
											<c:if test="${resultList.regUniqueId ne _mbrSession.uniqueId && resultList.secretYn eq 'Y'}">
												비밀글입니다.
											</c:if>
											<c:if test="${resultList.regUniqueId eq _mbrSession.uniqueId && resultList.secretYn eq 'Y'}">
											${resultList.ansCn}
											</c:if>
											<c:if test="${resultList.secretYn eq 'N' }">
											${resultList.ansCn}
											</c:if>
										</c:otherwise>
									</c:choose>
                                </div>
                                </c:if>
								<c:if test="${_mberSession.uniqueId eq resultList.regUniqueId}">
                                <div class="mt-2.5 text-right">
                                    <button type="button" class="btn btn-primary h-9 md:h-10 f_qa_modify" data-qa-no="${resultList.qaNo}">수정</button>
                                    <button type="button" class="btn btn-outline-primary h-9 md:h-10 f_qa_del" data-qa-no="${resultList.qaNo}">삭제</button>
                                </div>
                                </c:if>
                            </div>
                            </c:forEach>
                        </div>
                        </c:if>
                        <c:if test="${empty listVO.listObject}">
                        <div class="mt-2.5">
		                    <p class="box-result">등록된 상품 문의가 없습니다.</p>
		                </div>
		                </c:if>
                        <div class="pagination">
                            <front:jsPaging listVO="${listVO}" targetObject="qa-pager" />
                        </div>

                        <script>
                        $(function(){
                        	//상품 상세 문의 펼쳐보기
                            $('.product-qnaitem .answer .btn').on('click', function() {
                                $(this).closest('.product-qnaitem').toggleClass('is-active');
                            });
                        });
                        </script>