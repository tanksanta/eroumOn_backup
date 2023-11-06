<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<script>
  
  <c:if test="${!empty gaEvent}">
	//GA4 event 처리
	gtag('event', '${gaEvent.eventName}', {
		<c:forEach var="properyMap" items="${gaEvent.propertyObj}" varStatus="status">
			<c:if test="${status.index != 0}">,</c:if> ${properyMap.key} : "${properyMap.value}"
		</c:forEach>
	});
  </c:if>
  
</script>