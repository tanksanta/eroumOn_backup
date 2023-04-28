<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<main id="container">
	<jsp:include page="../../layout/page_header.jsp">
		<jsp:param value="가족 회원 관리" name="pageTitle" />
	</jsp:include>

	<div id="page-container">

	<jsp:include page="../../layout/page_sidenav.jsp" />

		<div id="page-content">
			<div class="items-center justify-between md:flex">
				<div class="space-y-1.5">
					<p class="text-alert">가족회원은 본인을 포함하여 최대 5명 까지 관리 가능합니다.</p>
					<p class="text-alert">등록된 가족회원은 관계 설정 및 삭제가 가능합니다.</p>
					<p class="text-alert">가족회원 초대는 수신인이 승인 또는 거부할 수 있습니다.</p>
					<p class="text-alert">이로움ON 마켓에 가입된 회원 대상으로 휴대전화 또는 이메일 주소로 초대 발송이 가능합니다.</p>
				</div>
			</div>

			<form id="infoFrm" name="infoFrm" action="./action" method="post" class="mypage-family-send mt-4 md:mt-6">
				<div class="send-group">
					<div class="form-group">
						<label for="mblTelno" class="form-label">휴대폰 번호</label>
						<input type="text" id="mblTelno" name="mblTelno" class="form-control" oninput="autoHyphen(this);"/>
					</div>
					<!-- <div class="form-group">
						<label for="eml" class="form-label">이메일 주소</label>
						<input type="text" id="eml" name="eml" class="form-control" />
					</div> -->
				</div>
				<button type="submit" class="btn btn-primary">
					<img src="/html/page/market/assets/images/ico-mypage-family.svg" alt="">
					<span>가족회원<br> 초대장 보내기</span>
				</button>
			</form>

			<div class="mt-14 space-y-5 sm:mt-5 md:mt-7.5 md:space-y-7.5">
                <div class="mypage-family-item">
                    <div class="item-user">
                        <div class="thumb">
                            <p><c:if test="${_mbrSession.proflImg ne null }"><img src="/comm/proflImg?fileName=${_mbrSession.proflImg}" alt=""></c:if></p>
                            <span class="label-primary">
                                <span>본인</span>
                                <i></i>
                            </span>
                        </div>
                        <div class="info">
                            <dl>
                                <dt>회원 아이디</dt>
								<dd>${_mbrSession.mbrId}</dd>
                            </dl>
                            <dl>
                                <dt>회원명</dt>
								<dd>${_mbrSession.mbrNm}</dd>
                            </dl>
                            <dl>
                                <dt>연락처</dt>
								<dd>${_mbrSession.mblTelno}</dd>
                            </dl>
                        </div>
                    </div>
                    <div class="item-point">
                        <dl class="mileage">
                            <dt>잔여 마일리지</dt>
                            <dd><fmt:formatNumber value="${resultMap.mbrMlg}" pattern="###,###" /></dd>
                        </dl>
                        <dl class="point">
                            <dt>잔여 포인트</dt>
                            <dd><fmt:formatNumber value="${resultMap.mbrPoint}" pattern="###,###" /></dd>
                        </dl>
                    </div>
                </div>
				<c:forEach var="familyList" items="${infoList}" varStatus="status">
				<c:if test="${familyList.reqTy eq 'F' }">
                <div class="mypage-family-item">
                    <button type="button" class="item-delete delFml" data-fml-nm="${familyList.mbrNm}" data-unique-id="${familyList.uniqueId}" data-prtcr-id="${familyList.prtcrUniqueId}" data-btn-ty="del">회원 삭제</button>
                    <div class="item-user">
                        <div class="thumb">
                            <p><c:if test="${familyList.proflImg ne null }"><img src="/comm/PROFL/getFile?fileName=${familyList.proflImg}" alt=""></c:if></p>
                        </div>
                        <div class="info">
                            <dl>
                                <dt>회원 아이디</dt>
								<dd>${familyList.mbrId}</dd>
                            </dl>
                            <dl>
                                <dt>회원명</dt>
								<dd>${familyList.mbrNm}</dd>
                            </dl>
                            <dl>
                                <dt>연락처</dt>
                                <input type="hidden" name="mblTelnos" value="${familyList.mblTelno}" />
								<dd>${familyList.mblTelno}</dd>
                            </dl>
                        </div>
                    </div>
                 			<div class="item-relative">
						<select name="updRel" class="form-control form-small">
							<c:forEach var="updRel" items="${prtcrRltCode}">
							<option value="${updRel.key}"<c:if test="${familyList.prtcrRlt eq updRel.key}">selected="selected"</c:if>>
								${updRel.value}
							</option>
							</c:forEach>
						</select>
						<input type="text" name="updateEtc" id="updateEtc${familyList.prtcrMbrNo}" value="${familyList.rltEtc}" class="form-control form-small" <c:if test="${familyList.prtcrRlt ne 'E' }">style="display:none;"</c:if> />
						<c:if test="${familyList.prtcrRlt ne 'E'}"><button type="button" class="btn btn-primary btn-small appBtn" data-prtcr-no="${familyList.prtcrMbrNo}" data-prtcr-rel="${familyList.prtcrRlt}" data-app-ty="modify" data-unique-id="${familyList.uniqueId}">변경사항 적용</button></c:if>
						<c:if test="${familyList.prtcrRlt eq 'E'}"><button type="button" class="btn btn-primary btn-small appBtn" data-prtcr-no="${familyList.prtcrMbrNo}" data-prtcr-rel="${familyList.prtcrRlt}" data-app-ty="modify" data-unique-id="${familyList.uniqueId}">변경사항 적용</button></c:if>
                 			</div>
                    <div class="item-point">
                        <dl class="mileage">
                            <dt>잔여 마일리지</dt>
                            <dd><fmt:formatNumber value="${familyList.mbrMlg}" pattern="###,###" /></dd>
                        </dl>
                        <dl class="point">
                            <dt>잔여 포인트</dt>
                            <dd><fmt:formatNumber value="${familyList.mbrPoint}" pattern="###,###" /></dd>
                        </dl>
                    </div>
                </div>
				</c:if>
				<c:if test="${familyList.reqTy eq 'P' }">
                <div class="mypage-family-item is-relative">
                    <button type="button" class="item-delete delFml" data-fml-nm="${familyList.mbrNm}" data-unique-id="${familyList.uniqueId}" data-prtcr-id="${familyList.prtcrUniqueId}" data-btn-ty="cancel">회원 삭제</button>
                    <div class="item-user">
                        <div class="thumb">
                            <p><c:if test="${familyList.proflImg ne null }"><img src="/comm/PROFL/getFile?fileName=${familyList.proflImg}" alt=""></c:if></p>
                        </div>
                        <div class="info">
                            <dl>
                                <dt>회원 아이디</dt>
								<dd>${familyList.mbrId}</dd>
                            </dl>
                            <dl>
                                <dt>회원명</dt>
								<dd>${familyList.mbrNm}</dd>
                            </dl>
                            <dl>
                                <dt>연락처</dt>
                                <input type="hidden" name="mblTelnos" value="${familyList.mblTelno}" />
								<dd>${familyList.mblTelno}</dd>
                            </dl>
                        </div>
                    </div>
                    <div class="item-apply">
						<c:if test="${familyList.appTy eq 'rcve'}" >
						<select name="prtcrRlt" class="form-control form-small" id="prtcrRlt${familyList.prtcrMbrNo}">
							<option value="none">선택</option>
							<c:forEach var="rel" items="${prtcrRltCode}">
							<option value="${rel.key}">${rel.value}</option>
							</c:forEach>
						</select>
						<input type="text" id="etc${familyList.prtcrMbrNo}" name="etc" class="form-control form-small" style="display:none;"/>
						<button type="button" class="btn btn-success btn-small appBtn" data-prtcr-no="${familyList.prtcrMbrNo}" data-app-ty="app" data-prtcr-rel="" data-unique-id="${familyList.uniqueId}">승인</button>
						<button type="button" class="btn btn-outline-danger btn-small appBtn" data-prtcr-no="${familyList.prtcrMbrNo}" data-app-ty="den" data-prtcr-rel="" data-unique-id="${familyList.uniqueId}">거부</button>
						</c:if>
						<c:if test="${familyList.appTy eq 'send'}" >
                        <span class="btn btn-primary btn-small pointer-events-none">대기중</span>
						</c:if>
                    </div>
                </div>
				</c:if>
				</c:forEach>
			</div>
		</div>
	</div>
