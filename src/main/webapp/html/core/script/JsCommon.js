
class JsCommon{
    fn_keycontrol(){
        var owner = this;

        /*숫자만 입력*/
        $(".keycontrol.numberonly").off('keyup').on('keyup', function(){
            this.value=this.value.replace(/[^-0-9]/g,'');
        });

        /*숫자,만 입력*/
        $(".keycontrol.numbercomma").off('keyup').on('keyup', function(){
            this.value=jsFuncs.numberWithCommas(this.value)
        });

        /*핸드폰 번호 형식*/
        $(".keycontrol.phonenumber").off("keyup").on("keyup", function(event){
            owner.fn_keycontrol_PhoneNumber(event);
        });

        /*한글만 입력가능하게*/
        var patternHangeul = /[a-z0-9]|[ \[\]{}()<>?|`~!@#$%^&*-_+=,.;:\"'\\]/g;
        $(".keycontrol.keyname").off('keyup').on('keyup', function(){
            this.value=this.value.replace(patternHangeul,'')
        });
        $(".keycontrol.hangeulonly").off('keyup').on('keyup', function(){
            this.value=this.value.replace(patternHangeul,'')
        });
        
        /*생년월일 형식*/
        $(".keycontrol.birthdt10").off("keyup").on("keyup", function(event){
            this.value= owner.fn_keycontrol_BirthDt10(this.value);
        });

    }
    

    fn_keycontrol_BirthDt10(date){
        date=date.replace(/[^0-9]/g,'');/*숫자만 입력*/
        if (date.length < 4) {
            return date;
        }

        if (date.length > 8){
            date = date.substring(0, 8);
        }

        var DataFormat, RegDateFmt;
        if (date.length <= 6) {
            DataFormat = "$1/$2"; // 포맷(-)을 바꾸려면 이곳을 변경
            RegDateFmt = /([0-9]{4})([0-9]+)/;
        } else if (date.length <= 9) {
            DataFormat = "$1/$2/$3"; // 포맷(-)을 바꾸려면 이곳을 변경
            RegDateFmt = /([0-9]{4})([0-9]{2})([0-9]+)/;
        }

        if (DataFormat != undefined){
            date = date.replace(RegDateFmt, DataFormat);
        }

        return date;
    }

    fn_keycontrol_NumberComma(x){
        x=x.replace(/[^-0-9]/g,'');
        return x.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
    }

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

    /*그리드에서 전체, 리스트 체크박스가 있는 경우 2개 컨트롤 하는 함수*/
    fn_checkbox_ctl_all_list(cssSelectorAll, cssSelectorList){
        const totalCnt = $(cssSelectorList).length;
        
        //전체 선택 체크박스 클릭시
        $(cssSelectorAll).on("click", function(){
            let isChecked = $(this).is(":checked");
            $(cssSelectorList).prop("checked",isChecked);
        });
        //리스트 체크박스 클릭시
        $(cssSelectorList).on("click", function(){
            let checkedCnt = $(cssSelectorList + ":checked").length;
            if( totalCnt==checkedCnt ){
                $(cssSelectorAll).prop("checked",true);
            }else{
                $(cssSelectorAll).prop("checked",false);
            }
        });
    }

    fn_checkbox_ctl_list(checked, checkboxList){
        if (checkboxList == undefined || checkboxList.length < 1)
            return;
        
        var ifor, ilen = checkboxList.length;
        if (checked){
			for(ifor=0 ; ifor<ilen ; ifor++){
				$(checkboxList[ifor]).prop("checked", true);
			}
		}else{
			for(ifor=0 ; ifor<ilen ; ifor++){
				$(checkboxList[ifor]).removeAttr('checked');
				$(checkboxList[ifor]).prop("checked", false);
			}
		}
    }
}