package icube.common.api.biz;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.egovframe.rte.fdl.string.EgovStringUtil;

import icube.common.util.DateUtil;
import icube.common.util.JsonUtil;
import icube.common.values.CodeList;

public class WelToolsInfoParser {

	
	private JSONObject infoMap = null; /*{"QLF_TYPE":"3"
										,"LTC_RCGT_GRADE_CD":"1"					// 등급
										,"APDT_FR_DT":"20230329" 					// 적용구간 시작
										,"APDT_TO_DT":"20240328" 					// 적용구간 마지막
										,"LTC_MGMT_NO_SEQ":"109" 					// 인정기간의 순번
										,"RCGT_EDA_DT":"2023-07-15 ~ 2025-07-14"	// 인정기간
										,"RCGT_EDA_TO_DT":"20250714"				// 인정기간 시작
										,"RCGT_EDA_FR_DT":"20230715"				// 인정기간 마지막
										,"SELF_BND_RT":15 							// 본인부담율
										,"REDUCE_NM":"일반"							 // 
										,"SBA_CD":"일반" 							 // 일반, 의료급여, 기초 , 등등
										,"LTC_MGMT_NO":"L0011559991"				// L-번호
										,"LMT_AMT":"1600000"						// 한도
										,"REMN_AMT":"1298500"						// 남은 금액
										,"USE_AMT":"301500"							// 사용금액(현재 적용구간은 금액을 각 더해야 한다. 이거랑 안 맞음)
									}*/
	private String peroidDtFr;// 인정기간 시작 (2023-11-01)
	private String peroidDtTo;// 인정기간 마지막 (2023-11-01)
	private String applyDtFr;// 적용구간 마지막 (2023-11-01)
	private String applyDtTo;// 적용구간 시작 (2023-11-01)

	private HashMap<String, WelToolsItemGrpInfo>  weltoolsItemGrpList = null;
	
	public WelToolsInfoParser() {
	}

	public WelToolsInfoParser(String peroidDtFr, String peroidDtTo, String applyDtFr, String applyDtTo) {
		if (applyDtFr.length() == 8) {
			applyDtFr = applyDtFr.substring(0, 4) + "-" + applyDtFr.substring(4, 6) + "-" + applyDtFr.substring(6, 8);
		}
		if (applyDtTo.length() == 8) {
			applyDtTo = applyDtTo.substring(0, 4) + "-" + applyDtTo.substring(4, 6) + "-" + applyDtTo.substring(6, 8);
		}

		this.peroidDtFr = peroidDtFr;
		this.peroidDtTo = peroidDtTo;
		this.applyDtFr = applyDtFr;
		this.applyDtTo = applyDtTo;

		weltoolsItemGrpList = this.getWeltoolsItemGrpList(this.peroidDtFr, this.peroidDtTo, this.applyDtFr,  this.applyDtTo);
	}
	
	public List<String> getItemGrpAbleICube() throws Exception {
		if (weltoolsItemGrpList == null) {
			throw new Exception("not found weltoolsItemGrpList");
		}
		
		List<String> resultList = this.getItemGrpAbleICube("S", "Y");

		resultList.addAll(this.getItemGrpAbleICube("R", "Y"));

		return resultList;
	}
	
	public int getUsedAmt() throws Exception {
		if (weltoolsItemGrpList == null) {
			throw new Exception("not found weltoolsItemGrpList");
		}

		int usedAmt = 0;
		WelToolsItemGrpInfo itemGrpInfo;
	   	for (String itemGrpCd : weltoolsItemGrpList.keySet()) {
	   		
	   		if (EgovStringUtil.equals(itemGrpCd , "antiSlipSocks") || EgovStringUtil.equals(itemGrpCd , "mattressS")) { 
				/*미끄럼 방지용품, 욕창예방 매트리스(대여) 에서 처리*/
	   			continue;
	   		}
	   		
	   		itemGrpInfo = (WelToolsItemGrpInfo)(weltoolsItemGrpList.get(itemGrpCd));
	   		if (EgovStringUtil.equals("Y", itemGrpInfo.getAble())) {
	   			usedAmt += itemGrpInfo.getUsedAmt();
	   		}
	   		
	   	}

		return usedAmt;
	}
	public List<String> getItemGrpAbleICube(String saleKind, String ableYn)throws Exception {
		if (weltoolsItemGrpList == null) {
			throw new Exception("not found weltoolsItemGrpList");
		}
		
		WelToolsItemGrpInfo itemGrpInfo;
		List<String> resultList = new ArrayList<>();
	   	for (String itemGrpCd : weltoolsItemGrpList.keySet()) {
	   		
	   		if (EgovStringUtil.equals(itemGrpCd , "antiSlipSocks") || EgovStringUtil.equals(itemGrpCd , "mattressS")) { /*미끄럼 방지용품, 욕창예방 매트리스(대여) 에서 처리*/
	   			continue;
	   		}
	   		itemGrpInfo = (WelToolsItemGrpInfo)(weltoolsItemGrpList.get(itemGrpCd));
	   		
	   		// System.out.print(itemGrpCd+"\n");
	   		
	   		if (EgovStringUtil.equals(itemGrpInfo.getSaleKind(), saleKind) && EgovStringUtil.equals(itemGrpInfo.getAble(), ableYn)) {
	   			if (EgovStringUtil.equals(itemGrpCd , "mattressR")) {
	   				resultList.add("mattress");
	   			}else {
	   				resultList.add(itemGrpInfo.getItemGrpCd());
	   			}
	   				
	   		}
	   	}
	   	 
//	   	System.out.println("@@ resultList " + saleKind + " : " + resultList);

		return resultList;
	}
	
	public List<String> getItemGrpAble() throws Exception {
		if (weltoolsItemGrpList == null) {
			throw new Exception("not found weltoolsItemGrpList");
		}
		
		List<String> resultList = this.getItemGrpAble("S", "Y");

		resultList.addAll(this.getItemGrpAble("R", "Y"));

		return resultList;
	}
	public List<String> getItemGrpAble(String saleKind, String ableYn) throws Exception {
		if (weltoolsItemGrpList == null) {
			throw new Exception("not found weltoolsItemGrpList");
		}
		
		WelToolsItemGrpInfo itemGrpInfo;
		List<String> resultList = new ArrayList<>();
	   	for (String itemGrpCd : weltoolsItemGrpList.keySet()) {
	   		itemGrpInfo = (WelToolsItemGrpInfo)(weltoolsItemGrpList.get(itemGrpCd));
	   		
	   		if (EgovStringUtil.equals(itemGrpInfo.getSaleKind(), saleKind) && EgovStringUtil.equals(itemGrpInfo.getAble(), ableYn)) {
	   			resultList.add(itemGrpInfo.getItemGrpCd());	
	   		}
	   	}
	   	 
//	   	System.out.println("@@ resultList " + saleKind + " : " + resultList);

		return resultList;
	}
	
	public boolean setContractInfoParse(String responseStr) throws Exception{

		boolean bBool = this.setContractInfoParsing(responseStr);

		if (!bBool){
			return bBool;
		}

		String sTemp;
		sTemp = (String) this.infoMap.get("APDT_FR_DT");//:"20230329" 					// 적용구간 시작
		if (sTemp.length() == 8) sTemp = this.date8To10(sTemp);
		this.applyDtFr = sTemp;

		sTemp = (String) this.infoMap.get("APDT_TO_DT");//:"20240328" 					// 적용구간 마지막
		if (sTemp.length() == 8) sTemp = this.date8To10(sTemp);
		this.applyDtTo = sTemp;

		sTemp = (String) this.infoMap.get("RCGT_EDA_FR_DT");//:"20250714"				// 인정기간 시작
		if (sTemp.length() == 8) sTemp = this.date8To10(sTemp);
		this.peroidDtFr = sTemp;

		sTemp = (String) this.infoMap.get("RCGT_EDA_TO_DT");//:"20230715"				// 인정기간 마지막
		if (sTemp.length() == 8) sTemp = this.date8To10(sTemp);
		this.peroidDtTo = sTemp;

		weltoolsItemGrpList = this.getWeltoolsItemGrpList(this.peroidDtFr, this.peroidDtTo, this.applyDtFr,  this.applyDtTo);

		return bBool;
	}

	protected boolean setContractInfoParsing(String responseStr) throws Exception{
		String methodName = Thread.currentThread().getStackTrace()[1].getMethodName();
		
		boolean bResult = false;

		JSONParser jsonParser = new JSONParser();
		Object obj = jsonParser.parse(responseStr);

		JSONObject jsonObject = new JSONObject((Map<String, Object>) obj);

		String Status = (String) jsonObject.get("Status");
		if(!EgovStringUtil.equals("OK", Status)) { // 정상
			return bResult;
		}

		
		JSONObject resultData = (JSONObject) jsonObject.get("Result");
		if (resultData == null){
			return bResult;
		}

		JSONArray welToolTgtList = (JSONArray) resultData.get("ds_welToolTgtList");/*현재 사용자의 기본 정보*/
		JSONArray toolPayLmtList = (JSONArray) resultData.get("ds_toolPayLmtList");/*적용구간 리스트*/
		// JSONArray toolPayLmtList = (JSONArray) resultData.get("ds_Result");/*공급자(사업소) 정보*/
		JSONArray welToolTgtHistList = (JSONArray) resultData.get("ds_welToolTgtHistList");/*인정기간 리스트*/
		if(welToolTgtList == null || welToolTgtList.size() < 1 
			|| toolPayLmtList == null || toolPayLmtList.size() < 1
			|| welToolTgtHistList == null || welToolTgtHistList.size() < 1 ) {
			return bResult;
		}

		bResult = true;
		this.infoMap = new JSONObject();

		/******************************수급자의 일반 사항****************************************/
		List<Map<String, Object>> welToolTgtListMap =  JsonUtil.getListMapFromJsonArray(welToolTgtList);
		for(Map<String, Object> welToolTgt : welToolTgtListMap) {
			String reduceNm = (String) welToolTgt.get("REDUCE_NM");/* 본인부담율  */
			String sbaCd = (String) welToolTgt.get("SBA_CD");/*본인부담율 - 감면*/
			int selfBndRt  = 0;

			//let penPayRate = rep_info['REDUCE_NM'] == '일반' ? '15%': rep_info['REDUCE_NM'] == '기초' ? '0%' : rep_info['REDUCE_NM'] == '의료급여' ? '6%': (rep_info['SBA_CD'].split('(')[1].substr(0, rep_info['SBA_CD'].split('(')[1].length-1));
			if( reduceNm.equals("일반") ) {
				selfBndRt = 15;
			}else if( reduceNm.equals("기초") ) {
				selfBndRt = 0;
			}else if( reduceNm.equals("의료급여") ) {
				selfBndRt = 6;
			}else if (sbaCd != null && sbaCd.indexOf("(") >= 0) {
				selfBndRt = EgovStringUtil.string2integer(sbaCd.split("\\(")[1].substring(0, sbaCd.split("\\(")[1].length()-1).replace("%", "")); // 9% or 6%
			}else{
				selfBndRt = 20; /* 현재 없는 경우 20%로 박음 */
			}

			this.infoMap.put("LTC_MGMT_NO", welToolTgt.get("LTC_MGMT_NO"));/*L-번호*/
			this.infoMap.put("LTC_RCGT_GRADE_CD", welToolTgt.get("LTC_RCGT_GRADE_CD"));/*등급*/
			this.infoMap.put("QLF_TYPE", welToolTgt.get("QLF_TYPE"));
			this.infoMap.put("RCGT_EDA_DT", welToolTgt.get("RCGT_EDA_DT"));/* 인정 기간 2023-06-18 ~ 2026-06-17 */
			this.infoMap.put("REDUCE_NM", reduceNm);/* 본인부담율  */
			this.infoMap.put("SBA_CD", sbaCd);/*본인부담율 - 감면*/
			this.infoMap.put("SELF_BND_RT", selfBndRt);

		}

		String apdtFrDt, apdtToDt, today;

		today = DateUtil.getToday("yyyyMMdd");
		/**********************************수급자의 현재 적용구간************************************/
		List<Map<String, Object>> toolPayLmtListMap =  JsonUtil.getListMapFromJsonArray(toolPayLmtList);
		for(Map<String, Object> toolPayLmt : toolPayLmtListMap) {
//			System.out.println("@@ " + methodName + " : " + toolPayLmt.toString());

			apdtFrDt = (String) toolPayLmt.get("APDT_FR_DT");
			apdtToDt = (String) toolPayLmt.get("APDT_TO_DT");
			
			if (today.compareTo(apdtFrDt) >= 0  && today.compareTo(apdtToDt) <= 0 ){
				this.infoMap.put("APDT_FR_DT", toolPayLmt.get("APDT_FR_DT")); // 적용구간 시작
				this.infoMap.put("APDT_TO_DT", toolPayLmt.get("APDT_TO_DT")); // 적용구간 종료
				this.infoMap.put("REMN_AMT", toolPayLmt.get("REMN_AMT")); // 급여잔액
				this.infoMap.put("USE_AMT", toolPayLmt.get("USE_AMT")); // 사용금액
				this.infoMap.put("LMT_AMT", toolPayLmt.get("LMT_AMT")); // 제한금액
			}
		}
//		System.out.println("@@ " + methodName + " : " + this.infoMap.toString());

		/**********************************수급자의 현재 인정기간************************************/
		List<Map<String, Object>> welToolTgtHistListMap =  JsonUtil.getListMapFromJsonArray(welToolTgtHistList);
		for(Map<String, Object> welTooTgtHistMap : welToolTgtHistListMap) {
//			System.out.println("@@ " + methodName + " : " + welTooTgtHistMap.toString());

			apdtFrDt = (String) welTooTgtHistMap.get("RCGT_EDA_FR_DT"); /* 20230715 */
			apdtToDt = (String) welTooTgtHistMap.get("RCGT_EDA_TO_DT"); /* 20250714 */

			if (today.compareTo(apdtFrDt) >= 0  && today.compareTo(apdtToDt) <= 0 ){
				this.infoMap.put("RCGT_EDA_FR_DT", welTooTgtHistMap.get("RCGT_EDA_FR_DT")); // 인정기간 시작
				this.infoMap.put("RCGT_EDA_TO_DT", welTooTgtHistMap.get("RCGT_EDA_TO_DT")); // 인정기간 종료
				this.infoMap.put("LTC_MGMT_NO_SEQ", welTooTgtHistMap.get("LTC_MGMT_NO_SEQ")); // 인정기간 순번(롱텀에서 부여된 순번)
			}
			
		}
		System.out.println("@@ " + methodName + " : " + this.infoMap.toString());

		return bResult;
	}

	public void setItemGrpAbleParse(String responseStr) throws Exception {
		if (weltoolsItemGrpList == null) {
			throw new Exception("not found weltoolsItemGrpList");
		}
		
		JSONParser jsonParser = new JSONParser();
		Object obj = jsonParser.parse(responseStr);

		JSONObject jsonObject = new JSONObject((Map<String, Object>) obj);

		JSONObject dsPayPsblObj = (JSONObject) jsonObject.get("Result");

//        System.out.println("@@ 4 : " + dsPayPsblObj);
        JSONArray ds_payPsbl1 = new JSONArray();
        JSONArray ds_payPsblLnd1 = new JSONArray();

        JSONArray ds_payPsbl2 = new JSONArray();
        JSONArray ds_payPsblLnd2 = new JSONArray();

		
        if(dsPayPsblObj != null) {
			
        	ds_payPsbl1 = (JSONArray) dsPayPsblObj.get("ds_payPsbl1");
            ds_payPsblLnd1 = (JSONArray) dsPayPsblObj.get("ds_payPsblLnd1");

            ds_payPsbl2 = (JSONArray) dsPayPsblObj.get("ds_payPsbl2");
            ds_payPsblLnd2 = (JSONArray) dsPayPsblObj.get("ds_payPsblLnd2");

			// 판매 급여 품목(가능 )
            List<Map<String, Object>> ds_payPsbl1Map =  JsonUtil.getListMapFromJsonArray(ds_payPsbl1);
            // 대여 급여 품목(가능 )
            List<Map<String, Object>> ds_payPsblLnd1Map =  JsonUtil.getListMapFromJsonArray(ds_payPsblLnd1);

            // 판매 급여 품목(불가능 )
            List<Map<String, Object>> ds_payPsbl2Map =  JsonUtil.getListMapFromJsonArray(ds_payPsbl2);
            // 대여 급여 품목(불가능 )
            List<Map<String, Object>> ds_payPsblLnd2Map =  JsonUtil.getListMapFromJsonArray(ds_payPsblLnd2);

			this.setItemGrpAble("Y", ds_payPsbl1Map);
			this.setItemGrpAble("Y", ds_payPsblLnd1Map);
			this.setItemGrpAble("N", ds_payPsbl2Map);
			this.setItemGrpAble("N", ds_payPsblLnd2Map);
		}
		
	}
	
	protected void setItemGrpAble(String yn, List<Map<String, Object>> ds_payPsbl1Map) throws Exception {

		WelToolsItemGrpInfo itemGrpInfo = null;
		String itemGrpNm, itemGrpCd;
		int idx;

		for(Map<String, Object> saleMap : ds_payPsbl1Map) {
            itemGrpNm = (String) saleMap.get("WIM_ITM_CD");
			idx = CodeList.WELTOOLS_ITEMGRP_NMS.indexOf(itemGrpNm);
			
			if (idx == -1) {
				idx = CodeList.WELTOOLS_ITEMGRP_NM_DISP.indexOf(itemGrpNm);
			}

			itemGrpCd = CodeList.WELTOOLS_ITEMGRP_CDS.get(idx);

			if (itemGrpCd == "mattress") {/*욕창예방 매트리스 판매, 대여 구분*/
				itemGrpCd = "mattressS";
				itemGrpInfo = (WelToolsItemGrpInfo)(weltoolsItemGrpList.get(itemGrpCd)); 
				itemGrpInfo.setAble(yn);
				
				itemGrpCd = "mattressR";
				itemGrpInfo = (WelToolsItemGrpInfo)(weltoolsItemGrpList.get(itemGrpCd)); 
				itemGrpInfo.setAble(yn);
			} else if (itemGrpCd == "antiSlipProduct") {
				/*미끄럼 방지용품 중 양말이면 양말에 표시*/
				
				itemGrpInfo = (WelToolsItemGrpInfo)(weltoolsItemGrpList.get(itemGrpCd)); 
				itemGrpInfo.setAble(yn);
				
				itemGrpCd = "antiSlipSocks";
				itemGrpInfo = (WelToolsItemGrpInfo)(weltoolsItemGrpList.get(itemGrpCd)); 
				itemGrpInfo.setAble(yn);
			}else {
				if (!weltoolsItemGrpList.containsKey(itemGrpCd)) {
					throw new Exception("not found " + itemGrpNm);
				}
				
				itemGrpInfo = (WelToolsItemGrpInfo)(weltoolsItemGrpList.get(itemGrpCd)); 
				itemGrpInfo.setAble(yn);
			}
			
		}
		
	}
	
	public void setContractItemListParse(String responseStr) throws Exception {
		if (weltoolsItemGrpList == null) {
			throw new Exception("not found weltoolsItemGrpList");
		}

		JSONParser jsonParser = new JSONParser();
		Object obj = jsonParser.parse(responseStr);

		JSONObject jsonObject = new JSONObject((Map<String, Object>) obj);

   	    JSONObject pre_result = (JSONObject) jsonObject.get("Result");
//   	    System.out.println("@@ 6 : " + pre_result.toJSONString());
   	    
   	 
   	    WelToolsItemGrpInfo itemGrpInfo;
   	    if(pre_result != null) {
   	    	JSONArray returnResult = (JSONArray) pre_result.get("ds_result");

   	    	if(returnResult != null) {
   	    		String itemGrpNm, itemGrpCd;
   	    		
			    List<Map<String, Object>> Ds_resultMap =  JsonUtil.getListMapFromJsonArray(returnResult);
			    Map<String, Object> dsResult2;
			    int idx, ifor, ilen = Ds_resultMap.size();
			    for(ifor = 0; ifor < ilen; ifor++) {

			    	dsResult2 = Ds_resultMap.get(ifor);
			    	
			    	itemGrpNm = (String) dsResult2.get("PROD_NM");
		    		 
					idx = CodeList.WELTOOLS_ITEMGRP_NMS.indexOf(itemGrpNm);
					if (idx == -1) {
						idx = CodeList.WELTOOLS_ITEMGRP_NM_DISP.indexOf(itemGrpNm);
					}
					itemGrpCd = CodeList.WELTOOLS_ITEMGRP_CDS.get(idx);
					

					if (itemGrpCd == "mattress") {/*욕창예방 매트리스 판매, 대여 구분*/
						if (((String) dsResult2.get("WLR_MTHD_CD")).equals("대여")) {
							itemGrpCd = "mattressR";
						}else {
							itemGrpCd = "mattressS";
						}
					} else if (itemGrpCd == "antiSlipProduct" && CodeList.WELTOOLS_ITEM_SOCKS.indexOf((String) dsResult2.get("WIM_CD")) >= 0) {
						/*미끄럼 방지용품 중 양말이면 양말에 표시*/
						itemGrpCd = "antiSlipSocks";
					}
						
					if (!weltoolsItemGrpList.containsKey(itemGrpCd)) {
						throw new Exception("not found " + itemGrpNm);
					}
					
					itemGrpInfo = (WelToolsItemGrpInfo)(weltoolsItemGrpList.get(itemGrpCd)); 
					itemGrpInfo.addItem(dsResult2);
			    }

   	    	}
   	    }

	}

	public JSONObject getResutAll()throws Exception {
		if (weltoolsItemGrpList == null) {
			throw new Exception("not found weltoolsItemGrpList");
		}
		
		JSONObject jsonObject = new JSONObject();
		WelToolsItemGrpInfo itemGrpInfo1, itemGrpInfo2;
		String itemGrpOther;
		for (String itemGrpCd : weltoolsItemGrpList.keySet()) {
	   		itemGrpInfo1 = (WelToolsItemGrpInfo)(weltoolsItemGrpList.get(itemGrpCd));

			if (EgovStringUtil.equals(itemGrpCd, "manualBed") || EgovStringUtil.equals(itemGrpCd, "mattressR") ){
				/*욕창예방 매트리스(대여), 수동침대는 욕창예방 매트리스(판매), 전동침대에서 처리*/
				continue;
			} else if (EgovStringUtil.equals(itemGrpCd, "electricBed")  ){
				itemGrpOther = "manualBed";

				itemGrpInfo2 = (WelToolsItemGrpInfo)(weltoolsItemGrpList.get(itemGrpOther));
				if (!EgovStringUtil.equals("Y", itemGrpInfo1.getAble())
					 || (itemGrpInfo1.getUsedPersistPeriodCnt() + itemGrpInfo2.getUsedPersistPeriodCnt()) == 0){
					jsonObject.put(itemGrpCd, itemGrpInfo1.getResult());
					jsonObject.put(itemGrpOther, itemGrpInfo2.getResult());
				}else{
					if (itemGrpInfo1.getUsedPersistPeriodCnt() > 0){
						jsonObject.put(itemGrpCd, itemGrpInfo1.getResult());
						jsonObject.put(itemGrpOther, itemGrpInfo2.getResultNoneOther());
					}else{
						jsonObject.put(itemGrpCd, itemGrpInfo1.getResultNoneOther());
						jsonObject.put(itemGrpOther, itemGrpInfo2.getResult());
					}
					
				}

			} else if (EgovStringUtil.equals(itemGrpCd, "mattressS") ){
				itemGrpOther = "mattressR";

				itemGrpInfo2 = (WelToolsItemGrpInfo)(weltoolsItemGrpList.get(itemGrpOther));

				if (EgovStringUtil.equals("Y", itemGrpInfo1.getAble())){
					if (itemGrpInfo1.getUsedPersistPeriodCnt() > 0){/*매트리스 판매가 있을 경우*/
						jsonObject.put(itemGrpCd, itemGrpInfo1.getResult());
						jsonObject.put(itemGrpOther, itemGrpInfo2.getResultNoneOther());
					} else if (itemGrpInfo2.getUsedPersistPeriodCnt() > 0){/*매트리스 대여가 있을 경우*/
						jsonObject.put(itemGrpCd, itemGrpInfo1.getResultNoneOther());
						jsonObject.put(itemGrpOther, itemGrpInfo2.getResult());
					} else {
						jsonObject.put(itemGrpCd, itemGrpInfo1.getResult());
						jsonObject.put(itemGrpOther, itemGrpInfo2.getResult());
					}
				}else{
					jsonObject.put(itemGrpCd, itemGrpInfo1.getResult());
					jsonObject.put(itemGrpOther, itemGrpInfo2.getResult());
				}

			}else{
				jsonObject.put(itemGrpCd, itemGrpInfo1.getResult());
			}
			
		}

		return jsonObject;
	}

	public List<String> getResutIcube(String saleKind)throws Exception {
		if (weltoolsItemGrpList == null) {
			throw new Exception("not found weltoolsItemGrpList");
		}
		
		WelToolsItemGrpInfo itemGrpInfo;
		List<String> resultList = new ArrayList<>();
	   	for (String itemGrpCd : weltoolsItemGrpList.keySet()) {
	   		itemGrpInfo = (WelToolsItemGrpInfo)(weltoolsItemGrpList.get(itemGrpCd));
	   		
	   		if (EgovStringUtil.equals(itemGrpInfo.getSaleKind(), saleKind)) {
	   			resultList.addAll(itemGrpInfo.getResultIcube());	
	   		}
	   	}
	   	 
	   	// System.out.println("@@ resultList " + saleKind + " : " + resultList);

		return resultList;
	}

