class JsMarketCartList extends JsMargetCartDrawItems{
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

			this._cls_info.ordrCd = '';/*주문 번호 : 카드에서는 없다*/
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

            this.fn_draw_cart_entrpsdlvygrp_list(".cart-list-container.welfare", this._cls_info.cartListWelfareJson);
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
			this.fn_draw_cart_entrpsdlvygrp_list(".cart-list-container.ordr", this._cls_info.cartListOrdrJson);
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
		
		this._cls_info.coms.jsCommon.fn_checkbox_ctl_list(true, list);
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
			if ($(this).closest(".order-product-inner").find(".btn-delete2.cart.gdsOptn").length < 2){
				alert("기본 옵션은 1개 이상 필요합니다.")
				return;
			}
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

		$( this._cls_info.pagePrefix + " .cart-list-container .order-product-inner .order-item-thumb").off('click').on('click',  function() {
			owner.fn_gds_view($(this));
		});
		$( this._cls_info.pagePrefix + " .cart-list-container .order-product-inner .order-item-base .gdsCd").off('click').on('click',  function() {
			owner.fn_gds_view($(this));
		});
    }

	fn_gds_view(jobjTarget){
		jobjTarget = jobjTarget.closest(".order-product-inner");

		var url = "/market/gds/{0}/{1}".format(jobjTarget.attr("ctgryNo"), jobjTarget.attr("gdsCd"));

		window.open(url, "_blank");
	}

	fn_draw_cart_entrpsdlvygrp_item_business(json){
		return '<dl class="order-item-business">'+
			'<dd class="form-check"><input class="form-check-input entrpsAll" type="checkbox" name="entrpsAll" value="{0}"></dd>'.format(json == undefined ? '' : json.entrpsNo)+
			'<dt><span>{0}</span></dt>'.format(json == undefined ? '' : json.entrpsNm)+
		'</dl>';
	}



	fn_draw_cart_entrpsdlvygrp_itemgrp_sold_out(){
		var strHtml = '<div class="order-disabled"><strong>품절 상품입니다</strong></div>';
		
		return strHtml;
	}

	/*
		ordrOptnTy : BASE, ADIT 구분자
		json : 구매한 상품(cart에 담겨있는 상품)
		aditOptnOne : BASE 이면 기본 상품의 정보, ADIT 이면 추가상품의 정보
		ableBuy : 구매가능 여부
	*/
	fn_draw_cart_entrpsdlvygrp_input_hidden(ordrOptnTy, json, aditOptnOne, ableBuy){
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

		var listTemp, listCheckbox = jobjRoot.find(".order-product .order-product-inner input[type='checkbox']:checked.cartGrpNo");
		var jobjTemp, jobjTarget, jobjCartGrp;
		var money = 0;
		var arrEntrpsDlvygrpList = [];
		var entrpsdlvygrpno;
		
		/*총 상품 금액 계산*/
		var ifor, ilen = listCheckbox.length;
		for(ifor=0 ; ifor<ilen ; ifor++){
			jobjTarget = $(listCheckbox[ifor]);

			jobjCartGrp = jobjTarget.closest('.order-product-inner');

			listTemp = jobjCartGrp.find('input[name="ordrPc"]');
			$.each (listTemp, function (index, el) {
				money += Number($(el).val().replace(",", ""));
			});
			
		}

		var dlvyBase = 0;
		/*배송비 계산*/
		for(ifor=0 ; ifor<ilen ; ifor++){
			jobjTarget = $(listCheckbox[ifor]);
			jobjCartGrp = jobjTarget.closest('.order-product-inner');

			if(jobjCartGrp.hasClass("entrpsDlvygrpNo") && jobjCartGrp.attr("entrpsDlvygrpNo") != undefined){/*그룹배송이 있는 경우*/
				entrpsdlvygrpno = jobjCartGrp.attr("entrpsDlvygrpNo");
				if (arrEntrpsDlvygrpList.indexOf(entrpsdlvygrpno) >= 0){
					/*묶음배송으로 이미 더해졌다*/
					continue;
				}

				/*묶음 배송이더라도 1개이면 개별 배송으로 처리한다.*/
				if (jobjRoot.find(".order-product .order-product-inner[entrpsdlvygrpno='{0}'] input[type='checkbox']:checked.cartGrpNo".format(entrpsdlvygrpno)).length > 1){
					arrEntrpsDlvygrpList.push(entrpsdlvygrpno);

					jobjTemp = jobjRoot.find(".order-item-payment.entrpsDlvygrpNo[entrpsdlvygrpno='{0}'] input[name='dlvyGrpBaseAmt']".format(entrpsdlvygrpno));
					if (jobjTemp.length > 0){
						dlvyBase += Number($(jobjTemp[0]).val());
						continue;
					}
				}
			}

			/*개별 배송을 더한다.*/
			jobjTemp = jobjCartGrp.find('input[name="dlvyBaseAmt"]');
			if (jobjTemp.length > 0){
				dlvyBase += Number($(jobjTemp[0]).val());
			}
			
		}

		return {"total-ordrpc":money, "total-dlvyBase":dlvyBase, "total-dlvyAdit":0}
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
		
		this._cls_info.coms.jsCommon.fn_checkbox_ctl_list(checked, list);
	}

	fn_checkbox_all_click(jobjTarget, bChecked){
		var jobjRoot = jobjTarget.closest('.cart-list-container');
		var list = jobjRoot.find('input[type="checkbox"][name="cartGrpNo"].form-check-input');
		
		this._cls_info.coms.jsCommon.fn_checkbox_ctl_list(bChecked, list);
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

		var ableBuy = 'Y';
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
					ableBuy = 'N'
				}
			});

			cartGrpNos.push(jobjCartGrp.attr("cartGrpNo"));
		}

		if (ableBuy != 'Y'){
			alert("품절된 상품이 존재합니다.")
			return;
		}

		if (!confirm("주문하시겠습니까?")){
			return;
		}
		let params = {cartTy, cartGrpNos : cartGrpNos.join(',')};

		jsCallApi.call_svr_post_move(this._cls_info._marketPath + '/ordr/cartPay', params)
	}
}

