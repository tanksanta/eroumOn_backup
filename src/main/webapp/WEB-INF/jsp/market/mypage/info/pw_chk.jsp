<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<main id="container">
	<jsp:include page="../../layout/page_header.jsp">
		<jsp:param value="회원 정보 수정" name="pageTitle" />
	</jsp:include>

	<div id="page-container">

		<jsp:include page="../../layout/page_sidenav.jsp" />

		<div id="page-content">
			<div class="items-center justify-between md:flex">
			    <div class="space-y-1.5">
			        <p class="text-alert">고객님의 개인정보를 안전하게 취급하며, 회원님의 동의 없이는 회원정보를 공개 및 변경하지 않습니다.</p>
			        <p class="text-alert">회원님의 개인정보 보호를 위해 비밀번호를 다시 입력해 주세요.</p>
			    </div>
			</div>

            <form id="pwdChkFrm" name="pwdChkFrm" method="post" action="${_marketPath}/mypage/info/action" class="mypage-modify-password">
                <fieldset>
                    <div class="form-group">
                        <label for="pswd" class="font-bold">비밀번호</label>
                        <input type="password" class="form-control" name="pswd" id="pswd">
                    </div>
                </fieldset>
                <button type="submit" class="btn-large btn-primary">확인</button>
            </form>
		</div>
	</div>
</main>

<script>
$(function(){

	const pswdChk = /^.*(?=.*\d)(?=.*[a-zA-Z])(?=.*[!@#$%^&+=]).*$/;

	//유효성 검사
	$("form[name='pwdChkFrm']").validate({
	    ignore: "input[type='text']:hidden",
	    rules : {
	    	pswd : {required : true, regex : pswdChk}
	    },
	    messages : {
	    	pswd : {required : "비밀번호는 필수 입력 항목입니다.", regex : "8~16자 영문, 숫자, 특수문자를 조합하여 입력해 주세요."}
	    },
	    errorElement:"p",
	    errorPlacement: function(error, element) {
		    var group = element.closest('.form-group');
		    if (group.length) {
		        group.after(error.addClass('text-alert is-danger'));
		    } else {
		        element.after(error.addClass('text-alert is-danger'));
		    }
		},
	    submitHandler: function (frm) {
    		frm.submit();
	    }
	});
});
</script>