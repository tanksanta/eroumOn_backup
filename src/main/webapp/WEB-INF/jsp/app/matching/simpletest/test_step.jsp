test_step

${step}
${testTy}
${selValue}

${title}
${img}
${listValues}
${listTexts}
${selectedValue}
${nextStep}


<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<div class="wrapper">
	
    <!-- 상단 뒤로가기 버튼 추가 -->
    <jsp:include page="/WEB-INF/jsp/app/matching/common/topButton.jsp">
        <jsp:param value="간편테스트" name="addTitle" />
    </jsp:include>

    <main>
        <section class="intro">
            ${testTy} ${step}
            
            <input type="button" onclick="fn_move_test()" value="선택" >
        </section>
        

    </main>
    
</div>
<script>
    function fn_move_test(){
        var selectedValue = {};

        var data = {"testTy":"${testTy}",  "selValue": JSON.stringify(selectedValue), "recipientsNo":0};
        callPostMove('${nextStepUrl}', data)
    }
</script>