<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

	<div class="wrapper">
	    <!-- 상단 뒤로가기 버튼 추가 -->
		<jsp:include page="/WEB-INF/jsp/app/matching/common/topButton.jsp">
			<jsp:param value="" name="addButton" />
		</jsp:include>

		<!--http://local-on.eroum.co.kr/html/page/app/matching/assets/src/pages/F_SNR_002_eld_regi01.html-->

        <main>
            <section class="intro">

                <div class="family_sel">
                    <div class="item partner active">
                        <span class="txt">${relationNm}</span>
                    </div>
                    <div>
                        <span class="color_tp_p font_shs">${recipientsNm}</span><span class="color_t_p font_sblr">님,</span>
                    </div>
                </div>

                <div class="h24"></div>

                <h3 class="title">
                    어르신의 생년월일을<br />
                    입력해주세요
                </h3>

                <div class="h32"></div>

                <input type="text" class="input_basic birth keycontrol birthdt10" placeholder="1958/01/01" value="${birth}" ${disabled}>
				<div class="vaild_txt birth disNone error name">다시 확인해 주세요.</div>

            </section>
        </main>

	    
		<footer class="page-footer">

            <div class="relative">
				<a class="waves-effect btn-large btn_primary w100p btnEvt_me modal-trigger" onclick="fn_next_birth($(this))">다음</a>
            </div>

        </footer>

	</div>
	<!-- wrapper -->
	
	
    <div id="modal_eld_apply" class="modal bottom-sheet">

        <div class="modal_header">
            <h4 class="modal_title">어르신 등록을 위해 동의해주세요</h4>
            <div class="close_x modal-close waves-effect"></div>
        </div>

        <div class="modal-content">



            <div class="group_chk_area">
                <div>
                    <input type="checkbox" name="" id="chk_j01" class="chk01_2 large evt_chk">
                    <label for="chk_j01">[필수] 회원은 어르신의 가족이며 어르신 등록 및 관리에 동의합니다.</label>
                </div>
            </div>

            <div class="h32"></div>


        </div>
        <!-- modal-content -->
        <div class="modal-footer">
            <div class="btn_area d-flex">
                <a class="modal-close waves-effect btn btn-large w100p btn_disable evt_btn" onclick="fn_next_click()">동의하고 등록하기</a>
            </div>
        </div>

    </div>
	
	<script>
		var _jsCommon
        var _dateValid = false;
        $(function () {
            _jsCommon = new JsCommon();
            _jsCommon.fn_keycontrol();

            $('.input_basic.birth').on('blur', function () {
                _dateValid = _jsCommon.fn_date10_slash_check($(this).val());
                if (_dateValid){
                    $(".vaild_txt.birth").addClass("disNone");
                    
                }else{
                    $(".vaild_txt.birth").removeClass("disNone");
                }
            });

            //동의시 버튼 활성화
            $('.evt_chk').on('click', function () {

                if ($(this).is(':checked') == true) {
                    $('.evt_btn').removeClass('btn_disable');
                    $('.evt_btn').addClass('btn_primary');
                }

                else {
                    $('.evt_btn').removeClass('btn_primary');
                    $('.evt_btn').addClass('btn_disable');
                }

            });

        });
        function fn_change_to_next(){
            $(".btnEvt_me").removeAttr("onclick");
            $(".btnEvt_me").attr("href", "#modal_eld_apply");
        }
        function fn_next_birth(){
            if (_dateValid){
                fn_change_to_next()
                return;
            }

            _dateValid = _jsCommon.fn_date10_slash_check($('.input_basic.birth').val());
            if (_dateValid){
                fn_change_to_next()
                return;
            }

            $(".vaild_txt.birth").removeClass("disNone");
        }

		var m_redirectUrl;
        var m_startStep;
        function fn_convert_redirectUrl(){
            var jsCommon = new JsCommon();
            var redirectUrlAct = '', redirectUrlOrigin = jsCommon.fn_redirect_url();

            while(true){
                try{
                    redirectUrlAct = decodeURIComponent(redirectUrlOrigin);
                    if (redirectUrlOrigin == redirectUrlAct){
                        break;
                    }else{
                        redirectUrlOrigin = redirectUrlAct;
                    }
                }catch{
                    redirectUrlAct = redirectUrlOrigin;
                    break;
                }
            }

            redirectUrlAct = redirectUrlAct.replaceAll("&amp;", "&")
            return redirectUrlAct;
        }

        function fn_HistoryStack_recipients_reset(startStep){
            if (startStep == 'intro'){
                popHistoryStack(-3);
            }else if (startStep == 'relation'){
                popHistoryStack(-2);
            }
        }

		function fn_next_click(){
            if (!_dateValid){
                showAlertPopup("생년월일을 확인하여 주십시오.");
                return;
            }
			var jobj = $("input.birth");
			var url = "./regist.json";

			var jsCommon = new JsCommon();
            var qsMap = jsCommon.fn_queryString_toMap();

            m_redirectUrl = fn_convert_redirectUrl();
            
            qsMap['brdt'] = jobj.val().replaceAll('-', '').replaceAll('/', '');
			qsMap['recipientsNm'] = decodeURI(qsMap['recipientsNm']);

            delete qsMap['redirectUrl'];

            m_startStep = qsMap["startStep"];

			callPostAjaxIfFailOnlyMsg(url, qsMap, fn_next_cb);
		}

		function fn_next_cb(result){
            var jsCommon = new JsCommon();
            var param;
            var qsMap;

            if (m_redirectUrl.indexOf("?") >= 0){
                param = m_redirectUrl.substring(m_redirectUrl.indexOf("?") + 1);

                m_redirectUrl = m_redirectUrl.substr(0, m_redirectUrl.indexOf("?"));
                qsMap = jsCommon.fn_queryString_toMap(param);
            }else{
                qsMap = {};
            }

            if (result && result.recipientsNo){
                qsMap["recipientsNo"] = result.recipientsNo;
            }

            m_redirectUrl += "?" + jsCommon.fn_queryString_fromMap(qsMap);

            fn_HistoryStack_recipients_reset(m_startStep);

            location.href = "/matching/common/complete?msg=" + encodeURIComponent("어르신이<br>등록되었어요")+"&redirectUrl="+encodeURIComponent(m_redirectUrl);
		}
	</script>