class JsMargetCartDrawItems {
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
	fn_draw_cart_entrpsdlvygrp_item_business(json){
		return '<dl class="order-item-business">'+
			'<dt><span>사업소</span> <span>{0}</span></dt>'.format(json == undefined ? '' : json.entrpsNm)+
		'</dl>';
	}

	/*퍼블리싱에서 order-product => order-body => order-delivery-total 의 html*/
	fn_draw_cart_entrpsdlvygrp_delivery_title(bDlvyGrp, cnt, json){
		return '<div class="order-delivery-total">'+
			'<strong>{0}</strong>'.format(((bDlvyGrp?"묶음배송":"개별배송") + " " + ((bDlvyGrp && this._cls_info.bDev)?json.entrpsDlvygrpNm:"")))+
			'<strong class="price2">{0}개</strong>'.format(cnt)+
		'</div>';
	}

	fn_draw_cart_entrpsdlvygrp_list(cssSelector, cartListJson){
        if (cartListJson == undefined) return;
		if (this._cls_info.entrpsDlvyGrpVOList == undefined) return;
		if (this._cls_info.entrpsVOList == undefined) return;
		
		var ifor, ilen = this._cls_info.entrpsVOList.length;
		var arrEachEntrpsAllItems;
		var entrpsVO;
		var arrEntrpsItemIdx;
		var arrHtml = [];
		var strHtml;

        for(ifor=0 ; ifor<ilen ; ifor++){/*사업소별 항목을 그린다*/
			entrpsVO = this._cls_info.entrpsVOList[ifor];

			arrEntrpsItemIdx = [];
			arrEachEntrpsAllItems = cartListJson.filter(function(item, idex) {
				if (item.gdsInfo != undefined && item.gdsInfo.entrpsNo == entrpsVO.entrpsNo) {
					arrEntrpsItemIdx.push(idex);
					return true;
				}
			});

			/*해당하는 아이템이 없다, 복지용구, 바로구매 2가지가 있어서 체크를 한다.*/
			if (arrEachEntrpsAllItems == undefined || arrEachEntrpsAllItems.length < 1){
				continue;
			}

			this.fn_draw_delelte_items(cartListJson, arrEntrpsItemIdx);

			arrHtml.push('<div class="order-product" recipterUniqueId="{0}" entrpsNo="{2}" cartTy="{1}">'.format(arrEachEntrpsAllItems[0].recipterUniqueId, arrEachEntrpsAllItems[0].cartTy, entrpsVO.entrpsNo));
			arrHtml.push(	'<div class="order-body">');
			strHtml = this.fn_draw_cart_entrpsdlvygrp_item_business(entrpsVO);
			arrHtml.push(strHtml);
			strHtml = this.fn_draw_cart_entrpsdlvygrp_each_entrps_list(cssSelector + " div.cart-list-box", entrpsVO, arrEachEntrpsAllItems);
			arrHtml.push(strHtml);
			arrHtml.push(	'</div>');
			arrHtml.push('</div>');
        }

		$(cssSelector + " div.cart-list-box").html(arrHtml.join(''));
    }


