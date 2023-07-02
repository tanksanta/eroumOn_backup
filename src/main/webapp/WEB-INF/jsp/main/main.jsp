<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<div class="main-visual">
    <div class="object1"></div>
    <div class="object2"></div>
    <div class="object3"></div>
    <div class="swiper">
        <div class="swiper-wrapper">
            <div class="swiper-slide">
                <p class="title">
                    최대 2,500만원 복지혜택,<br>
                    <strong>65세 이상이라면 바로 신청하세요</strong>
                </p>
                <p class="desc">등급별 지원 혜택이 달라요!</p>
                <a href="${_mainPath}/recipter/list" class="btn btn-primary3 is-arrow">내 인정등급 확인하기</a>
            </div>
            <div class="swiper-slide">
                <p class="title">
                    65세 미만이라도,<br>
                    <strong>등급 인정 확률이 높아요</strong>
                </p>
                <p class="desc">
                    타인 도움 없이 생활이 불가능한 어르신<br>
                    노인성 질환을 앓고 있는 어르신<br>
                    치매 증상으로 불편한 어르신
                </p>
                <a href="https://www.eroum.co.kr/find/step2-1" class="btn btn-primary3 is-arrow">지금 등급 확인하기</a>
            </div>
            <div class="swiper-slide">
                <p class="title">
                    <strong>어르신을 위한 복지,</strong><br>
                    놓치지 말고 누리세요
                </p>
                <p class="desc">등급을 받으시면 다양한 요양 용품, 서비스가 제공되요</p>
                <a href="https://www.eroum.co.kr/find/step2-1" class="btn btn-primary3 is-arrow">지금 등급 확인하기</a>
            </div>
        </div>
    </div>
    <p class="text-scroll is-white">아래에서 더 자세히 알아보세요</p>
</div>

<div class="main-welfare">
    <div class="container">
        <p class="desc">시니어를 위한 <strong>복지서비스</strong><br> <strong>한 곳에 모아서!</strong></p>
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
    <li class="link-item1"><a href="${_mainPath}/searchBokji">노인복지<br> 정보</a></li>
    <li class="link-item2"><a href="https://www.eroum.co.kr/find/step2-1" target="_blank">노인복지<br> 테스트</a></li>
    <li class="link-item3"><a href="${_marketPath}/index" target="_blank">복지용구<br> 구매</a></li>
    <li class="link-item4"><a href="//www.youtube.com/@Super_Senior" target="_blank">슈퍼<br>시니어</a></li>
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
            <a href="${_mainPath}/cntnts/page1" class="btn btn-outline-primary2 is-arrow">쉽게 알아보기</a>
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
            <a href="${_mainPath}/cntnts/page2" class="btn btn-outline-primary3 is-arrow">복지용구 알아보기</a>
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
            <a href="${_mainPath}/cntnts/page3" class="btn btn-outline-primary2 is-arrow">복지용구 선택하기</a>
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
            //main visual
            var swiper = new Swiper(".swiper", {
                slidesPerView: 1,
                loop: true,
                effect: "fade",
                speed: 1000,
                allowTouchMove: false,
                autoplay: {
                    delay: 6000,
                    disableOnInteraction: false,
                },
                fadeEffect: {
                    crossFade: true
                }
            });

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