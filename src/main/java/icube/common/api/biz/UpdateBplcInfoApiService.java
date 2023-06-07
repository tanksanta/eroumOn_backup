package icube.common.api.biz;

import java.io.OutputStream;
import java.net.HttpURLConnection;
import java.net.URL;
import java.nio.charset.StandardCharsets;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.apache.commons.io.IOUtils;
import org.egovframe.rte.fdl.string.EgovStringUtil;
import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;

import icube.common.util.Base64Util;
import icube.common.values.CodeMap;
import icube.manage.gds.gds.biz.GdsService;
import icube.manage.gds.gds.biz.GdsVO;
import icube.manage.gds.optn.biz.GdsOptnService;
import icube.manage.mbr.mbr.biz.MbrService;
import icube.manage.mbr.mbr.biz.MbrVO;
import icube.manage.ordr.chghist.biz.OrdrChgHistService;
import icube.manage.ordr.chghist.biz.OrdrChgHistVO;
import icube.manage.ordr.dtl.biz.OrdrDtlService;
import icube.manage.ordr.dtl.biz.OrdrDtlVO;
import icube.manage.ordr.ordr.biz.OrdrService;
import icube.manage.ordr.ordr.biz.OrdrVO;

@Service("updateBplcInfoApiService")
public class UpdateBplcInfoApiService {

	@Resource(name = "ordrService")
	private OrdrService ordrService;

	@Resource(name = "ordrDtlService")
	private OrdrDtlService ordrDtlService;

	@Resource(name = "gdsService")
	private GdsService gdsService;

	@Resource(name = "mbrService")
	private MbrService mbrService;

	@Resource(name = "gdsOptnService")
	private GdsOptnService gdsOptnService;

	@Resource(name = "ordrChgHistService")
	private OrdrChgHistService ordrChgHistService;

	@Value("#{props['Globals.EroumCare.PrivateKey']}")
	private String eroumKey;

	@Value("#{props['Globals.EroumCare.path']}")
	private String urlPath;

	JSONParser jsonParser = new JSONParser();

	/**
	 * 주문 정보 1.5 -> 1.0 급여 상품 정보 요청
	 * item_info
	 * @param 상품 정보 배열
	 * @return returnMap
	 * @throws Exception
	 */
	public String selectEroumCareOrdr(ArrayList<Map<String, Object>> arrayList) throws Exception {
		Map<String, Object> resultMap = new LinkedHashMap<String, Object>();

		// 필수 항목 : eroumAPI_Key, API_Div, ProdPayCode, item_id, item_opt_id
		resultMap.clear();
		resultMap.put("API_Div", Base64Util.encoder("item_info"));
		resultMap.put("_array_item", arrayList);

		System.out.println("##### resultMap ##### : " + resultMap.toString());
		String JsonData = this.urlConnect(resultMap);
		return JsonData;
	}

