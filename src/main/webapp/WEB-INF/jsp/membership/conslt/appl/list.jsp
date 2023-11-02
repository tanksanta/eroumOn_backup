<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

	<main id="container" class="is-mypage-style">
		<header id="page-title">
			<h2>
				<span>상담 내역 관리</span>
			</h2>
		</header>

		<jsp:include page="../../layout/page_nav.jsp" />

        <div id="page-content">

            <h3 class="mypage-title">
                상담 내역 관리
                <button type="button" class="mypage-consult-toggle">상세검색</button>
            </h3>

            <form action="./list" method="get" id="searchFrm" name="searchFrm" class="mypage-consult-search">
                <fieldset>
                    <legend>상세 검색</legend>
                    <button type="button" class="search-close">닫기</button>
                    <dl class="search-date">
                        <dt><label for="srchRegBgng">상담 신청일</label></dt>
                        <dd>
                            <div class="form-group">
                                <input type="date" class="form-control" id="srchRegBgng" name="srchRegBgng" value="${param.srchRegBgng}">
                                <span>-</span>
                                <input type="date" class="form-control" id="srchRegEnd" name="srchRegEnd" value="${param.srchRegEnd}">
                            </div>
                            <div class="form-group-check">
                                <label class="form-check">
                                    <input type="radio" name="" value="" class="form-check-input" onclick="f_srchJoinSet('1'); return false;">
                                    <span class="form-check-label">오늘</span>
                                </label>
                                <label class="form-check">
                                    <input type="radio" name="" value="" class="form-check-input" onclick="f_srchJoinSet('2'); return false;">
                                    <span class="form-check-label">일주일</span>
                                </label>
                                <label class="form-check">
                                    <input type="radio" name="" value="" class="form-check-input" onclick="f_srchJoinSet('3'); return false;">
                                    <span class="form-check-label">15일</span>
                                </label>
                                <label class="form-check">
                                    <input type="radio" name="" value="" class="form-check-input" onclick="f_srchJoinSet('4'); return false;">
                                    <span class="form-check-label">한달</span>
                                </label>
                            </div>
                        </dd>
                    </dl>
					<dl class="search-current">
                        <dt><label for="search-item3">수급자 선택</label></dt>
                        <dd>
                            <select name="srchRecipientsNo" id="srchRecipientsNo" class="form-control w-full" value="${param.srchRecipientsNo}">
                            	<option value="">전체</option>
                            	<c:forEach var="mbrRecipient" items="${mbrRecipientList}" varStatus="status">
                                	<option value="${mbrRecipient.recipientsNo}">${mbrRecipient.recipientsNm}</option>
                                </c:forEach>
                            </select>
                        </dd>
                        <dt class="mt-5.5 md:mt-0 md:text-center"><label for="srchConsltSttus" class="md:ml-4">진행 현황</label></dt>
                        <dd>
							<select name="srchConsltSttus" id="srchConsltSttus" class="form-control w-full">
                                <option value="">선택</option>
                                <option value="CS01" ${param.srchConsltSttus eq 'CS01'?'selected="selected"':''}>상담 신청 완료</option>
                                <option value="CS02" ${param.srchConsltSttus eq 'CS02'?'selected="selected"':''}>상담 기관 배정 완료</option>
                                <option value="CANCEL" ${param.srchConsltSttus eq 'CANCEL'?'selected="selected"':''}>상담 취소</option><%--상담취소 검색은 03, 04, 09가 포함되어야함 --%>
                                <%--<option value="CS03" ${param.srchConsltSttus eq 'CS03'?'selected="selected"':''}>상담 취소</option>사용자--%>
                                <%-- <option value="CS09" ${param.srchConsltSttus eq 'CS09'?'selected="selected"':''}>상담 취소</option>THKC --%>
                                <%-- <option value="CS04" ${param.srchConsltSttus eq 'CS04'?'selected="selected"':''}>상담 취소</option>사업소 --%>
                                <option value="CS05" ${param.srchConsltSttus eq 'CS05'?'selected="selected"':''}>상담 진행 중</option>
                                <option value="CS06" ${param.srchConsltSttus eq 'CS06'?'selected="selected"':''}>상담 완료</option>
                                <option value="CS07" ${param.srchConsltSttus eq 'CS07'?'selected="selected"':''}>재상담 신청 완료</option>
                                <option value="CS08" ${param.srchConsltSttus eq 'CS08'?'selected="selected"':''}>상담 기관 재배정 완료</option>
                            </select>
                        </dd>
                    </dl>
					<dl class="search-partner">
                        <dt><label for="srchBplcNm">장기요양기관</label></dt>
                        <dd><input type="text" id="srchBplcNm" name="srchBplcNm" value="${param.srchBplcNm}" class="form-control w-full"></dd>
                    </dl>
                    <!--이전 코드 백업-->
                    <!-- <dl class="search-partner">
                        <dt><label for="srchBplcNm">상담 기관</label></dt>
                        <dd><input type="text" id="srchBplcNm" name="srchBplcNm" value="${param.srchBplcNm}" class="form-control w-full md:w-83"></dd>
                    </dl> -->
                    <!-- <dl class="search-current">
                        <dt><label for="srchConsltSttus">상담 접수 현황</label></dt>
                        <dd>
                            <select name="srchConsltSttus" id="srchConsltSttus" class="form-control w-full md:w-40">
                                <option value="">선택</option>
                                <option value="CS01" ${param.srchConsltSttus eq 'CS01'?'selected="selected"':''}>상담 신청 완료</option>
                                <option value="CS02" ${param.srchConsltSttus eq 'CS02'?'selected="selected"':''}>상담 기관 배정 완료</option>
                                <option value="CANCEL" ${param.srchConsltSttus eq 'CANCEL'?'selected="selected"':''}>상담 취소</option><%--상담취소 검색은 03, 04, 09가 포함되어야함 --%>
                                <%--<option value="CS03" ${param.srchConsltSttus eq 'CS03'?'selected="selected"':''}>상담 취소</option>사용자--%>
                                <%-- <option value="CS09" ${param.srchConsltSttus eq 'CS09'?'selected="selected"':''}>상담 취소</option>THKC --%>
                                <%-- <option value="CS04" ${param.srchConsltSttus eq 'CS04'?'selected="selected"':''}>상담 취소</option>사업소 --%>
                                <option value="CS05" ${param.srchConsltSttus eq 'CS05'?'selected="selected"':''}>상담 진행 중</option>
                                <option value="CS06" ${param.srchConsltSttus eq 'CS06'?'selected="selected"':''}>상담 완료</option>
                                <option value="CS07" ${param.srchConsltSttus eq 'CS07'?'selected="selected"':''}>재상담 신청 완료</option>
                                <option value="CS08" ${param.srchConsltSttus eq 'CS08'?'selected="selected"':''}>상담 기관 재배정 완료</option>
                            </select>
                        </dd>
                    </dl> -->
                    <button type="submit" class="btn-primary btn-animate flex mt-6 mx-auto w-full md:w-43"><strong>검색</strong></button>
                </fieldset>
            </form>

            <div class="mypage-consult-desc text-with-icon">
				<i class="icon-alert"></i>
                <strong>인정등급 예상 테스트, 요양정보 조회 후 상담 신청하신 내역을 확인하는 페이지 입니다.</strong>
            </div>

            <p><strong>총 ${listVO.totalCount}건</strong>의 상담신청 내역이 있습니다.</p>

            <div class="mypage-consult-items mt-3.5 md:mt-5">
                <div class="mypage-consult-item-gutter"></div>

                <c:forEach var="resultList" items="${listVO.listObject}" varStatus="status">
	                <c:set var="consltSize" value="${fn:length(resultList.consltResultList)}" />
	                <div class="mypage-consult-item">
						<dl class="item-current">
	                        <dt>수급자 성명</dt>
	                        <dd class="flex justify-between">
	                            <span>${resultList.mbrNm}&nbsp;(${mbrRelationCd[resultList.relationCd]})</span>
	                            <a class="btn-conselng-info" onclick="viewConsltInfoModal('${resultList.consltNo}')" style="cursor: pointer;">
	                                상담정보확인<i class="icon-arrow-right opacity-70"></i>
	                            </a>
	                        </dd>
	                    </dl>
						<dl class="item-current">
	                        <dt>상담유형</dt>
	                        <dd>${resultList.prevPath == 'test' ? '인정등급상담' : '요양정보상담'}</dd>
	                    </dl>
	                    <dl class="item-current">
	                        <dt>진행 현황</dt>
	                        <dd>
	                        	<%-- 사용자/관리자 txt가 일부 달라서 코드만 동일하게 사용함 --%>
	                        	<c:choose>
									<c:when test="${resultList.consltSttus eq 'CS01'}">상담 신청 완료</c:when>
									<c:when test="${resultList.consltSttus eq 'CS02'}">상담 기관 배정 완료</c:when>
									<c:when test="${resultList.consltSttus eq 'CS03'}">상담 취소</c:when>
									<c:when test="${resultList.consltSttus eq 'CS09'}">상담 취소</c:when>
									<c:when test="${resultList.consltSttus eq 'CS04'}">상담 취소</c:when>
									<c:when test="${resultList.consltSttus eq 'CS05'}">상담 진행 중</c:when>
									<c:when test="${resultList.consltSttus eq 'CS06'}">상담 완료</c:when>
									<c:when test="${resultList.consltSttus eq 'CS07'}">재상담 신청 완료</c:when>
									<c:when test="${resultList.consltSttus eq 'CS08'}">상담 기관 재배정 완료</c:when>
								</c:choose>
	                        </dd>
	                    </dl>
	                    <dl class="item-partner">
	                        <dt>장기요양기관</dt>
	                        <dd>
								<c:choose>
									<c:when test="${resultList.consltResultList != null && resultList.consltResultList.size() == 1}">
										<strong>${resultList.consltResultList[0].bplcNm}</strong>
										<c:if test="${resultList.consltSttus == 'CS06'}">
											<c:if test="${!empty resultList.consltResultList[0].bplcInfo}">
												<a href="tel:${resultList.consltResultList[0].bplcInfo.telno}" class="mobile-tel-btn"><i class="icon-tel"></i></a>
											</c:if>
											<div class="item-request justify-end">
				                                <div class="flex items-center">
				                                    <label class="check1">
				                                        <input type="checkbox" name="recommend" value="${resultList.consltResultList[0].bplcUniqueId}" <c:if test="${bplcRcmdList.stream().filter(f -> f.bplcUniqueId == resultList.consltResultList[0].bplcUniqueId).count() > 0}">checked</c:if>>
				                                        <span>추천하기</span>
				                                    </label>
				                                    <label class="check2">
				                                        <input type="checkbox" name="itrst" value="${resultList.consltResultList[0].bplcUniqueId}" <c:if test="${itrstList.stream().filter(f -> f.bplcUniqueId == resultList.consltResultList[0].bplcUniqueId).count() > 0}">checked</c:if>>
				                                        <span>관심설정</span>
				                                    </label>
				                                </div>
				                            </div>
										</c:if>
									</c:when>
									<c:when test="${resultList.consltResultList != null && resultList.consltResultList.size() > 1}">
										<c:forEach var="consltResultInfo" items="${resultList.consltResultList}" varStatus="status">
											[${resultList.consltResultList.size() - status.index}차] ${resultList.consltResultList[resultList.consltResultList.size() - (status.index + 1)].bplcNm}
											
											<c:if test="${resultList.consltSttus == 'CS06' && status.index == 0 && !empty resultList.consltResultList[resultList.consltResultList.size() - (status.index + 1)].bplcInfo}">
												&nbsp;<a href="tel:${resultList.consltResultList[resultList.consltResultList.size() - (status.index + 1)].bplcInfo.telno}" class="mobile-tel-btn"><i class="icon-tel"></i></a>
											</c:if>
											
											<br>
										</c:forEach>
										
										<c:set var="lastBplcUniqueId" value="${resultList.consltResultList[resultList.consltResultList.size() - 1].bplcUniqueId}" />
										<c:if test="${resultList.consltSttus == 'CS06'}">
											<div class="item-request justify-end">
												<div class="flex items-center">
				                                    <label class="check1">
				                                        <input type="checkbox" name="recommend" value="${lastBplcUniqueId}" <c:if test="${bplcRcmdList.stream().filter(f -> f.bplcUniqueId == lastBplcUniqueId).count() > 0}">checked</c:if>>
				                                        <span>추천하기</span>
				                                    </label>
				                                    <label class="check2">
				                                        <input type="checkbox" name="itrst" value="${lastBplcUniqueId}" <c:if test="${itrstList.stream().filter(f -> f.bplcUniqueId == lastBplcUniqueId).count() > 0}">checked</c:if>>
				                                        <span>관심설정</span>
				                                    </label>
				                                </div>
			                                </div>
		                                </c:if>
									</c:when>
									<c:otherwise>
										(배정중)
									</c:otherwise>
								</c:choose>
	                        </dd>
	                    </dl>
	                    <dl class="item-date">
	                        <dt>상담 신청일</dt>
	                        <dd><fmt:formatDate value="${resultList.regDt}" pattern="yyyy.MM.dd" /></dd>
	                    </dl>
	                    <c:if test="${resultList.consltSttus eq 'CS06'}">
	                    	<dl class="item-date">
		                    	<dt>상담 완료일</dt>
		                        <dd><fmt:formatDate value="${resultList.sttusChgDt}" pattern="yyyy.MM.dd" /></dd>
	                        </dl>
	                    </c:if>
	                    <c:if test="${resultList.consltSttus eq 'CS03' || resultList.consltSttus eq 'CS04' || resultList.consltSttus eq 'CS09'}">
	                    	<dl class="item-date">
		                    	<dt>상담 취소일</dt>
		                        <dd><fmt:formatDate value="${resultList.sttusChgDt}" pattern="yyyy.MM.dd" /></dd>
	                        </dl>
	                    </c:if>
	                    
	                    <%--상담 완료시 --%>
	                    <c:if test="${resultList.consltSttus eq 'CS01' || resultList.consltSttus eq 'CS07'}">
	                    <div class="item-request  justify-end">
	                    	<button type="button" class="btn btn-outline-success btn-small f_cancel" data-conslt-no="${resultList.consltNo}" data-conslt-mbrNm="${mbrVO.mbrNm}" data-conslt-mbrTelno="${resultList.mbrTelno}">신청 취소하기</button>
	                    </div>
	                    </c:if>
	
	                    <c:if test="${resultList.consltSttus eq 'CS06' && resultList.consltResultList.size() < 3}">
	                    	<div class="item-request justify-end">
		                        <button type="button" class="btn btn-outline-success btn-small f_reconslt" 
		                        		data-conslt-no="${resultList.consltNo}" 
		                        		data-conslt-mbrNm="${mbrVO.mbrNm}" 
		                        		data-conslt-mbrTelno="${resultList.mbrTelno}" 
		                        		data-bplc-unique-id="${resultList.consltResultList[consltSize-1].bplcUniqueId}" 
		                        		data-bplc-conslt-no="${resultList.consltResultList[consltSize-1].bplcConsltNo}">
		                        		재 상담 신청하기
		                        </button>
		                    </div>
	                    </c:if>
	                </div>
                </c:forEach>
            </div>

			<div class="pagination">
				<front:paging listVO="${listVO}" />
			</div>

            <div class="modal modal-default fade" id="reqModal" tabindex="-1" aria-hidden="true">
                <div class="modal-dialog  modal-dialog-centered">
                    <form id="modalReConslt" name="modalReConslt" class="modal-content" enctype="multipart/form-data">
                    	<input type="hidden" name="consltNo" value="0">
                    	<input type="hidden" name="bplcUniqueId" value="">
                    	<input type="hidden" name="bplcConsltNo" value="0">
						<input type="hidden" name="consltmbrNm" value="">
						<input type="hidden" name="consltmbrTelno" value="">

                        <div class="modal-header">
                            <p class="text-title">재 상담 신청 사유 입력</p>
                        </div>
                        <div class="modal-close">
                            <button type="button" data-bs-dismiss="modal">모달 닫기</button>
                        </div>
                        <div class="modal-body">
                            <p class="text-alert">재 상담 신청 사유를 입력해 주세요.</p>
                            <textarea name="reconsltResn" id="reconsltResn" cols="30" rows="10" class="form-control mt-3.5 w-full h-58"></textarea>
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-primary btn-submit">저장하기</button>
                            <button type="button" class="btn btn-outline-primary btn-cancel" data-bs-dismiss="modal">닫기</button>
                        </div>
                    </form>
                </div>
            </div>


            <div class="modal modal-default fade" id="cancelModal" tabindex="-1" aria-hidden="true">
                <div class="modal-dialog modal-dialog-centered">
					<form id="modalCancel" name="modalCancel" class="modal-content" enctype="multipart/form-data">
							<input type="hidden" name="consltNo" value="0">
							<input type="hidden" name="consltmbrNm" value="">
							<input type="hidden" name="consltmbrTelno" value="">
							<div class="modal-header">
								<h2 class="text-title">상담 취소 사유 입력</h2>
							</div>
							<div class="modal-close">
								<button type="button" data-bs-dismiss="modal">모달 닫기</button>
							</div>
							<div class="modal-body">
								<p class="text-alert">상담 취소 사유를 입력해 주세요.</p>
								<textarea name="canclResn" id="canclResn" cols="30" rows="10" class="form-control mt-3.5 w-full h-58"></textarea>
							</div>
							<div class="modal-footer gap-1">
								<button type="button" class="btn btn-primary btn-cancel-submit">저장하기</button>
								<button type="button" class="btn btn-outline-primary btn-cancel" data-bs-dismiss="modal">닫기</button>
							</div>
						</form>
					</div>
            </div>
        </div>
        
		<!-- 상담정보확인팝업소스 -->
        <div class="modal modal-default fade" id="check-counseling-info" tabindex="-1" aria-hidden="true">
            <div class="modal-dialog modal-dialog-centered">
                <div class="modal-content">
                    <div class="modal-header">
                        <h2 class="text-title">상담 정보 확인</h2>
                        <button data-bs-dismiss="modal" class="btn-close">모달 닫기</button>
                    </div>

                    <div class="modal-body">
                        <div>
                            <div class="text-subtitle">
                                <i class="icon-alert"></i>
                                <p>신청하신 수급자의 정보와 상담받을 연락처를 확인하세요</p>
                            </div>
                            <table class="table-view">
                                <caption class="hidden">상담정보확인 위한 수급자와의 관계, 수급자성명, 요양인정번호, 상담받을연락처, 실거주지 주소, 생년월일,성별, 상담유형 내용입니다 </caption>
                                <colgroup>
                                    <col class="w-22 xs:w-32">
                                    <col>
                                </colgroup>
                                <tbody>
                                    <tr class="top-border">
                                        <td></td>
                                        <td></td>
                                    </tr>
                                    <tr>
                                        <th scope="row" class="text-gray1 font-medium">수급자와의 관계</th>
                                        <td id="relationText">본인</td>
                                    </tr>
                                    <tr>
                                        <th scope="row" class="text-gray1 font-medium">수급자 성명</th>
                                        <td id="mbrNm">이로움</td>
                                    </tr>
                                    <tr>
                                        <th scope="row" class="text-gray1 font-medium">요양인정번호</th>
                                        <td id="rcperRcognNo">L123456789</td>
                                    </tr>
                                    <tr>
                                        <th scope="row" class="text-gray1 font-medium">상담받을 연락처</th>
                                        <td id="mbrTelno">010-1234-5678</td>
                                    </tr>
                                    <tr>
                                        <th scope="row" class="text-gray1 font-medium">실거주지 주소</th>
                                        <td id="address">서울특별시 금천구 가산디지털로 104</td>
                                    </tr>
                                    <tr>
                                        <th scope="row" class="text-gray1 font-medium">생년월일</th>
                                        <td id="brdt">1900/01/01</td>
                                    </tr>
                                    <tr>
                                        <th scope="row" class="text-gray1 font-medium">성별</th>
                                        <td id="gender">남성</td>
                                    </tr>
                                    <tr>
                                        <th scope="row" class="text-gray1 font-medium">상담 유형</th>
                                        <td id="prevPath">인정등급 상담</td>
                                    </tr>
                                </tbody>
                            </table>
                        </div>
                        
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-primary w-2/6" data-bs-dismiss="modal">닫기</button>
                    </div>
                </div>
            </div>
        </div>

    </main>
	<script src="/html/core/vendor/masonry/masonry.pkgd.min.js"></script>
    <script>
	    function f_srchJoinSet(ty){
	    	$("#srchRegEnd").val(f_getToday());
	    	if(ty == "1"){//오늘
	       		$("#srchRegBgng").val(f_getToday());
	    	}else if(ty == "2"){//일주일
	    		$("#srchRegBgng").val(f_getDate(-7));
	    	}else if(ty == "3"){//15일
	    		$("#srchRegBgng").val(f_getDate(-15));
	    	}else if(ty == "4"){//한달
	    		$("#srchRegBgng").val(f_getDate(-30));
	    	}
	    }
	    
	    
	    //상담정보보기 클릭
	    function viewConsltInfoModal(consltNo) {
	    	$.ajax({
	    		type : "post",
	    		url  : "/membership/conslt/appl/getConsltInfo.json",
	    		data : {
	    			consltNo
	    		},
	    		dataType : 'json'
	    	})
	    	.done(function(data) {
	    		if(data.success) {
	    			$('#relationText').text(data.mbrConsltInfo.relationText);
	    			$('#mbrNm').text(data.mbrConsltInfo.mbrNm);
	    			if (data.mbrConsltInfo.rcperRcognNo) {
	    				$('#rcperRcognNo').text(data.mbrConsltInfo.rcperRcognNo);	    				
	    			} else {
	    				$('#rcperRcognNo').text('');
	    			}
	    			$('#mbrTelno').text(data.mbrConsltInfo.mbrTelno);
	    			$('#address').text(data.mbrConsltInfo.address);
	    			$('#brdt').text(data.mbrConsltInfo.brdt);
	    			$('#gender').text(data.mbrConsltInfo.gender);
	    			$('#prevPath').text(data.mbrConsltInfo.prevPath);
	    			
	    			$('#check-counseling-info').modal('show');
	    		}else{
	    			alert(data.msg);
	    		}
	    	})
	    	.fail(function(data, status, err) {
	    		alert('서버와 연결이 좋지 않습니다.');
	    	});
	    }
	    
	    
        //채널톡 event 처리 (재상담 신청시)
        function eventChannelTalk() {
            var propertyObj = {};
            
            //재상담 일자(현재시간)
            var now = new Date();
            propertyObj.reConsltDate = now.getFullYear() + '년 ' + String(now.getMonth() + 1).padStart(2, "0") + '월 ' + String(now.getDate()).padStart(2, "0") + '일';
            
            ChannelIO('track', 'click_rematching', propertyObj);
        }
	    
	
	    
	    $(function(){
	    	//모바일 체크 처리
	    	var isMobile = /Mobi/i.test(window.navigator.userAgent);
	    	if (!isMobile) {
	    		$('.mobile-tel-btn').css('display', 'none');
	    	}
	    	
	    	
	        $('.mypage-consult-items').masonry({
	            itemSelector   : '.mypage-consult-item',
	            gutter         : '.mypage-consult-item-gutter',
	            percentPosition: true
	        });
	
	        $('.mypage-consult-toggle, .search-close').on('click', function() {
	            $('body').toggleClass('overflow-hidden').find('.mypage-consult-search').toggle();
	        });
	
	        $(window).on('resize', function() {
	            if(resize) $('body').removeClass('overflow-hidden').find('.mypage-consult-search').removeAttr('style');
	        });
	
	        $(".f_reconslt").on("click", function(e){
	        	let consltNo = $(this).data("consltNo");
	        	let bplcUniqueId = $(this).data("bplcUniqueId");
	        	let bplcConsltNo = $(this).data("bplcConsltNo");
				let consltmbrNm = $(this).attr("data-conslt-mbrNm")
				let consltmbrTelno = $(this).attr("data-conslt-mbrTelno")

	        	console.log(consltNo, bplcUniqueId, bplcConsltNo);
	
	        	$("#modalReConslt input[name='consltNo']").val(consltNo);
	        	$("#modalReConslt input[name='bplcUniqueId']").val(bplcUniqueId);
	        	$("#modalReConslt input[name='bplcConsltNo']").val(bplcConsltNo);
				$("#modalReConslt input[name='consltmbrNm']").val(consltmbrNm);
				$("#modalReConslt input[name='consltmbrTelno']").val(consltmbrTelno);
	        	$("#reqModal").modal('show');
	        });
	
	
	        $("#modalReConslt .btn-submit").on("click", function(){
	    		$("#modalReConslt").submit();
	    	});
	
	    	$("form[name='modalReConslt']").validate({
	    	    ignore: "input[type='text']:hidden, [contenteditable='true']:not([name])",
	    	    rules : {
	    	    	reconsltResn : { required : true}
	    	    },
	    	    messages : {
	    	    	reconsltResn : { required : "내용을 작성해 주세요"}
	    	    },
	    	    submitHandler: function (frm) {
	
	    	    	let consltNo = $("#modalReConslt input[name='consltNo']").val();
	    	    	let reconsltResn = $("#modalReConslt textarea[name='reconsltResn']").val();
	    	    	let bplcUniqueId = $("#modalReConslt input[name='bplcUniqueId']").val();
	    	    	let bplcConsltNo = $("#modalReConslt input[name='bplcConsltNo']").val();
					let consltmbrNm = $("#modalReConslt input[name='consltmbrNm']").val();
					let consltmbrTelno = $("#modalReConslt input[name='consltmbrTelno']").val();
	
	   	            if (confirm('해당 내역을 저장하시겠습니까?')) {
		   	            $.ajax({
		       				type : "post",
		       				url  : "./reConslt.json", //주문확인
		       				data : {
		       					consltNo:consltNo
		       					, reconsltResn:reconsltResn
		       					, bplcUniqueId:bplcUniqueId
		       					, bplcConsltNo:bplcConsltNo
								, consltmbrNm:consltmbrNm
								, consltmbrTelno:consltmbrTelno
		       				},
		       				dataType : 'json'
		       			})
		       			.done(function(data) {
		       				if(data.result){
		       					alert("정상적으로 저장되었습니다.");
		       					//$("#modalReConslt .btn-cancel").click();
		       					
		       					eventChannelTalk();
		       					
		       					window.location.reload();
		       				} else {
		       					alert(data.msg);
		       				}
		       			})
		       			.fail(function(data, status, err) {
		       				alert('재 상담 신청에 실패하였습니다. : ' + data);
		       			});
	   	        	}else{
	   	        		return false;
	   	        	}
	    	    }
	    	});
	
	    	// 멤버스 추가
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
	
	    	$(".f_cancel").on("click", function(e){
	        	let consltNo = $(this).data("consltNo");
				let consltmbrNm = $(this).attr("data-conslt-mbrNm")
				let consltmbrTelno = $(this).attr("data-conslt-mbrTelno")
	        	console.log(consltNo);
				console.log($(this).attr("data-conslt-mbrNm"));
				console.log($(this).attr("data-conslt-mbrTelno"));
	        	$("#modalCancel input[name='consltNo']").val(consltNo);
				$("#modalCancel input[name='consltmbrNm']").val(consltmbrNm);
				$("#modalCancel input[name='consltmbrTelno']").val(consltmbrTelno);

				console.log($("#modalCancel input[name='consltmbrTelno']").val())
				
	        	$("#cancelModal").modal('show');
	        });
	
	    	$(".btn-cancel-submit").on("click", function(e){
	    		e.preventDefault();
	
	    		let consltNo = $("#modalCancel input[name='consltNo']").val();
				let consltmbrNm = $("#modalCancel input[name='consltmbrNm']").val();
				let consltmbrTelno = $("#modalCancel input[name='consltmbrTelno']").val();
	    		let canclResn = $("#modalCancel textarea[name='canclResn']").val();

	
	    		let params = {
	    				consltNo:consltNo
						, consltmbrNm:consltmbrNm
						, consltmbrTelno:consltmbrTelno
	    				, canclResn:canclResn};
	
	    		if($("#canclResn").val() === ""){
	    			alert("취소 사유를 입력해 주세요");
	    			$("#canclResn").focus();
	    		}else{
	    			$.ajax({
	    				type : "post",
	    				url  : "./canclConslt.json",
	    				data : params,
	    				dataType : 'json'
	    			})
	    			.done(function(data) {
	    				if(data.result){
	    					alert("정상적으로 저장되었습니다.");
	    				}else{
	    					alert("상담 취소 처리중 에러가 발생하였습니다.");
	    				}
	    				location.reload();
	    			})
	    			.fail(function(data, status, err) {
	    				console.log("ERROR : " + err);
	    			});
	    		}
	
	
	    	});
	
	    });
    </script>
