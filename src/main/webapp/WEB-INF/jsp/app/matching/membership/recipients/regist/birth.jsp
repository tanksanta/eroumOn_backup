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
                        <span class="txt">배우자</span>
                    </div>
                    <div>
                        <span class="color_tp_p font_shs">꽃분이</span><span class="color_t_p font_sblr">님,</span>
                    </div>
                </div>

                <div class="h24"></div>

                <h3 class="title">
                    어르신의 생년월일을<br />
                    입력해주세요
                </h3>

                <div class="h32"></div>

                <input type="date" class="input_basic birth" placeholder="1950/01/01" value="1954-06-30">
				<div class="vaild_txt disNone error name">다시 확인해 주세요.</div>

            </section>
        </main>

	    
		<footer class="page-footer">

            <div class="relative">
				<a class="waves-effect btn-large btn_primary w100p btnEvt_me modal-trigger" href="#modal_eld_apply">다음</a>
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
		
        $(function () {

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

		
		function fn_next_click(){
			var jobj = $("input.birth");
			var url = "./regist.json";

			var jsCommon = new JsCommon();
            var qsMap = jsCommon.fn_queryString_toMap();
            
            qsMap['brdt'] = jobj.val();
			qsMap['recipientsNm'] = decodeURI(qsMap['recipientsNm']);

			callPostAjaxIfFailOnlyMsg(url, qsMap, fn_next_cb)
		}

		function fn_next_cb(result){
		}
	</script>