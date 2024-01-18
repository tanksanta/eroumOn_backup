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
			<li><a href="./form?returnUrl=${param.returnUrl}" class="tabs-link active"><strong>회원정보</strong> 수정</a></li>

			<c:if test="${ !empty eroumAuthInfo }">
				<li><a href="./pswd?returnUrl=${param.returnUrl}" class="tabs-link"><strong>비밀번호</strong> 변경</a></li>
			</c:if>
		</ul>

		<div class="member-modify mt-11 md:mt-15">
			<form:form action="./infoAction" id="frmReg" name="frmReg" method="post" modelAttribute="mbrVO" enctype="multipart/form-data" class="member-join-content">
				<form:hidden path="ciKey" />
				<form:hidden path="diKey" />
				<form:hidden path="joinTy" />

				<input type="hidden" name="returnUrl" value="${param.returnUrl}" />

				<input type="hidden" id="uniqueId" name="uniqueId" value="${_mbrSession.uniqueId}" />

				<div class="space-y-1 5">
					<p class="text-alert">회원님의 정보를 중 변경된 내용이 있는 경우, 아래에서 수정해주세요.</p>
					<p class="text-alert">회원정보는 개인정보취급방침에 따라 안전하게 보호됩니다.</p>
				</div>
				<p class="mt-8 text-title2">기본 정보</p>
				<table class="table-detail">
					<colgroup>
						<col class="w-22 xs:w-32">
						<col>
					</colgroup>
					<tbody>
						<tr class="top-border">
							<td></td>
							<td></td>
						</tr>
						<tr>
							<th scope="row"><p>이름</p></th>
                            <td><p class="text-base font-bold md:text-lg">${_mbrSession.mbrNm}</p></td>
						</tr>
						<tr>
							<th scope="row"><p>아이디</p></th>
							<td>
								<c:choose>
									<c:when test="${ !empty eroumAuthInfo }">
										<p class="text-base font-bold md:text-lg">${eroumAuthInfo.mbrId}</p>
									</c:when>
									<c:otherwise>
										<span class="text-sm md:text-base" style="cursor:pointer;">이로움ON 아이디 만들기 &gt;</span>
									</c:otherwise>
								</c:choose>
							</td>
						</tr>
						<tr>
							<th scope="row"><p>소셜 로그인 설정</p></th>
							<td>
								<div class="flex w-full mt-4 mb-4">
									&nbsp;
									<img style="flex:1 1 0; border-radius:100%; width:30px; max-width:30px; height:30px;" src="/html/core/images/ico-kakao.png">&nbsp;&nbsp;&nbsp;
									<div style="flex:5 5 0; line-height:30px;">
										카카오 
										<span style="color:gray; opacity:0.6;">&nbsp;|&nbsp;</span>
										
										 <c:choose>
											<c:when test="${ !empty kakaoAuthInfo }">
												${!empty kakaoAuthInfo.eml ? kakaoAuthInfo.eml : kakaoAuthInfo.mblTelno}&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
												<a style="color:gray; opacity:0.6; border-bottom:1px solid gray; cursor:pointer;" onclick="removeAuth(${kakaoAuthInfo.authNo});">연결해제</a>
											</c:when>
											<c:otherwise>
												<span style="cursor:pointer;" onclick="if(confirm('소셜 계정을 연결하시겠어요?\n이후 연결된 계정으로 간편하게 로그인이 가능합니다')) { location.href='/membership/kakao/auth' }">연결하기 &gt;</span>
											</c:otherwise>
										</c:choose>
									</div>
								</div>
								
								<div class="flex w-full mb-4">
									&nbsp;
									<img style="flex:1 1 0; border-radius:100%; width:30px; max-width:30px; height:30px;" src="/html/core/images/ico-naver.png">&nbsp;&nbsp;&nbsp;
									<div style="flex:5 5 0; line-height:30px;">
										네이버 
										<span style="color:gray; opacity:0.6;">&nbsp;|&nbsp;</span> 
										
										<c:choose>
											<c:when test="${ !empty naverAuthInfo }">
												${naverAuthInfo.eml}&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
												<a style="color:gray; opacity:0.6; border-bottom:1px solid gray; cursor:pointer;" onclick="removeAuth(${naverAuthInfo.authNo});">연결해제</a>
											</c:when>
											<c:otherwise>
												<span style="cursor:pointer;" onclick="if(confirm('소셜 계정을 연결하시겠어요?\n이후 연결된 계정으로 간편하게 로그인이 가능합니다')) { location.href='/membership/naver/get' }">연결하기 &gt;</span>
											</c:otherwise>
										</c:choose>
									</div>
								</div>
							</td>
						</tr>
						<tr>
							<th scope="row"><p>생년월일</p></th>
							<td><p class="text-base font-bold md:text-lg"><fmt:formatDate value="${_mbrSession.brdt}" pattern="yyyy년 MM월 dd일" /></p></td>
						</tr>
						<tr>
							<th scope="row"><p>성별</p></th>
							<td><p class="text-base font-bold md:text-lg">${genderCode[_mbrSession.gender]}</p></td>
						</tr>
						<tr>
							<th scope="row"><p>휴대폰 번호<sup class="text-danger text-base md:text-lg">*</sup></p></th>
							<td>
								<div class="form-group w-full">
									<form:input class="form-control w-full max-w-73" path="mblTelno" maxlength="13" readonly="true" />
									<button type="button" class="btn btn-primary" id="mbrTelnoChg">변경</button>
								</div>
							</td>
						</tr>
						<!-- 
						<tr>
							<th scope="row"></th>
							<td>
								<p class="text-sm">
									전화번호를 입력해주세요.
								</p>
							</td>
						</tr>
						-->
						<tr>
							<th scope="row">
								<p>
									<label for="eml">이메일<sup class="text-danger text-base md:text-lg">*</sup></label>
								</p>
							</th>
							<td><form:input class="form-control w-full max-w-73" path="eml" maxlength="50"/></td>
						</tr>
						<tr>
							<th scope="row">
								<p>
									<label for="addr">주소<sup class="text-danger text-base md:text-lg">*</sup></label>
								</p>
							</th>
							<td>
								<div class="form-group w-full max-w-73">
									<form:input class="form-control w161" maxlength="5" path="zip" />
									<button type="button" class="btn btn-primary" style="padding: 0 0.75rem;" onclick="f_findAdres('zip', 'addr', 'daddr'); return false;">우편번호 검색</button>
								</div> <form:input class="form-control mt-1.5 w-full md:mt-2" path="addr" maxlength="200" /> <form:input class="form-control mt-1.5 w-full md:mt-2" path="daddr" maxlength="200" />
							</td>
						</tr>
						<tr>
							<th scope="row">
								<p class="flex">
									<label for="join-item3-3">개인정보 유효기간</label><sup class="text-danger text-base md:text-lg">*</sup>
								</p>
							</th>
							<td>
								<div class="form-radio-group">
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

				<p class="mt-8 text-title2">수급자 정보</p>
				<table class="table-detail">
					<colgroup>
						<col class="w-22 xs:w-32">
						<col>
					</colgroup>
					<tbody>
						<tr class="top-border">
							<td></td>
							<td></td>
						</tr>
						<c:forEach var="mbrRecipient" items="${mbrRecipientList}">
							<tr class="wrapNm">
								<th scope="row">
									<p>
										<label for="recipter">수급자 성명</label>
									</p>
								</th>
								<td>
									<div class="form-group w-full">
										<input type="hidden" value="${mbrRecipient.recipientsNo}">
										<input type="text" class="form-control w-full max-w-73" maxlength="50" value="${mbrRecipient.recipientsNm}" readonly>
										<button type="button" class="btn btn-primary" onclick="location.href='/membership/info/recipients/view?recipientsNo=${mbrRecipient.recipientsNo}'">상세보기</button>
									</div>
								</td>
							</tr>
						</c:forEach>
					</tbody>
				</table>

				<p class="mt-11 text-title2">정보 수신 정보</p>
				<table class="table-detail">
					<colgroup>
						<col class="w-22 xs:w-32">
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
								<input type="hidden" id="smsRcptnDt" name="smsRcptnDt" value="<fmt:formatDate value="${mbrVO.smsRcptnDt}" pattern="yyyy-MM-dd HH:mm:ss" />" />
								<input type="hidden" id="emlRcptnDt" name="emlRcptnDt" value="<fmt:formatDate value="${mbrVO.emlRcptnDt}" pattern="yyyy-MM-dd HH:mm:ss" />" />
								<input type="hidden" id="telRecptnDt" name="telRecptnDt" value="<fmt:formatDate value="${mbrVO.telRecptnDt}" pattern="yyyy-MM-dd HH:mm:ss" />" />
							
								<div class="py-1.5 md:py-2">
									<div class="form-check">
										<input class="form-check-input" type="checkbox" id="allChk"> <label class="form-check-label" for="allChk">전체 수신</label>
									</div>
								</div>
								<div class="mt-1.5 flex flex-wrap md:mt-2">
									<div class="form-check mr-3 xs:mr-auto">
										<form:checkbox class="form-check-input agree" path="smsRcptnYn" value="Y" />
										<label class="form-check-label" for="smsRcptnYn1">문자</label>
									</div>
									<div class="form-check mr-3 xs:mr-auto">
										<form:checkbox class="form-check-input agree" path="emlRcptnYn" value="Y" />
										<label class="form-check-label" for="emlRcptnYn1">이메일</label>
									</div>
									<div class="form-check mr-3 xs:mr-auto">
										<form:checkbox class="form-check-input agree" path="telRecptnYn" value="Y" />
										<label class="form-check-label" for="telRecptnYn1">전화</label>
									</div>
								</div>
								<p class="mt-2 text-sm">이벤트 및 다양한 정보를 받으실 수 있습니다</p>
								<p class="mt-1.5 text-sm">수신 동의와 상관없이 주문/배송 관련 문자/메일은 발송 됩니다</p>
								<br>
								<ul style="list-style: disc; list-style-position: inside;">
									<li>
										문자 : ${mbrVO.smsRcptnYn == "Y" ? "동의" : "비동의"}&nbsp;<fmt:formatDate value="${mbrVO.smsRcptnDt}" pattern="yyyy-MM-dd HH:mm:ss" />
									</li>
									<li>
										이메일 : ${mbrVO.emlRcptnYn == "Y" ? "동의" : "비동의"}&nbsp;<fmt:formatDate value="${mbrVO.emlRcptnDt}" pattern="yyyy-MM-dd HH:mm:ss" />
									</li>
									<li>
										전화 : ${mbrVO.telRecptnYn == "Y" ? "동의" : "비동의"}&nbsp;<fmt:formatDate value="${mbrVO.telRecptnDt}" pattern="yyyy-MM-dd HH:mm:ss" />
									</li>
								</ul>
							</td>
						</tr>
					</tbody>
				</table>

				<div class="content-button mt-20 md:mt-25">
					<button type="submit" class="btn btn-primary btn-large sm:w-53 sm-max:flex-1">수정하기</button>
					<!-- TODO : 플래너로 변경 -->
					<a href="${_marketPath}" class="btn btn-outline-primary btn-large w-[37.5%] sm:w-37">취소</a>
				</div>
				</form:form>
		</div>
	</div>
