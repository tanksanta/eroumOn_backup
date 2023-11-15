class JsCallApi{
    constructor() {
        this._cls_info = {jsWaiting:(new JsWaiting()), call_cnt:0};
        
    }
    call_api_get = function (owner, uri, callback, data, param){
        var _self = this;

        _self._cls_info.call_cnt += 1;
        _self._cls_info.jsWaiting.fn_show_popup();

        $.ajax({
            url: uri,
            data: data,
            method: "GET",
            param: param,
            callback:callback,
        }).done(function(result){
            _self.fn_callbacked();
            if (owner != null && owner != undefined && owner[callback] != null && owner[callback] != undefined){
                owner[callback](result, null, data, param);
            }
        }).fail(function(result, status, err) {
            _self.fn_callbacked();
            if (owner != null && owner != undefined && owner[callback] != null && owner[callback] != undefined){
                owner[callback](null, result, data, param);
            }
            // alert("배송지 삭제 중 오류가 발생했습니다. \n 관리자에게 문의 바랍니다.");
            // console.log('error forward : ' + data);
        });
    };

    
    call_api_post_json = function (owner, uri, callback, data, param){
        var _self = this;

        _self._cls_info.call_cnt += 1;
        _self._cls_info.jsWaiting.fn_show_popup();

        $.ajax({
            url: uri,
            data: data,
            method: "POST",
            param: param,
            dataType : 'json',
            callback:callback,
        }).done(function(result){
            _self.fn_callbacked();
            if (owner != null && owner != undefined && owner[callback] != null && owner[callback] != undefined){
                owner[callback](result, null, data, param);
            }
        }).fail(function(result, status, err) {
            _self.fn_callbacked();
            if (owner != null && owner != undefined && owner[callback] != null && owner[callback] != undefined){
                owner[callback](null, result, data, param);
            }
            // console.log('error forward : ' + data);
        });
    };

    call_sync_api_post = function (uri, data){
        var _self = this;

        _self._cls_info.call_cnt += 1;
        _self._cls_info.jsWaiting.fn_show_popup();

        $.ajax({
            async: false,
            url: uri,
            data: data,
            method: "POST",
        }).done(function(result){
            _self.fn_callbacked();

            return {"result":result};
        }).fail(function(result, status, err) {
            _self.fn_callbacked();

            return {"fail":result};
            // console.log('error forward : ' + data);
        });
    };

    call_svr_post_move = function (uri, data, searched_data){
        let f = document.createElement('form');
    
        let obj;

        if (data != undefined){
            for (var key in data){
                obj = document.createElement('input');
                obj.setAttribute('type', 'hidden');
                obj.setAttribute('name', key);
                obj.setAttribute('value', data[key]);
                
                f.appendChild(obj);
            } 
        }
        if (searched_data != undefined){
            obj = document.createElement('input');
            obj.setAttribute('type', 'hidden');
            obj.setAttribute('name', "searched_data");
            obj.setAttribute('value', JSON.stringify(searched_data));

            f.appendChild(obj);
        }

        f.setAttribute('method', 'post');
        f.setAttribute('action', uri);
        
        document.body.appendChild(f);

        f.submit();
    };

    json2param(param){
        
        if (param == undefined) return '';

        var arr = [];
        for(var key in param){
            arr.push(key + "=" + param[key]);
        }

        return arr.join('&')
    }

    fn_callbacked(){
        this._cls_info.call_cnt -= 1;
        if (this._cls_info.call_cnt <= 0){
            this._cls_info.jsWaiting.fn_close_popup();
        }
    }
}

class JsWaiting{/*생성 하지 마시오~ JsCallApi에서 들고가기...*/
    constructor(){
        this._cls_info = this._cls_info || {joContent:null, joParent:null};

        this._cls_info.pagePrefixParent = 'body';
        
    }
    fn_show_popup(step){
        if (this._cls_info.joContent == undefined){
            this.createProgressLoading();

            
        }

        this._cls_info.joParent.addClass('overlay-wait1');

        this._cls_info.joContent.removeClass('off');

        this.fn_show_overlay();

    }
    
    fn_show_overlay(){
        this._cls_info.joParent.addClass('overlay-wait1');
    }
    fn_close_popup(){
        this._cls_info.joContent.addClass('off');
        this._cls_info.joParent.removeClass('overlay-wait1');
    }
    
    //로딩바 생성
	createProgressLoading() {
        if (this._cls_info.joParent == undefined || this._cls_info.joParent.length < 1){
            this._cls_info.joParent = $(this._cls_info.pagePrefixParent);
        }

		
		
        if (this._cls_info.joParent != undefined && this._cls_info.joParent.length > 0){
            
            this._cls_info.joContent = $(this._cls_info.pagePrefixParent + " div.progress-loading");

            if (this._cls_info.joContent == undefined || this._cls_info.joContent.length < 1){
                var template = `<div class="progress-loading lazy is-dark">
                    <div class="icon">
                        <span></span><span></span><span></span>
                    </div>
                    <p class="text">데이터를 불러오는 중입니다.</p>
                </div>`;

                this._cls_info.joParent.append(template);
                this._cls_info.joContent = $(this._cls_info.pagePrefixParent + " div.progress-loading");
            }
            
        }
		
	}

}


var jsCallApi;
jsCallApi = new JsCallApi();