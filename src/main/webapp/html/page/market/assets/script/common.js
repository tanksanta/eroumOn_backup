var winSize  = null;
var resize   = false;
var timer    = null;

var horizonScroll = function(element) {
    var isDown = false;
    var slider = element;
    var startX;
    var scrollLeft;

    //navigation scroll
    slider.on('mousedown', function(e) {
        isDown = true;
        startX = e.pageX - slider.offset().left;
        scrollLeft = slider.scrollLeft();
    })

    slider.on('mouseleave mouseup', function(e) {
        isDown = false;
    })

    slider.on('mousemove', function(e) {
        if(!isDown) return;
        e.preventDefault();
        const x = e.pageX - slider.offset().left;
        const walk = (x - startX) * 3;
        slider.scrollLeft(scrollLeft - walk);
    });
};

var navClock = function() {
    var now  = new Date();
    var hour = now.getHours();
    var mins = now.getMinutes();

    $('.navigation-clock .hour').text(hour + '시').css({'--tw-rotate' : ((hour / 12) * 360) + 'deg'});
    $('.navigation-clock .mins').text(mins + '분').css({'--tw-rotate' : ((mins / 60) * 360) + 'deg'});
};



$(function() {
/*
	var keys = "";
	var srcs = "";
	var partnerImg = "";
	var partnerName = "";
	var partnerAddrs = "";
	var partnerTel = "";

	// 파트너스 선택

	$(document).on("click", ".product-partners", function(e){
		var uniqueKey = $(this).data("uniqueId");


		if(!$(this).hasClass("is-active")){
			keys = uniqueKey;
			srcs = $(this).children("img");
			partnerImg = srcs.attr("src");

			var nmDt = $(this).children("dl");
			var nmDl = nmDt.children("dt");
			partnerName = nmDl.text();

			var ad = nmDt.children("dd");
			var ads = ad.children(".addr");
			var tt = ads.text();
			partnerAddrs = tt.substr(5);

			var telInfo = ad.children(".call");
			var tels = telInfo.children("a");
			partnerTel = tels.text();
		}
		e.preventDefault();
	});

	// 파트너스 추가
	$(document).on("click", "#subPartners", function(e){
		$("#bplcUniqueId").val(keys);
		$(".btn-cancel").click();

		if(keys != ''){
			$(".noSelect").hide();
			$(".selectPart").show();
			$("#pImg").attr("src",partnerImg);
			$("#pName").text(partnerName);
			$(".pAddrs").text(partnerAddrs);
			$(".pTel").text(partnerTel);
			$(".pTel").attr("href","tel:" + partnerTel);
		}else{
			//$(".noSelect").show();
		}



		e.preventDefault();
	});*/

    //공용 툴팁 전역 초기화
    var tooltipTriggerList = [].slice.call(
        document.querySelectorAll('[data-bs-toggle="tooltip"]')
    );
    var tooltipList = tooltipTriggerList.map(function (tooltipTriggerEl) {
        return new Tooltip(tooltipTriggerEl);
    });

    var popoverTriggerList = [].slice.call(
        document.querySelectorAll('[data-bs-toggle="popover"]')
    );
    var popoverList = popoverTriggerList.map(function (popoverTriggerEl) {
        return new Popover(popoverTriggerEl);
    });

    //팝오버 클로즈
    $(document).on('click', '.popover .close', function() {
        $('[aria-describedby="' + $(this).closest('.popover').attr('id') + '"]').popover('hide');
    });

    //공용 토글버튼
    $('.btn-toggle').on('click', function() {
        $(this).toggleClass('is-active');
    })

    //공용 옵션박스
    /*
    $('.product-option .option-toggle').on('click', function() {
        $(this).closest('.product-option').toggleClass('is-active');
    })
    */

    // 팝업 닫기
    $(".cls-popup-btn").on("click",function(){
    	var popNo = $(this).data("popNo");
    	$(".view"+popNo).removeClass("is-active");

    	var id = $(this).data("oneHide");
    	console.log(id);
    	if($("#"+id).is(":checked")){
			$.cookie("popup"+popNo,"none",{expires:1, path:"/"});
		}
    });


    //상단 시계
    setInterval(navClock, 1000);
    navClock();


    //상단 네비 스크롤
    horizonScroll($('.navigation-menu .container'));


    //상단 네비 폴딩
    // $('.navigation-menu .toggle').on('click', function() {
    //     var mSpace  = 0;
    //     var target = $('.navigation-menu');

    //     target.find('li').each(function() {
    //         mSpace = mSpace + $(this).outerWidth(true);
    //         if($(this).hasClass('seperate')) {
    //             return false;
    //         }
    //     })

    //     target.find('ul').one('transitionend webkitTransitionEnd oTransitionEnd', function() {
    //         target.removeClass('is-animate');
    //     })

    //     if(target.hasClass('is-hidden')) {
    //         target.addClass('is-animate').removeClass('is-hidden').find('ul').removeAttr('style');
    //     } else {
    //         target.addClass('is-animate').addClass('is-hidden').find('ul').css({'margin-left' : -mSpace});
    //     }
    // });

    $('.header-layer .menu-item > a').on('click', function() {
        $(this).parent().toggleClass('is-active').siblings().removeClass('is-active');
    });

    //상단 전체 검색
    $('.navigation-search-toggle, .navigation-search-layer .closed').on('click', function() {
        var layer   = $('.navigation-search-layer');
        var trigger = $('.navigation-search-toggle');

        layer.one('transitionend webkitTransitionEnd oTransitionEnd', function() {
            $(this).removeClass('is-animate');
        });

        if(layer.hasClass('is-active')) {
            $('body').removeClass('overflow-hidden');
            layer.addClass('is-animate').removeClass('is-active');
            trigger.removeClass('is-active');
        } else {
            $('body').addClass('overflow-hidden');
            layer.addClass('is-animate').addClass('is-active');
            trigger.addClass('is-active');
        }
    });

    $('.navigation-search-layer').on('click', function(e) {
        var layer   = $('.navigation-search-layer');
        var trigger = $('.navigation-search-toggle');

        layer.one('transitionend webkitTransitionEnd oTransitionEnd', function() {
            $(this).removeClass('is-animate');
        });

        if(e.target === $(this).get(0)) {
            $('body').toggleClass('overflow-hidden');
            layer.addClass('is-animate').removeClass('is-active');
            trigger.removeClass('is-active');
        }
    })

    var swiper = new Swiper(".navigation-search-layer .swiper", {
        slidesPerView: 1,
        spaceBetween: 30,
        breakpoints: {
            768 : {
                slidesPerView: "auto"
            }
        }
    });

    //상단 상품 비교
    /* product.js로 이동
    $('.service-compare-items li').on('mouseenter', function() {
        $(this).addClass('is-active').siblings().removeClass('is-active');
    }).on('mouseleave', function() {
        $(this).removeClass('is-active');
    });

    $('.service-compare-toggle, .service-compare-layer .closed').on('click', function() {
        $('.service-compare-toggle, .service-compare-layer').toggleClass('is-active');
    });

    $('.service-compare-layer td').on('mouseenter mouseleave', function(e) {
        var index = $(this).index() - 1;
        var layer = $('.service-compare-layer');

        if(e.type === 'mouseenter') {
            layer.find('tr').each(function() {
                $(this).find('td').removeClass('is-active').eq(index).addClass('is-active');
            });

            layer.find('.select').css({'left' : $(this).position().left}).show();
        } else {
            layer.find('tr').each(function() {
                $(this).find('td').eq(index).removeClass('is-active');
            });

            layer.find('.select').hide();
        }
    });
    */

    //상단 쇼핑 히스토리
    var swiper2 = new Swiper(".service-recent-layer .swiper", {
        slidesPerView: "auto",
        spaceBetween: 16,
        navigation: {
            nextEl: ".swiper-button-next",
            prevEl: ".swiper-button-prev",
        },
        breakpoints: {
            768 : {
                spaceBetween: 28
            },
            1280 : {
                spaceBetween: 40
            }
        }
    });

    $('.service-recent, .service-recent-layer .closed').on('click', function() {
        $('.service-recent, .service-recent-layer').toggleClass('is-active');
        return false;
    });

    //상단 슬로건
    if($('.service-slogan').length > 0) {
        $('.service-slogan .word').each(function(index) {
            $(this).css('margin-top', ($(this).height() * index));
        });
        
        setInterval(function() {
            $('.service-slogan .word').each(function(index) {
                $(this).addClass('is-animate').css('margin-top', ($(this).height() * (index - 1))).one('transitionend webkitTransitionEnd oTransitionEnd', function() {
                    $(this).removeClass('is-animate');
                    if((index - 1) === -1) {
                        $(this).detach().appendTo($('.service-slogan')).css('margin-top', ($(this).height() * $(this).index()));
                    }
                });
            });
        }, 10000);
    }

    //개인화 레이어
    var person       = $('.personal-info');
    var personRoot   = person.parent();
    var personUser   = person.find('.personal-user');
    var personBody   = person.find('.personal-detail');
    var personLink   = person.find('.personal-famlink');
    var personCart   = person.find('.personal-famcart');
    var personTop    = person.find('.personal-toggle');
    var personLayer  = $('.personal-layer');
    var personLayer2 = $('.personal-layer2');
    var personInit   = function() {
        person.removeAttr('style');
        personUser.attr('data-width', personUser.outerWidth(true));
        personBody.each(function() {
            var temp = 0;
            $(this).find('> *').each(function() { temp = temp + $(this).outerWidth(true); });
            $(this).attr('data-width', temp);
        });

        if(person.is('[class*="bg-color"]')) {
            personLink.addClass('is-linked');
        } else {
            personLink.removeClass('is-linked');
        }

        if(personRoot.attr('id') === 'personal') {
            personRoot.addClass('is-active').css({'margin-left' : -(personRoot.outerWidth()/2)});
        }
    }

    personInit();

    personLink.on('click', function() {
        var link = personBody.filter('.personal-onlink');

        $('body').addClass('overflow-hidden');

        if(personRoot.attr('id') === 'personal') {
            var link = personBody.filter('.personal-onlink');

            personBody.removeClass('is-active').filter('.personal-onlink').addClass('is-active');

            person.removeClass('is-noshadow');
            personLayer.addClass('is-active');
            personLayer2.removeClass('is-active');

            personRoot.addClass('is-active').css({'margin-left' : -(link.position().left + parseInt(link.find('.personal-container').css('padding-left').replace('px','')) + (link.find('.icon').width()/2))});
        }

        if(personRoot.attr('id') === 'page-personal') {
            var scrollTop = personRoot.get(0).getBoundingClientRect().top - $('#header').outerHeight();
            var topSize   = personRoot.get(0).getBoundingClientRect().top + personRoot.outerHeight() + 8;

            if(scrollTop !== 0) {
                $(window).scrollTop($(window).scrollTop() + scrollTop);
                setTimeout(function() {
                    topSize = personRoot.get(0).getBoundingClientRect().top + personRoot.outerHeight() + 8;

                    personBody.removeClass('is-active').filter('.personal-onlink').addClass('is-active');
                    personLayer.css({'top': topSize}).addClass('is-active');
                    personLayer2.removeClass('is-active');
                    person.removeClass('is-noshadow').addClass('is-active').css({'left' : -((link.offset().left - ($(window).width()/2)) + (parseInt(link.find('.personal-container').css('padding-left').replace('px','')) + link.find('.icon').width()/2))});
                }, 500);
            }

            if(scrollTop == 0) {
                personBody.removeClass('is-active').filter('.personal-onlink').addClass('is-active');
                personLayer.css({'top': topSize}).addClass('is-active');
                personLayer2.removeClass('is-active');
                person.removeClass('is-noshadow').addClass('is-active').css({'left' : -((link.offset().left - ($(window).width()/2)) + (parseInt(link.find('.personal-container').css('padding-left').replace('px','')) + link.find('.icon').width()/2))});
            }
        }
    });

    personTop.on('click', function() {
        $(window).scrollTop(0);
        return false;
    });

    personLayer.find('.modal-item input').on('change', function() {
        if($(this).is(':checked')) {
            var color = 'personal-info bg-color' + ($(this).closest('.modal-item').index() + 1);
            person.attr('class', color);
        }
    })

    personLayer.find('.modal-footer .link1').on('click', function() {
        $(this).closest('.modal-content').find('.modal-item .input').prop('checked', false);
        person.attr('class', 'personal-info');
        return false;
    });

    /* .connect */
    personLayer.find('.modal-footer ').on('click', function() {
    	if($(".bg-color*").length > 0){
	    	$('body').removeClass('overflow-hidden');
	        personBody.removeClass('is-active').filter('.personal-onbase').addClass('is-active');
	        personLayer.removeClass('is-active');

	        if(person.is('[class*="bg-color"]')) {
	            personLink.addClass('is-linked');
	        } else {
	            personLink.removeClass('is-linked');
	        }
	        personInit();
    	}
    });

    personCart.on('click', function() {
        $('body').addClass('overflow-hidden');

        if(personRoot.attr('id') === 'personal') {
            personLayer2.addClass('is-active');
            person.addClass('is-noshadow');
        }

        if(personRoot.attr('id') === 'page-personal') {
            var scrollTop = personRoot.get(0).getBoundingClientRect().top - $('#header').outerHeight();
            var topSize   = personRoot.get(0).getBoundingClientRect().top + (personRoot.outerHeight() * 0.55);

            if(scrollTop !== 0) {
                $(window).scrollTop($(window).scrollTop() + scrollTop);
                setTimeout(function() {
                    topSize = personRoot.get(0).getBoundingClientRect().top + (personRoot.outerHeight()/2);

                    personBody.removeClass('is-active').filter('.personal-onbase').addClass('is-active');
                    personLayer.removeClass('is-active');
                    personLayer2.css({'top': topSize}).addClass('is-active');
                    person.addClass('is-noshadow');
                }, 500);
            }

            if(scrollTop == 0) {
                personBody.removeClass('is-active').filter('.personal-onbase').addClass('is-active');
                personLayer.removeClass('is-active');
                personLayer2.css({'top': topSize}).addClass('is-active');
                person.addClass('is-noshadow');
            }
        }
    });


    personLayer2.find('.modal-footer .btn-outline-primary').on('click', function() {
        $('body').removeClass('overflow-hidden');
        personLayer2.removeClass('is-active');
        person.removeClass('is-noshadow');
    });

    $(window).on('scroll', function() {
        if(personRoot.attr('id') === 'personal') {
            var targetH = $('#header').outerHeight(true) + $('#navigation').outerHeight(true) + $('#service').outerHeight(true);
            if($(this).scrollTop() >= targetH) {
                personBody.removeClass('is-active').filter('.personal-oncart').addClass('is-active');
            } else {
                personBody.removeClass('is-active').filter('.personal-onbase').addClass('is-active');
            }
        }
        personInit();
    });

    $(window).on('load resize', function() {
        personBody.removeClass('is-active').filter('.personal-onbase').addClass('is-active');
        personLayer.removeClass('is-active');
        personLayer2.removeClass('is-active');
        person.removeClass('is-noshadow');

        personInit();
    });


    //사이드 메뉴 토글
    $('.page-sidenav-toggle').on('click', function() {
        var layer   = $('#page-sidenav');
        var button  = $('.page-sidenav-toggle');
        var pheader = $('#page-header');
        var body    = $('body');

        layer.one('transitionend webkitTransitionEnd oTransitionEnd', function() {
            $(this).removeClass('is-animate');
        });

        if(layer.hasClass('is-active')) {
            body.removeClass('overflow-hidden');
            button.removeClass('is-active');
            layer.addClass('is-animate').removeClass('is-active');
        } else {
            if(pheader.get(0).getBoundingClientRect().top > pheader.css('top').replace('px', '')) {
                $(window).scrollTop($(window).scrollTop() + 1 + pheader.get(0).getBoundingClientRect().top - pheader.css('top').replace('px', ''));
                setTimeout(() => {
                    body.addClass('overflow-hidden');
                    button.addClass('is-active');
                    layer.css({'top': pheader.get(0).getBoundingClientRect().top + pheader.outerHeight()}).addClass('is-animate').addClass('is-active');
                }, 500);
            } else {
                body.addClass('overflow-hidden');
                button.addClass('is-active');
                layer.css({'top': pheader.get(0).getBoundingClientRect().top + pheader.outerHeight()}).addClass('is-animate').addClass('is-active');
            }
        }
    });

    $('#page-sidenav').on('click', function(e) {
        var layer  = $('#page-sidenav');
        var button = $('.page-sidenav-toggle');
        var body   = $('body');

        layer.one('transitionend webkitTransitionEnd oTransitionEnd', function() {
            $(this).removeClass('is-animate');
        });

        if(e.target === $(this).get(0)) {
            body.removeClass('overflow-hidden');
            button.removeClass('is-active');
            layer.addClass('is-animate').removeClass('is-active');
        }
    });

    //상품 검색 기타 플러스버튼
    $('#page-sidenav .moreview').on('click', function() {
        $(this).closest('.page-sidenav-group').toggleClass('is-active');
    });

    //타이틀 브래드스크럼 토글
    $('.page-header-breadcrumb > li > a').on('click', function() {
        $(this).parent().toggleClass('is-active').siblings().removeClass('is-active');
        return false;
    });

    //퀵메뉴
    $('#quick .moveTop').on('click', function() {
        $(window).scrollTop(0);
    });

    $(window).on('load scroll', function() {
        if($(window).scrollTop() > $(window).outerHeight() * 0.75) {
            $('#quick').addClass('is-active');
        } else {
            $('#quick').removeClass('is-active');
        }
    });

    //resize
    $(window).on('load resize', function() {
        resize  = (winSize !== null && $(window).outerWidth() === winSize[0]) ? false : true;
        winSize = [$(window).outerWidth(), $(window).outerHeight()];

        clearTimeout(timer);

        timer = setTimeout(function() {
            if(resize) {
                $('body').removeClass('overflow-hidden');
                $('#page-sidenav, .page-sidenav-toggle').removeClass('is-active').removeAttr('style');
            }
        }, 5);
    });

    //발리데이션 디폴트
	$.validator.setDefaults({
		onfocusout: false,
	   	errorElement: 'div',
		success: function(label){
			label.closest(".invalid-feedback").remove();
		},
		highlight:function(element, errorClass, validClass) {
		    $(element).addClass('is-invalid');
		},
		unhighlight: function(element, errorClass, validClass) {
		    $(element).removeClass('is-invalid');
		}
	});

	// 정규식 체크
	$.validator.addMethod("regex", function(value, element, regexpr) {
		if(value != ''){
			return regexpr.test(value)
		}else{
			return true;
		}
	}, "형식이 올바르지 않습니다.");

	//페이징
    $("#countPerPage").on("change", function(){
		var cntperpage = $("#countPerPage option:selected").val();
		$("#cntPerPage").val(cntperpage);
		$("#searchFrm").submit();
	});

	// 보호자 선택
	var FAMILY_SEL = (function(){
		$("#famsFrm input[name='fams']").on("click, change", function(){
			$(".f_fam_connect span").text("연결하시겠습니까?");
		});

		$(".f_fam_connect").on("click", function(){
			//console.log($("#famsFrm input[name='fams']:checked").val());
			const prtcrUniqueId = $("#famsFrm input[name='fams']:checked").val();
			const index = $("#famsFrm input[name='fams']:checked").data("count");
			if(prtcrUniqueId != null){
				$.ajax({
					type : "post",
					url  : "/market/fml/setPrtcr.json",
					data : {uniqueId:prtcrUniqueId, index:index},
					dataType : 'json'
				})
				.done(function(json) {
					if(json.result){
						location.reload();
					}else{
						alert("가족계정 변경에 실패하였습니다.");
					}
				})
				.fail(function(data, status, err) {
					console.log('error forward : ' + data);
				});
			}

		});


		$(".f_fam_connect2").on("click", function(){
			const prtcrUniqueId = $("#famsFrm2 input[name='fams']:checked").val();
			console.log(prtcrUniqueId);
			const index = $("#famsFrm2 input[name='fams']:checked").data("count");
			$.ajax({
				type : "post",
				url  : "/market/fml/setPrtcr.json",
				data : {uniqueId:prtcrUniqueId, index:index},
				dataType : 'json'
			})
			.done(function(json) {
				if(json.result){
					location.reload();
				}else{
					alert("가족계정 변경에 실패하였습니다.");
				}
			})
			.fail(function(data, status, err) {
				console.log('error forward : ' + data);
			});
		});

		$("#clsLayer").on("click",function(){
			var uniqueId = $(this).data("uniqueId");
			var prtcrId = $(this).data("prtcrId");
			if(uniqueId == prtcrId){
			    location.reload();
			}else{
				$(".f_fam_connect").click();
			}
		});


		$(".f_fam_disconnect").on("click", function(){
			const prtcrUniqueId = $(this).data("uniqueId");
			const index = $(this).data("count");

			if(confirm("가족 연결을 해제하시겠습니까?")){
				$.ajax({
				type : "post",
				url  : "/market/fml/setPrtcr.json",
				data : {uniqueId:prtcrUniqueId, index:index},
				dataType : 'json'
				})
				.done(function(json) {
					if(json.result){
						location.reload();
					}else{
						alert("가족계정 연결해제가 실패하였습니다.\n다시 로그인 해주세요");
					}
				})
				.fail(function(data, status, err) {
					console.log('error forward : ' + data);
				});
			}
		});
	})();


});


