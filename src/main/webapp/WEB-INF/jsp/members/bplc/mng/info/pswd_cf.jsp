<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<jsp:include page="../layout/page_header.jsp">
	<jsp:param value="비밀번호 확인" name="pageTitle" />
</jsp:include>

<form:form action="./pswdAction" id="pswdNewFrm" name="pswdNewFrm" method="post" modelAttribute="bplcVO">
	<fieldset>
		<legend class="text-title2">비밀번호 확인</legend>
		<table class="table-detail">
			<colgroup>
				<col class="w-43">
				<col>
			</colgroup>
			<tbody>
				<tr>
					<th scope="row"><label for="form-item1">아이디</label></th>
					<td><form:input path="bplcId" class="form-control w-75" placeholder="아이디를 입력해 주세요." maxlength="50" /></td>
				</tr>
				<tr>
					<th scope="row"><label for="form-item2">비밀번호</label></th>
					<td><form:input type="password" path="bplcPswd" class="form-control w-75" placeholder="사용중인 비밀번호를 입력해 주세요." maxlength="50"/></td>
				</tr>
			</tbody>
		</table>
		<div class="mt-5">
			* 아이디, 비밀번호 확인 후 새로운 비밀번호로 변경하실 수 있습니다.<br> * 개인정보 보호를 위해 주기적인 비밀번호 변경을 권장합니다.
		</div>
	</fieldset>
	<div class="btn-group center mt-10">
		<button type="submit" class="btn-save w-52 large shadow">확인</button>
	</div>
</form:form>
<script>
$(function(){
	//정규식
	var passwordChk = /^.*(?=.*\d)(?=.*[a-zA-Z])(?=.*[!@#$%^&+=]).*$/;

	//비밀번호 형식 체크
	$.validator.addMethod("passwordCk",  function( value, element ) {
		return this.optional(element) ||  /^.*(?=.*\d)(?=.*[a-zA-Z])(?=.*[!@#$%^&+=]).*$/.test(value);
	});

	//유효성
	$("form#pswdNewFrm").validate({
	    ignore: "input[type='text']:hidden",
	    rules : {
	    	bplcId : {required : true},
	    	bplcPswd : {required : true, passwordCk : true}
	    },
	    messages : {
	    	bplcId : {required : "아이디를 입력해주세요."},
	    	bplcPswd : {required : "비밀번호를 입력해주세요.", passwordCk : "비밀번호 형식이 맞지 않습니다."}
	    },
	    submitHandler: function (frm) {
	   			frm.submit();
	    }
	});

});
</script>