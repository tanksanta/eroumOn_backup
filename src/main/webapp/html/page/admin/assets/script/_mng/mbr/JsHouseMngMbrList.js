class JsHouseMngMbrList extends JsHouse2309PageBase{
    fn_searched_sub_cls(){
        if (this._cls_info.searched_data != undefined && this._cls_info.searched_data.grade != undefined && this._cls_info.searched_data.grade.length > 0){
            this._cls_info.searched_data.grade = decodeURIComponent(this._cls_info.searched_data.grade);
            this._cls_info.searched_data.grade = this._cls_info.searched_data.grade.split(',')
        }
    }

    fn_page_sub(){
        $(this._cls_info.pagePrefix + " table.table-list tr td a.btn.view.mbr").removeAttr("href");
        

        var owner = this;
        
        $(this._cls_info.pagePrefix + ' table.table-list tr td a.btn.view.mbr').off('click').on('click', function () {
            var searchedData = owner.fn_page_condition();
            var uniqueId = $(this).attr("uniqueId");

            owner._cls_info.jsCallApi.call_svr_post_move(uniqueId + "/view", null, searchedData);
        });
    }

    fn_page_condition(){
        var nStart, curPage = 1;
        
        nStart = window.location.href.indexOf("curPage");
        if (nStart >= 0){
            var saTemp, nLast = window.location.href.indexOf("&", nStart);
            if (nLast == -1 ) nLast = window.location.href.length;

            if (nLast > nStart){
                saTemp = window.location.href.substring(nStart, nLast).split('=');

                if (saTemp.length > 1 && !isNaN(saTemp[1])){
                    curPage = saTemp[1];
                }
            }
        }

        var obj = { 
            "srchMbrId": $(this._cls_info.pagePrefix + " #srchMbrId").val()
            , "srchMbrNm": $(this._cls_info.pagePrefix + " #srchMbrNm").val()
            , "srchLastTelnoOfMbl": $(this._cls_info.pagePrefix + " #srchLastTelnoOfMbl").val()
            , "srchBrdt": $(this._cls_info.pagePrefix + " #srchBrdt").val()
            , "srchRecipterYn": $(this._cls_info.pagePrefix + " input[type='radio'][name='srchRecipterYn']:checked").val()
            , "srchGrade0": $(this._cls_info.pagePrefix + " input[type='checkbox'][name='srchGrade0']:checked").val()
            , "srchGrade1": $(this._cls_info.pagePrefix + " input[type='checkbox'][name='srchGrade1']:checked").val()
            , "srchGrade2": $(this._cls_info.pagePrefix + " input[type='checkbox'][name='srchGrade2']:checked").val()
            , "srchGrade3": $(this._cls_info.pagePrefix + " input[type='checkbox'][name='srchGrade3']:checked").val()
            , "srchGrade4": $(this._cls_info.pagePrefix + " input[type='checkbox'][name='srchGrade4']:checked").val()
            , "cntPerPage": $(this._cls_info.pagePrefix + " #countPerPage option:selected").val()
            , "srchJoinBgng" : $(this._cls_info.pagePrefix + " #srchJoinBgng").val()
            , "srchJoinEnd" : $(this._cls_info.pagePrefix + " #srchJoinEnd").val()
            , "curPage" : curPage
            , "countPerPage" : $(this._cls_info.pagePrefix + " #countPerPage").val()
            };

        obj.grade = [];
        if (obj.srchGrade0 != undefined && obj.srchGrade0.length > 0) obj.grade.push(obj.srchGrade0);
        if (obj.srchGrade1 != undefined && obj.srchGrade1.length > 0) obj.grade.push(obj.srchGrade1);
        if (obj.srchGrade2 != undefined && obj.srchGrade2.length > 0) obj.grade.push(obj.srchGrade2);
        if (obj.srchGrade3 != undefined && obj.srchGrade3.length > 0) obj.grade.push(obj.srchGrade3);
        if (obj.srchGrade4 != undefined && obj.srchGrade4.length > 0) obj.grade.push(obj.srchGrade4);


        if (obj.grade.length > 0){
            obj.grade = encodeURIComponent(obj.grade.join(','));
        }else{
            delete obj.grade;
        }


        return obj;
    }
}