/* event add */
// numbercheck(클래스명)으로 숫자 정규식 체크
$(document)
	.on('keyup','.numbercheck',function(){/** 숫자입력만 가능하게 */
		$(this).val( $(this).val().replace(/[^0-9]/gi,"") );
	});

// 전화번호 마스킹
const autoHyphen = (target) => {
 target.value = target.value
   .replace(/[^0-9]/g, '')
   .replace(/^(\d{2,3})(\d{3,4})(\d{4})$/, `$1-$2-$3`);
}


/* function add*/
// 배열에서 특정값 삭제
function arrayRemove(arr, value) {
    return arr.filter(function(ele){
        return ele != value;
    });
}

// 이로움1.0 상품 조회
function f_itemChk(params){
	$.ajax({
		type : "post",
		url  : "/eroumcareApi/bplcRecv/info.json",
		traditional : true,
		data : {
			bnefCd : params.get("bnefList")
			},
		dataType : 'json'
	})
	.done(function(data) {
		var method = params.get("method");
		console.log(data.result);
		if(data.result){
			method(params);
		}else{
			alert("품절된 상품 또는 상품의 옵션이 존재합니다.");
			location.reload();
		}
	})
	.fail(function(data, status, err) {
		console.log(status + ' : 상품 조회 API 중 오류가 발생했습니다.');
	});
}




