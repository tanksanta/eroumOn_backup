
class JsHouse2309PopupBase{
    /*
        container : null일 수 있음(PopupZipSearch)
        cssSelector : 
        popName : 팝업 명칭
        popStep : 팝업 형태(1:일반, 2:팝업위 팝업, 1024:confirm, message)
    */
    constructor(container, cssSelector, popName, popStep, popOptions) {
        // if (container['fn_popup2_selected'] == undefined){
        //     alert("fn_popup2_selected 함수가 없습니다.")
        // }
        popOptions = popOptions || {};

        this._cls_info = this._cls_info || {};

        if (popStep == undefined) popStep = 1;

        this._cls_info.container = container;
        this._cls_info.pageModalfix = cssSelector;
        this._cls_info.popName = popName;
        this._cls_info.popStep = popStep;
        this._cls_info.popOptions = popOptions;
        this._cls_info.coms = {};/*컴포넌트*/
        this._cls_info.modalCon = $("div.modal2-con");
        if (this._cls_info.modalCon == undefined || this._cls_info.modalCon.length < 1) this._cls_info.modalCon = $("body");

        this._cls_info.modalPop = $(this._cls_info.pageModalfix);
        
        // this._cls_info._par_cls_info = this._cls_info.container._cls_info;

        this.fn_init_component();

        this.fn_init_click();
    }

    fn_popStep_get(){
        return this._cls_info.popStep;
    }
    fn_popStep_set(popStep){
        this._cls_info.popStep = popStep;
    }

    fn_popName_get(){
        return this._cls_info.popName;
    }
    fn_popName_set(popName){
        this._cls_info.popName = popName;
    }

    
    fn_init_title(popup_txt){
        $(this._cls_info.pageModalfix + ' .popup-head .popup-txt').html(popup_txt)
    }

    fn_init_component(){
        this.fn_init_sub_component();
    }

    fn_init_sub_component(){

    }
    
    fn_init_click( ){
        var owner = this;

        $(owner._cls_info.pageModalfix + ' .modal-close button[type="button"]').off('click').on('click', function(){
            owner.fn_close_popup();
        });

        this.fn_page_init_click();
    }

    fn_page_init_click(){
        this.fn_page_init_sub_click()
    }

    fn_page_init_sub_click(){

    }

    /* 코드값 객체를 받아서 저장*/
    fn_code_received(codeData){
        this._cls_info.codeData = codeData;
    }

    /*
        팝업창을 닫는 메서드
        현재는 modal에서 대신함
    */
    fn_close_popup(){
        $(this._cls_info.pageModalfix).removeClass("fade").modal("hide");

        if (this._cls_info.popup_param != undefined && this._cls_info.popup_param.isChanged > 0
            && this._cls_info.container != undefined && this._cls_info.container['fn_popup_selected'] != undefined){
            this._cls_info.container.fn_popup_selected('popup_data_changed', this._cls_info.popName, this._cls_info.popup_param, null, null);
        }
    }

    /* 
        팝업 찾을 여는 메서드
    */
    fn_show_popup(param){
        this._cls_info.popup_param = param;


        if (param == undefined || param.modalPop == undefined || param.modalPop){
            this._cls_info.modalPop.addClass('on');
        }

        this.fn_show_cls_popup(param);
        
        $(this._cls_info.pageModalfix).addClass("fade").modal("show");
    }

    /*
        하위 클래스에서 팝업을 열때 특정 액션
    */
    fn_show_cls_popup(param){

    }
}

