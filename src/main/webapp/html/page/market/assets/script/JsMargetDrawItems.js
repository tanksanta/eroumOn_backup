class JsMargetDrawItems {
    constructor(){
        this._cls_info = this._cls_info || {};

		this._cls_info.bDev = true;

		this._cls_info.coms = {jsMarketCartDlvyBaseCalc : new JsMarketCartDlvyBaseCalc(), jsCommon : new JsCommon()};
		
		this._cls_info.popups = {};
    }

    fn_page_init(){
        this.fn_init_addevent()

        this.fn_page_sub();

        this.fn_init_sub_addevent();
    }

    fn_page_sub(){

    }

    fn_init_addevent(){
        
    }

    fn_init_sub_addevent(){
        var owner = this;

    }

    
    
	fn_draw_delelte_items(arrOrigin, arrIndexes){
		var dfor, dlen;

		dlen = arrIndexes.length - 1;
		for(dfor=dlen ; dfor>=0 ; dfor--){
			arrOrigin.splice(arrIndexes[dfor], 1);/*이미 선택한 상품은 제외 한다.*/
		}
	}
    
	/*퍼블리싱에서 order-product => order-body => order-item-business 의 html*/
	fn_draw_html_order_item_business(json){
		return '<dl class="order-item-business">'+
			'<dt><span>사업소</span> <span>{0}</span></dt>'.format(json == undefined ? '' : json.entrpsNm)+
		'</dl>';
	}

	/*퍼블리싱에서 order-product => order-body => order-delivery-total 의 html*/
	fn_draw_html_order_delivery_title(bDlvyGrp, cnt, json){
		return '<div class="order-delivery-total">'+
			'<strong>{0}</strong>'.format(((bDlvyGrp?"묶음배송":"개별배송") + " " + ((bDlvyGrp && this._cls_info.bDev)?json.entrpsDlvygrpNm:"")))+
			'<strong class="price2">{0}개</strong>'.format(cnt)+
		'</div>';
	}
}

/*배송비 항목을 넘겨주면 배송비를 계산해 주는 함수*/
class JsMarketCartDlvyBaseCalc{


	/*전체 상품 금액을 더한다.*/
	fn_calc_cart_grp_sum_money(arrCartGrpBaseList, arrCartGrpAditList){
		var ifor, ilen, cartItemOne;
		var ret = {ordrQy:0, ordrPc:0, originPc:0};
		
		ilen = arrCartGrpBaseList.length;
		for(ifor=0 ; ifor<ilen ; ifor++){
			cartItemOne = arrCartGrpBaseList[ifor];

			ret.ordrQy += cartItemOne.ordrQy;
			ret.ordrPc += cartItemOne.ordrPc;

			ret.originPc += (cartItemOne.ordrQy * (cartItemOne.gdsInfo.pc + cartItemOne.ordrOptnPc));
		}

		ilen = arrCartGrpAditList.length;
		for(ifor=0 ; ifor<ilen ; ifor++){
			cartItemOne = arrCartGrpAditList[ifor];

			ret.ordrQy += cartItemOne.ordrQy;
			ret.ordrPc += cartItemOne.ordrPc;

			ret.originPc += cartItemOne.ordrPc;
		}

		return ret;
	}

	/*
		entrpsDlvyGrpInfo : 그룹배송
	*/
    fn_calc_cartgrp_grp_dlvy_base(entrpsDlvyGrpInfo, arrCartGrpBaseList, arrCartGrpAditList){
		if (arrCartGrpBaseList == undefined || arrCartGrpBaseList.length < 1){
			return {"dlvyBaseAmt":0, "dlvyAditAmt":0, "count":0};
		}
		var arrCartGrpList = arrCartGrpBaseList.concat(arrCartGrpAditList);
		var arrItemGrp = [];
		arrCartGrpBaseList.forEach((item) => {
			if (arrItemGrp.indexOf(item.cartGrpNo) === -1) {
				arrItemGrp.push(item.cartGrpNo);
			}
		});

		var dlvyCalcTy = entrpsDlvyGrpInfo.dlvyCalcTy;
		var dlvyBaseAmt = 0, cartBaseAmt;

		var ifor, ilen = arrItemGrp.length;
		for(ifor=0 ; ifor<ilen ; ifor++){
			arrCartGrpBaseList = arrCartGrpList.filter(function(item, idex) {
				if (item.ordrOptnTy == 'BASE' && item.cartGrpNo == arrItemGrp[ifor]) {
					return true;
				}
			});
			arrCartGrpAditList = arrCartGrpList.filter(function(item, idex) {
				if (item.ordrOptnTy == 'ADIT' && item.cartNo != item.cartGrpNo && item.cartGrpNo == arrItemGrp[ifor]) {
					return true;
				}
			});

			cartBaseAmt = this.fn_calc_cartgrp_each_dlvy_base(arrCartGrpBaseList, arrCartGrpAditList);

			if (dlvyCalcTy == 'MAX'){
				dlvyBaseAmt = Math.max(dlvyBaseAmt, cartBaseAmt);
			}else if(dlvyCalcTy == 'MIN'){
				if (dlvyBaseAmt == 0){
					dlvyBaseAmt = cartBaseAmt;
				}else{
					dlvyBaseAmt = Math.min(dlvyBaseAmt, cartBaseAmt);
				}
				
				if (dlvyBaseAmt == 0){
					ifor = ilen;/*배송비 0원 이면 더이상 계산할 필요없다*/
				}
			}else{
				throw new Error("JsMarketCartDlvyBaseCalc.fn_calc_cartgrp_dlvygrp_base dlvyCalcTy["+dlvyCalcTy+"] error")
			}
		}

		return {dlvyBaseAmt, "dlvyAditAmt":entrpsDlvyGrpInfo.dlvyAditAmt, count:ilen}
	}

	/*
		개별 배송비
		각 장바구니의 항목 그룹별 배송비를 계산
	*/
	fn_calc_cartgrp_each_dlvy_base(arrCartGrpBaseList, arrCartGrpAditList){
		var items_money = this.fn_calc_cart_grp_sum_money(arrCartGrpBaseList, arrCartGrpAditList);
		var gdsInfo = arrCartGrpBaseList[0].gdsInfo;

		var dlvyBaseAmt = 0;

		if (gdsInfo.dlvyCtTy == 'FREE'){
			dlvyBaseAmt = 0;
		} else if (gdsInfo.dlvyCtTy == 'OVERMONEY'){
			var ordrPc = items_money.ordrPc;
			// if (gdsInfo.dscntRt != undefined && gdsInfo.dscntRt > 0 && gdsInfo.dscntPc != undefined && gdsInfo.dscntPc > 0){
			// 	ordrPc = gdsInfo.dscntPc;
			// }
			if (ordrPc >= gdsInfo.dlvyCtCnd){
				dlvyBaseAmt = 0;
			}else{
				dlvyBaseAmt = gdsInfo.dlvyBassAmt;
			}
		} else if (gdsInfo.dlvyCtTy == 'PERCOUNT' && !isNaN(gdsInfo.dlvyCtCnd) && gdsInfo.dlvyCtCnd != 0){
			dlvyBaseAmt = (gdsInfo.dlvyBassAmt * Math.ceil(items_money.ordrQy / gdsInfo.dlvyCtCnd));

		} else {//if (gdsInfo.dlvyCtTy == 'PAY')
			dlvyBaseAmt = gdsInfo.dlvyBassAmt;
		}

		return dlvyBaseAmt;
	}
}