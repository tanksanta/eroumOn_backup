package icube.market.ordr;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.egovframe.rte.fdl.string.EgovStringUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.View;

import icube.common.api.biz.BiztalkOrderService;
import icube.common.api.biz.BootpayApiService;
import icube.common.api.biz.UpdateBplcInfoApiService;
import icube.common.framework.abst.CommonAbstractController;
import icube.common.framework.view.JavaScript;
import icube.common.framework.view.JavaScriptView;
import icube.common.mail.MailForm2Service;
import icube.common.mail.MailFormService;
import icube.common.util.Base64Util;
import icube.common.util.DateUtil;
import icube.common.util.LoginUtil;
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
import icube.manage.promotion.point.biz.MbrPointService;
import icube.manage.sysmng.entrps.biz.EntrpsService;
import icube.manage.sysmng.entrps.biz.EntrpsVO;
import icube.market.mbr.biz.MbrSession;
import icube.market.ordr.biz.DlvyCtAditRgnService;
import icube.membership.info.biz.DlvyService;
import icube.membership.info.biz.DlvyVO;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

@Controller
@RequestMapping(value = "#{props['Globals.Market.path']}/ordr")
public class OrdrController extends CommonAbstractController{

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

	@Resource(name = "mailFormService")
	private MailFormService mailFormService;

	@Resource(name = "mailForm2Service")
	private MailForm2Service mailForm2Service;

	@Resource(name = "biztalkOrderService")
	private BiztalkOrderService biztalkOrderService;
	

	@Resource(name = "updateBplcInfoApiService")
	private UpdateBplcInfoApiService updateBplcInfoApiService;

	@Resource(name = "recipterInfoService")
	private RecipterInfoService recipterInfoService;

	@Resource(name = "entrpsService")
	private EntrpsService entrpsService;

	@Resource(name = "dlvyCtAditRgnService")
	private DlvyCtAditRgnService dlvyCtAditRgnService;

	@Value("#{props['Globals.Market.path']}")
	private String marketPath;

	@Value("#{props['Globals.Membership.path']}")
	private String membershipPath;

	@Autowired
	private MbrSession mbrSession;

