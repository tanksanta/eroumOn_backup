<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%--멤버스메세지--%>

        <!-- 멤버스 반려 -->
        <div class="modal fade" id="partners-msg" tabindex="-1" aria-hidden="true">
            <div class="modal-dialog modal-dialog-centered">
                <div class="modal-content">
                    <div class="modal-header">
                        <p class="text-title">승인반려 사유</p>
                    </div>
                    <div class="modal-close">
                        <button type="button" data-bs-dismiss="modal">모달 닫기</button>
                    </div>
                    <div class="modal-body">
                        <div class="order-reason">
                            <div class="result">
                                <p class="title"> 반려된 상품은 주문취소를 진행해주세요.</p>
                                <dl>
                                    <dt>처리일시</dt>
                                    <dd class="font-serif font-bold"><fmt:formatDate value="${ordrChgHistVO.regDt}" pattern="yyyy.MM.dd HH:mm:ss" /></dd>
                                </dl>
                                <dl>
                                    <dt>사유</dt>
                                    <dd>
                                        ${ordrChgHistVO.resn}
                                    </dd>
                                </dl>
                            </div>
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-primary btn-submit" data-bs-dismiss="modal">확인</button>
                    </div>
                </div>
            </div>
        </div>
        <!-- //멤버스 반려 -->
