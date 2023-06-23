$(function() {
    $(window).on('scroll load', function() {
        $('#notice').prop('class',function (i,v) {
            return ($(window).scrollTop() > 60) ? 'is-active' : '';
        });

        if($(this).scrollTop() > $('#header').outerHeight() * 1.25) {
            $('body').addClass('is-scroll');
            if($('body').hasClass('is-index')) $('#logo').removeClass('is-white');
        } else {
            $('body').removeClass('is-scroll');
            if($('body').hasClass('is-index')) $('#logo').addClass('is-white');
        }
    });
})