</main>


<script src="/html/core/script/matchingAjaxCallApi.js?v=<spring:eval expression="@version['assets.version']"/>"></script>
<script>
// 본인인증
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
	            //console.log("response.data", response.data);

      			$.ajax({
      				type : "post",
      				url  : "getMbrTelno.json",
      				data : {
      					receiptId : response.data.receipt_id
      				},
      				dataType : 'json'
      			})
      			.done(function(data) {
      				if (data.success) {
      					var telno = data.mblTelno;
          				telno = telno.substring(0,3) + "-" + telno.substring(3,7) + "-" + telno.substring(7,11);
          				$("#mblTelno").val(telno);
          				$("#ciKey").val(data.ciKey);
          				$("#diKey").val(data.diKey);
          				alert("인증되었습니다.");
      				} else {
      					alert(data.msg);
      				}
      			})
      			.fail(function(data, status, err) {
      				console.log('error forward : ' + data);
      			});

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

//인증 수단 삭제
function removeAuth(authNo) {
	if (confirm('소셜 로그인 연결을 해제하시겠어요?')) {
		callPostAjaxIfFailOnlyMsg(
			'/membership/info/myinfo/removeMbrAuth.json',
			{ authNo },
			function(result) {
				location.reload();
			}
		);
	}
}


$(function(){

	const telchk = /^0([0-9]{2})-?([0-9]{3,4})-?([0-9]{4})$/;
	const emailchk = /^[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*\.[a-zA-Z]{2,3}$/i;
	
	function dateFormat(date) {
        let month = date.getMonth() + 1;
        let day = date.getDate();
        let hour = date.getHours();
        let minute = date.getMinutes();
        let second = date.getSeconds();

        month = month >= 10 ? month : '0' + month;
        day = day >= 10 ? day : '0' + day;
        hour = hour >= 10 ? hour : '0' + hour;
        minute = minute >= 10 ? minute : '0' + minute;
        second = second >= 10 ? second : '0' + second;

        return date.getFullYear() + '-' + month + '-' + day + ' ' + hour + ':' + minute + ':' + second;
	}

	//전체 수신
	$("#allChk").on("click",function(){
		$("#allChk").is(":checked") ? $(".agree").prop("checked",true) : $(".agree").prop("checked",false)
				
		$('#smsRcptnDt').attr('value', dateFormat(new Date()));
		$('#emlRcptnDt').attr('value', dateFormat(new Date()));
		$('#telRecptnDt').attr('value', dateFormat(new Date()));
	});

	$(".agree").on("click",function(){
		if($(".agree:checked").length == 3){
			$("#allChk").prop("checked",true);
		}else{
			$("#allChk").prop("checked",false);
		}
		
		var inputName = $(this).attr('name');
		$('#' + inputName.replace('Yn', '') + 'Dt').attr('value', dateFormat(new Date()));
	});

	// 휴대폰 번호 변경
	$("#mbrTelnoChg").on("click",function(){
		if(confirm("휴대폰 번호를 변경하시겠습니까?")){
			f_cert();
		}else{
			return false;
		}
	});

	//유효성 검사
	$("form#frmReg").validate({
	    ignore: "input[type='text']:hidden",
	    rules : {
	    	mblTelno : {required : true, regex : telchk}
	    	, eml : {required : true, regex : emailchk}
	    	, zip : {required : true, min : 5}
	    	, addr : {required : true}
	    	, daddr : {required : true}
	    	, recipter : {repChk : true}
	    	, rcperRcognNo : {repChk : true , searchChk : true}
	    },
	    messages : {
	    	mblTelno : {required : "! 전화번호는 필수 입력 항목입니다.", regex : "! 전화번호 형식이 잘못되었습니다.\n(000-0000-0000)"}
	    	, eml : {required : "! 이메일은 필수 입력 항목입니다.", regex : "! 이메일 형식이 잘못되었습니다.\n(abc@def.com)"}
	    	, zip : {required : "! 우편번호는 필수 입력 항목입니다.", min : "! 우편번호는 최소 5자리입니다."}
	    	, addr : {required : "! 주소는 필수 입력 항목입니다."}
	    	, daddr : {required : "! 상세주소는 필수 입력 항목입니다."}
	    	, recipter : {repChk : "! 수급자 성명은 필수 입력 항목입니다."}
	    	, rcperRcognNo : {repChk : "! 요양인정번호는 필수 입력 항목입니다.", searchChk : "! 수급자 조회는 필수 선택 항목입니다."}

	    },
	    errorElement:"p",
	    errorPlacement: function(error, element) {
		    var group = element.closest('.form-group, .form-check');
		    if (group.length) {
		        group.after(error.addClass('text-danger'));
		    } else {
		        element.after(error.addClass('text-danger'));
		    }
		},
	    submitHandler: function (frm) {
	   		if(confirm("저장하시겠습니까?")){
	   			frm.submit();
	   		}else{
	   			return false;
	   		}
	    }
	});
});
</script>