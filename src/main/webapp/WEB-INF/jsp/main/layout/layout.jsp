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
    <meta property="og:title" content="이로움ON" >
    <meta property="og:description" content="이로움ON" >

    <title>이로움ON</title>

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
</body>
</html>