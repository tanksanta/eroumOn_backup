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
	
		<div class="form-check form-agree">
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
					<label for="mblTelno">연락처</label>
				</dt>
				<dd>
					<input type="text" id="mbrTelno" name="mbrTelno" class="form-control w-full xs:max-w-50" value="${_mbrSession.mblTelno}" maxlength="15" <c:if test="${!empty _mbrSession.mblTelno}">readonly="true"</c:if>/>
				</dd>
			</dl>
			<dl>
				<dt>
					<label for="age">만나이</label>
				</dt>
				<dd>
					<c:set var="now" value="<%=new java.util.Date()%>" />
					<c:set var="year"><fmt:formatDate value="${now}" pattern="yyyy" /></c:set>
					
					<c:set var="age" value="" />
					<c:if test="${!empty _mbrSession.brdt}">
						<c:set var="age">
							<fmt:formatDate value="${_mbrSession.brdt}" pattern="yyyy" />
						</c:set>
					</c:if>
					<input type="text" id="age" name="age" class="form-control w-full xs:max-w-50" value="${year - age}" maxlengh="3" <c:if test="${!empty _mbrSession.brdt}">readonly="true"</c:if>/>
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
				이로움ON의 파트너이며, <br> 다양한 사례를 경험한 재가센터, 복지용구사업소의 전문가를 통해 상담 서비스가 이뤄집니다.
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


$(function(){
	
	const telchk = /^([0-9]{2,3})?-([0-9]{3,4})?-([0-9]{3,4})$/;
	
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
			mblTelno : {required : true, regex : telchk},
			age : {required : true},
			zip : {required : true, min : 5},
			addr : {required : true},
			daddr : {required : true}
		},
		messages : {
			mbrNm : {required : "성명은 필수 입력 항목입니다."},
			mbrTelno : {required : "연락처는 필수 입력 항목입니다."},
			age : {required : "만 나이는 필수 입력 항목입니다."},
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
