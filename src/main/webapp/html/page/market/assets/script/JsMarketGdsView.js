class JsMarketGdsView{
    constructor(loginCheck, gdsVOString){
        
        this._cls_info = this._cls_info || {};

        this._cls_info.loginCheck = loginCheck;
        this._cls_info.gdsVOJson = JSON.parse(gdsVOString);

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

        $('.product-option button').click(function() {
            owner.fn_product_option_click();
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

    fn_product_option_click(){
        var prevDisplay = $(this).parent().children('.option-items').css('display');
        $(this._cls_info.pagePrefix + ' .product-option .option-items').hide();
    
        if (prevDisplay === 'none') {
            $(this).parent().children('.option-items').show();
        }
    }

    fn_product_option_btn_plus_click(jobjTarget){
        var pObj = jobjTarget.parents(".product-quanitem");
        var qyObj = pObj.find("input[name='ordrQy']");
        var stockQy = qyObj.data("stockQy");

        // 주문수량
        if(Number(qyObj.val()) < stockQy){
            qyObj.val(Number(qyObj.val()) + 1);
            if("${_mbrSession.recipterYn}" == "Y" && Number(qyObj.val()) > 15 && $("#ordrTy1").is(":checked")){
                alert("급여 상품의 최대수량은 15개 입니다.");
                qyObj.val(Number(qyObj.val()) - 1);
            }
            pObj.find(".quantity strong").text(qyObj.val());
        } else {
            alert("현재 상품의 재고수량은 총 ["+ stockQy +"] 입니다.");
            alert("해당 제품은 총 "+ stockQy +" 개 까지 구매 가능합니다.");
        }

        f_totalPrice();
    }
    fn_product_option_btn_minus_click(jobjTarget){
        var pObj = jobjTarget.parents(".product-quanitem");
        var qyObj = pObj.find("input[name='ordrQy']");
        var stockQy = qyObj.data("stockQy");

        // 주문수량
        if(Number(qyObj.val()) > 1){
            qyObj.val(Number(qyObj.val()) - 1);
            pObj.find(".quantity strong").text(qyObj.val());
        } else {
            // nothing
        }
        f_totalPrice();
    }
    fn_product_option_btn_delete_click(jobjTarget){
        var pObj = jobjTarget.parents(".product-quanitem");
        pObj.remove();
        f_totalPrice();
    }
		
    f_totalPrice(){
		var totalPrice = 0;
		var gdsPc = 0;
		var gdsOptnPc = 0;
		var ordrQy = 1;
		$(".product-quanitem").each(function(){
			gdsPc = $(this).find("input[name='gdsPc']").val();
			gdsOptnPc = $(this).find("input[name='ordrOptnPc']").val();
			ordrQy = $(this).find("input[name='ordrQy']").val();

			totalPrice = Number(totalPrice) + (Number(gdsPc) + Number(gdsOptnPc)) * Number(ordrQy);
		});
		//console.log("###### totalPrice", comma(totalPrice));
		$("#totalPrice").text(comma(totalPrice));
	}
    
}