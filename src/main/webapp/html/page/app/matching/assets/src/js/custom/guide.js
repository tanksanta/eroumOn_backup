//guide.js
$(function(){

    //modal
    $('.modal:not(.static.alert):not(.static.confirm)').modal({
        endingTop:'20%'
    });

    //통신사 선택시 텍스트변경 및 리스트 선택
    $('.broad_area li').click(function(){

        var thisTxt = $(this).text();

        $('.broad_evt').text(thisTxt);

        $('.broad_area li').removeClass('active');
        $(this).addClass('active');
    });



    //회원가입 전체동의 체크박스
    $('.total_evt').on('click', function() {
        
        if($(this).is(':checked')==true){
            $('.group_chk_area :checkbox').prop('checked', true);				
        }

        else{
            $('.group_chk_area :checkbox').prop('checked', false);	
        }

    });
    $(".group_chk_area :checkbox").click(function() {
        var total = $(".group_chk_area :checkbox").length;
        var checked = $(".group_chk_area :checkbox:checked").length;
        
        if(total != checked) $(".total_evt").prop("checked", false);
        else $(".total_evt").prop("checked", true); 
    });


    //어르신등록 - 가족관계
    $('.family_tree_area .item').click(function(){

        $('.family_tree_area .item').removeClass('active');
        $(this).addClass('active');

        //본인 선택시 버튼 '등록하기'로 변경
        if($(this).hasClass('me')===false){

            $('.btnEvt_me').text('다음')
        }
        else{
            $('.btnEvt_me').text('등록하기');
        }
    
    });
    

    //시도 지역선택 chip
    $('.chip_area li').click(function(){

        $('.chip_area li').removeClass('active');
        $(this).addClass('active');

    });





});






//maxlength 넘버제한 처리
function maxLengthCheck(object){
    if (object.value.length > object.maxLength){
      object.value = object.value.slice(0, object.maxLength);
    }    
  }


  