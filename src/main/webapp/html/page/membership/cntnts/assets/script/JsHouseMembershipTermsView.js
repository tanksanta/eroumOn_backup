class JsHouseMembershipTermsView extends JsHouse2309PageBase{
    fn_page_first_call(){
        /*처음에는 할것이 없다*/
    }
    fn_page_kind(termsKind){
        this._cls_info.termsKind = termsKind;
    }
    fn_init_sub_addevent(){
        var owner = this;
        
        $(' #prevList').off('change').on('change', function(){
            owner.fn_change_termsno_call($(this).val())
        });
    }

    fn_change_termsno_call(termsNo){
        var data = {"termsNo" : termsNo};

        this._cls_info.jsCallApi.call_api_post_json(this, '/membership/cntnts/terms/contents.json', 'fn_change_termsno_cb', data, {});
    }

    fn_change_termsno_cb(result, fail, data, param){
        if (result != null && result.termsVO != null ){
            var contents = '';
            if (result.termsVO.contentHeader != null  && result.termsVO.contentHeader.length > 0){
                contents += result.termsVO.contentHeader;
            }
            if (result.termsVO.contentBody != null  && result.termsVO.contentBody.length > 0){
                contents += result.termsVO.contentBody;
            }

            // contents = contents.replace("\n", "<br>")
            
            $("#page-content .terms.contents").html(contents);
        }
    }
}