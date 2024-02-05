class JsHouse2309Popups{

}
class JsHouse2309PopupBase{
    /*
        container : null일 수 있음(PopupZipSearch)
        cssSelector : 
        popName : 팝업 명칭
        popStep : 팝업 형태(1:일반, 2:팝업위 팝업, 1024:confirm, message)
    */
    constructor(container, cssSelector, popName, popStep, popOptions) {
        // if (container['fn_popup2_selected'] == undefined){
        //     alert("fn_popup2_selected 함수가 없습니다.")
        // }
        popOptions = popOptions || {};

        this._cls_info = this._cls_info || {};

        if (popStep == undefined) popStep = 1;

        this._cls_info.container = container;
        this._cls_info.pageModalfix = cssSelector;
        this._cls_info.popName = popName;
        this._cls_info.popStep = popStep;
        this._cls_info.popOptions = popOptions;
        this._cls_info.coms = {};/*컴포넌트*/
        this._cls_info.modalCon = $("div.modal2-con");
        if (this._cls_info.modalCon == undefined || this._cls_info.modalCon.length < 1) this._cls_info.modalCon = $("body");

        this._cls_info.modalPop = $(this._cls_info.pageModalfix);
        
        // this._cls_info._par_cls_info = this._cls_info.container._cls_info;

        this.fn_init_component();

        this.fn_init_click();
    }

    fn_popStep_get(){
        return this._cls_info.popStep;
    }
    fn_popStep_set(popStep){
        this._cls_info.popStep = popStep;
    }

    fn_popName_get(){
        return this._cls_info.popName;
    }
    fn_popName_set(popName){
        this._cls_info.popName = popName;
    }

    
    fn_init_title(popup_txt){
        $(this._cls_info.pageModalfix + ' .popup-head .popup-txt').html(popup_txt)
    }

    fn_init_component(){
        this.fn_init_sub_component();
    }

    fn_init_sub_component(){

    }
    
    fn_init_click( ){
        var owner = this;

        $(owner._cls_info.pageModalfix + ' .modal-close button[type="button"]').off('click').on('click', function(){
            owner.fn_close_popup();
        });

        this.fn_page_init_click();
    }

    fn_page_init_click(){
        this.fn_page_init_sub_click()
    }

    fn_page_init_sub_click(){

    }

    /* 코드값 객체를 받아서 저장*/
    fn_code_received(codeData){
        this._cls_info.codeData = codeData;
    }

    /*
        팝업창을 닫는 메서드
        현재는 modal에서 대신함
    */
    fn_close_popup(){
        $(this._cls_info.pageModalfix).removeClass("fade").modal("hide");

        if (this._cls_info.popup_param != undefined && this._cls_info.popup_param.isChanged > 0
            && this._cls_info.container != undefined && this._cls_info.container['fn_popup_selected'] != undefined){
            this._cls_info.container.fn_popup_selected('popup_data_changed', this._cls_info.popName, this._cls_info.popup_param, null, null);
        }
    }

    /* 
        팝업 찾을 여는 메서드
    */
    fn_show_popup(param){
        this._cls_info.popup_param = param;


        if (param == undefined || param.modalPop == undefined || param.modalPop){
            this._cls_info.modalPop.addClass('on');
        }

        this.fn_show_cls_popup(param);
        
        $(this._cls_info.pageModalfix).addClass("fade").modal("show");
    }

    /*
        하위 클래스에서 팝업을 열때 특정 액션
    */
    fn_show_cls_popup(param){

    }
}

/*
    서버에서 자동으로 form을 받아서 화면 표시
    cssSelector : 
    popName : 팝업 명칭
    popStep : 팝업 형태(1:일반, 2:팝업위 팝업, 1024:confirm, message)
    popUrl : 서버의 경로
*/
class JsPopupLoadingFormBase extends JsHouse2309PopupBase{
    constructor(container, cssSelector, popName, popStep, popUrl, popOptions) {
        
        super(container, cssSelector, popName, popStep, popOptions);

        this._cls_info.loadeding = false;

        this._cls_info.loadedFormYn = false;
        this._cls_info.loadedDataYn = true;

        this._cls_info.popUrl = popUrl;
    }

    fn_init_sub_component(){
        this.fn_init_third_component();
    }

    fn_init_third_component(){

    }

