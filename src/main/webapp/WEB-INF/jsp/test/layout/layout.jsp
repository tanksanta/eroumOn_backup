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
</head>
<body class="bg-main">
	<tiles:insertAttribute name="content"/>
</body>
</html>