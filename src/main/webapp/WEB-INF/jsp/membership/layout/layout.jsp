<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="x-ua-compatible" content="ie=edge">
    <c:set var="naverSiteVerification"><spring:eval expression="@props['Naver.Site.Verification']"/></c:set>
    <c:if test="${!empty naverSiteVerification}">
	<meta name="naver-site-verification" content="${naverSiteVerification}" />
	</c:if>

    <title>통합회원</title>

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


    <link id="favicon" rel="shortcut icon" href="/html/core/images/favicon.ico" sizes="16x16">

    <!-- plugin -->
    <link rel="stylesheet" href="/html/core/vendor/swiperjs/swiper-bundle.css">

    <script src="/html/core/vendor/jquery/jquery-3.6.0.min.js"></script>
    <script src="/html/core/vendor/jquery.validate/jquery.validate.min.js"></script>
    <script src="/html/core/vendor/swiperjs/swiper-bundle.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery-cookie/1.4.1/jquery.cookie.min.js"></script>

    <link rel="stylesheet" href="/html/page/members/assets/style/style.min.css">
    <script src="/html/page/members/assets/script/common.js"></script>
    <script src="/html/core/script/hangjungdong.js"></script>
    <script src="/html/core/script/JsCallApi.js"></script>
    <script src="https://js.bootpay.co.kr/bootpay-4.2.5.min.js" type="application/javascript"></script>
<!--     <c:if test="${fn:indexOf(_curPath, '/membership/regist') > -1 || fn:indexOf(_curPath, '/membership/srchPswd') > -1}"> -->
<!--    </c:if>-->

	<!-- 네이버 연관채널 SEO -->
    <span itemscope="" itemtype="http://schema.org/Organization">
	<link itemprop="url" href="https://eroum.co.kr">
	<a itemprop="sameAs" href="https://play.google.com/store/apps/details?id=kr.co.eroum"></a>
	</span>
</head>
<body>
	<!-- Google Tag Manager (noscript) -->
    <noscript><iframe src="https://www.googletagmanager.com/ns.html?id=${googleAnalyticsGTM}" height="0" width="0" style="display:none;visibility:hidden"></iframe></noscript>
    <!-- End Google Tag Manager (noscript) -->

	<tiles:insertAttribute name="header"/>

	<tiles:insertAttribute name="content"/>
	
	<div class="modal2-con">
	</div>
	
    <tiles:insertAttribute name="footer"/>

</body>

    <script src="/html/core/vendor/twelements/index.min.js"></script>
    <script src="/html/core/vendor/twelements/popper.min.js"></script>

    <c:set var="naverAnalytics"><spring:eval expression="@props['Naver.Analytics']"/></c:set>
<!-- 	<c:if test="${!empty naverAnalytics}"> -->
       <script type="text/javascript" src="//wcs.naver.net/wcslog.js"></script>
	<script type="text/javascript">
	if(!wcs_add) var wcs_add = {};
	wcs_add["wa"] = "${naverAnalytics}";
	if(window.wcs) {
		wcs_do();
	}
	</script>
<!-- 	</c:if> -->


	<!-- 채널톡 연동처리 -->
	<jsp:include page="/WEB-INF/jsp/common/channel_talk.jsp" />
	
    <!-- GA 이벤트 -->
	<jsp:include page="/WEB-INF/jsp/common/ga4_event.jsp" />

</html>