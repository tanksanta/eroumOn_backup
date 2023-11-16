
class JsCommon{
    fn_keycontrol(){
        var owner = this;

        $(".keycontrol.numberonly").off('keyup').on('keyup', function(){
            this.value=this.value.replace(/[^-0-9]/g,'');
        });
        $(".keycontrol.numbercomma").off('keyup').on('keyup', function(){
            this.value=this.value.replace(/[^-0-9]/g,'');
            this.value=jsFuncs.numberWithCommas(this.value)
        });

        $(".keycontrol.phonenumber").off("keyup").on("keyup", function(event){
            owner.fn_keycontrol_PhoneNumber(event);
        });
        
    }
    /**
     * 휴대폰 번호 입력 마스크 처리
     * $(owner._cls_info.pageModalfix + " .mem_confirm .phone_no").on("keyup", function(event){
            owner.fn_keycontrol_PhoneNumber(event);
        });
     */

    fn_keycontrol_PhoneNumber(event) {
        var phone = event.target;
        
        if( event.keyCode != 8 ) {
            const regExp = new RegExp( /^[0-9]{2,3}-^[0-9]{3,4}-^[0-9]{4}/g );
            if( phone.value.replace( regExp, "").length != 0 ) {                
                if( this.checkPhoneNumber( phone.value ) == true ) {
                    let number = phone.value.replace( /[^0-9]/g, "" );
                    let tel = "";
                    let seoul = 0;
                    if( number.substring( 0, 2 ).indexOf( "02" ) == 0 ) {
                        seoul = 1;
                        phone.setAttribute("maxlength", "12");
                        console.log( phone );
                    } else {
                        phone.setAttribute("maxlength", "13");
                    }
                    if( number.length < ( 4 - seoul) ) {
                        return number;
                    } else if( number.length < ( 7 - seoul ) ) {
                        tel += number.substr( 0, (3 - seoul ) );
                        tel += "-";
                        tel += number.substr( 3 - seoul );
                    } else if(number.length < ( 11 - seoul ) ) {
                        tel += number.substr( 0, ( 3 - seoul ) );
                        tel += "-";
                        tel += number.substr( ( 3 - seoul ), 3 );
                        tel += "-";
                        tel += number.substr( 6 - seoul );
                    } else {
                        tel += number.substr( 0, ( 3 - seoul ) );
                        tel += "-";
                        tel += number.substr( ( 3 - seoul), 4 );
                        tel += "-";
                        tel += number.substr( 7 - seoul );
                    }
                    phone.value = tel;
                } else {
                    const regExp = new RegExp( /[^0-9|^-]*$/ );
                    phone.value = phone.value.replace(regExp, "");
                }
            }
        }
    }

    checkPhoneNumber( number ) {
        const regExp = new RegExp( /^[0-9|-]*$/ );
        if( regExp.test( number ) == true ) { return true; }
        else { return false; }
    }

    /*
        kind : d:일, m:월, y:년
        cnt : 숫자
    */
    fn_srchBtwnYmdSet(kind, cnt, srchWrtYmdBgng, srchWrtYmdEnd){
        if (!(kind == 'd' || kind == 'm' || kind == 'y')){
            return;
        }
        if (srchWrtYmdBgng == undefined || srchWrtYmdBgng == ''){
            srchWrtYmdBgng = '#srchWrtYmdBgng';
        }

        if (srchWrtYmdEnd == undefined || srchWrtYmdEnd == ''){
            srchWrtYmdEnd = '#srchWrtYmdEnd';
        }

        if (isNaN(cnt)){
            return;
        }else{
            if (typeof cnt == 'string'){
                cnt = parseInt(cnt);
            }
            
        }

        var date = new Date();

        $(srchWrtYmdEnd).val(date.format('yyyy-MM-dd'));

        if (kind == 'y'){
            date = date.addYears(cnt);
        } else if (kind == 'm'){
            date = date.addMonths(cnt);
        } else if (kind == 'd'){
            date = date.addDays(cnt);
        }
        
        $(srchWrtYmdBgng).val(date.format('yyyy-MM-dd'));
        
    }
    
    escapeHtml (string) {
        var entityMap = {
            '&': '&amp;',
            '<': '&lt;',
            '>': '&gt;',
            '"': '&quot;',
            "'": '&#39;',
            '/': '&#x2F;',
            '`': '&#x60;',
            '=': '&#x3D;'
          };

        return String(string).replace(/[&<>"'`=\/]/g, function (s) {
            return entityMap[s];
        });
    }
    
    unescapeHtml(str) {
        const regex = /&(amp|lt|gt|quot|#39);/g;
        const chars = {
            '&amp;': '&',
            '&lt;': '<',
            '&gt;': '>',
            '&quot;': '"',
            '&#39;': "'"
        }  
        if(regex.test(str)) {
            return str.replace(regex, (matched) => chars[matched] || matched);
        }
    }
}