$(function() {
    var swiper = new Swiper(".swiper", {
        effect: "fade",
        loop: false,
        speed: 1000,
        allowTouchMove: false,
        simulateTouch: false,
        autoplay: {
            delay: 10000,
            disableOnInteraction: false,
        },
        on: {
            afterInit: function() {
                var itemIndex = this.realIndex;
                var itemPer   = (100 / this.slides.length) / 100;
                var currPer   = itemIndex * itemPer;
                var nextPer   = (itemIndex + 1) * itemPer;
                
                $('.progress-link li').removeClass('is-active').filter(function() {return $(this).index() <= itemIndex}).addClass('is-active');

                $('.progress-bar .steps').attr('data-current', currPer).attr('data-next', nextPer).animate({
                    width: ($('.progress-bar').width() * $('.progress-bar .steps').attr('data-next')) + ($('.progress-link li sup').width() + 1)
                }, 10000);
            },
            slideChange: function() {
                var itemIndex = this.realIndex;
                var itemPer   = (100 / this.slides.length) / 100;
                var currPer   = itemIndex * itemPer;
                var nextPer   = (itemIndex + 1) * itemPer;
                
                $('.progress-link li').removeClass('is-active').filter(function() {return $(this).index() <= itemIndex}).addClass('is-active');

                $('.progress-bar .steps').attr('data-current', currPer).attr('data-next', nextPer).stop().animate({
                    width: ($('.progress-bar').width() * $('.progress-bar .steps').attr('data-current')) + ($('.progress-link li sup').width() + 1)
                }, {
                    duration: 200,
                    complete: function() {
                        $('.progress-bar .steps').animate({
                            width: ($('.progress-bar').width() * $('.progress-bar .steps').attr('data-next')) + ($('.progress-link li sup').width() + 1)
                        }, 9800);
                    }
                });
            }
        }
    });

    $('.progress-link a').on('click', function() {
        $('.progress-bar .steps').removeClass('is-animate');
        swiper.slideTo($(this).parent().index());
        return false;
    })

    $('.nav-item').on('mouseenter', function() {
        $(this).addClass('is-hover');
    }).on('mouseleave', function() {
        $(this).removeClass('is-hover');
    })
})