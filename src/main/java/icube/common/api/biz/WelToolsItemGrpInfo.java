package icube.common.api.biz;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.List;
import java.util.Map;

import org.egovframe.rte.fdl.string.EgovStringUtil;
import org.json.simple.JSONObject;

import icube.common.values.CodeList;


public class WelToolsItemGrpInfo {
    private String itemGrpCd;	// 복지용구 그룹 코드
    // private String itemGrpNm;	// 복지용구 그룹 명
    // private String itemGrpDisp;	// 복지용구 그룹 표시명
    private String saleKind;//"판매, 대여 구분"
    private String persistPeriodKind; // 복지용구를 구매 종류==> dayOne(몇년에 하나), dayCnt(몇년에 여러개), period(적용구간에 몇개), rent(대여)  중 하나
    private int persistPeriodYear;//구매 종류별 연도
    private int persistPeriodCnt;//신청 가능한 숫자

    private String ableYn;/*수급자별 사용가능 여부*/

    private String persistPeriodDtFr;/*날짜*/
    private String persistPeriodDtTo;/*날짜*/

    private String applyDtFr;/*적용구간*/
    private String applyDtTo;/*적용구간*/
//    private String peroidDtFr;/*인정기간*/
//    private String peroidDtTo;/*인정기간*/

    private int usedPersistPeriodCnt;/*사용한 갯수(내구연한, 대여기간 확인)*/
    private int usedAmt;/*사용한 금액()*/


    // private List<String> itemsContract;// 취소를 제외한 모든 아이템의 항목들
    private List<String> ItemsAble;//취소,구매 종류별로 기한내의 중복항목 제외 한 아이템들
    private List<String> usedCd;
    
    private String itemGrpNm;

    public WelToolsItemGrpInfo(String itemGrpCd, String persistPeriodKind, int persistPeriodYear, int persistPeriodCnt
        , String peroidDtFr, String peroidDtTo, String applyDtFr, String applyDtTo){
        
    	this.ableYn = "Y";
    	this.usedAmt = 0;
    	
    	int idx = CodeList.WELTOOLS_ITEMGRP_CDS.indexOf(itemGrpCd);
    	
    	itemGrpNm = CodeList.WELTOOLS_ITEMGRP_NM_DISP.get(idx);

        this.itemGrpCd = itemGrpCd;
        // this.itemGrpNm = itemGrpNm;
        // this.itemGrpDisp = itemGrpDisp;
        this.persistPeriodKind = persistPeriodKind;
        this.persistPeriodYear = persistPeriodYear;
        this.persistPeriodCnt = persistPeriodCnt;

        this.applyDtFr = applyDtFr;
        this.applyDtTo = applyDtTo;
//        this.peroidDtFr = peroidDtFr;
//        this.peroidDtTo = peroidDtTo;

        this.ItemsAble = new ArrayList<String>();
        this.usedCd = new ArrayList<String>();

        
        if (EgovStringUtil.equals("period", this.persistPeriodKind)){
        	this.saleKind = "S";
            this.persistPeriodDtFr = this.applyDtFr;
            this.persistPeriodDtTo = this.applyDtTo;
        }else{
        	
            Date now = new Date();
            SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");

            if (EgovStringUtil.equals("rent", this.persistPeriodKind)){
            	this.saleKind = "R";
                this.persistPeriodDtTo = this.persistPeriodDtFr = format.format(now);/*현재 날짜와 비교*/
                
            } else if (EgovStringUtil.equals("dayOne", this.persistPeriodKind) || EgovStringUtil.equals("dayCnt", this.persistPeriodKind)){
            	this.saleKind = "S";
                this.persistPeriodDtTo = format.format(now);/*마지막 날짜*/

                Calendar cal = Calendar.getInstance();
                cal.setTime(now);

                cal.add(Calendar.YEAR, -1 * this.persistPeriodYear);		//년 더하기

                this.persistPeriodDtFr = format.format(cal.getTime());/*시작 날짜*/
            }
        }
        
    }


