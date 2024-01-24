class JsMarketOrdredDone extends JsMarketOrdredDrawItems{
    constructor(cssSelector, ordredListJson, entrpsVOList, codeMapJson){
        super();

        this._cls_info.dispOptions.body.status.f_rtrcn_msg = false;
        this._cls_info.dispOptions.body.status.f_return_msg = false;
        this._cls_info.dispOptions.body.status.f_exchng_msg = false;
        this._cls_info.dispOptions.body.status.f_gds_exchng = false;
        this._cls_info.dispOptions.body.status.f_ordr_done = false;
        this._cls_info.dispOptions.body.status.f_partners_msg = false;
        this._cls_info.dispOptions.footer.f_ordr_return = false;

        console.log(ordredListJson)
		if (ordredListJson.trim().length > 0){
			this._cls_info.ordredList = JSON.parse(ordredListJson);
            this._cls_info.drawOrdredList = JSON.parse(ordredListJson);
		}

		console.log(entrpsVOList)
		if (entrpsVOList.trim().length > 0){
			this._cls_info.entrpsVOList = JSON.parse(entrpsVOList);
		}

		console.log(codeMapJson)
		if (codeMapJson.trim().length > 0){
			this._cls_info.codeMapJson = JSON.parse(codeMapJson);
            this._cls_info.codeMapJson.dlvyCoList = [];/*주문을 완료한 시점이기 때문에 회사가 있을주 없지만 조건은 맞춤*/
		}

        this._cls_info.pagePrefix = 'main#container div#page-content' ;
        this._cls_info.pagePopPrefix = 'main#container div.modal2-con';
        this._cls_info.pageOrdredListfix =  this._cls_info.pagePrefix + cssSelector;

        this.fn_draw_all_ordred_list();
    }

}
