class JsHouseMngGdsGdsFormDelivery{
    constructor(pagePrefixBasic, pagePrefixDelivery){
        this._cls_info = { 
                            pagePrefixBasic: pagePrefixBasic 
                            , pagePrefixDelivery : pagePrefixDelivery
                            , popups : {}
                        };

        this.fn_page_init();
        
        this.fn_changed_dlvyCtTy($( this._cls_info.pagePrefixDelivery + " select[name='dlvyCtTy']").val());
        this.fn_changed_dlvyGroupYn($( this._cls_info.pagePrefixDelivery + " .dlvy-ct-ty-tr.dlvyGroupYn .form-group input[name='dlvyGroupYn']"));
        
    }

    fn_popup_selected(alert_val, popName, popup_param, data, extra){
        console.log(alert_val, popName, popup_param, data)
        if (alert_val == 'confirm'){
            if (popName == "divDlvyGrpChoice" || popName == "divDlvyGrpAdd"){
                this.fn_popup_selected_divDlvyGrpChoice(popup_param, data, extra);
            }
        }else if (alert_val == 'popup_data_changed'){
            
        }
    }

    fn_popup_selected_divDlvyGrpChoice(popup_param, data, extra){
        var cssSelector = this._cls_info.pagePrefixDelivery;
        $(cssSelector + " .dlvy-ct-ty-tr.dlvyGroupYn input[name='entrpsDlvygrpNo']").val(data.entrpsDlvygrpNo);
        $(cssSelector + " .dlvy-ct-ty-tr.dlvyAditAmt input[name='dlvyAditAmt']").val(data.dlvyAditAmt);


        $(cssSelector + " .dlvy-ct-ty-tr.dlvyGroupYn .dlvy-group-disp .entrpsDlvygrpNm").html(data.entrpsDlvygrpNm);
        $(cssSelector + " .dlvy-ct-ty-tr.dlvyGroupYn .dlvy-group-disp .dlvyCalcTyNm").html(data.dlvyCalcTyNm);
        $(cssSelector + " .dlvy-ct-ty-tr.dlvyGroupYn .dlvy-group-disp .entrpsDlvygrpUseYn").html(data.useYnNm);

    }

    fn_page_init(){
        this.fn_init_addevent()

        this.fn_page_sub();

        this.fn_init_sub_addevent();
    }

    fn_page_sub(){
        this._cls_info.popups.jsPopupEntrpsDlvyGrpChoice = new JsPopupEntrpsDlvyGrpChoice(this
                                                                                            , ".modal2-con .divDlvyGrpChoice"
                                                                                            , "divDlvyGrpChoice"
                                                                                            , 1
                                                                                            , "/_mng/sysmng/entrps/dlvygrp/{0}/choicemodal"
                                                                                            , "/_mng/sysmng/entrps/dlvygrp/{0}/dlvygrplist.json"
                                                                                            , {}
                                                                                        );

        this._cls_info.popups.jsPopupEntrpsDlvyGrpModal = new JsPopupEntrpsDlvyGrpModal(this
                                                                                            , ".modal2-con .divDlvyGrpAdd"
                                                                                            , "divDlvyGrpAdd"
                                                                                            , 1
                                                                                            , "/_mng/sysmng/entrps/dlvygrp/modalform"
                                                                                            , "/_mng/sysmng/entrps/dlvygrp/dlvygrpno.json"
                                                                                            , {}
                                                                                        );



                                                                                

    }

    fn_init_sub_addevent(){

    }

    fn_init_addevent(){
        var owner = this;
        $( this._cls_info.pagePrefixBasic + " select[name='entrpsNo']" ).off('change').on('change',  function() {
            
        });

        $( this._cls_info.pagePrefixDelivery + " select[name='dlvyCtTy']").off('change').on('change',  function() {
            owner.fn_changed_dlvyCtTy($(this).val());
        });

        $( this._cls_info.pagePrefixDelivery + " .dlvy-ct-ty-tr.dlvyGroupYn .form-group input[name='dlvyGroupYn']").off('change').on('change',  function() {
            owner.fn_changed_dlvyGroupYn($(this));
        });

        $( this._cls_info.pagePrefixDelivery + " .btn.dlvy.grp.add").off('click').on('click',  function() {
            var entrpsNo = $( owner._cls_info.pagePrefixBasic + " select[name='entrpsNo']" ).val();

            if (entrpsNo == undefined || entrpsNo.length < 1 || entrpsNo == "" || entrpsNo == "0"){
                alert("입점업체를 먼저 선택하여 주십시오.")
                return;
            }

            owner._cls_info.popups.jsPopupEntrpsDlvyGrpModal.fn_loading_form_data_call({"entrpsNo":entrpsNo, choice:true}, false, {"entrpsNo":entrpsNo})

        });

        $( this._cls_info.pagePrefixDelivery + " .btn.dlvy.grp.select").off('click').on('click',  function() {
            var entrpsNo = $( owner._cls_info.pagePrefixBasic + " select[name='entrpsNo']" ).val();

            if (entrpsNo == undefined || entrpsNo.length < 1 || entrpsNo == "" || entrpsNo == "0"){
                alert("입점업체를 먼저 선택하여 주십시오.")
                return;
            }

            owner._cls_info.popups.jsPopupEntrpsDlvyGrpChoice.fn_loading_form_data_call({"entrpsNo":entrpsNo}, true, {"entrpsNo":entrpsNo})
        });
        
    }

    

