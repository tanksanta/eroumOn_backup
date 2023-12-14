<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

				<!--수급자 상담정보 상세-->
                <div class="modal modal-show" id="popup-welfare-detail" tabindex="-1" aria-hidden="true">
                    <div class="modal-dialog modal-dialog-centered modal-dialog-scrollable modal-lg">
                        <div class="modal-content">
                            <div class="modal-header">
                                <h2 class="text-title">수급자 상담정보 상세</h2>
                                <button data-bs-dismiss="modal" class="btn-close">모달 닫기</button>
                            </div>
                            <div class="modal-body">
                                <h3 class="text-xl">복지용구상담</h3>
                                <p class="flex items-center gap-2">
                                    <span>상담받을 연락처</span>
                                    <strong class="text-2xl">${mbrConsltVO.mbrTelno}</strong>
                                </p>
                                <hr class="divide-x-1"/>
                                <p class="mt-5 font-medium"><span>어르신 관심 품목(</span><strong class="font-normal">${ fn:length(mbrConsltGdsList) }</strong>개)</p>
                                <p class="mt-2 text-gray1 text-xs">※ 요양정보(계약완료/구매예상)는 데이터 조회 시점에 따라 실제와 다를 수 있으니 참고용으로만 사용바랍니다</p>
                            
                                <div class="careinfo-status !my-2">
                                    <div class="status-swiper">
                                        <div class="swiper">
                                            <div id="selectedWelfareList" class="swiper-wrapper">
                                                
                                            </div>
                                        </div>
                                        <div class="swiper-button-prev"></div>
                                        <div class="swiper-button-next"></div>
                                    </div>
                                </div>
                                
                                <fieldset class="mt-10">
                                    <legend class="text-title2">요양정보</legend>
                                    <table class="table-detail">
                                        <colgroup>
                                            <col class="w-43">
                                            <col>
                                            <col class="w-43">
                                            <col>
                                        </colgroup>
                                        <tbody>
                                            <tr>
                                                <th scope="row">수급자 성명</th>
                                                <td><input id="welfareSearchNm" type="text" class="form-control large" value="${mbrConsltVO.mbrNm}" disabled></td>
                                                <th scope="row">요양인정번호</th>
                                                <td><input id="welfareSearchLno" type="text" class="form-control large" value="${mbrConsltVO.rcperRcognNo}" <c:if test="${!empty mbrConsltVO.rcperRcognNo}">disabled</c:if>></td>
                                            </tr>
                                        </tbody>
                                    </table>
                                </fieldset>
                                <div class="flex justify-center my-4">
                                    <button class="btn-primary large w-52" onclick="welfareSearchBtn()">조회하기</button>
                                </div>


                                <div class="careinfo-myinfo !mt-8 search-info-view" style="display:none;">
                                    <div class="myinfo-wrapper">
                                        <div class="myinfo-box1">
                                            <p class="name"><span class="blurring" id="welfare-nm">이로미</span></p>
                                            <dl class="numb">
                                                <dt class="desc">요양인정번호</dt>
                                                <dd><span class="blurring" id="welfare-lno">L123456789</span></dd>
                                            </dl>
                                            <dl class="date">
                                                <dt class="desc">인정 유효기간</dt>
                                                <dd id="searchRcgt"><span class="blurring">2023년 1월 1일<br> ~ 2023년 12월 31일</span></dd>
                                            </dl>
                                        </div>
                                        <div class="myinfo-box2">
                                            <p class="desc">잔여급여</p>
                                            <p class="cost"><span class="blurring"><strong id="searchRemn">1,250,000</strong>원</span></p>
                                            <dl class="used1">
                                                <dt class="desc">사용</dt>
                                                <dd class="percent">
                                                    <div class="track">
                                                        <div class="bar" id="useAmtBar"></div>
                                                    </div>
                                                    <div class="won" id="searchUseAmt"><span class="blurring">350,000원</span></div>
                                                </dd>
                                            </dl>
                                            <dl class="used2">
                                                <dt class="desc">총 급여</dt>
                                                <dd class="percent">
                                                    <div class="track">
                                                        <div class="bar" id="setAmtBar"></div>
                                                    </div>
                                                    <div class="won" id="searchLimit"><span class="blurring">1,600,000원</span></div>
                                                </dd>
                                            </dl>
                                        </div>
                                        <div class="myinfo-box3">
                                            <p class="desc">인정등급</p>
                                            <p class="cost"><span class="blurring"><strong id="searchGrade">0</strong>등급</span></p>
                                            <p class="desc">제품가 최소 85% 지원</p>
                                        </div>
                                        <div class="myinfo-box4">
                                            <p class="name">본인부담율</p>
                                            <p class="cost"><span class="blurring"><strong id="searchQlf">15</strong>%</span></p>
                                            <p class="desc">월 141만원내에서<br> 요양보호사 신청 가능</p>
                                        </div>
                                    </div>
                                </div>

                                <div class="careinfo-status !my-8 search-info-view" style="display:none;">
                                    <div class="collapse" id="collapse-agree1">
                                        <h4 class="status-title">복지용구 상세 현황</h4>
                                        <table class="status-table">
                                            <caption class="hidden">복지용구 품목명, 계약완료상태, 구매예상 표입니다</caption>
                                            <colgroup>
                                                <col class="min-w-10 w-[15%]">
                                                <col>
                                                <col class="min-w-16 w-1/5">
                                                <col class="min-w-16 w-1/5">
                                            </colgroup>
                                            <thead>
                                                <tr>
                                                    <th scope="col">No</th>
                                                    <th scope="col">품목명</th>
                                                    <th scope="col">계약완료</th>
                                                    <th scope="col">구매예상</th>
                                                </tr>
                                            </thead>
                                            <tbody id="own-welfare-s">
                                                
                                            </tbody>
                                        </table>
                        
                                        <h4 class="status-title">대여 복지용구 상세 현황</h4>
                                        <table class="status-table">
                                            <caption class="hidden">대여 복지용구 품목명, 계약완료상태, 구매예상 표입니다</caption>
                                            <colgroup>
                                                <col class="min-w-10 w-[15%]">
                                                <col>
                                                <col class="min-w-16 w-1/5">
                                                <col class="min-w-16 w-1/5">
                                            </colgroup>
                                            <thead>
                                                <tr>
                                                    <th scope="col">No</th>
                                                    <th scope="col">품목명</th>
                                                    <th scope="col">계약완료</th>
                                                    <th scope="col">구매예상</th>
                                                </tr>
                                            </thead>
                                            <tbody id="own-welfare-r">
                                            
                                            </tbody>
                                        </table>
                                        <p class="text-center mt-3 text-sm">※ 위 내용은 데이터 조회 시점에 따라 <span class="underline font-bold">실제와 다를 수 있으니 참고용</span>으로만 사용해주세요. </p>
                                    </div>
                                    <div class="flex justify-center my-4">
                                        <button type="button" class="btn status-toggle" data-bs-target="#collapse-agree1" data-bs-toggle="collapse" aria-expanded="false">상세열기</button>
                                    </div>
                                </div>
                            </div>
                            <div class="modal-footer">
                                <button type="button" class="btn btn-primary btn-large" onclick="$('#popup-welfare-detail').modal('hide');">확인</button>
                            </div>
                        </div>
                    </div>
                </div>


