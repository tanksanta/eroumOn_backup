<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

	<div class="wrapper">
	    <!-- 상단 뒤로가기 버튼 추가 -->
		<jsp:include page="/WEB-INF/jsp/app/matching/common/topButton.jsp">
			<jsp:param value="" name="addButton" />
		</jsp:include>

		<!--http://local-on.eroum.co.kr/html/page/app/matching/assets/src/pages/F_SNR_002_eld_regi02.html-->

        <main>
            <section class="intro">

                <h3 class="title">
                    본인과의 가족관계를<br />
                    선택해주세요
                </h3>

                <div class="h32"></div>

                <div class="family_tree_area">

                    <div class="tree">
                        <div class="dept1 w50p">
                            <div class="item grandpa" code="005">
                                <span class="txt">할아버지</span>
                            </div>
                            <div class="item grandma" code="009">
                                <span class="txt">할머니</span>
                            </div>
                        </div>
                    </div>
                    <div class="tree">
                        <div class="dept1">
                            <div class="item father" code="002">
                                <span class="txt">아버지</span>
                            </div>
                            <div class="item mother" code="008">
                                <span class="txt">어머니</span>
                            </div>
                        </div>
                        <div class="dept1">
                            <div class="item p_father" code="006">
                                <span class="txt">배우자 아버지</span>
                            </div>
                            <div class="item p_mother" code="010">
                                <span class="txt">배우자 어머니</span>
                            </div>
                        </div>
                    </div>
                    <div class="tree">
                        <div class="dept1">
                            <div class="item me" code="007">
                                <span class="txt">나(본인)</span>
                            </div>
                            <div class="item partner" code="001">
                                <span class="txt">배우자</span>
                            </div>
                        </div>
                    </div>
                    <div class="tree">
                        <div class="dept2">
                            <div class="item brother" code="004">
                                <span class="txt">형제자매</span>
                            </div>
                            <div class="item child" code="003">
                                <span class="txt">자녀</span>
                            </div>
                        </div>
                    </div>

                </div>
                <!-- family_tree_area -->





            </section>
        </main>


        <footer class="page-footer">

            <div class="relative">
                <a class="waves-effect btn-large btn_primary w100p btnEvt_me btn_disable" onclick="fn_next_click($(this))">다음</a>
            </div>

        </footer>

	</div>
	<!-- wrapper -->
	
	
	<script>
		function fn_next_click(jobjTarget){
            if (jobjTarget.hasClass('btn_disable')){
                return;
            }

            var jobj = $(".item.active");
            if (jobj == undefined || jobj.length < 1){
                showAlertPopup("관계를 선택하여 주십시오");
                return;
            }

            var jsCommon = new JsCommon();
            var qsMap = jsCommon.fn_queryString_toMap();
            
            qsMap['relationCd'] = jobj.attr('code');

			var url = './name?' + jsCommon.fn_queryString_fromMap(qsMap);

			location.href = url;
		}


	</script>