<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

	<div class="wrapper">
	
       	<!-- 상단 뒤로가기 버튼 추가 -->
		<jsp:include page="/WEB-INF/jsp/app/matching/common/topButton.jsp" />
        
        <main>
            <section class="intro">

                <h3 class="title">
                    어르신이 서비스 받을 지역을<br />확인해주세요
                </h3>

                <div class="h40"></div>

                <div class="d-flex gap08">
                    <div class="fg1">

                        <label class="input_label c_757575">시/도</label>
                        <a class="input_basic fake_select modal-trigger region01_btn_evt" href="#modal_region01">지역</a>

                    </div>
                    <div class="fg1">

                        <label class="input_label c_757575">시/군/구</label>
                        <a class="input_basic fake_select modal-trigger region02_btn_evt" href="#modal_region02">지역</a>

                    </div>
                </div>

            </section>
        </main>

        <footer class="page-footer">

            <div class="relative">
                <a class="waves-effect btn-large btn_primary w100p modal-trigger" onclick="clickNextBtn();">다음</a>
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


        <!-- 약간 동의 modal -->
        <div id="modal_eld_apply" class="modal bottom-sheet">

            <div class="modal_header">
                <h4 class="modal_title">상담을 위해 동의가 필요해요</h4>
                <div class="close_x modal-close waves-effect"></div>
            </div>
    
            <div class="modal-content">
    
                <div class="group_chk_area">
                    <div>
                        <input type="checkbox" name="" id="chk_j01" class="chk01_2 large evt_chk" checked>
                        <label for="chk_j01">[필수] 상담 정보는 상담, 서비스 이용을 위해 장기요양기관에 제공되며 1년간 보관 후 폐기합니다.</label>
                    </div>
                </div>
    
                <div class="h32"></div>
        
            </div>

            <!-- modal-content --> 
            <div class="modal-footer">
                <div class="btn_area d-flex">
                    <a class="modal-close waves-effect btn btn-large w100p btn_primary evt_btn" onclick="clickAgreeBtn();">동의하고 등록하기</a>
                </div>
            </div>
    
        </div>
        
	</div>
	<!-- wrapper -->
	
	
	<script src="/html/core/script/hangjungdong.js"></script>
	<script>
		var sidoCode = '';    //선택된 시/도 코드값
		var sigugunCode = ''; //선택된 시/군/구 코드값
	
		
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
		
		
		//다음 버튼 클릭
		function clickNextBtn() {
			var sidoText = $('.region01_btn_evt').text();
			var sigugunText = $('.region02_btn_evt').text();
			
			if (sidoText !== '지역' && sigugunText !== '지역') {
				$('#modal_eld_apply').modal('open');	
			} else {
				showToastMsg('지역을 선택하세요');
			}
		}
		
		//동의 버튼 클릭(상담 신청)
		function clickAgreeBtn() {
			var prevPath = getInLocalStorage('consltPrevPath');
			var recipientsNo = getInLocalStorage('consltRecipientsNo');
			var tel = getInLocalStorage('consltTel');
			var sidoText = $('.region01_btn_evt').text();
			var sigugunText = $('.region02_btn_evt').text();
			
			callPostAjaxIfFailOnlyMsg(
				'/matching/membership/conslt/addMbrConslt.json', 
				{
					prevPath,
					recipientsNo: Number(recipientsNo),
					tel,
					sido: sidoText,
					sigugun: sigugunText,
				},
				function(result) {
					removeInLocalStorage('consltPrevPath');
					removeInLocalStorage('consltRecipientsNo');
					removeInLocalStorage('consltTel');
					location.href = '/matching/membership/conslt/complete?recipientsNo=' + recipientsNo;
				}
			);
		}
		
	
		$(function() {
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
	        
          	//동의시 버튼 활성화
            $('.evt_chk').on('click', function () {
            	
                if ($(this).is(':checked') == true) {
                    $('.evt_btn').removeClass('btn_disable');
                    $('.evt_btn').addClass('btn_primary');
                }
                else {
                    $('.evt_btn').removeClass('btn_primary');
                    $('.evt_btn').addClass('btn_disable');
                }

            });
		});
	</script>