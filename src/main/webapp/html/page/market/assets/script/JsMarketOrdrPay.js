class JsMarketOrdrPay{
    constructor(ordrTy, path, mbrSession, cartList, entrpsDlvyGrpVOList, entrpsVOList, codeMapJson){
        
        this._cls_info = this._cls_info || {};
		this._cls_info.bDev = true;

		this._cls_info.jsMarketDlvyGrpCalc = new JsMarketDlvyGrpCalc();;

		this._cls_info.ordrTy = ordrTy;
        this._cls_info.mbrSession = mbrSession;
        this._cls_info._membershipPath = path._membershipPath;
        this._cls_info._marketPath = path._marketPath;


		console.log(cartList)
		if (cartList.trim().length > 0){
			this._cls_info.cartList = JSON.parse(cartList);
			this._cls_info.drawCartList = JSON.parse(cartList);
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

		this._cls_info.pageCartListfix = 'main#container div#page-content div#cart-content' ;
		this._cls_info.pageResultRricefix = 'main#container div#page-content div.payment-result div.result-price' ;
		

										
		/*최종 결제금액 확인*/
		this._cls_info.cartResultMoney = {"total-ordrpc":0 		/*총 주문상품금액*/
										, "total-coupon" : 0 	/*쿠폰*/
										, "total-mlg":0			/*마일리지/포인트*/
										, "total-dlvyBase":0	/*배송비*/
										, "total-dlvyAdit":0	/*배송비-추가 지역 금액*/
									};
									
		this.fn_draw_cart_list();

		this.fn_calc_dlvyadit();
		this.fn_draw_result_money();

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

	/*추가 배송비 계산*/
	fn_calc_dlvyadit(){
		if (this._cls_info.dlvyCtAditRgnYn != 'Y'){/*도서산간 추가 배송지 지역이 아닌경우*/
			this._cls_info.cartResultMoney["total-dlvyAdit"] = 0;
			return;
		}
		var jobjDtl, jobjCartList = $(this._cls_info.pageCartListfix + " .draw.cart.item");

		var ifor, ilen = jobjCartList.length;
		var money = 0;
		for(ifor=0 ; ifor<ilen ; ifor++){
			jobjDtl = $(jobjCartList[ifor]);
			if (jobjDtl.find('input[name="ordrOptnTy"]').val() == "BASE"){
				money += Number(jobjDtl.find('input[name="dlvyAditAmt"]').val())
				
			}
		}

		if (isNaN(money)){
			alert("도서산간 배송비를 계산하는 중 오류가 발생하였습니다. 다시 시도해 주십시오.")
			window.location.reload();
		}
		this._cls_info.cartResultMoney["total-dlvyAdit"] = money;
	}

	fn_calc_order_product_item_money(arrCartGrpBaseList, arrCartGrpAditList){
		var ifor, ilen, cartItemOne;
		var ret = {ordrQy:0, ordrPc:0, originPc:0};
		
		ilen = arrCartGrpBaseList.length;
		for(ifor=0 ; ifor<ilen ; ifor++){
			cartItemOne = arrCartGrpBaseList[ifor];

			ret.ordrQy += cartItemOne.ordrQy;
			ret.ordrPc += cartItemOne.ordrPc;

			ret.originPc += (cartItemOne.ordrQy * cartItemOne.gdsInfo.pc);
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

	fn_draw_cart_list(){
		if (this._cls_info.drawCartList == undefined) return;
		if (this._cls_info.entrpsDlvyGrpVOList == undefined) return;
		if (this._cls_info.entrpsVOList == undefined) return;

		var owner = this;
		
		var dfor, dlen, kfor, klen, jfor, jlen, ifor, ilen = this._cls_info.entrpsVOList.length;
		var arrEntrpsDlvyGrp, arrCartList, arrCartGrpBaseList, arrCartGrpAditList, arrCartGrpBaseAllList, arrCartGrpAditAllList;
		var arrHtml = [];
		var cartIdx;
		var strHtml;
		var items_money;
		var ordrIdx = 0;

		for(ifor=0 ; ifor<ilen ; ifor++){/*사업소별 항목을 그린다*/
			arrHtml.push('<div class="order-product">');
			arrHtml.push('<div class="order-body">');
			
			arrHtml.push(this.fn_draw_html_order_item_business(this._cls_info.entrpsVOList[ifor]));

			arrEntrpsDlvyGrp = this._cls_info.entrpsDlvyGrpVOList.filter(function(item, idex) {
				if (item.entrpsNo == owner._cls_info.entrpsVOList[ifor].entrpsNo) {
					return true;
				}
			});

			jlen = arrEntrpsDlvyGrp.length;
			
			/*****************************묶음 배송 그룹별 항목을 그린다. 시작*****************************/
			for(jfor=0 ; jfor<jlen ; jfor++){
				// console.log(arrEntrpsDlvyGrp[jfor]);
				cartIdx = [];
				arrCartList = this._cls_info.drawCartList.filter(function(item, idex) {
					if (item.gdsInfo != null && item.gdsInfo.entrpsNo == arrEntrpsDlvyGrp[jfor].entrpsNo 
											&& item.gdsInfo.entrpsDlvygrpNo == arrEntrpsDlvyGrp[jfor].entrpsDlvygrpNo) {
						cartIdx.push(idex);
						return true;
					}
				});
				
				if (arrCartList.length <= 1) continue;/*1개짜리는 따로 그린다*/

				// console.log(cartIdx);
				dlen = cartIdx.length - 1;
				for(dfor=dlen ; dfor>=0 ; dfor--){
					this._cls_info.drawCartList.splice(cartIdx[dfor], 1);/*이미 선택한 상품은 제외 한다.*/
				}

				this._cls_info.jsMarketDlvyGrpCalc.fn_calc_dlvygrp(arrEntrpsDlvyGrp[jfor], arrCartList);

				klen = arrCartList.length;

				arrHtml.push(this.fn_draw_html_order_delivery_title(true, klen, arrEntrpsDlvyGrp[jfor]));

				arrCartGrpBaseAllList = [];
				arrCartGrpAditAllList = [];
				arrHtml.push('<div class="order-product-inner">');
				/*묶음 배송의 상품을 그린다*/
				for(kfor=0 ; kfor<klen ; kfor++){

					// console.log("arrCartList["+kfor+"]", arrCartList[kfor]);

					cartIdx = [];
					arrCartGrpBaseList = arrCartList.filter(function(item, idex) {
						if (item.ordrOptnTy == 'BASE' && item.cartGrpNo == arrCartList[kfor].cartGrpNo) {
							arrCartGrpBaseAllList.push(item);
							cartIdx.push(idex);
							return true;
						}
					});
					arrCartGrpAditList = arrCartList.filter(function(item, idex) {
						if (item.ordrOptnTy == 'ADIT' && item.cartNo != item.cartGrpNo && item.cartGrpNo == arrCartList[kfor].cartGrpNo) {
							arrCartGrpAditAllList.push(item);
							cartIdx.push(idex);
							return true;
						}
					});
					// console.log("arrCartGrpBaseList.length", arrCartGrpBaseList.length);
					// console.log("arrCartGrpAditList.length", arrCartGrpAditList.length);
					// console.log("cartIdx", cartIdx);

					
					items_money = this.fn_calc_order_product_item_money(arrCartGrpBaseList, arrCartGrpAditList);
					this._cls_info.cartResultMoney["total-ordrpc"] += items_money.ordrPc;

					if (this._cls_info.dlvyCtAditRgnYn == 'Y' && kfor == 0){
						this._cls_info.cartResultMoney["total-dlvyAdit"] += arrCartGrpBaseList[0].gdsInfo.dlvyAditAmt;
					}

					ordrIdx += 1;
					strHtml = this.fn_draw_html_order_product_item(this._cls_info.ordrCd, ordrIdx, true, arrEntrpsDlvyGrp[jfor], arrCartGrpBaseList[0], items_money, arrCartGrpBaseList, arrCartGrpAditList);
					arrHtml.push(strHtml);
					// console.log(strHtml)
				}

				strHtml = this.fn_draw_html_order_delivery_summary_grp(items_money, arrEntrpsDlvyGrp[jfor], arrCartGrpBaseAllList, arrCartGrpAditAllList);
				arrHtml.push(strHtml);
				// console.log(strHtml)

				arrHtml.push('</div>');
			}
			/*****************************묶음 배송 그룹별 항목을 그린다. 끝*****************************/


			/*****************************개별 배송 그룹별 항목을 그린다. cart_grp_no별로 그려야 한다. 시작*****************************/
			cartIdx = [];
			arrCartList = this._cls_info.drawCartList.filter(function(item, idex) {
				if (item.gdsInfo != undefined && item.gdsInfo.entrpsNo == owner._cls_info.entrpsVOList[ifor].entrpsNo) {
					cartIdx.push(idex);
					return true;
				}
			});
			// console.log(cartIdx);
			dlen = cartIdx.length - 1;
			for(dfor=dlen ; dfor>=0 ; dfor--){
				this._cls_info.drawCartList.splice(cartIdx[dfor], 1);/*이미 선택한 상품은 제외 한다.*/
			}

			
			jlen = arrCartList.length;
			for(jfor=0 ; jfor<jlen ; jfor++){
				arrHtml.push(this.fn_draw_html_order_delivery_title(false, 1, this._cls_info.entrpsVOList[ifor]));
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
				this._cls_info.cartResultMoney["total-ordrpc"] += items_money.ordrPc;
				if (this._cls_info.dlvyCtAditRgnYn == 'Y'){
					this._cls_info.cartResultMoney["total-dlvyAdit"] += arrCartGrpBaseList[0].gdsInfo.dlvyAditAmt;
				}
				this._cls_info.cartResultMoney["total-dlvyBase"] += arrCartGrpBaseList[0].gdsInfo.dlvyBassAmt;

				arrHtml.push('<div class="order-product-inner">');
				ordrIdx += 1;
				strHtml = this.fn_draw_html_order_product_item(this._cls_info.ordrCd, ordrIdx , false, null, arrCartGrpBaseList[0], items_money, arrCartGrpBaseList, arrCartGrpAditList);
				arrHtml.push(strHtml);

				strHtml = this.fn_draw_html_order_delivery_summary_each(items_money, arrCartGrpBaseList, arrCartGrpAditList);
				arrHtml.push(strHtml);

				arrHtml.push('</div>');

				if (cartIdx.length > 0){
					dlen = cartIdx.length - 1;
					for(dfor=dlen ; dfor>=0 ; dfor--){
						arrCartList.splice(cartIdx[dfor], 1);/*이미 선택한 상품은 제외 한다.*/
					}
					jlen = arrCartList.length;
				}
			}
			/*****************************개별 배송 그룹별 항목을 그린다. cart_grp_no별로 그려야 한다. 끝*****************************/

			arrHtml.push('</div>');//order-body 끝
			arrHtml.push('</div>');//order-product 끝
		}

		$(this._cls_info.pageCartListfix).html(arrHtml.join(''));
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

	/*퍼블리싱에서 order-product => order-body => order-product-inner 의 html*/
	fn_draw_html_order_product_item(ordrCd, ordrIdx, bDlvyGrp, entrpsDlvyGrpInfo, json, items_money, arrCartGrpBaseList, arrCartGrpAditList){
		var thumbnailFile = "/html/page/market/assets/images/noimg.png";
		if (json.gdsInfo.thumbnailFile != undefined){
			thumbnailFile = "/comm/getImage?srvcId=GDS&amp;upNo=" + json.gdsInfo.thumbnailFile.upNo +"&amp;fileTy="+json.gdsInfo.thumbnailFile.fileTy +"&amp;fileNo="+json.gdsInfo.thumbnailFile.fileNo +"&amp;thumbYn=Y";
		}

		var original_price = '';
		if (items_money.originPc != items_money.ordrPc){
			original_price = '<span class="original-price">{0}원</span>'.format(items_money.originPc.format_money());
		}

		var hiddenInfo = '';

		var cartItemOne;
		
		
		cartItemOne = '<div class="order-product-item" ordrCd="{0}" ordrIdx={1}>'.format(ordrCd, ordrIdx)+
			hiddenInfo+
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
						original_price+
						'<strong class="price">{0}원</strong>'.format(items_money.ordrPc.format_money())+
					'</div>'+
				'</div>'+
			'</div>'+
			'<div class="item-option">'+
				'<dl class="option">'+
					this.fn_draw_html_order_product_item_base(ordrCd, ordrIdx, bDlvyGrp, entrpsDlvyGrpInfo, json, arrCartGrpBaseList)+
				'</dl>'+
				'<div class="item-add-box">'+
					this.fn_draw_html_order_product_item_adit(ordrCd, ordrIdx, bDlvyGrp, entrpsDlvyGrpInfo, json, arrCartGrpAditList)+
				'</div>'+
			'</div>'+
			'<!-- <div class="item-btn"></div> -->'+
		'</div>';

		return cartItemOne;
	}

	/*아이템별 정보들-공통사항*/
	fn_draw_html_order_product_item_hidden(ordrOptnTy, ordrCd, ordrIdx, bDlvyGrp, entrpsDlvyGrpInfo, json, aditOptn){
		console.log(json)
		var hiddenInfo = '';
		hiddenInfo += '<input type="hidden" name="ordrDtlCd" value="{0}_{1}">'.format(ordrCd, ordrIdx);
		hiddenInfo += '<input type="hidden" name="gdsNo" value="{0}">'.format(json.gdsInfo.gdsNo);
		hiddenInfo += '<input type="hidden" name="gdsCd" id="gdsCd_{2}_{1}" value="{0}">'.format(json.gdsInfo.gdsCd, ordrIdx, ordrOptnTy);
		hiddenInfo += '<input type="hidden" name="gdsNm" value="{0}">'.format(json.gdsInfo.gdsNm);
		
		hiddenInfo += '<input type="hidden" name="entrpsNo" value="{0}">'.format(json.gdsInfo.entrpsNo);
		hiddenInfo += '<input type="hidden" name="entrpsNm" value="{0}">'.format(json.gdsInfo.entrpsNm == undefined?"":json.gdsInfo.entrpsNm);
		hiddenInfo += '<input type="hidden" name="dlvyGroupYn" value="{0}">'.format(bDlvyGrp?"Y":"N");
		hiddenInfo += '<input type="hidden" name="entrpsDlvygrpNo" value="{0}">'.format((!bDlvyGrp || entrpsDlvyGrpInfo == undefined)?"0":entrpsDlvyGrpInfo.entrpsDlvygrpNo);
		hiddenInfo += '<input type="hidden" name="bnefCd" value=""></input>';
		hiddenInfo += '<input type="hidden" name="recipterUniqueId" value="{0}"></input>'.format(this._cls_info.codeMapJson.recipterUniqueId);
		hiddenInfo += '<input type="hidden" name="bplcUniqueId" value="">';
		hiddenInfo += '<input type="hidden" name="couponNo" id="couponNo_{0}_{1}_{2}" value="">'.format(ordrOptnTy, json.gdsInfo.gdsNo, ordrIdx);
		hiddenInfo += '<input type="hidden" name="couponCd" id="couponCd_{0}_{1}_{2}" value="">'.format(ordrOptnTy, json.gdsInfo.gdsNo, ordrIdx);
		hiddenInfo += '<input type="hidden" name="couponAmt" id="couponAmt_{0}_{1}_{2}" value="0">'.format(ordrOptnTy, json.gdsInfo.gdsNo, ordrIdx);

		hiddenInfo += '<input type="hidden" name="ordrOptnTy" value="{0}">'.format(ordrOptnTy);
		hiddenInfo += '<input type="hidden" name="ordrQy" id ="ordrQy_{0}_{1}"  value="{2}">'.format(ordrOptnTy, ordrIdx, json.ordrQy);

		if (ordrOptnTy == "BASE"){
			hiddenInfo += '<input type="hidden" name="gdsPc" value="{0}">'.format(json.gdsPc);
			hiddenInfo += '<input type="hidden" name="gdsOptnNo" value="{0}"></input>'.format(json.gdsOptnNo);

			hiddenInfo += '<input type="hidden" name="ordrOptn" value="{0}">'.format(json.ordrOptn);
			hiddenInfo += '<input type="hidden" name="ordrOptnPc" value="{0}">'.format(json.ordrOptnPc);

			hiddenInfo += '<input type="hidden" name="ordrPc" id="ordrPc_{0}_{1}_{2}" value="{3}">'.format(ordrOptnTy, json.gdsInfo.gdsNo, ordrIdx, json.ordrPc);// <%--건별 주문금액--%>
			hiddenInfo += '<input type="hidden" name="plusOrdrPc" id="plusOrdrPc_{0}_{1}_{2}" value="{3}">'.format(ordrOptnTy, json.gdsInfo.gdsNo, ordrIdx, json.ordrPc);// <%--건별 주문금액 초기화를 위한 여분--%>

			hiddenInfo += '<input type="text" name="dlvyAditAmt" value="{0}">'.format(json.gdsInfo.dlvyAditAmt);
			
		}else if (ordrOptnTy == "ADIT"){
			hiddenInfo += '<input type="hidden" name="gdsPc" value="{0}">'.format(0);
			hiddenInfo += '<input type="hidden" name="gdsOptnNo" value="{0}"></input>'.format(aditOptn.gdsOptnNo);
			hiddenInfo += '<input type="hidden" name="ordrOptn" value="{0}">'.format(aditOptn.optnNm);
			hiddenInfo += '<input type="hidden" name="ordrOptnPc" value="{0}">'.format(aditOptn.optnPc);

			hiddenInfo += '<input type="hidden" name="ordrPc" id="ordrPc_{0}_{1}_{2}" value="{3}">'.format(ordrOptnTy, json.gdsInfo.gdsNo, ordrIdx, aditOptn.optnPc);// <%--건별 주문금액--%>
			hiddenInfo += '<input type="hidden" name="plusOrdrPc" id="plusOrdrPc_{0}_{1}_{2}" value="{3}">'.format(ordrOptnTy, json.gdsInfo.gdsNo, ordrIdx, aditOptn.optnPc);// <%--건별 주문금액 초기화를 위한 여분--%>
		}

		hiddenInfo += '<input type="hidden" name="dlvyBassAmt" id="dlvyBassAmt_{0}_{1}_{2}" value="{3}">'.format(ordrOptnTy, json.gdsInfo.gdsNo, ordrIdx, (ordrOptnTy =="BASE")?json.gdsInfo.dlvyBassAmt:"0");// <%--배송비 > 추가옵션일경우 제외 --%>
		hiddenInfo += '<input type="hidden" name="plusDlvyBassAmt" id="plusDlvyBassAmt_{0}_{1}_{2}" value="{3}">'.format(ordrOptnTy, json.gdsInfo.gdsNo, ordrIdx, (ordrOptnTy =="BASE")?json.gdsInfo.dlvyBassAmt:"0");// <%--배송비 > 할인초기화를 위한 여분 --%>
						
		if (json.gdsInfo.mlgPvsnYn == 'Y' && this._cls_info.ordrTy == 'N' && !isNaN(this._cls_info.codeMapJson._mileagePercent) ){
			hiddenInfo += '<input type="hidden" name="accmlMlg" value="{0}" />'.format(Math.round(json.gdsInfo.pc * json.ordrQy * this._cls_info.codeMapJson._mileagePercent) / 100);
			// <%--마일리지 > 비급여제품 + 마일리지 제공 제품--%>
		}else{
			hiddenInfo += '<input type="hidden" name="accmlMlg" value="0" />'
		}

		return hiddenInfo;
	}

	/*기본 옵션*/
	fn_draw_html_order_product_item_base(ordrCd, ordrIdx, bDlvyGrp, entrpsDlvyGrpInfo, json, arrCartGrpBaseList){
		var cartItemBaseList = [];

		if (arrCartGrpBaseList != undefined && arrCartGrpBaseList.length > 0
			&& json.gdsInfo != undefined && json.gdsInfo.optnList != undefined && json.gdsInfo.optnList.length > 0){
			var ifor, ilen = arrCartGrpBaseList.length;
			var aditOptnOne, aditOptnList = json.gdsInfo.optnList;
			var cartItemBaseOne;
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

				cartItemBaseOne = '<dd>'+
					'<span class="label-flat">{0}</span>'.format(json.ordrOptn)+
					'<span>{0}개(+{1}원)</span>'.format(json.ordrQy, json.ordrPc.format_money())+
				'</dd>';

				cartItemBaseList.push(cartItemBaseOne);

				cartItemBaseOne = '<div class="cart item draw {0}_{1}">'.format(ordrCd, ordrIdx);
				cartItemBaseOne += this.fn_draw_html_order_product_item_hidden("BASE", ordrCd, ordrIdx, bDlvyGrp, entrpsDlvyGrpInfo, json, null);
				cartItemBaseOne += "</div>"

				cartItemBaseList.push(cartItemBaseOne);
			}
		}else{//기본 옵션이 없는 경우
			cartItemBaseOne = '<div class="cart item draw {0}_{1}">'.format(ordrCd, ordrIdx);
			cartItemBaseOne += this.fn_draw_html_order_product_item_hidden("BASE", ordrCd, ordrIdx, bDlvyGrp, entrpsDlvyGrpInfo, json, null);
			cartItemBaseOne += "</div>"

			cartItemBaseList.push(cartItemBaseOne);
		}

		return cartItemBaseList.join('');

	}

	/*추가 옵션*/
	fn_draw_html_order_product_item_adit(ordrCd, ordrIdx, bDlvyGrp, entrpsDlvyGrpInfo, json, arrCartGrpAditList){
		var cartItemAditList = [];

		if (arrCartGrpAditList != undefined && arrCartGrpAditList.length > 0
			&& json.gdsInfo != undefined && json.gdsInfo.aditOptnList != undefined && json.gdsInfo.aditOptnList.length > 0){
			var ifor, ilen = arrCartGrpAditList.length;
			var aditOptnOne, aditOptnList = json.gdsInfo.aditOptnList;
			var cartItemAditOne;
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

				cartItemAditOne = '<div class="item-add{0}">'.format(((aditOptnOne.soldOutYn == 'Y')?" disabled ":""))+
					'<span class="label-outline-primary">'+
						'<span>추가</span>'+
						'<i><img src="/html/page/market/assets/images/ico-plus-white.svg" alt=""></i>'+
					'</span>'+
					'<div class="name">'+
						'<span class="font-semibold">{0}</span>'.format(aditOptnOne.optnNm.replace("* ", ""))+
						'<span class="font-semibold">{0}개</span>'.format(arrCartGrpAditList[ifor].ordrQy)+
						'<span>(+{0}원)</span>'.format((aditOptnOne.optnPc * arrCartGrpAditList[ifor].ordrQy).format_money())+
						((aditOptnOne.soldOutYn == 'Y')?'<strong class="text-soldout">임시품절</strong>':'')+
					'</div>'+
				'</div>';

				cartItemAditList.push(cartItemAditOne);

				cartItemAditOne = '<div class="cart item draw {0}_{1}">'.format(ordrCd, ordrIdx);
				cartItemAditOne += this.fn_draw_html_order_product_item_hidden("ADIT", ordrCd, ordrIdx, bDlvyGrp, entrpsDlvyGrpInfo, json, aditOptnOne);
				cartItemAditOne += '</div>';

				cartItemAditList.push(cartItemAditOne);
			}


		}	

		return cartItemAditList.join('');

		
	}

	/*퍼블리싱에서 order-product => order-body => order-item-payment 의 html*/
	/*
		개별 배송
		items_money ==> fn_calc_order_product_item_money함수에서 만들어진 값
		arrCartGrpBaseList : 기본 상품 리스트
		arrCartGrpAditList : 추가 상품 리스트
	*/
	fn_draw_html_order_delivery_summary_each(items_money, arrCartGrpBaseList, arrCartGrpAditList){
		var gdsInfo = arrCartGrpBaseList[0].gdsInfo;

		var temp = '';

		if (gdsInfo.dlvyCtTy == 'FREE'){
			temp = "무료";
		} else if (gdsInfo.dlvyCtTy == 'OVERMONEY'){
			if (items_money.ordrPc >= gdsInfo.dlvyCtCnd){
				temp = "무료";
			}else{
				temp = gdsInfo.dlvyBassAmt.format_money() +  "원";
			}
		} else if (gdsInfo.dlvyCtTy == 'PERCOUNT' && !isNaN(gdsInfo.dlvyCtCnd) && gdsInfo.dlvyCtCnd != 0){
			temp = (gdsInfo.dlvyBassAmt * Math.ceil(items_money.ordrQy / gdsInfo.dlvyCtCnd)).format_money() +  "원";
		} else {//if (gdsInfo.dlvyCtTy == 'PAY')
			temp = gdsInfo.dlvyBassAmt.format_money() +  "원";
		}

		var strHtml = '<dl class="order-item-payment">'+
			'<dt>배송비</dt>'+
			'<dd class="delivery-charge">{0}</dd>'.format(temp)+
		'</dl>';
		
		return strHtml;
	}

	/*
		묶음배송
		items_money ==> fn_calc_order_product_item_money함수에서 만들어진 값
		entrpsDlvyGrpInfo : 묶음배송 정보
		arrCartGrpBaseAllList : 기본 상품 전체
		arrCartGrpAditAllList : 추가 상품 전체
	*/
	fn_draw_html_order_delivery_summary_grp(items_money, entrpsDlvyGrpInfo, arrCartGrpBaseAllList, arrCartGrpAditAllList){
		
		return '<dl class="order-item-payment">'+
			'<dt>배송비</dt>'+
			'<dd class="delivery-charge">{0}원</dd>'.format(arrCartGrpBaseAllList[0].gdsInfo.dlvyBassAmt.format_money())
		'</dl>';
	}

	/*최종 결제금액 확인 표시하는 부분*/
	fn_draw_result_money(){
		var key;
		
		var money = 0;

		key = "total-ordrpc";
		money += this._cls_info.cartResultMoney[key];
		$(this._cls_info.pageResultRricefix + " ." + key + "-dl ." + key + "-txt").html(this._cls_info.cartResultMoney[key].format_money());

		key = "total-coupon";
		money -= this._cls_info.cartResultMoney[key];
		$(this._cls_info.pageResultRricefix + " ." + key + "-dl ." + key + "-txt").html(this._cls_info.cartResultMoney[key].format_money());

		key = "total-mlg";
		money -= this._cls_info.cartResultMoney[key];
		$(this._cls_info.pageResultRricefix + " ." + key + "-dl ." + key + "-txt").html(this._cls_info.cartResultMoney[key].format_money());

		key = "total-dlvyBase";
		money += this._cls_info.cartResultMoney[key];
		$(this._cls_info.pageResultRricefix + " ." + key + "-dl ." + key + "-txt").html(this._cls_info.cartResultMoney[key].format_money());

		key = "total-dlvyAdit";
		money += this._cls_info.cartResultMoney[key];
		$(this._cls_info.pageResultRricefix + " ." + key + "-dl ." + key + "-txt").html(this._cls_info.cartResultMoney[key].format_money());

		$("#stlmAmt").val(money);
		$(this._cls_info.pageResultRricefix + " .total-stlmAmt-txt").html(money.format_money());
	}

	
	f_findAdresCallback2(){
		let zipcode = $("#recptrZip").val();

		jsCallApi.call_api_post_json(this, "/comm/dlvyCt/chkRgn.json", 'fn_chkRgn_cb',  {
			zip : zipcode
		}, {});

	}

	fn_chkRgn_cb(result, fail, data, param){
		if (result.result){
			this._cls_info.dlvyCtAditRgnYn = 'Y';
		}else{
			this._cls_info.dlvyCtAditRgnYn = 'N';
		}

		this.fn_calc_dlvyadit();
		this.f_calStlmAmt();
	}

	f_use_coupon_click(){
		if($("#use-coupon").html() == '' ){
			var arrGdsCd = [], arrOrdrPc = [], arrOrdrQy = [];
			var key, money = 0;

			key = "total-ordrpc";
			money += this._cls_info.cartResultMoney[key];
			
			key = "total-dlvyBase";
			money += this._cls_info.cartResultMoney[key];
			
			

			if($("#usePoint").val() > 0){
				money += $("#usePoint").val();
			}

			if($("#useMlg").val() > 0){
				money += $("#useMlg").val();
			}

			var jobjDtl, jobjCartList = $(this._cls_info.pageCartListfix + " .draw.cart.item");

			var ifor, ilen = jobjCartList.length;

			for(ifor=0 ; ifor<ilen ; ifor++){
				jobjDtl = $(jobjCartList[ifor]);
				if (jobjDtl.find('input[name="ordrOptnTy"]').val() == "BASE"){
					arrGdsCd.push(jobjDtl.find('input[name="gdsCd"]').val());
					arrOrdrQy.push(jobjDtl.find('input[name="ordrQy"]').val());
					arrOrdrPc.push(jobjDtl.find('input[name="ordrPc"]').val());
				}

			}


			$("#use-coupon").load("/comm/dscnt/coupon"
					, {arrGdsCd : arrGdsCd
						, baseTotalAmt : money
						, arrOrdrQy : arrOrdrQy
						, arrOrdrPc : arrOrdrPc}
					, function(){
						$("#coupon-modal").modal('show');
						
					});
			}else{
				$("#coupon-modal").modal('show');
			}
	}

	f_calStlmAmt(){
		// let stlmAmt = 0; $("input[name='ordrPc']").each(function(){ stlmAmt += Number($(this).val()) });
    	// let dlvyBassAmt = 0; $("input[name='dlvyBassAmt']").each(function(){ dlvyBassAmt += Number($(this).val()) });
    	// let dlvyAditAmt = 0; $("input[name='dlvyAditAmt']").each(function(){ dlvyAditAmt += Number($(this).val()) });
    	let useMlg = uncomma($("#frmOrdr #useMlg").val());
    	let usePoint = uncomma($("#frmOrdr #usePoint").val());
    	let totalCouponAmt = uncomma($("#frmOrdr #totalCouponAmt").val());

		if (!isNaN(totalCouponAmt)){
			this._cls_info.cartResultMoney["total-coupon"] = Number(totalCouponAmt);
		}
		if (!isNaN(useMlg) && !isNaN(usePoint)){
			this._cls_info.cartResultMoney["total-mlg"] = Number(usePoint) + Number(useMlg);
		}

		this.fn_draw_result_money();
    	// let calStlmAmt = 0;

    	// /*console.log("totalCouponAmt> ", totalCouponAmt, useMlg, usePoint, stlmAmt);
    	// console.log("배송비 : " + dlvyBassAmt);
    	// console.log("쿠폰비 : " + totalCouponAmt.toString().replace(",",""));*/

    	// if(totalCouponAmt != null){
    	// 	totalCouponAmt = totalCouponAmt.toString().replace(",","");
    	// }

    	// calStlmAmt = (Number(stlmAmt) + Number(dlvyBassAmt) + Number(dlvyAditAmt)) - Number(useMlg) - Number(usePoint) - Number(totalCouponAmt);

    	// //console.log("calStlmAmt> ", calStlmAmt);


    	// $("#frmOrdr #stlmAmt").val(calStlmAmt);
    	// $("#frmOrdr .total-stlmAmt-txt").text(comma(calStlmAmt));
	}

	f_ordr_dtls(){
		var jobjCartList = $(this._cls_info.pageCartListfix + " .draw.cart.item");
		var jobjDtl;
		var itemone;
		var arrDtls = [];
		var ifor, ilen = jobjCartList.length;

		for(ifor=0 ; ifor<ilen ; ifor++){
			jobjDtl = $(jobjCartList[ifor]);

			itemone = {};
			arrDtls.push(itemone);

			itemone.ordrDtlCd			= jobjDtl.find('input[name="ordrDtlCd"]').val();
			itemone.gdsNo				= jobjDtl.find('input[name="gdsNo"]').val();
			itemone.gdsCd				= jobjDtl.find('input[name="gdsCd"]').val();
			itemone.gdsNm				= jobjDtl.find('input[name="gdsNm"]').val();
			itemone.gdsPc				= jobjDtl.find('input[name="gdsPc"]').val();
			itemone.entrpsNo			= jobjDtl.find('input[name="entrpsNo"]').val();
			itemone.entrpsNm			= jobjDtl.find('input[name="entrpsNm"]').val();
			itemone.dlvyGroupYn			= jobjDtl.find('input[name="dlvyGroupYn"]').val();
			itemone.entrpsDlvygrpNo		= jobjDtl.find('input[name="entrpsDlvygrpNo"]').val();
			itemone.bnefCd				= jobjDtl.find('input[name="bnefCd"]').val();
			itemone.recipterUniqueId	= jobjDtl.find('input[name="recipterUniqueId"]').val();
			itemone.bplcUniqueId		= jobjDtl.find('input[name="bplcUniqueId"]').val();
			itemone.couponNo			= jobjDtl.find('input[name="couponNo"]').val();
			itemone.couponCd			= jobjDtl.find('input[name="couponCd"]').val();
			itemone.couponAmt			= jobjDtl.find('input[name="couponAmt"]').val();
			itemone.gdsOptnNo			= jobjDtl.find('input[name="gdsOptnNo"]').val();
			itemone.ordrOptnTy			= jobjDtl.find('input[name="ordrOptnTy"]').val();
			itemone.ordrOptn			= jobjDtl.find('input[name="ordrOptn"]').val();
			itemone.ordrOptnPc			= jobjDtl.find('input[name="ordrOptnPc"]').val();
			itemone.ordrQy				= jobjDtl.find('input[name="ordrQy"]').val();
			itemone.ordrPc				= jobjDtl.find('input[name="ordrPc"]').val();
			itemone.plusOrdrPc			= jobjDtl.find('input[name="plusOrdrPc"]').val();
			itemone.dlvyBassAmt			= jobjDtl.find('input[name="dlvyBassAmt"]').val();
			itemone.plusDlvyBassAmt		= jobjDtl.find('input[name="plusDlvyBassAmt"]').val();
			itemone.accmlMlg			= jobjDtl.find('input[name="accmlMlg"]').val();

		}

		return arrDtls;
	}

	fn_remove_item_hidden(){
		$(this._cls_info.pageCartListfix + " .cart.item.draw input[type='hidden']").remove();
	}
	async f_pay(frm){
		let owner = this;
    	let stlmAmt = $("#stlmAmt").val();
		let _bootpayScriptKey = this._cls_info.codeMapJson._bootpayScriptKey;
		let test_deposit = (this._cls_info.codeMapJson._activeMode != "REAL")?true:false;

		let orderDtls = this.f_ordr_dtls();
		$("input[name='ordrDtls']").val(JSON.stringify(orderDtls));
		
    	//console.log('결제금액: ', stlmAmt);

    	if(stlmAmt > 0){
			var order_name;
			
			order_name = this._cls_info.cartList[0].gdsInfo.gdsNm;
			if (this._cls_info.cartList.length > 1){
				order_name += " 외 {0}건".format(this._cls_info.cartList.length -1);
			}
	    	//async
	    	try {
	   	    	//결제요청
	   	    	const response = await Bootpay.requestPayment({
	   	    		  "application_id": _bootpayScriptKey,
	   	    		  "price": stlmAmt,
					  "order_name": order_name,
	   	    		  "order_id": owner._cls_info.codeMapJson.ordrCd,
	   	    		  "pg": "이니시스",
	   	    		  "method": "",
	   	    		  "tax_free": 0,
	   	    		  "user": {
	   	    		    "id": owner._cls_info.mbrSession.mbrId,
	   	    		    "username": owner._cls_info.mbrSession.mbrNm,
	   	    		    "phone": owner._cls_info.mbrSession.mblTelno,
	   	    		    "email": owner._cls_info.mbrSession.eml,
	   	    		  },
	   	    		  "extra": {
	   	    		    "open_type": "iframe",
	   	    		   // "card_quota": "0,2,3",
	   	    		    "escrow": false,
	   	    		 	"separately_confirmed":true,
	   	    		 	"deposit_expiration":f_getDate(2)+" 23:59:00",
						"test_deposit":test_deposit
	   	    		  }
	   	    		});

	   	    	//응답처리
				switch (response.event) {
			        case 'issued':
			            break
			        case 'done':
			            console.log("done: ", response);
			            // 결제 완료 처리
			            break
			        case 'confirm':
			            const confirmedData = await Bootpay.confirm() //결제를 승인한다

			            if(confirmedData.event === 'done') {
							const stlmDt = confirmedData.data.purchased_at;
							const delngNo = confirmedData.data.receipt_id; // : 거래번호 => DELNG_NO
							const stlmKnd = confirmedData.data.method_symbol.toUpperCase(); // 결테타입 : CARD  => stlmKnd
							const stlmTy = confirmedData.data.method_origin_symbol; // 결테타입 : CARD  => STLM_TY

							$("#delngNo").val(delngNo);
				            $("#stlmKnd").val(stlmKnd);
							$("#stlmTy").val(stlmTy);
				            $("#stlmDt").val(stlmDt);

				            if(stlmKnd === "CARD"){ //CARD
				            	const cardAprvno = confirmedData.data.card_data.card_approve_no; //카드 승인번호 => CARD_APRVNO
					            const cardCoNm = confirmedData.data.card_data.card_company; //카드회사 => CARD_CO_NM
					            const cardNo = confirmedData.data.card_data.card_no; //카드번호 => CARD_NO

				            	$("#stlmYn").val("Y");
					            $("#cardAprvno").val(cardAprvno);
					            $("#cardCoNm").val(cardCoNm);
					            $("#cardNo").val(cardNo);
				            }else if(stlmTy.toUpperCase() === "BANK"){ //BANK
					        	const dpstBankCd = confirmedData.data.bank_data.bank_code;
					        	const dpstBankNm = confirmedData.data.bank_data.bank_name;

				            	$("#stlmYn").val("Y");
					            $("#dpstBankCd").val(dpstBankCd);
					            $("#dpstBankNm").val(dpstBankNm);
				            }
							owner.fn_remove_item_hidden();
			            	frm.submit();
			            } else if(confirmedData.event === 'issued') {
			            	const stlmDt = confirmedData.data.purchased_at;
							const delngNo = confirmedData.data.receipt_id; // : 거래번호 => DELNG_NO
							const stlmTy = confirmedData.data.method_origin_symbol; // 결테타입 : CARD  => STLM_TY
							const stlmKnd = confirmedData.data.method_symbol.toUpperCase(); // 결테타입 : CARD  => stlmKnd

							$("#delngNo").val(delngNo);
							$("#stlmKnd").val(stlmKnd);
				            $("#stlmTy").val(stlmTy);
				            $("#stlmDt").val(stlmDt);

				            if(stlmTy.toUpperCase() === "VBANK"){ //VBANK
				            	const vrActno = confirmedData.data.vbank_data.bank_account;
					        	const dpstBankCd = confirmedData.data.vbank_data.bank_code;
					        	const dpstBankNm = confirmedData.data.vbank_data.bank_name;
					        	const dpstr = confirmedData.data.vbank_data.bank_username;
					        	const pyrNm = confirmedData.data.vbank_data.sender_name;
					        	const dpstTermDt = confirmedData.data.vbank_data.expired_at;

					            $("#stlmYn").val("N");
					            $("#vrActno").val(vrActno);
					            $("#dpstBankCd").val(dpstBankCd);
					            $("#dpstBankNm").val(dpstBankNm);
					            $("#dpstr").val(dpstr);
					            $("#pyrNm").val(pyrNm);
					            $("#dpstTermDt").val(dpstTermDt);
				            }
							owner.fn_remove_item_hidden();
				            frm.submit();

			            } else if(confirmedData.event === 'error') {
			                //결제 승인 실패
			                alert("결제에 실패하였습니다.");

			            }
			            break
			        default:
			            break
			    }


		    } catch (e) {

		        switch (e.event) {
		            case 'cancel':
		                console.log(e.message);	// 사용자가 결제창을 닫을때 호출
		                break
		            case 'error':
		                console.log(e.error_code); // 결제 승인 중 오류 발생시 호출
		                if(e.error_code === 'RC_PRICE_LEAST_LT'){
		                	alert("결제금액이 너무 작습니다.")
		                }
		                break
		        }
		    }

    	} else {

    		$("#stlmYn").val("Y");
			$("#stlmKnd").val("FREE");
    		$("#stlmTy").val("FREE");
			owner.fn_remove_item_hidden();
    		frm.submit();
    	}
    }
}

class JsMarketDlvyGrpCalc{

	fn_calc_dlvygrp(entrpsDlvyGrpInfo, arrCartGrpBaseList){
		return 0;
	}
}