    fn_page_init_sub_click(){

        this.fn_page_init_third_click();
    }

    fn_page_init_third_click(){

    }

    fn_show_popup(param){
        if (this._cls_info.loadeding) return;

        super.fn_show_popup(param);
    }

    /*
        화면을 서버에서 불러와서 보여준다
    */
    fn_pop_url(){
        return this._cls_info.popUrl;
    }
    fn_loading_form_call(param){
        this._cls_info.popup_param = param;

        if (this._cls_info.modalPop == undefined || this._cls_info.modalPop.length == 0){
            this._cls_info.loadedFormYn = false;
            this._cls_info.loadeding = true;
            jsCallApi.call_api_get(this, this.fn_pop_url(), 'fn_loading_form_cb');
        }else{
            this.fn_loading_form_cb(null, null, null);
        }
        
    }

    fn_loading_form_cb(result, fail, data, param){
        this._cls_info.loadedFormYn = true;

        if (result != null) this._cls_info.formResult = result;
        
        if (this._cls_info.loadedDataYn){
            this.fn_loading_all_result_main();
        }
        
    }

    /*
        각 하위 클래스마다 팝업을 보여주고 난 뒤 처리해야 하는 부분.
        append할 당시에만 실행이 된다.
    */
    fn_loading_form_cls(){

    }

    /*
        화면, 데이터 둘다 불러왔으면 화면에 표시한다.
    */
    fn_loading_all_result_main(){
        this._cls_info.loadeding = false;

        if (this._cls_info.formResult != null && (this._cls_info.modalPop == undefined || this._cls_info.modalPop.length == 0)){
            this._cls_info.modalCon.append(this._cls_info.formResult);
            this._cls_info.modalPop = $(this._cls_info.pageModalfix);

            this.fn_loading_form_cls();
        }

        this.fn_init_click();

        this.fn_show_popup(this._cls_info.popup_param);

        var owner = this;
        
        setTimeout(() => {/*checkbox 가 안 먹어서 이렇게 한다.*/
            owner.fn_loading_all_result_data();
        }, 20);
    }

    /*
        하위 클래스에서 데이터 매핑하는 메서드
        기본 결과 데이터 : this._cls_info.dataAllResult
    */
    fn_loading_all_result_data(){
    }
}

/*
    서버에서 자동으로 form을, data를 받아서 화면 표시
    dataUrl : 데이터의 경로
*/
class JsPopupLoadingFormDataBase extends JsPopupLoadingFormBase{
    constructor(container, cssSelector, popName, popStep, popUrl, dataUrl, popOptions) {
        
        super(container, cssSelector, popName, popStep, popUrl, popOptions);

        this._cls_info.dataUrl = dataUrl;
        this._cls_info.loadedDataYn = true;
    }
    fn_data_url(){
        return this._cls_info.dataUrl;
    }
    /*
        화면과 데이터 모두 호출해서 보여주는 메스드
    */
    fn_loading_form_data_call(param, bSvrData, data){
        this.fn_loading_data_call(bSvrData, data);

        this.fn_loading_form_call(param);
    }

    /*
        데이터 호출하는 메서드
    */
    fn_loading_data_call(bSvrData, data){
        if (bSvrData){
            this._cls_info.loadeding = true;

            this._cls_info.loadedDataYn = false;
            this._cls_info.popup_data = data;
    
            jsCallApi.call_api_post_json(this, this.fn_data_url(), 'fn_loading_data_cb', data);    
        }else{
            this.fn_loading_data_cb(data, null, {});
        }
        
    }

    fn_loading_data_cb(result, fail, data, param){
        this._cls_info.loadedDataYn = true;

        this._cls_info.dataAllResult = result;
        
        if (this._cls_info.loadedFormYn){
            this.fn_loading_all_result_main();
        }
        
    }

}


class PopupZipSearch extends JsHouse2309PopupBase{
    constructor() {//constructor(container, cssSelector, popName, popStep, popOptions) {
        super(null, ".modal2-con #addrModal", 1, {});
    }

