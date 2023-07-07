$(function() {
    $('.notice-close').on('click', function() {
        $(this).closest('aside').addClass('is-closed');
    })

    $(window).on('load', function() {
        setTimeout(function() {
            $('#visual').addClass('is-active');
        }, 200)

        $('#quick .moveTop').on('click', function() {
            $(window).scrollTop(0);
        });
    })

    $(window).on('scroll load', function() {
        if($(window).scrollTop() > 60) {
            $('#notice').addClass('is-active');
        } else {
            $('#notice').removeClass('is-active');
        }

        if($(window).scrollTop() === 0 && $('#notice').hasClass('is-closed')) {
            $('#notice').removeClass('is-closed');
        }

        if($(window).scrollTop() > $(window).outerHeight() * 0.75) {
            $('#quick').addClass('is-active');
        } else {
            $('#quick').removeClass('is-active');
        }
        
        if($(this).scrollTop() > $('#header').outerHeight() * 1.25) {
            $('body').addClass('is-scroll');
            if($('body').hasClass('is-index')) $('#logo').removeClass('is-white');
        } else {
            $('body').removeClass('is-scroll');
            if($('body').hasClass('is-index')) $('#logo').addClass('is-white');
        }
    });

    $(window).on('load scroll resize', function() {
        $('#visual').css({'max-height': $(window).outerHeight() - $('#header').outerHeight()});
    })
})