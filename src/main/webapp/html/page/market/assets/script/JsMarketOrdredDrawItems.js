/*
    결제 완료 후 상품을 html로 그려주는 클래스
    ordredListJson : 주문된 데이터
    entrpsVOList : 입점업체 리스트
    codeMapJson : 코드성 데이터
                - CodeMap.ordrSttsCode
                - CodeMap.gdsTyCode
                - CodeMap.bassStlmTyCode
                - dlvyCoList : 배송업체 리스트
*/
class JsMarketOrdredDrawItems{
    constructor(){
        this._cls_info = this._cls_info || {};

		this._cls_info.bDev = true;
		
		this._cls_info.popups = {};
        this._cls_info.jsCommon = new JsCommon();

        this._cls_info.dispOptions = {};
        this._cls_info.dispOptions.body = {};
        this._cls_info.dispOptions.body.status = {};

        this._cls_info.dispOptions.body.status.f_rtrcn_msg = true;
        this._cls_info.dispOptions.body.status.f_return_msg = true;
        this._cls_info.dispOptions.body.status.f_exchng_msg = true;
        this._cls_info.dispOptions.body.status.f_gds_exchng = true;
        this._cls_info.dispOptions.body.status.f_ordr_done = true;
        this._cls_info.dispOptions.body.status.f_partners_msg = true;
        

        this._cls_info.dispOptions.footer = {};
        this._cls_info.dispOptions.footer.f_ordr_rtrcn = true;/*주문취소 버튼*/
        this._cls_info.dispOptions.footer.f_ordr_return = true;/*반품신청 버튼*/
        

        // this._cls_info.queryString
    }

    fn_draw_delelte_items(arrOrigin, arrIndexes){
		var dfor, dlen;

		dlen = arrIndexes.length - 1;
		for(dfor=dlen ; dfor>=0 ; dfor--){
			arrOrigin.splice(arrIndexes[dfor], 1);/*이미 선택한 상품은 제외 한다.*/
		}
	}

    
    fn_ordred_list_filter_ordrcd(){
        if (this._cls_info.drawOrdredList == undefined || this._cls_info.drawOrdredList.length < 1){
            return null;
        }

        var ordrCd = this._cls_info.drawOrdredList[0].ordrCd;
        var entrpsNo = this._cls_info.drawOrdredList[0].entrpsNo;
        var arrIndexed = [];
        var ordredList;
        ordredList = this._cls_info.drawOrdredList.filter(function(item, idex) {
            if (item.ordrCd == ordrCd && item.entrpsNo == entrpsNo) {
                arrIndexed.push(idex);
                return true;
            }
        });

        if (ordredList.length == 0 && this._cls_info.drawOrdredList.length > 0){
            ordredList = this._cls_info.drawOrdredList.filter(function(item, idex) {
                if (item.ordrCd == ordrCd) {
                    arrIndexed.push(idex);
                    return true;
                }
            });
        }

        this.fn_draw_delelte_items(this._cls_info.drawOrdredList, arrIndexed);

        return ordredList;
    }

    fn_draw_empty(){
        var query = this._cls_info.jsCommon.fn_queryString_toMap(this._cls_info.queryString);
        var strHtml;
        var period;
        strHtml = '';

        if (query.selPeriod == '1') period = "최근 1주일간";
        else if (query.selPeriod == '2') period = "최근 한 달간";
        else if (query.selPeriod == '3') period = "최근 6개월간";
        else if (query.selPeriod == '4') period = "최근 1년간";
        else if (query.selPeriod == '9') period = "최근 5년간";
        else period = "검색하신 기간에";
        
        strHtml += '<p class="box-result">';
        strHtml +=  period + ' 주문 내역이 없습니다';
        strHtml += '</p>';

        return strHtml;
    }

    fn_draw_all_ordred_list(){
        var ordredList;
        var arrHtml = [];
		var strHtml;
        if (this._cls_info.drawOrdredList != undefined && this._cls_info.drawOrdredList.length > 0){
            while(this._cls_info.drawOrdredList != undefined && this._cls_info.drawOrdredList.length > 0){
                ordredList = this.fn_ordred_list_filter_ordrcd();
    
                strHtml = this.fn_draw_ordred_ordrcd(ordredList);
    
                arrHtml.push(strHtml);
            }
        }else{
            arrHtml.push(this.fn_draw_empty());
        }
        
        $(this._cls_info.pageOrdredListfix).html(arrHtml.join(''));
    }


