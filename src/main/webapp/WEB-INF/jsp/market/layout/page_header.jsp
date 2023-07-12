<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%-- <c:if test="${!empty param.pageTitle}">
	<h2 id="page-title">${param.pageTitle}</h2>
</c:if> --%>

<c:choose>
	<%-- 상품 목록 --%>
	<c:when test="${fn:indexOf(_curPath, '/gds/') > -1 && fn:indexOf(_curPath, '/list') > -1 }">
		<div id="page-header">
            <ul class="page-header-breadcrumb">
            	<c:set var="linkUrl" value="" />
            	<c:set var="breadcrumb" value="${curCtgryVO.ctgryPath.split(' > ')}" />
            	<li><a href="${_marketPath}">홈</a></li>
            	<c:forEach items="${breadcrumb}" varStatus="status" begin="1">
            	<%-- 링크 가공 --%>
   				<c:choose>
   					<c:when test="${status.index eq 1 }">
   						<c:set var="linkUrl" value="${_marketPath}/gds/${upCtgryNo}/list"/>
   					</c:when>
   					<c:when test="${status.index eq 2 }">
   						<c:set var="linkUrl" value="${_marketPath}/gds/${upCtgryNo}/${ctgryNo1}/list"/>
   					</c:when>
   					<c:when test="${status.index eq 3 }">
   						<c:set var="linkUrl" value="${_marketPath}/gds/${upCtgryNo}/${ctgryNo1}/${ctgryNo2}/list"/>
   					</c:when>
   					<c:otherwise>
   						<c:set var="linkUrl" value="${_marketPath}/gds/${upCtgryNo}/${ctgryNo1}/${ctgryNo2}/${ctgryNo3}/list" />
   					</c:otherwise>
   				</c:choose>

    			<%-- 링크 가공// --%>
					<li><a href="${linkUrl}">${breadcrumb[status.index]}</a></li>
            	</c:forEach>


			</ul>
			<div class="page-header-title">
				<a href="#" class="back">이전 페이지 가기</a>
				<h2 class="subject">
					<c:forEach var="path" items="${breadcrumb}" varStatus="status">
						<c:if test="${status.last}">
							${breadcrumb[status.index]}
						</c:if>
					</c:forEach>
				</h2>
			</div>
			<button type="button" class="page-sidenav-toggle">사이드메뉴 레이어 열기/닫기</button>
		</div>
	</c:when>

	<%-- 상품 상세 --%>
	<c:when test="${fn:indexOf(_curPath, '/gds/') > -1 && !empty gdsVO}">
		<div id="page-header">
            <ul class="page-header-breadcrumb">
            	<c:set var="linkUrl" value="" />
            	<c:set var="breadcrumb" value="${gdsVO.gdsCtgryPath.split(' > ')}" />
            	<c:set var="ctgryNoPath" value="${noPath.split(' > ')}" />
            	<li><a href="${_marketPath}">홈</a></li>
            	<c:forEach items="${breadcrumb}" varStatus="status" begin="1">
            	<%-- 링크 가공 --%>
   				<c:choose>
   					<c:when test="${status.index eq 1 }">
   						<c:set var="linkUrl" value="${_marketPath}/gds/${ctgryNoPath[1]}/list"/>
   					</c:when>
   					<c:when test="${status.index eq 2 }">
   						<c:set var="linkUrl" value="${_marketPath}/gds/${ctgryNoPath[1]}/${ctgryNoPath[2]}/list"/>
   					</c:when>
   					<c:when test="${status.index eq 3 }">
   						<c:set var="linkUrl" value="${_marketPath}/gds/${ctgryNoPath[1]}/${ctgryNoPath[2]}/${ctgryNoPath[3]}/list"/>
   					</c:when>
   					<c:otherwise>
   						<c:set var="linkUrl" value="${_marketPath}/gds/${ctgryNoPath[1]}/${ctgryNoPath[2]}/${ctgryNoPath[3]}/${ctgryNoPath[4]}/list" />
   					</c:otherwise>
   				</c:choose>

    			<%-- 링크 가공// --%>
					<li><a href="${linkUrl}">${breadcrumb[status.index]}</a></li>
            	</c:forEach>


			</ul>
			<div class="page-header-title">
				<a href="#" class="back">이전 페이지 가기</a>
				<h2 class="subject">
					<c:forEach var="path" items="${breadcrumb}" varStatus="status">
						<c:if test="${status.last}">
							${breadcrumb[status.index]}
						</c:if>
					</c:forEach>
				</h2>
			</div>
			<button type="button" class="page-sidenav-toggle">사이드메뉴 레이어 열기/닫기</button>
		</div>
	</c:when>

	<%-- 고객센터 --%>
	<c:when test="${fn:indexOf(_curPath, '/etc/faq/') > -1 || fn:indexOf(_curPath, '/etc/inqry/') > -1 || fn:indexOf(_curPath, '/etc/ntce/') > -1 || fn:indexOf(_curPath, '/etc/bnft/') > -1}">
		<div id="page-header"></div>
	</c:when>
</c:choose>


