<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="ko">
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="x-ua-compatible" content="ie=edge">
    
    <script src="/html/core/vendor/jquery/jquery-3.6.0.min.js"></script>
    <script src="/html/core/script/matching/ajaxCallApi.js?v=<spring:eval expression="@version['assets.version']"/>"></script>
    <script src="/html/core/script/matching/cookie.js?v=<spring:eval expression="@version['assets.version']"/>"></script>
    <script src="https://js.bootpay.co.kr/bootpay-4.2.5.min.js" type="application/javascript"></script>
    <!-- materialize -->
 	<script type="text/javascript" src="/html/page/app/matching/assets/src/js/materialize.min.js"></script>

	<script type="text/javascript" src="/html/page/app/matching/assets/src/js/custom/guide.js?v=<spring:eval expression="@version['assets.version']"/>"></script>
    <script type="text/javascript" src="/html/core/script/JsCommon.js?v=<spring:eval expression="@version['assets.version']"/>"></script>

    <!-- materialize CSS -->
    <link rel="stylesheet" href="/html/page/app/matching/assets/src/css/materialize.min.css" />
    <!-- style.css -->
    <link rel="stylesheet" href="/html/page/app/matching/assets/src/css/style.css">

 	<script type="text/javascript" src="/html/core/script/JsHouse2309PopupBase.js?v=<spring:eval expression="@version['assets.version']"/>"></script>
</head>
<body>
	
	<tiles:insertAttribute name="content"/>
	
	<jsp:include page="/WEB-INF/jsp/app/matching/common/appCommon.jsp" />
	<jsp:include page="/WEB-INF/jsp/app/matching/common/communicateWithMobile.jsp" />
</body>
</html>