    /*주문번호 하나씩 한다.*/
    fn_draw_ordred_ordrcd(ordredList){
        var strHtmlHeader = this.fn_draw_ordred_ordrcd_header(ordredList[0]);
        var strHtmlFooter = this.fn_draw_ordred_ordrcd_footer(ordredList[0]);

        var strHtmlAll = '<div class="order-product order-product-mypage">';

        strHtmlAll += strHtmlHeader;

        strHtmlAll += this.fn_draw_ordred_ordrcd_body_all(ordredList);

        strHtmlAll += strHtmlFooter;
        
        strHtmlAll += '</div>';
        return strHtmlAll;
    }

    fn_draw_ordred_ordrcd_header(ordredDtlJson){
        var strHtml = '';
        strHtml += '<div class="order-header">';
        strHtml +=      '<div class="flex flex-col w-full gap-3">';
        strHtml +=      '    <!--2023-12-27:사업소명-->';
        strHtml +=      '    <dl class="order-item-business">';
        strHtml +=      '        <dt><span></span> <span>{0}</span></dt>'.format((ordredDtlJson.entrpsVO == undefined)?"":ordredDtlJson.entrpsVO.entrpsStoreNm);
        strHtml +=      '    </dl>';
        strHtml +=      '    <!--//2023-12-27:사업소명-->';

        // strHtml +=      '    <c:if test="${ordrDtl.ordrTy eq 'R' || ordrDtl.ordrTy eq 'L'}">';
        // strHtml +=      '        <%-- 급여구매일 경우만 경우만 멤버스(사업소) 있음 --%>';
        // strHtml +=      '        <c:if test="${!empty ordrDtl.bplcInfo}">';
        // strHtml +=      '            <dl class="large">';
        // strHtml +=      '                <dt>멤버스</dt>';
        // strHtml +=      '                <dd>${ordrDtl.bplcInfo.bplcNm}</dd>';
        // strHtml +=      '            </dl>';
        // strHtml +=      '        </c:if>';
        // strHtml +=      '    </c:if>';

        strHtml +=      '    <div class="flex items-center w-full">';
        strHtml +=      '        <dl>';
        strHtml +=      '            <dt>주문번호</dt>';
        strHtml +=      '            <dd><strong><a href="./view/{0}?{1}">{0}</a></strong></dd>'.format(ordredDtlJson.ordrCd, location.search);
        strHtml +=      '        </dl>';
        strHtml +=      '        <dl>';
        strHtml +=      '            <dt>주문일시</dt>';//<%--주문/취소 --%>
        strHtml +=      '            <dd>{0}</dd>'.format((new Date(ordredDtlJson.ordrDt)).format("yyyy.MM.dd HH:mm:ss"));
        strHtml +=      '        </dl>';
        strHtml +=      '    </div>';
        strHtml +=      '</div>';
        strHtml += '</div>';

        return strHtml;
    }

    fn_draw_ordred_ordrcd_footer(ordredDtlJson){
        var strHtml = '';

        strHtml += '<div class="order-footer">';

        if (this._cls_info.dispOptions.footer.f_ordr_rtrcn){
            if (ordredDtlJson.cancelBtn != undefined && ordredDtlJson.cancelBtn > 0){
                strHtml += '<button type="button" class="btn btn-outline-primary btn-small f_ordr_rtrcn" data-ordr-cd="{0}">주문취소</button>'.format(ordredDtlJson.ordrCd);
            }
        }
        if (this._cls_info.dispOptions.footer.f_ordr_return){
            if (ordredDtlJson.returnBtn != undefined && ordredDtlJson.returnBtn > 0){
                strHtml += '<button type="button" class="btn btn-outline-primary btn-small f_ordr_return" data-ordr-cd="{0}">반품신청</button>'.format(ordredDtlJson.ordrCd);
            }
        }
        

        strHtml += '</div>';
        return strHtml;
    }

