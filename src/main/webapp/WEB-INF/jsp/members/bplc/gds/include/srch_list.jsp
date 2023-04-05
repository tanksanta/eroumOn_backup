<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%-- 검색 --%>

<div class="product-items">
	<c:forEach items="${listVO.listObject}" var="resultList" varStatus="status">
		<c:set var="pageParam" value="curPage=${listVO.curPage}${!empty(listVO.urlParam)? '&amp;' : ''}${listVO.urlParam}" />

		<a href="${_marketPath}/gds/${resultList.upCtgryNo}/${resultList.ctgryNo}/${resultList.gdsCd}" class="product-item">
			<div class="thumb">
				<c:choose>
					<c:when test="${!empty resultList.thumbnailFile }">
						<img src="/comm/getImage?srvcId=GDS&amp;upNo=${resultList.thumbnailFile.upNo }&amp;fileTy=${resultList.thumbnailFile.fileTy }&amp;fileNo=${resultList.thumbnailFile.fileNo }&amp;thumbYn=Y" alt="">
					</c:when>
					<%-- <c:otherwise>
							<img src="/html/page/market/assets/images/noimg.jpg" alt="">
								</c:otherwise> --%>
				</c:choose>
			</div>
			<div class="content">
				<div class="name">
					<small>${resultList.ctgryNm}</small> <strong>${resultList.gdsNm}</strong>
				</div>
				<div class="cost">
					<dl>
						<dt>판매가</dt>
						<dd>
							<fmt:formatNumber value="${resultList.pc}" pattern="###,###" />
							<small>원</small>
						</dd>
					</dl>
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

