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
    $('.product-option .option-toggle').on('click', function() {
        $(this).closest('.product-option').toggleClass('is-active');
    })

    
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

    //개인화 레이어
    var personal       = $('.personal-info').parent();
    var personalbox    = $('.personal-info');
    var personalBody   = personal.find('.personal-detail');
    var personalLayer  = personal.find('.personal-layer');
    var personalLayer2 = personal.find('.personal-layer2');
    var personaltoggle = personal.find('.personal-toggle');
    var personalfcart  = personal.find('.personal-famcart');

    if(personal.attr('id') === 'personal') {
        personal.addClass('is-active').css({'margin-left' : -(personal.outerWidth()/2)});
    }

    personalBody.find('.personal-famlink').on('click', function() {
        if(personal.attr('id') === 'personal') {
            $('body').addClass('overflow-hidden');
            personalBody.removeClass('is-active').filter('.personal-onlink').addClass('is-active');
            personalLayer.addClass('is-active');
            personalLayer2.removeClass('is-active');
            personalbox.removeClass('is-noshadow');
            personal.addClass('is-active').css({'margin-left' : -(personal.outerWidth()/2)});
        }
        
        if(personal.attr('id') === 'page-personal') {
            // var scrollTop =  $('#page-title').get(0).getBoundingClientRect().top - $('#header').outerHeight();
            var scrollTop = personal.get(0).getBoundingClientRect().top - $('#header').outerHeight();
            var topSize   = personal.get(0).getBoundingClientRect().top + personal.outerHeight() + 8;
            
            if(scrollTop !== 0) {
                $(window).scrollTop($(window).scrollTop() + scrollTop);
                setTimeout(function() {
                    topSize = personal.get(0).getBoundingClientRect().top + personal.outerHeight() + 8;
                    
                    $('body').addClass('overflow-hidden');
                    personalBody.removeClass('is-active').filter('.personal-onlink').addClass('is-active');
                    personalLayer.css({'top': topSize}).addClass('is-active');
                    personalLayer2.removeClass('is-active');
                    personalbox.removeClass('is-noshadow');
                }, 500);
            }
            
            if(scrollTop == 0) {
                $('body').addClass('overflow-hidden');
                personalBody.removeClass('is-active').filter('.personal-onlink').addClass('is-active');
                personalLayer.css({'top': topSize}).addClass('is-active');
                personalLayer2.removeClass('is-active');      
                personalbox.removeClass('is-noshadow');  
            }
        }
    });

    personalfcart.on('click', function() {
        if(personal.attr('id') === 'personal') {
            $('body').addClass('overflow-hidden');
            personalLayer2.addClass('is-active');
            personalbox.addClass('is-noshadow');
        }

        if(personal.attr('id') === 'page-personal') {
            // var scrollTop =  $('#page-title').get(0).getBoundingClientRect().top - $('#header').outerHeight();
            var scrollTop = personal.get(0).getBoundingClientRect().top - $('#header').outerHeight();
            var topSize   = personal.get(0).getBoundingClientRect().top + (personal.outerHeight() * 0.55);
            
            if(scrollTop !== 0) {
                $(window).scrollTop($(window).scrollTop() + scrollTop);
                setTimeout(function() {
                    topSize = personal.get(0).getBoundingClientRect().top + (personal.outerHeight()/2);
                    
                    $('body').addClass('overflow-hidden');
                    personalBody.removeClass('is-active').filter('.personal-onbase').addClass('is-active');
                    personalLayer.removeClass('is-active');
                    personalLayer2.css({'top': topSize}).addClass('is-active');
                    personalbox.addClass('is-noshadow');
                }, 500);
            }
            
            if(scrollTop == 0) {
                $('body').addClass('overflow-hidden');
                personalBody.removeClass('is-active').filter('.personal-onbase').addClass('is-active');
                personalLayer.removeClass('is-active');
                personalLayer2.css({'top': topSize}).addClass('is-active');
                personalbox.addClass('is-noshadow');
            }
        }
    })

    personaltoggle.on('click', function() {
        if(personal.attr('id') === 'personal') {
            var targetH = $('#header').outerHeight(true) + $('#navigation').outerHeight(true) + $('#service').outerHeight(true);
            if($(window).scrollTop() >= targetH) {
                $(window).scrollTop(0);
            } else {
                $('body').removeClass('overflow-hidden');
                personal.removeClass('is-active');
                personalLayer.removeClass('is-active');
            }
        }
        return false;
    });

    personalLayer.find('.modal-title button').on('click', function() {
        $('body').removeClass('overflow-hidden');
        personalBody.removeClass('is-active').filter('.personal-onbase').addClass('is-active');
        personalLayer.removeClass('is-active');

        if(personal.attr('id') === 'personal') {
            personal.addClass('is-active').css({'margin-left' : -(personal.outerWidth()/2)});
        }
    });

    personalLayer.find('.modal-footer .link1').on('click', function() {
        personalLayer.find('.modal-item .input').prop('checked', false);
        return false;
    });

    personalLayer2.find('.modal-footer .btn-outline-primary').on('click', function() {
        $('body').removeClass('overflow-hidden');
        personalLayer2.removeClass('is-active');
        personalbox.removeClass('is-noshadow');
    });

    $(window).on('scroll', function() {
        if(personal.attr('id') === 'personal') {
            var targetH = $('#header').outerHeight(true) + $('#navigation').outerHeight(true) + $('#service').outerHeight(true);        ;
            if($(this).scrollTop() >= targetH) {
                personalBody.removeClass('is-active').filter('.personal-oncart').addClass('is-active');
            } else {
                personalBody.removeClass('is-active').filter('.personal-onbase').addClass('is-active');
            }

            personal.addClass('is-active').css({'margin-left' : -(personal.outerWidth()/2)});
        }
    });
    
    $(window).on('load resize', function() {
        personalBody.removeClass('is-active').filter('.personal-onbase').addClass('is-active');
        personalLayer.removeClass('is-active');
        personalLayer2.removeClass('is-active');
        personalbox.removeClass('is-noshadow');
        
        if(personal.attr('id') === 'personal') {
            personal.addClass('is-active').css({'margin-left' : -(personal.outerWidth()/2)});
        }
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

            //상단 네비 폴딩 정렬
            // if($('.navigation-menu').hasClass('is-hidden')) {
            //     var mSpace = 0;
            //     $('.navigation-menu li').each(function() {
            //         mSpace = mSpace + $(this).outerWidth(true);
            //         if($(this).hasClass('seperate')) {
            //             return false;
            //         }
            //     })
            //     $('.navigation-menu').find('ul').css({'margin-left' : -mSpace});
            // }
        }, 5);
    });
});