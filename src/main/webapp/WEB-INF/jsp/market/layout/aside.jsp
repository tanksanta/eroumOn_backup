<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<c:choose>
	<%--aside : 상품 목록/상세만 노출 --%>
	<c:when test="${fn:indexOf(_curPath, '/gds/') > -1 }">
		<aside id="service">
	        <div class="container">
	            <div class="service-slogan">
	                <div class="word"><p><span>SENIOR LIFE STYLE</span> <small>by E·ROUM</small></p></div>
	                <div class="word"><p><span>시니어 라이프 스타일</span> <small>by E·ROUM</small></p></div>
	            </div>
	            <c:if test="${_mbrSession.loginCheck}">
	            <a href="${_marketPath}/mypage/wish/list" class="service-interest"><span>관심상품</span> <i>${_mbrEtcInfoMap.totalWish}</i></a>
	            <a href="${_marketPath}/mypage/cart/list" class="service-mycart"><span>장바구니</span> <i>${_mbrEtcInfoMap.totalCart}</i></a>
	            </c:if>
	            <!-- <a href="#" class="service-recent"><span>최근본상품</span> <i>0</i></a> -->
	            <%--<div class="service-compare">
	                <div class="container">
	                    <button type="button" class="service-compare-toggle" data-bs-toggle="tooltip" title="상품비교">최근본상품</button>--%>
	                    <%-- 최근본상품 리스트업 script 확인 --%>
	                <%--</div>
	            </div> --%>
	            <p class="service-join">
	                <strong>회원가입</strong>하고 <em>제품가 최소 <span>85%</span></em> <strong>지원받으세요!</strong><br>
	                <small>* 장기요양 급여 등급에 따라 지원율은 달라질 수 있음</small>
	            </p>
	        </div>
	        <div class="service-compare-layer">
	        </div>
	    </aside>
    </c:when>
    <c:otherwise>
  	  <!-- banner -->
  	  	<c:forEach var="banner" items="${_bannerList}">
	        <aside id="banner">
	            <div class="container">
	            	<c:forEach var="fileList" items="${banner.pcFileList }" end="1">
	            		<c:if test="${banner.linkTy ne 'N'}"><a href="${banner.linkUrl}"  <c:if test="${banner.linkTy eq 'S'}">target="_blank"</c:if>></c:if>
	                	<img src="/comm/getFile?srvcId=BANNER&amp;upNo=${fileList.upNo }&amp;fileTy=${fileList.fileTy }&amp;fileNo=${fileList.fileNo }" alt="">
	                	<c:if test="${banner.linkTy ne 'N'}"></a></c:if>
	                </c:forEach>
	                <button type="button">
	                    <span class="sr-only">닫기</span>
	                </button>
	            </div>
	        </aside>
        </c:forEach>
        <script>
            $('#banner button').on('click', function() {
                $('body').removeClass('is-banner');
            })
        </script>
        <!-- //banner -->
    </c:otherwise>
</c:choose>

