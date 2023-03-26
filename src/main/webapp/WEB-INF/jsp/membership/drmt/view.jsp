<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<main id="container">
	<header id="page-title">
		<h2>
			<span>휴면계정 안내</span> <small>Member Hibernate</small>
		</h2>
	</header>

	<div id="page-content">
		<form id="frmDrmt" name="frmDrmt" action="/membership/drmt/clear" class="member-join-content" method="post" enctype="multipart/form-data">
			<input type="hidden" id="receiptId" name="receiptId" value="">
		</form>
		<div class="member-release-title is-glass">
			<img src="/html/page/members/assets/images/txt-sleep2.svg" alt="회원님의 계정은 휴면상태 입니다.">
			<p>
				<span class="text-lg md:text-xl">안녕하세요, <strong class="text-xl md:text-2xl">${mbrVO.mbrNm}</strong> 회원님!
				</span><br> 이로움 마켓을 1년 이상 로그인하지 않아,<br class="md:hidden"> 계정이 휴면 상태로 전환되었습니다.
			</p>
		</div>
		<div class="member-release-data mt-3 md:mt-4">
			<dl>
				<dt>마지막 접속일</dt>
				<dd><fmt:formatDate value="${mbrVO.recentCntnDt}" pattern="yyyy-MM-dd" /></dd>
			</dl>
			<dl>
				<dt>휴면 계정 전환일</dt>
				<dd><fmt:formatDate value="${mbrVO.mdfcnDt}" pattern="yyyy-MM-dd" /></dd>
			</dl>
		</div>
		<div class="mt-11 flex flex-col items-center md:mt-15">
			<p class="text-alert">
				이로움 마켓을 계속 이용하시려면 <strong>[휴면 해제하기]</strong>를 클릭하여 본인인증을 진행해 주세요.
			</p>
			<div class="flex justify-center gap-2 mt-5 w-full text-center md:gap-2.5 md:mt-6">
				<!-- TODO 플래너로 변경 -->
				<a href="/market" class="btn btn-large btn-outline-primary w-51 md:w-62">취소</a>
				<!-- <a href="/planner/index" class="btn btn-large btn-outline-primary w-51 md:w-62">취소</a> -->
				<button type="button" class="btn btn-large btn-primary w-51 md:w-62 f_clear">휴면 해제하기</button>
			</div>
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
	            $("#frmDrmt").submit();
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

	$(".f_clear").on("click",function(){
		f_cert();
	});
});
</script>