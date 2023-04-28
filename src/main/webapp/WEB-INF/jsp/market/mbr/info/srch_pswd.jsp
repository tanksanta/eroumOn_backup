<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<main id="container" class="is-product">
        <h2 id="page-title">비밀번호 찾기</h2>

        <div id="page-container">
            <div id="page-content">
                <form action="srchPswdAction" class="member-form" id="srchPswdFrm" name="srchPswdFrm" method="post">
                    <fieldset>
                        <legend>본인 확인 후 비밀번호를 다시 설정하실 수 있습니다.</legend>
                        <div class="search-group">
                            <label class="form-label" for="mbrId">아이디</label>
                            <input class="form-control" type="text" id="mbrId" name="mbrId" maxlength="50">
                        </div>
                        <%--
                        <div class="search-group">
                            <label class="form-label" for="mbrNm">이름</label>
                            <input class="form-control" type="text" id="mbrNm" name="mbrNm" maxlength="50">
                        </div>
                         --%>
                        <div class="search-auth">
                            <img src="/html/page/market/assets/images/img-join-auth.svg" alt="">
                            <dl>
                                <dt>휴대폰 본인 인증</dt>
                                <dd>
                                    고객님의 개인정보보호를 위해 본인인증이 필요합니다<br>
                                    본인 명의로 된 휴대폰 번호로 실명인증을 완료해 주세요
                                </dd>
                            </dl>
                        </div>
                        <div class="search-button">
                            <button class="btn btn-primary wide f_submit" type="submit">본인 인증하기</button>
                            <a href="${_marketPath}/login" class="btn btn-outline-primary">취소</a>
                        </div>
                    </fieldset>
                    <input type="hidden" id="receiptId" name="receiptId" value="">
                </form>

                <div class="member-login-desc">
                    <img src="/html/page/market/assets/images/img-login-desc.png" alt="" class="img">
                    <div class="cont">
                        <p>
                            이로움ON만의<br>
                            특별함을<br>
                            누리세요
                        </p>
                        <a href="${_marketPath}/mbr/regist" class="btn btn-outline-secondary">회원가입하기</a>
                    </div>
                </div>
            </div>
        </div>
    </main>

	<script>


	async function f_cert(frm){
		try {
		    const response = await Bootpay.requestAuthentication({
		        application_id: "${_bootpayScriptKey}",
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
		            break
		        case 'error':
		            console.log(e.error_code); // 결제 승인 중 오류 발생시 호출
		            break
		    }
		}
	}

    $(function(){

    	const idchk = /^[a-zA-Z][A-Za-z0-9]{5,14}$/;

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
                if (!this.checkable(el)){this.element(el); }
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