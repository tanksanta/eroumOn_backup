
class JsHouseMngTermsForm extends JsHouse2309PageBase{
    fn_page_sub(){
        var owner = this;

        console.log(baseConfig);

        baseConfig.init_instance_callback = "ctlMaster.fn_texteditor_loaded"
        tinymce.overrideDefaults(baseConfig);

        tinymce.init({selector: this._cls_info.pagePrefix + " #contents", content_css: '/html/page/members/assets/style/term.css'});


        this._cls_info.frmSerialized = $(this._cls_info.pagePrefix + " #frm").serialize();
        this._cls_info.myContent = tinymce.activeEditor.getContent();
        // console.log("loaded=" + this._cls_info.frmSerialized);
        // console.log("loaded=" + this._cls_info.myContent);

        // window.addEventListener('beforeunload', (event) => {
        //     // Cancel the event as stated by the standard.
        //     event.preventDefault();
        //     // Chrome requires returnValue to be set.
        //     event.returnValue = false;

        //     return "이동";
        // });

        $(window).unbind('beforeunload');
    }

    fn_texteditor_loaded(){
        this._cls_info.myContent = tinymce.activeEditor.getContent();
    }
    fn_init_sub_addevent(){
        var owner = this;

        // const beforeUnloadListener = (event) => {
        //     event.preventDefault();
        //     return (event.returnValue = "");
        //   };

        // $(owner._cls_info.pagePrefix + ' .btn-group button[type="button"].btn.save').off('click').on('click', function(){
        //     alert("save")
        // });

        $(owner._cls_info.pagePrefix + ' .btn-group button[type="button"].btn.list').off('click').on('click', function(){
            document.location.href = document.referrer;

            // console.log("clicked="+$(owner._cls_info.pagePrefix + " #frm").serialize());
            // console.log("clicked="+tinymce.activeEditor.getContent());
            // if ($(owner._cls_info.pagePrefix + " #frm").serialize() == owner._cls_info.frmSerialized 
            //     && tinymce.activeEditor.getContent() == owner._cls_info.myContent
            //     ){
            //         // $(window).off("beforeunload");
            //         document.location.href = document.referrer;
            // } else {
            //     // $(window).off("beforeunload").on("beforeunload", function() {
            //     //     return "저장되지 않았습니다.\n목록으로 이동하시겠습니까?";
            //     // });
            //     // $(window).off("beforeunload");
            // }
            
        });

        $("form").validate({
            ignore: "input[type='text']:hidden, [contenteditable='true']:not([name])",
            rules : {},
            messages : {},
            submitHandler: function (frm) {

                if ($("input[name=useYn]:checked").val() == 'Y' && $("input[name=publicYn]:checked").val() == 'N'){
                    alert("사용여부, 공개/비공개를 확인하여 주십시오.");
                    return false;
                }
                
                if (confirm('저장하시겠습니까?')) {
                    frm.submit();
                }else{
                    return false;
                }
                
            },
        });
    }
}