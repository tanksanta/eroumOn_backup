<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<main id="container">
	<h2 class="text-title">
		이로움ON 멤버스 등록 신청 <small>이로움ON과 함께 할 멤버스를 기다리고 있습니다.</small>
	</h2>

	<ul class="tabs-list">
		<li><a href="./registStep1">약관동의</a></li>
		<li><a href="./registStep2" class="active">정보입력</a></li>
		<li><a href="./registStep3">신청완료</a></li>
	</ul>

	<form:form class="form-container" id="registFrm" name="registFrm" method="post" modelAttribute="bplcVO" action="./registAction" enctype="multipart/form-data">
	<form:hidden path="crud" />
	<form:hidden path="uniqueId" />

		<fieldset>
			<legend>
				기본정보 <small>* 표시된 항목은 필수 입력 사항입니다.</small>
			</legend>
			<div class="form-rows">
				<label for="bplcId" class="form-label">아이디 <i>*</i></label>
				<div class="form-group">
					<c:if test="${bplcVO.crud eq 'CREATE' }">
						<form:input class="form-control" path="bplcId" placeholder="아이디를 입력하세요." maxlength="15"  />
						<button type="button" class="btn-primary" id="bplcIdChk" data-id-chk="off">중복체크</button>
					</c:if>
					<c:if test="${bplcVO.crud eq 'UPDATE' }">
						<p class="text-lg mt-0.5 font-bold">${bplcVO.bplcId}</p>
					</c:if>
				</div>
				<p class="form-desc" id="errorStr">※ 영문으로 띄어쓰기 없이 6 ~ 15자 영문, 숫자를 조합</p>
			</div>
			<div class="form-rows">
				<label for="bplcPswd" class="form-label">비밀번호 <i>*</i></label>
				<form:input type="password" class="form-control" path="bplcPswd" placeholder="비밀번호를 입력하세요."  maxlength="15" />
				<p class="form-desc">※ 영문 8 ~ 15자</p>
				<p class="form-desc">※ 특수문자 !, @, #, $, %, ^, &, * 가능</p>
			</div>
			<div class="form-rows">
				<label for="bplcPswdConfirm" class="form-label ">비밀번호 확인 <i>*</i></label>
				<input type="password" class="form-control" id="bplcPswdConfirm" name="bplcPswdConfirm" placeholder="비밀번호를 다시 입력하세요." maxlength="15">
			</div>
			<div class="form-rows">
				<label for="bplcNm" class="form-label">기업명 <i>*</i></label></br>
				<p class="text-lg mt-0.5 font-bold">${bplcNm}</p>
				<form:hidden path="bplcNm" value="${bplcNm}" />
			</div>
			<div class="form-rows">
				<label for="telno" class="form-label">전화번호 <i>*</i></label>
				<form:input class="form-control" path="telno" placeholder="-을 포함해주세요" maxlength="15" />
			</div>
			<div class="form-rows">
				<label for="fxno" class="form-label">팩스번호</label>
				<form:input class="form-control" path="fxno" placeholder="-을 포함해주세요" maxlength="15" />
			</div>
			<div class="form-rows">
				<label for="profImgFile" class="form-label">대표 이미지 <i>*</i></label>
				<div class="form-group form-upload mt-1.5 xs:mt-2">
					<input type="text" class="form-control" readonly> <label class="btn-primary">
					<input type="file" id="profImgFile" name="profImgFile" onchange="f_fileCheck(this);" class="form-control w-full" accept="image/*" /> 찾아보기</label>
				</div>
			</div>
		</fieldset>
		<fieldset class="mt-20 md:mt-24">
			<legend>
				업체정보 <small>* 표시된 항목은 필수 입력 사항입니다.</small>
			</legend>
			<div class="form-rows">
				<label for="form-item1" class="form-label bplcId">멤버스 URL <i>*</i></label>
				<p class="mb-2">https://www.eroum.com/members/</p>
					<div class="form-group">
						<form:input class="form-control" path="bplcUrl" placeholder="URL을 입력하세요." maxlength="50" />
						<button type="button" class="btn-primary" id="bplcUrlChk" data-id-chk="off">중복체크</button>
					</div>
			</div>
			<div class="form-rows">
				<label for="brno" class="form-label">사업자 번호 <i>*</i></label>
				<p class="text-lg mt-0.5 font-bold">${brno}</p>
				<form:hidden path="brno" value="${brno}" />
			</div>
			<div class="form-rows">
				<label for="rcperInstNo" class="form-label">장기요양기관번호 <i>*</i></label>
				<c:if test="${bplcVO.crud eq 'UPDATE'}"><p class="text-lg mt-0.5 font-bold">${bplcVO.rcperInstNo}</p></c:if>
				<c:if test="${bplcVO.crud eq 'CREATE'}"><form:input class="form-control" path="rcperInstNo" placeholder="장기요양기관번호를 입력하세요." maxlength="13"/></c:if>
			</div>
			<div class="form-rows">
				<label for="rprsvNm" class="form-label">대표자명 <i>*</i></label>
				<div class="form-group">
					<c:if test="${bplcVO.crud eq 'UPDATE'}"><p class="text-lg mt-0.5 font-bold">${bplcVO.rprsvNm}</p></c:if>
					<c:if test="${bplcVO.crud eq 'CREATE'}"><form:input class="form-control" path="rprsvNm" placeholder="대표자명을 입력하세요." maxlength="50"/></c:if>
				</div>
			</div>
			<div class="form-rows">
				<label for="bizcnd" class="form-label">업태 <i>*</i></label>
				<c:if test="${bplcVO.crud eq 'UPDATE'}"><p class="text-lg mt-0.5 font-bold">${bplcVO.bizcnd}</p></c:if>
				<c:if test="${bplcVO.crud eq 'CREATE'}"><form:input class="form-control" path="bizcnd" placeholder="업태를 입력하세요." maxlength="50"/></c:if>
			</div>
			<div class="form-rows">
				<label for="iem" class="form-label">종목 <i>*</i></label>
				<c:if test="${bplcVO.crud eq 'UPDATE'}"><p class="text-lg mt-0.5 font-bold">${bplcVO.bizcnd}</p></c:if>
				<c:if test="${bplcVO.crud eq 'CREATE'}"><form:input class="form-control" path="iem" placeholder="종목을 입력하세요." maxlength="50"/></c:if>
			</div>
			<div class="form-rows">
				<label for="form-item2-6" class="form-label">사업장 주소 <i>*</i></label>
				<div class="form-group">
					<form:input path="zip" class="form-control" placeholder="우편번호를 입력하세요." maxlength="5"/>
					<button type="button" class="btn-primary" onclick="f_findAdres('zip', 'addr', 'daddr', 'lat', 'lot'); return false;">우편번호 검색</button>
				</div>
				<form:input path="addr" class="form-control mt-2 xs:mt-2.5" maxlength="50"/>
				<form:input path="daddr" class="form-control mt-2 xs:mt-2.5" placeholder="상세주소를 입력하세요." maxlength="50"/>
				<form:hidden path="lat" />
				<form:hidden path="lot" />

			</div>
			<div class="form-rows">
				<label for="form-item2-7" class="form-label">배송지 주소 <i>*</i></label>
				<div class="mt-3 xs:mt-3.5">
					<div class="form-check mr-4 xs:mr-5">
						<input class="form-check-input" name="BplcZip" type="radio" id="copyBplcZip">
						<label class="form-check-label" for="copyBplcZip">사업장 주소와 동일</label>
					</div>
					<div class="form-check">
						<input class="form-check-input" name="BplcZip" type="radio" id="newBplcZip">
						<label class="form-check-label" for="newBplcZip">신규 배송지</label>
					</div>
				</div>
				<div class="form-group mt-2 xs:mt-2.5">
					<form:input class="form-control" placeholder="우편번호를 입력하세요." path="dlvyZip" maxlength="5"/>
					<button type="button" class="btn-primary" onclick="f_findAdress('dlvyZip', 'dlvyAddr', 'dlvyDaddr'); return false;">우편번호 검색</button>
				</div>
				<form:input class="form-control mt-2 xs:mt-2.5" maxlength="50" path="dlvyAddr" />
				<form:input path="dlvyDaddr" class="form-control mt-2 xs:mt-2.5" placeholder="상세주소를 입력하세요." maxlength="50"/>
			</div>
			<div class="form-rows">
				<label for="taxbilEml" class="form-label">세금계산서 수신용 메일 <i>*</i></label>
				<form:input class="form-control mt-2 xs:mt-2.5" path="taxbilEml" placeholder="이메일을 입력하세요." maxlength="50"/>
			</div>
			<div class="form-rows">
				<label for="bizrFile" class="form-label">사업자등록증 <i>*</i></label>
				<div class="form-group form-upload mt-1.5 xs:mt-2">
						<input type="text" class="form-control" readonly> <label class="btn-primary">
						<input type="file" id="bizrFile" name="bizrFile" class="form-control w-full" accept="image/*" /> 찾아보기</label>
				</div>
			</div>
			<div class="form-rows">
				<label for="offcsFile" class="form-label">사업자직인 (계약서 날인) <i>*</i></label>
				<div class="form-group form-upload mt-1.5 xs:mt-2">
					<input type="text" class="form-control" readonly> <label class="btn-primary">
					<input type="file" id="offcsFile" name="offcsFile" onchange="f_fileCheck(this);" class="form-control w-full" accept="image/*" /> 찾아보기</label>
				</div>
			</div>
		</fieldset>

		<!-- 담당자 정보 -->
		<fieldset class="mt-20 md:mt-24">
			<legend>
				담당자 정보 <small>* 표시된 항목은 필수 입력 사항입니다.</small>
			</legend>
			<div class="form-rows">
				<label for="picNm" class="form-label">담당자명 <i>*</i></label>
				<form:input class="form-control" placeholder="담당자명을 입력하세요." path="picNm" maxlength="50"/>
			</div>
			<div class="form-rows">
				<label for="picTelno" class="form-label">담당자 연락처 <i>*</i></label>
				<form:input class="form-control" placeholder="-을 포함해주세요" path="picTelno" maxlength="15"/>
			</div>
			<div class="form-rows">
				<label for="picEml" class="form-label">담당자 이메일 <i>*</i></label>
				<form:input class="form-control" path="picEml" placeholder="이메일을 입력하세요." maxlength="50"/>
			</div>
		</fieldset>

		<!-- 정산 정보-->
		<fieldset class="mt-20 md:mt-24">
			<legend>
				정산 정보 <small>* 표시된 항목은 필수 입력 사항입니다.</small>
			</legend>
			<div class="form-rows">
				<label for="picNm" class="form-label">은행 <i>*</i></label>
				<form:select path="clclnBank" class="form-control" >
					<c:forEach var="bankTy" items="${bankTy}">
						<form:option value="${bankTy.key}">${bankTy.value}</form:option>
					</c:forEach>
				</form:select>
			</div>
			<div class="form-rows">
				<label for="clclnActno" class="form-label">계좌번호 <i>*</i></label>
				<form:input class="form-control" placeholder="-을 포함해주세요" path="clclnActno" maxlength="30"/>
			</div>
			<div class="form-rows">
				<label for="clclnDpstr" class="form-label">예금주명 <i>*</i></label>
				<form:input class="form-control" path="clclnDpstr" maxlength="50"/>
			</div>
		</fieldset>

		<div class="btn-group">
			<a href="./introduce" class="btn-cancel large shadow">취소</a>
			<button type="submit" class="btn-partner large shadow">등록신청</button>
		</div>
	</form:form>
