<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

			<!-- page header -->
            <header id="page-header">
                <h1 class="text-title1">${_mngMenuVO.menuNm}</h1>
                <nav class="breadcrumb">
                    <ul>
						<c:forEach items="${fn:split(_mngMenuVO.menuNmPath, '/')}" var="menuNmPath" begin="1" varStatus="status">
                        <c:if test="${!status.last}">
                        <li>${menuNmPath}</li><%--상위메뉴에 링크가 없음 --%>
                        </c:if>
                        <c:if test="${status.last}">
                        <li><strong>${menuNmPath}</strong></li>
                        </c:if>
                        </c:forEach>
                    </ul>
                </nav>
                <a href="#" class="user-info">
                    <span class="name">
                        <strong>${_mngrSession.mngrId}</strong>
                        <small>접속중 <span>-</span></small>
                    </span>
                    <span class="thum">
                    	<c:if test="${!empty _mngrSession.proflImg }">
                    	<img src="/comm/proflImg?fileName=${_mngrSession.proflImg}" alt="${_mngrSession.mngrNm }">
                    	</c:if>
                    </span>
                </a>
                <a href="/_mng/logout" class="btn-logout">Logout</a>
            </header>
			<c:if test="${fn:indexOf(_curPath, 'banner/list') > -1}">
				<p>※ 메인 화면의 띠 배너와 메인 배너를 설정하는 페이지 입니다.</p>
			</c:if>
			<c:if test="${fn:indexOf(_curPath, 'usermenu/form') > -1}">
				<p>※ 메인 화면의 상단 메뉴를 설정하는 페이지입니다. 카테고리는 카테고리 관리에서 설정 할 수 있습니다.</p>
			</c:if>
			<!-- //page header -->