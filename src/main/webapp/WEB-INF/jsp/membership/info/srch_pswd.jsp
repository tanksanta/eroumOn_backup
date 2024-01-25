<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<main id="container">
	<header id="page-title">
		<h2>
			<span>비밀번호 찾기</span>
			<small>Password Search</small>
		</h2>
	</header>

	<div id="page-content">
		<form action="srchPswdAction" class="search-form" id="srchPswdFrm" name="srchPswdFrm" method="post">
			<fieldset>
				<legend>본인인증으로 찾기</legend>
				<div class="form-group">
					<label class="form-label" for="mbrId">이로움ON 아이디</label>
					<input class="form-control" type="text" id="mbrId" name="mbrId" maxlength="15" placeholder="이로움ON 아이디를 입력해 주세요">
				</div>
				<div class="form-group">
					<label class="form-label" for="mbrId">본인인증</label>
					<button class="btn btn-primary" type="button" style="width:69%" onclick="f_cert();">휴대폰 본인인증</button>
				</div>
				<div class="form-group" style="margin-top:20px; text-align:center;">
					<label class="form-label"></label>
					<p style="font-size:15px;">
						간편가입 회원은 비밀번호 찾기가 제공되지 않습니다.<br>
						각 소셜 서비스를 통해 확인 부탁드립니다.
					</p>
				</div>
				<div class="form-button">
                    <a href="/membership/login" class="btn btn-outline-primary" style="width:100%;">취소</a>
				</div>
			</fieldset>
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
	const idchk = /^[a-zA-Z][A-Za-z0-9]{5,14}$/;

	async function f_cert() {
		var mbrId = $('#mbrId').val();
		if (!mbrId) {
			alert('아이디를 입력해주세요.');
			return;
		}
		if (idchk.test(mbrId) == false) {
			alert('아이디 형식이 올바르지 않습니다.');
			return;
		}
		
		try {
		    const response = await Bootpay.requestAuthentication({
		        application_id: '${_bootpayScriptKey}',
		        pg: '다날',
		        order_name: '본인인증',
		        authentication_id: 'CERT00000000002',
		        extra: { show_close_button: true }
		    })
		    switch (response.event) {
		        case 'done':
		        	postAjaxSearchPswd(response.data.receipt_id, mbrId);
		            break;
		    }
		} catch (e) {
		    switch (e.event) {
		        case 'cancel':
		            console.log(e.message);	// 사용자가 결제창을 닫을때 호출
		            break;
		        case 'error':
		            console.log(e.error_code); // 결제 승인 중 오류 발생시 호출
		            break;
		    }
		}
	}
	
	function postAjaxSearchPswd(receiptId, mbrId) {
		callPostAjaxIfFailOnlyMsg(
			'/membership/srchPswd.json',
			{ receiptId, mbrId },
			function(result) {
				location.href = '/membership/srchPswdConfirm';					
			}
		);
	}
</script>