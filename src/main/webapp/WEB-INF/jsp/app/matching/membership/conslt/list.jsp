<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

	<div class="wrapper">
	
	    <!-- 상단 뒤로가기 버튼 추가 -->
		<jsp:include page="/WEB-INF/jsp/app/matching/common/topButton.jsp">
	        <jsp:param value="상담목록" name="addTitle" />
	    </jsp:include>
	
	
        <main>
            <section class="default">

				<c:forEach var="consltInfo" items="${mbrConsltList}" varStatus="status">
					<%-- 상담 취소 여부 --%>
					<c:set var="isCancelConslt" value="${consltInfo.consltSttus eq 'CS03' || consltInfo.consltSttus eq 'CS04' || consltInfo.consltSttus eq 'CS09' ? true : false}" />
				
					<div class="card waves-effect w100p" onclick="clickConsltDetail(${consltInfo.consltNo});">
						
						<%-- 상담 상태 박스 --%>
						<c:set var="consltInfo" value="${consltInfo}" scope="request"/>
						<jsp:include page="/WEB-INF/jsp/app/matching/membership/conslt/include/consltStatusBox.jsp" />
	
	                </div>
	                <!-- card -->
	
	                <div class="h12"></div>
				</c:forEach>

            </section>
        </main>
        
	</div>
	<!-- wrapper -->
	
	  
      <script>
      	function clickConsltDetail(consltNo) {
      		location.href = '/matching/membership/conslt/detail?consltNo=' + consltNo;
      	}
      </script>