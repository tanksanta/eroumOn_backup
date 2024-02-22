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
    <script src="/html/core/script/matching/localStorage.js?v=<spring:eval expression="@version['assets.version']"/>"></script>
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
	
	<!-- 네트워크 오류 모달 -->
	<div id="modal_net_error" class="modal no_network">

		<!-- <div class="modal_header">
			<h4 class="modal_title">title제목</h4>
		</div> -->
	
		<div class="h24"></div>
	
		<div class="modal-content">
	
			<p class="color_tp_s font_sbmr">
				네트워크가 연결되지 않았어요<br />
				Wi-Fi 또는 데이터를 확인해주세요
			</p>
	
		</div>
		<div class="modal-footer">
			<div class="btn_area d-flex">
				<a class="modal-close waves-effect btn btn-large w100p btn_primary">다시 시도</a>
			</div>
		</div>
	</div>
	
	<jsp:include page="/WEB-INF/jsp/app/matching/common/appCommon.jsp" />
	<jsp:include page="/WEB-INF/jsp/app/matching/common/communicateWithMobile.jsp" />
</body>
</html>