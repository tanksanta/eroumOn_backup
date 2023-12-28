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

	fn_draw_cart_list(){
		if (this._cls_info.cartList == undefined) return;
		if (this._cls_info.entrpsDlvyGrpVOList == undefined) return;
		if (this._cls_info.entrpsVOList == undefined) return;

		var owner = this;
		
		var dfor, dlen, kfor, klen, jfor, jlen, ifor, ilen = this._cls_info.entrpsVOList.length;
		var arrEntrpsDlvyGrp, arrCartList, arrCartGrpList;
		var arrHtml = [];
		var cartIdx;

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
			for(jfor=0 ; jfor<jlen ; jfor++){/*묶음 배송 그룹별 항목을 그린다*/

				console.log(arrEntrpsDlvyGrp[jfor]);
				cartIdx = [];
				arrCartList = this._cls_info.cartList.filter(function(item, idex) {
					if (item.gdsInfo != null && item.gdsInfo.entrpsNo == arrEntrpsDlvyGrp[jfor].entrpsNo && item.gdsInfo.entrpsDlvygrpNo == arrEntrpsDlvyGrp[jfor].entrpsDlvygrpNo) {
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
				for(kfor=0 ; kfor<klen ; kfor++){/*묶음 배송의 상품을 그린다*/
					console.log(arrCartList[kfor]);

					cartIdx = [];
					arrCartGrpList = arrCartList.filter(function(item, idex) {
						if (item.cartNo != item.cartGrpNo && item.cartGrpNo == arrCartList[kfor].cartGrpNo) {
							cartIdx.push(idex);
							return true;
						}
					});

					arrHtml.push(this.fn_draw_html_order_product_item(arrCartList[kfor]), arrCartGrpList);

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
			'<strong>{0}</strong>'.format(((bDlvyGrp?"묶음배송":"개별배송") + " " + ((this._cls_info.bDev)?json.entrpsDlvygrpNm:"")))+
			'<strong class="price2">{0}개</strong>'.format(cnt)+
		'</div>';
	}

	/*퍼블리싱에서 order-product => order-body => order-product-inner 의 html*/
	fn_draw_html_order_product_item(json, optionList){
		var thumbnailFile = "/html/page/market/assets/images/noimg.jpg";
		if (json.gdsInfo.thumbnailFile != undefined){
			thumbnailFile = "/comm/getImage?srvcId=GDS&amp;upNo=" + json.gdsInfo.thumbnailFile.upNo +"&amp;fileTy="+json.gdsInfo.thumbnailFile.fileTy +"&amp;fileNo="+json.gdsInfo.thumbnailFile.fileNo +"&amp;thumbYn=Y";
		}
		
		return '<div class="order-product-item">'+
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
							'<p class="pay-amount">주문수량<span>{0}</span>개</p>'.format(json.ordrQy)+
							'<div class="pay-price">'+
								'<span class="original-price">49,720원</span>'+
								'<strong class="price">{0}원</strong>'.format(json.ordrPc.format_money())+
							'</div>'+
						'</div>'+
					'</div>'+
					'<div class="item-option">'+
						'<dl class="option">'+
							'<dd>'+
								'<span class="label-flat">블루</span>'+
								'<span class="label-flat">800g</span>'+
								'<span>2개(+9,720원)</span>'+
							'</dd>'+
						'</dl>'+
						'<div class="item-add">'+
							'<span class="label-outline-primary">'+
								'<span>추가</span>'+
								'<i><img src="../../assets/images/ico-plus-white.svg" alt=""></i>'+
							'</span>'+
							'<div class="name">'+
								'<strong>모던 스타일 스툴</strong>'+
								'<strong>1개</strong>'+
								'<span>(+80,000원)</span>'+
							'</div>'+
						'</div>'+
					'</div>'+
					'<!-- <div class="item-btn"></div> -->'+
				'</div>';
	}

	/*퍼블리싱에서 order-product => order-body => order-item-payment 의 html*/
	fn_draw_html_order_item_payment(){
		return '<dl class="order-item-payment">'+
			'<dt>배송비</dt>'+
			'<dd class="delivery-charge">3000원</dd>'+
		'</dl>';
	}
}