	protected HashMap<String, WelToolsItemGrpInfo> getWeltoolsItemGrpList(String peroidDtFr, String peroidDtTo, String applyDtFr, String applyDtTo){

		return new HashMap<String, WelToolsItemGrpInfo>(){{
			put("mobileToilet"		, (new WelToolsItemGrpInfo("mobileToilet"	, "dayOne"	, 5, 1 , peroidDtFr, peroidDtTo, applyDtFr, applyDtTo)));//5년에 1개 구매가능(dayOne), "이동변기"			, "이동변기"				
			put("bathChair"			, (new WelToolsItemGrpInfo("bathChair"		, "dayOne"	, 5, 1 , peroidDtFr, peroidDtTo, applyDtFr, applyDtTo)));//5년에 1개 구매가능(dayOne)//, "목욕의자"			, "목욕의자"				
			put("walkerForAdults"	, (new WelToolsItemGrpInfo("walkerForAdults", "dayCnt"	, 5, 2 , peroidDtFr, peroidDtTo, applyDtFr, applyDtTo)));//5년에 2개 구매가능(dayCnt)//, "성인용보행기"		, "성인용보행기"			
			put("safetyHandle"		, (new WelToolsItemGrpInfo("safetyHandle"	, "period"	, 1, 10, peroidDtFr, peroidDtTo, applyDtFr, applyDtTo)));//적용기간 내 10개 구매가능(period)//, "안전손잡이"		, "안전손잡이"				
			put("antiSlipProduct"	, (new WelToolsItemGrpInfo("antiSlipProduct", "period"	, 1, 5 , peroidDtFr, peroidDtTo, applyDtFr, applyDtTo)));//적용기간 내 5개 구매가능(양말제외)//, "미끄럼 방지용품"	, "미끄럼 방지용품"			
			put("antiSlipSocks"		, (new WelToolsItemGrpInfo("antiSlipSocks"	, "period"	, 1, 6 , peroidDtFr, peroidDtTo, applyDtFr, applyDtTo)));//적용기간 내 6개 구매가능(period)//, "미끄럼 방지양말"	, "미끄럼 방지양말"			
			put("portableToilet"	, (new WelToolsItemGrpInfo("portableToilet"	, "period"	, 1, 2 , peroidDtFr, peroidDtTo, applyDtFr, applyDtTo)));//적용기간 내 2개 구매가능(period)//, "간이변기"			, "간이변기"				
			put("cane"				, (new WelToolsItemGrpInfo("cane"			, "dayOne"	, 2, 1 , peroidDtFr, peroidDtTo, applyDtFr, applyDtTo)));//2년에 1개 구매가능(dayOne)//, "지팡이"			, "지팡이"					
			put("cushion"			, (new WelToolsItemGrpInfo("cushion"		, "dayOne"	, 3, 1 , peroidDtFr, peroidDtTo, applyDtFr, applyDtTo)));//3년에 1개 구매가능(dayOne)//, "욕창예방방석"		, "욕창예방방석"			
			put("changeTool"		, (new WelToolsItemGrpInfo("changeTool"		, "period"	, 1, 5 , peroidDtFr, peroidDtTo, applyDtFr, applyDtTo)));//적용기간 내 5개 구매가능(period)//, "자세변환용구"		, "자세변환용구"			
			put("panties"			, (new WelToolsItemGrpInfo("panties"		, "period"	, 1, 4 , peroidDtFr, peroidDtTo, applyDtFr, applyDtTo)));//적용기간 내 4개 구매가능(period)//, "요실금팬티"		, "요실금팬티"				
			put("inRunway"			, (new WelToolsItemGrpInfo("inRunway"		, "dayCnt"	, 2, 6 , peroidDtFr, peroidDtTo, applyDtFr, applyDtTo)));//2년에 6개 구매가능(dayCnt)//, "실내용 경사로"		, "실내용 경사로"			
			put("wheelchair"		, (new WelToolsItemGrpInfo("wheelchair"		, "rent"	, 1, 1 , peroidDtFr, peroidDtTo, applyDtFr, applyDtTo)));//rent//, "수동휠체어"		, "수동휠체어"				
			put("electricBed"		, (new WelToolsItemGrpInfo("electricBed"	, "rent"	, 1, 1 , peroidDtFr, peroidDtTo, applyDtFr, applyDtTo)));//rent//, "전동침대"			, "전동침대"				
			put("manualBed"			, (new WelToolsItemGrpInfo("manualBed"		, "rent"	, 1, 1 , peroidDtFr, peroidDtTo, applyDtFr, applyDtTo)));//rent//, "수동침대"			, "수동침대"				
			put("bathtub"			, (new WelToolsItemGrpInfo("bathtub"		, "rent"	, 1, 1 , peroidDtFr, peroidDtTo, applyDtFr, applyDtTo)));//rent//, "이동욕조"			, "이동욕조"				  
			put("bathLift"			, (new WelToolsItemGrpInfo("bathLift"		, "rent"	, 1, 1 , peroidDtFr, peroidDtTo, applyDtFr, applyDtTo)));//rent//, "목욕리프트"		, "목욕리프트"				   
			put("detector"			, (new WelToolsItemGrpInfo("detector"		, "rent"	, 1, 1 , peroidDtFr, peroidDtTo, applyDtFr, applyDtTo)));//rent//, "배회감지기"		, "배회감지기"				   
			put("outRunway"			, (new WelToolsItemGrpInfo("outRunway"		, "rent"	, 1, 1 , peroidDtFr, peroidDtTo, applyDtFr, applyDtTo)));//rent//, "경사로"			, "경사로"					  
			put("mattressS"			, (new WelToolsItemGrpInfo("mattressS"		, "dayOne"	, 3, 1 , peroidDtFr, peroidDtTo, applyDtFr, applyDtTo)));//3년에 1개 구매가능(dayOne)//, "욕창예방 매트리스"	, "욕창예방 매트리스(판매)"		
			put("mattressR"			, (new WelToolsItemGrpInfo("mattressR"		, "rent"	, 1, 1 , peroidDtFr, peroidDtTo, applyDtFr, applyDtTo)));//rent//, "욕창예방 매트리스"	, "욕창예방 매트리스(대여)"		
		}};
	}


	public void testAction() throws Exception{
		
		WelToolsInfoParser wtInfoParser = new WelToolsInfoParser("2023-07-15", "2025-07-14", "2023-03-29", "2024-03-28");
		
		wtInfoParser.setItemGrpAbleParse(wtInfoParser.getTestDataPayPsb());
		
		wtInfoParser.setContractItemListParse(wtInfoParser.getTestDataContractItemHistory());
   	    
		Map<String, Object> infoMap = new HashMap<String, Object>();
		
		infoMap.put("allList", wtInfoParser.getItemGrpAbleICube());
		infoMap.put("lendList",  wtInfoParser.getItemGrpAbleICube("R", "Y"));
		infoMap.put("saleList", wtInfoParser.getItemGrpAbleICube("S", "Y"));
		
		infoMap.put("saleNonList", wtInfoParser.getItemGrpAbleICube("S", "N"));
		infoMap.put("lendNonList", wtInfoParser.getItemGrpAbleICube("R", "N"));
		
		infoMap.put("USE_AMT", wtInfoParser.getUsedAmt());
		
		List<String> ownSaleList = wtInfoParser.getResutIcube("S");
	    List<String> ownLendList = wtInfoParser.getResutIcube("R");

		if (ownSaleList != null && ownSaleList.size() > 0){
			infoMap.put("ownSaleList", ownSaleList);
		}else{
			infoMap.put("ownSaleList", null);
		}
		if (ownLendList != null && ownLendList.size() > 0){
			infoMap.put("ownLendList", ownLendList);
		}else{
			infoMap.put("ownLendList", null);
		}

		infoMap.put("ownList", wtInfoParser.getResutAll());

		System.out.println("infoMap = " + infoMap);
	
	}

	public void testAction2() throws Exception{
		
		WelToolsInfoParser wtInfoParser = new WelToolsInfoParser();
		
		wtInfoParser.setContractInfoParse(wtInfoParser.getTestDataContractInfo());

		wtInfoParser.setItemGrpAbleParse(wtInfoParser.getTestDataPayPsb());
		
		wtInfoParser.setContractItemListParse(wtInfoParser.getTestDataContractItemHistory());
   	    
		Map<String, Object> infoMap = new HashMap<String, Object>();
		
		infoMap.put("USE_AMT", wtInfoParser.getUsedAmt());
		
		infoMap.put("ownList", wtInfoParser.getResutAll());

		System.out.println("infoMap = " + infoMap);
	
	}

	private String date8To10(String date8){
		if (date8.length() == 8) {
			date8 = date8.substring(0, 4) + "-" + date8.substring(4, 6) + "-" + date8.substring(6, 8);
		}

		return date8;
	}

