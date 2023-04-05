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
				<input type="hidden" id="selfBndRt" name="selfBndRt" value="" />
				<input type="hidden" id="vldBgngYmd" name="vldBgngYmd" value="" />
				<input type="hidden" id="vldEndYmd" name="vldEndYmd" value="" />
				<input type="hidden" id="aplcnBgngYmd" name="aplcnBgngYmd" value="" />
				<input type="hidden" id="aplcnEndYmd" name="aplcnEndYmd" value="" />
				<input type="hidden" id="sprtAmt" name="sprtAmt" value="" />
				<input type="hidden" id="bnefBlce" name="bnefBlce" value="" />
				<input type="hidden" id="rcognGrad" name="rcognGrad" value="" />

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
									영문으로 띄어쓰기 없이 6~15자로 입력해주세요.
								</p>
							</td>
						</tr>
						<tr>
							<th scope="row">
								<p>
									<label for="join-item1-2">비밀번호<sup class="text-danger text-base md:text-lg">*</sup></label>
								</p>
							</th>
							<td><form:input type="password" class="form-control w-full" path="pswd" /></td>
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
							<td><input type="password" class="form-control w-full" id="pswdConfirm" name="pswdConfirm"></td>
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
						<tr>
							<td colspan="2">
								<div class="content-select py-1.5">
									<c:forEach var="reYn" items="${recipterYnCode}" varStatus="status">
									<div class="form-check">
										<form:radiobutton class="form-check-input" path="recipterYn" id="recipterYn${status.index}" value="${reYn.key}" />
										<label class="form-check-label" for="recipterYn${status.index}">${reYn.key eq 'Y'?'장기요양등급 수급자':'해당없음'}<small>(${reYn.value})</small></label>
									</div>
									</c:forEach>
								</div>
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
								<div class="form-group w-full">
									<p class="px-1.5 font-serif text-[1.375rem] font-bold md:text-2xl">L</p>
									<input type="text" class="form-control w400" id="rcperRcognNo" name="rcperRcognNo" maxlength="13" value="${mbrVO.recipterInfo.rcperRcognNo}">
								</div>
							</td>
						</tr>
					</tbody>
				</table>
				<div class="content-button mt-4">
					<button type="button" class="btn btn-primary btn-large flex-1 md:flex-none md:w-73 f_recipterCheck" name="srchReBtn">수급자 정보 조회</button>
					<button type="button" class="btn btn-outline-primary btn-large w-[26.5%]" id="newInfo">초기화</button>
				</div>
				</br>
				<div class="content-recipient mt-9.5" id="wrapInfo">
					<div class="title">
						<p class="name">
							<strong id="searchNm">${mbrVO.recipterInfo.mbrNm}</strong> 님의
						</p>
						<p class="desc">장기요양 정보</p>
					</div>
					<div class="group1">
						<dl class="number">
							<dt>장기요양인정번호</dt>
							<dd id="searchNo">L${mbrVO.recipterInfo.rcperRcognNo}</dd>
						</dl>
						<dl class="grade">
							<dt>등급</dt>
							<dd>
								<img id="searchGrade" src="<c:if test="${!empty mbrVO.recipterInfo.rcognGrad}">/html/page/market/assets/images/content2/num${mbrVO.recipterInfo.rcognGrad}.png</c:if>">
							</dd>
						</dl>
					</div>
					<div class="group2">
						<dl class="percent">
							<dt>본인부담율</dt>
							<dd>
								<strong id="searchQlf">${mbrVO.recipterInfo.selfBndRt}</strong> &nbsp;%
							</dd>
						</dl>
						<dl class="date">
							<dt>인정유효기간</dt>
							<dd>
								<p id="searchBgngRcgt">
									<fmt:formatDate value="${mbrVO.recipterInfo.vldBgngYmd}" pattern="yyyy-MM-dd" />
								</p>
								<p id="searchEndRcgt">
									~&nbsp;
									<fmt:formatDate value="${mbrVO.recipterInfo.vldEndYmd}" pattern="yyyy-MM-dd" />
								</p>
							</dd>
						</dl>
						<dl class="date">
							<dt>적용기간</dt>
							<dd>
								<p id="searchBgngApdt">
									<fmt:formatDate value="${mbrVO.recipterInfo.aplcnBgngYmd}" pattern="yyyy-MM-dd" />
								</p>
								<p id="searchEndApdt">
									~&nbsp;
									<fmt:formatDate value="${mbrVO.recipterInfo.aplcnEndYmd}" pattern="yyyy-MM-dd" />
								</p>
							</dd>
						</dl>
					</div>
					<dl class="price1">
						<dt>급여잔액</dt>
						<dd>
							<strong id="searchRemn"><fmt:formatNumber value="${mbrVO.recipterInfo.bnefBlce}" pattern="###,###" /></strong> &nbsp; 원 <small id="formatKo"></small>
						</dd>
					</dl>
					<dl class="price2">
						<dt>사용금액</dt>
						<dd>
							<strong id="searchUseAmt"><fmt:formatNumber value="${mbrVO.recipterInfo.sprtAmt -  mbrVO.recipterInfo.bnefBlce}" /></strong>
						</dd>
					</dl>

				</div>

				<p class="mt-17 text-title2">선택 정보</p>
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
									<label for="join-item-inter1">관심분야</label>
								</p></th>
							<td>
								<div class="content-interest">
									<c:forEach var="itrst" items="${itrstFieldCode}" varStatus="status">
										<div class="form-check">
											<input class="form-check-input" type="checkbox" id="itrst${status.index}" name="itrstField" value="${itrst.key}">
											<label class="form-check-label" for="itrst${status.index}">${itrst.value}</label>
										</div>
									</c:forEach>
								</div>
							</td>
						</tr>
						<tr>
							<th scope="row"></th>
							<td>
								<p class="text-sm">
									현재 관심있는 분야를 선택하고<br> 시니어에게 필요한 복지서비스를 추천받으세요
								</p>
							</td>
						</tr>
						<tr>
							<th scope="row"><p>
									<label for="rcmdtnId">추천인 아이디</label>
								</p></th>
							<td><form:input class="form-control w-full" path="rcmdtnId" maxlength="100" /></td>
						</tr>
						<tr>
							<th scope="row"></th>
							<td>
								<p class="text-sm">
									추천인에게 500포인트가 제공됩니다.
								</p>
							</td>
						</tr>
						<tr>
							<th scope="row"><p style="padding-left: 0;">
									<label for="rcmdtnMbrsId">추천 멤버스 아이디</label>
								</p></th>
							<td><form:input class="form-control w-full" path="rcmdtnMbrsId" maxlength="100" /></td>
						</tr>
						<tr>
							<th scope="row"></th>
							<td>
								<p class="text-sm">
									복지용구 사업소에서 안내 받은 아이디를 입력하세요.
								</p>
							</td>
						</tr>
						<tr>
							<th scope="row"><p>
									<label for="telno">전화번호</label>
								</p></th>
							<td><form:input class="form-control w-full" path="telno" maxlength="13" oninput="autoHyphen(this);" /></td>
						</tr>
						<tr>
							<th scope="row"></th>
							<td>
								<p class="text-sm">
									숫자만 입력해주세요.
								</p>
							</td>
						</tr>
						<tr>
							<th scope="row"><p style="padding-left: 0;">
									<label for="join-item3-3">개인정보 유효기간</label>
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
										<form:checkbox class="form-check-input" path="smsRcptnYn" value="Y" />
										<label class="form-check-label" for="smsRcptnYn">SMS</label>
									</div>
									<div class="form-check mr-3 xs:mr-auto">
										<form:checkbox class="form-check-input" path="emlRcptnYn" value="Y" />
										<label class="form-check-label" for="emlRcptnYn">이메일</label>
									</div>
									<div class="form-check mr-3 xs:mr-auto">
										<form:checkbox class="form-check-input" path="telRecptnYn" value="Y" />
										<label class="form-check-label" for="telRecptnYn">휴대폰</label>
									</div>
								</div>
							</td>
						</tr>
						<tr>
							<th scope="row"><p>
									<label for="join-item3-5">사진 등록</label>
								</p></th>
							<td>
								<div class="relative mb-4 aspect-square overflow-hidden rounded-md" style="display: none;">
									<input type="file" class="absolute top-0 left-0 w-full h-full opacity-0"> <img src="" alt="" class="w-full h-full object-cover" id="profImg">
								</div>

								<div class="form-upload">
									<label for="uploadFile" class="form-upload-trigger"> 파일을 선택해주세요. </label>
									<input type="file" class="form-upload-control" id="uploadFile" name="uploadFile" onchange="fileCheck(this);" multiple>
								</div>
								<p class="text-sm">e.g. 5MB 이하</p>
							</td>
						</tr>
					</tbody>
				</table>

				<div class="content-button mt-25">
					<button type="submit" class="btn btn-primary btn-large flex-1">정보 입력 완료</button>
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
	const pswdChk = /^.*(?=.*\d)(?=.*[a-zA-Z])(?=.*[!@#$%^&+=]).*$/;
	const emailchk = /^[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*.[a-zA-Z]{2,3}$/i;
	const telchk = /^([0-9]{2,3})?-([0-9]{3,4})?-([0-9]{3,4})$/;
	const rcperChk = /^([0-9]{1}-[0-9]{5}-[0-9]{5})$/;

	// 한글 변환
	$(".money").text(viewKorean("${mbrVO.recipterInfo.bnefBlce}"));

	// 수급자 정보
	$("input[name='recipterYn']").on("click",function(){
		if($("#recipterYn0").is(":checked")){
			$("#newInfo").click();
			$(".wrapNm, .wrapNo, .f_recipterCheck, #wrapInfo, #newInfo").hide();
		}else{
			$("#recipter").val("${mbrVO.mbrNm}");
			$(".wrapNm, .wrapNo, .f_recipterCheck, #newInfo").show();
		}
	});

	//체크 박스 값
	$("#smsRcptnYn1,#emlRcptnYn1,#telRecptnYn1").on("click",function(){
		!$(this).is(":checked") ? $(this).val("N") : $(this).val("Y");
	})

	//전체 수신
	$("#allChk").on("click",function(){
		$("#allChk").is(":checked") ? $("#smsRcptnYn1,#emlRcptnYn1,#telRecptnYn1").prop("checked",true) : $("#smsRcptnYn1,#emlRcptnYn1,#telRecptnYn1").prop("checked",false)
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

	//첨부파일 이미지 변경
	$("#uploadFile").change(function(){
    	setImageFromFile(this, "#profImg");
    	$("#profImg").parent("div .rounded-md").css("display","");
	});

	if($("#recipterYn0").is(":checked")){
		$(".wrapNm, .wrapNo, .f_recipterCheck, #wrapInfo, #newInfo").hide();
	}else{
		$(".wrapNm, .wrapNo, .f_recipterCheck, #wrapInfo, #newInfo").show();
	}

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


			$("#searchGrade").attr("src", "/html/page/market/assets/images/content2/num"+json.infoMap.LTC_RCGT_GRADE_CD+".png");
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
	}, "형식이 올바르지 않습니다.");

	//유효성
	$("form#frmReg").validate({
	    ignore: "input[type='text']:hidden",
	    rules : {
	    	mbrId : {required : true , regex : idchk, remote:"/market/mbr/mbrIdChk.json"}
	    	, pswd : {required : true, regex : pswdChk, minlength : 8}
	    	, pswdConfirm : {required : true, equalTo : "#pswd", regex : pswdChk, minlength : 8}
			, eml : {required : true, regex : emailchk}
			, zip : {required : true, }
			, addr : {required : true}
			, daddr : {required : true}
			/*, recipter : {equalTo : "${noMbrVO.mbrNm}"}*/
			, rcmdtnId : {regex : idchk}
			, telno : {regex : telchk}
			, agreeItem : {agreeChk : true}
			, recipter : {repChk : true}
			, rcperRcognNo : {repChk : true, searchChk : true}
			//, rcognGrad : {gradChk : true}
			//, selfBndRt : {selfChk : true}
	    },
	    messages : {
	    	mbrId : {required : "! 아이디를 입력해 주세요" , regex : "! 영문으로 띄어쓰기 없이 6~15자  영문,숫자를 조합하여 입력해 주세요.", remote:"! 사용할수 없는 아이디 입니다"}
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