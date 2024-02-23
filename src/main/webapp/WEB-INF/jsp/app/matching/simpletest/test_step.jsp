

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<div class="wrapper">
	
    <!-- 상단 뒤로가기 버튼 추가 -->
    <jsp:include page="/WEB-INF/jsp/app/matching/common/topButton.jsp">
        <jsp:param value="간편테스트" name="addTitle" />
    </jsp:include>

    <main>
        test_step

        ${testTy}
        ${selValue}

        ${title}
        ${img}
        ${listValues}
        ${listTexts}

        ${nextStep}


        <section class="intro">
            ${testTy} ${step}
            
            <input type="button" onclick="fn_move_test()" value="선택" >
        </section>
        

    </main>
    
</div>
<script>
    function fn_move_test(){
        if ("${step}" == "600"){
            fn_save_result_call();
        }else{
            fn_move_url();
        }
    }
    function fn_move_url(){
        var jsCommon = new JsCommon();
        var qsMap = jsCommon.fn_queryString_toMap();
        
        qsMap["step${step}"] = "1";

        location.href = '${nextStepUrl}' + '?' + jsCommon.fn_queryString_fromMap(qsMap);
    }
    function fn_save_result_call(){
        var url = "save.json";

        var jsCommon = new JsCommon();
        var qsMap = jsCommon.fn_queryString_toMap();
        
        qsMap["step${step}"] = "1";

        callPostAjaxIfFailOnlyMsg(url, qsMap, fn_save_result_cb);
    }
    function fn_save_result_cb(result){
        var jsCommon = new JsCommon();
        var qsMap = jsCommon.fn_queryString_toMap();

        var param = {recipientsNo:qsMap["recipientsNo"], mbrSimpletestNo : result["mbrSimpletestNo"]}
        
        location.href = '${nextStepUrl}' + '?' + jsCommon.fn_queryString_fromMap(param);
    }
</script>