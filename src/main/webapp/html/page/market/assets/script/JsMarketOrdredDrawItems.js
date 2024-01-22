class JsMarketOrdredDrawItems{
    constructor(){
        this._cls_info = this._cls_info || {};

		this._cls_info.bDev = true;
		
		this._cls_info.popups = {};
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
        var arrIndexed = [];
        var ordredList = this._cls_info.drawOrdredList.filter(function(item, idex) {
            if (item.ordrCd == ordrCd) {
                arrIndexed.push(idex);
                return true;
            }
        });

        this.fn_draw_delelte_items(this._cls_info.drawOrdredList, arrIndexed);

        return ordredList;
    }

    fn_draw_all_ordred_list(){
        var ordredList;
        var arrHtml = [];
		var strHtml;
        while(this._cls_info.drawOrdredList != undefined && this._cls_info.drawOrdredList.length > 0){
            ordredList = this.fn_ordred_list_filter_ordrcd();

            strHtml = this.fn_draw_ordred_ordrcd(ordredList);

            arrHtml.push(strHtml);
        }
        
        $(this._cls_info.pageOrdredListfix).html(arrHtml.join(''));
    }


    /*주문번호 하나씩 한다.*/
    fn_draw_ordred_ordrcd(ordredList){
        var strHtmlAll = '<div class="order-product order-product-mypage">';

        strHtmlAll += this.fn_draw_ordred_ordrcd_header(ordredList[0]);

        strHtmlAll += this.fn_draw_ordred_ordrcd_body_all(ordredList);

        strHtmlAll += this.fn_draw_ordred_ordrcd_footer(ordredList[0]);
        
        strHtmlAll += '</div>';
        return strHtmlAll;
    }

    fn_draw_ordred_ordrcd_header(ordredDtlJson){
        var strHtml = '';
        strHtml += '<div class="order-header">';
        strHtml +=      '<div class="flex flex-col w-full gap-3">';
        strHtml +=      '    <!--2023-12-27:사업소명-->';
        strHtml +=      '    <dl class="order-item-business">';
        strHtml +=      '        <dt><span>사업소</span> <span>{0}</span></dt>'.format(ordredDtlJson.entrpsVO.entrpsStoreNm);
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
        strHtml +=      '            <dd><strong><a href="./view/{0}?${pageParam}">{0}</a></strong></dd>'.format(ordredDtlJson.ordrCd);
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

        if (ordredDtlJson.cancelBtn != undefined && ordredDtlJson.cancelBtn > 0){
            strHtml += '<button type="button" class="btn btn-outline-primary btn-small f_ordr_rtrcn" data-ordr-cd="{0}">주문취소</button>'.format(ordredDtlJson.ordrCd);
        }
        if (ordredDtlJson.returnBtn != undefined && ordredDtlJson.returnBtn > 0){
            strHtml += '<button type="button" class="btn btn-outline-primary btn-small f_ordr_return" data-ordr-cd="{0}">반품신청</button>'.format(ordredDtlJson.ordrCd);
        }

        strHtml += '</div>';
        return strHtml;
    }

    
    fn_draw_ordred_ordrcd_body_all(ordredDtlList){
        var ifor, ilen = ordredDtlList.length;
        var arrList = [];
        var strHtml;


        
        for(ifor=0 ; ifor<ilen ; ifor++){
            strHtml =      this.fn_draw_ordred_ordrcd_body_one_all(ordredDtlList[ifor]);

            arrList.push(strHtml);
        }

        strHtml = '';
        strHtml += '<div class="order-body">';
        strHtml +=      '<div class="order-buyer"></div>';
        strHtml +=          arrList.join('');
        strHtml +=  '</div>';
		
        return strHtml;
    }

    fn_draw_ordred_ordrcd_body_one_all(ordredDtlJson){
        var strHtml = '';

        strHtml += '<div class="order-item order-item-mypage">';
        strHtml +=      this.fn_draw_ordred_ordrcd_body_one_thumbnail(ordredDtlJson);

        strHtml +=      this.fn_draw_ordred_ordrcd_body_one_content(ordredDtlJson);
        
        strHtml += '</div>';

        strHtml +=      this.fn_draw_ordred_ordrcd_dlvy(ordredDtlJson);
        
        return strHtml;
    }
    
    fn_draw_ordred_ordrcd_body_one_thumbnail(ordredDtlJson){
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

    fn_draw_ordred_ordrcd_body_one_content(ordredDtlJson){
        var strHtml = '';
        strHtml += '<div class="order-item-content">';
        strHtml +=      '<div class="flex items-start w-full">';
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
        strHtml +=                  '    <p class="name">{0}</p>'.format(ordredDtlJson.gdsNm);
        strHtml +=                  '</div>';
        strHtml +=              '</div>';
        strHtml +=          '</div>';
        strHtml +=          '<div class="order-item-count">';
        strHtml +=              '<p><strong>{0}</strong>개</p>'.format(ordredDtlJson.ordrQy);
        strHtml +=          '</div>';
        strHtml +=          '<p class="order-item-price"><span class="text-primary">5,500원</span></p>'.format((ordredDtlJson.ordrPc + ordredDtlJson.ordrOptnPc).format_money());
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
                strHtml += '            <a href="./view/{0}?${pageParam}" class="btn btn-primary btn-small">결제진행</a>'.format(ordredDtlJson.ordrCd);
                strHtml += '        </div>';
                strHtml += '    </div>';
                strHtml += '</div>';
                break
            case "OR03":
                strHtml += '<div class="box-gradient">';
                strHtml +=      '<div class="content">';
                strHtml +=          '<p class="flex-1">멤버스<br> 승인반려</p>';
                strHtml +=          '<div class="multibtn">';
                strHtml +=              '<button type="button" class="btn btn-primary btn-small f_partners_msg" data-ordr-no="{0}" data-dtl-no="{1}">사유확인</button>'.format(ordredDtlJson.ordrNo, ordredDtlJson.ordrDtlNo);
                strHtml +=          '</div>';
                strHtml +=      '</div>';
                strHtml += '</div>';
                break
            case "OR04":
                strHtml += '<div class="box-gray">';
                strHtml += '    <p class="flex-1">결제대기</p>';
                if (ordredDtlJson.ordrTy == 'R'){
                    strHtml += '<div class="multibtn">';
                    strHtml += '    <a href="./view/{0}?${pageParam}" class="btn btn-primary btn-small">결제진행</a>'.format(ordredDtlJson.ordrCd);
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
                strHtml += '    <dd>{0}</dd>'.format(ordredDtlJson.sndngDt.format("yyyy-MM-dd"))
                strHtml += '</dl>'

                // <c:set var="dlvyUrl" value="#" />
                // <c:forEach items="${dlvyCoList}" var="dlvyCoInfo">
                //     <c:if test="${dlvyCoInfo.coNo eq ordrDtl.dlvyCoNo}">
                //     <c:set var="dlvyUrl" value="${dlvyCoInfo.dlvyUrl}" />
                //     </c:if>
                // </c:forEach>

                // <a href="${dlvyUrl}${ordrDtl.dlvyInvcNo}" target="_blank" class="btn btn-delivery">
                //     <span class="name">
                //         <img src="/html/page/market/assets/images/ico-delivery.svg" alt="">
                //         ${ordrDtl.dlvyCoNm}
                //     </span>
                //     <span class="underline">${ordrDtl.dlvyInvcNo}</span>
                // </a>
                break;
            case "OR08":
                strHtml += '<div class="box-gray">';
                strHtml += '    <p class="flex-1">배송완료</p>';
                strHtml += '    <div class="multibtn">';
                strHtml += '        <button type="button" class="btn btn-primary btn-small f_ordr_done" data-ordr-no="{0}" data-dtl-cd="{1}" data-stts-ty="OR09" data-resn-ty="", data-resn="상품 구매확정" data-msg="마일리지가 적립됩니다.구매확정 처리하시겠습니까?">구매확정</button>'.format(ordredDtlJson.ordrNo, ordredDtlJson.ordrCd);
                strHtml += '        <button type="button" class="btn btn-outline-primary btn-small f_gds_exchng" data-dtl-cd="{1}" data-ordr-no="{0}" >교환신청</button>'.format(ordredDtlJson.ordrNo, ordredDtlJson.ordrDtlCd);
                strHtml += '    </div>';
                strHtml += '</div>';
                break;
            case "CA01"://<%-- 취소접수 & 취소완료 --%>
            case "CA02":
                strHtml += '<div class="box-gray">';
                strHtml += '    <p class="flex-1">{0}</p>'.format(this._cls_info.codeMapJson.ordrSttsCode[ordredDtlJson.sttsTy]);
                strHtml += '    <div class="multibtn">';
                strHtml += '        <button type="button" class="btn btn-primary btn-small f_rtrcn_msg" data-ordr-no="{0}" data-dtl-no="{1}" data-dtl-cd="{2}">취소 상세정보</button>'.format(ordredDtlJson.ordrNo, ordredDtlJson.ordrDtlNo, ordredDtlJson.ordrDtlCd);
                strHtml += '    </div>';
                strHtml += '</div>';
                break;
            case "EX01"://<%-- 교환 --%>
            case "EX02":
            case "EX03":
                strHtml += '<div class="box-gray">';
                strHtml += '    <p class="flex-1">{0}</p>'.format(this._cls_info.codeMapJson.ordrSttsCode[ordredDtlJson.sttsTy]);
                strHtml += '    <div class="multibtn">';
                strHtml += '        <button type="button" class="btn btn-primary btn-small f_exchng_msg" data-ordr-no="{0}" data-dtl-no="{1}" data-dtl-cd="{2}">교환 상세정보</button>'.format(ordredDtlJson.ordrNo, ordredDtlJson.ordrDtlNo, ordredDtlJson.ordrDtlCd);
                strHtml += '    </div>';
                strHtml += '</div>';
                break;
                
            case "RE01"://<%-- 반품 --%>
            case "RE02":
            case "RE03":
                strHtml += '<div class="box-gray">';
                strHtml += '    <p class="flex-1">{0}</p>'.format(this._cls_info.codeMapJson.ordrSttsCode[ordredDtlJson.sttsTy]);
                strHtml += '    <div class="multibtn">';
                strHtml += '        <button type="button" class="btn btn-primary btn-small f_return_msg" data-ordr-no="{0}" data-dtl-no="{1}" data-dtl-cd="{2}">반품 상세정보</button>'.format(ordredDtlJson.ordrNo, ordredDtlJson.ordrDtlNo, ordredDtlJson.ordrDtlCd);
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

    fn_draw_ordred_ordrcd_dlvy(ordredDtlJson){
        var bassStlmTyNm, strHtml = '';

        if (ordredDtlJson.dlvyBassAmt == 0){
            bassStlmTyNm = this._cls_info.codeMapJson.bassStlmTyCode['FREE'];
        }else{
            bassStlmTyNm = ordredDtlJson.dlvyBassAmt.format_money() + '원';
        }
        
        

        strHtml += '<div class="payment">'
        strHtml += '    <dl class="order-item-payment">'
        strHtml += '        <dd>배송비</dd>'
        strHtml += '        <dt class="delivery-charge">{0}</dt>'.format(bassStlmTyNm)
        strHtml += '    </dl>'
        strHtml += '</div>'

        return strHtml;
    }
}