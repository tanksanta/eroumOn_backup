class JsMarketCartList extends JsMargetDrawItems{
    constructor(path, mbrSession, cartListWelfareJson, cartListOrdrJson, entrpsDlvyGrpVOList, entrpsVOList, codeMapJson){
        super();

        this._cls_info.mbrSession = mbrSession;
		this._cls_info.path = path;
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
			$(this._cls_info.pagePrefix + " .cart-list-container.ordr .order-del-box").addClass("hidden");
			$(this._cls_info.pagePrefix + " .cart-list-container.ordr .order-buy-box").addClass("hidden");
			$(this._cls_info.pagePrefix + " .cart-list-container.ordr .order-amount").addClass("hidden");
		}else{
			$(this._cls_info.pagePrefix + " .cart-list-container.ordr .cart-list-none").addClass("hidden");
			$(this._cls_info.pagePrefix + " .cart-list-container.ordr .cart-list-box").removeClass("hidden");
			$(this._cls_info.pagePrefix + " .cart-list-container.ordr .order-del-box").removeClass("hidden");
			$(this._cls_info.pagePrefix + " .cart-list-container.ordr .order-buy-box").removeClass("hidden");
			$(this._cls_info.pagePrefix + " .cart-list-container.ordr .order-amount").removeClass("hidden");
			this.fn_draw_cart_list(".cart-list-container.ordr", this._cls_info.cartListOrdrJson);
			this.fn_init_cart_ordr_checkall();
			this.fn_draw_checked_amount($(this._cls_info.pagePrefix + " .cart-list-container.ordr"));
		}
        
		this.fn_page_init();
    }

	fn_popup_set(popkind, popObj){
        this._cls_info.popups[popkind] = popObj;
    }

	fn_init_cart_ordr_checkall(){
		var list = $(this._cls_info.pagePrefix + " .cart-list-container.ordr input[type='checkbox'].cartGrpNo");
		
		// jsCommon.fn_checkbox_ctl_list(true, list);
	}

	fn_init_sub_addevent(){
        var owner = this;

		/*각 상품별 체크박스 클릭*/
		$( this._cls_info.pagePrefix + " input[type='checkbox'].cartGrpNo").off('click').on('click',  function() {
			owner.fn_draw_checked_amount($(this).closest('.cart-list-container'));
        });

		/*각 사업소별 체크박스 클릭*/
		$( this._cls_info.pagePrefix + " input[type='checkbox'].entrpsAll").off('click').on('click',  function() {
            owner.fn_checkbox_entrps_click($(this));
			owner.fn_draw_checked_amount($(this).closest('.cart-list-container'));
        });

		/*전체 체크박스 클릭*/
		$( this._cls_info.pagePrefix + " .btn.select.all").off('click').on('click',  function() {
            owner.fn_checkbox_all_click($(this), $('input[type="checkbox"][name="cartGrpNo"].form-check-input').length != $('input[type="checkbox"][name="cartGrpNo"].form-check-input:checked').length);
			owner.fn_draw_checked_amount($(this).closest('.cart-list-container'));
        });
		$( this._cls_info.pagePrefix + " .btn.select.delete.whole").off('click').on('click',  function() {
            owner.fn_checkbox_all_click($(this), true);
			owner.fn_draw_checked_amount($(this).closest('.cart-list-container'));
			owner.fn_cartgrp_delete_part_click($(this));
        });
		$( this._cls_info.pagePrefix + " .btn.select.delete.part").off('click').on('click',  function() {
            owner.fn_cartgrp_delete_part_click($(this));
        });

		$( this._cls_info.pagePrefix + " .btn-delete2.cart.gdsOptn").off('click').on('click',  function() {
            owner.fn_del_cart_optn_click($(this));
        });
		$( this._cls_info.pagePrefix + " .btn.buy.part").off('click').on('click',  function() {
            owner.fn_buy_part_click($(this));
        });
		$( this._cls_info.pagePrefix + " .btn.buy.all").off('click').on('click',  function() {
            owner.fn_checkbox_all_click($(this), true);

			owner.fn_buy_part_click($(this));
        });

		$( this._cls_info.pagePrefix + " .cart-list-container .f_optn_chg").off('click').on('click',  function() {
			let cartGrpNo = $(this).attr("cartGrpNo");

			$("#cart-optn-chg").load(owner._cls_info._marketPath + "/mypage/cart/cartOptnModal",
					{
				cartGrpNo : cartGrpNo
				}, function(){
					$("#cartOptnModal").modal('show');

					owner._cls_info.popups.jsMarketCartModalOptnChg2.fn_loaded(owner._cls_info.path, $("#cart-optn-chg  textarea.cartListJson").val());
				});
		});

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

			arrHtml.push('<div class="order-product" recipterUniqueId="{0}" entrpsNo="{2}" cartTy="{1}">'.format(arrEachEntrpsAllItems[0].recipterUniqueId, arrEachEntrpsAllItems[0].cartTy, entrpsVO.entrpsNo));
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

	fn_draw_html_order_item_business(json){
		return '<dl class="order-item-business">'+
			'<dd class="form-check"><input class="form-check-input entrpsAll" type="checkbox" name="entrpsAll" value="{0}"></dd>'.format(json == undefined ? '' : json.entrpsNo)+
			'<dt><span>{0}</span></dt>'.format(json == undefined ? '' : json.entrpsNm)+
		'</dl>';
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

			strHtml = this.fn_draw_html_order_delivery_summary_each(arrCartGrpBaseAllList, arrCartGrpAditAllList);
			arrEntRpsHtml.push(strHtml);
		}


		/*****************************개별 배송 그룹별 항목을 그린다. cart_grp_no별로 그려야 한다. 끝*****************************/

		return arrEntRpsHtml.join('');
	}


	fn_draw_cart_each_dlvygrp_list(cssSelector, entrpsVO, entrpsDlvyGrpInfo, arrEachItems){
		var cartIdx = [], arrItemGrp = [];
		var cloneEachItems = arrEachItems.clone();

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
		strHtml = this.fn_draw_html_order_delivery_summary_grp(arrCartGrpBaseAllList, arrCartGrpAditAllList);
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
			'<div class="order-product-inner cartGrp" cartGrpNo="{0}">'.format(json.cartGrpNo)+
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
					'<div class="item-btn"><button class="btn btn-primary f_optn_chg" data-bs-toggle="modal" data-bs-target="#countModal" cartGrpNo="{0}">주문 수정</button></div>'.format(json.cartGrpNo)+
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

		var soldOutYn = 'N';
		if (baseOptnOne != undefined && baseOptnOne.length > 0 && baseOptnOne.soldOutYn == 'Y') {
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

		var soldOutTxt = ((soldOutYn == 'Y')?'<strong class="text-soldout">임시품절</strong>':'');
		var soldOutCls = ((soldOutYn == 'Y')?' disabled ':'');
		var ableBuy = ((soldOutYn=='Y')?'N':'Y');
		var btnDelte = '<button class="btn-delete2 cart gdsOptn base" ordrOptnTy="BASE" cartNo="{0}" cartGrpNo="{1}" gdsOptnNo="{2}" ableBuy="{3}">삭제</button>';

		var strHtml = '<dd class="{0}">'.format(soldOutCls)+
					arrTemp.join('')+
					'<span>{0}개(+{1}원)</span>'.format(json.ordrQy, json.ordrPc.format_money())+
					btnDelte.format(json.cartNo, json.cartGrpNo, json.gdsOptnNo, ableBuy)+
					soldOutTxt+
					this.fn_draw_cart_input_hidden("BASE", json, baseOptnOne, ableBuy)+
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
				this.fn_draw_cart_input_hidden("ADIT", json, aditOptnOne, ableBuy)+
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
	fn_draw_html_order_delivery_summary_each(arrCartGrpBaseList, arrCartGrpAditList){
		var items_money = this.fn_calc_cart_grp_sum_money(arrCartGrpBaseList, arrCartGrpAditList);

		var gdsInfo = arrCartGrpBaseList[0].gdsInfo;

		var dlvyBaseAmtNm = '';
		var dlvyBaseAmt = 0;

		if (gdsInfo.dlvyCtTy == 'FREE'){
			dlvyBaseAmt = 0;
			dlvyBaseAmtNm = "무료";
		} else if (gdsInfo.dlvyCtTy == 'OVERMONEY'){
			if (items_money.ordrPc >= gdsInfo.dlvyCtCnd){
				dlvyBaseAmt = 0;
				dlvyBaseAmtNm = "무료";
			}else{
				dlvyBaseAmt = gdsInfo.dlvyBassAmt;
				dlvyBaseAmtNm = dlvyBaseAmt.format_money() +  "원";
				
			}
		} else if (gdsInfo.dlvyCtTy == 'PERCOUNT' && !isNaN(gdsInfo.dlvyCtCnd) && gdsInfo.dlvyCtCnd != 0){
			dlvyBaseAmt = (gdsInfo.dlvyBassAmt * Math.ceil(items_money.ordrQy / gdsInfo.dlvyCtCnd));
			dlvyBaseAmtNm = dlvyBaseAmt.format_money() +  "원";

		} else {//if (gdsInfo.dlvyCtTy == 'PAY')
			dlvyBaseAmt = gdsInfo.dlvyBassAmt;
			dlvyBaseAmtNm = dlvyBaseAmt.format_money() +  "원";
		}

		var strHtml = '<dl class="order-item-payment">'+
			'<dt>배송비<input type="hidden" name="dlvyBaseAmt" value="{0}"></dt>'.format(dlvyBaseAmt)+
			'<dd class="delivery-charge">{0}</dd>'.format(dlvyBaseAmtNm)+
		'</dl>';
		
		return strHtml;
	}

	fn_draw_cart_itemgrp_sold_out(){
		var strHtml = '<div class="order-disabled"><strong>일시품절 상품입니다</strong></div>';
		
		return strHtml;
	}

	/*
		ordrOptnTy : BASE, ADIT 구분자
		json : 구매한 상품(cart에 담겨있는 상품)
		aditOptnOne : BASE 이면 기본 상품의 정보, ADIT 이면 추가상품의 정보
		ableBuy : 구매가능 여부
	*/
	fn_draw_cart_input_hidden(ordrOptnTy, json, aditOptnOne, ableBuy){
		var hiddenInfo = '';
		hiddenInfo += '<input type="hidden" name="cartNo" value="{0}">'.format(json.cartNo);
		hiddenInfo += '<input type="hidden" name="cartGrpNo" value="{0}">'.format(json.cartGrpNo);
		hiddenInfo += '<input type="hidden" name="gdsNo" value="{0}">'.format(json.gdsInfo.gdsNo);
		hiddenInfo += '<input type="hidden" name="ableBuy" value="{0}">'.format(ableBuy);

		hiddenInfo += '<input type="hidden" name="ordrQy" value="{0}">'.format(json.ordrQy);
		if (ordrOptnTy == 'BASE'){
			hiddenInfo += '<input type="hidden" name="ordrPc" value="{0}">'.format(json.ordrPc);// <%--건별 주문금액--%>
		}else if (ordrOptnTy == 'ADIT'){
			hiddenInfo += '<input type="hidden" name="ordrPc" value="{0}">'.format(json.ordrQy * aditOptnOne.optnPc);// <%--건별 주문금액--%>
		}
			
		return hiddenInfo;
	}

	fn_draw_checked_amount(jobjRoot){
		var key;
		
		var money = 0;
		var cssSelector = this._cls_info.pagePrefix + " .order-amount ";

		var cartResultMoney = this.fn_calc_checked_amount(jobjRoot);

		key = "total-ordrpc";
		money += cartResultMoney[key];
		$(cssSelector + "  ." + key + "-dl ." + key + "-txt").html(cartResultMoney[key].format_money());

		key = "total-dlvyBase";
		money += cartResultMoney[key];
		$(cssSelector + "  ." + key + "-dl ." + key + "-txt").html(cartResultMoney[key].format_money());

		$("#stlmAmt").val(money);
		$(cssSelector + " .total-stlmAmt-txt").html(money.format_money());
	}

	fn_calc_checked_amount(jobjRoot){

		var listTemp, listCheckbox = jobjRoot.find(".order-product .order-product-item input[type='checkbox'].cartGrpNo");
		var jobjTarget, jobjCartGrp;
		var money = 0;
		
		var ifor, ilen = listCheckbox.length;
		for(ifor=0 ; ifor<ilen ; ifor++){
			jobjTarget = $(listCheckbox[ifor]);
			if (jobjTarget.is(":checked")){
				jobjCartGrp = jobjTarget.closest('.order-product-item');

				listTemp = jobjCartGrp.find('input[name="ordrPc"]');
				$.each (listTemp, function (index, el) {
					money += Number($(el).val().replace(",", ""));
				});
			}
			
		}

		return {"total-ordrpc":money, "total-dlvyBase":0, "total-dlvyAdit":0}
	}


	fn_del_cart_optn_click(jobjTarget){
		if (!confirm("선택한 옵션을 삭제하시겠습니까?")){return;}
		var jObjTemp = jobjTarget.closest('.order-product');

		var recipterUniqueId = jObjTemp.attr("recipterUniqueId");

		var cartTy = jObjTemp.attr("cartTy");

		var cartNo = jobjTarget.attr("cartNo");
		var cartGrpNo = jobjTarget.attr("cartGrpNo");
		var gdsOptnNo = jobjTarget.attr("gdsOptnNo");

		var data = {cartNo
					, cartGrpNo
					, cartTy
					, gdsOptnNo
					, recipterUniqueId
				};



		jsCallApi.call_api_post_json(this
									, this._cls_info._marketPath + '/mypage/cart/removeCartOptn.json'
									, 'fn_del_cart_optn_cb'
									, data);

	}
	
    fn_del_cart_optn_cb(result, fail, data, param){
		if (result != undefined && result.result){
			alert("삭제되었습니다.")
			window.location.reload();
		}else{
			alert("장바구니를 삭제하는 중 오류가 발생하였습니다.\n새로고침 후 다시 시도해 주십시오.")
		}
	}

	fn_checkbox_entrps_click(jobjTarget){
		var checked = jobjTarget.is(":checked");

		var jobjRoot = jobjTarget.closest('.order-product');

		var list = jobjRoot.find('input[type="checkbox"][name="cartGrpNo"].form-check-input');
		
		jsCommon.fn_checkbox_ctl_list(checked, list);
		
			
	}

	fn_checkbox_all_click(jobjTarget, bChecked){
		var jobjRoot = jobjTarget.closest('.cart-list-container');
		var list = jobjRoot.find('input[type="checkbox"][name="cartGrpNo"].form-check-input');
		
		jsCommon.fn_checkbox_ctl_list(bChecked, list);
	}

	fn_cartgrp_delete_part_click(jobjTarget){
		var jobjRoot = jobjTarget.closest('.cart-list-container');

		var jobjProduct = jobjRoot.find('.order-product');

		if (jobjProduct == undefined || jobjProduct.length == 0){
			alert("삭제할 상품이 존재하지 않습니다.")
			return;
		}
		jobjProduct = $(jobjProduct[0]);
		var recipterUniqueId = jobjProduct.attr("recipterUniqueId");

		var cartTy = jobjProduct.attr("cartTy");

		var list = jobjRoot.find('input[type="checkbox"][name="cartGrpNo"].form-check-input:checked');
		if (list == undefined || list.length == 0){
			alert("삭제할 상품을 선택하여 주십시오.")
			return;
		}
		var cartGrpNos = [];
		$.each (list, function (index, el) {
			cartGrpNos.push($(el).val())
		});
		

		if (!confirm("선택한 상품 "+cartGrpNos.length+"건을 삭제하시겠습니까?")) return;

		var data = {cartGrpNos
			, cartTy
			, recipterUniqueId
		};

		jsCallApi.call_api_post_json(this
							, this._cls_info._marketPath + '/mypage/cart/removeCart.json'
							, 'fn_cartgrp_delete_part_cb'
							, data);
	}
	fn_cartgrp_delete_part_cb(result, fail, data, param){
		if (result != undefined && result.result){
			alert("삭제되었습니다.")
			window.location.reload();
		}else{
			alert("장바구니를 삭제하는 중 오류가 발생하였습니다.\n새로고침 후 다시 시도해 주십시오.")
		}
	}

	fn_buy_part_click(){
		if ($('input[type="checkbox"][name="cartGrpNo"].form-check-input:checked').length < 1){
			alert("주문 하실 상품을 선택해주세요.")
			return;
		}

		var jobjList = $('input[type="checkbox"][name="cartGrpNo"].form-check-input:checked');
		var ifor, ilen = jobjList.length;
		var jobjCartGrp;
		var jobjTemp;
		var cartTy = 'N';
		var cartGrpNos = [];
		for(ifor=0 ; ifor<ilen ; ifor++){
			jobjCartGrp = $(jobjList[ifor]).closest('.order-product-inner');
			jobjTemp = jobjCartGrp.find("input[name='ableBuy']");

			$.each(jobjTemp, function(i, item) {
				if ($(item).val() != 'Y') {
					alert("품절된 상품이 존재합니다.")
					return;
				}
			});

			cartGrpNos.push(jobjCartGrp.attr("cartGrpNo"));
		}

		let params = {cartTy, cartGrpNos : cartGrpNos.join(',')};

		jsCallApi.call_svr_post_move(this._cls_info._marketPath + '/ordr/cartPay', params)
	}
}