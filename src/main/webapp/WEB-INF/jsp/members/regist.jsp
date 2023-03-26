<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<main id="container">
	<h2 class="text-title">
		이로움 멤버스 <span class="inline-block">등록 신청</span> <small>이로움과 함께 할 멤버를 기다리고 있습니다.</small>
	</h2>

	<ul class="tabs-list">
		<li><a href="./registStep1">약관동의</a></li>
		<li><a href="./registStep2">정보입력</a></li>
		<li><a href="./registStep3">신청완료</a></li>
	</ul>

	<dl class="text-center mt-10 md:mt-12">
		<dt class="text-2xl sm:text-[1.625rem]">멤버스 등록 확인</dt>
		<dd class="mt-3 text-base sm:mt-3.5 sm:text-lg">
			<ul>
				<li>사업자등록증의 <strong class="text-success">상호명, 사업자번호</strong>를 입력하여 인증을 진행해주세요.</li>
				<li><strong class="text-success">상호명 입력 시 사업자등록증의 상호명</strong>과 띄어쓰기, 대/소문자, 특수문자 등이 일치 해야합니다.</li>
				<li>멤버스 계정 확인이 필요한 경우 <strong class="text-success">아이디, 비밀번호 찾기</strong>를 진행해주세요.</li>
			</ul>
		</dd>
	</dl>

	<form:form class="form-container" id="searchBplc" name="searchBplc" modelAttribute="bplcVO" method="post" action="./action">
		<fieldset>
			<div class="form-rows">
				<label for="bplcNm" class="form-label">상호명(법인명) <i>*</i></label>
				<div class="form-group">
					<input type="text" class="form-control" id="bplcNm" name="bplcNm" placeholder="사업자등록증의 상호명을 입력하세요." maxlength="50">
				</div>
				<%--<p class="form-desc">※ 띄어쓰기 없이 숫자만 입력</p> --%>
			</div>
			<div class="form-rows">
				<label for="brno" class="form-label">사업자 번호 <i>*</i></label>
				<div class="form-group">
					<form:input class="form-control" path="brno" placeholder="예) 123-45-67890" maxlength="12" />
				</div>
				<%-- <p class="form-desc">※ 띄어쓰기 없이 숫자만 입력</p> --%>
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
	  $("form[name='searchBplc']").validate({
			ignore: "input[type='text']:hidden",
			rules: {
				bplcNm : {required : true},
				brno : {required : true, regex :regExp}
			},
			messages : {
				bplcNm : {required : "! 상호명을 입력해주세요."},
				brno : {required : "! 사업자 번호를 입력해주세요."}
			},
		    submitHandler: function (frm) {
		    	$.ajax({
					type: 'post',
					url : 'brnoChk',
					data: {
						bplcNm : $("#bplcNm").val()
						, brno : $("#brno").val()
					},
					dataType: 'json'
				})
				.done(function(data){
					console.log(data);
					if(data.aprvTy == "X"){
						alert("미등록 멤버스입니다. 이로움 멤버스 신청 화면으로 이동합니다.");
						frm.submit();
					}else if(data.aprvTy == "W"){
						alert("승인 대기 중인 멤버스입니다.");
						return false;
					}else if(data.aprvTy == "C" && data.bplcPswd == null){
						alert("기존 파트너 확인 완료되었습니다. 약관 동의 화면으로 이동합니다.");
						frm.submit();
					}else{
						if(confirm("이미 등록된 멤버스입니다. 로그인 화면으로 이동하시겠습니까?")){
							location.href="./login";
						}
					}
				})
				.fail(function(){
					alert("정보를 처리하는 중 에러가 발생하였습니다.");
				})
		    }
		});
});
</script>