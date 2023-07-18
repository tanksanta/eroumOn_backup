<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="x-ua-compatible" content="ie=edge">

    <title>dashboard</title>

    <link id="favicon" rel="shortcut icon" href="/html/core/images/favicon.ico" sizes="16x16">

    <!-- plugin -->
    <link rel="stylesheet" href="/html/core/vendor/jstree/dist/themes/default/style.min.css">
    <link rel="stylesheet" href="/html/core/vendor/jquery/jquery-ui.min.css">

    <script src="/html/core/vendor/jquery/jquery-3.6.0.min.js"></script>
    <script src="/html/core/vendor/jquery/jquery-ui.min.js"></script>
    <script src="/html/core/vendor/jquery.validate/jquery.validate.min.js"></script>

	<!-- common -->
    <script src="/html/core/script/utility.js"></script>

    <!-- admin -->
    <link rel="stylesheet" href="/html/page/admin/assets/style/style.min.css">
    <script src="/html/page/admin/assets/script/common.js"></script>
</head>
<body style="background-color:#111">
    <div class="introduce-wrapper">
        <div class="market-title">eroum market</div>

        <div class="dashboard-account">
            <a href="/_mng/logout" class="btn-logout">로그아웃</a>
        </div>

        <div class="system-title">
            Management System
            <div class="user-info">
                <span class="thum"><c:if test="${_mngrSession.proflImg ne null && _mngrSession.proflImg ne '' }"><img src="/comm/proflImg?fileName=${_mngrSession.proflImg}" alt="manager"></c:if></span>
                <span class="name">
                    <strong>${_mngrSession.mngrId}</strong>
                    <small>마지막 접속 <fmt:formatDate value="${_mngrSession.recentLgnDt }" pattern="yyyy-MM-dd HH:mm:ss" /></small>
                </span>
            </div>
        </div>

		<%-- DB로 관리 --%>
        <ul class="dashboard-items my-auto">
        <%--
       	<c:forEach items="${_mngMenuList }" var="mngMenu" varStatus="status">
        	<c:if test="${mngMenu.levelNo eq '2'}">
            <li><a href="${mngMenu.menuUrl}" class="dashboard-${mngMenu.icon}">${mngMenu.menuNm}</a></li>
            </c:if>
        </c:forEach>
        --%>

            <li><a href="/_mng/dashboard" class="dashboard-item1">대시보드</a></li>
            <li><a href="/_mng/mbr/list" class="dashboard-item2">회원관리</a></li>
            <li><a href="/_mng/gds/gds/list" class="dashboard-item3">상품관리</a></li>
            <li><a href="/_mng/ordr/all/list" class="dashboard-item4">주문관리</a></li>
            <li><a href="/_mng/exhibit/banner/list" class="dashboard-item5">전시관리</a></li>
            <li><a href="/_mng/promotion/dspy/list" class="dashboard-item11">프로모션관리</a></li>
            <li><a href="/_mng/consult/mbrInqry/list" class="dashboard-item7">고객상담관리</a></li>
            <li><a href="/_mng/sysmng/mngr/list" class="dashboard-item8">시스템관리</a></li>
            <li><a href="/_mng/stats/sales/prfmnc" class="dashboard-item10">통계관리</a></li>
            <li><a href="/_mng/members/bplc/list" class="dashboard-item12">멤버스관리</a></li>
            <li><a href="/_mng/clcln/market/list" class="dashboard-item9">정산관리</a></li>
        </ul>

        <p class="text-copyright">Copyright ⓒEroumMarket All righs reserved.</p>
    </div>

    <script src="/html/core/vendor/twelements/index.min.js"></script>
</body>
</html>