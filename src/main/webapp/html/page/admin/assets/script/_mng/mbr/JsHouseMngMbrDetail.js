class JsHouseMngMbrDetail extends JsHouse2309PageBase{
    fn_page_sub(){
        var owner = this;

        
        $(this._cls_info.pagePrefix + " .btn-group a.btn.list").removeAttr("href");
        $(this._cls_info.pagePrefix + ' .btn-group a.btn.list').off('click').on('click', function () {
            var searchedData = owner._cls_info.searched_data;

            location.href = "/_mng/mbr/list?" + owner._cls_info.jsCallApi.json2param(searchedData);
        });


        $(this._cls_info.pagePrefix + " ul.tab-list.page-kind li a").removeAttr("href");
        
        $(this._cls_info.pagePrefix + ' ul.tab-list.page-kind li a').off('click').on('click', function () {
            var searchedData = owner._cls_info.searched_data;
            var uniqueId = $(this).attr("uniqueId");
            var pagekind = $(this).attr("page-kind");

            owner._cls_info.jsCallApi.call_svr_post_move("/_mng/mbr/" + uniqueId + "/" + pagekind, null, searchedData);
        });
    }

}

class JsHouseMngMbrView extends JsHouseMngMbrDetail{
    
}

class JsHouseMngMbrOrdr extends JsHouseMngMbrDetail{
    
}

class JsHouseMngMbrMlg extends JsHouseMngMbrDetail{
    
}

class JsHouseMngMbrCoupon extends JsHouseMngMbrDetail{
    
}

class JsHouseMngMbrPoint extends JsHouseMngMbrDetail{
    
}

class JsHouseMngMbrEvent extends JsHouseMngMbrDetail{
    
}

class JsHouseMngMbrReview extends JsHouseMngMbrDetail{
    
}

class JsHouseMngMbrQna extends JsHouseMngMbrDetail{
    
}

class JsHouseMngMbrQuestion extends JsHouseMngMbrDetail{
    
}

class JsHouseMngMbrFavoriteCart extends JsHouseMngMbrDetail{
    
}