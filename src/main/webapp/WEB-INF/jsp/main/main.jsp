<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<div class="main-visual">
    <div class="object1"></div>
    <div class="object2"></div>
    <div class="back1"></div>
    <div class="back2"></div>
    <div class="back3"></div>
    <div class="phone">
        <div class="mask">
            <div class="obj-3-group">
                <span></span>
                <span></span>
                <span></span>
                <span></span>
            </div>
            <img src="/html/page/index/assets/images/visual2/phone-img.png" alt="">
        </div>
    </div>
    <div class="swiper">
        <div class="swiper-wrapper">
            <div class="swiper-slide">
                <p class="title">
                    <span>최대 2,500만원 복지혜택,</span><br>
                    <strong><span class="t-obj"></span>65세 이상이라면 바로 신청하세요</strong>
                </p>
                <p class="desc"><span>등급별 지원 혜택이 달라요!</span></p>
                <a href="/find/step2-1" class="btn btn-primary3 btn-outline-none btn-arrow"><strong>지금 등급 확인하기</strong></a>
                <div class="timeline"></div>
            </div>
            <div class="swiper-slide">
                <p class="title">
                    <span>65세 미만이라도,</span><br>
                    <strong>등급 인정 확률이 높아요<span class="t-obj"></span></strong>
                </p>
                <p class="desc">
                    <span><span class="t-obj"></span>타인 도움 없이 생활이 불가능한 어르신</span>
                    <span><span class="t-obj"></span>노인성 질환을 앓고 있는 어르신</span>
                    <span><span class="t-obj"></span>치매 증상으로 불편한 어르신</span>
                </p>
                <a href="/find/step2-1" class="btn btn-primary3 btn-outline-none btn-arrow"><strong>지금 등급 확인하기</strong></a>
                <div class="timeline"></div>
            </div>
            <div class="swiper-slide">
                <p class="title">
                    <span>어르신을 위한 복지,<span class="t-obj"></span></span><br>
                    <strong>놓치지 말고 누리세요</strong>
                </p>
                <p class="desc"><span>등급을 받으시면 다양한 요양 용품, 서비스가 제공돼요</span></p>
                <a href="/find/step2-1" class="btn btn-primary3 btn-outline-none btn-arrow"><strong>지금 등급 확인하기</strong></a>
                <div class="timeline"></div>
            </div>
        </div>
        <div class="slide-nav">
            <span></span>
            <span></span>
            <span></span>
        </div>
        <div class="slide-prev"></div>
        <div class="slide-next"></div>
    </div>
    <p class="text-scroll is-white"><span class="mouse"></span>아래에서 더 자세히 알아보세요</p>
</div>

