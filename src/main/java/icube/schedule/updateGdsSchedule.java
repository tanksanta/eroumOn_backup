package icube.schedule;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.egovframe.rte.fdl.string.EgovStringUtil;
import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.springframework.scheduling.annotation.EnableScheduling;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Service;

import icube.common.api.biz.UpdateBplcInfoApiService;
import icube.common.framework.abst.CommonAbstractController;
import icube.common.util.Base64Util;
import icube.manage.gds.gds.biz.GdsService;
import icube.manage.gds.gds.biz.GdsVO;
import icube.manage.ordr.dtl.biz.OrdrDtlService;
import icube.manage.ordr.dtl.biz.OrdrDtlVO;
import icube.manage.ordr.ordr.biz.OrdrService;
import icube.manage.ordr.ordr.biz.OrdrVO;


/**
 * 이로움1.5 상품정보 -> 이로움1.0 정보로 업데이트
 */
@EnableScheduling
@Service("updateGdsSchedule")
public class updateGdsSchedule extends CommonAbstractController {

	@Resource(name = "gdsService")
	private GdsService gdsService;

	@Resource(name = "ordrService")
	private OrdrService ordrService;

	@Resource(name = "ordrDtlService")
	private OrdrDtlService ordrDtlService;

	@Resource(name = "updateBplcInfoApiService")
	private UpdateBplcInfoApiService updateBplcInfoApiService;

	/**
	 * 매일 1회 상품 정보 업데이트
	 * @throws Exception
	 */
	@Scheduled(cron="0 30 03 * * *")
	public void updateGdsInfo() throws Exception {
		ArrayList<Map<String, Object>> arrayList = new ArrayList<>();

		Map<String, Object> paramMap = new HashMap<String, Object>();
		paramMap.put("srchUseYn", "Y");
		paramMap.put("searchBnefCd", 1);

		List<GdsVO> gdsList = gdsService.selectGdsListAll(paramMap);

		for(GdsVO gdsVO : gdsList) {
			Map<String, Object> bnefMap = new HashMap<String, Object>();
			bnefMap.put("ProdPayCode", Base64Util.encoder(gdsVO.getBnefCd()));
			bnefMap.put("item_id", null);
			bnefMap.put("item_opt_id", null);
			arrayList.add(bnefMap);
		}

		// 상품 정보 조회
		String JsonData = updateBplcInfoApiService.selectEroumCareOrdr(arrayList);

		// 상품 정보 업데이트
		System.out.println("##### 전체 상품 업데이트 START ######");
		updateBplcInfoApiService.updateMarketGdsInfo(JsonData);
		System.out.println("##### 전체 상품 업데이트 END ######");
	}


