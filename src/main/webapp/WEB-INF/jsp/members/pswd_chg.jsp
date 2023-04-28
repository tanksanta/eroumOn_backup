<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<main id="container">
	<h2 class="text-title">
		이로움ON 멤버스 로그인 정보 찾기 <small>이로움ON 멤버스 관리자 아이디 / 비밀번호를 찾을 수 있습니다.</small>
	</h2>

	<ul class="tabs-list">
		<li><a href="./idSrch">아이디 찾기</a></li>
		<li><a href="./pswdSrch" class="active">비밀번호 찾기</a></li>
	</ul>

	<form class="form-container" id="pswdChgFrm" name="pswdChgFrm" method="post">
		<p class="text-complate mb-9 xs:mb-11">
			계정 확인이 완료되었습니다.<br> 사용하실 <em>새 비밀번호</em>를 입력해주세요.
		</p>
		<fieldset>
			<div class="form-rows">
				<label for="bplcPswd" class="form-label">새 비밀번호 <i>*</i></label>
				<input type="password" placeholder="비밀번호를 입력하세요." class="form-control" id="bplcPswd" name="bplcPswd"/>
				<p class="form-desc">※ 영문 8 ~ 15자</p>
				<p class="form-desc">※ 특수문자 !, @, #, $, %, ^, &, * 가능</p>
			</div>
			<div class="form-rows">
				<label for="newBplcPswd" class="form-label">새 비밀번호 확인 <i>*</i></label>
				<input type="password" placeholder="비밀번호를 다시 입력하세요." class="form-control" name="newBplcPswd" id="newBplcPswd"/>
			</div>
		</fieldset>
		<div class="btn-group">
			<button type="button" class="btn-cancel large shadow">취소</button>
			<button type="submit" class="btn-partner large shadow">완료</button>
		</div>
	</form>
</main>

<script>
$(function(){

	$.validator.addMethod("pswdConfirm", function(value, element) {
	    var ori = $("#bplcPswd").val();
	    var newP = $("#newBplcPswd").val();
	    if(ori != newP){
	    	return false;
	    }else{
	    	return true;
	    }
	}, "비밀번호가 일치하지 않습니다.");

	//비밀번호 형식 체크
	$.validator.addMethod("passwordCk",  function( value, element ) {
		return this.optional(element) ||  /^.*(?=.*\d)(?=.*[a-zA-Z])(?=.*[!@#$%^&+=]).*$/.test(value);
	}, "비밀번호 형식이 맞지 않습니다.");

	//유효성 검사
	  $("form#pswdChgFrm").validate({
			ignore: "input[type='text']:hidden",
			rules: {
				bplcPswd : {required : true, passwordCk : true},
				newBplcPswd : {required : true, pswdConfirm : true, passwordCk : true}
			},
			messages : {
				bplcPswd : {required : "! 비밀번호를 입력해주세요."},
				newBplcPswd : {required : "! 비밀번호가 일치하지 않습니다."}
			},
		    submitHandler: function (frm) {
		      	$.ajax({
					type: 'post',
					url : 'pswdChgDo',
					data: {
						bplcPswd : $("#bplcPswd").val()
						, newBplcPswd : $("#newBplcPswd").val()
					},
					dataType: 'json'
				})
				.done(function(data){
					console.log(data);
					if(data == true){
						if(confirm("새 비밀번호 설정이 완료되었습니다.")){
							location.href="./login";
						}else{
							return false;
						}
					}
				})
				.fail(function(){
					alert("비밀번호를를 변경하는 중 에러가 발생하였습니다.");
				})
		    }
		});
});
</script>