//첨부파일 이미지 제한
function fileCheck(obj) {

	if(obj.value != ""){

		/* 첨부파일 확장자 체크*/
		var atchLmttArr = new Array();
		atchLmttArr.push("jpg");
		atchLmttArr.push("png");
		atchLmttArr.push("gif");

		var file = obj.value;
		var fileExt = file.substring(file.lastIndexOf('.') + 1, file.length).toLowerCase();
		var isFileExt = false;

		for (var i = 0; i < atchLmttArr.length; i++) {
			if (atchLmttArr[i] == fileExt) {
				isFileExt = true;
				break;
			}
		}

		if (!isFileExt) {
			alert("<spring:message code='errors.ext.limit' arguments='" + atchLmttArr + "' />");
			obj.value = "";
			return false;
		}
	}
};

// 콤마 찍기 : ###,###
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

// 오늘날짜 구하기
function f_getToday(){
	var date = new Date();
    var year = date.getFullYear();
    var month = ("0" + (1 + date.getMonth())).slice(-2);
    var day = ("0" + date.getDate()).slice(-2);

    return year + "-" + month + "-" + day;
}

// 오늘날짜로 +- day
function f_getDate(day){
	var date = new Date();
	date.setDate(date.getDate()+day);
	var year = date.getFullYear();
    var month = ("0" + (1 + date.getMonth())).slice(-2);
    var day = ("0" + date.getDate()).slice(-2);

	return year + "-" + month + "-" + day;
}

