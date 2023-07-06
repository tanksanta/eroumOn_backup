<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<c:if test="${!empty param.pageTitle}">
	<h2 id="page-title">${param.pageTitle}</h2>
</c:if>

<c:choose>
	<%-- 상품 목록 --%>
	<c:when test="${fn:indexOf(_curPath, '/gds/') > -1 && fn:indexOf(_curPath, '/list') > -1}">
		<div id="page-header">
			<!-- <a href="/market" class="page-header-back">이전 페이지 가기</a> -->
            <ul class="page-header-breadcrumb">
				<li>
					<a href="#">${_gdsCtgryListMap[upCtgryNo]}</a>
				</li>
			</ul>

			<h2 class="page-header-name">
				<a href="${_marketPath}/gds/${upCtgryNo}/list">${_gdsCtgryListMap[upCtgryNo]}</a>
			</h2>
			<button type="button" class="page-sidenav-toggle">사이드메뉴 레이어 열기/닫기</button>
		</div>
	</c:when>
	<%-- 상품 상세 --%>
	<c:when test="${fn:indexOf(_curPath, '/gds/') > -1 && !empty gdsVO}">
		<div id="page-header">
			<a href="${_marketPath}/gds/${upCtgryNo}/list" class="page-header-back">이전 페이지 가기</a>
			<ul class="page-header-breadcrumb">
				<li><a href="#">${_gdsCtgryListMap[upCtgryNo]}</a>
					<ul>
						<c:forEach items="${_gdsCtgryList}" var="ctgry">
							<c:if test="${ctgry.upCtgryNo == 1}">
								<%--최상위--%>
								<li><a href="${_marketPath}/gds/${ctgry.ctgryNo}/list">${ctgry.ctgryNm}</a></li>
							</c:if>
						</c:forEach>
					</ul></li>
			</ul>
			<h2 class="page-header-name">${_gdsCtgryListMap[ctgryNo]}</h2>
		</div>
	</c:when>
	<%-- 마이페이지 --%>
	<c:when test="${fn:indexOf(_curPath, '/mypage/') > -1}">
		<c:if test="${fn:indexOf(_curPath, '/cart/') < 0 && fn:indexOf(_curPath, '/wish/') < 0}">
		<div id="page-header">
			<a href="#" onclick="history.back(); return false;" class="page-header-back">이전 페이지 가기</a>
			<a href="${_marketPath}/mypage/index"><h2 class="page-header-name">마이페이지</h2></a>
			<button type="button" class="page-sidenav-toggle">사이드메뉴 레이어 열기/닫기</button>
		</div>
		</c:if>
	</c:when>

	<%-- 고객센터 --%>
	<c:when test="${fn:indexOf(_curPath, '/etc/faq/') > -1 || fn:indexOf(_curPath, '/etc/inqry/') > -1 || fn:indexOf(_curPath, '/etc/ntce/') > -1 || fn:indexOf(_curPath, '/etc/bnft/') > -1}">
		<div id="page-header">
			<a href="#" onclick="history.back(); return false;" class="page-header-back">이전 페이지 가기</a>
			<h2 class="page-header-name">고객센터</h2>
			<button type="button" class="page-sidenav-toggle">사이드메뉴 레이어 열기/닫기</button>
		</div>
	</c:when>
</c:choose>


