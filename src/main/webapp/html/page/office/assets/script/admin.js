//DataTables lang
var dt_lang = {
    'decimal'        : '',
    'emptyTable'     : '검색조건을 선택 하신 후, 검색해 주세요.',
    'info'           : '총 <strong>_END_</strong>건, <strong>_PAGE_</strong>/_PAGES_ 페이지',
    'infoEmpty'      : '총 0건',
    "infoFiltered"   : '(전체 _MAX_건 중 검색결과)',
    'thousands'      : ',',
    'lengthMenu'     : '출력_MENU_',
    'loadingRecords' : '로딩중',
    'processing'     : '처리중',
    'search'         : '검색 ',
    'zeroRecords'    : '검색조건을 만족하는 결과가 없습니다.',
    'aria'           : {
        'sortAscending'  : '오름차순',
        'sortDescending' : '내림차순'
    },
    'paginate' : {
        'previous' : '이전',
        'next'     : '다음',
        'first'    : '처음',
        'last'     : '마지막'
    }
};

	//주소검색 DAUM API
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

	//좌표검색 DAUM API : (주소, lat, lot)
	function f_findGeocode(data, lat, lot) {
		const address = data.address;
		$.getScript('//dapi.kakao.com/v2/maps/sdk.js?appkey=84e3b82c817022c5d060e45c97dbb61f&autoload=false&libraries=services', function() {
			daum.maps.load(function() {
				const geocoder = new daum.maps.services.Geocoder();
				geocoder.addressSearch(address, function(result, status) {
					if(status === daum.maps.services.Status.OK){
	 					console.log({ lat: result[0].y, lot: result[0].x })
		               	$("#"+lat).val(result[0].y);
		               	$("#"+lot).val(result[0].x);
					}
				});
			});
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
}

$(function() {
    $('a[class*="menu-item"][href*="list-items"]').on('click', function(e) {
        $(this).addClass('active').parent().siblings().find('a').removeClass('active');
        $($(this).attr('href')).addClass('active').siblings('.list-items').removeClass('active');
        return false;
    });

    $('[data-bs-toggle="inner-modal"]').on('click', function(e) {
        $($(this).attr('data-bs-target')).show(0).addClass('show');
        return false;
    })

    $('.modal-inner [data-bs-dismiss]').on('click', function(e) {
        $(this).closest('.modal').removeClass('show').delay(100).hide(0);
        return false;
    });

    $('.modal-inner').on('click', function(e) {
        if(e.target === this) $(this).closest('.modal').removeClass('show').delay(100).hide(0);
    })

    //breadcrumb clock
	var clock = setInterval(function(){
		const time = new Date();
		const hour = time.getHours();
		const minutes = time.getMinutes();
		const seconds = time.getSeconds();
		$('.user-info > span.name span').text(`${hour<10 ? `0${hour}`:hour}:${minutes<10 ? `0${minutes}`:minutes}:${seconds<10 ? `0${seconds}`:seconds}`);
	}, 1000);

	$.validator.setDefaults({
		onfocusout: false,
	   	errorElement: 'p',
		errorPlacement: function(error, element) {
		    var group = element.closest('.form-check-group, .form-group');
		    if (group.length) {
		        group.after(error.addClass('text'));
		        error.wrap('<div class="alert alert-danger fade show invalid-feedback"></div>').before('<p class="moji">:(</p>')
		        		.after('<button type="button" data-bs-dismiss="alert" aria-label="close">닫기</button>');
		    } else {
		        element.after(error.addClass('text'));
		        error.wrap('<div class="alert alert-danger fade show invalid-feedback"></div>').before('<p class="moji">:(</p>')
		        		.after('<button type="button" data-bs-dismiss="alert" aria-label="close">닫기</button>');
		    }
		},
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

	$.validator.addMethod("regex", function(value, element, regexpr) {
		if(value != null){
	    	return regexpr.test(value);
		}
	}, "형식이 올바르지 않습니다.");


	/* rowspan function */
	$.fn.mergeClassRowspan = function (colIdx) {
	    return this.each(function () {
	        var that;
	        $('tr', this).each(function (row) {
	            //$('td:eq(' + colIdx + ')', this).filter(':visible').each(function (col) {
	            $('td:eq(' + colIdx + ')', this).each(function (col) {
	                if ($(this).attr('class') == $(that).attr('class')) {
	                    rowspan = $(that).attr("rowspan") || 1;
	                    rowspan = Number(rowspan) + 1;
	                    $(that).attr("rowspan", rowspan);
	                    $(this).hide();
	                } else {
	                    that = this;
	                }

	                that = (that == null) ? this : that;
	            });
	        });
	    });
	};

	// 페이지 > 출력 갯수
    $("#countPerPage").on("change", function(){
		var cntperpage = $("#countPerPage option:selected").val();
		$("#cntPerPage").val(cntperpage);
		$("#searchFrm").submit();
	});
})


//동적생성도 대응할수 있게 document ready
$(document)
	.on('keyup','.numbercheck',function(){/** 숫자입력만 가능하게 */
		$(this).val( $(this).val().replace(/[^0-9]/gi,"") );
	});

// 배열에서 특정값 삭제
function arrayRemove(arr, value) {
    return arr.filter(function(ele){
        return ele != value;
    });
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
