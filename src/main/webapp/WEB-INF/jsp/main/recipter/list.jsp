<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<header id="subject">
    <nav class="breadcrumb">
        <ul>
            <li class="home"><a href="#">홈</a></li>
            <li>요양정보 간편조회</li>
        </ul>
    </nav>
    <h2 class="subject">
        요양정보 간편조회 <img src="/html/page/index/assets/images/ico-subject2.png" alt="">
        <small>수급자명, 요양인정번호만 입력하면 조회할 수 있습니다.</small>
    </h2>
</header>

<div id="content">
    <div class="mx-auto max-w-[800px]">
        <form class="careinfo-search">
            <fieldset>
                <legend class="sr-only">요양정보 검색</legend>
                <div class="field">
                    <dl>
                        <dt><label for="recipter">이름</label></dt>
                        <dd><input type="text" id="recipter" name="recipter" class="form-control" value=""></dd>
                    </dl>
                    <dl>
                        <dt><label for="rcperRcognNo">요양인정번호</label></dt>
                        <dd><input type="text" id="rcperRcognNo" name="rcperRcognNo" class="form-control" value=""></dd>
                    </dl>
                </div>
                <button type="button" class="btn btn-large btn-primary3 f_recipterCheck">조회하기</button>
            </fieldset>
        </form>

        <div class="careinfo-myinfo recipter_view" style="display:none;">
            <p class="careinfo-title"><span class="searchNm">이로미</span>(<span class="searchNo">123456789</span>) &nbsp;님의 요양정보</p>
            <div class="myinfo-wrapper">
                <div class="myinfo-box1">
                    <p class="name" ><span class="searchNm">이로미</span>&nbsp; 님
                    	<c:if test="${_mbrSession.loginCheck}"> 
                    		<a href="/membership/mypage/list">정보수정</a>
                    	</c:if>
                    </p>
                    <dl class="numb">
                        <dt class="desc">요양인정번호</dt>
                        <dd class="searchNo">L123456789</dd>
                    </dl>
                    <dl class="date">
                        <dt class="desc">인정 유효기간</dt>
                        <dd id="searchRcgt">2023년 1월 1일 ~2023년 12월 31일</span>
                        </dd>
                    </dl>
                </div>
                <div class="myinfo-box2">
                    <p class="desc">잔여급여</p>
                    <p class="cost"><strong id="searchRemn">1,250,000</strong>원</p>
                    <dl class="used1">
                        <dt class="desc">사용</dt>
                        <dd class="percent">
                            <div class="track">
                                <div class="bar" id="useAmtBar" style="width: 25%;"></div>
                        </div>
                        <div class="won" id="searchUseAmt">350,000원</div>
                    </dd>
                </dl>
                <dl class="used2">
                    <dt class="desc">총 급여</dt>
                    <dd class="percent">
                        <div class="track">
                            <div class="bar" id="setAmtBar" style="width: 75%;"></div>
                        </div>
                        <div class="won" id="searchLimit">1,600,000원</div>
                    </dd>
                </dl>
            </div>
            <div class="myinfo-box3">
                <p class="desc">인정등급</p>
                <p class="cost"><strong id="searchGrade">15</strong>등급</p>
                <p class="desc">제품가 최소 85% 지원</p>
            </div>
            <div class="myinfo-box4">
                <p class="name">본인부담율</p>
                <p class="cost"><strong id="searchQlf">15</strong>%</p>
                <p class="desc">월 141만원내에서<br> 요양보호사 신청 가능</p>
            </div>
        </div>
    </div>
    
    <div class="careinfo-status recipter_view" style="display:none;">
        <p class="careinfo-title">복지용구 급여 품목 보유현황</p>
        <div class="status-swiper">
            <div class="swiper">
                <div class="swiper-wrapper own_view">
                    <div class="swiper-slide swiper-item1">
                        <strong>성인용 보행기</strong>
                        <i></i>
                        <dl>
                            <dt>계약완료</dt>
                            <dd class="finwalkerForAdults">0</dd>
                        </dl>
                        <dl>
                            <dt>구매가능</dt>
                            <dd class="buywalkerForAdults" >${apiVO.walkerForAdults}</dd>
                        </dl>
                    </div>
                    <div class="swiper-slide swiper-item2">
                        <strong>수동휠체어</strong>
                        <i></i>
                        <dl>
                            <dt>계약완료</dt>
                            <dd class="finwheelchair">0</dd>
                        </dl>
                        <dl>
                            <dt>구매가능</dt>
                            <dd class="buywheelchair">${apiVO.wheelchair}</dd>
                        </dl>
                    </div>
                    <div class="swiper-slide swiper-item3">
                        <strong>지팡이</strong>
                        <i></i>
                        <dl>
                            <dt>계약완료</dt>
                            <dd class="fincane">0</dd>
                        </dl>
                        <dl>
                            <dt>구매가능</dt>
                            <dd class="buycane">${apiVO.cane}</dd>
                        </dl>
                    </div>
                    <div class="swiper-slide swiper-item4">
                        <strong>안전손잡이</strong>
                        <i></i>
                        <dl>
                            <dt>계약완료</dt>
                            <dd class="finsafetyHandle">0</dd>
                        </dl>
                        <dl>
                            <dt>구매가능</dt>
                            <dd class="buysafetyHandle">${apiVO.safetyHandle}</dd>
                        </dl>
                    </div>
                    <div class="swiper-slide swiper-item5">
                        <strong>미끄럼방지 용품</strong>
                        <i></i>
                        <dl>
                            <dt>계약완료</dt>
                            <dd class="finantiSlipProduct">0</dd>
                        </dl>
                        <dl>
                            <dt>구매가능</dt>
                            <dd class="buyantiSlipProduct">${apiVO.antiSlipProduct}</dd>
                        </dl>
                    </div>
                    <!-- <div class="swiper-slide swiper-item6">
                        <strong>미끄럼방지 양말</strong>
                        <i></i>
                        <dl>
                            <dt>계약완료</dt>
                            <dd>1</dd>
                        </dl>
                        <dl>
                            <dt>구매가능</dt>
                            <dd>0</dd>
                        </dl>
                    </div> -->
                    <div class="swiper-slide swiper-item7">
                        <strong>욕창예방 매트리스</strong>
                        <i></i>
                        <dl>
                            <dt>계약완료</dt>
                            <dd class="finmattress">0</dd>
                        </dl>
                        <dl>
                            <dt>구매가능</dt>
                            <dd class="buymattress">${apiVO.mattress}</dd>
                        </dl>
                    </div>
                    <div class="swiper-slide swiper-item8">
                        <strong>욕창예방 방석</strong>
                        <i></i>
                        <dl>
                            <dt>계약완료</dt>
                            <dd class="fincushion">0</dd>
                        </dl>
                        <dl>
                            <dt>구매가능</dt>
                            <dd class="buycushion">${apiVO.cushion}</dd>
                        </dl>
                    </div>
                    <div class="swiper-slide swiper-item9">
                        <strong>자세변환용구</strong>
                        <i></i>
                        <dl>
                            <dt>계약완료</dt>
                            <dd class="finchangeTool">0</dd>
                        </dl>
                        <dl>
                            <dt>구매가능</dt>
                            <dd class="buychangeTool">${apiVO.changeTool}</dd>
                        </dl>
                    </div>
                    <div class="swiper-slide swiper-item10">
                        <strong>요실금 팬티</strong>
                        <i></i>
                        <dl>
                            <dt>계약완료</dt>
                            <dd class="finpanties">0</dd>
                        </dl>
                        <dl>
                            <dt>구매가능</dt>
                            <dd class="buypanties">${apiVO.panties}</dd>
                        </dl>
                    </div>
                    <div class="swiper-slide swiper-item11">
                        <strong>목욕의자</strong>
                        <i></i>
                        <dl>
                            <dt>계약완료</dt>
                            <dd class="finbathChair">0</dd>
                        </dl>
                        <dl>
                            <dt>구매가능</dt>
                            <dd class="buybathChair">${apiVO.bathChair}</dd>
                        </dl>
                    </div>
                    <div class="swiper-slide swiper-item12">
                        <strong>이동변기</strong>
                        <i></i>
                        <dl>
                            <dt>계약완료</dt>
                            <dd class="finmobileToilet">0</dd>
                        </dl>
                        <dl>
                            <dt>구매가능</dt>
                            <dd class="buymobileToilet">${apiVO.mobileToilet}</dd>
                        </dl>
                    </div>
                    <div class="swiper-slide swiper-item13">
                        <strong>간이변기</strong>
                        <i></i>
                        <dl>
                            <dt>계약완료</dt>
                            <dd class="finportableToilet">0</dd>
                        </dl>
                        <dl>
                            <dt>구매가능</dt>
                            <dd class="buyportableToilet">${apiVO.portableToilet}</dd>
                        </dl>
                    </div>
                    <div class="swiper-slide swiper-item14">
                        <strong>경사로(실외용)</strong>
                        <i></i>
                        <dl>
                            <dt>계약완료</dt>
                            <dd class="finoutRunway">0</dd>
                        </dl>
                        <dl>
                            <dt>구매가능</dt>
                            <dd class="buyoutRunway">${apiVO.outRunway}</dd>
                        </dl>
                    </div>
                    <div class="swiper-slide swiper-item15">
                        <strong>경사로(실내용)</strong>
                        <i></i>
                        <dl>
                            <dt>계약완료</dt>
                            <dd class="fininRunway">0</dd>
                        </dl>
                        <dl>
                            <dt>구매가능</dt>
                            <dd class="buyinRunway">${apiVO.inRunway}</dd>
                        </dl>
                    </div>
                    
                    
                    <div class="swiper-slide swiper-item16">
                        <strong>전동침대</strong>
                        <i></i>
                        <dl>
                            <dt>계약완료</dt>
                            <dd class="finelectricBed">0</dd>
                        </dl>
                        <dl>
                            <dt>구매가능</dt>
                            <dd class="buyelectricBed">${apiVO.electricBed}</dd>
                        </dl>
                    </div>
                    <div class="swiper-slide swiper-item17">
                        <strong>수동침대</strong>
                        <i></i>
                        <dl>
                            <dt>계약완료</dt>
                            <dd class="finmanualBed">0</dd>
                        </dl>
                        <dl>
                            <dt>구매가능</dt>
                            <dd class="buymanualBed">${apiVO.manualBed}</dd>
                        </dl>
                    </div>
                    <div class="swiper-slide swiper-item18">
                        <strong>이동욕조</strong>
                        <i></i>
                        <dl>
                            <dt>계약완료</dt>
                            <dd class="finbathtub">0</dd>
                        </dl>
                        <dl>
                            <dt>구매가능</dt>
                            <dd class="buybathtub">${apiVO.bathtub}</dd>
                        </dl>
                    </div>
                    <div class="swiper-slide swiper-item19">
                        <strong>목욕리프트</strong>
                        <i></i>
                        <dl>
                            <dt>계약완료</dt>
                            <dd class="finbathLift">0</dd>
                        </dl>
                        <dl>
                            <dt>구매가능</dt>
                            <dd class="buybathLift">${apiVO.bathLift}</dd>
                        </dl>
                    </div>
                    <div class="swiper-slide swiper-item20">
                        <strong>배회감지기</strong>
                        <i></i>
                        <dl>
                            <dt>계약완료</dt>
                            <dd class="findetector">0</dd>
                        </dl>
                        <dl>
                            <dt>구매가능</dt>
                            <dd class="buydetector">${apiVO.detector}</dd>
                        </dl>
                    </div>
                    
                    
                    
                </div>
            </div>
            <div class="swiper-button-prev"></div>
            <div class="swiper-button-next"></div>
        </div>

        <div class="collapse" id="collapse-agree1">
            <p class="status-title">판매 급여 품목</p>
            <table class="status-table">
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
                        <th scope="col">구매가능</th>
                    </tr>
                </thead>
                <tbody class="sale_return">
                </tbody>
            </table>

            <p class="status-title">대여 급여 품목</p>
            <table class="status-table">
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
                        <th scope="col">구매가능</th>
                    </tr>
                </thead>
                <tbody  class="lend_return">
                </tbody>
            </table>
        </div>

        <button type="button" class="btn status-toggle" data-bs-target="#collapse-agree1" data-bs-toggle="collapse" aria-expanded="false">상세열기</button>
    </div>&nbsp;&nbsp;

    <div class="market-banner">
        <strong>
            부모님 맞춤 제품이 필요하세요?
            <small>편안한 일상생활 & 미식을 책임지는 쇼핑몰</small>
        </strong>
        <a href="#">지금둘러보기</a>
    </div>

    <div class="careinfo-content">
        <div class="content-item1">
            <dl>
                <dt>신청방법부터<br> 등급별 혜택까지</dt>
                <dd>노인장기요양보험,<br> 차근차근 배워보세요</dd>
            </dl>
            <div>
                <img src="/html/page/index/assets/images/img-careinfo-content1.png" alt="">
                <a href="#" class="btn btn-outline-primary2 is-arrow">쉽게 알아보기</a>
            </div>
        </div>
        <div class="content-item2">
            <dl>
                <dt>부모님의 생활을<br> 한층 편하게</dt>
                <dd>삶의 질을 높여주는<br> 복지용구, 소개해드릴게요</dd>
            </dl>
            <div>
                <img src="/html/page/index/assets/images/img-careinfo-content2.png" alt="">
                <a href="#" class="btn btn-outline-primary3 is-arrow">복지용구 알아보기</a>
            </div>
        </div>
        <div class="content-item3">
            <dl>
                <dt>똑똑하게<br> 복지용구 선택하기</dt>
                <dd>부모님을 위한 복지용구,<br> 아무거나 고를 순 없어요</dd>
            </dl>
            <div>
                <img src="/html/page/index/assets/images/img-careinfo-content3.png" alt="">
                <a href="#" class="btn btn-outline-primary2 is-arrow">복지용구 선택하기</a>
            </div>
        </div>
    </div>
