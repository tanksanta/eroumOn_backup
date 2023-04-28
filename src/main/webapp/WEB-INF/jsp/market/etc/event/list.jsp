<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<main id="container">
	<jsp:include page="../../layout/page_header.jsp" >
		<jsp:param value="이로움ON 이벤트" name="pageTitle"/>
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
					즐거움이 함께하는 <br> 이로움ON 이벤트
				</p>
			</div>

			<ul class="tabs mt-8 md:mt-18">
				<li><a href="${_marketPath}/etc/event/list?sortVal=all" class="tabs-link all">전체</a></li>
				<li><a href="${_marketPath}/etc/event/list?sortVal=play" class="tabs-link play">진행중</a></li>
				<li><a href="${_marketPath}/etc/event/list?sortVal=exit" class="tabs-link exit">종료</a></li>
				<li><a href="${_marketPath}/etc/event/list?sortVal=finish" class="tabs-link finish">당첨자 확인</a></li>
			</ul>
			<form id="sortFrm" name="sortFrm" method="get" action="./list">
				<input type="hidden" name="sortVal" id="sortVal" value="">
			</form>

			<c:set var="getNow" value="<%=new java.util.Date()%>" />
			<c:if test="${empty listVO.listObject}"><div class="mt-8 mb-10 md:mt-18 md:mb-20 box-result is-large">등록된 이벤트가 없습니다</div></c:if>
			<c:if test="${!empty listVO.listObject}">
			<div class="grid grid-cols-1 gap-x-5 gap-y-10 mt-5 mb-10 md:mt-10 md:mb-20 md:gap-y-15 md:gap-x-7.5 md:grid-cols-2">
				<c:forEach var="resultList" items="${listVO.listObject}" varStatus="status">
				<c:set var="pageParam" value="eventNo=${resultList.eventNo}&amp;curPage=${listVO.curPage}&amp;sortVal=${param.sortVal}" />
					<div class="event-item">
						<a href="./view?${pageParam}">
						<p class="thumb">
							<c:forEach var="fileList" items="${resultList.fileList}" varStatus="status">
								<img src="/comm/getImage?srvcId=${fileList.srvcId}&amp;upNo=${fileList.upNo}&amp;fileTy=${fileList.fileTy }&amp;fileNo=${fileList.fileNo }" />
							</c:forEach>
						</p>
						</a>

						<div class="content">
							<div class="text">
								<c:if test="${param.sortVal ne 'finish'}">
									<small>
										<fmt:formatDate value="${resultList.bgngDt}" pattern="yyyy-MM-dd" /> ~ <fmt:formatDate value="${resultList.endDt}" pattern="yyyy-MM-dd" />
									</small>
								</c:if>

								<strong>${resultList.eventNm}</strong>

								<c:if test="${param.sortVal eq 'finish'}">
									<small>
										당첨자 발표일 :
										<fmt:formatDate value="${resultList.prsntnYmd}" pattern="yyyy-MM-dd" />
									</small>
								</c:if>
							</div>

							<p class="status">
									<c:if test="${resultList.bgngDt < getNow && getNow < resultList.endDt  }" >
										<a href="./view?${pageParam}"><span class="inactive">진행중</span></a>
									</c:if>
									<c:if test="${resultList.prsntnYmd != NULL && getNow >= resultList.prsntnYmd && getNow > resultList.endDt && resultList.przwinCount != 0 && resultList.eventPrzwinVO.dspyYn == 'Y'}">
										<a href="./przwin_view?${pageParam}"><span>당첨자 확인</span></a>
									</c:if>
									<c:if test="${getNow > resultList.endDt}">
										<a href="./view?${pageParam}"><span>종료</span></a>
									</c:if>
									<c:if test="${getNow < resultList.bgngDt}">
										<span class="inactive">준비중</span>
									</c:if>
							</p>
						</div>
						</div>
				</c:forEach>
			</div>
			</c:if>

			<div class="pagination">
				<mngr:mngrPaging listVO="${listVO}" />
			</div>
		</div>
	</div>
</main>

<script>
$(function(){
	//탭 유지
	var param = "${param.sortVal}";

	$("."+param).addClass("active");

});
</script>