// 콤마 제거
function uncomma(str) {
    str = String(str);
    return str.replace(/[^\d]+/g, '');
}

// 숫자형 날짜 -> yyyy-MM-dd
function f_dateFormat(value){
	var date = new Date(value);

	var yyyy = date.getFullYear();
	var mm = date.getMonth() + 1;
	mm = mm >= 10 ? mm : '0' + mm;
	var dd = date.getDate();
	dd = dd >= 10? dd: '0' + dd;
	return yyyy+'-'+mm+'-'+dd;
}

// 주소검색 DAUM API
function f_findAdres(zip, addr, daddr, lat, lot) {
	$.ajaxSetup({ cache: true });
	$.getScript( "//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js", function() {
		$.ajaxSetup({ cache: false });
		new daum.Postcode({
			oncomplete: function(data) {
				$("#"+zip).val(data.zonecode); // 우편번호
				$("#"+addr).val(data.roadAddress); // 도로명 주소 변수
				$("#"+daddr).focus(); //포커스

				if(lat != undefined && lot != undefined){
					f_findGeocode(data, lat, lot); //좌표
				}
	        }
	    }).open();
	});
}

//한글 변환
function viewKorean(num) {
    var hanA = new Array("","일","이","삼","사","오","육","칠","팔","구","십");
    var danA = new Array("","십","백","천","","십","백","천","","십","백","천","","십","백","천");
    var result = "";
    for(i=0; i<num.length; i++) {
        str = "";
        han = hanA[num.charAt(num.length-(i+1))];
        if(han != "") str += han+danA[i];
        if(i == 4) str += "만";
        if(i == 8) str += "억";
        if(i == 12) str += "조";
        result = str + result;
    }
    if(num != 0)
        result = result + "원";
    return result ;
}

