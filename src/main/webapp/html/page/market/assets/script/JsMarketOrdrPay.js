class JsMarketOrdrPay{
    constructor(path, loginCheck, cartList, entrpsDlvyGrpVOList, entrpsVOList, codeMapJson){
        
        this._cls_info = this._cls_info || {};
		this._cls_info.bDev = true;

        this._cls_info.loginCheck = loginCheck;
        this._cls_info._membershipPath = path._membershipPath;
        this._cls_info._marketPath = path._marketPath;

		console.log(cartList)
		if (cartList.trim().length > 0){
			this._cls_info.cartList = JSON.parse(cartList);
		}

		console.log(entrpsDlvyGrpVOList)
		if (entrpsDlvyGrpVOList.trim().length > 0){
			this._cls_info.entrpsDlvyGrpVOList = JSON.parse(entrpsDlvyGrpVOList);
		}

		console.log(entrpsVOList)
		if (entrpsVOList.trim().length > 0){
			this._cls_info.entrpsVOList = JSON.parse(entrpsVOList);
		}
		if (codeMapJson.trim().length > 0){
			this._cls_info.codeMapJson = JSON.parse(codeMapJson);
		}
		
        
        this._cls_info.pagePrefix = 'main#container div#page-content' ;
        this._cls_info.pagePopPrefix = 'main#container div.modal2-con';

		this._cls_info.pageCartListfix = 'main#container div#page-content div#cart-content' ;
		
		this.fn_draw_cart_list();


        this.fn_page_init();


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

	fn_calc_order_product_item_money(arrCartGrpBaseList, arrCartGrpAditList){
		var ifor, ilen, cartItemOne;
		var ret = {ordrQy:0, ordrPc:0};
		
		ilen = arrCartGrpBaseList.length;
		for(ifor=0 ; ifor<ilen ; ifor++){
			cartItemOne = arrCartGrpBaseList[ifor];

			ret.ordrQy += cartItemOne.ordrQy;
			ret.ordrPc += cartItemOne.ordrPc;
		}

		ilen = arrCartGrpAditList.length;
		for(ifor=0 ; ifor<ilen ; ifor++){
			cartItemOne = arrCartGrpAditList[ifor];

			ret.ordrQy += cartItemOne.ordrQy;
			ret.ordrPc += cartItemOne.ordrPc;
		}

		return ret;
	}

	fn_draw_cart_list(){
		if (this._cls_info.cartList == undefined) return;
		if (this._cls_info.entrpsDlvyGrpVOList == undefined) return;
		if (this._cls_info.entrpsVOList == undefined) return;

		var owner = this;
		
		var dfor, dlen, kfor, klen, jfor, jlen, ifor, ilen = this._cls_info.entrpsVOList.length;
		var arrEntrpsDlvyGrp, arrCartList, arrCartGrpBaseList, arrCartGrpAditList;
		var arrHtml = [];
		var cartIdx;
		var strHtml;
		var items_money;

		arrHtml.push('<div class="order-product">');
		arrHtml.push('<div class="order-body">');


		for(ifor=0 ; ifor<ilen ; ifor++){/*사업소별 항목을 그린다*/
			arrHtml.push(this.fn_draw_html_order_item_business(this._cls_info.entrpsVOList[ifor]));

			arrEntrpsDlvyGrp = this._cls_info.entrpsDlvyGrpVOList.filter(function(item, idex) {
				if (item.entrpsNo == owner._cls_info.entrpsVOList[ifor].entrpsNo) {
					return true;
				}
			});

			jlen = arrEntrpsDlvyGrp.length;
			/*묶음 배송 그룹별 항목을 그린다*/
			for(jfor=0 ; jfor<jlen ; jfor++){

				console.log(arrEntrpsDlvyGrp[jfor]);
				cartIdx = [];
				arrCartList = this._cls_info.cartList.filter(function(item, idex) {
					if (item.gdsInfo != null && item.gdsInfo.entrpsNo == arrEntrpsDlvyGrp[jfor].entrpsNo 
											&& item.gdsInfo.entrpsDlvygrpNo == arrEntrpsDlvyGrp[jfor].entrpsDlvygrpNo) {
						cartIdx.push(idex);
						return true;
					}
				});

				console.log(cartIdx);
				dlen = cartIdx.length - 1;
				for(dfor=dlen ; dfor>=0 ; dfor--){
					this._cls_info.cartList.splice(dfor, 1);/*이미 선택한 상품은 제외 한다.*/
				}

				klen = arrCartList.length;

				arrHtml.push(this.fn_draw_html_order_delivery_total(true, klen, arrEntrpsDlvyGrp[jfor]));

				arrHtml.push('<div class="order-product-inner">');
				/*묶음 배송의 상품을 그린다*/
				for(kfor=0 ; kfor<klen ; kfor++){
					if (arrCartList.length == 1) continue;/*1개짜리는 따로 그린다*/

					console.log(arrCartList[kfor]);

					cartIdx = [];
					arrCartGrpBaseList = arrCartList.filter(function(item, idex) {
						if (item.ordrOptnTy == 'BASE' && item.cartGrpNo == arrCartList[kfor].cartGrpNo) {
							cartIdx.push(idex);
							return true;
						}
					});
					arrCartGrpAditList = arrCartList.filter(function(item, idex) {
						if (item.ordrOptnTy == 'ADIT' && item.cartNo != item.cartGrpNo && item.cartGrpNo == arrCartList[kfor].cartGrpNo) {
							cartIdx.push(idex);
							return true;
						}
					});

					
					items_money = this.fn_calc_order_product_item_money(arrCartGrpBaseList, arrCartGrpAditList);

					strHtml = this.fn_draw_html_order_product_item(arrCartList[kfor], items_money, arrCartGrpBaseList, arrCartGrpAditList);
					arrHtml.push(strHtml);

					if (cartIdx.length > 0){
						dlen = cartIdx.length - 1;
						for(dfor=dlen ; dfor>=0 ; dfor--){
							arrCartList.splice(dfor, 1);/*이미 선택한 상품은 제외 한다.*/
						}
						klen = arrCartList.length;
					}
					
				}

				arrHtml.push('</div>');

				arrHtml.push(this.fn_draw_html_order_item_payment());
			}
			
			/*개별 배송 그룹별 항목을 그린다*/
			arrCartList = this._cls_info.cartList.filter(function(item, idex) {
				if (item.gdsInfo != undefined && item.gdsInfo.entrpsNo == owner._cls_info.entrpsVOList[ifor].entrpsNo) {
					return true;
				}
			});

			
			jlen = arrCartList.length;
			for(jfor=0 ; jfor<jlen ; jfor++){
				arrHtml.push(this.fn_draw_html_order_delivery_total(false, 1, this._cls_info.entrpsVOList[ifor]));
				cartIdx = [];
				arrCartGrpBaseList = arrCartList.filter(function(item, idex) {
					if (item.ordrOptnTy == 'BASE' && item.cartGrpNo == arrCartList[jfor].cartGrpNo) {
						cartIdx.push(idex);
						return true;
					}
				});
				arrCartGrpAditList = arrCartList.filter(function(item, idex) {
					if (item.ordrOptnTy == 'ADIT' && item.cartNo != item.cartGrpNo && item.cartGrpNo == arrCartList[jfor].cartGrpNo) {
						cartIdx.push(idex);
						return true;
					}
				});

				items_money = this.fn_calc_order_product_item_money(arrCartGrpBaseList, arrCartGrpAditList);

				arrHtml.push('<div class="order-product-inner">');
				strHtml = this.fn_draw_html_order_product_item(arrCartList[jfor], items_money, arrCartGrpBaseList, arrCartGrpAditList);
				arrHtml.push(strHtml);
				arrHtml.push('</div>');

				arrHtml.push(this.fn_draw_html_order_item_payment());

				if (cartIdx.length > 0){
					dlen = cartIdx.length - 1;
					for(dfor=dlen ; dfor>=0 ; dfor--){
						arrCartList.splice(dfor, 1);/*이미 선택한 상품은 제외 한다.*/
					}
					jlen = arrCartList.length;
				}
			}
		}

		arrHtml.push('</div>');//order-body 끝
		arrHtml.push('</div>');//order-product 끝

		$(this._cls_info.pageCartListfix).html(arrHtml.join(''));
	}

	/*퍼블리싱에서 order-product => order-body => order-item-business 의 html*/
	fn_draw_html_order_item_business(json){
		return '<dl class="order-item-business">'+
			'<dt><span>사업소</span> <span>{0}</span></dt>'.format(json == undefined ? '' : json.entrpsNm)+
		'</dl>';
	}

	/*퍼블리싱에서 order-product => order-body => order-delivery-total 의 html*/
	fn_draw_html_order_delivery_total(bDlvyGrp, cnt, json){
		return '<div class="order-delivery-total">'+
			'<strong>{0}</strong>'.format(((bDlvyGrp?"묶음배송":"개별배송") + " " + ((bDlvyGrp && this._cls_info.bDev)?json.entrpsDlvygrpNm:"")))+
			'<strong class="price2">{0}개</strong>'.format(cnt)+
		'</div>';
	}

	/*퍼블리싱에서 order-product => order-body => order-product-inner 의 html*/
	fn_draw_html_order_product_item(json, items_money, arrCartGrpBaseList, arrCartGrpAditList){
		var thumbnailFile = "/html/page/market/assets/images/noimg.jpg";
		if (json.gdsInfo.thumbnailFile != undefined){
			thumbnailFile = "/comm/getImage?srvcId=GDS&amp;upNo=" + json.gdsInfo.thumbnailFile.upNo +"&amp;fileTy="+json.gdsInfo.thumbnailFile.fileTy +"&amp;fileNo="+json.gdsInfo.thumbnailFile.fileNo +"&amp;thumbYn=Y";
		}

		var cartItemOne;
		
		cartItemOne = '<div class="order-product-item">'+
			'<div class="item-thumb">'+
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
					'<p class="pay-amount">주문수량 <span>{0}</span>개</p>'.format(items_money.ordrQy)+
					'<div class="pay-price">'+
						'<span class="original-price">49,720원</span>'+
						'<strong class="price">{0}원</strong>'.format(items_money.ordrPc.format_money())+
					'</div>'+
				'</div>'+
			'</div>'+
			'<div class="item-option">'+
				'<dl class="option">'+
					this.fn_draw_html_order_product_item_base(json, arrCartGrpBaseList)+
				'</dl>'+
				'<div class="item-add-box">'+
					this.fn_draw_html_order_product_item_adit(json, arrCartGrpAditList)+
				'</div>'+
			'</div>'+
			'<!-- <div class="item-btn"></div> -->'+
		'</div>';

		return cartItemOne;
	}

	fn_draw_html_order_product_item_base(json, arrCartGrpBaseList){
		var cartItemBaseList = [];

		if (arrCartGrpBaseList != undefined && arrCartGrpBaseList.length > 0
			&& json.gdsInfo != undefined && json.gdsInfo.optnList != undefined && json.gdsInfo.optnList.length > 0){
			var ifor, ilen = arrCartGrpBaseList.length;
			var aditOptnOne, aditOptnList = json.gdsInfo.optnList;

			for(ifor = 0; ifor<ilen ; ifor++){
				aditOptnOne = aditOptnList.filter(function(item, idex) {
					if (arrCartGrpBaseList[ifor].gdsOptnNo == item.gdsOptnNo) {
						return true;
					}
				});

				if (aditOptnOne == undefined || aditOptnOne.length == 0){
					continue;
				}

				aditOptnOne = aditOptnOne[0];

				var cartItemBaseOne = '<dd>'+
					'<span class="label-flat">{0}</span>'.format(json.ordrOptn)+
					'<span>{0}개(+{1}원)</span>'.format(json.ordrQy, json.ordrPc.format_money())+
				'</dd>';

				cartItemBaseList.push(cartItemBaseOne);
			}
		}

		return cartItemBaseList.join('');

		// '<dd>'+
		// 		'<span class="label-flat">블루</span>'+
		// 		'<span class="label-flat">800g</span>'+
		// 		'<span>2개(+9,720원)</span>'+
		// 	'</dd>';
	}

	fn_draw_html_order_product_item_adit(json, arrCartGrpAditList){
		var cartItemAditList = [];

		if (arrCartGrpAditList != undefined && arrCartGrpAditList.length > 0
			&& json.gdsInfo != undefined && json.gdsInfo.aditOptnList != undefined && json.gdsInfo.aditOptnList.length > 0){
			var ifor, ilen = arrCartGrpAditList.length;
			var aditOptnOne, aditOptnList = json.gdsInfo.aditOptnList;
			
			for(ifor = 0; ifor<ilen ; ifor++){
				aditOptnOne = aditOptnList.filter(function(item, idex) {
					if (arrCartGrpAditList[ifor].gdsOptnNo == item.gdsOptnNo) {
						return true;
					}
				});

				if (aditOptnOne == undefined || aditOptnOne.length == 0){
					continue;
				}

				aditOptnOne = aditOptnOne[0];

				var cartItemAditOne = '<div class="item-add{0}">'.format(((aditOptnOne.soldOutYn == 'Y')?" disabled ":""))+
					'<span class="label-outline-primary">'+
						'<span>추가</span>'+
						'<i><img src="../../assets/images/ico-plus-white.svg" alt=""></i>'+
					'</span>'+
					'<div class="name">'+
						'<span class="font-semibold">{0}</span>'.format(aditOptnOne.optnNm.replace("* ", ""))+
						'<span class="font-semibold">{0}개</span>'.format(arrCartGrpAditList[ifor].ordrQy)+
						'<span>(+{0}원)</span>'.format((aditOptnOne.optnPc * arrCartGrpAditList[ifor].ordrQy).format_money())+
						((aditOptnOne.soldOutYn == 'Y')?'<strong class="text-soldout">임시품절</strong>':'')+
					'</div>'+
				'</div>';

				cartItemAditList.push(cartItemAditOne);
			}


		}	

		return cartItemAditList.join('');

		
		// '<div class="item-add">'+
		// 	'<span class="label-outline-primary">'+
		// 		'<span>추가</span>'+
		// 		'<i><img src="../../assets/images/ico-plus-white.svg" alt=""></i>'+
		// 	'</span>'+
		// 	'<div class="name">'+
		// 		'<strong>모던 스타일 스툴</strong>'+
		// 		'<strong>1개</strong>'+
		// 		'<span>(+80,000원)</span>'+
		// 	'</div>'+
		// '</div>';
		
		// '<div class="item-add disabled">'+
		// 	'<span class="label-outline-primary">'+
		// 		'<span>추가</span>'+
		// 		'<i><img src="../../assets/images/ico-plus-white.svg" alt=""></i>'+
		// 	'</span>'+
		// 	'<div class="name">'+
		// 		'<span class="font-semibold">모던 스타일 스툴</span>'+
		// 		'<span class="font-semibold">1개</span>'+
		// 		'<span>(+80,000원)</span>'+
		// 		'<strong class="text-soldout">임시품절</strong>'+
		// 	'</div>'+
		// '</div>';
	}

	/*퍼블리싱에서 order-product => order-body => order-item-payment 의 html*/
	fn_draw_html_order_item_payment(){
		return '<dl class="order-item-payment">'+
			'<dt>배송비</dt>'+
			'<dd class="delivery-charge">3000원</dd>'+
		'</dl>';
	}
}