class JsMarketCartModalOptnChg2 extends JsHouse2309PopupBase{

    constructor(){
        super(null,  ".modal.cartOptnModal", "cartOptnModal", 1, {})
    }

    fn_loaded(path, cartListJson){
        this._cls_info.path = this;
        this._cls_info._membershipPath = path._membershipPath;
        this._cls_info._marketPath = path._marketPath;

        console.log(cartListJson)
		if (cartListJson.trim().length > 0){
			this._cls_info.cartListJson = JSON.parse(cartListJson.trim());

            this._cls_info.cartTy = this._cls_info.cartListJson[0].cartTy;

            if(this._cls_info.cartTy == "L"){
                this._cls_info.gdsPc = this._cls_info.cartListJson[0].gdsInfo.lendPc;
            }else if(this._cls_info.cartTy == "R"){
                switch(this._cls_info.cartListJson[0].recipterInfo.selfBndRt){
                    case 15:
                        this._cls_info.gdsPc = this._cls_info.cartListJson[0].gdsInfo.bnefPc15;
                        break;
                    case 9:
                        this._cls_info.gdsPc = this._cls_info.cartListJson[0].gdsInfo.bnefPc9;
                        break;
                    case 6:
                        this._cls_info.gdsPc = this._cls_info.cartListJson[0].gdsInfo.bnefPc6;
                        break;
                    case 0:
                        this._cls_info.gdsPc = 0;
                        break;
                }
            }else{
                this._cls_info.gdsPc = this._cls_info.cartListJson[0].gdsInfo.pc;
            }
            this._cls_info.bnefCd = this._cls_info.cartListJson[0].gdsInfo.bnefCd;
            
		}


        this.fn_init_event();
    }

    fn_init_event_del(){
        var owner = this;
        $(owner._cls_info.pageModalfix + " .btn.cart.del").on("click", function(){
            owner.f_cart_del($(this));
        });
    }
    fn_init_event(){
        var owner = this;
        

        $(".option-toggle").on("click", function(){
            $(this).closest('.product-option').toggleClass('is-active');
            $('.product-option').not($(this).closest('.product-option')).removeClass('is-active');
        });
            
        $(".f_cart_optn_chg").off("click").on("click", function(){
            owner.f_cart_optn_chg_click();
        });

        this.fn_init_event_item_added();
    }