	/**
	 * 1.5 상품 정보 업데이트
	 * @param JsonData
	 * @param ordrDtlVO
	 */
	public void updateMarketGdsInfo(String JsonData) throws Exception {
		Object obj = jsonParser.parse(JsonData);
		JSONObject jsonObj = (JSONObject)obj;

		System.out.println("#### jsonObj #### " + jsonObj.toJSONString());

		// 상품 배열 파싱
		JSONArray array_item = (JSONArray) jsonObj.get("_array_item");
		for(int i=0; i<array_item.size(); i++) {
			JSONObject item = (JSONObject) array_item.get(i);
			String bnefCd = Base64Util.decoder((String)item.get("ProdPayCode"));
			String itemId = Base64Util.decoder((String)item.get("item_id"));
			String itemNm = Base64Util.decoder((String)item.get("item_nm"));
			String itemQty = Base64Util.decoder((String)item.get("item_qty"));
			String itemSoldout = Base64Util.decoder((String)item.get("item_soldout"));
			String itemUse = Base64Util.decoder((String)item.get("item_use"));
			String itemOptTag = Base64Util.decoder((String)item.get("item_opt_tag"));

			System.out.println("#### 상품 급여 코드 #### " + bnefCd);
			System.out.println("#### 상품 아이디 #### " + itemId);
			System.out.println("#### 상품 명 #### " + itemNm);
			System.out.println("#### 상품 수량 #### " + itemQty);
			System.out.println("#### 상품 품절 여부 #### " + itemSoldout);
			System.out.println("#### 상품 사용 여부 #### " + itemUse);
			System.out.println("#### 상품 태그 #### " + itemOptTag);

			Map<String, Object> paramMap = new HashMap<String, Object>();
			paramMap.put("srchBnefCd", bnefCd);
			paramMap.put("srchUseYn", "Y");

			GdsVO gdsVO = gdsService.selectGdsByFilter(paramMap);
			if(gdsVO != null) {
				paramMap.put("stockQy", EgovStringUtil.string2integer(itemQty));
				// 상품 사용 여부
				if(itemUse.equals("1")) {
					paramMap.put("useYn", "Y");
				}else {
					paramMap.put("useYn", "N");
				}
				// 상품 품절여부
				if(itemSoldout.equals("1")) {
					paramMap.put("soldoutYn", "Y");
				}else {
					paramMap.put("soldoutYn", "N");
				}

				// 상품 태그는 1개만 넘어온다는 가정
				if(EgovStringUtil.isNotEmpty(itemOptTag)) {
					if(itemOptTag.equals("일시품절")) {
						paramMap.put("gdsTag", "C");
					}else if(itemOptTag.equals("품절")) {
						paramMap.put("gdsTag", "A");
					}else if(itemOptTag.equals("일부옵션품절")) {
						paramMap.put("gdsTag", "B");
					}else {
						paramMap.put("gdsTag", "D");
					}
				}else {
					paramMap.put("gdsTag", null);

					// 태그 x 처리 시 재고 9999 처리
					if(EgovStringUtil.isNotEmpty(gdsVO.getGdsTagVal()) && gdsVO.getGdsTagVal().equals("B")) {
						Map<String, Object> stockMap = new HashMap<String, Object>();
						stockMap.put("gdsNo", gdsVO.getGdsNo());
						stockMap.put("srchOptnStockQy", 1);
						stockMap.put("optnStockQy", 9999);
						stockMap.put("srchUseYn", "Y");
						gdsOptnService.updateOptnStockQy(stockMap);
					}
				}

				System.out.println("#### 상품 정보 업데이트 START #### ");

				try {
					gdsService.updateEroumGds(paramMap);
				}catch(Exception e) {
					e.printStackTrace();
					System.out.println("#### 상품 정보 업데이트 실패 : "+ e.toString() +" #### ");
				}
				System.out.println("#### 상품 정보 업데이트 END #### ");


				// 옵션 배열
				/**
				 * 2023-04-20
				 * 옵션은 메뉴얼로 수기 작성 진행
				 */
				/*JSONArray item_opt_array = (JSONArray)item.get("item_opt_id");
				if(item_opt_array.size() > 0) {

					for(int h=0; h<item_opt_array.size(); h++) {
						JSONObject item_opt = (JSONObject) item_opt_array.get(h);
						String ioid = Base64Util.decoder((String)item_opt.get("io_id"));
						ioid = ioid.replace("u001e", "");
						String ioType = Base64Util.decoder((String)item_opt.get("io_type"));
						String ioQty = Base64Util.decoder((String)item_opt.get("io_qty"));

						System.out.println("#### 상품 옵션 수량 #### " + ioQty);
						System.out.println("#### 상품 옵션 구분 #### " + ioType);
						System.out.println("#### 상품 옵션 아이디 #### " + ioid);

						Map<String, Object> optnMap = new HashMap<String, Object>();
						optnMap.put("gdsNo", gdsVO.getGdsNo());
						if(ioType.equals("0")) {
							optnMap.put("optnTy", "BASE");
						}else {
							optnMap.put("optnTy", "ADIT");
						}
						//optnMap.put("optnNm", ordrDtlVO.getOrdrOptn());
						optnMap.put("optnId", ioid);

						GdsOptnVO gdsOptnVO = gdsOptnService.selectGdsOptn(optnMap);
						if(gdsOptnVO != null) {
							try {
								System.out.println(" ### 상품옵션 조회 성공 ###");
								optnMap.put("optnStockQy", EgovStringUtil.string2integer(ioQty));
								gdsOptnService.updateOptnStockQy(optnMap);
							}catch(Exception e) {
								e.printStackTrace();
								System.out.println(" ### 상품옵션명 : "+ ioid +"업데이트 실패");
							}
						}
					}
				}else {
					System.out.println("#### 상품 옵션 없음 #### ");
				}*/
			}
		}
	}

