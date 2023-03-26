$(function() {
    //배송지 선택
    $('.order-delivery').on('click', function() {
        if($(this).hasClass('is-active')) {
            $(this).removeClass('is-active').find('.order-select input').prop('checked', false);
            $(this).siblings('.order-delivery').each(function() {
                $(this).removeClass('is-disable is-active').find('.order-select input').prop('checked', false);
            });
        } else {
            $(this).removeClass('is-disable').addClass('is-active').find('.order-select input').prop('checked', true);
            $(this).siblings('.order-delivery').each(function() {
                $(this).removeClass('is-active').addClass('is-disable').find('.order-select input').prop('checked', false);
            });
        }
    });

    $('.order-product').on('click', function() {
        if($(this).find('.order-select').length > 0) {
            if($(this).hasClass('is-active')) {
                $(this).removeClass('is-active').find('.order-select input').prop('checked', false);
                $(this).siblings('.order-product').each(function() {
                    $(this).removeClass('is-disable is-active').find('.order-select input').prop('checked', false);
                });
            } else {
                $(this).removeClass('is-disable').addClass('is-active').find('.order-select input').prop('checked', true);
                $(this).siblings('.order-product').each(function() {
                    $(this).removeClass('is-active').addClass('is-disable').find('.order-select input').prop('checked', false);
                });
            }
        }
    });
    
    //쿠폰사용
    $('.order-trigger').on('click', function() {
        if($('.order-coupon-layer').hasClass('is-active')) {
            $('.order-coupon-layer').removeClass('is-active');
        } else {
            $('.order-coupon-layer').addClass('is-active');
        }
    });
    $('.order-coupon-layer .text-title button').on('click', function() {
        $('.order-coupon-layer').removeClass('is-active');
    });
})