<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

		<!--1. 수급자 등록, 수정, 상담정보확인(본인, 가족)-->
        <div class="modal modal-default fade" id="roc-main-modal" tabindex="-1" aria-hidden="true">
            <div class="modal-dialog modal-dialog-centered modal-dialog-scrollable modal-lg min-w-lg">
                <div class="modal-content">
                    <div class="modal-header">
                        <h2 class="text-title"></h2>
                        <button data-bs-dismiss="modal" class="btn-close">모달 닫기</button>
                    </div>
                    <div class="additional">
                        <i class="icon-alert"></i>
                        <p id="roc-main-alert-msg"></p>
                    </div>
                    <div class="modal-body"> 
                        <div class="flex flex-col gap-10">
                            <div>
                                <div class="flex flex-col sm:flex-row sm:justify-between sm:items-end gap-2 mb-1">
                                    <h3 class="text-lg font-medium">수급자 (어르신) 정보</h3>
                                    <div class="text-sm text-right" id="roc-main-conslt-nm">
                                        <span>· 상담유형</span>
                                        <span class="text-indexKey1">인정등급상담</span>
                                    </div>
                                </div>
                                <div class="bg-box-beige flex flex-col gap-4">
                                	<!-- 가족일 때 -->
                                	<div class="flex items-start gap-2 text-lg md:whitespace-nowrap" id="roc-main-div-rel-family">
                                        <img src="/html/page/members/assets/images/img-senoir-mono.svg" alt="시니어얼굴" class="icon-senior"/>
                                        <div class="flex flex-wrap items-center gap-1">
                                            <span>수급자(어르신)</span>
                                            <strong class="text-indexKey1 roc-recipient-nm">
                                            	이영수
                                            </strong>
                                            <span>님은</span>
                                            <strong class="roc-mbr-nm">이로움이</strong>
                                            <span>님의</span>
                                            <strong class="roc-relation-text">
                                            	친척
                                            </strong>
                                            <span>입니다</span>
                                        </div>
                                    </div>
                                    <!-- 본인일 때 -->
                                    <div class="flex items-start gap-2 text-lg md:whitespace-nowrap" id="roc-main-div-rel-me">
                                        <img src="/html/page/members/assets/images/img-senoir-mono.svg" alt="시니어얼굴" class="icon-senior"/>
                                        
                                        <div class="flex flex-wrap items-center gap-1">
                                            <span>수급자(어르신)</span>
                                            <strong class="text-indexKey1 roc-mbr-nm">이영수</strong>
                                            <span>님의</span>
                                        </div>
                                    </div>
                                    <!--요양정보가 있을때-->
                                    <div class="flex items-start gap-2 text-lg md:whitespace-nowrap" id="roc-main-div-lno-yes">
                                        <img src="/html/page/members/assets/images/img-nhis.svg" alt="국민건강보험 심볼" class="w-5 mt-1"/>
                                        <div class="flex flex-wrap items-center gap-1">
                                            <div class="mr-1">요양인정번호는</div>
                                            <strong class="text-indexKey1 roc-lno">L1904014349</strong><span>입니다</span>
                                        </div>
                                    </div>
                                    <!--요양정보가 없을때-->
                                    <div class="flex flex-col sm:flex-row items-start gap-2 text-lg md:whitespace-nowrap" id="roc-main-div-lno-no">
                                        <div class="flex items-center gap-1">
                                            <img src="/html/page/members/assets/images/img-nhis.svg" alt="국민건강보험 심볼" class="w-5 mt-1"/>
                                            <div class="mr-1">요양인정번호는</div>
                                        </div>
                                        <div class="flex flex-col gap-2 sm-max:ml-6">
                                            <div class="form-check">
                                                <input class="form-check-input" type="radio" name="roc-check-lno" id="lno-no" value='N'>
                                                <label class="form-check-label" for="lno-no">없습니다.</label>
                                            </div>
                                            <div class="flex items-start gap-1">
                                                <div class="form-check with-form">
                                                    <input class="form-check-input with-input" type="radio" name="roc-check-lno" id="lno-yes" value='Y' checked>
                                                </div>
                                                <div class="w-full">
                                                    <label for="roc-rcpt-lno" class="rcpt-lno type2">
                                                        <input type="text" id="roc-rcpt-lno" placeholder="뒤의 숫자 10자리 입력" 
                                                        class="form-control keycontrol numberonly" maxlength="10" 
                                                        aria-required="true" aria-describedby="rcpt-lno-related-error" aria-invalid="true"
                                                        oninput="inputEventLnoInRocModal();" />
                                                    </label>
                                                    <span>입니다</span>
                                                    <p id="rcpt-lno-related-error" class="error text-danger">! 요양인정번호를 정확하게 입력해 주세요</p>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="flex flex-col gap-4">
                                <h3 class="text-lg font-medium -mb-3">상담 시 필요 정보</h3>
                                <div class="table-box">
                                    <table>      
                                        <caption class="hidden">상담정보확인 위한 상담받을연락처, 실거주지 주소, 생년월일,성별 내용입니다</caption>
                                        <colgroup>
                                            <col class="w-22 xs:w-32">
                                            <col/>
                                        </colgroup>
                                        <tbody>
                                            <tr>
                                                <th scope="row"><label for="roc-main-telno">상담받을 연락처<sup class="required">*</sup></label></th>
                                                <td class="roc-main-td-rel-me">010-1234-5678</td>
                                                <td class="roc-main-td-rel-family">
                                                	<input type="text" class="form-control w-full lg:w-[60%] keycontrol phonenumber is-invalid" id="roc-main-telno" placeholder="010-1234-5678" onfocus="onfocusInRocModal('telno');" onblur="onblurInRocModal('telno');">
                                                	<p class="error text-danger">! 연락처 형식이 올바르지 않습니다. (예시: 010-1234-5678)</p>
                                                	<p class="error text-valid">! 상담 전화 받으실 분의 연락처를 입력해 주세요</p>
                                                </td>
                                            </tr>
                                            <tr>
                                                <th scope="row"><label for="roc-main-sido">실거주지 주소<sup class="required">*</sup></label></th>
                                                <td class="roc-main-td-rel-me">서울특별시 금천구 가산디지털로 104</td>
                                                <td class="roc-main-td-rel-family">
                                                    <fieldset class="flex flex-col w-full md:flex-row gap-1">
                                                        <select id="roc-main-sido" class="form-control md:flex-1 is-invalid" onchange="setSigugun();" onfocus="onfocusInRocModal('sido');" onblur="onblurInRocModal('sido');">
                                                            <option value="">시/도</option>
                                                        </select>
                                                        <select id="roc-main-sigugun" class="form-control md:flex-1 is-invalid" onchange="setDong();" onfocus="onfocusInRocModal('sigugun');" onblur="onblurInRocModal('sigugun');">
                                                            <option value="">시/군/구</option>
                                                        </select>
                                                        <select id="roc-main-dong" class="form-control md:flex-1">
                                                            <option value="">동/읍/면</option>
                                                        </select>
                                                    </fieldset>
                                                    <p class="error text-danger">! 주소를 모두 선택해 주세요</p>
                                                    <p class="error text-valid">! 등록하신 주소와 가까운 사업소로 배정되니, 정확한 주소를 입력해 주세요</p>
                                                </td>
                                            </tr>
                                            <tr>
                                                <th scope="row"><label for="roc-main-brdt">생년월일<sup class="required">*</sup></label></th>
                                                <td class="roc-main-td-rel-me">1900/01/01</td>
                                                <td class="roc-main-td-rel-family">
                                                	<input type="text" class="form-control w-full lg:w-[60%] keycontrol birthdt10 is-invalid" id="roc-main-brdt" placeholder="1950/01/01" onfocus="onfocusInRocModal('brdt');" onblur="onblurInRocModal('brdt');">
                                                	<p class="error text-danger">! 생년월일 8자리를 입력해 주세요 (예시: 1950/01/01)</p>
                                                	<p class="error text-valid">! 수급자(어르신)분의 생년월일을 입력해 주세요</p>
                                                </td>
                                            </tr>
                                            <tr>
                                                <th scope="row"><label for="roc-main-gender">성별<sup class="required">*</sup></label></th>
                                                <td class="roc-main-td-rel-me">남성</td>
                                                <td class="roc-main-td-rel-family">
                                                    <div class="form-check-group" style="border-color:#dc3545;">
                                                        <div class="form-check">
                                                            <input class="form-check-input" type="radio" name="roc-main-gender" id="gender-m" value="M">
                                                            <label class="form-check-label" for="gender-m">남성</label>
                                                        </div>
                                                        <div class="form-check">
                                                            <input class="form-check-input" type="radio" name="roc-main-gender" id="gender-w" value="W">
                                                            <label class="form-check-label" for="gender-w">여성</label>
                                                        </div>
                                                    </div>
                                                    <p class="error text-danger">! 성별을 입력해 주세요</p>
                                                </td>
                                            </tr>
                                        </tbody>
                                    </table>
                                </div>
                                <div class="flex justify-end" id="roc-main-delete-div">
                                    <button type="button" class="btn btn-primary btn-small" onclick="removeRecipientInRocModal();">삭제하기</button>
                                </div>
                                <ul class="list-style1" id="roc-main-conslt-guid-text">
                                    <li>상기 정보는 장기요양등급 신청 및 상담이 가능한 장기요양기관에 제공되며 원활한 상담 진행 목적으로 상담 기관이 변경될 수도 있습니다.</li>
                                    <li>제공되는 정보는 상기 목적으로만 활용하며 1년간 보관 후 폐기됩니다.</li>
                                    <li>가입 시 동의받은 개인정보 제3자 제공동의에따라 위의 개인정보가 제공됩니다. 동의하지 않을 경우 서비스 이용이 제한될 수 있습니다.</li>
                                </ul>
                                <div class="form-check warning" id="roc-main-conslt-aggree-div">
                                    <input class="form-check-input" type="checkbox" id="roc-main-agree-check" onchange="checkActionBtnDisabled();">
                                    <label class="form-check-label" for="roc-main-agree-check">이용약관에 따라 수급자 등록과 관리하는 것에 동의합니다.</label>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-outline-black large2" onclick="$('#roc-main-modal').modal('hide');">취소하기</button>
                        <button type="button" id="roc-main-action-btn" class="btn-warning large2 flex-1 md:flex-none md:w-1/3" onclick="startActionInRocModal();"></button>
                    </div>
                </div>
            </div>
        </div>
        
        <!-- 상담 신청 완료 모달 -->
        <div class="modal modal-default fade" id="consulting-complated-modal" tabindex="-1" aria-hidden="true">
            <div class="modal-dialog modal-dialog-centered">
                <div class="modal-content">
                <div class="modal-header">
                    <h2 class="text-title">알림</h2>
                    <button data-bs-dismiss="modal" class="btn-close">모달 닫기</button>
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
                    <a href="/membership/conslt/appl/list" class="btn-warning large2 flex-1 md:flex-none md:w-1/2">신청내역 보러가기</a>
                </div>
                </div>
            </div>
        </div>
        
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
        
        
        <script src="/html/core/vendor/twelements/index.min.js"></script>
        <script>
	    	// 시/도 Select 박스 셋팅
		    function initSido() {
		    	var template = '<option value="">시/도</option>';
		    	
		    	for(var i = 0; i < hangjungdong.sido.length; i++) {
		    		template += '<option value="' + hangjungdong.sido[i].sido + '">' + hangjungdong.sido[i].codeNm + '</option>';
		    	}
		    	
		    	$('#roc-main-sido').html(template);
		    }
	    	// 시/구/군 Select 박스 셋팅
	    	function setSigugun() {
		    	var sidoCode = $('#roc-main-sido option:selected').val();
		    	
		    	if (sidoCode) {
		    		var sigugunArray = hangjungdong.sigugun.filter(f => f.sido === sidoCode);
		    		var template = '<option value="">시/군/구</option>';
		    		
		    		for(var i = 0; i < sigugunArray.length; i++) {
		    			template += '<option value="' + sigugunArray[i].sigugun + '">' + sigugunArray[i].codeNm + '</option>';
		    		}
		    		
		    		$('#roc-main-sigugun').html(template);
		    	}
		    }
	    	// 동/읍/면 Select 박스 셋팅
		    function setDong() {
		    	var sidoCode = $('#roc-main-sido option:selected').val();
		    	var sigugunCode = $('#roc-main-sigugun option:selected').val();
		    	
		    	if (sigugunCode) {
		    		var dongArray = hangjungdong.dong.filter(f => f.sido === sidoCode && f.sigugun === sigugunCode);
		    		var template = '<option value="">동/읍/면</option>';
		    		
		    		for(var i = 0; i < dongArray.length; i++) {
		    			template += '<option value="' + dongArray[i].dong + '">' + dongArray[i].codeNm + '</option>';
		    		}
		    		
		    		$('#roc-main-dong').html(template);
		    	}
		    }
	    	
	    	$(function() {
	    		//시도 Select 박스 로딩
	    		initSido();
	    	});
        </script>
        
        <script>
        	var roc_mbrNm = '';
        	var roc_mbrTelNo = '';
        	var roc_mbrAddr = '';
        	var roc_mbrBrdt = '';
        	var roc_mbrGender = '';
        	var roc_selectedRecipient = null;
        	var roc_recipients = null;
        	var roc_modalType = '';
        	var roc_prevPath = '';
        	var roc_relationCdMap = {
   	    		<c:forEach var="relation" items="${relationCd}" varStatus="status">
   	    			'${relation.key}': '${relation.value}',
   	    		</c:forEach>
   	    		'100': '기타(친척등)',
   	    	};
        	var telchk = /^([0-9]{2,3})?-([0-9]{3,4})?-([0-9]{3,4})$/;      //전화번호 정규식
    	    var datechk = /^([1-2][0-9]{3})\/([0-1][0-9])\/([0-3][0-9])$/;  //날짜 정규식
    	    
        	
        	//수급자 등록, 수정, 상담신청 모달창 띄우기
        	function openRecipientOrConsltModal(modalType, recipientsNo, prevPath) {
        		roc_modalType = modalType;
        		roc_prevPath = prevPath;
        		
        		//상담신청 모달인 경우만 진행중인 상담 체크
        		if (roc_modalType === 'requestConslt') {
        			var consltNm = '';
            		if (roc_prevPath === 'test') {
            			consltNm = '인정등급';
            		} else if (roc_prevPath === 'equip_ctgry') {
            			consltNm = '관심 복지용구';
            		}
        			
        			//진행중인 상담 모달에 상담명 매핑
            		var guideDiv = $('#notified-consulting-guide-div').html();
           			guideDiv = guideDiv.replace('((conslt_nm))', consltNm);
           			$('#notified-consulting-guide-div').html(guideDiv);
            		
            		//진행중인 상담 조회 API
            		$.ajax({
                		type : "post",
        				url  : "/membership/info/myinfo/getRecipientConsltSttus.json",
        				data : {
        					recipientsNo : recipientsNo,
        					prevPath : roc_prevPath
        				},
        				dataType : 'json'
                	})
                	.done(function(data) {
                		//해당 수급자가 진행중인 상담이 있는 경우
                		if (data.isExistRecipientConslt) {
                			$('#notified-consulting').modal('show').appendTo('body');
                		}
                		//진행중인 상담이 없으면 모달 진행
                		else {
                			showRocMainModal(recipientsNo);
                		}
                	})
                	.fail(function(data, status, err) {
                		alert('서버와 연결이 좋지 않습니다.');
        			});
        		} else {
        			showRocMainModal(recipientsNo);
        		}
        	}
    	    
    	    function showRocMainModal(recipientsNo) {
    	    	if (roc_modalType === 'addRecipient') {
    	    		//회원 정보만 조회
        			getMbrRecipientsDataSync();
    	    		//수급자 등록 폼 셋팅
    	    		setMainFormInRocRecipientAdd();
        		} else if (roc_modalType === 'updateRecipient') {
        			//수급자 정보 조회
        			getMbrRecipientsDataSync(recipientsNo);
        			//수급자 수정 폼 셋팅
        			setMainFormInRocRecipientUpdate();
        		} else if (roc_modalType === 'requestConslt') {
        			//수급자 정보 조회
        			getMbrRecipientsDataSync(recipientsNo);
        			
        			//해당 수급자가 기타(친척)인 경우 관계 변경을 위해 마이페이지 수급자 상세로 redirect
        			if (roc_selectedRecipient.relationCd === '100') {
        				alert('수급자 관계를 수정해 주세요');
        				location.href = '/membership/info/recipients/view?recipientsNo=' + roc_selectedRecipient.recipientsNo;
        				return;
        			}
        			
        			//상담신청 폼 셋팅
        			setMainFormInRocRequestModal();
        		}
        		
        		$('#roc-main-modal').modal('show');
    	    }
        	
        	//회원 수급자 정보 가져오기(동기식 처리)
        	function getMbrRecipientsDataSync(recipientsNo) {
        		$.ajax({
    	    		type : "post",
    	    		url  : "/membership/info/myinfo/getMbrInfo.json",
    	    		async : false,
    	    		dataType : 'json'
    	    	})
    	    	.done(function(data) {
    	    		//로그인 한 경우
    	    		if (data.isLogin) {
    	    			roc_mbrNm = data.mbrVO.mbrNm;
    	    			roc_mbrTelNo = data.mbrVO.mblTelno;
    	    			roc_mbrAddr = data.mbrVO.addr;
    	    			if (data.mbrVO.brdt) {
    	    				roc_mbrBrdt = new Date(data.mbrVO.brdt);	
    	    			}
    	    			roc_mbrGender = data.mbrVO.gender;
    	    			if (recipientsNo) {
    	    				roc_selectedRecipient = data.mbrRecipients.filter(f => f.recipientsNo === recipientsNo)[0];	
    	    			}
    	    			roc_recipients = data.mbrRecipients;
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
        	
        	//메인 폼 셋팅하기 (공통)
        	function setMainFormInCommon() {
        		//수급자와의 관계가 본인이면 표시 처리
        		if (roc_selectedRecipient.relationCd === '007') {
        			$('.roc-main-td-rel-family').css('display', 'none');
        			var tdTags = $('.roc-main-td-rel-me');
        			tdTags.css('display', 'table-cell');
        			
        			//아래 table에 회원 정보 매핑
        			tdTags[0].textContent = roc_mbrTelNo;
        			tdTags[1].textContent = roc_mbrAddr;
        			if (roc_mbrBrdt) {
        				tdTags[2].textContent = roc_mbrBrdt.getFullYear() + '/' + (roc_mbrBrdt.getMonth() + 1) + '/' + roc_mbrBrdt.getDate();	
        			}
        			tdTags[3].textContent = roc_mbrGender === 'M' ? '남성' : '여성';
        		}
        		//수급자와의 관계가 가족
        		else {
        			$('.roc-main-td-rel-me').css('display', 'none');
        			var tdTags = $('.roc-main-td-rel-family');
        			tdTags.css('display', 'table-cell');
        			
        			//아래 table에 유효성 초기화
        			var telnoInput = $(tdTags[0]).find('#roc-main-telno');
        			telnoInput.removeClass('is-invalid');
        			$(tdTags[0]).find('.error').css('display', 'none');
        			
        			var sidoSelect = $(tdTags[1]).find('#roc-main-sido');
        			sidoSelect.removeClass('is-invalid');
        			var sigugunSelect = $(tdTags[1]).find('#roc-main-sigugun');
        			sigugunSelect.removeClass('is-invalid');
        			$(tdTags[1]).find('.error').css('display', 'none');
        			
        			var brdtInput = $(tdTags[2]).find('#roc-main-brdt');
        			brdtInput.removeClass('is-invalid');
        			$(tdTags[2]).find('.error').css('display', 'none');
        			
        			$(tdTags[3]).find('.form-check-group').css('border-color', '#999999');
        			$(tdTags[3]).find('.error').css('display', 'none');
        			
        			//아래 table에 수급자 정보 매핑(수급자 등록 모달창에서는 안함)
        			if (roc_modalType !== 'addRecipient') {
        				telnoInput.val(roc_selectedRecipient.tel);
            			
            			if (roc_selectedRecipient.sido) {
            				var options = $('#roc-main-sido option');
            				for(var i = 0; i < options.length; i++) {
            	    			if (options[i].text === roc_selectedRecipient.sido) {
            	    				options[i].selected = true;
            	    			}
            	    		}
            				setSigugun();
            			}
            			if (roc_selectedRecipient.sigugun) {
            				var options = $('#roc-main-sigugun option');
            	    		for(var i = 0; i < options.length; i++) {
            	    			if (options[i].text === roc_selectedRecipient.sigugun) {
            	    				options[i].selected = true;
            	    			}
            	    		}
            	    		setDong();
            			}
            			if (roc_selectedRecipient.dong) {
            				var options = $('#roc-main-dong option');
            	    		for(var i = 0; i < options.length; i++) {
            	    			if (options[i].text === roc_selectedRecipient.dong) {
            	    				options[i].selected = true;
            	    			}
            	    		}
            			}
            			
            			if (roc_selectedRecipient.brdt) {
            				brdtInput.val(roc_selectedRecipient.brdt.substring(0, 4) + '/'
            						+ roc_selectedRecipient.brdt.substring(4, 6) + '/'
            						+ roc_selectedRecipient.brdt.substring(6, 8));	
            			} else {
            				brdtInput.val('');
            			}
            			
            			if (roc_selectedRecipient.gender === 'M') {
            				$('input[name=roc-main-gender]#gender-m')[0].checked = true;
            			} else if (roc_selectedRecipient.gender === 'W') {
            				$('input[name=roc-main-gender]#gender-w')[0].checked = true;
            			} else {
            				var genderInputs = $('input[name=roc-main-gender]');
            				genderInputs[0].checked = false;
            				genderInputs[1].checked = false;
            			}
        			}
        		}
        		
        		//해당 수급자의 L번호가 있으면 L번호 표시 처리
        		if (roc_selectedRecipient.recipientsYn === 'Y') {
        			$('#roc-main-div-lno-yes').css('display', 'flex');
        			$('#roc-main-div-lno-no').css('display', 'none');
        			
        			//위 div에 L번호 매핑
        			$('#roc-main-div-lno-yes .roc-lno').text("L" + roc_selectedRecipient.rcperRcognNo);
        		} else {
        			$('#roc-main-div-lno-yes').css('display', 'none');
        			$('#roc-main-div-lno-no').css('display', 'flex');
        			
        			var lnoInput = $('#roc-rcpt-lno');
        			lnoInput.removeClass('is-invalid');
        			$('#rcpt-lno-related-error').css('display', 'none');
        			
        			//수급자 가족이면 기본 없음으로 체크 본인이면 있음으로 체크(수급자 등록 모달창에서는 안함)
        			if (roc_modalType !== 'addRecipient') {
        			//	if (roc_selectedRecipient.relationCd === '007') {
            		//		$('input[name=roc-check-lno]')[1].checked = true;
            		//	} else {
            		//		$('input[name=roc-check-lno]')[0].checked = true;
            		//	}
        				
            			//L번호 입력 초기화
            			lnoInput.val('');
            			
            			//L번호 없는 것으로 체크
            			$('input[name=roc-check-lno]')[0].checked = true;
        			}
        		}
        	}
        	
        	//수급자와의 관계 선택 템플릿
        	function getRelationCdSelectTemplate() {
        		return `
        			<select name="relationSelect" id="roc-main-relation-cd" class="form-control form-small" onchange="relationCdChangeEvent();" style="font-weight:normal !important;">
	        		<c:forEach var="relation" items="${relationCd}" varStatus="status">
	        			<option value="${relation.key}">${relation.value}</option>
		    		</c:forEach>
	    			</select>
        		`;
        	}
        	//관계 change event
        	function relationCdChangeEvent() {
        		//선택 수급자 정보 기준으로 UI를 구성하므로 해당 정보를 같이 변경
        		roc_selectedRecipient.relationCd = $('#roc-main-relation-cd').val();
        		
        		setMainFormInCommon();
        		
        		//본인일 때 회원 이름을 텍스트 처리
        		if (roc_selectedRecipient.relationCd === '007') {
        			$('#roc-main-div-rel-family .roc-recipient-nm').text(roc_mbrNm);
        		}
        		//L번호가 있을 때 수급자 이름을 텍스트 처리
        		else if (roc_selectedRecipient.recipientsYn === 'Y') {
        			$('#roc-main-div-rel-family .roc-recipient-nm').text(roc_selectedRecipient.recipientsNm);
        		}
        		else {
        			//이름 정보 Input이 없을 때만 생성 후 매핑
        			if ($('#roc-main-recipient-nm').length === 0) {
        				$('#roc-main-div-rel-family .roc-recipient-nm').html('<input type="text" class="form-control form-small w-40" id="roc-main-recipient-nm" placeholder="홍길동">');
            			$('#roc-main-recipient-nm').val(roc_selectedRecipient.recipientsNm)
        			}
        		}
        	}
        	
        	
        	//메인 폼 셋팅하기 (수급자 등록)
        	function setMainFormInRocRecipientAdd() {
        		//수급자 정보가 없으므로 선택 수급자 정보를 default 모두 없음으로 만듬
        		roc_selectedRecipient = {
       				recipientsYn : 'N',
        		};
        		setMainFormInCommon();
        		
        		//모달 타이틀 수정
        		$('#roc-main-modal .text-title').text('수급자(어르신) 정보 등록');
        		
        		//안내문구 수정
        		$('#roc-main-alert-msg').text('수급자(어르신) 정보를 등록해 주세요');
        		
        		
        		//수급자 등록에서는 무조건 이름 및 관계 표시 가족 div를 사용 및 모두 Input으로 입력 받음
        		$('#roc-main-div-rel-family').css('display', 'flex');
    			$('#roc-main-div-rel-me').css('display', 'none');
    			$('#roc-main-div-rel-family .roc-recipient-nm').html('<input type="text" class="form-control form-small w-40" id="roc-main-recipient-nm" placeholder="홍길동">');
    			$('#roc-main-div-rel-family .roc-mbr-nm').text(roc_mbrNm);
    			$('#roc-main-div-rel-family .roc-relation-text').html(getRelationCdSelectTemplate());
    			$('#roc-main-relation-cd').val('');
    			//관계 select에 placeholder 기능을하는 option 추가
    			$('#roc-main-relation-cd').prepend('<option value="" disabled selected>관계선택</option>');
    			
    			//기본 남성 체크
    			$('input[name=roc-main-gender]#gender-m')[0].checked = true;
    			
    			
        		//삭제하기 버튼 제거
        		$('#roc-main-delete-div').css('display', 'none');
        		
        		//상담 관련 문구 제거
        		$('#roc-main-conslt-nm').css('display', 'none');
        		$('#roc-main-conslt-guid-text').css('display', 'none');
        		
        		//상담동의 체크박스 제거
        		$('#roc-main-conslt-aggree-div').css('display', 'none');
        		
        		//등록하기 버튼 활성화
        		var actionBtn = $('#roc-main-action-btn');
        		actionBtn.text('등록하기')
        		actionBtn.removeClass('disabled');
        	}
        	
        	//메인 폼 셋팅하기 (수급자 수정)
        	function setMainFormInRocRecipientUpdate() {
        		setMainFormInCommon();
        		
        		//모달 타이틀 수정
        		$('#roc-main-modal .text-title').text('수급자(어르신) 정보 수정');
        		
        		//안내문구 수정
        		$('#roc-main-alert-msg').text('정보를 확인하시고 수정사항이 있을 경우 수정해 주세요');
        		
        		
        		//수급자 수정에서는 무조건 이름 및 관계 표시 가족 div를 사용
        		$('#roc-main-div-rel-family').css('display', 'flex');
    			$('#roc-main-div-rel-me').css('display', 'none');
        		//본인일 때 회원 이름을 텍스트 처리
        		if (roc_selectedRecipient.relationCd === '007') {
        			$('#roc-main-div-rel-family .roc-recipient-nm').text(roc_mbrNm);
        		}
        		//L번호가 있을 때 수급자 이름을 텍스트 처리
        		else if (roc_selectedRecipient.recipientsYn === 'Y') {
        			$('#roc-main-div-rel-family .roc-recipient-nm').text(roc_selectedRecipient.recipientsNm);
        		}
        		else {
        			$('#roc-main-div-rel-family .roc-recipient-nm').html('<input type="text" class="form-control form-small w-40" id="roc-main-recipient-nm" placeholder="홍길동">');
        			//이름정보 매핑
        			$('#roc-main-recipient-nm').val(roc_selectedRecipient.recipientsNm)
        		}
        		$('#roc-main-div-rel-family .roc-mbr-nm').text(roc_mbrNm);
    			$('#roc-main-div-rel-family .roc-relation-text').html(getRelationCdSelectTemplate());
    			//관계정보 매핑
    			$('#roc-main-relation-cd').val(roc_selectedRecipient.relationCd);
    			
        		
        		//삭제하기 버튼 표시
        		$('#roc-main-delete-div').css('display', 'flex');
        		
        		//상담 관련 문구 제거
        		$('#roc-main-conslt-nm').css('display', 'none');
        		$('#roc-main-conslt-guid-text').css('display', 'none');
        		
        		//상담동의 체크박스 제거
        		$('#roc-main-conslt-aggree-div').css('display', 'none');
        		
        		//수정하기 버튼 활성화
        		var actionBtn = $('#roc-main-action-btn');
        		actionBtn.text('수정하기')
        		actionBtn.removeClass('disabled');
        	}
        	
        	//메인 폼 셋팅하기 (상담신청)
        	function setMainFormInRocRequestModal() {
        		setMainFormInCommon();
        		
        		//모달 타이틀 수정
        		$('#roc-main-modal .text-title').text('상담 정보 확인');
        		
        		//안내문구 수정
        		$('#roc-main-alert-msg').text('정보를 확인하시고 상담 시 필요 정보를 입력해 주세요');
        		
        		//본인인 경우 수급자 이름 및 관계 텍스트 처리
        		if (roc_selectedRecipient.relationCd === '007') {
        			$('#roc-main-div-rel-family').css('display', 'none');
        			$('#roc-main-div-rel-me').css('display', 'flex');
        			
        			//위 div에 회원 정보 매핑
        			$('#roc-main-div-rel-me .roc-mbr-nm').text(roc_mbrNm);
        		}
        		//가족인 경우
        		else {
        			$('#roc-main-div-rel-family').css('display', 'flex');
        			$('#roc-main-div-rel-me').css('display', 'none');
        			
        			//위 div에 수급자 정보 매핑
        			$('#roc-main-div-rel-family .roc-recipient-nm').text(roc_selectedRecipient.recipientsNm);
        			$('#roc-main-div-rel-family .roc-mbr-nm').text(roc_mbrNm);
        			$('#roc-main-div-rel-family .roc-relation-text').text(roc_relationCdMap[roc_selectedRecipient.relationCd]);
        		}
        		
        		//삭제하기 버튼 제거
        		$('#roc-main-delete-div').css('display', 'none');
        		
        		//상담유형 문구 표시 처리
        		$('#roc-main-conslt-nm').css('display', 'block');
        		if (roc_prevPath === 'test') {
    				$('#roc-main-conslt-nm .text-indexKey1').text('인정등급상담');
    			} else if (roc_prevPath === 'equip_ctgry') {
    				$('#roc-main-conslt-nm .text-indexKey1').text('복지용구상담');	
    			}
        		
        		//상담 관련 문구 표시
        		$('#roc-main-conslt-guid-text').css('display', 'block');
        		
        		//상담동의 표시 및 동의 defualt 처리
        		$('#roc-main-conslt-aggree-div').css('display', 'block');
        		$('#roc-main-agree-check')[0].checked = true;
        		
        		//최초 상담하기 버튼 활성화 처리
        		var actionBtn = $('#roc-main-action-btn');
        		actionBtn.text('상담 신청하기')
        		actionBtn.removeClass('disabled');
        	}
        	
        	//동의 여부를 확인하여 Action 버튼 활성화 처리
        	function checkActionBtnDisabled() {
        		if($('#roc-main-agree-check')[0].checked) {
        			$('#roc-main-action-btn').removeClass('disabled');
        		} else {
        			$('#roc-main-action-btn').addClass('disabled');
        		}
        	}
        	
        	//유효성 검사를 통해 신청 Form에 유효성 알림 표시
        	function validationInRocModal() {
        		var validData = true;
        		
        		//수급자 등록, 수정에서 추가 유효성 검사
        		if (roc_modalType === 'addRecipient' || roc_modalType === 'updateRecipient') {
        			var nameAndRelationCheck = true;
        			
        			//L번호를 등록안했으면서 본인이 아닌 경우는 이름도 검사
        			if (roc_selectedRecipient.recipientsYn !== 'Y' && roc_selectedRecipient.relationCd !== '007') {
        				var recipientNm = $('#roc-main-recipient-nm').val();
        				if (!recipientNm) {
        					nameAndRelationCheck = false;
        				}
        			}
        			
        			var relationCd = $('#roc-main-relation-cd').val();
        			if (!relationCd) {
        				nameAndRelationCheck = false;
        			}
        			
        			if (!nameAndRelationCheck) {
        				alert('수급자(어르신) 성함 및 관계를 입력하세요');
        				validData = false;
        			}
        		}
        		
        		//수급자 L번호가 없을 때
    			if (roc_selectedRecipient.recipientsYn !== 'Y') {
        			var lnoInput = $('#roc-rcpt-lno');
        			//L번호 등록하려고 하는 지 검사
        			if ($('input[name=roc-check-lno]:checked').val() === 'Y') { 
        				var lno = lnoInput.val();
        				//L번호 10자리 체크
        				if (!lno || lno.length != 10) {
        					$(lnoInput).addClass('is-invalid');
        					$('#rcpt-lno-related-error').css('display', 'block');
        					validData = false;
        				}
        			} else {
        				//L번호 유효성 체크 제거
            			$(lnoInput).removeClass('is-invalid');
    					$('#rcpt-lno-related-error').css('display', 'none');	
        			}
    			}
    			
    			//관계가 본인이 아닐 때 아래 테이블 입력값 검사
    			if (roc_selectedRecipient.relationCd !== '007') {
    				var tdTags = $('.roc-main-td-rel-family');
    				var telnoInput = $(tdTags[0]).find('#roc-main-telno');
    				var sidoSelect = $(tdTags[1]).find('#roc-main-sido');
    				var sigugunSelect = $(tdTags[1]).find('#roc-main-sigugun');
    				var brdtInput = $(tdTags[2]).find('#roc-main-brdt');
    				
    				var tel = telnoInput.val();
    				var sido = $('#roc-main-sido option:selected').text();
    				var sigugun = $('#roc-main-sigugun option:selected').text();
    				var dong = $('#roc-main-dong option:selected').text();
    				var brdt = brdtInput.val();
    				var gender = $('input[name=roc-main-gender]:checked').val();
    				
    				//연락처 형식 검사
    				if (!tel || telchk.test(tel) === false) {
            			telnoInput.addClass('is-invalid');
            			
            			var errorTextTag = $(tdTags[0]).find('.error.text-danger'); 
            			errorTextTag.css('display', 'block');
            			if (!tel) {
            				errorTextTag.text('! 상담 전화 받으실 분의 연락처를 입력해 주세요');
            			} else if (telchk.test(tel) === false) {
            				errorTextTag.text('! 연락처 형식이 올바르지 않습니다 (예시: 010-1234-5678)');
            			}
            			
            			validData = false;
    				} else {
    					telnoInput.removeClass('is-invalid');
            			$(tdTags[0]).find('.error.text-danger').css('display', 'none');
    				}
    				
    				//시도 검사
    				var addrCheck = true;
    				if (sido === '시/도') {
            			sidoSelect.addClass('is-invalid');
            			addrCheck = false;
    				} else {
    					sidoSelect.removeClass('is-invalid');
    				}
    				//시군구 검사
    				if (sigugun === '시/군/구') {
    					sigugunSelect.addClass('is-invalid');
    					addrCheck = false;
    				} else {
    					sigugunSelect.removeClass('is-invalid');
    				}
    				if (!addrCheck) {
    					$(tdTags[1]).find('.error.text-danger').css('display', 'block');
    					validData = false;
    				} else {
    					$(tdTags[1]).find('.error.text-danger').css('display', 'none');
    				}
    				
    				//생년월일 형식 검사
    				if (!brdt || datechk.test(brdt) === false) {
            			brdtInput.addClass('is-invalid');
            			
            			var errorTextTag = $(tdTags[2]).find('.error.text-danger'); 
            			errorTextTag.css('display', 'block');
            			if (!brdt) {
            				errorTextTag.text('! 수급자(어르신)분의 생년월일을 입력해 주세요');
            			} else if (datechk.test(brdt) === false) {
            				errorTextTag.text('! 생년월일 8자리를 입력해 주세요 (예시: 1950/01/01)');
            			}
            			
            			validData = false;
    				} else {
    					brdtInput.removeClass('is-invalid');
            			$(tdTags[2]).find('.error.text-danger').css('display', 'none');
    				}
    				
    				//성별 검사
					if (!gender) {
						$(tdTags[3]).find('.form-check-group').css('border-color', '#dc3545');
	        			$(tdTags[3]).find('.error.text-danger').css('display', 'block');
	        			validData = false;
					} else {
						$(tdTags[3]).find('.form-check-group').css('border-color', '#999999');
	        			$(tdTags[3]).find('.error.text-danger').css('display', 'none');
					}
    			}
        		
        		return validData;
        	}
        	
        	//수급자 등록, 수정, 상담신청하기
        	function startActionInRocModal() {
        		//유효성 검사
        		if (!validationInRocModal()) {
        			return;
        		}
        		
				var tel = '';
				var sido = '';
				var sigugun = '';
				var dong = '';
				var brdt = '';
				var gender = '';
        		
				var jsonData = {};
				
				//본인인 경우는 입력정보 필요없음
				if (roc_selectedRecipient.relationCd !== '007') {
					var tdTags = $('.roc-main-td-rel-family');
					var telnoInput = $(tdTags[0]).find('#roc-main-telno');
					var brdtInput = $(tdTags[2]).find('#roc-main-brdt');
					
					tel = telnoInput.val();
					sido = $('#roc-main-sido option:selected').text();
					sigugun = $('#roc-main-sigugun option:selected').text();
					dong = $('#roc-main-dong option:selected').text();
					brdt = brdtInput.val();
					gender = $('input[name=roc-main-gender]:checked').val();
					
					jsonData.tel = tel;
					jsonData.sido = sido;
					jsonData.sigugun = sigugun;
					jsonData.dong = dong;
					jsonData.brdt = brdt;
					jsonData.gender = gender;
				}
				
				//수급자 정보 등록, 수정 공통 요청 파라미터 매핑
				if (roc_modalType === 'addRecipient' || roc_modalType === 'updateRecipient') {
					var relationCd = $('#roc-main-relation-cd').val();
					
					jsonData.recipientsNo = roc_selectedRecipient.recipientsNo;
					jsonData.relationCd = relationCd;
					
					//본인일 때 회원 이름 저장
	        		if (roc_selectedRecipient.relationCd === '007') {
	        			jsonData.recipientsNm = roc_mbrNm;
	        		}
	        		//L번호가 있을 때 수급자 이름 저장
	        		else if (roc_selectedRecipient.recipientsYn === 'Y') {
	        			jsonData.recipientsNm = roc_selectedRecipient.recipientsNm;
	        		}
					//나머지 경우에는 입력 필드에 값 저장
	        		else {
	        			jsonData.recipientsNm = $('#roc-main-recipient-nm').val();
	        		}
					
					//수급자가 L번호가 있었으면 그대로 저장
					if (roc_selectedRecipient.recipientsYn === 'Y') {
						jsonData.rcperRcognNo = roc_selectedRecipient.rcperRcognNo;
					}
					//수급자 L번호가 없었는데 등록하려고 하는 경우
					else if (roc_selectedRecipient.recipientsYn !== 'Y' && $('input[name=roc-check-lno]:checked').val() === 'Y') {
						jsonData.rcperRcognNo = $('#roc-rcpt-lno').val();
					}
				}
				
				
        		//수급자 정보 등록
        		if (roc_modalType === 'addRecipient') {
        			//수급자 등록 API 호출
        	    	jsCallApi.call_api_post_json(window, "/membership/info/myinfo/addMbrRecipient.json", "addMbrRecipientCallback", jsonData);
        		}
        		//수급자 정보 수정
        		else if (roc_modalType === 'updateRecipient') {
        			//수급자 정보 수정 API 호출
    		    	jsCallApi.call_api_post_json(window, "/membership/info/myinfo/updateMbrRecipient.json", "updateMbrRecipientCallback", jsonData);
        		}
        		//상담신청
        		else if (roc_modalType === 'requestConslt') {
        			var consltRequestData = {
       					recipientsNo : roc_selectedRecipient.recipientsNo,
       					prevPath : roc_prevPath,
        			};
        			
        			//수급자 L번호가 없었는데 등록하려고 하는 경우
    				if (roc_selectedRecipient.recipientsYn !== 'Y' && $('input[name=roc-check-lno]:checked').val() === 'Y') {
    					consltRequestData.saveRecipientInfo = confirm('입력하신 수급자 정보도 함께 저장하시겠습니까?');
    					consltRequestData.rcperRcognNo = $('#roc-rcpt-lno').val();
    				}
        			
        			//본인인 경우
        			if (roc_selectedRecipient.relationCd === '007') {
        				//아직 수급자정보 같이 저장 입력안받은 경우
       				    if (consltRequestData.saveRecipientInfo === undefined) {
        					consltRequestData.saveRecipientInfo = true;
        				}
        			}
        			//가족인 경우
        			else {
        				//아직 수급자정보 같이 저장 입력안받고 수급자 정보가 변경된 경우
       				    if (consltRequestData.saveRecipientInfo === undefined && (
       				    		roc_selectedRecipient.tel !== (tel ? tel : null) ||
       				    		roc_selectedRecipient.sido !== (sido ? sido : null) ||
       				    		roc_selectedRecipient.sigugun !== (sigugun ? sigugun : null) ||
       				    		roc_selectedRecipient.dong !== (dong ? dong : null) ||
       				    		roc_selectedRecipient.brdt !== (brdt ? brdt.replaceAll('/', '') : null) ||
       				    		roc_selectedRecipient.gender !== (gender ? gender : null))) {
       				    	consltRequestData.saveRecipientInfo = confirm('입력하신 수급자 정보도 함께 저장하시겠습니까?');
        				} else if (consltRequestData.saveRecipientInfo === undefined) {
        					consltRequestData.saveRecipientInfo = false;
        				}
        				
        				//요청 파라미터 매핑
        				consltRequestData.mbrTelno = tel;
        				consltRequestData.zip = sido;
        				consltRequestData.addr = sigugun;
        				consltRequestData.daddr = dong;
        				consltRequestData.brdt = brdt;
        				consltRequestData.gender = gender;
        			}
        			
        			//상담신청 API 호출
    		    	jsCallApi.call_api_post_json(window, "/main/conslt/addMbrConslt.json", "addMbrConsltCallback", consltRequestData);
        		}
        	}
        	// 수급자 등록 콜백
    	    function addMbrRecipientCallback(result, errorResult, data, param) {
    	    	if (errorResult == null) {
    	    		var data = result;
    	    		
    	    		if(data.success) {
    	    			location.reload();
    	    		}else{
    	    			alert(data.msg);
    	    		}
    	    	} else {
    	    		alert('서버와 연결이 좋지 않습니다.');
    	    	}
    	    }
        	// 수급자 정보 수정 콜백
    	    function updateMbrRecipientCallback(result, errorResult, data, param) {
    	    	if (errorResult == null) {
    	    		var data = result;
    	    		
    	    		if(data.success) {
    	    			$('#roc-main-modal').modal('hide');
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
    	    			$('#roc-main-modal').modal('hide');
    	    			$('#consulting-complated-modal').modal('show').appendTo('body');
    	    			
    	    			//채널톡 이벤트 처리
    	    			if (roc_prevPath === 'test') {
    	    				eventChannelTalkForConslt('click_gradetest_matching');	
    	    			}
    	    		}else{
    	    			alert(data.msg);
    	    		}
    	    	} else {
    	    		alert('서버와 연결이 좋지 않습니다.');
    	    	}
    	    }
        	
        	//수급자 삭제하기
        	function removeRecipientInRocModal() {
		    	var recipientsNo = roc_selectedRecipient.recipientsNo;
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
        	
        	
        	//채널톡 event 처리 (1:1 상담하기 신청)
        	function eventChannelTalkForConslt(eventName) {
        		if (eventName === 'click_gradetest_matching') {
        			//수급자의 테스트 정보 가져오기
        			$.ajax({
        				type: "get",
        				url: "/membership/info/myinfo/getRecipientTestInfo.json",
        				data: {
        					recipientsNo : roc_selectedRecipient.recipientsNo,
        				},
        				dataType : 'json'
        			})
        			.done(function(data) {
        				if(data.success && data.mbrTestVO) {
        					//예상결과 등급
            			    var grade = data.mbrTestVO.grade;
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
        				}
        			})
        			.fail(function(data, status, err) {
        				alert('서버와 연결이 좋지 않습니다.');
        			});
        		}
        	}
        	
        	
        	//각 입력필드 포커스 이벤트
        	function onfocusInRocModal(inputTitle) {
        		var tdTags = $('.roc-main-td-rel-family');
        		var borderEffect = {
        			"border-color" : "#198754",
        			"border-width" : "2px",
        		};
        		
        		if (inputTitle === 'telno') {
        			var telnoInput = $('#roc-main-telno');
        			
        			telnoInput.css(borderEffect);
        			$(tdTags[0]).find('.error.text-valid').css('display', 'block');
        			
        			//유효성 error문구가 있으면 삭제
        			telnoInput.removeClass('is-invalid');
        			$(tdTags[0]).find('.error.text-danger').css('display', 'none');
        		}
        		else if (inputTitle === 'sido' || inputTitle === 'sigugun') {
        			var sidoSelect = $('#roc-main-sido');
        			var sigugunSelect = $('#roc-main-sigugun');
        			
        			sidoSelect.css(borderEffect);
        			sigugunSelect.css(borderEffect);
        			$(tdTags[1]).find('.error.text-valid').css('display', 'block');
        			
        			//유효성 error문구가 있으면 삭제
        			sidoSelect.removeClass('is-invalid');
        			sigugunSelect.removeClass('is-invalid');
        			$(tdTags[1]).find('.error.text-danger').css('display', 'none');
        		}
        		else if (inputTitle === 'brdt') {
        			var brdtInput = $('#roc-main-brdt');
        			
        			brdtInput.css(borderEffect);
        			$(tdTags[2]).find('.error.text-valid').css('display', 'block');
        			
        			//유효성 error문구가 있으면 삭제
        			brdtInput.removeClass('is-invalid');
        			$(tdTags[2]).find('.error.text-danger').css('display', 'none');
        		}
        	}
        	//각 입력필드 블러 이벤트
        	function onblurInRocModal(inputTitle) {
        		var tdTags = $('.roc-main-td-rel-family');
				var noneEffect = {
					"border-color" : "",
        			"border-width" : "",
        		};
        		
        		if (inputTitle === 'telno') {
        			$('#roc-main-telno').css(noneEffect);
        			$(tdTags[0]).find('.error.text-valid').css('display', 'none');
        		}
				else if (inputTitle === 'sido' || inputTitle === 'sigugun') {
					$('#roc-main-sido').css(noneEffect);
					$('#roc-main-sigugun').css(noneEffect);
					$(tdTags[1]).find('.error.text-valid').css('display', 'none');
        		}
				else if (inputTitle === 'brdt') {
					$('#roc-main-brdt').css(noneEffect);
					$(tdTags[2]).find('.error.text-valid').css('display', 'none');
        		}
        	}
        	
        	//L번호 입력 시 없습니다가 아닌 있는 것으로 체크 처리
        	function inputEventLnoInRocModal() {
        		var lno = $('#roc-rcpt-lno').val();
        		if (lno && lno.length > 0) {
        			$('input[name=roc-check-lno]')[1].checked = true;
        		} else {
        			$('input[name=roc-check-lno]')[0].checked = true;
        		}
        	}
        </script>