package icube.market.ordr;

import java.text.DecimalFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.egovframe.rte.fdl.string.EgovStringUtil;
import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import icube.common.api.biz.BootpayApiService;
import icube.common.api.biz.UpdateBplcInfoApiService;
import icube.common.mail.MailService;
import icube.common.util.Base64Util;
import icube.common.util.DateUtil;
import icube.common.util.FileUtil;
import icube.common.util.ValidatorUtil;
import icube.common.util.WebUtil;
import icube.common.util.egov.EgovDoubleSubmitHelper;
import icube.common.values.CodeMap;
import icube.manage.gds.gds.biz.GdsService;
import icube.manage.gds.gds.biz.GdsVO;
import icube.manage.mbr.itrst.biz.CartService;
import icube.manage.mbr.itrst.biz.CartVO;
import icube.manage.mbr.mbr.biz.MbrService;
import icube.manage.mbr.recipter.biz.RecipterInfoService;
import icube.manage.members.bplc.biz.BplcService;
import icube.manage.members.bplc.biz.BplcVO;
import icube.manage.ordr.chghist.biz.OrdrChgHistService;
import icube.manage.ordr.dtl.biz.OrdrDtlService;
import icube.manage.ordr.dtl.biz.OrdrDtlVO;
import icube.manage.ordr.ordr.biz.OrdrService;
import icube.manage.ordr.ordr.biz.OrdrVO;
import icube.manage.promotion.coupon.biz.CouponLstService;
import icube.manage.promotion.mlg.biz.MbrMlgService;
import icube.manage.promotion.mlg.biz.MbrMlgVO;
import icube.manage.promotion.point.biz.MbrPointService;
import icube.manage.promotion.point.biz.MbrPointVO;
import icube.market.mbr.biz.MbrSession;
import icube.market.mypage.info.biz.DlvyService;
import icube.market.mypage.info.biz.DlvyVO;

@Controller
@RequestMapping(value = "#{props['Globals.Market.path']}/ordr")
public class OrdrController {

	@Resource(name = "ordrService")
	private OrdrService ordrService;

	@Resource(name = "ordrDtlService")
	private OrdrDtlService ordrDtlService;

	@Resource(name = "ordrChgHistService")
	private OrdrChgHistService ordrChgHistService;

	@Resource(name = "gdsService")
	private GdsService gdsService;

	@Resource(name = "bplcService")
	private BplcService bplcService;

	@Resource(name = "mbrService")
	private MbrService mbrService;

	@Resource(name = "bootpayApiService")
	private BootpayApiService bootpayApiService;

	@Resource(name = "cartService")
	private CartService cartService;

	@Resource(name = "dlvyService")
	private DlvyService dlvyService;

	@Resource(name = "mbrMlgService")
	private MbrMlgService mbrMlgService;

	@Resource(name = "mbrPointService")
	private MbrPointService mbrPointService;

	@Resource(name = "couponLstService")
	private CouponLstService couponLstService;

	@Resource(name = "mailService")
	private MailService mailService;

	@Resource(name = "updateBplcInfoApiService")
	private UpdateBplcInfoApiService updateBplcInfoApiService;

	@Resource(name = "recipterInfoService")
	private RecipterInfoService recipterInfoService;

	@Value("#{props['Mail.Form.FilePath']}")
	private String mailFormFilePath;

	@Value("#{props['Mail.Username']}")
	private String sendMail;

	@Value("#{props['Profiles.Active']}")
	private String activeMode;

	@Autowired
	private MbrSession mbrSession;

	@Value("#{props['Globals.Market.path']}")
	private String marketPath;

	/**
	 * 급여 주문 > 사업소 요청
	 */
	@SuppressWarnings("null")
	@RequestMapping(value = "ordrRqst")
	public String ordrRqst(OrdrVO ordrVO, @RequestParam(value = "ordrTy", required = true) String ordrTy,
			@RequestParam(value = "gdsNo", required = true) String gdsNo,
			@RequestParam(value = "gdsCd", required = true) String gdsCd,
			@RequestParam(value = "bnefCd", required = true) String bnefCd,
			@RequestParam(value = "gdsNm", required = true) String gdsNm,
			@RequestParam(value = "gdsPc", required = true) String gdsPc

			, @RequestParam(value = "ordrOptnTy", required = true) String ordrOptnTy,
			@RequestParam(value = "ordrOptn", required = true) String ordrOptn,
			@RequestParam(value = "ordrOptnPc", required = true) String ordrOptnPc,
			@RequestParam(value = "ordrQy", required = true) String ordrQy

			, @RequestParam(value = "recipterUniqueId", required = false) String recipterUniqueId,
			@RequestParam(value = "bplcUniqueId", required = false) String bplcUniqueId

			, @RequestParam Map<String, Object> reqMap, HttpServletRequest request, HttpServletResponse response,
			HttpSession session, Model model) throws Exception {

		// STEP.1 로그인 체크
		if (!mbrSession.isLoginCheck()) {
			return "redirect:/" + marketPath + "/login";
		}
		// STEP.2 주문코드 생성 (O 2 1014 1041 00 000)
		// System.out.println("getCurrentDateTime::" +
		// DateUtil.getCurrentDateTime("yyMMddHHmmssSS").substring(1));
		String ordrCd = "O" + DateUtil.getCurrentDateTime("yyMMddHHmmssSS").substring(1);

		ordrVO.setOrdrCd(ordrCd);
		ordrVO.setOrdrTy(ordrTy);

		// STEP.3 주문 상세 정보
		List<OrdrDtlVO> ordrDtlList = new ArrayList<OrdrDtlVO>();
		String[] spGdsNo = gdsNo.split(",");
		for (int i = 0; i < spGdsNo.length; i++) {

			OrdrDtlVO ordrDtlVO = new OrdrDtlVO();
			ordrDtlVO.setGdsNo(EgovStringUtil.string2integer(gdsNo.split(",")[i].trim()));
			ordrDtlVO.setGdsCd(gdsCd.split(",")[i].trim());
			if (bnefCd.split(",").length > 0) { // bnefCd null일수 있음
				ordrDtlVO.setBnefCd(bnefCd.split(",")[i].trim());
			} else {
				ordrDtlVO.setBnefCd("");
			}
			ordrDtlVO.setGdsNm(gdsNm.split(",")[i].trim());
			ordrDtlVO.setGdsPc(EgovStringUtil.string2integer(gdsPc.split(",")[i].trim()));
			ordrDtlVO.setOrdrOptnTy(ordrOptnTy.split(",")[i].trim());
			ordrDtlVO.setOrdrOptn(ordrOptn.split(",")[i].trim());
			ordrDtlVO.setOrdrOptnPc(EgovStringUtil.string2integer(ordrOptnPc.split(",")[i].trim()));
			ordrDtlVO.setOrdrQy(EgovStringUtil.string2integer(ordrQy.split(",")[i].trim()));
			ordrDtlVO.setRecipterUniqueId(mbrSession.getPrtcrRecipterInfo().getUniqueId());
			ordrDtlVO.setBplcUniqueId(bplcUniqueId);

			int ordrPc = (ordrDtlVO.getGdsPc() + ordrDtlVO.getOrdrOptnPc()) * ordrDtlVO.getOrdrQy();
			ordrDtlVO.setOrdrPc(ordrPc);

			// 상품 정보
			GdsVO gdsVO = gdsService.selectGds(EgovStringUtil.string2integer(spGdsNo[i].trim()));
			ordrDtlVO.setGdsInfo(gdsVO);

			// 사업소 정보
			BplcVO bplcVO = bplcService.selectBplcByUniqueId(bplcUniqueId);
			ordrDtlVO.setBplcInfo(bplcVO);

			ordrDtlList.add(ordrDtlVO);
		}
		model.addAttribute("ordrDtlList", ordrDtlList);

		// STEP4. 기타정보
		model.addAttribute("gdsTyCode", CodeMap.GDS_TY);
		model.addAttribute("ordrVO", ordrVO);

		// 기본주소 call
		DlvyVO bassDlvyVO = dlvyService.selectBassDlvy(mbrSession.getUniqueId());
		if (bassDlvyVO != null) {
		} else {
			bassDlvyVO = new DlvyVO();
			bassDlvyVO.setNm(mbrSession.getMbrNm());
			bassDlvyVO.setMblTelno(mbrSession.getMblTelno());
			bassDlvyVO.setTelno(mbrSession.getTelno());
			bassDlvyVO.setZip(mbrSession.getZip());
			bassDlvyVO.setAddr(mbrSession.getAddr());
			bassDlvyVO.setDaddr(mbrSession.getDaddr());
		}
		model.addAttribute("bassDlvyVO", bassDlvyVO);

		return "/market/ordr/ordr_rqst";
	}

