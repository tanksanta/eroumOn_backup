<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<main id="container" class="is-mypage-style">
	<header id="page-title">
		<h2>
			<span>수급자 관리</span>
		</h2>
	</header>

	<jsp:include page="../../layout/page_nav.jsp" />
	
	<div id="page-content">               
		<h3 class="mypage-title2 with-icon">
			<a href="javascript:history.back();">
				<i class="icon-back"></i>
			</a>
			수급자 관리
		</h3>
		<div class="mypage-consult-desc text-with-icon">
			<i class="icon-alert"></i>
			<p>장기요양보험 수급자와 예비수급자의 정보를 관리할 수 있는 페이지입니다.</p>
		</div>

		<div class="mypage-client-details mt-3.5 md:mt-5">
			<div class="mypage-client-detail-item">
				<h4 class="mypage-client-detail-item-title">
					<strong class="text-xl">기본정보</strong>
					<a href="#" class="text-blue3 text-sm" onclick="clickUpdateRecipientBtn();">수정하기<i class="icon-plus icon-blue3"></i></a>
				</h4>
				<div class="mypage-client-detail-inner">
					<table class="table-view bg-title">
					<caption class="hidden">수급자 상세 기본정보표 입니다</caption>
					<colgroup>
						<col class="w-40">
						<col>
					</colgroup>
						<tbody>
							<tr>
								<th scope="row">수급자와의 관계</th>
								<td>${relationCd[recipientVO.relationCd]}</td>
							</tr>
							<tr>
								<th scope="row">수급자 성명</th>
								<td class="break-all">${recipientVO.recipientsNm}</td>
							</tr>
							<tr>
								<th scope="row">요양인정번호</th>
								<td><c:if test="${!empty recipientVO.rcperRcognNo}">L</c:if>${recipientVO.rcperRcognNo}</td>
							</tr>
							<tr>
								<th scope="row">상담받을 연락처</th>
								<td>${recipientVO.tel}</td>
							</tr>
							<tr>
								<th scope="row">실거주지 주소</th>
								<td class="break-all">${recipientVO.sido}&nbsp;${recipientVO.sigugun}&nbsp;${recipientVO.dong}</td>
							</tr>
							<tr>
								<th scope="row">생년월일</th>
								<td>
									<c:if test="${ recipientVO.brdt != null }">
										${recipientVO.brdt.substring(0,4)}/${recipientVO.brdt.substring(4,6)}/${recipientVO.brdt.substring(6,8)}
									</c:if>
								</td>
							</tr>
							<tr>
								<th scope="row">성별</th>
								<td>${genderCode[recipientVO.gender]}</td>
							</tr>
							<tr>
								<th scope="row">최근등록(수정)일시</th>
								<td>
									<c:choose>
										<c:when test="${!empty recipientVO.mdfcnDt}">
											<fmt:formatDate value="${recipientVO.mdfcnDt}" pattern="yyyy-MM-dd HH:mm:ss" />
										</c:when>
										<c:otherwise>
											<fmt:formatDate value="${recipientVO.regDt}" pattern="yyyy-MM-dd HH:mm:ss" />
										</c:otherwise>
									</c:choose>
								</td>
							</tr>
						</tbody>
					</table>
				</div>
			</div>
			<div class="mypage-client-detail-item">
				<h4 class="mypage-client-detail-item-title">
					<strong class="text-xl">상담 내역</strong>
					<a href="/membership/conslt/appl/list" class="text-sm">지난 상담 내역 보기<i class="icon-arrow-right"></i></a>
				</h4>
				<div class="mypage-client-detail-inner">
					<table class="table-view bg-title">
					<caption class="hidden">수급자 상담내역 정보입니다</caption>
					<colgroup>
						<col class="w-30">
						<col>
					</colgroup>
						<tbody>
							<tr>
								<th scope="row">수급자 성명</th>
								<td class="break-all">${consltVO.mbrNm}</td>
							</tr>
							<tr>
								<th scope="row">상담 유형</th>
								<td>${prevPathCode[consltVO.prevPath]}</td>
							</tr>
							<tr>
								<th scope="row">진행 현황</th>
								<td>
									<c:choose>
										<c:when test="${consltVO.consltSttus eq 'CS03'}">상담 취소</c:when>
										<c:when test="${consltVO.consltSttus eq 'CS09'}">상담 취소</c:when>
										<c:when test="${consltVO.consltSttus eq 'CS04'}">상담 취소</c:when>
										<c:otherwise>
											${consltSttusCode[consltVO.consltSttus]}
										</c:otherwise>
									</c:choose>
								</td>
							</tr>
							<tr>
								<th scope="row">장기요양기관</th>
								<td>
									<c:if test="${consltResultVO != null}">
										<strong>${consltResultVO.bplcNm}</strong>
                                        <c:if test="${!empty consltResultVO.bplcInfo}">
                                        	<a href="tel:${consltResultVO.bplcInfo.telno}" class="mobile-tel-btn"><i class="icon-tel"></i></a>
                                        </c:if>
										<div class="item-request justify-end">
											<div class="flex items-center">
												<label class="check1">
													<input type="checkbox" name="recommend" value="${consltResultVO.bplcUniqueId}" <c:if test="${bplcRcmdList.stream().filter(f -> f.bplcUniqueId == consltResultVO.bplcUniqueId).count() > 0}">checked</c:if>>
													<span>추천하기</span>
												</label>
												<%-- 관심설정 기능 제거 --%>
												<%-- <label class="check2">
													<input type="checkbox" name="itrst" value="${consltResultVO.bplcUniqueId}" <c:if test="${itrstList.stream().filter(f -> f.bplcUniqueId == consltResultVO.bplcUniqueId).count() > 0}">checked</c:if>>
													<span>관심설정</span>
												</label> --%>
											</div>
										</div>
									</c:if>
								</td>
							</tr>
							<tr>
								<th scope="row">상담 신청일</th>
								<td><fmt:formatDate value="${consltVO.regDt}" pattern="yyyy.MM.dd" /></td>
							</tr>
							<tr>
								<th scope="row">상담 완료일</th>
								<td>
									<c:if test="${completeChgHistVO != null}">
										<fmt:formatDate value="${completeChgHistVO.regDt}" pattern="yyyy.MM.dd" />
									</c:if>
								</td>
							</tr>
						</tbody>
					</table>
				</div>
			</div>
		</div>

		<div class="flex flex-col gap-4 mt-8">
            <div class="flex justify-between items-center gap-2">
                <h3 class="font-semibold text-xl">관심 복지용구</h3>
                <div>
                	<c:if test="${mbrRecipientsGdsList != null && fn:length(mbrRecipientsGdsList) > 0}">
                		<a class="btn-success btn-small" onclick="requestConslt('equip_ctgry');">상담하기</a>
                	</c:if>
                </div>
            </div>
            
            <c:choose>
            	<c:when test="${mbrRecipientsGdsList != null && fn:length(mbrRecipientsGdsList) > 0}">
            		<div class="welfare-kit-outer">
		                <ul class="welfare-kit-wrap members">
		                	<c:forEach var="mbrRecipientsGds" items="${mbrRecipientsGdsList}" varStatus="status">
		                		<c:if test="${mbrRecipientsGds.careCtgryCd eq '10a0'}">
			                		<li class="flex flex-col gap-1">
			                            <div class="welfare-kit-box">
			                                <div class="mx-auto">
			                                    <img src="/html/page/index/assets/images/img-checkpoint1.png" alt="성인용 보행기" class="h-20"/>
			                                </div>
			                                <label for="check-item1" class="welfare-kit-name">성인용 보행기</label>
			                            </div>
			                        </li>
			                	</c:if>
			                	<c:if test="${mbrRecipientsGds.careCtgryCd eq '2080'}">
				                    <li class="flex flex-col gap-1">
			                            <div class="welfare-kit-box">
			                                <div class="mx-auto">
			                                    <img src="/html/page/index/assets/images/img-checkpoint2.png" alt="수동휠체어" class="h-20"/>
			                                </div>
			                                <label for="check-item2" class="welfare-kit-name">수동휠체어</label>
			                            </div>
			                        </li>
			                    </c:if>
			                    <c:if test="${mbrRecipientsGds.careCtgryCd eq '1050'}">
				                    <li class="flex flex-col gap-1">
			                            <div class="welfare-kit-box">
			                                <div class="mx-auto">
			                                    <img src="/html/page/index/assets/images/img-checkpoint3.png" alt="지팡이" class="h-20"/>
			                                </div>
			                                <label for="check-item3" class="welfare-kit-name">지팡이</label>
			                            </div>
			                        </li>
			                    </c:if>
			                    <c:if test="${mbrRecipientsGds.careCtgryCd eq '1090'}">
				                    <li class="flex flex-col gap-1">
			                            <div class="welfare-kit-box">
			                                <div class="mx-auto">
			                                    <img src="/html/page/index/assets/images/img-checkpoint4.png" alt="안전손잡이" class="h-20"/>
			                                </div>
			                                <label for="check-item4" class="welfare-kit-name">안전손잡이</label>
			                            </div>
			                        </li>
			                    </c:if>
			                    <c:if test="${mbrRecipientsGds.careCtgryCd eq '1080'}">
				                    <li class="flex flex-col gap-1">
			                            <div class="welfare-kit-box">
			                                <div class="mx-auto">
			                                    <img src="/html/page/index/assets/images/img-checkpoint5.png" alt="미끄럼방지 매트" class="h-20"/>
			                                </div>
			                                <label for="check-item5" class="welfare-kit-name">미끄럼방지 매트</label>
			                            </div>
			                        </li>
			                    </c:if>
			                    <c:if test="${mbrRecipientsGds.careCtgryCd eq '1070'}">
				                    <li class="flex flex-col gap-1">
			                            <div class="welfare-kit-box">
			                                <div class="mx-auto">
			                                    <img src="/html/page/index/assets/images/img-checkpoint6.png" alt="미끄럼방지 양말" class="h-20"/>
			                                </div>
			                                <label for="check-item6" class="welfare-kit-name">미끄럼방지 양말</label>
			                            </div>
			                        </li>
			                    </c:if>
			                    <c:if test="${mbrRecipientsGds.careCtgryCd eq '1010'}">
				                    <li class="flex flex-col gap-1">
			                            <div class="welfare-kit-box">
			                                <div class="mx-auto">
			                                    <img src="/html/page/index/assets/images/img-checkpoint7.png" alt="욕창예방 매트리스" class="h-20"/>
			                                </div>
			                                <label for="check-item7" class="welfare-kit-name">욕창예방 매트리스</label>
			                            </div>
			                        </li>
			                    </c:if>
			                    <c:if test="${mbrRecipientsGds.careCtgryCd eq '1040'}">
				                    <li class="flex flex-col gap-1">
			                            <div class="welfare-kit-box">
			                                <div class="mx-auto">
			                                    <img src="/html/page/index/assets/images/img-checkpoint8.png" alt="욕창예방 방석" class="h-20"/>
			                                </div>
			                                <label for="check-item8" class="welfare-kit-name">욕창예방 방석</label>
			                            </div>
			                        </li>
			                    </c:if>
			                    <c:if test="${mbrRecipientsGds.careCtgryCd eq '1030'}">
				                    <li class="flex flex-col gap-1" id="collapse-welfare">
			                            <div class="welfare-kit-box">
			                                <div class="mx-auto">
			                                    <img src="/html/page/index/assets/images/img-checkpoint9.png" alt="자세변환용구" class="h-20"/>
			                                </div>
			                                <label for="check-item9" class="welfare-kit-name">자세변환용구</label>
			                            </div>
			                        </li>
			                    </c:if>
			                    <c:if test="${mbrRecipientsGds.careCtgryCd eq '1020'}">
				                    <li class="flex flex-col gap-1">
			                            <div class="welfare-kit-box">
			                                <div class="mx-auto">
			                                    <img src="/html/page/index/assets/images/img-checkpoint10.png" alt="요실금 팬티" class="h-20"/>
			                                </div>
			                                <label for="check-item10" class="welfare-kit-name">요실금 팬티</label>
			                            </div>
			                        </li>
			                    </c:if>
			                    <c:if test="${mbrRecipientsGds.careCtgryCd eq '10b0'}">
				                    <li class="flex flex-col gap-1">
			                            <div class="welfare-kit-box">
			                                <div class="mx-auto">
			                                    <img src="/html/page/index/assets/images/img-checkpoint11.png" alt="목욕의자" class="h-20"/>
			                                </div>
			                                <label for="check-item11" class="welfare-kit-name">목욕의자</label>
			                            </div>
			                        </li>
			                    </c:if>
			                    <c:if test="${mbrRecipientsGds.careCtgryCd eq '10c0'}">
				                    <li class="flex flex-col gap-1">
			                            <div class="welfare-kit-box">
			                                <div class="mx-auto">
			                                    <img src="/html/page/index/assets/images/img-checkpoint12.png" alt="이동변기" class="h-20"/>
			                                </div>
			                                <label for="check-item12" class="welfare-kit-name">이동변기</label>
			                            </div>
			                        </li>
			                    </c:if>
			                    <c:if test="${mbrRecipientsGds.careCtgryCd eq '1060'}">
				                    <li class="flex flex-col gap-1">
			                            <div class="welfare-kit-box">
			                                <div class="mx-auto">
			                                    <img src="/html/page/index/assets/images/img-checkpoint13.png" alt="간이변기" class="h-20"/>
			                                </div>
			                                <label for="check-item13" class="welfare-kit-name">간이변기</label>
			                            </div>
			                        </li>
			                    </c:if>
			                    <c:if test="${mbrRecipientsGds.careCtgryCd eq '10d0'}">
				                    <li class="flex flex-col gap-1">
			                            <div class="welfare-kit-box">
			                                <div class="mx-auto">
			                                    <img src="/html/page/index/assets/images/img-checkpoint14.png" alt="경사로" class="h-20"/>
			                                </div>
			                                <label for="check-item14" class="welfare-kit-name">경사로</label>
			                            </div>
			                        </li>
			                    </c:if>
		                	</c:forEach>
		                </ul>
		                <button id="welfare-more" type="button" class="btn btn-small btn-more3">
		                    <span>더보기</span>
		                    <img src="/html/page/members/assets/images/ico-angle-down.svg" alt="" class="">
		                </button>
		            </div>
            	</c:when>
            	<c:otherwise>
            		<div class="card-bg-gray">
			            <img src="/html/page/members/assets/images/img-welfare-kit-nodata.svg" class="w-25" alt="관심복지용품 이미지"/>
			            <p class="text-gray5">필요한 복지용구를 선택하고  <strong> 구매 신청해보세요</strong></p>
			            <a href="/main/welfare/equip/list?recipientsNo=${recipientVO.recipientsNo}" class="btn-outline-secondary btn-arrow mt-8">
			                선택하기
			                <i class="icon-next ml-3"></i>
			            </a>
			        </div>
            	</c:otherwise>
            </c:choose>
        </div>




		<div class="flex justify-between items-center gap-2  mt-8">
			<h3 class="font-semibold text-xl">인정등급 예상 테스트</h3>
			<c:if test="${testVO != null}">
				<a class="btn-success btn-small" onclick="requestConslt('test');">상담하기</a>
			</c:if>
		</div>
		
		<c:choose>
			<c:when test="${testVO != null}">
				<div class="card-bg-gray mt-4">
					<img src="/html/page/members/assets/images/img-expected-test.png" class="w-80" alt="인정등급예상테스트결과 표현이미지"/>
					<p class="text-gray6">진행하신 인정등급 예상 테스트 결과를 확인하세요</p>
					<p class="text-gray5 text-xs">최근 테스트 일시 :<span><fmt:formatDate value="${testVO.mdfcnDt != null ? testVO.mdfcnDt : testVO.regDt}" pattern="yyyy년 MM월 dd일 HH:mm:ss" /></span></p>
					<a href="#" class="btn-outline-secondary mt-8"  data-bs-toggle="modal" data-bs-target="#grade-test-result">
						결과 상세보기
						<i class="icon-next ml-3"></i>
					</a>
				</div>
			</c:when>
			<c:otherwise>
				<div class="card-bg-gray mt-4">
					<i class="icon-alert size-md opacity-60"></i>
					<p class="text-gray6">인정등급 예상 테스트를 하면 확인할 수 있어요</p>
					<a href="/test/physical?recipientsNo=${recipientVO.recipientsNo}" class="btn-outline-secondary mt-8">
						인정등급 예상 테스트 바로가기
						<i class="icon-next ml-3"></i>
					</a>
				</div>				
			</c:otherwise>
		</c:choose>
		
		<div class="text-center my-20">
			<a href="/membership/info/recipients/list" class="btn-primary btn-large w-1/3">목록</a>
		</div>
	</div>


	<!-- 수급자 등록하기, 수정하기, 상담 신청하기 지원 모달 -->
	<jsp:include page="/WEB-INF/jsp/common/modal/recipient_and_conslt_modal.jsp" />
	

	<!--모달: 인정등급 예상 테스트 결과보기 -->
	<div class="modal modal-scrolled  fade" id="grade-test-result" tabindex="-1">
		<div class="modal-dialog modal-dialog-centered  modal-dialog-scrollable modal-lg">
			<div class="modal-content">
				<div class="modal-header">
					<h2 class="text-title">결과 상세보기</h2>
					<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="close"></button>
				</div>
				<div class="modal-body">
					<iframe  src="/test/result.html?recipientsNo=${recipientsNo}" onload="this.before((this.contentDocument.body||this.contentDocument).children[0]);this.remove()"></iframe>
				</div>
			</div>
		</div>
	</div>
