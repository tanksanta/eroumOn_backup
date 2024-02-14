/*
    필요 스크립트
    <script src="/html/core/vendor/rsa/RSA.min.js" /></script>
	<script src="/html/core/script/JsCallApi.js" /></script>
    <script src="/html/core/script/JsHouseLoginRSA.js" /></script>
    

    ex)
        var jsHouseLogin
        $(document).ready(function() {
            jsHouseLogin = new JsHouseLoginRSA("");
        });

        var owner = this;
        $(".btn.join").off('click').on('click', function(){
            owner.fn_login_call("dylee96", "123456")
        });
*/
class JsHouseLoginRSA {
    constructor(domain){
        if (domain==undefined || domain.length < 1){
            domain = "https://eroum.co.kr";
        }

        if (domain.substr(domain.length -1, 1) != "/"){
            domain += "/";
        }
        var urlLoginPublic = "membership/oauth/loginpublic.json";
        var urlLoginAction = "membership/oauth/loginaction.json";
        this._cls_info = {domain, urlLoginPublic, urlLoginAction, publicKeyModulus:null, publicKeyExponent:null, retryYn:false};
        this._cls_info.jsCallApi = new JsCallApi();

        this.fn_publicKey_call(null, null);

        var owner = this;
        $(".btn.join").off('click').on('click', function(){
            owner.fn_login_call("dylee96", "123456")
        });
    }

    f_rsa_enc(v) {
        var rsaPublicKeyModulus;
		var rsaPublicKeyExponent;
        // rsaPublicKeyExponent = document.getElementById("rsaPublicKeyExponent").value;
        // rsaPublicKeyModulus = document.getElementById("rsaPublicKeyModulus").value;
        rsaPublicKeyExponent = this._cls_info.publicKeyExponent;
        rsaPublicKeyModulus = this._cls_info.publicKeyModulus;
        let rsa = new RSAKey();
        rsa.setPublic(rsaPublicKeyModulus, rsaPublicKeyExponent);
        return rsa.encrypt(v);
    }

    fn_publicKey_call(data, param){
        this._cls_info.jsCallApi.call_api_get(this, this._cls_info.domain + this._cls_info.urlLoginPublic, 'fn_publicKey_cb', data, param);
    }

    fn_publicKey_cb(result, fail, data, param){
        if (result != null && result.publicKeyModulus != null && result.publicKeyModulus.length > 0){
            this._cls_info.publicKeyModulus = result.publicKeyModulus;
            this._cls_info.publicKeyExponent = result.publicKeyExponent;

            if (data != undefined){
                this.fn_login_inner();
            }
        }else{
            console.log("do not received rsa public key")
        }
    }

    async fn_login_call(id, pw){
        

        this._cls_info.id = id;
        this._cls_info.pw = pw;
        
        this.fn_login_inner();
    }

    fn_login_inner(){

        var data = {};

        data.mbrId = this._cls_info.id;
        data.encPw = this.f_rsa_enc(this._cls_info.pw);

        this._cls_info.jsCallApi.call_api_post_json(this, this._cls_info.domain + this._cls_info.urlLoginAction, 'fn_login_cb', data, null);
    }

    fn_login_cb(result, fail, data, param){
        var loginResult = true;
        if (fail!=undefined && fail.status == 403){
            if (!this._cls_info.retryYn){
                this._cls_info.retryYn = true;

                loginResult = false;
                this.fn_publicKey_call({retryYn:true}, {retryYn:true});
            }
        }

        if (loginResult){
            delete this._cls_info.id;
            delete this._cls_info.pw;
        }
    }
}