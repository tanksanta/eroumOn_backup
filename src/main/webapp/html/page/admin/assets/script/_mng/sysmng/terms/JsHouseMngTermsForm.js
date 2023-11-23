
class JsHouseMngTermsForm extends JsHouse2309PageBase{
    fn_page_sub(){
        var owner = this;

        /*초기 데이터 저장 변수, 저장시 확인용*/
        this._cls_info.frmSerialized = $(this._cls_info.pagePrefix + " #frm").serialize();
        
    }


    fn_init_sub_addevent(){
        var owner = this;

        $(owner._cls_info.pagePrefix + ' .btn-group button[type="button"].btn.list').off('click').on('click', function(){
            var stemp = $(owner._cls_info.pagePrefix + " #frm").serialize();
            // console.log(owner._cls_info.frmSerialized);
            // console.log(stemp);
            if (stemp != owner._cls_info.frmSerialized ){
                if (!confirm("저장되지 않았습니다.\n목록으로 이동하시겠습니까?")) return;
            }
            
            window.onbeforeunload = function(){};
            document.location.href = document.referrer;
            
        });

        $("form").validate({
            ignore: "input",
            rules : {},
            messages : {},
            submitHandler: function (frm) {

                if ($("input[name=useYn]:checked").val() == 'Y' && $("input[name=publicYn]:checked").val() == 'N'){
                    alert("사용여부, 공개/비공개를 확인하여 주십시오.");
                    return false;
                }

                var msg;
                if ($("input[name=crud]").val() == 'UPDATE'){
                    msg = '변경사항을 저장하시겠습니까?';
                }else{
                    msg = '등록 하시겠습니까?';
                }
                
                if (confirm(msg)) {
                    window.onbeforeunload = function(){};

                    frm.submit();
                }else{
                    return false;
                }
                
            },
        });
    }
}