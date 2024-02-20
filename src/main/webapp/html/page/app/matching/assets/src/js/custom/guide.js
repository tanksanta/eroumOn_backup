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



});

//maxlength 넘버제한 처리
function maxLengthCheck(object){
    if (object.value.length > object.maxLength){
      object.value = object.value.slice(0, object.maxLength);
    }    
  }