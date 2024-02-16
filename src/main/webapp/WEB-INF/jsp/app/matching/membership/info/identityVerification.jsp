<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

	<div class="wrapper">
		
	    <header>
	
	    </header>
	
		<main>
	      <section>
	
	        <h3 id="verificationTitle" class="title">
	            휴대폰 번호를<br>입력해주세요
	        </h3>
	
	        <div class="h32"></div>
	        <form>
	
				<div id="mobileDiv">
		            <label class="input_label">휴대폰 번호</label>
		            <input type="text" class="input_basic keycontrol phonenumber" placeholder="010-1234-5678">
		            <div id="mobileErrorMsg" class="vaild_txt error">유효성 체크 텍스트입니다. Help message</div>
		
		            <div class="h20"></div>
	            </div>
	
				<div id="carrierDiv">
		            <label class="input_label">통신사</label>
		            <a class="input_basic fake_select modal-trigger" href="#modal_broad">SKT</a>
					<div id="carrierErrorMsg" class="vaild_txt error">유효성 체크 텍스트입니다. Help message</div>
		
		            <div class="h20"></div>
	            </div>
	
				<div id="residentNumDiv">
		            <label class="input_label">주민등록번호</label>
		            <div class="d-flex gap08">
		              <input id="inputResidentNumFront" type="text" class="input_basic keycontrol numberonly" placeholder="900101" maxlength="6" onkeypress="return inputKeypressEvent(event, 'residentNum');">
		              <div class="align_center">-</div>
		              <input id="inputResidentNumBack" type="text" class="input_basic keycontrol numberonly" maxlength="1" onkeypress="return inputKeypressEvent(event, 'residentNum');">
		            </div>
		            <div id="residentNumErrorMsg" class="vaild_txt error">유효성 체크 텍스트입니다. Help message</div>
		
		            <div class="h20"></div>
	            </div>
	
				<div>
		            <label class="input_label">이름</label>
		            <input id="inputName" type="text" class="input_basic" onkeypress="return inputKeypressEvent(event, 'name');">
		            <div id="nameErrorMsg" class="vaild_txt error">유효성 체크 텍스트입니다. Help message</div>
				</div>
	
	        </form>
	
	
	      </section>
	    </main>
	
	    <footer class="page-footer">
	
	      <div class="btn_area d-flex f-column">
	
	        <div class="relative">
	        	<a id="nextBtn" class="waves-effect btn-large btn_primary w100p modal-trigger" href="#modal_memConsent" onclick="clickNextBtn();">다음</a>
	        	<a id="verifyBtn" class="waves-effect btn-large btn_primary w100p modal-trigger" href="#modal_memConsent">본인인증하기</a>
	        </div>
	      </div>
	
	
	    </footer>
	
	</div>
	
	
	<script>
		var receiptId = '';
		var phase = '';  //현재 어디 입력중인지 체크용
		
		//정규식
		var namechk = /^[ㄱ-ㅎ|가-힣]+$/;
		var phonechk = /^01([0|1|6|7|8|9])-?([0-9]{3,4})-?([0-9]{4})$/;
			
		
		//UI 초기화
		function initialize() {
			$('#verificationTitle').html('이름을<br>입력해주세요');
			
			$('#mobileErrorMsg').addClass('disNone');
			$('#carrierErrorMsg').addClass('disNone');
			$('#residentNumErrorMsg').addClass('disNone');
			$('#nameErrorMsg').addClass('disNone');
			
			$('#mobileDiv').addClass('disNone');
			$('#carrierDiv').addClass('disNone');
			$('#residentNumDiv').addClass('disNone');
			
			$('#nextBtn').removeClass('disNone');
			$('#verifyBtn').addClass('disNone');
			
			phase = 'name';
		}
		
		//다음버튼 클릭
		function clickNextBtn() {
			validateByPhase(phase);
		}
		
		//본인인증 요청
		function requestVerification() {
			const name = 'a';
			const identityNo = 'b';
			const carrier = 'c';
			const phone = 'd';
			
			const param = {
				name,
				identityNo,
				carrier,
				phone,
			};
			
			callPostAjaxIfFailOnlyMsg(
				'/matching/membership/info/requestVerification',
				param,
				function(result) {
					receiptId = result.receiptId;
					$('#mbrInfo').css('display', 'none');
					$('#smsAction').css('display', 'block');
				}
			);
		}
		
		//본인인증 OTP 재전송
		function realarmVerification() {
			callPostAjaxIfFailOnlyMsg(
				'/matching/membership/info/realarmVerification',
				{receiptId},
				function(result) {
				}
			);
		}
		
		//본인인증 확인
		function confirmVerification() {
			const otpNum = '112233';
			
			callPostAjaxIfFailOnlyMsg(
				'/matching/membership/info/confirmVerification',
				{receiptId, otpNum},
				function(result) {
					var type = '${type}';
					if (type === 'regist') {
						registMbr();
					}
				}
			);
		}
	
		//회원가입
		function registMbr() {
			callPostAjaxIfFailOnlyMsg(
				'/matching/membership/regist.json', 
				{},
				function(result) {
					location.href = result.location;
				}
			);
		} 
		
		
		//키입력 이벤트
		function inputKeypressEvent(e, inputType) {
			if (e.keyCode == 13) {
				validateByPhase(inputType);
				return false;
			} else {
				return true;
			}
		}
		
		//단계에 따른 유효성 검사
		function validateByPhase(inputPhase) {
			//이름 인풋창 엔터
			if (inputPhase === 'name') {
				validateName();
			}
			//주민번호 인풋창 엔터
			if (inputPhase === 'residentNum') {
				validateResidentNum();
			}
		}
		
		
		//이름 유효성 검사
		function validateName() {
			var isValid = true;
			var name = $('#inputName').val();
			
			if (!name) {
				$('#nameErrorMsg').text('이름을 입력해주세요');
				isValid = false;
			}
			else if (!namechk.test(name)) {
				$('#nameErrorMsg').text('한글만 입력해주세요');
				isValid = false;
			}
			
			if (isValid) {
				phase = 'residentNum';
			} else {
				phase = 'name';
			}
			
			var showMsg = !isValid;
			showUiForPhase(phase, showMsg);
		}
		
		//주민번호 유효성 검사
		function validateResidentNum() {
			var isValid = true;
			var numFront = $('#inputResidentNumFront').val();
			var numBack = $('#inputResidentNumBack').val();
			var birthMonth = Number(numFront.substr(2, 2));
			var birthDate = Number(numFront.substr(4, 2));
			
			if (!numFront || !numBack) {
				$('#residentNumErrorMsg').text('번호를 확인해주세요');
				isValid = false;
			}
			//월 체크
			else if (birthMonth < 1 || birthMonth > 12) {
				$('#residentNumErrorMsg').text('번호를 확인해주세요');
				isValid = false;
			}
			//일 체크
			else if (birthDate < 1 || birthDate > 31) {
				$('#residentNumErrorMsg').text('번호를 확인해주세요');
				isValid = false;
			}
			
			if (isValid) {
				phase = 'carrier';
			} else {
				phase = 'residentNum';
			}
			
			var showMsg = !isValid;
			showUiForPhase(phase, showMsg);
		}
		
		//단계에 따른 UI노출
		function showUiForPhase(inputPhase, showMsg) {
			$('#mobileDiv').addClass('disNone');
			$('#carrierDiv').addClass('disNone');
			$('#residentNumDiv').addClass('disNone');
			
			//input 노출
			switch (inputPhase) {
				case "mobile" : 
					$('#mobileDiv').removeClass('disNone'); 
				case "carrier" :
					$('#carrierDiv').removeClass('disNone');
				case "residentNum" :
					$('#residentNumDiv').removeClass('disNone');
			}
			
			//타이틀 설정
			switch (inputPhase) {
				case "mobile" : $('#verificationTitle').html('휴대폰 번호를<br>입력해주세요'); break;
				case "carrier" : $('#verificationTitle').html('지금 쓰는 휴대폰은<br>통신사가 어디인가요?'); break;
				case "residentNum" : $('#verificationTitle').html('주민등록번호를<br>입력해주세요'); break;
				case "name" : $('#verificationTitle').html('이름을<br>입력해주세요'); break;
			}
			
			//메시지 표출
			$('#mobileErrorMsg').addClass('disNone');
			$('#carrierErrorMsg').addClass('disNone');
			$('#residentNumErrorMsg').addClass('disNone');
			$('#nameErrorMsg').addClass('disNone');
			
			if (showMsg) {
				switch (inputPhase) {
					case "mobile" : $('#mobileErrorMsg').removeClass('disNone'); break;
					case "carrier" : $('#carrierErrorMsg').removeClass('disNone'); break;
					case "residentNum" : $('#residentNumErrorMsg').removeClass('disNone'); break;
					case "name" : $('#nameErrorMsg').removeClass('disNone'); break;
				}
			}
		}
		
		
		/*
		function nameInputBlurEvent() {
			$('#residentNumDiv').css('display', 'block');
		}
		*/
		
		$(function() {
			(new JsCommon()).fn_keycontrol();
			
			//초기화
			initialize();
		})
	</script>