<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<main id="container" class="is-product">
	<h2 id="page-title">가족회원 신청</h2>

	<div id="page-container">
		<div id="page-content">
			<div class="member-family">
				<ul class="member-tabs nav">
					<li><a href="#tab-form1" data-bs-toggle="pill" data-bs-target="#mbrIdFrm" class="active">아이디</a></li>
					<li><a href="#tab-form2" data-bs-toggle="pill" data-bs-target="#mblTelnoFrm">휴대폰번호</a></li>
					<li><a href="#tab-form3" data-bs-toggle="pill" data-bs-target="#tab-form3">이름 + 생년월일</a></li>
				</ul>

				<form class="member-family-item active" id="mbrIdFrm" name="mbrIdFrm" method="get" action="./app">
				<input type="hidden" name="sortBy" value="" />
					<fieldset>
						<legend>아이디로 찾기</legend>
						<p class="item-text">
							가족회원으로 신청할 회원의 <strong>아이디를 아는 경우</strong> 아이디를 입력해 주세요
						</p>
						<label for="mbrId">아이디</label>
						<input type="text" class="form-control" id="mbrId" name="mbrId" placeholder="아이디를 입력해주세요" maxlength="15"/>
						<button type="submit" class="btn btn-primary" id="srchIdBtn" disabled>검색</button>
					</fieldset>
				</form>

				<span class="member-family-liner"></span>

				<form class="member-family-item" id="mblTelnoFrm" name="mblTelnoFrm" method="get" action="./app">
				<input type="hidden" name="sortBy" value="" />
					<fieldset>
						<legend>휴대폰 번호로 찾기</legend>
						<p class="item-text">
							가족회원으로 신청할 회원의 <strong>휴대폰 번호</strong>로 검색하실 수 있습니다
						</p>
						<label for="mblTelno">휴대폰 번호</label>
						<input type="text" class="form-control" id="mblTelno" name="mblTelno" placeholder="-을 포함해주세요." maxlength="13" oninput="autoHyphen(this);"/>
						<button type="submit" class="btn btn-primary" id="srchMblTelnoBtn" disabled>검색</button>
					</fieldset>
				</form>

				<span class="member-family-liner"></span>

				<form class="member-family-item" id="mbrNmBrdtFrm" name="mbrNmBrdtFrm" method="get" action="./app">
				<input type="hidden" name="sortBy" value="" />
					<fieldset>
						<legend>이름 + 생년월일로 찾기</legend>
						<p class="item-text">
							가족회원으로 신청할 회원의 <strong>이름과 생년월일</strong>로 검색하실 수 있습니다
						</p>
						<label for="mbrNm">이름</label>
						<input type="text" class="form-control" name="mbrNm" id="mbrNm" placeholder="이름을 입력해주세요." />
						<label for="brdt">생년월일(8자리)</label>
						<input type="text" class="form-control" name="brdt" id="brdt" placeholder="-을 포함해주세요." />
						<button type="submit" class="btn btn-primary" id="srchNmBrdtBtn" disabled>검색</button>
					</fieldset>
				</form>
			</div>

			<c:if test="${srchList.size() > 0}">
				<div class="member-family-result">
					<div class="result-text">
						아이디로 검색한 회원입니다<br> 원하는 회원에게 <strong>가족회원으로 초대장을 보내세요</strong>
					</div>
					<div class="result-items">
						<c:forEach var="resultList" items="${srchList}" varStatus="status">
							<c:if test="${resultList.uniqueId eq _mbrSession.uniqueId}"><strong>본인에게는 초대 할수 없습니다.</strong></c:if>
							<c:if test="${resultList.uniqueId ne _mbrSession.uniqueId}">

							<div class="result-item">
								<div class="thumb">
									<img src="/comm/proflImg?fileName=${resultList.proflImg}" />
								</div>
								<div class="content">
									<dl>
										<dt>아이디</dt>
										<dd>${resultList.mbrId}</dd>
									</dl>
									<dl>
										<dt>이름</dt>
										<dd>${resultList.mbrNm}</dd>
									</dl>
									<dl>
										<dt>생년월일</dt>
										<dd><fmt:formatDate value="${resultList.brdt}" pattern="yyyy-MM-dd"/></dd>
									</dl>
								</div>
								<button type="button" class="button appFmlBtn" data-req-ty="${resultList.reqTy}" data-mbr-nm="${resultList.mbrNm}" data-mbr-id="${resultList.mbrId}" data-unique-id="${resultList.uniqueId}">
									<small>가족회원</small>
									<c:if test="${resultList.reqTy ne ''}"><strong>${reqTyCode[resultList.reqTy]}</strong></c:if>
									<c:if test="${resultList.reqTy eq null}"><strong>초대하기</strong></c:if>
								</button>
							</div>
							</c:if>
						</c:forEach>
					</div>
				</div>
			</c:if>

			<c:if test="${empty srchList && param.sortBy ne 'none'}">
				<div class="member-family-result">
					<div class="result-text">
						검색된 회원이 없습니다.<br> 다른 방법으로 시도해보세요
					</div>
				</div>
			</c:if>
		</div>
	</div>
