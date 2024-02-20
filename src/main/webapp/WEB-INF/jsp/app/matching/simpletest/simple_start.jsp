<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<div class="wrapper">
	
    <!-- 상단 뒤로가기 버튼 추가 -->
    <jsp:include page="/WEB-INF/jsp/app/matching/common/topButton.jsp">
        <jsp:param value="어르신 돌봄" name="addTitle" />
    </jsp:include>

    <main>
        <section class="intro">
            simple_start
            
            <input type="button" onclick="fn_move_test()" value="시작하기" >
        </section>
        

    </main>
    
</div>
<script>
    function fn_move_test(){
        var selectedValue = {};

        var data = {"testTy":"simple",  "selValue": JSON.stringify(selectedValue), "recipientsNo":0};
        callPostMove('/matching/simpletest/test/100', data)
    }
</script>