	/**
	 * 1.5 -> 1.0 주문 정보 송신
	 * @param ordrCd
	 * @return resultMap
	 * @throws Exception
	 */
	public String putEroumOrdrInfo(String ordrCd, List<Map<String, Object>>itemList) throws Exception {

		OrdrVO ordrVO = ordrService.selectOrdrByCd(ordrCd);
		String JsonData ="";
		if(ordrVO == null) {
			System.out.println("##### OrdrVO equals NULL ##### ");
		}else {

			try {
				Map<String, Object> paramMap = new HashMap<String, Object>();
				Map<String, Object> dataMap = new LinkedHashMap<String, Object>();
				SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
				//ArrayList<Map<String, Object>> arrayList = new ArrayList<>();

				dataMap.put("API_Div", Base64Util.encoder("order_pen_first"));
				dataMap.put("order_send_id", Base64Util.encoder(ordrVO.getOrdrCd()));
				//dataMap.put("order_business_id", Base64Util.encoder("466-87-00410")); //TODO 아리아케어 사업자 번호로 하드코딩 -> 변경 예정
				dataMap.put("order_business_id", Base64Util.encoder("321-64-51984")); //TODO 아리아케어 사업자 번호로 하드코딩 -> 변경 예정

				String RecipterUniqueId = "";
				String penNm = "";
				String penLtmNum="";
				String penTel = "";
				String penGender = "";
				String penZip = "";
				String penAddr = "";
				String penAddr2 = "";
				//String businessId = "";

				MbrVO mbrVO = mbrService.selectMbrByUniqueId(ordrVO.getUniqueId());
				Date date = mbrVO.getBrdt();
				String brdt = "";

				for(OrdrDtlVO ordrDtlVO : ordrVO.getOrdrDtlList()) {
					//penNm = ordrDtlVO.getRecipterInfo().getMbrNm();
					penNm = ordrDtlVO.getRecipterInfo().getTestName();
					penLtmNum = "L"+ordrDtlVO.getRecipterInfo().getRcperRcognNo();
					penTel = ordrDtlVO.getRecipterInfo().getMblTelno();
					RecipterUniqueId = ordrDtlVO.getRecipterInfo().getUniqueId();
					penGender = ordrDtlVO.getRecipterInfo().getGender();
					//businessId = ordrDtlVO.getBplcInfo().getBrno();
					if(penGender.equals("M")) {
						penGender="남";
					}else {
						penGender="여";
					}

					penZip = ordrDtlVO.getRecipterInfo().getZip();
					penAddr = ordrDtlVO.getRecipterInfo().getAddr();
					penAddr2 = ordrDtlVO.getRecipterInfo().getDaddr();
					brdt = format.format(date);

				}
				// 상품 배열 담기
				//dataMap.put("order_business_id", Base64Util.encoder(businessId));
				dataMap.put("_array_item", itemList);

				// 수급자 정보
				dataMap.put("penNm", Base64Util.encoder(penNm));
				dataMap.put("penLtmNum", Base64Util.encoder(penLtmNum));
				dataMap.put("penTel", Base64Util.encoder(penTel));
				dataMap.put("penGender", Base64Util.encoder(penGender));
				dataMap.put("penZip", Base64Util.encoder(penZip));
				dataMap.put("penAddr", Base64Util.encoder(penAddr));
				dataMap.put("penAddr2", Base64Util.encoder(penAddr2));

				// 주문 정보
				dataMap.put("order_id", Base64Util.encoder(ordrVO.getOrdrrId()));
				dataMap.put("order_nm", Base64Util.encoder(ordrVO.getOrdrrNm()));
				dataMap.put("order_tel", Base64Util.encoder(ordrVO.getOrdrrMblTelno()));

				// 수급자 관계 확인
				if(ordrVO.getUniqueId().equals(RecipterUniqueId)) {
					dataMap.put("relation_code", Base64Util.encoder(EgovStringUtil.integer2string(0))); //0 본인으로 추가
				}else {
					paramMap.put("srchApiUniqueId", ordrVO.getUniqueId());
					paramMap.put("srchApiPrtcr", RecipterUniqueId);

					dataMap.put("order_zip", Base64Util.encoder(ordrVO.getOrdrrZip()));
					dataMap.put("order_addr", Base64Util.encoder(ordrVO.getOrdrrAddr()));
					dataMap.put("order_addr2", Base64Util.encoder(ordrVO.getOrdrrDaddr()));
					dataMap.put("order_birth", Base64Util.encoder(brdt));

					dataMap.put("relation_code", Base64Util.encoder(EgovStringUtil.integer2string(3)));
				}

				dataMap.put("delivery_nm", Base64Util.encoder(ordrVO.getRecptrNm()));
				dataMap.put("delivery_tel", Base64Util.encoder(ordrVO.getRecptrMblTelno()));
				dataMap.put("delivery_zip", Base64Util.encoder(ordrVO.getRecptrZip()));
				dataMap.put("delivery_addr", Base64Util.encoder(ordrVO.getRecptrAddr()));
				dataMap.put("delivery_addr2", Base64Util.encoder(ordrVO.getRecptrDaddr()));
				dataMap.put("delivery_memo", Base64Util.encoder(ordrVO.getOrdrrMemo()));

				System.out.println("#### DataMap #### " + dataMap);
				JsonData = this.urlConnect(dataMap);

			}catch(Exception e) {
				e.printStackTrace();
				System.out.println("##### 주문 정보 송신 실패 ##### : " + e.toString());
			}
		}
		return JsonData;
	}

