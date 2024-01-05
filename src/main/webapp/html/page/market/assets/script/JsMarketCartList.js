class JsMarketCartList extends JsMargetDrawItems{
    constructor(path, mbrSession, cartListWelfareJson, cartListOrdrJson, entrpsDlvyGrpVOList, entrpsVOList, codeMapJson){
        super();
		this._cls_info.bDev = true;

        this._cls_info.mbrSession = mbrSession;
        this._cls_info._membershipPath = path._membershipPath;
        this._cls_info._marketPath = path._marketPath;


		console.log(cartListWelfareJson)
		if (cartListWelfareJson.trim().length > 0){
			this._cls_info.cartListWelfareJson = JSON.parse(cartListWelfareJson.trim());
			// this._cls_info.drawCartList = JSON.parse(cartList);
		}

        console.log(cartListOrdrJson)
        if (cartListOrdrJson.trim().length > 0){
			this._cls_info.cartListOrdrJson = JSON.parse(cartListOrdrJson.trim());
			// this._cls_info.drawCartList = JSON.parse(cartList);
		}

		console.log(entrpsDlvyGrpVOList)
		if (entrpsDlvyGrpVOList.trim().length > 0){
			this._cls_info.entrpsDlvyGrpVOList = JSON.parse(entrpsDlvyGrpVOList);
		}

		console.log(entrpsVOList)
		if (entrpsVOList.trim().length > 0){
			this._cls_info.entrpsVOList = JSON.parse(entrpsVOList);
		}
        
		console.log(codeMapJson)
		if (codeMapJson.trim().length > 0){
			this._cls_info.codeMapJson = JSON.parse(codeMapJson);

			this._cls_info.ordrCd = this._cls_info.codeMapJson.ordrCd;
			this._cls_info.dlvyCtAditRgnYn = this._cls_info.codeMapJson.dlvyCtAditRgnYn;
		}
		
        this._cls_info.pagePrefix = 'main#container div#page-content' ;
        this._cls_info.pagePopPrefix = 'main#container div.modal2-con';

		
        if (this._cls_info.cartListWelfareJson == undefined || this._cls_info.cartListWelfareJson.length == 0){
            $(this._cls_info.pagePrefix + " .cart-list-container.welfare").addClass("hidden");
			$(this._cls_info.pagePrefix + " .cart-list-container.ordr").removeClass("mt-20");

			$(this._cls_info.pagePrefix + " .cart-list-container.welfare .cart-list-box").html('')
        }else{
            $(this._cls_info.pagePrefix + " .cart-list-container.welfare").removeClass("hidden");
			$(this._cls_info.pagePrefix + " .cart-list-container.ordr").addClass("mt-20");

            this.fn_draw_cart_list(".cart-list-container.welfare", this._cls_info.cartListWelfareJson);
        }
        
		if (this._cls_info.cartListOrdrJson == undefined || this._cls_info.cartListOrdrJson.length == 0){
			$(this._cls_info.pagePrefix + " .cart-list-container.ordr .cart-list-none").removeClass("hidden");
			$(this._cls_info.pagePrefix + " .cart-list-container.ordr .cart-list-box").addClass("hidden");
		}else{
			$(this._cls_info.pagePrefix + " .cart-list-container.ordr .cart-list-none").addClass("hidden");
			$(this._cls_info.pagePrefix + " .cart-list-container.ordr .cart-list-box").removeClass("hidden");
			this.fn_draw_cart_list(".cart-list-container.ordr", this._cls_info.cartListOrdrJson);
		}
        
    }


    fn_draw_cart_list(cssSelector, cartListJson){
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

			arrHtml.push('<div class="order-product">');
			arrHtml.push(	'<div class="order-body">');
			strHtml = this.fn_draw_html_order_item_business(entrpsVO);
			arrHtml.push(strHtml);
			strHtml = this.fn_draw_cart_each_entrps_list(cssSelector + " div.cart-list-box", entrpsVO, arrEachEntrpsAllItems);
			arrHtml.push(strHtml);
			arrHtml.push(	'</div>');
			arrHtml.push('</div>');
        }

		$(cssSelector + " div.cart-list-box").html(arrHtml.join(''));
    }

	fn_draw_cart_each_entrps_list(cssSelector, entrpsVO, arrEachEntrpsAllItems){
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
			
			strHtml = this.fn_draw_cart_each_dlvygrp_list(cssSelector, entrpsVO, entrpsDlvyGrpInfo, arrEachDlvyGrpItems);
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
		
		strHtml = this.fn_draw_html_order_delivery_title(false, jlen, null)
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

			strHtml = this.fn_draw_cart_itemgrp_one(cssSelector, arrCartGrpBaseAllList, arrCartGrpAditAllList);
			arrEntRpsHtml.push(strHtml);

			strHtml = this.fn_draw_html_order_delivery_summary_each();
			arrEntRpsHtml.push(strHtml);
		}


		/*****************************개별 배송 그룹별 항목을 그린다. cart_grp_no별로 그려야 한다. 끝*****************************/

		return arrEntRpsHtml.join('');
	}


	fn_draw_cart_each_dlvygrp_list(cssSelector, entrpsVO, entrpsDlvyGrpInfo, arrEachItems){
		var cartIdx = [], arrItemGrp = [];

		arrEachItems.forEach((item) => {
			if (arrItemGrp.indexOf(item.cartGrpNo) === -1) {
				arrItemGrp.push(item.cartGrpNo);
			}
		});
		var arrItems = [];
		var strHtml;

		strHtml = this.fn_draw_html_order_delivery_title(true, arrItemGrp.length, entrpsDlvyGrpInfo)
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

			strHtml = this.fn_draw_cart_itemgrp_one(cssSelector, arrCartGrpBaseAllList, arrCartGrpAditAllList);
			arrItems.push(strHtml);
		}

		strHtml = this.fn_draw_html_order_delivery_summary_each();
		arrItems.push(strHtml);

		return arrItems.join('');
	}

	/*각 상품별 리스트*/
	fn_draw_cart_itemgrp_one(cssSelector, arrCartGrpBaseAllList, arrCartGrpAditAllList){
		var strItemOptionBase = this.fn_draw_cart_itemgrp_base_list(arrCartGrpBaseAllList);
		var strItemOptionAdit = this.fn_draw_cart_itemgrp_adit_list(arrCartGrpAditAllList);

		var json = arrCartGrpBaseAllList[0];
		var thumbnailFile = "/html/page/market/assets/images/noimg.png";
		if (json.gdsInfo.thumbnailFile != undefined){
			thumbnailFile = "/comm/getImage?srvcId=GDS&amp;upNo=" + json.gdsInfo.thumbnailFile.upNo +"&amp;fileTy="+json.gdsInfo.thumbnailFile.fileTy +"&amp;fileNo="+json.gdsInfo.thumbnailFile.fileNo +"&amp;thumbYn=Y";
		}

		var cartGrpMoney = this.fn_calc_cart_grp_sum_money(arrCartGrpBaseAllList, arrCartGrpAditAllList);

		var original_price = '';
		if (cartGrpMoney.originPc != cartGrpMoney.ordrPc){
			original_price = '<span class="original-price">{0}원</span>'.format(cartGrpMoney.originPc.format_money());
		}

		var strHtml = ''+
			'<div class="order-product-inner cartGrpNo" ableBuy={0}>'.format(json.gdsInfo.soldOutYn=='Y'?'N':'')+
				'<div class="order-product-item">'+
					'<div class="item-thumb">'+
						'<div class="form-check">'+
							'<input class="form-check-input cart_ty_N" type="checkbox" name="cartGrpNo" value="{0}" cartGrpNo="{0}">'.format(json.cartGrpNo)+
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
								'<u>{0}</u>'.format(json.gdsCd)+
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
					'<div class="item-btn"><button class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#countModal">주문 수정</button></div>'+
					((json.gdsInfo.soldOutYn == 'Y') ? this.fn_draw_cart_itemgrp_sold_out():'') + 
				'</div>'+
			'</div>';

		return strHtml;
	}

	fn_draw_cart_itemgrp_base_list(arrCartGrpBaseAllList){
		var efor, elen = arrCartGrpBaseAllList.length;

		var arrTemp = [];
		for(efor = 0; efor<elen ; efor++){
			arrTemp.push(this.fn_draw_cart_itemgrp_base_one(arrCartGrpBaseAllList[efor]));
		}

		return arrTemp.join('');
	}

	fn_draw_cart_itemgrp_base_one(json){
		
		var baseOptnOne, aditOptnList = json.gdsInfo.optnList;
		baseOptnOne = aditOptnList.filter(function(item, idex) {
			if (json.gdsOptnNo == item.gdsOptnNo) {
				return true;
			}
		});

		if (baseOptnOne == undefined || baseOptnOne.length == 0){
			return '';
		}

		baseOptnOne = baseOptnOne[0];

		var list = json.ordrOptn.split(' * ');
		var arrTemp = [];
		var efor, elen = list.length;
		for(efor = 0; efor<elen ; efor++){
			if (list[efor] != undefined && list[efor].length > 0){
				arrTemp.push('<span class="label-flat">{0}</span>'.format(list[efor]));
			}
		}

		var soldOutTxt = ((baseOptnOne.soldOutYn == 'Y')?'<strong class="text-soldout">임시품절</strong>':'');
		var soldOutCls = ((baseOptnOne.soldOutYn == 'Y')?' disabled ':'');
		var ableBuy = (baseOptnOne.soldOutYn == 'Y')?' N ':'Y';

		var strHtml = '<dd class="{0}">'.format(soldOutCls)+
					arrTemp.join('')+
					'<span>{0}개(+{1}원)</span>'.format(json.ordrQy, json.ordrPc.format_money())+
					'<button class="btn-delete2 cart option base" cartNo="{0}" cartGrpNo="{1}" gdsOptnNo="{2}" ableBuy={3}>삭제</button>'.format(json.cartNo, json.cartGrpNo, json.gdsOptnNo, ableBuy)+
					soldOutTxt+
				'</dd>';

		return strHtml;
	}

	fn_draw_cart_itemgrp_adit_list(arrCartGrpAditAllList){
		var efor, elen = arrCartGrpAditAllList.length;

		if (elen.length < 1){
			return '';
		}

		var arrTemp = [];
		arrTemp.push('<div class="item-add-box">');
		for(efor = 0; efor<elen ; efor++){
			arrTemp.push(this.fn_draw_cart_itemgrp_adit_one(arrCartGrpAditAllList[efor]));
		}
		arrTemp.push('</div>');
		return arrTemp.join('');
	}

	fn_draw_cart_itemgrp_adit_one(json){
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
		var soldOutTxt = ((aditOptnOne.soldOutYn == 'Y')?'<strong class="text-soldout">임시품절</strong>':'');
		var soldOutCls = ((aditOptnOne.soldOutYn == 'Y')?' disabled ':'');
		var ableBuy = (aditOptnOne.soldOutYn == 'Y')?' N ':'Y';

		var strHtml = ''+
			'<div class="item-add">'+
				'<dd class="{0}">'.format(soldOutCls)+
					'<span class="label-outline-primary">'+
						'<span>추가</span>'+
						'<i><img src="../../assets/images/ico-plus-white.svg" alt=""></i>'+
					'</span>'+
					'<div class="name">'+
						'<span class="font-semibold">{0}</span>'.format(aditOptnOne.optnNm.replace("* ", ""))+
						'<span class="font-semibold">{0}개</span>'.format(json.ordrQy)+
						'<span>(+{0}원)</span>'.format((aditOptnOne.optnPc * json.ordrQy).format_money())+
						soldOutTxt+
						'<button class="btn-delete2 cart option adit" cartNo="{0}" cartGrpNo="{1}" gdsOptnNo="{2}" ableBuy={3}>삭제</button>'.format(json.cartNo, json.cartGrpNo, json.gdsOptnNo, ableBuy)+
					'</div>'+
				'</dd>'+
			'</div>';	
						
		return strHtml;
	}

	/*
		묶음배송
		items_money ==> fn_calc_cart_grp_sum_money함수에서 만들어진 값
		entrpsDlvyGrpInfo : 묶음배송 정보
		arrCartGrpBaseAllList : 기본 상품 전체
		arrCartGrpAditAllList : 추가 상품 전체
	*/
	fn_draw_html_order_delivery_summary_grp(items_money, entrpsDlvyGrpInfo, arrCartGrpBaseAllList, arrCartGrpAditAllList){
		
		return '<dl class="order-item-payment">'+
			'<dt>배송비</dt>'+
			'<dd class="delivery-charge">{0}원</dd>'+
		'</dl>';
	}

	
	/*퍼블리싱에서 order-product => order-body => order-item-payment 의 html*/
	/*
		개별 배송
		items_money ==> fn_calc_cart_grp_sum_money함수에서 만들어진 값
		arrCartGrpBaseList : 기본 상품 리스트
		arrCartGrpAditList : 추가 상품 리스트
	*/
	fn_draw_html_order_delivery_summary_each(items_money, arrCartGrpBaseList, arrCartGrpAditList){
		

		var strHtml = '<dl class="order-item-payment">'+
			'<dt>배송비</dt>'+
			'<dd class="delivery-charge">{0}</dd>'+
		'</dl>';
		
		return strHtml;
	}

	fn_draw_cart_itemgrp_sold_out(){
		var strHtml = '<div class="order-disabled"><strong>일시품절 상품입니다</strong></div>';
		
		return strHtml;
	}
}