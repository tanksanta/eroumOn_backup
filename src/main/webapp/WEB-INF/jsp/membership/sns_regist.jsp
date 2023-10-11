<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<main id="container">
	<header id="page-title">
		<h2>
			<span>간편 회원가입</span>
			<small>Member Join</small>
		</h2>
	</header>

	<div id="page-content">
		<div class="member-join">

			<form:form id="frmRegist" name="frmRegist" action="./action" class="member-join-content" method="post" modelAttribute="mbrVO" enctype="multipart/form-data">
				<form:input type="hidden" path="uniqueId" />

				<double-submit:preventer tokenKey="preventTokenKey" />

				<p class="mt-13 text-title2">기본 정보</p>
				<table class="table-detail">
					<colgroup>
						<col class="w-29 xs:w-32">
						<col>
					</colgroup>
					<tbody>
						<tr class="top-border">
							<td></td>
							<td></td>
						</tr>
						<tr>
							<th scope="row">
								<p>
									<label for="join-item1-5">주소<sup class="text-danger text-base md:text-lg">*</sup></label>
								</p>
							</th>
							<td>
								<div class="form-group w-full">
									<form:input class="form-control" maxlength="5" path="zip" />
									<button type="button" class="btn btn-primary" onclick="f_findAdres('zip', 'addr', 'daddr'); return false;" style="padding: 0 0.75rem;">우편번호 검색</button>
								</div> <form:input class="form-control mt-1.5 w-full md:mt-2" path="addr" maxlength="200" /> <form:input class="form-control mt-1.5 w-full md:mt-2" path="daddr" maxlength="200" />
							</td>
						</tr>
						<tr>
							<th scope="row"><p style="padding-left: 0;">
									<label for="join-item3-3">개인정보 유효기간<sup class="text-danger text-base md:text-lg">*</sup></label>
								</p></th>
							<td>
								<div class="form-check-group w-full">
									<c:forEach var="expr" items="${expirationCode}" varStatus="status">
										<div class="form-check">
											<form:radiobutton class="form-check-input" path="prvcVldPd" id="prvcVldPd${status.index}" value="${expr.key}" />
											<label class="form-check-label" for="prvcVldPd${status.index}">${expr.value}</label>
										</div>
									</c:forEach>
								</div>
							</td>
						</tr>
					</tbody>
				</table>
				</br>

				<p class="mt-13 text-title2">약관동의</p>
				<div class="form-check font-bold my-3.5">
					<input class="form-check-input" type="checkbox" id="check-all">
					<label class="form-check-label" for="check-all">전체 약관에 동의합니다</label>
				</div>


				<%@ include file="/WEB-INF/jsp/membership/cntnts/accordionAgree.jsp" %>


				<p class="mt-17 text-title2">정보수신 동의</p>
				<table class="table-detail">
					<colgroup>
						<col class="w-29 xs:w-32">
						<col>
					</colgroup>
					<tbody>
						<tr class="top-border">
							<td></td>
							<td></td>
						</tr>
						<tr>
							<th scope="row"><p>
									<label for="join-item3-4">정보수신</label>
								</p></th>
							<td>
								<div class="py-1.5 md:py-2">
									<div class="form-check">
										<input class="form-check-input" type="checkbox" id="allChk"> <label class="form-check-label" for="allChk">전체 수신</label>
									</div>
								</div>
								<div class="mt-1.5 flex flex-wrap md:mt-2">
									<div class="form-check mr-3 xs:mr-auto">
										<form:checkbox class="form-check-input agree" path="smsRcptnYn" value="Y" />
										<label class="form-check-label" for="smsRcptnYn1">SMS</label>
									</div>
									<div class="form-check mr-3 xs:mr-auto">
										<form:checkbox class="form-check-input agree" path="emlRcptnYn" value="Y" />
										<label class="form-check-label" for="emlRcptnYn1">이메일</label>
									</div>
									<div class="form-check mr-3 xs:mr-auto">
										<form:checkbox class="form-check-input agree" path="telRecptnYn" value="Y" />
										<label class="form-check-label" for="telRecptnYn1">휴대폰</label>
									</div>
								</div>
							</td>
						</tr>
					</tbody>
				</table>
				

				<dl class="content-auth mt-15">
					<dt>본인인증</dt>
				</dl>

				<div class="content-auth-phone mt-9">
					<img src="/html/page/members/assets/images/img-join-auth.svg" alt="">
					<dl>
						<dd>안전한 이용을 위해 본인인증이 필요합니다<br>본인 명의의 휴대폰 번호로만 인증이 가능합니다.<br>14세 이상만 가입 가능합니다.</dd>
					</dl>
				</div>

				<div class="content-button mt-5">
					<button type="button" class="btn btn-primary btn-large flex-1 selfBtn">본인 인증하기</button>
					<a href="javascript:history.back(-1)" class="btn btn-outline-primary btn-large w-[37.5%]">취소</a>
				</div>

				<input type="hidden" id="receiptId" name="receiptId" value="">
			</form:form>
		</div>
	</div>
</main>

<script>

async function f_cert(){	
	try {
	    const response = await Bootpay.requestAuthentication({
	        application_id: "${_bootpayScriptKey}",
	        pg: '다날',
	        order_name: '본인인증',
	        authentication_id: 'CERT00000000001',
	        extra: { show_close_button: true }
	    })
	    switch (response.event) {
	        case 'done':
	            console.log("response.data", response.data);
	            $("#receiptId").val(response.data.receipt_id);
		        $("#frmRegist").submit();
	            break;
	    }
	} catch (e) {
	    switch (e.event) {
	        case 'cancel':
	            console.log(e.message);	// 사용자가 결제창을 닫을때 호출
	            break
	        case 'error':
	            console.log(e.error_code); // 결제 승인 중 오류 발생시 호출
	            break
	    }
	}
}

$(function(){
	$("#mbrBtn").click();

	//약관 동의 확인
	$(".selfBtn").on("click",function(){
		if(!$("#firstChk").is(":checked") || !$("#secondChk").is(":checked") || !$("#thirdChk").is(":checked") || !$("#fourthChk").is(":checked")){
			alert("필수 약관에 동의 해주세요.");
			return false;
		} else if(!$('#zip').val() || !$('#addr').val() || !$('#daddr').val()) {
			alert("주소를 모두 입력하세요.");
			return false;
		} else{
			f_cert();
		}
	});

	// 전체 약관 동의
	$("#check-all").on("click",function(){
		if(!$("#check-all").is(":checked")){
			$("#firstChk, #secondChk, #thirdChk, #fourthChk").prop("checked",false);
		}else{
			$("#firstChk, #secondChk, #thirdChk, #fourthChk").prop("checked",true);
		}
	});
	
	//전체 수신
	$("#allChk").on("click",function(){
		$("#allChk").is(":checked") ? $(".agree").prop("checked",true) : $(".agree").prop("checked",false)
	});

	$(".agree").on("click",function(){
		if($(".agree:checked").length == 3){
			$("#allChk").prop("checked",true);
		}else{
			$("#allChk").prop("checked",false);
		}
	});
	
	$("input[name='agree']").on("click",function(){
		if(!$(this).is(":checked")){
			$("#check-all").prop("checked",false);
		}else{
			if($("input[name='agree']:checked").length == 4){
				$("#check-all").prop("checked",true);
			}
		}
	});
});
</script>