	/**
	 * 급여 주문 > 장바구니 > 사업소 요청
	 */
	@RequestMapping(value = "cartRqst")
	public String cartRqst(@RequestParam(value = "cartGrpNos", required = true) String cartGrpNos,
			@RequestParam(value = "cartTy", required = true) String cartTy, @RequestParam Map<String, Object> reqMap,
			HttpServletRequest request, HttpServletResponse response, HttpSession session, Model model)
			throws Exception {

		// STEP.1 로그인 체크
		if (!mbrSession.isLoginCheck()) {
			return "redirect:/" + marketPath + "/login";
		}

		// STEP.2 장바구니 호출
		String[] arrCartGrpNo = cartGrpNos.split(",");

		Map<String, Object> paramMap = new HashMap<String, Object>();
		paramMap.put("srchCartGrpNos", arrCartGrpNo);

		List<CartVO> cartList = cartService.selectCartListAll(paramMap);

		// STEP.3-1 주문코드 생성 (O 22 1014 1041 00 000)
		String ordrCd = "O" + DateUtil.getCurrentDateTime("yyMMddHHmmssSS").substring(1);

		OrdrVO ordrVO = new OrdrVO();
		ordrVO.setOrdrCd(ordrCd);
		ordrVO.setOrdrTy(cartTy);

		// STEP.3-2 주문 상세 정보
		List<OrdrDtlVO> ordrDtlList = new ArrayList<OrdrDtlVO>();
		for (CartVO cartVO : cartList) {
			OrdrDtlVO ordrDtlVO = new OrdrDtlVO();
			ordrDtlVO.setGdsNo(cartVO.getGdsNo());
			ordrDtlVO.setGdsCd(cartVO.getGdsCd());
			ordrDtlVO.setBnefCd(cartVO.getBnefCd());
			ordrDtlVO.setGdsNm(cartVO.getGdsNm());
			ordrDtlVO.setGdsPc(cartVO.getGdsPc());
			ordrDtlVO.setOrdrOptnTy(cartVO.getOrdrOptnTy());
			ordrDtlVO.setOrdrOptn(cartVO.getOrdrOptn());
			ordrDtlVO.setOrdrOptnPc(cartVO.getOrdrOptnPc());
			ordrDtlVO.setOrdrQy(cartVO.getOrdrQy());

			ordrDtlVO.setRecipterUniqueId(cartVO.getRecipterUniqueId());
			ordrDtlVO.setBplcUniqueId(cartVO.getBplcUniqueId());

			int ordrPc = (ordrDtlVO.getGdsPc() + ordrDtlVO.getOrdrOptnPc()) * ordrDtlVO.getOrdrQy();
			ordrDtlVO.setOrdrPc(ordrPc);

			// 상품 정보
			GdsVO gdsVO = gdsService.selectGds(cartVO.getGdsNo());
			ordrDtlVO.setGdsInfo(gdsVO);

			// 사업소 정보
			BplcVO bplcVO = bplcService.selectBplcByUniqueId(cartVO.getBplcUniqueId());
			ordrDtlVO.setBplcInfo(bplcVO);

			ordrDtlList.add(ordrDtlVO);
		}
		model.addAttribute("ordrDtlList", ordrDtlList);

		// STEP4. 기타정보
		model.addAttribute("gdsTyCode", CodeMap.GDS_TY);
		model.addAttribute("ordrVO", ordrVO);
		model.addAttribute("cartGrpNos", cartGrpNos);

		// 기본주소 call
		DlvyVO bassDlvyVO = dlvyService.selectBassDlvy(mbrSession.getUniqueId());
		if (bassDlvyVO != null) {
		} else {
			bassDlvyVO = new DlvyVO();
			bassDlvyVO.setNm(mbrSession.getMbrNm());
			bassDlvyVO.setMblTelno(mbrSession.getMblTelno());
			bassDlvyVO.setTelno(mbrSession.getTelno());
			bassDlvyVO.setZip(mbrSession.getZip());
			bassDlvyVO.setAddr(mbrSession.getAddr());
			bassDlvyVO.setDaddr(mbrSession.getDaddr());
		}
		model.addAttribute("bassDlvyVO", bassDlvyVO);

		return "/market/ordr/ordr_rqst";
	}

