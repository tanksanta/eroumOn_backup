<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<main id="container" class="is-mypage-style">
	<header id="page-title">
		<h2>
			<span>수급자상세</span>
		</h2>
	</header>
	
	<jsp:include page="../../layout/page_nav.jsp" />

	<div id="page-content">               
		<h3 class="mypage-title2">수급자관리 </h3>
		<div class="mypage-consult-desc text-with-icon">
			<i class="icon-alert"></i>
			<p>장기요양보험 수급자와 예비수급자의 정보를 관리할 수 있는 페이지입니다.</p>
		</div>

		<div class="mypage-client-details mt-3.5 md:mt-5">
			<c:forEach var="recipientInfo" items="${mbrVO.mbrRecipientsList}" varStatus="status">
				<div class="mypage-client-item <c:if test="${recipientInfo.mainYn == 'Y'}">active</c:if>">
					<input class="inputRecipientsNo" type="hidden" value="${recipientInfo.recipientsNo}">
					<label class="flag">
						<input type="radio" id="flag1" name="flag" value="" class="favorite" <c:if test="${recipientInfo.mainYn == 'Y'}">checked</c:if>>
					</label>
					<div class="item-current-header">
						<i class="icon-clienton"></i>
						<h4 class="text-2xl"><strong>${recipientInfo.recipientsNm}</strong>(${relationCd[recipientInfo.relationCd]})</h4>
						<p class="text-gray6">
							${recipientInfo.rcperRcognNo == null || recipientInfo.rcperRcognNo == "" ? "" : "L"}
							${recipientInfo.rcperRcognNo == null || recipientInfo.rcperRcognNo == "" ? "요양인정번호 없음" : recipientInfo.rcperRcognNo}
						</p>
					</div>
					<div class="rounded-card-gray" >
						<dl class="item-current">
							<dt>상담유형</dt>
							<dd>
								<c:if test="${mbrConsltMap[recipientInfo.recipientsNo] != null}">
									${prevPath[mbrConsltMap[recipientInfo.recipientsNo].prevPath]}
								</c:if>
							</dd>
						</dl>
						<dl class="item-current">
							<dt>상담 진행 현황</dt>
							<dd>
								<c:if test="${mbrConsltMap[recipientInfo.recipientsNo] != null}">
									${consltSttus[mbrConsltMap[recipientInfo.recipientsNo].consltSttus]}
								</c:if>
							</dd>
						</dl>
						<dl class="item-current">
							<dt>장기요양기간</dt>
							<dd class="flex flex-col items-start justify-center gap-2">
								<c:if test="${mbrConsltMap[recipientInfo.recipientsNo] != null}">
									<div class="flex items-center justify-start gap-2">
										<c:choose>
											<c:when test="${mbrConsltMap[recipientInfo.recipientsNo].consltResultList.size() > 0}">
												<c:set var="bplcInfo" value="${mbrConsltMap[recipientInfo.recipientsNo].consltResultList[0]}" />
												<strong>${bplcInfo.bplcNm}</strong>
												
												<label class="recommend">
													<input type="checkbox" id="mainYn${status.index}" name="mainYn${status.index}" value="${bplcInfo.bplcUniqueId}" 
														onchange="changeItrst(this);"
														<c:if test="${itrstList.stream().filter(f -> f.bplcUniqueId == bplcInfo.bplcUniqueId).count() > 0}">checked</c:if>
													>
												</label>
											</c:when>
											<c:otherwise>
												사업소 배정 중
											</c:otherwise>
										</c:choose>
									</div>
									<c:if test="${mbrConsltMap[recipientInfo.recipientsNo].consltResultList.size() > 0}">
										<div class="text-subtitle">
											<i class="icon-alert size-sm"></i>
											별(★)을 눌러 관심 멤버스 설정하세요
										</div>
									</c:if>
								</c:if>
							</dd>
						</dl>
						<a href="./view?recipientsNo=${recipientInfo.recipientsNo}" class="btn-success btn-small">상세보기</a>
					</div>
					
					<c:if test="${mbrConsltMap[recipientInfo.recipientsNo] == null}">
						<!-- 이미 상담중이라면 버튼 표시X -->
						<div class="rounded-card-gray gap-2">
							<div class="flex justify-between items-center">
								<strong>${recipientInfo.recipientsYn == "Y" ? "인정정보상담" : "요양등급상담"}</strong>
								<button type="button" class="btn btn-primary btn-small" data-bs-toggle="modal" data-bs-target="#check-counseling-info">상담하기</button>
							</div>
							<div class="text-subtitle">
								<i class="icon-alert size-sm"></i>
								상담을 신청하면 복지용구 구매를 도와드려요
							</div>
						</div>
					</c:if>
				</div>
			</c:forEach>
		
			<c:forEach begin="1" end="${4 - mbrVO.mbrRecipientsList.size()}">
				<div class="mypage-client-item add-item">
					<button type="button" class="btn-rounded">
						<i class="icon-plus-thin"></i>
					</button>
				</div>
			</c:forEach>
		</div>
	</div>

	<!-- 상담정보확인팝업소스 -->
	<div class="modal modal-scrolled fade" id="check-counseling-info" tabindex="-1" aria-hidden="true">
		<div class="modal-dialog modal-dialog-centered modal-dialog-scrolled modal-lg">
			<div class="modal-content">
				<div class="modal-header">
					<h2 class="text-title">상담 정보 확인</h2>
					<button data-bs-dismiss="modal" class="btn-close">모달 닫기</button>
				</div>
				<div class="modal-body">
					<div class="text-subtitle -mb-3">
						<i class="icon-alert"></i>
						<p>회원이 이용약관에 따라 수급자 등록과 관리하는 것에 동의합니다</p>
					</div>
					<table class="table-detail">
						<caption class="hidden">상담정보확인 위한 수급자와의 관계(필수), 수급자성명(필수), 요양인정번호, 상담받을연락처(필수), 실거주지 주소(필수), 생년월일(필수),성별(필수), 상담유형 입력폼입니다 </caption>
						<colgroup>
							<col class="w-22 xs:w-32">
							<col>
						</colgroup>
						<tbody>
							<tr class="wrapRelation">
								<tr class="top-border">
									<td></td>
									<td></td>
								</tr>
								<tr>
									<th scope="row">
										<p>
											<label for="recipter">수급자와의 관계<sup class="text-danger text-base md:text-lg">*</sup></label>
										</p>
									</th>
									<td>
										<select name="relationSelect" id="relationSelect" class="form-control w-full lg:w-8/12">
											<option value="">선택</option>
											<option value="001" selected>본인</option>
											<option value="002">아버지</option>
											<option value="003">어머니</option>
											<option value="004">시아버지</option>
											<option value="005">시어머니</option>
											<option value="006">배우자</option>
											<option value="007">형제자매</option>
											<option value="100">기타</option>
										</select>
									</td>
								</tr>
							<tr class="wrapNm">
								<th scope="row">
									<p>
										<label for="recipter">수급자 성명<sup class="text-danger text-base md:text-lg">*</sup></label>
									</p>
								</th>
								<td>
									<input type="text" class="form-control w-full  lg:w-8/12" id="recipter" name="testName" maxlength="50" value="홍길동" readonly>
								</td>
							</tr>
							<tr class="wrapNo">
								<th scope="row">
									<p>
										<label for="rcperRcognNo">요양인정번호</label>
									</p>
								</th>
								<td>
									<div class="flex flex-row gap-2.5 mb-1.5">
										<div class="form-check">
											<input class="form-check-input" type="radio" name="yn" id="yes" checked>
											<label class="form-check-label" for="yes">있음</label>
										</div>
										<div class="form-check">
											<input class="form-check-input" type="radio" name="yn" id="no">
											<label class="form-check-label" for="no">없음</label>
										</div>
									</div>
									<div class="form-group w-full flex lg:w-8/12">
										<p class="px-1.5 font-serif text-[1.375rem] font-bold md:text-2xl">L</p>
										<input  type="text" class="form-control " id="rcperRcognNo" name="rcperRcognNo" maxlength="13" value="1234567890" readonly>
									</div>
								</td>
							</tr>
							<tr>
								<th scope="row">
									<p><label for="search-item6">상담받을 연락처</label></p>
								</th>
								<td><input type="text" class="form-control w-full lg:w-8/12" id="info-tel"></td>
							</tr> 
							<tr>
								<th scope="row">
									<p><label for="search-item6">실거주지 주소<sup class="text-danger text-base md:text-lg">*</sup></label></p>
								</th>
								<td>
									<fieldset class="addr-select">
										<select name="" id="" class="form-control" readonly>
											<option value="">시/도</option>
										</select>
										<select name="" id="" class="form-control" readonly>
											<option value="">시/군/구</option>
										</select>
										<select name="" id="" class="form-control md:col-span-2 lg:col-span-1" readonly>
											<option value="">동/읍/면</option>
										</select>
									</fieldset>
								</td>
							</tr>
							<tr>
								<th scope="row"><p><label for="search-item4">생년월일<sup class="text-danger text-base md:text-lg">*</sup></label></p></th>
								<td><input type="text" class="form-control w-full  lg:w-8/12" id="search-item4" value="19001010"></td>
							</tr>
							<tr>
								<th scope="row"><p><label for="search-item4">성별<sup class="text-danger text-base md:text-lg">*</sup></label></p></th>
								<td>
									<div class="flex flex-row gap-2.5 mb-1.5">
										<div class="form-check">
											<input class="form-check-input" type="radio" name="info-gender" id="info-gender-m" value="M" checked disabled>
											<label class="form-check-label" for="info-gender-m">남성</label>
										</div>
										<div class="form-check">
											<input class="form-check-input" type="radio" name="info-gender" id="info-gender-w" value="W" disabled>
											<label class="form-check-label" for="info-gender-w">여성</label>
										</div>
									</div>
								</td>
							</tr>
							<tr class="top-border">
								<td></td>
								<td></td>
							</tr>
						</tbody>
					</table>
					<ul class="list-style1">
						<li>상기 정보는 장기요양등급 신청 및 상담이 가능한 장기요양기관에 제공되며 원활한 상담 진행 목적으로 상담 기관이 변경될 수도 있습니다.</li>
						<li>제공되는 정보는 상기 목적으로만 활용하며 1년간 보관 후 폐기됩니다.</li>
						<li>가입 시 동의받은 개인정보 제3자 제공동의에따라 위의 개인정보가 제공됩니다. 동의하지 않을 경우 서비스 이용이 제한될 수 있습니다.</li>
					</ul>
				</div>
				<div class="modal-footer md:w-3/4 mx-auto mt-4">
					<button type="button" class="btn btn-primary large w-3/5" data-bs-dismiss="modal" class="btn-close">닫기</button>
				</div>
			</div>
		</div>
	</div>
