<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

		<!-- 약간동의 상세 팝업 -->
	    <div id="modal_agree_fullsreen" class="modal fullscreen">

	      <div class="modal_header">
	        <h4 class="modal_title">이용약관</h4>
	        <div class="close_x modal-close waves-effect"></div>
	      </div>
	
	      <div class="modal-content">
			<ifame>
			
	      </div>
	      <!-- modal-content -->
	
	      <div class="modal-footer">
	        <div class="btn_area d-flex">
	          <a class="modal-close waves-effect btn btn-large w100p btn_primary">확인</a>
	        </div>
	      </div>
	
	    </div>
	    <!-- 약간동의 상세 팝업 -->
	    
	    
	    <!-- 약관별 내용 정의용 -->
	    <div id="agreeContent" style="display:none;">
	    	<div id="danal1">
	    		다날 개인정보이용동의 내용
	    	</div>
	    	
	    	<div id="danal2">
	    		다날 고유식별정보처리동의 내용
	    	</div>
	    	
	    	<div id="danal3">
	    		다날 서비스이용약관동의 내용
	    	</div>
	    	
	    	<div id="danal4">
	    		다날 통신사이용약관동의
	    	</div>
	    	
	    	<div id="danal5">
	    		다날 통신사이용약관동의
	    	</div>
	    </div>
	    
	    
	    <script>
	    	function setAgreementModal(type, content) {
	    		var title = '';
	    		
	    		switch(type) {
	    			case 'danal1':
	    				title = '개인정보이용동의';
	    				content = $('#danal1').html(); 
	    				break;
	    			case 'danal2': 
	    				title = '고유식별정보처리동의';
	    				content = $('#danal2').html(); 
	    				break;
	    			case 'danal3': 
	    				title = '서비스이용약관동의';
	    				content = $('#danal3').html(); 
	    				break;
	    			case 'danal4': 
	    				title = '통신사이용약관동의';
	    				content = $('#danal4').html(); 
	    				break;
	    			case 'danal5': 
	    				title = '제3자정보제공약관동의';
	    				content = $('#danal4').html(); 
	    				break;
	    			case 'TERMS':
	    				title = '이로움ON 이용약관';
	    				break;
	    			case 'PRIVACY':
	    				title = '이로움ON 개인정보이용약관';
	    				break;
	    		}
	    		
	    		$('#modal_agree_fullsreen .modal_title').text(title);
	    		$('#modal_agree_fullsreen .modal-content').html(content);
	    		$('#modal_agree_fullsreen').modal('open');
	    	}
	    	
	    	//Iframe 약관내용 컨텐츠 설정
	    	function setAgreementModalForIframe(type, termsNo) {
	    		var content = '<iframe src="/matching/terms/' + termsNo + '" width="100%" height="98%"></iframe>';
	    		setAgreementModal(type, content);
	    	}
	    </script>
	    