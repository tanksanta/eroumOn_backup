<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
		
		<!--1.수급자 등록-->
		<c:if test="${_mbrSession.loginCheck && fn:length(mbrVO.mbrRecipientsList) == 0}">
        <div class="modal modal-default fade" id="regist-rcpt" tabindex="-1" aria-hidden="true">
            <div class="modal-dialog modal-dialog-centered">
                <div class="modal-content">
                    <div class="modal-header">
                        <h2 class="text-title">수급자(어르신) 등록</h2>
                        <button data-bs-dismiss="modal" class="btn-close">모달 닫기</button>
                    </div>
                    <div class="additional">
                        <i class="icon-alert"></i>
                        <p class="sr-guide-mention-1"></p>
                    </div>
                    <div class="modal-body">
						<jsp:include page="./include/addRecipientFormInSrModal.jsp"/>
                    </div>
                    <div class="modal-footer">
                        <button id="regist-rcpt-add-btn" type="button" class="btn-warning large2 flex-1 md:flex-none md:w-1/2 disabled" disabled onclick="addRecipientInSrNoReciModal();">등록하기</button>
                    </div>
                </div>
            </div>
        </div>
        </c:if>

        <!--2.수급자정보확인-->
        <c:if test="${_mbrSession.loginCheck}">
        <div class="modal modal-default fade" id="rcpts-confirm" tabindex="-1" aria-hidden="true" style="z-index:10000;">
            <div class="modal-dialog modal-dialog-centered">
                <div class="modal-content">
                    <div class="modal-header">
                        <h2 class="text-title">수급자(어르신) 정보 확인</h2>
                        <button data-bs-dismiss="modal" class="btn-close" onclick="$('#rcpts-select').modal('show');">모달 닫기</button>
                    </div>
                    <div class="additional">
                        <i class="icon-alert"></i>
                        <p class="sr-guide-mention-1"></p>
                    </div>
                    <div class="modal-body">
                        <div class="bg-box-beige">
                            <ul class="modal-list-box">
                                <li>
                                    <span class="modal-list-label">가족 관계</span>
                                    <span id="rcpts-confirm-relation-text" class="modal-list-value">본인</span>
                                </li>
                                <li>
                                    <span class="modal-list-label">수급자(어르신) 성명</span>
                                    <span id="rcpts-confirm-recipient-nm" class="modal-list-value">홍길동홍길동홍길동홍</span>
                                </li>
                                <li>
                                    <span class="modal-list-label">요양인정번호</span>
                                    <span id="rcpts-confirm-lno" class="modal-list-value">L0011436322</span>
                                </li>
                            </ul>
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn-warning large2 flex-1 md:flex-none md:w-1/2" onclick="checkInRcptsConfirmModal();">확인</button>
                    </div>
                </div>
            </div>
        </div>
        </c:if>

        <!--3.수급자선택-->
        <c:if test="${_mbrSession.loginCheck && fn:length(mbrVO.mbrRecipientsList) > 0}">
        <div class="modal modal-default fade" id="rcpts-select" tabindex="-1" aria-hidden="true">
            <div class="modal-dialog modal-dialog-centered modal-dialog-scrollable modal-lg">
                <div class="modal-content">
                    <div class="modal-content-inner rcpts-select-content">
                        <div class="modal-header">
                            <h2 class="text-title">수급자(어르신) 선택</h2>
                            <button data-bs-dismiss="modal" class="btn-close">모달 닫기</button>
                        </div>
                        <div class="additional-wrap">
                            <div class="additional">
                                <i class="icon-alert"></i>
                                <p class="sr-guide-mention-1"></p>
                            </div>
                        </div>
                        <div class="modal-body">
                            <div class="flex justify-end">
                                <a href="/membership/info/recipients/list" class="btn-black btn-small w-auto gap-1">수급자 관리 <i class="icon-arrow-right-white"></i></a>
                            </div>
                            <div class="radio-check-group md:min-w-100">
                            	<%-- 선택할 수급자 리스트 표출 --%>
                            	<c:forEach var="recipientInfo" items="${mbrVO.mbrRecipientsList}" varStatus="status">
                            		<div class="form-check">
	                                    <input class="form-check-input" type="radio" name="rcpts" id="rcpt${status.index}" value="${recipientInfo.recipientsNo}">
	                                    <label class="form-check-label <c:if test="${recipientInfo.recipientsYn eq 'Y'}">check-btn</c:if>" for="rcpt${status.index}">
	                                        <div class="rcpt-inner">
	                                            <div>
	                                                <img src="/html/page/members/assets/images/img-senoir-mono.svg" alt="시니어얼굴" class="img-senior"/>
	                                                <strong class="text-xl text-left">${recipientInfo.recipientsNm}</strong>
	                                            </div>
	                                            <c:choose>
	                                            	<c:when test="${recipientInfo.recipientsYn eq 'Y'}">
	                                            		<span>L${recipientInfo.rcperRcognNo}</span>
	                                            	</c:when>
	                                            	<c:otherwise>
	                                            		<button class="add-lno-btn" onclick="moveRegistLnoForm(${recipientInfo.recipientsNo});">등록하기 <i class="icon-round-plus"></i></button>
	                                            	</c:otherwise>
	                                            </c:choose>
	                                        </div>
	                                    </label>
	                                </div>
                            	</c:forEach>
                            	
                            	<c:if test="${fn:length(mbrVO.mbrRecipientsList) < 4}">
                            		<button id="add-rcpts" class="btn btn-dotted-warning btn-xlarge">추가등록 <i class="icon-round-plus"></i></button>
                            	</c:if>
                            </div>
                        </div>
                        <div class="modal-footer">
                            <button id="go-next-btn" type="button" class="btn-warning large2 flex-1 md:flex-none md:w-1/2" onclick="goNextInRcptsSelectModal();">진행하기</button>
                        </div>
                    </div>
                    <!--추가등록-->
                    <div class="modal-content-inner regist-rcpts">
                        <div class="modal-header">
                            <div class="flex items-center gap-4">
                                <button class="rcpts-back"><i class="icon-arrow-left size-md"></i></button>
                                <h2 class="text-title">수급자(어르신) 추가 등록</h2>
                            </div>
                            <button data-bs-dismiss="modal" class="btn-close">모달 닫기</button>
                        </div>
                        <div class="additional">
                            <i class="icon-alert"></i>
                            <p class="sr-guide-mention-1"></p>
                        </div>
                        <div class="modal-body">
                            <jsp:include page="./include/addRecipientFormInSrModal.jsp"/>
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn-outline-black large2 rcpts-back">이전으로</button>
                            <button id="regist-rcpt-add-btn" type="button" class="btn-warning large2 flex-1 md:flex-none md:w-1/2 disabled" disabled onclick="addRecipientInSrNoReciModal();">등록하기</button>
                        </div>
                    </div>
					<!--요양정보등록-->
                    <div class="modal-content-inner regist-lno">
                        <div class="modal-header">
                            <div class="flex items-center gap-4">
                                <button class="rcpts-back"><i class="icon-arrow-left size-md"></i></button>
                                <h2 class="text-title">요양인정번호 등록</h2>
                            </div>
                            <button data-bs-dismiss="modal" class="btn-close">모달 닫기</button>
                        </div>
                        <div class="additional">
                            <i class="icon-alert"></i>
                            <p>수급자(어르신)의 요양인정번호를 등록해 주세요</p>
                        </div>
                        <div class="modal-body">
                            <div class="radio-tabs-wrap" data-name="userType">
                                <div class="radio-tabs-content">
                                    <div class="w-full">
                                        <div class="flex flex-col gap-4">
                                        	<input id="sr-target-rcpt-no" type="hidden">
                                            <div id="regist-lno-other-text">
                                                수급자(어르신) <strong class="text-indexKey1 sr-recipient-nm">이영수</strong>님은 <strong>${mbrVO.mbrNm}</strong>님의 <strong class="sr-relation-text">형제</strong>입니다
                                            </div>
                                            <div id="regist-lno-me-text">
                                        		<strong class="text-xl">${mbrVO.mbrNm}</strong><span>님의</span>
                                        	</div>
                                            <div class="bg-white rounded-md p-5">
                                                <div class="text-index1 mb-2">요양인정번호는</div>
                                                <div>
                                                    <label for="rcpt-lno" class="rcpt-lno">
                                                        <input type="text" id="sr-regist-rcpt-lno" placeholder="뒤의 숫자 10자리 입력" class="form-control input-lno keycontrol numberonly" maxlength="10" oninput="checkUpdateLnoBtnDisable();">
                                                    </label>
                                                    <span>입니다</span>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div>
                                <p class="text-center font-medium mt-8 mb-2">정보가 잘못되었나요?</p>
                                <div class="text-center">
                                    <a href="/membership/info/recipients/list" class="text-path-box">마이페이지 &gt; 수급자관리</a>
                                    <span>에서 수정할 수 있어요</span>
                                </div>
                            </div>
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn-outline-black large2 rcpts-back">이전으로</button>
                            <button id="update-recipient-lno-btn" type="button" class="btn-warning large2 flex-1 md:flex-none md:w-1/2" onclick="registLnoInRecipient();">인정번호 등록하기</button>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        </c:if>

        <!-- 진행중인 상담 알림 모달 -->
        <div class="modal modal-default fade" id="notified-consulting" tabindex="-1" aria-hidden="true">
            <div class="modal-dialog  modal-dialog-centered">
                <div class="modal-content">
                    <div class="modal-header">
                        <h2 class="text-title">알림</h2>
                        <button data-bs-dismiss="modal" class="btn-close">모달 닫기</button>
                    </div>
                    <div class="modal-body">
                        <div class="bg-box-beige">
                            <div id="notified-consulting-guide-div" class="text-center text-xl">
                                진행중인 ((conslt_nm)) 상담이 있습니다. <br>
                                상담 내역을 확인하시겠습니까?
                            </div>
                        </div>
                    </div>
                    <div class="modal-footer gap-1">
                        <button type="button" class="btn-warning large2 w-full md:w-1/2" data-bs-dismiss="modal" class="btn-close" onclick="location.href='/membership/conslt/appl/list';">상담내역 확인하기</button>
                    </div>
                </div>
            </div>
        </div>

        <!-- 7.등록된 수급자가 없을 때 -->
        <div class="modal modal-default fade" id="sr-lno-check-modal" tabindex="-1" aria-hidden="true">
            <div class="modal-dialog modal-dialog-centered">
                <div class="modal-content">
                    <div class="modal-header">
                        <h2 class="text-title">요양인정번호 유무</h2>
                        <button data-bs-dismiss="modal" class="btn-close">모달 닫기</button>
                    </div>
                    <div class="additional-wrap">
                        <div class="additional">
                            <i class="icon-alert"></i>
                            <p>요양인정등급을 받으신 경우 ‘있어요' 를 선택해 주세요</p>
                        </div>
                        <div class="additional">
                            <i class="icon-alert"></i>
                            <p>요양인정등급이 없어도 상담이 가능해요</p>
                        </div>
                    </div>

                    <div class="modal-body">

                        <div class="radio-check-group">
                            <div  class="form-check">
                                <input class="form-check-input" type="radio" name="sr-lno-check-radio" id="rcpts-yn1" value="Y">
                                <label class="form-check-label" for="rcpts-yn1">
                                    <span class="mx-auto">있어요</span>
                                </label>
                            </div>
                            <div  class="form-check">
                                <input class="form-check-input" type="radio" name="sr-lno-check-radio" id="rcpts-yn2" value="N">
                                <label class="form-check-label" for="rcpts-yn2">
                                    <span class="mx-auto">없어요</span>
                                </label>
                            </div>
                            <div class="form-check">
                                <input class="form-check-input" type="radio" name="sr-lno-check-radio" id="rcpts-yn3" value="N">
                                <label class="form-check-label" for="rcpts-yn3">
                                    <span class="mx-auto">기억이 안나요</span>
                                </label>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>

		
        
        <script src="/html/core/vendor/twelements/index.min.js"></script>
	    <script>
	    	//수급자 추가 등록 첫 화면으로 이동
			function moveFirstPageInAddRcpts() {
				$('.regist-rcpts').removeClass('inactive').addClass('active');
                $('.rcpts-select-content').removeClass('active').addClass('inactive');
                $('.regist-lno').removeClass('active').addClass('inactive');
	    	}
	    	
	    	//모달내에서 뒤로가기 이동
	    	function moveBackPageInSrModal() {
	    		$('.regist-rcpts, .regist-lno').removeClass('active').addClass('inactive');
                $('.rcpts-select-content').removeClass('inactive').addClass('active');
	    	}
	    	
	        $(function () {
	            //수급자 등록, 요양정보 등록 팝업 div높이 구하기
	            $('#rcpts-select').on('shown.bs.modal', function () {
	                var modalContentHeight = $('.modal-content-inner').outerHeight();
	                var modalHeaderHeight = $('.modal-content-inner .modal-header').outerHeight();
	                var modalFooterHeight = $('.modal-content-inner .modal-footer').outerHeight();
	                var additionalHeight = $('.modal-content-inner .additional-wrap').outerHeight();
	                var maxModalHeight = $(window).height() - (modalHeaderHeight + modalFooterHeight + additionalHeight) - 80;
	                $('.modal-body').css('max-height', maxModalHeight + 'px');
	            });
	
	            //수급자 등록, 요양정보 등록
	            $('#add-rcpts').click(function () {
	            	if (sr_prevPath === 'test') {
	            		moveFirstPageInAddRcpts();	
	            	} else {
	            		//수급자 선택창 숨기기
	        			$('#rcpts-select').modal('hide');
	            		//L번호 있어요, 없어요 모달 띄우기
	            		$('#sr-lno-check-modal').modal('show');
	            	}
	            });
	
	            $('.rcpts-back').click(function () {
	            	moveBackPageInSrModal();
	            });
	
	            //요양인정번호 등록 로직은 아래 다른 곳에 구현
	            //$('.add-lno').click(function () {
	            //    $('.regist-rcpts, .rcpts-select-content').removeClass('active').addClass('inactive');
	            //    $('.regist-lno').removeClass('inactive').addClass('active');
	            //});
	
	            //수급자 등록 라디오버튼 탭 컨텐츠
	            function tabCheckEvent(name, css) {
	                const tabWrap = $('.radio-tabs-wrap[data-name="'+ name+'"]');
	                tabWrap.on('change', ':radio', function() {
	                    if ($(this).attr('name') !== name) return;
	
	                    const tabToShow = tabWrap.find('.tab.'+ $(this).val());
	                    const tabs = tabWrap.find('.tab.'+css);
	                    tabs.addClass('hidden');
	                    tabToShow.removeClass('hidden');
	
	                    const labels = tabWrap.find('label');
	                    labels.removeClass('is-active');
	                    $(this).closest('label').addClass('is-active');
	                    
	                    checkAddRecipientBtnDisable();
	                });
	            }
	
	            tabCheckEvent('userType', 'tab');
	            
	            
	            //L번호 있어요, 없어요 모달에서 이벤트 처리
	            $('input[name=sr-lno-check-radio]').click(function() {
	            	var answer = $('input[name=sr-lno-check-radio]:checked').val();
	            	
	            	$('#sr-lno-check-modal').modal('hide');
	            	
	            	//등록된 수급자가 없는 경우
	        		if (!sr_recipients || sr_recipients.length === 0) {
	        			//등록 모달폼 띄우기
        				openAddRecipientSrModal(answer);
	        		}
	        		//회원에 등록된 수급자가 있는 경우
	        		else {
	        			//수급자 선택창 띄우기
	        			$('#rcpts-select').modal('show');
	        			//등록 모달폼 셋팅(폼은 안뜸)
	        			openAddRecipientSrModal(answer);
	        			moveFirstPageInAddRcpts();
	        		}
	            });
	        });
	    </script>
        
        
        <script>
	    	var sr_recipients = null;
	    	var sr_prevPath = ''; 
	    	var sr_lnoCheck = null;
	    	var sr_relationCdMap = {
	    		<c:forEach var="relation" items="${relationCd}" varStatus="status">
	    			'${relation.key}': '${relation.value}',
	    		</c:forEach>
	    	};
	    	
        
	    	//수급자 정보 조회 후 수급자 선택모달 띄우기 요청
        	function openSelectRecipientModal(prevPath) {
        		sr_prevPath = prevPath;
        		
        		$.ajax({
            		type : "post",
    				url  : "/membership/info/myinfo/getMbrInfo.json",
    				dataType : 'json'
            	})
            	.done(function(data) {
            		//로그인 한 경우
            		if (data.isLogin) {
            			//ajax 받아온 데이터 저장
            			sr_recipients = data.mbrRecipients;
            			
            			modalSelectRecipient();
            		}
            		//로그인 안한 경우
            		else {
            			//테스트는 로그인 안할 때 띄우는 폼이 따로 있어 실제 실행은 안된다.
            			if (sr_prevPath === 'test') {
            				location.href='/membership/login?returnUrl=/main/cntnts/test';	
            			}
            			else if (sr_prevPath === 'equip_ctgry') {
            				location.href='/membership/login?returnUrl=/main/welfare/equip/sub';	
            			}
            		}
            	})
            	.fail(function(data, status, err) {
            		alert('서버와 연결이 좋지 않습니다.');
    			});
        	}
        	
	    	//수급자 선택 모달을 띄울지 L번호 있어요 모달을 띄울지 결정
        	function modalSelectRecipient() {
        		//등록된 수급자가 없는 경우
        		if (!sr_recipients || sr_recipients.length === 0) {
        			//인정등급상담은 L번호 있어요, 없어요 모달 스킵
        			if (sr_prevPath === 'test') {
        				//등록 모달폼 띄우기
        				openAddRecipientSrModal('N');
        			}
        			//다른 상담은 L번호 있어요 선택 모달 부터 시작
        			else {
        				$('#sr-lno-check-modal').modal('show');
        			}
        		}
        		//회원에 등록된 수급자가 있는 경우
        		else {
        			var consltNm = '';
        			
        			if (sr_prevPath === 'test') {
        				consltNm = '인정등급';
        				updateGuideMentionInSrModal('rcpts-select', ['수급자(어르신) 선택 후 테스트를 진행하세요']);
            			$('#rcpts-select #go-next-btn').text('테스트 진행하기');
            			
            			//등록 모달폼 띄우기(폼이 없으므로 추가등록쪽 셋팅만 된다.)
            			openAddRecipientSrModal('N');
        			} else if (sr_prevPath === 'equip_ctgry') {
        				consltNm = '관심 복지용구';
        				updateGuideMentionInSrModal('rcpts-select', ['수급자(어르신)를 선택해 주세요']);
            			$('#rcpts-select #go-next-btn').text('상담하기');
        			}
        			
        			//진행중인 상담 모달에 상담명 매핑
        			var guideDiv = $('#notified-consulting-guide-div').html();
        			guideDiv = guideDiv.replace('((conslt_nm))', consltNm);
        			$('#notified-consulting-guide-div').html(guideDiv);
        			
        			//수급자 선택창 띄우기
        			$('#rcpts-select').modal('show');
        		}
        	}
        	
	    	//L번호 있어요 또는 없어요 선택 시 등록폼을 다르게 구성
	    	function openAddRecipientSrModal(answer) {
	    		sr_lnoCheck = answer;
	    		
	    		//있어요 인 경우 L번호가 포함된 모달폼
	    		if (sr_lnoCheck === 'Y') {
	    			$('#regist-rcpt-lno').css('display','flex');
	    			
	    			$('.regist-rcpt-lno-no').css('display','none');
	    			$('span.regist-rcpt-lno-yes').css('display','inline');
	    			$('div.regist-rcpt-lno-yes').css('display','block');
	    		}
	    		//없어요 또는 기억이 안나요 선택시 L번호 미포함 모달폼
	    		else {
	    			$('#regist-rcpt-lno').css('display','none');
	    			
	    			$('.regist-rcpt-lno-yes').css('display','none');
	    			$('span.regist-rcpt-lno-no').css('display','inline');
	    			$('div.regist-rcpt-lno-no').css('display','block');
	    		}
	    		
	    		if (sr_prevPath === 'test') {
	    			updateGuideMentionInSrModal('regist-rcpt', ['테스트를 진행할 수급자(어르신)를 등록해 주세요']);	
	    		} else if (sr_prevPath === 'equip_ctgry') {
	    			updateGuideMentionInSrModal('regist-rcpt', ['수급자(어르신)를 등록해 주세요']);
	    		}
	    		
	    		$('#regist-rcpt').modal('show');
	    	}
	    	
	    	//모달에 안내문구 수정 함수
        	function updateGuideMentionInSrModal(modalId, mentArray) {
	    		if (mentArray && mentArray.length > 0) {
	    			for (var i = 0; i < mentArray.length; i++) {
	    				$('#' + modalId + ' .sr-guide-mention-' + (i + 1)).text(mentArray[i]);	    				
	    			}
	    		}
	    	}
	    	
	    	//등록하기 버튼 활성화 체크 함수(수급자 없을 때 모달, 수급자 있을 때 추가등록 모달)
	    	function checkAddRecipientBtnDisable() {
	    		setTimeout(callbackCheckInSrModal, 300);
	    	}
	    	function callbackCheckInSrModal() {
	    		var userType = $('input[name=userType]:checked').val();
	    		//가족
	    		if (userType === 'tab1') {
	    			var recipientNm = $('#no-rcpt-nm').val();
	    			var relationCd = $('#no-rcpt-relation').val();
	    			
	    			if (sr_lnoCheck === 'Y') {
	    				var lno = $('#no-rcpt-tab1-lno').val();
	    				if (recipientNm && relationCd && lno && lno.length === 10) {
		    				useAddRecipientBtn(true);
		    			} else {
		    				useAddRecipientBtn(false);
		    			}
	    			} else {
	    				if (recipientNm && relationCd) {
		    				useAddRecipientBtn(true);
		    			} else {
		    				useAddRecipientBtn(false);
		    			}	
	    			}
	    		}
	    		//본인
	    		else {
	    			if (sr_lnoCheck === 'Y') {
	    				var lno = $('#no-rcpt-tab2-lno').val();
	    				if (lno && lno.length === 10) {
	    					useAddRecipientBtn(true);	    					
	    				} else {
	    					useAddRecipientBtn(false);
	    				}
	    			} else {
	    				useAddRecipientBtn(true);
	    			}	
	    		}
	    	}
	    	function useAddRecipientBtn(use) {
	    		if (use) {
	    			$('#regist-rcpt-add-btn').removeClass('disabled');
	    			$('#regist-rcpt-add-btn').removeAttr('disabled');	
	    		} else {
	    			$('#regist-rcpt-add-btn').addClass('disabled');
	    			$('#regist-rcpt-add-btn').attr('disabled', true);
	    		}
	    	}
	    	
	    	//수급자 등록하기(수급자 없을 때 모달에서)
	    	function addRecipientInSrNoReciModal() {
	    		var userType = $('input[name=userType]:checked').val();
	    		
	    		//가족
	    		if (userType === 'tab1') {
	    			var recipientNm = $('#no-rcpt-nm').val();
	    			var relationCd = $('#no-rcpt-relation').val();
	    			var lno = null;
	    			if (sr_lnoCheck === 'Y') {
	    				lno = $('#no-rcpt-tab1-lno').val();
	    			}
	    			
	    			$('#rcpts-select').modal('hide');
	    			openRcptsConfirmModal(relationCd, recipientNm, lno);
	    		}
	    		//본인
	    		else {
	    			var lno = null;
	    			if (sr_lnoCheck === 'Y') {
	    				lno = $('#no-rcpt-tab2-lno').val();
	    			}
	    			ajaxAddMbrRecipient('007', 'me', lno);
	    		}
	    	}
	    	
	    	//수급자 입력정보 확인 모달
	    	function openRcptsConfirmModal(relationCd, recipientNm, lno) {
	    		$('#rcpts-confirm-relation-text').text(sr_relationCdMap[relationCd]);
	    		$('#rcpts-confirm-recipient-nm').text(recipientNm);
	    		
	    		if (lno) {
	    			$('#rcpts-confirm-lno').text(lno);
	    			$('#rcpts-confirm-lno').parent().css('display', 'flex');
	    		} else {
	    			$('#rcpts-confirm-lno').parent().css('display', 'none');
	    		}
	    		
	    		if (sr_prevPath === 'test') {
	    			updateGuideMentionInSrModal('rcpts-confirm', ['수급자(어르신) 정보가 올바른지 확인 후 테스트를 진행하세요']);	
	    		} else if (sr_prevPath === 'equip_ctgry') {
	    			updateGuideMentionInSrModal('rcpts-confirm', ['수급자(어르신) 정보가 올바른지 확인해 주세요']);
	    		}
	    		
    			$('#rcpts-confirm').modal('show');
	    	}
	    	
	    	//수급자 입력정보 확인 모달에서 확인버튼 클릭
	    	function checkInRcptsConfirmModal() {
	    		var relationText = $('#rcpts-confirm-relation-text').text().trim();
	    		var relationCd = Object.keys(sr_relationCdMap).find(key => sr_relationCdMap[key] === relationText);
	    		var recipientNm = $('#rcpts-confirm-recipient-nm').text().trim();
	    		lnoDisplay = $('#rcpts-confirm-lno').parent().css('display');
	    		
				if (lnoDisplay === 'none') {
					ajaxAddMbrRecipient(relationCd, recipientNm);
				} else {
					var lno = $('#rcpts-confirm-lno').text();
					
					ajaxAddMbrRecipient(relationCd, recipientNm, lno);
				}
	    	}
	    	
	    	
	    	//수급자 선택모달에서 다음 진행하기 버튼 클릭
	    	function goNextInRcptsSelectModal() {
	    		var recipientNo = $('input[name=rcpts]:checked').val();
	    		if (!recipientNo) {
	    			alert('수급자를 선택하세요');
	    			return;
	    		}
	    		
	    		//진행중인 상담 조회 api
        		$.ajax({
            		type : "post",
    				url  : "/membership/info/myinfo/getRecipientConsltSttus.json",
    				data : {
    					recipientsNo : recipientNo,
    					prevPath : sr_prevPath
    				},
    				dataType : 'json'
            	})
            	.done(function(data) {
            		//해당 수급자가 진행중인 상담이 있는 경우
            		if (data.isExistRecipientConslt) {
            			$('#notified-consulting').modal('show').appendTo('body');
            		} else {
            			//해당 수급자가 기타(친척)인 경우 관계 변경을 위해 마이페이지 수급자 상세로 redirect
            			var srchRecipient = sr_recipients.filter(f => f.recipientsNo == recipientNo)[0];
            			if (srchRecipient.relationCd === '100') {
            				alert('수급자 관계를 수정해 주세요');
            				location.href = '/membership/info/recipients/view?recipientsNo=' + srchRecipient.recipientsNo;
            				return;
            			}
            			
            			goNextStepWithRecipientNo(recipientNo);
            		}
            	})
            	.fail(function(data, status, err) {
            		alert('서버와 연결이 좋지 않습니다.');
    			});
	    	}
	    	
	    	
	    	//수급자 등록 ajax 요청
	    	function ajaxAddMbrRecipient(relationCd, recipientsNm, lno) {
	    		if (!relationCd || !recipientsNm) {
	        		alert('모두 입력해주세요');
	        		return;
	        	}
	    		if (sr_lnoCheck === 'Y' && !lno) {
	    			alert('모두 입력해주세요');
	    			return;
	    		}
	    		
	    		var data = {
					relationCd
					, recipientsNm
				};
	    		if (lno) {
	    			data.rcperRcognNo = lno;
	    		};
	    		
	    		//더블클릭 방지를 위해 공통API함수 사용
	    		jsCallApi.call_api_post_json(window, "/membership/info/myinfo/addMbrRecipient.json", "addMbrRecipientCallbackInSrModal", data);
	    	}
	    	//수급자 등록 콜백
	    	function addMbrRecipientCallbackInSrModal(result, errorResult, data, param) {
	    		if (errorResult == null) {
		    		var data = result;
		    		
		    		if(data.success) {
	        			alert('수급자가 등록되었습니다.');
	        			goNextStepWithRecipientNo(data.createdRecipientsNo);
	        		}else{
	        			alert(data.msg);
	        		}
	    		} else {
		    		alert('서버와 연결이 좋지 않습니다');
		    	}
	    	}
	    	
	    	//다음 단계로 이동 함수
	    	function goNextStepWithRecipientNo(recipientNo) {
	    		if (sr_prevPath === 'test') {
	    			location.href = '/test/physical?recipientsNo=' + recipientNo;
    			}
    			else if (sr_prevPath === 'equip_ctgry') {
    				location.href = '/main/welfare/equip/list?recipientsNo=' + recipientNo;
    			}
	    	}
	    	
	    	
	    	//요양정보등록하기 모달로 이동
	    	function moveRegistLnoForm(recipientNo) {
	    		var recipientInfo = sr_recipients.find(f => f.recipientsNo === recipientNo);
	    		
	    		if (recipientInfo.relationCd === '007') {
	    			$('#regist-lno-other-text').css('display', 'none');
	    			$('#regist-lno-me-text').css('display', 'block');
	    		} else {
	    			$('#regist-lno-other-text').css('display', 'block');
	    			$('#regist-lno-me-text').css('display', 'none');
	    			
	    			$('#regist-lno-other-text .sr-recipient-nm').text(recipientInfo.recipientsNm);
	    			$('#regist-lno-other-text .sr-relation-text').text(sr_relationCdMap[recipientInfo.relationCd]);
	    		}
	    		
	    		//L번호 입력창 초기화
	    		$('#sr-regist-rcpt-lno').val('');
	    		checkUpdateLnoBtnDisable();
	    		
	    		//요양정보 등록으로 이동
	    		$('#sr-target-rcpt-no').val(recipientNo);
	    		$('.regist-rcpts, .rcpts-select-content').removeClass('active').addClass('inactive');
	            $('.regist-lno').removeClass('inactive').addClass('active');
	    	}
	    	
	    	//인정번호 등록하기 버튼 활성화 처리
	    	function checkUpdateLnoBtnDisable() {
	    		setTimeout(callbackLnoCheckInSrModal, 300);
	    	}
	    	function callbackLnoCheckInSrModal() {
	    		var lno = $('#sr-regist-rcpt-lno').val();
	    		if (lno && lno.length === 10) {
	    			$('#update-recipient-lno-btn').removeClass('disabled');
	    		} else {
	    			$('#update-recipient-lno-btn').addClass('disabled');
	    		}
	    	}
	    	
	    	//요양정보수정 API
	    	function registLnoInRecipient() {
	    		var recipientNo = $('#sr-target-rcpt-no').val();
	    		var lno = $('#sr-regist-rcpt-lno').val();
	    		if (!recipientNo || !lno) {
	    			alert('모두 입력하세요');
	    			return;
	    		}
	    		
	    		$.ajax({
		    		type : "post",
		    		url  : "/membership/info/myinfo/updateRecipientLno.json",
		    		data : { 
		    			recipientsNo : Number(recipientNo),
		    			rcperRcognNo : lno, 
		    		},
		    		dataType : 'json'
		    	})
		    	.done(function(data) {
		    		if(data.success) {
		    			alert('요양인정번호가 등록되었습니다');
		    			moveSelectRecipientModal(recipientNo, lno);
		    		}else{
		    			alert(data.msg);
		    		}
		    	})
		    	.fail(function(data, status, err) {
		    		alert('서버와 연결이 좋지 않습니다.');
		    	});	
	    	}
	    	
	    	//요양정보수정 후 수급자 선택창으로 이동
	    	function moveSelectRecipientModal(recipientNo, lno) {
	    		var targetInput = null;
	    		var recipientInputs = $('input[name=rcpts]');
	    		for (var i = 0; i < recipientInputs.length; i++) {
	    			if (recipientInputs[i].value === recipientNo) {
	    				targetInput = recipientInputs[i];
	    			}
	    		}
	    		
	    		//수급자 선택화면의 해당 수급자 버튼쪽 UI수정
	    		$(targetInput).parent().find('.add-lno-btn').remove();
	    		$(targetInput).parent().find('.form-check-label').addClass('check-btn');
	    		$(targetInput).parent().find('.rcpt-inner').append('<span>L' + lno + '</span>');
	    		
	    		//이전으로 이동
	    		moveBackPageInSrModal();
	    	}
        </script>