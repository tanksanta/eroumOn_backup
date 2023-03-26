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

$(function() {

	//마일리지, 포인트 회원 리스트 모달
	$(".listModalBtn").on("click",function(){
		var path = $(this).data("curPath");

		if(path.indexOf('/point') > 0){
			var mngNo = $(this).data("pointNo");
			//포인트 대상 리스트
			$("#listView").load("/_mng/promotion/point/searchTargetList.json"
			, {pointMngNo : mngNo}
			, function(){
       		$("#targetListModal").addClass('fade').modal('show');
			});
		}else{
			var mlgNo = $(this).data("mlgNo");
			console.log(mlgNo);
			//마일리지 대상 리스트
			$("#listView").load("/_mng/promotion/mlgMng/searchTargetList.json"
				, {mlgMngNo : mlgNo}
				, function(){
	       		$("#targetListModal").addClass('fade').modal('show');
				});
			}

	});

	//dashboard menu
    $('.dashboard-menu').on('click', function(e) {
        $(this).next('.dashboard-menu-layer').toggleClass('is-active');
    })

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

	// 페이지 > 출력 갯수
    $("#countPerPage").on("change", function(){
		var cntperpage = $("#countPerPage option:selected").val();
		$("#cntPerPage").val(cntperpage);
		$("#searchFrm").submit();
	});


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


	// validator add
	// 정규식 체크
	$.validator.addMethod("regex", function(value, element, regexpr) {
		if(value != ''){
			return regexpr.test(value)
		}else{
			return true;
		}
	}, "{0}");

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

	// 쿠폰, 포인트, 마일리지 선택 삭제
	$(document).on("click", "input[name='mbrChkBox']", function(){
		if($(this).is(":checked")){
			arrDelChk.push($(this).val());
		}
	});

	$(document).on("click", "#deleBtn", function(){
		var totalList = arrDelChk.length;

		for(var i=0; i<totalList; i++){
			$("."+arrDelChk[i]).remove();
		}
			arrDelChk = [];
			arrMbrChk = [];
	});

});

//동적생성도 대응할수 있게 document ready
$(document)
	.on('keyup','.numbercheck',function(){/** 숫자입력만 가능하게 */
			$(this).val( $(this).val().replace(/[^0-9]/gi,"") );
	}).on('focusout','.numbercheck',function(){
		if($(this).val().trim() == ""){
			$(this).val(0);
		}
	});


// 배열에서 특정값 삭제
function arrayRemove(arr, value) {
    return arr.filter(function(ele){
        return ele != value;
    });
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

// 오늘날짜 구하기
function f_getToday(){
	var date = new Date();
    var year = date.getFullYear();
    var month = ("0" + (1 + date.getMonth())).slice(-2);
    var day = ("0" + date.getDate()).slice(-2);

    return year + "-" + month + "-" + day;
}

// 전화번호 마스킹
const autoHyphen = (target) => {
	if(target.value.length > 8){
		target.value = target.value
   		.replace(/[^0-9]/g, '')
   		.replace(/^(\d{2,3})(\d{3,4})(\d{4})$/, `$1-$2-$3`);
	}else{
		target.value = target.value
   		.replace(/[^0-9]/g, '')
   		.replace(/^(\d{4})(\d{4})$/, `$1-$2`);
	}

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
// 숫자형 -> yyyy-MM-dd
function f_dateFormat(value){
console.log(value);
	var date = new Date(value);

	var yyyy = date.getFullYear();
	var mm = date.getMonth() + 1;
	mm = mm >= 10 ? mm : '0' + mm;
	var dd = date.getDate();
	dd = dd >= 10? dd: '0' + dd;
	return yyyy+'-'+mm+'-'+dd;
}
// 숫자형 -> yyyy-MM-dd HH:mm:ss
function f_dateTimeFormat(value){
	var date = new Date(value);
	return new Date(+date + 3240 * 10000).toISOString().replace("T"," ").replace(/\..*/, '');
}

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
