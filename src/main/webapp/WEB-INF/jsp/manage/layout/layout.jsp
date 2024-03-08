<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="x-ua-compatible" content="ie=edge">

    <title>E-ROUM MANAGEMENT SYSTEM</title>

    <link id="favicon" rel="shortcut icon" href="/html/core/images/favicon.ico" sizes="16x16">

    <!-- plugin -->
    <link rel="stylesheet" href="/html/core/vendor/jstree/dist/themes/default/style.min.css">
    <link rel="stylesheet" href="/html/core/vendor/jquery/jquery-ui.min.css">
    <link rel="stylesheet" href="/html/page/admin/assets/style/lightbox.min.css">

    <script src="/html/core/vendor/jquery/jquery-3.6.0.min.js"></script>
    <script src="/html/core/vendor/jquery/jquery-ui.min.js"></script>
    <script src="/html/core/vendor/jquery.validate/jquery.validate.min.js"></script>
    <script src="/html/page/admin/assets/script/lightbox.min.js"></script>

    <script src="/html/core/vendor/jstree/dist/jstree.min.js"></script>
    <script src="/html/core/vendor/datatables/datatables.min.js"></script>

    <script src="/html/core/vendor/tinymce/tinymce.min.js"></script>
    <script src="/html/core/vendor/tinymce/basic_config.js"></script>

	<!-- common -->
	<script src="/html/core/script/hangjungdong.js"></script>
    <script src="/html/core/script/formatter.js?v=<spring:eval expression="@version['assets.version']"/>"></script>
    <script src="/html/core/script/utility.js?v=<spring:eval expression="@version['assets.version']"/>"></script>
    <script src="/html/core/script/JsCommon.js?v=<spring:eval expression="@version['assets.version']"/>"></script>
    <script src="/html/core/script/JsCallApi.js?v=<spring:eval expression="@version['assets.version']"/>"></script>
    <script src="/html/core/script/JsHouse2309CodeConvert.js?v=<spring:eval expression="@version['assets.version']"/>"></script>
    <script src="/html/core/script/JsHouse2309PageBase.js?v=<spring:eval expression="@version['assets.version']"/>"></script>
    <script src="/html/core/script/JsHouse2309PopupBase.js?v=<spring:eval expression="@version['assets.version']"/>"></script>
    <script src="/html/core/script/JsHouse2309Popups.js?v=<spring:eval expression="@version['assets.version']"/>"></script>

    <!-- admin -->
    <link rel="stylesheet" href="/html/page/admin/assets/style/style.min.css?v=<spring:eval expression="@version['assets.version']"/>"/>
    <script src="/html/page/admin/assets/script/common.js?v=<spring:eval expression="@version['assets.version']"/>"></script>
    <script type="text/javascript">
        var jsCommon = null;
        $(document).ready(function() {
            jsCommon = new JsCommon();
    
            jsCommon.fn_keycontrol();
        });
    </script>
    <c:if test="${fn:indexOf(_curPath, '/ordr/') > -1}">
    <script src="https://js.bootpay.co.kr/bootpay-4.2.5.min.js" type="application/javascript"></script>
    </c:if>
</head>
<body>

	<tiles:insertAttribute name="header"/>

    <!-- main content -->
    <main id="container">
        <div id="content">

            <tiles:insertAttribute name="breadcrumb"/>

            <!-- page content -->
            <div id="page-content" class="layout page-content">

            	<tiles:insertAttribute name="content"/>

            </div>
            <div class="modal2-con">
            </div>
            
            <!-- //page content -->
        </div>
    </main>
    <!-- //main content -->

    <script src="/html/core/vendor/twelements/index.min.js"></script>
    
</body>
</html>