/*
    디자인된 Alert 팝업화면(webview에서는 system alert이 안 되기 때문에 이걸 사용해야 함)
    ex)
    popAlert = new JsMvpPopupAlerts(window, '.modal.static.alert');
    $('.modal-trigger.btn_primary').click(function(){
        popAlert.fn_show_popup({});
    });
*/
class JsHouse2309PopupAlert extends JsHouse2309PopupBase{
    /*
        container   : 리턴을 넘겨주는 대상(Alert는 없다)
        cssSelector : jquery 경로
        popName : JsHouse2309PopupConfirm에서 넘겨주기 위한 파라미터
    */
    constructor(container, cssSelector, popName) {
        if (popName == undefined || popName.length < 1) popName = 'popAlert';
        super(container, cssSelector, popName, 512, {})
    }

    fn_init_component(){
        var elems = document.querySelectorAll(this._cls_info.pageModalfix);
        var instances = M.Modal.init(elems, {
            endingTop:'20%',
            dismissible:false, 
        });

        this._cls_info.ctlModal = instances[0];
        this.fn_init_sub_component();
    }

    fn_page_init_sub_click(){
        var owner = this;
        $(this._cls_info.pageModalfix + ' .btn.btn_primary').off('click').on('click', function(){
            owner.fn_close_popup();
        });
    }

    fn_close_popup(){
        this._cls_info.ctlModal.close();
    }

    
    fn_txt_btn_primary(txt){
        if (txt != undefined && txt.length > 0){
            $(this._cls_info.pageModalfix + ' .modal-footer .btn.btn_primary').val(txt);
        }else{
            $(this._cls_info.pageModalfix + ' .modal-footer .btn.btn_primary').val('확인');
        }
    }
    fn_txt_btn_cancel(txt){
        if (txt != undefined && txt.length > 0){
            $(this._cls_info.pageModalfix + ' .modal-footer .btn.btn_primary').val(txt);
        }else{
            $(this._cls_info.pageModalfix + ' .modal-footer .btn.btn_primary').val('취소');
        }
    }

    fn_txt_title(txt){
        $(this._cls_info.pageModalfix + ' .modal_header .modal_title').html((txt == undefined)?"":txt);
    }
    
    fn_txt_message(txt){
        $(this._cls_info.pageModalfix + ' .modal-content').html((txt == undefined)?"":txt);
    }

    async fn_show_popup(param){
        this.fn_txt_title(param.title_txt);
        this.fn_txt_message(param.message_txt);

        this.fn_txt_btn_primary(param.confirm_txt);

        this._cls_info.ctlModal.open();

        return this.fn_async();
    }
    async fn_async(){
        var owner = this;
        return new Promise((resolve) => {
            $(owner._cls_info.pageModalfix + ' .btn.btn_primary').off('click').on('click', function(){
                owner.fn_close_popup();
                resolve('confirm');
            });
            
          })
    }
}

/*
    디자인된 confirm 팝업화면(webview에서는 system confirm이 안 되기 때문에 이걸 사용해야 함)

    $('.modal-trigger.btn_cancel').click(function(){
        fn_show_confirm();
    });
    
    async function fn_show_confirm(){
        const asyncConfirm = await popConfirm.fn_show_popup({});
        console.log(asyncConfirm)
    }
*/
class JsHouse2309PopupConfirm extends JsHouse2309PopupAlert{
    constructor(container, cssSelector) {
        var popName = 'popConfirm';
        super(container, cssSelector, popName);
    }



    async fn_show_popup(param){
        
        this.fn_txt_btn_cancel(param.cancel_txt);

        super.fn_show_popup(param);

        return this.fn_async();
    }

    async fn_async(){
        var owner = this;
        return new Promise((resolve) => {
            $(owner._cls_info.pageModalfix + ' .btn.btn_primary').off('click').on('click', function(){
                owner.fn_close_popup();
                resolve('confirm');
            });
            $(owner._cls_info.pageModalfix + ' .btn.btn_cancel').off('click').on('click', function(){
                owner.fn_close_popup();
                resolve('reject');
            });
            
          })
    }
}


class JsMvpPopupAlerts extends JsHouse2309PopupAlert{

}
class JsMvpPopupConfirm extends JsHouse2309PopupConfirm{

}