	/**
	 * 급여 주문 > 사업소 요청 (SAVE)
	 */
	@RequestMapping(value = "ordrRqstAction")
	public String ordrRqstAction(OrdrVO ordrVO, @RequestParam(value = "ordrDtlCd", required = true) String ordrDtlCd,
			@RequestParam(value = "gdsNo", required = true) String gdsNo,
			@RequestParam(value = "gdsCd", required = true) String gdsCd,
			@RequestParam(value = "bnefCd", required = true) String bnefCd,
			@RequestParam(value = "gdsNm", required = true) String gdsNm,
			@RequestParam(value = "gdsPc", required = true) String gdsPc

			, @RequestParam(value = "ordrOptnTy", required = true) String ordrOptnTy,
			@RequestParam(value = "ordrOptn", required = true) String ordrOptn,
			@RequestParam(value = "ordrOptnPc", required = true) String ordrOptnPc,
			@RequestParam(value = "ordrQy", required = true) String ordrQy,
			@RequestParam(value = "ordrPc", required = true) String ordrPc

			, @RequestParam(value = "dlvyBassAmt", required = false) String dlvyBassAmt,
			@RequestParam(value = "dlvyAditAmt", required = false) String dlvyAditAmt

			, @RequestParam(value = "couponNo", required = false) String couponNo,
			@RequestParam(value = "couponCd", required = false) String couponCd,
			@RequestParam(value = "couponAmt", required = false) String couponAmt

			, @RequestParam(value = "recipterUniqueId", required = false) String recipterUniqueId,
			@RequestParam(value = "bplcUniqueId", required = false) String bplcUniqueId

			, @RequestParam(value = "accmlMlg", required = false) String accmlMlg

			, @RequestParam(value = "stlmTy", required = false) String stlmTy // 결제 수단
			, @RequestParam(value = "stlmAmt", required = false) int stlmAmt // 총 결제 금액
			, @RequestParam(value = "stlmYn", required = false) String stlmYn

			, @RequestParam(value = "cartGrpNos", required = false) String cartGrpNos

			, @RequestParam Map<String, Object> reqMap, HttpServletRequest request, HttpServletResponse response,
			HttpSession session, Model model) throws Exception {

		// STEP.1 로그인 체크
		if (!mbrSession.isLoginCheck()) {
			return "redirect:/" + marketPath + "/login";
		}

		//double-submit-preventer
		if (EgovDoubleSubmitHelper.checkAndSaveToken("preventTokenKey", request)) {

			// ordrVO 저장
			ordrVO.setUniqueId(mbrSession.getUniqueId());
			ordrVO.setOrdrrId(mbrSession.getMbrId());
			ordrVO.setOrdrrNm(mbrSession.getMbrNm());
			ordrVO.setOrdrrEml(mbrSession.getEml());
			ordrVO.setOrdrrTelno(mbrSession.getTelno());
			ordrVO.setOrdrrMblTelno(mbrSession.getMblTelno());
			ordrVO.setOrdrrZip(mbrSession.getZip());
			ordrVO.setOrdrrAddr(mbrSession.getAddr());
			ordrVO.setOrdrrDaddr(mbrSession.getDaddr());

			ordrVO.setStlmDevice(WebUtil.getDevice(request));
			ordrVO.setStlmYn("N");// 가상계좌입금일 경우만 N

			// TO-DO : 마일리지/포인트
			ordrService.insertOrdr(ordrVO);

			// 주문 상세 정보
			List<OrdrDtlVO> ordrDtlList = new ArrayList<OrdrDtlVO>();
			String[] spOrdrDtlCd = ordrDtlCd.split(",");
			ArrayList<Map<String, Object>> ordrList = new ArrayList<>();
			JSONParser jsonParser = new JSONParser();
			boolean searchCnt = true;
			for (int i = 0; i < spOrdrDtlCd.length; i++) {

				OrdrDtlVO ordrDtlVO = new OrdrDtlVO();
				ordrDtlVO.setOrdrNo(ordrVO.getOrdrNo());
				ordrDtlVO.setOrdrCd(ordrVO.getOrdrCd());
				ordrDtlVO.setOrdrDtlCd(ordrDtlCd.split(",")[i].trim());
				ordrDtlVO.setGdsNo(EgovStringUtil.string2integer(gdsNo.split(",")[i].trim()));
				ordrDtlVO.setGdsCd(gdsCd.split(",")[i].trim());
				if (bnefCd.split(",").length > 0) { // bnefCd null일수 있음
					ordrDtlVO.setBnefCd(bnefCd.split(",")[i].trim());
				} else {
					ordrDtlVO.setBnefCd("");
				}
				ordrDtlVO.setGdsNm(gdsNm.split(",")[i].trim());
				ordrDtlVO.setGdsPc(EgovStringUtil.string2integer(gdsPc.split(",")[i].trim()));
				ordrDtlVO.setOrdrOptnTy(ordrOptnTy.split(",")[i].trim());
				ordrDtlVO.setOrdrOptn(ordrOptn.split(",")[i].trim());
				ordrDtlVO.setOrdrOptnPc(EgovStringUtil.string2integer(ordrOptnPc.split(",")[i].trim()));
				ordrDtlVO.setOrdrQy(EgovStringUtil.string2integer(ordrQy.split(",")[i].trim()));
				ordrDtlVO.setOrdrPc(EgovStringUtil.string2integer(ordrPc.split(",")[i].trim()));
				ordrDtlVO.setDlvyBassAmt(EgovStringUtil.string2integer(dlvyBassAmt.split(",")[i].trim()));
				ordrDtlVO.setDlvyAditAmt(EgovStringUtil.string2integer(dlvyAditAmt.split(",")[i].trim()));
				ordrDtlVO.setCouponNo(EgovStringUtil.string2integer(couponNo.split(",")[i].trim()));
				ordrDtlVO.setCouponCd(couponCd.split(",")[i].trim());
				ordrDtlVO.setCouponAmt(EgovStringUtil.string2integer(couponAmt.split(",")[i].trim()));

				// 수혜자
				if (recipterUniqueId.split(",").length > 0) {
					ordrDtlVO.setRecipterUniqueId(recipterUniqueId.split(",")[i].trim());
				} else {
					ordrDtlVO.setRecipterUniqueId("");
				}

				// 사업소
				if (bplcUniqueId.split(",").length > 0) {
					ordrDtlVO.setBplcUniqueId(bplcUniqueId.split(",")[i].trim());
				} else {
					ordrDtlVO.setBplcUniqueId("");
				}

				ordrDtlVO.setSttsTy("OR01");

				ordrDtlVO.setRegUniqueId(mbrSession.getUniqueId());
				ordrDtlVO.setRegId(mbrSession.getMbrId());
				ordrDtlVO.setRgtr(mbrSession.getMbrNm());

				// 상품 정보
				GdsVO gdsVO = gdsService.selectGds(EgovStringUtil.string2integer(gdsNo.split(",")[i].trim()));
				ordrDtlVO.setGdsInfo(gdsVO);

				ordrDtlService.insertOrdrDtl(ordrDtlVO);

				// 1.5 -> 1.0 상품 정보 조회 (item_info)
				ArrayList<Map<String, Object>> arrayList = new ArrayList<>();
				Map<String, Object> itemMap = new HashMap<String, Object>();
				Map<String, Object> gdsInfoMap = new HashMap<String, Object>();
				itemMap.put("ProdPayCode", Base64Util.encoder(ordrDtlVO.getGdsInfo().getBnefCd()));
				itemMap.put("item_id", null);
				itemMap.put("item_opt_id", null);
				arrayList.add(itemMap);

				String returnJson = updateBplcInfoApiService.selectEroumCareOrdr(arrayList);
				System.out.println("@@@@@@@@@@조회값 : " + returnJson);
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
						gdsInfoMap.put("item_opt_id", Base64Util.encoder(ordrDtlVO.getOrdrOptn().replace("*", Character.toString( (char) 0x1E)).replace(" ", "")));
						gdsInfoMap.put("item_qty", Base64Util.encoder(EgovStringUtil.integer2string(ordrDtlVO.getOrdrQy())));
						gdsInfoMap.put("order_send_dtl_id", Base64Util.encoder(ordrDtlVO.getOrdrDtlCd()));
						ordrList.add(gdsInfoMap);
						}
					}
				}

				// 히스토리 기록
				ordrDtlVO.setResn("주문승인대기");
				ordrDtlService.insertOrdrSttsChgHist(ordrDtlVO);

