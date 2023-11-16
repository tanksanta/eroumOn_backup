class JsHouse2309PageBase{
    constructor(prefix, prePop) {
        if (prefix == undefined) prefix = 'main#container .layout.page-content';
        if (prePop == undefined) prePop = 'main#container div.modal2-con';

        this._cls_info = { pagePrefix:prefix, pagePopPrefix:prePop
                        , ctlSearches:{}/*검색시 사용하는 컨트롤들*/
                        , ctlBtns:{}/*버튼들*/
                        , ctlComs:{}/*본문에 사용하는 컨트롤들*/
                        , popups:{}/*팝업들*/
                        , searched_data : null/* 뷰화면에서 받은 post값(리스트에서 항목을 선택한 후 뷰화면으로 이동을 한뒤)*/
                        , customData:{}/*각 화면별로 임시로 저장할 데이터*/
                        , codeCondition:null
                        , receivedData : null/*데이터를 호출 한 후 받은 값*/
                    };

        // this._cls_info.popups.waiting = new JsHousePop2305Waiting();
        // this._cls_info.popups.confirm = new JsHouse2305Confirm();;

        this._cls_info.jsCallApi = jsCallApi//new JsCallApi(null, null, null);
        this._cls_info.jsCommon = new JsCommon();
        this._cls_info.houseCode = new JsHouse2309CodeConvert();
    }

    
    fn_customdata_set(datakind, dataval){
        this._cls_info.customData[datakind] = dataval;
    }
    fn_popup_set(popkind, popObj){
        this._cls_info.popups[popkind] = popObj;
    }
    
    fn_searched_data(postdata){
        var json;
        console.log(postdata)
        if (postdata != undefined && postdata.length > 0){
            var bBool = false;
            try{
                json = JSON.parse(postdata);
                bBool = true;
            }catch{
    
            }

            if (!bBool){
                postdata = this._cls_info.jsCommon.unescapeHtml(postdata);

                try{
                    json = JSON.parse(postdata);
                    bBool = true;
                }catch{
        
                }
            }
            
        }
        
        this._cls_info.searched_data = json;
        
        this.fn_searched_sub_cls();
    }

    fn_searched_sub_cls(){
    }


    fn_page_resized(){

    }
    
    fn_page_init(){
        this.fn_init_addevent()

        this.fn_page_sub();

        this.fn_init_sub_addevent();
    }

    fn_page_sub(){

    }

    fn_init_addevent(){
        var owner = this;
        $( window ).resize( function() {
            owner.fn_page_resized();
        });
    }

    fn_init_sub_addevent(){

    }

    /*코드를 가져오기 위한 검색 조건들*/
    fn_code_condition(){/**/
        return null;
    }

    fn_code_cb_main(data, param, return_data){
        if (return_data != null && return_data.result_code == "1" && return_data.result_data != null){
            this._cls_info.houseCode.receivedData(return_data);
        }else{
            this._cls_info.houseCode.receivedData(null);
        }

        var data2 = this.fn_page_condition();
        if (data2 != undefined){
            this._cls_info.jsHouseHttp.call_svr4_post_json(this, 'fn_page_cb_main', data2, {});
            return;
        }
    }

    /*각 페이지 마다 해당하는 검색 조건들*/
    fn_page_condition(){
        return null;
    }

    /*처음으로 데이터를 콜 해주는 부분(1페이지 고정)*/
    fn_page_first_call(isCodeCallYn){
        if (isCodeCallYn != undefined && isCodeCallYn == true){
            var data;
            data = this.fn_code_condition();
            if (data != undefined){
                this._cls_info.jsHouseHttp.call_svr4_post_json(this, 'fn_code_cb_main', data, {});
                return;
            }
        }

        this.fn_page_second_call();
    }

    /*해당하는 페이지의 데이터를 가져온다*/
    fn_page_second_call(){
        var data;

        data = this.fn_page_condition();
        if (data != undefined){
            this._cls_info.jsHouseHttp.call_svr4_post_json(this, 'fn_page_cb_main', data, {});
            return;
        }
    }

    fn_page_cb_main(data, param, return_data){
        if (return_data == undefined ){ return; }

        this._cls_info.receivedData = return_data;

        this.fn_data_cb_subcls(data, param, return_data);
    }

    fn_data_cb_subcls(data, param, return_data){
        
    }

}