	fn_draw_cart_entrpsdlvygrp_each_entrps_list(cssSelector, entrpsVO, arrEachEntrpsAllItems){
		var jfor, jlen;
		var entrpsDlvyGrpInfo;
		var arrEachDlvyGrpItems;
		var arrEntrpsItemAllIdx;
		var arrEntrpsDlvyGrp;
		var arrEntRpsHtml = [];
		var strHtml;

		/*입점업체별 그룹배송*/
		arrEntrpsDlvyGrp = this._cls_info.entrpsDlvyGrpVOList.filter(function(item, idex) {
			if (item.entrpsNo == entrpsVO.entrpsNo) {
				return true;
			}
		});

		jlen = arrEntrpsDlvyGrp.length;
		
		
		/*****************************묶음 배송 그룹별 항목을 그린다. 시작*****************************/
		for(jfor=0 ; jfor<jlen ; jfor++){
			entrpsDlvyGrpInfo = arrEntrpsDlvyGrp[jfor];

			arrEntrpsItemAllIdx = [];
			arrEachDlvyGrpItems = arrEachEntrpsAllItems.filter(function(item, idex) {
				if (item.gdsInfo != null && item.gdsInfo.entrpsNo == entrpsDlvyGrpInfo.entrpsNo 
										&& item.gdsInfo.entrpsDlvygrpNo == entrpsDlvyGrpInfo.entrpsDlvygrpNo) {
					arrEntrpsItemAllIdx.push(idex);
					return true;
				}
			});
			
			if (arrEachDlvyGrpItems.length <= 1) continue;/*1개짜리는 따로 그린다*/

			this.fn_draw_delelte_items(arrEachEntrpsAllItems, arrEntrpsItemAllIdx);
			
			strHtml = this.fn_draw_cart_entrpsdlvygrp_each_dlvygrp_list(cssSelector, entrpsVO, entrpsDlvyGrpInfo, arrEachDlvyGrpItems);
			arrEntRpsHtml.push(strHtml);
			
		}

		/*****************************묶음 배송 그룹별 항목을 그린다. 끝*****************************/


		/*****************************개별 배송 그룹별 항목을 그린다. cart_grp_no별로 그려야 한다. 시작*****************************/
		
		var arrItemGrp = [];
		var arrCartGrpBaseAllList, arrCartGrpAditAllList;
		arrEachEntrpsAllItems.forEach((item) => {
			if (arrItemGrp.indexOf(item.cartGrpNo) === -1) {
				arrItemGrp.push(item.cartGrpNo);
			}
		});

		jlen = arrItemGrp.length;

		if (jlen == 0) {
			return arrEntRpsHtml.join('');
		}
		
		strHtml = this.fn_draw_cart_entrpsdlvygrp_delivery_title(false, jlen, null)
		arrEntRpsHtml.push(strHtml);

		
		for(jfor=0 ; jfor<jlen ; jfor++){
			arrEntrpsItemAllIdx = [];
			arrCartGrpBaseAllList = arrEachEntrpsAllItems.filter(function(item, idex) {
				if (item.ordrOptnTy == 'BASE' && item.cartGrpNo == arrItemGrp[jfor]) {
					arrEntrpsItemAllIdx.push(idex);
					return true;
				}
			});
			arrCartGrpAditAllList = arrEachEntrpsAllItems.filter(function(item, idex) {
				if (item.ordrOptnTy == 'ADIT' && item.cartNo != item.cartGrpNo && item.cartGrpNo == arrItemGrp[jfor]) {
					arrEntrpsItemAllIdx.push(idex);
					return true;
				}
			});

			this.fn_draw_delelte_items(arrEachEntrpsAllItems, arrEntrpsItemAllIdx);

			strHtml = this.fn_draw_cart_entrpsdlvygrp_itemgrp_one(null, arrCartGrpBaseAllList, arrCartGrpAditAllList);
			arrEntRpsHtml.push(strHtml);

			strHtml = this.fn_draw_cart_entrpsdlvygrp_delivery_summary_each(arrCartGrpBaseAllList, arrCartGrpAditAllList);
			arrEntRpsHtml.push(strHtml);
		}


		/*****************************개별 배송 그룹별 항목을 그린다. cart_grp_no별로 그려야 한다. 끝*****************************/

		return arrEntRpsHtml.join('');
	}


