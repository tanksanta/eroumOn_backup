<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<div class="wrapper">
	
    <!-- 상단 뒤로가기 버튼 추가 -->
    <jsp:include page="/WEB-INF/jsp/app/matching/common/topButton.jsp">
        <jsp:param value="어르신 돌봄" name="addTitle" />
    </jsp:include>

    <main>
        <section class="intro">

            <h3 class="title">
                어르신 돌봄이 필요한 시간을<br>
                선택하세요
            </h3>

            <div class="h40"></div>

            <div class="card care_time_area">

                <div>
                    <div class="h12"></div>
                    <input type="radio" name="care_time" id="chk_b1" class="chk01_2" value="3">
                    <label for="chk_b1" class="font_sblr">3시간 이내</label>
                </div>

                <img src="/html/page/app/matching/assets/src/images/08etc/time01_80.svg" alt="3시간">

            </div>


            <div class="card care_time_area">

                <div>
                    <div class="h12"></div>
                    <input type="radio" name="care_time" id="chk_b2" class="chk01_2" value="8">
                    <label for="chk_b2" class="font_sblr">3~8시간</label>
                </div>

                <img src="/html/page/app/matching/assets/src/images/08etc/time02_80.svg" alt="3~8시간">

            </div>


            <div class="card care_time_area">

                <div>
                    <div class="h12"></div>
                    <input type="radio" name="care_time" id="chk_b3" class="chk01_2" value="10">
                    <label for="chk_b3" class="font_sblr">8~10시간</label>
                    <div class="h08"></div>
                    <span class="badge_recomm">*직장인 추천</span>
                </div>

                <img src="/html/page/app/matching/assets/src/images/08etc/time03_80.svg" alt="8~10시간">

            </div>
            

        </section>
    </main>

    <footer class="page-footer">

        <a class="waves-effect btn-large btn_primary btnEvt_me btn_disable w100p" onclick="fn_move_test()">다음</a>

    </footer>

</div>
<script>
    $(async function () {

        var recipientsNo = "${recipientsNo}";
        if (recipientsNo == "" || parseInt(recipientsNo) == 0){
            const asyncConfirm = await showConfirmPopup('어르신을 등록해 주세요', '혜택을 받으려면 정확한 어르신 정보가 필요해요.', '등록하기');
            if (asyncConfirm != 'confirm'){
                location.href = '/matching/simpletest/care/intro'
                return;
            }

            url = '/matching/membership/recipients/regist/intro';
            location.href = location.pathname + location.search + ((location.search.indexOf("?") >= 0)? "&" :"?") + "redirectUrl=" + encodeURIComponent(url);

            return;
        }

        //돌봄이 시간 선택
        $('.care_time_area').click(function(){

            $('.care_time_area').removeClass('active');
            $(this).addClass('active').find(':radio').prop('checked', true);
            
            //하단 버튼 비활성 해제
            $('.btnEvt_me').removeClass("btn_disable");

        });


    });

    function fn_move_test(){

        var val = $("input[name='care_time']:checked").val();

        if (val == undefined || val.length < 1){
            showAlertPopup("어르신돌봄 시간을 선택해 주십시오.")
            return;
        }
        
        if ("${rcperRcognYn}" == "Y"){
            fn_save_result_call("${rcperRcognYn}", val);
        }else{
            location.href = '/matching/simpletest/test/100?testTy=care&recipientsNo=${recipientsNo}&careTime='+val;
        }
    }

    var _jsCommon;
    function fn_save_result_call(rcperRcognYn, careTime){
        var url = "/matching/simpletest/test/save.json";

        _jsCommon = new JsCommon();
        var qsMap = _jsCommon.fn_queryString_toMap();
        
        qsMap["testTy"] = "care";
        qsMap["careTime"] = careTime;
        qsMap["rcperRcognYn"] = rcperRcognYn;
        qsMap["recipientsNo"] = "${recipientsNo}";

        callPostAjaxIfFailOnlyMsg(url, qsMap, fn_save_result_cb);
    }

    function fn_save_result_cb(result){
        
        var qsMap = _jsCommon.fn_queryString_toMap();
        var param = {recipientsNo:"${recipientsNo}"}//, mbrSimpletestNo : result["mbrSimpletestNo"]

        location.href = "/matching/simpletest/care/result" + '?' + _jsCommon.fn_queryString_fromMap(param);
    }
</script>