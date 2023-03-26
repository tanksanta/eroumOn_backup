<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<jsp:include page="../layout/page_header.jsp">
	<jsp:param value="멤버스 안내" name="pageTitle" />
</jsp:include>
<form:form id="guideFrm" name="guideFrm" action="./action" method="post" modelAttribute="bplcVO" enctype="multipart/form-data">
<form:hidden path="uniqueId" />
<form:hidden path="crud" />
<form:hidden path="useYn" value="${bplcVO.useYn}" />
<form:hidden path="rcmdtnYn" value="${bplcVO.rcmdtnYn}" />
	<fieldset>
		<legend class="text-title2">기본정보</legend>
		<table class="table-detail">
			<colgroup>
				<col class="w-43">
				<col>
				<col class="w-43">
				<col>
			</colgroup>
			<tbody>
				<tr>
					<th scope="row"><label for="form-item1">대표 이미지</label></th>
					<td colspan="3">
						<div class="office-main-image">
							<label for="attachFile" class="thumb">
							<c:if test="${!empty bplcVO.proflImg}">
							<img src="/comm/PROFL/getFile?fileName=${bplcVO.proflImg}" id="profImg" />
							</c:if>
							<input type="file" class="form-control w-2/3" id="attachFile" name="attachFile" onchange="fileCheck(this);" style="display:none;"/>
							</label> <label for="attachFile" class="btn-primary">등록</label>
							<c:if test="${!empty bplcVO.proflImg}">
							<button type="button" class="btn-secondary" id="delBtn" onclick="f_delProflImg(); return false;">삭제</button>
							</c:if>
							<p>※ 권장 사이즈 : 가로 136px * 세로 136px</p>
							<form:input type="hidden" path="delProflImg" id="delProflImg" name="delProflImg"  value="N"/>
						</div>
					</td>
				</tr>
				<tr>
					<th scope="row"><label for="dlvyZip" class="require">사업장 주소</label></th>
					<td colspan="3">
						<div class="form-group">
							<form:input path="zip" class="form-control w-46" />
							<button type="button" class="btn-primary w-30" onclick="f_findAdres('zip', 'addr', 'daddr','lat','lot'); return false;">우편번호 검색</button>
							<div class="form-check form-switch ml-3">
								<input class="form-check-input" type="checkbox" id="copyAdrs">
								<label class="copyAdrs" for="form-item2-3">회원 정보와 동일</label>
							</div>
						</div>
						<div class="form-group mt-1 w-full">
							<form:input class="form-control w-90" path="addr" maxlength="50" />
							<form:input class="form-control flex-1" path="daddr" maxlength="50" />
							<form:hidden path="lat" /> <form:hidden path="lot" />
						</div>
					</td>
				</tr>
				<tr>
					<th scope="row"><label for="form-item3" class="require" >전화번호</label></th>
					<td colspan="3">
						<div class="form-group w-75">
							<form:input class="form-control flex-1" path="telno" maxlength="13" />
						</div>
					</td>
				</tr>
				<tr>
					<th scope="row"><label for="form-item5" class="require">영업시간</label></th>
					<td colspan="3">
						<div class="form-group w-75">
							<form:input type="time" path="bsnHrBgng" class="form-control flex-1" placeholder="09:00" />
							<i>~</i>
							<form:input type="time" path="bsnHrEnd" class="form-control flex-1" placeholder="10:00"  />
						</div>
					</td>
				</tr>
				<tr>
					<th scope="row"><label for="form-item6" class="require">휴무일</label></th>
					<td colspan="3">
						 <div class="form-group">
							<c:forEach var="day" items="${bplcRstdeCode}" varStatus="status">
								<div class="form-check mr-6">
									<form:checkbox class="form-check-input" id="hldy${status.index}" path="hldy" value="${day.key}" />
									<label class="form-check-label pl-1" for="hldy${status.index}">${day.value}</label>
								</div>
							</c:forEach>
							<form:input path="hldyEtc" class="form-control w-68" placeholder="20자 이내로 입력하세요." value="${bplcVO.hldyEtc}" />
						</div>
					</td>
				</tr>
				<tr>
					<th scope="row"><label for="form-item7" class="require">주차여부</label></th>
					<td colspan="3">
						<div class="form-check-group">
							<c:forEach var="car" items="${parkngYnCode}" varStatus="status">
								<div class="form-check">
									<form:radiobutton class="form-check-input" path="parkngYn" id="parkngYn${status.index}" value="${car.key}" />
									<label class="form-check-label" for="parkngYn${status.index}">${car.value}</label>
								</div>
							</c:forEach>
						</div>
					</td>
				</tr>
				<tr>
					<th scope="row"><label for="form-item8">소개</label></th>
					<td colspan="3"><form:textarea path="intrcn" rows="4" placeholder="소개내용을 입력해주세요." class="form-control w-full" /></td>
				</tr>
			</tbody>
		</table>
	</fieldset>

	<div class="btn-group center mt-10">
		<button type="submit" class="btn-save w-52 large shadow">저장</button>
		<a href="${_bplcPath}/mng/index" class="btn-cancel w-52 large shadow">취소</a>
	</div>
