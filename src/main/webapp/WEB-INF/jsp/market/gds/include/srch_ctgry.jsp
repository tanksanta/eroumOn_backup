<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<c:if test="${fn:length(childList) > 0}">
	<c:set var="allLink">
		<c:choose>
			<c:when test="${paramMap.ctgryNo3 > 0}">
				${_marketPath}/gds/${paramMap.upCtgryNo}/${paramMap.ctgryNo1}/${paramMap.ctgryNo2}/${paramMap.ctgryNo3}/list
			</c:when>
			<c:when test="${paramMap.ctgryNo2 > 0}">
				${_marketPath}/gds/${paramMap.upCtgryNo}/${paramMap.ctgryNo1}/${paramMap.ctgryNo2}/list
			</c:when>
			<c:when test="${paramMap.ctgryNo1 > 0}">
				${_marketPath}/gds/${paramMap.upCtgryNo}/${paramMap.ctgryNo2}/${paramMap.ctgryNo3}/list
			</c:when>
			<c:otherwise>
				${_marketPath}/gds/${paramMap.upCtgryNo}/list
			</c:otherwise>
		</c:choose>
	</c:set>
	<a href="${allLink}" ${upCtgryNo>0?'':'class="is-active"' } data-ctgry-no="">전체</a>
	<c:forEach items="${childList}" var="ctgry" varStatus="status">
		<c:choose>
			<c:when test="${ctgry.levelNo eq 4}">
				<a href="${_marketPath}/gds/${paramMap.upCtgryNo}/${paramMap.ctgryNo1}/${ctgry.ctgryNo}/list" data-ctgry-no="${ctgry.ctgryNo}">${ctgry.ctgryNm}</a>
			</c:when>
			<c:when test="${ctgry.levelNo eq 3}">
				<a href="${_marketPath}/gds/${paramMap.upCtgryNo}/${ctgry.ctgryNo}/list" data-ctgry-no="${ctgry.ctgryNo}">${ctgry.ctgryNm}</a>
			</c:when>
			<c:when test="${ctgry.levelNo eq 2}">
				<a href="${_marketPath}/gds/${ctgry.ctgryNo}/list" data-ctgry-no="${ctgry.ctgryNo}">${ctgry.ctgryNm}</a>
			</c:when>
		</c:choose>

	</c:forEach>
	<button type="button" class="category-moreview">더보기</button>
</c:if>