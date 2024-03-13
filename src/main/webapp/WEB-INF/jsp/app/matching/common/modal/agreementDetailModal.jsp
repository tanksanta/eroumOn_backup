<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

		<!-- 약간동의 상세 팝업 -->
	    <div id="modal_agree_fullsreen" class="modal fullscreen">

	      <div class="modal_header">
	        <h4 class="modal_title">이용약관</h4>
	        <div class="close_x modal-close waves-effect"></div>
	      </div>
	
	      <div class="modal-content">
			
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
	    </div>
	    
	    
	    <script>
	    	function setAgreementModal(type, content) {
	    		var title = '';
	    		
	    		switch(type) {
	    			case 'danal1':
	    				title = '개인정보이용동의';
	    				//content = $('#danal1').html(); 
	    				break;
	    			case 'danal2': 
	    				title = '고유식별정보처리동의';
	    				break;
	    			case 'danal3': 
	    				title = '서비스이용약관동의'; 
	    				break;
	    			case 'danal4': 
	    				title = '통신사이용약관동의'; 
	    				break;
	    			case 'danal5': 
	    				title = '제3자정보제공약관동의'; 
	    				break;
	    			case 'TERMS':
	    				title = '이로움ON 이용약관';
	    				break;
	    			case 'PRIVACY':
	    				title = '이로움ON 개인정보이용약관';
	    				break;
	    			case 'MARKETING':
	    				title = '이벤트 및 마케팅 정보 수신 동의';
	    				break;
	    			case 'NIGHT':
	    				title = '야간 혜택 수신 동의';
	    				break;
	    		}
	    		
	    		$('#modal_agree_fullsreen .modal_title').text(title);
	    		$('#modal_agree_fullsreen .modal-content').html(content);
	    		$('#modal_agree_fullsreen').modal('open');
	    	}
	    	
	    	//이로움 약관내용 컨텐츠 설정
	    	function setAgreementModalForEroum(type, termsNo) {
	    		var content = '<iframe src="/matching/terms/' + termsNo + '" width="100%" height="98%"></iframe>';
	    		setAgreementModal(type, content);
	    	}
	    	
	    	//다날 약관내용 컨텐츠 설정
	    	var danalAgreementUrl = {
	    		SKT: {
	    			//개인정보이용동의
	    			danal1: 'https://wauth.teledit.com/Danal/WebAuth/Notice/Agreement/agreement01_SKT.html',
	    			//고유식별정보처리동의
	    			danal2: 'https://wauth.teledit.com/Danal/WebAuth/Notice/Agreement/agreement02_SKT.html',
	    			//서비스이용약관동의
	    			danal3: 'https://wauth.teledit.com/Danal/WebAuth/Notice/Agreement/agreement03_SKT.html',
	    			//통신사이용약관동의
	    			danal4: 'https://wauth.teledit.com/Danal/WebAuth/Notice/Agreement/agreement04_SKT.html',
	    		},
	    		KT: {
	    			danal1: 'https://wauth.teledit.com/Danal/WebAuth/Notice/Agreement/agreement01_KTF.html',
	    			danal2: 'https://wauth.teledit.com/Danal/WebAuth/Notice/Agreement/agreement02_KTF.html',
	    			danal3: 'https://wauth.teledit.com/Danal/WebAuth/Notice/Agreement/agreement03_KTF.html',
	    			danal4: 'https://wauth.teledit.com/Danal/WebAuth/Notice/Agreement/agreement04_KTF.html',
	    		},
	    		LGT: {
	    			danal1: 'https://wauth.teledit.com/Danal/WebAuth/Notice/Agreement/agreement01_LGT.html',
	    			danal2: 'https://wauth.teledit.com/Danal/WebAuth/Notice/Agreement/agreement02_LGT.html',
	    			danal3: 'https://wauth.teledit.com/Danal/WebAuth/Notice/Agreement/agreement03_LGT.html',
	    			danal4: 'https://wauth.teledit.com/Danal/WebAuth/Notice/Agreement/agreement04_LGT.html',
	    		},
	    		SKT_MVNO: {
	    			danal1: 'https://wauth.teledit.com/Danal/WebAuth/Notice/Agreement/agreement01_SKT.html',
	    			danal2: 'https://wauth.teledit.com/Danal/WebAuth/Notice/Agreement/agreement02_SKT.html',
	    			danal3: 'https://wauth.teledit.com/Danal/WebAuth/Notice/Agreement/agreement03_SKT.html',
	    			danal4: 'https://wauth.teledit.com/Danal/WebAuth/Notice/Agreement/agreement04_SKT.html',
	    			//제3자정보제공약관동의 (알뜰폰만 해당)
	    			danal5: 'https://wauth.teledit.com/Danal/WebAuth/Notice/Agreement/agreement05_SKT.html',
	    		},
	    		KT_MVNO: {
	    			danal1: 'https://wauth.teledit.com/Danal/WebAuth/Notice/Agreement/agreement01_KTF.html',
	    			danal2: 'https://wauth.teledit.com/Danal/WebAuth/Notice/Agreement/agreement02_KTF.html',
	    			danal3: 'https://wauth.teledit.com/Danal/WebAuth/Notice/Agreement/agreement03_KTF.html',
	    			danal4: 'https://wauth.teledit.com/Danal/WebAuth/Notice/Agreement/agreement04_KTF.html',
	    			danal5: 'https://wauth.teledit.com/Danal/WebAuth/Notice/Agreement/agreement05_KTF.html',
	    		},
	    		LGT_MVNO: {
	    			danal1: 'https://wauth.teledit.com/Danal/WebAuth/Notice/Agreement/agreement01_LGT.html',
	    			danal2: 'https://wauth.teledit.com/Danal/WebAuth/Notice/Agreement/agreement02_LGT.html',
	    			danal3: 'https://wauth.teledit.com/Danal/WebAuth/Notice/Agreement/agreement03_LGT.html',
	    			danal4: 'https://wauth.teledit.com/Danal/WebAuth/Notice/Agreement/agreement04_LGT.html',
	    			danal5: 'https://wauth.teledit.com/Danal/WebAuth/Notice/Agreement/agreement05_LGT.html',
	    		},
	    	};
	    	function setAgreementModalForDanal(type, carrierCode) {
	    		var src = danalAgreementUrl[carrierCode][type];
				if (!src) {
					return;
				}
	    		
	    		var content = '<iframe src="' + src + '" width="100%" height="98%"></iframe>';
	    		setAgreementModal(type, content);
	    	}
	    </script>
	    