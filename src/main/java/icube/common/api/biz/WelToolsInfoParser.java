package icube.common.api.biz;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;

import org.egovframe.rte.fdl.string.EgovStringUtil;

import icube.common.util.JsonUtil;
import icube.common.values.CodeList;

public class WelToolsInfoParser {

	private String peroidDtFr;
	private String peroidDtTo;
	private String applyDtFr;
	private String applyDtTo;

	private HashMap<String, WelToolsItemGrpInfo>  weltoolsItemGrpList;
	
	public WelToolsInfoParser(String peroidDtFr, String peroidDtTo, String applyDtFr, String applyDtTo) {
		this.peroidDtFr = peroidDtFr;
		this.peroidDtTo = peroidDtTo;
		
		if (applyDtFr.length() == 8) {
			applyDtFr = applyDtFr.substring(0, 4) + "-" + applyDtFr.substring(4, 6) + "-" + applyDtFr.substring(6, 8);
		}
		if (applyDtTo.length() == 8) {
			applyDtTo = applyDtTo.substring(0, 4) + "-" + applyDtTo.substring(4, 6) + "-" + applyDtTo.substring(6, 8);
		}
		this.applyDtFr = applyDtFr;
		this.applyDtTo = applyDtTo;

		weltoolsItemGrpList = this.getWeltoolsItemGrpList(this.peroidDtFr, this.peroidDtTo, this.applyDtFr,  this.applyDtTo);
	}
	
	public List<String> getItemGrpAbleICube() {
		List<String> resultList = this.getItemGrpAbleICube("S", "Y");

		resultList.addAll(this.getItemGrpAbleICube("R", "Y"));

		return resultList;
	}
	