	/**
	 * 상품별 승인, 반려 상태 수신
	 * order_ent_response
	 * @param jsonObj
	 * @throws Exception
	 */
	public Map<String, Object> getBplcSttusInfo(JSONObject jsonObj) throws Exception {

		int result = 0;
		int updateTotal = 0;

		JSONArray arrayItem = (JSONArray)jsonObj.get("_array_item");
		ArrayList<JSONObject> addList = new ArrayList<JSONObject>();
		for(int i=0; i<arrayItem.size(); i++) {
			JSONObject item = (JSONObject)arrayItem.get(i);
			System.out.println("### item ### : " + item);
			String ordrDtlCd = Base64Util.decoder((String)item.get("order_send_dtl_id"));
			String sttus = Base64Util.decoder((String)item.get("item_state"));
			String resn = "";
			if(EgovStringUtil.isNotEmpty((String)item.get("item_memo"))) {
				resn = Base64Util.decoder((String)item.get("item_memo"));
			}else {
				resn = null;
			}

			List<OrdrDtlVO> dtlList = ordrDtlService.selectOrdrDtlList(ordrDtlCd);

			//히스토리 기록
			for(OrdrDtlVO ordrDtlVO : dtlList) {
				if(!ordrDtlVO.getSttsTy().equals("CA01") && !ordrDtlVO.getSttsTy().equals("CA02") && !ordrDtlVO.getSttsTy().equals("CA03")) {
					Map<String, Object> paramMap = new HashMap<String, Object>();
					paramMap.put("ordrDtlCd", ordrDtlVO.getOrdrDtlCd());
					if(!sttus.equals("1")) {
						paramMap.put("sttsTy", "OR03");
						ordrDtlVO.setSttsTy("OR03");
					}else {
						paramMap.put("sttsTy", "OR02");
						ordrDtlVO.setSttsTy("OR02");
					}

					result = ordrDtlService.updateBplcSttus(paramMap);
					updateTotal += result;

					if(!sttus.equals("1")) {
						ordrDtlVO.setResn(resn);
					}else {
						ordrDtlVO.setResn("급여상품 주문승인");
					}

					ordrDtlService.insertOrdrSttsChgHist(ordrDtlVO);

				}else {
					Map<String, Object> cancelMap = new HashMap<String, Object>();
					cancelMap.put("ordrDtlNo", ordrDtlVO.getOrdrDtlNo());
					cancelMap.put("chgStts", ordrDtlVO.getSttsTy());
					OrdrChgHistVO ordrChgHistVO = ordrChgHistService.selectOrdrChgHist(cancelMap);

					cancelMap.clear();
					cancelMap.put("item_memo", CodeMap.ORDR_CANCEL_TY.get(ordrChgHistVO.getResnTy()));
					cancelMap.put("order_send_dtl_id", ordrDtlVO.getOrdrDtlCd());

					JSONObject json = new JSONObject(cancelMap);
					addList.add(json);
				}
			}
		}
		Map<String, Object> resultMap = new HashMap<String, Object>();
		resultMap.put("updateTotal", updateTotal);
		resultMap.put("_array_item", addList);
		return resultMap;

	}

