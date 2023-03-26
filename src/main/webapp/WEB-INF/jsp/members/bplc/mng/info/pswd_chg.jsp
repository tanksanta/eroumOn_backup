<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<jsp:include page="../layout/page_header.jsp">
	<jsp:param value="비밀번호 변경" name="pageTitle" />
</jsp:include>
<form:form action="./newPswdAction" id="pswdChgFrm" name="pswdChgFrm" method="post" modelAttribute="bplcVO">
	<fieldset>
		<legend class="text-title2">비밀번호 확인</legend>
		<table class="table-detail">
			<colgroup>
				<col class="w-43">
				<col>
			</colgroup>
			<tbody>
				<tr >

					<th scope="row"><label for="bplcPswd" class="">새 비밀번호</label></th>
					<td>
						<div class="form-group w-75">
							<form:input type="password" path="bplcPswd" class="form-control w-75" placeholder="새 비밀번호를 입력하세요." maxlength="50" />
						</div>
					</td>
				</tr>
				<tr>
					<th scope="row"><label for="pswdConfirm">새 비밀번호 확인</label></th>
					<td>
						<div class="form-group w-75">
						<input type="password" id="pswdConfirm" name="pswdConfirm" class="form-control w-75" placeholder="새 비밀번호를 재입력하세요.">
						</div>
						</td>
				</tr>
			</tbody>
		</table>
		<div class="mt-5">
			<strong class="text-danger">! 비밀번호 변경 시 유의사항</strong>
			<p class="mt-2">
				* 띄어쓰기 없이 8~16자 영문,숫자,특수문자를 조합하여 입력하세요.<br> * 특수문자는 !, @, #, $, %, ^, &, *만 사용 가능합니다.<br> * 아이디와 동일한 비밀번호는 사용할 수 없습니다.
			</p>
		</div>
	</fieldset>
	<div class="btn-group center mt-10">
		<button type="submit" class="btn-save w-52 large shadow">확인</button>
		<a href="./newPswd" class="btn-cancel w-52 large shadow">취소</a>
	</div>
</form:form>

<script>
$(function(){

	$.validator.addMethod("pswdConfirm", function(value, element) {
	    var ori = $("#bplcPswd").val();
	    var newP = $("#pswdConfirm").val();
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

	//유효성
	$("form#pswdChgFrm").validate({
	    ignore: "input[type='text']:hidden",
	    rules : {
	    	bplcPswd : {required : true, passwordCk : true},
	    	pswdConfirm : {required : true, pswdConfirm : true, passwordCk : true}
	    },
	    messages : {
	    	bplcPswd : {required : "새 비밀번호를 입력해주세요."},
	    	pswdConfirm : {required : "확인 비밀번호를 입력해주세요."}
	    },
	    submitHandler: function (frm) {
	   		if(confirm("비밀번호를 변경하시겠습니까??")){
	   			frm.submit();
	   		}else{
	   			return false;
	   		}
	    }
	});


});
</script>