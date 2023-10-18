<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<header id="subject">
    <nav class="breadcrumb">
        <ul>
			<li class="home"><a href="${_mainPath}">홈</a></li>
			<li>이로움 서비스</li>
            <li>요양정보간편조회</li>
        </ul>
    </nav>
</header>

<div id="content">
   요양정보간편조회 서브 메인 페이지<br>
   <button onclick="searchRecipients();">요양정보 조회하기</button>

	<!--로그인사용자 : 등록된 수급자 없는 경우-->
	<div class="modal modal-index fade" id="login-no-rcpt" tabindex="-1" aria-hidden="true">
	    <div class="modal-dialog">
	        <div class="modal-content">
	            <div class="modal-header">
	                <h2 class="text-title">수급자 선택</h2>
	                <button data-bs-dismiss="modal" class="btn-close">모달 닫기</button>
	            </div>
	            <div class="modal-body">
	                <div class="flex flex-col justify-center items-end gap-1">
	                    <select name="no-rcpt-relation" id="no-rcpt-relation" class="form-control w-full">
	                    	<option value="">관계 선택</option>
							<c:forEach var="relation" items="${mbrRelationCode}" varStatus="status">
								<option value="${relation.key}">${relation.value}</option>	
							</c:forEach>
	                    </select>
	                    <input type="text" name="no-rcpt-nm" id="no-rcpt-nm" placeholder="수급자 성명" class="form-control w-full">
	                    <div class="flex">
	                    	<p class="px-1.5 font-serif text-[1.375rem] font-bold md:text-2xl">L</p>
	                    	<input type="text" name="no-rcpt-nm" id="no-rcpt-lno" placeholder="요양인정번호" class="form-control w-full">
	                    </div>
	                </div>
	            </div>
	            <div class="modal-footer">
	                <button type="button" class="btn btn-primary large flex-1 md:flex-none md:w-70" onclick="startLoginNoRcpt();">시작하기</button>
	            </div>
	        </div>
	    </div>
	</div>
	
	<!--로그인사용자 : 등록 수급자 n명이상인 경우-->
	<div class="modal modal-index fade" id="login-rcpts" tabindex="-1" aria-hidden="true">
	    <div class="modal-dialog">
	    <div class="modal-content">
	        <div class="modal-header">
	        <h2 class="text-title">수급자 선택</h2>
	        <button data-bs-dismiss="modal" class="btn-close">모달 닫기</button>
	        </div>
	        <div class="modal-body  items-end">
	         <div class="form-radio-button-group" id="recipient-list">
	             
	         </div>
	         <a href="#"class="underline text-blue3 text-sm">수급자 관리</a>
	         
	         
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
	            <div class="modal-body">
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
        			location.href='/membership/login?returnUrl=/main/recipter/sub'
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
				$('#login-no-rcpt').modal('show');
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
				
				$('#login-rcpts').modal('show');
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
        		
            	location.href = '/main/recipter/list?recipientsNo=' + radioRecipientsNo;
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
      	
      	//새로 등록할 수급자 확인
        function clickRegistRecipient() {
        	var relationCd = $('#modal-recipient-relation-cd').val();
        	var recipientsNm = $('#modal-recipient-nm').text();
        	var rcperRcognNo = $('#modal-recipient-lno').text();
        	var rcperRcognNo = rcperRcognNo.replace('L', '');
        	
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
        		if(data.success) {
        			alert('수급자 정보 등록에 동의했습니다.');
        			
        			location.href = '/main/recipter/list?recipientsNo=' + data.createdRecipientsNo;
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
        	$('#regist-rcpt').modal('show');
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
	</script>
</div>