</main>

<script>

//사업장주소검색 DAUM API
function f_findAdres(zip, addr, daddr ,lat ,lot) {
	$.ajaxSetup({ cache: true });
	$.getScript( "//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js", function() {
		$.ajaxSetup({ cache: false });
		new daum.Postcode({
			oncomplete: function(data) {
			$("#"+zip).val(data.zonecode); // 우편번호
			$("#"+addr).val(data.roadAddress); // 도로명 주소 변수
			$("#"+daddr).focus(); //포커스

			if($("#zip-error").length > 0){
				$("#zip-error").remove();
				$("#zip").addClass("is-valid");
				$("#zip").removeClass("is-invalid");
			}
			if($("#addr-error").length > 0){
				$("#addr-error").remove();
				$("#addr").addClass("is-valid");
				$("#addr").removeClass("is-invalid");
			}

			if(lat != undefined && lot != undefined){
				f_findGeocode(data, lat, lot); //좌표
			}

	        }
	    }).open();
	});
}

//좌표검색 DAUM API : (주소, lat, lot)
function f_findGeocode(data, lat, lot) {
	const address = data.address;
	$.getScript('//dapi.kakao.com/v2/maps/sdk.js?appkey=84e3b82c817022c5d060e45c97dbb61f&autoload=false&libraries=services', function() {
		daum.maps.load(function() {
			const geocoder = new daum.maps.services.Geocoder();
			geocoder.addressSearch(address, function(result, status) {
				if(status === daum.maps.services.Status.OK){
 					console.log({ lat: result[0].y, lot: result[0].x })
	               	$("#"+lat).val(result[0].y);
	               	$("#"+lot).val(result[0].x);
				}
			});
		});
	});
}

