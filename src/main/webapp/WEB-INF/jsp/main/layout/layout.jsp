<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="x-ua-compatible" content="ie=edge">

	<!-- open graph -->
    <meta property="og:url" content="https://eroum.co.kr${_curPath}" >
    <meta property="og:type" content="website" >
    <meta property="og:image" content="https://eroum.co.kr/html/page/market/assets/images/og_img.png" >
    <meta property="og:title" content="이로움ON : 시니어 정보 플랫폼" >
    <meta property="og:description" content="장기요양인정 등급 테스트부터 우리 동네 복지혜택, 복지용구 구매까지. 소중한 부모님과 나를 위한 서비스를 이로움온이 제공합니다." >

    <title>이로움ON</title>

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

    <link id="favicon" rel="shortcut icon" href="/html/core/images/favicon.ico" sizes="16x16">

    <!-- plugin -->
    <link rel="stylesheet" href="/html/core/vendor/swiperjs/swiper-bundle.css">
    <script src="/html/core/vendor/jquery/jquery-3.6.0.min.js"></script>
    <script src="/html/core/vendor/jquery.validate/jquery.validate.min.js"></script>

    <script src="/html/core/vendor/swiperjs/swiper-bundle.min.js"></script>
    <script src="/html/core/vendor/masonry/masonry.pkgd.min.js"></script>

    <link rel="stylesheet" href="/html/page/index/assets/style/style.min.css">
    <script src="/html/page/index/assets/script/index.js"></script>
</head>

<body>
	<!-- Google Tag Manager (noscript) -->
	<noscript><iframe src="https://www.googletagmanager.com/ns.html?id=GTM-TNTQ4GXN" height="0" width="0" style="display:none;visibility:hidden"></iframe></noscript>
	<!-- End Google Tag Manager (noscript) -->

	<tiles:insertAttribute name="aside"/>

	<tiles:insertAttribute name="header"/>

	<main id="container">

		<tiles:insertAttribute name="breadcrumb"/>

		<tiles:insertAttribute name="content"/>

	</main>

	<tiles:insertAttribute name="footer"/>

	<div id="modalSrvcDtl"></div>

	<script src="/html/core/vendor/twelements/index.min.js"></script>
    <script src="/html/core/vendor/twelements/popper.min.js"></script>

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
</body>
</html>