</form:form>

<script>
var hldy = "${bplcVO.hldy}";

//대표 이미지 삭제
function f_delProflImg(){
	if(confirm("삭제하시겠습니까?")){
		$("#delProflImg").val("Y");
		$("#delBtn").hide();
		$("#profImg").attr('src',"");
	}else{
		return false;
	}
}

function setImageFromFile(input, expression) {
	if($("#profImg").attr("src") == ''){
		$("#profImg").attr("src",'');
		$("#delBtn").show();
	}
	    if (input.files && input.files[0]) {
	    var reader = new FileReader();
	    reader.onload = function (e) {
	    $(expression).attr('src', e.target.result);
	  }
	  reader.readAsDataURL(input.files[0]);
	  }

}

$(function(){

	var telchk = /^0([0-9]{1,2})-?([0-9]{3,4})-?([0-9]{4})$/;


	//기타
	$("#hldy5").on("click",function(){
		if($("#hldy5").is(":checked")){
			$("#hldyEtc").show();
		}else{
			$("#hldyEtc").hide();
			$("#hldyEtc").val('');
		}
	});

	//첨부파일 이미지 변경
	$("#attachFile").change(function(){
    	setImageFromFile(this, "#profImg");
	});



	//휴무일 체크
	if(hldy != null){
		var hldys = hldy.replaceAll(" ","").split(",");
		for(var i=0; i<hldys.length; i++){
			console.log(hldys[i]);
			for(var h=0; h<6; h++){
				if(hldys[i] == $("#hldy"+h).val()){
					$("#hldy"+h).prop("checked",true);
					//기타 체크
					if($("#hldy5").is(":checked")){
						$("#hldyEtc").show();
					}else{
						$("#hldyEtc").hide();
					}
				}
			}
		}
	}

	//시간 체크
	$.validator.addMethod("timeChk", function(value, element) {
		if($("#bsnHrBgng").val() > $("#bsnHrEnd").val()){
			return false;
		}else{
			return true;
		}
	}, "시간을 다시 설정 해주세요.");

	//시간 체크 확인
	$.validator.addMethod("tmChk", function(value, element) {
		if($("#bsnHrBgng").val() !='' && $("#bsnHrEnd").val() != ''){
			return true;
		}else{
			return false;
		}
	}, "시간은 필수 입력 항목입니다.");

	//회원 정보와 동일
	$("#copyAdrs").on("click",function(){
		if($("#copyAdrs").is(":checked")){
			const zip = "${bplcVO.zip}";
			const addr = "${bplcVO.addr}";
			const daddr = "${bplcVO.daddr}";

			$("#zip").val(zip);
			$("#addr").val(addr);
			$("#daddr").val(daddr);
		}else{
			$("#zip").val('');
			$("#addr").val('');
			$("#daddr").val('');
		}
	});

	//기타 입력 사유
	$.validator.addMethod("etcChk", function(value, element) {
		if($("#hldy5").is(":checked")){
			if($("#hldyEtc").val() != ''){
				return true;
			}else{
				return false;
			}
		}else{
			return true;
		}
	}, "기타 사유는 필수 입력 사항입니다.");

	//유효성
	$("form#guideFrm").validate({
	    ignore: "input[type='text']:hidden",
	    rules : {
	    	telno : {required : true, regex : telchk},
	    	zip : {required : true, min : 5},
	    	addr : {required : true},
	    	daddr : {required : true},
	    	bsnHrBgng : {required : true, tmChk : true},
	    	hldy : {required : true},
	    	hldyEtc : {etcChk : true}
	    },
	    messages : {
	    	telno : {required : "전화번호는 필수 입력 항목입니다.", regex : "전화번호 형식이 잘못되었습니다.\n(000-0000-0000)"},
	    	zip : {required : "우편번호는 필수 입력 항목입니다.", min : "우편번호는 최소 5자리입니다."},
	    	addr : {required : "주소는 필수 입력 항목입니다."},
	    	daddr : {required : "상세주소는 필수 입력 항목입니다."},
	    	bsnHrBgng : {required : "영업 시간은 필수 입력 항목입니다."},
	    	hldy : {required : "휴무일은 필수 입력 항목입니다."},

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