    /*주문번호별 사업소별 데이터*/
    fn_draw_ordred_ordrcd_body_all(ordredDtlList){
        var ifor;
        var arrList = [];
        var strHtml;
        var filteredOrdrDtlAdit, filteredOrdrDtlBases, filteredGdsExists;
        var arrIndexed;
        var dlvyGroupYn, entrpsDlvygrpNo, ordrDtlCd;

        var gdsNoDlvyAmt = {};/*상품별 배송비 합을 구한다.(같은 주문에 같은 상품은 배송비를 한번만 한다)*/
        ordredDtlList.forEach((element) => {
            if (gdsNoDlvyAmt[element.gdsNo] == undefined) gdsNoDlvyAmt[element.gdsNo] = 0;

            gdsNoDlvyAmt[element.gdsNo] += element.dlvyBassAmt;
        });

        while(ordredDtlList.length > 0){
            ifor = 0;
            dlvyGroupYn = ordredDtlList[ifor].dlvyGroupYn;
            entrpsDlvygrpNo = ordredDtlList[ifor].entrpsDlvygrpNo;
            ordrDtlCd = ordredDtlList[ifor].ordrDtlCd;

            arrIndexed = [];
            /*묶음배송일 경우*/
            if (dlvyGroupYn == 'Y' && entrpsDlvygrpNo > 0){
                filteredOrdrDtlBases = ordredDtlList.filter(function(item, idex) {
                    if (item.dlvyGroupYn == dlvyGroupYn && item.entrpsDlvygrpNo == entrpsDlvygrpNo) {
                        arrIndexed.push(idex);
                        return true;
                    }
                });
                this.fn_draw_delelte_items(ordredDtlList, arrIndexed);

                arrIndexed = this.fn_draw_ordred_ordrcd_dlvygrp_all(filteredOrdrDtlBases);
                arrList = arrList.concat(arrIndexed);
            }else{/*개별배송일 경우*/
                filteredOrdrDtlBases = ordredDtlList.filter(function(item, idex) {
                    if (item.ordrDtlCd == ordrDtlCd && item.ordrOptnTy == 'BASE') {
                        arrIndexed.push(idex);
                        return true;
                    }
                });
                filteredOrdrDtlAdit = ordredDtlList.filter(function(item, idex) {
                    if (item.ordrDtlCd == ordrDtlCd && item.ordrOptnTy == 'ADIT') {
                        arrIndexed.push(idex);
                        return true;
                    }
                });

                this.fn_draw_delelte_items(ordredDtlList, arrIndexed);

                filteredGdsExists = ordredDtlList.filter(function(item, idex) {
                    if (item.gdsNo == filteredOrdrDtlBases[0].gdsNo) {
                        arrIndexed.push(idex);
                        return true;
                    }
                });

                // console.log(filteredOrdrDtlBases, filteredOrdrDtlAdit);

                strHtml = this.fn_draw_ordred_ordrcd_body_one_all(filteredOrdrDtlBases, filteredOrdrDtlAdit);
                arrList.push(strHtml);

                if (filteredGdsExists.length == 0){/*남은 상품이 없는 경우에만 배송비를 표시한다.*/
                    strHtml = this.fn_draw_ordred_ordrcd_delivery_summary_each(filteredOrdrDtlBases, gdsNoDlvyAmt[filteredOrdrDtlBases[0].gdsNo]);
                    arrList.push(strHtml);
                }
                
            }
            
        }
        
        strHtml = '';
        strHtml += '<div class="order-body">';
        strHtml +=      '<div class="order-buyer"></div>';
        strHtml +=          arrList.join('');
        strHtml +=  '</div>';
		
        return strHtml;
    }

