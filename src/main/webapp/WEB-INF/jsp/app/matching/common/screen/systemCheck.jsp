<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

  <div class="wrapper align_center">

   		<!-- Modal modal_system_ins -->
        <div id="modal_system_ins" class="modal bottom-sheet">

            <div class="modal_header">
                <h4 class="modal_title"></h4>
                <div class="close_x modal-close waves-effect" onclick="exitApp();"></div>
            </div>

            <div class="img_system_ins">
                <img src="/html/page/app/matching/assets/src/images/18icon/img_system_ins.png" alt="시스템 점검">
            </div>

            <div class="modal-content">

                <div class="h24"></div>

                <div class="color_tp_pp font_shs">[긴급]시스템 점검</div>
                <div class="color_tp_s font_sbms">2024.1.24 08:00 ~ 2024.1.24 09:00</div>

                <div class="h12"></div>
                
                <p class="color_t_s font_sbmr">더 빠르고 안정적인 서비스를 만들기 위해 서버를 점검하고 있습니다</p>


            </div>
            <div class="modal-footer">
                <div class="btn_area d-flex">
                    <a class="modal-close waves-effect btn btn-large w100p btn_primary" onclick="exitApp();">확인</a>
                </div>
            </div>

        </div>

  </div>
  <!-- wrapper -->
  
  
  <script>
  	function exitApp() {
  		sendDataToMobileApp({ actionName: 'exitApp' });
  	}
  
  	$(function() {
  		$('#modal_system_ins').modal('open');
  	})
  </script>