	//이병녀(0011559991)
	//수급자의 계약 정보
	public String getTestDataContractInfo(){
		String responseStr = "{\"Result\":{\"ds_Result\":{\"SEARCH_TO_DATE\":\"20231106\",\"LTC_ADMIN_NM\":\"(주)티에이치케이컴퍼니\",\"LOC_TEL_NO\":\"051-818-8170\",\"LTC_ADMIN_SYM\":\"32623000271\",\"SEARCH_FR_DATE\":\"20221106\",\"REPR_NM\":\"신종호\",\"ADMIN_PTTN_CD\":\"Y\",\"_ROW_STATUS\":\"1\"},\"ds_welToolTgtList\":[{\"UB20CNT\":\"11\",\"ERR_MSG\":null,\"RCGT_EDA_DT\":\"2023-07-15 ~ 2025-07-14\",\"OBJTR_HIPIN\":\"110000259997142\",\"BDAY\":\"19400205\",\"LTC_MGMT_NO\":\"L0011559991\",\"REDUCE_NM\":\"일반\",\"LTC_MGMT_NO_SEQ\":\"109\",\"RCGT_EDA_FR_DT\":\"20230715\",\"LIMIT_AMT\":\"1,097,000\",\"QLF_TYPE\":\"3\",\"VALID_YN\":\"Y\",\"DEATH_DT\":null,\"RCGT_EDA_TO_DT\":\"20250714\",\"LTC_RCGT_GRADE_CD\":\"1\",\"RNE\":\"40020529uP6sekIMzuYwiTKnhf95g==\",\"SBA_CD\":\"일반\",\"FNM\":\"이병녀\",\"REDUCE\":\"3\",\"_ROW_STATUS\":\"1\"}],\"ds_toolPayLmtList\":[{\"APDT_TO_DT\":\"20260328\",\"USE_AMT\":\"0\",\"LTC_MGMT_NO\":\"L0011559991\",\"APDT_FR_DT\":\"20250329\",\"REMN_AMT\":\"1600000\",\"LMT_AMT\":\"1600000\",\"_ROW_STATUS\":\"1\"},{\"APDT_TO_DT\":\"20250328\",\"USE_AMT\":\"0\",\"LTC_MGMT_NO\":\"L0011559991\",\"APDT_FR_DT\":\"20240329\",\"REMN_AMT\":\"1600000\",\"LMT_AMT\":\"1600000\",\"_ROW_STATUS\":\"1\"},{\"APDT_TO_DT\":\"20240328\",\"USE_AMT\":\"301500\",\"LTC_MGMT_NO\":\"L0011559991\",\"APDT_FR_DT\":\"20230329\",\"REMN_AMT\":\"1298500\",\"LMT_AMT\":\"1600000\",\"_ROW_STATUS\":\"1\"},{\"APDT_TO_DT\":\"20230328\",\"USE_AMT\":\"644700\",\"LTC_MGMT_NO\":\"L0011559991\",\"APDT_FR_DT\":\"20220329\",\"REMN_AMT\":\"955300\",\"LMT_AMT\":\"1600000\",\"_ROW_STATUS\":\"1\"},{\"APDT_TO_DT\":\"20220328\",\"USE_AMT\":\"106800\",\"LTC_MGMT_NO\":\"L0011559991\",\"APDT_FR_DT\":\"20210329\",\"REMN_AMT\":\"1493200\",\"LMT_AMT\":\"1600000\",\"_ROW_STATUS\":\"1\"},{\"APDT_TO_DT\":\"20210328\",\"USE_AMT\":\"956500\",\"LTC_MGMT_NO\":\"L0011559991\",\"APDT_FR_DT\":\"20200329\",\"REMN_AMT\":\"643500\",\"LMT_AMT\":\"1600000\",\"_ROW_STATUS\":\"1\"},{\"APDT_TO_DT\":\"20200328\",\"USE_AMT\":\"0\",\"LTC_MGMT_NO\":\"L0011559991\",\"APDT_FR_DT\":\"20190329\",\"REMN_AMT\":\"1600000\",\"LMT_AMT\":\"1600000\",\"_ROW_STATUS\":\"1\"}],\"ds_welToolTgtHistList\":[{\"DEATH_DT\":null,\"LTC_RCGT_GRADE_CD\":\"3\",\"RCGT_EDA_TO_DT\":\"20200328\",\"BDAY\":\"19400205\",\"LTC_MGMT_NO\":\"L0011559991\",\"SBA_CD\":\"일반\",\"BRCH_PSTN_TYPE\":\"0\",\"LTC_MGMT_NO_SEQ\":\"104\",\"RCGT_EDA_FR_DT\":\"20190329\",\"BRCH_CD\":\"0342\",\"QLF_TYPE\":\"3\",\"_ROW_STATUS\":\"1\"},{\"DEATH_DT\":null,\"LTC_RCGT_GRADE_CD\":\"4\",\"RCGT_EDA_TO_DT\":\"20210714\",\"BDAY\":\"19400205\",\"LTC_MGMT_NO\":\"L0011559991\",\"SBA_CD\":\"일반\",\"BRCH_PSTN_TYPE\":\"0\",\"LTC_MGMT_NO_SEQ\":\"105\",\"RCGT_EDA_FR_DT\":\"20200329\",\"BRCH_CD\":\"0342\",\"QLF_TYPE\":\"3\",\"_ROW_STATUS\":\"1\"},{\"DEATH_DT\":null,\"LTC_RCGT_GRADE_CD\":\"3\",\"RCGT_EDA_TO_DT\":\"20230714\",\"BDAY\":\"19400205\",\"LTC_MGMT_NO\":\"L0011559991\",\"SBA_CD\":\"일반\",\"BRCH_PSTN_TYPE\":\"0\",\"LTC_MGMT_NO_SEQ\":\"107\",\"RCGT_EDA_FR_DT\":\"20210715\",\"BRCH_CD\":\"0342\",\"QLF_TYPE\":\"3\",\"_ROW_STATUS\":\"1\"},{\"DEATH_DT\":null,\"LTC_RCGT_GRADE_CD\":\"1\",\"RCGT_EDA_TO_DT\":\"20250714\",\"BDAY\":\"19400205\",\"LTC_MGMT_NO\":\"L0011559991\",\"SBA_CD\":\"일반\",\"BRCH_PSTN_TYPE\":\"0\",\"LTC_MGMT_NO_SEQ\":\"109\",\"RCGT_EDA_FR_DT\":\"20230715\",\"BRCH_CD\":\"0342\",\"QLF_TYPE\":\"3\",\"_ROW_STATUS\":\"1\"}],\"ds_ctrHistTotalList\":[{\"BCD_NO\":\"200400001645\",\"CNCR_TEL_NO\":\"00000000000\",\"CNCR_HP_NO\":null,\"WIM_CD\":\"M06061091101\",\"TOT_AMT\":\"54500\",\"WEL_PAY_STL_NM\":\"판매\",\"PERIOD\":\"2020-07-08\",\"JUMIN_BDAY\":\"400205\",\"CNCR_BDAY\":\"19400205\",\"CNCR_TEL_LOC_NO\":\"000\",\"CNCR_NM\":\"이병녀\",\"CNCR_TEL_BUR_NO\":\"0000\",\"LTCP_CTR_NO\":\"202010988252\",\"CNCR_HP_SEQ_NO\":null,\"MECH_AMT\":\"54500\",\"PRSN_TOT\":\"6133590\",\"POF_FR_DT\":\"20200708\",\"CNCR_REL_CD\":\"10\",\"LTCP_OFFR_SEQ_NO\":\"2\",\"BDAY\":\"19400205\",\"CTR_FR_DT\":\"20200708\",\"LTC_ADMIN_SYM\":\"31168000216\",\"ETC_XPLN1\":\"1\",\"WIM_ITM_CD\":\"17\",\"CNCR_HP_LOC_NO\":null,\"PPE_TERM\":\"5\",\"CTR_TO_DT\":\"20200708\",\"WIM_ITM_CD_NM\":\"성인용보행기\",\"CNCR_TEL_SEQ_NO\":\"0000\",\"POF_TO_DT\":\"20200708\",\"WLR_MTHD_CD\":\"1\",\"PROC_CD\":\"M06061091101\",\"PRDCT_NM\":\"CK-06\",\"CNCR_HP_BUR_NO\":null,\"_ROW_STATUS\":\"1\"},{\"BCD_NO\":\"181100000163\",\"CNCR_TEL_NO\":\"00000000000\",\"CNCR_HP_NO\":null,\"WIM_CD\":\"T03030081602\",\"TOT_AMT\":\"162000\",\"WEL_PAY_STL_NM\":\"판매\",\"PERIOD\":\"2020-07-08\",\"JUMIN_BDAY\":\"400205\",\"CNCR_BDAY\":\"19400205\",\"CNCR_TEL_LOC_NO\":\"000\",\"CNCR_NM\":\"이병녀\",\"CNCR_TEL_BUR_NO\":\"0000\",\"LTCP_CTR_NO\":\"202010988252\",\"CNCR_HP_SEQ_NO\":null,\"MECH_AMT\":\"162000\",\"PRSN_TOT\":\"6133590\",\"POF_FR_DT\":\"20200708\",\"CNCR_REL_CD\":\"10\",\"LTCP_OFFR_SEQ_NO\":\"3\",\"BDAY\":\"19400205\",\"CTR_FR_DT\":\"20200708\",\"LTC_ADMIN_SYM\":\"31168000216\",\"ETC_XPLN1\":\"1\",\"WIM_ITM_CD\":\"01\",\"CNCR_HP_LOC_NO\":null,\"PPE_TERM\":\"5\",\"CTR_TO_DT\":\"20200708\",\"WIM_ITM_CD_NM\":\"이동변기\",\"CNCR_TEL_SEQ_NO\":\"0000\",\"POF_TO_DT\":\"20200708\",\"WLR_MTHD_CD\":\"1\",\"PROC_CD\":\"T03030081602\",\"PRDCT_NM\":\"PN-L30200BK\",\"CNCR_HP_BUR_NO\":null,\"_ROW_STATUS\":\"1\"},{\"BCD_NO\":\"200100001412\",\"CNCR_TEL_NO\":\"00000000000\",\"CNCR_HP_NO\":null,\"WIM_CD\":\"B03180088605\",\"TOT_AMT\":\"186000\",\"WEL_PAY_STL_NM\":\"판매\",\"PERIOD\":\"2020-07-08\",\"JUMIN_BDAY\":\"400205\",\"CNCR_BDAY\":\"19400205\",\"CNCR_TEL_LOC_NO\":\"000\",\"CNCR_NM\":\"이병녀\",\"CNCR_TEL_BUR_NO\":\"0000\",\"LTCP_CTR_NO\":\"202010988252\",\"CNCR_HP_SEQ_NO\":null,\"MECH_AMT\":\"186000\",\"PRSN_TOT\":\"6133590\",\"POF_FR_DT\":\"20200708\",\"CNCR_REL_CD\":\"10\",\"LTCP_OFFR_SEQ_NO\":\"4\",\"BDAY\":\"19400205\",\"CTR_FR_DT\":\"20200708\",\"LTC_ADMIN_SYM\":\"31168000216\",\"ETC_XPLN1\":\"1\",\"WIM_ITM_CD\":\"02\",\"CNCR_HP_LOC_NO\":null,\"PPE_TERM\":\"5\",\"CTR_TO_DT\":\"20200708\",\"WIM_ITM_CD_NM\":\"목욕의자\",\"CNCR_TEL_SEQ_NO\":\"0000\",\"POF_TO_DT\":\"20200708\",\"WLR_MTHD_CD\":\"1\",\"PROC_CD\":\"B03180088605\",\"PRDCT_NM\":\"IU\",\"CNCR_HP_BUR_NO\":null,\"_ROW_STATUS\":\"1\"},{\"BCD_NO\":\"200400000008\",\"CNCR_TEL_NO\":\"00000000000\",\"CNCR_HP_NO\":null,\"WIM_CD\":\"M06090088606\",\"TOT_AMT\":\"166000\",\"WEL_PAY_STL_NM\":\"판매\",\"PERIOD\":\"2020-07-08\",\"JUMIN_BDAY\":\"400205\",\"CNCR_BDAY\":\"19400205\",\"CNCR_TEL_LOC_NO\":\"000\",\"CNCR_NM\":\"이병녀\",\"CNCR_TEL_BUR_NO\":\"0000\",\"LTCP_CTR_NO\":\"202010988252\",\"CNCR_HP_SEQ_NO\":null,\"MECH_AMT\":\"166000\",\"PRSN_TOT\":\"6133590\",\"POF_FR_DT\":\"20200708\",\"CNCR_REL_CD\":\"10\",\"LTCP_OFFR_SEQ_NO\":\"1\",\"BDAY\":\"19400205\",\"CTR_FR_DT\":\"20200708\",\"LTC_ADMIN_SYM\":\"31168000216\",\"ETC_XPLN1\":\"1\",\"WIM_ITM_CD\":\"17\",\"CNCR_HP_LOC_NO\":null,\"PPE_TERM\":\"5\",\"CTR_TO_DT\":\"20200708\",\"WIM_ITM_CD_NM\":\"성인용보행기\",\"CNCR_TEL_SEQ_NO\":\"0000\",\"POF_TO_DT\":\"20200708\",\"WLR_MTHD_CD\":\"1\",\"PROC_CD\":\"M06090088606\",\"PRDCT_NM\":\"ST10\",\"CNCR_HP_BUR_NO\":null,\"_ROW_STATUS\":\"1\"},{\"BCD_NO\":\"16040265\",\"CNCR_TEL_NO\":\"00000000000\",\"CNCR_HP_NO\":null,\"WIM_CD\":\"S03090035103\",\"TOT_AMT\":\"455330\",\"WEL_PAY_STL_NM\":\"대여\",\"PERIOD\":\"2020-08-18~2021-02-22\",\"JUMIN_BDAY\":\"400205\",\"CNCR_BDAY\":\"19400205\",\"CNCR_TEL_LOC_NO\":\"000\",\"CNCR_NM\":\"이병녀\",\"CNCR_TEL_BUR_NO\":\"0000\",\"LTCP_CTR_NO\":\"202011243202\",\"CNCR_HP_SEQ_NO\":null,\"MECH_AMT\":\"73000\",\"PRSN_TOT\":\"6133590\",\"POF_FR_DT\":\"20200818\",\"CNCR_REL_CD\":\"10\",\"LTCP_OFFR_SEQ_NO\":\"1\",\"BDAY\":\"19400205\",\"CTR_FR_DT\":\"20200818\",\"LTC_ADMIN_SYM\":\"34113000586\",\"ETC_XPLN1\":\"1\",\"WIM_ITM_CD\":\"12\",\"CNCR_HP_LOC_NO\":null,\"PPE_TERM\":\"10\",\"CTR_TO_DT\":\"20210222\",\"WIM_ITM_CD_NM\":\"전동침대\",\"CNCR_TEL_SEQ_NO\":\"0000\",\"POF_TO_DT\":\"20210222\",\"WLR_MTHD_CD\":\"2\",\"PROC_CD\":\"S03090035103\",\"PRDCT_NM\":\"JB920LITE\",\"CNCR_HP_BUR_NO\":null,\"_ROW_STATUS\":\"1\"},{\"BCD_NO\":\"200100000168\",\"CNCR_TEL_NO\":\"00000000000\",\"CNCR_HP_NO\":null,\"WIM_CD\":\"H12060031003\",\"TOT_AMT\":\"32650\",\"WEL_PAY_STL_NM\":\"대여\",\"PERIOD\":\"2021-01-06~2021-02-22\",\"JUMIN_BDAY\":\"400205\",\"CNCR_BDAY\":\"19400205\",\"CNCR_TEL_LOC_NO\":\"000\",\"CNCR_NM\":\"이병녀\",\"CNCR_TEL_BUR_NO\":\"0000\",\"LTCP_CTR_NO\":\"202111924224\",\"CNCR_HP_SEQ_NO\":null,\"MECH_AMT\":\"20100\",\"PRSN_TOT\":\"6133590\",\"POF_FR_DT\":\"20210106\",\"CNCR_REL_CD\":\"10\",\"LTCP_OFFR_SEQ_NO\":\"1\",\"BDAY\":\"19400205\",\"CTR_FR_DT\":\"20210106\",\"LTC_ADMIN_SYM\":\"34113000586\",\"ETC_XPLN1\":\"1\",\"WIM_ITM_CD\":\"14\",\"CNCR_HP_LOC_NO\":null,\"PPE_TERM\":\"3\",\"CTR_TO_DT\":\"20210222\",\"WIM_ITM_CD_NM\":\"욕창예방 매트리스\",\"CNCR_TEL_SEQ_NO\":\"0000\",\"POF_TO_DT\":\"20210222\",\"WLR_MTHD_CD\":\"2\",\"PROC_CD\":\"H12060031003\",\"PRDCT_NM\":\"YB-1104A\",\"CNCR_HP_BUR_NO\":null,\"_ROW_STATUS\":\"1\"},{\"BCD_NO\":\"201200013969\",\"CNCR_TEL_NO\":\"00000000000\",\"CNCR_HP_NO\":null,\"WIM_CD\":\"F30091039113\",\"TOT_AMT\":\"3800\",\"WEL_PAY_STL_NM\":\"판매\",\"PERIOD\":\"2021-02-15\",\"JUMIN_BDAY\":\"400205\",\"CNCR_BDAY\":\"19400205\",\"CNCR_TEL_LOC_NO\":\"000\",\"CNCR_NM\":\"이병녀\",\"CNCR_TEL_BUR_NO\":\"0000\",\"LTCP_CTR_NO\":\"202112086949\",\"CNCR_HP_SEQ_NO\":null,\"MECH_AMT\":\"3800\",\"PRSN_TOT\":\"6133590\",\"POF_FR_DT\":\"20210215\",\"CNCR_REL_CD\":\"10\",\"LTCP_OFFR_SEQ_NO\":\"10\",\"BDAY\":\"19400205\",\"CTR_FR_DT\":\"20210215\",\"LTC_ADMIN_SYM\":\"32823700332\",\"ETC_XPLN1\":\"1\",\"WIM_ITM_CD\":\"06\",\"CNCR_HP_LOC_NO\":null,\"PPE_TERM\":\"0\",\"CTR_TO_DT\":\"20210215\",\"WIM_ITM_CD_NM\":\"미끄럼 방지용품\",\"CNCR_TEL_SEQ_NO\":\"0000\",\"POF_TO_DT\":\"20210215\",\"WLR_MTHD_CD\":\"1\",\"PROC_CD\":\"F30091039113\",\"PRDCT_NM\":\"YH-202\",\"CNCR_HP_BUR_NO\":null,\"_ROW_STATUS\":\"1\"},{\"BCD_NO\":\"201200013968\",\"CNCR_TEL_NO\":\"00000000000\",\"CNCR_HP_NO\":null,\"WIM_CD\":\"F30091039113\",\"TOT_AMT\":\"3800\",\"WEL_PAY_STL_NM\":\"판매\",\"PERIOD\":\"2021-02-15\",\"JUMIN_BDAY\":\"400205\",\"CNCR_BDAY\":\"19400205\",\"CNCR_TEL_LOC_NO\":\"000\",\"CNCR_NM\":\"이병녀\",\"CNCR_TEL_BUR_NO\":\"0000\",\"LTCP_CTR_NO\":\"202112086949\",\"CNCR_HP_SEQ_NO\":null,\"MECH_AMT\":\"3800\",\"PRSN_TOT\":\"6133590\",\"POF_FR_DT\":\"20210215\",\"CNCR_REL_CD\":\"10\",\"LTCP_OFFR_SEQ_NO\":\"9\",\"BDAY\":\"19400205\",\"CTR_FR_DT\":\"20210215\",\"LTC_ADMIN_SYM\":\"32823700332\",\"ETC_XPLN1\":\"1\",\"WIM_ITM_CD\":\"06\",\"CNCR_HP_LOC_NO\":null,\"PPE_TERM\":\"0\",\"CTR_TO_DT\":\"20210215\",\"WIM_ITM_CD_NM\":\"미끄럼 방지용품\",\"CNCR_TEL_SEQ_NO\":\"0000\",\"POF_TO_DT\":\"20210215\",\"WLR_MTHD_CD\":\"1\",\"PROC_CD\":\"F30091039113\",\"PRDCT_NM\":\"YH-202\",\"CNCR_HP_BUR_NO\":null,\"_ROW_STATUS\":\"1\"},{\"BCD_NO\":\"201200013967\",\"CNCR_TEL_NO\":\"00000000000\",\"CNCR_HP_NO\":null,\"WIM_CD\":\"F30091039113\",\"TOT_AMT\":\"3800\",\"WEL_PAY_STL_NM\":\"판매\",\"PERIOD\":\"2021-02-15\",\"JUMIN_BDAY\":\"400205\",\"CNCR_BDAY\":\"19400205\",\"CNCR_TEL_LOC_NO\":\"000\",\"CNCR_NM\":\"이병녀\",\"CNCR_TEL_BUR_NO\":\"0000\",\"LTCP_CTR_NO\":\"202112086949\",\"CNCR_HP_SEQ_NO\":null,\"MECH_AMT\":\"3800\",\"PRSN_TOT\":\"6133590\",\"POF_FR_DT\":\"20210215\",\"CNCR_REL_CD\":\"10\",\"LTCP_OFFR_SEQ_NO\":\"8\",\"BDAY\":\"19400205\",\"CTR_FR_DT\":\"20210215\",\"LTC_ADMIN_SYM\":\"32823700332\",\"ETC_XPLN1\":\"1\",\"WIM_ITM_CD\":\"06\",\"CNCR_HP_LOC_NO\":null,\"PPE_TERM\":\"0\",\"CTR_TO_DT\":\"20210215\",\"WIM_ITM_CD_NM\":\"미끄럼 방지용품\",\"CNCR_TEL_SEQ_NO\":\"0000\",\"POF_TO_DT\":\"20210215\",\"WLR_MTHD_CD\":\"1\",\"PROC_CD\":\"F30091039113\",\"PRDCT_NM\":\"YH-202\",\"CNCR_HP_BUR_NO\":null,\"_ROW_STATUS\":\"1\"},{\"BCD_NO\":\"201200013966\",\"CNCR_TEL_NO\":\"00000000000\",\"CNCR_HP_NO\":null,\"WIM_CD\":\"F30091039113\",\"TOT_AMT\":\"3800\",\"WEL_PAY_STL_NM\":\"판매\",\"PERIOD\":\"2021-02-15\",\"JUMIN_BDAY\":\"400205\",\"CNCR_BDAY\":\"19400205\",\"CNCR_TEL_LOC_NO\":\"000\",\"CNCR_NM\":\"이병녀\",\"CNCR_TEL_BUR_NO\":\"0000\",\"LTCP_CTR_NO\":\"202112086949\",\"CNCR_HP_SEQ_NO\":null,\"MECH_AMT\":\"3800\",\"PRSN_TOT\":\"6133590\",\"POF_FR_DT\":\"20210215\",\"CNCR_REL_CD\":\"10\",\"LTCP_OFFR_SEQ_NO\":\"7\",\"BDAY\":\"19400205\",\"CTR_FR_DT\":\"20210215\",\"LTC_ADMIN_SYM\":\"32823700332\",\"ETC_XPLN1\":\"1\",\"WIM_ITM_CD\":\"06\",\"CNCR_HP_LOC_NO\":null,\"PPE_TERM\":\"0\",\"CTR_TO_DT\":\"20210215\",\"WIM_ITM_CD_NM\":\"미끄럼 방지용품\",\"CNCR_TEL_SEQ_NO\":\"0000\",\"POF_TO_DT\":\"20210215\",\"WLR_MTHD_CD\":\"1\",\"PROC_CD\":\"F30091039113\",\"PRDCT_NM\":\"YH-202\",\"CNCR_HP_BUR_NO\":null,\"_ROW_STATUS\":\"1\"},{\"BCD_NO\":\"201200013965\",\"CNCR_TEL_NO\":\"00000000000\",\"CNCR_HP_NO\":null,\"WIM_CD\":\"F30091039113\",\"TOT_AMT\":\"3800\",\"WEL_PAY_STL_NM\":\"판매\",\"PERIOD\":\"2021-02-15\",\"JUMIN_BDAY\":\"400205\",\"CNCR_BDAY\":\"19400205\",\"CNCR_TEL_LOC_NO\":\"000\",\"CNCR_NM\":\"이병녀\",\"CNCR_TEL_BUR_NO\":\"0000\",\"LTCP_CTR_NO\":\"202112086949\",\"CNCR_HP_SEQ_NO\":null,\"MECH_AMT\":\"3800\",\"PRSN_TOT\":\"6133590\",\"POF_FR_DT\":\"20210215\",\"CNCR_REL_CD\":\"10\",\"LTCP_OFFR_SEQ_NO\":\"6\",\"BDAY\":\"19400205\",\"CTR_FR_DT\":\"20210215\",\"LTC_ADMIN_SYM\":\"32823700332\",\"ETC_XPLN1\":\"1\",\"WIM_ITM_CD\":\"06\",\"CNCR_HP_LOC_NO\":null,\"PPE_TERM\":\"0\",\"CTR_TO_DT\":\"20210215\",\"WIM_ITM_CD_NM\":\"미끄럼 방지용품\",\"CNCR_TEL_SEQ_NO\":\"0000\",\"POF_TO_DT\":\"20210215\",\"WLR_MTHD_CD\":\"1\",\"PROC_CD\":\"F30091039113\",\"PRDCT_NM\":\"YH-202\",\"CNCR_HP_BUR_NO\":null,\"_ROW_STATUS\":\"1\"},{\"BCD_NO\":\"201200013964\",\"CNCR_TEL_NO\":\"00000000000\",\"CNCR_HP_NO\":null,\"WIM_CD\":\"F30091039113\",\"TOT_AMT\":\"3800\",\"WEL_PAY_STL_NM\":\"판매\",\"PERIOD\":\"2021-02-15\",\"JUMIN_BDAY\":\"400205\",\"CNCR_BDAY\":\"19400205\",\"CNCR_TEL_LOC_NO\":\"000\",\"CNCR_NM\":\"이병녀\",\"CNCR_TEL_BUR_NO\":\"0000\",\"LTCP_CTR_NO\":\"202112086949\",\"CNCR_HP_SEQ_NO\":null,\"MECH_AMT\":\"3800\",\"PRSN_TOT\":\"6133590\",\"POF_FR_DT\":\"20210215\",\"CNCR_REL_CD\":\"10\",\"LTCP_OFFR_SEQ_NO\":\"5\",\"BDAY\":\"19400205\",\"CTR_FR_DT\":\"20210215\",\"LTC_ADMIN_SYM\":\"32823700332\",\"ETC_XPLN1\":\"1\",\"WIM_ITM_CD\":\"06\",\"CNCR_HP_LOC_NO\":null,\"PPE_TERM\":\"0\",\"CTR_TO_DT\":\"20210215\",\"WIM_ITM_CD_NM\":\"미끄럼 방지용품\",\"CNCR_TEL_SEQ_NO\":\"0000\",\"POF_TO_DT\":\"20210215\",\"WLR_MTHD_CD\":\"1\",\"PROC_CD\":\"F30091039113\",\"PRDCT_NM\":\"YH-202\",\"CNCR_HP_BUR_NO\":null,\"_ROW_STATUS\":\"1\"},{\"BCD_NO\":\"201200006808\",\"CNCR_TEL_NO\":\"00000000000\",\"CNCR_HP_NO\":null,\"WIM_CD\":\"T09060165006\",\"TOT_AMT\":\"38400\",\"WEL_PAY_STL_NM\":\"판매\",\"PERIOD\":\"2021-02-15\",\"JUMIN_BDAY\":\"400205\",\"CNCR_BDAY\":\"19400205\",\"CNCR_TEL_LOC_NO\":\"000\",\"CNCR_NM\":\"이병녀\",\"CNCR_TEL_BUR_NO\":\"0000\",\"LTCP_CTR_NO\":\"202112086949\",\"CNCR_HP_SEQ_NO\":null,\"MECH_AMT\":\"38400\",\"PRSN_TOT\":\"6133590\",\"POF_FR_DT\":\"20210215\",\"CNCR_REL_CD\":\"10\",\"LTCP_OFFR_SEQ_NO\":\"4\",\"BDAY\":\"19400205\",\"CTR_FR_DT\":\"20210215\",\"LTC_ADMIN_SYM\":\"32823700332\",\"ETC_XPLN1\":\"1\",\"WIM_ITM_CD\":\"20\",\"CNCR_HP_LOC_NO\":null,\"PPE_TERM\":\"0\",\"CTR_TO_DT\":\"20210215\",\"WIM_ITM_CD_NM\":\"요실금팬티\",\"CNCR_TEL_SEQ_NO\":\"0000\",\"POF_TO_DT\":\"20210215\",\"WLR_MTHD_CD\":\"1\",\"PROC_CD\":\"T09060165006\",\"PRDCT_NM\":\"AW300코지50cc\",\"CNCR_HP_BUR_NO\":null,\"_ROW_STATUS\":\"1\"},{\"BCD_NO\":\"201200006807\",\"CNCR_TEL_NO\":\"00000000000\",\"CNCR_HP_NO\":null,\"WIM_CD\":\"T09060165006\",\"TOT_AMT\":\"38400\",\"WEL_PAY_STL_NM\":\"판매\",\"PERIOD\":\"2021-02-15\",\"JUMIN_BDAY\":\"400205\",\"CNCR_BDAY\":\"19400205\",\"CNCR_TEL_LOC_NO\":\"000\",\"CNCR_NM\":\"이병녀\",\"CNCR_TEL_BUR_NO\":\"0000\",\"LTCP_CTR_NO\":\"202112086949\",\"CNCR_HP_SEQ_NO\":null,\"MECH_AMT\":\"38400\",\"PRSN_TOT\":\"6133590\",\"POF_FR_DT\":\"20210215\",\"CNCR_REL_CD\":\"10\",\"LTCP_OFFR_SEQ_NO\":\"3\",\"BDAY\":\"19400205\",\"CTR_FR_DT\":\"20210215\",\"LTC_ADMIN_SYM\":\"32823700332\",\"ETC_XPLN1\":\"1\",\"WIM_ITM_CD\":\"20\",\"CNCR_HP_LOC_NO\":null,\"PPE_TERM\":\"0\",\"CTR_TO_DT\":\"20210215\",\"WIM_ITM_CD_NM\":\"요실금팬티\",\"CNCR_TEL_SEQ_NO\":\"0000\",\"POF_TO_DT\":\"20210215\",\"WLR_MTHD_CD\":\"1\",\"PROC_CD\":\"T09060165006\",\"PRDCT_NM\":\"AW300코지50cc\",\"CNCR_HP_BUR_NO\":null,\"_ROW_STATUS\":\"1\"},{\"BCD_NO\":\"210100001043\",\"CNCR_TEL_NO\":\"00000000000\",\"CNCR_HP_NO\":null,\"WIM_CD\":\"F18030060120\",\"TOT_AMT\":\"219000\",\"WEL_PAY_STL_NM\":\"판매\",\"PERIOD\":\"2021-02-15\",\"JUMIN_BDAY\":\"400205\",\"CNCR_BDAY\":\"19400205\",\"CNCR_TEL_LOC_NO\":\"000\",\"CNCR_NM\":\"이병녀\",\"CNCR_TEL_BUR_NO\":\"0000\",\"LTCP_CTR_NO\":\"202112086949\",\"CNCR_HP_SEQ_NO\":null,\"MECH_AMT\":\"219000\",\"PRSN_TOT\":\"6133590\",\"POF_FR_DT\":\"20210215\",\"CNCR_REL_CD\":\"10\",\"LTCP_OFFR_SEQ_NO\":\"1\",\"BDAY\":\"19400205\",\"CTR_FR_DT\":\"20210215\",\"LTC_ADMIN_SYM\":\"32823700332\",\"ETC_XPLN1\":\"1\",\"WIM_ITM_CD\":\"05\",\"CNCR_HP_LOC_NO\":null,\"PPE_TERM\":\"0\",\"CTR_TO_DT\":\"20210215\",\"WIM_ITM_CD_NM\":\"안전손잡이\",\"CNCR_TEL_SEQ_NO\":\"0000\",\"POF_TO_DT\":\"20210215\",\"WLR_MTHD_CD\":\"1\",\"PROC_CD\":\"F18030060120\",\"PRDCT_NM\":\"ASH-201\",\"CNCR_HP_BUR_NO\":null,\"_ROW_STATUS\":\"1\"},{\"BCD_NO\":\"200800002032\",\"CNCR_TEL_NO\":\"00000000000\",\"CNCR_HP_NO\":null,\"WIM_CD\":\"M03031071601\",\"TOT_AMT\":\"69400\",\"WEL_PAY_STL_NM\":\"판매\",\"PERIOD\":\"2021-02-15\",\"JUMIN_BDAY\":\"400205\",\"CNCR_BDAY\":\"19400205\",\"CNCR_TEL_LOC_NO\":\"000\",\"CNCR_NM\":\"이병녀\",\"CNCR_TEL_BUR_NO\":\"0000\",\"LTCP_CTR_NO\":\"202112086949\",\"CNCR_HP_SEQ_NO\":null,\"MECH_AMT\":\"69400\",\"PRSN_TOT\":\"6133590\",\"POF_FR_DT\":\"20210215\",\"CNCR_REL_CD\":\"10\",\"LTCP_OFFR_SEQ_NO\":\"2\",\"BDAY\":\"19400205\",\"CTR_FR_DT\":\"20210215\",\"LTC_ADMIN_SYM\":\"32823700332\",\"ETC_XPLN1\":\"1\",\"WIM_ITM_CD\":\"08\",\"CNCR_HP_LOC_NO\":null,\"PPE_TERM\":\"2\",\"CTR_TO_DT\":\"20210215\",\"WIM_ITM_CD_NM\":\"지팡이\",\"CNCR_TEL_SEQ_NO\":\"0000\",\"POF_TO_DT\":\"20210215\",\"WLR_MTHD_CD\":\"1\",\"PROC_CD\":\"M03031071601\",\"PRDCT_NM\":\"백건 여자 지팡이-01\",\"CNCR_HP_BUR_NO\":null,\"_ROW_STATUS\":\"1\"},{\"BCD_NO\":\"180500000045\",\"CNCR_TEL_NO\":\"00000000000\",\"CNCR_HP_NO\":null,\"WIM_CD\":\"M18030111103\",\"TOT_AMT\":\"41250\",\"WEL_PAY_STL_NM\":\"대여\",\"PERIOD\":\"2021-02-15~2021-03-28\",\"JUMIN_BDAY\":\"400205\",\"CNCR_BDAY\":\"19400205\",\"CNCR_TEL_LOC_NO\":\"000\",\"CNCR_NM\":\"이병녀\",\"CNCR_TEL_BUR_NO\":\"0000\",\"LTCP_CTR_NO\":\"202112087020\",\"CNCR_HP_SEQ_NO\":null,\"MECH_AMT\":\"29400\",\"PRSN_TOT\":\"6133590\",\"POF_FR_DT\":\"20210215\",\"CNCR_REL_CD\":\"10\",\"LTCP_OFFR_SEQ_NO\":\"1\",\"BDAY\":\"19400205\",\"CTR_FR_DT\":\"20210215\",\"LTC_ADMIN_SYM\":\"32823700332\",\"ETC_XPLN1\":\"1\",\"WIM_ITM_CD\":\"11\",\"CNCR_HP_LOC_NO\":null,\"PPE_TERM\":\"5\",\"CTR_TO_DT\":\"20210328\",\"WIM_ITM_CD_NM\":\"수동휠체어\",\"CNCR_TEL_SEQ_NO\":\"0000\",\"POF_TO_DT\":\"20210328\",\"WLR_MTHD_CD\":\"2\",\"PROC_CD\":\"M18030111103\",\"PRDCT_NM\":\"MiKi-W AH\",\"CNCR_HP_BUR_NO\":null,\"_ROW_STATUS\":\"1\"},{\"BCD_NO\":\"210200001282\",\"CNCR_TEL_NO\":\"00000000000\",\"CNCR_HP_NO\":null,\"WIM_CD\":\"H12060031003\",\"TOT_AMT\":\"17510\",\"WEL_PAY_STL_NM\":\"대여\",\"PERIOD\":\"2021-03-02~2021-03-28\",\"JUMIN_BDAY\":\"400205\",\"CNCR_BDAY\":\"19400205\",\"CNCR_TEL_LOC_NO\":\"000\",\"CNCR_NM\":\"이병녀\",\"CNCR_TEL_BUR_NO\":\"0000\",\"LTCP_CTR_NO\":\"202112169320\",\"CNCR_HP_SEQ_NO\":null,\"MECH_AMT\":\"20100\",\"PRSN_TOT\":\"6133590\",\"POF_FR_DT\":\"20210302\",\"CNCR_REL_CD\":\"10\",\"LTCP_OFFR_SEQ_NO\":\"3\",\"BDAY\":\"19400205\",\"CTR_FR_DT\":\"20210302\",\"LTC_ADMIN_SYM\":\"32823700332\",\"ETC_XPLN1\":\"1\",\"WIM_ITM_CD\":\"14\",\"CNCR_HP_LOC_NO\":null,\"PPE_TERM\":\"3\",\"CTR_TO_DT\":\"20220328\",\"WIM_ITM_CD_NM\":\"욕창예방 매트리스\",\"CNCR_TEL_SEQ_NO\":\"0000\",\"POF_TO_DT\":\"20210328\",\"WLR_MTHD_CD\":\"2\",\"PROC_CD\":\"H12060031003\",\"PRDCT_NM\":\"YB-1104A\",\"CNCR_HP_BUR_NO\":null,\"_ROW_STATUS\":\"1\"},{\"BCD_NO\":\"210100000590\",\"CNCR_TEL_NO\":\"00000000000\",\"CNCR_HP_NO\":null,\"WIM_CD\":\"S03091064103\",\"TOT_AMT\":\"64280\",\"WEL_PAY_STL_NM\":\"대여\",\"PERIOD\":\"2021-03-02~2021-03-28\",\"JUMIN_BDAY\":\"400205\",\"CNCR_BDAY\":\"19400205\",\"CNCR_TEL_LOC_NO\":\"000\",\"CNCR_NM\":\"이병녀\",\"CNCR_TEL_BUR_NO\":\"0000\",\"LTCP_CTR_NO\":\"202112169320\",\"CNCR_HP_SEQ_NO\":null,\"MECH_AMT\":\"73800\",\"PRSN_TOT\":\"6133590\",\"POF_FR_DT\":\"20210302\",\"CNCR_REL_CD\":\"10\",\"LTCP_OFFR_SEQ_NO\":\"1\",\"BDAY\":\"19400205\",\"CTR_FR_DT\":\"20210302\",\"LTC_ADMIN_SYM\":\"32823700332\",\"ETC_XPLN1\":\"1\",\"WIM_ITM_CD\":\"12\",\"CNCR_HP_LOC_NO\":null,\"PPE_TERM\":\"10\",\"CTR_TO_DT\":\"20220328\",\"WIM_ITM_CD_NM\":\"전동침대\",\"CNCR_TEL_SEQ_NO\":\"0000\",\"POF_TO_DT\":\"20210328\",\"WLR_MTHD_CD\":\"2\",\"PROC_CD\":\"S03091064103\",\"PRDCT_NM\":\"NY(M)-1300\",\"CNCR_HP_BUR_NO\":null,\"_ROW_STATUS\":\"1\"},{\"BCD_NO\":\"210200001282\",\"CNCR_TEL_NO\":\"00000000000\",\"CNCR_HP_NO\":null,\"WIM_CD\":\"H12060031003\",\"TOT_AMT\":\"241200\",\"WEL_PAY_STL_NM\":\"대여\",\"PERIOD\":\"2021-03-29~2022-03-28\",\"JUMIN_BDAY\":\"400205\",\"CNCR_BDAY\":\"19400205\",\"CNCR_TEL_LOC_NO\":\"000\",\"CNCR_NM\":\"이병녀\",\"CNCR_TEL_BUR_NO\":\"0000\",\"LTCP_CTR_NO\":\"202112169320\",\"CNCR_HP_SEQ_NO\":null,\"MECH_AMT\":\"20100\",\"PRSN_TOT\":\"6133590\",\"POF_FR_DT\":\"20210329\",\"CNCR_REL_CD\":\"10\",\"LTCP_OFFR_SEQ_NO\":\"4\",\"BDAY\":\"19400205\",\"CTR_FR_DT\":\"20210302\",\"LTC_ADMIN_SYM\":\"32823700332\",\"ETC_XPLN1\":\"1\",\"WIM_ITM_CD\":\"14\",\"CNCR_HP_LOC_NO\":null,\"PPE_TERM\":\"3\",\"CTR_TO_DT\":\"20220328\",\"WIM_ITM_CD_NM\":\"욕창예방 매트리스\",\"CNCR_TEL_SEQ_NO\":\"0000\",\"POF_TO_DT\":\"20220328\",\"WLR_MTHD_CD\":\"2\",\"PROC_CD\":\"H12060031003\",\"PRDCT_NM\":\"YB-1104A\",\"CNCR_HP_BUR_NO\":null,\"_ROW_STATUS\":\"1\"},{\"BCD_NO\":\"210100000590\",\"CNCR_TEL_NO\":\"00000000000\",\"CNCR_HP_NO\":null,\"WIM_CD\":\"S03091064103\",\"TOT_AMT\":\"885600\",\"WEL_PAY_STL_NM\":\"대여\",\"PERIOD\":\"2021-03-29~2022-03-28\",\"JUMIN_BDAY\":\"400205\",\"CNCR_BDAY\":\"19400205\",\"CNCR_TEL_LOC_NO\":\"000\",\"CNCR_NM\":\"이병녀\",\"CNCR_TEL_BUR_NO\":\"0000\",\"LTCP_CTR_NO\":\"202112169320\",\"CNCR_HP_SEQ_NO\":null,\"MECH_AMT\":\"73800\",\"PRSN_TOT\":\"6133590\",\"POF_FR_DT\":\"20210329\",\"CNCR_REL_CD\":\"10\",\"LTCP_OFFR_SEQ_NO\":\"2\",\"BDAY\":\"19400205\",\"CTR_FR_DT\":\"20210302\",\"LTC_ADMIN_SYM\":\"32823700332\",\"ETC_XPLN1\":\"1\",\"WIM_ITM_CD\":\"12\",\"CNCR_HP_LOC_NO\":null,\"PPE_TERM\":\"10\",\"CTR_TO_DT\":\"20220328\",\"WIM_ITM_CD_NM\":\"전동침대\",\"CNCR_TEL_SEQ_NO\":\"0000\",\"POF_TO_DT\":\"20220328\",\"WLR_MTHD_CD\":\"2\",\"PROC_CD\":\"S03091064103\",\"PRDCT_NM\":\"NY(M)-1300\",\"CNCR_HP_BUR_NO\":null,\"_ROW_STATUS\":\"1\"},{\"BCD_NO\":\"180500000045\",\"CNCR_TEL_NO\":\"00000000000\",\"CNCR_HP_NO\":null,\"WIM_CD\":\"M18030111103\",\"TOT_AMT\":\"352800\",\"WEL_PAY_STL_NM\":\"대여\",\"PERIOD\":\"2021-03-29~2022-03-28\",\"JUMIN_BDAY\":\"400205\",\"CNCR_BDAY\":\"19400205\",\"CNCR_TEL_LOC_NO\":\"000\",\"CNCR_NM\":\"이병녀\",\"CNCR_TEL_BUR_NO\":\"0000\",\"LTCP_CTR_NO\":\"202112322063\",\"CNCR_HP_SEQ_NO\":null,\"MECH_AMT\":\"29400\",\"PRSN_TOT\":\"6133590\",\"POF_FR_DT\":\"20210329\",\"CNCR_REL_CD\":\"10\",\"LTCP_OFFR_SEQ_NO\":\"1\",\"BDAY\":\"19400205\",\"CTR_FR_DT\":\"20210329\",\"LTC_ADMIN_SYM\":\"32823700332\",\"ETC_XPLN1\":\"1\",\"WIM_ITM_CD\":\"11\",\"CNCR_HP_LOC_NO\":null,\"PPE_TERM\":\"5\",\"CTR_TO_DT\":\"20220328\",\"WIM_ITM_CD_NM\":\"수동휠체어\",\"CNCR_TEL_SEQ_NO\":\"0000\",\"POF_TO_DT\":\"20220328\",\"WLR_MTHD_CD\":\"2\",\"PROC_CD\":\"M18030111103\",\"PRDCT_NM\":\"MiKi-W AH\",\"CNCR_HP_BUR_NO\":null,\"_ROW_STATUS\":\"1\"},{\"BCD_NO\":\"210900007292\",\"CNCR_TEL_NO\":\"00000000000\",\"CNCR_HP_NO\":null,\"WIM_CD\":\"F30091039103\",\"TOT_AMT\":\"3000\",\"WEL_PAY_STL_NM\":\"판매\",\"PERIOD\":\"2022-03-14\",\"JUMIN_BDAY\":\"400205\",\"CNCR_BDAY\":\"19400205\",\"CNCR_TEL_LOC_NO\":\"000\",\"CNCR_NM\":\"이병녀\",\"CNCR_TEL_BUR_NO\":\"0000\",\"LTCP_CTR_NO\":\"202214228505\",\"CNCR_HP_SEQ_NO\":null,\"MECH_AMT\":\"3000\",\"PRSN_TOT\":\"6133590\",\"POF_FR_DT\":\"20220314\",\"CNCR_REL_CD\":\"10\",\"LTCP_OFFR_SEQ_NO\":\"6\",\"BDAY\":\"19400205\",\"CTR_FR_DT\":\"20220314\",\"LTC_ADMIN_SYM\":\"32823700332\",\"ETC_XPLN1\":\"1\",\"WIM_ITM_CD\":\"06\",\"CNCR_HP_LOC_NO\":null,\"PPE_TERM\":\"0\",\"CTR_TO_DT\":\"20220314\",\"WIM_ITM_CD_NM\":\"미끄럼 방지용품\",\"CNCR_TEL_SEQ_NO\":\"0000\",\"POF_TO_DT\":\"20220314\",\"WLR_MTHD_CD\":\"1\",\"PROC_CD\":\"F30091039103\",\"PRDCT_NM\":\"YH-004\",\"CNCR_HP_BUR_NO\":null,\"_ROW_STATUS\":\"1\"},{\"BCD_NO\":\"210900007291\",\"CNCR_TEL_NO\":\"00000000000\",\"CNCR_HP_NO\":null,\"WIM_CD\":\"F30091039103\",\"TOT_AMT\":\"3000\",\"WEL_PAY_STL_NM\":\"판매\",\"PERIOD\":\"2022-03-14\",\"JUMIN_BDAY\":\"400205\",\"CNCR_BDAY\":\"19400205\",\"CNCR_TEL_LOC_NO\":\"000\",\"CNCR_NM\":\"이병녀\",\"CNCR_TEL_BUR_NO\":\"0000\",\"LTCP_CTR_NO\":\"202214228505\",\"CNCR_HP_SEQ_NO\":null,\"MECH_AMT\":\"3000\",\"PRSN_TOT\":\"6133590\",\"POF_FR_DT\":\"20220314\",\"CNCR_REL_CD\":\"10\",\"LTCP_OFFR_SEQ_NO\":\"5\",\"BDAY\":\"19400205\",\"CTR_FR_DT\":\"20220314\",\"LTC_ADMIN_SYM\":\"32823700332\",\"ETC_XPLN1\":\"1\",\"WIM_ITM_CD\":\"06\",\"CNCR_HP_LOC_NO\":null,\"PPE_TERM\":\"0\",\"CTR_TO_DT\":\"20220314\",\"WIM_ITM_CD_NM\":\"미끄럼 방지용품\",\"CNCR_TEL_SEQ_NO\":\"0000\",\"POF_TO_DT\":\"20220314\",\"WLR_MTHD_CD\":\"1\",\"PROC_CD\":\"F30091039103\",\"PRDCT_NM\":\"YH-004\",\"CNCR_HP_BUR_NO\":null,\"_ROW_STATUS\":\"1\"},{\"BCD_NO\":\"211200002173\",\"CNCR_TEL_NO\":\"00000000000\",\"CNCR_HP_NO\":null,\"WIM_CD\":\"T09061052101\",\"TOT_AMT\":\"22200\",\"WEL_PAY_STL_NM\":\"판매\",\"PERIOD\":\"2022-03-14\",\"JUMIN_BDAY\":\"400205\",\"CNCR_BDAY\":\"19400205\",\"CNCR_TEL_LOC_NO\":\"000\",\"CNCR_NM\":\"이병녀\",\"CNCR_TEL_BUR_NO\":\"0000\",\"LTCP_CTR_NO\":\"202214228505\",\"CNCR_HP_SEQ_NO\":null,\"MECH_AMT\":\"22200\",\"PRSN_TOT\":\"6133590\",\"POF_FR_DT\":\"20220314\",\"CNCR_REL_CD\":\"10\",\"LTCP_OFFR_SEQ_NO\":\"4\",\"BDAY\":\"19400205\",\"CTR_FR_DT\":\"20220314\",\"LTC_ADMIN_SYM\":\"32823700332\",\"ETC_XPLN1\":\"1\",\"WIM_ITM_CD\":\"20\",\"CNCR_HP_LOC_NO\":null,\"PPE_TERM\":\"0\",\"CTR_TO_DT\":\"20220314\",\"WIM_ITM_CD_NM\":\"요실금팬티\",\"CNCR_TEL_SEQ_NO\":\"0000\",\"POF_TO_DT\":\"20220314\",\"WLR_MTHD_CD\":\"1\",\"PROC_CD\":\"T09061052101\",\"PRDCT_NM\":\"WHR-01\",\"CNCR_HP_BUR_NO\":null,\"_ROW_STATUS\":\"1\"},{\"BCD_NO\":\"210900007293\",\"CNCR_TEL_NO\":\"00000000000\",\"CNCR_HP_NO\":null,\"WIM_CD\":\"F30091039103\",\"TOT_AMT\":\"3000\",\"WEL_PAY_STL_NM\":\"판매\",\"PERIOD\":\"2022-03-14\",\"JUMIN_BDAY\":\"400205\",\"CNCR_BDAY\":\"19400205\",\"CNCR_TEL_LOC_NO\":\"000\",\"CNCR_NM\":\"이병녀\",\"CNCR_TEL_BUR_NO\":\"0000\",\"LTCP_CTR_NO\":\"202214228505\",\"CNCR_HP_SEQ_NO\":null,\"MECH_AMT\":\"3000\",\"PRSN_TOT\":\"6133590\",\"POF_FR_DT\":\"20220314\",\"CNCR_REL_CD\":\"10\",\"LTCP_OFFR_SEQ_NO\":\"7\",\"BDAY\":\"19400205\",\"CTR_FR_DT\":\"20220314\",\"LTC_ADMIN_SYM\":\"32823700332\",\"ETC_XPLN1\":\"1\",\"WIM_ITM_CD\":\"06\",\"CNCR_HP_LOC_NO\":null,\"PPE_TERM\":\"0\",\"CTR_TO_DT\":\"20220314\",\"WIM_ITM_CD_NM\":\"미끄럼 방지용품\",\"CNCR_TEL_SEQ_NO\":\"0000\",\"POF_TO_DT\":\"20220314\",\"WLR_MTHD_CD\":\"1\",\"PROC_CD\":\"F30091039103\",\"PRDCT_NM\":\"YH-004\",\"CNCR_HP_BUR_NO\":null,\"_ROW_STATUS\":\"1\"},{\"BCD_NO\":\"211200002170\",\"CNCR_TEL_NO\":\"00000000000\",\"CNCR_HP_NO\":null,\"WIM_CD\":\"T09061052101\",\"TOT_AMT\":\"22200\",\"WEL_PAY_STL_NM\":\"판매\",\"PERIOD\":\"2022-03-14\",\"JUMIN_BDAY\":\"400205\",\"CNCR_BDAY\":\"19400205\",\"CNCR_TEL_LOC_NO\":\"000\",\"CNCR_NM\":\"이병녀\",\"CNCR_TEL_BUR_NO\":\"0000\",\"LTCP_CTR_NO\":\"202214228505\",\"CNCR_HP_SEQ_NO\":null,\"MECH_AMT\":\"22200\",\"PRSN_TOT\":\"6133590\",\"POF_FR_DT\":\"20220314\",\"CNCR_REL_CD\":\"10\",\"LTCP_OFFR_SEQ_NO\":\"1\",\"BDAY\":\"19400205\",\"CTR_FR_DT\":\"20220314\",\"LTC_ADMIN_SYM\":\"32823700332\",\"ETC_XPLN1\":\"1\",\"WIM_ITM_CD\":\"20\",\"CNCR_HP_LOC_NO\":null,\"PPE_TERM\":\"0\",\"CTR_TO_DT\":\"20220314\",\"WIM_ITM_CD_NM\":\"요실금팬티\",\"CNCR_TEL_SEQ_NO\":\"0000\",\"POF_TO_DT\":\"20220314\",\"WLR_MTHD_CD\":\"1\",\"PROC_CD\":\"T09061052101\",\"PRDCT_NM\":\"WHR-01\",\"CNCR_HP_BUR_NO\":null,\"_ROW_STATUS\":\"1\"},{\"BCD_NO\":\"211200002171\",\"CNCR_TEL_NO\":\"00000000000\",\"CNCR_HP_NO\":null,\"WIM_CD\":\"T09061052101\",\"TOT_AMT\":\"22200\",\"WEL_PAY_STL_NM\":\"판매\",\"PERIOD\":\"2022-03-14\",\"JUMIN_BDAY\":\"400205\",\"CNCR_BDAY\":\"19400205\",\"CNCR_TEL_LOC_NO\":\"000\",\"CNCR_NM\":\"이병녀\",\"CNCR_TEL_BUR_NO\":\"0000\",\"LTCP_CTR_NO\":\"202214228505\",\"CNCR_HP_SEQ_NO\":null,\"MECH_AMT\":\"22200\",\"PRSN_TOT\":\"6133590\",\"POF_FR_DT\":\"20220314\",\"CNCR_REL_CD\":\"10\",\"LTCP_OFFR_SEQ_NO\":\"2\",\"BDAY\":\"19400205\",\"CTR_FR_DT\":\"20220314\",\"LTC_ADMIN_SYM\":\"32823700332\",\"ETC_XPLN1\":\"1\",\"WIM_ITM_CD\":\"20\",\"CNCR_HP_LOC_NO\":null,\"PPE_TERM\":\"0\",\"CTR_TO_DT\":\"20220314\",\"WIM_ITM_CD_NM\":\"요실금팬티\",\"CNCR_TEL_SEQ_NO\":\"0000\",\"POF_TO_DT\":\"20220314\",\"WLR_MTHD_CD\":\"1\",\"PROC_CD\":\"T09061052101\",\"PRDCT_NM\":\"WHR-01\",\"CNCR_HP_BUR_NO\":null,\"_ROW_STATUS\":\"1\"},{\"BCD_NO\":\"210900007296\",\"CNCR_TEL_NO\":\"00000000000\",\"CNCR_HP_NO\":null,\"WIM_CD\":\"F30091039103\",\"TOT_AMT\":\"3000\",\"WEL_PAY_STL_NM\":\"판매\",\"PERIOD\":\"2022-03-14\",\"JUMIN_BDAY\":\"400205\",\"CNCR_BDAY\":\"19400205\",\"CNCR_TEL_LOC_NO\":\"000\",\"CNCR_NM\":\"이병녀\",\"CNCR_TEL_BUR_NO\":\"0000\",\"LTCP_CTR_NO\":\"202214228505\",\"CNCR_HP_SEQ_NO\":null,\"MECH_AMT\":\"3000\",\"PRSN_TOT\":\"6133590\",\"POF_FR_DT\":\"20220314\",\"CNCR_REL_CD\":\"10\",\"LTCP_OFFR_SEQ_NO\":\"10\",\"BDAY\":\"19400205\",\"CTR_FR_DT\":\"20220314\",\"LTC_ADMIN_SYM\":\"32823700332\",\"ETC_XPLN1\":\"1\",\"WIM_ITM_CD\":\"06\",\"CNCR_HP_LOC_NO\":null,\"PPE_TERM\":\"0\",\"CTR_TO_DT\":\"20220314\",\"WIM_ITM_CD_NM\":\"미끄럼 방지용품\",\"CNCR_TEL_SEQ_NO\":\"0000\",\"POF_TO_DT\":\"20220314\",\"WLR_MTHD_CD\":\"1\",\"PROC_CD\":\"F30091039103\",\"PRDCT_NM\":\"YH-004\",\"CNCR_HP_BUR_NO\":null,\"_ROW_STATUS\":\"1\"},{\"BCD_NO\":\"211200002172\",\"CNCR_TEL_NO\":\"00000000000\",\"CNCR_HP_NO\":null,\"WIM_CD\":\"T09061052101\",\"TOT_AMT\":\"22200\",\"WEL_PAY_STL_NM\":\"판매\",\"PERIOD\":\"2022-03-14\",\"JUMIN_BDAY\":\"400205\",\"CNCR_BDAY\":\"19400205\",\"CNCR_TEL_LOC_NO\":\"000\",\"CNCR_NM\":\"이병녀\",\"CNCR_TEL_BUR_NO\":\"0000\",\"LTCP_CTR_NO\":\"202214228505\",\"CNCR_HP_SEQ_NO\":null,\"MECH_AMT\":\"22200\",\"PRSN_TOT\":\"6133590\",\"POF_FR_DT\":\"20220314\",\"CNCR_REL_CD\":\"10\",\"LTCP_OFFR_SEQ_NO\":\"3\",\"BDAY\":\"19400205\",\"CTR_FR_DT\":\"20220314\",\"LTC_ADMIN_SYM\":\"32823700332\",\"ETC_XPLN1\":\"1\",\"WIM_ITM_CD\":\"20\",\"CNCR_HP_LOC_NO\":null,\"PPE_TERM\":\"0\",\"CTR_TO_DT\":\"20220314\",\"WIM_ITM_CD_NM\":\"요실금팬티\",\"CNCR_TEL_SEQ_NO\":\"0000\",\"POF_TO_DT\":\"20220314\",\"WLR_MTHD_CD\":\"1\",\"PROC_CD\":\"T09061052101\",\"PRDCT_NM\":\"WHR-01\",\"CNCR_HP_BUR_NO\":null,\"_ROW_STATUS\":\"1\"},{\"BCD_NO\":\"210900007294\",\"CNCR_TEL_NO\":\"00000000000\",\"CNCR_HP_NO\":null,\"WIM_CD\":\"F30091039103\",\"TOT_AMT\":\"3000\",\"WEL_PAY_STL_NM\":\"판매\",\"PERIOD\":\"2022-03-14\",\"JUMIN_BDAY\":\"400205\",\"CNCR_BDAY\":\"19400205\",\"CNCR_TEL_LOC_NO\":\"000\",\"CNCR_NM\":\"이병녀\",\"CNCR_TEL_BUR_NO\":\"0000\",\"LTCP_CTR_NO\":\"202214228505\",\"CNCR_HP_SEQ_NO\":null,\"MECH_AMT\":\"3000\",\"PRSN_TOT\":\"6133590\",\"POF_FR_DT\":\"20220314\",\"CNCR_REL_CD\":\"10\",\"LTCP_OFFR_SEQ_NO\":\"8\",\"BDAY\":\"19400205\",\"CTR_FR_DT\":\"20220314\",\"LTC_ADMIN_SYM\":\"32823700332\",\"ETC_XPLN1\":\"1\",\"WIM_ITM_CD\":\"06\",\"CNCR_HP_LOC_NO\":null,\"PPE_TERM\":\"0\",\"CTR_TO_DT\":\"20220314\",\"WIM_ITM_CD_NM\":\"미끄럼 방지용품\",\"CNCR_TEL_SEQ_NO\":\"0000\",\"POF_TO_DT\":\"20220314\",\"WLR_MTHD_CD\":\"1\",\"PROC_CD\":\"F30091039103\",\"PRDCT_NM\":\"YH-004\",\"CNCR_HP_BUR_NO\":null,\"_ROW_STATUS\":\"1\"},{\"BCD_NO\":\"210900007295\",\"CNCR_TEL_NO\":\"00000000000\",\"CNCR_HP_NO\":null,\"WIM_CD\":\"F30091039103\",\"TOT_AMT\":\"3000\",\"WEL_PAY_STL_NM\":\"판매\",\"PERIOD\":\"2022-03-14\",\"JUMIN_BDAY\":\"400205\",\"CNCR_BDAY\":\"19400205\",\"CNCR_TEL_LOC_NO\":\"000\",\"CNCR_NM\":\"이병녀\",\"CNCR_TEL_BUR_NO\":\"0000\",\"LTCP_CTR_NO\":\"202214228505\",\"CNCR_HP_SEQ_NO\":null,\"MECH_AMT\":\"3000\",\"PRSN_TOT\":\"6133590\",\"POF_FR_DT\":\"20220314\",\"CNCR_REL_CD\":\"10\",\"LTCP_OFFR_SEQ_NO\":\"9\",\"BDAY\":\"19400205\",\"CTR_FR_DT\":\"20220314\",\"LTC_ADMIN_SYM\":\"32823700332\",\"ETC_XPLN1\":\"1\",\"WIM_ITM_CD\":\"06\",\"CNCR_HP_LOC_NO\":null,\"PPE_TERM\":\"0\",\"CTR_TO_DT\":\"20220314\",\"WIM_ITM_CD_NM\":\"미끄럼 방지용품\",\"CNCR_TEL_SEQ_NO\":\"0000\",\"POF_TO_DT\":\"20220314\",\"WLR_MTHD_CD\":\"1\",\"PROC_CD\":\"F30091039103\",\"PRDCT_NM\":\"YH-004\",\"CNCR_HP_BUR_NO\":null,\"_ROW_STATUS\":\"1\"},{\"BCD_NO\":\"180500000045\",\"CNCR_TEL_NO\":\"00000000000\",\"CNCR_HP_NO\":null,\"WIM_CD\":\"M18030111103\",\"TOT_AMT\":\"120450\",\"WEL_PAY_STL_NM\":\"대여\",\"PERIOD\":\"2022-03-29~2022-07-31\",\"JUMIN_BDAY\":\"400205\",\"CNCR_BDAY\":\"19400205\",\"CNCR_TEL_LOC_NO\":\"000\",\"CNCR_NM\":\"이병녀\",\"CNCR_TEL_BUR_NO\":\"0000\",\"LTCP_CTR_NO\":\"202214249647\",\"CNCR_HP_SEQ_NO\":null,\"MECH_AMT\":\"29400\",\"PRSN_TOT\":\"6133590\",\"POF_FR_DT\":\"20220329\",\"CNCR_REL_CD\":\"10\",\"LTCP_OFFR_SEQ_NO\":\"1\",\"BDAY\":\"19400205\",\"CTR_FR_DT\":\"20220329\",\"LTC_ADMIN_SYM\":\"32823700332\",\"ETC_XPLN1\":\"1\",\"WIM_ITM_CD\":\"11\",\"CNCR_HP_LOC_NO\":null,\"PPE_TERM\":\"5\",\"CTR_TO_DT\":\"20220731\",\"WIM_ITM_CD_NM\":\"수동휠체어\",\"CNCR_TEL_SEQ_NO\":\"0000\",\"POF_TO_DT\":\"20220731\",\"WLR_MTHD_CD\":\"2\",\"PROC_CD\":\"M18030111103\",\"PRDCT_NM\":\"MiKi-W AH\",\"CNCR_HP_BUR_NO\":null,\"_ROW_STATUS\":\"1\"},{\"BCD_NO\":\"210200001282\",\"CNCR_TEL_NO\":\"00000000000\",\"CNCR_HP_NO\":null,\"WIM_CD\":\"H12060031003\",\"TOT_AMT\":\"18700\",\"WEL_PAY_STL_NM\":\"대여\",\"PERIOD\":\"2022-03-29~2022-04-25\",\"JUMIN_BDAY\":\"400205\",\"CNCR_BDAY\":\"19400205\",\"CNCR_TEL_LOC_NO\":\"000\",\"CNCR_NM\":\"이병녀\",\"CNCR_TEL_BUR_NO\":\"0000\",\"LTCP_CTR_NO\":\"202214249647\",\"CNCR_HP_SEQ_NO\":null,\"MECH_AMT\":\"20100\",\"PRSN_TOT\":\"6133590\",\"POF_FR_DT\":\"20220329\",\"CNCR_REL_CD\":\"10\",\"LTCP_OFFR_SEQ_NO\":\"3\",\"BDAY\":\"19400205\",\"CTR_FR_DT\":\"20220329\",\"LTC_ADMIN_SYM\":\"32823700332\",\"ETC_XPLN1\":\"1\",\"WIM_ITM_CD\":\"14\",\"CNCR_HP_LOC_NO\":null,\"PPE_TERM\":\"3\",\"CTR_TO_DT\":\"20220731\",\"WIM_ITM_CD_NM\":\"욕창예방 매트리스\",\"CNCR_TEL_SEQ_NO\":\"0000\",\"POF_TO_DT\":\"20220425\",\"WLR_MTHD_CD\":\"2\",\"PROC_CD\":\"H12060031003\",\"PRDCT_NM\":\"YB-1104A\",\"CNCR_HP_BUR_NO\":null,\"_ROW_STATUS\":\"1\"},{\"BCD_NO\":\"210100000590\",\"CNCR_TEL_NO\":\"00000000000\",\"CNCR_HP_NO\":null,\"WIM_CD\":\"S03091064103\",\"TOT_AMT\":\"68640\",\"WEL_PAY_STL_NM\":\"대여\",\"PERIOD\":\"2022-03-29~2022-04-25\",\"JUMIN_BDAY\":\"400205\",\"CNCR_BDAY\":\"19400205\",\"CNCR_TEL_LOC_NO\":\"000\",\"CNCR_NM\":\"이병녀\",\"CNCR_TEL_BUR_NO\":\"0000\",\"LTCP_CTR_NO\":\"202214249647\",\"CNCR_HP_SEQ_NO\":null,\"MECH_AMT\":\"73800\",\"PRSN_TOT\":\"6133590\",\"POF_FR_DT\":\"20220329\",\"CNCR_REL_CD\":\"10\",\"LTCP_OFFR_SEQ_NO\":\"2\",\"BDAY\":\"19400205\",\"CTR_FR_DT\":\"20220329\",\"LTC_ADMIN_SYM\":\"32823700332\",\"ETC_XPLN1\":\"1\",\"WIM_ITM_CD\":\"12\",\"CNCR_HP_LOC_NO\":null,\"PPE_TERM\":\"10\",\"CTR_TO_DT\":\"20220731\",\"WIM_ITM_CD_NM\":\"전동침대\",\"CNCR_TEL_SEQ_NO\":\"0000\",\"POF_TO_DT\":\"20220425\",\"WLR_MTHD_CD\":\"2\",\"PROC_CD\":\"S03091064103\",\"PRDCT_NM\":\"NY(M)-1300\",\"CNCR_HP_BUR_NO\":null,\"_ROW_STATUS\":\"1\"},{\"BCD_NO\":\"220200001663\",\"CNCR_TEL_NO\":\"01020590118\",\"CNCR_HP_NO\":\"01020590118\",\"WIM_CD\":\"F30091003101\",\"TOT_AMT\":\"3100\",\"WEL_PAY_STL_NM\":\"판매\",\"PERIOD\":\"2022-04-11\",\"JUMIN_BDAY\":\"400205\",\"CNCR_BDAY\":\"19400205\",\"CNCR_TEL_LOC_NO\":\"010\",\"CNCR_NM\":\"이병녀\",\"CNCR_TEL_BUR_NO\":\"2059\",\"LTCP_CTR_NO\":\"202214388709\",\"CNCR_HP_SEQ_NO\":\"0118\",\"MECH_AMT\":\"3100\",\"PRSN_TOT\":\"6133590\",\"POF_FR_DT\":\"20220411\",\"CNCR_REL_CD\":\"10\",\"LTCP_OFFR_SEQ_NO\":\"6\",\"BDAY\":\"19400205\",\"CTR_FR_DT\":\"20220411\",\"LTC_ADMIN_SYM\":\"24159000563\",\"ETC_XPLN1\":\"1\",\"WIM_ITM_CD\":\"06\",\"CNCR_HP_LOC_NO\":\"010\",\"PPE_TERM\":\"0\",\"CTR_TO_DT\":\"20220411\",\"WIM_ITM_CD_NM\":\"미끄럼 방지용품\",\"CNCR_TEL_SEQ_NO\":\"0118\",\"POF_TO_DT\":\"20220411\",\"WLR_MTHD_CD\":\"1\",\"PROC_CD\":\"F30091003101\",\"PRDCT_NM\":\"편안한덧신양말(공용)\",\"CNCR_HP_BUR_NO\":\"2059\",\"_ROW_STATUS\":\"1\"},{\"BCD_NO\":\"211200013556\",\"CNCR_TEL_NO\":\"01020590118\",\"CNCR_HP_NO\":\"01020590118\",\"WIM_CD\":\"F30091003101\",\"TOT_AMT\":\"3100\",\"WEL_PAY_STL_NM\":\"판매\",\"PERIOD\":\"2022-04-11\",\"JUMIN_BDAY\":\"400205\",\"CNCR_BDAY\":\"19400205\",\"CNCR_TEL_LOC_NO\":\"010\",\"CNCR_NM\":\"이병녀\",\"CNCR_TEL_BUR_NO\":\"2059\",\"LTCP_CTR_NO\":\"202214388709\",\"CNCR_HP_SEQ_NO\":\"0118\",\"MECH_AMT\":\"3100\",\"PRSN_TOT\":\"6133590\",\"POF_FR_DT\":\"20220411\",\"CNCR_REL_CD\":\"10\",\"LTCP_OFFR_SEQ_NO\":\"5\",\"BDAY\":\"19400205\",\"CTR_FR_DT\":\"20220411\",\"LTC_ADMIN_SYM\":\"24159000563\",\"ETC_XPLN1\":\"1\",\"WIM_ITM_CD\":\"06\",\"CNCR_HP_LOC_NO\":\"010\",\"PPE_TERM\":\"0\",\"CTR_TO_DT\":\"20220411\",\"WIM_ITM_CD_NM\":\"미끄럼 방지용품\",\"CNCR_TEL_SEQ_NO\":\"0118\",\"POF_TO_DT\":\"20220411\",\"WLR_MTHD_CD\":\"1\",\"PROC_CD\":\"F30091003101\",\"PRDCT_NM\":\"편안한덧신양말(공용)\",\"CNCR_HP_BUR_NO\":\"2059\",\"_ROW_STATUS\":\"1\"},{\"BCD_NO\":\"211200001386\",\"CNCR_TEL_NO\":\"01020590118\",\"CNCR_HP_NO\":\"01020590118\",\"WIM_CD\":\"F30091079107\",\"TOT_AMT\":\"3100\",\"WEL_PAY_STL_NM\":\"판매\",\"PERIOD\":\"2022-04-11\",\"JUMIN_BDAY\":\"400205\",\"CNCR_BDAY\":\"19400205\",\"CNCR_TEL_LOC_NO\":\"010\",\"CNCR_NM\":\"이병녀\",\"CNCR_TEL_BUR_NO\":\"2059\",\"LTCP_CTR_NO\":\"202214388709\",\"CNCR_HP_SEQ_NO\":\"0118\",\"MECH_AMT\":\"3100\",\"PRSN_TOT\":\"6133590\",\"POF_FR_DT\":\"20220411\",\"CNCR_REL_CD\":\"10\",\"LTCP_OFFR_SEQ_NO\":\"4\",\"BDAY\":\"19400205\",\"CTR_FR_DT\":\"20220411\",\"LTC_ADMIN_SYM\":\"24159000563\",\"ETC_XPLN1\":\"1\",\"WIM_ITM_CD\":\"06\",\"CNCR_HP_LOC_NO\":\"010\",\"PPE_TERM\":\"0\",\"CTR_TO_DT\":\"20220411\",\"WIM_ITM_CD_NM\":\"미끄럼 방지용품\",\"CNCR_TEL_SEQ_NO\":\"0118\",\"POF_TO_DT\":\"20220411\",\"WLR_MTHD_CD\":\"1\",\"PROC_CD\":\"F30091079107\",\"PRDCT_NM\":\"4DM-204\",\"CNCR_HP_BUR_NO\":\"2059\",\"_ROW_STATUS\":\"1\"},{\"BCD_NO\":\"211200001384\",\"CNCR_TEL_NO\":\"01020590118\",\"CNCR_HP_NO\":\"01020590118\",\"WIM_CD\":\"F30091079107\",\"TOT_AMT\":\"3100\",\"WEL_PAY_STL_NM\":\"판매\",\"PERIOD\":\"2022-04-11\",\"JUMIN_BDAY\":\"400205\",\"CNCR_BDAY\":\"19400205\",\"CNCR_TEL_LOC_NO\":\"010\",\"CNCR_NM\":\"이병녀\",\"CNCR_TEL_BUR_NO\":\"2059\",\"LTCP_CTR_NO\":\"202214388709\",\"CNCR_HP_SEQ_NO\":\"0118\",\"MECH_AMT\":\"3100\",\"PRSN_TOT\":\"6133590\",\"POF_FR_DT\":\"20220411\",\"CNCR_REL_CD\":\"10\",\"LTCP_OFFR_SEQ_NO\":\"3\",\"BDAY\":\"19400205\",\"CTR_FR_DT\":\"20220411\",\"LTC_ADMIN_SYM\":\"24159000563\",\"ETC_XPLN1\":\"1\",\"WIM_ITM_CD\":\"06\",\"CNCR_HP_LOC_NO\":\"010\",\"PPE_TERM\":\"0\",\"CTR_TO_DT\":\"20220411\",\"WIM_ITM_CD_NM\":\"미끄럼 방지용품\",\"CNCR_TEL_SEQ_NO\":\"0118\",\"POF_TO_DT\":\"20220411\",\"WLR_MTHD_CD\":\"1\",\"PROC_CD\":\"F30091079107\",\"PRDCT_NM\":\"4DM-204\",\"CNCR_HP_BUR_NO\":\"2059\",\"_ROW_STATUS\":\"1\"},{\"BCD_NO\":\"211200010724\",\"CNCR_TEL_NO\":\"01020590118\",\"CNCR_HP_NO\":\"01020590118\",\"WIM_CD\":\"F30091079107\",\"TOT_AMT\":\"3100\",\"WEL_PAY_STL_NM\":\"판매\",\"PERIOD\":\"2022-04-11\",\"JUMIN_BDAY\":\"400205\",\"CNCR_BDAY\":\"19400205\",\"CNCR_TEL_LOC_NO\":\"010\",\"CNCR_NM\":\"이병녀\",\"CNCR_TEL_BUR_NO\":\"2059\",\"LTCP_CTR_NO\":\"202214388709\",\"CNCR_HP_SEQ_NO\":\"0118\",\"MECH_AMT\":\"3100\",\"PRSN_TOT\":\"6133590\",\"POF_FR_DT\":\"20220411\",\"CNCR_REL_CD\":\"10\",\"LTCP_OFFR_SEQ_NO\":\"2\",\"BDAY\":\"19400205\",\"CTR_FR_DT\":\"20220411\",\"LTC_ADMIN_SYM\":\"24159000563\",\"ETC_XPLN1\":\"1\",\"WIM_ITM_CD\":\"06\",\"CNCR_HP_LOC_NO\":\"010\",\"PPE_TERM\":\"0\",\"CTR_TO_DT\":\"20220411\",\"WIM_ITM_CD_NM\":\"미끄럼 방지용품\",\"CNCR_TEL_SEQ_NO\":\"0118\",\"POF_TO_DT\":\"20220411\",\"WLR_MTHD_CD\":\"1\",\"PROC_CD\":\"F30091079107\",\"PRDCT_NM\":\"4DM-204\",\"CNCR_HP_BUR_NO\":\"2059\",\"_ROW_STATUS\":\"1\"},{\"BCD_NO\":\"211200010725\",\"CNCR_TEL_NO\":\"01020590118\",\"CNCR_HP_NO\":\"01020590118\",\"WIM_CD\":\"F30091079107\",\"TOT_AMT\":\"3100\",\"WEL_PAY_STL_NM\":\"판매\",\"PERIOD\":\"2022-04-11\",\"JUMIN_BDAY\":\"400205\",\"CNCR_BDAY\":\"19400205\",\"CNCR_TEL_LOC_NO\":\"010\",\"CNCR_NM\":\"이병녀\",\"CNCR_TEL_BUR_NO\":\"2059\",\"LTCP_CTR_NO\":\"202214388709\",\"CNCR_HP_SEQ_NO\":\"0118\",\"MECH_AMT\":\"3100\",\"PRSN_TOT\":\"6133590\",\"POF_FR_DT\":\"20220411\",\"CNCR_REL_CD\":\"10\",\"LTCP_OFFR_SEQ_NO\":\"1\",\"BDAY\":\"19400205\",\"CTR_FR_DT\":\"20220411\",\"LTC_ADMIN_SYM\":\"24159000563\",\"ETC_XPLN1\":\"1\",\"WIM_ITM_CD\":\"06\",\"CNCR_HP_LOC_NO\":\"010\",\"PPE_TERM\":\"0\",\"CTR_TO_DT\":\"20220411\",\"WIM_ITM_CD_NM\":\"미끄럼 방지용품\",\"CNCR_TEL_SEQ_NO\":\"0118\",\"POF_TO_DT\":\"20220411\",\"WLR_MTHD_CD\":\"1\",\"PROC_CD\":\"F30091079107\",\"PRDCT_NM\":\"4DM-204\",\"CNCR_HP_BUR_NO\":\"2059\",\"_ROW_STATUS\":\"1\"},{\"BCD_NO\":\"220200001561\",\"CNCR_TEL_NO\":\"01020590118\",\"CNCR_HP_NO\":\"01020590118\",\"WIM_CD\":\"F30031059104\",\"TOT_AMT\":\"51300\",\"WEL_PAY_STL_NM\":\"판매\",\"PERIOD\":\"2022-04-11\",\"JUMIN_BDAY\":\"400205\",\"CNCR_BDAY\":\"19400205\",\"CNCR_TEL_LOC_NO\":\"010\",\"CNCR_NM\":\"이병녀\",\"CNCR_TEL_BUR_NO\":\"2059\",\"LTCP_CTR_NO\":\"202214430422\",\"CNCR_HP_SEQ_NO\":\"0118\",\"MECH_AMT\":\"51300\",\"PRSN_TOT\":\"6133590\",\"POF_FR_DT\":\"20220411\",\"CNCR_REL_CD\":\"10\",\"LTCP_OFFR_SEQ_NO\":\"1\",\"BDAY\":\"19400205\",\"CTR_FR_DT\":\"20220411\",\"LTC_ADMIN_SYM\":\"24159000563\",\"ETC_XPLN1\":\"1\",\"WIM_ITM_CD\":\"06\",\"CNCR_HP_LOC_NO\":\"010\",\"PPE_TERM\":\"0\",\"CTR_TO_DT\":\"20220411\",\"WIM_ITM_CD_NM\":\"미끄럼 방지용품\",\"CNCR_TEL_SEQ_NO\":\"0118\",\"POF_TO_DT\":\"20220411\",\"WLR_MTHD_CD\":\"1\",\"PROC_CD\":\"F30031059104\",\"PRDCT_NM\":\"NT-3050\",\"CNCR_HP_BUR_NO\":\"2059\",\"_ROW_STATUS\":\"1\"},{\"BCD_NO\":\"220200003567\",\"CNCR_TEL_NO\":\"01020590118\",\"CNCR_HP_NO\":\"01020590118\",\"WIM_CD\":\"F30031067109\",\"TOT_AMT\":\"33200\",\"WEL_PAY_STL_NM\":\"판매\",\"PERIOD\":\"2022-06-09\",\"JUMIN_BDAY\":\"400205\",\"CNCR_BDAY\":\"19400205\",\"CNCR_TEL_LOC_NO\":\"010\",\"CNCR_NM\":\"이병녀\",\"CNCR_TEL_BUR_NO\":\"2059\",\"LTCP_CTR_NO\":\"202214775150\",\"CNCR_HP_SEQ_NO\":\"0118\",\"MECH_AMT\":\"33200\",\"PRSN_TOT\":\"6133590\",\"POF_FR_DT\":\"20220609\",\"CNCR_REL_CD\":\"10\",\"LTCP_OFFR_SEQ_NO\":\"5\",\"BDAY\":\"19400205\",\"CTR_FR_DT\":\"20220609\",\"LTC_ADMIN_SYM\":\"24159000563\",\"ETC_XPLN1\":\"1\",\"WIM_ITM_CD\":\"06\",\"CNCR_HP_LOC_NO\":\"010\",\"PPE_TERM\":\"0\",\"CTR_TO_DT\":\"20220609\",\"WIM_ITM_CD_NM\":\"미끄럼 방지용품\",\"CNCR_TEL_SEQ_NO\":\"0118\",\"POF_TO_DT\":\"20220609\",\"WLR_MTHD_CD\":\"1\",\"PROC_CD\":\"F30031067109\",\"PRDCT_NM\":\"나이팅게일-C\",\"CNCR_HP_BUR_NO\":\"2059\",\"_ROW_STATUS\":\"1\"},{\"BCD_NO\":\"220200003566\",\"CNCR_TEL_NO\":\"01020590118\",\"CNCR_HP_NO\":\"01020590118\",\"WIM_CD\":\"F30031067109\",\"TOT_AMT\":\"33200\",\"WEL_PAY_STL_NM\":\"판매\",\"PERIOD\":\"2022-06-09\",\"JUMIN_BDAY\":\"400205\",\"CNCR_BDAY\":\"19400205\",\"CNCR_TEL_LOC_NO\":\"010\",\"CNCR_NM\":\"이병녀\",\"CNCR_TEL_BUR_NO\":\"2059\",\"LTCP_CTR_NO\":\"202214775150\",\"CNCR_HP_SEQ_NO\":\"0118\",\"MECH_AMT\":\"33200\",\"PRSN_TOT\":\"6133590\",\"POF_FR_DT\":\"20220609\",\"CNCR_REL_CD\":\"10\",\"LTCP_OFFR_SEQ_NO\":\"4\",\"BDAY\":\"19400205\",\"CTR_FR_DT\":\"20220609\",\"LTC_ADMIN_SYM\":\"24159000563\",\"ETC_XPLN1\":\"1\",\"WIM_ITM_CD\":\"06\",\"CNCR_HP_LOC_NO\":\"010\",\"PPE_TERM\":\"0\",\"CTR_TO_DT\":\"20220609\",\"WIM_ITM_CD_NM\":\"미끄럼 방지용품\",\"CNCR_TEL_SEQ_NO\":\"0118\",\"POF_TO_DT\":\"20220609\",\"WLR_MTHD_CD\":\"1\",\"PROC_CD\":\"F30031067109\",\"PRDCT_NM\":\"나이팅게일-C\",\"CNCR_HP_BUR_NO\":\"2059\",\"_ROW_STATUS\":\"1\"},{\"BCD_NO\":\"220300003433\",\"CNCR_TEL_NO\":\"01020590118\",\"CNCR_HP_NO\":\"01020590118\",\"WIM_CD\":\"F30031067109\",\"TOT_AMT\":\"33200\",\"WEL_PAY_STL_NM\":\"판매\",\"PERIOD\":\"2022-06-09\",\"JUMIN_BDAY\":\"400205\",\"CNCR_BDAY\":\"19400205\",\"CNCR_TEL_LOC_NO\":\"010\",\"CNCR_NM\":\"이병녀\",\"CNCR_TEL_BUR_NO\":\"2059\",\"LTCP_CTR_NO\":\"202214775150\",\"CNCR_HP_SEQ_NO\":\"0118\",\"MECH_AMT\":\"33200\",\"PRSN_TOT\":\"6133590\",\"POF_FR_DT\":\"20220609\",\"CNCR_REL_CD\":\"10\",\"LTCP_OFFR_SEQ_NO\":\"2\",\"BDAY\":\"19400205\",\"CTR_FR_DT\":\"20220609\",\"LTC_ADMIN_SYM\":\"24159000563\",\"ETC_XPLN1\":\"1\",\"WIM_ITM_CD\":\"06\",\"CNCR_HP_LOC_NO\":\"010\",\"PPE_TERM\":\"0\",\"CTR_TO_DT\":\"20220609\",\"WIM_ITM_CD_NM\":\"미끄럼 방지용품\",\"CNCR_TEL_SEQ_NO\":\"0118\",\"POF_TO_DT\":\"20220609\",\"WLR_MTHD_CD\":\"1\",\"PROC_CD\":\"F30031067109\",\"PRDCT_NM\":\"나이팅게일-C\",\"CNCR_HP_BUR_NO\":\"2059\",\"_ROW_STATUS\":\"1\"},{\"BCD_NO\":\"220500000674\",\"CNCR_TEL_NO\":\"01020590118\",\"CNCR_HP_NO\":\"01020590118\",\"WIM_CD\":\"F18030034104\",\"TOT_AMT\":\"201000\",\"WEL_PAY_STL_NM\":\"판매\",\"PERIOD\":\"2022-06-09\",\"JUMIN_BDAY\":\"400205\",\"CNCR_BDAY\":\"19400205\",\"CNCR_TEL_LOC_NO\":\"010\",\"CNCR_NM\":\"이병녀\",\"CNCR_TEL_BUR_NO\":\"2059\",\"LTCP_CTR_NO\":\"202214775150\",\"CNCR_HP_SEQ_NO\":\"0118\",\"MECH_AMT\":\"201000\",\"PRSN_TOT\":\"6133590\",\"POF_FR_DT\":\"20220609\",\"CNCR_REL_CD\":\"10\",\"LTCP_OFFR_SEQ_NO\":\"1\",\"BDAY\":\"19400205\",\"CTR_FR_DT\":\"20220609\",\"LTC_ADMIN_SYM\":\"24159000563\",\"ETC_XPLN1\":\"1\",\"WIM_ITM_CD\":\"05\",\"CNCR_HP_LOC_NO\":\"010\",\"PPE_TERM\":\"0\",\"CTR_TO_DT\":\"20220609\",\"WIM_ITM_CD_NM\":\"안전손잡이\",\"CNCR_TEL_SEQ_NO\":\"0118\",\"POF_TO_DT\":\"20220609\",\"WLR_MTHD_CD\":\"1\",\"PROC_CD\":\"F18030034104\",\"PRDCT_NM\":\"MSH-502\",\"CNCR_HP_BUR_NO\":\"2059\",\"_ROW_STATUS\":\"1\"},{\"BCD_NO\":\"220300003434\",\"CNCR_TEL_NO\":\"01020590118\",\"CNCR_HP_NO\":\"01020590118\",\"WIM_CD\":\"F30031067109\",\"TOT_AMT\":\"33200\",\"WEL_PAY_STL_NM\":\"판매\",\"PERIOD\":\"2022-06-09\",\"JUMIN_BDAY\":\"400205\",\"CNCR_BDAY\":\"19400205\",\"CNCR_TEL_LOC_NO\":\"010\",\"CNCR_NM\":\"이병녀\",\"CNCR_TEL_BUR_NO\":\"2059\",\"LTCP_CTR_NO\":\"202214775150\",\"CNCR_HP_SEQ_NO\":\"0118\",\"MECH_AMT\":\"33200\",\"PRSN_TOT\":\"6133590\",\"POF_FR_DT\":\"20220609\",\"CNCR_REL_CD\":\"10\",\"LTCP_OFFR_SEQ_NO\":\"3\",\"BDAY\":\"19400205\",\"CTR_FR_DT\":\"20220609\",\"LTC_ADMIN_SYM\":\"24159000563\",\"ETC_XPLN1\":\"1\",\"WIM_ITM_CD\":\"06\",\"CNCR_HP_LOC_NO\":\"010\",\"PPE_TERM\":\"0\",\"CTR_TO_DT\":\"20220609\",\"WIM_ITM_CD_NM\":\"미끄럼 방지용품\",\"CNCR_TEL_SEQ_NO\":\"0118\",\"POF_TO_DT\":\"20220609\",\"WLR_MTHD_CD\":\"1\",\"PROC_CD\":\"F30031067109\",\"PRDCT_NM\":\"나이팅게일-C\",\"CNCR_HP_BUR_NO\":\"2059\",\"_ROW_STATUS\":\"1\"},{\"BCD_NO\":\"180500000045\",\"CNCR_TEL_NO\":\"00000000000\",\"CNCR_HP_NO\":null,\"WIM_CD\":\"M18030111103\",\"TOT_AMT\":\"232350\",\"WEL_PAY_STL_NM\":\"대여\",\"PERIOD\":\"2022-08-01~2023-03-28\",\"JUMIN_BDAY\":\"400205\",\"CNCR_BDAY\":\"19400205\",\"CNCR_TEL_LOC_NO\":\"000\",\"CNCR_NM\":\"이병녀\",\"CNCR_TEL_BUR_NO\":\"0000\",\"LTCP_CTR_NO\":\"202215171216\",\"CNCR_HP_SEQ_NO\":null,\"MECH_AMT\":\"29400\",\"PRSN_TOT\":\"6133590\",\"POF_FR_DT\":\"20220801\",\"CNCR_REL_CD\":\"10\",\"LTCP_OFFR_SEQ_NO\":\"1\",\"BDAY\":\"19400205\",\"CTR_FR_DT\":\"20220801\",\"LTC_ADMIN_SYM\":\"22824500495\",\"ETC_XPLN1\":\"1\",\"WIM_ITM_CD\":\"11\",\"CNCR_HP_LOC_NO\":null,\"PPE_TERM\":\"5\",\"CTR_TO_DT\":\"20230328\",\"WIM_ITM_CD_NM\":\"수동휠체어\",\"CNCR_TEL_SEQ_NO\":\"0000\",\"POF_TO_DT\":\"20230328\",\"WLR_MTHD_CD\":\"2\",\"PROC_CD\":\"M18030111103\",\"PRDCT_NM\":\"MiKi-W AH\",\"CNCR_HP_BUR_NO\":null,\"_ROW_STATUS\":\"1\"},{\"BCD_NO\":\"200400000262\",\"CNCR_TEL_NO\":\"01020590118\",\"CNCR_HP_NO\":\"01020590118\",\"WIM_CD\":\"S03091064102\",\"TOT_AMT\":\"221820\",\"WEL_PAY_STL_NM\":\"대여\",\"PERIOD\":\"2022-09-07~2022-12-06\",\"JUMIN_BDAY\":\"400205\",\"CNCR_BDAY\":null,\"CNCR_TEL_LOC_NO\":\"010\",\"CNCR_NM\":\"최미영\",\"CNCR_TEL_BUR_NO\":\"2059\",\"LTCP_CTR_NO\":\"202215329348\",\"CNCR_HP_SEQ_NO\":\"0118\",\"MECH_AMT\":\"74100\",\"PRSN_TOT\":\"6133590\",\"POF_FR_DT\":\"20220907\",\"CNCR_REL_CD\":\"22\",\"LTCP_OFFR_SEQ_NO\":\"1\",\"BDAY\":\"19400205\",\"CTR_FR_DT\":\"20220907\",\"LTC_ADMIN_SYM\":\"34113000586\",\"ETC_XPLN1\":\"1\",\"WIM_ITM_CD\":\"12\",\"CNCR_HP_LOC_NO\":\"010\",\"PPE_TERM\":\"10\",\"CTR_TO_DT\":\"20221206\",\"WIM_ITM_CD_NM\":\"전동침대\",\"CNCR_TEL_SEQ_NO\":\"0118\",\"POF_TO_DT\":\"20221206\",\"WLR_MTHD_CD\":\"2\",\"PROC_CD\":\"S03091064102\",\"PRDCT_NM\":\"NY-1100\",\"CNCR_HP_BUR_NO\":\"2059\",\"_ROW_STATUS\":\"1\"},{\"BCD_NO\":\"220800001189\",\"CNCR_TEL_NO\":\"00000000000\",\"CNCR_HP_NO\":null,\"WIM_CD\":\"H12060031003\",\"TOT_AMT\":\"241000\",\"WEL_PAY_STL_NM\":\"판매\",\"PERIOD\":\"2022-09-20\",\"JUMIN_BDAY\":\"400205\",\"CNCR_BDAY\":\"19400205\",\"CNCR_TEL_LOC_NO\":\"000\",\"CNCR_NM\":\"이병녀\",\"CNCR_TEL_BUR_NO\":\"0000\",\"LTCP_CTR_NO\":\"202215352510\",\"CNCR_HP_SEQ_NO\":null,\"MECH_AMT\":\"241000\",\"PRSN_TOT\":\"6133590\",\"POF_FR_DT\":\"20220920\",\"CNCR_REL_CD\":\"10\",\"LTCP_OFFR_SEQ_NO\":\"1\",\"BDAY\":\"19400205\",\"CTR_FR_DT\":\"20220920\",\"LTC_ADMIN_SYM\":\"22824500495\",\"ETC_XPLN1\":\"1\",\"WIM_ITM_CD\":\"14\",\"CNCR_HP_LOC_NO\":null,\"PPE_TERM\":\"3\",\"CTR_TO_DT\":\"20220920\",\"WIM_ITM_CD_NM\":\"욕창예방 매트리스\",\"CNCR_TEL_SEQ_NO\":\"0000\",\"POF_TO_DT\":\"20220920\",\"WLR_MTHD_CD\":\"1\",\"PROC_CD\":\"H12060031003\",\"PRDCT_NM\":\"YB-1104A\",\"CNCR_HP_BUR_NO\":null,\"_ROW_STATUS\":\"1\"},{\"BCD_NO\":\"201100000574\",\"CNCR_TEL_NO\":\"00000000000\",\"CNCR_HP_NO\":null,\"WIM_CD\":\"S03091064103\",\"TOT_AMT\":\"261870\",\"WEL_PAY_STL_NM\":\"대여\",\"PERIOD\":\"2023-03-29~2023-07-14\",\"JUMIN_BDAY\":\"400205\",\"CNCR_BDAY\":\"19400205\",\"CNCR_TEL_LOC_NO\":\"000\",\"CNCR_NM\":\"이병녀\",\"CNCR_TEL_BUR_NO\":\"0000\",\"LTCP_CTR_NO\":\"202215859212\",\"CNCR_HP_SEQ_NO\":null,\"MECH_AMT\":\"73800\",\"PRSN_TOT\":\"6133590\",\"POF_FR_DT\":\"20230329\",\"CNCR_REL_CD\":\"10\",\"LTCP_OFFR_SEQ_NO\":\"2\",\"BDAY\":\"19400205\",\"CTR_FR_DT\":\"20221207\",\"LTC_ADMIN_SYM\":\"22824500495\",\"ETC_XPLN1\":\"1\",\"WIM_ITM_CD\":\"12\",\"CNCR_HP_LOC_NO\":null,\"PPE_TERM\":\"10\",\"CTR_TO_DT\":\"20230714\",\"WIM_ITM_CD_NM\":\"전동침대\",\"CNCR_TEL_SEQ_NO\":\"0000\",\"POF_TO_DT\":\"20230714\",\"WLR_MTHD_CD\":\"2\",\"PROC_CD\":\"S03091064103\",\"PRDCT_NM\":\"NY(M)-1300\",\"CNCR_HP_BUR_NO\":null,\"_ROW_STATUS\":\"1\"},{\"BCD_NO\":\"201100000574\",\"CNCR_TEL_NO\":\"00000000000\",\"CNCR_HP_NO\":null,\"WIM_CD\":\"S03091064103\",\"TOT_AMT\":\"273780\",\"WEL_PAY_STL_NM\":\"대여\",\"PERIOD\":\"2022-12-07~2023-03-28\",\"JUMIN_BDAY\":\"400205\",\"CNCR_BDAY\":\"19400205\",\"CNCR_TEL_LOC_NO\":\"000\",\"CNCR_NM\":\"이병녀\",\"CNCR_TEL_BUR_NO\":\"0000\",\"LTCP_CTR_NO\":\"202215859212\",\"CNCR_HP_SEQ_NO\":null,\"MECH_AMT\":\"73800\",\"PRSN_TOT\":\"6133590\",\"POF_FR_DT\":\"20221207\",\"CNCR_REL_CD\":\"10\",\"LTCP_OFFR_SEQ_NO\":\"1\",\"BDAY\":\"19400205\",\"CTR_FR_DT\":\"20221207\",\"LTC_ADMIN_SYM\":\"22824500495\",\"ETC_XPLN1\":\"1\",\"WIM_ITM_CD\":\"12\",\"CNCR_HP_LOC_NO\":null,\"PPE_TERM\":\"10\",\"CTR_TO_DT\":\"20230714\",\"WIM_ITM_CD_NM\":\"전동침대\",\"CNCR_TEL_SEQ_NO\":\"0000\",\"POF_TO_DT\":\"20230328\",\"WLR_MTHD_CD\":\"2\",\"PROC_CD\":\"S03091064103\",\"PRDCT_NM\":\"NY(M)-1300\",\"CNCR_HP_BUR_NO\":null,\"_ROW_STATUS\":\"1\"},{\"BCD_NO\":\"180500000045\",\"CNCR_TEL_NO\":\"00000000000\",\"CNCR_HP_NO\":null,\"WIM_CD\":\"M18030111103\",\"TOT_AMT\":\"16440\",\"WEL_PAY_STL_NM\":\"대여\",\"PERIOD\":\"2023-06-11~2023-07-14\",\"JUMIN_BDAY\":\"400205\",\"CNCR_BDAY\":\"19400205\",\"CNCR_TEL_LOC_NO\":\"000\",\"CNCR_NM\":\"이병녀\",\"CNCR_TEL_BUR_NO\":\"0000\",\"LTCP_CTR_NO\":\"202316374614\",\"CNCR_HP_SEQ_NO\":null,\"MECH_AMT\":\"14700\",\"PRSN_TOT\":\"6133590\",\"POF_FR_DT\":\"20230611\",\"CNCR_REL_CD\":\"10\",\"LTCP_OFFR_SEQ_NO\":\"2\",\"BDAY\":\"19400205\",\"CTR_FR_DT\":\"20230329\",\"LTC_ADMIN_SYM\":\"22824500495\",\"ETC_XPLN1\":\"1\",\"WIM_ITM_CD\":\"11\",\"CNCR_HP_LOC_NO\":null,\"PPE_TERM\":\"5\",\"CTR_TO_DT\":\"20230714\",\"WIM_ITM_CD_NM\":\"수동휠체어\",\"CNCR_TEL_SEQ_NO\":\"0000\",\"POF_TO_DT\":\"20230714\",\"WLR_MTHD_CD\":\"2\",\"PROC_CD\":\"M18030111103\",\"PRDCT_NM\":\"MiKi-W AH\",\"CNCR_HP_BUR_NO\":null,\"_ROW_STATUS\":\"1\"},{\"BCD_NO\":\"180500000045\",\"CNCR_TEL_NO\":\"00000000000\",\"CNCR_HP_NO\":null,\"WIM_CD\":\"M18030111103\",\"TOT_AMT\":\"71450\",\"WEL_PAY_STL_NM\":\"대여\",\"PERIOD\":\"2023-03-29~2023-06-10\",\"JUMIN_BDAY\":\"400205\",\"CNCR_BDAY\":\"19400205\",\"CNCR_TEL_LOC_NO\":\"000\",\"CNCR_NM\":\"이병녀\",\"CNCR_TEL_BUR_NO\":\"0000\",\"LTCP_CTR_NO\":\"202316374614\",\"CNCR_HP_SEQ_NO\":null,\"MECH_AMT\":\"29400\",\"PRSN_TOT\":\"6133590\",\"POF_FR_DT\":\"20230329\",\"CNCR_REL_CD\":\"10\",\"LTCP_OFFR_SEQ_NO\":\"1\",\"BDAY\":\"19400205\",\"CTR_FR_DT\":\"20230329\",\"LTC_ADMIN_SYM\":\"22824500495\",\"ETC_XPLN1\":\"1\",\"WIM_ITM_CD\":\"11\",\"CNCR_HP_LOC_NO\":null,\"PPE_TERM\":\"5\",\"CTR_TO_DT\":\"20230714\",\"WIM_ITM_CD_NM\":\"수동휠체어\",\"CNCR_TEL_SEQ_NO\":\"0000\",\"POF_TO_DT\":\"20230610\",\"WLR_MTHD_CD\":\"2\",\"PROC_CD\":\"M18030111103\",\"PRDCT_NM\":\"MiKi-W AH\",\"CNCR_HP_BUR_NO\":null,\"_ROW_STATUS\":\"1\"},{\"BCD_NO\":\"221100000338\",\"CNCR_TEL_NO\":\"01094616449\",\"CNCR_HP_NO\":\"01094616449\",\"WIM_CD\":\"M03031033103\",\"TOT_AMT\":\"61500\",\"WEL_PAY_STL_NM\":\"판매\",\"PERIOD\":\"2023-03-30\",\"JUMIN_BDAY\":\"400205\",\"CNCR_BDAY\":\"19400205\",\"CNCR_TEL_LOC_NO\":\"010\",\"CNCR_NM\":\"이병녀\",\"CNCR_TEL_BUR_NO\":\"9461\",\"LTCP_CTR_NO\":\"202316593203\",\"CNCR_HP_SEQ_NO\":\"6449\",\"MECH_AMT\":\"61500\",\"PRSN_TOT\":\"6133590\",\"POF_FR_DT\":\"20230330\",\"CNCR_REL_CD\":\"10\",\"LTCP_OFFR_SEQ_NO\":\"1\",\"BDAY\":\"19400205\",\"CTR_FR_DT\":\"20230330\",\"LTC_ADMIN_SYM\":\"24146000855\",\"ETC_XPLN1\":\"1\",\"WIM_ITM_CD\":\"08\",\"CNCR_HP_LOC_NO\":\"010\",\"PPE_TERM\":\"2\",\"CTR_TO_DT\":\"20230330\",\"WIM_ITM_CD_NM\":\"지팡이\",\"CNCR_TEL_SEQ_NO\":\"6449\",\"POF_TO_DT\":\"20230330\",\"WLR_MTHD_CD\":\"1\",\"PROC_CD\":\"M03031033103\",\"PRDCT_NM\":\"아이온 사발지팡이\",\"CNCR_HP_BUR_NO\":\"9461\",\"_ROW_STATUS\":\"1\"},{\"BCD_NO\":\"180500000045\",\"CNCR_TEL_NO\":\"00000000000\",\"CNCR_HP_NO\":null,\"WIM_CD\":\"M18030111103\",\"TOT_AMT\":\"124240\",\"WEL_PAY_STL_NM\":\"대여\",\"PERIOD\":\"2023-07-15~2024-03-28\",\"JUMIN_BDAY\":\"400205\",\"CNCR_BDAY\":\"19400205\",\"CNCR_TEL_LOC_NO\":\"000\",\"CNCR_NM\":\"이병녀\",\"CNCR_TEL_BUR_NO\":\"0000\",\"LTCP_CTR_NO\":\"202317048029\",\"CNCR_HP_SEQ_NO\":null,\"MECH_AMT\":\"14700\",\"PRSN_TOT\":\"6133590\",\"POF_FR_DT\":\"20230715\",\"CNCR_REL_CD\":\"10\",\"LTCP_OFFR_SEQ_NO\":\"1\",\"BDAY\":\"19400205\",\"CTR_FR_DT\":\"20230715\",\"LTC_ADMIN_SYM\":\"22824500495\",\"ETC_XPLN1\":\"1\",\"WIM_ITM_CD\":\"11\",\"CNCR_HP_LOC_NO\":null,\"PPE_TERM\":\"5\",\"CTR_TO_DT\":\"20240328\",\"WIM_ITM_CD_NM\":\"수동휠체어\",\"CNCR_TEL_SEQ_NO\":\"0000\",\"POF_TO_DT\":\"20240328\",\"WLR_MTHD_CD\":\"2\",\"PROC_CD\":\"M18030111103\",\"PRDCT_NM\":\"MiKi-W AH\",\"CNCR_HP_BUR_NO\":null,\"_ROW_STATUS\":\"1\"},{\"BCD_NO\":\"201100000574\",\"CNCR_TEL_NO\":\"00000000000\",\"CNCR_HP_NO\":null,\"WIM_CD\":\"S03091064103\",\"TOT_AMT\":\"623730\",\"WEL_PAY_STL_NM\":\"대여\",\"PERIOD\":\"2023-07-15~2024-03-28\",\"JUMIN_BDAY\":\"400205\",\"CNCR_BDAY\":\"19400205\",\"CNCR_TEL_LOC_NO\":\"000\",\"CNCR_NM\":\"이병녀\",\"CNCR_TEL_BUR_NO\":\"0000\",\"LTCP_CTR_NO\":\"202317077721\",\"CNCR_HP_SEQ_NO\":null,\"MECH_AMT\":\"73800\",\"PRSN_TOT\":\"6133590\",\"POF_FR_DT\":\"20230715\",\"CNCR_REL_CD\":\"10\",\"LTCP_OFFR_SEQ_NO\":\"1\",\"BDAY\":\"19400205\",\"CTR_FR_DT\":\"20230715\",\"LTC_ADMIN_SYM\":\"22824500495\",\"ETC_XPLN1\":\"1\",\"WIM_ITM_CD\":\"12\",\"CNCR_HP_LOC_NO\":null,\"PPE_TERM\":\"10\",\"CTR_TO_DT\":\"20240328\",\"WIM_ITM_CD_NM\":\"전동침대\",\"CNCR_TEL_SEQ_NO\":\"0000\",\"POF_TO_DT\":\"20240328\",\"WLR_MTHD_CD\":\"2\",\"PROC_CD\":\"S03091064103\",\"PRDCT_NM\":\"NY(M)-1300\",\"CNCR_HP_BUR_NO\":null,\"_ROW_STATUS\":\"1\"},{\"BCD_NO\":\"230900000249\",\"CNCR_TEL_NO\":\"01094616449\",\"CNCR_HP_NO\":\"01094616449\",\"WIM_CD\":\"H12030184001\",\"TOT_AMT\":\"240000\",\"WEL_PAY_STL_NM\":\"판매\",\"PERIOD\":\"2023-09-22\",\"JUMIN_BDAY\":\"400205\",\"CNCR_BDAY\":\"19400205\",\"CNCR_TEL_LOC_NO\":\"010\",\"CNCR_NM\":\"이병녀\",\"CNCR_TEL_BUR_NO\":\"9461\",\"LTCP_CTR_NO\":\"202317679063\",\"CNCR_HP_SEQ_NO\":\"6449\",\"MECH_AMT\":\"240000\",\"PRSN_TOT\":\"6133590\",\"POF_FR_DT\":\"20230922\",\"CNCR_REL_CD\":\"10\",\"LTCP_OFFR_SEQ_NO\":\"1\",\"BDAY\":\"19400205\",\"CTR_FR_DT\":\"20230922\",\"LTC_ADMIN_SYM\":\"31174000262\",\"ETC_XPLN1\":\"1\",\"WIM_ITM_CD\":\"09\",\"CNCR_HP_LOC_NO\":\"010\",\"PPE_TERM\":\"3\",\"CTR_TO_DT\":\"20230922\",\"WIM_ITM_CD_NM\":\"욕창예방방석\",\"CNCR_TEL_SEQ_NO\":\"6449\",\"POF_TO_DT\":\"20230922\",\"WLR_MTHD_CD\":\"1\",\"PROC_CD\":\"H12030184001\",\"PRDCT_NM\":\"CD-04\",\"CNCR_HP_BUR_NO\":\"9461\",\"_ROW_STATUS\":\"1\"}]},\"ApiTxKey\":\"0275214e-f7a6-4330-bc97-5509a077f530\",\"Status\":\"OK\",\"StatusSeq\":0,\"ErrorCode\":0,\"Message\":\"성공\",\"ErrorLog\":null,\"TargetCode\":null,\"TargetMessage\":null}";

		return responseStr;
	}
	
