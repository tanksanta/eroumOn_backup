class JsCallApi{
    constructor(waiting, alert, confirm) {
    }
    call_api_get = function (owner, uri, callback, data, param){
    
        $.ajax({
            url: uri,
            data: data,
            method: "GET",
            param: param,
            callback:callback,
        }).done(function(result){
            if (owner != null && owner != undefined && owner[callback] != null && owner[callback] != undefined){
                owner[callback](data, param, result);
            }
        });
    };

    
    call_svr_post_json = function (owner, uri, callback, data, param){
        
        $.ajax({
            url: uri,
            data: data,
            method: "POST",
            param: param,
            dataType : 'json',
            callback:callback,
        }).done(function(result){
            if (owner != null && owner != undefined && owner[callback] != null && owner[callback] != undefined){
                owner[callback](data, param, result);
            }
        }).fail(function(data, status, err) {
            // alert("배송지 삭제 중 오류가 발생했습니다. \n 관리자에게 문의 바랍니다.");
            console.log('error forward : ' + data);
        });;
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
}

var jsCallApi = new JsCallApi();