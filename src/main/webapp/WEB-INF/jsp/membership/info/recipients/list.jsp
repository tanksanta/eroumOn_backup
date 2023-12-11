<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<main id="container" class="is-mypage-style">
	<header id="page-title">
		<h2>
			<span>수급자 관리</span>
		</h2>
	</header>
	
	<jsp:include page="../../layout/page_nav.jsp" />

	<div id="page-content">               
		<h3 class="mypage-title2">수급자 관리</h3>
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
						<h4 class="text-2xl break-all"><strong>${recipientInfo.recipientsNm}</strong>(${relationCd[recipientInfo.relationCd]})</h4>
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
									<c:choose>
										<c:when test="${mbrConsltMap[recipientInfo.recipientsNo].consltSttus eq 'CS03'}">상담 취소</c:when>
										<c:when test="${mbrConsltMap[recipientInfo.recipientsNo].consltSttus eq 'CS09'}">상담 취소</c:when>
										<c:when test="${mbrConsltMap[recipientInfo.recipientsNo].consltSttus eq 'CS04'}">상담 취소</c:when>
										<c:otherwise>
											${consltSttus[mbrConsltMap[recipientInfo.recipientsNo].consltSttus]}
										</c:otherwise>
									</c:choose>
								</c:if>
							</dd>
						</dl>
						<dl class="item-current">
							<dt>장기요양기관</dt>
							<dd class="flex flex-col items-start justify-center gap-2">
								<c:if test="${mbrConsltMap[recipientInfo.recipientsNo] != null}">
									<div class="flex items-center justify-start gap-2">
										<c:choose>
											<c:when test="${mbrConsltMap[recipientInfo.recipientsNo].consltResultList.size() > 0}">
												<c:set var="bplcInfo" value="${mbrConsltMap[recipientInfo.recipientsNo].consltResultList[0]}" />
												<strong>${bplcInfo.bplcNm}</strong>
												
												<%-- 
												<label class="recommend">
													<input type="checkbox" id="mainYn${status.index}" name="mainYn${status.index}" value="${bplcInfo.bplcUniqueId}" 
														onchange="changeItrst(this);"
														<c:if test="${itrstList.stream().filter(f -> f.bplcUniqueId == bplcInfo.bplcUniqueId).count() > 0}">checked</c:if>
													>
												</label>
												--%>
											</c:when>
											<c:otherwise>
												<c:if test="${mbrConsltMap[recipientInfo.recipientsNo].consltSttus != 'CS03' && mbrConsltMap[recipientInfo.recipientsNo].consltSttus != 'CS09'}">
													사업소 배정 중
												</c:if>
											</c:otherwise>
										</c:choose>
									</div>
									<%-- 
									<c:if test="${mbrConsltMap[recipientInfo.recipientsNo].consltResultList.size() > 0}">
										<div class="text-subtitle">
											<i class="icon-alert size-sm"></i>
											별(★)을 눌러 관심 멤버스 설정하세요
										</div>
									</c:if>
									--%>
								</c:if>
							</dd>
						</dl>
						<a href="./view?recipientsNo=${recipientInfo.recipientsNo}" class="btn-success btn-small">상세보기</a>
					</div>
					
					<c:if test="${mbrConsltMap[recipientInfo.recipientsNo] == null}">
						<!-- 이미 상담중이라면 버튼 표시X -->
						<div class="rounded-card-gray gap-2">
							<div class="flex justify-between items-center">
								<c:set var="consltPrevPath" value="${recipientInfo.recipientsYn == 'Y' ? 'simpleSearch' : 'test'}" />
							
								<strong>${recipientInfo.recipientsYn == "Y" ? "인정정보상담" : "요양등급상담"}</strong>
								
								<c:if test="${consltPrevPath == 'simpleSearch' || consltPrevPath == 'test' && (mbrTestList.stream().filter(f -> f.recipientsNo == recipientInfo.recipientsNo).count() > 0)}">
									<button type="button" class="btn btn-primary btn-small" onclick="requestConslt('${recipientInfo.recipientsNo}', '${consltPrevPath}')">상담하기</button>
								</c:if>
							</div>
							<div class="text-subtitle">
								<i class="icon-alert size-sm"></i>
								상담을 신청하면 복지용구 구매를 도와드려요
							</div>
						</div>
					</c:if>
				</div>
			</c:forEach>
		
			<c:if test="${mbrVO.mbrRecipientsList.size() < 4}">
				<div class="mypage-client-item add-item">
					<button type="button" class="btn-rounded" onclick="clickAddRecipientBtn();">
						<i class="icon-plus-thin"></i>
					</button>
					<p>수급자 등록</p>
				</div>
			</c:if>
		</div>
	</div>
	
	<!-- 수급자 등록하기, 수정하기, 상담 신청하기 지원 모달 -->
	<jsp:include page="/WEB-INF/jsp/common/modal/recipient_and_conslt_modal.jsp" />
</main>

<script>
	// 수급자 추가하기 버튼 클릭
	function clickAddRecipientBtn() {
		openModal('addRecipient');
	}
	
	// 상담하기 버튼 클릭
	function requestConslt(recipientsNo, prevPath) {
		openModal('requestConslt', Number(recipientsNo), prevPath);	
		
		// if (prevPath === 'test') {
		// 	$.ajax({
	    // 		type : "post",
	    // 		url  : "/membership/info/recipients/test/result.json",
	    // 		data : {
	    // 			recipientsNo
	    // 		},
	    // 		dataType : 'json'
	    // 	})
	    // 	.done(function(data) {
	    // 		if(data.success) {
	    // 			if (data.isExistTest) {
	    // 				openModal('requestConslt', Number(recipientsNo), prevPath);	
	    // 			} else {
	    // 				alert('테스트 진행 후 상담요청해주세요')
	    // 			}
	    // 		}else{
	    // 			alert(data.msg);
	    // 		}
	    // 	})
	    // 	.fail(function(data, status, err) {
	    // 		alert('서버와 연결이 좋지 않습니다.');
	    // 	});
		// } else {
		// 	openModal('requestConslt', Number(recipientsNo), prevPath);	
		// }
  	}
	

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