	public int getUsedAmt() {
		int usedAmt = 0;
		WelToolsItemGrpInfo itemGrpInfo;
	   	for (String itemGrpCd : weltoolsItemGrpList.keySet()) {
	   		
	   		if (EgovStringUtil.equals(itemGrpCd , "antiSlipSocks") || EgovStringUtil.equals(itemGrpCd , "mattressS")) { /*미끄럼 방지용품, 욕창예방 매트리스(대여) 에서 처리*/
	   			continue;
	   		}
	   		
	   		itemGrpInfo = (WelToolsItemGrpInfo)(weltoolsItemGrpList.get(itemGrpCd));
	   		if (EgovStringUtil.equals("Y", itemGrpInfo.getAble())) {
	   			usedAmt += itemGrpInfo.getUsedAmt();
	   		}
	   		
	   	}

		return usedAmt;
	}
	public List<String> getItemGrpAbleICube(String saleKind, String ableYn) {
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
	
	public List<String> getItemGrpAble() {
		List<String> resultList = this.getItemGrpAble("S", "Y");

		resultList.addAll(this.getItemGrpAble("R", "Y"));

		return resultList;
	}
	public List<String> getItemGrpAble(String saleKind, String ableYn) {
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
	
	public void setItemGrpAble(String responseStr) throws Exception {
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
				String sss = "";
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
	
	public void contractItemListParse(String responseStr) throws Exception {
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

	public JSONObject getResutAll(){
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
					|| (itemGrpInfo1.getUsedPersistPeriodCnt() + itemGrpInfo2.getUsedPersistPeriodCnt()) > 0){
					jsonObject.put(itemGrpOther, itemGrpInfo2.getResultNone());
					jsonObject.put(itemGrpCd, itemGrpInfo1.getResultNone());
				}else{
					jsonObject.put(itemGrpOther, itemGrpInfo2.getResult());
					jsonObject.put(itemGrpCd, itemGrpInfo1.getResult());
				}

			} else if (EgovStringUtil.equals(itemGrpCd, "mattressS") ){
				itemGrpOther = "mattressR";

				itemGrpInfo2 = (WelToolsItemGrpInfo)(weltoolsItemGrpList.get(itemGrpOther));
				if (!EgovStringUtil.equals("Y", itemGrpInfo1.getAble()) || itemGrpInfo1.getUsedPersistPeriodCnt() > 0){
					jsonObject.put(itemGrpOther, itemGrpInfo2.getResultNone());
					jsonObject.put(itemGrpCd, itemGrpInfo1.getResultNone());
				}else{
					jsonObject.put(itemGrpOther, itemGrpInfo2.getResult());
					jsonObject.put(itemGrpCd, itemGrpInfo1.getResult());
				}

			}else{
				jsonObject.put(itemGrpCd, itemGrpInfo1.getResult());
			}
			
		}

		return jsonObject;
	}

	public List<String> getResutIcube(String saleKind){
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
			put("mobileToilet"		, (new WelToolsItemGrpInfo("mobileToilet"		, "dayOne"	, 5, 1, peroidDtFr, peroidDtTo, applyDtFr, applyDtTo)));//5년에 1개 구매가능(dayOne), "이동변기"			, "이동변기"				
			put("bathChair"			, (new WelToolsItemGrpInfo("bathChair"			, "dayOne"	, 5, 1, peroidDtFr, peroidDtTo, applyDtFr, applyDtTo)));//5년에 1개 구매가능(dayOne)//, "목욕의자"			, "목욕의자"				
			put("walkerForAdults"	, (new WelToolsItemGrpInfo("walkerForAdults"	, "dayCnt"	, 5, 2, peroidDtFr, peroidDtTo, applyDtFr, applyDtTo)));//5년에 2개 구매가능(dayCnt)//, "성인용보행기"		, "성인용보행기"			
			put("safetyHandle"		, (new WelToolsItemGrpInfo("safetyHandle"		, "period"	, 1, 10, peroidDtFr, peroidDtTo, applyDtFr, applyDtTo)));//적용기간 내 10개 구매가능(period)//, "안전손잡이"		, "안전손잡이"				
			put("antiSlipProduct"	, (new WelToolsItemGrpInfo("antiSlipProduct"	, "period"	, 1, 5, peroidDtFr, peroidDtTo, applyDtFr, applyDtTo)));//적용기간 내 5개 구매가능(양말제외)//, "미끄럼 방지용품"	, "미끄럼 방지용품"			
			put("antiSlipSocks"		, (new WelToolsItemGrpInfo("antiSlipSocks"		, "period"	, 1, 6, peroidDtFr, peroidDtTo, applyDtFr, applyDtTo)));//적용기간 내 6개 구매가능(period)//, "미끄럼 방지양말"	, "미끄럼 방지양말"			
			put("portableToilet"	, (new WelToolsItemGrpInfo("portableToilet"		, "period"	, 1, 2, peroidDtFr, peroidDtTo, applyDtFr, applyDtTo)));//적용기간 내 2개 구매가능(period)//, "간이변기"			, "간이변기"				
			put("cane"				, (new WelToolsItemGrpInfo("cane"				, "dayOne"	, 2, 1, peroidDtFr, peroidDtTo, applyDtFr, applyDtTo)));//2년에 1개 구매가능(dayOne)//, "지팡이"			, "지팡이"					
			put("cushion"			, (new WelToolsItemGrpInfo("cushion"			, "dayOne"	, 3, 1, peroidDtFr, peroidDtTo, applyDtFr, applyDtTo)));//3년에 1개 구매가능(dayOne)//, "욕창예방방석"		, "욕창예방방석"			
			put("changeTool"		, (new WelToolsItemGrpInfo("changeTool"			, "period"	, 1, 5, peroidDtFr, peroidDtTo, applyDtFr, applyDtTo)));//적용기간 내 5개 구매가능(period)//, "자세변환용구"		, "자세변환용구"			
			put("panties"			, (new WelToolsItemGrpInfo("panties"			, "period"	, 1, 4, peroidDtFr, peroidDtTo, applyDtFr, applyDtTo)));//적용기간 내 4개 구매가능(period)//, "요실금팬티"		, "요실금팬티"				
			put("inRunway"			, (new WelToolsItemGrpInfo("inRunway"			, "dayCnt"	, 2, 6, peroidDtFr, peroidDtTo, applyDtFr, applyDtTo)));//2년에 6개 구매가능(dayCnt)//, "실내용 경사로"		, "실내용 경사로"			
			put("wheelchair"		, (new WelToolsItemGrpInfo("wheelchair"			, "rent"	, 1, 1, peroidDtFr, peroidDtTo, applyDtFr, applyDtTo)));//rent//, "수동휠체어"		, "수동휠체어"				
			put("electricBed"		, (new WelToolsItemGrpInfo("electricBed"		, "rent"	, 1, 1, peroidDtFr, peroidDtTo, applyDtFr, applyDtTo)));//rent//, "전동침대"			, "전동침대"				
			put("manualBed"			, (new WelToolsItemGrpInfo("manualBed"			, "rent"	, 1, 1, peroidDtFr, peroidDtTo, applyDtFr, applyDtTo)));//rent//, "수동침대"			, "수동침대"				
			put("bathtub"			, (new WelToolsItemGrpInfo("bathtub"			, "rent"	, 1, 1, peroidDtFr, peroidDtTo, applyDtFr, applyDtTo)));//rent//, "이동욕조"			, "이동욕조"				  
			put("bathLift"			, (new WelToolsItemGrpInfo("bathLift"			, "rent"	, 1, 1, peroidDtFr, peroidDtTo, applyDtFr, applyDtTo)));//rent//, "목욕리프트"		, "목욕리프트"				   
			put("detector"			, (new WelToolsItemGrpInfo("detector"			, "rent"	, 1, 1, peroidDtFr, peroidDtTo, applyDtFr, applyDtTo)));//rent//, "배회감지기"		, "배회감지기"				   
			put("outRunway"			, (new WelToolsItemGrpInfo("outRunway"			, "rent"	, 1, 1, applyDtFr, peroidDtTo, applyDtFr, applyDtTo)));//rent//, "경사로"			, "경사로"					  
			put("mattressS"			, (new WelToolsItemGrpInfo("mattressS"			, "dayOne"	, 3, 1, peroidDtFr, peroidDtTo, applyDtFr, applyDtTo)));//3년에 1개 구매가능(dayOne)//, "욕창예방 매트리스"	, "욕창예방 매트리스(판매)"		
			put("mattressR"			, (new WelToolsItemGrpInfo("mattressR"			, "rent"	, 1, 1, peroidDtFr, peroidDtTo, applyDtFr, applyDtTo)));//rent//, "욕창예방 매트리스"	, "욕창예방 매트리스(대여)"		
		}};
	}


	public void testAction() throws Exception{
		
		WelToolsInfoParser wtInfoParser = new WelToolsInfoParser("2023-07-15", "2025-07-14", "2023-03-29", "2024-03-28");
		
		wtInfoParser.setItemGrpAble(wtInfoParser.getTestDataPayPsb());
		
		wtInfoParser.contractItemListParse(wtInfoParser.getTestDataContractHistory());
   	    
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


	public String getTestDataPayPsb(){
		String responseStr = "{\"Result\":{\"ds_payPsblLnd1\":[{\"WIM_ITM_CD\":\"수동휠체어\",\"_ROW_STATUS\":\"1\"},{\"WIM_ITM_CD\":\"전동침대\",\"_ROW_STATUS\":\"1\"},{\"WIM_ITM_CD\":\"수동침대\",\"_ROW_STATUS\":\"1\"},{\"WIM_ITM_CD\":\"욕창예방 매트리스\",\"_ROW_STATUS\":\"1\"},{\"WIM_ITM_CD\":\"이동욕조\",\"_ROW_STATUS\":\"1\"},{\"WIM_ITM_CD\":\"목욕리프트\",\"_ROW_STATUS\":\"1\"},{\"WIM_ITM_CD\":\"배회감지기\",\"_ROW_STATUS\":\"1\"},{\"WIM_ITM_CD\":\"경사로(실외용)\",\"_ROW_STATUS\":\"1\"}],\"ds_payPsblLnd2\":[],\"ds_payPsbl1\":[{\"WIM_ITM_CD\":\"이동변기\",\"_ROW_STATUS\":\"1\"},{\"WIM_ITM_CD\":\"목욕의자\",\"_ROW_STATUS\":\"1\"},{\"WIM_ITM_CD\":\"안전손잡이\",\"_ROW_STATUS\":\"1\"},{\"WIM_ITM_CD\":\"미끄럼 방지용품\",\"_ROW_STATUS\":\"1\"},{\"WIM_ITM_CD\":\"간이변기\",\"_ROW_STATUS\":\"1\"},{\"WIM_ITM_CD\":\"지팡이\",\"_ROW_STATUS\":\"1\"},{\"WIM_ITM_CD\":\"욕창예방방석\",\"_ROW_STATUS\":\"1\"},{\"WIM_ITM_CD\":\"자세변환용구\",\"_ROW_STATUS\":\"1\"},{\"WIM_ITM_CD\":\"욕창예방 매트리스\",\"_ROW_STATUS\":\"1\"},{\"WIM_ITM_CD\":\"성인용보행기\",\"_ROW_STATUS\":\"1\"},{\"WIM_ITM_CD\":\"요실금팬티\",\"_ROW_STATUS\":\"1\"},{\"WIM_ITM_CD\":\"경사로(실내용)\",\"_ROW_STATUS\":\"1\"}],\"ds_payPsbl2\":[]},\"ApiTxKey\":\"0195ad35-a23a-4239-b62d-08f6a50ba57d\",\"Status\":\"OK\",\"StatusSeq\":0,\"ErrorCode\":0,\"Message\":\"성공\",\"ErrorLog\":null,\"TargetCode\":null,\"TargetMessage\":null}";

		return responseStr;
	}
	
	public String getTestDataContractHistory(){
		String responseStr = "{\"Result\":{\"ds_result\":[{\"BCD_NO\":\"230900000249\",\"CTR_DT\":\"20230927\",\"ETC1\":\"1\",\"POF_FR_DT\":\"2023-09-22\",\"CNCR_REL_CD\":\"10\",\"LTC_MGMT_NO\":\"L0011559991\",\"WIM_CD\":\"H12030184001\",\"TOT_AMT\":\"240000\",\"QLF_TYPE\":\"일반\",\"NO\":\"1\",\"JUMIN_NO\":\"4002052247918\",\"LTC_RCGT_GRADE_CD\":\"1등급\",\"MGDS_NM\":\"CD-04\",\"CNCR_NM\":\"이병녀\",\"CNCL_YN\":\"정상\",\"WLR_MTHD_CD\":\"판매\",\"PROD_NM\":\"욕창예방방석\",\"IN_TYPE\":\"포털\",\"CNCR_REL_CD_NM\":\"본인\",\"_ROW_STATUS\":\"1\"},{\"BCD_NO\":\"201100000574\",\"CTR_DT\":\"20230620\",\"ETC1\":\"1\",\"POF_FR_DT\":\"2023-07-15~2024-03-28\",\"CNCR_REL_CD\":\"10\",\"LTC_MGMT_NO\":\"L0011559991\",\"WIM_CD\":\"S03091064103\",\"TOT_AMT\":\"623730\",\"QLF_TYPE\":\"일반\",\"NO\":\"2\",\"JUMIN_NO\":\"4002052247918\",\"LTC_RCGT_GRADE_CD\":\"1등급\",\"MGDS_NM\":\"NY(M)-1300\",\"CNCR_NM\":\"이병녀\",\"CNCL_YN\":\"정상\",\"WLR_MTHD_CD\":\"대여\",\"PROD_NM\":\"전동침대\",\"IN_TYPE\":\"포털\",\"CNCR_REL_CD_NM\":\"본인\",\"_ROW_STATUS\":\"1\"},{\"BCD_NO\":\"180500000045\",\"CTR_DT\":\"20230615\",\"ETC1\":\"1\",\"POF_FR_DT\":\"2023-07-15~2024-03-28\",\"CNCR_REL_CD\":\"10\",\"LTC_MGMT_NO\":\"L0011559991\",\"WIM_CD\":\"M18030111103\",\"TOT_AMT\":\"124240\",\"QLF_TYPE\":\"일반\",\"NO\":\"3\",\"JUMIN_NO\":\"4002052247918\",\"LTC_RCGT_GRADE_CD\":\"1등급\",\"MGDS_NM\":\"MiKi-W AH\",\"CNCR_NM\":\"이병녀\",\"CNCL_YN\":\"정상\",\"WLR_MTHD_CD\":\"대여\",\"PROD_NM\":\"수동휠체어\",\"IN_TYPE\":\"포털\",\"CNCR_REL_CD_NM\":\"본인\",\"_ROW_STATUS\":\"1\"},{\"BCD_NO\":\"221100000338\",\"CTR_DT\":\"20230405\",\"ETC1\":\"1\",\"POF_FR_DT\":\"2023-03-30\",\"CNCR_REL_CD\":\"10\",\"LTC_MGMT_NO\":\"L0011559991\",\"WIM_CD\":\"M03031033103\",\"TOT_AMT\":\"61500\",\"QLF_TYPE\":\"일반\",\"NO\":\"4\",\"JUMIN_NO\":\"4002052247918\",\"LTC_RCGT_GRADE_CD\":\"1등급\",\"MGDS_NM\":\"아이온 사발지팡이\",\"CNCR_NM\":\"이병녀\",\"CNCL_YN\":\"정상\",\"WLR_MTHD_CD\":\"판매\",\"PROD_NM\":\"지팡이\",\"IN_TYPE\":\"포털\",\"CNCR_REL_CD_NM\":\"본인\",\"_ROW_STATUS\":\"1\"},{\"BCD_NO\":\"180500000045\",\"CTR_DT\":\"20230303\",\"ETC1\":\"1\",\"POF_FR_DT\":\"2023-03-29~2023-06-10\",\"CNCR_REL_CD\":\"10\",\"LTC_MGMT_NO\":\"L0011559991\",\"WIM_CD\":\"M18030111103\",\"TOT_AMT\":\"71450\",\"QLF_TYPE\":\"일반\",\"NO\":\"5\",\"JUMIN_NO\":\"4002052247918\",\"LTC_RCGT_GRADE_CD\":\"1등급\",\"MGDS_NM\":\"MiKi-W AH\",\"CNCR_NM\":\"이병녀\",\"CNCL_YN\":\"정상\",\"WLR_MTHD_CD\":\"대여\",\"PROD_NM\":\"수동휠체어\",\"IN_TYPE\":\"포털\",\"CNCR_REL_CD_NM\":\"본인\",\"_ROW_STATUS\":\"1\"},{\"BCD_NO\":\"180500000045\",\"CTR_DT\":\"20230303\",\"ETC1\":\"1\",\"POF_FR_DT\":\"2023-06-11~2023-07-14\",\"CNCR_REL_CD\":\"10\",\"LTC_MGMT_NO\":\"L0011559991\",\"WIM_CD\":\"M18030111103\",\"TOT_AMT\":\"16440\",\"QLF_TYPE\":\"일반\",\"NO\":\"6\",\"JUMIN_NO\":\"4002052247918\",\"LTC_RCGT_GRADE_CD\":\"1등급\",\"MGDS_NM\":\"MiKi-W AH\",\"CNCR_NM\":\"이병녀\",\"CNCL_YN\":\"정상\",\"WLR_MTHD_CD\":\"대여\",\"PROD_NM\":\"수동휠체어\",\"IN_TYPE\":\"포털\",\"CNCR_REL_CD_NM\":\"본인\",\"_ROW_STATUS\":\"1\"},{\"BCD_NO\":\"201100000574\",\"CTR_DT\":\"20221207\",\"ETC1\":\"1\",\"POF_FR_DT\":\"2022-12-07~2023-03-28\",\"CNCR_REL_CD\":\"10\",\"LTC_MGMT_NO\":\"L0011559991\",\"WIM_CD\":\"S03091064103\",\"TOT_AMT\":\"273780\",\"QLF_TYPE\":\"일반\",\"NO\":\"7\",\"JUMIN_NO\":\"4002052247918\",\"LTC_RCGT_GRADE_CD\":\"1등급\",\"MGDS_NM\":\"NY(M)-1300\",\"CNCR_NM\":\"이병녀\",\"CNCL_YN\":\"정상\",\"WLR_MTHD_CD\":\"대여\",\"PROD_NM\":\"전동침대\",\"IN_TYPE\":\"포털\",\"CNCR_REL_CD_NM\":\"본인\",\"_ROW_STATUS\":\"1\"},{\"BCD_NO\":\"201100000574\",\"CTR_DT\":\"20221207\",\"ETC1\":\"1\",\"POF_FR_DT\":\"2023-03-29~2023-07-14\",\"CNCR_REL_CD\":\"10\",\"LTC_MGMT_NO\":\"L0011559991\",\"WIM_CD\":\"S03091064103\",\"TOT_AMT\":\"261870\",\"QLF_TYPE\":\"일반\",\"NO\":\"8\",\"JUMIN_NO\":\"4002052247918\",\"LTC_RCGT_GRADE_CD\":\"1등급\",\"MGDS_NM\":\"NY(M)-1300\",\"CNCR_NM\":\"이병녀\",\"CNCL_YN\":\"정상\",\"WLR_MTHD_CD\":\"대여\",\"PROD_NM\":\"전동침대\",\"IN_TYPE\":\"포털\",\"CNCR_REL_CD_NM\":\"본인\",\"_ROW_STATUS\":\"1\"},{\"BCD_NO\":\"200400000262\",\"CTR_DT\":\"20221206\",\"ETC1\":\"1\",\"POF_FR_DT\":\"2022-09-07~2022-12-06\",\"CNCR_REL_CD\":\"22\",\"LTC_MGMT_NO\":\"L0011559991\",\"WIM_CD\":\"S03091064102\",\"TOT_AMT\":\"221820\",\"QLF_TYPE\":\"일반\",\"NO\":\"9\",\"JUMIN_NO\":\"4002052247918\",\"LTC_RCGT_GRADE_CD\":\"1등급\",\"MGDS_NM\":\"NY-1100\",\"CNCR_NM\":\"최미영\",\"CNCL_YN\":\"변경\",\"WLR_MTHD_CD\":\"대여\",\"PROD_NM\":\"전동침대\",\"IN_TYPE\":\"포털\",\"CNCR_REL_CD_NM\":\"가족(자녀)\",\"_ROW_STATUS\":\"1\"},{\"BCD_NO\":\"220800001189\",\"CTR_DT\":\"20220920\",\"ETC1\":\"1\",\"POF_FR_DT\":\"2022-09-20\",\"CNCR_REL_CD\":\"10\",\"LTC_MGMT_NO\":\"L0011559991\",\"WIM_CD\":\"H12060031003\",\"TOT_AMT\":\"241000\",\"QLF_TYPE\":\"일반\",\"NO\":\"10\",\"JUMIN_NO\":\"4002052247918\",\"LTC_RCGT_GRADE_CD\":\"1등급\",\"MGDS_NM\":\"YB-1104A\",\"CNCR_NM\":\"이병녀\",\"CNCL_YN\":\"정상\",\"WLR_MTHD_CD\":\"판매\",\"PROD_NM\":\"욕창예방 매트리스\",\"IN_TYPE\":\"포털\",\"CNCR_REL_CD_NM\":\"본인\",\"_ROW_STATUS\":\"1\"},{\"BCD_NO\":\"180500000045\",\"CTR_DT\":\"20220817\",\"ETC1\":\"1\",\"POF_FR_DT\":\"2022-08-01~2023-03-28\",\"CNCR_REL_CD\":\"10\",\"LTC_MGMT_NO\":\"L0011559991\",\"WIM_CD\":\"M18030111103\",\"TOT_AMT\":\"232350\",\"QLF_TYPE\":\"일반\",\"NO\":\"11\",\"JUMIN_NO\":\"4002052247918\",\"LTC_RCGT_GRADE_CD\":\"1등급\",\"MGDS_NM\":\"MiKi-W AH\",\"CNCR_NM\":\"이병녀\",\"CNCL_YN\":\"정상\",\"WLR_MTHD_CD\":\"대여\",\"PROD_NM\":\"수동휠체어\",\"IN_TYPE\":\"포털\",\"CNCR_REL_CD_NM\":\"본인\",\"_ROW_STATUS\":\"1\"},{\"BCD_NO\":\"180500000045\",\"CTR_DT\":\"20220816\",\"ETC1\":\"1\",\"POF_FR_DT\":\"2021-03-29~2022-03-28\",\"CNCR_REL_CD\":\"10\",\"LTC_MGMT_NO\":\"L0011559991\",\"WIM_CD\":\"M18030111103\",\"TOT_AMT\":\"352800\",\"QLF_TYPE\":\"일반\",\"NO\":\"12\",\"JUMIN_NO\":\"4002052247918\",\"LTC_RCGT_GRADE_CD\":\"1등급\",\"MGDS_NM\":\"MiKi-W AH\",\"CNCR_NM\":\"이병녀\",\"CNCL_YN\":\"변경\",\"WLR_MTHD_CD\":\"대여\",\"PROD_NM\":\"수동휠체어\",\"IN_TYPE\":\"포털\",\"CNCR_REL_CD_NM\":\"본인\",\"_ROW_STATUS\":\"1\"},{\"BCD_NO\":\"180500000045\",\"CTR_DT\":\"20220816\",\"ETC1\":\"1\",\"POF_FR_DT\":\"2022-03-29~2022-07-31\",\"CNCR_REL_CD\":\"10\",\"LTC_MGMT_NO\":\"L0011559991\",\"WIM_CD\":\"M18030111103\",\"TOT_AMT\":\"120450\",\"QLF_TYPE\":\"일반\",\"NO\":\"13\",\"JUMIN_NO\":\"4002052247918\",\"LTC_RCGT_GRADE_CD\":\"1등급\",\"MGDS_NM\":\"MiKi-W AH\",\"CNCR_NM\":\"이병녀\",\"CNCL_YN\":\"변경\",\"WLR_MTHD_CD\":\"대여\",\"PROD_NM\":\"수동휠체어\",\"IN_TYPE\":\"포털\",\"CNCR_REL_CD_NM\":\"본인\",\"_ROW_STATUS\":\"1\"},{\"BCD_NO\":\"210200001282\",\"CTR_DT\":\"20220816\",\"ETC1\":\"1\",\"POF_FR_DT\":\"2021-03-29~2022-03-28\",\"CNCR_REL_CD\":\"10\",\"LTC_MGMT_NO\":\"L0011559991\",\"WIM_CD\":\"H12060031003\",\"TOT_AMT\":\"241200\",\"QLF_TYPE\":\"일반\",\"NO\":\"14\",\"JUMIN_NO\":\"4002052247918\",\"LTC_RCGT_GRADE_CD\":\"1등급\",\"MGDS_NM\":\"YB-1104A\",\"CNCR_NM\":\"이병녀\",\"CNCL_YN\":\"변경\",\"WLR_MTHD_CD\":\"대여\",\"PROD_NM\":\"욕창예방 매트리스\",\"IN_TYPE\":\"포털\",\"CNCR_REL_CD_NM\":\"본인\",\"_ROW_STATUS\":\"1\"},{\"BCD_NO\":\"210200001282\",\"CTR_DT\":\"20220816\",\"ETC1\":\"1\",\"POF_FR_DT\":\"2022-03-29~2022-04-25\",\"CNCR_REL_CD\":\"10\",\"LTC_MGMT_NO\":\"L0011559991\",\"WIM_CD\":\"H12060031003\",\"TOT_AMT\":\"18700\",\"QLF_TYPE\":\"일반\",\"NO\":\"15\",\"JUMIN_NO\":\"4002052247918\",\"LTC_RCGT_GRADE_CD\":\"1등급\",\"MGDS_NM\":\"YB-1104A\",\"CNCR_NM\":\"이병녀\",\"CNCL_YN\":\"변경\",\"WLR_MTHD_CD\":\"대여\",\"PROD_NM\":\"욕창예방 매트리스\",\"IN_TYPE\":\"포털\",\"CNCR_REL_CD_NM\":\"본인\",\"_ROW_STATUS\":\"1\"},{\"BCD_NO\":\"210100000590\",\"CTR_DT\":\"20220816\",\"ETC1\":\"1\",\"POF_FR_DT\":\"2021-03-29~2022-03-28\",\"CNCR_REL_CD\":\"10\",\"LTC_MGMT_NO\":\"L0011559991\",\"WIM_CD\":\"S03091064103\",\"TOT_AMT\":\"885600\",\"QLF_TYPE\":\"일반\",\"NO\":\"16\",\"JUMIN_NO\":\"4002052247918\",\"LTC_RCGT_GRADE_CD\":\"1등급\",\"MGDS_NM\":\"NY(M)-1300\",\"CNCR_NM\":\"이병녀\",\"CNCL_YN\":\"변경\",\"WLR_MTHD_CD\":\"대여\",\"PROD_NM\":\"전동침대\",\"IN_TYPE\":\"포털\",\"CNCR_REL_CD_NM\":\"본인\",\"_ROW_STATUS\":\"1\"},{\"BCD_NO\":\"210100000590\",\"CTR_DT\":\"20220816\",\"ETC1\":\"1\",\"POF_FR_DT\":\"2022-03-29~2022-04-25\",\"CNCR_REL_CD\":\"10\",\"LTC_MGMT_NO\":\"L0011559991\",\"WIM_CD\":\"S03091064103\",\"TOT_AMT\":\"68640\",\"QLF_TYPE\":\"일반\",\"NO\":\"17\",\"JUMIN_NO\":\"4002052247918\",\"LTC_RCGT_GRADE_CD\":\"1등급\",\"MGDS_NM\":\"NY(M)-1300\",\"CNCR_NM\":\"이병녀\",\"CNCL_YN\":\"변경\",\"WLR_MTHD_CD\":\"대여\",\"PROD_NM\":\"전동침대\",\"IN_TYPE\":\"포털\",\"CNCR_REL_CD_NM\":\"본인\",\"_ROW_STATUS\":\"1\"},{\"BCD_NO\":\"220200003566\",\"CTR_DT\":\"20220613\",\"ETC1\":\"1\",\"POF_FR_DT\":\"2022-06-09\",\"CNCR_REL_CD\":\"10\",\"LTC_MGMT_NO\":\"L0011559991\",\"WIM_CD\":\"F30031067109\",\"TOT_AMT\":\"33200\",\"QLF_TYPE\":\"일반\",\"NO\":\"18\",\"JUMIN_NO\":\"4002052247918\",\"LTC_RCGT_GRADE_CD\":\"1등급\",\"MGDS_NM\":\"나이팅게일-C\",\"CNCR_NM\":\"이병녀\",\"CNCL_YN\":\"정상\",\"WLR_MTHD_CD\":\"판매\",\"PROD_NM\":\"미끄럼 방지용품\",\"IN_TYPE\":\"포털\",\"CNCR_REL_CD_NM\":\"본인\",\"_ROW_STATUS\":\"1\"},{\"BCD_NO\":\"220200003567\",\"CTR_DT\":\"20220613\",\"ETC1\":\"1\",\"POF_FR_DT\":\"2022-06-09\",\"CNCR_REL_CD\":\"10\",\"LTC_MGMT_NO\":\"L0011559991\",\"WIM_CD\":\"F30031067109\",\"TOT_AMT\":\"33200\",\"QLF_TYPE\":\"일반\",\"NO\":\"19\",\"JUMIN_NO\":\"4002052247918\",\"LTC_RCGT_GRADE_CD\":\"1등급\",\"MGDS_NM\":\"나이팅게일-C\",\"CNCR_NM\":\"이병녀\",\"CNCL_YN\":\"정상\",\"WLR_MTHD_CD\":\"판매\",\"PROD_NM\":\"미끄럼 방지용품\",\"IN_TYPE\":\"포털\",\"CNCR_REL_CD_NM\":\"본인\",\"_ROW_STATUS\":\"1\"},{\"BCD_NO\":\"220300003433\",\"CTR_DT\":\"20220613\",\"ETC1\":\"1\",\"POF_FR_DT\":\"2022-06-09\",\"CNCR_REL_CD\":\"10\",\"LTC_MGMT_NO\":\"L0011559991\",\"WIM_CD\":\"F30031067109\",\"TOT_AMT\":\"33200\",\"QLF_TYPE\":\"일반\",\"NO\":\"20\",\"JUMIN_NO\":\"4002052247918\",\"LTC_RCGT_GRADE_CD\":\"1등급\",\"MGDS_NM\":\"나이팅게일-C\",\"CNCR_NM\":\"이병녀\",\"CNCL_YN\":\"정상\",\"WLR_MTHD_CD\":\"판매\",\"PROD_NM\":\"미끄럼 방지용품\",\"IN_TYPE\":\"포털\",\"CNCR_REL_CD_NM\":\"본인\",\"_ROW_STATUS\":\"1\"},{\"BCD_NO\":\"220300003434\",\"CTR_DT\":\"20220613\",\"ETC1\":\"1\",\"POF_FR_DT\":\"2022-06-09\",\"CNCR_REL_CD\":\"10\",\"LTC_MGMT_NO\":\"L0011559991\",\"WIM_CD\":\"F30031067109\",\"TOT_AMT\":\"33200\",\"QLF_TYPE\":\"일반\",\"NO\":\"21\",\"JUMIN_NO\":\"4002052247918\",\"LTC_RCGT_GRADE_CD\":\"1등급\",\"MGDS_NM\":\"나이팅게일-C\",\"CNCR_NM\":\"이병녀\",\"CNCL_YN\":\"정상\",\"WLR_MTHD_CD\":\"판매\",\"PROD_NM\":\"미끄럼 방지용품\",\"IN_TYPE\":\"포털\",\"CNCR_REL_CD_NM\":\"본인\",\"_ROW_STATUS\":\"1\"},{\"BCD_NO\":\"220500000674\",\"CTR_DT\":\"20220613\",\"ETC1\":\"1\",\"POF_FR_DT\":\"2022-06-09\",\"CNCR_REL_CD\":\"10\",\"LTC_MGMT_NO\":\"L0011559991\",\"WIM_CD\":\"F18030034104\",\"TOT_AMT\":\"201000\",\"QLF_TYPE\":\"일반\",\"NO\":\"22\",\"JUMIN_NO\":\"4002052247918\",\"LTC_RCGT_GRADE_CD\":\"1등급\",\"MGDS_NM\":\"MSH-502\",\"CNCR_NM\":\"이병녀\",\"CNCL_YN\":\"정상\",\"WLR_MTHD_CD\":\"판매\",\"PROD_NM\":\"안전손잡이\",\"IN_TYPE\":\"포털\",\"CNCR_REL_CD_NM\":\"본인\",\"_ROW_STATUS\":\"1\"},{\"BCD_NO\":\"220200001561\",\"CTR_DT\":\"20220418\",\"ETC1\":\"1\",\"POF_FR_DT\":\"2022-04-11\",\"CNCR_REL_CD\":\"10\",\"LTC_MGMT_NO\":\"L0011559991\",\"WIM_CD\":\"F30031059104\",\"TOT_AMT\":\"51300\",\"QLF_TYPE\":\"일반\",\"NO\":\"23\",\"JUMIN_NO\":\"4002052247918\",\"LTC_RCGT_GRADE_CD\":\"1등급\",\"MGDS_NM\":\"NT-3050\",\"CNCR_NM\":\"이병녀\",\"CNCL_YN\":\"정상\",\"WLR_MTHD_CD\":\"판매\",\"PROD_NM\":\"미끄럼 방지용품\",\"IN_TYPE\":\"포털\",\"CNCR_REL_CD_NM\":\"본인\",\"_ROW_STATUS\":\"1\"},{\"BCD_NO\":\"211200001384\",\"CTR_DT\":\"20220411\",\"ETC1\":\"1\",\"POF_FR_DT\":\"2022-04-11\",\"CNCR_REL_CD\":\"10\",\"LTC_MGMT_NO\":\"L0011559991\",\"WIM_CD\":\"F30091079107\",\"TOT_AMT\":\"3100\",\"QLF_TYPE\":\"일반\",\"NO\":\"24\",\"JUMIN_NO\":\"4002052247918\",\"LTC_RCGT_GRADE_CD\":\"1등급\",\"MGDS_NM\":\"4DM-204\",\"CNCR_NM\":\"이병녀\",\"CNCL_YN\":\"정상\",\"WLR_MTHD_CD\":\"판매\",\"PROD_NM\":\"미끄럼 방지용품\",\"IN_TYPE\":\"포털\",\"CNCR_REL_CD_NM\":\"본인\",\"_ROW_STATUS\":\"1\"},{\"BCD_NO\":\"211200001386\",\"CTR_DT\":\"20220411\",\"ETC1\":\"1\",\"POF_FR_DT\":\"2022-04-11\",\"CNCR_REL_CD\":\"10\",\"LTC_MGMT_NO\":\"L0011559991\",\"WIM_CD\":\"F30091079107\",\"TOT_AMT\":\"3100\",\"QLF_TYPE\":\"일반\",\"NO\":\"25\",\"JUMIN_NO\":\"4002052247918\",\"LTC_RCGT_GRADE_CD\":\"1등급\",\"MGDS_NM\":\"4DM-204\",\"CNCR_NM\":\"이병녀\",\"CNCL_YN\":\"정상\",\"WLR_MTHD_CD\":\"판매\",\"PROD_NM\":\"미끄럼 방지용품\",\"IN_TYPE\":\"포털\",\"CNCR_REL_CD_NM\":\"본인\",\"_ROW_STATUS\":\"1\"},{\"BCD_NO\":\"211200010724\",\"CTR_DT\":\"20220411\",\"ETC1\":\"1\",\"POF_FR_DT\":\"2022-04-11\",\"CNCR_REL_CD\":\"10\",\"LTC_MGMT_NO\":\"L0011559991\",\"WIM_CD\":\"F30091079107\",\"TOT_AMT\":\"3100\",\"QLF_TYPE\":\"일반\",\"NO\":\"26\",\"JUMIN_NO\":\"4002052247918\",\"LTC_RCGT_GRADE_CD\":\"1등급\",\"MGDS_NM\":\"4DM-204\",\"CNCR_NM\":\"이병녀\",\"CNCL_YN\":\"정상\",\"WLR_MTHD_CD\":\"판매\",\"PROD_NM\":\"미끄럼 방지용품\",\"IN_TYPE\":\"포털\",\"CNCR_REL_CD_NM\":\"본인\",\"_ROW_STATUS\":\"1\"},{\"BCD_NO\":\"211200010725\",\"CTR_DT\":\"20220411\",\"ETC1\":\"1\",\"POF_FR_DT\":\"2022-04-11\",\"CNCR_REL_CD\":\"10\",\"LTC_MGMT_NO\":\"L0011559991\",\"WIM_CD\":\"F30091079107\",\"TOT_AMT\":\"3100\",\"QLF_TYPE\":\"일반\",\"NO\":\"27\",\"JUMIN_NO\":\"4002052247918\",\"LTC_RCGT_GRADE_CD\":\"1등급\",\"MGDS_NM\":\"4DM-204\",\"CNCR_NM\":\"이병녀\",\"CNCL_YN\":\"정상\",\"WLR_MTHD_CD\":\"판매\",\"PROD_NM\":\"미끄럼 방지용품\",\"IN_TYPE\":\"포털\",\"CNCR_REL_CD_NM\":\"본인\",\"_ROW_STATUS\":\"1\"},{\"BCD_NO\":\"211200013556\",\"CTR_DT\":\"20220411\",\"ETC1\":\"1\",\"POF_FR_DT\":\"2022-04-11\",\"CNCR_REL_CD\":\"10\",\"LTC_MGMT_NO\":\"L0011559991\",\"WIM_CD\":\"F30091003101\",\"TOT_AMT\":\"3100\",\"QLF_TYPE\":\"일반\",\"NO\":\"28\",\"JUMIN_NO\":\"4002052247918\",\"LTC_RCGT_GRADE_CD\":\"1등급\",\"MGDS_NM\":\"편안한덧신양말(공용)\",\"CNCR_NM\":\"이병녀\",\"CNCL_YN\":\"정상\",\"WLR_MTHD_CD\":\"판매\",\"PROD_NM\":\"미끄럼 방지용품\",\"IN_TYPE\":\"포털\",\"CNCR_REL_CD_NM\":\"본인\",\"_ROW_STATUS\":\"1\"},{\"BCD_NO\":\"220200001663\",\"CTR_DT\":\"20220411\",\"ETC1\":\"1\",\"POF_FR_DT\":\"2022-04-11\",\"CNCR_REL_CD\":\"10\",\"LTC_MGMT_NO\":\"L0011559991\",\"WIM_CD\":\"F30091003101\",\"TOT_AMT\":\"3100\",\"QLF_TYPE\":\"일반\",\"NO\":\"29\",\"JUMIN_NO\":\"4002052247918\",\"LTC_RCGT_GRADE_CD\":\"1등급\",\"MGDS_NM\":\"편안한덧신양말(공용)\",\"CNCR_NM\":\"이병녀\",\"CNCL_YN\":\"정상\",\"WLR_MTHD_CD\":\"판매\",\"PROD_NM\":\"미끄럼 방지용품\",\"IN_TYPE\":\"포털\",\"CNCR_REL_CD_NM\":\"본인\",\"_ROW_STATUS\":\"1\"},{\"BCD_NO\":\"210900007291\",\"CTR_DT\":\"20220314\",\"ETC1\":\"1\",\"POF_FR_DT\":\"2022-03-14\",\"CNCR_REL_CD\":\"10\",\"LTC_MGMT_NO\":\"L0011559991\",\"WIM_CD\":\"F30091039103\",\"TOT_AMT\":\"3000\",\"QLF_TYPE\":\"일반\",\"NO\":\"30\",\"JUMIN_NO\":\"4002052247918\",\"LTC_RCGT_GRADE_CD\":\"1등급\",\"MGDS_NM\":\"YH-004\",\"CNCR_NM\":\"이병녀\",\"CNCL_YN\":\"정상\",\"WLR_MTHD_CD\":\"판매\",\"PROD_NM\":\"미끄럼 방지용품\",\"IN_TYPE\":\"포털\",\"CNCR_REL_CD_NM\":\"본인\",\"_ROW_STATUS\":\"1\"},{\"BCD_NO\":\"210900007292\",\"CTR_DT\":\"20220314\",\"ETC1\":\"1\",\"POF_FR_DT\":\"2022-03-14\",\"CNCR_REL_CD\":\"10\",\"LTC_MGMT_NO\":\"L0011559991\",\"WIM_CD\":\"F30091039103\",\"TOT_AMT\":\"3000\",\"QLF_TYPE\":\"일반\",\"NO\":\"31\",\"JUMIN_NO\":\"4002052247918\",\"LTC_RCGT_GRADE_CD\":\"1등급\",\"MGDS_NM\":\"YH-004\",\"CNCR_NM\":\"이병녀\",\"CNCL_YN\":\"정상\",\"WLR_MTHD_CD\":\"판매\",\"PROD_NM\":\"미끄럼 방지용품\",\"IN_TYPE\":\"포털\",\"CNCR_REL_CD_NM\":\"본인\",\"_ROW_STATUS\":\"1\"},{\"BCD_NO\":\"210900007293\",\"CTR_DT\":\"20220314\",\"ETC1\":\"1\",\"POF_FR_DT\":\"2022-03-14\",\"CNCR_REL_CD\":\"10\",\"LTC_MGMT_NO\":\"L0011559991\",\"WIM_CD\":\"F30091039103\",\"TOT_AMT\":\"3000\",\"QLF_TYPE\":\"일반\",\"NO\":\"32\",\"JUMIN_NO\":\"4002052247918\",\"LTC_RCGT_GRADE_CD\":\"1등급\",\"MGDS_NM\":\"YH-004\",\"CNCR_NM\":\"이병녀\",\"CNCL_YN\":\"정상\",\"WLR_MTHD_CD\":\"판매\",\"PROD_NM\":\"미끄럼 방지용품\",\"IN_TYPE\":\"포털\",\"CNCR_REL_CD_NM\":\"본인\",\"_ROW_STATUS\":\"1\"},{\"BCD_NO\":\"210900007294\",\"CTR_DT\":\"20220314\",\"ETC1\":\"1\",\"POF_FR_DT\":\"2022-03-14\",\"CNCR_REL_CD\":\"10\",\"LTC_MGMT_NO\":\"L0011559991\",\"WIM_CD\":\"F30091039103\",\"TOT_AMT\":\"3000\",\"QLF_TYPE\":\"일반\",\"NO\":\"33\",\"JUMIN_NO\":\"4002052247918\",\"LTC_RCGT_GRADE_CD\":\"1등급\",\"MGDS_NM\":\"YH-004\",\"CNCR_NM\":\"이병녀\",\"CNCL_YN\":\"정상\",\"WLR_MTHD_CD\":\"판매\",\"PROD_NM\":\"미끄럼 방지용품\",\"IN_TYPE\":\"포털\",\"CNCR_REL_CD_NM\":\"본인\",\"_ROW_STATUS\":\"1\"},{\"BCD_NO\":\"210900007295\",\"CTR_DT\":\"20220314\",\"ETC1\":\"1\",\"POF_FR_DT\":\"2022-03-14\",\"CNCR_REL_CD\":\"10\",\"LTC_MGMT_NO\":\"L0011559991\",\"WIM_CD\":\"F30091039103\",\"TOT_AMT\":\"3000\",\"QLF_TYPE\":\"일반\",\"NO\":\"34\",\"JUMIN_NO\":\"4002052247918\",\"LTC_RCGT_GRADE_CD\":\"1등급\",\"MGDS_NM\":\"YH-004\",\"CNCR_NM\":\"이병녀\",\"CNCL_YN\":\"정상\",\"WLR_MTHD_CD\":\"판매\",\"PROD_NM\":\"미끄럼 방지용품\",\"IN_TYPE\":\"포털\",\"CNCR_REL_CD_NM\":\"본인\",\"_ROW_STATUS\":\"1\"},{\"BCD_NO\":\"210900007296\",\"CTR_DT\":\"20220314\",\"ETC1\":\"1\",\"POF_FR_DT\":\"2022-03-14\",\"CNCR_REL_CD\":\"10\",\"LTC_MGMT_NO\":\"L0011559991\",\"WIM_CD\":\"F30091039103\",\"TOT_AMT\":\"3000\",\"QLF_TYPE\":\"일반\",\"NO\":\"35\",\"JUMIN_NO\":\"4002052247918\",\"LTC_RCGT_GRADE_CD\":\"1등급\",\"MGDS_NM\":\"YH-004\",\"CNCR_NM\":\"이병녀\",\"CNCL_YN\":\"정상\",\"WLR_MTHD_CD\":\"판매\",\"PROD_NM\":\"미끄럼 방지용품\",\"IN_TYPE\":\"포털\",\"CNCR_REL_CD_NM\":\"본인\",\"_ROW_STATUS\":\"1\"},{\"BCD_NO\":\"211200002170\",\"CTR_DT\":\"20220314\",\"ETC1\":\"1\",\"POF_FR_DT\":\"2022-03-14\",\"CNCR_REL_CD\":\"10\",\"LTC_MGMT_NO\":\"L0011559991\",\"WIM_CD\":\"T09061052101\",\"TOT_AMT\":\"22200\",\"QLF_TYPE\":\"일반\",\"NO\":\"36\",\"JUMIN_NO\":\"4002052247918\",\"LTC_RCGT_GRADE_CD\":\"1등급\",\"MGDS_NM\":\"WHR-01\",\"CNCR_NM\":\"이병녀\",\"CNCL_YN\":\"정상\",\"WLR_MTHD_CD\":\"판매\",\"PROD_NM\":\"요실금팬티\",\"IN_TYPE\":\"포털\",\"CNCR_REL_CD_NM\":\"본인\",\"_ROW_STATUS\":\"1\"},{\"BCD_NO\":\"211200002171\",\"CTR_DT\":\"20220314\",\"ETC1\":\"1\",\"POF_FR_DT\":\"2022-03-14\",\"CNCR_REL_CD\":\"10\",\"LTC_MGMT_NO\":\"L0011559991\",\"WIM_CD\":\"T09061052101\",\"TOT_AMT\":\"22200\",\"QLF_TYPE\":\"일반\",\"NO\":\"37\",\"JUMIN_NO\":\"4002052247918\",\"LTC_RCGT_GRADE_CD\":\"1등급\",\"MGDS_NM\":\"WHR-01\",\"CNCR_NM\":\"이병녀\",\"CNCL_YN\":\"정상\",\"WLR_MTHD_CD\":\"판매\",\"PROD_NM\":\"요실금팬티\",\"IN_TYPE\":\"포털\",\"CNCR_REL_CD_NM\":\"본인\",\"_ROW_STATUS\":\"1\"},{\"BCD_NO\":\"211200002172\",\"CTR_DT\":\"20220314\",\"ETC1\":\"1\",\"POF_FR_DT\":\"2022-03-14\",\"CNCR_REL_CD\":\"10\",\"LTC_MGMT_NO\":\"L0011559991\",\"WIM_CD\":\"T09061052101\",\"TOT_AMT\":\"22200\",\"QLF_TYPE\":\"일반\",\"NO\":\"38\",\"JUMIN_NO\":\"4002052247918\",\"LTC_RCGT_GRADE_CD\":\"1등급\",\"MGDS_NM\":\"WHR-01\",\"CNCR_NM\":\"이병녀\",\"CNCL_YN\":\"정상\",\"WLR_MTHD_CD\":\"판매\",\"PROD_NM\":\"요실금팬티\",\"IN_TYPE\":\"포털\",\"CNCR_REL_CD_NM\":\"본인\",\"_ROW_STATUS\":\"1\"},{\"BCD_NO\":\"211200002173\",\"CTR_DT\":\"20220314\",\"ETC1\":\"1\",\"POF_FR_DT\":\"2022-03-14\",\"CNCR_REL_CD\":\"10\",\"LTC_MGMT_NO\":\"L0011559991\",\"WIM_CD\":\"T09061052101\",\"TOT_AMT\":\"22200\",\"QLF_TYPE\":\"일반\",\"NO\":\"39\",\"JUMIN_NO\":\"4002052247918\",\"LTC_RCGT_GRADE_CD\":\"1등급\",\"MGDS_NM\":\"WHR-01\",\"CNCR_NM\":\"이병녀\",\"CNCL_YN\":\"정상\",\"WLR_MTHD_CD\":\"판매\",\"PROD_NM\":\"요실금팬티\",\"IN_TYPE\":\"포털\",\"CNCR_REL_CD_NM\":\"본인\",\"_ROW_STATUS\":\"1\"},{\"BCD_NO\":\"210200001282\",\"CTR_DT\":\"20210302\",\"ETC1\":\"1\",\"POF_FR_DT\":\"2021-03-02~2021-03-28\",\"CNCR_REL_CD\":\"10\",\"LTC_MGMT_NO\":\"L0011559991\",\"WIM_CD\":\"H12060031003\",\"TOT_AMT\":\"17510\",\"QLF_TYPE\":\"일반\",\"NO\":\"40\",\"JUMIN_NO\":\"4002052247918\",\"LTC_RCGT_GRADE_CD\":\"1등급\",\"MGDS_NM\":\"YB-1104A\",\"CNCR_NM\":\"이병녀\",\"CNCL_YN\":\"정상\",\"WLR_MTHD_CD\":\"대여\",\"PROD_NM\":\"욕창예방 매트리스\",\"IN_TYPE\":\"포털\",\"CNCR_REL_CD_NM\":\"본인\",\"_ROW_STATUS\":\"1\"},{\"BCD_NO\":\"210100000590\",\"CTR_DT\":\"20210302\",\"ETC1\":\"1\",\"POF_FR_DT\":\"2021-03-02~2021-03-28\",\"CNCR_REL_CD\":\"10\",\"LTC_MGMT_NO\":\"L0011559991\",\"WIM_CD\":\"S03091064103\",\"TOT_AMT\":\"64280\",\"QLF_TYPE\":\"일반\",\"NO\":\"41\",\"JUMIN_NO\":\"4002052247918\",\"LTC_RCGT_GRADE_CD\":\"1등급\",\"MGDS_NM\":\"NY(M)-1300\",\"CNCR_NM\":\"이병녀\",\"CNCL_YN\":\"정상\",\"WLR_MTHD_CD\":\"대여\",\"PROD_NM\":\"전동침대\",\"IN_TYPE\":\"포털\",\"CNCR_REL_CD_NM\":\"본인\",\"_ROW_STATUS\":\"1\"},{\"BCD_NO\":\"200100000168\",\"CTR_DT\":\"20210222\",\"ETC1\":\"1\",\"POF_FR_DT\":\"2021-01-06~2021-02-22\",\"CNCR_REL_CD\":\"10\",\"LTC_MGMT_NO\":\"L0011559991\",\"WIM_CD\":\"H12060031003\",\"TOT_AMT\":\"32650\",\"QLF_TYPE\":\"일반\",\"NO\":\"42\",\"JUMIN_NO\":\"4002052247918\",\"LTC_RCGT_GRADE_CD\":\"1등급\",\"MGDS_NM\":\"YB-1104A\",\"CNCR_NM\":\"이병녀\",\"CNCL_YN\":\"변경\",\"WLR_MTHD_CD\":\"대여\",\"PROD_NM\":\"욕창예방 매트리스\",\"IN_TYPE\":\"포털\",\"CNCR_REL_CD_NM\":\"본인\",\"_ROW_STATUS\":\"1\"},{\"BCD_NO\":\"16040265\",\"CTR_DT\":\"20210222\",\"ETC1\":\"1\",\"POF_FR_DT\":\"2020-08-18~2021-02-22\",\"CNCR_REL_CD\":\"10\",\"LTC_MGMT_NO\":\"L0011559991\",\"WIM_CD\":\"S03090035103\",\"TOT_AMT\":\"455330\",\"QLF_TYPE\":\"일반\",\"NO\":\"43\",\"JUMIN_NO\":\"4002052247918\",\"LTC_RCGT_GRADE_CD\":\"1등급\",\"MGDS_NM\":\"JB920LITE\",\"CNCR_NM\":\"이병녀\",\"CNCL_YN\":\"변경\",\"WLR_MTHD_CD\":\"대여\",\"PROD_NM\":\"전동침대\",\"IN_TYPE\":\"포털\",\"CNCR_REL_CD_NM\":\"본인\",\"_ROW_STATUS\":\"1\"},{\"BCD_NO\":\"201200013964\",\"CTR_DT\":\"20210215\",\"ETC1\":\"1\",\"POF_FR_DT\":\"2021-02-15\",\"CNCR_REL_CD\":\"10\",\"LTC_MGMT_NO\":\"L0011559991\",\"WIM_CD\":\"F30091039113\",\"TOT_AMT\":\"3800\",\"QLF_TYPE\":\"일반\",\"NO\":\"44\",\"JUMIN_NO\":\"4002052247918\",\"LTC_RCGT_GRADE_CD\":\"1등급\",\"MGDS_NM\":\"YH-202\",\"CNCR_NM\":\"이병녀\",\"CNCL_YN\":\"정상\",\"WLR_MTHD_CD\":\"판매\",\"PROD_NM\":\"미끄럼 방지용품\",\"IN_TYPE\":\"포털\",\"CNCR_REL_CD_NM\":\"본인\",\"_ROW_STATUS\":\"1\"},{\"BCD_NO\":\"201200013965\",\"CTR_DT\":\"20210215\",\"ETC1\":\"1\",\"POF_FR_DT\":\"2021-02-15\",\"CNCR_REL_CD\":\"10\",\"LTC_MGMT_NO\":\"L0011559991\",\"WIM_CD\":\"F30091039113\",\"TOT_AMT\":\"3800\",\"QLF_TYPE\":\"일반\",\"NO\":\"45\",\"JUMIN_NO\":\"4002052247918\",\"LTC_RCGT_GRADE_CD\":\"1등급\",\"MGDS_NM\":\"YH-202\",\"CNCR_NM\":\"이병녀\",\"CNCL_YN\":\"정상\",\"WLR_MTHD_CD\":\"판매\",\"PROD_NM\":\"미끄럼 방지용품\",\"IN_TYPE\":\"포털\",\"CNCR_REL_CD_NM\":\"본인\",\"_ROW_STATUS\":\"1\"},{\"BCD_NO\":\"201200013966\",\"CTR_DT\":\"20210215\",\"ETC1\":\"1\",\"POF_FR_DT\":\"2021-02-15\",\"CNCR_REL_CD\":\"10\",\"LTC_MGMT_NO\":\"L0011559991\",\"WIM_CD\":\"F30091039113\",\"TOT_AMT\":\"3800\",\"QLF_TYPE\":\"일반\",\"NO\":\"46\",\"JUMIN_NO\":\"4002052247918\",\"LTC_RCGT_GRADE_CD\":\"1등급\",\"MGDS_NM\":\"YH-202\",\"CNCR_NM\":\"이병녀\",\"CNCL_YN\":\"정상\",\"WLR_MTHD_CD\":\"판매\",\"PROD_NM\":\"미끄럼 방지용품\",\"IN_TYPE\":\"포털\",\"CNCR_REL_CD_NM\":\"본인\",\"_ROW_STATUS\":\"1\"},{\"BCD_NO\":\"201200013967\",\"CTR_DT\":\"20210215\",\"ETC1\":\"1\",\"POF_FR_DT\":\"2021-02-15\",\"CNCR_REL_CD\":\"10\",\"LTC_MGMT_NO\":\"L0011559991\",\"WIM_CD\":\"F30091039113\",\"TOT_AMT\":\"3800\",\"QLF_TYPE\":\"일반\",\"NO\":\"47\",\"JUMIN_NO\":\"4002052247918\",\"LTC_RCGT_GRADE_CD\":\"1등급\",\"MGDS_NM\":\"YH-202\",\"CNCR_NM\":\"이병녀\",\"CNCL_YN\":\"정상\",\"WLR_MTHD_CD\":\"판매\",\"PROD_NM\":\"미끄럼 방지용품\",\"IN_TYPE\":\"포털\",\"CNCR_REL_CD_NM\":\"본인\",\"_ROW_STATUS\":\"1\"},{\"BCD_NO\":\"201200013968\",\"CTR_DT\":\"20210215\",\"ETC1\":\"1\",\"POF_FR_DT\":\"2021-02-15\",\"CNCR_REL_CD\":\"10\",\"LTC_MGMT_NO\":\"L0011559991\",\"WIM_CD\":\"F30091039113\",\"TOT_AMT\":\"3800\",\"QLF_TYPE\":\"일반\",\"NO\":\"48\",\"JUMIN_NO\":\"4002052247918\",\"LTC_RCGT_GRADE_CD\":\"1등급\",\"MGDS_NM\":\"YH-202\",\"CNCR_NM\":\"이병녀\",\"CNCL_YN\":\"정상\",\"WLR_MTHD_CD\":\"판매\",\"PROD_NM\":\"미끄럼 방지용품\",\"IN_TYPE\":\"포털\",\"CNCR_REL_CD_NM\":\"본인\",\"_ROW_STATUS\":\"1\"},{\"BCD_NO\":\"201200013969\",\"CTR_DT\":\"20210215\",\"ETC1\":\"1\",\"POF_FR_DT\":\"2021-02-15\",\"CNCR_REL_CD\":\"10\",\"LTC_MGMT_NO\":\"L0011559991\",\"WIM_CD\":\"F30091039113\",\"TOT_AMT\":\"3800\",\"QLF_TYPE\":\"일반\",\"NO\":\"49\",\"JUMIN_NO\":\"4002052247918\",\"LTC_RCGT_GRADE_CD\":\"1등급\",\"MGDS_NM\":\"YH-202\",\"CNCR_NM\":\"이병녀\",\"CNCL_YN\":\"정상\",\"WLR_MTHD_CD\":\"판매\",\"PROD_NM\":\"미끄럼 방지용품\",\"IN_TYPE\":\"포털\",\"CNCR_REL_CD_NM\":\"본인\",\"_ROW_STATUS\":\"1\"},{\"BCD_NO\":\"180500000045\",\"CTR_DT\":\"20210215\",\"ETC1\":\"1\",\"POF_FR_DT\":\"2021-02-15~2021-02-26\",\"CNCR_REL_CD\":\"10\",\"LTC_MGMT_NO\":\"L0011559991\",\"WIM_CD\":\"M18030111103\",\"TOT_AMT\":\"12600\",\"QLF_TYPE\":\"일반\",\"NO\":\"50\",\"JUMIN_NO\":\"4002052247918\",\"LTC_RCGT_GRADE_CD\":\"1등급\",\"MGDS_NM\":\"MiKi-W AH\",\"CNCR_NM\":\"이병녀\",\"CNCL_YN\":\"취소\",\"WLR_MTHD_CD\":\"대여\",\"PROD_NM\":\"수동휠체어\",\"IN_TYPE\":\"포털\",\"CNCR_REL_CD_NM\":\"본인\",\"_ROW_STATUS\":\"1\"},{\"BCD_NO\":\"180500000045\",\"CTR_DT\":\"20210215\",\"ETC1\":\"1\",\"POF_FR_DT\":\"2021-02-15~2021-03-28\",\"CNCR_REL_CD\":\"10\",\"LTC_MGMT_NO\":\"L0011559991\",\"WIM_CD\":\"M18030111103\",\"TOT_AMT\":\"41250\",\"QLF_TYPE\":\"일반\",\"NO\":\"51\",\"JUMIN_NO\":\"4002052247918\",\"LTC_RCGT_GRADE_CD\":\"1등급\",\"MGDS_NM\":\"MiKi-W AH\",\"CNCR_NM\":\"이병녀\",\"CNCL_YN\":\"정상\",\"WLR_MTHD_CD\":\"대여\",\"PROD_NM\":\"수동휠체어\",\"IN_TYPE\":\"포털\",\"CNCR_REL_CD_NM\":\"본인\",\"_ROW_STATUS\":\"1\"},{\"BCD_NO\":\"210100001043\",\"CTR_DT\":\"20210215\",\"ETC1\":\"1\",\"POF_FR_DT\":\"2021-02-15\",\"CNCR_REL_CD\":\"10\",\"LTC_MGMT_NO\":\"L0011559991\",\"WIM_CD\":\"F18030060120\",\"TOT_AMT\":\"219000\",\"QLF_TYPE\":\"일반\",\"NO\":\"52\",\"JUMIN_NO\":\"4002052247918\",\"LTC_RCGT_GRADE_CD\":\"1등급\",\"MGDS_NM\":\"ASH-201\",\"CNCR_NM\":\"이병녀\",\"CNCL_YN\":\"정상\",\"WLR_MTHD_CD\":\"판매\",\"PROD_NM\":\"안전손잡이\",\"IN_TYPE\":\"포털\",\"CNCR_REL_CD_NM\":\"본인\",\"_ROW_STATUS\":\"1\"},{\"BCD_NO\":\"201200006807\",\"CTR_DT\":\"20210215\",\"ETC1\":\"1\",\"POF_FR_DT\":\"2021-02-15\",\"CNCR_REL_CD\":\"10\",\"LTC_MGMT_NO\":\"L0011559991\",\"WIM_CD\":\"T09060165006\",\"TOT_AMT\":\"38400\",\"QLF_TYPE\":\"일반\",\"NO\":\"53\",\"JUMIN_NO\":\"4002052247918\",\"LTC_RCGT_GRADE_CD\":\"1등급\",\"MGDS_NM\":\"AW300코지50cc\",\"CNCR_NM\":\"이병녀\",\"CNCL_YN\":\"정상\",\"WLR_MTHD_CD\":\"판매\",\"PROD_NM\":\"요실금팬티\",\"IN_TYPE\":\"포털\",\"CNCR_REL_CD_NM\":\"본인\",\"_ROW_STATUS\":\"1\"},{\"BCD_NO\":\"201200006808\",\"CTR_DT\":\"20210215\",\"ETC1\":\"1\",\"POF_FR_DT\":\"2021-02-15\",\"CNCR_REL_CD\":\"10\",\"LTC_MGMT_NO\":\"L0011559991\",\"WIM_CD\":\"T09060165006\",\"TOT_AMT\":\"38400\",\"QLF_TYPE\":\"일반\",\"NO\":\"54\",\"JUMIN_NO\":\"4002052247918\",\"LTC_RCGT_GRADE_CD\":\"1등급\",\"MGDS_NM\":\"AW300코지50cc\",\"CNCR_NM\":\"이병녀\",\"CNCL_YN\":\"정상\",\"WLR_MTHD_CD\":\"판매\",\"PROD_NM\":\"요실금팬티\",\"IN_TYPE\":\"포털\",\"CNCR_REL_CD_NM\":\"본인\",\"_ROW_STATUS\":\"1\"},{\"BCD_NO\":\"201200006809\",\"CTR_DT\":\"20210215\",\"ETC1\":\"1\",\"POF_FR_DT\":\"2021-02-15\",\"CNCR_REL_CD\":\"10\",\"LTC_MGMT_NO\":\"L0011559991\",\"WIM_CD\":\"T09060165006\",\"TOT_AMT\":\"38400\",\"QLF_TYPE\":\"일반\",\"NO\":\"55\",\"JUMIN_NO\":\"4002052247918\",\"LTC_RCGT_GRADE_CD\":\"1등급\",\"MGDS_NM\":\"AW300코지50cc\",\"CNCR_NM\":\"이병녀\",\"CNCL_YN\":\"취소\",\"WLR_MTHD_CD\":\"판매\",\"PROD_NM\":\"요실금팬티\",\"IN_TYPE\":\"포털\",\"CNCR_REL_CD_NM\":\"본인\",\"_ROW_STATUS\":\"1\"},{\"BCD_NO\":\"200800002032\",\"CTR_DT\":\"20210215\",\"ETC1\":\"1\",\"POF_FR_DT\":\"2021-02-15\",\"CNCR_REL_CD\":\"10\",\"LTC_MGMT_NO\":\"L0011559991\",\"WIM_CD\":\"M03031071601\",\"TOT_AMT\":\"69400\",\"QLF_TYPE\":\"일반\",\"NO\":\"56\",\"JUMIN_NO\":\"4002052247918\",\"LTC_RCGT_GRADE_CD\":\"1등급\",\"MGDS_NM\":\"백건 여자 지팡이-01\",\"CNCR_NM\":\"이병녀\",\"CNCL_YN\":\"정상\",\"WLR_MTHD_CD\":\"판매\",\"PROD_NM\":\"지팡이\",\"IN_TYPE\":\"포털\",\"CNCR_REL_CD_NM\":\"본인\",\"_ROW_STATUS\":\"1\"},{\"BCD_NO\":\"200100001412\",\"CTR_DT\":\"20200709\",\"ETC1\":\"1\",\"POF_FR_DT\":\"2020-07-08\",\"CNCR_REL_CD\":\"10\",\"LTC_MGMT_NO\":\"L0011559991\",\"WIM_CD\":\"B03180088605\",\"TOT_AMT\":\"186000\",\"QLF_TYPE\":\"일반\",\"NO\":\"57\",\"JUMIN_NO\":\"4002052247918\",\"LTC_RCGT_GRADE_CD\":\"1등급\",\"MGDS_NM\":\"IU\",\"CNCR_NM\":\"이병녀\",\"CNCL_YN\":\"정상\",\"WLR_MTHD_CD\":\"판매\",\"PROD_NM\":\"목욕의자\",\"IN_TYPE\":\"포털\",\"CNCR_REL_CD_NM\":\"본인\",\"_ROW_STATUS\":\"1\"},{\"BCD_NO\":\"200400001645\",\"CTR_DT\":\"20200709\",\"ETC1\":\"1\",\"POF_FR_DT\":\"2020-07-08\",\"CNCR_REL_CD\":\"10\",\"LTC_MGMT_NO\":\"L0011559991\",\"WIM_CD\":\"M06061091101\",\"TOT_AMT\":\"54500\",\"QLF_TYPE\":\"일반\",\"NO\":\"58\",\"JUMIN_NO\":\"4002052247918\",\"LTC_RCGT_GRADE_CD\":\"1등급\",\"MGDS_NM\":\"CK-06\",\"CNCR_NM\":\"이병녀\",\"CNCL_YN\":\"정상\",\"WLR_MTHD_CD\":\"판매\",\"PROD_NM\":\"성인용보행기\",\"IN_TYPE\":\"포털\",\"CNCR_REL_CD_NM\":\"본인\",\"_ROW_STATUS\":\"1\"},{\"BCD_NO\":\"200400000008\",\"CTR_DT\":\"20200709\",\"ETC1\":\"1\",\"POF_FR_DT\":\"2020-07-08\",\"CNCR_REL_CD\":\"10\",\"LTC_MGMT_NO\":\"L0011559991\",\"WIM_CD\":\"M06090088606\",\"TOT_AMT\":\"166000\",\"QLF_TYPE\":\"일반\",\"NO\":\"59\",\"JUMIN_NO\":\"4002052247918\",\"LTC_RCGT_GRADE_CD\":\"1등급\",\"MGDS_NM\":\"ST10\",\"CNCR_NM\":\"이병녀\",\"CNCL_YN\":\"정상\",\"WLR_MTHD_CD\":\"판매\",\"PROD_NM\":\"성인용보행기\",\"IN_TYPE\":\"포털\",\"CNCR_REL_CD_NM\":\"본인\",\"_ROW_STATUS\":\"1\"},{\"BCD_NO\":\"181100000163\",\"CTR_DT\":\"20200709\",\"ETC1\":\"1\",\"POF_FR_DT\":\"2020-07-08\",\"CNCR_REL_CD\":\"10\",\"LTC_MGMT_NO\":\"L0011559991\",\"WIM_CD\":\"T03030081602\",\"TOT_AMT\":\"162000\",\"QLF_TYPE\":\"일반\",\"NO\":\"60\",\"JUMIN_NO\":\"4002052247918\",\"LTC_RCGT_GRADE_CD\":\"1등급\",\"MGDS_NM\":\"PN-L30200BK\",\"CNCR_NM\":\"이병녀\",\"CNCL_YN\":\"정상\",\"WLR_MTHD_CD\":\"판매\",\"PROD_NM\":\"이동변기\",\"IN_TYPE\":\"포털\",\"CNCR_REL_CD_NM\":\"본인\",\"_ROW_STATUS\":\"1\"}]},\"ApiTxKey\":\"ef4b28f2-0872-450d-90be-9b592f728717\",\"Status\":\"OK\",\"StatusSeq\":0,\"ErrorCode\":0,\"Message\":\"성공\",\"ErrorLog\":null,\"TargetCode\":null,\"TargetMessage\":null}";

		return responseStr;
	}

}