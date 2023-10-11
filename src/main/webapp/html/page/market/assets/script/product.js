$(function() {
    //상품 상세 사이드메뉴 fixed
    var productFixed = function() {
        if($('.product-detail-infomation').length > 0) {
            if(Math.round($('.product-detail-infomation').find('.product-payment').get(0).getBoundingClientRect().top) <= 100) {
                $('.product-detail-infomation').addClass('is-fixed');
            } else {
                $('.product-detail-infomation').removeClass('is-fixed');
            }
        }
    }

    productFixed();

    $(window).on('load resize scroll', productFixed);

    //상품 목록 마우스 오버
    $('.product-item .item-layer').on('mouseenter', function() {
        $(this).closest('.product-item').addClass('is-hover');
    }).on('mouseleave', function() {
        $(this).closest('.product-item').removeClass('is-hover');
    });

    //공용 옵션박스
    $('.product-option .option-toggle').on('click', function() {
        $(this).closest('.product-option').toggleClass('is-active');
    })

    //상품 목록 더보기
    var cateResize = function() {
        var cateItem = $('.product-category a');
        var cateMore = $('.category-moreview');

        if($(window).outerWidth() < 768) {
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
    };

    cateResize();

    $(window).on('load resize', cateResize);

    //상품 상세 scrollspy
    $(window).on('load resize', function() {
        if($('#prod-tablist').length > 0) {
            $('body').scrollspy('dispose');
            $('body').attr('data-bs-target', '#prod-tablist').attr('data-bs-offset', 100).scrollspy({target: '#prod-tablist', offset: 100});
        }
    }).on('scroll', function() {
        if($('#prod-tablist').length > 0) {
            if($('#prod-tablist a.active').length === 0) $('#prod-tablist a:eq(0)').addClass('active');
        }
    });

    //상품 상세 슬라이더
    var productSwiperThumb = new Swiper('.product-slider .product-swiper-thumb', {
        slidesPerView: 'auto',
        spaceBetween: 6,
        breakpoints: {
            768: {
                spaceBetween: 10,
            }
        },
        watchSlidesProgress: true
    });
    var productSwiper = new Swiper('.product-slider .product-swiper', {
        loop: false,
        navigation: {
            nextEl: '.swiper-button-next',
            prevEl: '.swiper-button-prev',
        },
        thumbs: {
            swiper: productSwiperThumb,
        }
    });
    var goodsSwiper = new Swiper('.product-relgood .product-swiper', {
        loop: false,
        slidesPerView: 4,
        spaceBetween: 16,
        watchSlidesProgress: true,
        observer: true,
        observeParents: true,
        breakpoints: {
            0: {
                slidesPerView: 2,
                spaceBetween: 12,
            },
            768: {
                slidesPerView: 3,
                spaceBetween: 16,
            },
            1024: {
                slidesPerView: 4,
                spaceBetween: 20,
            }
        },
        pagination: {
            clickable: true,
            el: ".swiper-pagination",
        },
        on: {
            resize: function() {
                if(this.slides.length > this.params.slidesPerView) {
                    $('.product-relgood .swiper-button-prev, .product-relgood .swiper-button-next').show();
                } else {
                    $('.product-relgood .swiper-button-prev, .product-relgood .swiper-button-next').hide();
                }
            }
        }
    });

    $('.product-relgood .swiper-button-prev').on('click', function() {
        goodsSwiper.slidePrev();
    });

    $('.product-relgood .swiper-button-next').on('click', function() {
        goodsSwiper.slideNext();
    });

    //상품 상세 펼쳐보기
    $('.product-iteminfo .btn').on('click', function() {
        $(this).parent().toggleClass('is-active');
        $(this).text(($(this).text() === '상품 상세 펼쳐보기') ? '상품 상세 접기' : '상품 상세 펼쳐보기');
    });

    //상품 상세 문의 펼쳐보기
    $('.product-qnaitem .answer .btn').on('click', function() {
        $(this).closest('.product-qnaitem').toggleClass('is-active');
    });

    //상품 구매
    $('.payment-type-select input').on('click change', function() {
        $('.payment-type-select input').each(function() {
            $($(this).attr('data-target')).removeClass('is-active');
        });

        $($(this).attr('data-target')).addClass('is-active');

        if($(window).outerWidth() < 1041) {
            $(this).closest('.product-payment').addClass('is-active');
            $('body').addClass('overflow-hidden');
        }
    });

    $('.payment-toggle').click(function() {
        $(this).closest('.product-payment').removeClass('is-active');
    })

    //상품 사업소 선택
    $('.product-partners-layer .product-partners').on('click', function() {
        if($(this).hasClass('is-active')) {
            $(this).removeClass('is-active').find('.partners-select input').prop('checked', false);
            $(this).siblings('.product-partners').each(function() {
                $(this).removeClass('is-disable is-active').find('.partners-select input').prop('checked', false);
            });
        } else {
            $(this).removeClass('is-disable').addClass('is-active').find('.partners-select input').prop('checked', true);
            $(this).siblings('.product-partners').each(function() {
                $(this).removeClass('is-active').addClass('is-disable').find('.partners-select input').prop('checked', false);
            });
        }
    });

	$(document).on("click", ".f_compare", function(e){
		e.stopPropagation();
        e.preventDefault();

		let gdsNo = $(this).data("gdsNo");
		let gdsCd = $(this).data("gdsCd");
		let gdsCtgryNo = $(this).data("ctgryNo");
		let gdsFile = $(this).data("gdsFile");
		let gdsInfo = gdsNo+"|"+gdsCd+"|"+gdsFile;
		let compareGds = getCookie("compareGds");
		if(compareGds == ""){
			compareGds = gdsCtgryNo + "__" + gdsInfo;
			setCookie("compareGds", compareGds, 1);
			f_compareSet();
		}else{
			let spCompareGds = compareGds.split("__");
			if(spCompareGds[0] == gdsCtgryNo){
				if(compareGds.indexOf(gdsInfo) > -1){
					//console.log("@@@ 같은 상품", gdsInfo, compareGds);
				}else{
					if(spCompareGds.length > 4){
            			alert("상품비교는 4개까지 가능합니다.")
        			}else{
            			compareGds = compareGds + "__" + gdsInfo;
            			setCookie("compareGds", compareGds, 1);
            			f_compareSet();
        			}
				}
			}else{
				alert("상품비교는 동일 카테고리만 가능합니다.");
				//console.log("@@@ 다른 카테고리");
			}
		}
		//console.log("compareGds: ", compareGds);
	});
	f_compareSet();

	// 삭제버튼
	$(document).on("click", ".service-compare-items button, button.f_compare_item_del", function(){
		//console.log($(this).data("gdsInfo"));
		let gdsInfo = $(this).data("gdsInfo");
		let compareGds = getCookie("compareGds");
			compareGds = compareGds.replace("__"+gdsInfo, "");

		//console.log(compareGds.split("__").length);
		if(compareGds.split("__").length < 2 ){
			compareGds = "";
			$('.service-compare-toggle, .service-compare-layer').removeClass('is-active');
		}
		setCookie("compareGds", compareGds, 1);
		f_compareSet();
		if($('.service-compare-layer').hasClass("is-active")){
			f_compareCall();
		}
	});

	// 위시리스트
	$(document).on("click", ".f_wish", function(e){
        e.stopPropagation();
        e.preventDefault();

		let obj = $(this);
		let gdsNo = $(this).data("gdsNo");
		let wishYn = $(this).data("wishYn");

		$.ajax({
			type : "post",
			url  : "/market/mypage/wish/putWish.json",
			data : {gdsNo:gdsNo, wishYn:wishYn},
			dataType : 'json'
		})
		.done(function(data) {
			if(data.result){
				if(data.resultMsg == "PUT"){
					obj.data("wishYn", "Y").addClass("is-active");
					$('.service-interest i, .personal-cart .interest').text(Number($('.service-interest i').text()) + 1);
				}else if(data.resultMsg == "REMOVE"){
					obj.data("wishYn", "N").removeClass("is-active");
					$('.service-interest i, .personal-cart .interest').text(Number($('.service-interest i').text()) - 1);
				}
			}
		})
		.fail(function(data, status, err) {
			console.log('위시리스트 저장/삭제 작업에 실패하였습니다. : ' + data);
		});

	});

});


function f_compareCall(){
	let compareGds = getCookie("compareGds");
	if(compareGds != ""){
    	let spCompareGds = compareGds.split("__");
    	let ctgryNo = spCompareGds[0];
    	let gdsCds = [];
    	for(var i=1;i<spCompareGds.length;i++){
    		var spGdsInfo = spCompareGds[i].split("|");
    		gdsCds.push(spGdsInfo[1]);
    	}
		$(".service-compare-layer").load(
   			"/market/gds/compare"
   			, {ctgryNo:ctgryNo, gdsCds:gdsCds}
   			, function(data, status, xhr){
   				if(status == "success"){
   					$('.service-compare-toggle, .service-compare-layer').addClass('is-active');
   				}
   			}
   		);
	}else{
		console.log("비교상품 없음");
	}
}

function f_compareSet(){
	let compareGds = getCookie("compareGds");
    $('.service-compare .container .service-compare-items').remove();
	if(compareGds != ""){
    	let spCompareGds = compareGds.split("__");
		$('.service-compare .container').append('<ul class="service-compare-items"></ul>');
		for(var i=1;i<spCompareGds.length;i++){
			var spGdsInfo = spCompareGds[i].split("|");
			var imgSrc = '<img src="/comm/getImage?srvcId=GDS&amp;upNo='+ spGdsInfo[0] +'&amp;fileTy=THUMB&amp;fileNo='+ spGdsInfo[2] +'&amp;thumbYn=Y" alt="">';
			$('.service-compare .container .service-compare-items').append('<li>'+ imgSrc +'<button type="button" data-gds-info="'+ spCompareGds[i]+'">닫기</button></li>');
			$("button.f_compare[data-gds-cd='"+ spGdsInfo[1] +"']").addClass("is-active");
		}
	}

}