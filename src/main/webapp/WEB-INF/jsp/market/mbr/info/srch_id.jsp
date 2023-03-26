<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<main id="container" class="is-product">
	<h2 id="page-title">아이디 찾기</h2>

	<div id="page-container">
		<div id="page-content">
			<form action="srchIdAction" class="member-form" id="srchIdFrm" name="srchIdFrm" method="post">
				<ul class="member-tabs is-equal nav">
					<li><a href="#tab-search1" data-bs-toggle="pill" data-bs-target="#srchIdByTelno" class="active" id="srchByTelno">휴대폰 번호로 찾기</a></li>
					<li><a href="#tab-search2" data-bs-toggle="pill" data-bs-target="#srchIdByEml" id="srchByEml">이메일 주소로 찾기</a></li>
				</ul>
				<div class="tab-content">
					<fieldset class="tab-pane show active" id="srchIdByTelno">
						<div class="search-group">
							<label class="form-label" for="mbrId">이름</label>
							<input class="form-control" type="text" id="mbrNm" name="mbrNm" maxlength="50">
						</div>
						<div class="search-group telnoView">
							<label class="form-label" for="mblTelno">휴대폰 번호</label>
							<input class="form-control" type="text" id="mblTelno" name="mblTelno" maxlength="13" oninput="autoHyphen(this);" autofocus />
						</div>
						<div class="search-group emlView" style="display:none;">
							<label class="form-label" for="eml">이메일 주소</label>
							<input class="form-control" type="text" id="eml" name="eml" maxlength="50">
						</div>
						<div class="search-button">
							<button class="btn btn-primary" type="submit">확인</button>
							<a href="${_marketPath}/login" class="btn btn-outline-primary">취소</a>
						</div>
					</fieldset>
				</div>
			</form>

			<div class="member-login-desc">
				<img src="/html/page/market/assets/images/img-login-desc.png" alt="" class="img">
				<div class="cont">
					<p>
						이로움만의<br> 특별함을<br> 누리세요
					</p>
					<a href="${_marketPath}/mbr/regist" class="btn btn-outline-secondary">회원가입하기</a>
				</div>
			</div>
		</div>
	</div>
</main>

<script>
$(function(){

	const emailchk = /^[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*.[a-zA-Z]{2,3}$/i;
	const telchk = /^([0-9]{2,3})?-([0-9]{3,4})?-([0-9]{3,4})$/;

	$("#srchByEml").on("click",function(){
		$(".emlView").css("display","");
		$(".telnoView").css("display","none");
		$("#mblTelno-error").remove();
		$("#eml").removeClass("is-invalid");
	});

	$("#srchByTelno").on("click",function(){
		$(".emlView").css("display","none");
		$(".telnoView").css("display","");
		$("#eml-error").remove();
		$("#mblTelno").removeClass("is-invalid");
	});

	// 정규식 체크
	$.validator.addMethod("regex", function(value, element, regexpr) {
		if(value != ''){
			return regexpr.test(value)
		}else{
			return true;
		}
	}, "형식이 올바르지 않습니다.");

	//휴대폰 번호 && 이메일 검사
	$.validator.addMethod("chkInput", function(value, element) {
		if($("#srchByTelno").hasClass("active")){
			if($("#mblTelno").val() == ''){
				return false;
			}else{
				return true;
			}
		}else{
			if($("#eml").val() == ''){
				return false;
			}else{
				return true;
			}
		}
	});


	//유효성
	$("form#srchIdFrm").validate({
	    ignore: "input[type='text']:hidden",
	    rules : {
	    	mbrNm : {required : true}
	    	, mblTelno : {regex : telchk, chkInput : true}
	    	, eml : {regex : emailchk, chkInput : true}
	    },
	    messages : {
	    	mbrNm : {required : "! 이름은 필수 입력 항목입니다."}
			, mblTelno : {regex : "! 전화번호 형식이 잘못되었습니다.\n(000-0000-0000)", chkInput : "! 휴대폰 번호는 필수 입력 항목입니다."}
			, eml : {regex : "! 이메일 형식이 잘못되었습니다.\n(abc@def.com)", chkInput : "! 이메일 주소는 필수 입력 항목입니다."}
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
   			frm.submit();
	    }
	});
});
</script>
