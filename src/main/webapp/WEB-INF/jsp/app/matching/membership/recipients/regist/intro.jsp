<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

	<div class="wrapper">
	    <!-- 상단 뒤로가기 버튼 추가 -->
		<jsp:include page="/WEB-INF/jsp/app/matching/common/topButton.jsp">
			<jsp:param value="" name="addButton" />
		</jsp:include>

		<!--http://local-on.eroum.co.kr/html/page/app/matching/assets/src/pages/F_SNR_002_eld_regi01.html-->
		<!--
		function fn_next_click(){
			var url = '/matching/membership/recipients/regist/intro?redirectUrl=' + encodeURIComponent(location.pathname + location.search);
			
			location.href = url ;
		}
		-->

		<main>
			<section class="intro bottom_0">

                <h3 class="title">
                    혜택을 받으려면<br />
                    정확한 어르신 정보가 필요해요
                </h3>

                <div class="h32"></div>

                <div class="center">
                    <img class="eld_reg_woman"  src="/html/page/app/matching/assets/src/images/09people/pp_05.svg" alt="">
                </div>




            </section>
	    </main>
	    
		<footer class="page-footer">

            <div class="relative">
                <a class="waves-effect btn-large btn_primary w100p" onclick="fn_next_click()">다음</a>
            </div>

        </footer>

	</div>
	<!-- wrapper -->
	
	
	<script>
		function fn_next_click(){
			var url = './relation';

			var jsCommon = new JsCommon();

			var redirectUrl;

			redirectUrl = jsCommon.fn_redirect_url();
			
			location.href = url + '?startStep=intro&redirectUrl='+ encodeURIComponent(redirectUrl);
		}
	</script>