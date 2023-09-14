<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<main id="container" >

	<jsp:include page="../layout/page_header.jsp">
		<jsp:param value="회원가입" name="pageTitle"/>
	</jsp:include>

	<div id="page-container">
		<div id="page-content">
			<div class="member-join">
				<div class="member-join-container">
					<div class="member-join-sidebar">
						<p class="text">
							<span>STEP 1</span>
						</p>
					</div>
					<div class="member-join-step2">
						<img src="/html/page/market/assets/images/txt-join-number2.svg" alt="STEP 2">
					</div>

					<form:form action="./action" class="member-join-content" id="frmReg" name="frmReg" method="post" modelAttribute="mbrVO" enctype="multipart/form-data">
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
							<li><a href="./registStep2" class="active">정보입력</a></li>
							<li><span>가입완료</span></li>
						</ul>

						<p class="mt-13 text-lg font-bold md:text-xl">기본 정보</p>
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
									<td><p class="text-base font-bold md:text-lg" id="brdt"><fmt:formatDate value="${noMbrVO.brdt}" pattern="yyyy년 MM월 dd일" /></p></td>
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
									<td><form:input class="form-control w-full" path="mbrId" maxlength="15"/>
											<p class="text-sm mt-2.5">영문으로 띄어쓰기 없이 6~15자로 입력해주세요</p></td>
								</tr>
								<tr>
									<th scope="row">
										<p>
											<label for="join-item1-2">비밀번호<sup class="text-danger text-base md:text-lg">*</sup></label>
										</p>
									</th>
									<td><form:input type="password" class="form-control w-full" path="pswd" />
											<p class="text-sm mt-2.5">띄어쓰기 없이 8~16자 영문, 숫자, 특수문자를 조합하여 입력해주세요.  (특수문자는 !,@,#,$,%,^,&,*만 사용 가능) 아이디와 동일한 비밀번호는 사용 할 수 없습니다.</p></td>
								</tr>
								<tr>
									<th scope="row">
										<p>
											<label for="join-item1-3">비밀번호 확인<sup class="text-danger text-base md:text-lg">*</sup></label>
										</p>
									</th>
									<td><input type="password" class="form-control w-full" id="pswdConfirm" name="pswdConfirm" >
									<p class="text-sm mt-2.5">비밀번호 확인을 위해 다시 한번 입력해주세요.</p></td>
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
											<button type="button" class="btn btn-primary" onclick="f_findAdres('zip', 'addr', 'daddr'); return false;" style="padding:0 0.75rem;">우편번호 검색</button>
										</div>
										<form:input class="form-control mt-1.5 w-full md:mt-2" path="addr" maxlength="200"/>
										<form:input class="form-control mt-1.5 w-full md:mt-2" path="daddr" maxlength="200"/>
									</td>
								</tr>
							</tbody>
						</table>

						<p class="text-lg font-bold md:text-xl">수급자 정보</p>
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
									<td colspan="2">
										<div class="recipient-select py-1.5">
											<div class="form-check">
												<form:radiobutton class="form-check-input" path="recipterYn" id="recipterYn0" value="N" />
												<label class="form-check-label" for="recipterYn0">해당없음<small>(일반회원)</small></label>
											</div>
											<div class="form-check">
												<form:radiobutton class="form-check-input" path="recipterYn" id="recipterYn1" value="Y" />
												<label class="form-check-label" for="recipterYn1">장기요양등급 수급자<small>(수급자회원)</small></label>
											</div>
										</div>
									</td>
								</tr>
							</tbody>
						</table>

						<p class="mt-9 text-[1.375rem] text-center font-bold md:text-2xl" id="wrapTitle">요양정보</p>
						<table class="table-detail" id="wrapTable">
							<colgroup>
								<col class="w-29 xs:w-32">
								<col>
							</colgroup>
							<tbody>
								<tr>
									<th scope="row"><p>
											<label for="join-item2">수급자 성명</label>
										</p></th>
									<td><input type="text" class="form-control w-full" id="recipter" name="recipter" maxlength="50" value="${noMbrVO.mbrNm}"></td>
								</tr>
								<tr>
									<th scope="row"><p>
											<label for="join-item2-2">요양인정번호</label>
										</p></th>
									<td>
										<div class="form-group w-full">
											<p class="px-1.5 font-serif text-[1.375rem] font-bold md:text-2xl">L</p>
											<input type="text" class="form-control" id="rcperRcognNo" name="rcperRcognNo" maxlength="13" />
										</div>
									</td>
								</tr>
								<%-- <tr>
									<th scope="row">
										<p>
											<label for="rcognGrad">등급선택</label>
										</p>
									</th>
									<td>
										<select name="rcognGrad" id="rcognGrad" class="form-control w-full">
											<option value="">등급 선택</option>
											<option value="0">등급 외</option>
											<option value="1">1 등급</option>
											<option value="2">2 등급</option>
											<option value="3">3 등급</option>
											<option value="4">4 등급</option>
											<option value="5">5 등급</option>
											<option value="6">6 등급</option>
										</select>
									</td>
								</tr>
								<tr>
									<th scope="row">
										<p>
											<label for="selfBndRt">본인부담금율</label>
										</p>
									</th>
									<td>
										<select name="selfBndRt" id="selfBndRt" class="form-control w-full">
											<option value="">본인부담금율 선택</option>
											<option value="15, 일반대상자">일반대상자(15%)</option>
											<option value="9, 감경대상자">감경대상자(9%)</option>
											<option value="6, 감경대상자">감경대상자(6%)</option>
											<option value="6, 의료급여수급권자">의료급여수급권자(6%)</option>
											<option value="0, 기초생활수급권자">기초생활수급권자(0%)</option>
										</select>
									</td>
								</tr> --%>
							</tbody>
						</table>
						<div class="content-button mt-4" id="wrapBtn">
							<button type="button" class="btn btn-primary btn-large flex-1 f_recipterCheck">수급자 정보 조회</button>
							<button type="button" class="btn btn-outline-primary btn-large w-[26.5%]" id="cancleBtn">취소</button>
						</div>

						<div class="content-recipient mt-9.5" id="wrapInfo" style="display:none;">
							<div class="title">
								<p class="name">
									<strong id="searchNm"></strong> 님의
								</p>
								<p class="desc">장기요양 정보</p>
							</div>
							<div class="group1">
								<dl class="number">
									<dt>장기요양인정번호</dt>
									<dd id="searchNo"></dd>
								</dl>
								<dl class="grade">
									<dt>등급</dt>
									<dd id="searchGrade">	</dd>
								</dl>
							</div>
							<div class="group2">
								<dl class="percent">
									<dt>본인부담율</dt>
									<dd>
										<strong id="searchQlf"></strong> &nbsp; %
									</dd>
								</dl>
								<dl class="date">
									<dt>인정유효기간</dt>
									<dd>
										<p id="searchBgngRcgt"></p>
										<p id="searchEndRcgt"></p>
									</dd>
								</dl>
								<dl class="date">
									<dt>적용기간</dt>
									<dd>
										<p id="searchBgngApdt"></p>
										<p id="searchEndApdt"></p>
									</dd>
								</dl>
							</div>
							<dl class="price1">
								<dt>급여잔액</dt>
								<dd>
									<strong id="searchRemn"></strong> &nbsp; 원 <small id="formatKo"></small>
								</dd>
							</dl>
							<dl class="price2">
								<dt>사용금액</dt>
								<dd>
									<strong id="searchUseAmt"></strong> 원
								</dd>
							</dl>

							<div class="form-check mt-4 text-base font-bold md:text-lg">
								<input class="form-check-input" type="checkbox" id="agree-item" name="agreeItem">
								<label class="form-check-label" for="agree-item">장기요양등급 정보 사용에 동의합니다</label>
							</div>
						</div>

						<p class="text-lg font-bold md:text-xl mt-17">선택 정보</p>
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
											<label for="rcmdtnId">추천인 아이디</label>
										</p></th>
									<td><form:input class="form-control w-full" path="rcmdtnId" maxlength="13"/>
										<p class="text-sm mt-2.5">추천인에게 포인트가 제공됩니다.</p></td>
								</tr>
								<tr>
									<th scope="row"><p>
											<label for="telno">전화번호</label>
										</p></th>
									<td><form:input class="form-control w-full" path="telno" maxlength="13" oninput="autoHyphen(this);"/>
										<p class="text-sm mt-2.5">숫자만 입력해주세요</p></td>
								</tr>
								<tr>
									<th scope="row"><p style="padding-left: 0;">
											<label for="join-item3-3">개인정보 유효기간</label>
										</p></th>
									<td>
										<div class="form-check-group w-full">
											<c:forEach var="expr" items="${expirationCode}" varStatus="status">
												<div class="form-check">
													<form:radiobutton class="form-check-input" path="prvcVldPd" id="prvcVldPd${status.index}" value="${expr.key}"/>
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
												<input class="form-check-input" type="checkbox" id="allChk">
												<label class="form-check-label" for="allChk">전체 수신</label>
											</div>
										</div>
										<div class="mt-1.5 flex flex-wrap md:mt-2">
											<div class="form-check mr-3 xs:mr-auto">
												<form:checkbox class="form-check-input" path="smsRcptnYn" value="Y"/>
												<label class="form-check-label" for="smsRcptnYn">SMS</label>
											</div>
											<div class="form-check mr-3 xs:mr-auto">
												<form:checkbox class="form-check-input" path="emlRcptnYn" value="Y"/>
												<label class="form-check-label" for="emlRcptnYn">이메일</label>
											</div>
											<div class="form-check mr-3 xs:mr-auto">
												<form:checkbox class="form-check-input" path="telRecptnYn" value="Y"/>
												<label class="form-check-label" for="telRecptnYn">전화</label>
											</div>
										</div>
									</td>
								</tr>
								<tr>
									<th scope="row"><p>
											<label for="join-item3-5">사진 등록</label>
										</p></th>
									<td>
										<div class="relative mb-4 aspect-square overflow-hidden rounded-md" style="display:none;">
											<input type="file" class="absolute top-0 left-0 w-full h-full opacity-0">
											<img src="" alt="" class="w-full h-full object-cover" id="profImg">
										</div>

										<div class="form-upload">
											<label for="uploadFile" class="form-upload-trigger">
												파일을 선택해주세요.
											</label>
											<input type="file" class="form-upload-control" id="uploadFile" name="uploadFile" onchange="fileCheck(this);" multiple>
										</div>
										<!--
										<div class="flex">
											<div class="flex-none mr-2 w-35 h-35 overflow-hidden rounded-md">
												<img src="/html/page/market/assets/images/dummy/img-dummy-partners.png" alt="" class="w-full h-full object-cover">
											</div>
											<div class="form-upload flex-1 w-[calc(100%_-_9.25rem)]">
												<label for="join-item3-5" class="form-upload-trigger">파일을 선택하거나<br> 사진을 드래그 해서 등록하세요
												</label> <input type="file" class="form-upload-control" id="join-item3-5" name="upload[]" multiple>
											</div>
										</div> -->
									</td>
								</tr>
							</tbody>
						</table>

						<div class="content-button mt-25">
							<button type="submit" class="btn btn-primary btn-large flex-1">정보 입력 완료</button>
							<a href="${_marketPath }/index" class="btn btn-outline-primary btn-large w-[37.5%]">취소</a>
						</div>
					</form:form>
					<div class="member-join-sidebar is-right is-down is-step2 is-process">
						<p class="text">
							<span>STEP 3</span>
						</p>
					</div>
				</div>
			</div>
		</div>
	</div>
</main>

<script>

function viewKorean(num) {
    var hanA = new Array("","일","이","삼","사","오","육","칠","팔","구","십");
    var danA = new Array("","십","백","천","","십","백","천","","십","백","천","","십","백","천");
    var result = "";
    for(i=0; i<num.length; i++) {
        str = "";
        han = hanA[num.charAt(num.length-(i+1))];
        if(han != "") str += han+danA[i];
        if(i == 4) str += "만";
        if(i == 8) str += "억";
        if(i == 12) str += "조";
        result = str + result;
    }
    if(num != 0)
        result = result + "원";
    return result ;
}


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


//주소검색 DAUM API
/*
function f_findAdres(zip, addr, daddr) {
	$.ajaxSetup({ cache: true });
	$.getScript( "//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js", function() {
		$.ajaxSetup({ cache: false });
		new daum.Postcode({
			oncomplete: function(data) {
				$("#"+zip).val(data.zonecode); // 우편번호
				$("#"+addr).val(data.roadAddress); // 도로명 주소 변수
				$("#"+daddr).focus(); //포커스
	        }
	    }).open();
	});
}
*/

$(function(){

	const idchk = /^[a-zA-Z][A-Za-z0-9]{5,14}$/;
	const pswdChk = /^.*(?=.*\d)(?=.*[a-zA-Z])(?=.*[!@#$%^&+=]).*$/;
	const emailchk = /^[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*.[a-zA-Z]{2,3}$/i;
	const telchk = /^([0-9]{2,3})?-([0-9]{3,4})?-([0-9]{3,4})$/;
	const rcperChk = /^([0-9]{1}-[0-9]{5}-[0-9]{5})$/;

	//요양정보 wrap
	$("#wrapTitle, #wrapTable, #wrapBtn, #wrapInfo").wrapAll('<div class="wrappingInfo" style="display:none;"></div>');

	//수급자 회원 선택
	$("input[name='recipterYn']").on("click",function(){
		$(this).val() == "Y" ? $(".wrappingInfo").css("display","") : $(".wrappingInfo").css("display","none");
	});

	//체크 박스 값
	$("#smsRcptnYn1,#emlRcptnYn1,#telRecptnYn1").on("click",function(){
		!$(this).is(":checked") ? $(this).val("N") : $(this).val("Y");
	})

	//전체 수신
	$("#allChk").on("click",function(){
		$("#allChk").is(":checked") ? $("#smsRcptnYn1,#emlRcptnYn1,#telRecptnYn1").prop("checked",true) : $("#smsRcptnYn1,#emlRcptnYn1,#telRecptnYn1").prop("checked",false)
	});

	//첨부파일 이미지 변경
	$("#uploadFile").change(function(){
    	setImageFromFile(this, "#profImg");
    	$("#profImg").parent("div .rounded-md").css("display","");
	});

	// 수급자 정보 취소 버튼
	$("#cancleBtn").on("click",function(){
		$("#recipterYn0").prop("checked",true);
		$(".wrappingInfo").hide();
		$("#recipter").val('');
		$("#rcperRcognNo").val('');
		$("#searchNm").text('');
		$("#searchNo").text('');
		$("#searchGrade").text('');
		$("#searchQlf").text('');
		$("#searchBgngRcgt").text('');
		$("#searchEndRcgt").text('');
		$("#searchBgngApdt").text('');
		$("#searchEndApdt").text('');
		$("#searchRemn").text('');
		$("#formatKo").text('');

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
			if($('.wrappingInfo').is(':visible')){
				return true;
			}else{
				return false;
			}
		}else{
			return true;
		}
	}, );

	// 수급자정보 조회
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
				console.log(json.result);
				console.log(json.infoMap);

				$("#wrapInfo").show()

				//TO DO 등급
				$("#searchNm").text($("#recipter").val())
				$("#searchNo").text("L"+$("#rcperRcognNo").val())

				let penPayRate = json.infoMap.REDUCE_NM == '일반' ? '15': json.infoMap.REDUCE_NM == '기초' ? '0' : json.infoMap.REDUCE_NM == '의료급여' ? '6': (json.infoMap.SBA_CD.split('(')[1].substr(0, json.infoMap.SBA_CD.split('(')[1].length-1).replaceAll("%",""));
				$("#searchQlf").text(penPayRate);


				$("#searchGrade").html('<img src="/html/page/members/assets/images/txt-grade-num'+json.infoMap.LTC_RCGT_GRADE_CD+'.png">');
				$("#searchBgngRcgt").text((json.infoMap.RCGT_EDA_DT).split('~')[0].replaceAll(' ',''))
				$("#searchEndRcgt").text("~ " + (json.infoMap.RCGT_EDA_DT).split('~')[1].replaceAll(' ',''))
				$("#searchBgngApdt").text(f_hiponFormat(json.infoMap.APDT_FR_DT))
				$("#searchEndApdt").text("~ " + f_hiponFormat(json.infoMap.APDT_TO_DT))
				$("#searchRemn").text(comma(json.infoMap.REMN_AMT))
				$("#formatKo").text(viewKorean(json.infoMap.REMN_AMT))
				$("#searchUseAmt").text(comma(json.infoMap.USE_AMT))

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

	/*$.validator.addMethod("gradChk", function(value, element) {
		if($("#recipterYn1").is(":checked")){
			if($("#rcognGrad").val() == ''){
				return false;
			}else{
				return true;
			}
		}else{
			return true;
		}
	}, "! 요양 등급은 필수 선택 항목입니다.");

	$.validator.addMethod("selfChk", function(value, element) {
		if($("#recipterYn1").is(":checked")){
			if($("#selfBndRt").val() == ''){
				return false;
			}else{
				return true;
			}
		}else{
			return true;
		}
	}, "! 본인부담금율은 필수 선택 항목입니다.");*/

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