	fn_draw_cart_entrpsdlvygrp_each_dlvygrp_list(cssSelector, entrpsVO, entrpsDlvyGrpInfo, arrEachItems){
		var cartIdx = [], arrItemGrp = [];
		var cloneEachItems = arrEachItems.clone();

		arrEachItems.forEach((item) => {
			if (arrItemGrp.indexOf(item.cartGrpNo) === -1) {
				arrItemGrp.push(item.cartGrpNo);
			}
		});
		var arrItems = [];
		var strHtml;

		strHtml = this.fn_draw_cart_entrpsdlvygrp_delivery_title(true, arrItemGrp.length, entrpsDlvyGrpInfo)
		arrItems.push(strHtml);
		
		var arrCartGrpBaseAllList = [], arrCartGrpAditAllList = [];
		var kfor, klen = arrItemGrp.length;
		for(kfor=0 ; kfor<klen ; kfor++){
			cartIdx = [];
			arrCartGrpBaseAllList = arrEachItems.filter(function(item, idex) {
				if (item.ordrOptnTy == 'BASE' && item.cartGrpNo == arrItemGrp[kfor]) {
					cartIdx.push(idex);
					return true;
				}
			});
			arrCartGrpAditAllList = arrEachItems.filter(function(item, idex) {
				if (item.ordrOptnTy == 'ADIT' && item.cartNo != item.cartGrpNo && item.cartGrpNo == arrItemGrp[kfor]) {
					cartIdx.push(idex);
					return true;
				}
			});

			this.fn_draw_delelte_items(arrEachItems, cartIdx);

			strHtml = this.fn_draw_cart_entrpsdlvygrp_itemgrp_one(entrpsDlvyGrpInfo, arrCartGrpBaseAllList, arrCartGrpAditAllList);
			arrItems.push(strHtml);
		}

		arrCartGrpBaseAllList = cloneEachItems.filter(function(item, idex) {
			if (item.ordrOptnTy == 'BASE' ) {
				cartIdx.push(idex);
				return true;
			}
		});
		arrCartGrpAditAllList = cloneEachItems.filter(function(item, idex) {
			if (item.ordrOptnTy == 'ADIT' && item.cartNo != item.cartGrpNo ) {
				cartIdx.push(idex);
				return true;
			}
		});
		strHtml = this.fn_draw_cart_entrpsdlvygrp_delivery_summary_grp(entrpsDlvyGrpInfo, arrCartGrpBaseAllList, arrCartGrpAditAllList);
		arrItems.push(strHtml);

		return arrItems.join('');
	}

	
	/*각 상품별 리스트*/
	fn_draw_cart_entrpsdlvygrp_itemgrp_one(entrpsDlvyGrpInfo, arrCartGrpBaseAllList, arrCartGrpAditAllList){
		var strItemOptionBase = this.fn_draw_cart_entrpsdlvygrp_itemgrp_base_list(arrCartGrpBaseAllList);
		var strItemOptionAdit = this.fn_draw_cart_entrpsdlvygrp_itemgrp_adit_list(arrCartGrpAditAllList);
		var dlvyBaseAmt = this._cls_info.coms.jsMarketCartDlvyBaseCalc.fn_calc_cartgrp_each_dlvy_base(arrCartGrpBaseAllList, arrCartGrpAditAllList);

		var json = arrCartGrpBaseAllList[0];
		var thumbnailFile = "/html/page/market/assets/images/noimg.png";
		if (json.gdsInfo.thumbnailFile != undefined){
			thumbnailFile = "/comm/getImage?srvcId=GDS&amp;upNo=" + json.gdsInfo.thumbnailFile.upNo +"&amp;fileTy="+json.gdsInfo.thumbnailFile.fileTy +"&amp;fileNo="+json.gdsInfo.thumbnailFile.fileNo +"&amp;thumbYn=Y";
		}

		var cartGrpMoney = this._cls_info.coms.jsMarketCartDlvyBaseCalc.fn_calc_cart_grp_sum_money(arrCartGrpBaseAllList, arrCartGrpAditAllList);

		var original_price = '';
		if (cartGrpMoney.originPc != cartGrpMoney.ordrPc){
			original_price = '<span class="original-price">{0}원</span>'.format(cartGrpMoney.originPc.format_money());
		}

		var entrpsDlvygrpAttr = '', entrpsDlvygrpCls = '';
		if (entrpsDlvyGrpInfo != undefined && entrpsDlvyGrpInfo.entrpsDlvygrpNo != undefined){
			entrpsDlvygrpAttr = ' entrpsDlvygrpNo="{0}"'.format(entrpsDlvyGrpInfo.entrpsDlvygrpNo);
			entrpsDlvygrpCls = ' entrpsDlvygrpNo ';
		}

		var soldoutYn = json.gdsInfo.soldoutYn;
		if (json.gdsInfo.stockQy == undefined || json.gdsInfo.stockQy < 1 ){
			soldoutYn = 'Y';
		}
		
		var strHtml = ''+
			'<div class="order-product-inner cartGrp{2}" cartGrpNo="{0}" {1} ctgryNo="{3}" gdsCd="{4}">'.format(json.cartGrpNo, entrpsDlvygrpAttr, entrpsDlvygrpCls, json.gdsInfo.ctgryNo, json.gdsInfo.gdsCd)+
				'<div class="order-product-item">'+
					'<div class="item-thumb">'+
						'<div class="form-check">'+
							'<input class="form-check-input cartGrpNo" type="checkbox" name="cartGrpNo" value="{0}" cartGrpNo="{0}">'.format(json.cartGrpNo)+
						'</div>'+
						'<div class="order-item-thumb">'+
							'<img src="{0}" alt="">'.format(thumbnailFile)+
						'</div>'+
					'</div>'+
					'<div class="item-name">'+
						'<div class="order-item-base">'+
							'<p class="code">'+
								'<span class="label-primary">'+
									'<span>{0}</span>'.format(this._cls_info.codeMapJson.gdsTyCode[json.gdsInfo.gdsTy])+
									'<i></i>'+
								'</span>'+
								'<u class="gdsCd">{0}</u>'.format(json.gdsCd)+
							'</p>'+
							'<div class="product">'+
								'<p class="name">{0}</p>'.format(json.gdsNm)+
							'</div>'+
						'</div>'+
					'</div>'+
					'<div class="item-price">'+
						'<div class="pay-info">'+
							'<p class="pay-amount">주문수량<span>{0}</span>개</p>'.format(cartGrpMoney.ordrQy.format_money())+
							'<div class="pay-price">'+
								original_price+
								'<strong class="price">{0}원</strong>'.format(cartGrpMoney.ordrPc.format_money())+
							'</div>'+
						'</div>'+
					'</div>'+
					'<div class="item-option">'+
						'<dl class="option">'+
						strItemOptionBase+
						'</dl>'+
						strItemOptionAdit+
					'</div>'+
					'<div class="item-btn"><button class="btn btn-primary f_optn_chg" data-bs-toggle="modal" data-bs-target="#countModal" cartGrpNo="{0}">주문 수정</button></div>'.format(json.cartGrpNo)+
					((soldoutYn == 'Y') ? this.fn_draw_cart_entrpsdlvygrp_itemgrp_sold_out():'') + 
					'<input type="hidden" name="dlvyBaseAmt" value="{0}">'.format(dlvyBaseAmt)+
				'</div>'+
			'</div>';

		return strHtml;
	}

