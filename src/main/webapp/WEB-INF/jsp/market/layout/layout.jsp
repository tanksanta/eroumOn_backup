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
    <meta name="description" content="장기요양인정 등급 테스트부터 우리 동네 복지혜택, 복지용구 구매까지. 소중한 부모님과 나를 위한 서비스를 이로움온이 제공합니다.">

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

    <!-- market -->
    <link rel="stylesheet" href="/html/page/market/assets/style/style.min.css?v=<spring:eval expression="@version['assets.version']"/>">
    <link rel="stylesheet" href="/html/page/market/assets/style/style_add.css?v=<spring:eval expression="@version['assets.version']"/>">
    
    <script src="/html/page/market/assets/script/common.js?v=<spring:eval expression="@version['assets.version']"/>"></script>
    <script src="/html/core/script/formatter.js?v=<spring:eval expression="@version['assets.version']"/>"></script> 
    <script src="/html/core/script/JsCommon.js?v=<spring:eval expression="@version['assets.version']"/>"></script>
    <script src="/html/core/script/JsCallApi.js?v=<spring:eval expression="@version['assets.version']"/>"></script>
    <script src="/html/page/market/assets/script/product.js"></script>
    <script src="/html/page/market/assets/script/index.js"></script>

    <c:if test="${fn:indexOf(_curPath, '/ordr/') > -1}">
    <script src="/html/page/market/assets/script/order.js?v=<spring:eval expression="@version['assets.version']"/>"></script>
    <script src="https://js.bootpay.co.kr/bootpay-4.2.5.min.js" type="application/javascript"></script>
    </c:if>
    <c:if test="${fn:indexOf(_curPath, '/mbr/registStep1') > -1 || fn:indexOf(_curPath, '/info/srchPswd') > -1}">
    <script src="https://js.bootpay.co.kr/bootpay-4.2.5.min.js" type="application/javascript"></script>
    </c:if>
    
    <!-- 마켓팅팀 요청 head 태그안 삽입 코드 -->
    <jsp:include page="/WEB-INF/jsp/common/common_marketing_head_tag.jsp" />
    
</head>
<body>
	<!-- Google Tag Manager (noscript) -->
    <noscript><iframe src="https://www.googletagmanager.com/ns.html?id=${googleAnalyticsGTM}" height="0" width="0" style="display:none;visibility:hidden"></iframe></noscript>
    <!-- End Google Tag Manager (noscript) -->
	<script>
	$(function(){
		//console.log($.cookie("topBanner"));
		if(Number($.cookie("topBanner")) > 0){
			$("body").removeClass("is-banner");
		}else{
			if(Number("${fn:length(_bannerList)}" > 0)){
				$("body").addClass("is-banner");
			}
		}


	});
	</script>

    <!-- access -->
    <ul id="skip-navigation">
        <li><a href="#container">본문 바로가기</a></li>
    </ul>
    <!-- //access -->

	<header id="header">

		<!-- aside -->
	    <tiles:insertAttribute name="aside"/>
	    <!-- //aside -->

        <!-- header logo -->
        <div id="utility">
            <h1 class="global-logo"><a href="/market"><em>이로움 ON</em></a></h1>
            <ul class="utility-menu">
            	<c:if test="${!_mbrSession.loginCheck}">
	                <li><a href="${_membershipPath }/login?returnUrl=${_curPath}">로그인</a></li>
	            	<li><a href="${_membershipPath }/regist">회원가입</a></li>
                </c:if>
                <c:if test="${_mbrSession.loginCheck}">
                	<li><a href="${_membershipPath}/logout?returnUrl=${_marketPath}">로그아웃</a></li>
                </c:if>
                <li><a href="${_marketPath}/etc/faq/list">고객센터</a></li>
            </ul>
        </div>
        <!-- //header logo -->

        <!-- navigation -->
	    <tiles:insertAttribute name="navigation"/>
	    <!-- //navigation -->

    </header>

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
	
	
	<!-- 채널톡 연동처리 -->
	<jsp:include page="/WEB-INF/jsp/common/channel_talk.jsp" />
	
    <!-- GA 이벤트 -->
	<jsp:include page="/WEB-INF/jsp/common/ga4_event.jsp" />

    <script type="text/javascript">
        var jsCommon = null;
        $(document).ready(function() {
            jsCommon = new JsCommon();
    
            jsCommon.fn_keycontrol();
        });
    </script>
    
    <!-- 마켓팅팀 요청 body 태그안 삽입 코드 -->
    <jsp:include page="/WEB-INF/jsp/common/common_marketing_body_tag.jsp" />
    
</body>
</html>
