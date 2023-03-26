<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<main id="container" class="is-product">
	<h2 id="page-title">비밀번호 찾기</h2>

	<div id="page-container">
		<div id="page-content">
			<form action="./srchPswdChg" class="member-form is-noborder" name="pswdChgFrm" id="pswdChgFrm" method="post">
				<picture class="block sm:mb-6">
				<source srcset="/html/page/market/assets/images/txt-search-pw-mobile.svg" media="(max-width: 576px)">
				<source srcset="/html/page/market/assets/images/txt-search-pw.svg">
				<img src="/html/page/market/assets/images/txt-search-pw.svg" alt="본인 인증이 완료되었습니다. 사용하실 새 비밀번호를 입력해주세요" class="mx-auto"> </picture>
				<fieldset>
					<div class="search-group">
						<label class="form-label" for="pswd">새 비밀번호</label>
						<input class="form-control" type="password" id="pswd" name="pswd" maxlength="16">
					</div>
					<div class="search-group">
						<label class="form-label" for="newPswd">비밀번호 확인</label>
						<input class="form-control" type="password" id="newPswd" name="newPswd" maxlength="16">
					</div>
					<div class="search-button">
						<button class="btn btn-primary" type="submit">확인</button>
						<a href="${_marketPath}/login" class="btn btn-outline-primary">취소</a>
					</div>
				</fieldset>
			</form>
		</div>
	</div>
</main>

<script>
$(function(){

	const pswdChk = /^.*(?=.*\d)(?=.*[a-zA-Z])(?=.*[!@#$%^&+=]).*$/;

	//유효성 검사
	$("form#pswdChgFrm").validate({
	    ignore: "input[type='text']:hidden",
	    rules : {
	    	pswd : {required : true, regex : pswdChk}
	    	, newPswd : {required : true, equalTo : "#pswd", }
	    },
	    messages : {
	    	pswd : {required : "! 새 비밀번호는 필수 입력 항목입니다.", regex : "! 8~16자 영문, 숫자, 특수문자를 조합하여 입력해 주세요."}
			, newPswd : {required : "! 새 비밀번호 확인은 필수 입력 항목입니다.", equalTo : "! 비밀번호가 같지 않습니다."}
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
	    	if(confirm("새로운 비밀번호로 수정하시겠습니까?")){
	    		frm.submit();
	    	}else{
	    		return false;
	    	}

	    }
	});
});
</script>