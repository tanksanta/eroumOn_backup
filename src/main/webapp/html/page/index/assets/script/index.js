$(function() {
    $(window).on('load', function() {
        setTimeout(function() {
            $('.main-visual, #visual').addClass('is-active');
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
})