<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<main id="container" class="is-mypage">
	<jsp:include page="../../layout/page_header.jsp">
		<jsp:param value="내가 참여한 이벤트" name="pageTitle" />
	</jsp:include>

	<div id="page-container">

		<jsp:include page="../../layout/page_sidenav.jsp" />

		<div id="page-content">
			<jsp:include page="../../layout/mobile_userinfo.jsp" />

	        <div class="items-center justify-between md:flex">
	            <div class="space-y-1.5">
					<p class="text-alert">최근 ${srchLastMonthParam}개월간 참여한 이벤트 리스트입니다.</p>
	            </div>
	        </div>

			<p class="text-title2 mt-6 md:mt-7.5">나의 참여 이벤트 <strong class="text-red3">${listVO.totalCount}</strong>건</p>

            <div class="overflow-hidden mt-3.5 md:mt-4.5 space-y-5.5 md:space-y-7.5">
			<c:set var="getNow" value="<%=new java.util.Date()%>" />
			<c:forEach var="resultList" items="${listVO.listObject}" varStatus="status">
	            <div class="mypage-myinfo-event-item">
	                <div class="item-thumb">
					<c:forEach var="fileList" items="${resultList.fileList}" varStatus="status">
						<img src="/comm/getImage?srvcId=${fileList.srvcId}&amp;upNo=${fileList.upNo}&amp;fileTy=${fileList.fileTy }&amp;fileNo=${fileList.fileNo }" />
					</c:forEach>
	                </div>
                    <div class="item-content">
                        <span class="label-outline-primary">
							<c:if test="${resultList.bgngDt < getNow && getNow < resultList.endDt}"><span>진행중</span></c:if>
							<c:if test="${getNow > resultList.endDt}"><span>종료</span></c:if>
							<i></i>
                        </span>
                        <p class="name"><a href="${_marketPath}/etc/event/view?eventNo=${resultList.eventNo}" target="_blank">${resultList.eventNm}</a></p>
                        <p class="date"><fmt:formatDate value="${resultList.bgngDt}" pattern="yyyy-MM-dd" /> ~ <fmt:formatDate value="${resultList.endDt}" pattern="yyyy-MM-dd" /></p>
                    </div>
                    <div class="item-infomation">
						<dl>
							<dt>응모일</dt>
							<dd><fmt:formatDate value="${resultList.applctDt}" pattern="yyyy-MM-dd HH:mm" /></dd>
						</dl>
						<dl>
							<dt>당첨자 발표</dt>
							<dd><fmt:formatDate value="${resultList.prsntnYmd}" pattern="yyyy-MM-dd HH:mm" /></dd>
						</dl>
						<c:if test="${getNow >= resultList.prsntnYmd && resultList.przwinCount > 0}">
							<div class="item-status">
	                            <a href="${_marketPath}/etc/event/przwin_view?eventNo=${resultList.eventNo}" target="_blank" class="status2">당첨자 보기</a>
	                        </div>
                        </c:if>
                    </div>
	            </div>
			</c:forEach>
			<c:if test="${empty listVO.listObject}">
				<div class="box-result is-large">아직 참여하신 이벤트가 없습니다</div>
			</c:if>
           	</div>
		</div>
	</div>
</main>