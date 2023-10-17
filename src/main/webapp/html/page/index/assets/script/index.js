var winSize = null;
var resize  = false;

$(function() {
    //공지 닫기
    $('.notice-close').on('click', function() {
        $(this).closest('aside').addClass('is-closed');
    });

    //퀵메뉴 닫기
    $('#quick .moveTop').on('click', function() {
        $(window).scrollTop(0);
    });

    //네비게이션
    $('#navigation').on('mouseleave', function() {
        $('#navigation, #navigation *').removeClass('is-hover');
    });

    $('#navigation a').on('mouseenter focus mouseleave focusout', function(e) {
        var navi   = $('#navigation');
        var target = $(this).parent();
        var parent = $(this).closest('.nav-item');

        if(e.type === 'mouseleave') {
            if(target.hasClass('nav-sub-item')) target.removeClass('is-hover');
        } else if(e.type === 'focusout') {
            if(parent.is(':last-child') && target.is(':last-child') && target.hasClass('nav-sub-item')) navi.removeClass('is-hover').find('li').removeClass('is-hover');
        } else {
            navi.addClass('is-hover');
    
            target.addClass('is-hover').siblings().each(function() {
                $(this).removeClass('is-hover').find('li').removeClass('is-hover');
            });
            
            parent.addClass('is-hover').siblings().each(function() {
                $(this).removeClass('is-hover').find('li').removeClass('is-hover');
            });
        }
    });

    $()

    $(window).on('load', function() {
        setTimeout(function() {
            $('#visual').addClass('is-active');
        }, 200)
    })

    $(window).on('scroll load', function() {
        if($(window).scrollTop() > 60) {
            $('#notice').addClass('is-active');
        } else {
            $('#notice').removeClass('is-active');
        }

        if($(window).scrollTop() > $(window).outerHeight() * 0.75) {
            $('#quick').addClass('is-active');
        } else {
            $('#quick').removeClass('is-active');
        }
        
        if($(this).scrollTop() > $('#header').outerHeight() * 1.25) {
            $('body').addClass('is-scroll');
        } else {
            $('body').removeClass('is-scroll');
        }
    });

    $(window).on('load resize', function(e) {
        resize  = (winSize !== null && $(window).outerWidth() === winSize[0]) ? false : true;
        winSize = [$(window).outerWidth(), $(window).outerHeight()];
        
        if(e.type === 'load' || (e.type === 'resize' && resize)) {
            $('.main-visual, #visual').css({'max-height': $(window).outerHeight() - $('#header').outerHeight()});
        }
    })
})