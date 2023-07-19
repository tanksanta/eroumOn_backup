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
				<legend>아이디로 찾기</legend>
				<div class="form-group">
					<label class="form-label" for="mbrId">아이디</label>
					<input class="form-control" type="text" id="mbrId" name="mbrId" maxlength="50">
				</div>
				<%--<div class="form-group">
					<label class="form-label" for="search-item2">이름</label>
					<input class="form-control" type="text" id="search-item2">
				</div> --%>
				<div class="form-auth">
					<img src="/html/page/members/assets/images/img-join-auth.svg" alt="">
					<dl>
						<dt>휴대폰 본인 인증</dt>
						<dd>
							고객님의 개인정보보호를 위해 본인인증이 필요합니다<br> 본인 명의로 된 휴대폰 번호로 실명인증을 완료해 주세요
						</dd>
					</dl>
				</div>
				<div class="form-button">
					<button class="btn btn-primary wide f_submit" type="submit">본인 인증하기</button>
                    <a href="/membership/login" class="btn btn-outline-primary">취소</a>
				</div>
			</fieldset>
			<input type="hidden" id="receiptId" name="receiptId" value="">
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
<script>

	async function f_cert(frm){
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
		            //console.log("response.data", response.data);
		            $("#receiptId").val(response.data.receipt_id);
		            frm.submit();
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


    $(function(){

    	const idchk = /^[a-zA-Z][A-Za-z0-9]{5,14}$/;

		// 간편 회원가입 체크
    	$("#mbrId").on("focusout",function(){
    		let mbrId = $("#mbrId").val();

    		$.ajax({
        		type : "post",
        		url  : "checkEasyMbr.json",
        		data : {mbrId:mbrId},
        		dataType : 'json'
        	})
        	.done(function(data){
				if(!data.result){
					alert("간편가입 회원은 비밀번호 찾기를 이용하실 수 없습니다.");
				}
        	})
        	.fail(function(xhr,status,errorThrown){
        		console.log("아이디 체크 중 오류 발생 : " + error);
        	})
    	});

    	//유효성
    	$("form#srchPswdFrm").validate({
    	    ignore: "input[type='text']:hidden",
    	    rules : {
	  	    	mbrId : {required : true, regex : idchk}
    	    	//, mbrNm : {required : true}
    	    },
    	    messages : {
    	    	mbrId : {required : "! 아이디는 필수 입력 항목입니다.", regex : "! 영문으로 띄어쓰기 없이 6~15자 영문,숫자를 조합하여 입력해 주세요."}
    			//, mbrNm : {required : "! 이름은 필수 입력 항목입니다."}
    	    },
      	    onfocusout: function(el) { // 추가
                if (!this.checkable(el)){
                	this.element(el);
                }
            },
    	    errorPlacement: function(error, element) {
    		    var group = element.closest('.search-group');
    		    if (group.length) {
    		        group.after(error.addClass('text-danger'));
    		    } else {
    		        element.after(error.addClass('text-danger'));
    		    }
    		},
    	    submitHandler: function (frm) {
    	    	f_cert(frm);
    	    	//frm.submit();
    	    }
    	});
    });
    </script>