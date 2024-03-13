//guide.js
$(function(){

    //modal
    $('.modal:not(.static.alert):not(.static.confirm)').modal({
        endingTop:'20%',
        opacity: 0.6
    });


    //입력폼 input_basic - valid 추가
    $('input.input_basic').attr({
        'required': true,
    });




    //입력폼이 div안에 있을때 input_noClass
    $('.input_noClass').each(function(){

        
        //포커싱시 주황색 라인
        $(this).focus(function(){

            $(this).parents('.input_basic').css('border', '2px solid #FF8120');

        });
        

        //포커스아웃시 텍스트 유무에 따라 border값 설정
        $(this).focusout(function(){

            if($(this).val().length > 0){


                //레드라인일때 그대로 유지
                if($(this).parents('.input_basic').hasClass('bder_danger')==true){

                    $(this).parents('.input_basic').css('border', '2px solid #E53935');

                }

                else{
                    //valid
                    $(this).parents('.input_basic').css('border', '1px solid #999');

                }

            }


            else{

                //레드라인일때 그대로 유지
                if($(this).parents('.input_basic').hasClass('bder_danger')==true){

                    //red
                    $(this).parents('.input_basic').css('border', '2px solid #E53935');

                }

                else{

                    $(this).parents('.input_basic').css('border', '1px solid #E0E0E0');

                }

            }

        });


        //텍스트 있을시
        if($(this).val().length > 0){

            //레드라인일때 return 
            if($(this).parents('.input_basic').hasClass('bder_danger')==true){

                return;

            }

            else{

                //valid
                $(this).parents('.input_basic').css('border', '1px solid #999');

            }
            

        };


    });



    //어르신step 텍스트 active시 그래프에도 active처리
    $('.step_txt_area li.active').each(function(){

        var activeLen = $(this).index()+1;

        $('.step_graph_area li:nth-child('+ activeLen +')').addClass('active');

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

        $('.btnEvt_me').removeClass("btn_disable");
        
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
    


    //오버레이 화면
    $('.overlay_evt').click(function(){

        $('.overlay_screen').fadeIn();
        $('body').css('overflow','hidden');

    });

    $('.overlay_screen').click(function(){

        $(this).fadeOut();
        $('body').css('overflow','initial');


    });



    //상단 토글버튼 현재 안씀
    // $('.top_dropdown_btn').on('click', function() {
        
    //     if($(this).hasClass('active')==true){
    //         $(this).removeClass('active');
    //         $(this).next('.top_dropdown_menu').slideUp(100);				
    //     }

    //     else{
    //         $(this).addClass('active');
    //         $(this).next('.top_dropdown_menu').slideDown(100);		
    //     }

    // });



});






//maxlength 넘버제한 처리
function maxLengthCheck(object){
    if (object.value.length > object.maxLength){
      object.value = object.value.slice(0, object.maxLength);
    }    
  }


  