    /*묶음배송 전체(entrpsDlvygrpNo별)*/
    fn_draw_ordred_ordrcd_dlvygrp_all(filteredOrdrDtls){
        var filteredOrdrDtlBases, filteredOrdrDtlAdit;
        var arrIndexed;
        var ordrDtlCd, strHtml;
        var arrGrp = [];
        
        var strDlvy = this.fn_draw_ordred_ordrcd_delivery_summary_grp(filteredOrdrDtls);

        while(filteredOrdrDtls.length > 0){
            ordrDtlCd = filteredOrdrDtls[0].ordrDtlCd;
            arrIndexed = [];

            filteredOrdrDtlBases = filteredOrdrDtls.filter(function(item, idex) {
                if (item.ordrDtlCd == ordrDtlCd && item.ordrOptnTy == 'BASE') {
                    arrIndexed.push(idex);
                    return true;
                }
            });
            filteredOrdrDtlAdit = filteredOrdrDtls.filter(function(item, idex) {
                if (item.ordrDtlCd == ordrDtlCd && item.ordrOptnTy == 'ADIT') {
                    arrIndexed.push(idex);
                    return true;
                }
            });
            this.fn_draw_delelte_items(filteredOrdrDtls, arrIndexed);

            // console.log(filteredOrdrDtlBases, filteredOrdrDtlAdit);

            strHtml = this.fn_draw_ordred_ordrcd_body_one_all(filteredOrdrDtlBases, filteredOrdrDtlAdit);
            arrGrp.push(strHtml);
        }

        arrGrp.push(strDlvy);

        return arrGrp;
    }

    /**/
    fn_draw_ordred_ordrcd_body_one_all(filteredOrdrDtlBases, filteredOrdrDtlAdit){
        var strHtml = '';

        strHtml += '<div class="order-item order-item-mypage">';
        strHtml +=      this.fn_draw_ordred_ordrcd_body_one_thumbnail(filteredOrdrDtlBases);

        strHtml +=      this.fn_draw_ordred_ordrcd_body_one_content(filteredOrdrDtlBases, filteredOrdrDtlAdit);
        
        strHtml += '</div>';

        return strHtml;
    }
    
    fn_draw_ordred_ordrcd_body_one_thumbnail(filteredOrdrDtlBases){
        var ordredDtlJson = filteredOrdrDtlBases[0];

        var strHtml = '';
        var thumbnailFile = "/html/page/market/assets/images/noimg.png";
		if (ordredDtlJson.gdsInfo.thumbnailFile != undefined){
			thumbnailFile = "/comm/getImage?srvcId=GDS&amp;upNo=" + ordredDtlJson.gdsInfo.thumbnailFile.upNo +"&amp;fileTy="+ordredDtlJson.gdsInfo.thumbnailFile.fileTy +"&amp;fileNo="+ordredDtlJson.gdsInfo.thumbnailFile.fileNo +"&amp;thumbYn=Y";
		}
        strHtml += '<div class="order-item-thumb">'
        strHtml +=     '<img src="{0}" alt="">'.format(thumbnailFile);
        strHtml += '</div>';

        return strHtml;
    }

    fn_draw_ordred_ordrcd_body_one_content_optn_base(ordrOptn){
        var list = ordrOptn.split(" * ");
        var txtOptn = '';

        if (ordrOptn.length > 0){
            txtOptn += '<dl class="option">';
            list.forEach((element) => {
                txtOptn += '    <dd>';
                txtOptn += '        <span class="label-flat">{0}</span>'.format(element);
                txtOptn += '    </dd>';
            });
            txtOptn += '</dl>';
        }
        

        return txtOptn;
    }
    fn_draw_ordred_ordrcd_body_one_content_optn_adit(filteredOrdrDtlAdit){
        var strTemp, strHtml = '';
        var arrList = [];

        var ifor, ilen = filteredOrdrDtlAdit.length;
        for(ifor=0 ; ifor<ilen; ifor++){
            var aditOptnOne = filteredOrdrDtlAdit[ifor];
            var optnNm = aditOptnOne.ordrOptn.split("*");

            strTemp = '';
            strTemp += '<div class="item-add">';
            strTemp += '    <dd class="item-add-one ">';
            strTemp += '        <span class="label-outline-primary">';
            strTemp += '            <span>{0}</span>'.format(optnNm[0].trim());
            strTemp += '            <i><img src="/html/page/market/assets/images/ico-plus-white.svg" alt=""></i></span>';
            strTemp += '        </span>';
            strTemp += '        <div class="name">';
            strTemp += '            <span class="font-semibold">{0}</span>'.format(optnNm[1].trim());
            strTemp += '            <span class="font-semibold">{0}개</span>'.format(aditOptnOne.ordrQy);
            strTemp += '            <span>(+{0}원)</span>'.format((aditOptnOne.ordrOptnPc * aditOptnOne.ordrQy).format_money())
            strTemp += '        </div>';
            strTemp += '    </dd>';
            strTemp += '</div>';

            arrList.push(strTemp);
        }
        

        if (arrList != undefined && arrList.length > 0){
            strHtml += '<div class="item-add-box">';
            strHtml += arrList.join('');
            strHtml += '</div>';
        }
        

        return strHtml;
    }