	/**
	 * 주문 상태 전달
	 * order_pen_confirm
	 * @param paramMap
	 * @param order_state, order_send_id
	 */
	public Map<String, Object> putStlmYnSttus(
			Map<String, Object> paramMap
			)throws Exception {
		Map<String, Object> resultMap = new HashMap<String, Object>();

		boolean result = false;
		String resultCode = "";
		String resultMsg = "";

		paramMap.put("API_Div", Base64Util.encoder("order_pen_confirm"));
		//TODO 임시 사업자 번호 -> 아리아케어
		//paramMap.put("order_business_id", Base64Util.encoder("466-87-00410"));
		paramMap.put("order_business_id", Base64Util.encoder("321-64-51984"));

		//결제,취소 구분
		OrdrVO ordrVO = ordrService.selectOrdrByNo((Integer)paramMap.get("ordrNo"));

		String type = (String)paramMap.get("dataType");
		if(type.equals("cancel")) {
			paramMap.put("order_state", Base64Util.encoder("N"));
		}else {
			paramMap.put("order_state", Base64Util.encoder("Y"));
		}

		List<Map<String, Object>> arrayItem = new ArrayList<Map<String, Object>>();

		for(OrdrDtlVO ordrDtlVO : ordrVO.getOrdrDtlList()) {
			if(type.equals("cancel")) {
				paramMap.put("order_send_id", Base64Util.encoder(ordrDtlVO.getOrdrCd()));

				Map<String, Object> dataMap = new HashMap<String, Object>();
				dataMap.put("order_send_dtl_id", Base64Util.encoder(ordrDtlVO.getOrdrDtlCd()));
				dataMap.put("ProdPayCode", Base64Util.encoder(ordrDtlVO.getGdsInfo().getBnefCd()));
				dataMap.put("item_state", Base64Util.encoder("N"));

				if(!EgovStringUtil.isEmpty((String)paramMap.get("resnTy"))) {
					dataMap.put("item_memo", Base64Util.encoder(CodeMap.ORDR_CANCEL_TY.get((String)paramMap.get("resnTy"))));
				}

				arrayItem.add(dataMap);
			}else {
				if(ordrDtlVO.getSttsTy().equals("OR05")) {
					paramMap.put("order_send_id", Base64Util.encoder(ordrDtlVO.getOrdrCd()));

					Map<String, Object> dataMap = new HashMap<String, Object>();
					dataMap.put("order_send_dtl_id", Base64Util.encoder(ordrDtlVO.getOrdrDtlCd()));
					dataMap.put("ProdPayCode", Base64Util.encoder(ordrDtlVO.getGdsInfo().getBnefCd()));
					dataMap.put("item_state", Base64Util.encoder("Y"));

					if(!EgovStringUtil.isEmpty((String)paramMap.get("resnTy"))) {
						dataMap.put("item_memo", Base64Util.encoder(CodeMap.ORDR_CANCEL_TY.get((String)paramMap.get("resnTy"))));
					}

					arrayItem.add(dataMap);
				}
			}

		}
		paramMap.put("_array_item", arrayItem);
		paramMap.remove("ordrNo");
		paramMap.remove("resnTy");
		paramMap.remove("dataType");
		JSONObject jsonObj = new JSONObject(paramMap);
		System.out.println("##### 주문 상태 정보 ##### : " + jsonObj.toString());

		String jsonData = "";

		// 주문 상태 전달
		try {
			jsonData = this.urlConnect(paramMap);
			result = true;

			Object obj = jsonParser.parse(jsonData);
			JSONObject json = (JSONObject)obj;

			String code = (String)json.get("code");
			String msg = (String)json.get("message");

			ordrService.updateOrdrByMap(ordrVO, jsonData, "ordrStlm");

			resultCode = code;
			resultMsg = msg;

			System.out.println("#### 주문상태 수신 데이터 #### : " + jsonData);
		}catch(Exception e) {
			e.printStackTrace();
			System.out.println("#### 주문 상태 전달 실패 #### : " + e.toString());
		}

		resultMap.put("result", result);
		resultMap.put("resultCode", resultCode);
		resultMap.put("resultMsg", resultMsg);
		return resultMap;

	}

