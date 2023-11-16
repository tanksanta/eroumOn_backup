class JsHouse2309CodeConvert{
    constructor() {
        this._cls_info = { 
                            codeData:{}/*코드에서 받은 값*/
                            , codeConv:{}/*코드변환 값*/
                        };
    }

    receivedData(result_data){
        this._cls_info.codeData = result_data;
        this._cls_info.codeConv = {};
    }
}