    fn_changed_dlvyCtTy(dlvyCtTy){
        // dlvyCtTy FREE==>무료, PAY==>유료, OVERMONEY==>조건부 무료, PERCOUNT==>구매수량별

        //dlvy-ct-ty-tr dlvyCtStlm:배송비결제, dlvyBassAmt:기본 배송료, dlvyCtCnd:배송비조건, dlvyAditAmt:산간지역 추가 배송비, dlvyGroupYn:묶음배송

        switch(dlvyCtTy){
            case "FREE":
                $(this._cls_info.pagePrefixDelivery + " .dlvy-ct-ty-tr.dlvyBassAmt").addClass("disp-off");
                $(this._cls_info.pagePrefixDelivery + " .dlvy-ct-ty-tr.dlvyCtCnd").addClass("disp-off");
                $(this._cls_info.pagePrefixDelivery + " .dlvy-ct-ty-tr.dlvyCtCnd2").addClass("disp-off");
                break;
            case "PAY":
                $(this._cls_info.pagePrefixDelivery + " .dlvy-ct-ty-tr.dlvyBassAmt").removeClass("disp-off");
                $(this._cls_info.pagePrefixDelivery + " .dlvy-ct-ty-tr.dlvyBassAmt .txt").removeClass("disp-off");
                $(this._cls_info.pagePrefixDelivery + " .dlvy-ct-ty-tr.dlvyCtCnd").addClass("disp-off");
                $(this._cls_info.pagePrefixDelivery + " .dlvy-ct-ty-tr.dlvyCtCnd2").addClass("disp-off");
                break;
            case "OVERMONEY":
                $(this._cls_info.pagePrefixDelivery + " .dlvy-ct-ty-tr.dlvyBassAmt").removeClass("disp-off");
                $(this._cls_info.pagePrefixDelivery + " .dlvy-ct-ty-tr.dlvyBassAmt .txt").addClass("disp-off");

                $(this._cls_info.pagePrefixDelivery + " .dlvy-ct-ty-tr.dlvyCtCnd").removeClass("disp-off");
                $(this._cls_info.pagePrefixDelivery + " .dlvy-ct-ty-tr.dlvyCtCnd .tit").html('무료조건');
                $(this._cls_info.pagePrefixDelivery + " .dlvy-ct-ty-tr.dlvyCtCnd .txt").html('원 이상 구매시 배송비 무료');

                $(this._cls_info.pagePrefixDelivery + " .dlvy-ct-ty-tr.dlvyCtCnd2").addClass("disp-off");
                break;
            case "PERCOUNT":
                $(this._cls_info.pagePrefixDelivery + " .dlvy-ct-ty-tr.dlvyBassAmt").removeClass("disp-off");
                $(this._cls_info.pagePrefixDelivery + " .dlvy-ct-ty-tr.dlvyBassAmt .txt").addClass("disp-off");

                $(this._cls_info.pagePrefixDelivery + " .dlvy-ct-ty-tr.dlvyCtCnd").removeClass("disp-off");

                $(this._cls_info.pagePrefixDelivery + " .dlvy-ct-ty-tr.dlvyCtCnd .tit").html('배송비 조건');
                $(this._cls_info.pagePrefixDelivery + " .dlvy-ct-ty-tr.dlvyCtCnd .txt").html(' 개 마다 배송비 반복 부과');

                $(this._cls_info.pagePrefixDelivery + " .dlvy-ct-ty-tr.dlvyCtCnd2").removeClass("disp-off");
                break;
        }
    }

    fn_changed_dlvyGroupYn(jobjTarget ){
        var isChecked = jobjTarget.is(":checked");

        var cssSelector = this._cls_info.pagePrefixDelivery;

        if (isChecked){
            $(cssSelector + " .dlvy-ct-ty-tr.dlvyGroupYn .btn.dlvy.grp.add").removeClass("disp-off");
            $(cssSelector + " .dlvy-ct-ty-tr.dlvyGroupYn .btn.dlvy.grp.select").removeClass("disp-off");

            $(cssSelector + " .dlvy-ct-ty-tr.dlvyGroupYn .dlvy-group-disp").removeClass("disp-off");
            $(cssSelector + " .dlvy-ct-ty-tr.dlvyAditAmt input[name='dlvyAditAmt']").attr("readonly", "true");
            $(cssSelector + " .dlvy-ct-ty-tr.dlvyAditAmt input[name='dlvyAditAmt']").val(jobjTarget.attr("dlvy_adit_amt"));
        }else{
            $(cssSelector + " .dlvy-ct-ty-tr.dlvyGroupYn .btn.dlvy.grp.add").addClass("disp-off");
            $(cssSelector + " .dlvy-ct-ty-tr.dlvyGroupYn .btn.dlvy.grp.select").addClass("disp-off");

            // $(cssSelector + " .dlvy-ct-ty-tr.dlvyGroupYn input[name='entrpsDlvygrpNo']").val("0");
            // $(cssSelector + " .dlvy-ct-ty-tr.dlvyGroupYn .dlvy-group-disp").html("");
            $(cssSelector + " .dlvy-ct-ty-tr.dlvyGroupYn .dlvy-group-disp").addClass("disp-off");
            $(cssSelector + " .dlvy-ct-ty-tr.dlvyAditAmt input[name='dlvyAditAmt']").removeAttr("readonly");
        }
        
    }
}