//배송지주소검색 DAUM API
function f_findAdress(dlvyZip, dlvyAddr, dlvyDaddr) {
	$.ajaxSetup({ cache: true });
	$.getScript( "//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js", function() {
		$.ajaxSetup({ cache: false });
		new daum.Postcode({
			oncomplete: function(data) {
			$("#"+dlvyZip).val(data.zonecode); // 우편번호
			$("#"+dlvyAddr).val(data.roadAddress); //도로명 주소 변수
			$("#"+dlvyDaddr).focus(); //포커스
			if($("#dlvyZip-error").length > 0){
				$("#dlvyZip-error").remove();
				$("#dlvyZip").addClass("is-valid");
				$("#dlvyZip").removeClass("is-invalid");
			}
			if($("#dlvyAddr-error").length > 0){
				$("#dlvyAddr-error").remove();
				$("#dlvyAddr").addClass("is-valid");
				$("#dlvyAddr").removeClass("is-invalid");
			}
	        }
	    }).open();
	});
}

$(function(){
	var idchk = /^[a-zA-Z][A-Za-z0-9]{5,14}$/;
	var urlchk = /^[a-zA-Z0-9]*$/;
	var passwordChk = /^.*(?=.*\d)(?=.*[a-zA-Z])(?=.*[!@#$%^&+=]).*$/;
	var emailchk = /^[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*.[a-zA-Z]{2,3}$/i;
	var phonechk = /^01([0|1|6|7|8|9])-?([0-9]{3,4})-?([0-9]{4})$/;
	var telchk = /^([0-9]{2,3})?-([0-9]{3,4})?-([0-9]{3,4})$/;
	var brnoChk = /^([0-9]{3}-[0-9]{2}-[0-9]{5})$/;
	var rcperChk = /^([0-9]{1}-[0-9]{5}-[0-9]{5})$/;
	var acctChk = /^([0-9,\-]{3,6})?-([0-9,\-]{2,6})?-([0-9]{2,6})([0-9,\-]{0,6})$/;

	//아이디 중복 체크
	$("#bplcIdChk").on("click",function(){
		if($("#bplcId").val() == null){
			alert("아이디를 먼저 입력해주세요.");
			return false;
		}else{
			if(idchk.test($("#bplcId").val())){
				$.ajax({
					type : "post",
					url  : "/members/bplcIdChk", //사업장, 회원 아이디 조회
					data : {
						uniqueId : $("#uniqueId").val()
						, bplcId : $("#bplcId").val()
						, crud : $("#crud").val()
						},
					dataType : 'json'
				})
				.done(function(data) {
					if(data == true){
						alert("사용 가능한 아이디입니다.");
						$("#errorStr").remove();
						$("#bplcId-error").remove();
						$("#bplcId").addClass("is-valid");
						$("#bplcId").removeClass("is-invalid");
						//확정 체크
						if(confirm("사용 하시겠습니까?")){
							//url 유무
							if($("#bplcUrl").val() == ''){
								$("#bplcUrl").val($("#bplcId").val());
							}
							$("#bplcIdChk").data("idChk",'on');
							$("#bplcId").attr("readonly",true);
							$("#bplcIdChk").attr("disabled",true);
						}else{
							return false;
						}
					}else{
						alert("사용할 수 없는 아이디입니다.");
						$("#bplcIdChk").data("idChk",'off');
						$("#bplcId").addClass("is-invalid");
						$("#bplcId").removeClass("is-valid");
					}
				})
				.fail(function(data, status, err) {
					console.log(status + ' : 아이디 중복 체크 중 오류가 발생했습니다.');
				});
			}else{
				$("#errorStr").attr("class","form-desc error");
			}

		}
	});

	//배송지 주소 > 주소 동일
	$("#copyBplcZip").on("click",function(){
		if($("#copyBplcZip").is(":checked")){
			var zip = $("#zip").val();
			var addr = $("#addr").val();
			var daddr = $("#daddr").val();
			$("#dlvyZip").val(zip);
			$("#dlvyAddr").val(addr);
			$("#dlvyDaddr").val(daddr);
			if($("#dlvyZip-error").length > 0){
				$("#dlvyZip-error").remove();
				$("#dlvyZip").addClass("is-valid");
				$("#dlvyZip").removeClass("is-invalid");
			}
			if($("#dlvyAddr-error").length > 0){
				$("#dlvyAddr-error").remove();
				$("#dlvyAddr").addClass("is-valid");
				$("#dlvyAddr").removeClass("is-invalid");
			}
			if($("#dlvyDaddr-error").length > 0){
				$("#dlvyDaddr-error").remove();
				$("#dlvyDaddr").addClass("is-valid");
				$("#dlvyDaddr").removeClass("is-invalid");
			}
		}
	});
	//배송지 주소 > 신규
	$("#newBplcZip").on("click",function(){
		$("#dlvyZip").val("");
		$("#dlvyAddr").val("");
		$("#dlvyDaddr").val("");
	});

	//사업장 URL 중복 체크
	$("#bplcUrlChk").on("click",function(){
		if($("#bplcUrl").val() == null){
			alert("URL을 입력해주세요.");
		}else{
			if(!idchk.test($("#bplcUrl").val())){
				alert("사용할 수 없는 URL입니다.");
			}else{
				$.ajax({
					type : "post",
					url  : "/members/bplcUrlChk", //사업장 url 조회
					data : {
						bplcUrl : $("#bplcUrl").val()
						, crud : $("#crud").val()
						, uniqueId : $("#uniqueId").val()
					},
					dataType : 'json'
				})
				.done(function(data) {
					if(data == true){
						alert("사용 가능한 URL입니다.");
						$("#bplcUrl-error").remove();
						$("#bplcUrl").addClass("is-valid");
						$("#bplcUrl").removeClass("is-invalid");
						//확정 체크
						if(confirm("사용 하시겠습니까?")){
							$("#bplcUrlChk").data("idChk",'on');
							$("#bplcUrl").attr("readonly",true);
							$("#bplcUrlChk").attr("disabled",true);
						}else{
							return false;
						}
					}else{
						alert("이미 사용중인 URL입니다.");
					}
				})
				.fail(function(data, status, err) {
					console.log(status + ' : URL 중복 체크 중 오류가 발생했습니다.');
				});
			}
		}
	});

	//비밀번호 형식 체크
	$.validator.addMethod("passwordCk",  function( value, element ) {
		return this.optional(element) ||  /^.*(?=.*\d)(?=.*[a-zA-Z])(?=.*[!@#$%^&+=]).*$/.test(value);
	});


	//아이디 중복체크 확인
	$.validator.addMethod("idChkConfirm",  function( value, element ) {
		if($("#bplcIdChk").data("idChk") == "off"){
			return false;
		}else{
			return true;
		}
	}, "! 아이디 사용확인을 해주세요");

	//url 중복 체크 검사
	$.validator.addMethod("urlChkConfirm",  function( value, element ) {
		if($("#bplcUrlChk").data("idChk") == "off"){
			return false;
		}else{
			return true;
		}
	}, "! URL 사용확인을 해주세요");

	//아이디, 비밀번호 확인
	$.validator.addMethod("sameChk",  function( value, element ) {
		var id = $("#bplcId").val();
		var pw = $("#bplcPswd").val();
		if(id == pw){
			return false;
		}else{
			return true;
		}
	}, "! 아이디와 동일한 비밀번호는 사용할 수 없습니다.");

	//첨부파일
	$("#profImgFile,#bizrFile,#offcsFile").on("change",function(){
		if($("#profImgFile").val() != ''){
			$("#profImgFile-error").remove();
		}
		if($("#bizrFile").val() != ''){
			$("#bizrFile-error").remove();
		}
		if($("#offcsFile").val() != ''){
			$("#offcsFile-error").remove();
		}
	});

	//유효성 검사
  $("form#registFrm").validate({
		ignore: "input[type='text']:hidden",
		rules: {
			bplcId : {required : true, idChkConfirm : true, minlength : 6},
			bplcPswd : {required : true,  passwordCk : true, minlength : 8, sameChk : true, },
			bplcPswdConfirm : {required : true , passwordCk : true, equalTo : "#bplcPswd", minlength : 8},
			bplcNm : {required : true, maxlength : 50},
			telno : {regex : telchk, required : true},
			fxno : {regex : telchk},
			bplcUrl : {required : true, regex:urlchk, urlChkConfirm : true},
			brno : {required : true , regex : brnoChk},
			rcperInstNo : {required : true, regex : rcperChk}, //숫자 확인
			rprsvNm : {required : true},
			bizcnd : {required : true},
			iem : {required : true},
			zip : {required : true, min : 5},
			addr : {required : true},
			daddr : {required : true},
			dlvyZip : {required : true, min : 5},
			dlvyAddr : {required : true},
			dlvyDaddr : {required : true},
			taxbilEml : {required : true , regex : emailchk},
			profImgFile : {required : true},
			bizrFile : {required : true},
			offcsFile : {required : true},
			picNm : {required : true},
			picTelno : {required : true, regex : telchk},
			picEml : {required : true, regex : emailchk},
			clclnBank : {required : true},
			clclnActno : {required : true, regex : acctChk},
			clclnDpstr : {required : true}
		},
		messages : {
			bplcId : {required : "! 아이디는 필수 입력 항목입니다.", minlength : "! 아이디는 6자 이상 입력해주세요."},
			bplcPswd : {required : "! 비밀번호는 필수 입력 항목입니다.", passwordCk : "! 비밀번호는 영문자, 숫자, 특수문자 조합을 입력해야 합니다." , minlength : "! 비밀번호는 8자 이상 입력해주세요", notEqual : "! 아이디와 같은 비밀번호는 사용할 수 없습니다."},
			bplcPswdConfirm : {required : "! 비밀번호 확인은 필수 입력 항목입니다.", passwordCk : "! 비밀번호는 영문자, 숫자, 특수문자 조합을 입력해야 합니다.", minlength : "! 비밀번호는 8자 이상 입력해주세요", equalTo : "! 같은 비밀번호를 입력해주세요."},
			bplcNm : {required : "! 기업명은 필수 입력 항목입니다."},
			telno : {required : "! 전화번호는 필수 입력 항목입니다." ,regex : "! 전화번호 형식이 잘못되었습니다.\n(000-0000-0000)"},
			fxno : {regex : "! 숫자와 하이폰으로 입력해주세요."},
			bplcUrl : {required : "! 사업장 URL은 필수 입력 항목입니다.", regex : "! 영문자, 숫자를 입력해야 합니다."}, //url 체크 확인
			brno : {required : "! 사업자 번호는 필수 입력 항목입니다."},
			rcperInstNo : {required : "! 기관번호는 필수 입력 항목입니다.", regex : "! 형식이 올바르지 않습니다. \n(0-00000-00000)"},
			rprsvNm : {required : "! 대표자명은 필수 입력 항목입니다."},
			bizcnd : {required : "! 업태는 필수 입력 항목입니다."},
			iem : {required : "! 종목은 필수 입력 항목입니다."},
			zip : {required : "! 우편번호는 필수 입력 항목입니다.", min : "! 우편번호는 최소 5자리입니다."},
			addr : {required : "! 주소는 필수 입력 항목입니다."},
			daddr : {required : "! 상세 주소는 필수 입력 항목입니다."},
			dlvyZip : {required : "! 우편번호는 필수 입력 항목입니다.", min : "! 우편번호는 최소 5자리입니다."},
			dlvyAddr : {required : "! 주소는 필수 입력 항목입니다."},
			dlvyDaddr : {required : "! 상세 주소는 필수 입력 항목입니다."},
			taxbilEml : {required : "! 수신용 이메일은 필수 입력 항목입니다.", regex : "! 이메일 형식이 잘못되었습니다.\n(abc@def.com)"},
			profImgFile : {required : "! 대표 이미지는 필수 선택 항목입니다."},
			bizrFile : {required : "! 사업자등록증은 필수 선택 항목입니다."},
			offcsFile : {required : "! 사업자직인은 필수 선택 항목입니다."},
			picNm : {required : "! 담당자명은 필수 입력 항목입니다."},
			picTelno : {required : "! 담당자 연락처는 필수 입력 항목입니다.", regex : "! 전화번호 형식이 잘못되었습니다.\n(000-0000-0000)"},
			picEml : {required : "! 담당자 이메일은 필수 입력 항목입니다.", regex : "! 이메일 형식이 잘못되었습니다.\n(abc@def.com)"},
			clclnBank : {required : "! 은행은 필수 입력 항목입니다."},
			clclnActno : {required : "! 계좌번호는 필수 입력 항목입니다.", regex : "! 숫자와 하이폰만 가능합니다."},
			clclnDpstr : {required : "! 예금주명은 필수 입력 항목입니다."}
		},
	    submitHandler: function (frm) {
	    	if(confirm("이로움ON 마켓 멤버스 등록신청 하시겠습니까?")){
	    		frm.submit();
	    	} else{
	    		return false;
	    	}
	    }

	});

});
</script>