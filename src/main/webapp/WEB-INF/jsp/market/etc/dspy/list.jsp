<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<main id="container">
	<jsp:include page="../../layout/page_header.jsp" >
		<jsp:param value="이로움ON 기획전" name="pageTitle"/>
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
					즐거움이 함께하는 <br> 이로움ON 마켓 기획전
				</p>
			</div>

			<c:if test="${empty listVO.listObject}"><div class="mt-8 mb-10 md:mt-18 md:mb-20 box-result is-large">등록된 기획전이 없습니다</div></c:if>
			<c:if test="${!empty listVO.listObject}">
				<div class="grid grid-cols-1 gap-x-5 gap-y-10 mt-8 mb-10 md:mt-18 md:mb-20 md:gap-y-15 md:gap-x-7.5 md:grid-cols-2">
					<c:forEach var="resultList" items="${listVO.listObject}" varStatus="status">
					<c:set var="pageParam" value="planngDspyNo=${resultList.planngDspyNo}&amp;curPage=${listVO.curPage}" />
						<a href="./view?${pageParam}" class="event-item">
							<p class="thumb">
								<c:forEach var="fileList" items="${resultList.fileList}" varStatus="status">
										<img src="/comm/getImage?srvcId=${fileList.srvcId}&amp;upNo=${fileList.upNo}&amp;fileTy=${fileList.fileTy }&amp;fileNo=${fileList.fileNo }" />
								</c:forEach>
							</p>
							<div class="content">
								<div class="text">
									<small>
										<fmt:formatDate value="${resultList.bgngDt}" pattern="yyyy-MM-dd"/>
									 	~
										<fmt:formatDate value="${resultList.endDt}" pattern="yyyy-MM-dd"/>
									 </small>
									<strong>${resultList.planngDspyNm}</strong>
								</div>
							</div>
						</a>
					</c:forEach>
				</div>
			</c:if>

			<div class="pagination">
				<mngr:mngrPaging listVO="${listVO}" />
			</div>
		</div>
	</div>
</main>