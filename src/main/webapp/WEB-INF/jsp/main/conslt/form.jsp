<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<header id="subject">
	<nav class="breadcrumb">
		<ul>
			<li class="home"><a href="${_mainPath}">홈</a></li>
			<li>제3자 정보제공동의</li>
		</ul>
	</nav>
	<h2 class="subject">
		제3자 정보제공동의 <img src="/html/page/index/assets/images/ico-subject6.png" alt="">
	</h2>
</header>
<div id="content">
	<form:form class="provide-form" id="consltFrm" name="consltFrm" modelAttribute="mbrConsltVO" action="./action">
	<form:hidden path="consltNo" />

		<div class="form-check form-agree form-group">
			<input class="form-check-input" type="checkbox" name="agreeBtn" id="agreeBtn" value="Y">
			<label class="form-check-label" for="agreeBtn">동의합니다</label>
		</div>
		<fieldset class="form-fieldset">
			<legend>개인정보 제3자 제공 동의</legend>
			<dl>
				<dt>
					<label for="mbrNm">성명</label>
				</dt>
				<dd>
					<input type="text" id="mbrNm" name="mbrNm" class="form-control w-full xs:max-w-50" value="${_mbrSession.mbrNm}"  maxlength="100"/>
				</dd>
			</dl>
			<dl>
				<dt>
					<label for="mbrNm">성별</label>
				</dt>
				<dd>
					<div class="form-group gap-4 h-10 md:h-11 md:gap-5">
					<c:forEach var="gender" items="${genderCode}" varStatus="status">
						<label class="form-check" for="gender${status.index}">
							<input class="form-check-input" type="radio" name="gender" id="gender${status.index}" value="${gender.key}" <c:if test="${gender.key eq  _mbrSession.gender}">checked="checked"</c:if>>
							<span class="form-check-label">${gender.value}</span>
						</label>
					</c:forEach>
					</div>
				</dd>
			</dl>
			<dl>
				<dt>
					<label for="mblTelno">연락처</label>
				</dt>
				<dd>
					<input type="text" id="mbrTelno" name="mbrTelno" class="form-control w-full xs:max-w-50" value="${_mbrSession.mblTelno}" maxlength="13" <c:if test="${!empty _mbrSession.mblTelno}">readonly="true"</c:if> oninput="autoHyphen(this);"/>
				</dd>
			</dl>
			<dl>
				<dt>
					<label for="age">생년월일</label>
				</dt>
				<dd>
					<input type="text" id="brdt" name="brdt" class="form-control w-full xs:max-w-50" value="<fmt:formatDate value="${_mbrSession.brdt}" pattern="yyyyMMdd" />" maxlengh="8"/>
				</dd>
			</dl>
			<dl>
				<dt>
					<label for="searchAddr">거주지주소</label>
				</dt>
				<dd>
					<div class="form-group w-full xs:max-w-76">
						<input type="text" class="form-control flex-1" id="zip" name="zip" value="${_mbrSession.zip}" maxlength="5"/>
						<button class="btn btn-outline-primary w-[6em]" id="searchAddr" onclick="f_findAdres('zip', 'addr', 'daddr'); return false;">주소검색</button>
					</div>
					<input type="text" class="form-control w-full" id="addr" name="addr" value="${_mbrSession.addr}" maxlength="200"/>
					<input type="text" class="form-control w-full" id="daddr" name="daddr" value="${_mbrSession.daddr}" maxlength="200" />
				</dd>
			</dl>
			<p>
				※ 상기 정보는 장기요양등급 신청 및 상담이 가능한 장기요양기관 [<a href="javascript:;" class="text-primary3"
					onclick="window.open('./include/popup','','width=500,height=650,scrollbars=yes')">전체보기</a>]에
				제공되며, 원활한 상담 진행 목적으로 상담 기관이 변경될 수도 있습니다.
			</p>
		</fieldset>
		<div class="form-submit">
			<button type="submit" class="btn btn-large btn-primary3">상담신청하기</button>
			<a href="${_mainPath}" class="btn btn-large">취소</a>
		</div>
	</form:form>
</div>

<script>
function f_findAdres(zip, addr, daddr, lat, lot) {
	$.ajaxSetup({ cache: true });
	$.getScript( "//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js", function() {
		$.ajaxSetup({ cache: false });
		new daum.Postcode({
			oncomplete: function(data) {
				$("#"+zip).val(data.zonecode); // 우편번호
				$("#"+zip).removeClass("is-invalid");
				$("#"+zip+"-error").remove();
				$("#"+addr).val(data.roadAddress); // 도로명 주소 변수
				$("#"+addr).removeClass("is-invalid");
				$("#"+addr+"-error").remove();
				$("#"+daddr).focus(); //포커스
	        }
	    }).open();
	});
}

//전화번호 마스킹
const autoHyphen = (target) => {
	if(target.value.length > 8){
		target.value = target.value
   		.replace(/[^0-9]/g, '')
   		.replace(/^(\d{2,3})(\d{3,4})(\d{4})$/, `$1-$2-$3`);
	}else{
		target.value = target.value
   		.replace(/[^0-9]/g, '')
   		.replace(/^(\d{4})(\d{4})$/, `$1-$2`);
	}

}

$(function(){

	const telchk = /^([0-9]{2,3})?-([0-9]{3,4})?-([0-9]{3,4})$/;
	const numberCheck = /[0-9]/g;

	// 정규식 체크
	$.validator.addMethod("regex", function(value, element, regexpr) {
		if(value != ''){
			return regexpr.test(value)
		}else{
			return true;
		}
	}, "형식이 올바르지 않습니다.");

	$.validator.setDefaults({
		onfocusout: false,
	   	errorElement: 'div',
		errorPlacement: function(error, element) {
		    var group = element.closest('.form-check-group, .form-group');
		    if (group.length) {
		        group.after(error.addClass('text'));
		    } else {
		        element.after(error.addClass('text'));
		    }
		},
		success: function(label){
			label.closest(".invalid-feedback").remove();
		},
		highlight:function(element, errorClass, validClass) {
		    $(element).addClass('is-invalid');
		},
		unhighlight: function(element, errorClass, validClass) {
		    $(element).removeClass('is-invalid');
		}
	});

	//유효성 검사
	$("form#consltFrm").validate({
		ignore: "input[type='text']:hidden",
		rules: {
			mbrNm : {required : true},
			mbrTelno : {required : true, regex : telchk},
			gender : {required : true},
			brdt : {required : true},
			zip : {required : true, min : 5},
			addr : {required : true},
			daddr : {required : true}
		},
		messages : {
			mbrNm : {required : "성명은 필수 입력 항목입니다."},
			mbrTelno : {required : "연락처는 필수 입력 항목입니다."},
			gender : {required : "성별은 필수 선택 항목입니다."},
			brdt : {required : "생년월일은 필수 입력 항목입니다."},
			zip : {required : "우편번호는 필수 입력 항목입니다.", min : 5},
			addr : {required : "주소는 필수 입력 항목입니다."},
			daddr : {required : "상세 주소는 필수 입력 항목입니다."}
		},
	    submitHandler: function (frm) {
	    	let agreeFlag = $("#agreeBtn").is(":checked");

	    	if(!agreeFlag){
	    		alert("개인정보 제3자 제공에 동의바랍니다.");
	    		return false;
	    	}else{
	    		if(confirm("상담신청 하시겠습니까?")){
	    			frm.submit();
	    		}else{
	    			return false;
	    		}
	    	}
	    }

	});

});
</script>