    fn_add_layer(){
        var owner = this;

        // 우편번호 찾기 화면을 넣을 element
        var element_layer = document.getElementById('addrModal');
        
        if (!element_layer){
            var width = 500;
            if (window.screen.width < 500) {
                width = 300;
            }
            
            var addrModalTemplate = `
                <div id="addrModal" class="popup" style="position:absolute; width:100%; height:100%; background:rgba(0,0,0,8); top:0; left:0; display:none;">
                    <div id="addrModal-contents" style="width:${width}px; height:500px; background:#fff; border-radius:10px; position:relative; top:30%; left:50%; margin-top:-100px; transform: translateX(-50%); text-align:center; box-sizing:border-box; padding:10px 0; line-height:23px; cursor:pointer;">
                        <button id="addrModalClose" type="button" style="float:right; margin-right: 10px; border: 1px solid lightgray; padding: 5px; border-radius: 5px;">닫기</button>
                    </div>
                </div>
            `;

            this._cls_info.modalCon.append(addrModalTemplate);
            this._cls_info.modalPop = $(this._cls_info.pageModalfix);

            $(this._cls_info.pageModalfix + " #addrModalClose").on("click", function() {
                owner.fn_close_popup();
			});
        }
        
    }

    fn_close_popup(){
        this._cls_info.modalPop.fadeOut();

    }

    /* container : 호출하는 클래스
        , callback : fn_zipsearch_cb 샘플
        , bGeoInfo : lat, lot(위도, 경도)
        , param : {
                    defalut_result:true ==> 경과가 $("#"+zip).val(data.zonecode); // 우편번호
                                                    $("#"+addr).val(data.roadAddress); // 도로명 주소 변수
                                                    $("#"+daddr).focus(); //포커스
                    }
    */
    fn_show_popup(container, callback, bGeoInfo, param){
        var owner = this;

        param.container = container;
        param.callback = callback;
        param.bGeoInfo = bGeoInfo;

        this._cls_info.popup_param = param;
        this.fn_add_layer();

        $.ajaxSetup({ cache: true });
        $.getScript( "//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js", function() {
            $.ajaxSetup({ cache: false });
            
            owner.fn_show_zip();
        });

    }

    fn_show_zip(){
        this.fn_show_cls_popup({});
    }

    fn_show_cls_popup(){
        var owner = this;

        var width = 500;
        if (window.screen.width < 500) {
            width = 300;
        }
        
        var daumLayer = document.getElementById('__daum__layer_1');
        if (daumLayer){
            daumLayer.remove();
        }
		if(true) {
            var element_layer = document.getElementById('addrModal-contents');    

			//다음 주소검색 추가
			new daum.Postcode({
				width,
                contentType: false,
                processData: false,
				oncomplete: function(data) {
                    /*{"postcode":"","postcode1":"","postcode2":"","postcodeSeq":"","zonecode":"08504","address":"서울 금천구 서부샛길 606"
                        ,"addressEnglish":"606, Seobusaet-gil, Geumcheon-gu, Seoul, Korea","addressType":"R","bcode":"1154510100"
                        ,"bname":"가산동","bnameEnglish":"Gasan-dong","bname1":"","bname1English":"","bname2":"가산동","bname2English":"Gasan-dong"
                        ,"sido":"서울","sidoEnglish":"Seoul","sigungu":"금천구","sigunguEnglish":"Geumcheon-gu","sigunguCode":"11545","userLanguageType":"K"
                        ,"query":"디폴리스","buildingName":"대성디폴리스지식산업센터","buildingCode":"1154510100104890007014247","apartment":"N"
                        ,"jibunAddress":"서울 금천구 가산동 543-1","jibunAddressEnglish":"543-1, Gasan-dong, Geumcheon-gu, Seoul, Korea"
                        ,"roadAddress":"서울 금천구 서부샛길 606","roadAddressEnglish":"606, Seobusaet-gil, Geumcheon-gu, Seoul, Korea"
                        ,"autoRoadAddress":"","autoRoadAddressEnglish":"","autoJibunAddress":"","autoJibunAddressEnglish":"","userSelectedType":"R"
                        ,"noSelected":"N","hname":"","roadnameCode":"4151238","roadname":"서부샛길","roadnameEnglish":"Seobusaet-gil"}
                    */
                    

                    if (false && owner._cls_info.popup_param.bGeoInfo){/*401 오류*/
                        $.getScript('https://dapi.kakao.com/v2/maps/sdk.js?appkey=84e3b82c817022c5d060e45c97dbb61f&autoload=false&libraries=services', function() {
                            daum.maps.load(function() {
                                const geocoder = new daum.maps.services.Geocoder();
                                geocoder.addressSearch(data.address, function(result, status) {
                                    if(status === daum.maps.services.Status.OK){
                                         data.geoinfo = result;

                                         console.log(JSON.stringify(data))
                                    }
                                });
                            });
                        });
                    }else{
                        // console.log(JSON.stringify(data))

                        owner.fn_close_popup();
                        owner.fn_search_result(data);
                        
                    }
					
		        }
		    }).embed(element_layer);
		}
		
        if (this._cls_info.popStep == 2){
            $(this._cls_info.pageModalfix).addClass("popOnPop")
            $(this._cls_info.pageModalfix).removeClass("popOn3Pop")
        }
        
        $(this._cls_info.pageModalfix).fadeIn();
    }

