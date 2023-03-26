<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=0">
    <meta http-equiv="x-ua-compatible" content="ie=edge">
    <c:set var="naverSiteVerification"><spring:eval expression="@props['Naver.Site.Verification']"/></c:set>
    <c:if test="${!empty naverSiteVerification}">
	<meta name="naver-site-verification" content="${naverSiteVerification}" />
	</c:if>

    <title>이로움 마켓</title>

    <link id="favicon" rel="shortcut icon" href="/html/core/images/favicon.ico" sizes="16x16">
    
    <!-- plugin -->
    <link rel="stylesheet" href="/html/core/vendor/swiperjs/swiper-bundle.css">
    <script src="/html/core/vendor/jquery/jquery-3.6.0.min.js"></script>
    <script src="/html/core/vendor/jquery.validate/jquery.validate.min.js"></script>
    <script src="/html/core/vendor/swiperjs/swiper-bundle.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery-cookie/1.4.1/jquery.cookie.min.js"></script>

    <!-- market -->
    <link rel="stylesheet" href="/html/page/market/assets/style/style.min.css?v=<spring:eval expression="@version['assets.version']"/>">
    <script src="/html/page/market/assets/script/common.js?v=<spring:eval expression="@version['assets.version']"/>"></script>
    <c:if test="${fn:indexOf(_curPath, '/gds/') > -1}">
    <script src="/html/page/market/assets/script/product.js?v=<spring:eval expression="@version['assets.version']"/>"></script>
    </c:if>
    <c:if test="${fn:indexOf(_curPath, '/ordr/') > -1}">
    <script src="/html/page/market/assets/script/order.js?v=<spring:eval expression="@version['assets.version']"/>"></script>
    <script src="https://js.bootpay.co.kr/bootpay-4.2.5.min.js" type="application/javascript"></script>
    </c:if>
    <c:if test="${fn:indexOf(_curPath, '/mbr/registStep1') > -1 || fn:indexOf(_curPath, '/info/srchPswd') > -1}">
    <script src="https://js.bootpay.co.kr/bootpay-4.2.5.min.js" type="application/javascript"></script>
    </c:if>
</head>
<body>
    <!-- access -->
    <ul id="skip-navigation">
        <li><a href="#container">본문 바로가기</a></li>
    </ul>
    <!-- //access -->

	<!-- header -->
    <tiles:insertAttribute name="header"/>
    <!-- //header -->

    <!-- navigation -->
    <tiles:insertAttribute name="navigation"/>
    <!-- //navigation -->

    <!-- aside -->
    <tiles:insertAttribute name="aside"/>
    <!-- //aside -->

    <!-- container -->
	<tiles:insertAttribute name="content"/>
    <!-- //container -->

    <!-- footer -->
    <tiles:insertAttribute name="footer"/>
    <!-- //footer -->

    <!-- popup -->
    <c:if test="${fn:indexOf(_curPath, '/market') > -1 && fn:indexOf(_curPath, '/market/') < 0}">
	    <tiles:insertAttribute name="popup"/>
	    <!--<tiles:insertAttribute name="newWindow"/>-->
    </c:if>
    <!-- //popup -->




    <script src="/html/core/vendor/twelements/index.min.js"></script>
    <script src="/html/core/vendor/twelements/popper.min.js"></script>

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
