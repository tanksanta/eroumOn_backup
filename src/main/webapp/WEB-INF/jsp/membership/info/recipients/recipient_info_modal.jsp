<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

	<!--모달: 수급자 정보 -->
	<div class="modal modal-default fade" id="pop-client-edit" tabindex="-1" aria-hidden="true">
		<div class="modal-dialog modal-dialog-centered modal-lg">
			<div class="modal-content">
			<div class="modal-header">
				<h2 class="text-title">수급자 정보 수정</h2>
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
                                    <label for="recipter">수급자와의 관계<sup class="text-danger text-base md:text-lg">*</sup></label>
                                </p>
                            </th>
                            <td>
                                <select name="relationSelect" id="info-relationSelect" class="form-control w-full lg:w-8/12">
                                    <option value="">관계 선택</option>
									<c:forEach var="relation" items="${mbrRelationCode}" varStatus="status">
										<option value="${relation.key}">${relation.value}</option>	
									</c:forEach>
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
                                <input type="text" class="form-control  lg:w-8/12" id="info-recipientsNm" name="info-recipientsNm" maxlength="50" value="">
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
                                    <input type="text" class="form-control " id="info-rcperRcognNo" name="info-rcperRcognNo" maxlength="13" value="">
                                </div>
                            </td>
                        </tr>
						<tr>
                            <th scope="row">
                                <p><label for="search-item6">상담받을 연락처<sup class="text-danger text-base md:text-lg">*</sup></label></p>
                            </th>
                            <td><input type="text" class="form-control w-full lg:w-8/12" id="info-tel"></td>
                        </tr> 
						<tr>
                            <th scope="row">
                                <p><label for="search-item6">실거주지 주소<sup class="text-danger text-base md:text-lg">*</sup></label></p>
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
                            <th scope="row"><p><label for="search-item4">생년월일<sup class="text-danger text-base md:text-lg">*</sup></label></p></th>
                            <td><input type="text" class="form-control  lg:w-8/12" id="info-brdt" placeholder="1950/01/01"></td>
                        </tr>
						<tr>
                        	<th scope="row"><p><label for="search-item4">성별<sup class="text-danger text-base md:text-lg">*</sup></label></p></th>
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
						<tr class="top-border">
							<td></td>
							<td></td>
						</tr>
					</tbody>
				</table>
				<div class="flex justify-end">
					<button class="btn-text-primary">삭제하기</button>
				</div>
			</div>
			<div class="modal-footer md:w-3/4 mx-auto mt-4">
				<button type="button" class="btn btn-primary large w-3/5" onclick="requestAction();">등록하기</button>
				<button type="button" class="btn btn-outline-primary large w-2/5">취소하기</button>
			</div>
			</div>
		</div>
	</div>

    <script>
	    var me = {};
	    var myRecipientInfo = {};
	    var mbrRecipients = {};
	    var infoModalType = '';
    
	  	//수급자 등록 수정 ,상담신청 모달창 띄우기(또는 진행중인 상담존재 모달에서 새롭게 진행하기 클릭)
	    function openModal(modalType, recipientsNo) {
	    	infoModalType = modalType;
	  		if (modalType === 'updateRecipient') {
	  			mappingModalData(recipientsNo);	
	  		}
	    }
	  	
	  	function mappingModalData(recipientsNo) {
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
	    			
	    			//모달 데이터 매핑
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
	    	    	
	    	    	
	    	    	$('#pop-client-edit').modal('show');
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
	    var telchk = /^([0-9]{2,3})?-([0-9]{3,4})?-([0-9]{3,4})$/;
	    var datechk = /^([1-2][0-9]{3})\/([0-1][0-9])\/([0-3][0-9])$/;
	    function requestAction() {
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
	    	if (!tel) {
	    		alert('상담받을 연락처를 입력하세요');
	    		return;
	    	}
	    	if (!sidoCode || !sigugunCode || !dongCode) {
	    		alert('실거주지 주소를 모두 선택하세요');
	    		return;
	    	}
	    	if (!brdt) {
	    		alert('생년월일를 입력하세요');
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
	    	var meCount = mbrRecipients.filter(f => f.recipientsNo !== myRecipientInfo.recipientsNo && f.relationCd === '007').length; //내 수급자가 아닌 다른수급자도 본인인지 확인
	    	var spouseCount = mbrRecipients.filter(f => f.recipientsNo !== myRecipientInfo.recipientsNo && f.relationCd === '001').length; //내 수급자가 아닌 다른수급자도 배우자인지 확인
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
	    	
	    	//수급자 정보 수정
	    	if (infoModalType === 'addRecipient') {
	    		$.ajax({
		    		type : "post",
		    		url  : "/membership/info/myinfo/addMbrRecipient.json",
		    		data : jsonData,
		    		dataType : 'json'
		    	})
		    	.done(function(data) {
		    		if(data.success) {
		    			$('#modal-consulting-info').modal('hide');
		    			$('#modal-consulting-complated').modal('show');
		    		}else{
		    			alert(data.msg);
		    		}
		    	})
		    	.fail(function(data, status, err) {
		    		alert('서버와 연결이 좋지 않습니다.');
		    	});
	    	}
	    	//수급자 정보 수정
	    	else if (infoModalType === 'updateRecipient') {
	    		jsonData.recipientsNo = myRecipientInfo.recipientsNo;
	    		
		    	$.ajax({
		    		type : "post",
		    		url  : "/membership/info/myinfo/updateMbrRecipient.json",
		    		data : jsonData,
		    		dataType : 'json'
		    	})
		    	.done(function(data) {
		    		if(data.success) {
		    			$('#pop-client-edit').modal('hide');
		    			location.reload();
		    		}else{
		    			alert(data.msg);
		    		}
		    	})
		    	.fail(function(data, status, err) {
		    		alert('서버와 연결이 좋지 않습니다.');
		    	});
	    	}
	    	//상담신청
	    	else {
				var saveRecipientInfo = confirm('입력하신 수급자 정보를 마이페이지에도 저장하시겠습니까?');
		    	
		    	$.ajax({
		    		type : "post",
		    		url  : "/main/conslt/addMbrConslt.json",
		    		data : {
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
		    			, prevPath: 'simpleSearch'
		    			, saveRecipientInfo
		    		},
		    		dataType : 'json'
		    	})
		    	.done(function(data) {
		    		if(data.success) {
		    			$('#modal-consulting-info').modal('hide');
		    			$('#modal-consulting-complated').modal('show');
		    		}else{
		    			alert(data.msg);
		    		}
		    	})
		    	.fail(function(data, status, err) {
		    		alert('서버와 연결이 좋지 않습니다.');
		    	});
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
	    	var sigugunCode = $('#sigugun option:selected').val();
	    	
	    	if (sigugunCode) {
	    		var dongArray = hangjungdong.dong.filter(f => f.sigugun === sigugunCode);
	    		var template = '<option value="">동/읍/면</option>';
	    		
	    		for(var i = 0; i < dongArray.length; i++) {
	    			template += '<option value="' + dongArray[i].dong + '">' + dongArray[i].codeNm + '</option>';
	    		}
	    		
	    		$('#dong').html(template);
	    	}
	    }
	    
	    $(function() {
	    	initSido();
	    });
    </script>
