<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<main id="container">
	<header id="page-title">
		<h2>
			<span>회원가입</span> <small>Member Join</small>
		</h2>
	</header>

	<div id="page-content">
		<div class="member-join">
			<div class="member-join-sidebar">
				<p class="text">
					<span>STEP 1</span>
				</p>
			</div>

			<div class="member-join-step2">
				<img src="/html/page/members/assets/images/txt-join-number2.svg" alt="STEP 2">
			</div>

			<form:form action="/membership/action" class="member-join-content" id="frmReg" name="frmReg" method="post" modelAttribute="mbrVO" enctype="multipart/form-data">
				<form:hidden path="crud" />
				<input type="hidden" id="termsYn" name="termsYn" value="${mbrAgreementVO.termsYn}" />
				<input type="hidden" id="termsDt" name="termsDt" value="<fmt:formatDate value="${mbrAgreementVO.termsDt}" pattern="yyyy-MM-dd HH:mm:ss" />" />
				<input type="hidden" id="privacyYn" name="privacyYn" value="${mbrAgreementVO.privacyYn}" />
				<input type="hidden" id="privacyDt" name="privacyDt" value="<fmt:formatDate value="${mbrAgreementVO.privacyDt}" pattern="yyyy-MM-dd HH:mm:ss" />" />
				<input type="hidden" id="provisionYn" name="provisionYn" value="${mbrAgreementVO.provisionYn}" />
				<input type="hidden" id="provisionDt" name="provisionDt" value="<fmt:formatDate value="${mbrAgreementVO.provisionDt}" pattern="yyyy-MM-dd HH:mm:ss" />" />
				<input type="hidden" id="thirdPartiesYn" name="thirdPartiesYn" value="${mbrAgreementVO.thirdPartiesYn}" />
				<input type="hidden" id="thirdPartiesDt" name="thirdPartiesDt" value="<fmt:formatDate value="${mbrAgreementVO.thirdPartiesDt}" pattern="yyyy-MM-dd HH:mm:ss" />" />
				<input type="hidden" name="returnUrl" value="${param.returnUrl}" />

				<double-submit:preventer tokenKey="preventTokenKey" />

				<ul class="member-tabs mb-5.5 xs:mb-11">
					<li><span>약관동의 및 본인인증</span></li>
					<li><a href="/membership/registStep2" class="active">정보입력</a></li>
					<li><span>가입완료</span></li>
				</ul>

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
							<th scope="row"><p>이름</p></th>
							<td><p class="text-base font-bold md:text-lg" id="mbrNm">${noMbrVO.mbrNm}</p></td>
						</tr>
						<tr>
							<th scope="row"><p>생년월일</p></th>
							<td><p class="text-base font-bold md:text-lg" id="brdt">
									<fmt:formatDate value="${noMbrVO.brdt}" pattern="yyyy년 MM월 dd일" />
								</p></td>
						</tr>
						<tr>
							<th scope="row"><p>성별</p></th>
							<td><p class="text-base font-bold md:text-lg" id="gender">${genderCode[noMbrVO.gender]}</p></td>
						</tr>
						<tr>
							<th scope="row"><p>휴대폰 번호</p></th>
							<td><p class="text-base font-bold md:text-lg" id="mblTelno">${noMbrVO.mblTelno}</p></td>
						</tr>
						<tr>
							<th scope="row">
								<p>
									<label for="join-item1">아이디<sup class="text-danger text-base md:text-lg">*</sup></label>
								</p>
							</th>
							<td><form:input class="form-control w-full" path="mbrId" maxlength="15" /></td>
						</tr>
						<tr>
							<th scope="row"></th>
							<td>
								<p class="text-sm">
									6~15자 영문,숫자를 조합하여 입력해 주세요.
								</p>
							</td>
						</tr>
						<tr>
							<th scope="row">
								<p>
									<label for="join-item1-2">비밀번호<sup class="text-danger text-base md:text-lg">*</sup></label>
								</p>
							</th>
							<td><form:input type="password" class="form-control w-full" path="pswd" maxlength="16"/></td>
						</tr>
						<tr>
							<th scope="row"></th>
							<td>
								<p class="text-sm">
									띄어쓰기 없이 8~16자 영문, 숫자, 특수문자를 조합하여 입력해주세요. (특수문자는 !,@,#,$,%,^,&,*만 사용 가능) 아이디와 동일한 비밀번호는 사용 할 수 없습니다.
								</p>
							</td>
						</tr>
						<tr>
							<th scope="row">
								<p>
									<label for="join-item1-3">비밀번호 확인<sup class="text-danger text-base md:text-lg">*</sup></label>
								</p>
							</th>
							<td><input type="password" class="form-control w-full" id="pswdConfirm" name="pswdConfirm" maxlength="16"></td>
						</tr>
						<tr>
							<th scope="row"></th>
							<td>
								<p class="text-sm">
									비밀번호 확인을 위해 다시 한번 입력해주세요.
								</p>
							</td>
						</tr>
						<tr>
							<th scope="row">
								<p>
									<label for="join-item1-4">이메일<sup class="text-danger text-base md:text-lg">*</sup></label>
								</p>
							</th>
							<td><form:input class="form-control w-full" path="eml" maxlength="50"/></td>
						</tr>
						<tr>
							<th scope="row"></th>
							<td>
								<p class="text-sm">
									주문/배송 및 공지를 위해 정확한 정보를 입력해 주세요.
								</p>
							</td>
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

				<div class="text-title2-wrap mt-13">
					<p class="text-title2">수급자(어르신) 정보</p>
				</div>
				<div class="table-detail-wrap">
					<div class="flex flex-row justify-between items-center">
						<p class="text-gray5">수급자 입력 <span>1</span></p>
						<!--2개 이상일 경우 닫기버튼 노출-->
						<i class="icon-close">닫기</i>
					</div>
					<table class="table-detail">
						<colgroup>
							<col class="w-22 xs:w-32">
							<col>
						</colgroup>
						<tbody>
							<tr class="wrapRelation">
								<th scope="row"><p>
										<label for="recipter">수급자와의 관계</label>
									</p></th>
								<td>
									<select name="relationSelect" id="relationSelect" class="form-control w-full">
											<option value="">선택</option>
											<c:forEach var="relation" items="${mbrRelationCode}" varStatus="status">
												<option value="${relation.key}">${relation.value}</option>	
											</c:forEach>
									</select>
								</td>
							</tr>
							<tr class="wrapNm">
								<th scope="row"><p>
										<label for="recipter">수급자 성명</label>
									</p></th>
								<td><!-- <input type="text" class="form-control w-full" id="recipter" name="recipter" maxlength="50" value="${mbrVO.mbrNm}"> -->
									<input type="text" class="form-control w-full" id="recipter" name="testName" maxlength="50" value="${mbrVO.recipterInfo.testName}">
								</td>
							</tr>
							<tr class="wrapNo">
								<th scope="row"><p style="padding-left: 0;">
										<label for="rcperRcognNo">요양인정번호</label>
									</p></th>
								<td>
									<div class="flex flex-row gap-2.5 mb-1.5">
										<div class="form-check">
											<input class="form-check-input" type="radio" name="yn" id="yes" checked>
											<label class="form-check-label" for="yes">있음</label>
										</div>
										<div class="form-check">
											<input class="form-check-input" type="radio" name="yn" id="no">
											<label class="form-check-label" for="no">없음</label>
										</div>
									</div>
									<div class="form-group w-full">
										<p class="px-1.5 font-serif text-[1.375rem] font-bold md:text-2xl">L</p>
										<input type="text" class="form-control w400" id="rcperRcognNo" name="rcperRcognNo" maxlength="13" value="${mbrVO.recipterInfo.rcperRcognNo}">
									</div>
								</td>
							</tr>
						</tbody>
					</table>
					<div class="content-button mt-2">
						<!-- <button type="button" class="btn btn-primary btn-large flex-1 f_recipterCheck" name="srchReBtn">등록하기</button>
						<button type="button" class="btn btn-outline-primary btn-large w-[26.5%]" id="newInfo">삭제</button> -->
						<button type="button" class="btn btn-primary large flex-1" name="" data-bs-toggle="modal" data-bs-target="#check-recipient-info">등록하기</button>
					</div>
				</div>
				
				<div class="content-button mt-2">
					<button type="button" class="btn btn-outline-secondary large flex-1" id="">
						<img src="/html/page/members/assets/images/ico-plus.svg" alt="추가하기" class="w-4.5">
					</button>
				</div>
				

				<p class="mt-13 text-title2">정보수신 동의</p>
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

				<div class="content-button mt-25">
					<button type="submit" class="btn btn-primary btn-large flex-1">가입하기</button>
					<a href="membership/login" class="btn btn-outline-primary btn-large w-[37.5%]">취소</a>
				</div>
			</form:form>

			<div class="member-join-sidebar is-step2">
				<p class="text">
					<span>STEP 3</span>
				</p>
			</div>
		</div>
	</div>
	
	<!--등록하는 수급자 정보를 확인하세요-->
	<div class="modal modal-default fade" id="check-recipient-info" tabindex="-1" aria-hidden="true">
		<div class="modal-dialog modal-dialog-centered">
			<div class="modal-content">
				<div class="modal-header">
					<h2 class="text-title">등록하신 수급자 정보를 확인하세요</h2>
					<button data-bs-dismiss="modal" class="btn-close">모달 닫기</button>
				</div>

				<div class="modal-body">
					<div class="text-subtitle">
						<i class="icon-alert"></i>
						<p>회원이 이용약관에 따라 수급자 등록과 관리하는 것에 동의합니다</p>
					</div>
					<div class="modal-bg-wrap">
						<ul class="modal-list-box">
							<li>
								<span class="modal-list-label">수급자와의 관계</span>
								<span class="modal-list-value">본인</span>
							</li>
							<li>
								<span class="modal-list-label">수급자 성명</span>
								<span class="modal-list-value">홍길동</span>
							</li>
							<!--modal B : 아래 내용없음-->
							<li>
								<span class="modal-list-label">요양인정번호</span>
								<span class="modal-list-value">L1234567890</span>
							</li>
						</ul>
					</div>
					<!--modal B : 추가-->
					<div class="text-subtitle">
						<i class="icon-alert"></i>
						<p>요양인정번호는 마이페이지에서 등록하실 수 있어요</p>
					</div>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-primary w-full">확인</button>
				</div>
			</div>
		</div>
	</div>
	<!--// 등록하는 수급자 정보를 확인하세요-->
</main>

<script>

//사진 실시간 변경
function setImageFromFile(input, expression) {
	    if (input.files && input.files[0]) {
	    var reader = new FileReader();
	    reader.onload = function (e) {
	    $(expression).attr('src', e.target.result);
	  }
	  reader.readAsDataURL(input.files[0]);
	  }

}

$(function(){

	const idchk = /^[a-zA-Z][A-Za-z0-9]{5,14}$/;
	const pswdChk = /^.*(?=.*\d)(?=.*[a-zA-Z])(?=.*[!@#$%^&+*=*]).*$/;
	const emailchk = /^[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*\.[a-zA-Z]{2,3}$/i;
	const telchk = /^([0-9]{2,3})?-([0-9]{3,4})?-([0-9]{3,4})$/;
	const rcperChk = /^([0-9]{1}-[0-9]{5}-[0-9]{5})$/;
	
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

	// 한글 변환
	$(".money").text(viewKorean("${mbrVO.recipterInfo.bnefBlce}"));

	//체크 박스 값
	$("#smsRcptnYn1,#emlRcptnYn1,#telRecptnYn1").on("click",function(){
		!$(this).is(":checked") ? $(this).val("N") : $(this).val("Y");
	})

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

	//초기화
	$("#newInfo").on("click",function(){
		$("#recipter").val(null);
		$("#rcperRcognNo").val(null);
		$(".noneGrade").prop("selected",true);
		$("#noneGrade").val('');
		$("#selfBndRt").val('');
		$("#wrapInfo").hide();
	});

	// 수급자 일때 정보 체크
	$.validator.addMethod("repChk", function(value, element) {
		if($("#recipterYn1").is(":checked")){
			if($("#recipter").val() == '' || $("#rcperRcognNo").val() == ''){
				return false;
			}else{
				return true;
			}
		}else{
			return true;
		}
	}, );

	// 수급자 조회 체크
	$.validator.addMethod("searchChk", function(value, element) {
		if($("#recipterYn1").is(":checked")){
			if($('#wrapInfo').is(':visible')){
				return true;
			}else{
				return false;
			}
		}else{
			return true;
		}
	}, );

	//수급자 정보 조회
	$(".f_recipterCheck").on("click", function(){
		$.ajax({
			type : "post",
			url  : "/common/recipter/getRecipterInfo.json",
			data : {
				//mbrNm:'${noMbrVO.mbrNm}'
				mbrNm:$("#recipter").val()
				, rcperRcognNo:$("#rcperRcognNo").val()
			},
			dataType : 'json'
		})
		.done(function(json) {
			if(json.result){
				$("#wrapInfo").show();


				$("#searchNm").text($("#recipter").val());
				$("#searchNo").text("L"+$("#rcperRcognNo").val());


				let penPayRate = json.infoMap.REDUCE_NM == '일반' ? '15': json.infoMap.REDUCE_NM == '기초' ? '0' : json.infoMap.REDUCE_NM == '의료급여' ? '6': (json.infoMap.SBA_CD.split('(')[1].substr(0, json.infoMap.SBA_CD.split('(')[1].length-1).replaceAll("%",""));
				$("#searchQlf").text(penPayRate);


				$("#searchGrade").attr("src", "/html/page/members/assets/images/txt-grade-num"+json.infoMap.LTC_RCGT_GRADE_CD+".png");
				$("#searchBgngRcgt").html((json.infoMap.RCGT_EDA_DT).split('~')[0].replaceAll(' ',''));
				$("#searchEndRcgt").html("~ " + (json.infoMap.RCGT_EDA_DT).split('~')[1].replaceAll(' ',''));
				$("#searchBgngApdt").html(f_hiponFormat((json.infoMap.APDT_FR_DT)));
				$("#searchEndApdt").html("~ " + f_hiponFormat((json.infoMap.APDT_TO_DT)));
				$("#searchRemn").text(comma(json.infoMap.REMN_AMT))
				$("#formatKo").text(viewKorean(json.infoMap.REMN_AMT))
				$("#searchUseAmt").html(comma(json.infoMap.USE_AMT) + ' <span class="won">원</span>');

				$("#rcperRcognNo").val($("#rcperRcognNo").val());
				$("#rcognGrad").val(json.infoMap.LTC_RCGT_GRADE_CD);
				$("#selfBndRt").val(Number(penPayRate));
				$("#vldBgngYmd").val((json.infoMap.RCGT_EDA_DT).split('~')[0].replaceAll(' ',''));
				$("#vldEndYmd").val((json.infoMap.RCGT_EDA_DT).split('~')[1].replaceAll(' ',''));
				$("#aplcnBgngYmd").val(f_dateFormat(f_hiponFormat(json.infoMap.APDT_FR_DT)));
				$("#aplcnEndYmd").val(f_dateFormat(f_hiponFormat(json.infoMap.APDT_TO_DT)));
				$("#sprtAmt").val(Number(json.infoMap.LMT_AMT));
				$("#bnefBlce").val(Number(json.infoMap.REMN_AMT));

			}else{
				alert("조회된 데이터가 없습니다.");
			}

		})
		.fail(function(data, status, err) {
			console.log('error forward : ' + data);
		});
	});


	// 동의 체크
	$.validator.addMethod("agreeChk", function(value, element, regexpr) {
		if($("#recipterYn1").is(":checked")){
			if($("#agree-item").is(":checked")){
				return true;
			}else{
				alert("장기요양등급 정보 사용에 동의해주세요.");
				return false;
			}
		}else{
			return true;
		}
	}, "! 형식이 올바르지 않습니다.");

	$.validator.addMethod("notEqual", function(value, element, param) {
		  if($("#mbrId").val() === $("#rcmdtnId").val()){
			  return false;
		  }else{
			  return true;
		  }
	}, "! 본인 아이디는 추천 할 수 없습니다.");

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

	//유효성
	$("form#frmReg").validate({
	    ignore: "input[type='text']:hidden",
	    rules : {
	    	mbrId : {required : true , regex : idchk, remote:"/market/mbr/mbrIdChk.json"}
	    	, pswd : {required : true, regex : pswdChk, minlength : 8, pswdFrmChk : true}
	    	, pswdConfirm : {required : true, equalTo : "#pswd", regex : pswdChk, minlength : 8}
			, eml : {required : true, regex : emailchk}
			, zip : {required : true, }
			, addr : {required : true}
			, daddr : {required : true}
			/*, recipter : {equalTo : "${noMbrVO.mbrNm}"}*/
			, rcmdtnId : {regex : idchk, notEqual : "#mbrId"}
			, telno : {regex : telchk}
			, agreeItem : {agreeChk : true}
			, recipter : {repChk : true}
			, rcperRcognNo : {repChk : true, searchChk : true}
			//, rcognGrad : {gradChk : true}
			//, selfBndRt : {selfChk : true}
	    },
	    messages : {
	    	mbrId : {required : "! 아이디를 입력해 주세요" , regex : "! 6~15자 영문,숫자를 조합하여 입력해 주세요.", remote:"! 사용할수 없는 아이디 입니다"}
	    	, pswd : {required : "! 비밀번호는 필수 입력 항목입니다.", minlength : "! 비밀번호는 최소 8자리 입니다."}
	    	, pswdConfirm : {required : "! 비밀번호 확인은 필수 입력 항목입니다.", equalTo : "! 비밀번호가 같지 않습니다.", regex : "! 비밀번호는 영문자, 숫자, 특수문자 조합을 입력해야 합니다.", minlength : "! 비밀번호는 최소 8 자리입니다." }
			, eml : {required : "! 이메일은 필수 입력 항목입니다.", regex : "! 이메일 형식이 잘못되었습니다.\n(abc@def.com)"}
			, zip : {required : "! 우편번호는 필수 입력 항목입니다."}
			, addr : {required : "! 주소는 필수 입력 항목입니다."}
			, daddr : {required : "! 상세 주소는 필수 입력 항목입니다."}
			/*, recipter : {equalTo : "! 회원 이름과 같지 않습니다."}*/
			, rcmdtnId : {regex : "! 6~15자 영문, 숫자를 조합하여 입력해주세요."}
			, telno : {regex : "! 전화번호 형식이 잘못되었습니다.\n(000-0000-0000)"}
			, agreeItem : {agreeChk : ""}
			, recipter : {repChk : "! 수급자 성명은 필수 입력 항목입니다."}
			, rcperRcognNo : {repChk : "! 요양인정번호는 필수 입력 항목입니다.", searchChk : "! 수급자 조회는 필수 선택 항목입니다."}
	    },
	    onfocusout: function(el) { // 추가
            if (!this.checkable(el)){this.element(el); }
        },
	    errorPlacement: function(error, element) {
		    var group = element.closest('.form-group, .form-check');
		    if (group.length) {
		        group.after(error.addClass('text-danger'));
		    } else {
		        element.after(error.addClass('text-danger'));
		    }
		},
	    submitHandler: function (frm) {
   			frm.submit();
	    }
	});
});
</script>