<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<div class="main-inner">
    <div class="main-visual">

        <div class="swiper">
            <div class="swiper-wrapper">
                <div class="swiper-slide slide-item1" data-slide-number="1">
                    <div class="content">
                        <p class="title">
                            <span class="ani-text">최대 2,500만원 복지혜택,</span>
                            <strong class="ani-text"><span class="ani-obj"></span>65세 이상이라면 바로 신청하세요</strong>
                        </p>
                        <p class="desc"><span class="ani-text">등급별 지원 혜택이 달라요!</span></p>
                        <a href="${_mainPath}/cntnts/test" target="_blank" class="btn btn-primary3 btn-arrow"><strong>내 인정등급 확인하기</strong></a>
                    </div>
                </div>
                <div class="swiper-slide slide-item2" data-slide-number="2">
                    <div class="content">
                        <p class="title">
                            <span class="ani-text">65세 미만이라도,</span>
                            <strong class="ani-text">등급 인정 확률이 높아요<span class="ani-obj"></span></strong>
                        </p>
                        <p class="desc">
                            <span class="ani-text"><span class="ani-obj"></span>타인 도움 없이 생활이 불가능한 어르신</span>
                            <span class="ani-text"><span class="ani-obj"></span>노인성 질환을 앓고 있는 어르신</span>
                            <span class="ani-text"><span class="ani-obj"></span>치매 증상으로 불편한 어르신</span>
                        </p>
                        <a href="${_mainPath}/cntnts/test" target="_blank" class="btn btn-primary3 btn-arrow"><strong>지금 등급 확인하기</strong></a>
                    </div>
                </div>
                <div class="swiper-slide slide-item3" data-slide-number="3">
                    <div class="content">
                        <p class="title">
                            <span class="ani-text">어르신을 위한 복지,<span class="ani-obj"></span></span>
                            <strong class="ani-text">놓치지 말고 누리세요</strong>
                        </p>
                        <p class="desc"><span class="ani-text">등급을 받으시면 다양한 요양 용품, 서비스가 제공돼요</span></p>
                        <a href="${_mainPath}/cntnts/test" target="_blank" class="btn btn-primary3 btn-arrow"><strong>지금 등급 확인하기</strong></a>
                    </div>
                </div>
            </div>
            <div class="swiper-button-prev"></div>
            <div class="swiper-button-next"></div>
            <div class="swiper-pagination"></div>
            <div class="object">
                <div class="object-content">
                    <div class="wrapper">
                        <img src="/html/page/index/assets/images/visual/img-main-visual-phone2.jpg" alt="">
                        <div class="objects">
                            <div class="objects-1"></div>
                            <div class="objects-2"></div>
                            <div class="objects-3"></div>
                            <div class="objects-4"></div>
                        </div>
                    </div>
                </div>
                <div class="object-group">
                    <div class="object1"></div>
                    <div class="object2"></div>
                </div>
            </div>
        </div>
        <p class="text-scroll is-white"><i></i> 자세히 보기</p>
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
            <a href="${_mainPath}/recipter/sub">남은 혜택보기​</a>

        </div>
        <div class="notice-banner2">
            <dl>
                <dt>부모님 맞춤 상품이 필요하세요?</dt>
                <dd>복지용구부터 시니어 생활용품까지 한 번에</dd>
            </dl>
            <a href="${_marketPath}/index" target="_blank">지금 둘러보기</a>
        </div>
    </div>

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
                <p>복지용구로 더실 수 있어요.</p>
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
                <p>혜택받는 방법과<br> 고르는 법을 알려드릴게요.</p>
                <a href="${_mainPath}/cntnts/page3" class="btn btn-large2 btn-outline-primary2 btn-arrow"><strong>복지용구 선택하기</strong></a>
            </div>
        </div>
    </div>

    <div class="main-banner">
        <div class="market-banner">
            <strong>
                부모님 맞춤 상품이 필요하세요?​
                <small>복지용구부터 시니어 생활용품까지 한 번에</small>
            </strong>
            <a href="${_marketPath}/index" target="_blank">지금 둘러보기</a>
        </div>
    </div>

    <!--구글플레이, QR-->
    <hr class="divide-x-1 mt-8"/>
    <div class="main-store">
        <div class="main-store-inner">
            <div class="main-store-text">
                <p>지금 바로 앱 다운로드하고,</p>
                <strong>다양한 혜택을 누려보세요</strong>
            </div>
            <div class="main-store-link">
                <img src="/html/page/index/assets/images/img-qr.svg" alt="QR Code" class="hidden md:block"/>
                <a href="https://play.google.com/store/apps/details?id=kr.co.eroum&pli=1" target="_blank"><img src="/html/page/index/assets/images/img-google-play.png" alt="google play"/></a>
            </div>
        </div>
    </div>
    <!--//구글플레이, QR-->
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

    //object visible check
    var observerCallback = (entries, observer, header) => {
        if(entries[0].isIntersecting) {
            entries[0].target.parentNode.classList.add('is-active');
        }
    };

    var visualAnimate = function(swiper) {
        $(swiper.slides).each(function(i) {
            if(i === swiper.activeIndex) {
                var numb = $(this).attr('data-slide-number');
                $(this).find('.content').addClass('is-active').find('.ani-text, .ani-obj').last().one('transitionend animationend',function() {
                    $('.main-visual .object-group').prop('class', 'object-group is-scene' + swiper.slides[swiper.activeIndex].dataset.slideNumber + ' is-active');
                });
            } else {
                $(this).find('.content').removeClass('is-active').find('.ani-text, .ani-obj').off('transitionend animationend');
            }
        });
	};

    var visualSetting = function(swiper) {
        pageBtn = $('.main-visual .swiper-slide-active .btn');
        slider  = [$('.main-visual .swiper-slide-active').outerWidth(), $('.main-visual .swiper-slide-active').outerHeight()];

        $(swiper.pagination.el).css({'bottom' : $('.main-visual').height() - (pageBtn.position().top + pageBtn.height() + ($(window).outerWidth() > 768 ? 48 : 23) + parseInt(pageBtn.css('margin-top').replace('px', '')))});

        if($(window).outerWidth() > 768) {
            $('.swiper .object').css({
                '--tw-scale-x' : (slider[0] * 0.5583333 / 670 > 1.2) ? 1.2 : slider[0] * 0.5583333 / 670,
                '--tw-scale-y' : (slider[0] * 0.5583333 / 670 > 1.2) ? 1.2 : slider[0] * 0.5583333 / 670
            });
        } else {
            $('.swiper .object').css({
                '--tw-scale-x' : (slider[1] * 0.5 / 670 > 0.6) ? 0.6 : slider[1] * 0.5 / 670,
                '--tw-scale-y' : (slider[1] * 0.5 / 670 > 0.6) ? 0.6 : slider[1] * 0.5 / 670
            });
        }
    };
    
    $(function() {
        var swiper = new Swiper(".main-visual .swiper", {
            slidesPerView: 1,
            loop: true,
            effect: "fade",
            speed: 1000,
            pagination: {
                el: '.main-visual .swiper-pagination',
            },
			autoplay: {
                delay: 6000,
                disableOnInteraction: false,
            },
            navigation: {
                nextEl: '.main-visual .swiper-button-next',
                prevEl: '.main-visual .swiper-button-prev',
            },
            fadeEffect: {
                crossFade: true
            },
            on: {
                beforeInit: function(swiper) {
                    $('.main-visual .object').addClass('is-init');
                },
                afterInit: function(swiper) {
                	visualAnimate(swiper);
                    visualSetting(swiper);
                },
                slideChange: function(swiper) {
                    $('.main-visual .object-group').removeClass('is-active');
                    $('.main-visual .object-content').prop('class', 'object-content is-scene' + swiper.slides[swiper.activeIndex].dataset.slideNumber);
                },
                slideChangeTransitionEnd: function(swiper) {
                	$('.object').on('transitionend', visualAnimate(swiper));
                }
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

        $(window).on('load', function(e) {
        	visualSetting(swiper);
        });

        $(window).on('resize', function(e) {
            if(e.type === 'resize' && resize) {
            	visualSetting(swiper);
            }
        });
    })
</script>