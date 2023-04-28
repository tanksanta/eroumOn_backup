<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%pageContext.setAttribute("newLineChar", "\n");%>
<main id="container">
	<jsp:include page="../../layout/page_header.jsp">
		<jsp:param value="이로움ON 테마전시" name="pageTitle" />
	</jsp:include>

	<div id="page-container">
		<div id="page-content">
			<div class="event-slogan">
				<picture class="name">
				<source srcset="/html/page/market/assets/images/txt-event-eroum-mobile.svg" media="(max-width: 768px)">
				<source srcset="/html/page/market/assets/images/txt-event-eroum.svg">
				<img src="/html/page/market/assets/images/txt-event-eroum.svg" alt="" /> </picture>
				<img src="/html/page/market/assets/images/img-shopbag.png" alt="" class="bags">
				<p class="desc">
					이야기가 있는 <br> 이로움ON 테마 마켓
				</p>
			</div>

			<div class="board-detail is-event mt-8 md:mt-18">
				<div class="detail-header">
					<div class="name">
						<strong>${themeVO.themeDspyNm}</strong><small><fmt:formatDate value="${themeVO.regDt}" pattern="yyyy-MM-dd" /></small>
					</div>
				</div>

				<div class="detail-body">
					<div class="mx-4 mt-11 md:mt-15 md:mx-6">
						<p>${fn:replace(themeVO.cn, newLineChar, "<br/>")}</p>
					</div>
				</div>


				<c:if test="${themeVO.relYn eq 'Y'}">
					<div class="event-title">
						<small>eroum market</small>
						<%--<strong>그대와 함께라서 행복한 거실용품</strong>--%>
					</div>


					<div class="grid grid-cols-2 gap-x-5 gap-y-12 mt-8.5 md:grid-cols-3 md:gap-x-6 md:gap-y-19 md:mt-12">
						<c:forEach var="item" items="${itemList}" varStatus="status">
							<div class="product-item">
								<div class="item-thumb">
									<a href="${_marketPath}/gds/2/${item.themeGdsNo}/${item.gdsCd}" class="item-content"><img src="/comm/getImage?srvcId=GDS&amp;upNo=${item.thumbnailFile.upNo}&amp;fileTy=${item.thumbnailFile.fileTy}&amp;fileNo=${item.thumbnailFile.fileNo}&amp;thumbYn=Y" /></a>
								</div>
								<a href="${_marketPath}/gds/2/${item.themeGdsNo}/${item.gdsCd}" class="item-content">
									<div class="label">
										<span class="label-primary"> <span>급여가</span><i></i></span>
										<span class="label-outline-primary"> <span>직배송</span> <i></i>	</span>
										<span class="label-outline-primary"> <span>설치</span> <i></i> <c:if test="${item.soldoutYn eq 'Y' }"></span>
										<span class="label-outline-danger"> <span>일시품절</span> <i></i>
				</c:if>
				</span>
			</div>
			<div class="name">
				<small>${item.ctgryNm}</small> <strong>${item.gdsNm}</strong>
			</div>
			</a>
		</div>
		</c:forEach>

	</div>
	</c:if>

	<a href="./list?curPage=${param.curPage}" class="detail-golist">목록으로</a>
	</div>
	</div>
	</div>
</main>