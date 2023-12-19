class JsPopupEntrpsDlvyGrpModal extends JsPopupLoadingFormDataBase{
    fn_page_init_click(){
        var owner = this;

        $(owner._cls_info.pageModalfix + ' .btn.f_confm_save').off('click').on('click', function(){
            owner.fn_save_click();
        });
        
    }

    fn_loading_form_cls(){
        (new JsCommon()).fn_keycontrol(this._cls_info.pageModalfix + " .keycontrol");
    }

    fn_loading_all_result_data(){
        if (this._cls_info != undefined && this._cls_info.popup_param != undefined && this._cls_info.popup_param.entrpsNo != undefined){
            $(this._cls_info.pageModalfix + " select[name=entrpsList]").val(this._cls_info.popup_param.entrpsNo);
        }

        if (this._cls_info.dataAllResult != undefined && this._cls_info.dataAllResult.resultData != undefined ){
            $(this._cls_info.pageModalfix + " input[name='entrpsDlvygrpNo']").val(this._cls_info.dataAllResult.resultData.entrpsDlvygrpNo);
            $(this._cls_info.pageModalfix + " input[name='entrpsDlvygrpNm']").val(this._cls_info.dataAllResult.resultData.entrpsDlvygrpNm);
            $(this._cls_info.pageModalfix + " input[name='dlvyAditAmt']").val(this._cls_info.dataAllResult.resultData.dlvyAditAmt.format_money());

            $(this._cls_info.pageModalfix + " input[name='dlvyCalcTy'][value!='" + this._cls_info.dataAllResult.resultData.dlvyCalcTy + "']").removeAttr("checked");
            $(this._cls_info.pageModalfix + " input[name='dlvyCalcTy'][value ='" + this._cls_info.dataAllResult.resultData.dlvyCalcTy + "']").prop("checked", "checked");
            

            $(this._cls_info.pageModalfix + " input[name='useYn'][value!='" + this._cls_info.dataAllResult.resultData.useYn + "']").removeAttr("checked");
            $(this._cls_info.pageModalfix + " input[name='useYn'][value ='" + this._cls_info.dataAllResult.resultData.useYn + "']").prop("checked", "checked");
            
            
        }else{
            
            $(this._cls_info.pageModalfix + " input[name='entrpsDlvygrpNo']").val("0");
            $(this._cls_info.pageModalfix + " input[name='entrpsDlvygrpNm']").val("");
            $(this._cls_info.pageModalfix + " input[name='dlvyAditAmt']").val("0");

        }

        
    }
    
    fn_save_click(){
        this._cls_info.saveUrl = "/_mng/sysmng/entrps/dlvygrp/dlvygrpmodalaction.json";

        var data = {entrpsNo : $(this._cls_info.pageModalfix + " select[name=entrpsList]").val()
                    , entrpsDlvygrpNo : $(this._cls_info.pageModalfix + " input[name='entrpsDlvygrpNo']").val()
                    , entrpsDlvygrpNm : $(this._cls_info.pageModalfix + " input[name='entrpsDlvygrpNm']").val()
                    , dlvyCalcTy : $(this._cls_info.pageModalfix + " input[name='dlvyCalcTy']:checked").val()
                    , dlvyAditAmt : $(this._cls_info.pageModalfix + " input[name='dlvyAditAmt']").val().replace(",", "")
                    , useYn : $(this._cls_info.pageModalfix + " input[name='useYn']:checked").val()};

        jsCallApi.call_api_post_json(this, this._cls_info.saveUrl, 'fn_save_cb', data);
        
    }
    fn_save_cb(result, fail, data, param){
        if (result != undefined && result.success){
            if (result.sucmsg != undefined && result.sucmsg.length > 0){
                alert(result.sucmsg)

                this._cls_info.popup_param.isChanged = 1;
                
                this.fn_close_popup();
            }
        }
    }
}