// 숫자형 날짜 하이폰 삽입
function f_hiponFormat(value){
	var yyyy = value.substring(0,4);
	var mm = value.substring(4,6);
	var dd = value.substring(6,8);

	return yyyy+'-'+mm+'-'+dd;
}

// param set
function f_setInfo(obj){

	let rctInfoMap = new Map();

	var Name = $($(obj).children('.order-name')).find('.recent-nm'); // 받는 사람
	var MblTelno = $($(obj).children('.order-addr')).find('.recent-mbl-telno'); // 휴대전화
	var Telno = $($(obj).children('.order-addr')).find('.recent-telno'); // 전화
	var zip = $($(obj).children('.order-addr')).find('.recent-zip'); // 우편번호
	var addr = $($(obj).children('.order-addr')).find('.recent-addr'); // 주소
	var daddr = $($(obj).children('.order-addr')).find('.recent-daddr'); // 상세 주소
	var memo = $($(obj).children('.order-select')).find('.recent-memo'); // 메모
	var pkNo = $($(obj).children('.recent-pk')).val(); // 주문 번호
	var path = $($(obj).children('.recent-curpath')).val(); // 사용처 구분

	rctInfoMap.set("nm",Name.text());
	rctInfoMap.set("mbltelno",MblTelno.text());
	rctInfoMap.set("telno",Telno.val());
	rctInfoMap.set("zip",zip.text());
	rctInfoMap.set("addr",addr.text());
	rctInfoMap.set("daddr",daddr.text());
	rctInfoMap.set("memo",memo.val());
	rctInfoMap.set("pkNo",pkNo);
	rctInfoMap.set("path",path);

	return rctInfoMap;

}

