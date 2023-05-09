<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<head>
	<link rel="stylesheet" href="/html/page/members/assets/style/style.min.css">
</head>
<main id="container">
	<header id="page-title">
		<h2>
			<span>제휴 / 입점문의</span>
		</h2>
	</header>

	<div id="page-content">
		<form id="inqryFrm" name="inqryFrm" action="./action" class="member-join-content !border-0 !py-0 mx-auto max-w-screen-md" method="post" enctype="multipart/form-data">
			<p class="text-title2">문의유형</p>
			<table class="table-detail">
				<colgroup>
					<col class="w-29 sm:w-32 md:w-45">
					<col>
				</colgroup>
				<tbody>
					<tr class="top-border">
						<td></td>
						<td></td>
					</tr>
					<tr>
						<td colspan="2">
							<div class="content-select py-1.5">
								<div class="form-check">
									<input class="form-check-input" type="radio" name="inqryTy" id="inqryTy0" checked="checked" value="bsns">
									<label class="form-check-label" for="inqryTy0">사업제휴</label>
								</div>
								<div class="form-check">
									<input class="form-check-input" type="radio" name="inqryTy" id="inqryTy1" value="market">
									<label class="form-check-label" for="inqryTy1">마켓입점</label>
								</div>
							</div>
						</td>
					</tr>
				</tbody>
			</table>

			<p class="text-title2 mt-10 md:mt-17">고객정보</p>
			<table class="table-detail">
				<colgroup>
					<col class="w-29 sm:w-32 md:w-45">
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
								<label for="bsnsNm">회사명<sup class="text-danger text-base md:text-lg">*</sup></label>
							</p>
						</th>
						<td><input type="text" class="form-control w-full" id="bsnsNm" name="bsnsNm" maxlength="255"></td>
					</tr>
					<tr>
						<th scope="row"></th>
						<td><p class="text-sm">※ 사업자등록증의 법인명 또는 상호명을 입력하세요.</p></td>
					</tr>
					<tr>
						<th scope="row">
							<p>
								<label for="cntntsNm">이름<sup class="text-danger text-base md:text-lg">*</sup></label>
							</p>
						</th>
						<td><input type="text" class="form-control w-full" id="cntntsNm" name="cntntsNm" maxlength="100"></td>
					</tr>
					<tr>
						<th scope="row">
							<p>
								<label for="cntntsEml">이메일<sup class="text-danger text-base md:text-lg">*</sup></label>
							</p>
						</th>
						<td><input type="text" class="form-control w-full" id="cntntsEml" name="cntntsEml" maxlength="100"></td>
					</tr>
				</tbody>
			</table>

			<p class="text-title2 mt-10 md:mt-17">문의내용</p>
			<table class="table-detail">
				<colgroup>
					<col class="w-29 sm:w-32 md:w-45">
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
								<label for="cntntsSj">제목<sup class="text-danger text-base md:text-lg">*</sup></label>
							</p>
						</th>
						<td><input type="text" class="form-control w-full" id="cntntsSj" name="cntntsSj" maxlength="100"></td>
					</tr>
					<tr>
						<th scope="row">
							<p>
								<label for="cntnts">내용<sup class="text-danger text-base md:text-lg">*</sup></label>
							</p>
						</th>
						<td><textarea class="form-control w-full" rows="16" id="cntnts" name="cntnts"></textarea></td>
					</tr>
					<tr>
						<th scope="row"><p>
								<label for="attachFile">첨부파일</label>
							</p></th>
						<td>
							<div class="form-upload">
								<input type="file" class="form-control w-full" id="attachFile" name="attachFile">
							</div>
						</td>
					</tr>
					<tr>
						<th scope="row"></th>
						<td>
							<p class="text-sm mt-1.5 mb-4">※ 첨부파일은 20MB 용량 이하로 첨부해 주세요.</p>
						</td>
					</tr>
					<tr class="bot-border">
						<td></td>
						<td></td>
					</tr>
				</tbody>
			</table>

			<button type="button" class="group flex w-full items-center justify-between text-title2 mt-10 md:mt-17" data-bs-target="#collapse-agree1" data-bs-toggle="collapse" aria-expanded="false">
				<span>개인정보 수집 및 이용 동의</span> <img src="/html/page/members/assets/images/ico-angle-down.svg" alt="" class="mt-0.5 w-[0.875em] transition-transform ease-in-out group-aria-expanded:rotate-180">
			</button>
			<div class="border-t-0.5 border-gray2 mt-2 md:mt-3">
				<div class="collapse" id="collapse-agree1">
					<div class="mt-2 px-5 py-4 rounded-[1em] bg-neutral-100 text-sm md:mt-3 md:px-8 md:py-6 md:text-base">
						<p class="font-bold">주식회사 티에이치케이컴퍼니(이하 “회사”라 함)는 개인정보보호법, 정보통신망 이용촉진 및 정보보호 등에 관한 법률 등 관련 법령상의 개인정보보호 규정을 준수하며, 제휴/입점 문의사의 개인정보 보호에 최선을 다하고 있습니다.</p>
						<ol class="list-number mt-4 md:mt-5 spacey-y-1 md:spacey-1.5">
							<li>개인정보 수집 및 이용주체: 제휴/입점문의 및 상담신청을 통해 제공하신 정보는 “회사”가 직접 접수하고 관리합니다.</li>
							<li>동의를 거부할 권리 및 동의 거부에 따른 불이익: 신청자는 개인정보제공 등에 관해 동의하지 않을 권리가 있습니다.(이 경우 제휴/입점문의 및 상담신청이 불가능합니다.)</li>
							<li>수집하는 개인정보 항목(필수항목): 회사명, 이름, E-mail</li>
							<li>수집 및 이용목적: 제휴/입점사 검토, 제휴/입점사 관리시스템의 운용, 공지사항의 전달 등</li>
							<li>보유기간 및 이용기간: 수집된 정보는 제휴/입점문의 및 상담서비스가 종료되는 시점까지 보관됩니다.</li>
						</ol>
						<table class="table-list mt-4 md:mt-5">
							<thead>
								<tr>
									<th scope="col"><p>목적</p></th>
									<th scope="col"><p>항목</p></th>
									<th scope="col"><p>보유 기간</p></th>
								</tr>
							</thead>
							<tbody>
								<tr class="text-center">
									<td>사업자 식별, 제휴/입점 검토</td>
									<td>회사명, 이름, E-mail</td>
									<td>제휴/입점 처리 기간이<br> 종료되는 시점까지
									</td>
								</tr>
								<tr class="bot-border">
									<td></td>
									<td></td>
									<td></td>
								</tr>
							</tbody>
						</table>
					</div>
				</div>
			</div>

			<div class="form-check mt-4 md:mt-5">
				<input class="form-check-input" type="checkbox" name="cntntsAgree" id="cntntsAgree" value="Y">
				<label class="form-check-label" for="cntntsAgree">개인정보 수집 및 이용에 동의합니다.</label>
			</div>

			<div class="content-button mt-11 md:mt-18">
				<button type="submit" class="btn btn-primary btn-large w-40 md:w-50">문의 등록</button>
			</div>
		</form>
	</div>