	fn_draw_cart_entrpsdlvygrp_itemgrp_base_list(arrCartGrpBaseAllList){
		var efor, elen = arrCartGrpBaseAllList.length;

		var arrTemp = [];
		for(efor = 0; efor<elen ; efor++){
			arrTemp.push(this.fn_draw_cart_entrpsdlvygrp_itemgrp_base_one(arrCartGrpBaseAllList[efor]));
		}

		return arrTemp.join('');
	}

	fn_draw_cart_entrpsdlvygrp_itemgrp_base_one(json){
		
		var baseOptnOne, aditOptnList = json.gdsInfo.optnList;

		if (aditOptnList.length == 0) return; /*옵션 자체가 없으면 표시 안함*/

		baseOptnOne = aditOptnList.filter(function(item, idex) {
			if (json.gdsOptnNo == item.gdsOptnNo) {
				return true;
			}
		});

		var soldOutYn = 'N';
		if (json.gdsInfo.soldoutYn == 'Y'){
			soldOutYn = json.gdsInfo.soldoutYn;
		}else if (baseOptnOne != undefined && baseOptnOne.length > 0 && baseOptnOne[0].soldOutYn == 'Y') {
			soldOutYn = baseOptnOne[0].soldOutYn;
		}

		var list = json.ordrOptn.split(' * ');
		var arrTemp = [];
		var efor, elen = list.length;
		for(efor = 0; efor<elen ; efor++){
			if (list[efor] != undefined && list[efor].length > 0){
				arrTemp.push('<span class="label-flat">{0}</span>'.format(list[efor]));
			}
		}

		var soldOutTxt = ((soldOutYn == 'Y')?'<strong class="text-soldout">일시품절</strong>':'');
		var soldOutCls = ((soldOutYn == 'Y')?' disabled ':'');
		var ableBuy = ((soldOutYn=='Y')?'N':'Y');
		var btnDelte = '<button class="btn-delete2 cart gdsOptn base" ordrOptnTy="BASE" cartNo="{0}" cartGrpNo="{1}" gdsOptnNo="{2}" ableBuy="{3}">삭제</button>';

		var ordrOptnPcDisp = '';
		if (json.ordrOptnPc > 0){
			ordrOptnPcDisp = "(+{0}원)".format(json.ordrOptnPc.format_money());
		}

		var strHtml = '<dd class="{0}">'.format(soldOutCls)+
					arrTemp.join('')+
					'<span>{0}개 {1}</span>'.format(json.ordrQy, ordrOptnPcDisp)+
					soldOutTxt+
					btnDelte.format(json.cartNo, json.cartGrpNo, json.gdsOptnNo, ableBuy)+
					this.fn_draw_cart_entrpsdlvygrp_input_hidden("BASE", json, baseOptnOne, ableBuy)+
				'</dd>';

		return strHtml;
	}