    fn_draw_ordred_ordrcd_body_one_content(filteredOrdrDtlBases, filteredOrdrDtlAdit){
        var ordredDtlJson = filteredOrdrDtlBases[0];

        var txtOptnBase = '', txtOptnAdit = '';
        if (ordredDtlJson.ordrOptn != undefined && ordredDtlJson.ordrOptn.length > 0){
            txtOptnBase = this.fn_draw_ordred_ordrcd_body_one_content_optn_base(ordredDtlJson.ordrOptn);
        }
        if (filteredOrdrDtlAdit != undefined && filteredOrdrDtlAdit.length > 0){
            txtOptnAdit = this.fn_draw_ordred_ordrcd_body_one_content_optn_adit(filteredOrdrDtlAdit);
        }

        var strHtml = '';
        strHtml += '<div class="order-item-content">';
        strHtml +=      '<div class="flex items-start w-full order-item-content-body">';
        strHtml +=          '<div class="order-item-group">';
        strHtml +=              '<div class="order-item-base">';
        strHtml +=                  '<p class="code">';
        strHtml +=                      '<span class="label-primary">';
        strHtml +=                          '<span>{0}</span>'.format(this._cls_info.codeMapJson.gdsTyCode[ordredDtlJson.gdsInfo.gdsTy]);
        strHtml +=                          '<i></i>';
        strHtml +=                      '</span>';
        strHtml +=                      '<u>{0}</u>'.format(ordredDtlJson.gdsCd);
        strHtml +=                  '</p>';
        strHtml +=                  '<div class="product">';
        strHtml +=                      '<p class="name">{0}</p>'.format(ordredDtlJson.gdsNm);
        strHtml +=                      txtOptnBase;
        strHtml +=                      txtOptnAdit;
        strHtml +=                  '</div>';
        strHtml +=              '</div>';
        strHtml +=          '</div>';
        strHtml +=          '<div class="order-item-count">';
        strHtml +=              '<p><strong>{0}</strong>개</p>'.format(ordredDtlJson.ordrQy);
        strHtml +=          '</div>';
        strHtml +=          '<p class="order-item-price"><span class="text-primary">{0}원</span></p>'.format((ordredDtlJson.ordrPc + ordredDtlJson.ordrOptnPc).format_money());
        strHtml +=      '</div>';
        strHtml +=      '<div class="order-item-info">';
        strHtml +=          '<div class="status">';
        strHtml +=              this.fn_draw_ordred_ordrcd_body_one_content_status(ordredDtlJson.sttsTy, ordredDtlJson);
        strHtml +=          '</div>';
        strHtml +=      '</div>';
        strHtml += '</div>';

        return strHtml;
    }

