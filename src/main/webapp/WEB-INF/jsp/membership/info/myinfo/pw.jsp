<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<main id="container" class="is-mypage-style">
	<header id="page-title">
		<h2>
			<span>회원정보수정</span> <small>Member Modify</small>
		</h2>
	</header>

	<jsp:include page="../../layout/page_nav.jsp" />

	<div id="page-content">
		<ul class="tabs">
			<li><a href="./form?returnUrl=${param.returnUrl}" class="tabs-link"><strong>회원정보</strong> 수정</a></li>
			<li><a href="./pswd?returnUrl=${param.returnUrl}" class="tabs-link active"><strong>비밀번호</strong> 변경</a></li>
		</ul>

		<div class="member-modify is-left mt-11 md:mt-15">
			<form:form id="pwdFrm" name="pwdFrm" action="./pwdAction" method="post" modelAttribute="mbrVO" class="member-join-content">
				<input type="hidden" id="uniqueId" name="uniqueId" value="${_mbrSession.uniqueId}" />
				<input type="hidden" name="returnUrl" value="${param.returnUrl}" />
				<div class="space-y-1 5">
					<p class="text-alert">회원님의 정보를 중 변경된 내용이 있는 경우, 아래에서 수정해주세요.</p>
					<p class="text-alert">회원정보는 개인정보취급방침에 따라 안전하게 보호됩니다.</p>
				</div>
				<table class="table-detail mt-7.5">
					<colgroup>
						<col class="w-29 xs:w-32">
						<col>
					</colgroup>
					<tbody>
						<tr>
							<th scope="row"><p>이름</p></th>
							<td><p class="text-base font-bold md:text-lg">${_mbrSession.mbrNm}</p></td>
						</tr>
						<tr>
							<th scope="row"><p>아이디</p></th>
							<td><p class="text-base font-bold md:text-lg">${_mbrSession.mbrId}</p></td>
							<input type="hidden" name="mbrId" id="mbrId" value="${_mbrSession.mbrId}" />
						</tr>
						<tr>
							<th scope="row">
								<p>
									<label for="pswd">비밀번호<sup class="text-danger text-base md:text-lg">*</sup></label>
								</p>
							</th>
							<td><form:input type="password" class="form-control w-full" malength="16" path="pswd"/></td>
						</tr>
						<tr>
							<th scope="row"></th>
							<td>
								<p class="text-sm">
									띄어쓰기 없이 8~16자 영문, 숫자, 특수문자를 조합하여 입력해주세요. (특수문자는 !,@,#,$,%,^,&amp;,*만 사용 가능) 아이디와 동일한 비밀번호는 사용 할 수 없습니다.
								</p>
							</td>
						</tr>
						<tr>
							<th scope="row">
								<p><label for="pswdCnfm">비밀번호 확인<sup class="text-danger text-base md:text-lg">*</sup></label></p>
							</th>
							<td><input type="password" class="form-control w-full" maxlength="16" id="pswdCnfm" name="pswdCnfm"></td>
						</tr>
						<tr>
							<th scope="row"></th>
							<td>
								<p class="text-sm">
									비밀번호 확인을 위해 다시 한번 입력해주세요.
								</p>
							</td>
						</tr>
					</tbody>
				</table>

				<div class="content-button mt-20 md:mt-25">
					<button type="submit" class="btn btn-primary btn-large sm:w-53 sm-max:flex-1">확인</button>
					<!-- TODO 플래너로 변경 -->
					<a href="${_marketPath}" class="btn btn-outline-primary btn-large w-[37.5%] sm:w-37">취소</a>
				</div>
			</form:form>
		</div>
	</div>
</main>

<script>

	$(function(){

		const pswdChk = /^.*(?=.*\d)(?=.*[a-zA-Z])(?=.*[!@#$%^&+*=*]).*$/;

		$.validator.addMethod("pswdFrmChk", function(value, element, param) {
			if(value.search(/\s/) != -1){
				return false;
			}else{
				if(value == $("#mbrId").val()){
					return false;
				}else{
					return true;
				}
			}
		}, "! 공백 및 아이디와 똑같은 비밀번호는 사용하실 수 없습니다.");

		//유효성 검사
		$("form#pwdFrm").validate({
		    ignore: "input[type='text']:hidden",
		    rules : {
		    	pswd : {required : true, regex : pswdChk, minlength : 8, pswdFrmChk : true}
		    	, pswdCnfm : {required : true, equalTo : "#pswd"}
		    },
		    messages : {
		     	pswd : {required : "! 비밀번호는 필수 입력 항목입니다.", regex : "! 8~16자 영문, 숫자, 특수문자를 조합하여 입력해 주세요." , minlength : "! 비밀번호는 최소 8자리 입니다."}
	    		, pswdCnfm : {required : "! 비밀번호 확인은 필수 입력 항목입니다.", equalTo : "! 동일한 비밀번호를 입력해주세요."}
		    },
		    errorElement:"p",
		    errorPlacement: function(error, element) {
			    var group = element.closest('.form-group, .form-check');
			    if (group.length) {
			        group.after(error.addClass('mt-1.5 text-sm text-danger'));
			    } else {
			        element.after(error.addClass('mt-1.5 text-sm text-danger'));
			    }
			},
		    submitHandler: function (frm) {
		   		if(confirm("수정하시겠습니까?")){
		   			frm.submit();
		   		}else{
		   			return false;
		   		}
		    }
		});

	});
</script>