</main>

<script>
	$(function(){

		const emailchk = /^[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*\.[a-zA-Z]{2,3}$/i;

		$.validator.addMethod("regex", function(value, element, regexpr) {
			if(value != ''){
				return regexpr.test(value)
			}else{
				return true;
			}
		}, "이메일 형식이 일치하지 않습니다. ");

		$.validator.addMethod("agreeChk", function(value,element){
			if($("#cntntsAgree").is(":checked")){
				return true;
			}else{
				return false;
			}
		},"개인정보 수집 및 이용에 동의해 주세요.");

		$("#inqryFrm").validate({
		    ignore: "input[type='text']:hidden",
		    rules : {
		    	bsnsNm : { required : true}
		    ,	cntntsNm : {required : true}
		    ,	cntntsEml : {required : true, regex : emailchk}
		    ,	cntntsSj : {required : true}
		    ,	cntnts : {required : true}
		    ,	cntntsAgree : {agreeChk : true}
		    },
		    messages : {
		    	bsnsNm : { required : "회사명을 입력해주세요."}
		    ,	cntntsNm : {required : "이름을 입력해주세요."}
		    ,	cntntsEml : {required : "이메일을 입력해주세요."}
		    ,	cntntsSj : {required : "제목을 입력해주세요."}
		    ,	cntnts : {required : "내용을 입력해주세요."}
		    },
		    onfocusout: false,
		    onkeyup : false,
		    onclick : false,
		    showErrors : function(errorMap, errorList){
		    	if(errorList.length){
		    		alert(errorList[0].message);
		    	}
		    },
		    submitHandler: function (frm) {
		    	var confirmMsg = "사업제휴";

		    	if($("input[name='inqryTy']:checked").val() != "bsns"){
		    		confirmMsg = "마켓입점";
		    	}

		    	$("input[name='inqryTy']:checked").val(confirmMsg);

		    	if(confirm(confirmMsg + " 문의를 등록하시겠습니까?")){
		    		frm.submit();
		    	}else{
		    		return false;
		    	}
		    }
		});

	});
</script>