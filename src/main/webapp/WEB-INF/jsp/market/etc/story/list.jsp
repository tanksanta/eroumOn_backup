<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<main id="container">
		<jsp:include page="../../layout/page_header.jsp" >
			<jsp:param value="이로움 테마전시" name="pageTitle"/>
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
						이야기가 있는 <br> 이로움 테마 마켓
					</p>
				</div>

				<c:if test="${empty listVO.listObject}"><div class="mt-8 mb-10 md:mt-18 md:mb-20 box-result is-large">등록된 스토리가 없습니다</div></c:if>
				<c:if test="${!empty listVO.listObject}">
				<div class="mt-8 mb-10 space-y-11 md:mt-18 md:mb-20 md:space-y-15">
					<c:forEach var="resultList" items="${listVO.listObject}" varStatus="status">
					<c:set var="pageParam" value="themeDspyNo=${resultList.themeDspyNo}&amp;curPage=${listVO.curPage}&amp;cntPerPage=${param.cntPerPage}" />
						<a href="./view?${pageParam}" class="story-item">
							<p class="thumb">
								<c:forEach var="fileList" items="${resultList.fileList}" varStatus="status">
									<img src="/comm/getImage?srvcId=${fileList.srvcId}&amp;upNo=${fileList.upNo}&amp;fileTy=${fileList.fileTy }&amp;fileNo=${fileList.fileNo }" style="height:300px;"/>
								</c:forEach>
							</p>
							<div class="content">
								<div class="text">
									<strong>${resultList.themeDspyNm}</strong>
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