</main>

<script>
$(function(){

	const telchk = /^([0-9]{2,3})?-([0-9]{3,4})?-([0-9]{3,4})$/;
	const numchk = /^([0-9]{8})$/;

	// 아이디 찾기 버튼
	$("#mbrId").on("keyup",function(){
		if($("#mbrId").val() != ''){
			$("#srchIdBtn").attr("disabled",false);
		}else{
			$("#srchIdBtn").attr("disabled",true);
		}
	});

	// 휴대폰 번호 찾기 버튼
	$("#mblTelno").on("keyup",function(){
		if($("#mblTelno").val() != ''){
			$("#srchMblTelnoBtn").attr("disabled",false);
		}else{
			$("#srchMblTelnoBtn").attr("disabled",true);
		}
	});

	// 휴대폰 번호 찾기 버튼
	$("#mbrNm,#brdt").on("keyup",function(){
		if($("#mbrNm").val() != '' && $("#brdt").val() != ''){
			$("#srchNmBrdtBtn").attr("disabled",false);
		}else{
			$("#srchNmBrdtBtn").attr("disabled",true);
		}
	});

	// 아이디 찾기 검사
	$("form#mbrIdFrm").validate({
		ignore: "input[type='text']:hidden",
		rules: {
			mbrId : {required : true, minlength : 6},
		},
		messages : {
			mbrId : {required : "! 아이디는 필수 입력 항목입니다.", minlength : "! 아이디는 6자 이상 입력해주세요."},
		},
	    submitHandler: function (frm) {
	    		frm.submit();
	    }

	});

	// 휴대폰 번호 찾기 검사
	$("form#mblTelnoFrm").validate({
		ignore: "input[type='text']:hidden",
		rules: {
			mblTelno : {regex : telchk},
		},
		messages : {
			mblTelno : {regex : "! 전화번호 형식이 잘못되었습니다.\n(000-0000-0000)"},
		},
	    submitHandler: function (frm) {
	    		frm.submit();
	    }

	});

	// 이름 + 생년월일 찾기 검사
	$("form#mbrNmBrdtFrm").validate({
		ignore: "input[type='text']:hidden",
		rules: {
			brdt : {regex : numchk}
		},
		messages : {
			brdt : {regex : "! 형식이 잘못되었습니다. \n(20000513)"}
		},
	    submitHandler: function (frm) {
	    		frm.submit();
	    }

	});

	// 가족회원 신청
	$(".appFmlBtn").on("click",function(){
		var unqId = $(this).data("uniqueId");
		var mbrId = $(this).data("mbrId");
		console.log(unqId);
		//초대하기 검사
		if($(this).data("reqTy") != ''){
			return false;
		}else{
			if(confirm("아이디 "+ $(this).data("mbrId") + " (" +$(this).data("mbrNm") + ") " + "님에게 가족회원으로 신청하시겠습니까?")){
				$.ajax({
					type : "post",
					url  : "/market/fml/registFml.json",
					data : {
						uniqueId : unqId
						},
					dataType : 'json'
				})
				.done(function(data) {
					if(data==true){
						location.href="/market/fml/appCnfm?mbrId="+ mbrId;
					}else{
						alert("가족회원은 자기 자신을 포함한 최대 5명입니다.");
						return false;
					}
				})
				.fail(function(data, status, err) {
					console.log(status + ' : 가족회원 초대 중 오류가 발생했습니다.');
				});
			}else{
				return false;
			}
		}
	});

});
</script>
