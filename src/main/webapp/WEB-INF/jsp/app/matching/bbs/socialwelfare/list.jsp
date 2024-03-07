<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<div class="wrapper">
	
    <!-- 상단 뒤로가기 버튼 추가 -->
    <jsp:include page="/WEB-INF/jsp/app/matching/common/topButton.jsp">
        <jsp:param value="" name="addButton" />
        <jsp:param value="어르신 복지" name="addTitle" />
    </jsp:include>

    <main>
        <section class="default">


            <div class="intro_om_wel_list">
                <h4 class="title">어르신 복지가 궁금하세요?</h4>
            </div>

            <div class="h20"></div>

            <c:forEach var="resultList" items="${listVO.listObject}" varStatus="status">
                <c:set var="pageParam" value="nttNo=${resultList.nttNo}&amp;curPage=${listVO.curPage}" />
                
                <a class="waves-effect box_om_wel_list" href="./view?${pageParam}">
                    <div class="img_area">
                        <img src="/html/page/app/matching/assets/src/images/08etc/bokji01_40.svg" alt="어르신용품">
                    </div>
                    <div class="font_sbms">
                        ${resultList.ttl}
                    </div>
                </a>

			</c:forEach>

        </section>
    </main>


</div>

<script>
    
</script>