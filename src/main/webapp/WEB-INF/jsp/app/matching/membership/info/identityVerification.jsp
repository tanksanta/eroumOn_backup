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
		            <input id="inputMobile" type="text" class="input_basic keycontrol phonenumber bder_danger" placeholder="010-1234-5678" onkeypress="return inputKeypressEvent(event, 'mobile');">
		            <div id="mobileErrorMsg" class="vaild_txt error">유효성 체크 텍스트입니다. Help message</div>
		
		            <div class="h20"></div>
	            </div>
	
				<div id="carrierDiv">
		            <label class="input_label">통신사</label>
		            <a id="atagCarrier" class="input_basic fake_select modal-trigger broad_evt bder_danger" href="#modal_broad">SKT</a>
					<div id="carrierErrorMsg" class="vaild_txt error">유효성 체크 텍스트입니다. Help message</div>
		
		            <div class="h20"></div>
	            </div>
	
				<div id="residentNumDiv">
		            <label class="input_label">주민등록번호</label>
		            <div class="d-flex gap08">
		              <input id="inputResidentNumFront" type="text" class="input_basic keycontrol numberonly bder_danger" placeholder="900101" maxlength="6" onkeypress="return inputKeypressEvent(event, 'residentNum');">
		              <div class="align_center">-</div>
		              <div class="input_basic input_password bder_danger">
		               	<input id="inputResidentNumBack" type="text" class="input_noClass keycontrol numberonly" maxlength="1" onkeypress="return inputKeypressEvent(event, 'residentNum');">
		               	<div class="img_password"></div>
		              </div>
		              
		            </div>
		            <div id="residentNumErrorMsg" class="vaild_txt error">유효성 체크 텍스트입니다. Help message</div>
		
		            <div class="h20"></div>
	            </div>
	
				<div>
		            <label class="input_label">이름</label>
		            <input id="inputName" type="text" class="input_basic bder_danger" onkeypress="return inputKeypressEvent(event, 'name');">
		            <div id="nameErrorMsg" class="vaild_txt error">유효성 체크 텍스트입니다. Help message</div>
				</div>
	
	        </form>
	
	
	      </section>
	    </main>
	
	    <footer class="page-footer">
	
	      <div class="btn_area d-flex f-column">
	
	        <div class="relative">
	        	<a id="nextBtn" class="waves-effect btn-large btn_primary w100p modal-trigger" href="#modal_memConsent" onclick="clickNextBtn();">다음</a>
	        	<a id="verifyBtn" class="waves-effect btn-large btn_primary w100p modal-trigger" href="#modal_memConsent" onclick="clickVerifyBtn();">본인인증하기</a>
	        </div>
	      </div>
	
	
	    </footer>
	    
	    
	    <!-- 통신사 선택 바텀 시트 -->
	    <div id="modal_broad" class="modal bottom-sheet">
	
	      <div class="modal_header">
	        <h4 class="modal_title">통신사를 선택해주세요</h4>
	        <div class="close_x modal-close waves-effect"></div>
	      </div>
	
	      <div class="modal-content">
	
	
	        <ul class="broad_area">
	          <li class="modal-close active">SKT</li>
	          <li class="modal-close">KT</li>
	          <li class="modal-close">LG U+</li>
	          <li class="modal-close">SKT 알뜰폰</li>
	          <li class="modal-close">KT 알뜰폰</li>
	          <li class="modal-close">LG U+ 알뜰폰</li>
	        </ul>
	
	      </div>
	
	    </div>
	
	
		<!-- 약관 동의 바텀 시트 -->
		<div id="modal_memConsent" class="modal bottom-sheet">

	      <div class="modal_header">
	        <h4 class="modal_title">인증을 위해 동의가 필요해요</h4>
	        <div class="close_x modal-close waves-effect"></div>
	      </div>
	
	      <div class="modal-content">
	
	        <input type="checkbox" name="" id="chk_join_t" class="chk02 large border_gray total_evt">
	        <label for="chk_join_t" class="fw600">전체 동의하기</label>
	
	        <div class="h12"></div>
	
	        <div class="scrollBox">
	
	          <div class="group_chk_area">
	            <span class="icon_btn i_right waves-effect modal-trigger" onclick="showAgreementDetailModal('danal1')"></span>
	            <div>
	              <input type="checkbox" name="check-agree" id="chk_j01" class="chk01_2 large total_evt_sub">
	              <label for="chk_j01">[필수] 개인정보이용동의</label>
	            </div>
	          </div>
	          <div class="group_chk_area">
	            <span class="icon_btn i_right waves-effect modal-trigger" onclick="showAgreementDetailModal('danal2')"></span>
	            <div>
	              <input type="checkbox" name="check-agree" id="chk_j02" class="chk01_2 large total_evt_sub">
	              <label for="chk_j02">[필수] 고유식별정보처리동의</label>
	            </div>
	          </div>
	          <div class="group_chk_area">
	            <span class="icon_btn i_right waves-effect modal-trigger" onclick="showAgreementDetailModal('danal3')"></span>
	            <div>
	              <input type="checkbox" name="check-agree" id="chk_j03" class="chk01_2 large total_evt_sub">
	              <label for="chk_j03">[필수] 서비스이용약관동의</label>
	            </div>
	          </div>
	          <div class="group_chk_area">
	            <span class="icon_btn i_right waves-effect modal-trigger" onclick="showAgreementDetailModal('danal4')"></span>
	            <div>
	              <input type="checkbox" name="check-agree" id="chk_j04" class="chk01_2 large total_evt_sub">
	              <label for="chk_j04">[필수] 통신사이용약관동의</label>
	            </div>
	          </div>
	          <div class="group_chk_area">
	            <span class="icon_btn i_right waves-effect modal-trigger" onclick="showAgreementDetailModal('danal5')"></span>
	            <div>
	              <input type="checkbox" name="check-agree" id="chk_j04" class="chk01_2 large total_evt_sub">
	              <label for="chk_j04">[필수] 제3자정보제공약관동의</label>
	            </div>
	          </div>
	          <div class="group_chk_area">
	            <span class="icon_btn i_right waves-effect modal-trigger" onclick="showAgreementDetailModal('terms')"></span>
	            <div>
	              <input type="checkbox" name="check-agree" id="chk_j05" class="chk01_2 large total_evt_sub">
	              <label for="chk_j05">[필수] 이로움ON 이용약관</label>
	            </div>
	          </div>
	          <div class="group_chk_area">
	            <span class="icon_btn i_right waves-effect modal-trigger" onclick="showAgreementDetailModal('privacy')"></span>
	            <div>
	              <input type="checkbox" name="check-agree" id="chk_j06" class="chk01_2 large total_evt_sub">
	              <label for="chk_j06">[필수] 이로움ON 개인정보처리방침</label>
	            </div>
	          </div>
	          <div class="group_chk_area">
	            <div>
	              <input type="checkbox" name="check-agree" id="chk_j07" class="chk01_2 large total_evt_sub">
	              <label for="chk_j07">[필수] 만 14세 이상입니다</label>
	            </div>
	          </div>
	          <div class="group_chk_area">
	            <span class="icon_btn i_right waves-effect modal-trigger" onclick="showAgreementDetailModal('privacy')"></span>
	            <div>
	              <input type="checkbox" name="check-agree" id="chk_j08" class="chk01_2 large total_evt_sub">
	              <label for="chk_j08">[선택] 이벤트 및 마케팅 정보 수신 동의</label>
	            </div>
	          </div>
	          <div class="group_chk_area">
	            <span class="icon_btn i_right waves-effect modal-trigger" onclick="showAgreementDetailModal('privacy')"></span>
	            <div>
	              <input type="checkbox" name="check-agree" id="chk_j09" class="chk01_2 large total_evt_sub">
	              <label for="chk_j09">[선택] 야간 혜택 수신 동의</label>
	            </div>
	          </div>
	
	          <div class="h20"></div>
	
	
	        </div>
	        <!-- scrollBox -->
	
	      </div>
	      <!-- modal-content -->
	      <div class="modal-footer">
	        <div class="btn_area d-flex">
	          <a class="modal-close waves-effect btn btn-large w100p btn_primary">확인</a>
	        </div>
	      </div>
	
	    </div>
	    <!-- 약간동의 바텀 시트 끝 -->
	    
	    
	    <!-- 약간동의 상세 -->
	    <jsp:include page="/WEB-INF/jsp/app/matching/common/modal/agreementDetailModal.jsp" />
	    
	</div>
	
	
	<script>
		var afterWorkType = '${type}';   //본인인증 후 다음 작업
		var termsHisList = [   //이용약관 버전 리스트
			<c:forEach var="termsInfo" items="${termsHisList}" varStatus="status">
			{
	   			'termsNo': '${termsInfo.termsNo}',
	   			'termsDt': '${termsInfo.termsDt}',
			},
	   		</c:forEach>
		];
		var privacyHisList = [   //개인정보 버전 리스트
			<c:forEach var="privacyInfo" items="${privacyHisList}" varStatus="status">
	   		{
	   			'termsNo': '${privacyInfo.termsNo}',
	   			'termsDt': '${privacyInfo.termsDt}',
	   		},
	   		</c:forEach>
		];
		
		var receiptId = '';
		var phase = '';  //현재 어디 입력중인지 체크용
		
		//정규식
		var namechk = /^[ㄱ-ㅎ|가-힣]+$/;
		var phonechk = /^01([0|1|6|7|8|9])-?([0-9]{3,4})-?([0-9]{4})$/;
			
		
		//UI 초기화
		function initialize() {
			$('#verificationTitle').html('이름을<br>입력해주세요');
			
			var inputName = $('#inputName');
			var inputResidentNumFront = $('#inputResidentNumFront');
			var inputResidentNumBack = $('#inputResidentNumBack');
			//주민번호 뒷자리는 부모의 테두리를 변경해야 한다(유효성 검사 시)
			var inputResidentBackParent = inputResidentNumBack.parent();
			var atagCarrier = $('#atagCarrier');
			var inputMobile = $('#inputMobile');
			
			//값 초기화
			inputName.val('');
			inputResidentNumFront.val('');
			inputResidentNumBack.val('');
			atagCarrier.text('통신사');
			inputMobile.val('');
			
			//유효성 효과 끄기
			inputName.removeClass('bder_danger');
			inputResidentNumFront.removeClass('bder_danger');
			inputResidentBackParent.removeClass('bder_danger');
			atagCarrier.removeClass('bder_danger');
			inputMobile.removeClass('bder_danger');
			
			
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
					if (afterWorkType === 'regist') {
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
			//휴대폰 번호 인풋창 엔터
			if (inputPhase === 'mobile') {
				validateMobile();
			}
		}
		
		
		//이름 유효성 검사
		function validateName() {
			var isValid = true;
			var inputName = $('#inputName');
			var name = inputName.val();
			
			if (!name) {
				$('#nameErrorMsg').text('이름을 입력해주세요');
				isValid = false;
			}
			else if (!namechk.test(name)) {
				$('#nameErrorMsg').text('한글만 입력해주세요');
				isValid = false;
			}
			
			if (isValid) {
				inputName.removeClass('bder_danger');
				phase = 'residentNum';
			} else {
				inputName.addClass('bder_danger');
				phase = 'name';
			}
			
			var showMsg = !isValid;
			showUiForPhase(phase, showMsg);
			return isValid;
		}
		
		//주민번호 유효성 검사
		function validateResidentNum() {
			var isValid = true;
			var inputResidentNumFront = $('#inputResidentNumFront');
			var inputResidentNumBack = $('#inputResidentNumBack');
			//주민번호 뒷자리는 부모의 테두리를 변경해야 한다(유효성 검사 시)
			var inputResidentBackParent = inputResidentNumBack.parent();
			var numFront = inputResidentNumFront.val();
			var numBack = inputResidentNumBack.val();
			var birthMonth = Number(numFront.substr(2, 2));
			var birthDate = Number(numFront.substr(4, 2));
			
			//앞자리 체크
			if (!numFront) {
				inputResidentNumFront.addClass('bder_danger');
				isValid = false;
			}
			//월 체크
			else if (birthMonth < 1 || birthMonth > 12) {
				inputResidentNumFront.addClass('bder_danger');
				isValid = false;
			}
			//일 체크
			else if (birthDate < 1 || birthDate > 31) {
				inputResidentNumFront.addClass('bder_danger');
				isValid = false;
			}
			else {
				inputResidentNumFront.removeClass('bder_danger');
			}
			
			//뒷자리 체크
			if (!numBack) {
				inputResidentBackParent.addClass('bder_danger');
				isValid = false;
			}
			else {
				inputResidentBackParent.removeClass('bder_danger');
			}
			
			if (isValid) {
				phase = 'carrier';
			} else {
				$('#residentNumErrorMsg').text('번호를 확인해주세요');
				phase = 'residentNum';
			}
			
			var showMsg = !isValid;
			showUiForPhase(phase, showMsg);
			return isValid;
		}
		
		//핸드폰 번호 유효성 검사
		function validateMobile() {
			var isValid = true;
			var inputMobile = $('#inputMobile');
			var mobile = inputMobile.val();
			
			if (!mobile) {
				$('#mobileErrorMsg').text('번호를 확인해주세요');
				isValid = false;
			}
			//번호 형식 검사
			else if (!phonechk.test(mobile)) {
				$('#mobileErrorMsg').text('번호를 확인해주세요');
				isValid = false;
			}
			
			if (isValid) {
				inputMobile.removeClass('bder_danger');
				showUiForPhase('mobile', false);
			} else {
				inputMobile.addClass('bder_danger');
				showUiForPhase('mobile', true);
			}
			return isValid;
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
			
			//타이틀 및 버튼 설정
			$('#nextBtn').removeClass('disNone');
			switch (inputPhase) {
				case "mobile" : 
					$('#verificationTitle').html('휴대폰 번호를<br>입력해주세요');
					$('#nextBtn').addClass('disNone');
					$('#verifyBtn').removeClass('disNone');
					break;
				case "carrier" : 
					$('#verificationTitle').html('지금 쓰는 휴대폰은<br>통신사가 어디인가요?');
					$('#nextBtn').addClass('disNone');
					break;
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
		
		//본인인증하기 버튼 클릭
		function clickVerifyBtn() {
			var nameVaild = validateName();
			var residentVaild = validateResidentNum();
			var mobileVaild = validateMobile();
			if (!nameVaild || !residentVaild || !mobileVaild) {
				//return;
			}
			
			$('#modal_memConsent').modal('open');
		}
		
		//약관동의 상세보기 모달보기
		function showAgreementDetailModal(type) {
			if (type === 'terms') {
				setAgreementModalForIframe('TERMS', Number(termsHisList[0].termsNo));
			} else if (type === 'privacy') {
				setAgreementModalForIframe('PRIVACY', Number(privacyHisList[0].termsNo));
			} else {
				setAgreementModal(type);	
			}
		}
		
		
		$(function() {
			(new JsCommon()).fn_keycontrol();
			
			//초기화
			initialize();
			
			//통신사 클릭 시 바로 다음단계 처리
			$('.broad_area li').click(function() {
				phase = 'mobile';
				showUiForPhase(phase);
			});
		})
	</script>