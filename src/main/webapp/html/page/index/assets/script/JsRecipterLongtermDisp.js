class JsRecipterLongtermDisp{
    constructor(){
        this._cls_info = { 
        }
    }

    fn_init_page(mainPath){
        this._cls_info._mainPath = mainPath;
    }

    fn_data_CodeMap(codeMap){
        this._cls_info._codeMap = codeMap;
    }



    fn_data_received_getRecipterInfo(json){
        /*console.log(json)*/
        if (json == undefined || json.isSearch == false || json.infoMap == undefined){
            return;
        }

        this.fn_itemGrp_summary(".recipter_view .own_view", json.infoMap.ownList);

        this.fn_tabletr_detail(".recipter_view .status-table tbody.sale_return", "S", json.infoMap.ownList);
        this.fn_tabletr_detail(".recipter_view .status-table tbody.lend_return", "R", json.infoMap.ownList);

    }

    fn_itemGrp_summary(cssPrefix, jsonOwnList){
        var ifor, key, keys = Object.keys(jsonOwnList);
        var itemOne, joTargetFin, joTargetBuy;

        for (ifor=0; ifor<keys.length; ifor++) {
            key = keys[ifor];
            itemOne = jsonOwnList[key];

            joTargetFin = $(cssPrefix + " .fin" + itemOne.itemGrpCd + " .cnt");
            joTargetBuy = $(cssPrefix + " .buy" + itemOne.itemGrpCd + " .cnt");

            if (itemOne.ableYn != 'Y'){
                joTargetFin.html(0);
                joTargetBuy.html(0);
            }else{
                if (itemOne.ableCnt > itemOne.persistPeriodCnt){
                    joTargetFin.html(itemOne.persistPeriodCnt);
                }else{
                    joTargetFin.html(itemOne.persistPeriodCnt - itemOne.ableCnt);
                }
                joTargetBuy.html(itemOne.ableCnt);

            }

        }

        /************************************매트리스 예외사항***********************************/
        itemOne = jsonOwnList["mattressR"];
        var itemSelected, itemTwo = jsonOwnList["mattressS"];
        joTargetFin = $(cssPrefix + " .fin" + "mattress" + " .cnt");
        joTargetBuy = $(cssPrefix + " .buy" + "mattress" + " .cnt");

        if (itemOne.ableYn != 'Y'){
            joTargetFin.html(0);
            joTargetBuy.html(0);
        }else{
            if (itemTwo.ableCnt > 0){
                itemSelected = itemTwo;
            }else{
                itemSelected = itemTwo;
            }

            if (itemSelected.ableCnt > itemSelected.persistPeriodCnt){
                joTargetFin.html(itemSelected.persistPeriodCnt);
            }else{
                joTargetFin.html(itemSelected.persistPeriodCnt - itemSelected.ableCnt);
            }
            joTargetBuy.html(itemSelected.ableCnt);
        }
    }

    fn_tabletr_detail(cssPrefix, saleKind, jsonOwnList){
        var key, keys = Object.keys(jsonOwnList);
        var joTarget = $(cssPrefix);
        var itemOne;

        var ifor;
        var sTrTemp, sTrBase = "<tr>"+
                    "<td class=\"sale_index\">{{ifor}}</td>"+
                    "<td class=\"subject\"><a href=\""+this._cls_info._mainPath+"/cntnts/page3-checkpoint#check-cont{{Link}}\" target=\"_blank\">{{itemGrpNm}}</a></td>"+
                    "<td class=\"fin{{itemGrpCd}}\">{{contractCnt}}</td><td class=\"buy{{itemGrpCd}}\">{{ableCnt}}</td>"+
                "</tr>";


        joTarget.empty();

        if (keys.length == 0){
            let html = "";
            html +='   <tr>';
            html +='    <td colspan="4">검색된 데이터가 없습니다.</td>';
            html +='</tr>';
            joTarget.append(html);
        }else{
            var ipos = 0;
            for (ifor=0; ifor<keys.length; ifor++) {
                key = keys[ifor];
                itemOne = jsonOwnList[key];

                if (itemOne.saleKind != saleKind){
                    continue;
                }

                ipos += 1;
                sTrTemp = sTrBase;
    
                sTrTemp = sTrTemp.replaceAll("{{ifor}}", (ipos));
                sTrTemp = sTrTemp.replaceAll("{{Link}}", this.f_replaceLink(itemOne.itemGrpCd));
                
                sTrTemp = sTrTemp.replaceAll("{{itemGrpCd}}", itemOne.itemGrpCd);
                
                if (itemOne.ableYn != 'Y'){
                    if (itemOne.saleKind == "S"){
                        sTrTemp = sTrTemp.replaceAll("{{itemGrpNm}}", itemOne.itemGrpNm.replaceAll("(대여)", "").replaceAll("(판매)", "") + "(판매 불가)");
                    }else{
                        sTrTemp = sTrTemp.replaceAll("{{itemGrpNm}}", itemOne.itemGrpNm.replaceAll("(대여)", "").replaceAll("(판매)", "") + "(대여 불가)");
                    }
                    
                    sTrTemp = sTrTemp.replaceAll("{{contractCnt}}", "해당없음");
                    sTrTemp = sTrTemp.replaceAll("{{ableCnt}}", "해당없음");
                }else{
                    sTrTemp = sTrTemp.replaceAll("{{itemGrpNm}}", itemOne.itemGrpNm.replaceAll("(대여)", "").replaceAll("(판매)", ""));
                    if (itemOne.ableCnt > itemOne.persistPeriodCnt){
                        sTrTemp = sTrTemp.replaceAll("{{contractCnt}}", itemOne.persistPeriodCnt);
                    }else{
                        sTrTemp = sTrTemp.replaceAll("{{contractCnt}}", itemOne.persistPeriodCnt - itemOne.ableCnt);
                    }
                    
                    sTrTemp = sTrTemp.replaceAll("{{ableCnt}}", itemOne.ableCnt);
                }
                
    
                joTarget.append(sTrTemp)
            }
        }
        
    }

    f_replaceLink (str){
        let link = 0;
    
        switch(str){
            case "walkerForAdults":
                link = 1;
                break;
            case "wheelchair":
                link = 2;
                break;
            case "cane":
                link = 3;
                break;
            case "safetyHandle":
                link = 4;
                break;
            case "antiSlipProduct":
                link = 5;
                break;
            case "antiSlipSocks":
                link = 6;
                break;
            case "mattress":
            case "mattressS":
            case "mattressR":
                link = 7;
                break;
            case "cushion":
                link = 8;
                break;
            case "changeTool":
                link = 9;
                break;
            case "panties":
                link = 10;
                break;
            case "bathChair":
                link = 11;
                break;
            case "mobileToilet":
                link = 12;
                break;
            case "portableToilet":
                link = 13;
                break;
            case "outRunway":
                link = 14;
                break;
            case "inRunway":
                link = 14;
                break;
            default:
                // link = 0;
                new Error("f_replaceLink not founded str=" + str)
                break;
        }
    
    
        return link;
    }

    
    fn_get_json(){
        return this.fn_get_json_2();
    }
    fn_get_json_1(){
        var str = `{
            "result": true,
            "isSearch": true,
            "infoMap": {
                "QLF_TYPE": "3",
                "LTC_RCGT_GRADE_CD": "1",
                "APDT_FR_DT": "20230329",
                "allList": [
                    "mobileToilet",
                    "bathChair",
                    "walkerForAdults",
                    "safetyHandle",
                    "antiSlipProduct",
                    "portableToilet",
                    "cane",
                    "cushion",
                    "changeTool",
                    "panties",
                    "inRunway",
                    "wheelchair",
                    "electricBed",
                    "manualBed",
                    "bathtub",
                    "bathLift",
                    "detector",
                    "outRunway",
                    "mattress"
                ],
                "lendList": [
                    "wheelchair",
                    "electricBed",
                    "manualBed",
                    "mattress",
                    "bathtub",
                    "bathLift",
                    "detector",
                    "outRunway"
                ],
                "saleNonList": [],
                "saleList": [
                    "mobileToilet",
                    "bathChair",
                    "safetyHandle",
                    "antiSlipProduct",
                    "portableToilet",
                    "cane",
                    "cushion",
                    "changeTool",
                    "mattress",
                    "walkerForAdults",
                    "panties",
                    "inRunway"
                ],
                "lendNonList": [],
                "LTC_MGMT_NO_SEQ": "109",
                "RCGT_EDA_DT": "2023-07-15 ~ 2025-07-14",
                "SELF_BND_RT": 15,
                "SBA_CD": "일반",
                "ownLendList": [
                    "electricBed",
                    "wheelchair",
                    "wheelchair",
                    "wheelchair",
                    "electricBed"
                ],
                "APDT_TO_DT": "20240328",
                "ownList": {
                    "wheelchair": {
                        "ableYn": "Y",
                        "ableCnt": 0,
                        "saleKind": "R",
                        "itemGrpNm": "수동휠체어",
                        "persistPeriodCnt": 1,
                        "itemGrpCd": "wheelchair",
                        "persistPeriodYear": 1
                    },
                    "bathLift": {
                        "ableYn": "Y",
                        "ableCnt": 1,
                        "saleKind": "R",
                        "itemGrpNm": "목욕리프트",
                        "persistPeriodCnt": 1,
                        "itemGrpCd": "bathLift",
                        "persistPeriodYear": 1
                    },
                    "bathChair": {
                        "ableYn": "Y",
                        "ableCnt": 0,
                        "saleKind": "S",
                        "itemGrpNm": "목욕의자",
                        "persistPeriodCnt": 1,
                        "itemGrpCd": "bathChair",
                        "persistPeriodYear": 5
                    },
                    "safetyHandle": {
                        "ableYn": "Y",
                        "ableCnt": 10,
                        "saleKind": "S",
                        "itemGrpNm": "안전손잡이",
                        "persistPeriodCnt": 10,
                        "itemGrpCd": "safetyHandle",
                        "persistPeriodYear": 1
                    },
                    "panties": {
                        "ableYn": "Y",
                        "ableCnt": 4,
                        "saleKind": "S",
                        "itemGrpNm": "요실금팬티",
                        "persistPeriodCnt": 4,
                        "itemGrpCd": "panties",
                        "persistPeriodYear": 1
                    },
                    "antiSlipProduct": {
                        "ableYn": "Y",
                        "ableCnt": 5,
                        "saleKind": "S",
                        "itemGrpNm": "미끄럼 방지매트/액",
                        "persistPeriodCnt": 5,
                        "itemGrpCd": "antiSlipProduct",
                        "persistPeriodYear": 1
                    },
                    "changeTool": {
                        "ableYn": "Y",
                        "ableCnt": 5,
                        "saleKind": "S",
                        "itemGrpNm": "자세변환용구",
                        "persistPeriodCnt": 5,
                        "itemGrpCd": "changeTool",
                        "persistPeriodYear": 1
                    },
                    "outRunway": {
                        "ableYn": "Y",
                        "ableCnt": 1,
                        "saleKind": "R",
                        "itemGrpNm": "경사로(실외용)",
                        "persistPeriodCnt": 1,
                        "itemGrpCd": "outRunway",
                        "persistPeriodYear": 1
                    },
                    "manualBed": {
                        "ableYn": "Y",
                        "ableCnt": 0,
                        "saleKind": "R",
                        "itemGrpNm": "수동침대",
                        "persistPeriodCnt": 1,
                        "itemGrpCd": "manualBed",
                        "persistPeriodYear": 1
                    },
                    "antiSlipSocks": {
                        "ableYn": "Y",
                        "ableCnt": 6,
                        "saleKind": "S",
                        "itemGrpNm": "미끄럼 방지양말",
                        "persistPeriodCnt": 6,
                        "itemGrpCd": "antiSlipSocks",
                        "persistPeriodYear": 1
                    },
                    "bathtub": {
                        "ableYn": "Y",
                        "ableCnt": 1,
                        "saleKind": "R",
                        "itemGrpNm": "이동욕조",
                        "persistPeriodCnt": 1,
                        "itemGrpCd": "bathtub",
                        "persistPeriodYear": 1
                    },
                    "walkerForAdults": {
                        "ableYn": "Y",
                        "ableCnt": 0,
                        "saleKind": "S",
                        "itemGrpNm": "성인용보행기",
                        "persistPeriodCnt": 2,
                        "itemGrpCd": "walkerForAdults",
                        "persistPeriodYear": 5
                    },
                    "inRunway": {
                        "ableYn": "Y",
                        "ableCnt": 6,
                        "saleKind": "S",
                        "itemGrpNm": "경사로(실내용)",
                        "persistPeriodCnt": 6,
                        "itemGrpCd": "inRunway",
                        "persistPeriodYear": 2
                    },
                    "cushion": {
                        "ableYn": "Y",
                        "ableCnt": 0,
                        "saleKind": "S",
                        "itemGrpNm": "욕창예방방석",
                        "persistPeriodCnt": 1,
                        "itemGrpCd": "cushion",
                        "persistPeriodYear": 3
                    },
                    "mobileToilet": {
                        "ableYn": "Y",
                        "ableCnt": 0,
                        "saleKind": "S",
                        "itemGrpNm": "이동변기",
                        "persistPeriodCnt": 1,
                        "itemGrpCd": "mobileToilet",
                        "persistPeriodYear": 5
                    },
                    "portableToilet": {
                        "ableYn": "Y",
                        "ableCnt": 2,
                        "saleKind": "S",
                        "itemGrpNm": "간이변기",
                        "persistPeriodCnt": 2,
                        "itemGrpCd": "portableToilet",
                        "persistPeriodYear": 1
                    },
                    "cane": {
                        "ableYn": "Y",
                        "ableCnt": 0,
                        "saleKind": "S",
                        "itemGrpNm": "지팡이",
                        "persistPeriodCnt": 1,
                        "itemGrpCd": "cane",
                        "persistPeriodYear": 2
                    },
                    "mattressR": {
                        "ableYn": "Y",
                        "ableCnt": 0,
                        "saleKind": "R",
                        "itemGrpNm": "욕창예방 매트리스(대여)",
                        "persistPeriodCnt": 1,
                        "itemGrpCd": "mattressR",
                        "persistPeriodYear": 1
                    },
                    "mattressS": {
                        "ableYn": "Y",
                        "ableCnt": 0,
                        "saleKind": "S",
                        "itemGrpNm": "욕창예방 매트리스(판매)",
                        "persistPeriodCnt": 1,
                        "itemGrpCd": "mattressS",
                        "persistPeriodYear": 3
                    },
                    "detector": {
                        "ableYn": "Y",
                        "ableCnt": 1,
                        "saleKind": "R",
                        "itemGrpNm": "배회감지기",
                        "persistPeriodCnt": 1,
                        "itemGrpCd": "detector",
                        "persistPeriodYear": 1
                    },
                    "electricBed": {
                        "ableYn": "Y",
                        "ableCnt": 0,
                        "saleKind": "R",
                        "itemGrpNm": "전동침대",
                        "persistPeriodCnt": 1,
                        "itemGrpCd": "electricBed",
                        "persistPeriodYear": 1
                    }
                },
                "LMT_AMT": "1600000",
                "REMN_AMT": "1298500",
                "LTC_MGMT_NO": "L0011559991",
                "REDUCE_NM": "일반",
                "ownSaleList": [
                    "mattress",
                    "cushion",
                    "cane"
                ],
                "USE_AMT": 1399230
            },
            "refleshDate": "2023년 11월 03일 12:09:39"
        }`;
    
        return JSON.parse(str);
    }
    fn_get_json_2(){
        var str = `
        {
            "result": true,
            "isSearch": true,
            "infoMap": {
                "QLF_TYPE": "3",
                "LTC_RCGT_GRADE_CD": "3",
                "APDT_FR_DT": "20230913",
                "allList": [
                    "mobileToilet",
                    "bathChair",
                    "walkerForAdults",
                    "safetyHandle",
                    "antiSlipProduct",
                    "portableToilet",
                    "cane",
                    "cushion",
                    "changeTool",
                    "panties",
                    "inRunway",
                    "wheelchair",
                    "electricBed",
                    "manualBed",
                    "bathtub",
                    "bathLift",
                    "detector",
                    "outRunway",
                    "mattress"
                ],
                "lendList": [
                    "wheelchair",
                    "electricBed",
                    "manualBed",
                    "mattress",
                    "detector",
                    "outRunway"
                ],
                "saleNonList": [
                    "changeTool"
                ],
                "saleList": [
                    "mobileToilet",
                    "bathChair",
                    "safetyHandle",
                    "antiSlipProduct",
                    "portableToilet",
                    "cane",
                    "cushion",
                    "mattress",
                    "walkerForAdults",
                    "panties",
                    "inRunway"
                ],
                "lendNonList": [
                    "bathtub",
                    "bathLift"
                ],
                "LTC_MGMT_NO_SEQ": "111",
                "RCGT_EDA_DT": "2023-03-13 ~ 2026-09-12",
                "SELF_BND_RT": 15,
                "SBA_CD": "일반",
                "ownLendList": [
                    "wheelchair"
                ],
                "APDT_TO_DT": "20240912",
                "ownList": {
                    "wheelchair": {
                        "ableYn": "Y",
                        "ableCnt": 0,
                        "saleKind": "R",
                        "itemGrpNm": "수동휠체어",
                        "persistPeriodCnt": 1,
                        "itemGrpCd": "wheelchair",
                        "persistPeriodYear": 1
                    },
                    "bathLift": {
                        "ableYn": "N",
                        "ableCnt": 1,
                        "saleKind": "R",
                        "itemGrpNm": "목욕리프트",
                        "persistPeriodCnt": 1,
                        "itemGrpCd": "bathLift",
                        "persistPeriodYear": 1
                    },
                    "bathChair": {
                        "ableYn": "Y",
                        "ableCnt": 1,
                        "saleKind": "S",
                        "itemGrpNm": "목욕의자",
                        "persistPeriodCnt": 1,
                        "itemGrpCd": "bathChair",
                        "persistPeriodYear": 5
                    },
                    "safetyHandle": {
                        "ableYn": "Y",
                        "ableCnt": 10,
                        "saleKind": "S",
                        "itemGrpNm": "안전손잡이",
                        "persistPeriodCnt": 10,
                        "itemGrpCd": "safetyHandle",
                        "persistPeriodYear": 1
                    },
                    "panties": {
                        "ableYn": "Y",
                        "ableCnt": 4,
                        "saleKind": "S",
                        "itemGrpNm": "요실금팬티",
                        "persistPeriodCnt": 4,
                        "itemGrpCd": "panties",
                        "persistPeriodYear": 1
                    },
                    "antiSlipProduct": {
                        "ableYn": "Y",
                        "ableCnt": 5,
                        "saleKind": "S",
                        "itemGrpNm": "미끄럼 방지매트/액",
                        "persistPeriodCnt": 5,
                        "itemGrpCd": "antiSlipProduct",
                        "persistPeriodYear": 1
                    },
                    "changeTool": {
                        "ableYn": "N",
                        "ableCnt": 5,
                        "saleKind": "S",
                        "itemGrpNm": "자세변환용구",
                        "persistPeriodCnt": 5,
                        "itemGrpCd": "changeTool",
                        "persistPeriodYear": 1
                    },
                    "outRunway": {
                        "ableYn": "Y",
                        "ableCnt": 1,
                        "saleKind": "R",
                        "itemGrpNm": "경사로(실외용)",
                        "persistPeriodCnt": 1,
                        "itemGrpCd": "outRunway",
                        "persistPeriodYear": 1
                    },
                    "manualBed": {
                        "ableYn": "Y",
                        "ableCnt": 1,
                        "saleKind": "R",
                        "itemGrpNm": "수동침대",
                        "persistPeriodCnt": 1,
                        "itemGrpCd": "manualBed",
                        "persistPeriodYear": 1
                    },
                    "antiSlipSocks": {
                        "ableYn": "Y",
                        "ableCnt": 6,
                        "saleKind": "S",
                        "itemGrpNm": "미끄럼 방지양말",
                        "persistPeriodCnt": 6,
                        "itemGrpCd": "antiSlipSocks",
                        "persistPeriodYear": 1
                    },
                    "bathtub": {
                        "ableYn": "N",
                        "ableCnt": 1,
                        "saleKind": "R",
                        "itemGrpNm": "이동욕조",
                        "persistPeriodCnt": 1,
                        "itemGrpCd": "bathtub",
                        "persistPeriodYear": 1
                    },
                    "walkerForAdults": {
                        "ableYn": "Y",
                        "ableCnt": 2,
                        "saleKind": "S",
                        "itemGrpNm": "성인용보행기",
                        "persistPeriodCnt": 2,
                        "itemGrpCd": "walkerForAdults",
                        "persistPeriodYear": 5
                    },
                    "inRunway": {
                        "ableYn": "Y",
                        "ableCnt": 6,
                        "saleKind": "S",
                        "itemGrpNm": "경사로(실내용)",
                        "persistPeriodCnt": 6,
                        "itemGrpCd": "inRunway",
                        "persistPeriodYear": 2
                    },
                    "cushion": {
                        "ableYn": "Y",
                        "ableCnt": 1,
                        "saleKind": "S",
                        "itemGrpNm": "욕창예방방석",
                        "persistPeriodCnt": 1,
                        "itemGrpCd": "cushion",
                        "persistPeriodYear": 3
                    },
                    "mobileToilet": {
                        "ableYn": "Y",
                        "ableCnt": 1,
                        "saleKind": "S",
                        "itemGrpNm": "이동변기",
                        "persistPeriodCnt": 1,
                        "itemGrpCd": "mobileToilet",
                        "persistPeriodYear": 5
                    },
                    "portableToilet": {
                        "ableYn": "Y",
                        "ableCnt": 2,
                        "saleKind": "S",
                        "itemGrpNm": "간이변기",
                        "persistPeriodCnt": 2,
                        "itemGrpCd": "portableToilet",
                        "persistPeriodYear": 1
                    },
                    "cane": {
                        "ableYn": "Y",
                        "ableCnt": 1,
                        "saleKind": "S",
                        "itemGrpNm": "지팡이",
                        "persistPeriodCnt": 1,
                        "itemGrpCd": "cane",
                        "persistPeriodYear": 2
                    },
                    "mattressR": {
                        "ableYn": "Y",
                        "ableCnt": 1,
                        "saleKind": "R",
                        "itemGrpNm": "욕창예방 매트리스(대여)",
                        "persistPeriodCnt": 1,
                        "itemGrpCd": "mattressR",
                        "persistPeriodYear": 1
                    },
                    "mattressS": {
                        "ableYn": "Y",
                        "ableCnt": 1,
                        "saleKind": "S",
                        "itemGrpNm": "욕창예방 매트리스(판매)",
                        "persistPeriodCnt": 1,
                        "itemGrpCd": "mattressS",
                        "persistPeriodYear": 3
                    },
                    "detector": {
                        "ableYn": "Y",
                        "ableCnt": 1,
                        "saleKind": "R",
                        "itemGrpNm": "배회감지기",
                        "persistPeriodCnt": 1,
                        "itemGrpCd": "detector",
                        "persistPeriodYear": 1
                    },
                    "electricBed": {
                        "ableYn": "Y",
                        "ableCnt": 1,
                        "saleKind": "R",
                        "itemGrpNm": "전동침대",
                        "persistPeriodCnt": 1,
                        "itemGrpCd": "electricBed",
                        "persistPeriodYear": 1
                    }
                },
                "LMT_AMT": "1600000",
                "REMN_AMT": "1600000",
                "LTC_MGMT_NO": "L0010477232",
                "REDUCE_NM": "일반",
                "ownSaleList": [],
                "USE_AMT": 384000
            },
            "refleshDate": "2023년 11월 03일 12:19:54"
        }
        `

        return JSON.parse(str);
    }
}