    fn_search_result(data){
        var owner = this;

        if (owner._cls_info.popup_param.defalut_result == true){
            $("#zip").val(data.zonecode); // 우편번호
            $("#addr").val(data.roadAddress); // 도로명 주소 변수
            $("#daddr").focus(); //포커스
        }else{
            owner._cls_info.popup_param.container[owner._cls_info.popup_param.callback](data);
        }
    }

    // fn_zipsearch_cb(data){
    //     $("#"+zip).val(data.zonecode); // 우편번호
    //     $("#"+addr).val(data.roadAddress); // 도로명 주소 변수

 	// 	if(lat != undefined && lot != undefined){
    //     	f_findGeocode(data, lat, lot); //좌표
    //     }

    //     $('#addrModal').fadeOut();
    //     $('#container').css({"display": "block"});

    //     $("#"+daddr).focus(); //포커스
        
    //     console.log(JSON.stringify(data))
    // }
}



class JsPopupDlvyInfo extends JsPopupLoadingFormDataBase{
    fn_page_init_click(){
        var owner = this;

        $(owner._cls_info.pageModalfix + ' #findAdres').removeAttr("onclick");
        $(owner._cls_info.pageModalfix + ' #findAdres').off('click').on('click', function(){
            popupZipSearch.fn_show_popup(owner, 'fn_zipsearch_cb', true, {defalut_result:true});
        });
        
        // 삭제기능 없음
        // $(owner._cls_info.pageModalfix + ' .delDlvyBtn').off('click').on('click', function(){
        //     owner.fn_del_click();
        // });
    }

    fn_loading_all_result_data(){
        if (this._cls_info.dataAllResult.resultData == undefined) this._cls_info.dataAllResult.resultData = {};

        $(this._cls_info.pageModalfix + " #dlvyNm").val(this._cls_info.dataAllResult.resultData.dlvyNm);

        var valObj1 = $(this._cls_info.pageModalfix + " .form-check.dlvyYn input[type='checkbox'][name='bassDlvyYn']");
        var valObj2 = $(this._cls_info.pageModalfix + " .form-check.dlvyYn label.form-check-label");
        var valObj3 = $(this._cls_info.pageModalfix + " .form-check.dlvyYn input[type='hidden'][name='_bassDlvyYn']");
        var bBool = this._cls_info.dataAllResult.resultData.bassDlvyYn == 'Y';
        valObj3.val(bBool?"on":"");
        valObj1.val(bBool?"Y":"N");
        valObj1.attr("origin", bBool?"Y":"N");
        valObj1.prop("checked", bBool);
        
        if (bBool){
            valObj1.attr('checked',bBool?'checked':'');

            valObj1.css('visibility', 'hidden');
            valObj2.css('visibility', 'hidden');
        }else{
            valObj1.removeAttr('checked');

            valObj1.css('visibility', '');
            valObj2.css('visibility', '');
        }

        $(this._cls_info.pageModalfix + " #nm").val(this._cls_info.dataAllResult.resultData.nm);
        $(this._cls_info.pageModalfix + " #mblTelno").val(this._cls_info.dataAllResult.resultData.mblTelno);
        $(this._cls_info.pageModalfix + " #telno").val(this._cls_info.dataAllResult.resultData.telno);


        $(this._cls_info.pageModalfix + " #zip").val(this._cls_info.dataAllResult.resultData.zip);
        $(this._cls_info.pageModalfix + " #addr").val(this._cls_info.dataAllResult.resultData.addr);
        $(this._cls_info.pageModalfix + " #daddr").val(this._cls_info.dataAllResult.resultData.daddr);


        valObj1 = $(this._cls_info.pageModalfix + " #selMemo");
        valObj2 = $(this._cls_info.pageModalfix + " #memo");

        if (this._cls_info.dataAllResult.resultData.memo == undefined || this._cls_info.dataAllResult.resultData.memo.length < 1){
            valObj1.val(this._cls_info.dataAllResult.resultData.memo).prop("selected", true);
            valObj2.val('');
            valObj2.css('display', 'none');
        }else{
            valObj1.val(this._cls_info.dataAllResult.resultData.memo).prop("selected", true);
            if (valObj1.val() == undefined || valObj1.val() == ""){
                valObj1.val("직접입력").prop("selected", true);
                valObj2.val(this._cls_info.dataAllResult.resultData.memo);
                valObj2.css('display', '');
            }else{
                valObj2.val('');
                valObj2.css('display', 'none');
            }
        }
        
    }
    
