<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

			<div class="modal modal-default fade" id="regist-eroum-auth-modal" tabindex="-1" aria-hidden="true">
	            <div class="modal-dialog modal-dialog-centered">
	                <div class="modal-content">
	                    <div class="modal-header">
	                        <h2 class="text-title">아이디/비밀번호</h2>
	                        <button data-bs-dismiss="modal" class="btn-close">모달 닫기</button>
	                    </div>
	
	                    <div class="modal-body" style="padding:0; margin:20px 0px;">
	                    	<div class="flex flex-col justify-center items-start" style="width:300px;">
	                    		<label>아이디</label>
	                        	<input type="text" id="rea-id" class="form-control w-full" oninput="oninputInReaModal('id');" maxlength="15" onfocus="onfocusInReaModal('id');" onblur="onblurInReaModal('id');">
	                        	<p id="rea-id-error" class="error text-danger">! 아이디를 입력해 주세요</p>
	                        	<p id="rea-id-valid" class="error text-valid">! 6~15자 영문,숫자를 조합해주세요</p>
	                        	
	                        	<label style="margin-top:10px;">비밀번호</label>
	                        	<input type="password" id="rea-pw" class="form-control w-full" oninput="oninputInReaModal('pw');" maxlength="16" onfocus="onfocusInReaModal('pw')" onblur="onblurInReaModal('pw');">
	                        	<p id="rea-pw-error" class="error text-danger">! 비밀번호를 입력해 주세요</p>
	                        	<p id="rea-pw-valid" class="error text-valid">! 8~15자 영문,숫자,특수문자를 조합해주세요</p>
	                        </div>
	                    </div>
	                    
	                    <div class="modal-footer">
	                        <button id="rea-action" type="button" class="btn btn-warning large w-full" onclick="reaActionBtnClick();">이로움ON 계정 만들기</button>
	                    </div>
	                </div>
	            </div>
	        </div>


    <script>
    	
    	//이로움 인증 등록 모달 띄우기
    	function openRegistEroumAuthModal() {
    		initReaModal(true);
    		
    		$('#regist-eroum-auth-modal').modal('show');
    	}
    	
    	//초기 상태로 만들기
    	function initReaModal(isValueInit) {
    		//아이디 필드 초기화
    		var idInput = $('#rea-id');
    		if (isValueInit) {
    			idInput.val('');	
    		}
    		
    		idInput.removeClass('is-invalid');
    		$('#rea-id-error').css('display', 'none');
    		$('#rea-id-valid').css('display', 'none');
    		
    		//패스워드 필드 초기화
    		var pwInput = $('#rea-pw');
    		if (isValueInit) {
    			pwInput.val('');    			
    		}
    		
    		pwInput.removeClass('is-invalid');
    		$('#rea-pw-error').css('display', 'none');
    		$('#rea-pw-valid').css('display', 'none');
    		
    		$('#rea-action').addClass('disabled');
    	}
    	
    	//각 입력필드 포커스 이벤트
    	function onfocusInReaModal(inputTitle) {
    		var borderEffect = {
         		"border-color" : "#198754",
         		"border-width" : "2px",
         	};
    		
    		if (inputTitle == 'id') {
    			var idInput = $('#rea-id');
    			
    			idInput.css(borderEffect);
    			$('#rea-id-valid').css('display', 'block');
    			
    			//유효성 error효과 삭제
    			idInput.removeClass('is-invalid');
    			$('#rea-id-error').css('display', 'none');
    		}
    		else if (inputTitle == 'pw') {
    			var pwInput = $('#rea-pw');
    			
    			pwInput.css(borderEffect);
    			$('#rea-pw-valid').css('display', 'block');
    			
    			//유효성 error효과 삭제
    			pwInput.removeClass('is-invalid');
    			$('#rea-pw-error').css('display', 'none');
    		}
    	}
    	
    	//각 입력필드 블러 이벤트
    	function onblurInReaModal(inputTitle) {
    		var noneEffect = {
				"border-color" : "",
       			"border-width" : "",
       		};
    		
    		if (inputTitle == 'id') {
				var idInput = $('#rea-id');
    			idInput.css(noneEffect);
    			$('#rea-id-valid').css('display', 'none');
    		}
    		else if (inputTitle == 'pw') {
				var pwInput = $('#rea-pw');
    			pwInput.css(noneEffect);
    			$('#rea-pw-valid').css('display', 'none');
    		}
    	}
    	
    	//각 입력필드 change 이벤트(ID, PW가 유효성이 검증된 경우 계정만들기 버튼 활성화)
    	const idchk = /^[a-zA-Z][A-Za-z0-9]{5,14}$/;
		const pswdChk = /^.*(?=.*\d)(?=.*[a-zA-Z])(?=.*[!@#$%^&+*=*]).*$/;
    	function oninputInReaModal(inputTitle) {
    		var idInput = $('#rea-id');
    		var pwInput = $('#rea-pw');
    		var mbrId = idInput.val();
    		var pswd = pwInput.val();
    		var isValidId = false;
    		var isVlaidPw = false;
    		
    		//검증
    		if (mbrId.length >= 6 && mbrId.length <= 15 && idchk.test(mbrId)) {
    			isValidId = true;
    		}
    		if (pswd.length >= 8 && pswd.length <= 16 && pswdChk.test(pswd)) {
    			isVlaidPw = true;    			
    		}
    		
    		//검증 통과시 버튼 활성화
    		if (isValidId && isVlaidPw) {
    			initReaModal(false);
    			$('#rea-action').removeClass('disabled');
    		} else {
    			$('#rea-action').addClass('disabled');
    			if (inputTitle == 'id') {
    				onfocusInReaModal('id');
    			}
    			else {
    				onfocusInReaModal('pw');
    			}
    		}
    	}
    	
    
	  	//이로움 계정 인증정보 등록
	    function reaActionBtnClick() {
	    	var idInput = $('#rea-id');
    		var pwInput = $('#rea-pw');
    		var mbrId = idInput.val();
    		var pswd = pwInput.val();
	  		
	    	$.ajax({
	    		type : "post",
	    		url  : "/membership/info/myinfo/addEroumAuth.json",
	    		data : {
	    			mbrId,
	    			pswd
	    		},
	    		dataType : 'json'
	    	})
	    	.done(function(data) {
	    		if(data.success) {
	    			location.reload();
	    		}else{
	    			//아이디가 있는 경우는 alert으로 안내를 하지 않는다.
	    			if (data.existId) {
	    				var errorTag = $('#rea-id-error');
	    				errorTag.text('! ' + data.msg);
	    				errorTag.css('display', 'block')
	    				$('#rea-id').addClass('is-invalid');
	    				
	    				$('#rea-action').addClass('disabled');
	    				return;
	    			}
	    			
	    			alert(data.msg);
	    		}
	    	})
	    	.fail(function(data, status, err) {
	    		alert('서버와 연결이 좋지 않습니다.');
	    	});
	    }
    </script>
