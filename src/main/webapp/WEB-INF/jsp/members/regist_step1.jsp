<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<main id="container">
	<h2 class="text-title">
		이로움ON 멤버스 등록 신청 <small>이로움ON과 함께 할 멤버스를 기다리고 있습니다.</small>
	</h2>

	<ul class="tabs-list">
		<li><a href="./registStep1" class="active">약관동의</a></li>
		<li><a href="./registStep2">정보입력</a></li>
		<li><a href="./registStep3">신청완료</a></li>
	</ul>

	<form class="form-container" id="agreeFrm" name="agreeFrm" action="./step1action" method="post">
		<fieldset>
			<dl class="term-agree">
				<dt>이용약관</dt>
				<dd>
					<div>
						e-roumcare 서비스 이용약관 <br>
						<br> e-roumcare 시스템 이용 전 본 이용약관의 모든 내용과 설명을 신중하게 읽으시기 바랍니다. <br>
						<br> 1. 목적<br> 본 이용약관은 (주)티에이치케어컴퍼니(이하 “갑”이라 합니다)와 갑이 제공하는 e-roumcare 서비스(이하 “서비스”이라 합니다)를 사용(이용)하는 기관(이하 “을”)의 권리 및 의무관계를 정함을 목적으로 합니다. <br>
						<br> 2. 서비스 이용료
					</div>
				</dd>
			</dl>
			<div class="form-check mt-1.5 xs:mt-2">
				<input class="form-check-input" type="checkbox" id="agree1" name="agree1" value="Y">
				<label class="form-check-label" for="agree1">이용약관에 동의합니다.</label>
			</div>
			<dl class="term-agree mt-11 xs:mt-14">
				<dt>개인정보취급방침</dt>
				<dd>
					<div>
						e-roumcare 서비스 이용약관 <br>
						<br> e-roumcare 시스템 이용 전 본 이용약관의 모든 내용과 설명을 신중하게 읽으시기 바랍니다. <br>
						<br> 1. 목적<br> 본 이용약관은 (주)티에이치케어컴퍼니(이하 “갑”이라 합니다)와 갑이 제공하는 e-roumcare 서비스(이하 “서비스”이라 합니다)를 사용(이용)하는 기관(이하 “을”)의 권리 및 의무관계를 정함을 목적으로 합니다. <br>
						<br> 2. 서비스 이용료
					</div>
				</dd>
			</dl>
			<div class="form-check mt-1.5 xs:mt-2">
				<input class="form-check-input" type="checkbox" id="agree2" name="agree2" value="Y">
				<label class="form-check-label" for="agree2">이용약관에 개인정보취급방침에 동의 합니다.</label>
			</div>
			<div class="mt-13 xs:mt-16">
				<div class="form-check">
					<input class="form-check-input" type="checkbox" id="allChk">
					<label class="form-check-label" for="allChk">모두 동의 합니다.</label>
				</div>
			</div>
		</fieldset>
		<div class="btn-group">
			<a href="./introduce" class="btn-cancel large shadow">취소</a>
			<button type="submit" class="btn-partner large shadow">확인</button>
		</div>
	</form>
</main>

<script>
$(function(){
	// 모두 동의
	$("#allChk").on("click",function(){
		if($(this).is(":checked")){
			$("#agree1, #agree2").prop("checked",true);
		}else{
			$("#agree1, #agree2").prop("checked",false);
		}
	});

	//동의 체크
	$.validator.addMethod("agreeChk1", function(value,element){
		if($("#agree1").is(":checked")){
			return true;
		}else{
			return false;
		}
	}," ");

	//동의 체크 2
	$.validator.addMethod("agreeChk2", function(value,element){
		if($("#agree2").is(":checked")){
			return true;
		}else{
			return false;
		}
	}," ");


	//유효성 검사
  $("form[name='agreeFrm']").validate({
		ignore: "input[type='text']:hidden",
		rules: {
			agree1 : {agreeChk1 : true},
			agree2 : {agreeChk2 : true},
		},
	    submitHandler: function (frm) {
	 		frm.submit();
	    }
	});

});
</script>