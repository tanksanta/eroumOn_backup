class JsMarketMypageIndex extends JsMarketOrdredDrawItems{
    constructor(cssSelector, ordredListJson, entrpsVOList, codeMapJson){
        super();

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
		}

		this._cls_info.queryString = "selPeriod=3";

        this._cls_info.pagePrefix = 'main#container div#page-content' ;
        this._cls_info.pagePopPrefix = 'main#container div.modal2-con';
        this._cls_info.pageOrdredListfix =  this._cls_info.pagePrefix + cssSelector;

        this.fn_draw_all_ordred_list();
    }

}
