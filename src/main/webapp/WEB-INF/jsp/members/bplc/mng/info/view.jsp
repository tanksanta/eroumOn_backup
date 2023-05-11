<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<jsp:include page="../layout/page_header.jsp">
	<jsp:param value="정보변경" name="pageTitle" />
</jsp:include>
<div id="page-content">
	<form:form action="./action" id="infoFrm" name="infoFrm" modelAttribute="bplcVO" method="post" enctype="multipart/form-data">
	<form:hidden path="crud" value="UPDATE" />
	<form:hidden path="uniqueId"/>
	<form:hidden path="useYn" />
	<form:hidden path="rcmdtnYn"  />
	<form:hidden path="parkngYn"  />
	<form:hidden path="hldyEtc"  />
		<fieldset>
			<legend class="text-title2">기본 정보</legend>
			<table class="table-detail">
				<colgroup>
					<col class="w-43">
					<col>
				</colgroup>
				<tbody>
					<tr>
						<th scope="row">아이디</th>
						<td>${bplcVO.bplcId}</td>
					</tr>
					<tr>
						<th scope="row">멤버스 URL</th>
						<td>https://www.eroum.co.kr/members/<strong class="text-success">${bplcVO.bplcUrl}</strong></td>
					</tr>
					<tr>
						<th scope="row">기업명</th>
						<td>${bplcVO.bplcNm}</td>
					</tr>
					<tr>
						<th scope="row"><label for="telno" class="require">전화번호</label></th>
						<td>
							<div class="form-group w-75">
								<form:input class="form-control flex-1" path="telno" maxlength="13" oninput="autoHyphen(this);"/>
							</div>
						</td>
					</tr>
					<tr>
						<th scope="row"><label for="form-item1-2">팩스번호</label></th>
						<td>
							<div class="form-group w-75">
								<form:input class="form-control flex-1" path="fxno" maxlength="20" />
							</div>
						</td>
					</tr>
				</tbody>
			</table>
		</fieldset>

		<fieldset class="mt-13">
			<legend class="text-title2">업체 정보</legend>
			<table class="table-detail">
				<colgroup>
					<col class="w-43">
					<col>
				</colgroup>
				<tbody>
					<tr>
						<th scope="row">사업자등록번호</th>
						<td>${bplcVO.brno}</td>
					</tr>
					<tr>
						<th scope="row">장기요양기관번호</th>
						<td>${bplcVO.rcperInstNo}</td>
					</tr>
					<tr>
						<th scope="row">대표자명</th>
						<td>${bplcVO.picNm}</td>
					</tr>
					<tr>
						<th scope="row">업태</th>
						<td>${bplcVO.bizcnd}</td>
					</tr>
					<tr>
						<th scope="row">종목</th>
						<td>${bplcVO.iem}</td>
					</tr>
					<tr>
						<th scope="row"><label for="zip" class="require">사업장 주소</label></th>
						<td>
							<div class="form-group">
								<input type="text" class="form-control w-46" readonly value="${bplcVO.zip}" id="zip">
								<button class="btn-primary w-30" disabled>우편번호 검색</button>
							</div>
							<div class="form-group mt-1 w-full">
								<input type="text" class="form-control w-90" readonly value="${bplcVO.addr}" id="addr"></br>
							</div> <input type="text" class="form-control flex-1" readonly value="${bplcVO.daddr}" id="daddr">
						</td>
					</tr>
					<tr>
						<th scope="row"><label for="dlvyZip" class="require">배송지 주소</label></th>
						<td>
							<div class="form-group">
								<form:input path="dlvyZip" class="form-control w-46" />
								<button type="button" class="btn-primary w-30" onclick="f_findAdres('dlvyZip', 'dlvyAddr', 'dlvyDaddr'); return false;">우편번호 검색</button>
								<div class="form-check form-switch ml-3">
									<input class="form-check-input" type="checkbox" id="copyAdrs"> <label class="form-check-label" for="form-item2-3">사업장 주소와 동일</label>
								</div>
							</div>
							<div class="form-group mt-1 w-full">
								<form:input class="form-control w-90" path="dlvyAddr" maxlength="50"/>
							</div> <form:input class="form-control w-90" path="dlvyDaddr" maxlength="50"/>
						</td>
					</tr>
					<tr>
						<th scope="row"><label for="form-item2-4" class="require">세금계산서 수신용 메일</label></th>
						<td>
							<div class="form-group">
								<form:input class="form-control w-75" path="taxbilEml" maxlength="50"/>
							</div>
						</td>
					</tr>
					<tr>
						<th scope="row"><label for="bsnmOffcs">사업자직인(계약서 날인)</th>
						<td><c:if test="${!empty bplcVO.bsnmOffcs}">
								<div class="form-group" style="display: flex;">
									<a href="/comm/OFFCS/getFile?fileName=${bplcVO.bsnmOffcs}">${bplcVO.bsnmOffcs}</a>&nbsp;&nbsp;
									<button type="button" class="btn-secondary delBsnmOffcsBtn">삭제</button>
								</div>
							</c:if>
							<div id="bsnmOffcsFileDiv">
								<div class="row" id="bsnmOffcs1FileDiv" <c:if test="${!empty bplcVO.bsnmOffcs }">style="display:none;"</c:if>>
									<div class="col-12">
										<div class="custom-file" id="uptAttach">
											<input type="file" class="form-control w-2/3" id="bsnmOffcs1" name="bsnmOffcs1" onchange="fileCheck(this);" />
										</div>
									</div>
								</div>
								<p class="text-black">* 파일은 png, jpg, jpeg, gif 만 등록가능하며 10Mbyte 이하로 등록해주세요.</p>
							</div> <form:input type="hidden" path="delBsnmOffcs" id="delBsnmOffcs" name="delBsnmOffcs" value="N" /></td>
					</tr>
				</tbody>
			</table>
		</fieldset>

		<fieldset class="mt-13">
			<legend class="text-title2">담당자 정보</legend>
			<table class="table-detail">
				<colgroup>
					<col class="w-43">
					<col>
				</colgroup>
				<tbody>
					<tr>
						<th scope="row"><label for="picNm" class="require">담당자명</label></th>
						<td><form:input class="form-control w-75" path="picNm" maxlength="50"/></td>
					</tr>
					<tr>
						<th scope="row"><label for="picTelno" class="require">담당자 연락처</label></th>
						<td>
							<div class="form-group w-75">
								<form:input class="form-control flex-1" path="picTelno" maxlength="13"/>
							</div>
						</td>
					</tr>
					<tr>
						<th scope="row"><label for="picEml" class="require">담당자 이메일</label></th>
						<td>
							<div class="form-group">
								<form:input class="form-control w-75" path="picEml" maxlength="50"/>
							</div>
						</td>
					</tr>
				</tbody>
			</table>
		</fieldset>

		<div class="btn-group center mt-10">
			<button type="submit" class="btn-save w-52 large shadow">저장</button>
		</div>
	</form:form>
