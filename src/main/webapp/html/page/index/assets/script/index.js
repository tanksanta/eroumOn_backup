$(function() {
    $(window).on('load', function() {
        setTimeout(function() {
            $('#visual').addClass('is-active');
        }, 200)

        $('#quick .moveTop').on('click', function() {
            $(window).scrollTop(0);
        });
    })

    $(window).on('scroll load', function() {
        $('#notice').prop('class',function (i,v) {
            return ($(window).scrollTop() > 60) ? 'is-active' : '';
        });

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
        var visualheight = ($(window).outerWidth() < 768 && $(window).height() > 700) ? 700 : $(window).outerHeight() - $('#header').outerHeight();

        $('#visual').css({'max-height': visualheight});
    })
})