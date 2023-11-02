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

		<!-- open graph -->
	    <meta property="og:url" content="https://eroum.co.kr${_curPath}" >
	    <meta property="og:type" content="website" >
	    <meta property="og:image" content="https://eroum.co.kr/html/page/market/assets/images/og_img.png" >
	    <meta property="og:title" content="이로움ON 멤버스" >
	    <meta property="og:description" content="이로움ON 멤버스" >

    	<link id="favicon" rel="shortcut icon" href="/html/core/images/favicon.ico" sizes="16x16">

        <title>이로움ON 멤버스</title>

        <!-- Google tag (gtag.js) -->
		<c:set var="googleAnalyticsId"><spring:eval expression="@props['Google.Analytics.Id']"/></c:set>
		<c:set var="googleAnalyticsGTM"><spring:eval expression="@props['Google.Analytics.GTM']"/></c:set>
		
		<script async src="https://www.googletagmanager.com/gtag/js?id=${googleAnalyticsId}"></script>
		<script>
			window.dataLayer = window.dataLayer || [];
			function gtag(){dataLayer.push(arguments);}
			gtag('js', new Date());
			gtag('config', '${googleAnalyticsId}');
		</script>
		<!-- Google Tag Manager -->
		<script>(function(w,d,s,l,i){w[l]=w[l]||[];w[l].push({'gtm.start':
		new Date().getTime(),event:'gtm.js'});var f=d.getElementsByTagName(s)[0],
		j=d.createElement(s),dl=l!='dataLayer'?'&l='+l:'';j.async=true;j.src=
		'https://www.googletagmanager.com/gtm.js?id='+i+dl;f.parentNode.insertBefore(j,f);
		})(window,document,'script','dataLayer','${googleAnalyticsGTM}');</script>
		<!-- End Google Tag Manager -->

        <!-- common -->
        <script src="/html/core/vendor/jquery/jquery-3.6.0.min.js"></script>
        <script src="/html/core/vendor/jquery.validate/jquery.validate.min.js"></script>

        <!-- office -->
        <link rel="stylesheet" href="/html/page/office/assets/style/partner.min.css">
        <script src="/html/page/office/assets/script/common.js"></script>
    </head>
    <body>
    	<!-- Google Tag Manager (noscript) -->
		<noscript><iframe src="https://www.googletagmanager.com/ns.html?id=${googleAnalyticsGTM}" height="0" width="0" style="display:none;visibility:hidden"></iframe></noscript>
		<!-- End Google Tag Manager (noscript) -->
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