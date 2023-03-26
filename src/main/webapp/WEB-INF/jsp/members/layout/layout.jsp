<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="ko">
    <head>
        <meta charset="UTF-8">
		<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=0">
		<c:set var="naverSiteVerification"><spring:eval expression="@props['Naver.Site.Verification']"/></c:set>
	    <c:if test="${!empty naverSiteVerification}">
		<meta name="naver-site-verification" content="${naverSiteVerification}" />
		</c:if>

    	<link id="favicon" rel="shortcut icon" href="/html/core/images/favicon.ico" sizes="16x16">
    	
        <title>이로움 멤버스</title>

        <!-- common -->
        <script src="/html/core/vendor/jquery/jquery-3.6.0.min.js"></script>
        <script src="/html/core/vendor/jquery.validate/jquery.validate.min.js"></script>

        <!-- office -->
        <link rel="stylesheet" href="/html/page/office/assets/style/partner.min.css">
        <script src="/html/page/office/assets/script/common.js"></script>
    </head>
    <body>
        <!-- header -->
		<tiles:insertAttribute name="header"/>
        <!-- //header -->

		<%-- introduce페이지 때문에 <main>부터 content로 처리 --%>
        <!-- container -->
        <tiles:insertAttribute name="content"/>
        <!-- //container -->

        <!-- footer -->
       <tiles:insertAttribute name="footer"/>
        <!-- //footer -->

        <script src="/html/core/vendor/twelements/index.min.js"></script>


        <c:set var="naverAnalytics"><spring:eval expression="@props['Naver.Analytics']"/></c:set>
		<c:if test="${!empty naverAnalytics}">
        <script type="text/javascript" src="//wcs.naver.net/wcslog.js"></script>
		<script type="text/javascript">
		if(!wcs_add) var wcs_add = {};
		wcs_add["wa"] = "${naverAnalytics}";
		if(window.wcs) {
			wcs_do();
		}
		</script>
		</c:if>
    </body>
</html>