//param : field  map
function f_dlvyRraw(paramMap){

	if(paramMap.get("path").indexOf("/mypage") > 0){
		$.ajax({
			type : "post",
			url  : "/comm/dlvy/updDlvyBySelect.json",
			data : { ordrDlvyCd : paramMap.get("pkNo")
						, path : paramMap.get("path")
						, nm : paramMap.get("nm")
						, mbltelno : paramMap.get("mbltelno")
						, telno : paramMap.get("telno")
						, zip : paramMap.get("zip")
						, addr : paramMap.get("addr")
						, daddr : paramMap.get("daddr")
						, memo : paramMap.get("memo")},
			dataType : 'json'
		})
		.done(function(data) {
    			if(data.result == true){
    				location.reload();
    			}else{
    				alert('배송지 업데이트에 실패하였습니다. ');
    			}
    	})
		.fail(function(data, status, err) {
			alert('배송지 업데이트에 실패하였습니다. ');
		});
	}else{

		$("#recptrNm").val(paramMap.get("nm"))
		$("#recptrMblTelno").val(paramMap.get("mbltelno"))
		$("#recptrTelno").val(paramMap.get("telno"))
		$("#recptrZip").val(paramMap.get("zip"))
		$("#recptrAddr").val(paramMap.get("addr"))
		$("#recptrDaddr").val(paramMap.get("daddr"))

		if(paramMap.get("memo") == '문 앞에 놓아주세요' || paramMap.get("memo") == '직접 받겠습니다(부재시 문 앞)' || paramMap.get("memo") == '경비실에 보관해 주세요' || paramMap.get("memo") == '택배함에 넣어주세요'){
			$("#ordrrMemo").hide();
			$("#selMemo").val(paramMap.get("memo"));
		}else{
			if(paramMap.get("memo") != null){
				$("#selMemo").val("직접입력");
				$("#ordrrMemo").val(paramMap.get("memo"));
				$("#ordrrMemo").show();
			}else{
				$("#selMemo").val("");
				$("#ordrrMemo").hide();
			}

		}

	}
	$("#hide-btn").click();

}


// 쿠키 생성
function setCookie(cName, cValue, cDay){
    var expire = new Date();
    expire.setDate(expire.getDate() + cDay);
    cookies = cName + '=' + escape(cValue) + '; path=/ ';
    if(typeof cDay != 'undefined') cookies += ';expires=' + expire.toGMTString() + ';';
    document.cookie = cookies;
}

// 쿠키 가져오기
function getCookie(cName) {
    cName = cName + '=';
    var cookieData = document.cookie;
    var start = cookieData.indexOf(cName);
    var cValue = '';
    if(start != -1){
        start += cName.length;
        var end = cookieData.indexOf(';', start);
        if(end == -1)end = cookieData.length;
        cValue = cookieData.substring(start, end);
    }
    return unescape(cValue);
}