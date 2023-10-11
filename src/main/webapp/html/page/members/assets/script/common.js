var timer   = null;
var winSize = null;
var resize  = false;

// 주소검색 DAUM API
function f_findAdres(zip, addr, daddr, lat, lot) {
	$.ajaxSetup({ cache: true });
	$.getScript( "//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js", function() {
		$.ajaxSetup({ cache: false });
		
		// 우편번호 찾기 화면을 넣을 element
		var element_layer = document.getElementById('addrModal-contents');
		var width = 500;
		if (window.screen.width < 500) {
			width = 300;
		}
		
		if(!element_layer) {
			var addrModalTemplate = `
				<div id="addrModal" style="position:absolute; width:100%; height:100%; background:rgba(0,0,0,8); top:0; left:0; z-index: 2000; display:none;">
					<div id="addrModal-contents" style="width:${width}px; height:500px; background:#fff; border-radius:10px; position:relative; top:30%; left:50%; margin-top:-100px; transform: translateX(-50%); text-align:center; box-sizing:border-box; padding:10px 0; line-height:23px; cursor:pointer;">
						<button id="addrModalClose" type="button" style="float:right; margin-right: 10px; border: 1px solid lightgray; padding: 5px; border-radius: 5px;">닫기</button>
					</div>
				</div>
			`;
			document.getElementById('container').insertAdjacentHTML('beforebegin', addrModalTemplate);
			
			element_layer = document.getElementById('addrModal-contents');
			
			//닫기 이벤트
			$("#addrModalClose").on("click", function() {
				$('#addrModal').fadeOut();
	    		$('#container').css({"display": "block"});
			});
		}
		
		var daumLayer = document.getElementById('__daum__layer_1');
		if(!daumLayer) {
			//다음 주소검색 추가
			new daum.Postcode({
				width,
				oncomplete: function(data) {
					$("#"+zip).val(data.zonecode); // 우편번호
					$("#"+addr).val(data.roadAddress); // 도로명 주소 변수
		
					if(lat != undefined && lot != undefined){
						f_findGeocode(data, lat, lot); //좌표
					}
				
					$('#addrModal').fadeOut();
		    		$('#container').css({"display": "block"});
		    		
		    		$("#"+daddr).focus(); //포커스
		        }
		    }).embed(element_layer);
		}
		
	    $('#addrModal').fadeIn();
	    $('#container').css({"display": "none"});
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

// 전화번호 마스킹
const autoHyphen = (target) => {
 target.value = target.value
   .replace(/[^0-9]/g, '')
   .replace(/^(\d{2,3})(\d{3,4})(\d{4})$/, `$1-$2-$3`);
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


$(function() {
    $(window).on('scroll load', function() {
        if($(window).scrollTop() > $(window).outerHeight() * 0.75) {
            $('#quick').addClass('is-active');
        } else {
            $('#quick').removeClass('is-active');
        }

        if($(this).scrollTop() > $('#header').outerHeight()) {
            $('body').addClass('is-scroll');
        } else {
            $('body').removeClass('is-scroll');
        }
    });

    $(window).on('load scroll resize', function(e) {
        resize  = (winSize !== null && $(window).outerWidth() === winSize[0]) ? false : true;
        winSize = [$(window).outerWidth(), $(window).outerHeight()];
	});

    //퀵메뉴 닫기
    $('#quick .moveTop').on('click', function() {
        $(window).scrollTop(0);
    });

    //공용 옵션박스
    $('.product-option .option-toggle').on('click', function() {
        $(this).closest('.product-option').toggleClass('is-active');
    });

    // 정규식 체크
	$.validator.addMethod("regex", function(value, element, regexpr) {
		if(value != ''){
			return regexpr.test(value)
		}else{
			return true;
		}
	}, "형식이 올바르지 않습니다.");

	//발리데이션 디폴트
	$.validator.setDefaults({
		onfocusout: false,
	   	errorElement: 'div',
		success: function(label){
			label.closest(".is-invalid").remove();
		},
		highlight:function(element, errorClass, validClass) {
		    $(element).addClass('is-invalid');
		},
		unhighlight:function(element, errorClass, validClass) {
		    $(element).removeClass('is-invalid');
		},
	});

	// numbercheck(클래스명)으로 숫자 정규식 체크
	$(document)
		.on('keyup','.numbercheck',function(){/** 숫자입력만 가능하게 */
			$(this).val( $(this).val().replace(/[^0-9]/gi,"") );
	});


});

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