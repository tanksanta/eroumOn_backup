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
        if (result != null && result.termsVO != null && result.termsVO.contents != null && result.termsVO.contents.length > 0){
            $("#page-content .terms.contents").html(result.termsVO.contents);
        }
    }
}