    // 삭제기능 없음
    fn_del_click(){
        // var mngNo = $(this).data("mngNo");
        // if(confirm("이 배송지를 삭제하시겠습니까?")){
        //     $.ajax({
        //         type : "post",
        //         url  : "delDlvyMng.json",
        //         data : {dlvyMngNo :mngNo},
        //         dataType : 'json'
        //     })
        //     .done(function(data) {
        //         if(data.result == true){
        //             alert("정상적으로 삭제되었습니다.");
        //             location.reload();
        //         }else{
        //             alert("배송지 삭제 중 오류가 발생했습니다. \n 관리자에게 문의 바랍니다.");
        //         }
        //     })
        //     .fail(function(data, status, err) {
        //         alert("배송지 삭제 중 오류가 발생했습니다. \n 관리자에게 문의 바랍니다.");
        //         console.log('error forward : ' + data);
        //     });
        // }else{
        //     return false;
        // }
    }
}

class JsPopupTest{
    constructor(){
        
    }

    async fn_aa(){
        var jsPopupExcelPwd = new JsPopupExcelPwd(this, '', 'jsPopupExcelPwd', 1, {});
        const asyncConfirm = await jsPopupExcelPwd.fn_show_popup({})
        console.log(asyncConfirm)
        if (asyncConfirm != "confirm"){
            return;
        }

        


    }
}
class JsPopupExcelPwd extends JsPopupLoadingFormBase{
    /*
    async fn_aa(){
        var jsPopupExcelPwd = new JsPopupExcelPwd(this, '', 'jsPopupExcelPwd', 1, {});
        const asyncConfirm = await jsPopupExcelPwd.fn_show_popup({})
        console.log(asyncConfirm)
        if (asyncConfirm != "confirm"){
            return;
        }
    */

    fn_init_third_component(){
        if (this._cls_info.modalPop == undefined || this._cls_info.modalPop.length < 1){
            var contents = `<div class="modal fade" id="modal-excel-download" tabindex="-1" aria-modal="true" role="dialog" >
                <div class="modal-dialog modal-dialog-centered">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h2>엑셀다운로드</h2>
                            <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="close"></button>
                        </div>
                        <div class="modal-body">
                            <div class="mb-5">
                                <p class="flex items-center gap-1"><i class="ico-alert2 size-sm"></i> 로그인한 계정의 비밀번호를 입력하세요.</p>
                                <p class="flex items-center gap-1"><i class="ico-alert2 size-sm"></i> 개인정보 다운로드 시 사유를 작성하세요.</p>
                            </div>
                            <table class="table-detail">
                                <colgroup>
                                    <col class="w-1/3">
                                    <col>
                                </colgroup>
                                <tbody>
                                    <tr class="pwd">
                                        <th scope="row"><label for="form-item1" class="require">비밀번호</label></th>
                                        <td class="con">
                                            <input type="password" class="form-control w-full mb-1" id="form-item1">
                                            <div class="w-full alert alert-danger fade show">
                                                <p class="moji">:(</p>
                                                <p class="text">비밀번호를 입력하세요.</p>
                                                <button type="button" aria-label="close">닫기</button>
                                            </div>
                                        </td>
                                    </tr>
                                    <tr class="txt">
                                        <th scope="row"><label for="form-item2" class="require">사유</label></th>
                                        <td class="con">
                                            <textarea name="" id="form-item2" cols="30" rows="7" class="form-control w-full mb-1"></textarea>
                                            <div class="w-full alert alert-danger fade show">
                                                <p class="moji">:(</p>
                                                <p class="text">다운로드 사유를 입력해 주세요.</p>
                                                <button type="button" aria-label="close">닫기</button>
                                            </div>
                                        </td>
                                    </tr>
                                </tbody>
                            </table>
                        </div>
                        <div class="modal-footer">
                            <a href="#" class="btn large btn-primary save">저장</a>
                            <a href="#" class="btn large btn-outline-primary cancel">취소</a>
                        </div>
                    </div>
                </div>
            </div>`;

            this._cls_info.pageModalfix = '#modal-excel-download';
            this._cls_info.modalCon.append(contents);

            this._cls_info.modalPop = $(this._cls_info.pageModalfix);

            this._cls_info.coms.inputPwd = $(this._cls_info.pageModalfix + ' .table-detail tr.pwd td.con input[type="password"]');
            this._cls_info.coms.inputTxt = $(this._cls_info.pageModalfix + ' .table-detail tr.txt td.con textarea');

            this._cls_info.coms.msgPwd = $(this._cls_info.pageModalfix + ' .table-detail tr.pwd td.con div');
            this._cls_info.coms.msgTxt = $(this._cls_info.pageModalfix + ' .table-detail tr.txt td.con div');

            this._cls_info.coms.msgPwd.hide();
            this._cls_info.coms.msgTxt.hide();
        }
    }

