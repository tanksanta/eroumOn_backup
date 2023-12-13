<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<header id="subject">
    <nav class="breadcrumb">
        <ul>
			<li class="home"><a href="${_mainPath}">홈</a></li>
			<li>이로움 서비스</li>
            <li>관심 복지용구 상담</li>
        </ul>
    </nav>

</header>

<div id="content">
	<div class="grade-content1 welfare-equip">
        <h2 class="grade-title2">관심 복지용구 상담</h2>
        <p class="grade-text2 mt-10">
            <strong class="text-hightlight-orange font-bold">필요한 복지용구</strong>를 선택한 후<br>
            혜택을 확인하고 <strong class="text-hightlight-orange font-bold">구매 신청해보세요</strong>
        </p>
        <div class="grade-start mt-11 md:mt-15">
            <div class="picture">
                <img src="/html/page/index/assets/images/img-welfare-start.png" class="hidden md:block" alt="관심 복지용구 상담 이미지">
                <img src="/html/page/index/assets/images/img-welfare-start-m.png" class="md:hidden" alt="관심 복지용구 상담 모바일 이미지">
                <div class="msg1" aria-hidden="true">
                    <div class="box">
                        어머니 상태에 도움이 되는<br>
                        <strong>복지용구</strong>를 신청하고 싶어요
                    </div>
                    <svg xmlns="http://www.w3.org/2000/svg" width="46" height="25" viewBox="0 0 46 25" fill="none">
                        <g filter="url(#filter0_d_518_4641)">
                        <path d="M37.6807 13.7944C24.8807 14.1944 18.4047 4.52527 14.9047 1.02527C6.57133 -0.808059 -7.31903 -1.20563 4.68097 8.79437C16.681 18.7944 30.514 16.961 37.6807 13.7944Z" fill="#333333"/>
                        </g>
                        <defs>
                        <filter id="filter0_d_518_4641" x="0" y="0" width="45.6807" height="24.3057" filterUnits="userSpaceOnUse" color-interpolation-filters="sRGB">
                        <feFlood flood-opacity="0" result="BackgroundImageFix"/>
                        <feColorMatrix in="SourceAlpha" type="matrix" values="0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 127 0" result="hardAlpha"/>
                        <feOffset dx="4" dy="4"/>
                        <feGaussianBlur stdDeviation="2"/>
                        <feComposite in2="hardAlpha" operator="out"/>
                        <feColorMatrix type="matrix" values="0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0.1 0"/>
                        <feBlend mode="normal" in2="BackgroundImageFix" result="effect1_dropShadow_518_4641"/>
                        <feBlend mode="normal" in="SourceGraphic" in2="effect1_dropShadow_518_4641" result="shape"/>
                        </filter>
                        </defs>
                    </svg>
                </div>
                <div class="msg2" aria-hidden="true">
                    <div class="box">
                        지팡이, 보행기가 필요한데<br>
                        받을 수 있는 <strong>복지용구를 알고 싶어요</strong>
                    </div>
                    <svg xmlns="http://www.w3.org/2000/svg" width="46" height="25" viewBox="0 0 46 25" fill="none">
                        <g filter="url(#filter0_d_518_4641)">
                        <path d="M37.6807 13.7944C24.8807 14.1944 18.4047 4.52527 14.9047 1.02527C6.57133 -0.808059 -7.31903 -1.20563 4.68097 8.79437C16.681 18.7944 30.514 16.961 37.6807 13.7944Z" fill="#333333"/>
                        </g>
                        <defs>
                        <filter id="filter0_d_518_4641" x="0" y="0" width="45.6807" height="24.3057" filterUnits="userSpaceOnUse" color-interpolation-filters="sRGB">
                        <feFlood flood-opacity="0" result="BackgroundImageFix"/>
                        <feColorMatrix in="SourceAlpha" type="matrix" values="0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 127 0" result="hardAlpha"/>
                        <feOffset dx="4" dy="4"/>
                        <feGaussianBlur stdDeviation="2"/>
                        <feComposite in2="hardAlpha" operator="out"/>
                        <feColorMatrix type="matrix" values="0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0.1 0"/>
                        <feBlend mode="normal" in2="BackgroundImageFix" result="effect1_dropShadow_518_4641"/>
                        <feBlend mode="normal" in="SourceGraphic" in2="effect1_dropShadow_518_4641" result="shape"/>
                        </filter>
                        </defs>
                    </svg>
                </div>
                <button onclick="searchRecipients();" class="btn-welfare btn btn-large2 btn-primary2 btn-arrow">
					<strong>복지용구 선택하기</strong>
				</button>
            </div>

        </div>
    
        <a href="/main/cntnts/test" class="text-link">
            요양인정번호가 없으세요?
        </a>
    </div>

    <div class="grade-content2 welfare-equip">
        <h2 class="grade-title">
            <small>관심 복지용구 상담</small>
            <span class="font-normal">필요한 복지용구</span> 
            상담부터<br> 
            <span class="font-normal">복지용구</span> 구매 신청까지 한번에
        </h2>
        <div class="grade-rolling mt-13 md:mt-23">
            <div class="container">
                <div class="rolling-item1 is-active">
                    <div class="grade-rolling-inner">
                        <div class="item-thumb">
                            <img src="/html/page/index/assets/images/img-grade-rolling1.svg" alt="여자얼굴 이미지">
                        </div>
                        <div class="item-content">
                            복지용구를 고르기 어려워서<br>
                            <strong>추천 받고 싶어요</strong>
                        </div>
                    </div>
                </div>
                <div class="rolling-item2">
                    <div class="grade-rolling-inner">
                        <div class="item-thumb">
                            <img src="/html/page/index/assets/images/img-grade-rolling2.svg" alt="할머니얼굴 이미지">
                        </div>
                        <div class="item-content">
                            지팡이, 보행기가 필요한데<br>
                            <strong>받을 수 있는 복지용구를 알고 싶어요</strong>
                        </div>
                    </div>
                </div>
                <div class="rolling-item3">
                    <div class="grade-rolling-inner">
                        <div class="item-thumb">
                            <img src="/html/page/index/assets/images/img-grade-rolling4.svg" alt="남자얼굴 이미지">
                        </div>
                        <div class="item-content">
                            어머니 상태에 도움이 되는<br>
                            <strong>복지용구를 신청하고 싶어요</strong>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <div class="grade-content3 welfare-equip">
        <h2 class="grade-title">
            <small>관심 복지용구 상담</small>
            받을 수 있는 혜택 확인
        </h2>
        
        <div class="content-box">
            <div class="text-center text-2xl">
                <p class="tracking-normal">관심있는 <strong>복지용구</strong>를 바탕으로</p>
                <p><span class="text-indexKey1">100%~85% 지원 혜택</span>을 받을 수 있는 지 알려드려요</p>
            </div>
            <img src="/html/page/index/assets/images/img-welfare-content3.png" alt="관심있는 복지용구를 바탕으로 100%~85% 지원 혜택을 받을 수 있는 지 알려드려요">
        </div>
    </div>

    <div class="grade-content4 welfare-equip">
        <h2 class="grade-title">
            <small>관심 복지용구 상담</small>
            필요한 복지용구 추천
        </h2>
        
        <div class="content-box">
            <div class="text-center text-2xl">
                <p class="tracking-normal">다양한 복지용구 상품 중</p>
                <p><span class="text-indexKey1">어르신 상태</span>에 도움이 되는 <span class="text-indexKey1">상품을 추천해드려요</span></p>
            </div>
            <img src="/html/page/index/assets/images/img-welfare-content4.png" alt="다양한 복지용구 상품 중 어르신 상태에 도움이 되는 상품을 추천해드려요">
        </div>
    </div>

    <div class="grade-content3 welfare-equip">
        <h2 class="grade-title">
            <small>관심 복지용구 상담</small>
            간편한 구매 신청
        </h2>
        
        <div class="content-box">
            <div class="text-center text-2xl">
                <p class="tracking-normal">필요한 복지용구 상품을</p>
                <p><span class="text-indexKey1">간편하게 구매</span>할 수 있도록 도와드려요</p>
            </div>
            <img src="/html/page/index/assets/images/img-welfare-content5.png" alt="복지용구 상담 도와드려요">
        </div>
    </div>

    <div class="text-center text-xl md:text-4xl">
        <span class="text-hightlight-orange font-bold">필요한 복지용구</span>를 선택한 후<br>
        혜택을 확인하고 <span class="text-hightlight-orange font-bold">구매 신청해보세요</span>
    </div>

	<a href="/main/welfare/equip/list" id="search-recipients" class="grade-floating">
        <strong>복지용구 선택하기</strong>
    </a>
	

	<!--로그인사용자 : 등록된 수급자 없는 경우-->
	<div class="modal modal-index fade" id="login-no-rcpt" tabindex="-1" aria-hidden="true">
	    <div class="modal-dialog modal-dialog-centered">
	        <div class="modal-content">
	            <div class="modal-header">
	                <h2 class="text-title">수급자 선택</h2>
	                <button data-bs-dismiss="modal" class="btn-close">모달 닫기</button>
	            </div>
	            <div class="modal-body space-no-horizonal">
	                <div class="flex flex-col justify-center items-end gap-1">
	                    <select name="no-rcpt-relation" id="no-rcpt-relation" class="form-control w-full">
	                    	<option value="">관계 선택</option>
							<c:forEach var="relation" items="${mbrRelationCode}" varStatus="status">
								<option value="${relation.key}">${relation.value}</option>	
							</c:forEach>
	                    </select>
	                    <input type="text" name="no-rcpt-nm" id="no-rcpt-nm" placeholder="수급자 성명" class="form-control w-full">
	                    <div class="flex w-full">
	                    	<p class="px-1.5 font-serif text-[1.375rem] font-bold md:text-2xl">L</p>
	                    	<input type="text" name="no-rcpt-nm" id="no-rcpt-lno" placeholder="요양인정번호" class="form-control w-full">
	                    </div>
	                </div>
	            </div>
	            <div class="modal-footer">
	                <button type="button" class="btn btn-primary large flex-1 md:flex-none md:w-70" onclick="startLoginNoRcpt();">조회하기</button>
	            </div>
	        </div>
	    </div>
	</div>
	
	<!--로그인사용자 : 등록 수급자 n명이상인 경우-->
	<div class="modal modal-index fade" id="login-rcpts" tabindex="-1" aria-hidden="true">
	    <div class="modal-dialog modal-dialog-centered">
	    <div class="modal-content">
	        <div class="modal-header">
	        <h2 class="text-title">수급자 선택</h2>
	        <button data-bs-dismiss="modal" class="btn-close">모달 닫기</button>
	        </div>
	        <div class="modal-body space-no-horizonal items-end">
	         <div class="form-radio-button-group" id="recipient-list">
	             
	         </div>
	         <a href="/membership/info/recipients/list"class="underline text-blue3 text-sm">수급자 관리</a>
	         
	         
	         <!--추가 등록-->
	         <div id="registRecipientForm" style="display: block; width: 100%;">
	             
	         </div>
	        </div>
	        <div class="modal-footer">
	        <button type="button" class="btn btn-primary large flex-1 md:flex-none md:w-70" onclick="startloginRcpts();">시작하기</button>
	        </div>
	    </div>
	    </div>
	</div>
	
	<!-- 수급자정보등록 팝업소스 -->
	<div class="modal modal-index fade" id="regist-rcpt" tabindex="-1" aria-hidden="true">
	    <div class="modal-dialog modal-dialog-centered">
	        <div class="modal-content">
	            <div class="modal-header">
	                <h2 class="text-title">수급자 정보 등록</h2>
	                <button data-bs-dismiss="modal" class="btn-close">모달 닫기</button>
	            </div>
	            <div class="modal-body space-no-horizonal">
	            <div class="flex flex-col">
	                <div class="text-subtitle">
	                    <i class="icon-alert"></i>
	                    <p>테스트를 하려면 수급자 등록이 필요해요</p>
	                </div>
	                <div class="text-subtitle">
	                    <i class="icon-alert"></i>
	                    <p>등록하려는 수급자 정보를 확인하세요</p>
	                </div>
	                <div class="text-subtitle">
	                    <i class="icon-alert"></i>
	                    <p>회원이 이용약관에 따라 수급자 등록과 관리하는 것에 동의합니다</p>
	                </div>
	            </div>
	            <div class="modal-bg-wrap">
	                <ul class="modal-list-box">
	                	<input id="modal-recipient-relation-cd" type="hidden" value="">
	                    <li>
	                        <span class="modal-list-label">수급자와의 관계</span>
	                        <span class="modal-list-value" id="modal-recipient-relation">본인</span>
	                    </li>
	                    <li>
	                        <span class="modal-list-label">수급자 성명</span>
	                        <span class="modal-list-value" id="modal-recipient-nm">홍길동</span>
	                    </li>
	                    <li>
	                        <span class="modal-list-label">요양인정번호</span>
	                        <span class="modal-list-value" id="modal-recipient-lno">L1234512345</span>
	                    </li>
	                </ul>
	            </div>
	            <div class="text-subtitle">
	                <i class="icon-alert"></i>
	                <p>요양인정번호는 마이페이지에서 등록하실 수 있어요</p>
	            </div>
	            </div>
	            <div class="modal-footer">
	                <button type="button" class="btn btn-primary w-full" onclick="clickRegistRecipient();">확인</button>
	            </div>
	        </div>
	    </div>
	</div>

	<!--알림 팝업소스-->
    <div class="modal modal-index fade" id="notified-consulting" tabindex="-1" aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content">
            <div class="modal-header">
            <h2 class="text-title">알림</h2>
            <button data-bs-dismiss="modal" class="btn-close">모달 닫기</button>
            </div>
            <div class="modal-body">
            <div class="modal-bg-wrap">
                <div class="flex flex-col justify-center items-center">
                <div class="text-center text-xl">
                    <p>진행중인 관심 복지용구 상담이 있습니다</p>
                    <p>상담내역을 확인하시겠습니까?</p>
                </div>
                </div>
            </div>
            </div>
            <div class="modal-footer gap-1">
	            <button type="button" class="btn btn-primary large flex-initial w-55" onclick="location.href='/membership/conslt/appl/list'">상담내역 확인하기</button>
	            
	            <!-- 새롭게 진행하기 버튼 제거 -->
	            <!-- <button type="button" class="btn btn-outline-primary large flex-initial w-45" onclick="createNewConslt();">새롭게 진행하기</button> -->
            </div>
        </div>
        </div>
    </div>


	<script>
		var mbrNm = null;
		var recipients = null;
	
		//펼치기 접기
	    function toggleText() {
	        const el = document.querySelector(".btn-toggle-box");
	        const icon = document.querySelector(".icon-collapse");
	        const text = document.querySelector(".btn-collapse > span")
	        
	        if (el.classList.contains("collapsed") ) {
	            icon.classList.remove("expand")
	            text.textContent = "펼치기";
	        } else {
	            icon.classList.add("expand")
	            text.textContent =  "접기";
	        }
	    }
		
	  	//요양정보 조회하기 버튼 클릭
	    function searchRecipients() {
	    	$.ajax({
	    		type : "post",
				url  : "/membership/info/myinfo/getMbrInfo.json",
				dataType : 'json'
	    	})
	    	.done(function(data) {
	    		//로그인 한 경우
	    		if (data.isLogin) {
	    			//ajax 받아온 데이터 저장
	    			mbrNm = data.mbrVO.mbrNm;
	    	    	recipients = data.mbrRecipients;
	    			
	    	    	modalRecipient();
	    		}
	    		//로그인 안한 경우
	    		else {
	    			location.href='/membership/login?returnUrl=/main/welfare/equip/sub'
	    		}
	    	})
	    	.fail(function(data, status, err) {
	    		alert('서버와 연결이 좋지 않습니다.');
			});
	    }
	  	
	  	//수급자 없는 모달 또는 등록된 수급자 있는 모달 띄우기
	    function modalRecipient() {
	    	$('#notified-consulting').modal('hide');
	    	
	    	//등록된 수급자가 없는 경우
			if(!recipients || recipients.length === 0) {
				$('#login-no-rcpt').modal('show').appendTo('body');
			}
			//기존에 등록한 수급자가 있는 경우
			else {
				var template = '';
				
				//수급자 선택 박스 생성
				for (var i = 0; i < recipients.length; i++) {
					template += `<div  class="form-check">
	                    <input class="form-check-input" type="radio" name="rcpts" id="rcpt` + i + `" value="` + recipients[i].recipientsNo + `"` + (recipients[i].mainYn === 'Y' ? `checked` : ``) + `>
	                    <label class="form-check-label" for="rcpt` + i + `">` + recipients[i].recipientsNm + `</label>
	                </div>`;
				}
				$('#recipient-list').html(template);
				
				//직접입력하기 폼 추가(등록된 수급자가 4명 미만인 경우)
				if (recipients.length < 4) {
					template = getRegistRecipientForm();
					
					$('#registRecipientForm').html(template);
				} else {
					$('#registRecipientForm').html('');
				}
				
				$('#login-rcpts').modal('show').appendTo('body');
			}
	    }
	  	
	  	//수급자가 없는 모달 시작하기
	    function startLoginNoRcpt() {
	    	var relationCd = $('#no-rcpt-relation option:selected').val();
	    	var relationText = $('#no-rcpt-relation option:selected').text();
	    	var recipientsNm = $('#no-rcpt-nm').val();
	    	var recipientsLno = $('#no-rcpt-lno').val();
	    	
	    	if (!relationCd || !recipientsNm || !recipientsLno) {
	    		alert('모두 입력해주세요');
	    		return;
	    	}
	    	if (relationCd === '007' && mbrNm !== recipientsNm) {
	    		alert('수급자와의 관계를 확인해주세요');
	    		return;
	    	}
	    	
	    	recipientsLno = 'L' + recipientsLno;
	    	mappingRecipientModal(relationCd, relationText, recipientsNm, recipientsLno);
	    }
	  	
	  	//등록된 수급자가 있는 모달 시작하기
	    function startloginRcpts() {
	    	var el = document.querySelector(".btn-toggle-box");
	    	var isRegist = !el ? true : el.classList.contains("collapsed");
	    	  
	    	//수급자 선택인 경우
	    	if (isRegist) {
	    		//등록된 수급자 선택값 가져오기
	        	var radioRecipientsNo =  $('input[name=rcpts]:checked').val();
	        	if (!radioRecipientsNo) {
	    			alert('수급자를 선택하세요');
	    			return;
	    		}
	        	
	        	var recipientInfo = recipients.filter(f => f.recipientsNo === Number(radioRecipientsNo))[0];
	        	if (!recipientInfo.rcperRcognNo) {
	        		alert('마이페이지 수급자 관리에서 요양인정번호를 등록해주세요');
	        		return;
	        	}
	    		
	        	
	        	//진행중인 상담 조회 api
	        	$.ajax({
            		type : "post",
    				url  : "/membership/info/myinfo/getRecipientConsltSttus.json",
    				data : {
    					recipientsNo : radioRecipientsNo,
    					prevPath : 'equip_ctgry'
    				},
    				dataType : 'json'
            	})
            	.done(function(data) {
            		//해당 수급자가 진행중인 상담이 있는 경우
            		if (data.isExistRecipientConslt) {
            			$('#notified-consulting').modal('show').appendTo('body');
            		} else {
            			location.href = '/main/welfare/equip/list?recipientsNo=' + radioRecipientsNo;
            		}
            	})
            	.fail(function(data, status, err) {
            		alert('서버와 연결이 좋지 않습니다.');
    			});
	        	
	    	}
	    	//직접입력하기인 경우
	    	else {
	    		//직접 입력하기 수급자 정보
	        	var relationCd = $('#login-rcpts-relation option:selected').val();
	        	var relationText = $('#login-rcpts-relation option:selected').text();
	        	var recipientsNm = $('#login-rcpts-nm').val();
	        	var recipientsLno = $('#login-rcpts-lno').val();
	        	
	        	if (!relationCd || !recipientsNm || !recipientsLno) {
	        		alert('모두 입력해주세요');
	        		return;
	        	}
	        	
	        	//본인과 배우자는 한명만 등록이 가능하다.
	        	if (relationCd === '007' && recipients.findIndex(f => f.relationCd === '007') !== -1) {
	        		alert('본인은 한명만 등록이 가능합니다.')
	        		return;
	        	}
	        	else if (relationCd === '001' && recipients.findIndex(f => f.relationCd === '001') !== -1) {
	        		alert('배우자는 한명만 등록이 가능합니다.')
	        		return;
	        	}
	        	
	        	recipientsLno = 'L' + recipientsLno;
	        	mappingRecipientModal(relationCd, relationText, recipientsNm, recipientsLno);
	    	}
	    }
	  	
	    var clickRegistRecipient_click = false;
	  	//새로 등록할 수급자 확인
	    function clickRegistRecipient() {
	    	var relationCd = $('#modal-recipient-relation-cd').val();
	    	var recipientsNm = $('#modal-recipient-nm').text();
	    	var rcperRcognNo = $('#modal-recipient-lno').text();
	    	var rcperRcognNo = rcperRcognNo.replace('L', '');
	
	        if (clickRegistRecipient_click){
	            return;
	        }
	
	        clickRegistRecipient_click = true;
	    	
	    	$.ajax({
	    		type : "post",
				url  : "/membership/info/myinfo/addMbrRecipient.json",
				data : {
					relationCd
					, recipientsNm
					, rcperRcognNo
				},
				dataType : 'json'
	    	})
	    	.done(function(data) {
	            clickRegistRecipient_click = false;
	    		if(data.success) {
	    			alert('수급자가 등록되었습니다');
	    			
	    			location.href = '/main/welfare/equip/list?recipientsNo=' + data.createdRecipientsNo;
	    		}else{
	    			alert(data.msg);
	    		}
	    	})
	    	.fail(function(data, status, err) {
	    		alert('서버와 연결이 좋지 않습니다.');
			});
	    }
	
	    
	    //등록하려는 수급자 확인 모달값 매핑
	    function mappingRecipientModal(relationCd, relationText, recipientsNm, recipientsLno) {
	    	$('#modal-recipient-relation-cd').val(relationCd);
	    	$('#modal-recipient-relation').text(relationText);
	    	$('#modal-recipient-nm').text(recipientsNm);
	    	$('#modal-recipient-lno').text(recipientsLno);
	    	$('#regist-rcpt').modal('show').appendTo('body');
	    }
	    
	    //직접입력하기(수급자 등록) 폼 반환
	    function getRegistRecipientForm() {
	    	return `
	    	<div class="flex flex-col gap-2">
	            <a href="#direct-rcpt" data-bs-toggle="collapse" aria-expanded="false" class="btn-toggle-box collapsed">
	                <p class="text-gray5">추가 등록</p>
	                <div class="btn-collapse" onclick="toggleText()">
	                    <span>펼치기</span>
	                    <i class="icon-collapse">펼치기/접기</i> 
	                </div>
	            </a>
	            <div id="direct-rcpt" class="collapse">
	            <div class="flex flex-col justify-center items-start gap-2">
	                <label for="rcpt-related" class="w-full">
	                    <select name="login-rcpts-relation" id="login-rcpts-relation" class="form-control w-full is-invalid"  aria-required="true" aria-describedby="rcpt-related-error" aria-invalid="true" onchange="validateRequiredField();">
	                    	<option value="">관계 선택</option>
							<c:forEach var="relation" items="${mbrRelationCode}" varStatus="status">
								<option value="${relation.key}">${relation.value}</option>	
							</c:forEach>
	                    </select>
	                    <p id="rcpt-related-error" class="error text-danger">! 필수로 선택해 주세요</p>
	                </label>
	                <label for="rcpt-name" class="w-full">
	                    <input type="text" id="login-rcpts-nm" aria-required="true" aria-describedby="rcpt-name-error" 
	                    aria-invalid="true" placeholder="수급자 성명" class="form-control w-full is-invalid" oninput="validateRequiredField();">
	                    <p id="rcpt-name-error" class="error text-danger">! 필수로 입력해 주세요</p>
	                </label>
	                <label for="rcpt-lno" class="w-full">
	                	<div class="flex">
		                	<p class="px-1.5 font-serif text-[1.375rem] font-bold md:text-2xl">L</p>
		                    <input type="text" id="login-rcpts-lno" aria-required="true" aria-describedby="rcpt-lno-error" 
		                    aria-invalid="true" placeholder="요양인정번호" class="form-control w-full is-invalid" oninput="validateRequiredField();">
	                	</div>
	                    <p id="rcpt-lno-error" class="error text-danger">! 필수로 입력해 주세요</p>
	                </label>
	               </div>
	           </div>
	        </div>
	    	`
	    }
	    
	    //직접입력하기 필수체크
	    function validateRequiredField() {
	    	//직접 입력하기 수급자 정보
	    	var relationCd = $('#login-rcpts-relation option:selected').val();
	    	var relationText = $('#login-rcpts-relation option:selected').text();
	    	var recipientsNm = $('#login-rcpts-nm').val();
	    	var recipientsLno = $('#login-rcpts-lno').val();
	    	
	    	if (relationCd) {
	    		$('#login-rcpts-relation').removeClass('is-invalid');
	    		$('#rcpt-related-error').css('display', 'none');
	    	} else {
	    		$('#login-rcpts-relation').addClass('is-invalid');
	    		$('#rcpt-related-error').css('display', 'block');
	    	}
	    	
	    	if (recipientsNm) {
	    		$('#login-rcpts-nm').removeClass('is-invalid');
	    		$('#rcpt-name-error').css('display', 'none');
	    	} else {
	    		$('#login-rcpts-nm').addClass('is-invalid');
	    		$('#rcpt-name-error').css('display', 'block');
	    	}
	    	
	    	if (recipientsLno) {
	    		$('#login-rcpts-lno').removeClass('is-invalid');
	    		$('#rcpt-lno-error').css('display', 'none');
	    	} else {
	    		$('#login-rcpts-lno').addClass('is-invalid');
	    		$('#rcpt-lno-error').css('display', 'block');
	    	}
	    }
	    
	    
	    var rolling1 = null;
	    var rolling2 = null;
	
	    $('.grade-slider').each(function () {
	        var slider = $(this);
	
	        new Swiper(slider.find('.swiper').get(0), {
	            loop: true,
	            speed: 1000,
	            autoplay: {
	                speed: 5000,
	                disableOnInteraction: false,
	            },
	            navigation: {
	                prevEl: slider.find('.swiper-button-prev').get(0),
	                nextEl: slider.find('.swiper-button-next').get(0)
	            },
	            pagination: {
	                el: slider.find('.swiper-pagination').get(0),
	            },
	            on: {
	                slideChange: function (swiper) {
	                    var el = $(swiper.slides[swiper.activeIndex]);
	                    el.closest('[class*="grade-content"]').find('.grade-taps a[href="#' + el.attr('id') + '"]').parent().addClass('is-active').siblings().removeClass('is-active');
	                }
	            }
	        });
	    })

	    rolling2 = setInterval(function () {
	        var items = $('[class*="rolling-item"]');
	        var active = items.filter('.is-active');
	        var margin = -active.next().outerHeight(true);
	
	        active.clone().removeClass('is-active').appendTo(items.closest('.container'));
	
	        active.removeClass('is-active').css({ 'margin-top': margin }).next().addClass('is-active').one('transitionend animationend', function () {
	            active.remove();
	        });
	    }, 3000);
	</script>
</div>
