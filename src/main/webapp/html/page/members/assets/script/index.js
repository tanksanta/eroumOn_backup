$(function(){

    ////// 추가 leemw
    //하단 드롭다운메뉴 토글
    $('.btn_menu_dropdown').on('click', function () {

        if ($(this).hasClass('active') == true) {
            $(this).removeClass('active');
            $('.menu_dropdown').removeClass('active');
        } else {
            $(this).addClass('active');
            $('.menu_dropdown').addClass('active');
        }

    });


});