</div>

<script>
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

$(function() {
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
    
   // 기능
    $(".f_recipterCheck").on("click", function(){
    	let name = $("#recipter").val();
    	let no = $("#rcperRcognNo").val();
    	
    	if(name == '' || no == '' ){
    		alert("이름과 요양인정번호는 필수 입력 항목입니다.");
    	}else{
    		
		$.ajax({
			type : "post",
			url  : "/common/recipter/getRecipterInfo.json",
			data : {
				mbrNm : $("#recipter").val()
				, rcperRcognNo : $("#rcperRcognNo").val()
			},
			dataType : 'json'
		})
		.done(function(json) {
			if(json.result){
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

				$(".searchNm").text($("#recipter").val());
				$(".searchNo").text("L"+$("#rcperRcognNo").val());
				$("#searchGrade").text(json.infoMap.LTC_RCGT_GRADE_CD);
				$("#searchRcgt").html(json.infoMap.RCGT_EDA_DT);
				$("#searchBgngApdt").html(f_hiponFormat((json.infoMap.APDT_FR_DT)));
				$("#searchEndApdt").html("~ " + f_hiponFormat((json.infoMap.APDT_TO_DT)));
				$("#searchRemn").text(comma(json.infoMap.REMN_AMT));
				$("#searchUseAmt").html(comma(json.infoMap.USE_AMT) + ' <span class="won">원</span>');
				$("#searchLimit").text(comma(json.infoMap.LMT_AMT)+"원")
				
				$("#useAmtBar").attr("style", 'width: '+usePercent+'%');
				$("#setAmtBar").attr("style", 'width: '+setPercent+'%');
				
				let allList = new Array();
				
				let saleList = new Array();
				let lendList = new Array();
				
				let ownSaleList = new Array();
				let ownLendList = new Array();
				
				if(json.infoMap.saleList != '' && json.infoMap.saleList != null){
					saleList = json.infoMap.saleList
				}
				if(json.infoMap.lendList != '' && json.infoMap.lendList != null){
					lendList = json.infoMap.lendList
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
				
				// 고유 보유 개수
				let apiMap = new Map();
				
				let vo = "${apiVO}";
				vo = vo.replaceAll("TilkoApiVO(","").replaceAll(")","").replaceAll(" ","").split(",");
				
				for(let v=0; v<vo.length; v++){
					let obj = vo[v].split("=");
					apiMap.set(obj[0],obj[1]);
				}
				
				// 전체 고유 개수
				if(allList.length > 0){
					for(let i=0; i<allList.length; i++){
						$(".fin"+allList[i]).text(0);
						$(".buy"+allList[i]).text(apiMap.get(allList[i]));
					}
				}
				
				let CodeMap = new Map();
				let code = "${apiCode}";
				code = code.replaceAll("{","").replaceAll("}","").replaceAll(" ","").split(",");
				
				for(let v=0; v<code.length; v++){
					let str = code[v];
					str = str.split("=");
					CodeMap.set(str[1], str[0]);
				}

				// 판매 급여 품목
				$(".sale_return").empty();
				if(saleList.length > 0){
					for(let i=0; i<saleList.length; i++){
						let uniqueCnt = Number($(".own_view .buy"+saleList[i]).text());
						let html = "";
						html +='   <tr>';
						html +='    <td>'+(i+1)+'</td>';
						html +=' <td class="subject"><a href="${_mainPath}/cntnts/page3-checkpoint#check-cont'+f_replaceLink(saleList[i])+'" target=_blank>'+CodeMap.get(saleList[i])+'</a></td>';
						html +=' <td class="fin'+saleList[i]+'">0</td>';
						html +='<td class="buy'+saleList[i]+'">'+uniqueCnt+'</td>';
						html +='</tr>';
						$(".sale_return").append(html);
					}
				}else{
					let html = "";
					html +='   <tr>';
					html +='    <td colspan="4">검색된 데이터가 없습니다.</td>';
					html +='</tr>';
					$(".sale_return").append(html);
				}
					
				
				
				// 대여 급여 품목
				$(".lend_return").empty();
				if(lendList.length > 0){
					for(let i=0; i<lendList.length; i++){
						let uniqueCnt = Number($(".own_view .buy"+lendList[i]).text());
						let html = "";
						html +='   <tr>';
						html +='    <td>'+(i+1)+'</td>';
						if(f_replaceLink(lendList[i]) == 0){
							html +=' <td class="subject">'+CodeMap.get(lendList[i])+'</td>';
						}else{
							html +=' <td class="subject"><a href="${_mainPath}/cntnts/page3-checkpoint#check-cont'+f_replaceLink(lendList[i])+'" target=_blank>'+CodeMap.get(lendList[i])+'</a></td>';		
						}
						
						
						html +=' <td class="fin'+lendList[i]+'">0</td>';
						html +='<td class="buy'+lendList[i]+'">'+uniqueCnt+'</td>';
						html +='</tr>';
						$(".lend_return").append(html);
					}
				}else{
					let html = "";
					html +='   <tr>';
					html +='    <td class="colspan=4">검색된 데이터가 없습니다.</td>';
					html +='   </tr>';
					$(".lend_return").append(html);
				}
				
				
				// 보유 현황 카운트 - 판매
				if(ownSaleList.length > 0){
					for(let i=0; i<ownSaleList.length; i++){
						let finCnt = Number($(".sale_return .fin"+ownSaleList[i]).text());
						let buyCnt = Number($(".own_view .buy"+ownSaleList[i]).text());
						$(".fin"+ownSaleList[i]).text(finCnt+1);
						
						if(buyCnt > 0){
							$(".buy"+ownSaleList[i]).text(buyCnt-1);	
						}
					}	
				}
				// 보유 현황 카운트 - 대여
				if(ownLendList.length > 0){
					for(let i=0; i<ownLendList.length; i++){
						let finCnt = Number($(".sale_return .fin"+ownLendList[i]).text());
						let buyCnt = Number($("own_view .buy"+ownLendList[i]).text());
						$(".fin"+ownLendList[i]).text(fintCnt + 1);
						
						if(buyCnt > 0){
							$(".buy"+ownLendList[i]).text(buyCnt-1);	
						}
						
					}	
				}
				$(".recipter_view").show();
			}else{
				alert("조회된 데이터가 없습니다.");
			}

		})
		.fail(function(data, status, err) {
			console.log('error forward : ' + data);
		});
    }
	});
})
</script>
</div>
