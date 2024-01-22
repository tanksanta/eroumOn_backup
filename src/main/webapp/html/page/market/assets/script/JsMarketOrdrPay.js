class JsMarketOrdrPay extends JsMargetCartDrawItems{
    constructor(ordrTy, path, mbrSession, cartList, entrpsDlvyGrpVOList, entrpsVOList, codeMapJson){
        super();
		

		this._cls_info.jsMarketDlvyGrpCalc = new JsMarketDlvyGrpCalc();;

		this._cls_info.ordrTy = ordrTy;
        this._cls_info.mbrSession = mbrSession;
        this._cls_info._membershipPath = path._membershipPath;
        this._cls_info._marketPath = path._marketPath;


		// console.log(cartList)
		if (cartList.trim().length > 0){
			this._cls_info.cartList = JSON.parse(cartList);
			this._cls_info.drawCartList = JSON.parse(cartList);
		}

		// console.log(entrpsDlvyGrpVOList)
		if (entrpsDlvyGrpVOList.trim().length > 0){
			this._cls_info.entrpsDlvyGrpVOList = JSON.parse(entrpsDlvyGrpVOList);
		}

		// console.log(entrpsVOList)
		if (entrpsVOList.trim().length > 0){
			this._cls_info.entrpsVOList = JSON.parse(entrpsVOList);
		}

		// console.log(codeMapJson)
		if (codeMapJson.trim().length > 0){
			this._cls_info.codeMapJson = JSON.parse(codeMapJson);

			this._cls_info.ordrCd = this._cls_info.codeMapJson.ordrCd;
			this._cls_info.ordrIdx = 0;/*주문 상세 인덱스*/
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
									
		this.fn_draw_cart_entrpsdlvygrp_list(this._cls_info.pageCartListfix , this._cls_info.drawCartList);

		this.fn_calc_dlvybase();
		this.fn_calc_dlvyadit();
		this.fn_draw_result_money();

        this.fn_page_init();

    }

	/*개별 배송을 계산.*/
	fn_calc_dlvybase(){
		var cartList = $(this._cls_info.pageCartListfix + " .order-product-inner");
		
		var jobjRoot = $(this._cls_info.pageCartListfix);
		var jobjCartGrp, jobjTemp;
		var dlvyBase = 0;
		var arrEntrpsDlvygrpList = [];
		var entrpsdlvygrpno;
		var ifor, ilen = cartList.length;
		/*배송비 계산*/
		for(ifor=0 ; ifor<ilen ; ifor++){
			jobjCartGrp = $(cartList[ifor]);

			if(jobjCartGrp.hasClass("entrpsDlvygrpNo") && jobjCartGrp.attr("entrpsDlvygrpNo") != undefined){/*그룹배송이 있는 경우*/
				entrpsdlvygrpno = jobjCartGrp.attr("entrpsDlvygrpNo");
				if (arrEntrpsDlvygrpList.indexOf(entrpsdlvygrpno) >= 0){
					/*묶음배송으로 이미 더해졌다*/
					continue;
				}

				/*묶음 배송이더라도 1개이면 개별 배송으로 처리한다.*/
				if (jobjRoot.find(".order-product .order-product-inner[entrpsdlvygrpno='{0}']".format(entrpsdlvygrpno)).length > 1){
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
		this._cls_info.cartResultMoney["total-dlvyBase"] = dlvyBase;
	}

	/*추가 배송비 계산*/
	fn_calc_dlvyadit(){
		if (this._cls_info.dlvyCtAditRgnYn != 'Y'){/*도서산간 추가 배송지 지역이 아닌경우*/
			this._cls_info.cartResultMoney["total-dlvyAdit"] = 0;
			return;
		}
		var jobjDtl, jobjCartList = $(this._cls_info.pageCartListfix + " .order-product-inner.cartGrp ");

		var entrpsDlvygrpList = [];
		var entrpsDlvygrpNo;
		var ifor, ilen = jobjCartList.length;
		var money = 0;
		for(ifor=0 ; ifor<ilen ; ifor++){
			jobjDtl = $(jobjCartList[ifor]);
			entrpsDlvygrpNo = jobjDtl.attr("entrpsDlvygrpNo");
			if (entrpsDlvygrpNo == undefined || entrpsDlvygrpList.indexOf(entrpsDlvygrpNo) < 0){
				if (jobjDtl.find('input[name="ordrOptnTy"]').val() == "BASE"){
					money += Number(jobjDtl.find('input[name="dlvyAditAmt"]').val());
					if (entrpsDlvygrpNo != undefined) entrpsDlvygrpList.push(entrpsDlvygrpNo);
				}
			}
			
		}

		if (isNaN(money)){
			alert("도서산간 배송비를 계산하는 중 오류가 발생하였습니다. 다시 시도해 주십시오.")
			window.location.reload();
		}
		this._cls_info.cartResultMoney["total-dlvyAdit"] = money;
	}

	fn_draw_cart_entrpsdlvygrp_itemgrp_one(entrpsDlvyGrpInfo, arrCartGrpBaseAllList, arrCartGrpAditAllList){
		var strItemOptionBase = this.fn_draw_cart_entrpsdlvygrp_itemgrp_base_list(entrpsDlvyGrpInfo, arrCartGrpBaseAllList);
		var strItemOptionAdit = this.fn_draw_cart_entrpsdlvygrp_itemgrp_adit_list(entrpsDlvyGrpInfo, arrCartGrpAditAllList);
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
		
		
		var noOptnInputhidden;
		if ((isNaN(json.gdsOptnNo) || json.gdsOptnNo == 0) && json.gdsInfo.optnList.length < 1){
			this._cls_info.ordrIdx += 1;
			noOptnInputhidden = this.fn_draw_cart_entrpsdlvygrp_input_hidden("BASE", entrpsDlvyGrpInfo, json, null, 'Y');
		}else{
			noOptnInputhidden = '';
		}
		
		var strHtml = ''+
			'<div class="order-product-inner cartGrp{2}" cartGrpNo="{0}" {1} ctgryNo="{3}" gdsCd="{4}">'.format(json.cartGrpNo, entrpsDlvygrpAttr, entrpsDlvygrpCls, json.gdsInfo.ctgryNo, json.gdsInfo.gdsCd)+
				'<div class="order-product-item">'+
					'<div class="item-thumb">'+
						'<div class="form-check">'+
							'<input class="form-check-input cartGrpNo" type="checkbox" name="cartGrpNo" value="{0}" cartGrpNo="{0}">'.format(json.cartGrpNo)+
						'</div>'+
						'<div class="order-item-thumb  move cursor">'+
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
								'<u class="gdsCd move cursor">{0}</u>'.format(json.gdsCd)+
							'</p>'+
							'<div class="product">'+
								'<p class="name gdsNm move cursor">{0}</p>'.format(json.gdsNm)+
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
					noOptnInputhidden+
				'</div>'+
			'</div>';

		return strHtml;
	}

	
	/*아이템별 정보들-공통사항*/
	fn_draw_cart_entrpsdlvygrp_input_hidden(ordrOptnTy, entrpsDlvyGrpInfo, json, aditOptn){
		var bDlvyGrp = (entrpsDlvyGrpInfo == undefined)?false:true;
		var ordrCd = this._cls_info.ordrCd;
		var ordrIdx = this._cls_info.ordrIdx;

		this._cls_info.cartResultMoney["total-ordrpc"] += json.ordrPc;/*총 상품 금액은 전체 상품 금액의 합*/

		// console.log(json)
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

			hiddenInfo += '<input type="hidden" name="dlvyAditAmt" value="{0}">'.format(json.gdsInfo.dlvyAditAmt);
			
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
			hiddenInfo += '<input type="hidden" name="accmlMlg" value="{0}" />'.format(Math.floor(json.gdsInfo.pc * json.ordrQy * this._cls_info.codeMapJson._mileagePercent / 100));
			// <%--마일리지 > 비급여제품 + 마일리지 제공 제품--%>
		}else{
			hiddenInfo += '<input type="hidden" name="accmlMlg" value="0" />'
		}

		return hiddenInfo;
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

			var jobjDtl, jobjCartList = $(this._cls_info.pageCartListfix + " .order-product-inner.cartGrp");

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
    	
	}

	f_ordr_dtls(){
		var jobjCartList = $(this._cls_info.pageCartListfix + " .order-product-inner.cartGrp");
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