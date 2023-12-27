class JsMarketGdsView{
    constructor(path, loginCheck, gdsVOString){
        
        this._cls_info = this._cls_info || {};

        this._cls_info.loginCheck = loginCheck;
        this._cls_info._membershipPath = path._membershipPath;
        this._cls_info._marketPath = path._marketPath;

		console.log(gdsVOString)
		if (gdsVOString.trim().length > 0){
			this._cls_info.gdsVOJson = JSON.parse(gdsVOString);

			if (this._cls_info.gdsVOJson != undefined){
				if (this._cls_info.gdsVOJson.optnTtl != undefined && this._cls_info.gdsVOJson.optnTtl.length > 0){
					this._cls_info.arrOptnTtl = this._cls_info.gdsVOJson.optnTtl.split('|');
				}
				if (this._cls_info.gdsVOJson.optnVal != undefined && this._cls_info.gdsVOJson.optnVal.length > 0){
					this._cls_info.arrOptnVal = this._cls_info.gdsVOJson.optnVal.split('|');
				}
			}
			
		}

		
        
        this._cls_info.pagePrefix = 'main#container .layout.page-content' ;
        this._cls_info.pagePopPrefix = 'main#container div.modal2-con';
        
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
        var owner = this;
        $( window ).resize( function() {
            owner.fn_page_resized();
        });
    }

    fn_init_sub_addevent(){
        var owner = this;

        $(".option-toggle").on("click", function(){
			if(!owner._cls_info.loginCheck){
				if(confirm("회원만 사용가능합니다. 로그인하시겠습니까?")){
					location.href= owner._cls_info._membershipPath + '/login?returnUrl=' + window.location.pathname;
				}
			}else{
                $('.product-option').not($(this).closest('.product-option')).removeClass('is-active');
				$(this).closest('.product-option').toggleClass('is-active');
				
			}
		});
        
        $('.product-option button').click(function() {
            owner.fn_product_option_click($(this));
        });

        $(document).on("click", ".btn-plus", function(e){
            owner.fn_product_option_btn_plus_click($(this));
		});

		$(document).on("click", ".btn-minus", function(e){
			owner.fn_product_option_btn_minus_click($(this));
		});

		$(document).on("click", ".btn-delete", function(e){
			owner.fn_product_option_btn_delete_click($(this));
		});

    }

    fn_product_option_click(jobjTarget){
        var prevDisplay = jobjTarget.parent().children('.option-items').css('display');
        $(' .product-option .option-items').hide();
    
        if (prevDisplay === 'none') {
            jobjTarget.parent().children('.option-items').show();
        }
    }

    fn_product_option_btn_plus_click(jobjTarget){
        var pObj = jobjTarget.parents(".product-quanitem");
        var qyObj = pObj.find("input[name='ordrQy']");
        var stockQy = qyObj.data("stockQy");
		var ordrOptnTy = pObj.find("input[name='ordrOptnTy']").val();
		var gdsPc  = Number(pObj.find("input[name='gdsPc']").val()) + Number(pObj.find("input[name='ordrOptnPc']").val());

        // 주문수량
        if(Number(qyObj.val()) < stockQy){
            qyObj.val(Number(qyObj.val()) + 1);
            if("${_mbrSession.recipterYn}" == "Y" && Number(qyObj.val()) > 15 && $("#ordrTy1").is(":checked")){
                alert("급여 상품의 최대수량은 15개 입니다.");
                qyObj.val(Number(qyObj.val()) - 1);
            }
            pObj.find(".quantity strong").text(qyObj.val());
			pObj.find(".price strong").text((qyObj.val() * gdsPc).format_money());
        } else {
            alert("현재 상품의 재고수량은 총 ["+ stockQy +"] 입니다.");
            alert("해당 제품은 총 "+ stockQy +" 개 까지 구매 가능합니다.");
        }

        this.f_totalPrice();
    }
    fn_product_option_btn_minus_click(jobjTarget){
        var pObj = jobjTarget.parents(".product-quanitem");
        var qyObj = pObj.find("input[name='ordrQy']");
        var stockQy = qyObj.data("stockQy");
		var ordrOptnTy = pObj.find("input[name='ordrOptnTy']").val();
		var gdsPc  = Number(pObj.find("input[name='gdsPc']").val()) + Number(pObj.find("input[name='ordrOptnPc']").val());

        // 주문수량
        if(Number(qyObj.val()) > 1){
            qyObj.val(Number(qyObj.val()) - 1);
            pObj.find(".quantity strong").text(qyObj.val());
			pObj.find(".price strong").text((qyObj.val() * gdsPc).format_money());
        } else {
            // nothing
        }
        this.f_totalPrice();
    }
    fn_product_option_btn_delete_click(jobjTarget){
        var pObj = jobjTarget.parents(".product-quanitem");
        pObj.remove();
        this.f_totalPrice();
    }
		
    f_totalPrice(){
		var totalPrice = 0;
		var totalQy = 0;
		var gdsPc = 0;
		var gdsOptnPc = 0;
		var ordrQy = 1;
		$(".product-quanitem").each(function(){
			gdsPc = $(this).find("input[name='gdsPc']").val();
			gdsOptnPc = $(this).find("input[name='ordrOptnPc']").val();
			ordrQy = $(this).find("input[name='ordrQy']").val();

			totalQy += Number(ordrQy);
			totalPrice = Number(totalPrice) + (Number(gdsPc) + Number(gdsOptnPc)) * Number(ordrQy);
		});
		//console.log("###### totalPrice", comma(totalPrice));
		$("#totalQy").text(comma(totalQy));
		$("#totalPrice").text(comma(totalPrice));
	}
    
    f_optnVal1(optnVal, optnTy){
		$('.product-option').removeClass('is-active');
		$("#optnVal1 ul.option-items li").remove();

		$.ajax({
			type : "post",
			url  : this._cls_info._marketPath + "/gds/optn/getOptnInfo.json",
			data : {
				gdsNo:this._cls_info.gdsVOJson.gdsNo
				, optnTy:optnTy
				, optnVal:optnVal
			},
			dataType : 'json'
		})
		.done(function(json) {
			if(json.result){
				$("#optnVal1 button").prop("disabled", false);
				var oldOptnNm = "";
				$.each(json.optnList, function(index, data){
					var optnNm = data.optnNm.split("*");
					if(oldOptnNm != optnNm[0]){
						if(optnNm.length < 2){
							var optnPc = "";
							var optnSoldout = "";
							if(data.optnPc > 0){ optnPc = " + " + data.optnPc +"원"; }
							if(data.optnStockQy < 1){ optnSoldout = " [품절]"; }
							if(data.soldOutYn === 'Y') { optnSoldout = " [일시품절]"; }
							$("#optnVal1 ul.option-items").append("<li><a href='#' data-optn-ty='BASE' data-opt-val='"+ data.optnNm +"|"+ data.optnPc +"|"+ data.optnStockQy +"|BASE|"+ data.gdsOptnNo+ "|" + data.soldOutYn +"'>"+ optnNm[0] + optnPc + optnSoldout +"</a></li>");
						}else{
							$("#optnVal1 ul.option-items").append("<li><a href='#' data-optn-ty='BASE' data-opt-val='"+ data.optnNm +"'>"+ optnNm[0] +"</li>");
						}
						oldOptnNm = optnNm[0];
					}
				});
			}else{
				$("#optnVal1 button").prop("disabled", true);
			}

		})
		.fail(function(data, status, err) {
			console.log('error forward : ' + data);
		});
	}

    
	f_optnVal2(optnVal1, optnTy){ // 추후 사용자에서도 사용할 예정
		$('.product-option').removeClass('is-active');
		$("#optnVal2 ul.option-items li").remove();
		$("#optnVal3 ul.option-items li").remove();
		if(optnVal1!=""){
			$.ajax({
				type : "post",
				url  : this._cls_info._marketPath + "/gds/optn/getOptnInfo.json",
				data : {
					gdsNo:this._cls_info.gdsVOJson.gdsNo
					, optnTy:optnTy
					, optnVal:optnVal1
				},
				dataType : 'json'
			})
			.done(function(json) {
				if(json.result){
					$("#optnVal2 button").prop("disabled", false);
					var oldOptnNm = "";
					$.each(json.optnList, function(index, data){
						var optnNm = data.optnNm.split("*");
						if(oldOptnNm != optnNm[1]){
	    					if(optnNm.length < 3){
	    						var optnPc = "";
	    						var optnSoldout = "";
	    						if(data.optnPc > 0){ optnPc = " + " + comma(data.optnPc) +"원"; }
	    						if(data.optnStockQy < 1){ optnSoldout = " [품절]"; }
	    						if(data.soldOutYn === 'Y') { optnSoldout = " [일시품절]"; }
	    						$("#optnVal2 ul.option-items").append("<li><a href='#' data-optn-ty='BASE' data-opt-val='"+ data.optnNm +"|"+ data.optnPc +"|"+ data.optnStockQy +"|BASE|"+ data.gdsOptnNo + "|" + data.soldOutYn +"'>"+ optnNm[1] + optnPc + optnSoldout +"</a></li>");
	    					}else{
	    						$("#optnVal2 ul.option-items").append("<li><a href='#' data-optn-ty='BASE' data-opt-val='"+ data.optnNm +"'>"+ optnNm[1] +"</li>");
	    					}
	    					oldOptnNm = optnNm[1];
						}
	                });
					$('.product-option .option-toggle')[1].click();
				}else{
					$("#optnVal2").prop("disabled", true);
				}

			})
			.fail(function(data, status, err) {
				console.log('error forward : ' + data);
			});
		}else{
			$("#optnVal2").prop("disabled", true);

			// 3번 옵션도
			$("#optnVal3").prop("disabled", true);
		}
	}


	f_optnVal3(optnVal2, optnTy){ // 추후 사용자에서도 사용할 예정
		$('.product-option').removeClass('is-active');
		$("#optnVal3 ul.option-items li").remove();
		if(optnVal2!=""){
			$.ajax({
				type : "post",
				url  : this._cls_info._marketPath + "/gds/optn/getOptnInfo.json",
				data : {
					gdsNo:this._cls_info.gdsVOJson.gdsNo
					, optnTy:optnTy
					, optnVal:optnVal2
				},
				dataType : 'json'
			})
			.done(function(json) {
				if(json.result){
					$("#optnVal3 button").prop("disabled", false);
					var oldOptnNm = "";
					$.each(json.optnList, function(index, data){
						var optnNm = data.optnNm.split("*");
						var optnPc = "";
						var optnSoldout = "";
						if(data.optnPc > 0){ optnPc = " + " + data.optnPc +"원"; }
						if(data.optnStockQy < 1){ optnSoldout = " [품절]"; }
						if(data.soldOutYn === 'Y') { optnSoldout = " [일시품절]"; }
						$("#optnVal3 ul.option-items").append("<li><a href='#' data-optn-ty='BASE' data-opt-val='"+ data.optnNm +"|"+ data.optnPc +"|"+ data.optnStockQy +"|BASE|"+ data.gdsOptnNo + "|" + data.soldOutYn +"'>"+ optnNm[2] + optnPc + optnSoldout +"</a></li>");
	                });
					//$('.product-option .option-toggle')[1].click();
					$('.product-option .option-toggle')[2].click();
				}else{
					$("#optnVal3").prop("disabled", true);
				}

			})
			.fail(function(data, status, err) {
				console.log('error forward : ' + data);
			});
		}else{
			$("#optnVal2").prop("disabled", true);
		}
	}



	f_baseOptnChg(optnVal){
		var spOptnVal = optnVal.split("|");
		var spOptnTxt = spOptnVal[0].split("*");
		var skip = false;
		var gdsLastPc = this._cls_info.gdsVOJson.pc;

		if (this._cls_info.gdsVOJson.dscntPc > 0) {
			gdsLastPc = this._cls_info.gdsVOJson.dscntPc;
		}

		console.log("gdsPc", gdsLastPc);
		console.log("optnVal", optnVal); // R * 10 * DEF|1000|0|BASE

		$(".product-quanitem input[name='ordrOptn']").each(function(){
			if($(this).val() == spOptnVal[0].trim()){
				alert("["+spOptnVal[0] + "]은(는) 이미 추가된 옵션상품입니다.");
				skip = true;
			}

		});
		//console.log("재고:", spOptnVal[2]);
		if(spOptnVal[2] < 1){
			alert("선택하신 옵션은 품절상태입니다.");
			skip = true;
		}
		if(spOptnVal.length > 5 && spOptnVal[5] === 'Y') {
			alert("선택하신 옵션은 일시품절상태입니다.");
			skip = true;
		}

		if(!skip){
			var html = '';
				html += '<div class="product-quanitem">';
				html += '	<input type="hidden" name="gdsNo" value="{0}">'.format(this._cls_info.gdsVOJson.gdsNo);
				html += '	<input type="hidden" name="gdsCd" value="{0}">'.format(this._cls_info.gdsVOJson.gdsCd);
				html += '	<input type="hidden" name="bnefCd" value="{0}">'.format(this._cls_info.gdsVOJson.bnefCd);
				html += '	<input type="hidden" name="gdsNm" value="{0}">'.format(this._cls_info.gdsVOJson.gdsNm);
				if(typeof spOptnVal[4] != 'undefined'){
					html += '	<input type="hidden" name="gdsOptnNo" value="'+ spOptnVal[4] +'">';
				}else{
					html += '	<input type="hidden" name="gdsOptnNo" value="0">';
				}

				html += '	<input type="hidden" name="gdsPc" value="'+ gdsLastPc +'">';
				html += '	<input type="hidden" name="ordrOptnTy" value="'+ spOptnVal[3] +'">';
				html += '	<input type="hidden" name="ordrOptn" value="'+ spOptnVal[0] +'">';
				html += '	<input type="hidden" name="ordrOptnPc" value="'+ spOptnVal[1] +'">';
				html += '	<input type="hidden" name="ordrQy" value="1" data-stock-qy="'+ spOptnVal[2] +'">';

				html += '<dl class="infomation">';
				html += '<dt>{0}</dt>'.format(this._cls_info.gdsVOJson.gdsNm);
				html += '<dd>';
				html += '	<div class="option">';
				html += '		<div>';
				for(var i=0; i<spOptnTxt.length;i++){
					if(i == spOptnTxt.length-1 ){
						html += '       	<span>'+ spOptnTxt[i].trim() +'</span>';
					}else{
						html += '       	<span class="title">'+ spOptnTxt[i].trim() +'</span>';
					}
				}
				html += '   	</div>';
				html += '	</div>';
				html += '	<div class="quantity">';
				html += '    	<button type="button" class="btn btn-minus">수량삭제</button>';
				html += '   	<strong>1</strong>';
				html += '   	<button type="button" class="btn btn-plus">수량추가</button>';
				html += '    	<button type="button" class="btn btn-delete">상품삭제</button>';
				html += '	</div>';
				html += '	<p class="price"><strong> '+ comma(Number(gdsLastPc) + Number(spOptnVal[1])) +'</strong> 원</p>';
				html += '</dd>';
				html += '</dl>';
				html += '</div>';
			$(".payment-option").append(html);
		}

		$('.product-option').removeClass('is-active');

		this.f_totalPrice();
	}

	//추가옵션
	f_aditOptnChg(optnVal){
		var spOptnVal = optnVal.split("|");
		var spOptnTxt = spOptnVal[0].split("*"); // AA * BB
		var skip = false;

		$(".product-quanitem input[name='ordrOptn']").each(function(){
			if($(this).val() == spOptnVal[0].trim()){
				alert("["+spOptnVal[0] + "]은(는) 이미 추가된 옵션상품입니다.");
				skip = true;
			}
		});
		if(spOptnVal[2] < 1){
			alert("선택하신 옵션은 품절상태입니다.");
			skip = true;
		}

		if(!skip){
			var html = '';
				html += '<div class="product-quanitem">';
				html += '	<input type="hidden" name="gdsNo" value="{0}">'.format(this._cls_info.gdsVOJson.gdsNo);
				html += '	<input type="hidden" name="gdsCd" value="{0}">'.format(this._cls_info.gdsVOJson.gdsCd);
				html += '	<input type="hidden" name="bnefCd" value="{0}">'.format(this._cls_info.gdsVOJson.bnefCd);
				html += '	<input type="hidden" name="gdsNm" value="{0}">'.format(this._cls_info.gdsVOJson.gdsNm);
				html += '	<input type="hidden" name="gdsPc" value="0">';

				if(typeof spOptnVal[4] != "undefined"){
					html += '	<input type="hidden" name="gdsOptnNo" value="'+ spOptnVal[4] +'">';
				}else{
					html += '	<input type="hidden" name="gdsOptnNo" value="0">';
				}

				html += '	<input type="hidden" name="ordrOptnTy" value="'+ spOptnVal[3] +'">';
				html += '	<input type="hidden" name="ordrOptn" value="'+ spOptnVal[0] +'">';
				html += '	<input type="hidden" name="ordrOptnPc" value="'+ spOptnVal[1] +'">';
				html += '	<input type="hidden" name="ordrQy" value="1" data-stock-qy="'+ spOptnVal[2] +'">';

				html += '<dl class="infomation">';
				html += '<dt><span class="label-outline-primary"><span>'+ spOptnTxt[0] +'</span><i><img src="/html/page/market/assets/images/ico-plus-white.svg" alt=""></i></span></dt>';
				html += '<dd>';
				html += '	<div class="option">';
				html += '		<div>';
				html += '       	<span>'+ spOptnTxt[1].trim() +'</span>';
				html += '   	</div>';
				html += '	</div>';
				html += '	<div class="quantity">';
				html += '    	<button type="button" class="btn btn-minus">수량삭제</button>';
				html += '   	<strong>1</strong>';
				html += '   	<button type="button" class="btn btn-plus">수량추가</button>';
				html += '    	<button type="button" class="btn btn-delete">상품삭제</button>';
				html += '	</div>';
				html += '	<p class="price"><strong> '+ comma(Number(spOptnVal[1])) +'</strong> 원</p>';
				html += '</dd>';
				html += '</dl>';
				html += '</div>';
			$(".payment-option").append(html);
		}

		$('.product-option').removeClass('is-active');

		this.f_totalPrice();
	}

	f_ordr_able_check(){
		let skip = true;
		if(this._cls_info.gdsVOJson.gdsTagVal != null && this._cls_info.gdsVOJson.gdsTagVal != ''){
			var tagVal = this._cls_info.gdsVOJson.gdsTagVal;
			tagVal = tagVal.replaceAll(' ','').split(',');
			if(tagVal.indexOf("A") > -1){
				alert("선택하신 옵션은 품절상태입니다.");
				skip = false;
			}else if(tagVal.indexOf("B") > -1){
				//alert("선택하신 옵션은 일부옵션품절상태입니다.");
				//console.log(skip);
				//skip = false;
			}else if(tagVal.indexOf("C") > -1){
				alert("선택하신 옵션은 일시품절상태입니다.");
				skip = false;
			}
		}

		return skip;
	}

	f_buyClick(){
		this.f_buy_cart_call(true);
	}

	f_cart_click(){
		this.f_buy_cart_call(false);
	}

	f_buy_cart_call(bBuy){
		
		if (!this.f_ordr_able_check()){
			return;
		}

		$("#frmOrdr input[name='viewYn']").val(bBuy ? "N":"Y");

		var ordrTy = $("input[name='ordrTy']:checked").val() === undefined?"N":$("input[name='ordrTy']:checked").val(); //R / L / N

		if((ordrTy == "R" || ordrTy == "L") && $("#bplcUniqueId").val() == "" ){
			alert("급여상품 구입은 멤버스(사업소)를 선택해야 합니다.");
			return false;
		}else if($(".product-quanitem").length < 1){
			alert("필수 옵션을 선택하세요");
			$('.payment-type-content1 .payment-scroller').addClass('is-active');
			return false;
		}else{
			if (bBuy){
				if (this._cls_info.arrOptnTtl != undefined && this._cls_info.arrOptnTtl.length > 0){
					if (this._cls_info.gdsVOJson.stockQy < 1){
						alert("선택하신 상품은 품절입니다.");
						return false;
					}
				}
			}
			var formData = $("#frmOrdr").serialize();
			if (bBuy){
				jsCallApi.call_api_post_json(this, this._cls_info._marketPath + "/mypage/cart/putCart.json", 'f_buy_cb', formData, {ordrTy});
			}else{
				jsCallApi.call_api_post_json(this, this._cls_info._marketPath + "/mypage/cart/putCart.json", 'f_cart_cb', formData);
			}
			
		}
	}

	f_buy_cb(result, fail, data, param){
		if (result != undefined && result.resultMsg == "SUCCESS"){
			var data = {cartTy : param.ordrTy, cartGrpNos : result.cartGrpNo};
			jsCallApi.call_svr_post_move(this._cls_info._marketPath + "/ordr/cartPay", data, null);
		}else{
			alert("주문으로 이동하는 중 오류가 발생하였습니다.\n새로고침 후 다시 시도해 주십시오.")
		}
	}
	f_cart_cb(result, fail, data, param){
		if (result != undefined){
			if(result.resultMsg == "ALREADY"){
				alert("장바구니에 담겨있는 상품입니다.");
			}else{
				$('.navigation-util .util-item3 i').text(Number($('.navigation-util .util-item3 i').text()) + 1);
				if (confirm("장바구니에 상품을 담았습니다.\n장바구니로 이동하시겠습니까?")){
					window.location.href = this._cls_info._marketPath + "/mypage/cart/list";
				}
			}
		} else if (fail != undefined){
			alert("장바구니 담기에 실패하였습니다.\n잠시후 다시 시도해 주시기 바랍니다.")
		}
	}
}