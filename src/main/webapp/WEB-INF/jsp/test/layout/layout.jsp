<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>

<html lang="ko">
<head>
	<meta charSet="utf-8" />
	<meta name="theme-color" content="rgba(246, 248, 255, 0.6)" />
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<link rel="apple-touch-icon" href="/html/page/test/assets/images/icon_128.png" />
	<link rel="shortcut icon" href="/html/page/test/assets/images/favicon.ico" />
	<link rel="manifest" href="/html/page/test/assets/manifest.json" />
	<link rel="stylesheet" href="/html/page/test/assets/style/style.min.css">
	<script data-ad-client="ca-pub-9521817924224887" async src="https://pagead2.googlesyndication.com/pagead/js/adsbygoogle.js"></script>
	
	<!-- plugin -->
    <script src="/html/core/vendor/jquery/jquery-3.6.0.min.js"></script>
	
	<script src="/html/page/test/assets/script/common.js?v=<spring:eval expression="@version['assets.version']"/>"></script>
	
    <!-- Google tag (gtag.js) -->
    <script async src="https://www.googletagmanager.com/gtag/js?id=G-KBLJXQCQZT"></script>
    <script>
        window.dataLayer = window.dataLayer || [];
        function gtag(){dataLayer.push(arguments);}
        gtag('js', new Date());
        gtag('config', 'G-KBLJXQCQZT');
    </script>
    <!-- Google Tag Manager -->
    <script>(function(w,d,s,l,i){w[l]=w[l]||[];w[l].push({'gtm.start':
    new Date().getTime(),event:'gtm.js'});var f=d.getElementsByTagName(s)[0],
    j=d.createElement(s),dl=l!='dataLayer'?'&l='+l:'';j.async=true;j.src=
    'https://www.googletagmanager.com/gtm.js?id='+i+dl;f.parentNode.insertBefore(j,f);
    })(window,document,'script','dataLayer','GTM-TNTQ4GXN');</script>
    <!-- End Google Tag Manager -->
    
    <c:set var="naverSiteVerification"><spring:eval expression="@props['Naver.Site.Verification']"/></c:set>
    <c:if test="${!empty naverSiteVerification}">
	<meta name="naver-site-verification" content="${naverSiteVerification}" />
	</c:if>
</head>
<body class="bg-main">
	<!-- Google Tag Manager (noscript) -->
    <noscript><iframe src="https://www.googletagmanager.com/ns.html?id=GTM-TNTQ4GXN" height="0" width="0" style="display:none;visibility:hidden"></iframe></noscript>
    <!-- End Google Tag Manager (noscript) -->

	<tiles:insertAttribute name="content"/>
	
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