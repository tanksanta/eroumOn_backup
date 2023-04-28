<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<main id="container">
	<jsp:include page="../../layout/page_header.jsp">
			<jsp:param value="회원 탈퇴" name="pageTitle"/>
	</jsp:include>

	<div id="page-container">
			<jsp:include page="../../layout/page_sidenav.jsp" />
		<div id="page-content">


			<div class="member-release-title">
				<img src="/html/page/market/assets/images/txt-withdrawal.svg" alt="그동안 이로움ON 마켓을 이용해 주셔서 감사합니다.">
				<p>
					이로움ON 마켓 이용 시 불편했거나 부족했던 부분을 알려주시면,<br> 더 좋은 모습으로 찾아 뵙기 위해 노력하겠습니다.
				</p>
			</div>

			<div class="member-release-info mt-7 md:mt-8.5">
				<p class="text-title2">회원탈퇴 안내</p>
				<p>&nbsp;</p>
				<p>회원 탈퇴는 본 서비스에 대한 이용 해지를 의미합니다. 자사가 제공하는 광고성 이메일 및 SMS의 경우 회원탈퇴 접수 후 24시간 이내 발송이 중지됩니다.</p>
				<p>&nbsp;</p>
				<p class="text-alert">
					다만 데이터처리상의 이유로, 탈퇴처리가 지연될 수 있습니다.<br> 탈퇴신청 이후 48시간이 지난 후에도 이메일 및 SMS를 받으시는 경우 당사 고객센터(02-830-1301)로 연락 주시기 바랍니다.
				</p>
				<p>&nbsp;</p>
				<ol class="list-number ml-4 sm:ml-9 md:ml-14">
					<li>회원탈퇴 시 사용하고 계신 아이디는 재사용 및 복구가 불가능합니다.</li>
					<li>소유하고 있는 마일리지/포인트/쿠폰 등은 자동으로 소멸되며, 재가입하더라도 복구되지 않습니다.</li>
					<li>주문내역, 위시리스트 등 기타 서비스 이용 내용이 모두 삭제되며, 재가입하더라도 복구되지 않습니다.</li>
					<li>상품주문 및 취소/교환/반품 처리가 진행중일 경우에는 탈퇴처리가 이루어지지 않습니다.</li>
					<li>회원 탈퇴 이후 90일 이내에는 재 가입되지 않습니다.</li>
				</ol>
				<p>&nbsp;</p>
				<p>&nbsp;</p>
				<p class="text-title2">탈퇴회원 정보 보존기간,파기절차 및 시점</p>
				<p>&nbsp;</p>
				<p>
					회원에 대하여 수집한 개인정보는 이로움ON 마켓 탈퇴 신청이 완료된 이후,<br> 보관기간 및 이용기간에 따라 해당 정보를 지체없이 파기합니다. 파기 절차, 방법, 시점은 다음과 같습니다. 기 바랍니다.
				</p>
				<p>&nbsp;</p>
				<ol class="list-number">
					<li class="mb-5 md:mb-6">파기절차 및 시점 고객이 서비스 가입 등을 위해 기재한 개인정보는 서비스 해지 등 이용목적이 달성된 후 내부 방침 및 기타 관련 법령에 의한 정보보호 사유(위 개인정보의 보유 및 이용기간 참조)에 따른 보유기간이 경과한 후에 삭제되거나 파기합니다.<br> 주문정보는 교환/반품/환불 및 사후처리(A/S) 등을 위하여 ‘전자상거래등에서의 소비자보호에 관한 법률’에 의거한 개인정보보호정책에 따라 5년간 보관됩니다.<br> 일반적으로 잔존하는 채권-채무 관계가 없는 경우 당사 회원가입시 수집되어 전자적 파일형태로 관리하는 개인정보는 회원 탈퇴 시점에 바로 삭제 됩니다.
					</li>
					<li>파기방법 종이에 출력된 개인정보는 분쇄기로 분쇄 또는 소각하거나 화학약품 처리를 하여 용해하여 파기하고, 전자적 파일형태로 저장된 개인정보는 기록을 재생할 수 없는 기술적 방법을 사용하여 삭제합니다.</li>
				</ol>
			</div>

			<div class="member-release-data mt-10 md:mt-12">
				<dl>
					<dt>현재 보유 포인트</dt>
					<dd>
						<fmt:formatNumber value="${resultMap.point}" pattern="###,###" /> <img src="/html/page/market/assets/images/ico-point.svg" alt="포인트">
					</dd>
				</dl>
				<dl>
					<dt>현재 보유 마일리지</dt>
					<dd>
						<fmt:formatNumber value="${resultMap.mlg}" pattern="###,###" /> <img src="/html/page/market/assets/images/ico-mileage.svg" alt="마일리지">
					</dd>
				</dl>
				<dl>
					<dt>현재 보유 쿠폰</dt>
					<dd>
						${resultMap.coupon} <small>장</small>
					</dd>
				</dl>
			</div>

			<form id="radioFrm" name="radioFrm" method="get" >
				<p class="text-title2 mt-6 md:mt-8">회원탈퇴 사유</p>
				<div class="member-release-check mt-2.5 md:mt-3">
					<c:forEach var="whdwlCode" items="${norResnCdCode}" varStatus="status">
						<div class="form-check">
							<input class="form-check-input" type="radio" id="whdwlCode${status.index}" name="whdwlCode" value="${whdwlCode.key}">
							<label class="form-check-label" for="whdwlCode${status.index}">${whdwlCode.value}</label>
						</div>
					</c:forEach>
				</div>

				<div class="flex justify-center space-x-1.5 mt-4 mx-auto md:space-x-2 md:mt-10">
					<button type="submit" class="btn btn-large btn-primary w-44 md:w-53">탈퇴하기</button>
					<a href="${_marketPath}/mypage/index" class="btn btn-large btn-outline-primary w-31 md:w-37">취소</a>
				</div>
			</form>


			<!-- 탈퇴 모달 -->
		<form id="lveFrm" name="lveFrm" action="${_marketPath}/mypage/whdwl/action" method="post">
			<div class="modal fade" id="leaveModal" tabindex="-1" aria-hidden="true" >
				<input type="hidden" id="resnCn" name="resnCn" value="" />
					<div class="modal-dialog modal-dialog-centered">
						<div class="modal-content">
							<div class="modal-header">
								<p class="text-title">정말 탈퇴하시겠습니까?</p>
							</div>
							<div class="modal-close">
								<button data-bs-dismiss="modal">모달 닫기</button>
							</div>
							<div class="modal-body">
								<div class="content">
									<p class="text-alert">고객님의 개인정보를 안전하게 취급하며, 회원님의 동의 없이는 회원정보를 공개 및 변경하지 않습니다.</p>
									<p class="text-alert">확인을 위해 비밀번호를 다시 입력해 주세요.</p>

									<div class="member-release-reason mt-6">
										<label for="leave-item" class="pswd">비밀번호</label>&nbsp;
										<input type="password" class="form-control" id="pswd" name="pswd" placeholder="비밀번호" />
									</div>
									<div class="modal-footer">
										<button type="submit" class="btn btn-primary btn-submit">확인</buttton>
										<button type="button" class="btn btn-outline-primary btn-cancel" data-bs-dismiss="modal">취소</buttton>
									</div>
								</div>
							</div>
						</div>
					</div>
			</div>
		</form>

		</div>
	</div>

