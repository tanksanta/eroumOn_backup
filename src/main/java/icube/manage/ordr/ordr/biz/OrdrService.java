package icube.manage.ordr.ordr.biz;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.egovframe.rte.fdl.string.EgovStringUtil;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.bind.annotation.RequestParam;

import icube.common.api.biz.BootpayApiService;
import icube.common.api.biz.UpdateBplcInfoApiService;
import icube.common.framework.abst.CommonAbstractServiceImpl;
import icube.common.mail.MailFormService;
import icube.common.util.DateUtil;
import icube.common.util.WebUtil;
import icube.common.values.CodeMap;
import icube.common.vo.CommonListVO;
import icube.manage.gds.gds.biz.GdsService;
import icube.manage.gds.gds.biz.GdsVO;
import icube.manage.gds.optn.biz.GdsOptnVO;
import icube.manage.mbr.itrst.biz.CartService;
import icube.manage.ordr.dtl.biz.OrdrDtlService;
import icube.manage.ordr.dtl.biz.OrdrDtlVO;
import icube.manage.promotion.coupon.biz.CouponLstService;
import icube.manage.promotion.mlg.biz.MbrMlgService;
import icube.manage.promotion.mlg.biz.MbrMlgVO;
import icube.manage.promotion.point.biz.MbrPointService;
import icube.manage.promotion.point.biz.MbrPointVO;
import icube.manage.sysmng.entrps.biz.EntrpsService;
import icube.manage.sysmng.entrps.biz.EntrpsVO;
import icube.market.mbr.biz.MbrSession;

@Service("ordrService")
public class OrdrService extends CommonAbstractServiceImpl {

	@Resource(name="ordrDAO")
	private OrdrDAO ordrDAO;

	@Resource(name = "ordrDtlService")
	private OrdrDtlService ordrDtlService;

	@Resource(name = "gdsService")
	private GdsService gdsService;

	@Resource(name = "mbrMlgService")
	private MbrMlgService mbrMlgService;

	@Resource(name = "mbrPointService")
	private MbrPointService mbrPointService;

	@Resource(name = "couponLstService")
	private CouponLstService couponLstService;

	@Resource(name = "cartService")
	private CartService cartService;

	@Resource(name = "bootpayApiService")
	private BootpayApiService bootpayApiService;

	@Resource(name = "mailFormService")
	private MailFormService mailFormService;

	@Resource(name = "updateBplcInfoApiService")
	private UpdateBplcInfoApiService updateBplcInfoApiService;

	@Resource(name = "entrpsService")
	private EntrpsService entrpsService;
	
	@Autowired
	private MbrSession mbrSession;
	
	@Resource(name = "ordrService")
	private OrdrService ordrService;
	

	JSONParser jsonParser = new JSONParser();

	/**
	 * 주문목록 > 주문상태 기준
	 * @param listVO
	 * @return
	 * @throws Exception
	 */
	public CommonListVO ordrListVO(CommonListVO listVO) throws Exception {
		return ordrDAO.ordrListVO(listVO);
	}

	// 내가 구매한 상품용
	public CommonListVO ordrMyListVO(CommonListVO listVO) throws Exception {
		return ordrDAO.ordrMyListVO(listVO);
	}

	public OrdrVO selectOrdrByCd(String ordrCd) throws Exception {
		Map<String, Object> paramMap = new HashMap<String, Object>();
		paramMap.put("ordrCd", ordrCd);
		return ordrDAO.selectOrdr(paramMap);
	}

	public OrdrVO selectOrdrByNo(int ordrNo) throws Exception {
		Map<String, Object> paramMap = new HashMap<String, Object>();
		paramMap.put("ordrNo", ordrNo);
		return ordrDAO.selectOrdr(paramMap);
	}

