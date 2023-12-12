<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<header id="subject">
    <nav class="breadcrumb">
        <ul>
			<li class="home"><a href="${_mainPath}">홈</a></li>
			<li>이로움 서비스</li>
            <li>관심 복지용구 선택</li>
        </ul>
    </nav>
    <h2 class="subject">
        관심 복지용구 선택
        <small>
            필요한 복지용구를 선택하세요<br>
            상담을 통해 혜택을 확인하고 구매 신청해보세요
        </small>
    </h2>
</header>

<div id="content">
    <div class="flex justify-between items-center mb-3">
        <div class="form-check">
            <input class="form-check-input" type="checkbox" id="check-all">
            <label class="form-check-label" for="check-all">전체선택</label>
        </div>
        <div id="welfareCntDiv">0/14</div>
    </div>
    <ul class="welfare-kit-wrap">
        <li class="flex flex-col gap-1">
            <div class="welfare-kit-box">
                <div class="form-check warning self-end">
                    <input class="form-check-input welfare-check" type="checkbox" id="check-item1" value="10,성인용보행기">
                </div>
                <div class="mx-auto">
                    <img src="/html/page/index/assets/images/img-checkpoint1.png" alt="성인용 보행기" class="h-20"/>
                </div>
                <label for="check-item1" class="welfare-kit-name">성인용 보행기</label>
            </div>
            <button type="button" class="btn-gray" data-bs-toggle="modal" data-bs-target="#welfare-kit1">자세히보기</button>
        </li>   
        <li class="flex flex-col gap-1">
            <div class="welfare-kit-box">
                <div class="form-check warning self-end">
                    <input class="form-check-input welfare-check" type="checkbox" id="check-item2" value="20,수동휠체어">
                </div>
                <div class="mx-auto">
                    <img src="/html/page/index/assets/images/img-checkpoint2.png" alt="수동휠체어" class="h-20"/>
                </div>
                <label for="check-item2" class="welfare-kit-name">수동휠체어</label>
            </div>
            <button type="button" class="btn-gray" data-bs-toggle="modal" data-bs-target="#welfare-kit2">자세히보기</button>
        </li>   
        <li class="flex flex-col gap-1">
            <div class="welfare-kit-box">
                <div class="form-check warning self-end">
                    <input class="form-check-input welfare-check" type="checkbox" id="check-item3" value="10,지팡이">
                </div>
                <div class="mx-auto">
                    <img src="/html/page/index/assets/images/img-checkpoint3.png" alt="지팡이" class="h-20"/>
                </div>
                <label for="check-item3" class="welfare-kit-name">지팡이</label>
            </div>
            <button type="button" class="btn-gray" data-bs-toggle="modal" data-bs-target="#welfare-kit3">자세히보기</button>
        </li>   
        <li class="flex flex-col gap-1">
            <div class="welfare-kit-box">
                <div class="form-check warning self-end">
                    <input class="form-check-input welfare-check" type="checkbox" id="check-item4" value="10,안전손잡이">
                </div>
                <div class="mx-auto">
                    <img src="/html/page/index/assets/images/img-checkpoint4.png" alt="안전손잡이" class="h-20"/>
                </div>
                <label for="check-item4" class="welfare-kit-name">안전손잡이</label>
            </div>
            <button type="button" class="btn-gray" data-bs-toggle="modal" data-bs-target="#welfare-kit4">자세히보기</button>
        </li>   
        <li class="flex flex-col gap-1">
            <div class="welfare-kit-box">
                <div class="form-check warning self-end">
                    <input class="form-check-input welfare-check" type="checkbox" id="check-item5" value="10,미끄럼방지매트">
                </div>
                <div class="mx-auto">
                    <img src="/html/page/index/assets/images/img-checkpoint5.png" alt="미끄럼방지 매트" class="h-20"/>
                </div>
                <label for="check-item5" class="welfare-kit-name">미끄럼방지 매트</label>
            </div>
            <button type="button" class="btn-gray" data-bs-toggle="modal" data-bs-target="#welfare-kit5">자세히보기</button>
        </li>   
        <li class="flex flex-col gap-1">
            <div class="welfare-kit-box">
                <div class="form-check warning self-end">
                    <input class="form-check-input welfare-check" type="checkbox" id="check-item6" value="10,미끄럼방지양말">
                </div>
                <div class="mx-auto">
                    <img src="/html/page/index/assets/images/img-checkpoint6.png" alt="미끄럼방지 양말" class="h-20"/>
                </div>
                <label for="check-item6" class="welfare-kit-name">미끄럼방지 양말</label>
            </div>
            <button type="button" class="btn-gray" data-bs-toggle="modal" data-bs-target="#welfare-kit6">자세히보기</button>
        </li>   
        <li class="flex flex-col gap-1">
            <div class="welfare-kit-box">
                <div class="form-check warning self-end">
                    <input class="form-check-input welfare-check" type="checkbox" id="check-item7" value="10,욕창예방매트리스">
                </div>
                <div class="mx-auto">
                    <img src="/html/page/index/assets/images/img-checkpoint7.png" alt="욕창예방 매트리스" class="h-20"/>
                </div>
                <label for="check-item7" class="welfare-kit-name">욕창예방 매트리스</label>
            </div>
            <button type="button" class="btn-gray" data-bs-toggle="modal" data-bs-target="#welfare-kit7">자세히보기</button>
        </li>   
        <li class="flex flex-col gap-1">
            <div class="welfare-kit-box">
                <div class="form-check warning self-end">
                    <input class="form-check-input welfare-check" type="checkbox" id="check-item8" value="10,욕창예방방석">
                </div>
                <div class="mx-auto">
                    <img src="/html/page/index/assets/images/img-checkpoint8.png" alt="욕창예방 방석" class="h-20"/>
                </div>
                <label for="check-item8" class="welfare-kit-name">욕창예방 방석</label>
            </div>
            <button type="button" class="btn-gray" data-bs-toggle="modal" data-bs-target="#welfare-kit8">자세히보기</button>
        </li>   
        <li class="flex flex-col gap-1">
            <div class="welfare-kit-box">
                <div class="form-check warning self-end">
                    <input class="form-check-input welfare-check" type="checkbox" id="check-item9" value="10,자세변환용구">
                </div>
                <div class="mx-auto">
                    <img src="/html/page/index/assets/images/img-checkpoint9.png" alt="자세변환용구" class="h-20"/>
                </div>
                <label for="check-item9" class="welfare-kit-name">자세변환용구</label>
            </div>
            <button type="button" class="btn-gray" data-bs-toggle="modal" data-bs-target="#welfare-kit9">자세히보기</button>
        </li>   
        <li class="flex flex-col gap-1">
            <div class="welfare-kit-box">
                <div class="form-check warning self-end">
                    <input class="form-check-input welfare-check" type="checkbox" id="check-item10" value="10,요실금팬티">
                </div>
                <div class="mx-auto">
                    <img src="/html/page/index/assets/images/img-checkpoint10.png" alt="요실금 팬티" class="h-20"/>
                </div>
                <label for="check-item10" class="welfare-kit-name">요실금 팬티</label>
            </div>
            <button type="button" class="btn-gray" data-bs-toggle="modal" data-bs-target="#welfare-kit10">자세히보기</button>
        </li>   
        <li class="flex flex-col gap-1">
            <div class="welfare-kit-box">
                <div class="form-check warning self-end">
                    <input class="form-check-input welfare-check" type="checkbox" id="check-item11" value="10,목욕의자">
                </div>
                <div class="mx-auto">
                    <img src="/html/page/index/assets/images/img-checkpoint11.png" alt="목욕의자" class="h-20"/>
                </div>
                <label for="check-item11" class="welfare-kit-name">목욕의자</label>
            </div>
            <button type="button" class="btn-gray" data-bs-toggle="modal" data-bs-target="#welfare-kit11">자세히보기</button>
        </li>   
        <li class="flex flex-col gap-1">
            <div class="welfare-kit-box">
                <div class="form-check warning self-end">
                    <input class="form-check-input welfare-check" type="checkbox" id="check-item12" value="10,이동변기">
                </div>
                <div class="mx-auto">
                    <img src="/html/page/index/assets/images/img-checkpoint12.png" alt="이동변기" class="h-20"/>
                </div>
                <label for="check-item12" class="welfare-kit-name">이동변기</label>
            </div>
            <button type="button" class="btn-gray" data-bs-toggle="modal" data-bs-target="#welfare-kit12">자세히보기</button>
        </li>   
        <li class="flex flex-col gap-1">
            <div class="welfare-kit-box">
                <div class="form-check warning self-end">
                    <input class="form-check-input welfare-check" type="checkbox" id="check-item13" value="10,간이변기">
                </div>
                <div class="mx-auto">
                    <img src="/html/page/index/assets/images/img-checkpoint13.png" alt="간이변기" class="h-20"/>
                </div>
                <label for="check-item13" class="welfare-kit-name">간이변기</label>
            </div>
            <button type="button" class="btn-gray" data-bs-toggle="modal" data-bs-target="#welfare-kit13">자세히보기</button>
        </li>   
        <li class="flex flex-col gap-1">
            <div class="welfare-kit-box">
                <div class="form-check warning self-end">
                    <input class="form-check-input welfare-check" type="checkbox" id="check-item14" value="10,경사로">
                </div>
                <div class="mx-auto">
                    <img src="/html/page/index/assets/images/img-checkpoint14.png" alt="경사로" class="h-20"/>
                </div>
                <label for="check-item14" class="welfare-kit-name">경사로</label>
            </div>
            <button type="button" class="btn-gray" data-bs-toggle="modal" data-bs-target="#welfare-kit14">자세히보기</button>
        </li>   
    </ul>

    <!--상담하기-->
    <div class="text-center my-15">
        <button class="btn btn-primary2 btn-large btn-arrow justify-center w-full md:w-1/3" onclick="clickStartConsltBtn()">
            <strong>상담하기<span class="ml-2" id="welfareCntSpan">(0/14)</span></strong>
        </button>
    </div>


	<!-- 복지용구 자세히보기 모달 -->
	<jsp:include page="./welfare-modal.jsp" />
	
	<!-- 상담 신청하기 지원 모달 -->
	<jsp:include page="/WEB-INF/jsp/common/modal/recipient_and_conslt_modal.jsp" />


    <script>
  		//상담하기 버튼 클릭
	    function clickStartConsltBtn() {
	    	var selectedCnt = $('.welfare-check:checked').length
  			
	    	if (selectedCnt > 0) {
	    		var recipientsNo = '46';
		    	openModal('requestConslt', Number(recipientsNo), 'equip_ctgry');	
	    	} else {
	    		alert('관심 복지용구를 선택하세요');	
	    	}
	    }
  		
  		//선택된 갯수 UI표시 처리
  		function drawSelectedWelfareCount() {
  			var selectedInputs = $('.welfare-check:checked');
  			var totalCnt = $('.welfare-check').length;
  			var selectedCnt = $('.welfare-check:checked').length
  			
  			var inputText = selectedCnt + '/' + totalCnt;
  			$('#welfareCntDiv').text(inputText);
  			$('#welfareCntSpan').text('(' + inputText + ')');
  			
  			//선택 정보 저장
  			ctgryNmArr.ctgry10Nms = [];
  			ctgryNmArr.ctgry20Nms = [];
  			for (var i = 0; i < selectedInputs.length; i++) {
  				var split = selectedInputs[i].value.split(',');
  				var ctgryTy = split[0];
  				var ctgryNm = split[1];
  				if (ctgryTy === '10') {
  					ctgryNmArr.ctgry10Nms.push(ctgryNm);
  				} else if (ctgryTy === '20') {
  					ctgryNmArr.ctgry20Nms.push(ctgryNm);
  				}
  			}
  		}

        document.addEventListener('DOMContentLoaded', () => {
            const checkAllItems = document.querySelector("#check-all");
            const parents = document.querySelectorAll(".welfare-kit-box");
            const checks = document.querySelectorAll(".welfare-kit-box .form-check-input");

            checks.forEach((chk) => {
            	//복지용구 단일선택 이벤트
                chk.addEventListener("change", (e) => {
                    const current = e.currentTarget;
                    const parent = current.closest('.welfare-kit-box');
                    if (current.checked) {
                        parent.classList.add('is-active');
                    } else {
                        parent.classList.remove('is-active');
                    }
                    
                    drawSelectedWelfareCount();
                });
            });

            //복지용구 전체선택 이벤트
            checkAllItems.addEventListener('change', (e) => {
                const current = e.currentTarget;
                checks.forEach(function (item) {
                    item.checked = current.checked;
                    const parent = item.closest('.welfare-kit-box');
                    if (current.checked) {
                        parent.classList.add('is-active');
                    } else {
                        parent.classList.remove('is-active');
                    }
                });
                
                drawSelectedWelfareCount();
            });
        });
    </script>
</div>