	fn_draw_cart_entrpsdlvygrp_itemgrp_adit_list(arrCartGrpAditAllList){
		var efor, elen = arrCartGrpAditAllList.length;

		if (elen.length < 1){
			return '';
		}

		var arrTemp = [];
		arrTemp.push('<div class="item-add-box">');
		for(efor = 0; efor<elen ; efor++){
			arrTemp.push(this.fn_draw_cart_entrpsdlvygrp_itemgrp_adit_one(arrCartGrpAditAllList[efor]));
		}
		arrTemp.push('</div>');
		return arrTemp.join('');
	}

	fn_draw_cart_entrpsdlvygrp_itemgrp_adit_one(json){
		var aditOptnOne, aditOptnList = json.gdsInfo.aditOptnList;
		aditOptnOne = aditOptnList.filter(function(item, idex) {
			if (json.gdsOptnNo == item.gdsOptnNo) {
				return true;
			}
		});

		if (aditOptnOne == undefined || aditOptnOne.length == 0){
			return '';
		}

		aditOptnOne = aditOptnOne[0];
		var soldOutTxt = ((aditOptnOne.soldOutYn == 'Y')?'<strong class="text-soldout">일시품절</strong>':'');
		var soldOutCls = ((aditOptnOne.soldOutYn == 'Y')?' disabled ':'');
		var ableBuy = aditOptnOne.soldOutYn=='Y'?'N':'Y';
		var btnDelte = '<button class="btn-delete2 cart gdsOptn adit" ordrOptnTy="ADIT" cartNo="{0}" cartGrpNo="{1}" gdsOptnNo="{2}" ableBuy="{3}">삭제</button>';

		var optnNm = aditOptnOne.optnNm.split("*");
		var strHtml = ''+
			'<div class="item-add">'+
				'<dd class="item-add-one {0}">'.format(soldOutCls)+
					'<span class="label-outline-primary">'+
						'<span>{0}</span>'.format(optnNm[0].trim())+
						'<i><img src="/html/page/market/assets/images/ico-plus-white.svg" alt=""></i>'+
					'</span>'+
					'<div class="name">'+
						'<span class="font-semibold">{0}</span>'.format(optnNm[1].trim())+
						'<span class="font-semibold">{0}개</span>'.format(json.ordrQy)+
						'<span>(+{0}원)</span>'.format((aditOptnOne.optnPc * json.ordrQy).format_money())+
						soldOutTxt+
						btnDelte.format(json.cartNo, json.cartGrpNo, json.gdsOptnNo, ableBuy)+
					'</div>'+
				'</dd>'+
				this.fn_draw_cart_entrpsdlvygrp_input_hidden("ADIT", json, aditOptnOne, ableBuy)+
			'</div>';	
						
		return strHtml;
	}

