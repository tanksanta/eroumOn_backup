<%@page import="javax.servlet.annotation.WebServlet"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<script src="/html/page/admin/assets/script/_mng/mbr/JsHouseMngMbrDetail.js"></script>

<div id="page-content">
	<%@include file="./include/header.jsp"%>

	<div class="text-right mt-6">
		<button type="button" class="btn shadow" id="sendPw">임시비밀번호 발송</button>
	</div>

	<form:form action="./action" class="mt-2" modelAttribute="mbrVO" method="post" id="mbrViewFrm" name="mbrViewFrm">
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
						<th scope="row">회원분류</th>
						<td class="recipterVal">${recipter[mbrVO.recipterYn]}</td>

						<th scope="row">회원등급</th>
						<td>
							<select name="mbrGrade" id="mbrGrade" class="form-control w-45" <c:if test="${_mngrSession.authrtTy ne '1'}">readonly=true</c:if>>
								<c:forEach var="grade" items="${mberGrade}">
									<option value="${grade.key}" <c:if test="${grade.key eq mbrVO.mberGrade}">selected="selected"</c:if>>${grade.value}</option>
								</c:forEach>
							</select>
							<c:if test="${_mngrSession.authrtTy eq '1'}">
								<button type="button" class="btn-small btn-primary f_chg_grade">변경</button>
							</c:if>
						</td>
					</tr>
					<tr>
						<th scope="row">회원아이디</th>
						<td>${mbrVO.mbrId}</td>
						
						<th scope="row">가입유형</th>
						<td>${mbrJoinTy3[mbrVO.joinTy]}</td>
					</tr>
					<tr>
						<th scope="row">이름/생년월일/성별</th>
						<td class="nameVal">${mbrVO.mbrNm }/ <fmt:formatDate value="${mbrVO.brdt}" pattern="yyyy-MM-dd" /> / ${gender[mbrVO.gender] }

						<th scope="row">휴대폰 번호</th>
						<td>${mbrVO.mblTelno}</td>
					</td>

					</tr>
					<tr>
						<th scope="row">이메일</th>
						<td>${mbrVO.eml}</td>

						<th scope="row">가입매체 / 가입일</th>
						<td class="joinVal">${joinCours[mbrVO.joinCours] }/ <fmt:formatDate value="${mbrVO.joinDt }" pattern="yyyy-MM-dd HH:mm:ss" /></td>
					</tr>
					<tr>
						<th scope="row">주소</th>
						<td>${mbrVO.zip }&nbsp;${mbrVO.addr }&nbsp; ${mbrVO.daddr }</td>

						<th scope="row">등록수급자수</th>
						<td class="joinVal">${mbrVO.mbrRecipientsList.size()}</td>
					</tr>
					<tr>
						<th scope="row">최근접속일</th>
						<td><fmt:formatDate value="${mbrVO.recentCntnDt}" pattern="yyyy-MM-dd HH:mm:ss" /></td>
						
						<th scope="row">최종변경일 / 처리자</th>
						<td>
							<c:if test="${mbrVO.mdfr ne null}">
								<fmt:formatDate value="${mbrVO.mdfcnDt}" pattern="yyyy-MM-dd HH:mm:ss"/> / ${mbrVO.mdfr}
							</c:if>
						</td>
					</tr>
					<tr>
						<th scope="row">
							이용약관<br>
							개인정보처리방침<br>
							개인정보동의<br>
							제3자제공동의<br>
						</th>
						<td>
							${mbrAgreementVO == null ? "비동의" : (mbrAgreementVO.termsYn == "Y" ? "동의" : "비동의")}&nbsp;<fmt:formatDate value="${mbrAgreementVO == null ? '' : mbrAgreementVO.termsDt}" pattern="yyMMdd HH:mm:ss"/><br>
							${mbrAgreementVO == null ? "비동의" : (mbrAgreementVO.privacyYn == "Y" ? "동의" : "비동의")}&nbsp;<fmt:formatDate value="${mbrAgreementVO == null ? '' : mbrAgreementVO.privacyDt}" pattern="yyMMdd HH:mm:ss"/><br>
							${mbrAgreementVO == null ? "비동의" : (mbrAgreementVO.provisionYn == "Y" ? "동의" : "비동의")}&nbsp;<fmt:formatDate value="${mbrAgreementVO == null ? '' : mbrAgreementVO.provisionDt}" pattern="yyMMdd HH:mm:ss"/><br>
							${mbrAgreementVO == null ? "비동의" : (mbrAgreementVO.thirdPartiesYn == "Y" ? "동의" : "비동의")}&nbsp;<fmt:formatDate value="${mbrAgreementVO == null ? '' : mbrAgreementVO.thirdPartiesDt}" pattern="yyMMdd HH:mm:ss"/><br>
						</td>
					</tr>
					<tr>
						<th scope="row">개인정보 유효기간</th>
						<td colspan="3">
							<div class="form-check-group w-90">
								<c:forEach var="expiration" items="${expiration}" varStatus="status">
									<div class="form-check">
										<input class="form-check-input prvcVal" type="radio" name="expiration" id="expiration${status.index}" value="${expiration.key}" <c:if test="${expiration.key eq mbrVO.prvcVldPd }">checked="checked"</c:if> disabled>
										<label class="form-check-label" for="expiration${status.index}">${expiration.value}</label>
									</div>
								</c:forEach>
							</div>
						</td>
					</tr>
				</tbody>
			</table>
		</fieldset>

		<fieldset class="mt-13">
			<legend class="text-title2">선택정보</legend>
			<table class="table-detail">
				<colgroup>
					<col class="w-43">
					<col>
					<col class="w-43">
					<col>
				</colgroup>
				<tbody>
					<tr>
						<th scope="row">정보수신</th>
						<td colspan="2">
							<div class="flex flex-wrap -mx-2">
								<div class="form-group px-2 my-1 mr-auto">
									<label for="member-item2-1" class="pr-1">문자 수신</label>
									<div class="form-check">
										<input type="checkbox" class="form-check-input choiceVal" name="smsRcptnYn" id="smsRcptnYn" value="${mbrVO.smsRcptnYn}" <c:if test="${mbrVO.smsRcptnYn eq 'Y' }">checked="checked"</c:if>> <label class="form-check-label" for="smsRcptnYn"></label>
									</div>

									<label for="member-item2-1" class="pr-1">이메일 수신</label>
									<div class="form-check">
										<input type="checkbox" class="form-check-input choiceVal" name="emlRcptnYn" id="emlRcptnYn" value="${mbrVO.emlRcptnYn}" <c:if test="${mbrVO.emlRcptnYn eq 'Y' }">checked="checked"</c:if>> <label class="form-check-label" for="emlRcptnYn"></label>
									</div>

									<label for="member-item2-1" class="pr-1">전화 수신</label>
									<div class="form-check">
										<input type="checkbox" class="form-check-input choiceVal" name="telRecptnYn" id="telRecptnYn" value="${mbrVO.telRecptnYn}" <c:if test="${mbrVO.telRecptnYn eq 'Y' }">checked="checked"</c:if>> <label class="form-check-label" for="telRecptnYn"></label>
									</div>
								</div>
							</div>
						</td>
						
						<th scope="row">
							문자 수신<br>
							이메일 수신<br>
							전화 수신<br>
						</th>
						<td>
							${mbrVO.smsRcptnYn == 'Y' ? '동의' : '비동의'}&nbsp;<fmt:formatDate value="${mbrVO.smsRcptnDt == null ? '' : mbrVO.smsRcptnDt}" pattern="yyMMdd HH:mm:ss"/><br>
							${mbrVO.emlRcptnYn == 'Y' ? '동의' : '비동의'}&nbsp;<fmt:formatDate value="${mbrVO.emlRcptnDt == null ? '' : mbrVO.emlRcptnDt}" pattern="yyMMdd HH:mm:ss"/><br>
							${mbrVO.telRecptnYn == 'Y' ? '동의' : '비동의'}&nbsp;<fmt:formatDate value="${mbrVO.telRecptnDt == null ? '' : mbrVO.telRecptnDt}" pattern="yyMMdd HH:mm:ss"/><br>
						</td>
					</tr>
				</tbody>
			</table>
		</fieldset>

		<div class="btn-group mt-8">
			<a href="/_mng/mbr/list" class="btn-primary large shadow w-52 btn list">목록</a>
		</div>
	</form:form>

	<!-- 경고관리 -->

	<div class="offcanvas offcanvas-end w-95" tabindex="-1" id="offcanvas1">
		<div class="offcanvas-header">
			<p>경고관리</p>
		</div>
		<div class="offcanvas-body">
			<form name="warningFrm" id="warningFrm" action="#" method="get">
				<input type="hidden" name="uniqueId" id="uniqueId" value="${mbrVO.uniqueId}"> <input type="hidden" name="mngTy" id="mngTyW" value="WARNING">
				<fieldset>
					<label for="modal-item1-1" class="block font-bold mb-2">구분<span class="require"></span></label>
					<div class="form-check-group w-full">
						<c:forEach var="result" items="${mngSeWarning}" varStatus="status">
							<div class="form-check">
								<input type="radio" class="form-check-input" name="mngSe" id="mngSe${status.index}" value="${result.key}" /> <label class="form-check-label" for="mngSe${status.index}">${result.value}</label>
							</div>
						</c:forEach>
					</div>

					<label for="resnCd" class="block font-bold mt-5 mb-2">사유선택<span class="require"></span></label>
					<div class="form-group w-full">
						<select name="resnCd" id="resnCd" class="form-control w-full">
							<option value="">선택</option>
							<option class="resnCdOnlyValue" value="CS" style="display:none;">고객 요청</option>
							<option class="resnCdOnlyValue" value="ETC" style="display:none;">기타</option>
							<c:forEach var="result" items="${resnCd}" varStatus="status">
								<option class="resnCdValue" value="${result.key }">${result.value}</option>
							</c:forEach>
						</select>
					</div>
					<label for="modal-item1-3" class="block font-bold mt-5 mb-2">관리자 메모</label>
					<textarea name="mngrMemo" id="mngrMemo" cols="30" rows="7" class="form-control w-full"></textarea>

					<div class="flex mt-6">
						<button type="submit" class="btn-primary large shadow flex-1 mr-2">저장</button>
						<button type="button" id="warningCancel" data-bs-dismiss="offcanvas" class="btn-secondary large shadow w-25">취소</button>
					</div>
				</fieldset>
			</form>
		</div>
		<button type="button" data-bs-dismiss="offcanvas" class="offcanvas-close">닫기</button>
	</div>
	<!-- //경고관리 -->

	<!-- 블랙리스트 관리 -->
	<div class="offcanvas offcanvas-end w-95" tabindex="-1" id="offcanvas2">
		<div class="offcanvas-header">
			<p>블랙리스트관리</p>
		</div>
		<div class="offcanvas-body">
			<form action="#" id="blackFrm" name="blackFrm" method="get">
				<input type="hidden" name="mngTy" id="mngTyB" value="BLACK">
				<fieldset>
					<label for="modal-item2-1" class="block font-bold mb-2">구분</label>
					<div class="form-check-group w-full whitespace-nowrap">
						<c:forEach var="result" items="${mngSeBlack}" varStatus="status">
							<div class="form-check">
								<input type="radio" class="form-check-input" name="mngSeBlack" id="mngSeBlack${status.index}" value="${result.key}" /> <label class="form-check-label" for="mngSeBlack${status.index}">${result.value}</label>
							</div>
						</c:forEach>
					</div>

					<div class="dateView" style="display: none;">
						<label for="modal-item2-3" class="block font-bold mt-5 mb-2">정지기간</label>
						<div class="form-group">
							<input type="date" class="form-control flex-1 calendar" id="stopBgngYmd" name="stopBgngYmd"> <i>~</i> <input type="date" class="form-control flex-1 calendar" id="stopEndYmd" name="stopEndYmd">
						</div>
					</div>

					<label for="blackResnCd" class="block font-bold mt-5 mb-2">사유선택</label>
					<div class="form-group w-full">
						<select name="blackResnCd" id="blackResnCd" class="form-control w-full">
							<option value="">선택하세요</option>
							<option class="itemcnOnlyValue" value="CS" style="display:none;">고객 요청</option>
							<option class="itemcnOnlyValue" value="ETC" style="display:none;">기타</option>
							<c:forEach var="itemcn" items="${blackResnCd}">
								<option class="itemcnValue" value="${itemcn.key}">${itemcn.value }</option>
							</c:forEach>
						</select>
					</div>

					<label for="mngrMemoBlack" class="block font-bold mt-5 mb-2">관리자 메모</label>
					<textarea name="mngrMemoBlack" id="mngrMemoBlack" cols="30" rows="7" class="form-control w-full"></textarea>

					<div class="flex mt-6">
						<button type="submit" class="btn-primary large shadow flex-1 mr-2">저장</button>
						<button type="button" id="blackCancel" data-bs-dismiss="offcanvas" class="btn-secondary large shadow w-25">취소</button>
					</div>
				</fieldset>
			</form>
		</div>
		<button type="button" data-bs-dismiss="offcanvas" class="offcanvas-close">닫기</button>
	</div>
	<!-- //블랙리스트 관리 -->

	<!-- 직권탈퇴 -->
	<div class="offcanvas offcanvas-end w-95" tabindex="-1" id="offcanvas3">
		<div class="offcanvas-header">
			<p>직권탈퇴 관리</p>
		</div>
		<div class="offcanvas-body">
			<form action="#" id="authFrm" name="authFrm" method="get">
				<input type="hidden" name="mngTy" id="mngTyA" value="AUTH">
				<fieldset>
					<label for="modal-item3-1" class="block font-bold mt-5 mb-2">사유선택</label>
					<div class="form-group w-full">
						<select name="authResnCd" id="authResnCd" class="form-control w-full">
							<option value="">선택하세요</option>
							<c:forEach var="auth" items="${authResnCd}" varStatus="status">
								<option value="${auth.key}">${auth.value}</option>
							</c:forEach>
						</select>
					</div>

					<div class="textareaView" style="display: none;">
						<label for="modal-item3-2" class="block font-bold mt-5 mb-2">사유입력</label>
						<textarea name="mngrMemo" id="authMngrMemo" cols="30" rows="5" class="form-control w-full"></textarea>
					</div>

					<div class="flex mt-6">
						<button type="submit" class="btn-primary large shadow flex-1 mr-2">저장</button>
						<button type="button" id="authCancel" data-bs-dismiss="offcanvas" class="btn-secondary large shadow w-25">취소</button>
					</div>
				</fieldset>
			</form>
		</div>
		<button type="button" data-bs-dismiss="offcanvas" class="offcanvas-close">닫기</button>
	</div>
	<!-- //직권탈퇴 -->

	<div id="modifyList"></div>
