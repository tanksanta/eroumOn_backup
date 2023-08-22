<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%-- 검색 --%>

<div class="product-items">
	<c:forEach items="${listVO.listObject}" var="resultList" varStatus="status">
		<c:set var="pageParam" value="curPage=${listVO.curPage}${!empty(listVO.urlParam)? '&amp;' : ''}${listVO.urlParam}" />

		<a href="${_marketPath}/gds/${resultList.ctgryNo}/${resultList.gdsCd}" class="product-item">
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
			<div class="content">
				<div class="label">
					<c:if test="${!empty resultList.gdsTagVal}">
						<span class="${resultList.gdsTagVal eq 'A'?'label-outline-danger':'label-outline-primary' }"> <span>${gdsTagCode[resultList.gdsTagVal]}</span><i></i>
						</span>
					</c:if>
					<c:if test="${empty resultList.gdsTagVal}">
						<span></span>
					</c:if>
				</div>
				<div class="name">
					<small>${resultList.ctgryNm}</small> <strong>${resultList.gdsNm}</strong>
				</div>
				<div class="cost">
					<dl <c:if test="${resultList.dscntRt > 0 && _mbrSession.recipterYn eq 'N'}"> style="color : rgb(153 153 153/var(--tw-text-opacity));"</c:if>>
						<dt>판매가</dt>
						<dd <c:if test="${resultList.dscntRt > 0}">style="text-decoration : line-through;"</c:if>>
							<fmt:formatNumber value="${resultList.pc}" pattern="###,###" />
							<small>원</small>
						</dd>
					</dl>
					<c:if test="${resultList.dscntRt > 0}">
						<dl>
							<dt>할인가</dt>
							<dd>
								<fmt:formatNumber value="${resultList.dscntPc}" pattern="###,###" />
								<small>원</small>
							</dd>
						</dl>
					</c:if>
					<%--
					<c:choose>
						<c:when test="${(resultList.gdsTy eq 'R' || resultList.gdsTy eq 'L') && _mbrSession.prtcrRecipterYn eq 'Y'}">
							<dl class="discount">
								<dt>${resultList.gdsTy eq 'R'?'본인부담금':'대여가(월)'}</dt>
								<dd>
									<c:choose>
										<c:when test="${_mbrSession.prtcrRecipterInfo.selfBndRt == 15 }">
											<fmt:formatNumber value="${resultList.bnefPc15}" pattern="###,###" />
											<small>원</small>
										</c:when>
										<c:when test="${_mbrSession.prtcrRecipterInfo.selfBndRt == 9 }">
											<fmt:formatNumber value="${resultList.bnefPc9}" pattern="###,###" />
											<small>원</small>
										</c:when>
										<c:when test="${_mbrSession.prtcrRecipterInfo.selfBndRt == 6 }">
											<fmt:formatNumber value="${resultList.bnefPc6}" pattern="###,###" />
											<small>원</small>
										</c:when>
										<c:when test="${_mbrSession.prtcrRecipterInfo.selfBndRt == 0 }">
                                    	0<small>원</small>
										</c:when>
									</c:choose>
								</dd>
							</dl>
						</c:when>
					</c:choose>
					 --%>
				</div>
			</div>
		</a>
	</c:forEach>
	<c:if test="${empty listVO.listObject}">
		<p class="box-result is-large" style="grid-column: 1/-1;">상품 검색 결과가 없습니다.</p>
	</c:if>

</div>
<div class="pagination">
	<front:jsPaging listVO="${listVO}" targetObject="gds-pager" />
</div>