</div>

<script>


//주소검색 DAUM API
function f_findAdres(dlvyZip, dlvyAddr, dlvyDaddr) {
$.ajaxSetup({ cache: true });
$.getScript( "//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js", function() {
	$.ajaxSetup({ cache: false });
	new daum.Postcode({
		oncomplete: function(data) {
			$("#"+dlvyZip).val(data.zonecode); // 우편번호
			$("#"+dlvyAddr).val(data.roadAddress); // 도로명 주소 변수
			$("#"+dlvyDaddr).focus(); //포커스
        }
    }).open();
});
}

const autoHyphen = (target) => {
	 target.value = target.value
	   .replace(/[^0-9]/g, '')
	   .replace(/^(\d{2,3})(\d{3,4})(\d{4})$/, `$1-$2-$3`);
}

	$(function() {

		//주소 복사 버튼 체크
		if($("#zip").val() == $("#dlvyZip").val() && $("#addr").val() == $("#dlvyAddr").val() && $("#daddr").val() == $("#dlvyDaddr").val()){
			$("#copyAdrs").prop("checked",true);
		}

		//주소 복사
		$("#copyAdrs").on("click",function(){
			if($("#copyAdrs").is(":checked")){
				var zip = $("#zip").val();
				var addr = $("#addr").val();
				var daddr = $("#daddr").val();

				$("#dlvyZip").val(zip);
				$("#dlvyAddr").val(addr);
				$("#dlvyDaddr").val(daddr);
			}else{
				$("#dlvyZip").val(' ');
				$("#dlvyAddr").val(' ');
				$("#dlvyDaddr").val(' ');
			}
		});

		//사업자 직인 삭제버튼
		$(".delBsnmOffcsBtn").on("click", function(){
			$("#delBsnmOffcs").val("Y");
			$(this).closest("div").slideUp(10);
			$("#bsnmOffcs1FileDiv").css("display","");
		});


	//정규식
	var telchk = /^([0-9]{2,3})?-([0-9]{3,4})?-([0-9]{3,4})$/;
	var numChk = /^[0-9]-?[0-9]/g;
	var emailchk = /^[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*.[a-zA-Z]{2,3}$/i;

	$.validator.addMethod("fxChk", function(value, element) {
		if($("#fxno").val() != ''){
	    	return numChk.test($("#fxno").val());
		}else{
			return true;
		}
	}, "숫자와 하이폰으로 입력해주세요.");

	// 첨부파일 검사 메소드
	$.validator.addMethod("filechk", function(value,element){
		if($("#crud").val() == "UPDATE"){
			if($("#bsnmOffcs1FileDiv").css("display") != 'block'){
				return true;
			}else{
				if($("#bsnmOffcs1").val() == ''){
					return false;
				}else{
					return true;
				}
			}
		}else{
			if($("#bsnmOffcs1").val() == ''){
				return false;
			}else{
				return true;
			}
		}
	}, "파일은 필수 입력 항목입니다.");

	//유효성
	$("form#infoFrm").validate({
	    ignore: "input[type='text']:hidden",
	    rules : {
	    	telno : {required : true, regex : telchk},
	    	fxno : {fxChk : true},
	    	dlvyZip : {required : true, min : 5},
	    	dlvyAddr : {required : true},
	    	dlbyDaddr : {required : true},
	    	taxbilEml : {required : true, regex : emailchk},
	    	picNm : {required : true},
	    	picTelno : {required : true, regex : telchk},
	    	picEml : {required : true, regex : emailchk}
	    },
	    messages : {
	    	telno : {required : "전화번호는 필수 입력 항목입니다.", regex : "전화번호 형식이 잘못되었습니다.\n(000-0000-0000)"},
	    	dlvyZip : {required : "우편번호는 필수 입력 항목입니다.", min : "우편번호는 최소 5자리입니다."},
	    	dlvyAddr : {required : "주소는 필수 입력 항목입니다."},
	    	dlvyDaddr : {required : "상세주소는 필수 입력 항목입니다."},
	    	taxbilEml : {required : "수신메일은 필수 입력 항목입니다.", regex : "이메일 형식이 잘못되었습니다.\n(abc@def.com)"},
	    	picNm : {required : "담당자명은 필수 입력 항목입니다."},
	    	picTelno : {required : "담당자 연락처는 필수 입력 항목입니다.", regex : "전화번호 형식이 잘못되었습니다.\n(000-0000-0000)"},
	    	picEml : {required : "담당자 이메일은 필수 입력 항목입니다.", regex : "이메일 형식이 잘못되었습니다.\n(abc@def.com)"}
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