    fn_init_event_item_added(){
        var owner = this;
        $(owner._cls_info.pageModalfix + " input[name='ordrQy']").off("change").on("change",function(){
            owner.f_orderQy_change_call($(this))
        })

        this.fn_init_event_del();
    }


    
    f_cart_del(jobjTarget) {
        //console.log($(obj).data("dtlNo"));

        var ordrOptnTy = jobjTarget.closest("tr").find("input[name='ordrOptnTy']").val();

        if (ordrOptnTy == 'BASE'){
            if (jobjTarget.closest("table.cart-chg-list").find("input[value='BASE']").length == 1){
                alert("기본 옵션은 필수 사항입니다.")
                return;
            }
        }

        if (jobjTarget.data("cartNo") != "0"){
            if($("#delCartNos").val()==""){
                $("#delCartNos").val(jobjTarget.data("cartNo"));
            }else{
                $("#delCartNos").val($("#delCartNos").val()+","+jobjTarget.data("cartNo"));
            }
        }
        
        console.log($("#delCartNo").val());
        jobjTarget.parents("tr").remove();

        this.f_order_summary();
    }

        
    f_optnVal1(optnVal, optnTy){
        var owner = this;

        $('.product-option').removeClass('is-active');
        $("#optnVal1 ul.option-items li").remove();

        $.ajax({
            type : "post",
            url  : owner._cls_info._marketPath + "/gds/optn/getOptnInfo.json",
            data : {
                gdsNo: owner._cls_info.cartListJson[0].gdsInfo.gdsNo
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
                            var optnSoldoutTxt = "";
                            var optnSoldoutYn = "";

                            if(data.optnPc > 0){ optnPc = " + " + data.optnPc +"원"; }
                            if(data.soldOutYn == 'Y' || data.optnStockQy < 1){ 
                                optnSoldoutTxt = " [품절]"; 
                                optnSoldoutYn = "Y";
                            }
                            $("#optnVal1 ul.option-items").append("<li><a href='#' data-optn-ty='BASE' optnSoldoutYn='"+optnSoldoutYn+"' data-opt-val='"+ data.optnNm +"|"+ data.optnPc +"|"+ data.optnStockQy +"|BASE|"+ data.gdsOptnNo +"'>"+ optnNm[0] + optnPc + optnSoldoutTxt +"</a></li>");
                        }else{
                            $("#optnVal1 ul.option-items").append("<li><a href='#' data-optn-ty='BASE' optnSoldoutYn='"+optnSoldoutYn+"' data-opt-val='"+ data.optnNm +"'>"+ optnNm[0] +"</li>");
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
        var owner = this;
        $('.product-option').removeClass('is-active');
        $("#optnVal2 ul.option-items li").remove();
        $("#optnVal3 ul.option-items li").remove();
        if(optnVal1!=""){
            $.ajax({
                type : "post",
                url  : owner._cls_info._marketPath + "/gds/optn/getOptnInfo.json",
                data : {
                    gdsNo: owner._cls_info.cartListJson[0].gdsInfo.gdsNo
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
                                var optnSoldoutTxt = "";
                                var optnSoldoutYn = "";

                                if(data.optnPc > 0){ optnPc = " + " + data.optnPc +"원"; }
                                if(data.soldOutYn == 'Y' || data.optnStockQy < 1){ 
                                    optnSoldoutTxt = " [품절]"; 
                                    optnSoldoutYn = "Y";
                                }
                                
                                $("#optnVal2 ul.option-items").append("<li><a href='#' data-optn-ty='BASE' optnSoldoutYn='"+optnSoldoutYn+"' data-opt-val='"+ data.optnNm +"|"+ data.optnPc +"|"+ data.optnStockQy +"|BASE|"+ data.gdsOptnNo +"'>"+ optnNm[1] + optnPc + optnSoldoutTxt +"</a></li>");
                            }else{
                                $("#optnVal2 ul.option-items").append("<li><a href='#' data-optn-ty='BASE' optnSoldoutYn='"+optnSoldoutYn+"' data-opt-val='"+ data.optnNm +"'>"+ optnNm[1] +"</li>");
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
        var owner = this;

        $('.product-option').removeClass('is-active');
        $("#optnVal3 ul.option-items li").remove();
        
        if(optnVal2!=""){
            $.ajax({
                type : "post",
                url  : owner._cls_info._marketPath + "/gds/optn/getOptnInfo.json",
                data : {
                    gdsNo: owner._cls_info.cartListJson[0].gdsInfo.gdsNo
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
                        var optnSoldoutTxt = "";
                        var optnSoldoutYn = "";

                        if(data.soldOutYn == 'Y' || data.optnStockQy < 1){ 
                            optnSoldoutTxt = " [품절]"; 
                            optnSoldoutYn = "Y";
                        }
                        if(data.optnPc > 0){ optnPc = " + " + data.optnPc +"원"; }
                        if(data.optnStockQy < 1){ optnSoldout = " [품절]"; }
                        $("#optnVal3 ul.option-items").append("<li><a href='#' data-optn-ty='BASE' optnSoldoutYn='"+optnSoldoutYn+"' data-opt-val='"+ data.optnNm +"|"+ data.optnPc +"|"+ data.optnStockQy +"|BASE|"+ data.gdsOptnNo +"'>"+ optnNm[2] + optnPc + optnSoldoutTxt +"</a></li>");
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

    f_baseOptnChg(jobjTarget, optnVal){
        var spOptnVal = optnVal.split("|");
        var spOptnTxt = spOptnVal[0].split("*");
        var skip = false;

        if (jobjTarget != null && jobjTarget.attr("optnSoldoutYn") == "Y"){
            alert("품절된 상품은 추가할 수 없습니다.");
            return;
        }

        console.log("optnVal", optnVal); // R * 10 * DEF|1000|0|BASE
        if(spOptnVal[0].trim() != ""){
            $(".cart-chg-list tbody input[name='ordrOptn']").each(function(){
                if($(this).val().trim() == spOptnVal[0].trim()){
                    alert("["+spOptnVal[0] + "]은(는) 이미 추가된 옵션상품입니다.");
                    skip = true;
                }

            });
        }
        console.log("재고:", spOptnVal[2]);
        if(spOptnVal[2] < 1){
            //alert("선택하신 옵션은 품절상태입니다.");
            skip = true;
        }

        if(!skip){
            var gdsPc = this.f_order_pricecost_base();
            var recipterUniqueId = $(" .cart-chg-list tbody input[name='recipterUniqueId']").val();
            var bplcUniqueId = $(" .cart-chg-list tbody input[name='bplcUniqueId']").val();

            var optnHtml = '';
            for(var i=0; i<spOptnTxt.length;i++){
                optnHtml += '<span class="label-flat">' + spOptnTxt[i].trim() +'</span>';
            }
            
            var gdsHtml = '';
            gdsHtml += '';
            
            gdsHtml += '<tr class="tr_0 optn_BASE">'
            gdsHtml +=      '<td>'
            gdsHtml +=           '<input type="hidden" name="cartNo" value="0">'
            gdsHtml +=           '<input type="hidden" name="gdsOptnNo" value="{0}">'.format(spOptnVal[4])
            gdsHtml +=           '<input type="hidden" name="ordrOptnTy" value="BASE">'
            gdsHtml +=           '<input type="hidden" name="ordrOptn" value="{0}">'.format(spOptnVal[0])
            gdsHtml +=           '<input type="hidden" name="ordrOptnPc" value="{0}">'.format(spOptnVal[1])
            gdsHtml +=           '<input type="hidden" name="recipterUniqueId" value="{0}">'.format(recipterUniqueId)
            // gdsHtml +=           '<input type="hidden" name="bplcUniqueId" value="{0}">'.format(bplcUniqueId)
            gdsHtml +=           '<div class="baseitem">'
            gdsHtml +=                '<div class="content">'
            gdsHtml +=                    '<dl class="option">'
            gdsHtml +=                    '    <dd class="ordrOptn">'
            gdsHtml +=                              optnHtml
            gdsHtml +=                    '    </dd>'
            gdsHtml +=                    '</dl>'
            gdsHtml +=                '</div>'
            gdsHtml +=           '</div>'
            gdsHtml +=           '</td>'
            gdsHtml +=      '<td class="price !text-right">'
            gdsHtml +=       '<strong class="ordrOptnPc">{0}</strong> 원'.format((Number(gdsPc)+Number(spOptnVal[1])).format_money())
            gdsHtml +=      '</td>'
            gdsHtml +=      '<td class="count">'
            gdsHtml +=       '<p>'
            gdsHtml +=           '<input type="number" name="ordrQy" class="form-control numbercheck" value="1" min="1" max="9999">'
            gdsHtml +=       '</p>'
            gdsHtml +=       '<button type="button" class="btn cart del btn-small btn-outline-primary" data-cart-no="0">삭제</button>'
            gdsHtml +=      '</td>'
            gdsHtml += '</tr>';

            $(".cart-chg-list tbody").append(gdsHtml);

            this.fn_init_event_item_added();
            this.f_order_summary();
        }

        $('.product-option').removeClass('is-active');

    }

    //추가옵션
    f_aditOptnChg(jobjTarget, optnVal){
        if (jobjTarget != null && jobjTarget.attr("optnSoldoutYn") == "Y"){
            alert("품절된 상품은 추가할 수 없습니다.");
            return;
        }
        
        var spAditOptnVal = optnVal.split("|");
        var spAditOptnTxt = spAditOptnVal[0].split("*"); // AA * BB
        var skip = false;

        var recipterUniqueId = $(" .cart-chg-list tbody input[name='recipterUniqueId']").val();
        var bplcUniqueId = $(" .cart-chg-list tbody input[name='bplcUniqueId']").val();
        

        $(" .cart-chg-list tbody input[name='ordrOptn']").each(function(){
            if($(this).val() == spAditOptnVal[0].trim()){
                alert("["+spAditOptnVal[0] + "]은(는) 이미 추가된 옵션상품입니다.");
                skip = true;
            }
        });
        if(spAditOptnVal[2] < 1){
            alert("선택하신 옵션은 품절상태입니다.");
            skip = true;
        }

        if(!skip){
            var gdsHtml = '';
            gdsHtml += '';
            gdsHtml += '<tr class="tr_0 optn_ADIT">';
            gdsHtml += '	<td>';
            gdsHtml += '		<input type="hidden" name="cartNo" value="0">';
            gdsHtml += '		<input type="hidden" name="ordrOptnTy" value="ADIT">';
            gdsHtml += '		<input type="hidden" name="ordrOptn" value="'+spAditOptnVal[0]+'">';
            gdsHtml += '		<input type="hidden" name="ordrOptnPc" value="'+spAditOptnVal[1]+'">';
            gdsHtml += '		<input type="hidden" name="gdsOptnNo" value="'+spAditOptnVal[4]+'">';
            gdsHtml += '		<input type="hidden" name="recipterUniqueId" value="{0}">'.format(recipterUniqueId);
            gdsHtml += '		<input type="hidden" name="bplcUniqueId" value="{0}">'.format(bplcUniqueId);

            gdsHtml += '		<div class="additem">';
            gdsHtml += '			<span class="label-outline-primary">';
            gdsHtml += '			<span>'+ spAditOptnTxt[0] +'</span>';
            gdsHtml += '			<i><img src="/html/page/market/assets/images/ico-plus-white.svg" alt=""></i>';
            gdsHtml += '			</span>';
            gdsHtml += '			<div class="content">';
            gdsHtml += '				<p class="name">'+ spAditOptnTxt[1] +'</p>';
            gdsHtml += '			</div>';
            gdsHtml += '		</div>';
            gdsHtml += '	</td>';
            gdsHtml += '	<td class="price !text-right">';
            gdsHtml += '		<strong>'+ spAditOptnVal[1].format_money() +'</strong> 원';
            gdsHtml += '	</td>';

            gdsHtml += '	<td class="count">';
            gdsHtml += '		<p>';
            gdsHtml += '		<input type="number" name="ordrQy" class="form-control numbercheck" value="1" min="1" max="9999">';
            gdsHtml += '		</p>';
            gdsHtml += '		<button type="button" class="btn cart del btn-small btn-outline-primary" data-cart-no="0" data-optn-ty="ADIT">삭제</button>';
            gdsHtml += '	</td>';
            gdsHtml += '</tr>';

            $(".cart-chg-list tbody").append(gdsHtml);

            this.fn_init_event_item_added();
            this.f_order_summary();
        }

        $('.product-option').removeClass('is-active');

        //f_totalPrice();
    }

    
    f_cart_optn_chg_click(){
        var owner = this;
        var cartNos = [];
        var ordrOptnTys = [];
        var ordrOptns = [];
        var ordrOptnPcs = [];
        var ordrQys = [];
        var recipterUniqueIds = [];
        var bplcUniqueIds = [];
        var gdsOptnNo = [];
        
        $(this._cls_info.pageModalfix + " input[name='cartNo']").each(function(){	cartNos.push($(this).val());});
        $(this._cls_info.pageModalfix + " input[name='ordrOptnTy']").each(function(){ordrOptnTys.push($(this).val());});
        $(this._cls_info.pageModalfix + " input[name='ordrOptn']").each(function(){ordrOptns.push($(this).val());});
        $(this._cls_info.pageModalfix + " input[name='ordrOptnPc']").each(function(){ordrOptnPcs.push($(this).val());});
        $(this._cls_info.pageModalfix + " input[name='ordrQy']").each(function(){ordrQys.push($(this).val());});
        $(this._cls_info.pageModalfix + " input[name='recipterUniqueId']").each(function(){recipterUniqueIds.push($(this).val());});
        $(this._cls_info.pageModalfix + " input[name='bplcUniqueId']").each(function(){bplcUniqueIds.push($(this).val());});
        $(this._cls_info.pageModalfix + " input[name='gdsOptnNo']").each(function(){gdsOptnNo.push($(this).val());});

        $(this._cls_info.pageModalfix + " input[name='bnefCd']").val(owner._cls_info.bnefCd);/*bnefCd는 제품 공통이다*/
        
        var formData = $("#frmOrdrChg").serialize();

        jsCallApi.call_api_post_json(this
            , this._cls_info._marketPath + '/mypage/cart/optnChgSave.json'
            , 'f_cart_optn_chg_cb'
            , formData);

    }
    f_cart_optn_chg_cb(result, fail, data, param){
        if(result!=undefined && result.result){
            $("#cartOptnModal .btn-cancel").click();
            console.log("success");
            location.reload();
        }else{
            alert("옵션수정 중 오류가 발생하였습니다.");
        }

    }

    /*기본 옵션일 경우 기본 단가 return + 추가금액을 해야 된다.*/
    f_order_pricecost_base(){
        var jobjTable =  $("table.cart-chg-list");

        var gdsPc;
        var gdsDscntRt = jobjTable.find("input[name='gdsDscntRt']").val();
        if (!isNaN(gdsDscntRt) && Number(gdsDscntRt) > 0 ){
            gdsPc = Number(jobjTable.find("input[name='gdsDscntPc']").val().replaceAll(",", ""));
        }else{
            gdsPc = Number(jobjTable.find("input[name='gdsPc']").val().replaceAll(",", ""));
        }

        return gdsPc;
    }

    f_orderQy_change_call(jobjTarget){
        console.log(jobjTarget.val());
        if(jobjTarget.val() > 15 && $("#_cartTy").val() == 'R'){
            alert("최대 수량은 15개 입니다.");
            jobjTarget.val(15);
        }

        var jobjTr =  jobjTarget.closest("tr");

        var ordrOptnTy = jobjTr.find("input[name='ordrOptnTy']").val();

        var gdsPc = 0;
        if (ordrOptnTy == 'BASE'){
            gdsPc = this.f_order_pricecost_base() + Number(jobjTr.find("input[name='ordrOptnPc']").val());
        }else if (ordrOptnTy == 'ADIT'){
            gdsPc = Number(jobjTr.find("input[name='ordrOptnPc']").val());
        }
        
        if (gdsPc == 0){
            alert("단가를 가지오 오지 못 하였습니다.")
            location.reload();
            return;
        }

        jobjTr.find(".price strong").html((gdsPc * Number(jobjTarget.val())).format_money());

        this.f_order_summary();
        
    }

    f_order_summary(){
        var jobjList = $('.cart-chg-list tbody tr');
        var jobjTr;
        var summary = {ordrQy : 0, ordrPc : 0};

        if (jobjList.length != 0){
            var gdsPc = this.f_order_pricecost_base();
            var ordrOptnTy, ordrQy, ordrOptnPc;
            $.each(jobjList, function(index, data){
                jobjTr = $(data);
                ordrOptnTy = jobjTr.find("input[name='ordrOptnTy']").val();
                ordrQy = Number(jobjTr.find("input[name='ordrQy']").val().replaceAll(",", ""));
                ordrOptnPc = Number(jobjTr.find("input[name='ordrOptnPc']").val().replaceAll(",", ""));
                if (ordrOptnTy == "BASE"){
                    ordrOptnPc += gdsPc;
                }
                
                summary.ordrQy += ordrQy;
                summary.ordrPc += (ordrOptnPc * ordrQy);
            });
        }

        $('.pay-order-wrap .price-box .amount .txt').html(summary.ordrQy.format_money());
        $('.pay-order-wrap .price-box .total .txt').html(summary.ordrPc.format_money());
        
    }
}