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

	<!-- open graph -->
    <meta property="og:url" content="https://eroum.co.kr${_curPath}" >
    <meta property="og:type" content="website" >
    <meta property="og:image" content="https://eroum.co.kr/html/page/market/assets/images/og_img.png" >
    <meta property="og:title" content="이로움ON MARKET" >
    <meta property="og:description" content="이로움ON MARKET" >

    <title>이로움ON 마켓</title>

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

<%-- 기본 채널톡
	<script>
	  (function(){var w=window;if(w.ChannelIO){return w.console.error("ChannelIO script included twice.")}var ch=function(){ch.c(arguments)};ch.q=[];ch.c=function(args){ch.q.push(args)};w.ChannelIO=ch;function l(){if(w.ChannelIOInitialized){return}w.ChannelIOInitialized=true;var s=document.createElement("script");s.type="text/javascript";s.async=true;s.src="https://cdn.channel.io/plugin/ch-plugin-web.js";var x=document.getElementsByTagName("script")[0];if(x.parentNode){x.parentNode.insertBefore(s,x)}}if(document.readyState==="complete"){l()}else{w.addEventListener("DOMContentLoaded",l);w.addEventListener("load",l)}})();

	  ChannelIO('boot', {
	    "pluginKey": "8f96ca15-d09d-4434-b2fb-ace28cdfbfdb"
	  });
	</script>
 --%>
	<c:if test="${_activeMode ne 'REAL'}">
	<script>
	  (function(){var w=window;if(w.ChannelIO){return w.console.error("ChannelIO script included twice.")}var ch=function(){ch.c(arguments)};ch.q=[];ch.c=function(args){ch.q.push(args)};w.ChannelIO=ch;function l(){if(w.ChannelIOInitialized){return}w.ChannelIOInitialized=true;var s=document.createElement("script");s.type="text/javascript";s.async=true;s.src="https://cdn.channel.io/plugin/ch-plugin-web.js";var x=document.getElementsByTagName("script")[0];if(x.parentNode){x.parentNode.insertBefore(s,x)}}if(document.readyState==="complete"){l()}else{w.addEventListener("DOMContentLoaded",l);w.addEventListener("load",l)}})();

	  ChannelIO('boot', {
	    "pluginKey": "8f96ca15-d09d-4434-b2fb-ace28cdfbfdb"
	    , "mobileMessengerMode": "newTab"
		, "customLauncherSelector": ".channelTalk"
		, "hideChannelButtonOnBoot": true
	    <c:if test="${!empty _mbrIdHash}">
	    , "memberHash": "${_mbrIdHash}"
	    , "profile": {
	      	"name": "${_mbrSession.mbrNm}"
	      , "mobileNumber": "${_mbrSession.mblTelno}"
	      , "email": "${_mbrSession.eml}"
	    }
	    </c:if>
	  });
	</script>
	</c:if>
	<script>
	$(document).ready(function() {

    	$('.deleteKwd').on('click', function(){
    		const cookiedata = document.cookie.split('; ').find(row => row.startsWith('keywords')).split('=')[1];
    		const delKwd = encodeURIComponent($(this).parent().find('a:eq(0)').text());
    		document.cookie = "keywords=" + cookiedata.replace('__'+delKwd, '') + "; path=/";
    		$(this).parent().remove();
    	});
    });

	</script>

</body>
</html>