    fn_draw_ordred_ordrcd_body_one_content_status(sttsTy, ordredDtlJson){
        var strHtml = '';
        
        switch(sttsTy){
            case "OR02":
                strHtml += '<div class="box-gradient">';
                strHtml += '    <div class="content">';
                strHtml += '        <p class="flex-1">멤버스<br> 승인완료</p>';
                strHtml += '        <div class="multibtn">';
                strHtml += '            <a href="./view/{0}?{1}" class="btn btn-primary btn-small">결제진행</a>'.format(ordredDtlJson.ordrCd, location.search);
                strHtml += '        </div>';
                strHtml += '    </div>';
                strHtml += '</div>';
                break
            case "OR03":
                strHtml += '<div class="box-gradient">';
                strHtml +=      '<div class="content">';
                strHtml +=          '<p class="flex-1">멤버스<br> 승인반려</p>';
                strHtml +=          '<div class="multibtn">';
                if (this._cls_info.dispOptions.body.status.f_partners_msg){
                    strHtml +=              '<button type="button" class="btn btn-primary btn-small f_partners_msg" data-ordr-no="{0}" data-dtl-no="{1}">사유확인</button>'.format(ordredDtlJson.ordrNo, ordredDtlJson.ordrDtlNo);
                }
                strHtml +=          '</div>';
                strHtml +=      '</div>';
                strHtml += '</div>';
                break
            case "OR04":
                strHtml += '<div class="box-gray">';
                strHtml += '    <p class="flex-1">결제대기</p>';
                if (ordredDtlJson.ordrTy == 'R'){
                    strHtml += '<div class="multibtn">';
                    strHtml += '    <a href="./view/{0}?{1}" class="btn btn-primary btn-small">결제진행</a>'.format(ordredDtlJson.ordrCd, location.search);
                    // strHtml += '    <%-- <button type="button" class="btn btn-outline-primary btn-small f_ordr_rtrcn" data-ordr-cd="${ordrDtl.ordrCd}">주문취소</button> --%>';
                    strHtml += '</div>';
                }
                
                strHtml += '</div>';
                break
            case "OR05":
                strHtml += '<div class="box-gray">'
                strHtml += '    <p class="flex-1">결제완료</p>'
                // strHtml += '    <%-- <div class="multibtn">'
                // strHtml += '        <button type="button" class="btn btn-outline-primary btn-small f_ordr_rtrcn" data-ordr-cd="${ordrDtl.ordrCd}">주문취소</button>'
                // strHtml += '    </div> --%>'
                strHtml += '</div>'
                
                break;
            case "OR07":
                strHtml += '<dl>'
                strHtml += '    <dt>배송중</dt>'
                strHtml += '    <dd>{0}</dd>'.format(new Date(ordredDtlJson.sndngDt).format("yyyy-MM-dd"))
                strHtml += '</dl>'

                var arrTemp = this._cls_info.codeMapJson.dlvyCoList.filter(function(item, idex) {
                    if (item.coNo == ordredDtlJson.dlvyCoNo) {
                        return true;
                    }
                });

                if (arrTemp != undefined && arrTemp.length > 0){
                    strHtml += '<a href="{0}{1}" target="_blank" class="btn btn-delivery">'.format(arrTemp[0].dlvyUrl, ordredDtlJson.dlvyInvcNo);
                    strHtml += '    <span class="name">';
                    strHtml += '        <img src="/html/page/market/assets/images/ico-delivery.svg" alt="">';
                    strHtml += '        {0}'.format(arrTemp[0].dlvyCoNm);
                    strHtml += '    </span>';
                    strHtml += '    <span class="underline">{0}</span>'.format(ordredDtlJson.dlvyInvcNo);
                    strHtml += '</a>';
                }
                break;
            case "OR08":
                strHtml += '<div class="box-gray">';
                strHtml += '    <p class="flex-1">배송완료</p>';
                strHtml += '    <div class="multibtn">';
                if (this._cls_info.dispOptions.body.status.f_ordr_done){
                    strHtml += '        <button type="button" class="btn btn-primary btn-small f_ordr_done" data-ordr-no="{0}" data-dtl-cd="{1}" data-stts-ty="OR09" data-resn-ty="", data-resn="상품 구매확정" data-msg="마일리지가 적립됩니다.구매확정 처리하시겠습니까?">구매확정</button>'.format(ordredDtlJson.ordrNo, ordredDtlJson.ordrCd);
                }
                if (this._cls_info.dispOptions.body.status.f_gds_exchng){
                    strHtml += '        <button type="button" class="btn btn-outline-primary btn-small f_gds_exchng" data-dtl-cd="{1}" data-ordr-no="{0}" >교환신청</button>'.format(ordredDtlJson.ordrNo, ordredDtlJson.ordrDtlCd);    
                }
                strHtml += '    </div>';
                strHtml += '</div>';
                break;
            case "CA01"://<%-- 취소접수 & 취소완료 --%>
            case "CA02":
                strHtml += '<div class="box-gray">';
                strHtml += '    <p class="flex-1">{0}</p>'.format(this._cls_info.codeMapJson.ordrSttsCode[ordredDtlJson.sttsTy]);
                strHtml += '    <div class="multibtn">';
                if (this._cls_info.dispOptions.body.status.f_rtrcn_msg){
                    strHtml += '        <button type="button" class="btn btn-primary btn-small f_rtrcn_msg" data-ordr-no="{0}" data-dtl-no="{1}" data-dtl-cd="{2}">취소 상세정보</button>'.format(ordredDtlJson.ordrNo, ordredDtlJson.ordrDtlNo, ordredDtlJson.ordrDtlCd);
                }
                
                strHtml += '    </div>';
                strHtml += '</div>';
                break;
            case "EX01"://<%-- 교환 --%>
            case "EX02":
            case "EX03":
                strHtml += '<div class="box-gray">';
                strHtml += '    <p class="flex-1">{0}</p>'.format(this._cls_info.codeMapJson.ordrSttsCode[ordredDtlJson.sttsTy]);
                strHtml += '    <div class="multibtn">';
                if (this._cls_info.dispOptions.body.status.f_exchng_msg){
                    strHtml += '        <button type="button" class="btn btn-primary btn-small f_exchng_msg" data-ordr-no="{0}" data-dtl-no="{1}" data-dtl-cd="{2}">교환 상세정보</button>'.format(ordredDtlJson.ordrNo, ordredDtlJson.ordrDtlNo, ordredDtlJson.ordrDtlCd);
                }
                
                strHtml += '    </div>';
                strHtml += '</div>';
                break;
                
            case "RE01"://<%-- 반품 --%>
            case "RE02":
            case "RE03":
                strHtml += '<div class="box-gray">';
                strHtml += '    <p class="flex-1">{0}</p>'.format(this._cls_info.codeMapJson.ordrSttsCode[ordredDtlJson.sttsTy]);
                strHtml += '    <div class="multibtn">';
                if (this._cls_info.dispOptions.body.status.f_return_msg){
                    strHtml += '        <button type="button" class="btn btn-primary btn-small f_return_msg" data-ordr-no="{0}" data-dtl-no="{1}" data-dtl-cd="{2}">반품 상세정보</button>'.format(ordredDtlJson.ordrNo, ordredDtlJson.ordrDtlNo, ordredDtlJson.ordrDtlCd);
                }
                strHtml += '    </div>';
                strHtml += '</div>';
                break;
            default:
                strHtml += '<div class="box-gray">';
                strHtml += '    <p class="flex-1">{0}</p>'.format(this._cls_info.codeMapJson.ordrSttsCode[ordredDtlJson.sttsTy]);
                strHtml += '</div>';
                break;
        }

        return strHtml;
    }