	//수급자의 가능품목, 불가능 품목
	public String getTestDataPayPsb(){
		String responseStr = "{\"Result\":{\"ds_payPsblLnd1\":[{\"WIM_ITM_CD\":\"수동휠체어\",\"_ROW_STATUS\":\"1\"},{\"WIM_ITM_CD\":\"전동침대\",\"_ROW_STATUS\":\"1\"},{\"WIM_ITM_CD\":\"수동침대\",\"_ROW_STATUS\":\"1\"},{\"WIM_ITM_CD\":\"욕창예방 매트리스\",\"_ROW_STATUS\":\"1\"},{\"WIM_ITM_CD\":\"이동욕조\",\"_ROW_STATUS\":\"1\"},{\"WIM_ITM_CD\":\"목욕리프트\",\"_ROW_STATUS\":\"1\"},{\"WIM_ITM_CD\":\"배회감지기\",\"_ROW_STATUS\":\"1\"},{\"WIM_ITM_CD\":\"경사로(실외용)\",\"_ROW_STATUS\":\"1\"}],\"ds_payPsblLnd2\":[],\"ds_payPsbl1\":[{\"WIM_ITM_CD\":\"이동변기\",\"_ROW_STATUS\":\"1\"},{\"WIM_ITM_CD\":\"목욕의자\",\"_ROW_STATUS\":\"1\"},{\"WIM_ITM_CD\":\"안전손잡이\",\"_ROW_STATUS\":\"1\"},{\"WIM_ITM_CD\":\"미끄럼 방지용품\",\"_ROW_STATUS\":\"1\"},{\"WIM_ITM_CD\":\"간이변기\",\"_ROW_STATUS\":\"1\"},{\"WIM_ITM_CD\":\"지팡이\",\"_ROW_STATUS\":\"1\"},{\"WIM_ITM_CD\":\"욕창예방방석\",\"_ROW_STATUS\":\"1\"},{\"WIM_ITM_CD\":\"자세변환용구\",\"_ROW_STATUS\":\"1\"},{\"WIM_ITM_CD\":\"욕창예방 매트리스\",\"_ROW_STATUS\":\"1\"},{\"WIM_ITM_CD\":\"성인용보행기\",\"_ROW_STATUS\":\"1\"},{\"WIM_ITM_CD\":\"요실금팬티\",\"_ROW_STATUS\":\"1\"},{\"WIM_ITM_CD\":\"경사로(실내용)\",\"_ROW_STATUS\":\"1\"}],\"ds_payPsbl2\":[]},\"ApiTxKey\":\"65d2833a-c4f9-47a5-be38-91663476e170\",\"Status\":\"OK\",\"StatusSeq\":0,\"ErrorCode\":0,\"Message\":\"성공\",\"ErrorLog\":null,\"TargetCode\":null,\"TargetMessage\":null}";

		return responseStr;
	}
	
