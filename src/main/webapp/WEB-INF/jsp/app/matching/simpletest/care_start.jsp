<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<div class="wrapper">
	
    <!-- 상단 뒤로가기 버튼 추가 -->
    <jsp:include page="/WEB-INF/jsp/app/matching/common/topButton.jsp">
        <jsp:param value="어르신 돌봄" name="addTitle" />
    </jsp:include>

    <main>
        <section class="intro">
            care_start
            둘러보기
            
            <input type="button" onclick="fn_move_test()" value="시작하기" >
        </section>
        

    </main>
    
</div>
<script>
    function fn_move_test(){
        
        location.href = '${nextStepUrl}' + '/matching/simpletest/test/100?testTy=care&recipientsNo=${recipientsNo}';
        
    }
</script>