</main>

<script>
$(function(){
	//정규식
	const emailchk = /^[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*.[a-zA-Z]{2,3}$/i;
	const telchk = /^([0-9]{2,3})?-([0-9]{3,4})?-([0-9]{3,4})$/;

	//관계 설정
	$("select[name='prtcrRlt']").on("change",function(){
		$(".appBtn").data("prtcrRel",$(this).val());
		var obj = $(this).next();
		if($(this).val() == "E"){
			obj.show();
		}else{
			obj.hide();
		}
	});

	//승인 && 거부 && 변경
	$(".appBtn").on("click",function(){
		var prNo = $(this).data("prtcrNo");
		var appTy = $(this).data("appTy");
		var text = $(this).text();
		var rel = $(this).data("prtcrRel");
		var etc = $(this).prev().val();
		var uniqueId = $(this).data("uniqueId");

		//승인 , 거부 체크
		if(appTy == "app" && $("#prtcrRlt"+prNo).val() == "none"){
			alert("관계를 선택해주세요.");
			return false;
		}

		//기타 체크
		if(appTy == "app" && $("#prtcrRlt"+prNo).val() == "E" && $("#etc"+prNo).val() == ''){
			alert("기타 관계는 필수 입력 사항입니다.");
			return false;
		}

		if(confirm(text + "하시겠습니까?")){
			$.ajax({
				type : "post",
				url  : "/market/mypage/fam/appFam.json",
				data : {
					prtcrMbrNo : prNo
					, appType : appTy
					, prtcrRel : rel
					, rltEtc : etc
					, uniqueId : uniqueId
					},

				dataType : 'json'
			})
			.done(function(data) {
				if(data.result == true){
					alert(text + "되었습니다.");
					location.reload();
				}else{
					alert("정보 업데이트 중 오류가 발생하였습니다 \n 관리자에게 문의 바랍니다.");
				}
			})
			.fail(function(data, status, err) {
				console.log(status + ' : 가족회원 승인 업데이트 중 오류가 발생했습니다.');
			});
		}else{
			return false;
		}


	});

	//관계 변경
	$("select[name='updRel']").on("change",function(){
		var obJj = $(this).next().next();
		if($(this).val() != "E"){
			$("#updateEtc"+obJj.data("prtcrNo")).hide();
			$("#updateEtc"+obJj.data("prtcrNo")).val('');
		}else{
			$("#updateEtc"+obJj.data("prtcrNo")).show();
		}
		var obj = $(this).next().next();
		obj.data("prtcrRel",$(this).val());
	});


	//초대장 체크
   	$.validator.addMethod("paramChk", function(value, element) {
   		if($("#mblTelno").val() != '' || $("#eml").val() != ''){
   			return true;
   		}else{
   			return false;
   		}
   	});

  //가족회원 체크
   	$.validator.addMethod("prtcrChk", function(value, element) {
   		var existFlag = false;
   		$("input[name='mblTelnos']").each(function(){
   			console.log($(this).val());
   			console.log($("#mblTelno").val());
   			if($(this).val() == $("#mblTelno").val()){
   				existFlag = true;
   			}
   		});

   		if(existFlag){
   			return false;
   		}else{
   			return true;
   		}
   	}, "이미 처리된 가족회원입니다.");

	//가족회원 초대장 보내기
	$("form#infoFrm").validate({
	    ignore: "input[type='text']:hidden",
	    rules : {
	    	mblTelno : {regex : telchk, required : true, prtcrChk : true}
	    	, eml : {paramChk : true , regex : emailchk}
	    },
	    messages : {
	    	mblTelno : {regex : "! 전화번호 형식이 잘못되었습니다.\n(000-0000-0000)", required : "! 휴대폰 번호는 필수 입력 항목입니다."}
	    	, eml : {paramChk : "! 이메일 또는 휴대폰 번호는 필수 입력 항목입니다." ,regex : "! 이메일 형식이 잘못되었습니다.\n(abc@def.com)"}
	    },
	    errorElement:"div",
	    errorPlacement: function(error, element) {
		    var group = element.closest('.form-group');
		    if (group.length) {
		        group.after(error.addClass('text-danger'));
		    } else {
		        element.after(error.addClass('text-danger'));
		    }
		},
	    submitHandler: function (frm) {
	    	if(confirm("초대장을 보내시겠습니까?")){
	    		frm.submit();
	    	}else{
	    		return false;
	    	}
	    }
	});

	// 가족회원 삭제
	$(".delFml").on("click",function(){
		var nm = $(this).data("fmlNm");
		var uniqueId = $(this).data("uniqueId");
		var prtcrUniqueId = $(this).data("prtcrId");
		var btnType = $(this).data("btnTy");
		var msgs = "신청을 취소하시겠습니까?";

		console.log("asd" + uniqueId);

		if(btnType == "del"){
			msgs = nm + "님을 가족회원에서 제외하시겠습니까?";
		}

		if(confirm(msgs)){
			$.ajax({
				type : "post",
				url  : "/market/mypage/fam/excludeFml.json",
				data : {
					paramUniqueId : uniqueId
					, paramPrtcrId : prtcrUniqueId
					},
				dataType : 'json'
			})
			.done(function(data) {
				if(data.result == true){
					alert("삭제 되었습니다.");
					location.reload();
				}else{
					alert("가족 회원 삭제 중 오류가 발생하였습니다 \n 관리자에게 문의 바랍니다.");
				}
			})
			.fail(function(data, status, err) {
				console.log(status + ' : 가족회원 삭제 처리 중 오류가 발생했습니다.');
			});
		}else{
			return false;
		}


	});

});
</script>