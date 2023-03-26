<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="x-ua-compatible" content="ie=edge">

    <title>팝업</title>
    <script src="/html/core/vendor/jquery/jquery-3.6.0.min.js"></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery-cookie/1.4.1/jquery.cookie.min.js"></script>
	<script></script>
    <link rel="stylesheet" href="/html/page/market/assets/style/style.min.css?v=<spring:eval expression="@version['assets.version']"/>">
	<style>
		body {
			padding: 0;
		}

		.popup-window {
			display: flex;
			flex-flow: column;
			height: 100vh;
			background: #333;
		}

		.window-content {
			flex: 1 1 0px;
			background: white;
			border-bottom-left-radius: 1.125rem;
			border-bottom-right-radius: 1.125rem;
		}

		.window-content img {
			min-height: 90%;
			object-fit: contain;
		}

		.window-footer {
			display: flex;
			align-items: center;
			justify-content: space-between;
			padding: 0.5rem 1.25rem;
			color: white;
		}

		.window-close {
			margin: -0.5rem;
			width: 2rem;
			height: 2rem;
			overflow: hidden;
			background: url(/html/page/market/assets/images/ico-close-white.svg) no-repeat center / 1rem;
			text-indent: -999em;
    	}
	</style>
</head>
<body>

	<div class="popup-window view${popupVO.popNo}" >
	<div class="window-content">
		<c:forEach var="fileList" items="${popupVO.fileList}" varStatus="status">
			<c:if test="${!empty fileList}">
				<img src="/comm/getImage?srvcId=POPUP&amp;upNo=${fileList.upNo}&amp;fileNo=${fileList.fileNo }" alt="" id="imgview">
			</c:if>
		</c:forEach>
	</div>
	<div class="window-footer">
		<div class="form-check" style="font-size: 1rem;">
			<c:if test="${popupVO.oneViewTy eq 'Y'}">
				<input class="form-check-input" type="checkbox" id="check-close">
				<label class="form-check-label" for="check-close">1일동안 보지 않음</label>
			</c:if>
		</div>
		<button type="button" class="window-close cls-popup-btn" data-pop-no="${popupVO.popNo}" >닫기</button>
	</div>
	</div>
</body>
</html>
<script>
$(function(){

	//팝업 닫기
	$(".cls-popup-btn").on("click",function(){
		var popNo = $(this).data("popNo");

		if($("#check-close").is(":checked")){
			$.cookie("popup"+popNo,"none",{expires:1, path:"/"});
		}

		window.close();
	});
});


</script>