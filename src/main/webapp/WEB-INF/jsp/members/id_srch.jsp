<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<main id="container">
	<h2 class="text-title">
		이로움ON 멤버스 로그인 정보 찾기 <small>이로움ON 멤버스 관리자 아이디 / 비밀번호를 찾을 수 있습니다.</small>
	</h2>

	<ul class="tabs-list">
		<li><a href="./idSrch" class="active">아이디 찾기</a></li>
		<li><a href="./pswdSrch">비밀번호 찾기</a></li>
	</ul>

	<form:form class="form-container" id="idSrchFrm" name="idSrchFrm" method="post" modelAttribute="bplcVO" action="idSrchDo">
		<fieldset>
			<div class="form-rows">
				<label for="bplcNm" class="form-label">상호명 <i>*</i></label>
				<form:input placeholder="가입 시 입력한 사업자등록증의 상호명을 입력하세요." path="bplcNm" class="form-control w-full" />
				<p class="form-desc">※ 띄어쓰기, 대/소문자, 특수문자 등 일치</p>
			</div>
			<div class="form-rows">
				<label for="brno" class="form-label">사업자 번호 <i>*</i></label>
				<form:input placeholder="가입 시 입력한 사업자번호를 입력하세요." class="form-control w-full" path="brno" maxlength="12"/>
				<p class="form-desc">※ 띄어쓰기 없이 숫자만 입력</p>
			</div>
		</fieldset>
		<div class="btn-group">
			<button type="submit" class="btn-partner large shadow">확인</button>
		</div>
	</form:form>
</main>

<script>
$(function(){

	var regExp = /^([0-9]{3}-[0-9]{2}-[0-9]{5})$/;

	//유효성 검사
	  $("form#idSrchFrm").validate({
			ignore: "input[type='text']:hidden",
			rules: {
				bplcNm : {required : true},
				brno : {required : true, regex : regExp},
			},
			messages : {
				bplcNm : {required : "! 상호명을 입력해주세요."},
				brno : {required : "! 사업자 번호를 입력해주세요."},
			},
		    submitHandler: function (frm) {
		 		frm.submit();
		    }
		});
});

</script>

