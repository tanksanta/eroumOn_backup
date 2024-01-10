<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>

<html lang="ko">
<head>
	<meta charSet="utf-8" />
	<meta name="theme-color" content="rgba(246, 248, 255, 0.6)" />
	<meta name="viewport" content="width=device-width, initial-scale=1.0" media="screen and (min-width: 768px)">
	<meta name="viewport" content="initial-scale=1, viewport-fit=cover" media="screen and (max-width: 767px)">
	<link rel="apple-touch-icon" href="/html/page/test/assets/images/icon_128.png" />
	<link rel="shortcut icon" href="/html/page/test/assets/images/favicon.ico" />
	<link rel="manifest" href="/html/page/test/assets/manifest.json" />
	<link rel="stylesheet" href="/html/page/test/assets/style/style.min.css">
	<script data-ad-client="ca-pub-9521817924224887" async src="https://pagead2.googlesyndication.com/pagead/js/adsbygoogle.js"></script>
	
	<!-- plugin -->
    <script src="/html/core/vendor/jquery/jquery-3.6.0.min.js"></script>
	
	<script src="/html/page/test/assets/script/common.js?v=<spring:eval expression="@version['assets.version']"/>"></script>
	
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
    
    <c:set var="naverSiteVerification"><spring:eval expression="@props['Naver.Site.Verification']"/></c:set>
    <c:if test="${!empty naverSiteVerification}">
	<meta name="naver-site-verification" content="${naverSiteVerification}" />
	</c:if>
	
	<!-- 마켓팅팀 요청 head 태그안 삽입 코드 -->
    <jsp:include page="/WEB-INF/jsp/common/common_marketing_head_tag.jsp" />
    
</head>
<body class="bg-main">
	<!-- Google Tag Manager (noscript) -->
    <noscript><iframe src="https://www.googletagmanager.com/ns.html?id=${googleAnalyticsGTM}" height="0" width="0" style="display:none;visibility:hidden"></iframe></noscript>
    <!-- End Google Tag Manager (noscript) -->

	<tiles:insertAttribute name="content"/>


	<!-- 예상치 못한 오류 팝업 -->
	<div class="modal modal-default fade" id="modalError" tabindex="-1" aria-hidden="true">
		<div class="modal-dialog modal-dialog-centered ">
			<div class="modal-content">
				<div class="modal-header">
				</div>
				<div class="modal-body md:min-w-[26rem]">
					<!-- 예상치 못한 오류로 결과를 확인할 수 없는 상황에 호출되는 모달(팝업) -->
					<div class="flex flex-col items-center text-xl">
						<i class="ico-alert orange mb-8"></i>
						<p>죄송합니다</p>
						<p><strong>일시적 오류</strong>가 발생했습니다</p>
						<p>잠시후 다시 시도해 주세요</p>
					</div>
					<!--// 예상치 못한 오류로 결과를 확인할 수 없는 상황에 호출되는 모달(팝업) -->
				</div>
				<div class="modal-footer">
					<a href="/main/cntnts/test" class="btn btn-primary">테스트 시작하기</a>
				</div>
			</div>
		</div>
	</div>
	
	
	<!-- quick -->
	<div id="quick" class="global-quick" style="right:2.5rem;">
		<button type="button" class="channelTalk">위로 이동</button>
	</div>
	<!-- //quick -->
	
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
	
	
	<script src="/html/core/vendor/twelements/index.min.js"></script>
    <script src="/html/core/vendor/twelements/popper.min.js"></script>
	
	<!-- 채널톡 연동처리 -->
	<jsp:include page="/WEB-INF/jsp/common/channel_talk.jsp" />
	
	<!-- GA 이벤트 -->
	<jsp:include page="/WEB-INF/jsp/common/ga4_event.jsp" />

	<!-- 마켓팅팀 요청 body 태그안 삽입 코드 -->
    <jsp:include page="/WEB-INF/jsp/common/common_marketing_body_tag.jsp" />
    
</body>
</html>