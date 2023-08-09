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

$(function() {
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

    //상단 네비 스크롤
    horizonScroll($('.navigation-submenu ul'));

	//상단 전체메뉴 이벤트
	$('#navigation .allmenu-toggle').on('click', function() {
		var navHeight = ($(window).outerWidth() > 1040) ? $(window).width() * 0.2604166666666667 : $(window).height() - ($('#navigation').height() + $('#navigation').get(0).getClientRects()[0].y + 1);

		$('.allmenu-list').height(navHeight).find('[class*="allmenu-group"]').height(navHeight);
		
		if($(window).outerWidth() < 1041) {
			$('[class*="allmenu-group"]').height(navHeight - 46);
			if($(this).hasClass('is-active')) {
				if(!$('#page-sidenav').hasClass('is-active')) $('body').removeClass('overflow-hidden');
			} else {
				$('body').addClass('overflow-hidden');
			}
		}

		$(this).toggleClass('is-active').next().toggleClass('is-active').find('*').removeClass('is-active');
	});

	$('[class*="allmenu-item"] a').on('mouseenter mouseleave click', function(e) {
		var el = $(this).parent();

		if(e.type === 'click' && $(window).outerWidth() < 1041) {
			if($(this).next('[class*="allmenu-group"]').length > 0) {
				if(!el.hasClass('is-active')) {
					el.addClass('is-active').find('> [class*="allmenu-group"]').addClass('is-active');
					el.siblings().removeClass('is-active').find('*').removeClass('is-active');
				} else {
					el.removeClass('is-active').find('> [class*="allmenu-group"]').removeClass('is-active');
				}
				return false;
			}
		} else if(e.type === 'mouseenter' && $(window).outerWidth() > 1040) {
			el.addClass('is-active').find('> [class*="allmenu-group"]').addClass('is-active');
			el.siblings().removeClass('is-active').find('*').removeClass('is-active');
		} else if(e.type === 'mouseleave' && $(window).outerWidth() > 1040) {
			if(!el.hasClass('is-depth')) el.removeClass('is-active');
		}
	});

	$('.allmenu-list').on('mouseleave', function(e) {
		if($(window).outerWidth() > 1040) {
			$(this).find('*').removeClass('is-active');
		}
	});

	$('[class*="allmenu-group"] > ul').on('mousemove', function(e) {
		if(e.target === $(this).get(0) && $(window).outerWidth() > 1040) {
			$(this).find('*').removeClass('is-active');
		}
	})

	$(document).on('click', function(e) {
		if($(window).outerWidth() > 1040 && $(e.target).closest('.navigation-allmenu').length === 0) {
			$('.navigation-allmenu *').removeClass('is-active');
		}
	})

	//통합검색
	$('.navigation-search .search-form input').on('focus', function() {
		$('.navigation-search .form-current').addClass('is-active');
	});

	$('.navigation-search .option-close').on('click', function() {
		$('.navigation-search *').removeClass('is-active');
	})

	$('.navigation-search .search-toggle').on('click', function() {
		var navHeight = ($(window).outerWidth() > 1040) ? $(window).width() * 0.2604166666666667 : $(window).height() - ($('#navigation').height() + $('#navigation').get(0).getClientRects()[0].y + 1);
		if($(window).outerWidth() < 1041) {
			$('.search-form').height(navHeight);
			if($(this).hasClass('is-active')) {
				if(!$('#page-sidenav').hasClass('is-active')) $('body').removeClass('overflow-hidden');
			} else {
				$('body').addClass('overflow-hidden');
			}
		}
		$(this).toggleClass('is-active').next('.search-form').toggleClass('is-active');
	});

    //사이드 메뉴 토글
    $('#page-sidenav-toggle').on('click', function() {
        var layer   = $('#page-sidenav');
        var button  = $('#page-sidenav-toggle');
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
				if(!$('#container').hasClass('is-mypage')) {
					$(window).scrollTop($(window).scrollTop() + pheader.get(0).getBoundingClientRect().top - ($('#navigation').outerHeight()));
					setTimeout(() => {
						body.addClass('overflow-hidden');
						button.addClass('is-active');
						layer.css({'top': pheader.get(0).getBoundingClientRect().top + pheader.outerHeight()}).addClass('is-animate').addClass('is-active');
					}, 500);
				} else {
					body.addClass('overflow-hidden');
					layer.addClass('is-animate').addClass('is-active');
				}
            } else {
                body.addClass('overflow-hidden');
                button.addClass('is-active');
                layer.css({'top': pheader.get(0).getBoundingClientRect().top + pheader.outerHeight()}).addClass('is-animate').addClass('is-active');
            }
        }
    });

    $('#page-sidenav').on('click', function(e) {
        var layer  = $('#page-sidenav');
        var button = $('#page-sidenav-toggle');
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

	//마이페이지용 사이드메뉴 헤더 토글
	$('.page-sidenav-header .header-close, .global-user .user-toggle').on('click', function() {
        var layer  = $('#page-sidenav');
        var button = $('#page-sidenav-toggle');
        var body   = $('body');
		
        layer.one('transitionend webkitTransitionEnd oTransitionEnd', function() {
            $(this).removeClass('is-animate');
        });

		body.toggleClass('overflow-hidden');
		button.toggleClass('is-active');
		layer.addClass('is-animate').toggleClass('is-active');
	})

    //퀵메뉴
    $('#quick .moveTop').on('click', function() {
        $(window).scrollTop(0);
    });

    // 팝업 닫기
    $(".cls-popup-btn").on("click",function(){
    	var popNo = $(this).data("popNo");
    	$(".view"+popNo).removeClass("is-active");

    	var id = $(this).data("oneHide");
		
    	if($("#"+id).is(":checked")){
			$.cookie("popup"+popNo,"none",{expires:1, path:"/"});
		}
    });

    //resize
    $(window).on('load scroll resize', function(e) {
        resize  = (winSize !== null && $(window).outerWidth() === winSize[0]) ? false : true;
        winSize = [$(window).outerWidth(), $(window).outerHeight()];
		
		if($(window).scrollTop() > $('#header').outerHeight() - ($('#navigation').outerHeight() + 3)) {
			$('body').addClass('is-scroll');
		} else {
			$('body').removeClass('is-scroll');
		}

        if($(window).scrollTop() > $(window).outerHeight() * 0.75) {
            $('#quick').addClass('is-active');
        } else {
            $('#quick').removeClass('is-active');
        }

		var navHeight = ($(window).outerWidth() > 1040) ? $(window).width() * 0.2604166666666667 : $(window).height() - ($('#navigation').height() + $('#navigation').get(0).getClientRects()[0].y + 1);

		$('.allmenu-list, .search-form').height(navHeight).find('[class*="allmenu-group"]').height(navHeight);

		if($(window).outerWidth() < 1041) {
			$('[class*="allmenu-group"]').height(navHeight - 46);
		}

		if(e.type !== 'scroll') {
			clearTimeout(timer);
	
			timer = setTimeout(function() {
				if(resize) {
					$('body').removeClass('overflow-hidden');
					$('#page-sidenav, #page-sidenav-toggle, .navigation-allmenu *, .navigation-search *').removeClass('is-active').removeAttr('style');
				}
			}, 5);
		}
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