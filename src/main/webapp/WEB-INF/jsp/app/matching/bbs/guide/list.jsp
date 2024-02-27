<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<div class="wrapper">
	
    <!-- 상단 뒤로가기 버튼 추가 -->
    <jsp:include page="/WEB-INF/jsp/app/matching/common/topButton.jsp">
        <jsp:param value="" name="addButton" />
    </jsp:include>

    <main>
        <section class="intro">

            <c:if test="${empty listVO.listObject}"><div class="box-result is-large mt-3 md:mt-5">어르신 복지가 없습니다</div></c:if>
            <c:forEach var="resultList" items="${listVO.listObject}" varStatus="status">
                <c:set var="pageParam" value="nttNo=${resultList.nttNo}&amp;curPage=${listVO.curPage}" />
                
                <a href="./view?${pageParam}" class="block">${resultList.ttl}</a>
			</c:forEach>
        </section>
        

    </main>
    
		<footer class="page-footer">

            <div class="relative">
                <a class="waves-effect btn-large btn_primary w100p" >다음</a>
            </div>

        </footer>
</div>

<script>
    
</script>