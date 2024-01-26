<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<main id="container">
	<header id="page-title">
		<h2>
			<span>아이디 찾기</span>
			<small>Id Search</small>
		</h2>
	</header>

	<div id="page-content">
		<form action="srchIdAction" class="search-form" id="srchIdFrm" name="srchIdFrm" method="post">
			<ul class="member-tabs is-equal nav">
				<li><a href="#tab-search1" data-bs-toggle="pill" data-bs-target="#tab-srchIdByTelno" class="active" id="menu-srchByTelno">본인인증으로 찾기</a></li>
				<li><a href="#tab-search2" data-bs-toggle="pill" data-bs-target="#tab-srchByInfo" id="menu-srchByInfo">가입 시 회원정보로 찾기</a></li>
			</ul>
			<div class="tab-content" id="tab-srchIdByTelno">
				<fieldset class="tab-pane show active">
					<div class="form-group">
						<label class="form-label" for="mbrId">본인인증</label>
						<button class="btn btn-primary" type="button" style="width:69%" onclick="f_cert();">휴대폰 본인인증</button>
					</div>
					<div class="form-group" style="margin-top:20px; text-align:center;">
						<label class="form-label"></label>
						<p style="font-size:15px;">
							간편가입 회원은 아이디 찾기가 제공되지 않습니다.<br>
							각 소셜 서비스를 통해 확인 부탁드립니다.
						</p>
					</div>
					<div class="form-button">
	                    <a href="/membership/login" class="btn btn-outline-primary" style="width:100%;">취소</a>
					</div>
				</fieldset>
			</div>
			<div class="tab-content" style="display:none;" id="tab-srchByInfo">
				<fieldset class="tab-pane show active">
					<div class="form-group">
						<label class="form-label" for="mbrId">이름</label>
						<input class="form-control is-invalid" type="text" id="mbrNm" name="mbrNm" maxlength="50" placeholder="이름을 입력해 주세요">
						<div id="mbrNm-error" class="error text-danger">! 이름은 필수 입력 항목입니다.</div>
					</div>
					<div class="form-group telnoView">
						<label class="form-label">회원정보</label>
						<div style="display:flex; margin-top:10px; margin-bottom:8px;">
							<div class="form-check" style="margin-left:0; width:100%;">
			                    <input class="form-check-input" name="srchTy" type="radio" id="radio-email" value="eml" checked>
			                    <label class="form-check-label" for="radio-email">이메일로 찾기</label>
			                </div>
			                <div class="form-check" style="margin-left:0; width:100%;">
			                    <input class="form-check-input" name="srchTy" type="radio" id="radio-telno" value="tel">
			                    <label class="form-check-label" for="radio-telno">휴대폰번호로 찾기</label>
			                </div>
						</div>
						
						<input class="form-control is-invalid" type="text" id="mbrInfo" placeholder="가입 시 등록한 이메일을 입력해 주세요" />
						<div id="mbrInfo-error" class="error text-danger">! 회원정보는 필수 입력 항목입니다.</div>
					</div>
					<div class="form-group" style="margin-top:20px; text-align:center;">
						<p>
							개인정보 보호를 위해 아이디 또는 이메일의 일부만 제공합니다.<br>
							전체를 확인하시려면 ‘본인인증으로 찾기’ 로 진행해 주세요.
						</p>
					</div>
					<div class="form-button">
						<button class="btn btn-primary" type="button" onclick="clickSearchByMbrInfo();">확인</button>
						<a href="/membership/login" class="btn btn-outline-primary">취소</a>
					</div>
				</fieldset>
			</div>
		</form>

        <dl class="member-social">
            <dt>이로움ON 회원가입</dt>
            <dd>
                <a href="${_membershipPath}/registStep1" class="btn btn-eroum w-full">
                    <span>회원가입</span>
                </a>
            </dd>
        </dl>

        <dl class="member-social">
            <dt>간편 로그인</dt>
            <dd>
                <a href="${_membershipPath}/kakao/auth" class="btn btn-kakao w-full">
                	<span>카카오 로그인</span>
                </a>
                <a href="${_membershipPath}/naver/get" class="btn btn-naver w-full">
                	<span>네이버 로그인</span>
                </a>
            </dd>
        </dl>
	</div>
</main>


<script src="/html/core/script/matchingAjaxCallApi.js?v=<spring:eval expression="@version['assets.version']"/>"></script>
<script>
var validMbrInfo = {};

//회원정보 입력 초기화
function initInputMbrInfo() {
	var inputMbrNm = $('#mbrNm');
	var inputMbrInfo = $('#mbrInfo');
	inputMbrNm.val('');
	inputMbrNm.removeClass('is-invalid');
	inputMbrInfo.val('');
	inputMbrInfo.removeClass('is-invalid');
	
	//유효성 이펙트 끄기
	$('#mbrNm-error').css('display', 'none');
	$('#mbrInfo-error').css('display', 'none');
}

