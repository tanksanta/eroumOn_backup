<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

	<!--모달: 수급자 정보 -->
	<div class="modal fade" id="pop-client-edit" tabindex="-1" aria-hidden="true">
		<div class="modal-dialog modal-dialog-centered modal-lg">
			<div class="modal-content">
			<div class="modal-header">
				<h2 class="text-title"></h2>
				<button data-bs-dismiss="modal" class="btn-close">모달 닫기</button>
			</div>
			<div class="modal-body">
				<div class="text-subtitle -mb-2">
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
						<tr class="top-border wrapRelation">
							<td></td>
							<td></td>
						</tr>
						<tr>
							<th scope="row">
                                <p>
                                    <label for="recipter">수급자와의 관계</label>
									<sup class="text-danger text-base md:text-lg">*</sup>
                                </p>
                            </th>
                            <td>
                                <select name="relationSelect" id="info-relationSelect" class="form-control w-full lg:w-8/12">
                                    <option value="">관계 선택</option>
									<c:forEach var="relation" items="${relationCd}" varStatus="status">
										<option value="${relation.key}">${relation.value}</option>	
									</c:forEach>
                                </select>
                            </td>
						</tr>
						<tr class="wrapNm">
                            <th scope="row">
                                <p>
                                    <label for="recipter">수급자 성명</label>
									<sup class="text-danger text-base md:text-lg">*</sup>
                                </p>
                            </th>
                            <td>
                                <input type="text" class="form-control  lg:w-8/12" id="info-recipientsNm" name="info-recipientsNm" maxlength="50" value="" placeholder="성명">
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
                                    <div class="form-check input-rcperRcognNo-yn">
                                        <input class="form-check-input" type="radio" name="info-rcperRcognNo-yn" id="info-rcperRcognNo-y" value="Y" checked onchange="changeRcperRcognNoYn();">
                                        <label class="form-check-label" for="info-rcperRcognNo-y">있음</label>
                                    </div>
                                    <div class="form-check input-rcperRcognNo-yn">
                                        <input class="form-check-input" type="radio" name="info-rcperRcognNo-yn" id="info-rcperRcognNo-n" value="N" onchange="changeRcperRcognNoYn();">
                                        <label class="form-check-label" for="info-rcperRcognNo-n">없음</label>
                                    </div>
                                </div>
                                <div class="form-group w-full lg:w-8/12" id="input-rcperRcognNo">
                                    <p class="px-1.5 font-serif text-[1.375rem] font-bold md:text-2xl">L</p>
                                    <input type="text" class="form-control " id="info-rcperRcognNo" name="info-rcperRcognNo" maxlength="13" value="" placeholder="1234567890">
                                </div>
                            </td>
                        </tr>
						<tr>
                            <th scope="row">
                                <p>
									<label for="search-item6">상담받을 연락처</label>
									<sup class="text-danger text-base md:text-lg">*</sup>
								</p>
                            </th>
                            <td><input type="text" class="form-control w-full lg:w-8/12 keycontrol phonenumber" id="info-tel" placeholder="010-1234-5678"></td>
                        </tr> 
						<tr>
                            <th scope="row">
                                <p>
									<label for="search-item6">실거주지 주소</label>
									<sup class="text-danger text-base md:text-lg">*</sup>
								</p>
                            </th>
                            <td>
                                <fieldset  class="addr-select">
                                    <select name="sido" id="sido" class="form-control" onchange="setSigugun();">
                                    </select>
                                    <select name="sigugun" id="sigugun" class="form-control" onchange="setDong();">
                                    	<option value="">시/군/구</option>
                                    </select>
                                    <select name="dong" id="dong" class="form-control md:col-span-2 lg:col-span-1">
                                        <option value="">동/읍/면</option>
                                    </select>
                                </fieldset>
                            </td>
                        </tr>
						<tr>
                            <th scope="row">
								<p>
									<label for="search-item4">수급자 생년월일</label>
									<sup class="text-danger text-base md:text-lg">*</sup>
								</p>
							</th>
                            <td><input type="text" class="form-control lg:w-8/12 keycontrol birthdt10" id="info-brdt" placeholder="1950/01/01"></td>
                        </tr>
						<tr>
                        	<th scope="row">
								<p>
									<label for="search-item4">성별</label>
									<sup class="text-danger text-base md:text-lg">*</sup>
								</p>
							</th>
                        	<td>
                        		<div class="flex flex-row gap-2.5 mb-1.5">
                                    <div class="form-check">
                                        <input class="form-check-input" type="radio" name="info-gender" id="info-gender-m" value="M">
                                        <label class="form-check-label" for="info-gender-m">남성</label>
                                    </div>
                                    <div class="form-check">
                                        <input class="form-check-input" type="radio" name="info-gender" id="info-gender-w" value="W">
                                        <label class="form-check-label" for="info-gender-w">여성</label>
                                    </div>
                                </div>
                        	</td>
                        </tr>
                        <tr id="tr-prev-path">
                            <th scope="row"><p><label for="search-item4">상담유형</label></p></th>
                            <td>요양정보상담</td>
                        </tr>
						<tr class="top-border">
							<td></td>
							<td></td>
						</tr>
					</tbody>
				</table>
				<div class="flex justify-end" id="div-remove-recipient">
					<button class="btn-text-primary" onclick="removeRecipient();">삭제하기</button>
				</div>
				<ul class="list-style1" id="ul-conslt-info">
                    <li>상기 정보는 장기요양등급 신청 및 상담이 가능한 장기요양기관에 제공되며 원활한 상담 진행 목적으로 상담 기관이 변경될 수도 있습니다.</li>
                    <li>제공되는 정보는 상기 목적으로만 활용하며 1년간 보관 후 폐기됩니다.</li>
                    <li>가입 시 동의받은 개인정보 제3자 제공동의에따라 위의 개인정보가 제공됩니다. 동의하지 않을 경우 서비스 이용이 제한될 수 있습니다.</li>
                </ul>
			</div>
			<div class="modal-footer md:w-3/4 mx-auto mt-4">
				<button type="button" id="actionBtn" class="btn btn-primary large w-3/5" onclick="requestAction();">등록하기</button>
				<button type="button" class="btn btn-outline-primary large w-2/5" data-bs-dismiss="modal">취소하기</button>
			</div>
			</div>
		</div>
	</div>

	<!--모달: 진행중인 상담 알림 모달 -->
	<div class="modal fade" id="modal-my-consulting" tabindex="-1" aria-hidden="true">
		<div class="modal-dialog modal-dialog-centered">
			<div class="modal-content">
				<div class="modal-header">
					<h2 class="text-title">알림</h2>
					<button data-bs-dismiss="modal" class="btn-close">모달 닫기</button>
				</div>
				<div class="modal-body">
					<div class="bg-box-beige">
					<%-- <div class="flex flex-col justify-center items-center"> --%>
						<div class="text-center text-xl" id="process-conslt-noti">
							진행중인 인정등급 상담이 있습니다.<br>
							상담 내역을 확인하시겠습니까?
						</div>
					<%-- </div> --%>
					</div>
				</div>
				<div class="modal-footer gap-2">
					<button type="button" class="btn-warning large w-full md:w-1/2" onclick="location.href='/membership/conslt/appl/list'">상담내역 확인하기</button>
					<!-- <button type="button" class="btn btn-outline-primary large flex-initial w-45" onclick="openNewConslt();">새롭게 진행하기</button> -->
				</div>
			</div>
		</div>
	</div>

	<!--모달: 상담신청완료-->
    <div class="modal fade" id="modal-consulting-complated" tabindex="-1" aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered">
            <div class="modal-content">
            <div class="modal-header">
                <h2 class="text-title">알림</h2>
                <button data-bs-dismiss="modal" class="btn-close"></button>
            </div>
            <div class="modal-body">
                <div class="text-center">
                    <div class="provide-complate">
                        <div class="wrapper">
                            <svg width="45.1731884px" height="44.9930805px" viewBox="0 0 45.1731884 44.9930805">
                                <g id="airplane" stroke="none" stroke-width="1" fill="none" fill-rule="evenodd">
                                    <g id="airplane" transform="translate(-836.3067, -384.1337)" fill="#FFFFFF">
                                        <g id="airplane" transform="translate(787, 329)">
                                            <path d="M49.8149249,79.6635069 L92.9878533,55.2632727 C93.4686607,54.9915327 94.078721,55.1610153 94.350461,55.6418227 C94.4586743,55.8332916 94.5007484,56.0550947 94.470169,56.2728912 L89.2316897,93.5830877 C89.0781107,94.6769283 88.0668774,95.439161 86.9730368,95.285582 C86.8468774,95.2678688 86.7226991,95.2381419 86.6021946,95.1968067 L75.5767429,91.4148747 C74.7376734,91.1270585 73.8092758,91.426319 73.2962443,92.1499725 L67.940117,99.7050262 C67.620703,100.155574 66.9965258,100.261879 66.5459782,99.9424645 C66.2814978,99.7549621 66.1243285,99.4508781 66.1243285,99.1266759 L66.1243285,89.5357494 C66.1243285,88.8171161 66.3822929,88.1223582 66.8512931,87.5778653 L81.6305995,70.4196045 C81.8108177,70.2103773 81.7873014,69.8946695 81.5780742,69.7144512 C81.3931938,69.555204 81.1203694,69.552664 80.9325561,69.7084415 L62.4817313,85.0120537 C61.6191487,85.727503 60.4297149,85.9025231 59.3976054,85.4658696 L49.9173201,81.4550557 C49.4086824,81.2398669 49.1707951,80.6530897 49.3859839,80.1444521 C49.4719751,79.9411962 49.6227902,79.7720965 49.8149249,79.6635069 Z" id="Path-4"></path>
                                        </g>
                                    </g>
                                </g>
                            </svg>
                            <div class="object1"></div>
                            <div class="object2"></div>
                            <div class="object3"></div>
                        </div>
                    </div>
                    <p class="mt-5.5 text-lg font-bold md:mt-6 md:text-xl lg:mt-7 lg:text-2xl">상담 신청이 완료되었습니다.</p>
                    <p class="mt-2 mb-4 text-sm md:text-base tracking-tight">
                        "영업일 기준, 2일 이내 해피콜 통해 <span class="block md:inline-block">안내 받으실 수 있어요"</span>
                    </p>
                </div>

                <script>
                    $('.provide-complate').addClass('animate1');
                    $('.provide-complate svg').one('animationend transitionend',function(){
                        $('.provide-complate').removeClass('animate1').addClass('animate2');
                    });
                </script>
            </div>
            <div class="modal-footer">
                <a href="#" id="goConsltHist" class="btn-large btn-warning flex-1 md:w-70" onclick="location.href='/membership/conslt/appl/list'">신청내역 보러가기</a>
            </div>
            </div>
        </div>
    </div>


	<!-- 수급자정보등록 확인팝업 -->
	<div class="modal fade" id="regist-rcpt" tabindex="-1" aria-hidden="true">
	    <div class="modal-dialog modal-dialog-centered">
	        <div class="modal-content">
	            <div class="modal-header">
	                <h2 class="text-title">수급자 정보 등록</h2>
	                <button data-bs-dismiss="modal" class="btn-close"></button>
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
	                    <li id="regist-rcpt-lno">
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
		
	    var me = {};
	    var myRecipientInfo = {};
	    var mbrRecipients = {};
	    var infoModalType = '';
	    var infoPrevPath = '';
	    var addRecipientInfo = {};
    
	  	//수급자 등록 수정 ,상담신청 모달창 띄우기(또는 진행중인 상담존재 모달에서 새롭게 진행하기 클릭)
	    function openModal(modalType, recipientsNo, prevPath) {
	    	doubleClickCheck = false;
	    	infoModalType = modalType;
	    	infoPrevPath = prevPath;
	    	
	    	//접속 uri에 따라 모달에 클래스 다르게 부여
	    	if (location.pathname.startsWith('/main')) {
	    		$('#pop-client-edit').addClass('modal-index');
	    		$('#modal-my-consulting').addClass('modal-default');
	    		$('#modal-consulting-complated').addClass('modal-default');
	    		$('#regist-rcpt').addClass('modal-index');
	    		
	    		$('#actionBtn').removeClass('btn-primary');
	    		$('#actionBtn').addClass('btn-primary3');
	    		$('#goConsltHist').addClass(['btn-large', 'btn-warning']);
	    	} else {
	    		$('#pop-client-edit').addClass('modal-default');
	    		$('#modal-my-consulting').addClass('modal-default');
	    		$('#modal-consulting-complated').addClass('modal-default');
	    		$('#regist-rcpt').addClass('modal-default');
	    		$('#goConsltHist').addClass('btn-success');
	    	}
	    
	    	
	    	if (modalType === 'addRecipient') {
	    		initModal();
	    		
	    		$('#actionBtn').text('등록하기');
	    	} else if (modalType === 'updateRecipient') {
	  			getUpdateRecipientInfoData(recipientsNo);
	  			
	  			$('#actionBtn').text('수정하기');
	  		} else if (modalType === 'requestConslt') {
	  			getRequestConsltInfoData(recipientsNo);
	  			
	  			$('#actionBtn').text('상담신청하기');
	  		}
	    }
	  	
	  	//수급자 수정하기 정보 가져오기
	  	function getUpdateRecipientInfoData(recipientsNo) {
	  		$.ajax({
	    		type : "post",
	    		url  : "/membership/info/myinfo/getMbrInfo.json",
	    		dataType : 'json'
	    	})
	    	.done(function(data) {
	    		//로그인 한 경우
	    		if (data.isLogin) {
	    			me = data.mbrVO;
	    			myRecipientInfo = data.mbrRecipients.filter(f => f.recipientsNo === recipientsNo)[0];
	    			mbrRecipients = data.mbrRecipients;
	    			
	    			mappingModalData();
	    		}
	    		//로그인 안한 경우
	    		else {
	    			alert('로그인 이후 이용가능합니다')
	    		}
	    	})
	    	.fail(function(data, status, err) {
	    		alert('서버와 연결이 좋지 않습니다');
	    	});
	  	}
	  	
	  	//상담하기 정보 가져오기
	  	function getRequestConsltInfoData(recipientsNo) {
	  		//진행중인 상담 조회 api
    		$.ajax({
        		type : "post",
				url  : "/membership/info/myinfo/getRecipientConsltSttus.json",
				data : {
					recipientsNo : recipientsNo,
					prevPath : infoPrevPath,
				},
				dataType : 'json'
        	})
        	.done(function(data) {
        		//해당 수급자가 진행중인 상담이 있는 경우
        		if (data.isExistRecipientConslt) {
        			if (infoPrevPath === 'test') {
    					$('#process-conslt-noti').html(`
							진행중인 인정등급 상담이 있습니다.<br>
							상담 내역을 확인하시겠습니까?
    					`);
    				} else if (infoPrevPath === 'simpleSearch') {
    					$('#process-conslt-noti').html(`
							진행중인 요양정보 상담이 있습니다.<br>
							상담 내역을 확인하시겠습니까?
    					`);
    				} else {
    					$('#process-conslt-noti').html(`
   							진행중인 관심 복지용구 상담이 있습니다.<br>
   							상담 내역을 확인하시겠습니까?
       					`);
    				}
        			$('#modal-my-consulting').modal('show');
        		} else {
        			getRecipientInfoIntoModal(recipientsNo);
        		}
        	})
        	.fail(function(data, status, err) {
        		alert('서버와 연결이 좋지 않습니다.');
			});
	  		
	  	}
	  	
	  	function getRecipientInfoIntoModal(recipientsNo) {
	  		$.ajax({
	    		type : "post",
	    		url  : "/membership/info/myinfo/getMbrInfo.json",
	    		data : {recipientsNo},
	    		dataType : 'json'
	    	})
	    	.done(function(data) {
	    		//로그인 한 경우
	    		if (data.isLogin) {
	    			me = data.mbrVO;
	    			myRecipientInfo = data.mbrRecipients.filter(f => f.recipientsNo === recipientsNo)[0];
	    			mbrRecipients = data.mbrRecipients;
	    			
	    			//등록된 수급자가 아닌 경우 다음단계 진행하지 않음
	    			if (!myRecipientInfo) {
	    				alert('등록된 수급자가 아닙니다.');
	    				return;
	    			}
	    			
	    			//진행중인 상담 있는지 체크
	    			if (data.recipientConslt) {
	    				if (data.recipientConslt.prevPath === 'test') {
	    					$('#process-conslt-noti').html(`
    							진행중인 인정등급 상담이 있습니다.<br>
    							상담 내역을 확인하시겠습니까?
	    					`);
	    				} else {
	    					$('#process-conslt-noti').html(`
    							진행중인 요양정보 상담이 있습니다.<br>
    							상담 내역을 확인하시겠습니까?
	    					`);
	    				}
	    				$('#modal-my-consulting').modal('show').appendTo('body');
	    				return;
	    			}
	    			
	    			mappingModalData();
	    		}
	    		//로그인 안한 경우
	    		else {
	    			alert('로그인 이후 이용가능합니다')
	    		}
	    	})
	    	.fail(function(data, status, err) {
	    		alert('서버와 연결이 좋지 않습니다');
	    	});
	  	}
	  	
	  	
	  	//진행중인 상담 모달에서 새롭게 진행하기 클릭
	  	function openNewConslt() {
	  		$('#modal-my-consulting').modal('hide');
	  		mappingModalData();
	  	}
	  	
	  	//수급자 추가하기 모달
	  	function initModal() {
	  		$('#pop-client-edit .text-title').text('수급자 정보 등록');
  			$('#tr-prev-path').css('display', 'none');
  			$('#div-remove-recipient').css('display', 'none');
  			$('#ul-conslt-info').css('display', 'none');
	  		
  			//사용자 정보 가져오기
  			$.ajax({
	    		type : "post",
	    		url  : "/membership/info/myinfo/getMbrInfo.json",
	    		dataType : 'json'
	    	})
	    	.done(function(data) {
	    		//로그인 한 경우
	    		if (data.isLogin) {
	    			me = data.mbrVO;
	    			mbrRecipients = data.mbrRecipients;
	    			
	    			$('#pop-client-edit').modal('show').appendTo('body');
	    		}
	    		//로그인 안한 경우
	    		else {
	    			alert('로그인 이후 이용가능합니다')
	    		}
	    	})
	    	.fail(function(data, status, err) {
	    		alert('서버와 연결이 좋지 않습니다');
	    	});
	  	}
	  	
	  	//모달에 데이터 매핑
	  	function mappingModalData() {
	  		//데이터 매핑전 모달 타입에 따라 UI 변경
	  		if (infoModalType === 'updateRecipient') {
	  			$('#pop-client-edit .text-title').text('수급자 정보 수정');
	  			
	  			$('#tr-prev-path').css('display', 'none');
	  			$('#div-remove-recipient').css('display', 'flex');
	  			$('#ul-conslt-info').css('display', 'none');
	  		} else if (infoModalType === 'requestConslt') {
	  			$('#pop-client-edit .text-title').text('상담 정보 확인');
	  			
	  			$('#tr-prev-path').css('display', 'table-row');	
	  			if (infoPrevPath === 'test') {
	  				$('#tr-prev-path td').text('인정등급상담');
	  			} else if (infoPrevPath === 'simpleSearch') {
	  				$('#tr-prev-path td').text('요양정보상담');
	  			} else {
	  				$('#tr-prev-path td').text('복지용구상담');
	  			}
	  			$('#div-remove-recipient').css('display', 'none');
	  			$('#ul-conslt-info').css('display', 'block');
	  		}
	  		
	  		
	  		//데이터 매핑
			$('#info-relationSelect').val(myRecipientInfo.relationCd);
	    	$('#info-recipientsNm').val(myRecipientInfo.recipientsNm);
	    	
	    	if(myRecipientInfo.rcperRcognNo) {
	    		//L번호가 있는 경우 이름, L번호 수정 불가
	    		$('#info-recipientsNm').prop('readonly', true);
	    		
	            $('.input-rcperRcognNo-yn').css('display', 'none');
	    		$('#info-rcperRcognNo-y').prop('disabled', true);
	    		$('#info-rcperRcognNo-n').prop('disabled', true);
	    		
	    		$('#info-rcperRcognNo-y').prop('checked', true); 
	    		$('#info-rcperRcognNo').val(myRecipientInfo.rcperRcognNo);
	    		$('#input-rcperRcognNo').css('display', 'inline-flex');
	    		$('#info-rcperRcognNo').prop('readonly', true);
	    	} else {
	    		$('#info-recipientsNm').prop('readonly', false);
	    		
	            $('.input-rcperRcognNo-yn').css('display', 'inline-block');
	    		$('#info-rcperRcognNo-y').prop('disabled', false);
	    		$('#info-rcperRcognNo-n').prop('disabled', false);
	    		
	    		$('#info-rcperRcognNo-n').prop('checked', true);
	    		$('#info-rcperRcognNo').val('');
	    		$('#input-rcperRcognNo').css('display', 'none');
	    	}
	    	
	    	$('#info-tel').val(myRecipientInfo.tel);
	    	
	    	if (myRecipientInfo.sido) {
	    		var options = $('#sido option');
	    		for(var i = 0; i < options.length; i++) {
	    			if ($('#sido option')[i].text === myRecipientInfo.sido) {
	    				$('#sido option')[i].selected = true;
	    			}
	    		}
	    		setSigugun();
	    	}
	    	if (myRecipientInfo.sigugun) {
	    		var options = $('#sigugun option');
	    		for(var i = 0; i < options.length; i++) {
	    			if ($('#sigugun option')[i].text === myRecipientInfo.sigugun) {
	    				$('#sigugun option')[i].selected = true;
	    			}
	    		}
	    		setDong();
	    	}
	    	if (myRecipientInfo.dong) {
	    		var options = $('#dong option');
	    		for(var i = 0; i < options.length; i++) {
	    			if ($('#dong option')[i].text === myRecipientInfo.dong) {
	    				$('#dong option')[i].selected = true;
	    			}
	    		}
	    	}
	    	
	    	if(myRecipientInfo.brdt) {
	    		$('#info-brdt').val(myRecipientInfo.brdt.substring(0, 4) + '/' + myRecipientInfo.brdt.substring(4, 6) + '/' + myRecipientInfo.brdt.substring(6, 8));	
	    	}else {
	    		$('#info-brdt').val('');    			
	    	}
	    	
	    	if (myRecipientInfo.gender === 'M') {
	    		$('#info-gender-m').prop('checked', true);
	    	} else if (myRecipientInfo.gender === 'W') {
	    		$('#info-gender-w').prop('checked', true);
	    	} else {
	    		$('#info-gender-m').prop('checked', false);
	    		$('#info-gender-w').prop('checked', false);
	    	}
	    	
	    	
	    	$('#pop-client-edit').modal('show').appendTo('body');
	  	}
	  	
	  	
	  	//모달창안에 L번호 있음, 없음 체크로 readonly 처리
	    function changeRcperRcognNoYn() {
	    	var checkedVal = $('input[name=info-rcperRcognNo-yn]:checked').val();
	    	if (checkedVal === 'Y') {
	    		$('#info-rcperRcognNo').prop('readonly', false);
	    		$('#input-rcperRcognNo').css('display', 'inline-flex');
	    	} else {
	    		$('#info-rcperRcognNo').prop('readonly', true);
	    		$('#input-rcperRcognNo').css('display', 'none');
	    	}
	    }
	  	
	  	//수급자 등록, 수정 또는 상담신청하기
	  	var doubleClickCheck = false;
	    var telchk = /^([0-9]{2,3})?-([0-9]{3,4})?-([0-9]{3,4})$/;
	    var datechk = /^([1-2][0-9]{3})\/([0-1][0-9])\/([0-3][0-9])$/;
	    function requestAction() {
	    	if (doubleClickCheck) {
	    		return;
	    	}
	    	
	    	var relationCd = $('#info-relationSelect').val();
	    	var recipientsNm = $('#info-recipientsNm').val();
	    	var rcperRcognNoYn = $('input[name=info-rcperRcognNo-yn]:checked').val();
	    	var rcperRcognNo = $('#info-rcperRcognNo').val();
	    	var tel = $('#info-tel').val();
	    	var sidoCode = $('#sido option:selected').val();
	    	var sido = $('#sido option:selected').text();
	    	var sigugunCode = $('#sigugun option:selected').val();
	    	var sigugun = $('#sigugun option:selected').text();
	    	var dongCode = $('#dong option:selected').val();
	    	var dong = $('#dong option:selected').text();
	    	var brdt = $('#info-brdt').val();
	    	var gender = $('input[name=info-gender]:checked').val();
	    	
	    	//필수항목 입력검사
	    	if (!relationCd) {
	    		alert('수급자와의 관계를 선택하세요');
	    		return;
	    	}
	    	if (!recipientsNm) {
	    		alert('수급자 성명을 입력하세요');
	    		return;
	    	}
	    	if (rcperRcognNoYn === 'Y' && !rcperRcognNo) {
	    		alert('요양인정번호를 입력하세요');
	    		return;
	    	}
			//요양번호 10자리 검사
			if (rcperRcognNoYn === 'Y' && rcperRcognNo.length != 10) {
				alert('요양인정번호 숫자 10자리를 입력하세요 (예: 1234567890)');
				return;
			}
	    	if (!tel) {
	    		alert('상담받을 연락처를 입력하세요');
	    		return;
	    	}
	    	
	    	//동은 선택값이 없으면 검사하지 않음
	    	var dongOptions = $('#dong option');
	    	if (dongOptions.length === 1) {
	    		if (!sidoCode || !sigugunCode) {
		    		alert('실거주지 주소를 선택하세요');
		    		return;
		    	}
	    		dong = null;
	    	} 
	    	else {
	    		if (!sidoCode || !sigugunCode || !dongCode) {
		    		alert('실거주지 주소를 모두 선택하세요');
		    		return;
		    	}
	    	}
	    	
	    	if (!brdt) {
	    		alert('수급자 생년월일를 입력하세요');
	    		return;
	    	}
	    	if (!gender) {
	    		alert('성별을 입력하세요');
	    		return;
	    	}
	    	
	    	//본인인지 체크
	    	if (relationCd === '007' && recipientsNm !== me.mbrNm) {
	    		alert('수급자와의 관계를 확인해주세요');
	    		return;
	    	}
	    	//본인과 배우자는 한명만 등록
	    	var meCount = 0;
	    	var spouseCount = 0;
	    	if (infoModalType === 'addRecipient') {
	    		meCount = mbrRecipients.filter(f => f.relationCd === '007').length; //다른수급자도 본인인지 확인
	    		spouseCount = mbrRecipients.filter(f => f.relationCd === '001').length; //다른수급자도 배우자인지 확인
	    	} else {
	    		meCount = mbrRecipients.filter(f => f.recipientsNo !== myRecipientInfo.recipientsNo && f.relationCd === '007').length; //내 수급자가 아닌 다른수급자도 본인인지 확인
	    		spouseCount = mbrRecipients.filter(f => f.recipientsNo !== myRecipientInfo.recipientsNo && f.relationCd === '001').length; //내 수급자가 아닌 다른수급자도 배우자인지 확인
	    	}
	    	if ((relationCd === '007' && meCount > 0) ||
	    		(relationCd === '001' && spouseCount > 0)) {
	    		alert('수급자와의 관계를 확인해주세요');
	    		return;
	    	}
	    	
	    		
	    	//연락처 형식 검사
	    	if (telchk.test(tel) === false) {
	    		alert('연락처 형식이 올바르지 않습니다 (예시: 010-0000-0000)');
	    		return;
	    	}
	    	
	    	//생년월일 형식 검사
	    	if (datechk.test(brdt) === false) {
	    		alert('생년월일 형식이 올바르지 않습니다 (예시: 1950/01/01)');
	    		return;
	    	}
	    	
			if (rcperRcognNoYn === 'N') {
				rcperRcognNo = '';
			}
	    	
	    	jsonData = {
    			relationCd
    			, recipientsNm
    			, rcperRcognNo
    			, tel
    			, sido
    			, sigugun
    			, dong
    			, brdt
    			, gender
	    	};
	    	
	    	//수급자 정보 등록
	    	if (infoModalType === 'addRecipient') {
	    		//등록 확인 모달창
	    		$('#modal-recipient-relation-cd').val(relationCd);
	        	$('#modal-recipient-relation').text($('#info-relationSelect option:checked').text());
	        	$('#modal-recipient-nm').text(recipientsNm);
	        	
	        	if (rcperRcognNoYn === 'Y') {
	        		$('#regist-rcpt-lno').css('display', 'flex');
	        		$('#modal-recipient-lno').text('L' + rcperRcognNo);
	        	} else {
	        		$('#regist-rcpt-lno').css('display', 'none');
	        	}
	        	
	    		$('#regist-rcpt').modal('show').appendTo('body');
	    		addRecipientInfo = jsonData;
	    	}
	    	//수급자 정보 수정
	    	else if (infoModalType === 'updateRecipient') {
	    		doubleClickCheck = true;
	    		jsonData.recipientsNo = myRecipientInfo.recipientsNo;
	    		
	    		//수급자 정보 수정 API 호출
		    	jsCallApi.call_api_post_json(window, "/membership/info/myinfo/updateMbrRecipient.json", "updateMbrRecipientCallback", jsonData);
	    	}
	    	//상담신청
	    	else if (infoModalType === 'requestConslt') {
	    		//입력된 정보가 수정되었는지 체크 후 alert처리
	    	    var saveRecipientInfo = false;
	    	    if (myRecipientInfo.relationCd !== (relationCd ? relationCd : null) ||
	    	    		myRecipientInfo.recipientsNm !== (recipientsNm ? recipientsNm : null) ||
	    	    		myRecipientInfo.rcperRcognNo !== (rcperRcognNo ? rcperRcognNo : null) ||
	    	    		myRecipientInfo.tel !== (tel ? tel : null) ||
	    	    		myRecipientInfo.sido !== (sido ? sido : null) ||
	    	    		myRecipientInfo.sigugun !== (sigugun ? sigugun : null) ||
	    	    		myRecipientInfo.dong !== (dong ? dong : null) ||
	    	    		(brdt && myRecipientInfo.brdt !== (brdt ? brdt.replaceAll('/', '') : null) ) ||
	    	    		myRecipientInfo.gender !== (gender ? gender : null)) {
	    	    	saveRecipientInfo = confirm('입력하신 수급자 정보도 함께 저장하시겠습니까?');	
	    	    }
		    	
	    	    var consltRequestData = {
		    		relationCd
	    			, mbrNm: recipientsNm
	    			, rcperRcognNo
	    			, mbrTelno: tel
	    			, zip: sido
	    			, addr: sigugun
	    			, daddr: dong
	    			, brdt
	    			, gender
	    			, recipientsNo: myRecipientInfo.recipientsNo
	    			, prevPath: infoPrevPath
	    			, saveRecipientInfo
		    	};

	    	    doubleClickCheck = true;
	    	    
	    	  	//상담신청 API 호출
		    	jsCallApi.call_api_post_json(window, "/main/conslt/addMbrConslt.json", "addMbrConsltCallback", consltRequestData);
	    	}
	    }
	    // 수급자 정보 수정 콜백
	    function updateMbrRecipientCallback(result, errorResult, data, param) {
	    	if (errorResult == null) {
	    		var data = result;
	    		
	    		doubleClickCheck = false;
	    		if(data.success) {
	    			$('#pop-client-edit').modal('hide');
	    			location.reload();
	    		}else{
	    			alert(data.msg);
	    		}
	    	}
	    	else {
				alert('서버와 연결이 좋지 않습니다.');
			}
	    }
	    // 상담신청하기 콜백
	    function addMbrConsltCallback(result, errorResult, data, param) {
	    	if (errorResult == null) {
	    		var data = result;
	    		
	    		if(data.success) {
	    			$('#pop-client-edit').modal('hide');
	    			$('#modal-consulting-complated').modal('show').appendTo('body');
	    			
	    			//채널톡 이벤트 처리
	    			if (infoPrevPath === 'test') {
	    				eventChannelTalkForConslt('click_gradetest_matching');	
	    			} else if (infoPrevPath === 'simpleSearch') {
	    				eventChannelTalkForConslt('click_infocheck_matching');
	    			}
	    		}else{
	    			alert(data.msg);
	    		}
	    		
	    		doubleClickCheck = false;
	    	} else {
	    		alert('서버와 연결이 좋지 않습니다.');
	    	}
	    }

	    //채널톡 event 처리 (1:1 상담하기 신청)
	    function eventChannelTalkForConslt(eventName) {
		     
		    if (eventName === 'click_gradetest_matching') {
		    	//예상결과 등급
			    var grade = testResult.grade;
			    var propertyObj = {
			   		 grade
			   	}
			    
			  	//상담 신청 일자
				var now = new Date();
				propertyObj.consltDate = now.getFullYear() + '년 ' + String(now.getMonth() + 1).padStart(2, "0") + '월 ' + String(now.getDate()).padStart(2, "0") + '일';
			    
			    ChannelIO('track', eventName, propertyObj);
			     
			     
			    //GA 이벤트 처리
			    var gaProp = {
			        grade,
			    };
		    	gaProp.consltDate = propertyObj.consltDate;
		    	
		    	gtag('event', eventName, gaProp);
		    } else {
		    	
		    	//인정 등급
		    	var grade = $('#searchGrade').text();
		    	//총 급여액
		    	var limitAmt = $('#searchLimit').text().replaceAll('원', '').replaceAll(',', '');
		    	//사용 금액
		    	var useAmt = $('#searchUseAmt').text().replaceAll('원', '').replaceAll(',', '').replaceAll(' ', '');
		    	//잔여 금액
		    	var remainingAmt = comma(Number(limitAmt) - Number(useAmt)) + '원';
		    	
		    	var propertyObj = {
	    			 grade,
	    			 remainingAmt
	    		}
		    	
		    	//상담 신청 일자
				var now = new Date();
				propertyObj.consltDate = now.getFullYear() + '년 ' + String(now.getMonth() + 1).padStart(2, "0") + '월 ' + String(now.getDate()).padStart(2, "0") + '일';
				
				ChannelIO('track', eventName, propertyObj);
				 
				 
				//GA 이벤트 처리
				var gaProp = {
					grade,
				};
				
				gtag('event', eventName, gaProp);
		    }
		}


	    // 시/도 Select 박스 셋팅
	    function initSido() {
	    	var template = '<option value="">시/도</option>';
	    	
	    	for(var i = 0; i < hangjungdong.sido.length; i++) {
	    		template += '<option value="' + hangjungdong.sido[i].sido + '">' + hangjungdong.sido[i].codeNm + '</option>';
	    	}
	    	
	    	$('#sido').html(template);
	    }
	    // 시/구/군 Select 박스 셋팅
	    function setSigugun() {
	    	var sidoCode = $('#sido option:selected').val();
	    	
	    	if (sidoCode) {
	    		var sigugunArray = hangjungdong.sigugun.filter(f => f.sido === sidoCode);
	    		var template = '<option value="">시/군/구</option>';
	    		
	    		for(var i = 0; i < sigugunArray.length; i++) {
	    			template += '<option value="' + sigugunArray[i].sigugun + '">' + sigugunArray[i].codeNm + '</option>';
	    		}
	    		
	    		$('#sigugun').html(template);
	    	}
	    }
	    // 동/읍/면 Select 박스 셋팅
	    function setDong() {
	    	var sidoCode = $('#sido option:selected').val();
	    	var sigugunCode = $('#sigugun option:selected').val();
	    	
	    	if (sigugunCode) {
	    		var dongArray = hangjungdong.dong.filter(f => f.sido === sidoCode && f.sigugun === sigugunCode);
	    		var template = '<option value="">동/읍/면</option>';
	    		
	    		for(var i = 0; i < dongArray.length; i++) {
	    			template += '<option value="' + dongArray[i].dong + '">' + dongArray[i].codeNm + '</option>';
	    		}
	    		
	    		$('#dong').html(template);
	    	}
	    }
	    
	    
	    // 수급자 등록하기
	    function clickRegistRecipient() {
	    	if (doubleClickCheck) {
	    		return;
	    	}
	    	doubleClickCheck = true;
	    	
	    	//수급자 등록 API 호출
	    	jsCallApi.call_api_post_json(window, "/membership/info/myinfo/addMbrRecipient.json", "addMbrRecipientCallback", addRecipientInfo);
	    }
	    // 수급자 등록 콜백
	    function addMbrRecipientCallback(result, errorResult, data, param) {
	    	if (errorResult == null) {
	    		var data = result;
	    		
	    		doubleClickCheck = false;
	    		if(data.success) {
	    			location.reload();
	    		}else{
	    			alert(data.msg);
	    		}
	    	} else {
	    		alert('서버와 연결이 좋지 않습니다.');
	    	}
	    }
	    
	    
	    // 수급자 삭제하기
	    function removeRecipient() {
	    	var recipientsNo = myRecipientInfo.recipientsNo;
	    	if (!recipientsNo) {
	    		alert('삭제할 수급자를 선택하세요');
	    		return;
	    	}
    		
	    	if (confirm('수급자를 삭제한 후에는 복구가 불가합니다. 정말 삭제하시겠습니까?')) {
	    		$.ajax({
		    		type : "post",
		    		url  : "/membership/info/myinfo/removeMbrRecipient.json",
		    		data : { recipientsNo },
		    		dataType : 'json'
		    	})
		    	.done(function(data) {
		    		if(data.success) {
		    			location.href = '/membership/info/recipients/list';
		    		}else{
		    			alert(data.msg);
		    		}
		    	})
		    	.fail(function(data, status, err) {
		    		alert('서버와 연결이 좋지 않습니다.');
		    	});	
	    	}
	    }
	    
	    
	    $(function() {
	    	initSido();
	    });
    </script>