<div class="main-welfare">
    <div class="container">
        <p class="desc">어르신 맞춤 <strong>복지서비스,</strong><br> <strong>한 곳에서 편하게!</strong></p>
        <p class="count"><strong class="totalCount"><fmt:formatNumber value="${total}" pattern="###,###" /></strong>건 </p>
        
        <c:set var="addr" value="" />
		<c:if test="${_mbrAddr1 eq '충남'}"><c:set var="addr" value="충청남도" /></c:if>
		<c:if test="${_mbrAddr1 eq '충북'}"><c:set var="addr" value="충청북도" /></c:if>
		<c:if test="${_mbrAddr1 eq '경남'}"><c:set var="addr" value="경상남도" /></c:if>
		<c:if test="${_mbrAddr1 eq '경북'}"><c:set var="addr" value="경상북도" /></c:if>
		<c:if test="${_mbrAddr1 eq '전남'}"><c:set var="addr" value="전라남도" /></c:if>
		<c:if test="${_mbrAddr1 eq '전북'}"><c:set var="addr" value="전라북도" /></c:if>
		<c:if test="${_mbrAddr1 eq '서울'}"><c:set var="addr" value="서울특별시" /></c:if>
		<c:if test="${_mbrAddr1 eq '강원' || _mbrAddr1 eq '경기' }"><c:set var="addr" value="${_mbrAddr1}도" /></c:if>
		<c:if test="${_mbrAddr1 eq '광주'}"><c:set var="addr" value="광주광역시" /></c:if>
		<c:if test="${_mbrAddr1 eq '대구' || _mbrAddr1 eq '대전' || _mbrAddr1 eq '부산' || _mbrAddr1 eq '울산' || _mbrAddr1 eq '인천'}"><c:set var="addr" value="${_mbrAddr1}+광역시" /></c:if>
				
				
        <form class="form" action="${_mainPath}/searchBokji" id="bokjiFrm" name="bokjiFrm" method="get">
        	<select name="select-sido" class="form-control">
	            <c:forEach var="stdg" items="${stdgCdList}">
					<option value="${stdg.stdgCd}" 
						<c:if test="${!_mbrSession.loginCheck && stdg.ctpvNm eq '서울특별시'}">selected="selected"</c:if>
						<c:if test="${_mbrSession.loginCheck && stdg.ctpvNm eq addr}">selected="selected"</c:if>
					>${stdg.ctpvNm}</option>
				</c:forEach>
			</select>
            <select name="select-gugun" class="form-control">
                <!--<c:if test="${!_mbrSession.loginCheck}"><option value="">금천구</option></c:if>
                <c:if test="${_mbrSession.loginCheck}"><option value="">${_mbrAddr2}</option></c:if>-->
            </select>
            <button type="submit" class="btn">바로 확인</button>
            <%-- <a class="btn" href="${_mainPath}/searchBokji?sido=${addr}&amp;gugun=${}">바로 확인</a> --%>
        </form>
    </div>
</div>

<div id="notice-mobile" class="main-notice">
    <div class="notice-banner1">
        <dl>
            <dt><em>장기요양인정등급</em>을 이미 받으셨나요?</dt>
            <dd>올해 남은 복지 혜택을 <em>여기에서 확인</em>하세요</dd>
        </dl>
		<a href="${_mainPath}/recipter/list">남은 금액보기</a>

	</div>
    <div class="notice-banner2">
        <dl>
            <dt>부모님 맞춤 제품이 필요하세요?</dt>
            <dd>편안한 일상생활 &amp; 미식을 책임지는 쇼핑몰</dd>
        </dl>
        <a href="${_marketPath}/index" target="_blank">지금 둘러보기</a>
    </div>
</div>

<ul class="main-link">
    <li class="link-item1"><a href="${_mainPath}/searchBokji">어르신<br> 복지</a></li>
    <li class="link-item2"><a href="https://www.eroum.co.kr/find/step2-1" target="_blank">인정 등급<br> 테스트</a></li>
    <li class="link-item3"><a href="${_marketPath}/index" target="_blank">어르신 <br> 맞춤몰</a></li>
    <!-- li class="link-item4"><a href="//www.youtube.com/@Super_Senior" target="_blank">유튜브<br> 채널</a></li -->
</ul>

<div class="main-content-wrapper">
    <div class="main-content1">
        <div class="image">
            <div class="object1"></div>
            <div class="object2"></div>
        </div>
        <div class="box">
            <h2>
                <small>신청방법부터 등급별 혜택까지</small>
                <em class="text-primary2">노인장기요양보험,</em><br>
                차근 차근 배워보세요
            </h2>
            <p>우리 부모님은<br> 지원대상일까요?</p>
            <p>어떤 요양 서비스와 용품이<br> 제공될까요?</p>
            <a href="${_mainPath}/cntnts/page1" class="btn btn-large2 btn-outline-primary2 btn-arrow"><strong>쉽게 알아보기</strong></a>
        </div>
    </div>
    
    <div class="main-content2">
        <div class="image">
            <div class="object1"></div>
        </div>
        <div class="box">
            <h2>
                <small>부모님 생활을 한층 편하게</small>
                삶의 질을 높여주는<br>
                <em class="text-primary3">복지용구, 소개해 드릴게요</em>
            </h2>
            <p>불편한 거동, 낙상 사고 등의 걱정을</p>
            <p>복지용구로 덜으실 수 있어요</p>
            <a href="${_mainPath}/cntnts/page2" class="btn btn-large2 btn-outline-primary3 btn-arrow"><strong>복지용구 알아보기</strong></a>
        </div>
    </div>
    
    <div class="main-content3">
        <div class="image">
            <div class="object1"></div>
            <div class="object2"></div>
        </div>
        <div class="box">
            <h2>
                <small>똑똑하게 복지용구 선택하기</small>
                <em class="text-primary2">부모님을 위한 복지용구,</em><br>
                아무거나 고를 순 없어요
            </h2>
            <p>높은 금액의 복지용구,</p>
            <p>혜택받는 방법과<br> 고르는 법을 알려드려요</p>
            <a href="${_mainPath}/cntnts/page3" class="btn btn-large2 btn-outline-primary2 btn-arrow"><strong>복지용구 선택하기</strong></a>
        </div>
    </div>
