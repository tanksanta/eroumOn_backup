<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!-- banner -->
<c:forEach var="banner" items="${_bannerList}">
	<aside id="banner">
		<div class="container">
			<c:forEach var="fileList" items="${banner.pcFileList }" end="1">
				<c:if test="${banner.linkTy ne 'N'}">
					<a href="${banner.linkUrl}?rdcntBanner=${banner.bannerNo}" <c:if test="${banner.linkTy eq 'S'}">target="_blank"</c:if>>
				</c:if>
				<img src="/comm/getFile?srvcId=BANNER&amp;upNo=${fileList.upNo }&amp;fileTy=${fileList.fileTy }&amp;fileNo=${fileList.fileNo }" alt="">
				<c:if test="${banner.linkTy ne 'N'}">
					</a>
				</c:if>
			</c:forEach>
			<button type="button" data-banner-no="${banner.bannerNo}">
				<span class="sr-only">닫기</span>
			</button>
		</div>
	</aside>
</c:forEach>
<script>
$('#banner button').on('click', function() {
	$('body').removeClass('is-banner');

	let bannerNo = $(this).data("bannerNo");
	$.cookie("topBanner",bannerNo,{expires:1, path:"/"});
});
</script>