<script>
	//수급자 관심 복지용구 리스트 정보
	var mbrConsltGdsList = [
		<c:forEach items="${mbrConsltGdsList}" var="consltGds">
			{
				consltGdsNo : ${consltGds.consltGdsNo},
				careCtgryCd : '${consltGds.careCtgryCd}',
				ctgryNm : '${consltGds.ctgryNm}'
			},
		</c:forEach>
	]


	//조회하기 버튼 클릭
	function welfareSearchBtn() {
		getRecipterInfo();
	}

	//숫자형 날짜 하이폰 삽입
	function f_hiponFormat(value){
		var yyyy = value.substring(0,4);
		var mm = value.substring(4,6);
		var dd = value.substring(6,8);
	
		return yyyy+'-'+mm+'-'+dd;
	}
	
	//콤마 찍기 : ###,###
	function comma(num){
	    var len, point, str;
	    str = "0";
		if(num != ''){
		    num = num + "";
		    point = num.length % 3 ;
		    len = num.length;

		    str = num.substring(0, point);
		    while (point < len) {
		        if (str != "") str += ",";
		        str += num.substring(point, point + 3);
		        point += 3;
		    }
	    }
	    return str;
	}
	
	//숫자형 날짜 -> yyyy-MM-dd
	function f_dateFormat(value){
		var date = new Date(value);

		var yyyy = date.getFullYear();
		var mm = date.getMonth() + 1;
		mm = mm >= 10 ? mm : '0' + mm;
		var dd = date.getDate();
		dd = dd >= 10? dd: '0' + dd;
		return yyyy+'-'+mm+'-'+dd;
	}
	
	function f_replaceLink (str){
		let link = 0;
	
		switch(str){
		case "walkerForAdults":
			link = 1;
			break;
		case "wheelchair":
			link = 2;
			break;
		case "cane":
			link = 3;
			break;
		case "safetyHandle":
			link = 4;
			break;
		case "antiSlipProduct":
			link = 5;
			break;
		case "antiSlipProduct":
			link = 6;
			break;
		case "mattress":
			link = 7;
			break;
		case "cushion":
			link = 8;
			break;
		case "changeTool":
			link = 9;
			break;
		case "panties":
			link = 10;
			break;
		case "bathChair":
			link = 11;
			break;
		case "mobileToilet":
			link = 12;
			break;
		case "portableToilet":
			link = 13;
			break;
		case "outRunway":
			link = 14;
			break;
		case "inRunway":
			link = 14;
			break;
		default:
			link = 0;
			break;
		}
	
		return link;
	}
	
	//수급자 정보 조회
	function getRecipterInfo(){
		$(".careinfo-mask").removeClass("is-active");
		$("#collapse-agree1").removeClass("show");
		const name = $('#welfareSearchNm').val();
		const no = $('#welfareSearchLno').val();

		
		if(no == '' ){
			alert("요양인정번호는 필수 입력 항목입니다.");
			return;
		}
		
		$.ajax({
			type : "post",
			url  : "/common/recipter/getRecipterInfo.json",
			data : {
				mbrNm : name
				, rcperRcognNo : no
			},
			dataType : 'json'
		})
		.done(function(json) {
			if(!json.isSearch) {
				alert(json.msg);
				return;
			}
			
			if(json.result){
				//간편조회 정보 표출
				$('.search-info-view').css('display','block');
				
				let usePercent = 0;
				let setPercent = 100;
				if(Number(json.infoMap.USE_AMT) != 0){
					let total = Number(json.infoMap.LMT_AMT);
					let use = Number(json.infoMap.USE_AMT);
					usePercent = ((use / total) * 100);
					setPercent = (((total-use) / total) * 100);
				}

				let penPayRate = json.infoMap.REDUCE_NM == '일반' ? '15': json.infoMap.REDUCE_NM == '기초' ? '0' : json.infoMap.REDUCE_NM == '의료급여' ? '6': (json.infoMap.SBA_CD.split('(')[1].substr(0, json.infoMap.SBA_CD.split('(')[1].length-1).replaceAll("%",""));
				$("#searchQlf").text(penPayRate);

				$("#welfare-nm").text($("#welfareSearchNm").val() + ' 님');
				$("#welfare-lno").text("L"+$("#welfareSearchLno").val());
				$("#searchRcgt").html(json.infoMap.RCGT_EDA_DT);
				$("#searchRemn").text(comma(json.infoMap.LMT_AMT - json.infoMap.USE_AMT));
				$("#searchUseAmt").html(comma(json.infoMap.USE_AMT) + ' <span class="won">원</span>');
				$("#searchLimit").text(comma(json.infoMap.LMT_AMT)+"원");
				$("#searchGrade").text(json.infoMap.LTC_RCGT_GRADE_CD);
				//$("#searchBgngApdt").html(f_hiponFormat((json.infoMap.APDT_FR_DT)) + " ~ " + f_hiponFormat((json.infoMap.APDT_TO_DT)));
				//$("#searchEndApdt").html("~ " + f_hiponFormat((json.infoMap.APDT_TO_DT)));

				$("#useAmtBar").attr("style", 'width: '+usePercent+'%');
				$("#setAmtBar").attr("style", 'width: '+setPercent+'%');

				let allList = new Array();

				let saleList = new Array();
				let saleNonList = new Array();
				let lendList = new Array();
				let lendNonList = new Array();

				let ownSaleList = new Array();
				let ownLendList = new Array();

				if(json.infoMap.saleList != '' && json.infoMap.saleList != null){
					saleList = json.infoMap.saleList
				}
				if(json.infoMap.saleNonList != '' && json.infoMap.saleNonList != null){
					saleNonList = json.infoMap.saleNonList
				}
				if(json.infoMap.lendList != '' && json.infoMap.lendList != null){
					lendList = json.infoMap.lendList
				}
				if(json.infoMap.lendNonList != '' && json.infoMap.lendNonList != null){
					lendNonList = json.infoMap.lendNonList
				}
				if(json.infoMap.ownSaleList != '' && json.infoMap.ownSaleList != null){
					ownSaleList = json.infoMap.ownSaleList
				}
				if(json.infoMap.ownLendList != '' && json.infoMap.ownLendList != null){
					ownLendList = json.infoMap.ownLendList
				}
				if(json.infoMap.allList != '' && json.infoMap.allList != null){
					allList = json.infoMap.allList;
				}

				
				//판매, 대여 복지용구 상세 현황 매핑
				let ownList = json.infoMap.ownList;
				let ownListKeys = Object.keys(ownList);
				let welfareSTemp = '';
				let welfareRTemp = '';
				let sCount = 1;
				let rCount = 1;
				
				initSelectedWelfare();
				
				for (var i = 0; i < ownListKeys.length; i++) {
					const ownWelfareInfo = ownList[ownListKeys[i]];
					
					//선택된 관심 복지용구인 경우 careCtgryCd 반환
					var myCareCtgryCd = getCareCtgryCdIfInteresting(ownWelfareInfo.itemGrpNm);
					if (myCareCtgryCd) {
						appendSelectedWelfare(myCareCtgryCd
								, (ownWelfareInfo.ableYn == 'Y' ? ownWelfareInfo.persistPeriodCnt - ownWelfareInfo.ableCnt : 0)
								, (ownWelfareInfo.ableYn == 'Y' ? ownWelfareInfo.ableCnt : 0));
					}
					
					
					//판매
					if (ownWelfareInfo.saleKind === 'S') {
						welfareSTemp += '<tr' + (myCareCtgryCd ? ' class="bg-[#ffe1cc]"' : '') + '>'
							+ '<td>' + sCount + '</td>'
							+ '<td class="subject">' + ownWelfareInfo.itemGrpNm + '</td>'
							+ '<td>' + (ownWelfareInfo.ableYn == 'Y' ? ownWelfareInfo.persistPeriodCnt - ownWelfareInfo.ableCnt : '해당없음')  + '</td>'
							+ '<td>' + (ownWelfareInfo.ableYn == 'Y' ? ownWelfareInfo.ableCnt : '해당없음') + '</td>'
							+ '</tr>';
							
						sCount++;
					}
					//대여
					else {
						welfareRTemp += '<tr' + (myCareCtgryCd ? ' class="bg-[#ffe1cc]"' : '') + '>'
							+ '<td>' + rCount + '</td>'
							+ '<td class="subject">' + ownWelfareInfo.itemGrpNm + '</td>'
							+ '<td>' + (ownWelfareInfo.ableYn == 'Y' ? ownWelfareInfo.persistPeriodCnt - ownWelfareInfo.ableCnt : '해당없음')  + '</td>'
							+ '<td>' + (ownWelfareInfo.ableYn == 'Y' ? ownWelfareInfo.ableCnt : '해당없음') + '</td>'
							+ '</tr>';
						
						rCount++;
					}
				}

				$('#own-welfare-s').html(welfareSTemp);
				$('#own-welfare-r').html(welfareRTemp);
				
			}else{
				alert("조회된 데이터가 없습니다.");
			}
		})
		.fail(function(data, status, err) {
			console.log('error forward : ' + data);
		});
	}
	
	
	//관심품목 리스트 초기화
	function initSelectedWelfare() {
		$('#selectedWelfareList').html('');
	}
	
	//선택 관심품목 리스트에 추가
	function appendSelectedWelfare(careCtgryCd, contractCnt, ableCnt) {
		var imgClassNm = '';  //이미지가 부여되는 css 클래스명
		var textNm = '';      //화면에 표시되는 복지용구명
		var contractText = contractCnt == undefined ? '-' : contractCnt;  //계약완료 갯수
		var ableText = ableCnt == undefined ? '-' : ableCnt;              //구매예상 갯수
		
		//단순 텍스트 비교로는 판매와 대여가 구분이 안되므로 care 코드를 사용
		switch(careCtgryCd) {
			case '10a0': imgClassNm = 'swiper-item1'; textNm = '성인용 보행기'; break;
			case '2080': imgClassNm = 'swiper-item2'; textNm = '수동휠체어'; break;
			case '1050': imgClassNm = 'swiper-item3'; textNm = '지팡이'; break;
			case '1090': imgClassNm = 'swiper-item4'; textNm = '안전손잡이'; break;
			case '1080': imgClassNm = 'swiper-item5'; textNm = '미끄럼방지 매트'; break;
			case '1070': imgClassNm = 'swiper-item6'; textNm = '미끄럼방지 양말'; break;
			case '1010': imgClassNm = 'swiper-item7'; textNm = '욕창예방 매트리스(판매)'; break;
			case '2010': imgClassNm = 'swiper-item7'; textNm = '욕창예방 매트리스(대여)'; break;
			case '1040': imgClassNm = 'swiper-item8'; textNm = '욕창예방 방석'; break;
			case '1030': imgClassNm = 'swiper-item9'; textNm = '자세변환용구'; break;
			case '1020': imgClassNm = 'swiper-item10'; textNm = '요실금 팬티'; break;
			case '10b0': imgClassNm = 'swiper-item11'; textNm = '목욕의자'; break;
			case '10c0': imgClassNm = 'swiper-item12'; textNm = '이동변기'; break;
			case '1060': imgClassNm = 'swiper-item13'; textNm = '간이변기'; break;
			case '10d0': imgClassNm = 'swiper-item14'; textNm = '경사로(실내)'; break;
			case '2020': imgClassNm = 'swiper-item15'; textNm = '경사로(실외)'; break;
			case '2070': imgClassNm = 'swiper-item16'; textNm = '전동침대'; break;
			case '2060': imgClassNm = 'swiper-item17'; textNm = '수동침대'; break;
			case '2050': imgClassNm = 'swiper-item18'; textNm = '이동욕조'; break;
			case '2040': imgClassNm = 'swiper-item19'; textNm = '목욕리프트'; break;
			case '2030': imgClassNm = 'swiper-item20'; textNm = '배회감지기'; break;
		}
		
		var template = '<div class="swiper-slide ' + imgClassNm + '">';
		template += '<strong>' + textNm + '</strong>';
		template += '<i></i>';
		template += '<dl>';
		template += '  <dt>계약완료</dt>';
		template += '  <dd><span class="blurring">' + contractText + '</span></dd>';
		template += '</dl>';
		template += '<dl>';
		template += '  <dt>구매예상</dt>';
		template += '  <dd><span class="blurring">' + ableText + '</span></dd>';
		template += '</dl>';
		template += '</div>';
		
		$('#selectedWelfareList').append(template);
	}
	
	//해당 품목명이 관심 복지용구 선택인지 확인하여 care코드 반환
	function getCareCtgryCdIfInteresting(itemGrpNm) {
		var returnCareCd = '';
		
		switch(itemGrpNm) {
			case '성인용보행기': returnCareCd = '10a0'; break;
			case '수동휠체어': returnCareCd = '2080'; break;
			case '지팡이': returnCareCd = '1050'; break;
			case '안전손잡이': returnCareCd = '1090'; break;
			case '미끄럼 방지매트/액': returnCareCd = '1080'; break;
			case '미끄럼 방지양말': returnCareCd = '1070'; break;
			case '욕창예방 매트리스(판매)': returnCareCd = '1010'; break;
			case '욕창예방 매트리스(대여)': returnCareCd = '2010'; break;
			case '욕창예방방석': returnCareCd = '1040'; break;
			case '자세변환용구': returnCareCd = '1030'; break;
			case '요실금팬티': returnCareCd = '1020'; break;
			case '목욕의자': returnCareCd = '10b0'; break;
			case '이동변기': returnCareCd = '10c0'; break;
			case '간이변기': returnCareCd = '1060'; break;
			case '경사로(실내용)': returnCareCd = '10d0'; break;
			case '경사로(실외용)': returnCareCd = '2020'; break;
			case '전동침대': returnCareCd = '2070'; break;
			case '수동침대': returnCareCd = '2060'; break;
			case '이동욕조': returnCareCd = '2050'; break;
			case '목욕리프트': returnCareCd = '2040'; break;
			case '배회감지기': returnCareCd = '2030'; break;
		}
		
		if (!returnCareCd) {
			return returnCareCd;
		}
		
		if (mbrConsltGdsList.findIndex(f => f.careCtgryCd == returnCareCd) > -1) {
			return returnCareCd;
		} else {
			return '';
		}
	}
	
	

	$(function() {
		//관심 복지용구 선택 처리
		for(var i = 0; i < mbrConsltGdsList.length; i++) {
			appendSelectedWelfare(mbrConsltGdsList[i].careCtgryCd);
		}
		
		
		var swiper = new Swiper(".swiper", {
	        slidesPerView : 'auto',
	        spaceBetween : 10,
	        navigation: {
	            nextEl: ".swiper-button-next",
	            prevEl: ".swiper-button-prev",
	        },
	        breakpoints: {
	            spaceBetween : 12,
	        },
	    });
	    
	    $('.status-toggle').on('click', function() {
	        $(this).toggleClass('is-active').prev('.status-list').toggleClass('hidden');
	    })
	});
</script>