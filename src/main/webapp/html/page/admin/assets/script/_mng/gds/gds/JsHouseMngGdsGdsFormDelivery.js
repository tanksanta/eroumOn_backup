class JsHouseMngGdsGdsFormDelivery{
    constructor(pagePrefixBasic, pagePrefixDelivery){
        this._cls_info = { 
                            pagePrefixBasic: pagePrefixBasic 
                            , pagePrefixDelivery : pagePrefixDelivery
                            , popups : {}
                        };

        this.fn_page_init();

        this.fn_changed_dlvyCtTy($( this._cls_info.pagePrefixDelivery + " select[name='dlvyCtTy']").val());
        this.fn_changed_dlvyGroupYn($( this._cls_info.pagePrefixDelivery + " .dlvy-ct-ty-tr.dlvyGroupYn .form-group input.dlvyGroupYn").val());
        
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
                                                                                            , "/_mng/sysmng/entrps/dlvygrp/dlvygrpno.json", {})

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

        $( this._cls_info.pagePrefixDelivery + " .dlvy-ct-ty-tr.dlvyGroupYn .form-group input.dlvyGroupYn").off('change').on('change',  function() {
            owner.fn_changed_dlvyGroupYn($(this).val());
        });

        $( this._cls_info.pagePrefixDelivery + " .btn.dlvy.grp.select").off('click').on('click',  function() {
            var entrpsNo = $( owner._cls_info.pagePrefixBasic + " select[name='entrpsNo']" ).val();

            if (entrpsNo == undefined || entrpsNo.length < 1 || entrpsNo == "" || entrpsNo == "0"){
                alert("입점업체를 먼저 선택하여 주십시오.")
                return;
            }

            owner._cls_info.popups.jsPopupEntrpsDlvyGrpChoice.fn_loading_form_data_call({"entrpsNo":entrpsNo}, false, {"entrpsNo":entrpsNo})
        });
        
    }

    

    fn_changed_dlvyCtTy(dlvyCtTy){
        // dlvyCtTy FREE==>무료, PAY==>유료, OVERMONEY==>조건부 무료, PERCOUNT==>구매수량별

        //dlvy-ct-ty-tr dlvyCtStlm:배송비결제, dlvyBassAmt:기본 배송료, dlvyCtCnd:배송비조건, dlvyAditAmt:산간지역 추가 배송비, dlvyGroupYn:묶음배송

        switch(dlvyCtTy){
            case "FREE":
                $(this._cls_info.pagePrefixDelivery + " .dlvy-ct-ty-tr.dlvyBassAmt" ).addClass("disp-off");
                $(this._cls_info.pagePrefixDelivery + " .dlvy-ct-ty-tr.dlvyCtCnd" ).addClass("disp-off");
            break;
        }
    }

    fn_changed_dlvyGroupYn(dlvyGroupYn){
        var cssSelector = this._cls_info.pagePrefixDelivery + " .dlvy-ct-ty-tr.dlvyGroupYn";

        if (dlvyGroupYn == "Y"){
            $(cssSelector + " .dlvy-group-disp").removeClass("disp-off");
        }else{
            $(cssSelector + " input[name='entrpsDlvygrpNo']").val("0");
            $(cssSelector + " .dlvy-group-disp").html("");
            $(cssSelector + " .dlvy-group-disp").addClass("disp-off");
        }
        
    }
}