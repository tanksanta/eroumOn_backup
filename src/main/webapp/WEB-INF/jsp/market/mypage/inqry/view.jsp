<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<main id="container">
	<jsp:include page="../../layout/page_header.jsp">
		<jsp:param value="1:1 문의" name="pageTitle" />
	</jsp:include>

	<div id="page-container">

	<jsp:include page="../../layout/page_sidenav.jsp" />

		<div id="page-content">
	        <div class="items-center justify-between md:flex">
	            <div class="space-y-1.5 md:mr-3">
					<p class="text-alert">문의하신 내용과 답변내용 확인하실 수 있습니다.</p>
					<p class="text-alert">질문 내용에 만족 하실 만한 답변 작성을 위해서 시간 소요가 될 수 있는 점 양해 부탁드립니다.</p>
					<p class="text-alert">답변 완료된 문의는 수정, 삭제 하실 수 없습니다.</p>
	            </div>
	            <div class="ml-auto my-3 w-46 md:w-53">
	                <a href="${_marketPath}/mypage/inqry/form" class="btn btn-large btn-primary w-full">1:1 문의하기</a>
	            </div>
	        </div>

            <p class="mt-14 text-title2 font-bold md:mt-17">문의내용</p>
            <div class="mypage-inquiry is-inquiry mt-2.5 md:mt-3">
                <div class="inquiry-content">
                    <div class="content-header">
                        <dl>
                            <dt>문의유형</dt>
                            <dd class="font-bold">${inqryTyCode[inqryVO.inqryTy]} &gt; ${inqryDtlTyCode[inqryVO.inqryDtlTy]}</dd>
                        </dl>
                        <dl>
                            <dt>답변알림</dt>
                            <dd>
								<c:if test="${inqryVO.smsAnsYn eq 'Y'}">${inqryVO.mblTelno} <i>|</i> </c:if>
								<c:if test="${inqryVO.smsAnsYn eq 'N'}">없음 <i>|</i> </c:if>
								<c:if test="${inqryVO.emlAnsYn eq 'Y' }">${inqryVO.eml}</c:if>
								<c:if test="${inqryVO.emlAnsYn eq 'N'}">없음</c:if>
							</dd>
                        </dl>
                        <c:if test="${inqryVO.ordrCd ne null && inqryVO.ordrCd ne ''}">
	                        <dl>
	                            <dt>주문번호</dt>
	                            <dd><u>${inqryVO.ordrCd}</u></dd>
	                        </dl>
                        </c:if>
                    </div>
                    <div class="content-body">
                        <div class="title">
                            <strong>${inqryVO.ttl}</strong>
                            <small><fmt:formatDate value="${inqryVO.regDt}" pattern="yyyy-MM-dd" /></small>
                        </div>
                        <div class="content">${inqryVO.cn}</div>
                        <dl class="files">
                            <dt>첨부파일</dt>
                            <dd>
							<c:forEach var="fileList" items="${inqryVO.fileList}">
								<a href="/comm/getFile?srvcId=INQRY&amp;upNo=${fileList.upNo}&amp;fileTy=${fileList.fileTy}&amp;fileNo=${fileList.fileNo}">${fileList.orgnlFileNm}</a>
							</c:forEach>
                            </dd>
                        </dl>
						<c:if test="${inqryVO.ansYn eq 'N'}">
						<div class="text-right">
								<a href="${_marketPath}/mypage/inqry/form?inqryNo=${inqryVO.inqryNo}" class="btn btn-primary btn-small">수정</a>
								<button type="button" class="btn btn-outline-primary btn-small">삭제</button>
							</div>
						</c:if>
                    </div>
                </div>
            </div>

			<p class="mt-14 text-title2 font-bold md:mt-17">답변내용</p>
            <div class="mypage-inquiry is-answer mt-2.5 md:mt-3">
                <div class="inquiry-content">
                    <div class="content-header">
                        <dl>
                            <dt>답변상태</dt>
                            <dd class="font-bold">${inqryVO.ansYn eq 'Y'?'답변완료':'미답변'}</dd>
                        </dl>
                        <dl>
                            <dt>답변일시</dt>
                            <dd>
								<c:if test="${inqryVO.ansDt ne null}">
									<fmt:formatDate value="${inqryVO.ansDt}" pattern="yyyy-MM-dd" />
								</c:if>
							</dd>
                        </dl>
                    </div>
                    <div class="content-body">
                        <div class="content">
							<c:if test="${inqryVO.ansYn eq 'N' }">답변이 아직 등록되지 않았습니다.</c:if>
							<c:if test="${inqryVO.ansYn eq 'Y'}">${inqryVO.ansCn}</c:if>
                        </div>
                    </div>
                </div>
            </div>

            <p class="mt-14 text-center md:mt-17">
				<a href="${_marketPath}/mypage/inqry/list" class="btn btn-large">목록으로</a>
			</p>
		</div>
	</div>
</main>