</div>

<script>
	var ctlMaster;
	$(document).ready(function(){
		ctlMaster = new JsHouseMngMbrView();
		ctlMaster.fn_searched_data(`<%= request.getParameter("searched_data") != null ? request.getParameter("searched_data") : "" %>`); 
		ctlMaster.fn_page_init();
	});

	$(function() {
		// 경고관리 해제 시 벨류 체인지
		$("input[name='mngSe']").on("click",function(){
			if($("#mngSe3").is(":checked")){
				$(".resnCdValue").hide();
				$(".resnCdOnlyValue").show();
			}else{
				$(".resnCdValue").show();
				$(".resnCdOnlyValue").hide();
			}

		});

		//경고관리 유효성 검사
		$("form[name='warningFrm']").validate({
			ignore : "input[type='text']:hidden",
			rules : {
				mngSe : {
					required : true
				},
				resnCd : {
					required : true
				}
			},
			messages : {
				mngSe : {
					required : "구분은 필수 선택 항목입니다."
				},
				resnCd : {
					required : "사유선택은 필수 입력 항목입니다."
				}
			},
			submitHandler : function(frm) {
				if (confirm("저장하시겠습니까?")) {
					$.ajax({
						type : "post",
						url : "manageInfo.json",
						data : {
							mngTy : $("#mngTyW").val(),
							mngSe : $('input[name="mngSe"]:checked').val(),
							resnCd : $("#resnCd").val(),
							mngrMemo : $("#mngrMemo").val()
						},
						dataType : 'json'
					}).done(function(data) {
						alert("저장되었습니다.");
						frm.submit();
					}).fail(function(data, status, err) {
						alert("경고관리 등록 중 오류가 발생했습니다.");
						console.log('error forward : ' + data);
					});
				} else {
					return false;
				}
			}
		});

		//날짜 시작일 < 마감일 체크
		$.validator.addMethod("SizeValidate", function(value, element) {
			var bgng = $("#stopBgngYmd").val();
			var end = $("#stopEndYmd").val();
			if (end < bgng) {
				return false;
			} else {
				return true;
			}
		}, "기간을 확인해주세요.");

		//날짜, 시간 체크 추가 유효성 검사 메소드
		$.validator.addMethod("dtValidate", function(value, element) {
			var arrDate = [];
			arrDate.push($("#stopBgngYmd").val() == "");
			arrDate.push($("#stopEndYmd").val() == "");
			if (arrDate.includes(true)) {
				return false;
			} else {
				return true;
			}
		}, "항목을 입력해주세요.");

		//일시정지 > 날짜 체크
		$.validator.addMethod("pauseValidate", function(value, element) {
			if ($("#mngSeBlack0").is(":checked")) {
				var arrDate = [];
				arrDate.push($("#stopBgngYmd").val() == "");
				arrDate.push($("#stopEndYmd").val() == "");
				if (arrDate.includes(true)) {
					return false;
				} else {
					var bgng = $("#stopBgngYmd").val();
					var end = $("#stopEndYmd").val();
					if (end < bgng) {
						return false;
					} else {
						return true;
					}
				}
			} else {
				return true;
			}
		}, "기간을 확인해주세요.");

		//블랙리스트 유효성 검사
		$("form[name='blackFrm']")	.validate({
			ignore : "input[type='text']:hidden",
			rules : {
				mngSeBlack : {	required : true},
				stopBgngYmd : {pauseValidate : true},
				blackResnCd : {required : true}
				},
				messages : {
					mngSeBlack : {	required : "구분은 필수 선택 항목입니다."},
					blackResnCd : {required : "사유선택은 필수 입력 항목입니다."}
					},
				submitHandler : function(frm) {
					if (confirm("저장하시겠습니까?")) {
						$.ajax({
							type : "post",
							url : "manageInfo.json",
							data : {
								mngTy : $("#mngTyB")	.val(),
								mngSe : $('input[name="mngSeBlack"]:checked')	.val(),
								resnCd : $("#blackResnCd").val(),
								mngrMemo : $("#mngrMemoBlack")	.val(),
								bgng : $("#stopBgngYmd").val(),
								end : $("#stopEndYmd").val()
								},
							dataType : 'json'
							})
							.done(function(data) {
								alert("저장되었습니다.");
								frm.submit();
							})
							.fail(function(data, status, err) {
								alert("블랙리스트 등록 중 오류가 발생했습니다.");
								console.log('error forward : '+ data);
							});
						} else {
							return false;
							}
					}
			});

		//블랙리스트 팝업
		$("#mngSeBlack0").on("click", function() {
			$(".dateView").css({	"display" : ""});
		});
		$("#mngSeBlack1").on("click", function() {
			$(".dateView").css({	"display" : "none"});
		});
		$("#mngSeBlack2").on("click", function() {
			$(".dateView").css({	"display" : "none"});
		});

		// 블랙리스트 해제 시 벨류 체인지
		$("input[name='mngSeBlack']").on("click",function(){
			if($("#mngSeBlack2").is(":checked")){
				$(".itemcnValue").hide();
				$(".itemcnOnlyValue").show();
			}else{
				$(".itemcnValue").show();
				$(".itemcnOnlyValue").hide();
			}

		});


		//직권탈퇴 유효성 검사
		$("form[name='authFrm']").validate({
			ignore : "input[type='text']:hidden",
			rules : {
				authResnCd : {
					required : true
				}
			//authMngrMemo : {required : true}
			},
			messages : {
				authResnCd : {
					required : "사유는 필수 선택 항목입니다."
				}
			//authMngrMemo : {required : "사유선택은 필수 입력 항목입니다."}
			},
			submitHandler : function(frm) {
				if (confirm("저장하시겠습니까?")) {
					$.ajax({
						type : "post",
						url : "manageInfo.json",
						data : {
							uniqueId : $("#uniqueIdA").val(),
							mngTy : $("#mngTyA").val(),
							resnCd : $("#authResnCd").val(),
							mngrMemo : $("#authMngrMemo").val()
						},
						dataType : 'json'
					}).done(function(data) {
						alert("저장되었습니다.");
						location.href = "/_mng/mbr/list";
					}).fail(function(data, status, err) {
						alert("직권탈퇴 등록 중 오류가 발생했습니다.");
						console.log('error forward : ' + data);
					});
				} else {
					return false;
				}
			}
		});

		//직권탈퇴 사유입력
		$("#authResnCd").on("click", function() {
			if ($("#authResnCd").val() === "SELF") {
				$(".textareaView").css({"display" : ""});
			} else {
				$(".textareaView").css({"display" : "none"	});
			}
		});

		// 선택 정보
		$(".choiceVal").on("click", function() {
			if(confirm("변경하시겠습니까?")){
				if ($(this).is(":checked")) {
					$(this).attr("value", "Y");
				} else {
					$(this).attr("value", "N");
				}
				$.ajax({
					type : "post",
					url : "choice.json",
					data : {
						uniqueId : $("#uniqueId").val(),
						smsYn : $("#smsRcptnYn").val(),
						emlYn : $("#emlRcptnYn").val(),
						telYn : $("#telRecptnYn").val()
					},
					dataType : 'json'
				}).done(function(data) {
					alert("저장되었습니다.");
				}).fail(function(data, status, err) {
					alert("정보변경 중 오류가 발생했습니다.");
					console.log('error forward : ' + data);
				});
			}else{
				return false;
			}

		});

		//개인정보 유효기간
		// $(".prvcVal").on("click", function() {
		// 	if(confirm("변경하시겠습니까?")){
		// 		$.ajax({
		// 			type : "post",
		// 			url : '/_mng/mbr/' + $("#uniqueId").val() + '/prvc.json',
		// 			data : {
		// 				uniqueId : $("#uniqueId").val(),
		// 				prvc : $('input[name=expiration]:checked').val()
		// 			},
		// 			dataType : 'json'
		// 		}).done(function(data) {
		// 			alert("저장되었습니다.");
		// 		}).fail(function(data, status, err) {
		// 			alert("정보변경 중 오류가 발생했습니다.");
		// 			console.log('error forward : ' + data);
		// 		});
		// 	}else{
		// 		return false;
		// 	}
		// });

		 //변경내역
		 $("#changeListBtn").on("click",function(){
			 var uniqueId = $(this).data("uniqueId");

			 $("#modifyList").load("/_mng/mbr/black/mbrMngInfoList.json", {uniqueId : uniqueId}, function(){
					$("#modal1").addClass("fade").modal("show");
				});
		 });

		 // 임시 비밀번호
		 $("#sendPw").on("click",function(){
				$.ajax({
					type : "post",
					url : '/_mng/mbr/' + $("#uniqueId").val() + '/sendPw.json',
					data : {
						uniqueId : $("#uniqueId").val(),
						prvc : $('input[name=expiration]:checked').val()
					},
					dataType : 'json'
				}).done(function(data) {
					if(data.result){
						alert("발송되었습니다.");
					}else{
						alert("이메일 발송 중 오류가 발생하였습니다.");
					}
				}).fail(function(data, status, err) {
					alert("이메일발송 중 오류가 발생했습니다.");
					console.log('error forward : ' + data);
				});
		 });

		 // 회원 등급
		 $(".f_chg_grade").on("click",function(){
			 let mbrGrade = "${mbrVO.mberGrade}";

			 if(confirm("회원 등급을 변경하시겠습니까?")){
				 $.ajax({
					type : "post",
					url : '/_mng/mbr/' + $("#uniqueId").val() + '/chgGrade.json',
					data : {
						mberGrade : $("#mbrGrade").val()
					},
					dataType : 'json'
				}).done(function(data) {
					if(data.result){
						alert("변경되었습니다.");
					}else{
						alert("회원 등급 처리 중 오류가 발생하였습니다.");
					}
				}).fail(function(data, status, err) {
					console.log('error forward : ' + data);
				});
			 }else{
				 $("#mbrGrade").val(mbrGrade);
				 return false;
			 }
		 });

	});
</script>