	public List<OrdrDtlVO> insertOrdr(
			OrdrVO ordrVO
			, @RequestParam Map<String, Object> reqMap
			, HttpServletRequest request) throws Exception {

		String ordrDtlCd = (String) reqMap.get("ordrDtlCd");

		String gdsNo = (String) reqMap.get("gdsNo");
		String gdsCd = (String) reqMap.get("gdsCd");
		String bnefCd = (String) reqMap.get("bnefCd");
		String gdsNm = (String) reqMap.get("gdsNm");
		String gdsPc = (String) reqMap.get("gdsPc");

		String gdsOptnNo = (String) reqMap.get("gdsOptnNo");

		String ordrOptnTy = (String) reqMap.get("ordrOptnTy");
		String ordrOptn = (String) reqMap.get("ordrOptn");
		String ordrOptnPc = (String) reqMap.get("ordrOptnPc");
		String ordrQy = (String) reqMap.get("ordrQy");
		String ordrPc = (String) reqMap.get("ordrPc");

		String dlvyBassAmt = (String) reqMap.get("dlvyBassAmt");
		String dlvyAditAmt = (String) reqMap.get("dlvyAditAmt");

		String couponNo = (String) reqMap.get("couponNo");
		String couponCd = (String) reqMap.get("couponCd");
		String couponAmt = (String) reqMap.get("couponAmt");

		String recipterUniqueId = (String) reqMap.get("recipterUniqueId");
		String bplcUniqueId = (String) reqMap.get("bplcUniqueId");

		String accmlMlg = (String) reqMap.get("accmlMlg");
		String cartGrpNos = (String) reqMap.get("cartGrpNos");

		//String stlmYn = (String) reqMap.get("stlmYn");
		String stlmTy = (String) reqMap.get("stlmTy");

		String mbrMlg = (String) reqMap.get("mbrMlg");
		String mbrPoint = (String) reqMap.get("mbrPoint");

		ordrVO.setOrdrrEml(mbrSession.getEml());

		if (EgovStringUtil.equals("FREE", stlmTy)) {
			ordrVO.setStlmYn("Y");
			ordrVO.setStlmDt(DateUtil.getCurrentDateTime("yyyy-MM-dd HH:mm:ss")); // 결제일
		} else {
			if(EgovStringUtil.isNotEmpty(ordrVO.getDelngNo())) {
				// 결제 정보 검증
				try {
					HashMap<String, Object> res = bootpayApiService.confirm(ordrVO.getDelngNo());
					if (res.get("error_code") == null) { // success
						System.out.println("success: " + res);
						ordrVO.setStlmYn("Y");
					} else {
						System.out.println("fail: " + res);
						ordrVO.setStlmYn("N");
					}
				} catch (Exception e) {
					e.printStackTrace();
					ordrVO.setStlmYn("N");
				}

				// DATE CONVERT
				SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd'T'HH:mm:ss");
				SimpleDateFormat output = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
				if (EgovStringUtil.isNotEmpty(ordrVO.getStlmDt())) {
					Date parseStlmDt = format.parse(ordrVO.getStlmDt());
					String convertStlmDt = output.format(parseStlmDt);
					ordrVO.setStlmDt(convertStlmDt); // 결제일
				}
				if (EgovStringUtil.isNotEmpty(ordrVO.getDpstTermDt())) {
					Date parseDpstTermDt = format.parse(ordrVO.getDpstTermDt());
					String convertDpstTermDt = output.format(parseDpstTermDt);
					ordrVO.setDpstTermDt(convertDpstTermDt);
				}
				ordrVO.setStlmTy(ordrVO.getStlmTy().toUpperCase());
			}
		}

		// 주문정보
		ordrVO.setUniqueId(mbrSession.getUniqueId());
		ordrVO.setOrdrrId(mbrSession.getMbrId());
		ordrVO.setOrdrrNm(mbrSession.getMbrNm());
		ordrVO.setOrdrrTelno(mbrSession.getTelno());
		ordrVO.setOrdrrZip(mbrSession.getZip());
		ordrVO.setOrdrrAddr(mbrSession.getAddr());
		ordrVO.setOrdrrDaddr(mbrSession.getDaddr());
		ordrVO.setOrdrrMblTelno(mbrSession.getMblTelno());
		ordrVO.setStlmDevice(WebUtil.getDevice(request));

		ordrDAO.insertOrdr(ordrVO);

		// 주문 상세 정보
		List<OrdrDtlVO> ordrDtlList = new ArrayList<OrdrDtlVO>();
		String[] spOrdrDtlCd = ordrDtlCd.split(",");

		for (int i = 0; i < spOrdrDtlCd.length; i++) {

			OrdrDtlVO ordrDtlVO = new OrdrDtlVO();
			ordrDtlVO.setOrdrNo(ordrVO.getOrdrNo());
			ordrDtlVO.setOrdrCd(ordrVO.getOrdrCd());
			ordrDtlVO.setOrdrDtlCd(ordrDtlCd.split(",")[i].trim());
			
			int dtlGdsNo = EgovStringUtil.string2integer(gdsNo.split(",")[i].trim());
			
			// 상품 정보
			GdsVO gdsVO = gdsService.selectGds(EgovStringUtil.string2integer(gdsNo.split(",")[i].trim()));
			// 상품에 대한 입점업체정보 조회
			EntrpsVO entrpsVO = entrpsService.selectEntrpsByGdsNo(dtlGdsNo);
			
			ordrDtlVO.setGdsNo(dtlGdsNo);
			ordrDtlVO.setGdsCd(gdsCd.split(",")[i].trim());
			ordrDtlVO.setGdsNm(gdsNm.split(",")[i].trim());
			ordrDtlVO.setGdsPc(EgovStringUtil.string2integer(gdsPc.split(",")[i].trim()));
			ordrDtlVO.setGdsSupPc(gdsVO.getSupPc());
			if (entrpsVO != null) {
				ordrDtlVO.setEntrpsNo(entrpsVO.getEntrpsNo());
			}
			if (entrpsVO != null) {
				ordrDtlVO.setEntrpsNm(entrpsVO.getEntrpsNm());
			}
			
			if (gdsOptnNo.split(",")[i].trim().length() > 0){
				ordrDtlVO.setGdsOptnNo((EgovStringUtil.string2integer(gdsOptnNo.split(",")[i].trim())));
			}
			ordrDtlVO.setOrdrOptnTy(ordrOptnTy.split(",")[i].trim());
			ordrDtlVO.setOrdrOptnPc(EgovStringUtil.string2integer(ordrOptnPc.split(",")[i].trim()));
			ordrDtlVO.setOrdrQy(EgovStringUtil.string2integer(ordrQy.split(",")[i].trim()));
			ordrDtlVO.setOrdrPc(EgovStringUtil.string2integer(ordrPc.split(",")[i].trim()));
			ordrDtlVO.setDlvyBassAmt(EgovStringUtil.string2integer(dlvyBassAmt.split(",")[i].trim()));
			ordrDtlVO.setDlvyAditAmt(EgovStringUtil.string2integer(dlvyAditAmt.split(",")[i].trim()));
			ordrDtlVO.setRegUniqueId(mbrSession.getUniqueId());
			ordrDtlVO.setRegId(mbrSession.getMbrId());
			ordrDtlVO.setRgtr(mbrSession.getMbrNm());

			if (bnefCd.split(",").length > 0) {
				ordrDtlVO.setBnefCd(bnefCd.split(",")[i].trim());
			} else {
				ordrDtlVO.setBnefCd("");
			}

			
			String ordrDtlOptnNm = "";
			if (EgovStringUtil.isNotEmpty(ordrOptn)) {
				ordrDtlOptnNm = ordrOptn.split(",")[i].trim();
			}
			
			if (EgovStringUtil.isNotEmpty(ordrDtlOptnNm)) {
				ordrDtlVO.setOrdrOptn(ordrDtlOptnNm);
				
				//옵션이면 옵션 품목코드 입력
				GdsOptnVO optn = null;
				if ("BASE".equals(ordrDtlVO.getOrdrOptnTy())) {
					optn = gdsVO.getOptnList().stream().filter(f -> f.getOptnNm().equals(ordrDtlVO.getOrdrOptn())).findAny().orElse(null);
				} else {
					optn = gdsVO.getAditOptnList().stream().filter(f -> f.getOptnNm().equals(ordrDtlVO.getOrdrOptn())).findAny().orElse(null);
				}
				
				if (optn != null) {
					ordrDtlVO.setOptnItemCd(optn.getOptnItemCd());
				}
			}
			//옵션이 아니면 상품 품목코드 입력
			else {
				ordrDtlVO.setGdsItemCd(gdsVO.getItemCd());
			}

			if(EgovStringUtil.isNotEmpty(accmlMlg)) {
				ordrDtlVO.setAccmlMlg(EgovStringUtil.string2integer(accmlMlg.split(",")[i].trim(), 0));
			}else {
				ordrDtlVO.setAccmlMlg(0);
			}

			if(EgovStringUtil.isNotEmpty(couponCd)) {
				ordrDtlVO.setCouponCd(couponCd.split(",")[i].trim());
			}
			if(EgovStringUtil.isNotEmpty(couponAmt)) {
				ordrDtlVO.setCouponAmt(EgovStringUtil.string2integer(couponAmt.split(",")[i].trim()));
			}

			if (recipterUniqueId.split(",").length > 0) {
				ordrDtlVO.setRecipterUniqueId(recipterUniqueId.split(",")[i].trim());
			} else {
				ordrDtlVO.setRecipterUniqueId("");
			}

			if (bplcUniqueId.split(",").length > 0) {
				ordrDtlVO.setBplcUniqueId(bplcUniqueId.split(",")[i].trim());
			} else {
				ordrDtlVO.setBplcUniqueId("");
			}

			if(EgovStringUtil.isNotEmpty(couponNo)) {
				ordrDtlVO.setCouponNo(EgovStringUtil.string2integer(couponNo.split(",")[i].trim()));

				// 쿠폰 사용처리
				if (couponNo.split(",").length > 0) {
					Map<String, Object> paramMap = new HashMap<String, Object>();
					paramMap.put("uniqueId", mbrSession.getUniqueId());
					paramMap.put("couponNo", EgovStringUtil.string2integer(couponNo.split(",")[i].trim()));
					paramMap.put("useYn", "Y");
					couponLstService.updateCouponUseYn(paramMap);
				}
			}

			if(EgovStringUtil.equals("N", ordrVO.getOrdrTy())) {
				if (EgovStringUtil.equals("Y", ordrVO.getStlmYn())) {
					ordrDtlVO.setSttsTy("OR05");
				} else {
					ordrDtlVO.setSttsTy("OR04");
				}
			}else {
				ordrDtlVO.setSttsTy("OR01");
			}

			ordrDtlVO.setGdsInfo(gdsVO);
			ordrDtlService.insertOrdrDtl(ordrDtlVO);

			// 히스토리 기록
			ordrDtlVO.setResn(CodeMap.ORDR_STTS.get(ordrDtlVO.getSttsTy()));
			ordrDtlService.insertOrdrSttsChgHist(ordrDtlVO);

			ordrDtlList.add(ordrDtlVO);

		}

		// 마일리지
		if (EgovStringUtil.isNotEmpty(mbrMlg)) {
			String[] spMbrMlg = mbrMlg.split(",");
			for (int i = 0; i < spMbrMlg.length; i++) {
				String[] spVal = spMbrMlg[i].split("[|]");
				MbrMlgVO mbrMlgVO = new MbrMlgVO();
				mbrMlgVO.setUniqueId(spVal[0].trim());
				mbrMlgVO.setOrdrCd(ordrVO.getOrdrCd());
				mbrMlgVO.setMlgSe("M");
				mbrMlgVO.setMlgCn("11"); // 상품주문
				mbrMlgVO.setGiveMthd("SYS");
				mbrMlgVO.setRgtr("System");
				mbrMlgVO.setMlg(EgovStringUtil.string2integer(spVal[1].trim()));

				// 내역 등록
				mbrMlgService.insertMbrMlg(mbrMlgVO);
			}
		}

		// 포인트
		if (EgovStringUtil.isNotEmpty(mbrPoint)) {
			String[] spMbrPoint = mbrPoint.split(",");
			for (int i = 0; i < spMbrPoint.length; i++) {
				String[] spVal = spMbrPoint[i].split("[|]");
				MbrPointVO mbrPointVO = new MbrPointVO();
				mbrPointVO.setUniqueId(spVal[0].trim());
				mbrPointVO.setOrdrCd(ordrVO.getOrdrCd());
				mbrPointVO.setPointSe("M");
				mbrPointVO.setPointCn("11"); // 상품주문
				mbrPointVO.setRgtr("System");
				mbrPointVO.setGiveMthd("SYS");
				mbrPointVO.setPoint(EgovStringUtil.string2integer(spVal[1].trim()));

				// 내역 등록
				mbrPointService.insertMbrPoint(mbrPointVO);
			}
		}

		// 장바구니 삭제
		if (EgovStringUtil.isNotEmpty(cartGrpNos)) {
			String[] arrCartGrpNo = cartGrpNos.split(",");
			Map<String, Object> paramMap = new HashMap<String, Object>();
			paramMap.put("srchCartGrpNos", arrCartGrpNo);
			paramMap.put("srchRecipterUniqueId", ordrDtlList.get(0).getRecipterUniqueId());
			cartService.deleteCart(paramMap);
		}

		return ordrDtlList;
	}