    fn_page_init_third_click(){
        if (this._cls_info.coms.msgPwd != undefined){
            $(this._cls_info.pageModalfix + ' .table-detail tr td.con div.alert button[type="button"][aria-label="close"]').off('click').on('click', function(){
                $(this).closest('div.alert').hide();

                $(this).closest('td').find(".is-invalid").removeClass("is-invalid");
            });
        }

    }

    async fn_show_popup(param){
        var owner = this;

        super.fn_show_popup(param);

        owner._cls_info.coms.msgPwd.find('.text').html('비밀번호를 입력하세요.');
        owner._cls_info.coms.msgPwd.hide();

        this._cls_info.coms.inputPwd.removeClass("is-invalid");
        this._cls_info.coms.inputTxt.removeClass("is-invalid");
        
        $(owner._cls_info.pageModalfix + ' .table-detail tr.pwd input[type="password"]').val("");
        $(owner._cls_info.pageModalfix + ' .table-detail tr.txt textarea').val("");

        return this.fn_async();
    }

    async fn_async(){
        var owner = this;
        var bCall;
        return new Promise((resolve) => {
            $(owner._cls_info.pageModalfix + ' .btn.save').off('click').on('click', function(){
                bCall = true;

                var data = {};
                data.pwd = $(owner._cls_info.pageModalfix + ' .table-detail tr.pwd input[type="password"]').val();
                data.txt = $(owner._cls_info.pageModalfix + ' .table-detail tr.txt textarea').val();
                data.caller = document.location.pathname + document.location.search;

                if (data.pwd == "" || data.pwd.length < 2){
                    owner._cls_info.coms.inputPwd.addClass("is-invalid");
        
                    owner._cls_info.coms.msgPwd.find('.text').html('비밀번호를 입력하세요.');
                    owner._cls_info.coms.msgPwd.show();
                    bCall = false;
                }
    
                if (data.txt == "" || data.txt.length < 2){
                    owner._cls_info.coms.inputTxt.addClass("is-invalid");
                    owner._cls_info.coms.msgTxt.show();
                    bCall = false;
                }

                if (!bCall){
                    return;
                }

                var retVal =  jsCallApi.call_sync_api_post('/_mng/api/popups/excelPwd.json', data);
                if (retVal == null || retVal.result == null || retVal.result.result != "OK"){
                    owner._cls_info.coms.msgPwd.find('.text').html('비밀번호가 일치하지 않습니다.');
                    owner._cls_info.coms.msgPwd.show();
                    return;
                }

                owner.fn_close_popup();

                resolve('confirm');
            });
            $(owner._cls_info.pageModalfix + ' .btn.cancel').off('click').on('click', function(){
                owner.fn_close_popup();
                resolve('reject')
            });
            
          })
    }

    fn_call_svr(){
        
    }


}

