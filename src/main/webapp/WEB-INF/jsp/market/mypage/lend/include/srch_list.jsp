<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>


			<div class="mt-2.5 space-y-3 md:mt-3 md:space-y-4">
				<c:forEach items="${listVO.listObject}" var="result" varStatus="status">
				<div class="order-history">
					<div class="history-header">
						<p class="name">결제일시</p>
						<p class="date">${result.stlmDt}</p>
					</div>
					<div class="history-content">
						<p class="name">결제수단</p>
						<div class="card">
							<%-- <span class="label-flat">${bassStlmTyCode[ordrVO.stlmTy]}</span> --%>
							<span class="label-flat">카드결제</span>
							<dl>
								<dt>카드승인번호</dt>
								<dd>
									<c:if test="${result.stlmYn eq 'Y'}">
									${result.cardAprvno}
									</c:if>
									<c:if test="${result.stlmYn eq 'N'}">
									-
									</c:if>
								</dd>
							</dl>
							<dl>
								<dt>카드회사</dt>
								<dd>${result.cardCoNm}</dd>
							</dl>
						</div>
						<div class="payment">
							<p class="cost">
								<fmt:formatNumber value="${result.stlmAmt}" pattern="###,###" /><small>원</small>
							</p>
							<p class="time">
								${result.ordrCnt}<small>회차</small>
							</p>
							<c:if test="${result.stlmYn eq 'Y'}">
							<p class="status">결제완료</p>
							</c:if>
							<c:if test="${result.stlmYn eq 'N'}">
							<p class="status text-danger">결제실패</p>
							</c:if>

						</div>
					</div>
				</div>
				</c:forEach>
			</div>
			<div class="pagination">
				<front:jsPaging listVO="${listVO}" targetObject="rebill-pager" />
			</div>