	/*
		묶음배송
		entrpsDlvyGrpInfo : 묶음배송 정보
		arrCartGrpBaseAllList : 기본 상품 전체
		arrCartGrpAditAllList : 추가 상품 전체
	*/
	fn_draw_cart_entrpsdlvygrp_delivery_summary_grp(entrpsDlvyGrpInfo, arrCartGrpBaseAllList, arrCartGrpAditAllList){
		var objDlvyBase = this._cls_info.coms.jsMarketCartDlvyBaseCalc.fn_calc_cartgrp_grp_dlvy_base(entrpsDlvyGrpInfo, arrCartGrpBaseAllList, arrCartGrpAditAllList);
		var dlvyBaseAmtNm;
		if (objDlvyBase.dlvyBaseAmt == 0){
			dlvyBaseAmtNm = "무료";
		}else{
			dlvyBaseAmtNm = objDlvyBase.dlvyBaseAmt.format_money() +  "원";
		}
		return '<dl class="order-item-payment entrpsDlvygrpNo" entrpsDlvygrpNo="{0}">'.format(entrpsDlvyGrpInfo.entrpsDlvygrpNo)+
			'<dt>위 {0}건 함께 주문시 배송비<input type="hidden" name="dlvyGrpBaseAmt" value="{1}"></dt>'.format(objDlvyBase.count, objDlvyBase.dlvyBaseAmt)+
			'<dd class="delivery-charge">{0}</dd>'.format(dlvyBaseAmtNm)+
		'</dl>';
	}

	
	/*퍼블리싱에서 order-product => order-body => order-item-payment 의 html*/
	/*
		개별 배송
		arrCartGrpBaseList : 기본 상품 리스트
		arrCartGrpAditList : 추가 상품 리스트
	*/
	fn_draw_cart_entrpsdlvygrp_delivery_summary_each(arrCartGrpBaseList, arrCartGrpAditList){
		var dlvyBaseAmt = this._cls_info.coms.jsMarketCartDlvyBaseCalc.fn_calc_cartgrp_each_dlvy_base(arrCartGrpBaseList, arrCartGrpAditList);
		var dlvyBaseAmtNm;
		if (dlvyBaseAmt == 0){
			dlvyBaseAmtNm = "무료";
		}else{
			dlvyBaseAmtNm = dlvyBaseAmt.format_money() +  "원";
		}

		var strHtml = '<dl class="order-item-payment">'+
			'<dt>배송비<input type="hidden" name="dlvyBaseAmt" value="{0}"></dt>'.format(dlvyBaseAmt)+
			'<dd class="delivery-charge">{0}</dd>'.format(dlvyBaseAmtNm)+
		'</dl>';
		
		return strHtml;
	}


	fn_draw_cart_entrpsdlvygrp_itemgrp_sold_out(){
		return '';
	}

	fn_draw_cart_entrpsdlvygrp_input_hidden(ordrOptnTy, json, aditOptnOne, ableBuy){
		return 'input hidden area'
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