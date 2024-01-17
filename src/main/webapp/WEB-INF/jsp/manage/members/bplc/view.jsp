<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<form:form name="frmBplc" id="frmBplc" modelAttribute="bplcVO" method="post" action="./action" enctype="multipart/form-data">
	<!-- 검색조건 -->
	<input type="hidden" name="cntPerPage" id="cntPerPage" value="${param.cntPerPage}" />
	<input type="hidden" name="curPage" id="curPage" value="${param.curPage}" />
	<input type="hidden" name="sortBy" id="sortBy" value="${param.sortBy}" />
	<input type="hidden" name="srchBgngDt" id="srchBgngDt" value="${param.srchBgngDt}" />
	<input type="hidden" name="srchEndDt" id="srchEndDt" value="${param.srchEndDt}" />
	<input type="hidden" name="srchBplcId" id="srchBplcId" value="${param.srchBplcId}" />
	<input type="hidden" name="srchBplcNm" id="srchBplcNm" value="${param.srchBplcNm }" />
	<input type="hidden" name="srchRprsvNm" id="srchRprsvNm" value="${param.srchRprsvNm }" />
	<input type="hidden" name="srchBrno" id="srchBrno" value="${param.srchBrno }" />
	<input type="hidden" name="srchDspyYn" id="srchDspyYn" value="${param.srchDspyYn }" />
	<input type="hidden" name="srchUseYn" id="srchUseYn" value="${param.srchUseYn }" />
	<input type="hidden" name="hldyEtc" id="hldyEtc" value="${bplcVO.hldyEtc}" />

	<form:hidden path="crud" value="UPDATE" />
	<form:hidden path="uniqueId" value="${bplcVO.uniqueId}" />

	<fieldset>
		<legend class="text-title2 relative">기본정보</legend>
		<table class="table-detail bplc">
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
					<th scope="row"><label for="bplcNm" class="require">기업 명</label></th>
					<td><form:input path="bplcNm" class="form-control w-90" maxlength="100" value="${bplcVO.bplcNm}" /></td>
				</tr>
				<tr>
					<th scope="row"><label for="telno" class="require">전화번호</label></th>
					<td><form:input path="telno" class="form-control w-90" maxlength="15" value="${bplcVO.telno}" /></td>
				</tr>
				<tr>
					<th scope="row"><label for="fxno">팩스번호</label></th>
					<td><form:input path="fxno" class="form-control w-90" maxlength="21" value="${bplcVO.fxno}" /></td>
				</tr>
				<tr>
					<th>대표 이미지</th>
					<td>
						<c:if test="${!empty bplcVO.proflImg}">
							<div class="form-group" style="display: flex;">
								<img src="/comm/PROFL/getFile?fileName=${bplcVO.proflImg}" id="proflImg" style="width: 55px; height: 55px; border-radius: 25%;">
								<a href="/comm/PROFL/getFile?fileName=${bplcVO.proflImg}">${bplcVO.proflImg}</a>&nbsp;&nbsp;
								<button type="button" class="btn-secondary delProfileImgBtn"> 삭제</button>
							</div>
						</c:if>
						<div id="attachFileDiv">
								<div class="row" id="attachFileInputDiv" <c:if test="${!empty bplcVO.proflImg }">style="display:none;"</c:if>>
									<div class="col-12">
										<div class="custom-file" id="uptAttach">
											<input type="file" class="form-control w-2/3" id="attachFile" name="attachFile" onchange="fileCheck(this);" />
										</div>
									</div>
								</div>
						</div>
						<form:input type="hidden" path="delProflImg" id="delProflImg" name="delProflImg"  value="N"/>
					</td>
				</tr>
			</tbody>
		</table>
	</fieldset>

	<fieldset class="mt-13">
		<legend class="text-title2 relative"> 업체정보 </legend>
		<table class="table-detail br">
			<colgroup>
				<col class="w-43">
				<col>
			</colgroup>
			<tbody>
				<tr>
					<th scope="row"><label for="brno" class="require">사업자 등록번호</label></th>
					<td><form:input path="brno" class="form-control w-90" maxlength="12" value="${bplcVO.brno}" /></td>
				</tr>
				<tr>
					<th scope="row"><label for="rcperInstNo">장기요양 기관번호</label></th>
					<td><form:input path="rcperInstNo" class="form-control w-90" maxlength="13" value="${bplcVO.rcperInstNo}" /></td>
				</tr>
				<tr>
					<th scope="row"><label for="rprsvNm" class="require">대표자 명</label></th>
					<td><form:input path="rprsvNm" class="form-control w-90" maxlength="50" value="${bplcVO.rprsvNm}" /></td>
				</tr>
				<tr>
					<th scope="row"><label for="bizcnd">업태</label></th>
					<td><form:input path="bizcnd" class="form-control w-90" maxlength="50" value="${bplcVO.bizcnd}" /></td>
				</tr>
				<tr>
					<th scope="row"><label for="iem">종목</label></th>
					<td><form:input path="iem" class="form-control w-90" maxlength="50" value="${bplcVO.iem}" /></td>
				</tr>
				<tr>
					<th scope="row"><label for="bplcId" class="require">사업장 주소</th>
					<td>
						<div class="form-group">
							<form:input path="zip" class="form-control w-50 numbercheck" value="${bplcVO.zip}" maxlength="5"/>
							<button type="button" class="btn-primary w-30" onclick="f_findAdress('zip', 'addr', 'daddr','lat','lot'); return false;">우편번호 검색</button>
						</div>
						<form:input class="form-control w-full mt-1" path="addr" maxlength="200" value="${bplcVO.addr}" />
						<form:input class="form-control w-full mt-1" path="daddr" maxlength="200" value="${bplcVO.daddr }" />
						<form:hidden path="lat" value="${bplcVO.lat}"/>
						<form:hidden path="lot" value="${bplcVO.lot}"/>
					</td>
				</tr>
				<tr>
					<th scope="row"><label for="dlvyZip">배송지 주소</th>
					<td>
						<div class="form-group">
							<form:input path="dlvyZip" class="form-control w-50 numbercheck" value="${bplcVO.dlvyZip}" maxlength="5" />
							<button type="button" class="btn-primary w-30" onclick="f_findAdrs('dlvyZip', 'dlvyAddr', 'dlvyDaddr'); return false;">우편번호 검색</button>
							<div class="form-check">
								<input type="checkbox" class="form-check-input" id="bplcCopy">
								<label class="form-check-label" for="bplcCopy">사업장 주소와 동일</label>
							</div>
						</div>
						<form:input class="form-control w-full mt-1" path="dlvyAddr" maxlength="200" value="${bplcVO.dlvyAddr }"/>
						<form:input class="form-control w-full mt-1" path="dlvyDaddr" maxlength="200" value="${bplcVO.dlvyDaddr }" />
					</td>
				</tr>
				<tr>
					<th scope="row">세금계산서 수신메일<span></span></th>
					<td><form:input class="form-control w-90" path="taxbilEml" value="${bplcVO.taxbilEml}" maxlength="50" /></td>
				</tr>
				<tr>
					<th scope="row"><label for="bsnmCeregrt">사업자 등록증</th>
					<td><c:if test="${!empty bplcVO.bsnmCeregrt}">
							<div class="form-group" style="display: flex;">
								<a href="/comm/CEREGRT/getFile?fileName=${bplcVO.bsnmCeregrt}">${bplcVO.bsnmCeregrt}</a>&nbsp;&nbsp;
								<button type="button" class="btn-secondary delBsnmCeregrtBtn"> 삭제</button>
							</div>
						</c:if>
						<div id="bsnmCeregrtFileDiv">
							<div class="row" id="bsnmCeregrt1FileDiv" <c:if test="${!empty bplcVO.bsnmCeregrt }">style="display:none;"</c:if>>
								<div class="col-12">
									<div class="custom-file" id="bsnmCeregrtAttach">
										<input type="file" class="form-control w-2/3" id="bsnmCeregrt1" name="bsnmCeregrt1" onchange="fileCheck(this);" />
									</div>
								</div>
							</div>
						</div>
						<form:input type="hidden" path="delBsnmCeregrt" id="delBsnmCeregrt" name="delBsnmCeregrt" value="N" />
					</td>
				</tr>
				<tr>
					<th scope="row"><label for="bsnmOffcs">사업자 직인</th>
					<td><c:if test="${!empty bplcVO.bsnmOffcs}">
							<div class="form-group" style="display: flex;">
								<a href="/comm/OFFCS/getFile?fileName=${bplcVO.bsnmOffcs}">${bplcVO.bsnmOffcs}</a>&nbsp;&nbsp;
								<button type="button" class="btn-secondary delBsnmOffcsBtn"> 삭제</button>
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
						</div>
						<form:input type="hidden" path="delBsnmOffcs" id="delBsnmOffcs" name="delBsnmOffcs" value="N" />
					</td>
				</tr>
			</tbody>
		</table>
	</fieldset>

	<fieldset class="mt-13">
		<legend class="text-title2 relative"> 담당자정보 </legend>
		<table class="table-detail pic">
			<colgroup>
				<col class="w-43">
				<col>
			</colgroup>
			<tbody>
				<tr>
					<th scope="row"><label for="picNm">담당자 명</label></th>
					<td><form:input class="form-control w-90" path="picNm" value="${bplcVO.picNm}" maxlength="50" /></td>
				</tr>
				<tr>
					<th scope="row"><label for="picTelno">담당자 연락처</label></th>
					<td><form:input class="form-control w-90" path="picTelno" value="${bplcVO.picTelno}" maxlength="13" /></td>
				</tr>
				<tr>
					<th scope="row"><label for="picEml">담당자 이메일</label></th>
					<td><form:input class="form-control w-90" path="picEml" value="${bplcVO.picEml}" maxlength="100"/></td>
				</tr>
			</tbody>
		</table>
	</fieldset>

	<fieldset class="mt-13">
		<legend class="text-title2 relative"> 정산정보 </legend>
		<table class="table-detail bank">
			<colgroup>
				<col class="w-43">
				<col>
			</colgroup>
			<tbody>
				<tr>
					<th scope="row">은행</th>
					<td>
						<form:select class="form-control" path="clclnBank" >
							<c:forEach var="bank" items="${bankTyCode}">
								<form:option value="${bank.key}">${bank.value}</form:option>
							</c:forEach>
						</form:select>
					</td>
				</tr>
				<tr>
					<th scope="row">계좌번호</th>
					<td><form:input class="form-control w-90" path="clclnActno" value="${bplcVO.clclnActno}" maxlength="50"/></td>
				</tr>
				<tr>
					<th scope="row">예금주</th>
					<td><form:input class="form-control w-90" path="clclnDpstr" value="${bplcVO.clclnDpstr}" maxlength="50"/></td>
				</tr>
			</tbody>
		</table>
	</fieldset>

	<fieldset class="mt-13">
		<legend class="text-title2 relative"> 등록정보 </legend>
		<table class="table-detail join">
			<colgroup>
				<col class="w-43">
				<col>
			</colgroup>
			<tbody>
				<tr>
					<th scope="row"><label for="joinDt">등록일</label></th>
					<td>
						<fmt:formatDate value="${bplcVO.joinDt}" pattern="yyyy-MM-dd HH:mm" />
					</td>
				</tr>
				<tr>
					<th scope="row"><label for="trmsAgreDt">약관 동의 일시</label></th>
					<td>
						<fmt:formatDate value="${bplcVO.trmsAgreDt}" pattern="yyyy-MM-dd HH:mm" />
					</td>
				</tr>
				<tr>
					<th scope="row">사용 여부<span class="require"></span></th>
					<td>
						<div class="form-check-group">
							<c:forEach items="${useYnCode}" var="useYn" varStatus="status">
								<div class="form-check">
									<form:radiobutton class="form-check-input" path="useYn" id="useYn${status.index}" value="${useYn.key}" />
									<label class="form-check-label" for="useYn${status.index}">${useYn.value}</label>
								</div>
							</c:forEach>
						</div>
					</td>
				</tr>
				<tr>
					<th scope="row">상담 장기요양기관<span></span></th>
					<td>
						<div class="form-check-group">
							<c:forEach items="${dspyYnCode}" var="mbGiupMatching" varStatus="status"> 
								<div class="form-check">
									<form:radiobutton class="form-check-input" path="mbGiupMatching" id="mbGiupMatching${status.index}" value="${mbGiupMatching.key}" />
									<label class="form-check-label" for="mbGiupMatching${status.index}">${mbGiupMatching.value}</label>
								</div>
							</c:forEach>
						</div>
					</td>
				</tr>
				<tr>
					<th scope="row">추천 멤버스<span></span></th>
					<td>
						<div class="form-check-group">
							<c:forEach items="${dspyYnCode}" var="rcmdtnYn" varStatus="status">
								<div class="form-check">
									<form:radiobutton class="form-check-input" path="rcmdtnYn" id="rcmdtnYn${status.index}" value="${rcmdtnYn.key}" />
									<label class="form-check-label" for="rcmdtnYn${status.index}">${rcmdtnYn.value}</label>
								</div>
							</c:forEach>
						</div>
					</td>
				</tr>
				<tr>
					<th scope="row">탈퇴 여부</th>
					<td>
						<c:choose>
							<c:when test="${ !empty bplcVO.leaveRejectDate }">
								-
							</c:when>
							<c:when test="${ !empty bplcVO.leaveConfirmDate }">
								<span class="text-red1">탈퇴 승인 완료</span> (${ fn:substring(bplcVO.leaveConfirmDate, 0, 4) }-${ fn:substring(bplcVO.leaveConfirmDate, 4, 6) }-${ fn:substring(bplcVO.leaveConfirmDate, 6, 8) })
							</c:when>
							<c:when test="${ !empty bplcVO.leaveRequestDate }">
								<span class="text-red1">탈퇴 승인 대기 중</span> (${ fn:substring(bplcVO.leaveRequestDate, 0, 4) }-${ fn:substring(bplcVO.leaveRequestDate, 4, 6) }-${ fn:substring(bplcVO.leaveRequestDate, 6, 8) })
							</c:when>
							<c:otherwise>
								-
							</c:otherwise>
						</c:choose>
						
					</td>
				</tr>
				
			</tbody>
		</table>
	</fieldset>


	<div class="btn-group right mt-8">
		<button type="button" class="btn-success large shadow f_sendRndPwd">임시 비밀번호 발급</button>

		<button type="submit" class="btn-primary large shadow">저장</button>

		<c:set var="pageParam" value="curPage=${param.curPage}&amp;cntPerPage=${param.cntPerPage}&amp;srchBgngDt=${param.srchBgngDt}&amp;srchEndDt=${param.srchEndDt}&amp;sortBy=${param.sortBy}&amp;srchBplcId=${param.srchBplcId}
		&amp;srchBplcNm=${param.srchBplcNm}&amp;srchRprsvNm=${param.srchRprsvNm}&amp;srchBrno=${param.srchBrno}&amp;srchDspyYn=${param.srchDspyYn}&amp;srchUseYn=${param.srchUseYn}" />
		<a href="./list?${pageParam}" class="btn-secondary large shadow">목록</a>
	</div>
