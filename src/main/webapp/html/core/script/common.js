//DataTables lang
var dt_lang = {
    'decimal'        : '',
    'emptyTable'     : '검색조건을 선택 하신 후, 검색해 주세요.',
    'info'           : '총 <strong>_END_</strong>건, <strong>_PAGE_</strong>/_PAGES_ 페이지',
    'infoEmpty'      : '총 0건',
    "infoFiltered"   : '(전체 _MAX_건 중 검색결과)',
    'thousands'      : ',',
    'lengthMenu'     : '출력_MENU_',
    'loadingRecords' : '로딩중',
    'processing'     : '처리중',
    'search'         : '검색 ',
    'zeroRecords'    : '검색조건을 만족하는 결과가 없습니다.',
    'aria'           : {
        'sortAscending'  : '오름차순',
        'sortDescending' : '내림차순'
    },
    'paginate' : {
        'previous' : '이전',
        'next'     : '다음',
        'first'    : '처음',
        'last'     : '마지막'
    }
};

$(function() {
    $('a[class*="menu-item"][href*="list-items"]').on('click', function(e) {
        $(this).addClass('active').parent().siblings().find('a').removeClass('active');
        $($(this).attr('href')).addClass('active').siblings('.list-items').removeClass('active');
        return false;
    });

    $('[data-bs-toggle="inner-modal"]').on('click', function(e) {
        $($(this).attr('data-bs-target')).show(0).addClass('show');
        return false;
    })

    $('.modal-inner [data-bs-dismiss]').on('click', function(e) {
        $(this).closest('.modal').removeClass('show').delay(100).hide(0);
        return false;
    });
    
    $('.modal-inner').on('click', function(e) {
        if(e.target === this) $(this).closest('.modal').removeClass('show').delay(100).hide(0);
    })
})