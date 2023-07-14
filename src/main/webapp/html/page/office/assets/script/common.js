
// 전화번호 마스킹
const autoHyphen = (target) => {
 target.value = target.value
   .replace(/[^0-9]/g, '')
   .replace(/^(\d{2,3})(\d{3,4})(\d{4})$/, `$1-$2-$3`);
}

//첨부파일 이미지 제한
function f_fileCheck(obj) {

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
    var header  = $('#header');
    var slider  = $('#navigation');
    var winSize = [$(window).outerWidth(), $(window).outerHeight()];
    var isDown  = false;
    var startX;
    var scrollLeft;
    var timer  = null;

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

    //퀵메뉴 닫기
    $('#quick .moveTop').on('click', function() {
        $(window).scrollTop(0);
    });

      //상품 목록 더보기
    $(window).on('load resize', function() {
        var cateItem = $('.product-category a');
        var cateMore = $('.category-moreview');

        if(winSize[0] < 576) {
            if(cateItem.length < 9) {
                cateItem.addClass('is-visible');
            } else {
                cateItem.each(function(i) {
                    if(i < 7) $(this).addClass('is-visible');
                })
                cateMore.addClass('is-visible');
            }
        } else {
            cateItem.removeClass('is-visible');
            cateMore.removeClass('is-visible');
        }

        cateMore.off('click').on('click', function() {
            var cateWrap = $(this).closest('dd');
            if(cateWrap.hasClass('is-expand')) {
                cateWrap.removeClass('is-expand').find('a').each(function(i) {
                    if(i > 6) {
                        $(this).removeClass('is-visible');
                    }
                });
            } else {
                cateWrap.addClass('is-expand').find('a').addClass('is-visible');
            }
        });
    });

    $(window).on('scroll load', function() {
        if($(window).scrollTop() > $(window).outerHeight() * 0.75) {
            $('#quick').addClass('is-active');
        } else {
            $('#quick').removeClass('is-active');
        }
    });

    //mobile introduce
    $('#header .logo a').on('click', function(e) {
        if($(window).outerWidth() < 1281) {
            if(header.hasClass('active')) {
                header.removeClass('active');
                $('html').removeClass('overflow-hidden');
            } else {
                header.addClass('active');
                $('html').addClass('overflow-hidden');
            }
            return false;
        }

        winSize = [$(window).outerWidth(), $(window).outerHeight()];
    });

    $('#header .infomation-close').on('click', function(e) {
        header.removeClass('active');
        $('html').removeClass('overflow-hidden');
    });

    $('.form-upload .btn-primary input[type="file"]').on('change', function() {
        $(this).parent().prev().val($(this).val().split('\\').pop());
    });

    $(window).on('load resize', function() {
        header.removeClass('active');
        $('html').removeClass('overflow-hidden');
    });


	$.validator.setDefaults({
		onfocusout: false,
   		errorElement: 'p',
		errorPlacement: function(error, element) {
		    var group = element.closest('.form-group');
		    if (group.length) {
		        group.after(error.addClass('form-desc'));
		    } else {
		        element.after(error.addClass('form-desc'));
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
		    $(element).addClass('is-valid');
		},
	});

	$.validator.addMethod("regex", function(value, element, regexpr) {
		if(value != ''){
	    	return regexpr.test(value);
		}else{
			return true;
		}
	}, "형식이 올바르지 않습니다.");

	// 출력 개수
    $("#countPerPage").on("change", function(){
		var cntperpage = $("#countPerPage option:selected").val();
		$("#cntPerPage").val(cntperpage);
		$("#listFrm").submit();
	});

});