	public void updateOrdr(OrdrVO ordrVO) throws Exception {
		ordrDAO.updateOrdr(ordrVO);
	}

	public void deleteOrdr(int ordrNo) throws Exception {
		ordrDAO.deleteOrdr(ordrNo);
	}

	// 배송지정보 수정
	public Integer updateDlvyInfo(Map<String, Object> paramMap) throws Exception {
		return ordrDAO.updateDlvyInfo(paramMap);
	}

	// 총 결제금액 수정
	public void updateStlmAmt(OrdrVO ordrVO) throws Exception {
		ordrDAO.updateStlmAmt(ordrVO);
	}

	//사용 마일리지 수정
	public void updateUseMlg (OrdrVO ordrVO) throws Exception {
		ordrDAO.updateUseMlg(ordrVO);
	}
	
	//사용 포인트 수정
	public void updateUsePoint (OrdrVO ordrVO) throws Exception {
		ordrDAO.updateUsePoint(ordrVO);
	}

	// 단계별 카운트
	public Map<String, Integer> selectSttsTyCnt(Map<String, Object> paramMap) throws Exception {
		return ordrDAO.selectSttsTyCnt(paramMap);
	}

	public List<OrdrVO> selectOrdrList(Map<String, Object> paramMap) throws Exception {
		return ordrDAO.selectOrdrList(paramMap);
	}

