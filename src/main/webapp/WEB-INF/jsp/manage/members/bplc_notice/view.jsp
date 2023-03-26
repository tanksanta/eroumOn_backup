<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<form:form name="frmBplc" id="frmBplc" modelAttribute="bplcVO" method="post" action="./action">
	<!-- 검색조건 -->
	<input type="hidden" name="cntPerPage" id="cntPerPage" value="${param.cntPerPage}" />
	<input type="hidden" name="curPage" id="curPage" value="${param.curPage}" />
	<input type="hidden" name="sortBy" id="sortBy" value="${param.sortBy}" />
	<input type="hidden" name="srchBgngDt" id="srchBgngDt" value="${param.srchBgngDt}" />
	<input type="hidden" name="srchEndDt" id="srchEndDt" value="${param.srchEndDt}" />
	<input type="hidden" name="srchTarget" id="srchTarget" value="${param.srchTarget}" />
	<input type="hidden" name="srchText" id="srchText" value="${param.srchText}" />
	<input type="hidden" name="srchUseYn" id="srchUseYn" value="${param.srchUseYn }" />

	<form:hidden path="crud" value="UPDATE" />
	<form:hidden path="uniqueId" value="${bplcVO.uniqueId}" />

	<fieldset>
		<legend class="text-title2 relative">기본정보</legend>
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
					<th scope="row"><label for="bplcNm" class="require">기업명</label></th>
					<td><form:input path="bplcNm" class="form-control w-90" maxlength="100" value="${bplcVO.bplcNm}" /></td>
				</tr>
				<tr>
					<th scope="row"><label for="telno" class="require">전화번호</label></th>
					<td><form:input path="telno" class="form-control w-90" maxlength="15" value="${bplcVO.telno}" /></td>
				</tr>
				<tr>
					<th scope="row"><label for="fxno">팩스번호</label></th>
					<td><form:input path="fxno" class="form-control w-90" maxlength="15" value="${bplcVO.fxno}" /></td>
				</tr>
				<tr>
					<th>대표 이미지</th>
					<td><c:if test="${!empty bplcVO.proflImg}">
							<div class="form-group" style="display: flex;">
								<img src="/comm/proflImg?fileName=${bplcVO.proflImg}" id="profile" style="width: 55px; height: 55px; border-radius: 25%;">
								<button type="button" class="delProfileImgBtn">
									<i class="fa fa-trash"></i>
								</button>
							</div>
						</c:if>
					</td>
				</tr>
			</tbody>
		</table>
	</fieldset>

	<fieldset class="mt-13">
		<legend class="text-title2 relative"> 업체정보 </legend>
		<table class="table-detail">
			<colgroup>
				<col class="w-43">
				<col>
			</colgroup>
			<tbody>
				<tr>
					<th scope="row"><label for="brno" class="require">사업자등록번호</label></th>
					<td><form:input path="brno" class="form-control w-90 numbercheck" maxlength="15" value="${bplcVO.brno}" /></td>
				</tr>
				<tr>
					<th scope="row"><label for="rcperInstNo" class="require">장기요양기관번호</label></th>
					<td><form:input path="rcperInstNo" class="form-control w-90 numbercheck" maxlength="20" value="${bplcVO.rcperInstNo}" /></td>
				</tr>
				<tr>
					<th scope="row"><label for="rprsvNm" class="require">대표자명</label></th>
					<td><form:input path="rprsvNm" class="form-control w-90" maxlength="10" value="${bplcVO.rprsvNm}" /></td>
				</tr>
				<tr>
					<th scope="row"><label for="bizcnd" class="require">업태</label></th>
					<td><form:input path="bizcnd" class="form-control w-90" maxlength="10" value="${bplcVO.bizcnd}" /></td>
				</tr>
				<tr>
					<th scope="row"><label for="iem" class="require">종목</label></th>
					<td><form:input path="iem" class="form-control w-90" maxlength="10" value="${bplcVO.iem}" /></td>
				</tr>
				<tr>
					<th scope="row"><label for="bplcId" class="require">사업장주소</th>
					<td>
						<div class="form-group">
							<form:input path="zip" class="form-control w-50" value="${bplcVO.zip}"/>
							<button type="button" class="btn-primary w-30" onclick="f_findAdress('zip', 'addr', 'daddr'); return false;">우편번호 검색</button>
						</div>
						<form:input class="form-control w-full mt-1" path="addr" maxlength="200" value="${bplcVO.addr}" />
						<form:input class="form-control w-full mt-1" path="daddr" maxlength="200" value="${bplcVO.daddr }" />
						<form:input class="form-control w-full" path="lat" value="${bplcVO.lat}"/>
						<form:input class="form-control w-full" path="lot" value="${bplcVO.lot}"/>
					</td>
				</tr>
				<tr>
					<th scope="row"><label for="dlvyZip" class="require">배송지주소</th>
					<td>
						<div class="form-group">
							<form:input path="dlvyZip" class="form-control w-50" value="${bplcVO.dlvyZip}" />
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
					<th scope="row">세금계산서 수신메일<span class="require"></span></th>
					<td><form:input class="form-control w-90" path="taxbilEml" value="${bplcVO.taxbilEml}" maxlength="50" /></td>
				</tr>
				<tr>
					<th scope="row"><label for="bsnmCeregrt" class="require">사업자 등록증</th>
					<td><c:if test="${!empty bplcVO.bsnmCeregrt}">
							<div class="form-group" style="display: flex;">
								<img src="/comm/proflImg?fileName=${bplcVO.bsnmCeregrt}" id="bsnmCeregrt" style="width: 55px; height: 55px; border-radius: 25%;">
								<button type="button" class="delProfileImgBtn">
									<i class="fa fa-trash"></i>
								</button>
							</div>
						</c:if>
					</td>
				</tr>
				<tr>
					<th scope="row"><label for="bsnmOffcs" class="require">사업자 직인</th>
					<td><c:if test="${!empty bplcVO.bsnmOffcs}">
							<div class="form-group" style="display: flex;">
								<img src="/comm/proflImg?fileName=${bplcVO.bsnmOffcs}" id="bsnmOffcs" style="width: 55px; height: 55px; border-radius: 25%;">
								<button type="button" class="delProfileImgBtn">
									<i class="fa fa-trash"></i>
								</button>
							</div>
						</c:if>
					</td>
				</tr>
			</tbody>
		</table>
	</fieldset>

	<fieldset class="mt-13">
		<legend class="text-title2 relative"> 담당자정보 </legend>
		<table class="table-detail">
			<colgroup>
				<col class="w-43">
				<col>
			</colgroup>
			<tbody>
				<tr>
					<th scope="row"><label for="picNm" class="require">담당자명</label></th>
					<td><form:input class="form-control w-90" path="picNm" value="${bplcVO.picNm}" /></td>
				</tr>
				<tr>
					<th scope="row"><label for="picTelno" class="require">담당자 연락처</label></th>
					<td><form:input class="form-control w-90" path="picTelno" value="${bplcVO.picTelno}" /></td>
				</tr>
				<tr>
					<th scope="row"><label for="picEml" class="require">담당자 이메일</label></th>
					<td><form:input class="form-control w-90" path="picEml" value="${bplcVO.picEml}" /></td>
				</tr>
			</tbody>
		</table>
	</fieldset>

	<fieldset class="mt-13">
		<legend class="text-title2 relative"> 정산정보 </legend>
		<table class="table-detail">
			<colgroup>
				<col class="w-43">
				<col>
			</colgroup>
			<tbody>
				<tr>
					<th scope="row">은행</th>
					<td>${bplcVO.clclnBank}</td>
				</tr>
				<tr>
					<th scope="row">계좌번호</th>
					<td>${bplcVO.clclnActno}</td>
				</tr>
				<tr>
					<th scope="row">예금주</th>
					<td>${bplcVO.clclnDpstr}</td>
				</tr>
			</tbody>
		</table>
	</fieldset>

	<fieldset class="mt-13">
		<legend class="text-title2 relative"> 등록정보 </legend>
		<table class="table-detail">
			<colgroup>
				<col class="w-43">
				<col>
			</colgroup>
			<tbody>
				<!-- TO DO 신규, 기존 구분 -->
				<tr>
					<th scope="row"><label for="aprvDt">등록일</label></th>
					<td>
						<fmt:formatDate value="${bplcVO.aprvDt}" pattern="yyyy-MM-dd HH:mm" />
					</td>
				</tr>
				<tr>
					<th scope="row">사용여부<span class="require"></span></th>
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
					<th scope="row">추천멤버스<span class="require"></span></th>
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

			</tbody>
		</table>
	</fieldset>


	<div class="btn-group right mt-8">
		<button type="button" class="btn-success large shadow">임시 비밀번호 발급</button>

		<button type="submit" class="btn-primary large shadow">저장</button>

		<c:set var="pageParam" value="uniqueId=${bplcVO.uniqueId}&amp;curPage=${param.curPage}&amp;cntPerPage=${param.cntPerPage}&amp;srchBgngDt=${param.srchBgngDt}&amp;srchEndDt=${param.srchEndDt}&amp;sortBy=${param.sortBy}&amp;srchUseYn=${param.srchUseYn}" />
		<a href="./list?${pageParam}" class="btn-secondary large shadow">목록</a>
	</div>