</form:form>

<script>

//사업장주소검색 DAUM API
function f_findAdress(zip, addr, daddr, lat, lot) {
	$.ajaxSetup({ cache: true });
	$.getScript( "//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js", function() {
		$.ajaxSetup({ cache: false });
		new daum.Postcode({
			oncomplete: function(data) {
			$("#"+zip).val(data.zonecode); // 우편번호
			$("#"+addr).val(data.roadAddress); // 도로명 주소 변수
			$("#"+daddr).focus(); //포커스

			if(lat != undefined && lot != undefined){
				f_findGeocode(data, lat, lot); //좌표
			}
	        }
	    }).open();
	});
}

//배송지주소검색 DAUM API
function f_findAdrs(dlvyZip, dlvyAddr, dlvyDaddr) {
	$.ajaxSetup({ cache: true });
	$.getScript( "//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js", function() {
		$.ajaxSetup({ cache: false });
		new daum.Postcode({
			oncomplete: function(data) {
			$("#"+dlvyZip).val(data.zonecode); // 우편번호
			$("#"+dlvyAddr).val(data.roadAddress); //도로명 주소 변수
			$("#"+dlvyDaddr).focus(); //포커스
	        }
	    }).open();
	});
}


//미승인 시 사유 체크
$(function(){

	//대표이미지 삭제버튼
	$(".delProfileImgBtn").on("click", function(){
		$("#delProflImg").val("Y");
		$(this).closest("div").slideUp(10);
		$("#attachFileInputDiv").css("display","");
	});

	//사업자 등록증 삭제버튼
	$(".delBsnmCeregrtBtn").on("click", function(){
		$("#delBsnmCeregrt").val("Y");
		$(this).closest("div").slideUp(10);
		$("#bsnmCeregrt1FileDiv").css("display","");
	});

	//사업자 직인 삭제버튼
	$(".delBsnmOffcsBtn").on("click", function(){
		$("#delBsnmOffcs").val("Y");
		$(this).closest("div").slideUp(10);
		$("#bsnmOffcs1FileDiv").css("display","");
	});

	//사업장 주소 복사
	$("#bplcCopy").on("click",function(){
		if($("#bplcCopy").is(":checked")){
			var zip = $("#zip").clone().val();
			var addr = $("#addr").clone().val();
			var daddr = $("#daddr").clone().val();
			$("#dlvyZip").val(zip);
			$("#dlvyAddr").val(addr);
			$("#dlvyDaddr").val(daddr);
		}else{
			$("#dlvyZip").val('');
			$("#dlvyAddr").val('');
			$("#dlvyDaddr").val('');
		}
	});

	//주소 복사 버튼 체크
	if($("#zip").val() == $("#dlvyZip").val() && $("#addr").val() == $("#dlvyAddr").val() && $("#daddr").val() == $("#dlvyDaddr").val()){
		$("#bplcCopy").prop("checked",true);
	}

	//임시 비밀번호 발급
	$(".f_sendRndPwd").on("click", function(){
		if(confirm($("#picEml").val() + " 해당 이메일로 이메일을 발송하시겠습니까?")){
			$.ajax({
				type : "post",
				url  : "sendRndPswd.json",
				data : {
					uniqueId:'${bplcVO.uniqueId}'
				},
				dataType : 'json'
			})
			.done(function(data) {
				if(data.result){
					alert("임시비밀번호가 담당자 이메일로 발송되었습니다.");
				}else{
					console.log("fail");
				}
			})
			.fail(function(data, status, err) {
				//console.log('f_dlvy_save : error forward : ' + data);
				alert(data.reason);
			});
		}else{
			return false;
		}
	});

	var telchk = /^([0-9]{2,3})?-([0-9]{3,4})?-([0-9]{3,4})$/;
	var brnoChk = /^([0-9]{3}-[0-9]{2}-[0-9]{5})$/;
	var rcperChk = /^([0-9]{1}-[0-9]{5}-[0-9]{5})$/;
	const regExp = /[\{\}\[\]\/?.,;:|\)*~`!^\-_+<>@\#$%&\\\=\(\'\"]/g;
	var emailchk = /^[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*.[a-zA-Z]{2,3}$/i;
	var acctChk = /^([0-9,\-]{3,6})?-([0-9,\-]{2,6})?-([0-9]{2,6})([0-9,\-]{0,6})$/;

	//유효성
	$("form#frmBplc").validate({
	    ignore: "input[type='text']:hidden",
	    rules : {
	    	bplcNm : {required : true},
	    	telno : {required : true, regex : telchk},
	    	//fxno : {regex : telchk},
	    	brno : {required : true, regex : brnoChk},
	    	//rcperInstNo : {required : false, regex : rcperChk},
	    	rprsvNm : {required : true},
	    	bizcnd : {required : false},
	    	iem : {required : false},
	    	zip : {required : false, min : 5},
	    	addr : {required : false},
	    	daddr : {required : false},
	    	dlvyZip : {required : false, min : 5},
	    	dlvyAddr : {required : false},
	    	dlvyDaddr : {required : false},
	    	taxbilEml : {required : false, regex : emailchk},
	    	picNm : {required : false},
	    	picTelno : {required : false, regex : telchk},
	    	picEml : {required : false, regex : emailchk},
	    	clclnActno : {regex : acctChk},
	    	useYn : {required : true},
	    	rcmdtnYn : {required : false},
	    },
	    messages : {
	    	bplcNm : {required : "기업명은 필수 입력 항목입니다."},
	    	telno : {required : "전화번호는 필수 입력 항목입니다.", regex : "전화번호 형식이 잘못되었습니다.\n(000-0000-0000)"},
	    	//fxno : {regex : "숫자와 하이폰으로 입력해주세요."},
	    	brno : {required : "사업자등록번호는 필수 입력 항목입니다."},
	    	//rcperInstNo : {required : "장기요양기관번호는 필수 입력 항목입니다.", regex : "형식이 잘못되었습니다.\n(0-00000-00000)"},
	    	rprsvNm : {required : "대표자명은 필수 입력 항목입니다."},
	    	bizcnd : {required : "업태는 필수 입력 항목입니다."},
	    	iem : {required : "종목은 필수 입력 항목입니다."},
	    	zip : {required : "우편번호는 필수 입력 항목입니다.", min : "우편번호는 최소 5자리입니다."},
	    	addr : {required : "주소는 필수 입력 항목입니다."},
	    	daddr : {required : "상세주소는 필수 입력 항목입니다."},
	    	dlvyZip : {required : "우편번호는 필수 입력 항목입니다.", min : "우편번호는 최소 5자리입니다."},
	    	dlvyAddr : {required : "주소는 필수 입력 항목입니다."},
	    	dlvyDaddr : {required : "상세주소는 필수 입력 항목입니다."},
	    	taxbilEml : {required : "수신메일은 필수 입력 항목입니다.", regex : "이메일 형식이 잘못되었습니다.\n(abc@def.com)"},
	    	picNm : {required : "담당자명은 필수 입력 항목입니다."},
	    	picTelno : {required : "담당자 연락처는 필수 입력 항목입니다.", regex : "전화번호 형식이 잘못되었습니다.\n(000-0000-0000)"},
	    	picEml : {required : "담당자 이메일은 필수 입력 항목입니다.", regex : "이메일 형식이 잘못되었습니다.\n(abc@def.com)"},
	    	clclnActno : {regex : "숫자와 하이폰만 가능합니다."},
	    	useYn : {required : "사용여부는 필수 입력 항목입니다."},
	    	rcmdtnYn : {required : "전시여부는 필수 입력 항목입니다."},
	    },
	    submitHandler: function (frm) {
	   		if(confirm("저장하시겠습니까?")){
	   			frm.submit();
	   		}else{
	   			return false;
	   		}
	    }
	});

	
	//장기요양 기관번호 입력시  - 기호추가
	<%--
	$("#rcperInstNo").on("keydown",function(e){
		if (e.keyCode !== 11) {
			if(e.key === "Backspace" || e.key === "Delete") {
				var currentValue = $(this).val();
				var caretPosition = this.selectionStart;
				var newValue = currentValue.slice(0, caretPosition - 1) + currentValue.slice(caretPosition);
				$(this).val(newValue);
				this.setSelectionRange(caretPosition - 1, caretPosition - 1);
				return false; 
			}

			if($(this).val().length == 1){
				$(this).val($(this).val() + "-");
			}

			if($(this).val().length == 7){
				$(this).val($(this).val() + "-");
			}
			
			if($(this).val().length == 13){
				$(this).val($(this).val() + "-");
			}
		}
	});

	$("#rcperInstNo").on("keyup",function(){
		if($(this).val().length > 13){
			$(this).val($(this).val().substr(0,13));
		}
	});
	--%>
});


$(document).ready(function(){
	/* 기본정보, 업체정보, 정산정보 영역 disabled*/
	$(".table-detail.bplc input").attr("readonly", "true");
	$(".table-detail.br input").attr("readonly", "true");
	$(".table-detail.bank input").attr("readonly", "true");
	$(".table-detail.bank select").attr("readonly", "true");

	$(".table-detail.bplc button").off("click");
	$(".table-detail.br button").off("click");
	$(".table-detail.br button").removeAttr("onclick");
});
</script>