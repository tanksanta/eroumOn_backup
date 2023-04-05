<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="x-ua-compatible" content="ie=edge">

    <title>이로움온</title>

    <!-- plugin -->
    <link rel="stylesheet" href="/html/core/vendor/swiperjs/swiper-bundle.css">
    <script src="/html/core/vendor/jquery/jquery-3.6.0.min.js"></script>
    <script src="/html/core/vendor/swiperjs/swiper-bundle.min.js"></script>
    <script src="/html/core/vendor/masonry/masonry.pkgd.min.js"></script>

    <link rel="stylesheet" href="/html/page/planner/assets/style/style.min.css">
    <script src="/html/page/planner/assets/script/index.js"></script>
</head>
<body ${isIndex?'class="is-index"':''}>

	<tiles:insertAttribute name="header"/>

	<main id="container">

		<tiles:insertAttribute name="content"/>

	</main>

	<tiles:insertAttribute name="footer"/>

	<div id="modalLogin"></div>

	<script src="/html/core/vendor/twelements/index.min.js"></script>
    <script src="/html/core/vendor/twelements/popper.min.js"></script>
	<script>
	$(function(){
		$(".f_login").on("click", function(e){
			e.preventDefault();
			$("#modalLogin").load(
       			"/planner/modalLogin"
       			, function(){
					$("#modal-login").modal("show");
       			}
       		);

		});
	});
	</script>

</body>
</html>