	// 결제완료 처리
	public void updateStlmYn(Map<String, Object> paramMap) throws Exception {
		ordrDAO.updateStlmYn(paramMap);
		if("Y".equals(paramMap.get("stlmYn"))) { // 승인변경시
			ordrDtlService.updateOrdrOR05( (String) paramMap.get("ordrCd") );
		}

	}

	public List<OrdrVO> selectOrdrSttsList(Map<String, Object> paramMap) throws Exception {
		return ordrDAO.selectOrdrSttsList(paramMap);
	}

	// 빌링키삭제
	public void updateBillingCancel(int ordrNo) throws Exception {
		Map<String, Object> paramMap = new HashMap<String, Object>();
		paramMap.put("ordrNo", ordrNo);
		ordrDAO.updateBillingCancel(paramMap);
	}

	// 빌링키 업데이트
	public void updateBillingChg(Map<String, Object> paramMap) throws Exception {
		ordrDAO.updateBillingChg(paramMap);
	}

	// 이로움1.5 -> 이로움1.0 주문정보 송신 결과 값 업데이트
	public void updateOrdrByMap(OrdrVO ordrVO, String returnData, String type) throws Exception {

		Object obj = jsonParser.parse(returnData);
		JSONObject jsonObj = (JSONObject)obj;
		Map<String, Object> paramMap = new HashMap<String, Object>();

		// 주문정보
		if(EgovStringUtil.equals("ordrSend", type)) {
			String status = (String)jsonObj.get("success");

			paramMap.put("ordrNo", ordrVO.getOrdrNo());
			paramMap.put("ordrCd", ordrVO.getOrdrCd());
			if(status.equals("true")) {
				paramMap.put("srchSendSttus", "Y");
			}else {
				paramMap.put("srchSendSttus", "N");
			}
		// 결제정보
		}else {
			String code = (String)jsonObj.get("code");

			paramMap.put("ordrNo", ordrVO.getOrdrNo());
			paramMap.put("ordrCd", ordrVO.getOrdrCd());
			paramMap.put("srchSendSttus", "Y");

			if(code.equals("200")) {
				paramMap.put("srchStlmSttus", "Y");
			}else {
				paramMap.put("srchStlmSttus", "N");
			}
		}

		ordrDAO.updateOrdrByMap(paramMap);

	}

