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

    <link id="favicon" rel="shortcut icon" href="/html/core/images/favicon.ico" sizes="16x16">

    <!-- plugin -->
    <link rel="stylesheet" href="/html/core/vendor/swiperjs/swiper-bundle.css">

    <script src="/html/core/vendor/jquery/jquery-3.6.0.min.js"></script>
    <script src="/html/core/vendor/jquery.validate/jquery.validate.min.js"></script>
    <script src="/html/core/vendor/swiperjs/swiper-bundle.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery-cookie/1.4.1/jquery.cookie.min.js"></script>

    <link rel="stylesheet" href="/html/page/members/assets/style/style.min.css">
    <script src="/html/page/members/assets/script/common.js"></script>
    <script src="https://js.bootpay.co.kr/bootpay-4.2.5.min.js" type="application/javascript"></script>
<!--     <c:if test="${fn:indexOf(_curPath, '/membership/regist') > -1 || fn:indexOf(_curPath, '/membership/srchPswd') > -1}"> -->
<!--    </c:if>-->
</head>
<body>

	<tiles:insertAttribute name="header"/>

	<tiles:insertAttribute name="content"/>

    <tiles:insertAttribute name="footer"/>

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
</html>