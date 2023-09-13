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

			<c:if test="${mbrVO.joinTy eq 'E'}">
			<li><a href="./pswd?returnUrl=${param.returnUrl}" class="tabs-link"><strong>비밀번호</strong> 변경</a></li>
			</c:if>

		</ul>

		<div class="member-modify mt-11 md:mt-15">
			<form:form action="./infoAction" id="frmReg" name="frmReg" method="post" modelAttribute="mbrVO" enctype="multipart/form-data" class="member-join-content">
				<form:input type="hidden" path="delProflImg" id="delProflImg" name="delProflImg" value="N" />
				<form:hidden path="proflImg" />
				<form:hidden path="diKey" />
				<form:hidden path="joinTy" />

				<input type="hidden" id="rcognGrad" name="rcognGrad" value="${mbrVO.recipterInfo.rcognGrad}" />
				<input type="hidden" id="selfBndRt" name="selfBndRt" value="${mbrVO.recipterInfo.selfBndRt}" />
				<input type="hidden" id="vldBgngYmd" name="vldBgngYmd" value="<fmt:formatDate value="${mbrVO.recipterInfo.vldBgngYmd}" pattern="yyyy-MM-dd" />" />
				<input type="hidden" id="vldEndYmd" name="vldEndYmd" value="<fmt:formatDate value="${mbrVO.recipterInfo.vldEndYmd}" pattern="yyyy-MM-dd" />" />
				<input type="hidden" id="aplcnBgngYmd" name="aplcnBgngYmd" value="<fmt:formatDate value="${mbrVO.recipterInfo.aplcnBgngYmd}" pattern="yyyy-MM-dd" />" />
				<input type="hidden" id="aplcnEndYmd" name="aplcnEndYmd" value="<fmt:formatDate value="${mbrVO.recipterInfo.aplcnEndYmd}" pattern="yyyy-MM-dd" />" />
				<input type="hidden" id="sprtAmt" name="sprtAmt" value="${mbrVO.recipterInfo.sprtAmt}" />
				<input type="hidden" id="bnefBlce" name="bnefBlce" value="${mbrVO.recipterInfo.bnefBlce}" />
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
							<th scope="row">
								<c:set var="joinTy">
								<c:choose>
									<c:when test="${_mbrSession.joinTy eq 'K'}">카카오</c:when>
									<c:when test="${_mbrSession.joinTy eq 'N'}">네이버</c:when>
								</c:choose>
								</c:set>
								<p>${joinTy} 아이디</p>
							</th>
							<td><p class="text-base font-bold md:text-lg">${_mbrSession.mbrId}</p></td>
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
							<th scope="row"><p>휴대폰 번호</p></th>
							<td>
								<div class="form-group w-full">
									<form:input class="form-control w-full max-w-73" path="mblTelno" maxlength="13" readonly="true" />
									<button type="button" class="btn btn-primary" id="mbrTelnoChg">변경</button>
								</div>
							</td>
						</tr>
						<tr>
							<th scope="row"></th>
							<td>
								<p class="text-sm">
									전화번호를 입력해주세요.
								</p>
							</td>
						</tr>
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
									<input type="text" class="form-control w400 numbercheck" id="rcperRcognNo" name="rcperRcognNo" maxlength="13" value="${mbrVO.recipterInfo.rcperRcognNo}">
								</div>
							</td>
						</tr>
					</tbody>
				</table>

				<div class="content-button mt-4">
					<button type="button" class="btn btn-primary btn-large flex-1 md:flex-none md:w-73 f_recipterCheck" name="srchReBtn">수급자 정보 조회</button>
					<button type="button" class="btn btn-outline-primary btn-large w-[26.5%]" id="newInfo">초기화</button>
				</div>

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
								<img id="searchGrade" src="<c:if test="${!empty mbrVO.recipterInfo.rcognGrad}">/html/page/members/assets/images/txt-grade-num${mbrVO.recipterInfo.rcognGrad}.png</c:if>">
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
							<strong id="searchUseAmt"><fmt:formatNumber value="${mbrVO.recipterInfo.sprtAmt -  mbrVO.recipterInfo.bnefBlce}" /></strong> 원
						</dd>
					</dl>

				</div>

				<p class="mt-11 text-title2">선택 정보</p>
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
									<label for="join-item-inter1">관심분야</label>
								</p></th>
							<td>
								<div class="content-interest">
									<c:forEach var="itrstCode" items="${itrstCode}" varStatus="status">
										<div class="form-check">
											<input class="form-check-input" type="checkbox" id="itrstCode${status.index}" name="itrstField" value="${itrstCode.key}" >
											<label class="form-check-label" for="itrstCode${status.index}">${itrstCode.value}</label>
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
								<p class="mt-1.5 text-sm">
									<strong>선택 시</strong>, 장기 미접속시에도 휴면회원으로 전환되지 않고 회원 혜택을 받으실 수 있습니다.
								</p>
								<p class="mt-1.5 text-sm">
									<strong>미선택시</strong>, 개인정보 유효기간은 1년입니다.
								</p>
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
								<p class="mt-2 text-sm">이벤트 및 다양한 정보를 받으실 수 있습니다.</p>
								<p class="mt-1.5 text-sm">수신 동의와 상관없이 주문/배송 관련 SMS/메일은 발송 됩니다.</p>
							</td>
						</tr>
						<tr>
							<th scope="row"><p>프로필 사진</p></th>
							<td>
								<div class="flex space-x-2">
									<div class="w-31 h-31 img" <c:if test="${empty mbrVO.proflImg}">style="display:none;"</c:if>>
										<img src="/comm/PROFL/getFile?fileName=${mbrVO.proflImg}" alt="" class="w-full h-full object-cover" id="profImg">
									</div>
									<div class="form-upload">
										<label for="uploadFile" class="form-upload-trigger">
									 		파일을 선택해주세요.<br>
									 		5MB 이하의 이미지만 첨부가 가능합니다.
									 	</label>
										<input type="file" class="form-upload-control" id="uploadFile" name="uploadFile" onchange="fileCheck(this);">
									</div>
									<button type="button" class="btn btn-primary" id="delBtn" onclick="f_delProflImg(); return false;">삭제</button>
								</div>
							</td>
						</tr>
					</tbody>
				</table>

				<div class="content-button mt-20 md:mt-25">
					<button type="submit" class="btn btn-primary btn-large sm:w-53 sm-max:flex-1">확인</button>
					<!-- TODO : 플래너로 변경 -->
					<a href="${_marketPath}" class="btn btn-outline-primary btn-large w-[37.5%] sm:w-37">취소</a>
				</div>
				</form:form>
		</div>
	</div>
