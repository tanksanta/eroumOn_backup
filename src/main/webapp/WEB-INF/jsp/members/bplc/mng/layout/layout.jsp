<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="x-ua-compatible" content="ie=edge">

    <title>이로움ON 멤버스</title>

    <!-- plugin -->
    <script src="/html/core/vendor/jquery/jquery-3.6.0.min.js"></script>

    <!-- common -->
    <script src="/html/core/script/utility.js"></script>

    <!-- admin -->
    <link rel="stylesheet" href="/html/page/office/assets/style/admin.min.css">
    <script src="/html/core/vendor/jquery.validate/jquery.validate.min.js"></script>
    <script src="/html/core/vendor/datatables/datatables.min.js"></script>
    <script src="/html/core/vendor/tinymce/tinymce.min.js"></script>
    <script src="/html/core/vendor/tinymce/basic_config.js"></script>

    <script src="/html/page/office/assets/script/admin.js"></script>



</head>
<body>

    <tiles:insertAttribute name="header"/>

    <!-- main content -->
    <main id="container">
        <div id="content">

            <tiles:insertAttribute name="page-content"/>

        </div>
    </main>
    <!-- //main content -->

    <script src="/html/core/vendor/twelements/index.min.js"></script>
</body>
</html>