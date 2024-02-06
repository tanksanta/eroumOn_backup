class JsPopupLoadingFormDataBaseWithDataTables extends JsPopupLoadingFormDataBase{
    fn_loading_form_cls(){
        var owner = this;
        this._cls_info.coms.gridList = $(this._cls_info.pageModalfix + " .con-datatables").DataTable({
            bFilter: false,
            bInfo: false,
            bSort : false,
            bAutoWidth: false,
            bLengthChange: false,
            "oLanguage": {
                "sEmptyTable": "생성된 묶음그룹이 없습니다."
              },

			bServerSide: false,

			aoColumns: this.fn_gridList_columns(),
			aaData : [],
		});
    }

    fn_gridList_columns(){
        return [
				
            { mDataProp: "addr"},
            { mDataProp: "addr2"},
            { mDataProp: "telno"}
        ];
    }
    

    fn_gridList_databinding(arrData){
        var ifor, ilen = arrData.length;

        this._cls_info.coms.gridList.clear();

        for(ifor=0 ; ifor<ilen ; ifor++){
            this._cls_info.coms.gridList.row.add(arrData[ifor]);
        }

        this._cls_info.coms.gridList.draw(false);
        
    }
}

class JsPopupEntrpsDlvyGrpChoice extends JsPopupLoadingFormDataBaseWithDataTables{
    fn_pop_url(){
        return this._cls_info.popUrl.format(this._cls_info.popUrlEntrpsNo);
    }
    fn_data_url(){
        var dataUrl = this._cls_info.dataUrl.format(this._cls_info.popUrlEntrpsNo);
        var schEntrpsDlvygrpNm = $(this._cls_info.pageModalfix + " input[name='schEntrpsDlvygrpNm']").val();

        if (schEntrpsDlvygrpNm != undefined && schEntrpsDlvygrpNm.length > 0){
            dataUrl +=  ((dataUrl.indexOf("?")>0)?"&":"?") + "srchText="+schEntrpsDlvygrpNm;
        }

        return dataUrl;
    }

    fn_gridList_columns(){
        return [
            { mDataProp: "entrpsDlvygrpNm"},
            { mDataProp: "dlvyCalcTyNm2"},

            { mRender: function (data, type, row) {
                    var str = '<div class="form-check">';
                    str += ' <input type="radio" class="form-check-input" name="entrpsDlvygrpNo"';

                    str += ' value="' + row.entrpsDlvygrpNo+'"';
                    str += ' entrpsNo="' + row.entrpsNo+'"';
                    str += ' entrpsDlvygrpNo="' + row.entrpsDlvygrpNo+'"';
                    str += ' entrpsDlvygrpNm="' + row.entrpsDlvygrpNm+'"';
                    str += ' dlvyCalcTy="' + row.dlvyCalcTy+'"';
                    str += ' dlvyCalcTyNm="' + row.dlvyCalcTyNm+'"';
                    str += ' dlvyCalcTyNm2="' + row.dlvyCalcTyNm2+'"';
                    str += ' useYn="' + row.useYn+'"';
                    str += ' useYnNm="' + row.useYnNm+'"';
                    str += ' dlvyAditAmt="' + row.dlvyAditAmt+'"';

                    str += '>';
                    str += '</div>';
                

                    return str;
                }
            },
        ];
    }

    fn_page_init_click(){
        var owner = this;

        $(owner._cls_info.pageModalfix + ' .btn.f_confm_save').off('click').on('click', function(){
            owner.fn_confirm_click();
        });
        $(owner._cls_info.pageModalfix + ' .btn.f_search').off('click').on('click', function(){
            owner.fn_loading_data_call(true, null);
        });
    }

    fn_loading_form_data_call(param, bSvrData, data){
        $(this._cls_info.pageModalfix + " input[name='schEntrpsDlvygrpNm']").val("");
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

    fn_loading_all_result_convert(){
        var ifor, ilen = this._cls_info.dataAllResult.resultData.length;
        var itemone;
        for(ifor=0 ; ifor<ilen ; ifor++){
            itemone = this._cls_info.dataAllResult.resultData[ifor];

            itemone.dlvyCalcTyNm  = this._cls_info.dataAllResult.dlvyCalcTyCode[itemone.dlvyCalcTy];
            itemone.dlvyCalcTyNm2 = this._cls_info.dataAllResult.dlvyCalcTy2Code[itemone.dlvyCalcTy];
            itemone.useYnNm = this._cls_info.dataAllResult.useYnCode[itemone.useYn];
        }

        console.log(this._cls_info.dataAllResult.resultData)
    }

    fn_loading_all_result_data(){
        if (this._cls_info != undefined && this._cls_info.popup_param != undefined && this._cls_info.popup_param.entrpsNo != undefined){
            this._cls_info.selected_entrpsNo = this._cls_info.popup_param.entrpsNo;
        }

        if (this._cls_info.dataAllResult != undefined && this._cls_info.dataAllResult.resultData != undefined ){
            this.fn_loading_all_result_convert();
            this.fn_gridList_databinding(this._cls_info.dataAllResult.resultData);
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
                    , "dlvyCalcTyNm2":objTarget.attr("dlvyCalcTyNm2")
                    , "useYn":objTarget.attr("useYn")
                    , "useYnNm":objTarget.attr("useYnNm")
                    , "dlvyAditAmt":objTarget.attr("dlvyAditAmt")
                };

        if (this._cls_info.container != undefined && this._cls_info.container['fn_popup_selected'] != undefined){
            this._cls_info.container['fn_popup_selected']('confirm', this._cls_info.popName, this._cls_info.popup_param, data, null);
        }
        
    }
    
}