</div>

<div class="main-banner">
    <div class="market-banner">
        <strong>
            부모님 맞춤 제품이 필요하세요?
            <small>편안한 일상생활 & 미식을 책임지는 쇼핑몰</small>
        </strong>
        <a href="${_marketPath}/index" target="_blank">지금둘러보기</a>
    </div>
</div>

<script>

function f_srchInstList(){

	if(sido != "" && sido != "선택"){ //sido는 필수

		if(isAllow){	// GPS허용
			dist = 10000;
		}else{
			dist = 0;
		}
		var params = {
				srchMode:srchMode
				, sido:sido, gugun:gugun
				, isAllow:false, lot:lot, lat:lat, dist:dist };

		//console.log("params", params);

		$.ajax({
			type : "post",
			url  : "${_mainPath}/srchInstList.json",
			data : params,
			dataType : 'json'
		})
		.done(function(json) {
			var instCnt = "";
			if(srchMode == "LOCATION"){
				objData = json.bplcList;
				instCnt = Number(json.bplcCnt)
			}else{
				objData = json.instList;
				instCnt = Number(json.instCnt);
			}
			 
			$(".instListCnt").text(comma(instCnt));

			addListItem();
			kakaoMapDraw();

			//cntSum();
		})
		.fail(function(data, status, err) {
			console.log(data);
		});
	}
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

    //object visible check
    var observerCallback = (entries, observer, header) => {
        if(entries[0].isIntersecting) {
            entries[0].target.parentNode.classList.add('is-active');
        }
    };

    $(function() {
    	
        $(window).on('scroll, load', function() {
            //object visible
            [].slice.call(document.querySelectorAll('[class*="main-content"] .image')).forEach((e) => {
            var observer = new IntersectionObserver((entries) => {
                observerCallback(entries, observer);
            }, {
                threshold: 0.8
            });

            observer.observe(e);
        }, this);
        })
        
      	// 시/군/구 검색
    	$(document).on("change", "select[name='select-sido']", function(e){
    		e.preventDefault();
    		var stdgCd = $(this).val();
    		var stdgNm = $(this).text();

    	   	if(stdgCd != ""){
        		$.ajax({
    				type : "post",
    				url  : "${_membersPath}/stdgCd/stdgCdList.json",
    				data : {stdgCd:stdgCd},
    				dataType : 'json'
    			})
    			.done(function(data) {
    				if(data.result){
    					$("select[name='select-gugun']").empty();
       					$.each(data.result, function(index, item){ 
    							$("select[name='select-gugun']").append('<option value='+item.stdgCd+'>'+item.sggNm+'</option>');
       	                });
    				}
   			     	<c:if test="${empty _mbrSession.uniqueId}">
   			     		$("select[name='select-gugun'] option[value='1154500000']").prop("selected",true);
   			     	</c:if>
   			     	
   			     	<c:if test="${!empty _mbrSession.uniqueId}">
	   			       	if("${_mbrAddr2}" == ''){
	   			    		$("select[name='select-gugun'] option").each(function(){
	   			    			if($(this).val() == "1154500000"){
	   			    				$(this).prop("selected",true);
	   			    			}
	   			    		});
	   			       	}else{
		   			     	$("select[name='select-gugun'] option").each(function(){
	   			    			if($(this).text() == "${_mbrAddr2}"){
	   			    				$(this).prop("selected",true);
	   			    			}
	   			    		});
	   			       	}
   			     	</c:if>
    			})
    			.fail(function(data, status, err) {
    				console.log('지역호출 error forward : ' + data);
    			});
        	}

    	});
        if("${_mbrSession.uniqueId}" != '' && "${_mbrAddr1}" == ''){
        	$("select[name='select-sido'] option").each(function(){
    			if($(this).val() == "1100000000"){
    				$(this).prop("selected",true);
    			}
    		});
        }
       $("select[name='select-sido']").trigger("change");
       
   	$("form[name='bokjiFrm']").validate({
	    ignore: "input[type='text']:hidden, [contenteditable='true']:not([name])",
	    submitHandler: function (frm) {
	    	$("select[name='select-sido']").attr("name","selectSido");
	    	$("select[name='select-gugun']").attr("name","selectGugun");
	    	frm.submit();
	    }
	});

    });
</script>



<style>
    @media screen and (min-width:768px){
        .main-visual {background-image: url(/html/page/index/assets/images/visual2/bg-main-visual-1.png); max-height: 740px; transition: 0.5s background-image;}
        
        .main-visual .swiper {overflow: visible;}
    }

    .phone {position: absolute;left: 50%;margin-left: calc(440px);top:100%;transform: translate(-50%,-50%);width:380px;height:727px;background: url(/html/page/index/assets/images/visual2/frame-iphone.png) no-repeat 50% / 100%; z-index: 0; opacity: 0;}
    .phone .mask {position: absolute;left: 46px;top: 70px;width: 265px;height: 576px;overflow: hidden;border-radius: 36px;background-color: #FF8300;}
    .phone .mask img {height:576px; width:795px; max-width: none; transition: 0.5s ease;}
    .is-active.phone {top: 53%;transition: 1.5s ease;opacity: 1;}

    .main-visual .back1,
    .main-visual .back2,
    .main-visual .back3 {position: absolute; left:0; width:100%; height:105%; top:0; z-index: 0; background-repeat: no-repeat; background-size: cover; opacity: 0; transition: 1s ease; background-position: center bottom;} 
    .main-visual .back1 {background-image: url(/html/page/index/assets/images/visual2/bg-main-visual-1.png);}
    .main-visual .back2 {background-image: url(/html/page/index/assets/images/visual2/bg-main-visual-2.png);}
    .main-visual .back3 {background-image: url(/html/page/index/assets/images/visual2/bg-main-visual-3.png);}
    .main-visual .back1 {opacity: 1;}
    .main-visual.slide-1 .back1,
    .main-visual.slide-2 .back2,
    .main-visual.slide-3 .back3 {opacity: 1;}
    
    
    .main-visual .swiper-slide {padding: max(1.625rem,9.235668789808917%) 2.25rem 3.75rem}
    
    
    .main-visual .object1,
    .main-visual .object2 {max-width: 1800px; left:50% !important;--tw-translate-x:-50%; }
    
    .slide-1.phone img {margin-left:0;}
    .slide-2.phone img {margin-left:-265px;}
    .slide-3.phone img {margin-left:-530px;}
    div.obj-3-group {opacity: 0;}
    .slide-3.phone div.obj-3-group {position: absolute; left:10px; width:calc(100% - 20px); top:52%; height:50%; opacity: 1;}
    .phone div.obj-3-group span {position: absolute; width:115px; height:115px; background-position: 0 0; background-size: cover; background-repeat: no-repeat;}
    .phone div.obj-3-group span:nth-child(1) {left:0; top:0; background-image: url(/html/page/index/assets/images/visual2/img-main-visual-obj3-3.png); opacity: 0; margin-top:100px;}
    .phone div.obj-3-group span:nth-child(2) {left:calc(50% + 5px); top:0; background-image: url(/html/page/index/assets/images/visual2/img-main-visual-obj3-4.png); opacity: 0; margin-top:150px;}
    .phone div.obj-3-group span:nth-child(3) {left:0; top:125px; background-image: url(/html/page/index/assets/images/visual2/img-main-visual-obj3-5.png); opacity: 0; margin-top:200px;}
    .phone div.obj-3-group span:nth-child(4) {left:calc(50% + 5px); top:125px; background-image: url(/html/page/index/assets/images/visual2/img-main-visual-obj3-6.png); opacity: 0; margin-top:250px;}
    
    .slide-3.phone div.obj-3-group span:nth-child(1) {transition: 1.5s ease; transition-delay: 2.4s; opacity: 1; margin-top: 0;}
    .slide-3.phone div.obj-3-group span:nth-child(2) {transition: 1.5s ease; transition-delay: 2.6s; opacity: 1; margin-top: 0;}
    .slide-3.phone div.obj-3-group span:nth-child(3) {transition: 1.5s ease; transition-delay: 2.8s; opacity: 1; margin-top: 0;}
    .slide-3.phone div.obj-3-group span:nth-child(4) {transition: 1.5s ease; transition-delay: 3.0s; opacity: 1; margin-top: 0;}
    
    .main-visual .object1.hide,.main-visual .object2.hide {opacity: 0; transition-delay: 0s; background-position: center 45% !important;}
    .main-visual .object1,.main-visual .object2  {z-index: 1;}
    .swiper-slide {position: absolute;}
    .swiper-slide:nth-child(1) {opacity: 0; z-index: 0;}
    .swiper-slide:nth-child(2) {opacity: 0; z-index: 0;}
    .swiper-slide:nth-child(3) {opacity: 0; z-index: 0;}
    .main-visual .swiper-slide .btn {opacity: 0;}
    .main-visual.slide-1 .swiper-slide .btn,
    .main-visual.slide-2 .swiper-slide .btn,
    .main-visual.slide-3 .swiper-slide .btn {opacity: 1; transition: 1s ease;}
    
    .main-visual {max-height: 748px !important;}
    .main-visual [class*=object] {transition-duration: 1s;}
    .swiper-slide.ani {opacity: 1;z-index: 2; margin-top:-100px;}
    .swiper-slide .title span,
    .swiper-slide .title strong,
    .swiper-slide .desc span {opacity: 0; top:1rem; position: relative;text-shadow: 0 2px 6px rgba(0,0,0,0.1);}
    .swiper-slide:nth-child(1) .desc span,
    .swiper-slide:nth-child(3) .desc span {padding-top:50px;}
    .swiper-slide .desc span {display: block;}
    .swiper-slide .desc {height: 6rem;}
    .swiper-slide:nth-child(2) .desc span:nth-child(1) {transition-delay: 1.5s;}
    .swiper-slide:nth-child(2) .desc span:nth-child(2) {transition-delay: 1.8s;}
    .swiper-slide:nth-child(2) .desc span:nth-child(3) {transition-delay: 2.1s;}
    .swiper-slide.ani .title span {opacity: 1; top:0; transition: 1s ease; }
    .swiper-slide.ani .title strong {opacity: 1; top:0; transition: 1s ease;transition-delay: 0.5s; }
    .swiper-slide.ani .desc span {opacity: 1; top:0;  transition: 1s ease; transition-delay: 1.5s;}
    .swiper-slide .timeline {position: absolute; left:0; bottom:0; width:100%; height:2px;}
    .swiper-slide .timeline::after {content:''; position: absolute; left:0; width:0; height:0; top:0; background-color: #fff;}
    .swiper-slide.ani .timeline::after {width:100%; transition: 10s linear;}
    
    .main-visual.slide-1 .object1 {background-image: url(/html/page/index/assets/images/visual2/img-main-visual-obj1-1.png);}
    .main-visual.slide-1 .object2 {background-image: url(/html/page/index/assets/images/visual2/img-main-visual-obj1-2.png);}
    .main-visual.slide-2 .object1 {background-image: url(/html/page/index/assets/images/visual2/img-main-visual-obj2-1.png);}
    .main-visual.slide-2 .object2 {background-image: url(/html/page/index/assets/images/visual2/img-main-visual-obj2-2.png);}
    .main-visual.slide-3 .object1 {background-image: url(/html/page/index/assets/images/visual2/img-main-visual-obj3-1.png);}
    .main-visual.slide-3 .object2 {background-image: url(/html/page/index/assets/images/visual2/img-main-visual-obj3-2.png);}
    
    .swiper-slide:nth-child(1) .title .t-obj {width:50px; height:50px; display: inline-block; background: url(/html/page/index/assets/images/visual2/main-visual-title-obj1-1.png) no-repeat center bottom / auto 39px; position: relative;}
    .swiper-slide:nth-child(1) .title .t-obj::before {content:''; position: absolute; left:0; top:-50%; background: url(/html/page/index/assets/images/visual2/main-visual-title-obj1-2.png) no-repeat left center / auto 78px; width:0; height:80px; }
    .swiper-slide.ani:nth-child(1) .title .t-obj::before {transition: 0.3s ease-out; transition-delay: 1.5s; width:92px;}
    
    .swiper-slide:nth-child(2) .title .t-obj {width:60px; height:50px; display: inline-block; background: url(/html/page/index/assets/images/visual2/main-visual-title-obj2-1.png) no-repeat center bottom / auto 51px; position: relative; left:10px; top:30px; opacity: 0; transform: scale(0.5);}
    .swiper-slide.ani:nth-child(2) .title .t-obj {transition: 0.5s ease; transition-delay: 1.5s; top:10px; opacity: 1; transform: scale(1);}
    
    .swiper-slide:nth-child(2) .desc span .t-obj {display: inline-block; position: relative; width:20px; height:20px; background: url(/html/page/index/assets/images/visual2/main-visual-title-obj2-2.png) no-repeat center bottom / auto 19px; margin-right:5px;}
    .swiper-slide:nth-child(2) .desc span .t-obj::before {content:''; position: absolute; left:2px; top:-5px; background: url(/html/page/index/assets/images/visual2/main-visual-title-obj2-3.png) no-repeat left center / auto 25px; width:0; height:25px; }
    .swiper-slide.ani:nth-child(2) .desc span .t-obj::before {transition: 0.3s ease-out; width:25px;}
    .swiper-slide.ani:nth-child(2) .desc span:nth-child(1) .t-obj::before {transition-delay: 3.5s;}
    .swiper-slide.ani:nth-child(2) .desc span:nth-child(2) .t-obj::before {transition-delay: 3.8s;}
    .swiper-slide.ani:nth-child(2) .desc span:nth-child(3) .t-obj::before {transition-delay: 4.1s;}
    
    .swiper-slide:nth-child(3) .title span {font-weight: bold;}
    .swiper-slide:nth-child(3) .title strong {font-weight: normal;}
    .swiper-slide:nth-child(3) .title span .t-obj {position: absolute; width:40px; height:0px; transform: rotate(-30deg) translate(-24px,-8px);}
    .swiper-slide:nth-child(3) .title span .t-obj::before {content:''; position: absolute; left:0; bottom:-1px; width:34px; height:21px; background: url(/html/page/index/assets/images/visual2/main-visual-title-obj3-1.png) no-repeat 0 bottom / 100% 100%; transform-origin: bottom;}
    .swiper-slide:nth-child(3) .title span .t-obj::after {content:''; position: absolute; left:0; top:0px; width:40px; height:9px; background: url(/html/page/index/assets/images/visual2/main-visual-title-obj3-2.png) no-repeat 0 bottom / 100% 100%; transform-origin: top;}
    .swiper-slide:nth-child(3) .title span .t-obj::before {animation: b-fly-left 5s ease infinite;}
    .swiper-slide:nth-child(3) .title span .t-obj::after {animation: b-fly-right 6.5s ease infinite;}
    .slide-prev,.slide-next {position: absolute; top:50%; transform: translateY(-50%); width:100px; height:200px;z-index: 999; cursor: pointer;}
    .slide-prev {left:-50px;}
    .slide-next {right:-50px;}
    .slide-next::before,.slide-prev::before {content:'';position: absolute; width:100%; height:100%; background: url(/html/page/index/assets/images/visual2/slide-arrow.svg) no-repeat center center / 40px auto;transition: 0.5s ease;left:0; opacity: 0.5;}
    .slide-prev::before {transform: rotate(180deg);}
    .slide-prev:hover::before {transition: 0.5s ease; left:-20px; opacity: 1;}
    .slide-next:hover::before {transition: 0.5s ease; left:20px; opacity: 1;}
    .slide-nav {position: absolute; left:0; bottom:220px; height:6px; display: flex; padding-left:2.5rem;}
    .slide-nav span {display:flex; width:6px; height:6px; border-radius: 3px; background-color:rgba(255,255,255,0.5); transition: 0.5s ease; margin-right:4px;}
    .slide-nav.s1 span:nth-child(1),
    .slide-nav.s2 span:nth-child(2),
    .slide-nav.s3 span:nth-child(3) {width:36px;background-color:rgba(255,255,255,1)}
    .text-scroll.is-white {font-weight: normal; font-size: 0.875rem; height: 22px; line-height: 22px;}
    .text-scroll.is-white:after {background-image: url(/html/page/index/assets/images/visual2/ico-scroll-arrow-white.svg); background-position: 50%; background-size: 80%; background-repeat: no-repeat;}
    .text-scroll.is-white:after {display: none;}
    .text-scroll.is-white span.mouse {position: absolute; left:-20px;height:22px; width:14px; overflow: hidden; background: url(/html/page/index/assets/images/visual2/mouse.svg) no-repeat 0 0 / 100%; }
    .text-scroll.is-white span.mouse::before {content:'';position: absolute; left:50%; transform: translateX(-50%); width:2px; border-radius: 1px; background-color: #fff; height:4px; top:5px;}
    .text-scroll.is-white span.mouse::before {animation: mousewheelmotion 2s ease infinite;}
    @keyframes mousewheelmotion {
        30% {top:5px; height:4px; opacity: 1;}
        50% {top:5px; height:10px; opacity: 1;}
        60% {top:10px; height:5px; opacity: 0.5;}
        70% {top:11px; height:4px; opacity: 0;}
        85% {top: 5px; height: 4px; opacity: 0;}
        100% {top: 5px; height: 4px; opacity: 1;}
    }
    
    @media screen and (min-width:1040px){
        .main-link [class*=link-item] a:hover {color:#FF8300; transition: 0.2s ease;} 
        .main-link [class*=link-item] a,
        .main-link [class*=link-item] a::before {transition: 0.2s ease;}
    }
    .main-link .link-item1 a:hover::before {transition: 0.2s ease; background-image: url(/html/page/index/assets/images/visual2/ico-main-link1-ov.svg);}
    .main-link .link-item2 a:hover::before {transition: 0.2s ease; background-image: url(/html/page/index/assets/images/visual2/ico-main-link2-ov.svg);}
    .main-link .link-item3 a:hover::before {transition: 0.2s ease; background-image: url(/html/page/index/assets/images/visual2/ico-main-link3-ov.svg);}
    .main-link .link-item4 a:hover::before {transition: 0.2s ease; background-image: url(/html/page/index/assets/images/visual2/ico-main-link4-ov.svg);}
    
    
    @keyframes b-fly-left {
        0% {transform: scaleY(1);}
        30% {transform: scaleY(0.2);}
        70% {transform: scaleY(0.9);}
        80% {transform: scaleY(0.7);}
        100% {transform: scaleY(1);}
    }
    @keyframes b-fly-right {
        0% {transform: scaleY(1);}
        60% {transform: scaleY(0.6);}
        90% {transform: scaleY(1.2);}
        100% {transform: scaleY(1);}
    }
    
    @media screen and (max-width:768px){
        .main-visual .back1 {background-image: url(/html/page/index/assets/images/visual2/bg-main-visual-1-m.png);}
        .main-visual .back2 {background-image: url(/html/page/index/assets/images/visual2/bg-main-visual-2-m.png);}
        .main-visual .back3 {background-image: url(/html/page/index/assets/images/visual2/bg-main-visual-3-m.png);}
        .swiper-slide:nth-child(2) .desc span .t-obj {top:2px;}
        .main-visual {background-image: url(/html/page/index/assets/images/visual2/bg-main-visual-m.png);}
        .swiper-slide.ani .desc {padding-top:1rem;}
        .swiper-slide.ani {margin-top:0px;}
        .swiper-slide:nth-child(1) .title .t-obj {transform: scale(1);position: absolute;right: -20vw;top: 10px;}
        .swiper-slide:nth-child(1) .title strong {display: block; max-width: 50vw;}
        .swiper-slide:nth-child(2) .title strong {transform: translateY(55px); position: absolute;}
        .swiper-slide:nth-child(3) .title span .t-obj {transform: rotate(-30deg) translate(-17px,-9px) scale(0.8);}
        .main-visual.slide-1 .object1 {background-image: url(/html/page/index/assets/images/visual2/img-main-visual-obj1-1-m.png);}
        .main-visual.slide-1 .object2 {background-image: url(/html/page/index/assets/images/visual2/img-main-visual-obj1-2-m.png);}
        .main-visual.slide-1 .object3 {background-image: url(/html/page/index/assets/images/visual2/img-main-visual-obj1-3-m.png);}
        .main-visual.slide-2 .object1 {background-image: url(/html/page/index/assets/images/visual2/img-main-visual-obj2-1-m.png);}
        .main-visual.slide-2 .object2 {background-image: url(/html/page/index/assets/images/visual2/img-main-visual-obj2-2-m.png);}
        .main-visual.slide-2 .object3 {background-image: none;}
        .main-visual.slide-3 .object1 {background-image: url(/html/page/index/assets/images/visual2/img-main-visual-obj3-1-m.png);}
        .main-visual.slide-3 .object2 {background-image: url(/html/page/index/assets/images/visual2/img-main-visual-obj3-2-m.png);}
        .main-visual.slide-3 .object3 {background-image: url(/html/page/index/assets/images/visual2/img-main-visual-obj3-3-m.png);}
        .slide-nav {left: 50%;bottom: 47px;transform: translateX(-50%) scale(0.7); padding-left:0;}
        .main-visual .text-scroll {opacity: 0.7;}
        .text-scroll.is-white {height:auto}
        .text-scroll.is-white:after {background-size: 100%; display: block;}
        .text-scroll.is-white span.mouse {display: none;}
        .phone {transform: translate(-50%,-57%) scale(0.57);margin-left: calc(50vw);top:53%;}
        .is-active.phone {margin-left: calc(24vw); transition: 1.5s ease; opacity: 1;}
        .main-visual .swiper-slide:nth-child(3) .desc span {padding-top:30px;}
    
    }
</style>
<script>
// 추가 //
function mainslide(e) {
    AA = e;
    $('.slide-nav').removeClass('s1 s2 s3').addClass('s'+AA);
    $('.main-visual .object1,.main-visual .object2').addClass('hide');
    $('.phone').removeClass('slide-1 slide-2 slide-3').addClass('slide-'+AA);  
    setTimeout(function(){
        $('.main-visual').removeClass('slide-1 slide-2 slide-3').addClass('slide-'+AA);                
    },1000)
    $('.main-visual').removeClass('is-active');
    $('.swiper-slide').removeClass('ani');
    $('.swiper-slide:nth-child('+AA+')').addClass('ani');
}

$(function() {
    $(window).on('load', function() {
        setTimeout(function() {
            $('#visual,.phone').addClass('is-active'); // 수정
        }, 200)

        // 추가 //
        var slideNum = 1;
        $('.phone').one('transitionend animationend',function(){ 
            mainslide(slideNum)
        })
        
        $('.swiper-slide .desc span').on('transitionend animationend',function(){ 
            $('.main-visual > .object1,.main-visual > .object2').removeClass('hide');
            $('.main-visual').addClass('is-active');
        })
        $('.swiper-slide .timeline').on('transitionend animationend',function(){
            slideNum ++;
            if (slideNum > 3){slideNum = 1;}
            mainslide(slideNum);
        })
        $('.swiper .slide-prev').on('click',function(){
            slideNum --;
            if (slideNum < 1){slideNum = 3;}
            mainslide(slideNum);
        })
        $('.swiper .slide-next').on('click',function(){
            slideNum ++;
            if (slideNum > 3){slideNum = 1;}
            mainslide(slideNum);
        })


    })

})


</script>