</main>

<script src="/html/core/script/formatter.js"></script>
<script>
  	//모바일 체크 처리
	var isMobile = /Mobi/i.test(window.navigator.userAgent);
	if (!isMobile) {
		$('.mobile-tel-btn').css('display', 'none');
	}
    
  	//수급자 정보 수정 클릭
    function clickUpdateRecipientBtn() {
		var recipientsNo = '${recipientsNo}'
		openModal('updateRecipient', Number(recipientsNo));
    }
  	
  	//상담하기 버튼 클릭
  	function requestConslt(prevPath) {
  		var recipientsNo = '${recipientsNo}'
		openModal('requestConslt', Number(recipientsNo), prevPath);
  	}
  	
  	
    $(function() {
    	
		var swiper = new Swiper(".swiper", {
			slidesPerView : 'auto',
			spaceBetween : 10,
			navigation: {
				nextEl: ".swiper-button-next",
				prevEl: ".swiper-button-prev",
			},
			breakpoints: {
				spaceBetween : 12,
			},
		});
		
		$('.status-toggle').on('click', function() {
			$(this).toggleClass('is-active').prev('.status-list').toggleClass('hidden');
		})
		
		
		//추천하기 이벤트
		$("input[name='recommend']").on("click",function(){
    		let bplcUniqueId = $(this).val();
    		let checked = $(this).is(':checked');
    		console.log(bplcUniqueId, checked);

    		if(bplcUniqueId != ""){
	    		$.ajax({
					type : "post",
					url  : "/members/bplc/rcmd/incrsAction.json",
					data : {bplcUniqueId},
					dataType : 'json'
				})
				.done(function(data) {
					console.log(data.result);
					if(data.result==="success"){
						$(this).prop('checked', false);
					}else if(data.result==="login"){
						$(this).prop('checked', false);
						alert("로그인을 해야 사용하실 수 있습니다.");
					}else if(data.result==="dislike"){
						$(this).prop('checked', false);
					/*
					}else if(data.result==="already"){
						alert("이미 '좋아요'를 하셨습니다.");
					*/
					}
				})
				.fail(function(data, status, err) {
					console.log('error forward : ' + data);
				});
    		}

    	});
		
		//관심멤버스 이벤트
		$("input[name='itrst']").on("click",function(){
    		let bplcUniqueId = $(this).val();
    		let checked = $(this).is(':checked');
    		console.log(bplcUniqueId, checked);

    		var uniqueIds = [];
    		uniqueIds.push(bplcUniqueId);

    		/* 기존 관심멤서브 자원 활용 */
    		if(uniqueIds.length > 0 && checked){ //등록
   				$.ajax({
   					type : "post",
   					url  : "/membership/conslt/itrst/insertItrstBplc.json",
   					data : {
   						arrUniqueId : uniqueIds
   					},
   					traditional: true,
   					dataType : 'json'
   				}).done(function(data) {
   					if(data.result == 0){
   						$(this).prop('checked', false);
   						alert("관심 멤버스 등록에 실패했습니다. /n 관리자에게 문의바랍니다.");
   						return false;
   					}else if(data.result == 1){
   						//alert("등록되었습니다.");
   						console.log("관심 멤버스로 등록 완료");
   					}else{
   						$(this).prop('checked', false);
   						alert("관심 멤버스는 최대 5개 입니다.");
   						return false;
   					}

   				}).fail(function(data, status, err) {
   					console.log(data);
   					return false;
   				});
    		}else if(uniqueIds.length > 0 && !checked){ //삭제

    			$.ajax({
    				type : "post",
    				url  : "/membership/conslt/itrst/deleteItrstBplc.json",
    				data : {
    					uniqueId : bplcUniqueId
    				},
    				dataType : 'json'
    			})
    			.done(function(json) {
    				console.log("관심 멤버스에서 삭제 완료");
    				$(this).prop('checked', false);
    				//alert("삭제되었습니다.");
    			})
    			.fail(function(data, status, err) {
    				console.log(data);
    			});
    		}


    	});

		//관심복지용품목록
		function isMobileDevice() {
			return (typeof window.orientation !== "undefined") || (navigator.userAgent.indexOf('IEMobile') !== -1);
		}

           let items = $('.welfare-kit-wrap li');

           if (isMobileDevice()) {
               let itemsMo = $('.welfare-kit-wrap li:nth-child(n+7)')
               if (items.length < 7) {
                   $('#welfare-more').hide()
               }
               itemsMo.hide();
               moreEvent(itemsMo)
           } else {
               let itemsPc = $('.welfare-kit-wrap li:nth-child(n+11)')
               if (items.length < 11) {
                   $('#welfare-more').hide()
               }
               itemsPc.hide();
               moreEvent(itemsPc)
           }

           function moreEvent (item) {
               $('#welfare-more').click(function () {
                   if ($(this).hasClass('is-active')) {
                       item.hide();
                       $(this).children('span').text('더보기');
                       $(this).removeClass('is-active');
                   } else {
                       item.show();
                       $(this).children('span').text('숨기기');
                       $(this).addClass('is-active');
                   }
               });
           }
	})
</script>