	//수급자의 계약 상품 리스트
	public String getTestDataContractItemHistory(){
		String responseStr = "{\"Result\":{\"ds_result\":[{\"BCD_NO\":\"230900000249\",\"CTR_DT\":\"20230927\",\"ETC1\":\"1\",\"POF_FR_DT\":\"2023-09-22\",\"CNCR_REL_CD\":\"10\",\"LTC_MGMT_NO\":\"L0011559991\",\"WIM_CD\":\"H12030184001\",\"TOT_AMT\":\"240000\",\"QLF_TYPE\":\"일반\",\"NO\":\"1\",\"JUMIN_NO\":\"4002052247918\",\"LTC_RCGT_GRADE_CD\":\"1등급\",\"MGDS_NM\":\"CD-04\",\"CNCR_NM\":\"이병녀\",\"CNCL_YN\":\"정상\",\"WLR_MTHD_CD\":\"판매\",\"PROD_NM\":\"욕창예방방석\",\"IN_TYPE\":\"포털\",\"CNCR_REL_CD_NM\":\"본인\",\"_ROW_STATUS\":\"1\"},{\"BCD_NO\":\"201100000574\",\"CTR_DT\":\"20230620\",\"ETC1\":\"1\",\"POF_FR_DT\":\"2023-07-15~2024-03-28\",\"CNCR_REL_CD\":\"10\",\"LTC_MGMT_NO\":\"L0011559991\",\"WIM_CD\":\"S03091064103\",\"TOT_AMT\":\"623730\",\"QLF_TYPE\":\"일반\",\"NO\":\"2\",\"JUMIN_NO\":\"4002052247918\",\"LTC_RCGT_GRADE_CD\":\"1등급\",\"MGDS_NM\":\"NY(M)-1300\",\"CNCR_NM\":\"이병녀\",\"CNCL_YN\":\"정상\",\"WLR_MTHD_CD\":\"대여\",\"PROD_NM\":\"전동침대\",\"IN_TYPE\":\"포털\",\"CNCR_REL_CD_NM\":\"본인\",\"_ROW_STATUS\":\"1\"},{\"BCD_NO\":\"180500000045\",\"CTR_DT\":\"20230615\",\"ETC1\":\"1\",\"POF_FR_DT\":\"2023-07-15~2024-03-28\",\"CNCR_REL_CD\":\"10\",\"LTC_MGMT_NO\":\"L0011559991\",\"WIM_CD\":\"M18030111103\",\"TOT_AMT\":\"124240\",\"QLF_TYPE\":\"일반\",\"NO\":\"3\",\"JUMIN_NO\":\"4002052247918\",\"LTC_RCGT_GRADE_CD\":\"1등급\",\"MGDS_NM\":\"MiKi-W AH\",\"CNCR_NM\":\"이병녀\",\"CNCL_YN\":\"정상\",\"WLR_MTHD_CD\":\"대여\",\"PROD_NM\":\"수동휠체어\",\"IN_TYPE\":\"포털\",\"CNCR_REL_CD_NM\":\"본인\",\"_ROW_STATUS\":\"1\"},{\"BCD_NO\":\"221100000338\",\"CTR_DT\":\"20230405\",\"ETC1\":\"1\",\"POF_FR_DT\":\"2023-03-30\",\"CNCR_REL_CD\":\"10\",\"LTC_MGMT_NO\":\"L0011559991\",\"WIM_CD\":\"M03031033103\",\"TOT_AMT\":\"61500\",\"QLF_TYPE\":\"일반\",\"NO\":\"4\",\"JUMIN_NO\":\"4002052247918\",\"LTC_RCGT_GRADE_CD\":\"1등급\",\"MGDS_NM\":\"아이온 사발지팡이\",\"CNCR_NM\":\"이병녀\",\"CNCL_YN\":\"정상\",\"WLR_MTHD_CD\":\"판매\",\"PROD_NM\":\"지팡이\",\"IN_TYPE\":\"포털\",\"CNCR_REL_CD_NM\":\"본인\",\"_ROW_STATUS\":\"1\"},{\"BCD_NO\":\"180500000045\",\"CTR_DT\":\"20230303\",\"ETC1\":\"1\",\"POF_FR_DT\":\"2023-03-29~2023-06-10\",\"CNCR_REL_CD\":\"10\",\"LTC_MGMT_NO\":\"L0011559991\",\"WIM_CD\":\"M18030111103\",\"TOT_AMT\":\"71450\",\"QLF_TYPE\":\"일반\",\"NO\":\"5\",\"JUMIN_NO\":\"4002052247918\",\"LTC_RCGT_GRADE_CD\":\"1등급\",\"MGDS_NM\":\"MiKi-W AH\",\"CNCR_NM\":\"이병녀\",\"CNCL_YN\":\"정상\",\"WLR_MTHD_CD\":\"대여\",\"PROD_NM\":\"수동휠체어\",\"IN_TYPE\":\"포털\",\"CNCR_REL_CD_NM\":\"본인\",\"_ROW_STATUS\":\"1\"},{\"BCD_NO\":\"180500000045\",\"CTR_DT\":\"20230303\",\"ETC1\":\"1\",\"POF_FR_DT\":\"2023-06-11~2023-07-14\",\"CNCR_REL_CD\":\"10\",\"LTC_MGMT_NO\":\"L0011559991\",\"WIM_CD\":\"M18030111103\",\"TOT_AMT\":\"16440\",\"QLF_TYPE\":\"일반\",\"NO\":\"6\",\"JUMIN_NO\":\"4002052247918\",\"LTC_RCGT_GRADE_CD\":\"1등급\",\"MGDS_NM\":\"MiKi-W AH\",\"CNCR_NM\":\"이병녀\",\"CNCL_YN\":\"정상\",\"WLR_MTHD_CD\":\"대여\",\"PROD_NM\":\"수동휠체어\",\"IN_TYPE\":\"포털\",\"CNCR_REL_CD_NM\":\"본인\",\"_ROW_STATUS\":\"1\"},{\"BCD_NO\":\"201100000574\",\"CTR_DT\":\"20221207\",\"ETC1\":\"1\",\"POF_FR_DT\":\"2022-12-07~2023-03-28\",\"CNCR_REL_CD\":\"10\",\"LTC_MGMT_NO\":\"L0011559991\",\"WIM_CD\":\"S03091064103\",\"TOT_AMT\":\"273780\",\"QLF_TYPE\":\"일반\",\"NO\":\"7\",\"JUMIN_NO\":\"4002052247918\",\"LTC_RCGT_GRADE_CD\":\"1등급\",\"MGDS_NM\":\"NY(M)-1300\",\"CNCR_NM\":\"이병녀\",\"CNCL_YN\":\"정상\",\"WLR_MTHD_CD\":\"대여\",\"PROD_NM\":\"전동침대\",\"IN_TYPE\":\"포털\",\"CNCR_REL_CD_NM\":\"본인\",\"_ROW_STATUS\":\"1\"},{\"BCD_NO\":\"201100000574\",\"CTR_DT\":\"20221207\",\"ETC1\":\"1\",\"POF_FR_DT\":\"2023-03-29~2023-07-14\",\"CNCR_REL_CD\":\"10\",\"LTC_MGMT_NO\":\"L0011559991\",\"WIM_CD\":\"S03091064103\",\"TOT_AMT\":\"261870\",\"QLF_TYPE\":\"일반\",\"NO\":\"8\",\"JUMIN_NO\":\"4002052247918\",\"LTC_RCGT_GRADE_CD\":\"1등급\",\"MGDS_NM\":\"NY(M)-1300\",\"CNCR_NM\":\"이병녀\",\"CNCL_YN\":\"정상\",\"WLR_MTHD_CD\":\"대여\",\"PROD_NM\":\"전동침대\",\"IN_TYPE\":\"포털\",\"CNCR_REL_CD_NM\":\"본인\",\"_ROW_STATUS\":\"1\"},{\"BCD_NO\":\"200400000262\",\"CTR_DT\":\"20221206\",\"ETC1\":\"1\",\"POF_FR_DT\":\"2022-09-07~2022-12-06\",\"CNCR_REL_CD\":\"22\",\"LTC_MGMT_NO\":\"L0011559991\",\"WIM_CD\":\"S03091064102\",\"TOT_AMT\":\"221820\",\"QLF_TYPE\":\"일반\",\"NO\":\"9\",\"JUMIN_NO\":\"4002052247918\",\"LTC_RCGT_GRADE_CD\":\"1등급\",\"MGDS_NM\":\"NY-1100\",\"CNCR_NM\":\"최미영\",\"CNCL_YN\":\"변경\",\"WLR_MTHD_CD\":\"대여\",\"PROD_NM\":\"전동침대\",\"IN_TYPE\":\"포털\",\"CNCR_REL_CD_NM\":\"가족(자녀)\",\"_ROW_STATUS\":\"1\"},{\"BCD_NO\":\"220800001189\",\"CTR_DT\":\"20220920\",\"ETC1\":\"1\",\"POF_FR_DT\":\"2022-09-20\",\"CNCR_REL_CD\":\"10\",\"LTC_MGMT_NO\":\"L0011559991\",\"WIM_CD\":\"H12060031003\",\"TOT_AMT\":\"241000\",\"QLF_TYPE\":\"일반\",\"NO\":\"10\",\"JUMIN_NO\":\"4002052247918\",\"LTC_RCGT_GRADE_CD\":\"1등급\",\"MGDS_NM\":\"YB-1104A\",\"CNCR_NM\":\"이병녀\",\"CNCL_YN\":\"정상\",\"WLR_MTHD_CD\":\"판매\",\"PROD_NM\":\"욕창예방 매트리스\",\"IN_TYPE\":\"포털\",\"CNCR_REL_CD_NM\":\"본인\",\"_ROW_STATUS\":\"1\"},{\"BCD_NO\":\"180500000045\",\"CTR_DT\":\"20220817\",\"ETC1\":\"1\",\"POF_FR_DT\":\"2022-08-01~2023-03-28\",\"CNCR_REL_CD\":\"10\",\"LTC_MGMT_NO\":\"L0011559991\",\"WIM_CD\":\"M18030111103\",\"TOT_AMT\":\"232350\",\"QLF_TYPE\":\"일반\",\"NO\":\"11\",\"JUMIN_NO\":\"4002052247918\",\"LTC_RCGT_GRADE_CD\":\"1등급\",\"MGDS_NM\":\"MiKi-W AH\",\"CNCR_NM\":\"이병녀\",\"CNCL_YN\":\"정상\",\"WLR_MTHD_CD\":\"대여\",\"PROD_NM\":\"수동휠체어\",\"IN_TYPE\":\"포털\",\"CNCR_REL_CD_NM\":\"본인\",\"_ROW_STATUS\":\"1\"},{\"BCD_NO\":\"180500000045\",\"CTR_DT\":\"20220816\",\"ETC1\":\"1\",\"POF_FR_DT\":\"2021-03-29~2022-03-28\",\"CNCR_REL_CD\":\"10\",\"LTC_MGMT_NO\":\"L0011559991\",\"WIM_CD\":\"M18030111103\",\"TOT_AMT\":\"352800\",\"QLF_TYPE\":\"일반\",\"NO\":\"12\",\"JUMIN_NO\":\"4002052247918\",\"LTC_RCGT_GRADE_CD\":\"1등급\",\"MGDS_NM\":\"MiKi-W AH\",\"CNCR_NM\":\"이병녀\",\"CNCL_YN\":\"변경\",\"WLR_MTHD_CD\":\"대여\",\"PROD_NM\":\"수동휠체어\",\"IN_TYPE\":\"포털\",\"CNCR_REL_CD_NM\":\"본인\",\"_ROW_STATUS\":\"1\"},{\"BCD_NO\":\"180500000045\",\"CTR_DT\":\"20220816\",\"ETC1\":\"1\",\"POF_FR_DT\":\"2022-03-29~2022-07-31\",\"CNCR_REL_CD\":\"10\",\"LTC_MGMT_NO\":\"L0011559991\",\"WIM_CD\":\"M18030111103\",\"TOT_AMT\":\"120450\",\"QLF_TYPE\":\"일반\",\"NO\":\"13\",\"JUMIN_NO\":\"4002052247918\",\"LTC_RCGT_GRADE_CD\":\"1등급\",\"MGDS_NM\":\"MiKi-W AH\",\"CNCR_NM\":\"이병녀\",\"CNCL_YN\":\"변경\",\"WLR_MTHD_CD\":\"대여\",\"PROD_NM\":\"수동휠체어\",\"IN_TYPE\":\"포털\",\"CNCR_REL_CD_NM\":\"본인\",\"_ROW_STATUS\":\"1\"},{\"BCD_NO\":\"210200001282\",\"CTR_DT\":\"20220816\",\"ETC1\":\"1\",\"POF_FR_DT\":\"2021-03-29~2022-03-28\",\"CNCR_REL_CD\":\"10\",\"LTC_MGMT_NO\":\"L0011559991\",\"WIM_CD\":\"H12060031003\",\"TOT_AMT\":\"241200\",\"QLF_TYPE\":\"일반\",\"NO\":\"14\",\"JUMIN_NO\":\"4002052247918\",\"LTC_RCGT_GRADE_CD\":\"1등급\",\"MGDS_NM\":\"YB-1104A\",\"CNCR_NM\":\"이병녀\",\"CNCL_YN\":\"변경\",\"WLR_MTHD_CD\":\"대여\",\"PROD_NM\":\"욕창예방 매트리스\",\"IN_TYPE\":\"포털\",\"CNCR_REL_CD_NM\":\"본인\",\"_ROW_STATUS\":\"1\"},{\"BCD_NO\":\"210200001282\",\"CTR_DT\":\"20220816\",\"ETC1\":\"1\",\"POF_FR_DT\":\"2022-03-29~2022-04-25\",\"CNCR_REL_CD\":\"10\",\"LTC_MGMT_NO\":\"L0011559991\",\"WIM_CD\":\"H12060031003\",\"TOT_AMT\":\"18700\",\"QLF_TYPE\":\"일반\",\"NO\":\"15\",\"JUMIN_NO\":\"4002052247918\",\"LTC_RCGT_GRADE_CD\":\"1등급\",\"MGDS_NM\":\"YB-1104A\",\"CNCR_NM\":\"이병녀\",\"CNCL_YN\":\"변경\",\"WLR_MTHD_CD\":\"대여\",\"PROD_NM\":\"욕창예방 매트리스\",\"IN_TYPE\":\"포털\",\"CNCR_REL_CD_NM\":\"본인\",\"_ROW_STATUS\":\"1\"},{\"BCD_NO\":\"210100000590\",\"CTR_DT\":\"20220816\",\"ETC1\":\"1\",\"POF_FR_DT\":\"2021-03-29~2022-03-28\",\"CNCR_REL_CD\":\"10\",\"LTC_MGMT_NO\":\"L0011559991\",\"WIM_CD\":\"S03091064103\",\"TOT_AMT\":\"885600\",\"QLF_TYPE\":\"일반\",\"NO\":\"16\",\"JUMIN_NO\":\"4002052247918\",\"LTC_RCGT_GRADE_CD\":\"1등급\",\"MGDS_NM\":\"NY(M)-1300\",\"CNCR_NM\":\"이병녀\",\"CNCL_YN\":\"변경\",\"WLR_MTHD_CD\":\"대여\",\"PROD_NM\":\"전동침대\",\"IN_TYPE\":\"포털\",\"CNCR_REL_CD_NM\":\"본인\",\"_ROW_STATUS\":\"1\"},{\"BCD_NO\":\"210100000590\",\"CTR_DT\":\"20220816\",\"ETC1\":\"1\",\"POF_FR_DT\":\"2022-03-29~2022-04-25\",\"CNCR_REL_CD\":\"10\",\"LTC_MGMT_NO\":\"L0011559991\",\"WIM_CD\":\"S03091064103\",\"TOT_AMT\":\"68640\",\"QLF_TYPE\":\"일반\",\"NO\":\"17\",\"JUMIN_NO\":\"4002052247918\",\"LTC_RCGT_GRADE_CD\":\"1등급\",\"MGDS_NM\":\"NY(M)-1300\",\"CNCR_NM\":\"이병녀\",\"CNCL_YN\":\"변경\",\"WLR_MTHD_CD\":\"대여\",\"PROD_NM\":\"전동침대\",\"IN_TYPE\":\"포털\",\"CNCR_REL_CD_NM\":\"본인\",\"_ROW_STATUS\":\"1\"},{\"BCD_NO\":\"220200003566\",\"CTR_DT\":\"20220613\",\"ETC1\":\"1\",\"POF_FR_DT\":\"2022-06-09\",\"CNCR_REL_CD\":\"10\",\"LTC_MGMT_NO\":\"L0011559991\",\"WIM_CD\":\"F30031067109\",\"TOT_AMT\":\"33200\",\"QLF_TYPE\":\"일반\",\"NO\":\"18\",\"JUMIN_NO\":\"4002052247918\",\"LTC_RCGT_GRADE_CD\":\"1등급\",\"MGDS_NM\":\"나이팅게일-C\",\"CNCR_NM\":\"이병녀\",\"CNCL_YN\":\"정상\",\"WLR_MTHD_CD\":\"판매\",\"PROD_NM\":\"미끄럼 방지용품\",\"IN_TYPE\":\"포털\",\"CNCR_REL_CD_NM\":\"본인\",\"_ROW_STATUS\":\"1\"},{\"BCD_NO\":\"220200003567\",\"CTR_DT\":\"20220613\",\"ETC1\":\"1\",\"POF_FR_DT\":\"2022-06-09\",\"CNCR_REL_CD\":\"10\",\"LTC_MGMT_NO\":\"L0011559991\",\"WIM_CD\":\"F30031067109\",\"TOT_AMT\":\"33200\",\"QLF_TYPE\":\"일반\",\"NO\":\"19\",\"JUMIN_NO\":\"4002052247918\",\"LTC_RCGT_GRADE_CD\":\"1등급\",\"MGDS_NM\":\"나이팅게일-C\",\"CNCR_NM\":\"이병녀\",\"CNCL_YN\":\"정상\",\"WLR_MTHD_CD\":\"판매\",\"PROD_NM\":\"미끄럼 방지용품\",\"IN_TYPE\":\"포털\",\"CNCR_REL_CD_NM\":\"본인\",\"_ROW_STATUS\":\"1\"},{\"BCD_NO\":\"220300003433\",\"CTR_DT\":\"20220613\",\"ETC1\":\"1\",\"POF_FR_DT\":\"2022-06-09\",\"CNCR_REL_CD\":\"10\",\"LTC_MGMT_NO\":\"L0011559991\",\"WIM_CD\":\"F30031067109\",\"TOT_AMT\":\"33200\",\"QLF_TYPE\":\"일반\",\"NO\":\"20\",\"JUMIN_NO\":\"4002052247918\",\"LTC_RCGT_GRADE_CD\":\"1등급\",\"MGDS_NM\":\"나이팅게일-C\",\"CNCR_NM\":\"이병녀\",\"CNCL_YN\":\"정상\",\"WLR_MTHD_CD\":\"판매\",\"PROD_NM\":\"미끄럼 방지용품\",\"IN_TYPE\":\"포털\",\"CNCR_REL_CD_NM\":\"본인\",\"_ROW_STATUS\":\"1\"},{\"BCD_NO\":\"220300003434\",\"CTR_DT\":\"20220613\",\"ETC1\":\"1\",\"POF_FR_DT\":\"2022-06-09\",\"CNCR_REL_CD\":\"10\",\"LTC_MGMT_NO\":\"L0011559991\",\"WIM_CD\":\"F30031067109\",\"TOT_AMT\":\"33200\",\"QLF_TYPE\":\"일반\",\"NO\":\"21\",\"JUMIN_NO\":\"4002052247918\",\"LTC_RCGT_GRADE_CD\":\"1등급\",\"MGDS_NM\":\"나이팅게일-C\",\"CNCR_NM\":\"이병녀\",\"CNCL_YN\":\"정상\",\"WLR_MTHD_CD\":\"판매\",\"PROD_NM\":\"미끄럼 방지용품\",\"IN_TYPE\":\"포털\",\"CNCR_REL_CD_NM\":\"본인\",\"_ROW_STATUS\":\"1\"},{\"BCD_NO\":\"220500000674\",\"CTR_DT\":\"20220613\",\"ETC1\":\"1\",\"POF_FR_DT\":\"2022-06-09\",\"CNCR_REL_CD\":\"10\",\"LTC_MGMT_NO\":\"L0011559991\",\"WIM_CD\":\"F18030034104\",\"TOT_AMT\":\"201000\",\"QLF_TYPE\":\"일반\",\"NO\":\"22\",\"JUMIN_NO\":\"4002052247918\",\"LTC_RCGT_GRADE_CD\":\"1등급\",\"MGDS_NM\":\"MSH-502\",\"CNCR_NM\":\"이병녀\",\"CNCL_YN\":\"정상\",\"WLR_MTHD_CD\":\"판매\",\"PROD_NM\":\"안전손잡이\",\"IN_TYPE\":\"포털\",\"CNCR_REL_CD_NM\":\"본인\",\"_ROW_STATUS\":\"1\"},{\"BCD_NO\":\"220200001561\",\"CTR_DT\":\"20220418\",\"ETC1\":\"1\",\"POF_FR_DT\":\"2022-04-11\",\"CNCR_REL_CD\":\"10\",\"LTC_MGMT_NO\":\"L0011559991\",\"WIM_CD\":\"F30031059104\",\"TOT_AMT\":\"51300\",\"QLF_TYPE\":\"일반\",\"NO\":\"23\",\"JUMIN_NO\":\"4002052247918\",\"LTC_RCGT_GRADE_CD\":\"1등급\",\"MGDS_NM\":\"NT-3050\",\"CNCR_NM\":\"이병녀\",\"CNCL_YN\":\"정상\",\"WLR_MTHD_CD\":\"판매\",\"PROD_NM\":\"미끄럼 방지용품\",\"IN_TYPE\":\"포털\",\"CNCR_REL_CD_NM\":\"본인\",\"_ROW_STATUS\":\"1\"},{\"BCD_NO\":\"211200001384\",\"CTR_DT\":\"20220411\",\"ETC1\":\"1\",\"POF_FR_DT\":\"2022-04-11\",\"CNCR_REL_CD\":\"10\",\"LTC_MGMT_NO\":\"L0011559991\",\"WIM_CD\":\"F30091079107\",\"TOT_AMT\":\"3100\",\"QLF_TYPE\":\"일반\",\"NO\":\"24\",\"JUMIN_NO\":\"4002052247918\",\"LTC_RCGT_GRADE_CD\":\"1등급\",\"MGDS_NM\":\"4DM-204\",\"CNCR_NM\":\"이병녀\",\"CNCL_YN\":\"정상\",\"WLR_MTHD_CD\":\"판매\",\"PROD_NM\":\"미끄럼 방지용품\",\"IN_TYPE\":\"포털\",\"CNCR_REL_CD_NM\":\"본인\",\"_ROW_STATUS\":\"1\"},{\"BCD_NO\":\"211200001386\",\"CTR_DT\":\"20220411\",\"ETC1\":\"1\",\"POF_FR_DT\":\"2022-04-11\",\"CNCR_REL_CD\":\"10\",\"LTC_MGMT_NO\":\"L0011559991\",\"WIM_CD\":\"F30091079107\",\"TOT_AMT\":\"3100\",\"QLF_TYPE\":\"일반\",\"NO\":\"25\",\"JUMIN_NO\":\"4002052247918\",\"LTC_RCGT_GRADE_CD\":\"1등급\",\"MGDS_NM\":\"4DM-204\",\"CNCR_NM\":\"이병녀\",\"CNCL_YN\":\"정상\",\"WLR_MTHD_CD\":\"판매\",\"PROD_NM\":\"미끄럼 방지용품\",\"IN_TYPE\":\"포털\",\"CNCR_REL_CD_NM\":\"본인\",\"_ROW_STATUS\":\"1\"},{\"BCD_NO\":\"211200010724\",\"CTR_DT\":\"20220411\",\"ETC1\":\"1\",\"POF_FR_DT\":\"2022-04-11\",\"CNCR_REL_CD\":\"10\",\"LTC_MGMT_NO\":\"L0011559991\",\"WIM_CD\":\"F30091079107\",\"TOT_AMT\":\"3100\",\"QLF_TYPE\":\"일반\",\"NO\":\"26\",\"JUMIN_NO\":\"4002052247918\",\"LTC_RCGT_GRADE_CD\":\"1등급\",\"MGDS_NM\":\"4DM-204\",\"CNCR_NM\":\"이병녀\",\"CNCL_YN\":\"정상\",\"WLR_MTHD_CD\":\"판매\",\"PROD_NM\":\"미끄럼 방지용품\",\"IN_TYPE\":\"포털\",\"CNCR_REL_CD_NM\":\"본인\",\"_ROW_STATUS\":\"1\"},{\"BCD_NO\":\"211200010725\",\"CTR_DT\":\"20220411\",\"ETC1\":\"1\",\"POF_FR_DT\":\"2022-04-11\",\"CNCR_REL_CD\":\"10\",\"LTC_MGMT_NO\":\"L0011559991\",\"WIM_CD\":\"F30091079107\",\"TOT_AMT\":\"3100\",\"QLF_TYPE\":\"일반\",\"NO\":\"27\",\"JUMIN_NO\":\"4002052247918\",\"LTC_RCGT_GRADE_CD\":\"1등급\",\"MGDS_NM\":\"4DM-204\",\"CNCR_NM\":\"이병녀\",\"CNCL_YN\":\"정상\",\"WLR_MTHD_CD\":\"판매\",\"PROD_NM\":\"미끄럼 방지용품\",\"IN_TYPE\":\"포털\",\"CNCR_REL_CD_NM\":\"본인\",\"_ROW_STATUS\":\"1\"},{\"BCD_NO\":\"211200013556\",\"CTR_DT\":\"20220411\",\"ETC1\":\"1\",\"POF_FR_DT\":\"2022-04-11\",\"CNCR_REL_CD\":\"10\",\"LTC_MGMT_NO\":\"L0011559991\",\"WIM_CD\":\"F30091003101\",\"TOT_AMT\":\"3100\",\"QLF_TYPE\":\"일반\",\"NO\":\"28\",\"JUMIN_NO\":\"4002052247918\",\"LTC_RCGT_GRADE_CD\":\"1등급\",\"MGDS_NM\":\"편안한덧신양말(공용)\",\"CNCR_NM\":\"이병녀\",\"CNCL_YN\":\"정상\",\"WLR_MTHD_CD\":\"판매\",\"PROD_NM\":\"미끄럼 방지용품\",\"IN_TYPE\":\"포털\",\"CNCR_REL_CD_NM\":\"본인\",\"_ROW_STATUS\":\"1\"},{\"BCD_NO\":\"220200001663\",\"CTR_DT\":\"20220411\",\"ETC1\":\"1\",\"POF_FR_DT\":\"2022-04-11\",\"CNCR_REL_CD\":\"10\",\"LTC_MGMT_NO\":\"L0011559991\",\"WIM_CD\":\"F30091003101\",\"TOT_AMT\":\"3100\",\"QLF_TYPE\":\"일반\",\"NO\":\"29\",\"JUMIN_NO\":\"4002052247918\",\"LTC_RCGT_GRADE_CD\":\"1등급\",\"MGDS_NM\":\"편안한덧신양말(공용)\",\"CNCR_NM\":\"이병녀\",\"CNCL_YN\":\"정상\",\"WLR_MTHD_CD\":\"판매\",\"PROD_NM\":\"미끄럼 방지용품\",\"IN_TYPE\":\"포털\",\"CNCR_REL_CD_NM\":\"본인\",\"_ROW_STATUS\":\"1\"},{\"BCD_NO\":\"210900007291\",\"CTR_DT\":\"20220314\",\"ETC1\":\"1\",\"POF_FR_DT\":\"2022-03-14\",\"CNCR_REL_CD\":\"10\",\"LTC_MGMT_NO\":\"L0011559991\",\"WIM_CD\":\"F30091039103\",\"TOT_AMT\":\"3000\",\"QLF_TYPE\":\"일반\",\"NO\":\"30\",\"JUMIN_NO\":\"4002052247918\",\"LTC_RCGT_GRADE_CD\":\"1등급\",\"MGDS_NM\":\"YH-004\",\"CNCR_NM\":\"이병녀\",\"CNCL_YN\":\"정상\",\"WLR_MTHD_CD\":\"판매\",\"PROD_NM\":\"미끄럼 방지용품\",\"IN_TYPE\":\"포털\",\"CNCR_REL_CD_NM\":\"본인\",\"_ROW_STATUS\":\"1\"},{\"BCD_NO\":\"210900007292\",\"CTR_DT\":\"20220314\",\"ETC1\":\"1\",\"POF_FR_DT\":\"2022-03-14\",\"CNCR_REL_CD\":\"10\",\"LTC_MGMT_NO\":\"L0011559991\",\"WIM_CD\":\"F30091039103\",\"TOT_AMT\":\"3000\",\"QLF_TYPE\":\"일반\",\"NO\":\"31\",\"JUMIN_NO\":\"4002052247918\",\"LTC_RCGT_GRADE_CD\":\"1등급\",\"MGDS_NM\":\"YH-004\",\"CNCR_NM\":\"이병녀\",\"CNCL_YN\":\"정상\",\"WLR_MTHD_CD\":\"판매\",\"PROD_NM\":\"미끄럼 방지용품\",\"IN_TYPE\":\"포털\",\"CNCR_REL_CD_NM\":\"본인\",\"_ROW_STATUS\":\"1\"},{\"BCD_NO\":\"210900007293\",\"CTR_DT\":\"20220314\",\"ETC1\":\"1\",\"POF_FR_DT\":\"2022-03-14\",\"CNCR_REL_CD\":\"10\",\"LTC_MGMT_NO\":\"L0011559991\",\"WIM_CD\":\"F30091039103\",\"TOT_AMT\":\"3000\",\"QLF_TYPE\":\"일반\",\"NO\":\"32\",\"JUMIN_NO\":\"4002052247918\",\"LTC_RCGT_GRADE_CD\":\"1등급\",\"MGDS_NM\":\"YH-004\",\"CNCR_NM\":\"이병녀\",\"CNCL_YN\":\"정상\",\"WLR_MTHD_CD\":\"판매\",\"PROD_NM\":\"미끄럼 방지용품\",\"IN_TYPE\":\"포털\",\"CNCR_REL_CD_NM\":\"본인\",\"_ROW_STATUS\":\"1\"},{\"BCD_NO\":\"210900007294\",\"CTR_DT\":\"20220314\",\"ETC1\":\"1\",\"POF_FR_DT\":\"2022-03-14\",\"CNCR_REL_CD\":\"10\",\"LTC_MGMT_NO\":\"L0011559991\",\"WIM_CD\":\"F30091039103\",\"TOT_AMT\":\"3000\",\"QLF_TYPE\":\"일반\",\"NO\":\"33\",\"JUMIN_NO\":\"4002052247918\",\"LTC_RCGT_GRADE_CD\":\"1등급\",\"MGDS_NM\":\"YH-004\",\"CNCR_NM\":\"이병녀\",\"CNCL_YN\":\"정상\",\"WLR_MTHD_CD\":\"판매\",\"PROD_NM\":\"미끄럼 방지용품\",\"IN_TYPE\":\"포털\",\"CNCR_REL_CD_NM\":\"본인\",\"_ROW_STATUS\":\"1\"},{\"BCD_NO\":\"210900007295\",\"CTR_DT\":\"20220314\",\"ETC1\":\"1\",\"POF_FR_DT\":\"2022-03-14\",\"CNCR_REL_CD\":\"10\",\"LTC_MGMT_NO\":\"L0011559991\",\"WIM_CD\":\"F30091039103\",\"TOT_AMT\":\"3000\",\"QLF_TYPE\":\"일반\",\"NO\":\"34\",\"JUMIN_NO\":\"4002052247918\",\"LTC_RCGT_GRADE_CD\":\"1등급\",\"MGDS_NM\":\"YH-004\",\"CNCR_NM\":\"이병녀\",\"CNCL_YN\":\"정상\",\"WLR_MTHD_CD\":\"판매\",\"PROD_NM\":\"미끄럼 방지용품\",\"IN_TYPE\":\"포털\",\"CNCR_REL_CD_NM\":\"본인\",\"_ROW_STATUS\":\"1\"},{\"BCD_NO\":\"210900007296\",\"CTR_DT\":\"20220314\",\"ETC1\":\"1\",\"POF_FR_DT\":\"2022-03-14\",\"CNCR_REL_CD\":\"10\",\"LTC_MGMT_NO\":\"L0011559991\",\"WIM_CD\":\"F30091039103\",\"TOT_AMT\":\"3000\",\"QLF_TYPE\":\"일반\",\"NO\":\"35\",\"JUMIN_NO\":\"4002052247918\",\"LTC_RCGT_GRADE_CD\":\"1등급\",\"MGDS_NM\":\"YH-004\",\"CNCR_NM\":\"이병녀\",\"CNCL_YN\":\"정상\",\"WLR_MTHD_CD\":\"판매\",\"PROD_NM\":\"미끄럼 방지용품\",\"IN_TYPE\":\"포털\",\"CNCR_REL_CD_NM\":\"본인\",\"_ROW_STATUS\":\"1\"},{\"BCD_NO\":\"211200002170\",\"CTR_DT\":\"20220314\",\"ETC1\":\"1\",\"POF_FR_DT\":\"2022-03-14\",\"CNCR_REL_CD\":\"10\",\"LTC_MGMT_NO\":\"L0011559991\",\"WIM_CD\":\"T09061052101\",\"TOT_AMT\":\"22200\",\"QLF_TYPE\":\"일반\",\"NO\":\"36\",\"JUMIN_NO\":\"4002052247918\",\"LTC_RCGT_GRADE_CD\":\"1등급\",\"MGDS_NM\":\"WHR-01\",\"CNCR_NM\":\"이병녀\",\"CNCL_YN\":\"정상\",\"WLR_MTHD_CD\":\"판매\",\"PROD_NM\":\"요실금팬티\",\"IN_TYPE\":\"포털\",\"CNCR_REL_CD_NM\":\"본인\",\"_ROW_STATUS\":\"1\"},{\"BCD_NO\":\"211200002171\",\"CTR_DT\":\"20220314\",\"ETC1\":\"1\",\"POF_FR_DT\":\"2022-03-14\",\"CNCR_REL_CD\":\"10\",\"LTC_MGMT_NO\":\"L0011559991\",\"WIM_CD\":\"T09061052101\",\"TOT_AMT\":\"22200\",\"QLF_TYPE\":\"일반\",\"NO\":\"37\",\"JUMIN_NO\":\"4002052247918\",\"LTC_RCGT_GRADE_CD\":\"1등급\",\"MGDS_NM\":\"WHR-01\",\"CNCR_NM\":\"이병녀\",\"CNCL_YN\":\"정상\",\"WLR_MTHD_CD\":\"판매\",\"PROD_NM\":\"요실금팬티\",\"IN_TYPE\":\"포털\",\"CNCR_REL_CD_NM\":\"본인\",\"_ROW_STATUS\":\"1\"},{\"BCD_NO\":\"211200002172\",\"CTR_DT\":\"20220314\",\"ETC1\":\"1\",\"POF_FR_DT\":\"2022-03-14\",\"CNCR_REL_CD\":\"10\",\"LTC_MGMT_NO\":\"L0011559991\",\"WIM_CD\":\"T09061052101\",\"TOT_AMT\":\"22200\",\"QLF_TYPE\":\"일반\",\"NO\":\"38\",\"JUMIN_NO\":\"4002052247918\",\"LTC_RCGT_GRADE_CD\":\"1등급\",\"MGDS_NM\":\"WHR-01\",\"CNCR_NM\":\"이병녀\",\"CNCL_YN\":\"정상\",\"WLR_MTHD_CD\":\"판매\",\"PROD_NM\":\"요실금팬티\",\"IN_TYPE\":\"포털\",\"CNCR_REL_CD_NM\":\"본인\",\"_ROW_STATUS\":\"1\"},{\"BCD_NO\":\"211200002173\",\"CTR_DT\":\"20220314\",\"ETC1\":\"1\",\"POF_FR_DT\":\"2022-03-14\",\"CNCR_REL_CD\":\"10\",\"LTC_MGMT_NO\":\"L0011559991\",\"WIM_CD\":\"T09061052101\",\"TOT_AMT\":\"22200\",\"QLF_TYPE\":\"일반\",\"NO\":\"39\",\"JUMIN_NO\":\"4002052247918\",\"LTC_RCGT_GRADE_CD\":\"1등급\",\"MGDS_NM\":\"WHR-01\",\"CNCR_NM\":\"이병녀\",\"CNCL_YN\":\"정상\",\"WLR_MTHD_CD\":\"판매\",\"PROD_NM\":\"요실금팬티\",\"IN_TYPE\":\"포털\",\"CNCR_REL_CD_NM\":\"본인\",\"_ROW_STATUS\":\"1\"},{\"BCD_NO\":\"210200001282\",\"CTR_DT\":\"20210302\",\"ETC1\":\"1\",\"POF_FR_DT\":\"2021-03-02~2021-03-28\",\"CNCR_REL_CD\":\"10\",\"LTC_MGMT_NO\":\"L0011559991\",\"WIM_CD\":\"H12060031003\",\"TOT_AMT\":\"17510\",\"QLF_TYPE\":\"일반\",\"NO\":\"40\",\"JUMIN_NO\":\"4002052247918\",\"LTC_RCGT_GRADE_CD\":\"1등급\",\"MGDS_NM\":\"YB-1104A\",\"CNCR_NM\":\"이병녀\",\"CNCL_YN\":\"정상\",\"WLR_MTHD_CD\":\"대여\",\"PROD_NM\":\"욕창예방 매트리스\",\"IN_TYPE\":\"포털\",\"CNCR_REL_CD_NM\":\"본인\",\"_ROW_STATUS\":\"1\"},{\"BCD_NO\":\"210100000590\",\"CTR_DT\":\"20210302\",\"ETC1\":\"1\",\"POF_FR_DT\":\"2021-03-02~2021-03-28\",\"CNCR_REL_CD\":\"10\",\"LTC_MGMT_NO\":\"L0011559991\",\"WIM_CD\":\"S03091064103\",\"TOT_AMT\":\"64280\",\"QLF_TYPE\":\"일반\",\"NO\":\"41\",\"JUMIN_NO\":\"4002052247918\",\"LTC_RCGT_GRADE_CD\":\"1등급\",\"MGDS_NM\":\"NY(M)-1300\",\"CNCR_NM\":\"이병녀\",\"CNCL_YN\":\"정상\",\"WLR_MTHD_CD\":\"대여\",\"PROD_NM\":\"전동침대\",\"IN_TYPE\":\"포털\",\"CNCR_REL_CD_NM\":\"본인\",\"_ROW_STATUS\":\"1\"},{\"BCD_NO\":\"200100000168\",\"CTR_DT\":\"20210222\",\"ETC1\":\"1\",\"POF_FR_DT\":\"2021-01-06~2021-02-22\",\"CNCR_REL_CD\":\"10\",\"LTC_MGMT_NO\":\"L0011559991\",\"WIM_CD\":\"H12060031003\",\"TOT_AMT\":\"32650\",\"QLF_TYPE\":\"일반\",\"NO\":\"42\",\"JUMIN_NO\":\"4002052247918\",\"LTC_RCGT_GRADE_CD\":\"1등급\",\"MGDS_NM\":\"YB-1104A\",\"CNCR_NM\":\"이병녀\",\"CNCL_YN\":\"변경\",\"WLR_MTHD_CD\":\"대여\",\"PROD_NM\":\"욕창예방 매트리스\",\"IN_TYPE\":\"포털\",\"CNCR_REL_CD_NM\":\"본인\",\"_ROW_STATUS\":\"1\"},{\"BCD_NO\":\"16040265\",\"CTR_DT\":\"20210222\",\"ETC1\":\"1\",\"POF_FR_DT\":\"2020-08-18~2021-02-22\",\"CNCR_REL_CD\":\"10\",\"LTC_MGMT_NO\":\"L0011559991\",\"WIM_CD\":\"S03090035103\",\"TOT_AMT\":\"455330\",\"QLF_TYPE\":\"일반\",\"NO\":\"43\",\"JUMIN_NO\":\"4002052247918\",\"LTC_RCGT_GRADE_CD\":\"1등급\",\"MGDS_NM\":\"JB920LITE\",\"CNCR_NM\":\"이병녀\",\"CNCL_YN\":\"변경\",\"WLR_MTHD_CD\":\"대여\",\"PROD_NM\":\"전동침대\",\"IN_TYPE\":\"포털\",\"CNCR_REL_CD_NM\":\"본인\",\"_ROW_STATUS\":\"1\"},{\"BCD_NO\":\"201200013964\",\"CTR_DT\":\"20210215\",\"ETC1\":\"1\",\"POF_FR_DT\":\"2021-02-15\",\"CNCR_REL_CD\":\"10\",\"LTC_MGMT_NO\":\"L0011559991\",\"WIM_CD\":\"F30091039113\",\"TOT_AMT\":\"3800\",\"QLF_TYPE\":\"일반\",\"NO\":\"44\",\"JUMIN_NO\":\"4002052247918\",\"LTC_RCGT_GRADE_CD\":\"1등급\",\"MGDS_NM\":\"YH-202\",\"CNCR_NM\":\"이병녀\",\"CNCL_YN\":\"정상\",\"WLR_MTHD_CD\":\"판매\",\"PROD_NM\":\"미끄럼 방지용품\",\"IN_TYPE\":\"포털\",\"CNCR_REL_CD_NM\":\"본인\",\"_ROW_STATUS\":\"1\"},{\"BCD_NO\":\"201200013965\",\"CTR_DT\":\"20210215\",\"ETC1\":\"1\",\"POF_FR_DT\":\"2021-02-15\",\"CNCR_REL_CD\":\"10\",\"LTC_MGMT_NO\":\"L0011559991\",\"WIM_CD\":\"F30091039113\",\"TOT_AMT\":\"3800\",\"QLF_TYPE\":\"일반\",\"NO\":\"45\",\"JUMIN_NO\":\"4002052247918\",\"LTC_RCGT_GRADE_CD\":\"1등급\",\"MGDS_NM\":\"YH-202\",\"CNCR_NM\":\"이병녀\",\"CNCL_YN\":\"정상\",\"WLR_MTHD_CD\":\"판매\",\"PROD_NM\":\"미끄럼 방지용품\",\"IN_TYPE\":\"포털\",\"CNCR_REL_CD_NM\":\"본인\",\"_ROW_STATUS\":\"1\"},{\"BCD_NO\":\"201200013966\",\"CTR_DT\":\"20210215\",\"ETC1\":\"1\",\"POF_FR_DT\":\"2021-02-15\",\"CNCR_REL_CD\":\"10\",\"LTC_MGMT_NO\":\"L0011559991\",\"WIM_CD\":\"F30091039113\",\"TOT_AMT\":\"3800\",\"QLF_TYPE\":\"일반\",\"NO\":\"46\",\"JUMIN_NO\":\"4002052247918\",\"LTC_RCGT_GRADE_CD\":\"1등급\",\"MGDS_NM\":\"YH-202\",\"CNCR_NM\":\"이병녀\",\"CNCL_YN\":\"정상\",\"WLR_MTHD_CD\":\"판매\",\"PROD_NM\":\"미끄럼 방지용품\",\"IN_TYPE\":\"포털\",\"CNCR_REL_CD_NM\":\"본인\",\"_ROW_STATUS\":\"1\"},{\"BCD_NO\":\"201200013967\",\"CTR_DT\":\"20210215\",\"ETC1\":\"1\",\"POF_FR_DT\":\"2021-02-15\",\"CNCR_REL_CD\":\"10\",\"LTC_MGMT_NO\":\"L0011559991\",\"WIM_CD\":\"F30091039113\",\"TOT_AMT\":\"3800\",\"QLF_TYPE\":\"일반\",\"NO\":\"47\",\"JUMIN_NO\":\"4002052247918\",\"LTC_RCGT_GRADE_CD\":\"1등급\",\"MGDS_NM\":\"YH-202\",\"CNCR_NM\":\"이병녀\",\"CNCL_YN\":\"정상\",\"WLR_MTHD_CD\":\"판매\",\"PROD_NM\":\"미끄럼 방지용품\",\"IN_TYPE\":\"포털\",\"CNCR_REL_CD_NM\":\"본인\",\"_ROW_STATUS\":\"1\"},{\"BCD_NO\":\"201200013968\",\"CTR_DT\":\"20210215\",\"ETC1\":\"1\",\"POF_FR_DT\":\"2021-02-15\",\"CNCR_REL_CD\":\"10\",\"LTC_MGMT_NO\":\"L0011559991\",\"WIM_CD\":\"F30091039113\",\"TOT_AMT\":\"3800\",\"QLF_TYPE\":\"일반\",\"NO\":\"48\",\"JUMIN_NO\":\"4002052247918\",\"LTC_RCGT_GRADE_CD\":\"1등급\",\"MGDS_NM\":\"YH-202\",\"CNCR_NM\":\"이병녀\",\"CNCL_YN\":\"정상\",\"WLR_MTHD_CD\":\"판매\",\"PROD_NM\":\"미끄럼 방지용품\",\"IN_TYPE\":\"포털\",\"CNCR_REL_CD_NM\":\"본인\",\"_ROW_STATUS\":\"1\"},{\"BCD_NO\":\"201200013969\",\"CTR_DT\":\"20210215\",\"ETC1\":\"1\",\"POF_FR_DT\":\"2021-02-15\",\"CNCR_REL_CD\":\"10\",\"LTC_MGMT_NO\":\"L0011559991\",\"WIM_CD\":\"F30091039113\",\"TOT_AMT\":\"3800\",\"QLF_TYPE\":\"일반\",\"NO\":\"49\",\"JUMIN_NO\":\"4002052247918\",\"LTC_RCGT_GRADE_CD\":\"1등급\",\"MGDS_NM\":\"YH-202\",\"CNCR_NM\":\"이병녀\",\"CNCL_YN\":\"정상\",\"WLR_MTHD_CD\":\"판매\",\"PROD_NM\":\"미끄럼 방지용품\",\"IN_TYPE\":\"포털\",\"CNCR_REL_CD_NM\":\"본인\",\"_ROW_STATUS\":\"1\"},{\"BCD_NO\":\"180500000045\",\"CTR_DT\":\"20210215\",\"ETC1\":\"1\",\"POF_FR_DT\":\"2021-02-15~2021-02-26\",\"CNCR_REL_CD\":\"10\",\"LTC_MGMT_NO\":\"L0011559991\",\"WIM_CD\":\"M18030111103\",\"TOT_AMT\":\"12600\",\"QLF_TYPE\":\"일반\",\"NO\":\"50\",\"JUMIN_NO\":\"4002052247918\",\"LTC_RCGT_GRADE_CD\":\"1등급\",\"MGDS_NM\":\"MiKi-W AH\",\"CNCR_NM\":\"이병녀\",\"CNCL_YN\":\"취소\",\"WLR_MTHD_CD\":\"대여\",\"PROD_NM\":\"수동휠체어\",\"IN_TYPE\":\"포털\",\"CNCR_REL_CD_NM\":\"본인\",\"_ROW_STATUS\":\"1\"},{\"BCD_NO\":\"180500000045\",\"CTR_DT\":\"20210215\",\"ETC1\":\"1\",\"POF_FR_DT\":\"2021-02-15~2021-03-28\",\"CNCR_REL_CD\":\"10\",\"LTC_MGMT_NO\":\"L0011559991\",\"WIM_CD\":\"M18030111103\",\"TOT_AMT\":\"41250\",\"QLF_TYPE\":\"일반\",\"NO\":\"51\",\"JUMIN_NO\":\"4002052247918\",\"LTC_RCGT_GRADE_CD\":\"1등급\",\"MGDS_NM\":\"MiKi-W AH\",\"CNCR_NM\":\"이병녀\",\"CNCL_YN\":\"정상\",\"WLR_MTHD_CD\":\"대여\",\"PROD_NM\":\"수동휠체어\",\"IN_TYPE\":\"포털\",\"CNCR_REL_CD_NM\":\"본인\",\"_ROW_STATUS\":\"1\"},{\"BCD_NO\":\"210100001043\",\"CTR_DT\":\"20210215\",\"ETC1\":\"1\",\"POF_FR_DT\":\"2021-02-15\",\"CNCR_REL_CD\":\"10\",\"LTC_MGMT_NO\":\"L0011559991\",\"WIM_CD\":\"F18030060120\",\"TOT_AMT\":\"219000\",\"QLF_TYPE\":\"일반\",\"NO\":\"52\",\"JUMIN_NO\":\"4002052247918\",\"LTC_RCGT_GRADE_CD\":\"1등급\",\"MGDS_NM\":\"ASH-201\",\"CNCR_NM\":\"이병녀\",\"CNCL_YN\":\"정상\",\"WLR_MTHD_CD\":\"판매\",\"PROD_NM\":\"안전손잡이\",\"IN_TYPE\":\"포털\",\"CNCR_REL_CD_NM\":\"본인\",\"_ROW_STATUS\":\"1\"},{\"BCD_NO\":\"201200006807\",\"CTR_DT\":\"20210215\",\"ETC1\":\"1\",\"POF_FR_DT\":\"2021-02-15\",\"CNCR_REL_CD\":\"10\",\"LTC_MGMT_NO\":\"L0011559991\",\"WIM_CD\":\"T09060165006\",\"TOT_AMT\":\"38400\",\"QLF_TYPE\":\"일반\",\"NO\":\"53\",\"JUMIN_NO\":\"4002052247918\",\"LTC_RCGT_GRADE_CD\":\"1등급\",\"MGDS_NM\":\"AW300코지50cc\",\"CNCR_NM\":\"이병녀\",\"CNCL_YN\":\"정상\",\"WLR_MTHD_CD\":\"판매\",\"PROD_NM\":\"요실금팬티\",\"IN_TYPE\":\"포털\",\"CNCR_REL_CD_NM\":\"본인\",\"_ROW_STATUS\":\"1\"},{\"BCD_NO\":\"201200006808\",\"CTR_DT\":\"20210215\",\"ETC1\":\"1\",\"POF_FR_DT\":\"2021-02-15\",\"CNCR_REL_CD\":\"10\",\"LTC_MGMT_NO\":\"L0011559991\",\"WIM_CD\":\"T09060165006\",\"TOT_AMT\":\"38400\",\"QLF_TYPE\":\"일반\",\"NO\":\"54\",\"JUMIN_NO\":\"4002052247918\",\"LTC_RCGT_GRADE_CD\":\"1등급\",\"MGDS_NM\":\"AW300코지50cc\",\"CNCR_NM\":\"이병녀\",\"CNCL_YN\":\"정상\",\"WLR_MTHD_CD\":\"판매\",\"PROD_NM\":\"요실금팬티\",\"IN_TYPE\":\"포털\",\"CNCR_REL_CD_NM\":\"본인\",\"_ROW_STATUS\":\"1\"},{\"BCD_NO\":\"201200006809\",\"CTR_DT\":\"20210215\",\"ETC1\":\"1\",\"POF_FR_DT\":\"2021-02-15\",\"CNCR_REL_CD\":\"10\",\"LTC_MGMT_NO\":\"L0011559991\",\"WIM_CD\":\"T09060165006\",\"TOT_AMT\":\"38400\",\"QLF_TYPE\":\"일반\",\"NO\":\"55\",\"JUMIN_NO\":\"4002052247918\",\"LTC_RCGT_GRADE_CD\":\"1등급\",\"MGDS_NM\":\"AW300코지50cc\",\"CNCR_NM\":\"이병녀\",\"CNCL_YN\":\"취소\",\"WLR_MTHD_CD\":\"판매\",\"PROD_NM\":\"요실금팬티\",\"IN_TYPE\":\"포털\",\"CNCR_REL_CD_NM\":\"본인\",\"_ROW_STATUS\":\"1\"},{\"BCD_NO\":\"200800002032\",\"CTR_DT\":\"20210215\",\"ETC1\":\"1\",\"POF_FR_DT\":\"2021-02-15\",\"CNCR_REL_CD\":\"10\",\"LTC_MGMT_NO\":\"L0011559991\",\"WIM_CD\":\"M03031071601\",\"TOT_AMT\":\"69400\",\"QLF_TYPE\":\"일반\",\"NO\":\"56\",\"JUMIN_NO\":\"4002052247918\",\"LTC_RCGT_GRADE_CD\":\"1등급\",\"MGDS_NM\":\"백건 여자 지팡이-01\",\"CNCR_NM\":\"이병녀\",\"CNCL_YN\":\"정상\",\"WLR_MTHD_CD\":\"판매\",\"PROD_NM\":\"지팡이\",\"IN_TYPE\":\"포털\",\"CNCR_REL_CD_NM\":\"본인\",\"_ROW_STATUS\":\"1\"},{\"BCD_NO\":\"200100001412\",\"CTR_DT\":\"20200709\",\"ETC1\":\"1\",\"POF_FR_DT\":\"2020-07-08\",\"CNCR_REL_CD\":\"10\",\"LTC_MGMT_NO\":\"L0011559991\",\"WIM_CD\":\"B03180088605\",\"TOT_AMT\":\"186000\",\"QLF_TYPE\":\"일반\",\"NO\":\"57\",\"JUMIN_NO\":\"4002052247918\",\"LTC_RCGT_GRADE_CD\":\"1등급\",\"MGDS_NM\":\"IU\",\"CNCR_NM\":\"이병녀\",\"CNCL_YN\":\"정상\",\"WLR_MTHD_CD\":\"판매\",\"PROD_NM\":\"목욕의자\",\"IN_TYPE\":\"포털\",\"CNCR_REL_CD_NM\":\"본인\",\"_ROW_STATUS\":\"1\"},{\"BCD_NO\":\"200400001645\",\"CTR_DT\":\"20200709\",\"ETC1\":\"1\",\"POF_FR_DT\":\"2020-07-08\",\"CNCR_REL_CD\":\"10\",\"LTC_MGMT_NO\":\"L0011559991\",\"WIM_CD\":\"M06061091101\",\"TOT_AMT\":\"54500\",\"QLF_TYPE\":\"일반\",\"NO\":\"58\",\"JUMIN_NO\":\"4002052247918\",\"LTC_RCGT_GRADE_CD\":\"1등급\",\"MGDS_NM\":\"CK-06\",\"CNCR_NM\":\"이병녀\",\"CNCL_YN\":\"정상\",\"WLR_MTHD_CD\":\"판매\",\"PROD_NM\":\"성인용보행기\",\"IN_TYPE\":\"포털\",\"CNCR_REL_CD_NM\":\"본인\",\"_ROW_STATUS\":\"1\"},{\"BCD_NO\":\"200400000008\",\"CTR_DT\":\"20200709\",\"ETC1\":\"1\",\"POF_FR_DT\":\"2020-07-08\",\"CNCR_REL_CD\":\"10\",\"LTC_MGMT_NO\":\"L0011559991\",\"WIM_CD\":\"M06090088606\",\"TOT_AMT\":\"166000\",\"QLF_TYPE\":\"일반\",\"NO\":\"59\",\"JUMIN_NO\":\"4002052247918\",\"LTC_RCGT_GRADE_CD\":\"1등급\",\"MGDS_NM\":\"ST10\",\"CNCR_NM\":\"이병녀\",\"CNCL_YN\":\"정상\",\"WLR_MTHD_CD\":\"판매\",\"PROD_NM\":\"성인용보행기\",\"IN_TYPE\":\"포털\",\"CNCR_REL_CD_NM\":\"본인\",\"_ROW_STATUS\":\"1\"},{\"BCD_NO\":\"181100000163\",\"CTR_DT\":\"20200709\",\"ETC1\":\"1\",\"POF_FR_DT\":\"2020-07-08\",\"CNCR_REL_CD\":\"10\",\"LTC_MGMT_NO\":\"L0011559991\",\"WIM_CD\":\"T03030081602\",\"TOT_AMT\":\"162000\",\"QLF_TYPE\":\"일반\",\"NO\":\"60\",\"JUMIN_NO\":\"4002052247918\",\"LTC_RCGT_GRADE_CD\":\"1등급\",\"MGDS_NM\":\"PN-L30200BK\",\"CNCR_NM\":\"이병녀\",\"CNCL_YN\":\"정상\",\"WLR_MTHD_CD\":\"판매\",\"PROD_NM\":\"이동변기\",\"IN_TYPE\":\"포털\",\"CNCR_REL_CD_NM\":\"본인\",\"_ROW_STATUS\":\"1\"}]},\"ApiTxKey\":\"6bcb69fd-a98d-452c-adc0-cb99e8d12041\",\"Status\":\"OK\",\"StatusSeq\":0,\"ErrorCode\":0,\"Message\":\"성공\",\"ErrorLog\":null,\"TargetCode\":null,\"TargetMessage\":null}";

		return responseStr;
	}

}