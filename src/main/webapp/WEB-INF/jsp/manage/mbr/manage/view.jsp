<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
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
						<th scope="row">회원분류 / 회원등급</th>
						<td class="recipterVal">${recipter[mbrVO.recipterYn]}&nbsp;&nbsp; <span class="badge-primary">${mberGrade[mbrVO.mberGrade]}</span>
						</td>
						<th scope="row">가족회원 여부</th>
						<td>${fmlCount > 0 ? '가족회원' : '일반회원' }</td>
					</tr>
					<tr>
						<th scope="row">아이디</th>
						<td>${mbrVO.mbrId}</td>
						<th scope="row">휴대폰 번호</th>
						<td>${mbrVO.mblTelno}</td>
					</tr>
					<tr>
						<th scope="row">이름/생년월일/성별</th>
						<td class="nameVal">${mbrVO.mbrNm }/ <fmt:formatDate value="${mbrVO.brdt }" pattern="yyyy-MM-dd" /> / ${gender[mbrVO.gender] }
						</td>

						<th scope="row">가입매체 / 가입일</th>
						<td class="joinVal">${joinCours[mbrVO.joinCours] }/ <fmt:formatDate value="${mbrVO.joinDt }" pattern="yyyy-MM-dd HH:mm:ss" /></td>
					</tr>
					<tr>
						<th scope="row">이메일</th>
						<td colspan="3">${mbrVO.eml }</td>
					</tr>
					<tr>
						<th scope="row">주소</th>
						<td colspan="3">${mbrVO.zip }&nbsp;${mbrVO.addr }&nbsp; ${mbrVO.daddr }</td>
					</tr>
					<tr>
						<th scope="row">최근접속일</th>
						<td><fmt:formatDate value="${mbrVO.recentCntnDt }" pattern="yyyy-MM-dd HH:mm:ss" /></td>
						<th scope="row">최종변경일 / 처리자</th>
						<td><c:if test="${mbrVO.mdfr ne null}">
								<fmt:formatDate value="${mbrVO.mdfcnDt }" pattern="yyyy-MM-dd HH:mm:ss" /> / ${mbrVO.mdfr}</c:if></td>
					</tr>
				</tbody>
			</table>
		</fieldset>

		<c:if test="${mbrVO.recipterYn eq 'Y'}">
			<fieldset class="mt-13">
				<legend class="text-title2">수급자정보</legend>
				<table class="table-detail">
					<colgroup>
						<col class="w-43">
						<col>
						<col class="w-43">
						<col>
					</colgroup>
					<tbody>
						<tr>
							<th scope="row">요양인정번호</th>
							<td colspan="3">${mbrVO.recipterInfo.rcperRcognNo}</td>
							<th scope="row">본인부담율</th>
							<td colspan="3">${mbrVO.recipterInfo.selfBndRt}%</td>
						</tr>
						<tr>
							<th scope="row">인정유효기간</th>
							<td colspan="3"><fmt:formatDate value="${mbrVO.recipterInfo.vldBgngYmd }" pattern="yyyy-MM-dd" /> ~ <fmt:formatDate value="${mbrVO.recipterInfo.vldEndYmd }" pattern="yyyy-MM-dd" /></td>
							<th scope="row">적용기간</th>
							<td colspan="3"><fmt:formatDate value="${mbrVO.recipterInfo.aplcnBgngYmd }" pattern="yyyy-MM-dd" /> ~ <fmt:formatDate value="${mbrVO.recipterInfo.aplcnEndYmd }" pattern="yyyy-MM-dd" /></td>
						</tr>
						<tr>
							<th scope="row">급여잔액</th>
							<td colspan="3"><fmt:formatNumber value="${mbrVO.recipterInfo.bnefBlce}" pattern="#,###" />원</td>
							<th scope="row">사용금액</th>
							<td colspan="3"><fmt:formatNumber value="${mbrVO.recipterInfo.sprtAmt - mbrVO.recipterInfo.bnefBlce}" pattern="#,###" />원</td>
						</tr>
					</tbody>
				</table>
			</fieldset>
		</c:if>

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
						<th scope="row">전화번호</th>
						<td>${mbrVO.telno }</td>
						<th scope="row">추천인 ID</th>
						<td>${mbrVO.rcmdtnId }</td>
					</tr>
					<tr>
						<th scope="row">개인정보 유효기간</th>
						<td colspan="3">
							<div class="form-check-group w-90">
								<c:forEach var="expiration" items="${expiration}" varStatus="status">
									<div class="form-check">
										<input class="form-check-input prvcVal" type="radio" name="expiration" id="expiration${status.index}" value="${expiration.key}" <c:if test="${expiration.key eq mbrVO.prvcVldPd }">checked="checked"</c:if>> <label class="form-check-label" for="expiration${status.index}">${expiration.value}</label>
									</div>
								</c:forEach>
							</div>
						</td>
					</tr>
					<tr>
						<th scope="row">정보수신</th>
						<td colspan="3">
							<div class="flex flex-wrap -mx-2">
								<div class="form-group px-2 my-1 mr-auto">
									<label for="member-item2-1" class="pr-1">SMS 수신</label>
									<div class="form-check">
										<input type="checkbox" class="form-check-input choiceVal" name="smsRcptnYn" id="smsRcptnYn" value="${mbrVO.smsRcptnYn }" <c:if test="${mbrVO.smsRcptnYn eq 'Y' }">checked="checked"</c:if>> <label class="form-check-label" for="smsRcptnYn"></label>
									</div>

									<label for="member-item2-1" class="pr-1">이메일 수신</label>
									<div class="form-check">
										<input type="checkbox" class="form-check-input choiceVal" name="emlRcptnYn" id="emlRcptnYn" value="${mbrVO.emlRcptnYn }" <c:if test="${mbrVO.emlRcptnYn eq 'Y' }">checked="checked"</c:if>> <label class="form-check-label" for="emlRcptnYn"></label>
									</div>

									<label for="member-item2-1" class="pr-1">전화 수신</label>
									<div class="form-check">
										<input type="checkbox" class="form-check-input choiceVal" name="telRecptnYn" id="telRecptnYn" value="${mbrVO.telRecptnYn }" <c:if test="${mbrVO.telRecptnYn eq 'Y' }">checked="checked"</c:if>> <label class="form-check-label" for="telRecptnYn"></label>
									</div>
								</div>
							</div>
						</td>
					</tr>
					<tr>
						<th scope="row"><label for="member-item3">프로필 이미지</label></th>
						<td colspan="3"><c:if test="${!empty mbrVO.proflImg}">
								<div class="form-group" style="display: flex;">
									<img src="/comm/PROFL/getFile?fileName=${mbrVO.proflImg}" id="profile" style="width: 55px; height: 55px; border-radius: 25%;">
									<!-- <button type="button" class="delProfileImgBtn">
										<i class="fa fa-trash"></i>
									</button> -->
								</div>
							</c:if></td>
					</tr>
				</tbody>
			</table>
		</fieldset>

		<fieldset class="mt-13">
			<legend class="text-title2">관리정보</legend>
			<table class="table-detail">
				<colgroup>
					<col class="w-43">
					<col>
					<col class="w-43">
					<col>
				</colgroup>
				<tbody>
					<tr>
						<th scope="row" rowspan="5">관리대상</th>
						<td>
							<div class="form-group w-full">
								<button type="button" class="btn shadow" data-bs-toggle="offcanvas" data-bs-target="#offcanvas1">경고관리</button>
								<p class="flex-1 mx-2"><c:if test="${mngMap.warning ne null}">${mngSeWarning[mngMap.warning.mngSe]} :
									<c:if test="${mngMap.warning.resnCd ne 'ETC'}">
							  	      	<c:if test="${mngMap.warning.resnCd eq 'CS'}">고객 요청</c:if>
                                  		<c:if test="${mngMap.warning.resnCd ne 'CS'}">${resnCd[mngMap.warning.resnCd]}</c:if>
									</c:if>
									<c:if test="${mngMap.warning.resnCd eq 'ETC' }">${mngMap.warning.mngrMemo}</c:if>
									</c:if>
									</p>
								<button type="button" id="changeListBtn" class="btn shadow ml-auto" data-unique-id="${mbrVO.uniqueId}">변경내역보기</button>
							</div>
						</td>
						<th scope="row">최종변경일/처리자</th>
						<td><c:if test="${mngMap.warning.regId ne null}">
								<fmt:formatDate value="${mngMap.warning.regDt}" pattern="yyyy.MM.dd HH:mm:ss" /> / ${mngMap.warning.regId}</c:if></td>
					</tr>
					<tr>
						<td>
							<div class="form-group w-full">
								<button type="button" class="btn shadow" data-bs-toggle="offcanvas" data-bs-target="#offcanvas2">블랙리스트관리</button>
								<p class="flex-1 mx-2">
									<c:if test="${mngMap.black ne null }">
                                    ${mngSeBlack[mngMap.black.mngSe]} <c:if test="${mngMap.black.mngSe eq 'PAUSE'}">(<fmt:formatDate value="${mngMap.black.stopBgngYmd}" pattern="yyyy-MM-dd" /> ~ <fmt:formatDate value="${mngMap.black.stopEndYmd}" pattern="yyyy-MM-dd" />)</c:if><br>
                                    사유 : <c:if test="${mngMap.black.resnCd ne 'ETC'}">
                                    	      	<c:if test="${mngMap.black.resnCd eq 'CS'}">고객 요청</c:if>
                                    			<c:if test="${mngMap.black.resnCd ne 'CS'}">${blackResnCd[mngMap.black.resnCd]}</c:if>
                                    		</c:if>
                                    		<c:if test="${mngMap.black.resnCd eq 'ETC'}">${mngMap.black.mngrMemo}</c:if>
                                    </c:if>
								</p>
							</div>
						</td>
						<th scope="row">최종변경일/처리자</th>
						<td><c:if test="${mngMap.black.regId ne null}">
								<fmt:formatDate value="${mngMap.black.regDt}" pattern="yyyy.MM.dd HH:mm:ss" /> / ${mngMap.black.regId }</c:if></td>
					</tr>
					<tr>
						<td>
							<div class="form-group w-full">
								<button type="button" class="btn authBtn" data-bs-toggle="offcanvas" data-bs-target="#offcanvas3">직권탈퇴관리</button>
								<p class="flex-1 mx-2 authView">
									<c:if test="${mngMap.auth ne null}">
                                    직권탈퇴<br>
                                    사유 : <c:if test="${mngMap.auth.resnCd ne 'SELF'}">
                                    			${authResnCd[mngMap.auth.resnCd]}
                                    		</c:if>
                                    		<c:if test="${mngMap.auth.resnCd eq 'SELF'}">${mngMap.auth.mngrMemo}</c:if>
                                    </c:if>
								</p>
							</div>
						</td>
						<th scope="row">최종변경일/처리자</th>
						<td><c:if test="${mngMap.auth.regId ne null}">
								<fmt:formatDate value="${mngMap.auth.regDt}" pattern="yyyy.MM.dd HH:mm:ss" /> / ${mngMap.auth.regId}</c:if></td>
					</tr>
					<!--
                    <tr>
                        <td colspan="3">
                            <div class="form-group">
                                <label for="member-item4" class="mr-1">이벤트 당첨자 제외</label>
                                <div class="form-check-group">
                                	<c:forEach var="result" items="${yn}" varStatus="status">
                                     <div class="form-check">
                                         <input class="form-check-input eventVal" type="radio" name="useYn" id="useYn${status.index}" value="${result.key}" <c:if test="${mbrVO.eventRecptnYn eq result.key }">checked="checked"</c:if>>
                                         <label class="form-check-label" for="useYn${status.index}">${result.value}</label>
                                     </div>
                                    </c:forEach>
                                </div>
                            </div>
                        </td>
                    </tr>
                     -->
				</tbody>
			</table>
		</fieldset>

		<div class="btn-group mt-8">
			<a href="/_mng/mbr/list" class="btn-primary large shadow w-52">목록</a>
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
		$(".prvcVal").on("click", function() {
			if(confirm("변경하시겠습니까?")){
				$.ajax({
					type : "post",
					url : '/_mng/mbr/' + $("#uniqueId").val() + '/prvc.json',
					data : {
						uniqueId : $("#uniqueId").val(),
						prvc : $('input[name=expiration]:checked').val()
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

	});
</script>


