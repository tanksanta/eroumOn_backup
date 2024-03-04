<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

    <div class="wrapper">


        <main>
            <section>

                <h3 class="title">
                    앱 접근 권한을 허용해주세요
                </h3>

                <div class="h08"></div>

                <div class="color_t_s font_sbmr">선택 권한의 경우 허용하지 않아도 서비스를 이용할 수 있으나 일부 서비스 이용이 제한될 수 있습니다</div>

                <div class="h32"></div>
                
                <div class="color_t_p font_sbls">선택 권한</div>

                <div class="h20"></div>

                <div class="img_list_area">
                    <div class ="img_list_box" >
                        <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none">
                            <path fill-rule="evenodd" clip-rule="evenodd" d="M16.2855 3.67451C17.4221 4.81109 18.0606 6.35262 18.0606 7.95998C18.0606 15.0306 21.0909 17.0508 21.0909 17.0508H2.90918C2.90918 17.0508 5.93946 15.0306 5.93946 7.95998C5.93946 6.35262 6.57798 4.81109 7.71456 3.67451C8.85114 2.53794 10.3927 1.89941 12 1.89941C13.6074 1.89941 15.1489 2.53794 16.2855 3.67451ZM14.308 21.1964C15.01 20.6699 15.5935 19.9125 16 19H8C8.4065 19.9125 8.98996 20.6699 9.69196 21.1964C10.394 21.7229 11.1899 22 12 22C12.8101 22 13.606 21.7229 14.308 21.1964Z" fill="#616161"/>
                        </svg>
                    </div>
                    <div class="txt">
                        <div class="title">알림</div>
                        <p class="ctn">알림 메시지 발송</p>
                    </div>
                </div>
            </section>
        </main>

        <footer class="page-footer">

            <div class="btn_area d-flex f-column">

                <a class="waves-effect btn-large btn_primary w100p" onclick="clickConfirmBtn();">확인</a>

            </div>
            
        </footer>

    </div>
    <!-- wrapper -->


	<script>
		var clickCtn = 0;
	
		function clickConfirmBtn() {
			if (clickCtn === 1) {
				location.href = '${redirectUrl}';
				return;
			}
			
			sendDataToMobileApp({ actionName: 'requestPermissions', type: 'push', redirectUrl: '${redirectUrl}' });
			clickCtn++;
		}
	</script>