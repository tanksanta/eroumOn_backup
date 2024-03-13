

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<div class="wrapper">
	
    <!-- 상단 뒤로가기 버튼 추가 -->
    <jsp:include page="/WEB-INF/jsp/app/matching/common/topButton.jsp">
        <jsp:param value="간편테스트" name="addTitle" />
    </jsp:include>

    <main>
        
        <section class="default">
                
            <progress class="progress01" value="${stepIdx}" min="0" max="6"></progress>
            <div class="progress_num"><span class="step">${stepIdx}</span>/6</div>

            <div class="scene01">
                <h2 class="font_h2">
                    <mark class="mk01">${subjectMk}</mark><br>
                    ${subjectNormal}
                </h2>


                <div class="center marH40">
                    <img src="/html/page/app/matching/assets/src/images/11easy/${imgFileNm}" alt="인정등급 간편테스트">
                </div>

                <c:forEach var="item" items="${listValues}" varStatus="status">
                    <input type="radio" name="t01" id="rd_0${status.index}" class="chk01_3 large border_gray" value="${item}">
                    <label for="rd_0${status.index}">${listTexts[status.index]}</label>
                </c:forEach>
            </div>
    

        </section>
    </main>
    
</div>
<script>
    $(function() {
        $("input[type='radio'].chk01_3").off('click').on('click', function(){

            $("body").append('<div class="overlay_screen" style="display: block;"></div>')
            setTimeout(function() {
                fn_move_test();
            }, 1000);
        });
    });

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
        
        qsMap["step${step}"] = $("input[type='radio'][name='t01']:checked").val();

        if (qsMap["step${step}"] == undefined || qsMap["step${step}"].length < 1){
            showAlertPopup("항목을 선택해 주십시오.")
            return;
        }

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

        var param = {recipientsNo:qsMap["recipientsNo"]}//, mbrSimpletestNo : result["mbrSimpletestNo"]
        
        location.href = '${nextStepUrl}' + '?' + jsCommon.fn_queryString_fromMap(param);
    }
</script>