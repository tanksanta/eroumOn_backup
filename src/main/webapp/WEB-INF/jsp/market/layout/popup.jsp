<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!-- 공지 레이어 배너 -->
<c:set var="arrPopNo" value="" />
<c:forEach var="popList" items="${_popupList}" varStatus="status">
	<c:if test="${popList.popTy eq 'L'}">

		<c:choose>
			<c:when test="${empty arrPopNo}">
				<c:set var="arrPopNo" value="${popList.popNo}" />
			</c:when>
			<c:otherwise>
				<c:set var="arrPopNo" value="${arrPopNo}//${popList.popNo}" />
			</c:otherwise>
		</c:choose>

		<!-- 현재창 팝업 -->

			<div class="notice-layer view${popList.popNo}" style="<c:if test="${!empty popList.popHeight}">height : ${popList.popHeight}px;</c:if> <c:if test="${!empty popList.popWidth}"> width : ${popList.popWidth}px;</c:if> <c:if test="${!empty popList.popLeft}"> left : ${popList.popLeft}px;</c:if> <c:if test="${!empty popList.popTop}"> top : ${popList.popTop}px;</c:if>"/>
				<div class="layer-content">
				<a href="${popList.linkUrl}" <c:if test="${popList.linkTy eq 'S'}">target="_blank"</c:if>>
					<c:forEach var="fileList" items="${popList.fileList}" varStatus="status">
						<c:if test="${!empty fileList}" >
							<img src="/comm/getImage?srvcId=POPUP&amp;upNo=${fileList.upNo}&amp;fileNo=${fileList.fileNo }" alt="">
						</c:if>
					</c:forEach>
				</a>
				</div>
				<div class="layer-footer">
					<div class="form-check">
						<c:if test="${popList.oneViewTy eq 'Y'}">
							<input class="form-check-input check-close" type="checkbox" id="close${status.index}">
							<label class="form-check-label" for="close${status.index}">1일동안 보지 않음</label>
						</c:if>
					</div>
					<button type="button" class="layer-close cls-popup-btn" data-pop-no="${popList.popNo}" data-one-hide="close${status.index}">닫기</button>
				</div>
			</div>
	</c:if>
</c:forEach>
<!-- //공지 레이어 배너 -->


<script>
$(function(){

	// popup show

	var arrPopNo = "${arrPopNo}";
	arrPopNo = arrPopNo.replaceAll(' ','');
	arrPopNo = arrPopNo.split('//');

	for(var i=0; i<arrPopNo.length; i++){
		if($.cookie("popup"+arrPopNo[i]) != "none"){
			$(".view"+arrPopNo[i]).addClass("is-active");
		}
	}


});
</script>
