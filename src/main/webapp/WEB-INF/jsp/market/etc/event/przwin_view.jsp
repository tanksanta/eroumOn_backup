<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<main id="container">
	<jsp:include page="../../layout/page_header.jsp" >
		<jsp:param value="이로움 이벤트" name="pageTitle"/>
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
					즐거움이 함께하는 <br> 이로움 이벤트
				</p>
			</div>

<%-- 당첨자 확인 --%>
<div class="board-detail is-event mt-5 md:mt-10">
<c:set var="pageParam" value="curPage=${param.curPage}&amp;sortVal=${param.sortVal}" />
	<div class="detail-header">
		<div class="name">
			<strong>${eventVO.eventNm}</strong> <small><fmt:formatDate value="${eventVO.regDt}" pattern="yyyy-MM-dd" /></small>
		</div>
	</div>

	<div class="detail-body">${eventVO.eventPrzwinVO.cn}</div>

	<c:if test="${eventVO.eventPrzwinVO.fileList.size() ne 0}">
		<dl class="detail-file">
			<dt>첨부파일</dt>
			<dd>
				<c:forEach var="fileList" items="${eventVO.eventPrzwinVO.fileList}">
					<a href="/comm/getFile?srvcId=EVENT_PRZWIN&amp;upNo=${fileList.upNo}&amp;fileTy=${fileList.fileTy}&amp;fileNo=${fileList.fileNo}">${fileList.orgnlFileNm}</a>
				</c:forEach>
			</dd>
		</dl>
	</c:if>

	<a href="./list?${pageParam}" class="detail-golist">목록으로</a>
</div>

</div>
</div>
</main>