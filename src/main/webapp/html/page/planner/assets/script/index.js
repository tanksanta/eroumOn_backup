
// 콤마 찍기 : ###,###
function comma(num){
    var len, point, str;
    str = "0";
	if(num != ''){
	    num = num + "";
	    point = num.length % 3 ;
	    len = num.length;

	    str = num.substring(0, point);
	    while (point < len) {
	        if (str != "") str += ",";
	        str += num.substring(point, point + 3);
	        point += 3;
	    }
    }
    return str;
}

$(function() {
    $('#userinfo .close-button').on('click', function() {
        $(window).scrollTop($('#content').offset().top  - $('#header').outerHeight())
        return false;
    });

    $('.page-content-items .content-items').masonry({
        itemSelector: '.content-item',
        columnWidth: '.content-sizer',
        gutter: '.content-gutter',
        percentPosition: true
    });

    $('.map-select-link').on('click', function() {
        $(this).toggleClass('is-active');
        return false;
    });

    $('.map-select .nav-link').on('click', function() {
        $(this).closest('.map-select').addClass('is-active');
    });

    $('.map-select .resizer').on('click', function() {
        $(this).closest('.map-select').toggleClass('is-active');
    })

    var observer = new MutationObserver(function(mutations) {
        if($(mutations[0].target).hasClass('active')) {
            $('.page-content-items .content-items').masonry({
                itemSelector: '.content-item',
                columnWidth: '.content-sizer',
                gutter: '.content-gutter',
                percentPosition: true
            });
        }
    });

    if(document.querySelector("#tabs-cont1") !== null) {
        observer.observe(document.querySelector("#tabs-cont1"), {
            attributes : true
        });
    }

    $(window).on('resize load', function() {
        if($('#userinfo').length > 0) {
            $('#account.is-nologin').attr('style', '--margin:' + ($(window).outerWidth() - ($('.userinfo-box').offset().left + $('.userinfo-box').outerWidth() + 10)) + 'px');
        }
    });

    $(window).on('scroll load', function() {
        if($(this).scrollTop() > $('#header').outerHeight() * 1.25) {
            $('body').addClass('is-scroll');
        } else {
            $('body').removeClass('is-scroll');
        }
    });
});