//유효성 검사
const emailchk = /^[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*.[a-zA-Z]{2,3}$/i;
const telchk = /^([0-9]{2,3})?-([0-9]{3,4})?-([0-9]{3,4})$/;
function validateInputMbrInput() {
	validMbrInfo = {};
	var isValid = true;
	
	var inputMbrNm = $('#mbrNm');
	var inputMbrInfo = $('#mbrInfo');
	var mbrNm = inputMbrNm.val();
	var srchTy = $('input[name=srchTy]:checked').val();
	var mbrInfo = inputMbrInfo.val();  //이메일 or 번호
	
	var mbrNmErrorDiv = $('#mbrNm-error');
	var mbrInfoErrorDiv = $('#mbrInfo-error');
	
	//이름 검증
	if (mbrNm.length < 1) {
		inputMbrNm.addClass('is-invalid');
		
		mbrNmErrorDiv.text('! 이름은 필수 입력 항목입니다.');
		mbrNmErrorDiv.css('display', 'block');
		isValid = false;
	} else {
		inputMbrNm.removeClass('is-invalid');
		mbrNmErrorDiv.css('display', 'none');
		
		validMbrInfo.mbrNm = mbrNm;
	}
	
	//회원 정보 검증
	if (mbrInfo.length < 1) {
		inputMbrInfo.addClass('is-invalid');
		
		var srchTyText = srchTy === 'eml' ? '이메일은' : '휴대폰번호는';
		mbrInfoErrorDiv.text('! ' + srchTyText + ' 필수 입력 항목입니다.');
		mbrInfoErrorDiv.css('display', 'block');
		isValid = false;
	}
	else {
		inputMbrInfo.removeClass('is-invalid');
		mbrInfoErrorDiv.css('display', 'none');
	}
	
	if (mbrInfo.length > 0 && srchTy === 'eml') {
		if (emailchk.test(mbrInfo)) {
			inputMbrInfo.removeClass('is-invalid');
			mbrInfoErrorDiv.css('display', 'none');
			
			validMbrInfo.eml = mbrInfo;
		}
		else {
			inputMbrInfo.addClass('is-invalid');
			mbrInfoErrorDiv.text('! 이메일 형식이 잘못되었습니다.(abc@def.com)');
			mbrInfoErrorDiv.css('display', 'block');
			isValid = false;
		}
	}
	else if (mbrInfo.length > 0 && srchTy === 'tel') {
		if (telchk.test(mbrInfo)) {
			inputMbrInfo.removeClass('is-invalid');
			mbrInfoErrorDiv.css('display', 'none');
			
			validMbrInfo.mblTelno = mbrInfo;
		}
		else {
			inputMbrInfo.addClass('is-invalid');
			mbrInfoErrorDiv.text('! 휴대폰번호 형식이 잘못되었습니다.(000-0000-0000)');
			mbrInfoErrorDiv.css('display', 'block');
			isValid = false;
		}
	}
	
	return isValid;
}

//본인인증
async function f_cert(){
	try {
	    const response = await Bootpay.requestAuthentication({
	        application_id: "${_bootpayScriptKey}",
	        pg: '다날',
	        order_name: '본인인증',
	        authentication_id: 'CERT00000000001',
	        extra: { show_close_button: true }
	    })
	    switch (response.event) {
	        case 'done':
	            console.log("response.data", response.data);
	            var receiptId = response.data.receipt_id;
	            
	            postAjaxSearchId(receiptId);
	            break;
	    }
	} catch (e) {
	    switch (e.event) {
	        case 'cancel':
	            console.log(e.message);	// 사용자가 결제창을 닫을때 호출
	            break
	        case 'error':
	            console.log(e.error_code); // 결제 승인 중 오류 발생시 호출
	            break
	    }
	}
}

//회원정보로 찾기에서 확인 버튼 클릭
function clickSearchByMbrInfo() {
	//유효성 검사
	if (!validateInputMbrInput()) {
		return;
	}
	
	postAjaxSearchId(null, validMbrInfo.mbrNm, validMbrInfo.eml, validMbrInfo.mblTelno);
}

//아이디 찾기 ajax 호출
function postAjaxSearchId(receiptId, mbrNm, eml, mblTelno) {
	var requestJson = {};
	if (receiptId) {
		requestJson.receiptId = receiptId;
	}
	if (mbrNm) {
		requestJson.mbrNm = mbrNm;
	}
	if (eml) {
		requestJson.eml = eml;
	}
	if (mblTelno) {
		requestJson.mblTelno = mblTelno;
	}
	
	callPostAjaxIfFailOnlyMsg(
		'/membership/srchId.json',
		requestJson,
		function(result) {
			location.href = '/membership/srchIdConfirm';					
		}
	);
}


$(function(){
	//탭 클릭 이벤트
	$("#menu-srchByTelno").on("click",function(){
		$('#tab-srchIdByTelno').css('display', 'block');
		$('#tab-srchByInfo').css('display', 'none');
	});
	$("#menu-srchByInfo").on("click",function(){
		$('#tab-srchIdByTelno').css('display', 'none');
		$('#tab-srchByInfo').css('display', 'block');
		
		initInputMbrInfo();
	});
	
	//회원정보 라디오버튼 선택 이벤트
	$("input[name=srchTy]").on("change",function() {
		var srchTy = $('input[name=srchTy]:checked').val();
		var inputMbrInfo = $('#mbrInfo');
		inputMbrInfo.val('');
		
		if (srchTy === 'eml') {
			inputMbrInfo.removeClass('keycontrol');
			inputMbrInfo.removeClass('phonenumber');
			inputMbrInfo.attr('placeholder', '가입 시 등록한 이메일을 입력해 주세요');
			
			var target = document.querySelector('#mbrInfo');
			var clone = target.cloneNode(true);
			inputMbrInfo.remove();
			document.querySelector('#mbrInfo-error').insertAdjacentElement('beforebegin', clone);
		} else if (srchTy === 'tel') {
			inputMbrInfo.addClass('keycontrol');
			inputMbrInfo.addClass('phonenumber');
			inputMbrInfo.attr('placeholder', '가입 시 등록한 휴대폰번호를 입력해 주세요');
			
			jsCommon.fn_keycontrol();
		}
	});
});
</script>