</main>

<script>
	$(function(){
		const pswdChk = /^.*(?=.*\d)(?=.*[a-zA-Z])(?=.*[!@#$%^&+=*]).*$/;

		//배송 상태
		const ordrSttsCode = {
		<c:forEach items="${ordrSttsCode}" var="stts">
			${stts.key} : '${stts.value}',
		</c:forEach>
		};

		//사유
		$("input[name='whdwlCode']").on("click",function(){
			$("#resnCn").val($(this).val());
		});

		//유효성 검사
		$("form[name='radioFrm']").validate({
		    ignore: "input[type='text']:hidden",
		    rules : {
		    	whdwlCode : {required : true}
		    },
		    messages : {
		    	whdwlCode : {required : "! 사유선택은 필수 입력 항목입니다."}
		    },
		    errorElement:"p",
		    errorPlacement: function(error, element) {
			    var group = element.closest('.member-release-check');
			    if (group.length) {
			        group.after(error.addClass('text-danger'));
			    } else {
			        element.after(error.addClass('text-danger'));
			    }
			},
		    submitHandler: function (frm) {

		    	/*특정 단계 제외 카운트*/
	   			$.ajax({
    				type : "post",
    				url  : "exDlvySttsCnt.json",
    				dataType : 'json'
    			})
    			.done(function(data) {
    				if(data.result == true){
    					$("#leaveModal").modal("show");
    				}else{
    					//alert(ordrSttsCode[data.sttsTy] + " 의외의 단계가 존재합니다.");
    					alert("주문 건수 중 진행 중인 단계가 존재합니다.");
    				}
    			})
    			.fail(function(data, status, err) {
    				alert("단계 검사 중 오류가 발생했습니다.");
    				console.log('error forward : ' + data);
    			});

		    }
		});


		//유효성 검사
		$("form[name='lveFrm']").validate({
		    ignore: "input[type='text']:hidden",
		    rules : {
		    	pswd : {required : true, regex : pswdChk}
		    },
		    messages : {
		    	pswd : {required : "! 비밀번호는 필수 입력 항목입니다.", regex : "! 8~16자 영문, 숫자, 특수문자를 조합하여 입력해 주세요."}
		    },
		    errorElement:"p",
		    errorPlacement: function(error, element) {
			    var group = element.closest('.member-release-reason');
			    if (group.length) {
			        group.after(error.addClass('text-danger'));
			    } else {
			        element.after(error.addClass('text-danger'));
			    }
			},
		    submitHandler: function (frm) {
		    	if(confirm("이로움ON 마켓 회원에서 정말 탈퇴하시겠습니까?")){
		    		frm.submit();
		    	}else{
		    		return false;
		    	}
		    }
		});

	});
</script>