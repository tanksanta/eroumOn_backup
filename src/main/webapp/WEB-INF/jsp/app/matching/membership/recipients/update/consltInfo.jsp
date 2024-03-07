<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

	<div class="wrapper">

		<!-- 상단 뒤로가기 버튼 추가 -->
	    <jsp:include page="/WEB-INF/jsp/app/matching/common/topButton.jsp">
	        <jsp:param value="어르신 상담 정보 수정" name="addTitle" />
	    </jsp:include>
	    
	    
	    <main>
            <section class="default">

                <form action="">

                    <label class="input_label">상담받을 연락처</label>
                    <input id="inputMobile" type="tel" class="input_basic keycontrol phonenumber bder_danger" value="${curRecipientInfo.tel}">
					<div id="mobileErrorMsg" class="vaild_txt error">유효성 체크 텍스트입니다. Help message</div>
		
                    <div class="h32"></div>

                    <label class="input_label c_757575">서비스받을 지역</label>
                    <div class="d-flex gap08">
                        <div class="fg1">
                            <a id="aTagSido" class="input_basic fake_select modal-trigger region01_btn_evt bder_danger" href="#modal_region01">${curRecipientInfo.sido}</a>
                        </div>
                        <div class="fg1">
                            <a id="aTagSigugun" class="input_basic fake_select modal-trigger region02_btn_evt bder_danger" href="#modal_region02">${curRecipientInfo.sigugun}</a>
                        </div>
                    </div>
                    <div id="areaErrorMsg" class="vaild_txt error">유효성 체크 텍스트입니다. Help message</div>

                </form>

                <div class="h32"></div>

                <div class="card-panel default">
                    과거 신청한 상담 정보는 변경되지 않아요
                </div>

            </section>
        </main>


        <footer class="page-footer">

            <div class="relative">
                <a class="waves-effect btn-large btn_primary w100p" onclick="clickUpdateRecipient();">수정하기</a>
            </div>

        </footer>
	    
	    
        <!-- 시/도 modal -->
        <div id="modal_region01" class="modal bottom-sheet">

            <div class="modal_header">
                <h4 class="modal_title">

                    <div class="breadCb">
                        <span class="dept01 active">시/도</span>
                        <span class="dept02">시/군/구</span>
                    </div>

                </h4>
                <div class="close_x modal-close waves-effect"></div>
            </div>

            <div class="modal-content">

                <div class="h16"></div>

                <ul id="ulSido" title="region01" class="chip_area scrollBox height_top">
                    
                </ul>
            </div>
        </div>


        <!-- 시/군/구 modal -->
        <div id="modal_region02" class="modal bottom-sheet">

            <div class="modal_header">
                <h4 class="modal_title">

                    <div class="breadCb">
                        <span id="selectedSido" class="dept01 selected">시/도</span>
                        <span class="dept02 active">시/군/구</span>
                    </div>

                </h4>
                <div class="close_x modal-close waves-effect"></div>
            </div>

            <div class="modal-content">

                <div class="h16"></div>

                <ul id="ulSigugun" title="region02" class="chip_area scrollBox height_top">
                
                </ul>
            </div>
        </div>
	    
	</div>
	<!-- wrapper -->
	
	
	<script src="/html/core/script/hangjungdong.js"></script>
	<script>
		var _jsCommon;
		var recipientsNo = '${curRecipientInfo.recipientsNo}';
		var sidoCode = '';    //선택된 시/도 코드값
		var sigugunCode = ''; //선택된 시/군/구 코드값
	
		var phonechk = /^01([0|1|6|7|8|9])-?([0-9]{3,4})-?([0-9]{4})$/;
		
		
		// UI초기화
		function initialize() {
			var inputMobile = $('#inputMobile');
			var aTagSido = $('#aTagSido');
			var aTagSigugun = $('#aTagSigugun');
			
			inputMobile.removeClass('bder_danger');
			aTagSido.removeClass('bder_danger');
			aTagSigugun.removeClass('bder_danger');
			
			var mobileErrorMsg = $('#mobileErrorMsg');
			var areaErrorMsg = $('#areaErrorMsg');
			mobileErrorMsg.addClass('disNone');
			areaErrorMsg.addClass('disNone');
		}
		
		// 유효성 검사
		function validation() {
			var isValid = true;
			var inputMobile = $('#inputMobile');
			var aTagSido = $('#aTagSido');
			var aTagSigugun = $('#aTagSigugun');
			
			var mobileErrorMsg = $('#mobileErrorMsg');
			var areaErrorMsg = $('#areaErrorMsg');
			
			//번호
			var mobile = inputMobile.val();
			if (!mobile || !phonechk.test(mobile)) {
				inputMobile.addClass('bder_danger');
				mobileErrorMsg.text('번호를 확인해주세요');
				mobileErrorMsg.removeClass('disNone');
				isValid = false;
			} else {
				inputMobile.removeClass('bder_danger');
				mobileErrorMsg.addClass('disNone');
			}
			
			//지역
			var areaValid = true;
			var sido = aTagSido.text();
			var sigugun = aTagSigugun.text();
			if (!sido) {
				aTagSido.addClass('bder_danger');
				areaValid = false;
			} else {
				aTagSido.removeClass('bder_danger');
			}
			if (!sigugun) {
				aTagSigugun.addClass('bder_danger');
				areaValid = false;
			} else {
				aTagSigugun.removeClass('bder_danger');
			}
			
			if (!areaValid) {
				areaErrorMsg.text('지역을 선택하세요');
				areaErrorMsg.removeClass('disNone');
				isValid = false;
			} else {
				areaErrorMsg.addClass('disNone');
			}
			
			return isValid;
		}
		
		//수정하기 버튼 클릭 이벤트
		async function clickUpdateRecipient() {
			var valid = validation();
			if (!valid) {
				return;
			}
			
			var answer = await showConfirmPopup('정말 수정하시겠어요?', '정확한 정보를 입력하셔야 필요한 정보를 받을 수 있어요');
			if (answer === 'confirm') {
				var inputMobile = $('#inputMobile');
				var aTagSido = $('#aTagSido');
				var aTagSigugun = $('#aTagSigugun');
				
				var tel = inputMobile.val();
				var sido = aTagSido.text();
				var sigugun = aTagSigugun.text();
				
				callPostAjaxIfFailOnlyMsg(
	        		'/matching/membership/recipients/updateMbrRecipient.json',
	        		{
	        			recipientsNo : Number(recipientsNo),
	        			updateType : 'conslt',
	        			tel,
	        			sido,
	        			sigugun,
	        		},
	        		function(result) {
	        			backBtnEvent();
	        		}
	     		);
			}
		}
		
		
		// 시/도 셋팅
		function initSido() {
			var template = '';
			for(var i = 0; i < hangjungdong.sido.length; i++) {
				template += '<li code="' + hangjungdong.sido[i].sido + '">' + hangjungdong.sido[i].codeNm + '</li>';
			}
			$('#ulSido').html(template);
		}
		// 시/군/구 셋팅
		function setSigugun() {
	    	if (sidoCode) {
	    		var sigugunArray = hangjungdong.sigugun.filter(f => f.sido === sidoCode);
	    		var template = '';
	    		
	    		for(var i = 0; i < sigugunArray.length; i++) {
	    			template += '<li class="waves-effect modal-close" onclick="clickSigugun(this);">' + sigugunArray[i].codeNm + '</li>';
	    		}
	    		$('#ulSigugun').html(template);
	    	}
		}
	
		// 시도 클릭 이벤트
		function clickSido() {
			//셀렉트박스 텍스트 변경
            var thisRegion = $(this).parent('.chip_area').attr('title');
            var thisTxt = $(this).text();
            var code = $(this).attr('code');
            if (code) {
            	$('#selectedSido').text(thisTxt);
            	sidoCode = code;
            	
            	// 시/군/구 셋팅
                setSigugun();
            }

            $('.' + thisRegion + '_btn_evt').text(thisTxt);
            
            
            //버튼 활성화 클래스변경
            $(this).parent('.chip_area').find('li').removeClass('active');
            $(this).addClass('active');
		}
		// 시군구 클릭 이벤트
		function clickSigugun(obj) {
			var thisRegion = $(obj).parent('.chip_area').attr('title');
            var thisTxt = $(obj).text();
            
            $('.' + thisRegion + '_btn_evt').text(thisTxt);
            
          	//버튼 활성화 클래스변경
            $(obj).parent('.chip_area').find('li').removeClass('active');
            $(obj).addClass('active');
		}
		
		
		$(function() {
			_jsCommon = new JsCommon();
            _jsCommon.fn_keycontrol();
            
            // UI초기화
            initialize();
            
         	// 시/도 셋팅
			initSido();
			
			
			//시도 지역선택 chip
            $('.chip_area li').click(clickSido);
			
	        //관련 클래스 및 modal오픈 설정
	        $('[title^="region01"] li').each(function () {
	
	            $(this).prop({
	                'href': '#modal_region02',
	                'class': 'waves-effect modal-close modal-trigger'
	            });
	
	        });
		});
	</script>