	// 주문 리스트 전체 조회
	public List<OrdrVO> selectOrdrListAll(Map<String, Object> paramMap) throws Exception {
		return ordrDAO.selectOrdrListAll(paramMap);
	}

	// 급여 주문 정보 저장 및 이로움1.0 사업소에 주문
	public List<OrdrDtlVO> insertOrdrForRecipter(OrdrVO ordrVO
			, @RequestParam Map<String, Object> reqMap
			, HttpServletRequest request) throws Exception {
		
		List<OrdrDtlVO> ordrDtlList = ordrService.insertOrdr(ordrVO, reqMap, request);

		ArrayList<Map<String, Object>> ordrList = new ArrayList<>();

		if(!ordrVO.getOrdrTy().equals("N") && ordrDtlList.size() > 0) {

			for(OrdrDtlVO ordrDtlVO : ordrDtlList) {
				Map<String, Object> gdsInfoMap = updateBplcInfoApiService.confirmOrdrRqst(ordrDtlVO);
				ordrList.add(gdsInfoMap);
			}
			
			// 1.5 -> 1.0 주문정보 송신
			String returnData = updateBplcInfoApiService.putEroumOrdrInfo(ordrVO.getOrdrCd(), ordrList);

			// -- start : 1.0 사업소 주문에 실패한 경우 --
			if (EgovStringUtil.isEmpty(returnData)) {
				throw new Exception("사업소 주문에 문제가 발생하였습니다.");
			}
			Object obj = jsonParser.parse(returnData);
			JSONObject jsonObj = (JSONObject)obj;
			String code = (String)jsonObj.get("code");
			if (!"200".equals(code)) {
				throw new Exception((String)jsonObj.get("message"));
			}
			// -- end : 1.0 사업소 주문에 실패한 경우 --
			
			// 송신 상태 업데이트
			ordrService.updateOrdrByMap(ordrVO, returnData, "ordrSend");
		}
		
		return ordrDtlList;
	}

	// 2일 동안 결제를 안 한 주문 리스트 (입금요청)
	public List<OrdrVO> selectOrdrScheduleStlmNForRequestList() throws Exception {
		return this.selectOrdrScheduleStlmNList(-2);
	}

	// 3일 동안 결제를 안 한 주문 리스트 (주문취소)
	public List<OrdrVO> selectOrdrScheduleStlmNForCancelList() throws Exception {
		return this.selectOrdrScheduleStlmNList(-3);
	}

	protected List<OrdrVO> selectOrdrScheduleStlmNList(int days) throws Exception {
		Map<String, Object> paramMap = new HashMap<String, Object>();

		Date now = new Date();

		paramMap.put("srchStlmKnd", "VBANK");
		paramMap.put("srchStlmTy", "VBANK");
		paramMap.put("srchStlmYn", "N");
		
		paramMap.put("srchBgngDt", DateUtil.formatDate(DateUtil.getDateAdd(now, "date", days + 0), "yyyy-MM-dd"));
		paramMap.put("srchEndDt" , DateUtil.formatDate(DateUtil.getDateAdd(now, "date", days + 1), "yyyy-MM-dd"));

		return ordrDAO.selectOrdrScheduleStlmNList(paramMap);
	}

}