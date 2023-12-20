class JsPopupEntrpsDlvyGrpChoice extends JsPopupLoadingFormDataBase{
    fn_page_init_click(){
        var owner = this;

        $(owner._cls_info.pageModalfix + ' .btn.f_confm_save').off('click').on('click', function(){
            owner.fn_confirm_click();
        });
        
    }

    fn_pop_url(){
        return this._cls_info.popUrl.format(this._cls_info.popUrlEntrpsNo);
    }

    fn_loading_form_data_call(param, bSvrData, data){
        this._cls_info.popUrlEntrpsNo = param.entrpsNo;

        if (this._cls_info.selected_entrpsNo != param.entrpsNo){
            if (this._cls_info.modalPop != undefined && this._cls_info.modalPop.length > 0){
                this._cls_info.modalPop.remove();
                this._cls_info.modalPop = null;
                this._cls_info.loadedFormYn = false;
            }
        }

        super.fn_loading_form_data_call(param, bSvrData, data);
    }

    fn_loading_all_result_data(){
        if (this._cls_info != undefined && this._cls_info.popup_param != undefined && this._cls_info.popup_param.entrpsNo != undefined){
            this._cls_info.selected_entrpsNo = this._cls_info.popup_param.entrpsNo;
        }

        if (this._cls_info.dataAllResult != undefined && this._cls_info.dataAllResult.resultData != undefined ){
            
        }else{
        }

        
    }
    
    fn_confirm_click(){
        var objTarget = $(this._cls_info.pageModalfix + " input[name='entrpsDlvygrpNo']:checked");

        if (objTarget.length < 1){
            alert("선택하여 주십시오.")
            return;
        }

        this.fn_close_popup();
        
        var data = {"entrpsNo":objTarget.attr("entrpsNo")
                    , "entrpsDlvygrpNo":objTarget.attr("entrpsDlvygrpNo")
                    , "entrpsDlvygrpNm":objTarget.attr("entrpsDlvygrpNm")
                    , "dlvyCalcTy":objTarget.attr("dlvyCalcTy")
                    , "dlvyCalcTyNm":objTarget.attr("dlvyCalcTyNm")
                    , "useYn":objTarget.attr("useYn")
                    , "dlvyAditAmt":objTarget.attr("dlvyAditAmt")
                };

        if (this._cls_info.container != undefined && this._cls_info.container['fn_popup_selected'] != undefined){
            this._cls_info.container['fn_popup_selected']('confirm', this._cls_info.popName, this._cls_info.popup_param, data, null);
        }
        
    }
    
}