	/**
	 * 주문 정보 재전송
	 * @throws Exception
	 */
	//@Scheduled(cron="0 0 0 * * *")
	//@Scheduled(cron="*/30 * * * * *")
	public void rePutOrdrCancleInfo() throws Exception {

		JSONParser jsonParser = new JSONParser();
		ArrayList<Map<String, Object>> itemList = new ArrayList<>();
		List<OrdrDtlVO> ordrDtlList = new ArrayList<OrdrDtlVO>();

		Map<String, Object> paramMap = new HashMap<String, Object>();
		paramMap.put("srchSendSttus", "N");
		paramMap.put("ordrSttsTy", "ALL");

		//List<OrdrVO> ordrList = ordrService.selectOrdrList(paramMap);
		List<OrdrVO> ordrList =  ordrService.selectOrdrListAll(paramMap);

		// 주문 리스트
		for(OrdrVO ordrVO : ordrList) {

			// 주문 상세 리스트
			for(OrdrDtlVO ordrDtlVO : ordrVO.getOrdrDtlList()) {
				// 1.5 -> 1.0 상품 정보 조회 (item_info)
				ArrayList<Map<String, Object>> arrayList = new ArrayList<>();
				Map<String, Object> itemMap = new HashMap<String, Object>();
				Map<String, Object> gdsInfoMap = new HashMap<String, Object>();
				itemMap.put("ProdPayCode", Base64Util.encoder(ordrDtlVO.getGdsInfo().getBnefCd()));
				itemMap.put("item_id", null);
				itemMap.put("item_opt_id", null);
				arrayList.add(itemMap);

				String returnJson = updateBplcInfoApiService.selectEroumCareOrdr(arrayList);
				String itemId = "";
				if(EgovStringUtil.isNotEmpty(returnJson)) {

					Object obj = jsonParser.parse(returnJson);
					JSONObject jsonObj = (JSONObject)obj;
					String status = (String)jsonObj.get("success");
					if(status.equals("true")) {
						JSONArray arry = (JSONArray)jsonObj.get("_array_item");
						JSONObject item = (JSONObject) arry.get(0);
						itemId = (String)item.get("item_id");
						gdsInfoMap.put("item_id", itemId);
						gdsInfoMap.put("ProdPayCode", Base64Util.encoder(ordrDtlVO.getGdsInfo().getBnefCd()));
						gdsInfoMap.put("item_opt_id", Base64Util.encoder(ordrDtlVO.getOrdrOptn().replace("*", Character.toString( (char) 0x1E)).replace(" ", "")));
						gdsInfoMap.put("item_qty", Base64Util.encoder(EgovStringUtil.integer2string(ordrDtlVO.getGdsInfo().getStockQy())));
						gdsInfoMap.put("order_send_dtl_id", Base64Util.encoder(ordrDtlVO.getOrdrDtlCd()));
						itemList.add(gdsInfoMap);
					}
				}

				// 히스토리 기록
				ordrDtlVO.setResn("주문승인대기");
				ordrDtlService.insertOrdrSttsChgHist(ordrDtlVO);

				ordrDtlList.add(ordrDtlVO);
			}

			// 1.5 -> 1.0 주문정보 송신
			String returnData = updateBplcInfoApiService.putEroumOrdrInfo(ordrVO.getOrdrCd(), itemList);

			System.out.println("@@@@@@@@@@ 송신결과값 : " + returnData);
			Object obj = jsonParser.parse(returnData);
			JSONObject jsonObj = (JSONObject)obj;
			System.out.println("@@@@@@@@@@ 송신결과 상태 : " + (String)jsonObj.get("success"));
			String status = (String)jsonObj.get("success");
			Map<String, Object> sttusMap = new HashMap<String, Object>();
			sttusMap.put("ordrNo", ordrVO.getOrdrNo());
			sttusMap.put("ordrCd", ordrVO.getOrdrCd());
			if(status.equals("true")) {
				sttusMap.put("srchSendSttus", "Y");
			}else {
				sttusMap.put("srchSendSttus", "N");
			}
			ordrService.updateOrdrByMap(sttusMap);

			}
		}

	/**
	 * 결제 정보 재전송
	 * @throws Exception
	 */
	//@Scheduled(cron="0 0 0 * * *")
	//@Scheduled(cron="*/30 * * * * *")
	public void rePutOrdrInfo() throws Exception {
		boolean or02 = true;

		Map<String, Object> paramMap = new HashMap<String, Object>();
		paramMap.put("srchStlmSttus", "N");
		paramMap.put("ordrSttsTy", "ALL");
		List<OrdrVO> ordrList = ordrService.selectOrdrListAll(paramMap);

		for(OrdrVO ordrVO : ordrList) {
			for(OrdrDtlVO ordrDtlVO : ordrVO.getOrdrDtlList()) {
				if(ordrDtlVO.getSttsTy().equals("OR01")) {
					or02=false;
				}
			}
			Map<String, Object> stlmMap = new HashMap<String, Object>();
			stlmMap.put("ordrNo", ordrVO.getOrdrNo());
			stlmMap.put("dataType", "stlm");

			if(or02) {
				try {
					updateBplcInfoApiService.putStlmYnSttus(stlmMap);
				}catch(Exception e) {
					e.printStackTrace();
					System.out.println("#### rePutOrdrInfo fail #### : " + e.toString());
				}
			}
		}
	}

}