	/**
	 * 급여 주문 > 사업소 요청
	 */
	@RequestMapping(value = "ordrRqst")
	public String ordrRqst(OrdrVO ordrVO
			, @RequestParam(value = "ordrTy", required = true) String ordrTy
			, @RequestParam(value = "gdsNo", required = true) String gdsNo
			, @RequestParam(value = "gdsCd", required = true) String gdsCd
			, @RequestParam(value = "bnefCd", required = true) String bnefCd
			, @RequestParam(value = "gdsNm", required = true) String gdsNm
			, @RequestParam(value = "gdsPc", required = true) String gdsPc

			, @RequestParam(value = "ordrOptnTy", required = true) String ordrOptnTy
			, @RequestParam(value = "ordrOptn", required = true) String ordrOptn
			, @RequestParam(value = "ordrOptnPc", required = true) String ordrOptnPc
			, @RequestParam(value = "ordrQy", required = true) String ordrQy

			, @RequestParam(value = "recipterUniqueId", required = false) String recipterUniqueId
			, @RequestParam(value = "bplcUniqueId", required = false) String bplcUniqueId

			, @RequestParam Map<String, Object> reqMap
			, HttpServletRequest request
			, HttpServletResponse response
			, HttpSession session
			, Model model
			) throws Exception {

		// STEP.1 로그인 체크
		if (!mbrSession.isLoginCheck()) {
			return "redirect:/" + membershipPath + "/login";
		}

		// STEP.2 주문코드 생성 (O 2 1014 1041 00 000)
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
			ordrDtlVO.setRecipterUniqueId(mbrSession.getUniqueId());
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
	public String cartRqst(
			@RequestParam(value = "cartGrpNos", required = true) String cartGrpNos
			, @RequestParam(value = "cartTy", required = true) String cartTy
			, @RequestParam Map<String, Object> reqMap
			, HttpServletRequest request
			, HttpServletResponse response
			, HttpSession session
			, Model model
			) throws Exception {

		// STEP.1 로그인 체크
		if (!mbrSession.isLoginCheck()) {
			return "redirect:/" + membershipPath + "/login";
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
	public View ordrRqstAction(OrdrVO ordrVO
			, @RequestParam(value = "ordrDtlCd", required = true) String ordrDtlCd
			, @RequestParam(value = "gdsNo", required = true) String gdsNo
			, @RequestParam(value = "gdsCd", required = true) String gdsCd
			, @RequestParam(value = "bnefCd", required = true) String bnefCd
			, @RequestParam(value = "gdsNm", required = true) String gdsNm
			, @RequestParam(value = "gdsPc", required = true) String gdsPc

			, @RequestParam(value = "ordrOptnTy", required = true) String ordrOptnTy
			, @RequestParam(value = "ordrOptn", required = true) String ordrOptn
			, @RequestParam(value = "ordrOptnPc", required = true) String ordrOptnPc
			, @RequestParam(value = "ordrQy", required = true) String ordrQy
			, @RequestParam(value = "ordrPc", required = true) String ordrPc

			, @RequestParam Map<String, Object> reqMap
			, HttpServletRequest request
			, HttpServletResponse response
			, HttpSession session
			, Model model
			) throws Exception {

		JavaScript javaScript = new JavaScript();

		// STEP.1 로그인 체크
		if (!mbrSession.isLoginCheck()) {
			javaScript.setLocation("/" + membershipPath + "/login");
			return new JavaScriptView(javaScript);
		}

		//double-submit-preventer
		if (EgovDoubleSubmitHelper.checkAndSaveToken("preventTokenKey", request)) {
			try {
				//급여 주문
				List<OrdrDtlVO> ordrDtlList = ordrService.insertOrdrForRecipter(ordrVO, reqMap, request);

				model.addAttribute("ordrDtlList", ordrDtlList);
				model.addAttribute("gdsTyCode", CodeMap.GDS_TY);

				javaScript.setLocation("/" + marketPath + "/ordr/ordrRqstDone/" + ordrVO.getOrdrCd());
				return new JavaScriptView(javaScript);
			} catch (Exception ex) {

				String msg = ex.getMessage();
				if (EgovStringUtil.isEmpty(msg)) {
					msg = "주문 요청에 실패하였습니다.";
				}

				javaScript.setMessage(msg);
				javaScript.setMethod("history.go(-2)");
				return new JavaScriptView(javaScript);
			}
		} else {
			javaScript.setLocation("/" + marketPath);
			return new JavaScriptView(javaScript);
		}
	}

	/**
	 * 급여 주문 > 사업소 요청 완료
	 */
	@RequestMapping(value = "ordrRqstDone/{ordrCd}")
	public String ordrRqstDone(
			@PathVariable String ordrCd
			, @RequestParam Map<String, Object> reqMap
			, HttpServletRequest request
			, HttpServletResponse response
			, HttpSession session
			, Model model
		) throws Exception {

		// STEP.1 로그인 체크
		if (!mbrSession.isLoginCheck()) {
			return "redirect:/" + membershipPath + "/login";
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
	// @RequestMapping(value = "ordrPay")
	// public String ordrPayment(
	// 		OrdrVO ordrVO
	// 		, @RequestParam(value = "ordrTy", required = true) String ordrTy
	// 		, @RequestParam(value = "gdsNo", required = true) String gdsNo
	// 		, @RequestParam(value = "gdsCd", required = true) String gdsCd
	// 		, @RequestParam(value = "bnefCd", required = true) String bnefCd
	// 		, @RequestParam(value = "gdsNm", required = true) String gdsNm
	// 		, @RequestParam(value = "gdsPc", required = true) String gdsPc

	// 		, @RequestParam(value = "ordrOptnTy", required = true) String ordrOptnTy
	// 		, @RequestParam(value = "ordrOptn", required = true) String ordrOptn
	// 		, @RequestParam(value = "ordrOptnPc", required = true) String ordrOptnPc
	// 		, @RequestParam(value = "ordrQy", required = true) String ordrQy

	// 		, @RequestParam(value = "recipterUniqueId", required = false) String recipterUniqueId
	// 		, @RequestParam(value = "bplcUniqueId", required = false) String bplcUniqueId
	// 		, @RequestParam Map<String, Object> reqMap

	// 		, HttpServletRequest request
	// 		, RedirectAttributes redirectAttributes
	// 		, HttpServletResponse response
	// 		, HttpSession session
	// 		, Model model
	// 	) throws Exception {

	// 	// STEP.1 로그인 체크
	// 	if (!mbrSession.isLoginCheck()) {
	// 		LoginUtil.loginRedirectValue(redirectAttributes, request.getServletPath(), reqMap, true);
	// 		return "redirect:/" + membershipPath + "/login";
	// 	}

	// 	//주문정보 계산을 위해 카트 객체로 변환
	// 	List<CartVO> cartList = new ArrayList<>();
	// 	String[] spGdsNo = gdsNo.split(",");
	// 	for (int i = 0; i < spGdsNo.length; i++) {

	// 		CartVO cartVO = new CartVO();
	// 		cartVO.setGdsNo(EgovStringUtil.string2integer(gdsNo.split(",")[i].trim()));
	// 		cartVO.setGdsCd(gdsCd.split(",")[i].trim());
	// 		if (bnefCd.split(",").length > 0) { // bnefCd null일수 있음
	// 			cartVO.setBnefCd(bnefCd.split(",")[i].trim());
	// 		} else {
	// 			cartVO.setBnefCd("");
	// 		}
	// 		cartVO.setGdsNm(gdsNm.split(",")[i].trim());
	// 		cartVO.setGdsPc(EgovStringUtil.string2integer(gdsPc.split(",")[i].trim()));
	// 		cartVO.setOrdrOptnTy(ordrOptnTy.split(",")[i].trim());
	// 		cartVO.setOrdrOptn(ordrOptn.split(",")[i].trim());
	// 		cartVO.setOrdrOptnPc(EgovStringUtil.string2integer(ordrOptnPc.split(",")[i].trim()));
	// 		cartVO.setOrdrQy(EgovStringUtil.string2integer(ordrQy.split(",")[i].trim()));
	// 		cartVO.setRecipterUniqueId(mbrSession.getUniqueId());
	// 		cartVO.setBplcUniqueId(bplcUniqueId);

	// 		int ordrPc = (cartVO.getGdsPc() + cartVO.getOrdrOptnPc()) * cartVO.getOrdrQy();
	// 		cartVO.setOrdrPc(ordrPc);
			
	// 		//상품 정보 조회
	// 		GdsVO gdsVO = gdsService.selectGds(cartVO.getGdsNo());
	// 		cartVO.setGdsInfo(gdsVO);
			
	// 		cartList.add(cartVO);
	// 	}
		
	// 	//주문정보 model에 담기
	// 	getOrderDetailListForPay(ordrTy, cartList, model);
		
	// 	return "/market/ordr/ordr_pay";
	// }

	/**
	 * 비급여 주문 > 장바구니
	 */
	@RequestMapping(value = {"cartPay", "ordrPay"})
	public String cartPay(
			@RequestParam(value = "cartGrpNos", required = true) String cartGrpNos
			, @RequestParam(value = "cartTy", required = true) String cartTy
			, @RequestParam Map<String, Object> reqMap
			, HttpServletRequest request
			, RedirectAttributes redirectAttributes
			, HttpServletResponse response
			, HttpSession session
			, Model model
		) throws Exception {

		// STEP.1 로그인 체크
		if (!mbrSession.isLoginCheck()) {
			LoginUtil.loginRedirectValue(redirectAttributes, request.getServletPath(), reqMap, true);
			return "redirect:/" + membershipPath + "/login";
		}

		// STEP.2 장바구니 호출
		String[] arrCartGrpNo = cartGrpNos.split(",");
		Map<String, Object> paramMap = new HashMap<String, Object>();
		paramMap.put("srchCartGrpNos", arrCartGrpNo);

		List<CartVO> cartList = cartService.selectCartListAll(paramMap);

		//주문정보 model에 담기
		getOrderDetailListForPay(cartTy, cartList, model);
		
		model.addAttribute("cartGrpNos", cartGrpNos);

		return "/market/ordr/ordr_pay";
	}

	// 상품주문 결제
	@RequestMapping(value = "ordrPayAction")
	public String ordrPayAction(OrdrVO ordrVO
			, @RequestParam(value = "ordrDtlCd", required = true) String ordrDtlCd
			, @RequestParam(value = "gdsNo", required = true) String gdsNo
			, @RequestParam(value = "gdsCd", required = true) String gdsCd
			, @RequestParam(value = "bnefCd", required = true) String bnefCd
			, @RequestParam(value = "gdsNm", required = true) String gdsNm
			, @RequestParam(value = "gdsPc", required = true) String gdsPc
			, @RequestParam(value = "ordrOptnTy", required = true) String ordrOptnTy
			, @RequestParam(value = "ordrOptn", required = true) String ordrOptn
			, @RequestParam(value = "ordrOptnPc", required = true) String ordrOptnPc
			, @RequestParam(value = "ordrQy", required = true) String ordrQy
			, @RequestParam(value = "ordrPc", required = true) String ordrPc
			, @RequestParam(value = "stlmKnd", required = true) String stlmKnd
			, @RequestParam Map<String, Object> reqMap
			, HttpServletRequest request
			, RedirectAttributes redirectAttributes
			, HttpServletResponse response
			, HttpSession session
			, Model model) throws Exception {

		// STEP.1 로그인 체크
		if (!mbrSession.isLoginCheck()) {
			LoginUtil.loginRedirectValue(redirectAttributes, request.getServletPath(), reqMap, true);
			return "redirect:/" + membershipPath + "/login";
		}

		// doubleSubmit check
		if (EgovDoubleSubmitHelper.checkAndSaveToken("preventTokenKey", request)) {

			String ordrMailTy = "MAILSEND_ORDR_MARKET_PAYDONE_"+stlmKnd;
			String ordrBiztalkTy = "BIZTALKSEND_ORDR_MARKET_PAYDONE_"+stlmKnd;
			
			List<OrdrDtlVO> ordrDtlList = ordrService.insertOrdr(ordrVO, reqMap, request);

			ordrVO = ordrService.selectOrdrByCd(ordrVO.getOrdrCd());

			biztalkOrderService.sendOrdr(ordrBiztalkTy, mbrSession, ordrVO);
			mailForm2Service.sendMailOrder(ordrMailTy, mbrSession, ordrVO);
			// String mailHtml = "mail_ordr.html";
			// String mailSj = "[이로움ON] 회원님의 주문이 접수 되었습니다.";
			// mailFormService.makeMailForm(ordrVO, null, mailHtml, mailSj);


			model.addAttribute("ordrDtlList", ordrDtlList);
			model.addAttribute("gdsTyCode", CodeMap.GDS_TY);

		}else {
			return "redirect:/" + marketPath;
		}

		return "redirect:/" + marketPath + "/ordr/ordrPayDone/" + ordrVO.getOrdrCd();
	}

	@RequestMapping(value = "ordrPayDone/{ordrCd}")
	public String ordrPayDone(
			@PathVariable String ordrCd
			, @RequestParam Map<String, Object> reqMap
			, HttpServletRequest request
			, HttpServletResponse response
			, HttpSession session
			, Model model
		) throws Exception {

		// STEP.1 로그인 체크
		if (!mbrSession.isLoginCheck()) {
			return "redirect:/" + membershipPath + "/login";
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

		if(!ordrVO.getOrdrTy().equals("N")) {
			updateBplcInfoApiService.putStlmYnSttus(dataMap);
		}

		// 주문완료 이메일
		/*String mailHtml = "mail_ordr.html";
		String mailSj = "[이로움ON] 회원님의 주문이 접수 되었습니다.";
		mailFormService.makeMailForm(ordrVO, mailHtml, mailSj);*/

		model.addAttribute("ordrVO", ordrVO);

		// 코드 정보
		model.addAttribute("gdsTyCode", CodeMap.GDS_TY);
		model.addAttribute("ordrSttsCode", CodeMap.ORDR_STTS);
		model.addAttribute("bassStlmTyCode", CodeMap.BASS_STLM_TY);

		return "/market/ordr/ordr_pay_done";
	}

	
	/**
	 * 결제 직전 화면에서 호출(model에 데이터를 담음)
	 * 바로 구매하기, 장바구니 구매하기 시 상품 및 배송비 계산 로직 함수
	 */
	private void getOrderDetailListForPay(String cartTy, List<CartVO> cartList, Model model) throws Exception {
		// 주문코드 생성 (O 22 1014 1041 00 000)
		String ordrCd = "O" + DateUtil.getCurrentDateTime("yyMMddHHmmssSS").substring(1);

		OrdrVO ordrVO = new OrdrVO();
		ordrVO.setOrdrCd(ordrCd);
		ordrVO.setOrdrTy(cartTy);
		
		
		//입점업체 정보
		Map<Integer, Boolean> entrpsFirstCheckMap = new HashMap<>();
		List<EntrpsVO> entrpsList = entrpsService.selectEntrpsListAll(new HashMap<>());
		
		
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
		

		// 도서산간지역 배송지역 체크
		int aditCt = dlvyCtAditRgnService.selectDlvyCtAditRgnCnt(bassDlvyVO.getZip());
		log.debug("@@ 도서산간지역 체크: " + aditCt);
		
		
		// STEP.3 주문 상세 정보
		List<OrdrDtlVO> ordrDtlList = new ArrayList<OrdrDtlVO>();
		for (CartVO cartVO : cartList) {
			OrdrDtlVO ordrDtlVO = new OrdrDtlVO();
			ordrDtlVO.setGdsNo(cartVO.getGdsNo());
			ordrDtlVO.setGdsCd(cartVO.getGdsCd());
			ordrDtlVO.setBnefCd(cartVO.getBnefCd());
			ordrDtlVO.setGdsNm(cartVO.getGdsNm());
			ordrDtlVO.setGdsPc(cartVO.getGdsPc());
			ordrDtlVO.setGdsOptnNo(cartVO.getGdsOptnNo());
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
			// 산간지역 체크
			if(aditCt>0) {
				gdsVO.setDlvyAditAmt(aditCt); //도서산간 배송비
			}else {
				gdsVO.setDlvyAditAmt(0); //0원
			}
			ordrDtlVO.setGdsInfo(gdsVO);

			
			//상품에 입점업체 정보가 있는지 체크
			boolean isCheckEntrps = true;
			if (gdsVO.getEntrpsNo() == 0) {
				isCheckEntrps = false;
			}
			
			
			//배송비 무료조건에 부합하는지 검사
			EntrpsVO entrpsVO = entrpsList.stream().filter(e -> e.getEntrpsNo() == gdsVO.getEntrpsNo()).findAny().orElse(null);
			if (isCheckEntrps) {
				//선택된 상품중 같은 입점업체 상품 가격 합
				int checkedGdsPrice = cartList.stream().filter(c -> c.getGdsInfo().getEntrpsNo() == gdsVO.getEntrpsNo()).mapToInt(c -> c.getOrdrPc()).sum();
				if (checkedGdsPrice >= entrpsVO.getDlvyCtCnd()) {
					//배송비 무료처리
                	gdsVO.setDlvyBassAmt(0);
                	gdsVO.setDlvyAditAmt(0);
					isCheckEntrps = false;
				}
			}
			
			
			// 20231016 : 장바구니에서 넘어온경우 묶음 배송처리 체크해야함
			//묶음 배송 처리
			if (isCheckEntrps && entrpsVO != null && "Y".equals(gdsVO.getDlvyGroupYn())) {
				int dlvyBaseCt = entrpsVO.getDlvyBaseCt(); //입점업체 기본 배송료

                //입점업체에 기본 배송비가 아니면 부과(묶음상품 제외)
				//int checkDlvyCy = gdsVO.getDlvyBassAmt() + gdsVO.getDlvyAditAmt();
				int checkDlvyCy = gdsVO.getDlvyBassAmt(); //도서산간 > gdsVO.getDlvyAditAmt();
                if (checkDlvyCy != dlvyBaseCt) {
                }
                //묶음상품이여도 최초에 한번 배송비 부과
                else if (!entrpsFirstCheckMap.containsKey(gdsVO.getEntrpsNo())) {
					entrpsFirstCheckMap.put(gdsVO.getEntrpsNo(), true);
				}
                else {
                	//묶음상품 배송비 무료처리
                	gdsVO.setDlvyBassAmt(0);
                	gdsVO.setDlvyAditAmt(0);
                }
			}


			// 사업소 정보 > 바로 구매는 사업소가 없음
//			BplcVO bplcVO = new BplcVO();
//			ordrDtlVO.setBplcInfo(bplcVO);

			ordrDtlList.add(ordrDtlVO);
		}
		
		model.addAttribute("bassDlvyVO", bassDlvyVO);
		model.addAttribute("ordrDtlList", ordrDtlList);

		// STEP4. 기타정보
		model.addAttribute("gdsTyCode", CodeMap.GDS_TY);
		model.addAttribute("ordrVO", ordrVO);
		
		//쿠폰, 마일리지, 포인트 정보
		Map<String, Object> mbrEtcInfoMap = mbrService.selectMbrEtcInfo(mbrSession.getUniqueId());
		model.addAttribute("remindCouponCount", mbrEtcInfoMap.get("totalCoupon"));
		model.addAttribute("remindPoint", mbrEtcInfoMap.get("totalPoint"));
		model.addAttribute("remindMlg", mbrEtcInfoMap.get("totalMlg"));
	}
}