    public void addItem(Map<String, Object> dsResult){
    	if (!EgovStringUtil.equals("Y", ableYn)) {
    		return;
    	}
        String cnclYn = (String) dsResult.get("CNCL_YN");
        
        if(EgovStringUtil.equals("취소",cnclYn)) {
            return;    
        }

        String itemDtTo, itemDtFr = (String) dsResult.get("POF_FR_DT");
        boolean bAble = true;
        
        if (EgovStringUtil.equals("rent", this.persistPeriodKind)){/* 대여일 경우 기간 산정해서 적용여부*/
            itemDtTo = itemDtFr.substring(itemDtFr.indexOf("~") + 1);
            itemDtFr = itemDtFr.substring(0, itemDtFr.indexOf("~"));

            if (itemDtTo.compareTo(this.persistPeriodDtFr) < 0 || itemDtFr.compareTo(this.persistPeriodDtFr) > 0){
                bAble = false;
            }
        }else{/* 판매일 경우 기간에 산정해서 적용여부 */
        	itemDtTo = itemDtFr;
            if (itemDtFr.compareTo(this.persistPeriodDtFr) < 0 || itemDtFr.compareTo(this.persistPeriodDtTo) > 0){
                bAble = false;
            }
        }

        if (bAble){
        	usedPersistPeriodCnt += 1;
        	this.usedCd.add(this.itemGrpCd);/*2023-11-01 현재 취소만 아니면*/
        }
        
        if (itemDtTo.compareTo(this.applyDtTo) <= 0 && itemDtFr.compareTo(this.applyDtFr) >= 0){
        	this.usedAmt += EgovStringUtil.string2integer((String) dsResult.get("TOT_AMT"));
        }
        
    }
    
    
    public void setAble(String val){/*사용가능 여부*/
    	this.ableYn = val;
    }
    
    public int getAbleCnt(){/*적용기간 내 구개/대여 가능한 갯수*/
    	if (this.usedPersistPeriodCnt > this.persistPeriodCnt) {
    		return 0;
    	}else {
    		return this.persistPeriodCnt - this.usedPersistPeriodCnt;
    	}
    }
    
    public String getAble(){/*사용가능 여부*/
    	return this.ableYn;
    }
    
    public int getUsedAmt(){/*적용기간 내 사용한 금액*/
    	return this.usedAmt;
    }
    
    public int getUsedPersistPeriodCnt(){/*기간내 사용한 갯수*/
    	return this.usedPersistPeriodCnt;
    }
    
    
    public String getItemGrpCd(){
    	return this.itemGrpCd;
    }
    
    public String getSaleKind(){
    	return this.saleKind;
    }

    public JSONObject getResult() {
        return this.getResult(this.getAbleCnt());
    }
    public JSONObject getResultNone() {
        return this.getResult(0);
    }
    protected JSONObject getResult(int ableCnt) {

        JSONObject jsonObject = new JSONObject();

        jsonObject.put("ableYn", this.ableYn);
        jsonObject.put("saleKind", this.saleKind);
        jsonObject.put("itemGrpCd", this.itemGrpCd);
        jsonObject.put("itemGrpNm", this.itemGrpNm);
        
        jsonObject.put("persistPeriodCnt", this.persistPeriodCnt);

        jsonObject.put("ableCnt", ableCnt);

        return jsonObject;
    }
    
    public List<String> getResultIcube() {
    	List<String> list = new ArrayList<>();
    	
    	if (this.usedPersistPeriodCnt < 1) {
    		return list;	
    	}
    	
    	String itemGrpCd = this.itemGrpCd;
    	
    	// if (EgovStringUtil.equals(itemGrpCd, "mattressS") || EgovStringUtil.equals(itemGrpCd, "mattressR") ) {
    	// 	itemGrpCd = "mattress";
    	// }else 
        if (EgovStringUtil.equals(itemGrpCd, "antiSlipSocks") ) {
    		itemGrpCd = "antiSlipProduct";
    	}
    	
    	
    	int ifor, ilen = this.usedPersistPeriodCnt;
    	for(ifor=0 ; ifor<ilen ; ifor++) {
    		list.add(itemGrpCd);
    	}
    	
    	return list;
    }
}
