<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<main id="container">
	<header id="page-title">
		<h2>
			<span>본인인증</span>
			<small>Member Auth</small>
		</h2>
	</header>

	<div id="page-content">
		<div class="member-join">
			<form class="member-join-content my-15">
				<dl class="content-auth">
					<dt>본인인증</dt>
				</dl>
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
					</tbody>
				</table>
	
				<div class="content-auth-phone mt-9">
					<img src="/html/page/members/assets/images/img-join-auth.svg" alt="">
					<dl>
						<dd>안전한 이용을 위해 본인인증이 필요합니다<br>본인 명의의 휴대폰 번호로만 인증이 가능합니다.<br>14세 이상만 가입 가능합니다.</dd>
					</dl>
				</div>
	
				<div class="content-button mt-5">
					<button type="button" class="btn btn-primary btn-large flex-1" onclick="f_cert();">본인 인증하기</button>
	                   <!-- <button type="button" class="btn btn-primary btn-large flex-1" data-bs-toggle="modal" data-bs-target="#completed-members">본인 인증하기</button> -->
					<a href="/membership/logout" class="btn btn-outline-primary btn-large w-[37.5%]">취소</a>
				</div>
	
				<input type="hidden" id="receiptId" name="receiptId" value="">
			</form>
		</div>
	</div>


</main>

<script src="/html/core/script/matchingAjaxCallApi.js?v=<spring:eval expression="@version['assets.version']"/>"></script>
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
		            var receiptId = response.data.receipt_id;
		            $("#receiptId").val(receiptId);
		            
		            updateMbrCiKey(receiptId);
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
	
	function updateMbrCiKey(receiptId) {
		callPostAjaxIfFailOnlyMsg(
			'/membership/info/myinfo/updateMbrCi.json',
			{receiptId},
			function(result) {
				location.href = '/';					
			}
		);
	}
	
</script>