				ordrDtlList.add(ordrDtlVO);
			}

			// 1.5 -> 1.0 주문정보 송신
			String returnData = updateBplcInfoApiService.putEroumOrdrInfo(ordrVO.getOrdrCd(), ordrList);

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


			// 장바구니 삭제
			if (EgovStringUtil.isNotEmpty(cartGrpNos)) {
				String[] arrCartGrpNo = cartGrpNos.split(",");
				Map<String, Object> paramMap = new HashMap<String, Object>();
				paramMap.put("srchCartGrpNos", arrCartGrpNo);
				paramMap.put("srchRecipterUniqueId", ordrDtlList.get(0).getRecipterUniqueId());
				cartService.deleteCart(paramMap);
			}

			model.addAttribute("ordrDtlList", ordrDtlList);
			model.addAttribute("gdsTyCode", CodeMap.GDS_TY);

			return "redirect:/" + marketPath + "/ordr/ordrRqstDone/" + ordrVO.getOrdrCd();

			}else {
				return "redirect:/" + marketPath;
			}
	}

	/**
	 * 급여 주문 > 사업소 요청 완료
	 */
	@RequestMapping(value = "ordrRqstDone/{ordrCd}")
	public String ordrRqstDone(@PathVariable String ordrCd, @RequestParam Map<String, Object> reqMap,
			HttpServletRequest request, HttpServletResponse response, HttpSession session, Model model)
			throws Exception {

		// STEP.1 로그인 체크
		if (!mbrSession.isLoginCheck()) {
			return "redirect:/" + marketPath + "/login";
		}

		OrdrVO ordrVO = ordrService.selectOrdrByCd(ordrCd);

		model.addAttribute("ordrVO", ordrVO);

		// 코드 정보
		model.addAttribute("gdsTyCode", CodeMap.GDS_TY);
		model.addAttribute("ordrSttsCode", CodeMap.ORDR_STTS);
		model.addAttribute("bassStlmTyCode", CodeMap.BASS_STLM_TY);

		return "/market/ordr/ordr_rqst_done";
	}

	/**
	 * 비급여 주문
	 */
	@RequestMapping(value = "ordrPay")
	public String ordrPayment(OrdrVO ordrVO, @RequestParam(value = "ordrTy", required = true) String ordrTy,
			@RequestParam(value = "gdsNo", required = true) String gdsNo,
			@RequestParam(value = "gdsCd", required = true) String gdsCd,
			@RequestParam(value = "bnefCd", required = true) String bnefCd,
			@RequestParam(value = "gdsNm", required = true) String gdsNm,
			@RequestParam(value = "gdsPc", required = true) String gdsPc

			, @RequestParam(value = "ordrOptnTy", required = true) String ordrOptnTy,
			@RequestParam(value = "ordrOptn", required = true) String ordrOptn,
			@RequestParam(value = "ordrOptnPc", required = true) String ordrOptnPc,
			@RequestParam(value = "ordrQy", required = true) String ordrQy

			, @RequestParam(value = "recipterUniqueId", required = false) String recipterUniqueId,
			@RequestParam(value = "bplcUniqueId", required = false) String bplcUniqueId

			, @RequestParam Map<String, Object> reqMap, HttpServletRequest request, HttpServletResponse response,
			HttpSession session, Model model) throws Exception {

		// STEP.1 로그인 체크
		if (!mbrSession.isLoginCheck()) {
			return "redirect:/" + marketPath + "/login";
		}

		// STEP.2 주문코드 생성 (O 2 1014 1041 00 000)
		// System.out.println("getCurrentDateTime::" +
		// DateUtil.getCurrentDateTime("yyMMddHHmmssSS").substring(1));
		String ordrCd = "O" + DateUtil.getCurrentDateTime("yyMMddHHmmssSS").substring(1);
		ordrVO.setOrdrCd(ordrCd);
		ordrVO.setOrdrTy(ordrTy);

		// STEP.3 주문 상세 정보
		List<OrdrDtlVO> ordrDtlList = new ArrayList<OrdrDtlVO>();
		String[] spGdsNo = gdsNo.split(",");
		for (int i = 0; i < spGdsNo.length; i++) {

			OrdrDtlVO ordrDtlVO = new OrdrDtlVO();
			ordrDtlVO.setGdsNo(EgovStringUtil.string2integer(gdsNo.split(",")[i].trim()));
			ordrDtlVO.setGdsCd(gdsCd.split(",")[i].trim());
			if (bnefCd.split(",").length > 0) { // bnefCd null일수 있음
				ordrDtlVO.setBnefCd(bnefCd.split(",")[i].trim());
			} else {
				ordrDtlVO.setBnefCd("");
			}
			ordrDtlVO.setGdsNm(gdsNm.split(",")[i].trim());
			ordrDtlVO.setGdsPc(EgovStringUtil.string2integer(gdsPc.split(",")[i].trim()));
			ordrDtlVO.setOrdrOptnTy(ordrOptnTy.split(",")[i].trim());
			ordrDtlVO.setOrdrOptn(ordrOptn.split(",")[i].trim());
			ordrDtlVO.setOrdrOptnPc(EgovStringUtil.string2integer(ordrOptnPc.split(",")[i].trim()));
			ordrDtlVO.setOrdrQy(EgovStringUtil.string2integer(ordrQy.split(",")[i].trim()));
			ordrDtlVO.setRecipterUniqueId(mbrSession.getPrtcrRecipterInfo().getUniqueId());
			ordrDtlVO.setBplcUniqueId(bplcUniqueId);

			int ordrPc = (ordrDtlVO.getGdsPc() + ordrDtlVO.getOrdrOptnPc()) * ordrDtlVO.getOrdrQy();
			ordrDtlVO.setOrdrPc(ordrPc);

			// 상품 정보
			GdsVO gdsVO = gdsService.selectGds(EgovStringUtil.string2integer(spGdsNo[i].trim()));
			ordrDtlVO.setGdsInfo(gdsVO);

			ordrDtlList.add(ordrDtlVO);
		}
		model.addAttribute("ordrDtlList", ordrDtlList);

		// STEP4. 기타정보
		model.addAttribute("gdsTyCode", CodeMap.GDS_TY);
		model.addAttribute("ordrVO", ordrVO);

		// 기본주소 call
		DlvyVO bassDlvyVO = dlvyService.selectBassDlvy(mbrSession.getUniqueId());
		if (bassDlvyVO != null) {
		} else {
			bassDlvyVO = new DlvyVO();
			bassDlvyVO.setNm(mbrSession.getMbrNm());
			bassDlvyVO.setMblTelno(mbrSession.getMblTelno());
			bassDlvyVO.setTelno(mbrSession.getTelno());
			bassDlvyVO.setZip(mbrSession.getZip());
			bassDlvyVO.setAddr(mbrSession.getAddr());
			bassDlvyVO.setDaddr(mbrSession.getDaddr());
		}
		model.addAttribute("bassDlvyVO", bassDlvyVO);

		return "/market/ordr/ordr_pay";
	}

	/**
	 * 비급여 주문 > 장바구니
	 */
	@RequestMapping(value = "cartPay")
	public String cartPay(@RequestParam(value = "cartGrpNos", required = true) String cartGrpNos,
			@RequestParam(value = "cartTy", required = true) String cartTy, @RequestParam Map<String, Object> reqMap,
			HttpServletRequest request, HttpServletResponse response, HttpSession session, Model model)
			throws Exception {

		// STEP.1 로그인 체크
		if (!mbrSession.isLoginCheck()) {
			return "redirect:/" + marketPath + "/login";
		}

		// STEP.2 장바구니 호출
		String[] arrCartGrpNo = cartGrpNos.split(",");
		Map<String, Object> paramMap = new HashMap<String, Object>();
		paramMap.put("srchCartGrpNos", arrCartGrpNo);

		List<CartVO> cartList = cartService.selectCartListAll(paramMap);

		// STEP.3-1 주문코드 생성 (O 22 1014 1041 00 000)
		String ordrCd = "O" + DateUtil.getCurrentDateTime("yyMMddHHmmssSS").substring(1);

		OrdrVO ordrVO = new OrdrVO();
		ordrVO.setOrdrCd(ordrCd);
		ordrVO.setOrdrTy(cartTy);

		// STEP.3 주문 상세 정보
		List<OrdrDtlVO> ordrDtlList = new ArrayList<OrdrDtlVO>();
		for (CartVO cartVO : cartList) {
			OrdrDtlVO ordrDtlVO = new OrdrDtlVO();
			ordrDtlVO.setGdsNo(cartVO.getGdsNo());
			ordrDtlVO.setGdsCd(cartVO.getGdsCd());
			ordrDtlVO.setBnefCd(cartVO.getBnefCd());
			ordrDtlVO.setGdsNm(cartVO.getGdsNm());
			ordrDtlVO.setGdsPc(cartVO.getGdsPc());
			ordrDtlVO.setOrdrOptnTy(cartVO.getOrdrOptnTy());
			ordrDtlVO.setOrdrOptn(cartVO.getOrdrOptn());
			ordrDtlVO.setOrdrOptnPc(cartVO.getOrdrOptnPc());
			ordrDtlVO.setOrdrQy(cartVO.getOrdrQy());

			ordrDtlVO.setRecipterUniqueId(cartVO.getRecipterUniqueId());
			ordrDtlVO.setBplcUniqueId(cartVO.getBplcUniqueId());

			int ordrPc = (ordrDtlVO.getGdsPc() + ordrDtlVO.getOrdrOptnPc()) * ordrDtlVO.getOrdrQy();
			ordrDtlVO.setOrdrPc(ordrPc);

			// 상품 정보
			GdsVO gdsVO = gdsService.selectGds(cartVO.getGdsNo());
			ordrDtlVO.setGdsInfo(gdsVO);

			// 사업소 정보 > 바로 구매는 사업소가 없음
			// BplcVO bplcVO = bplcService.selectBplcByUniqueId(cartVO.getBplcUniqueId());
			BplcVO bplcVO = new BplcVO();
			ordrDtlVO.setBplcInfo(bplcVO);

			ordrDtlList.add(ordrDtlVO);
		}
		model.addAttribute("ordrDtlList", ordrDtlList);

		// STEP4. 기타정보
		model.addAttribute("gdsTyCode", CodeMap.GDS_TY);
		model.addAttribute("ordrVO", ordrVO);
		model.addAttribute("cartGrpNos", cartGrpNos);

		// 기본주소 call
		DlvyVO bassDlvyVO = dlvyService.selectBassDlvy(mbrSession.getUniqueId());
		if (bassDlvyVO != null) {
		} else {
			bassDlvyVO = new DlvyVO();
			bassDlvyVO.setNm(mbrSession.getMbrNm());
			bassDlvyVO.setMblTelno(mbrSession.getMblTelno());
			bassDlvyVO.setTelno(mbrSession.getTelno());
			bassDlvyVO.setZip(mbrSession.getZip());
			bassDlvyVO.setAddr(mbrSession.getAddr());
			bassDlvyVO.setDaddr(mbrSession.getDaddr());
		}
		model.addAttribute("bassDlvyVO", bassDlvyVO);

		return "/market/ordr/ordr_pay";
	}

	// 상품주문 결제
	@RequestMapping(value = "ordrPayAction")
	public String ordrPayAction(OrdrVO ordrVO, @RequestParam(value = "ordrDtlCd", required = true) String ordrDtlCd,
			@RequestParam(value = "gdsNo", required = true) String gdsNo,
			@RequestParam(value = "gdsCd", required = true) String gdsCd,
			@RequestParam(value = "bnefCd", required = true) String bnefCd,
			@RequestParam(value = "gdsNm", required = true) String gdsNm,
			@RequestParam(value = "gdsPc", required = true) String gdsPc

			, @RequestParam(value = "ordrOptnTy", required = true) String ordrOptnTy,
			@RequestParam(value = "ordrOptn", required = true) String ordrOptn,
			@RequestParam(value = "ordrOptnPc", required = true) String ordrOptnPc,
			@RequestParam(value = "ordrQy", required = true) String ordrQy

			, @RequestParam(value = "ordrPc", required = true) String ordrPc

			, @RequestParam(value = "dlvyBassAmt", required = false) String dlvyBassAmt,
			@RequestParam(value = "dlvyAditAmt", required = false) String dlvyAditAmt

			, @RequestParam(value = "couponNo", required = false) String couponNo,
			@RequestParam(value = "couponCd", required = false) String couponCd,
			@RequestParam(value = "couponAmt", required = false) String couponAmt

			, @RequestParam(value = "recipterUniqueId", required = false) String recipterUniqueId,
			@RequestParam(value = "bplcUniqueId", required = false) String bplcUniqueId

			, @RequestParam(value = "accmlMlg", required = false) String accmlMlg,
			@RequestParam(value = "cartGrpNos", required = false) String cartGrpNos

			, @RequestParam(value = "stlmYn", required = true) String stlmYn,
			@RequestParam(value = "stlmTy", required = true) String stlmTy

			, @RequestParam(value = "mbrMlg", required = false) String mbrMlg,
			@RequestParam(value = "mbrPoint", required = false) String mbrPoint

			, @RequestParam Map<String, Object> reqMap, HttpServletRequest request, HttpServletResponse response,
			HttpSession session, Model model) throws Exception {

		// STEP.1 로그인 체크
		if (!mbrSession.isLoginCheck()) {
			return "redirect:/" + marketPath + "/login";
		}

		// doubleSubmit check
		if (EgovDoubleSubmitHelper.checkAndSaveToken("preventTokenKey", request)) {

			if (EgovStringUtil.equals("FREE", stlmTy)) {
				ordrVO.setStlmYn("Y");
				ordrVO.setStlmDt(DateUtil.getCurrentDateTime("yyyy-MM-dd HH:mm:ss")); // 결제일
			} else {
				// 결제 정보 검증
				try {
					HashMap<String, Object> res = bootpayApiService.confirm(ordrVO.getDelngNo());
					if (res.get("error_code") == null) { // success
						System.out.println("success: " + res);
						ordrVO.setStlmYn("Y");

						// 이메일 발송
						SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
						DecimalFormat numberFormat = new DecimalFormat("###,###");

						try {
							if (ValidatorUtil.isEmail(ordrVO.getOrdrrEml())) {
								String MAIL_FORM_PATH = mailFormFilePath;
								String mailForm = FileUtil.readFile(MAIL_FORM_PATH + "mail_deposit.html");

								// 입금기한
								mailForm = mailForm.replace("{yyyy}", ordrVO.getDpstTermDt().substring(0, 4));
								mailForm = mailForm.replace("{MM}", ordrVO.getDpstTermDt().substring(5, 7));
								mailForm = mailForm.replace("{dd}", ordrVO.getDpstTermDt().substring(8, 10));
								mailForm = mailForm.replace("{HH}", ordrVO.getDpstTermDt().substring(11, 16));

								mailForm = mailForm.replace("{mbrNm}", ordrVO.getOrdrrNm()); // 주문자
								mailForm = mailForm.replace("{ordrDt}", formatter.format(ordrVO.getOrdrDt())); // 주문일
								mailForm = mailForm.replace("{ordrCd}", ordrVO.getOrdrCd()); // 주문번호

								// 상품 정보 Start
								String last = "";
								String base = "";
								String adit = "";
								String base_reset = "";
								String adit_reset = "";
								String bplc = "";

								for (int i=0; i<ordrVO.getOrdrDtlList().size(); i++) {

									// BASE
									if(ordrVO.getOrdrDtlList().get(i).getOrdrOptnTy().equals("BASE")) {
										base = base.replace("{aditOptn}", "");
										base_reset = "";
										String base_html = FileUtil.readFile(MAIL_FORM_PATH + "mail_ordr_gds.html");
										base_html = base_html.replace("{gdsNm}", ordrVO.getOrdrDtlList().get(i).getGdsNm());
										base_html = base_html.replace("{gdsOptnNm}", ordrVO.getOrdrDtlList().get(i).getOrdrOptn());
										base_html = base_html.replace("{ordrQy}", EgovStringUtil.integer2string(ordrVO.getOrdrDtlList().get(i).getOrdrQy()));
										base_html = base_html.replace("{ordrPc}", numberFormat.format(ordrVO.getOrdrDtlList().get(i).getOrdrPc()));

										// 멤버스
										if (!ordrVO.getOrdrTy().equals("N")) {
											bplc = FileUtil.readFile(MAIL_FORM_PATH + "mail_ordr_bplc.html");
											bplc = bplc.replace("{bplcNm}", ordrVO.getOrdrDtlList().get(i).getBplcInfo().getBplcNm());
											bplc = bplc.replace("{telno}", ordrVO.getOrdrDtlList().get(i).getBplcInfo().getTelno());
											bplc = bplc.replace("{dlvyPc}",
													numberFormat.format((ordrVO.getOrdrDtlList().get(i).getDlvyAditAmt()
															+ ordrVO.getOrdrDtlList().get(i).getDlvyBassAmt())));
											base_html = base_html.replace("{bplc}", bplc);
										} else {
											base_html = base_html.replace("{bplc}", "");
										}

										base_reset = base_html;
									}

									if(ordrVO.getOrdrDtlList().get(i).getOrdrOptnTy().equals("ADIT")) {
										// ADIT
										adit_reset = "";
										String adit_html = FileUtil.readFile(MAIL_FORM_PATH + "mail_ordr_gds_optn.html");
										adit_html = adit_html.replace("{optnNm}", ordrVO.getOrdrDtlList().get(i).getOrdrOptn());
										adit_html = adit_html.replace("{optnQy}", EgovStringUtil.integer2string(ordrVO.getOrdrDtlList().get(i).getOrdrQy()));
										adit_html = adit_html.replace("{optnPc}", numberFormat.format(ordrVO.getOrdrDtlList().get(i).getOrdrOptnPc()));

										adit_reset = adit_html;
									}


									if(i == (ordrVO.getOrdrDtlList().size()-1)) {

										if(ordrVO.getOrdrDtlList().get(i).getOrdrOptnTy().equals("BASE")) {

											base += base_reset;
											base = base.replace("{aditOptn}", "");
										}else {
											adit += adit_reset;
											base = base.replace("{aditOptn}",adit);
										}
										last += base;

										mailForm = mailForm.replace("{gdsView}", last);
									}else {
										if(ordrVO.getOrdrDtlList().get(i).getOrdrOptnTy().equals("BASE")) {
											base += base_reset;
										}else {
											adit += adit_reset;
										}
									}


								}

								// 배송 정보
								mailForm = mailForm.replace("{recptrNm}", ordrVO.getRecptrNm()); // 받는사람
								mailForm = mailForm.replace("{dpstTermDt}", ordrVO.getDpstTermDt()); // 입금기한
								mailForm = mailForm.replace("{zip}", ordrVO.getRecptrZip()); // 지번
								mailForm = mailForm.replace("{addr}", ordrVO.getRecptrAddr() + ordrVO.getRecptrDaddr()); // 주소

								// 결제 정보
								int totalGdsPc = 0; // 총 상품 금액 (상품 가격 * 수량)
								int dlvyPc = 0; // 배송비
								int couponAmts = 0; // 쿠폰 할인

								int mlg = ordrVO.getUseMlg(); // 마일리지
								int point = ordrVO.getUsePoint(); // 포인트

								for (OrdrDtlVO ordrDtlVO : ordrVO.getOrdrDtlList()) {
									if(ordrDtlVO.getOrdrOptnTy().equals("BASE")) {
										totalGdsPc += (ordrDtlVO.getGdsPc() * ordrDtlVO.getOrdrQy());
									}else {
										totalGdsPc += (ordrDtlVO.getOrdrOptnPc() * ordrDtlVO.getOrdrQy());
									}
									dlvyPc += (ordrDtlVO.getDlvyBassAmt() + ordrDtlVO.getDlvyAditAmt());
									couponAmts += ordrDtlVO.getCouponAmt();
								}

								mailForm = mailForm.replace("{totalOrdrPc}", numberFormat.format(totalGdsPc));
								mailForm = mailForm.replace("{dlvyPc}", numberFormat.format(dlvyPc));
								mailForm = mailForm.replace("{couponAmt}", numberFormat.format(couponAmts + mlg + point));

								mailForm = mailForm.replace("{stlmAmt}", numberFormat.format(ordrVO.getStlmAmt())); // 결제금액

								mailForm = mailForm.replace("{bank}", ordrVO.getDpstBankNm()); // 은행
								mailForm = mailForm.replace("{actno}", ordrVO.getVrActno()); // 계좌번호
								mailForm = mailForm.replace("{dsptDt}", ordrVO.getDpstTermDt().substring(0, 16)); // 입금기한

								// 메일 발송
								String mailSj = "[EROUM] 회원님의 주문이 접수 되었습니다.";
								if (EgovStringUtil.equals("real", activeMode)) {
									mailService.sendMail(sendMail, ordrVO.getOrdrrEml(), mailSj, mailForm);
								} else if (EgovStringUtil.equals("dev", activeMode)) {
									mailService.sendMail(sendMail, ordrVO.getOrdrrEml(), mailSj, mailForm);
								} else {
									mailService.sendMail(sendMail, "gyoh@icubesystems.co.kr", mailSj, mailForm); // 테스트
								}
							} else {
								System.out.println("사용자 상품 주문 접수 알림 EMAIL 전송 실패 :: 이메일 체크 " + ordrVO.getOrdrrEml());
							}
						} catch (Exception e) {
							System.out.println("사용자 상품 주문 접수 알림 EMAIL 전송 실패 :: " + e.toString());
						}

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
			}

			// ordrVO 저장
			// 주문정보
			ordrVO.setUniqueId(mbrSession.getUniqueId());
			ordrVO.setOrdrrId(mbrSession.getMbrId());
			ordrVO.setOrdrrNm(mbrSession.getMbrNm());
			ordrVO.setOrdrrEml(mbrSession.getEml());
			ordrVO.setOrdrrTelno(mbrSession.getTelno());
			ordrVO.setOrdrrMblTelno(mbrSession.getMblTelno());
			ordrVO.setOrdrrZip(mbrSession.getZip());
			ordrVO.setOrdrrAddr(mbrSession.getAddr());
			ordrVO.setOrdrrDaddr(mbrSession.getDaddr());
			ordrVO.setStlmDevice(WebUtil.getDevice(request));
			ordrVO.setStlmTy(ordrVO.getStlmTy().toUpperCase());

			// System.out.println("ordrVO: " + ordrVO.toString());

			ordrService.insertOrdr(ordrVO);

			// 주문 상세 정보
			List<OrdrDtlVO> ordrDtlList = new ArrayList<OrdrDtlVO>();
			String[] spOrdrDtlCd = ordrDtlCd.split(",");

			// 주문 상태 전달용
			for (int i = 0; i < spOrdrDtlCd.length; i++) {

				OrdrDtlVO ordrDtlVO = new OrdrDtlVO();
				ordrDtlVO.setOrdrNo(ordrVO.getOrdrNo());
				ordrDtlVO.setOrdrCd(ordrVO.getOrdrCd());
				ordrDtlVO.setOrdrDtlCd(ordrDtlCd.split(",")[i].trim());
				ordrDtlVO.setGdsNo(EgovStringUtil.string2integer(gdsNo.split(",")[i].trim()));
				ordrDtlVO.setGdsCd(gdsCd.split(",")[i].trim());
				if (bnefCd.split(",").length > 0) { // bnefCd null일수 있음
					ordrDtlVO.setBnefCd(bnefCd.split(",")[i].trim());
				} else {
					ordrDtlVO.setBnefCd("");
				}
				ordrDtlVO.setGdsNm(gdsNm.split(",")[i].trim());
				ordrDtlVO.setGdsPc(EgovStringUtil.string2integer(gdsPc.split(",")[i].trim()));
				ordrDtlVO.setOrdrOptnTy(ordrOptnTy.split(",")[i].trim());
				ordrDtlVO.setOrdrOptn(ordrOptn.split(",")[i].trim());
				ordrDtlVO.setOrdrOptnPc(EgovStringUtil.string2integer(ordrOptnPc.split(",")[i].trim()));
				ordrDtlVO.setOrdrQy(EgovStringUtil.string2integer(ordrQy.split(",")[i].trim()));
				ordrDtlVO.setOrdrPc(EgovStringUtil.string2integer(ordrPc.split(",")[i].trim()));

				ordrDtlVO.setAccmlMlg(EgovStringUtil.string2integer(accmlMlg.split(",")[i].trim(), 0));

				ordrDtlVO.setDlvyBassAmt(EgovStringUtil.string2integer(dlvyBassAmt.split(",")[i].trim()));
				ordrDtlVO.setDlvyAditAmt(EgovStringUtil.string2integer(dlvyAditAmt.split(",")[i].trim()));

				ordrDtlVO.setCouponNo(EgovStringUtil.string2integer(couponNo.split(",")[i].trim()));
				ordrDtlVO.setCouponCd(couponCd.split(",")[i].trim());
				ordrDtlVO.setCouponAmt(EgovStringUtil.string2integer(couponAmt.split(",")[i].trim()));

				// 수혜자
				if (recipterUniqueId.split(",").length > 0) {
					ordrDtlVO.setRecipterUniqueId(recipterUniqueId.split(",")[i].trim());
				} else {
					ordrDtlVO.setRecipterUniqueId("");
				}

				// 사업소
				if (bplcUniqueId.split(",").length > 0) {
					ordrDtlVO.setBplcUniqueId(bplcUniqueId.split(",")[i].trim());
				} else {
					ordrDtlVO.setBplcUniqueId("");
				}


				if (EgovStringUtil.equals("Y", ordrVO.getStlmYn())) {
					ordrDtlVO.setSttsTy("OR05");
				} else {
					ordrDtlVO.setSttsTy("OR04");
				}

				// 쿠폰 사용처리
				if (couponNo.split(",").length > 0) {
					Map<String, Object> paramMap = new HashMap<String, Object>();
					paramMap.put("uniqueId", mbrSession.getUniqueId());
					paramMap.put("couponNo", EgovStringUtil.string2integer(couponNo.split(",")[i].trim()));
					paramMap.put("useYn", "Y");
					couponLstService.updateCouponUseYn(paramMap);
				}

				ordrDtlVO.setRegUniqueId(mbrSession.getUniqueId());
				ordrDtlVO.setRegId(mbrSession.getMbrId());
				ordrDtlVO.setRgtr(mbrSession.getMbrNm());

				// 상품 정보
				GdsVO gdsVO = gdsService.selectGds(EgovStringUtil.string2integer(gdsNo.split(",")[i].trim()));
				ordrDtlVO.setGdsInfo(gdsVO);

				// System.out.println("ordrDtlVO: " + ordrVO.toString());

				ordrDtlService.insertOrdrDtl(ordrDtlVO);

				// System.out.println("ordrDtlVO:" + ordrDtlVO.toString());

				// 히스토리 기록
				String resn = "";
				if ("OR04".equals(ordrDtlVO.getSttsTy())) {
					resn = "결제대기";
				} else if ("OR05".equals(ordrDtlVO.getSttsTy())) {
					resn = "결제완료";
				}

				ordrDtlVO.setResn(resn);
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
					mbrMlgVO.setMlg(EgovStringUtil.string2integer(spVal[1].trim()) * -1);

					// 내역 등록
					mbrMlgService.insertMbrMlg(mbrMlgVO);

					// TO-DO : 사용인원별 차감
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
					mbrPointVO.setGiveMthd("SYS");
					mbrPointVO.setPoint(EgovStringUtil.string2integer(spVal[1].trim()) * -1);

					// 내역 등록
					mbrPointService.insertMbrPoint(mbrPointVO);

					// TO-DO : 사용인원별 차감
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

			model.addAttribute("ordrDtlList", ordrDtlList);
			model.addAttribute("gdsTyCode", CodeMap.GDS_TY);
			}else {
				return "redirect:/" + marketPath;
			}

		return "redirect:/" + marketPath + "/ordr/ordrPayDone/" + ordrVO.getOrdrCd();
	}

	@RequestMapping(value = "ordrPayDone/{ordrCd}")
	public String ordrPayDone(@PathVariable String ordrCd, @RequestParam Map<String, Object> reqMap,
			HttpServletRequest request, HttpServletResponse response, HttpSession session, Model model)
			throws Exception {

		// STEP.1 로그인 체크
		if (!mbrSession.isLoginCheck()) {
			return "redirect:/" + marketPath + "/login";
		}

		OrdrVO ordrVO = ordrService.selectOrdrByCd(ordrCd);

		// 주문 상태 전달 1.5 -> 1.0
		Map<String, Object> dataMap = new HashMap<String, Object>();
		if(ordrVO.getStlmYn().equals("Y")) {
			dataMap.put("order_state", Base64Util.encoder("Y"));
		}else {
			dataMap.put("order_state", Base64Util.encoder("N"));
		}
		dataMap.put("order_send_id", Base64Util.encoder(ordrVO.getOrdrCd()));
		dataMap.put("ordrNo", ordrVO.getOrdrNo());
		dataMap.put("dataType", "stlm");
		updateBplcInfoApiService.putStlmYnSttus(dataMap);

		// 주문완료 이메일
		SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		DecimalFormat numberFormat = new DecimalFormat("###,###");

		try {
			if (ValidatorUtil.isEmail(ordrVO.getOrdrrEml())) {
				String MAIL_FORM_PATH = mailFormFilePath;
				String mailForm = FileUtil.readFile(MAIL_FORM_PATH + "mail_ordr.html");

				// 입금기한
				mailForm = mailForm.replace("{yyyy}", ordrVO.getDpstTermDt().substring(0, 4));
				mailForm = mailForm.replace("{MM}", ordrVO.getDpstTermDt().substring(5, 7));
				mailForm = mailForm.replace("{dd}", ordrVO.getDpstTermDt().substring(8, 10));
				mailForm = mailForm.replace("{HH}", ordrVO.getDpstTermDt().substring(11, 16));

				mailForm = mailForm.replace("{mbrNm}", ordrVO.getOrdrrNm()); // 주문자
				mailForm = mailForm.replace("{ordrDt}", formatter.format(ordrVO.getOrdrDt())); // 주문일
				mailForm = mailForm.replace("{ordrCd}", ordrVO.getOrdrCd()); // 주문번호

				// 상품 정보 Start
				String last = "";
				String base = "";
				String adit = "";
				String base_reset = "";
				String adit_reset = "";
				String bplc = "";

				for (int i=0; i<ordrVO.getOrdrDtlList().size(); i++) {

					// BASE
					if(ordrVO.getOrdrDtlList().get(i).getOrdrOptnTy().equals("BASE")) {
						base = base.replace("{aditOptn}", "");
						base_reset = "";
						String base_html = FileUtil.readFile(MAIL_FORM_PATH + "mail_ordr_gds.html");
						base_html = base_html.replace("{gdsNm}", ordrVO.getOrdrDtlList().get(i).getGdsNm());
						base_html = base_html.replace("{gdsOptnNm}", ordrVO.getOrdrDtlList().get(i).getOrdrOptn());
						base_html = base_html.replace("{ordrQy}", EgovStringUtil.integer2string(ordrVO.getOrdrDtlList().get(i).getOrdrQy()));
						base_html = base_html.replace("{ordrPc}", numberFormat.format(ordrVO.getOrdrDtlList().get(i).getOrdrPc()));

						// 멤버스
						if (!ordrVO.getOrdrTy().equals("N")) {
							bplc = FileUtil.readFile(MAIL_FORM_PATH + "mail_ordr_bplc.html");
							bplc = bplc.replace("{bplcNm}", ordrVO.getOrdrDtlList().get(i).getBplcInfo().getBplcNm());
							bplc = bplc.replace("{telno}", ordrVO.getOrdrDtlList().get(i).getBplcInfo().getTelno());
							bplc = bplc.replace("{dlvyPc}",
									numberFormat.format((ordrVO.getOrdrDtlList().get(i).getDlvyAditAmt()
											+ ordrVO.getOrdrDtlList().get(i).getDlvyBassAmt())));
							base_html = base_html.replace("{bplc}", bplc);
						} else {
							base_html = base_html.replace("{bplc}", "");
						}

						base_reset = base_html;
					}

					if(ordrVO.getOrdrDtlList().get(i).getOrdrOptnTy().equals("ADIT")) {
						// ADIT
						adit_reset = "";
						String adit_html = FileUtil.readFile(MAIL_FORM_PATH + "mail_ordr_gds_optn.html");
						adit_html = adit_html.replace("{optnNm}", ordrVO.getOrdrDtlList().get(i).getOrdrOptn());
						adit_html = adit_html.replace("{optnQy}", EgovStringUtil.integer2string(ordrVO.getOrdrDtlList().get(i).getOrdrQy()));
						adit_html = adit_html.replace("{optnPc}", numberFormat.format(ordrVO.getOrdrDtlList().get(i).getOrdrOptnPc()));

						adit_reset = adit_html;
					}


					if(i == (ordrVO.getOrdrDtlList().size()-1)) {

						if(ordrVO.getOrdrDtlList().get(i).getOrdrOptnTy().equals("BASE")) {

							base += base_reset;
							base = base.replace("{aditOptn}", "");
						}else {
							adit += adit_reset;
							base = base.replace("{aditOptn}",adit);
						}
						last += base;

						mailForm = mailForm.replace("{gdsView}", last);
					}else {
						if(ordrVO.getOrdrDtlList().get(i).getOrdrOptnTy().equals("BASE")) {
							base += base_reset;
						}else {
							adit += adit_reset;
						}
					}


				}

				// 배송 정보
				mailForm = mailForm.replace("{recptrNm}", ordrVO.getRecptrNm()); // 받는사람
				mailForm = mailForm.replace("{dpstTermDt}", ordrVO.getDpstTermDt()); // 입금기한
				mailForm = mailForm.replace("{zip}", ordrVO.getRecptrZip()); // 지번
				mailForm = mailForm.replace("{addr}", ordrVO.getRecptrAddr() + ordrVO.getRecptrDaddr()); // 주소

				// 결제 정보
				int totalGdsPc = 0; // 총 상품 금액 (상품 가격 * 수량)
				int dlvyPc = 0; // 배송비
				int couponAmt = 0; // 쿠폰 할인

				int mlg = ordrVO.getUseMlg(); // 마일리지
				int point = ordrVO.getUsePoint(); // 포인트

				for (OrdrDtlVO ordrDtlVO : ordrVO.getOrdrDtlList()) {
					if(ordrDtlVO.getOrdrOptnTy().equals("BASE")) {
						totalGdsPc += (ordrDtlVO.getGdsPc() * ordrDtlVO.getOrdrQy());
					}else {
						totalGdsPc += (ordrDtlVO.getOrdrOptnPc() * ordrDtlVO.getOrdrQy());
					}
					dlvyPc += (ordrDtlVO.getDlvyBassAmt() + ordrDtlVO.getDlvyAditAmt());
					couponAmt += ordrDtlVO.getCouponAmt();
				}

				mailForm = mailForm.replace("{totalOrdrPc}", numberFormat.format(totalGdsPc));
				mailForm = mailForm.replace("{dlvyPc}", numberFormat.format(dlvyPc));
				mailForm = mailForm.replace("{couponAmt}", numberFormat.format(couponAmt + mlg + point));

				mailForm = mailForm.replace("{stlmAmt}", numberFormat.format(ordrVO.getStlmAmt())); // 결제금액

				mailForm = mailForm.replace("{bank}", ordrVO.getDpstBankNm()); // 은행
				mailForm = mailForm.replace("{actno}", ordrVO.getVrActno()); // 계좌번호
				mailForm = mailForm.replace("{dsptDt}", ordrVO.getDpstTermDt().substring(0, 16)); // 입금기한

				// 메일 발송
				String mailSj = "[EROUM] 회원님의 주문이 접수 되었습니다.";
				if (EgovStringUtil.equals("real", activeMode)) {
					mailService.sendMail(sendMail, ordrVO.getOrdrrEml(), mailSj, mailForm);
				} else if (EgovStringUtil.equals("dev", activeMode)) {
					mailService.sendMail(sendMail, ordrVO.getOrdrrEml(), mailSj, mailForm);
				} else {
					mailService.sendMail(sendMail, "gyoh@icubesystems.co.kr", mailSj, mailForm); // 테스트
				}
			} else {
				System.out.println("사용자 상품 주문 접수 알림 EMAIL 전송 실패 :: 이메일 체크 " + ordrVO.getOrdrrEml());
			}
		} catch (Exception e) {
			System.out.println("사용자 상품 주문 접수 알림 EMAIL 전송 실패 :: " + e.toString());
		}

		model.addAttribute("ordrVO", ordrVO);

		// 코드 정보
		model.addAttribute("gdsTyCode", CodeMap.GDS_TY);
		model.addAttribute("ordrSttsCode", CodeMap.ORDR_STTS);
		model.addAttribute("bassStlmTyCode", CodeMap.BASS_STLM_TY);

		return "/market/ordr/ordr_pay_done";
	}

}
