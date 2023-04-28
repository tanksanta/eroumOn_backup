<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="ko">
    <head>
        <meta charset="UTF-8">
		<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=0">

        <title>${bplcSetupVO.bplcNm} | 이로음 멤버스</title>

    	<link id="favicon" rel="shortcut icon" href="/html/core/images/favicon.ico" sizes="16x16">

        <!-- common -->
        <script src="/html/core/vendor/jquery/jquery-3.6.0.min.js"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery-cookie/1.4.1/jquery.cookie.min.js"></script>

        <!-- office -->
        <link rel="stylesheet" href="/html/page/office/assets/style/home.min.css">
        <script src="/html/core/vendor/jquery.validate/jquery.validate.min.js"></script>
        <script src="/html/page/office/assets/script/common.js"></script>
    </head>
    <body>
        <!-- skip navigation -->
        <nav id="skip-navigation">
            <ul>
                <li><a href="#container">본문 바로가기</a></li>
            </ul>
        </nav>
        <!-- //skip navigation -->

		<tiles:insertAttribute name="header"/>

		<tiles:insertAttribute name="navigation"/>

		<tiles:insertAttribute name="aside"/>

        <tiles:insertAttribute name="content"/>

        <tiles:insertAttribute name="footer"/>

        <script src="/html/core/vendor/twelements/index.min.js"></script>
        <script>
        $(function(){

        });
        </script>
    </body>
</html>