    fn_draw_ordred_ordrcd_delivery_summary_each(ordredDtlList, dlvyBassAmt){
        var bassStlmTyNm = '', strHtml = '';

        if (dlvyBassAmt == 0){
            bassStlmTyNm = this._cls_info.codeMapJson.bassStlmTyCode['FREE'];
        }else{
            bassStlmTyNm = dlvyBassAmt.format_money() + '원';
        }

        strHtml += '<div class="payment">'
        strHtml += '    <dl class="order-item-payment">'
        strHtml += '        <dd>배송비</dd>'
        strHtml += '        <dt class="delivery-charge">{0}</dt>'.format(bassStlmTyNm)
        strHtml += '    </dl>'
        strHtml += '</div>'

        return strHtml;
    }

    fn_draw_ordred_ordrcd_delivery_summary_grp(ordredDtlList){
        var bassStlmTyNm = '', strHtml = '';

        var dlvyBassAmt = 0;
        ordredDtlList.forEach((element) => {
            dlvyBassAmt += element.dlvyBassAmt;
        });

        if (dlvyBassAmt == 0){
            bassStlmTyNm = this._cls_info.codeMapJson.bassStlmTyCode['FREE'];
        }else{
            bassStlmTyNm = dlvyBassAmt.format_money() + '원';
        }

        strHtml += '<div class="payment">'
        strHtml += '    <dl class="order-item-payment">'
        strHtml += '        <dd>배송비(묶음배송)</dd>'
        strHtml += '        <dt class="delivery-charge">{0}</dt>'.format(bassStlmTyNm)
        strHtml += '    </dl>'
        strHtml += '</div>'

        return strHtml;
    }
}