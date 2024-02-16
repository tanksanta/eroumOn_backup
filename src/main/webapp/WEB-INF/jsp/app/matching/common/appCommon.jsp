<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%-- 전역적으로 APP 관련 처리 스크립트 --%>
<script>
	var popAlert, popConfirm;
	function showAlertPopup(msg) {
		if (popAlert == undefined) popAlert = new JsMvpPopupAlerts(window, '.modal.static.alert');

		popAlert.fn_show_popup({message_txt: msg});
	}

	/*
	async function fn_test_confirm(){
		const asyncConfirm = await showAlertPopup('제목', '내용', '확인');
		if (asyncConfirm != 'confirm'){
			return;
		}
	}
	
	*/
	async function showConfirmPopup(title, msg, btn) {
		if (popConfirm == undefined) popConfirm = new JsHouse2309PopupConfirm(window, '.modal.static.confirm');
		
		return popConfirm.fn_show_popup({title_txt: title, message_txt: msg, confirm_txt: btn});
	}

	//App 토큰 처리
	function checkAppToken() {
		var appMatToken = '${appMatToken}';
		
		if (appMatToken) {
			sendDataToMobileApp({actionName: 'saveToken', token: appMatToken});
		}
	}
</script>

<div class="modal2-con">
  <!-- popAlert -->
  <div id="popAlert" class="modal static alert">

    <div class="modal_header">
        <h4 class="modal_title"><!--title제목--></h4>
    </div>
    <div class="modal-content">
      
      <!--p>
        Lorem Ipsum is simply dummy text of the printing and typesetting industry.
        Lorem Ipsum has been the industry's standard dummy text ever since the 1500s,
        when an unknown printer took a galley of type and scrambled it to make a type specimen book.
      </p>
      <p class="fs16">내용넣는곳</p-->

    </div>
    <div class="modal-footer">
        <div class="btn_area d-flex">
            <a class="modal-close waves-effect btn btn-large w100p btn_primary">확인</a>
        </div>
    </div>
  </div>

  <!-- popConfirm -->
  <div id="popConfirm" class="modal static confirm">

    <div class="modal_header">
        <h4 class="modal_title"><!--title제목--></h4>
    </div>
    <div class="modal-content">
      
      <!--p>내용넣는곳</p>
      <p class="fs16">내용넣는곳</p-->

    </div>
    <div class="modal-footer">
        <div class="btn_area d-flex">
            <a class="modal-close waves-effect btn btn-large w100p btn_cancel">취소</a>
            <a class="modal-close waves-effect btn btn-large w100p btn_primary">확인</a>
        </div>
    </div>
  </div>


</div>