</main>
<script>

// 프로필 이미지 실시간 변경
function setImageFromFile(input, expression) {
	    if (input.files && input.files[0]) {
	    var reader = new FileReader();
	    reader.onload = function (e) {
	    $(expression).attr('src', e.target.result);
	  }
	  reader.readAsDataURL(input.files[0]);
	  }

}

//프로필 이미지 삭제
function f_delProflImg(){
	if(confirm("삭제하시겠습니까?")){
		$("#delProflImg").val("Y");
		$("#delBtn").hide();
		$("#profImg").attr('src',"");
		$(".img").hide();
		$(".form-upload").show();
	}else{
		return false;
	}
}

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
      				var telno = data.mblTelno;
      				telno = telno.substring(0,3) + "-" + telno.substring(3,7) + "-" + telno.substring(7,11);
      				$("#mblTelno").val(telno);
      				$("#diKey").val(data.diKey);
      				alert("인증되었습니다.");
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

$(function(){

	const telchk = /^0([0-9]{2})-?([0-9]{3,4})-?([0-9]{4})$/;
	const emailchk = /^[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*\.[a-zA-Z]{2,3}$/i;

	// 관심 분야
	let itemList = "${mbrVO.itrstField}";
	itemList = itemList.replaceAll(' ','').split(',');
	for(var i=0; i<8; i++){
		for(var h=0; h<itemList.length; h++){
			if($("#itrstCode"+i).val() == itemList[h]){
				$("#itrstCode"+i).prop("checked",true);
			}
		}
	}

	if($(".agree:checked").length == 3){
		$("#allChk").prop("checked",true);
	}

	// 한글 변환
	$(".money").text(viewKorean("${mbrVO.recipterInfo.bnefBlce}"));

	//전체 수신
	$("#allChk").on("click",function(){
		if($("#allChk").is(":checked")){
			$(".agree").prop("checked",true);
		}else{
			$(".agree").prop("checked",false);
		}
	});

	$(".agree").on("click",function(){
		if($(".agree:checked").length == 3){
			$("#allChk").prop("checked",true);
		}else{
			$("#allChk").prop("checked",false);
		}
	});

	// 수급자 정보
	$("input[name='recipterYn']").on("click",function(){
		if($("#recipterYn0").is(":checked")){
			$("#newInfo").click();
			$(".wrapNm, .wrapNo, .f_recipterCheck, #wrapInfo, #newInfo").hide();
		}else{
			//$("#recipter").val("${mbrVO.mbrNm}");
			$(".wrapNm, .wrapNo, .f_recipterCheck, #newInfo").show();
		}
	});

	// 정보수신
	if($("input[name='smsRcptnYn']").is(":checked") && $("input[name='emlRcptnYn']").is(":checked") && $("input[name='telRecptnYn']").is(":checked")){
		$("#allchk").prop("checked",true);
	}

	// 프로필 사진
	$("#uploadFile").change(function(){
    	setImageFromFile(this, "#profImg");
    	$(".form-upload").hide()
    	$(".img").show();
    	$("#delBtn").show();

	});

	if("${mbrVO.proflImg}" != ''){
		$(".form-upload").hide();
	}else{
		$(".form-upload").show();
		$(".img").hide();
		$("#delBtn").hide();
	}

	if($("#recipterYn0").is(":checked")){
		$(".wrapNm, .wrapNo, .f_recipterCheck, #wrapInfo, #newInfo").hide();
	}else{
		$(".wrapNm, .wrapNo, .f_recipterCheck, #wrapInfo, #newInfo").show();
	}

	//초기화
	$("#newInfo").on("click",function(){
		$("#recipter").val(null);
		$("#rcperRcognNo").val(null);
		$(".noneGrade").prop("selected",true);
		$("#noneGrade").val('');
		$("#selfBndRt").val('');
		$("#wrapInfo").hide();
	});

	// 휴대폰 번호 변경
	$("#mbrTelnoChg").on("click",function(){
		if(confirm("휴대폰 번호를 변경하시겠습니까?")){
			f_cert();
		}else{
			return false;
		}
	});

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
            if(!json.isSearch) {
                alert(json.msg);
                return;
            }

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
				$("#searchUseAmt").html(comma(json.infoMap.USE_AMT));

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
	}, "형식이 올바르지 않습니다.");

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

	}, "형식이 올바르지 않습니다.");

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