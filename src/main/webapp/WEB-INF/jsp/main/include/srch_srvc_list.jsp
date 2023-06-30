<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<input type="hidden" id="srvcListCnt" name="srvcListCnt" value="${listVO.totalCount}">

<div class="service-content" data-page-total="${listVO.totalPage}">
	<c:if test="${!empty listVO.listObject}">
		<div class="content-sizer"></div>
		<div class="content-gutter"></div>

		<c:forEach items="${listVO.listObject}" var="resultList" varStatus="status">
			<c:set var="colorNumber">
				<%-- 카테고리 선택안했을 경우 default --%>
				<c:choose>
					<c:when test="${fn:contains(resultList.categoryList, '주거')}">1</c:when>
					<c:when test="${fn:contains(resultList.categoryList, '문화')}">2</c:when>
					<c:when test="${fn:contains(resultList.categoryList, '보건')}">3</c:when>
					<c:when test="${fn:contains(resultList.categoryList, '고용')}">4</c:when>
					<c:when test="${fn:contains(resultList.categoryList, '교육')}">5</c:when>
					<c:when test="${fn:contains(resultList.categoryList, '상담')}">6</c:when>
					<c:when test="${fn:contains(resultList.categoryList, '보호')}">8</c:when>
					<c:when test="${fn:contains(resultList.categoryList, '지원')}">7</c:when>
				</c:choose>
			</c:set>
			<a href="#${resultList.bokjiId}" class="content-item is-color${colorNumber}">
				<div class="content">
					<p class="name">${resultList.benefitName}</p>
					<p class="type">
						<c:forEach items="${resultList.categoryList}" var="cate" varStatus="s">
                                        	${cate} ${s.last?'':' ∙ '}
                                        	</c:forEach>
					</p>
					<p class="part">${resultList.bokjiResource}</p>
				</div>
				<div class="status"></div>
			</a>
		</c:forEach>
		<div class="service-button">
			<c:if test="${listVO.curPage > 1}">
				<button type="button" class="button-prev srvc-pager" data-page-no="${listVO.curPage - 1}" data-page-total="${listVO.totalPage}">
					<span>이전 페이지</span> <i></i>
				</button>
			</c:if>
			<c:if test="${listVO.curPage < listVO.totalPage}">
				<button type="button" class="button-next srvc-pager" data-page-no="${listVO.curPage + 1}" data-page-total="${listVO.totalPage}">
					<span>다음 페이지</span> <i></i>
				</button>
			</c:if>
		</div>
	</c:if>
	<c:if test="${empty listVO.listObject}">데이터가 없습니다.</c:if>
</div>

<script>
$(function(){
    $('.welfare-service-item .service-content').masonry({
        itemSelector: '.content-item',
        columnWidth: '.content-sizer',
        gutter: '.content-gutter',
        percentPosition: true
    });
    
    var observer = new MutationObserver(function(mutations) {
        if($(mutations[0].target).hasClass('is-active')) {
            $('.service-content').masonry({
                itemSelector: '.content-item',
                columnWidth: '.content-sizer',
                gutter: '.content-gutter',
                percentPosition: true
            });
        }
    });

    observer.observe(document.querySelector('.welfare-service-item'), {
        attributes : true
    });
    
    $('.button-next').on('click', function() {
        page = (page + 1 > pageT) ? pageT : page + 1;
        $('.service-paging i').removeClass('is-active')
        $('.service-paging i[data-num="' + page + '"]').addClass('is-active');
        if(page > 3 && page <= pageT-2) {
            var a = (page - 3) * 20;
            $('.service-paging .paging-flow').css('margin-left', -a);
        }
    })
    $('.button-prev').on('click', function() {
        page = (page - 1 >= 1) ? page - 1 : 1;
        $('.service-paging i').removeClass('is-active')
        $('.service-paging i[data-num="' + page + '"]').addClass('is-active');
        if(page > 2) {
            var a = (page - 3) * 20;
            console.log(page - 3)
            $('.service-paging .paging-flow').css('margin-left', -a);
        }
    })
});
</script>