</main>

<script>
	window.onload = function(){
		const parents = document.querySelectorAll(".mypage-client-item");
		const radios = document.querySelectorAll(".favorite");
	
		radios.forEach((radio) => {
			//수급자 대표 변경 이벤트
			radio.addEventListener("change", (e) => {
				const current = e.currentTarget;
				const parent = current.closest('.mypage-client-item');
				if(current.checked){
					parents.forEach(parent => {
						parent.classList.remove('active');
					});

					if (parent) {
						parent.classList.add('active');
					}
				}
				
				//대표 수급자 처리
				var recipientsNo = $(current).parent().prev().val();
				
				$.ajax({
					type : "post",
					url  : "/membership/info/recipients/update/main.json",
					data : {
						recipientsNo : Number(recipientsNo)
					},
					dataType : 'json'
				})
				.done(function(data) {
					if(data.success) {
						
					}else{
						alert(data.msg);
					}
				})
				.fail(function(data, status, err) {
					alert('서버와 연결이 좋지 않습니다.');
				});
			});
		});
	};
	
	//관심 멤버스 등록/해제
	function changeItrst(event) {
		var checked = $(event)[0].checked;
		var bplcUniqueId = $(event)[0].value;
		
		//체크 상태시 등록
		if (checked) {
			$.ajax({
				type : "post",
				url  : "/membership/conslt/itrst/insertItrstBplc.json",
				data : {
					arrUniqueId : [bplcUniqueId]
				},
				traditional: true,
				dataType : 'json'
			}).done(function(data) {
				if(data.result == 0){
					$(this).prop('checked', false);
					alert("관심 멤버스 등록에 실패했습니다. /n 관리자에게 문의바랍니다.");
					return false;
				}else if(data.result == 1){
				}else{
					$(this).prop('checked', false);
					alert("관심 멤버스는 최대 5개 입니다.");
					return false;
				}
			}).fail(function(data, status, err) {
				console.log(data);
				return false;
			});
		} else {
			$.ajax({
				type : "post",
				url  : "/membership/conslt/itrst/deleteItrstBplc.json",
				data : {
					uniqueId : bplcUniqueId
				},
				dataType : 'json'
			})
			.done(function(json) {
				
			})
			.fail(function(data, status, err) {
				console.log(data);
			});
		}
	}
	
</script>