</form:form>

<script>

//사업장주소검색 DAUM API
function f_findAdress(zip, addr, daddr) {
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

	//유효성
	$("form#frmBplc").validate({
	    ignore: "input[type='text']:hidden",
	    rules : {
	    	bplcNm : {required : true},
	    	telno : {required : true},
	    	brno : {required : true},
	    	rcperInstNo : {required : true},
	    	rprsvNm : {required : true},
	    	bizcnd : {required : true},
	    	iem : {required : true},
	    	zip : {required : true},
	    	addr : {required : true},
	    	daddr : {required : true},
	    	<%--
	    	lat : {required : true},
	    	lot : {required : true},
	    	--%>
	    	dlvyZip : {required : true},
	    	dlvyAddr : {required : true},
	    	dlvyDaddr : {required : true},
	    	taxbilEml : {required : true},
	    	picNm : {required : true},
	    	picTelno : {required : true},
	    	picEml : {required : true},
	    	useYn : {required : true},
	    	rcmdtnYn : {required : true},
	    },
	    messages : {
	    	bplcNm : {required : "기업명은 필수 입력 항목입니다."},
	    	telno : {required : "전화번호는 필수 입력 항목입니다."},
	    	brno : {required : "사업자등록번호는 필수 입력 항목입니다."},
	    	rcperInstNo : {required : "장기요양기관번호는 필수 입력 항목입니다."},
	    	rprsvNm : {required : "대표자명은 필수 입력 항목입니다."},
	    	bizcnd : {required : "업태는 필수 입력 항목입니다."},
	    	iem : {required : "종목은 필수 입력 항목입니다."},
	    	zip : {required : "우편번호는 필수 입력 항목입니다."},
	    	addr : {required : "주소는 필수 입력 항목입니다."},
	    	daddr : {required : "상세주소는 필수 입력 항목입니다."},
	    	<%--
	    	lat : {required : "위도는 필수 입력 항목입니다."},
	    	lot : {required : "경도는 필수 입력 항목입니다."},
	    	--%>
	    	dlvyZip : {required : "우편번호는 필수 입력 항목입니다."},
	    	dlvyAddr : {required : "주소는 필수 입력 항목입니다."},
	    	dlvyDaddr : {required : "상세주소는 필수 입력 항목입니다."},
	    	taxbilEml : {required : "수신메일은 필수 입력 항목입니다."},
	    	picNm : {required : "담당자명은 필수 입력 항목입니다."},
	    	picTelno : {required : "담당자 연락처는 필수 입력 항목입니다."},
	    	picEml : {required : "담당자 이메일은 필수 입력 항목입니다."},
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



});
</script>