	/**
	 * 1.0 조회 상품 List up
	 * @param ordrDtlVO
	 * @return ordrList
	 * @throws Exception
	 */
	public Map<String, Object> confirmOrdrRqst (OrdrDtlVO ordrDtlVO) throws Exception {

		ArrayList<Map<String, Object>> arrayList = new ArrayList<>();
		Map<String, Object> itemMap = new HashMap<String, Object>();

		Map<String, Object> gdsInfoMap = new HashMap<String, Object>();
		itemMap.put("ProdPayCode", Base64Util.encoder(ordrDtlVO.getGdsInfo().getBnefCd()));
		itemMap.put("item_id", null);
		itemMap.put("item_opt_id", null);
		arrayList.add(itemMap);

		String returnJson = this.selectEroumCareOrdr(arrayList);
		String itemId = "";

		if(EgovStringUtil.isNotEmpty(returnJson)) {
			Object obj = jsonParser.parse(returnJson);
			JSONObject jsonObj = (JSONObject)obj;
			String status = (String)jsonObj.get("success");

			if(status.equals("true")) {
				if(EgovStringUtil.isEmpty(ordrDtlVO.getOrdrOptnTy()) || (EgovStringUtil.isNotEmpty(ordrDtlVO.getOrdrOptnTy()) && !ordrDtlVO.getOrdrOptnTy().equals("ADIT"))) {
					JSONArray arry = (JSONArray)jsonObj.get("_array_item");
					JSONObject item = (JSONObject) arry.get(0);

					itemId = (String)item.get("item_id");
					gdsInfoMap.put("item_id", itemId);
					gdsInfoMap.put("ProdPayCode", Base64Util.encoder(ordrDtlVO.getGdsInfo().getBnefCd()));
					gdsInfoMap.put("item_qty", Base64Util.encoder(EgovStringUtil.integer2string(ordrDtlVO.getOrdrQy())));
					gdsInfoMap.put("order_send_dtl_id", Base64Util.encoder(ordrDtlVO.getOrdrDtlCd()));

					if(EgovStringUtil.isNotEmpty(ordrDtlVO.getOrdrOptn())) {
						gdsInfoMap.put("item_opt_id", Base64Util.encoder(ordrDtlVO.getOrdrOptn().replace("*", Character.toString( (char) 0x1E)).replace(" ", "")));
					}
				}
			}
		}
		return gdsInfoMap;
	}

	// URL Connect
	public String urlConnect(Map<String, Object> dataMap)throws Exception {
		JSONObject json = new JSONObject(dataMap);
		String jsonData = json.toJSONString();
		System.out.println("#### jsonData #### " + jsonData);

		StringBuilder urlBuilder = new StringBuilder(urlPath);

		URL url = new URL(urlBuilder.toString()); // url화
        HttpURLConnection conn = (HttpURLConnection) url.openConnection(); // url 연결 객체 생성

        conn.setRequestMethod("POST"); 		// 요청 방식
        conn.setRequestProperty("Content-type", "application/json"); // data를 json으로 전달
        conn.setRequestProperty("Accept", "application/json"); // data를 json으로 수신
        conn.setRequestProperty("eroumAPI_Key", eroumKey);
        conn.setDoOutput(true); 			// output으로 stream으로 전달
        conn.setUseCaches(false); 			// 캐싱데이터 수신x
        conn.setDefaultUseCaches(false); 	// 캐싱데이터 디폴트 값 설정x

        try(OutputStream os = conn.getOutputStream()) {
        	byte[] input = jsonData.getBytes("utf-8");
            os.write(input, 0, input.length);
        }

		String jsons = IOUtils.toString(conn.getInputStream(), StandardCharsets.UTF_8);
		System.out.println(" ### 수신 데이터 ### " + jsons);

		return jsons;
	}

}
