package icube.manage.ordr.ordr;

import java.text.DecimalFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.StringJoiner;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.egovframe.rte.fdl.string.EgovDateUtil;
import org.egovframe.rte.fdl.string.EgovStringUtil;
import org.json.simple.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import icube.common.api.biz.BootpayApiService;
import icube.common.framework.abst.CommonAbstractController;
import icube.common.mail.MailService;
import icube.common.util.ArrayUtil;
import icube.common.util.FileUtil;
import icube.common.util.HtmlUtil;
import icube.common.util.ValidatorUtil;
import icube.common.util.WebUtil;
import icube.common.values.CodeMap;
import icube.common.vo.CommonListVO;
import icube.manage.gds.gds.biz.GdsService;
import icube.manage.gds.gds.biz.GdsVO;
import icube.manage.gds.optn.biz.GdsOptnService;
import icube.manage.gds.optn.biz.GdsOptnVO;
import icube.manage.ordr.chghist.biz.OrdrChgHistService;
import icube.manage.ordr.chghist.biz.OrdrChgHistVO;
import icube.manage.ordr.dtl.biz.OrdrDtlService;
import icube.manage.ordr.dtl.biz.OrdrDtlVO;
import icube.manage.ordr.ordr.biz.OrdrService;
import icube.manage.ordr.ordr.biz.OrdrVO;
import icube.manage.promotion.coupon.biz.CouponLstService;
import icube.manage.sysmng.dlvy.biz.DlvyCoMngService;
import icube.manage.sysmng.dlvy.biz.DlvyCoMngVO;
import icube.manage.sysmng.mngr.biz.MngrSession;
import kr.co.bootpay.Bootpay;
import kr.co.bootpay.model.request.Subscribe;
import kr.co.bootpay.model.request.User;

/**
 * ordrStts : 주문상태
 */
@Controller
@RequestMapping(value="/_mng/ordr")
public class MOrdrController extends CommonAbstractController {


	@Resource(name = "ordrService")
	private OrdrService ordrService;

	@Resource(name = "ordrDtlService")
	private OrdrDtlService ordrDtlService;

	@Resource(name = "ordrChgHistService")
	private OrdrChgHistService ordrChgHistService;

	@Resource(name = "gdsService")
	private GdsService gdsService;

	@Resource(name = "couponLstService")
	private CouponLstService couponLstService;

	@Resource(name = "gdsOptnService")
	private GdsOptnService gdsOptnService;

	@Resource(name = "dlvyCoMngService")
	private DlvyCoMngService dlvyCoMngService;

	@Resource(name= "bootpayApiService")
	private BootpayApiService bootpayApiService;

	@Resource(name="mailService")
	private MailService mailService;

	@Value("#{props['Mail.Form.FilePath']}")
	private String mailFormFilePath;

	@Value("#{props['Mail.Username']}")
	private String sendMail;

	@Value("#{props['Profiles.Active']}")
	private String activeMode;

	@Value("#{props['Bootpay.Script.Key']}")
	private String bootpayScriptKey;

	@Value("#{props['Bootpay.Private.Key']}")
	private String bootpayPrivateKey;

	@Value("#{props['Bootpay.Rest.Key']}")
	private String bootpayRestKey;

	@Autowired
	private MngrSession mngrSession;


	// Page Parameter Keys
	private static String[] targetParams = {"curPage", "cntPerPage", "srchTarget", "srchText", "sortBy"
											, "srchSttsTy", "srchOrdrYmdBgng", "srchOrdrYmdEnd", "srchOrdrrNm", "srchRecptrNm", "srchOrdrTy", "srchStlmTy", "srchGdsCd", "srchGdsNm"};

    // 리스트
	@RequestMapping(value="{ordrStts}/list")
	public String list(
			@PathVariable String ordrStts
			, HttpServletRequest request
			, Model model) throws Exception {

		CommonListVO listVO = new CommonListVO(request);
		listVO.setParam("ordrSttsTy", ordrStts.toUpperCase());
		listVO = ordrService.ordrListVO(listVO);

		model.addAttribute("gdsTyCode", CodeMap.GDS_TY);
		model.addAttribute("bassStlmTyCode", CodeMap.BASS_STLM_TY);
		model.addAttribute("ordrSttsCode", CodeMap.ORDR_STTS);
		model.addAttribute("ordrCancelTyCode", CodeMap.ORDR_CANCEL_TY);

		model.addAttribute("listVO", listVO);
		model.addAttribute("ordrSttsTy", ordrStts.toUpperCase());

		return "/manage/ordr/list";
	}


	// 주문상세정보
	@RequestMapping(value="include/ordrDtlView")
	public String ordrDtlView(
			@RequestParam(value="ordrCd", required=true) String ordrCd
			, @RequestParam Map<String,Object> reqMap
			, Model model) throws Exception {


		// 주문정보
		OrdrVO ordrVO = ordrService.selectOrdrByCd(ordrCd);

		// 택배사
		Map<String, Object> paramMap = new HashMap<String, Object>();
		paramMap.put("srchYn", "Y"); // TO-DO : srchYn -> srchUseYn
		List<DlvyCoMngVO> dlvyCoList = dlvyCoMngService.selectDlvyCoListAll(paramMap);
		model.addAttribute("dlvyCoList", dlvyCoList);


		// result
		model.addAttribute("recipterYnCode", CodeMap.RECIPTER_YN);
		model.addAttribute("gradeCode", CodeMap.GRADE);
		model.addAttribute("bassStlmTyCode", CodeMap.BASS_STLM_TY);
		model.addAttribute("bankTyCode", CodeMap.BANK_TY);
		model.addAttribute("ordrCancelTyCode", CodeMap.ORDR_CANCEL_TY);

		model.addAttribute("gdsTyCode", CodeMap.GDS_TY);
		model.addAttribute("ordrSttsCode", CodeMap.ORDR_STTS);

		model.addAttribute("ordrVO", ordrVO);
		model.addAttribute("_bootpayScriptKey", bootpayScriptKey);

		return "/manage/ordr/include/ordr_dtl";
	}

	// 상품옵션
	@RequestMapping(value="include/optnChg")
	public String optnChg(
			@RequestParam(value="ordrDtlNo", required=true) int ordrDtlNo
			, @RequestParam(value="ordrDtlCd", required=true) String ordrDtlCd
			, @RequestParam(value="gdsNo", required=true) int gdsNo
			, @RequestParam Map<String,Object> reqMap
			, Model model) throws Exception {


		/* 상품 1
		OrdrDtlVO ordrDtlVO = ordrDtlService.selectOrdrDtl(ordrDtlNo);
		model.addAttribute("ordrDtlVO", ordrDtlVO);
		*/

		/* 상품 1 +추가옵션 상품*/
		List<OrdrDtlVO> ordrDtlList = ordrDtlService.selectOrdrDtlList(ordrDtlCd);
		model.addAttribute("ordrDtlList", ordrDtlList);
		model.addAttribute("ordrDtlCd", ordrDtlCd);


		GdsVO gdsVO = gdsService.selectGds(gdsNo);
		// 상품옵션 set
		List<String> optnVal1 = new ArrayList<String>()
				, optnVal2 = new ArrayList<String>()
				, optnVal3 = new ArrayList<String>();
		for(GdsOptnVO gdsoOtnVO : gdsVO.getOptnList()) {
			String[] optnVal = gdsoOtnVO.getOptnNm().split("[*]");
			//log.debug("optnVal.length" + optnVal.length);
			if(optnVal.length > 0 && !ArrayUtil.isContainsInList(optnVal1, optnVal[0].trim())) {
				optnVal1.add(optnVal[0].trim());
			}
			if(optnVal.length > 1 && !ArrayUtil.isContainsInList(optnVal2, optnVal[1].trim())) {
				optnVal2.add(optnVal[1].trim());
			}
			if(optnVal.length > 2 && !ArrayUtil.isContainsInList(optnVal3, optnVal[2].trim())) {
				optnVal3.add(optnVal[2].trim());
			}
		}
		String optnVal1Str = optnVal1.toString().replace("[", "").replace("]", "").replace(", ", ",");
		String optnVal2Str = optnVal2.toString().replace("[", "").replace("]", "").replace(", ", ",");
		String optnVal3Str = optnVal3.toString().replace("[", "").replace("]", "").replace(", ", ",");

		StringJoiner joiner = new StringJoiner("|");
		if(EgovStringUtil.isNotEmpty(optnVal1Str)) {
			joiner.add(optnVal1Str); }
		if(EgovStringUtil.isNotEmpty(optnVal2Str)) {
			joiner.add(optnVal2Str); }
		if(EgovStringUtil.isNotEmpty(optnVal3Str)) {
			joiner.add(optnVal3Str); }
		gdsVO.setOptnVal(joiner.toString());

		model.addAttribute("gdsVO", gdsVO);
		model.addAttribute("gdsTyCode", CodeMap.GDS_TY);

		return "/manage/ordr/include/ordr_optn_chg";
	}

	// 옵션변경 저장 1row = 1상품
	@ResponseBody
	@RequestMapping(value="optnChgSave.json")
	public Map<String, Object> optnChgSave(
			@RequestParam(value="ordrNo", required=true) String ordrNo
			, @RequestParam(value="ordrCd", required=true) String ordrCd
			, @RequestParam(value="ordrDtlNo", required=true) String ordrDtlNo
			, @RequestParam(value="ordrDtlCd", required=true) String ordrDtlCd

			, @RequestParam(value="gdsNo", required=true) String gdsNo
			, @RequestParam(value="gdsCd", required=true) String gdsCd
			, @RequestParam(value="bnefCd", required=true) String bnefCd
			, @RequestParam(value="gdsNm", required=true) String gdsNm
			, @RequestParam(value="gdsPc", required=true) String gdsPc

			, @RequestParam(value="ordrOptnTy", required=true) String ordrOptnTy
			, @RequestParam(value="ordrOptn", required=true) String ordrOptn
			, @RequestParam(value="ordrOptnPc", required=true) String ordrOptnPc
			, @RequestParam(value="ordrQy", required=true) String ordrQy

			, @RequestParam(value="recipterUniqueId", required=false) String recipterUniqueId
			, @RequestParam(value="bplcUniqueId", required=false) String bplcUniqueId

			, @RequestParam(value="sttsTy", required=true) String sttsTy
			, @RequestParam Map<String,Object> reqMap
			, HttpServletRequest request) throws Exception {

		boolean result = false;
		Integer resultCnt = 0;

		try {
			for(int i=0;i < ordrDtlNo.split(",").length;i++) {
				OrdrDtlVO ordrDtlVO = new OrdrDtlVO();
				ordrDtlVO.setOrdrNo(EgovStringUtil.string2integer(ordrNo.split(",")[i]));
				ordrDtlVO.setOrdrCd(ordrCd.split(",")[i]);
				ordrDtlVO.setOrdrDtlNo(EgovStringUtil.string2integer(ordrDtlNo.split(",")[i]));
				ordrDtlVO.setOrdrDtlCd(ordrDtlCd.split(",")[i]);
				ordrDtlVO.setGdsNo(EgovStringUtil.string2integer(gdsNo.split(",")[i]));
				ordrDtlVO.setGdsCd(gdsCd.split(",")[i]);
				if(bnefCd.split(",").length > 0) { // bnefCd null일수 있음
					ordrDtlVO.setBnefCd(bnefCd.split(",")[i]);
				}else {
					ordrDtlVO.setBnefCd("");
				}
				ordrDtlVO.setGdsNm(gdsNm.split(",")[i]);
				ordrDtlVO.setGdsPc(EgovStringUtil.string2integer(gdsPc.split(",")[i]));
				ordrDtlVO.setOrdrOptnTy(ordrOptnTy.split(",")[i]);
				ordrDtlVO.setOrdrOptn(ordrOptn.split(",")[i]);
				ordrDtlVO.setOrdrOptnPc(EgovStringUtil.string2integer(ordrOptnPc.split(",")[i]));
				ordrDtlVO.setOrdrQy(EgovStringUtil.string2integer(ordrQy.split(",")[i]));

				// 수혜자
				if(recipterUniqueId.split(",").length > 0) {
					ordrDtlVO.setRecipterUniqueId(recipterUniqueId.split(",")[i]);
				} else {
					ordrDtlVO.setRecipterUniqueId("");
				}

				// 사업소
				if(bplcUniqueId.split(",").length > 0) {
					ordrDtlVO.setBplcUniqueId(bplcUniqueId.split(",")[i]);
				} else {
					ordrDtlVO.setBplcUniqueId("");
				}

				ordrDtlVO.setSttsTy(sttsTy.split(",")[i]);

				int ordrPc = (ordrDtlVO.getGdsPc() +  ordrDtlVO.getOrdrOptnPc()) * ordrDtlVO.getOrdrQy();
				ordrDtlVO.setOrdrPc(ordrPc);

				resultCnt += ordrDtlService.modifyOptnChg(ordrDtlVO);
			}

			// 삭제
			String delOrdrDtlNo = WebUtil.clearSqlInjection((String) reqMap.get("delOrdrDtlNo"));
			String[] arrDelOrdrDtlNo = delOrdrDtlNo.split(",");
			if(arrDelOrdrDtlNo.length > 0) {
				ordrDtlService.deleteOrdrDtlByNos(arrDelOrdrDtlNo);
			}

			result = true;

			log.debug("resultCnt: " + resultCnt);

		} catch (Exception e) {
			result = false;
		}

		// result
		Map<String, Object> resultMap = new HashMap<String, Object>();
		resultMap.put("result", result);
		return resultMap;
	}


	// 주문취소 모달
	@RequestMapping(value="include/ordrRtrcn")
	public String ordrRtrcn(
			@RequestParam(value="ordrCd", required=true) String ordrCd
			, @RequestParam Map<String,Object> reqMap
			, Model model) throws Exception {

		// 주문정보
		OrdrVO ordrVO = ordrService.selectOrdrByCd(ordrCd);


		// result
		model.addAttribute("recipterYnCode", CodeMap.RECIPTER_YN);
		model.addAttribute("gradeCode", CodeMap.GRADE);
		model.addAttribute("bassStlmTyCode", CodeMap.BASS_STLM_TY);
		model.addAttribute("bankTyCode", CodeMap.BANK_TY);
		model.addAttribute("ordrCancelTyCode", CodeMap.ORDR_CANCEL_TY);

		model.addAttribute("gdsTyCode", CodeMap.GDS_TY);
		model.addAttribute("ordrSttsCode", CodeMap.ORDR_STTS);



		model.addAttribute("ordrVO", ordrVO);
		model.addAttribute("bankTyCode", CodeMap.BANK_TY);


		return "/manage/ordr/include/ordr_rtrcn";
	}

	/**
	 * 주문취소 접수
	 */
	@ResponseBody
	@RequestMapping(value="ordrRtrcnRcpt.json")
	public Map<String, Object> ordrRtrcnRcpt(
			@RequestParam(value="ordrNo", required=true) int ordrNo
			, @RequestParam(value="ordrDtlCds[]", required=true) String[] ordrDtlCds
			, @RequestParam(value="resnTy", required=true) String resnTy
			, @RequestParam(value="resn", required=false) String resn
			, @RequestParam(value="rfndBank", required=false) String rfndBank
			, @RequestParam(value="rfndActno", required=false) String rfndActno
			, @RequestParam(value="rfndDpstr", required=false) String rfndDpstr
			, @RequestParam Map<String,Object> reqMap) throws Exception {

		boolean result = false;

		// 주문 상세코드로 주문 상세번호를 가져온 뒤 처리
		HashSet<String> tmpOrdrDtlNos = new HashSet<>();
		for(String ordrDtlCd : ordrDtlCds) {
			List<OrdrDtlVO> ordrDtlList = ordrDtlService.selectOrdrDtlList(ordrDtlCd);
			for (OrdrDtlVO ordrDtlVO : ordrDtlList) {
				tmpOrdrDtlNos.add(EgovStringUtil.integer2string(ordrDtlVO.getOrdrDtlNo()));
			}
		}
		String[] ordrDtlNos = tmpOrdrDtlNos.toArray(new String[tmpOrdrDtlNos.size()]);

		OrdrDtlVO ordrDtlVO = new OrdrDtlVO();
		ordrDtlVO.setOrdrNo(ordrNo);
		ordrDtlVO.setOrdrDtlNos(ordrDtlNos);
		ordrDtlVO.setSttsTy("CA01");
		ordrDtlVO.setResnTy(resnTy);
		ordrDtlVO.setResn(resn);
		ordrDtlVO.setRegUniqueId(mngrSession.getUniqueId());
		ordrDtlVO.setRegId(mngrSession.getMngrId());
		ordrDtlVO.setRgtr(mngrSession.getMngrNm());
		ordrDtlVO.setRfndBank(rfndBank);
		ordrDtlVO.setRfndActno(rfndActno);
		ordrDtlVO.setRfndDpstr(rfndDpstr);

		Integer resultCnt = ordrDtlService.updateOrdrCA01(ordrDtlVO);
		if(resultCnt == 1){
			result = true;
		}

		// result
		Map<String, Object> resultMap = new HashMap<String, Object>();
		resultMap.put("result", result);
		return resultMap;
	}

	/**
	 * 주문취소 완료
	 * DTL_CD 그룹 전체 취소
	 */
	@ResponseBody
	@RequestMapping(value="ordrRtrcnSave.json")
	public Map<String, Object> ordrRtrcnSave(
			@RequestParam(value="ordrNo", required=true) int ordrNo
			, @RequestParam(value="ordrDtlCd", required=true) String ordrDtlCd
			, @RequestParam(value="resnTy", required=true) String resnTy
			, @RequestParam(value="resn", required=false) String resn
			, @RequestParam Map<String,Object> reqMap) throws Exception {

		boolean result = false;

		// 주문 상세코드로 주문 상세번호를 가져온 뒤 처리
		HashSet<String> tmpOrdrDtlNos = new HashSet<>();
		List<OrdrDtlVO> ordrDtlList = ordrDtlService.selectOrdrDtlList(ordrDtlCd);
		for (OrdrDtlVO ordrDtlVO : ordrDtlList) {
			tmpOrdrDtlNos.add(EgovStringUtil.integer2string(ordrDtlVO.getOrdrDtlNo()));
		}

		String[] ordrDtlNos = tmpOrdrDtlNos.toArray(new String[tmpOrdrDtlNos.size()]);

		OrdrDtlVO ordrDtlVO = new OrdrDtlVO();
		ordrDtlVO.setOrdrNo(ordrNo);
		ordrDtlVO.setOrdrDtlNos(ordrDtlNos);
		ordrDtlVO.setSttsTy("CA02");
		ordrDtlVO.setResnTy(resnTy);
		ordrDtlVO.setResn(resn);
		ordrDtlVO.setRegUniqueId(mngrSession.getUniqueId());
		ordrDtlVO.setRegId(mngrSession.getMngrId());
		ordrDtlVO.setRgtr(mngrSession.getMngrNm());

		Integer resultCnt = ordrDtlService.updateOrdrCA02(ordrDtlVO);
		if(resultCnt == 1){
			result = true;

			//이메일
			Date now = new Date();
			SimpleDateFormat  formatter = new SimpleDateFormat ("yyyy-MM-dd HH:mm:ss");
			DecimalFormat numberFormat = new DecimalFormat("###,###");

			OrdrVO ordrVO = ordrService.selectOrdrByNo(ordrNo);
			List<OrdrDtlVO> nowDtlList = ordrDtlService.selectOrdrDtlList(ordrDtlCd);

			try {
				if(ValidatorUtil.isEmail(ordrVO.getOrdrrEml())) {
					String MAIL_FORM_PATH = mailFormFilePath;
					String mailForm = FileUtil.readFile(MAIL_FORM_PATH+"mail_ordr_rfnd.html");

					mailForm = mailForm.replace("{mbrNm}", ordrVO.getOrdrrNm()); // 주문자
					mailForm = mailForm.replace("{ordrDt}", formatter.format(ordrVO.getOrdrDt())); // 주문일
					mailForm = mailForm.replace("{ordrCd}", ordrVO.getOrdrCd()); // 주문번호
					mailForm = mailForm.replace("{now_year}", formatter.format(now).substring(0, 4)); // 현재 년
					mailForm = mailForm.replace("{now_month}", formatter.format(now).substring(5, 7)); // 현재 월
					mailForm = mailForm.replace("{now_day}", formatter.format(now).substring(8, 10)); // 현재 일

					// 상품 정보 Start
					String last = "";
					String base = "";
					String adit = "";
					String base_reset = "";
					String adit_reset = "";
					String bplc = "";

					for (int i=0; i<nowDtlList.size(); i++) {

						// BASE
						if(nowDtlList.get(i).getOrdrOptnTy().equals("BASE")) {
							base = base.replace("{aditOptn}", "");
							base_reset = "";
							String base_html = FileUtil.readFile(MAIL_FORM_PATH + "mail_ordr_gds.html");
							base_html = base_html.replace("{gdsNm}", nowDtlList.get(i).getGdsNm());
							base_html = base_html.replace("{gdsOptnNm}", nowDtlList.get(i).getOrdrOptn());
							base_html = base_html.replace("{ordrQy}", EgovStringUtil.integer2string(nowDtlList.get(i).getOrdrQy()));
							base_html = base_html.replace("{ordrPc}", numberFormat.format(nowDtlList.get(i).getOrdrPc()));

							// 멤버스
							if (!ordrVO.getOrdrTy().equals("N")) {
								bplc = FileUtil.readFile(MAIL_FORM_PATH + "mail_ordr_bplc.html");
								bplc = bplc.replace("{bplcNm}", nowDtlList.get(i).getBplcInfo().getBplcNm());
								bplc = bplc.replace("{telno}", nowDtlList.get(i).getBplcInfo().getTelno());
								bplc = bplc.replace("{dlvyPc}",
										numberFormat.format((nowDtlList.get(i).getDlvyAditAmt()
												+ nowDtlList.get(i).getDlvyBassAmt())));
								base_html = base_html.replace("{bplc}", bplc);
							} else {
								base_html = base_html.replace("{bplc}", "");
							}

							base_reset = base_html;
						}

						if(nowDtlList.get(i).getOrdrOptnTy().equals("ADIT")) {
							// ADIT
							adit_reset = "";
							String adit_html = FileUtil.readFile(MAIL_FORM_PATH + "mail_ordr_gds_optn.html");
							adit_html = adit_html.replace("{optnNm}", nowDtlList.get(i).getOrdrOptn());
							adit_html = adit_html.replace("{optnQy}", EgovStringUtil.integer2string(nowDtlList.get(i).getOrdrQy()));
							adit_html = adit_html.replace("{optnPc}", numberFormat.format(nowDtlList.get(i).getOrdrOptnPc()));

							adit_reset = adit_html;
						}


						if(i == (nowDtlList.size()-1)) {

							if(nowDtlList.get(i).getOrdrOptnTy().equals("BASE")) {

								base += base_reset;
								base = base.replace("{aditOptn}", "");
							}else {
								adit += adit_reset;
								base = base.replace("{aditOptn}",adit);
							}
							last += base;

							mailForm = mailForm.replace("{gdsView}", last);
						}else {
							if(nowDtlList.get(i).getOrdrOptnTy().equals("BASE")) {
								base += base_reset;
							}else {
								adit += adit_reset;
							}
						}
					}

					// 결제 정보
					int totalGdsPc = 0; // 총 상품 금액 (상품 가격 * 수량)
					int dlvyPc = 0; // 배송비
					int  couponAmt = 0; // 쿠폰 할인
					int totalRfndAmt = 0; // 환불금액

					for(OrdrDtlVO nowDtlVO : nowDtlList) {
						totalGdsPc += (nowDtlVO.getOrdrPc() * nowDtlVO.getOrdrQy());
						dlvyPc += (nowDtlVO.getDlvyBassAmt() + nowDtlVO.getDlvyAditAmt());
						couponAmt += nowDtlVO.getCouponAmt();
						totalRfndAmt += nowDtlVO.getRfndAmt();
					}

					int mlg = ordrVO.getUseMlg(); // 마일리지
					int point = ordrVO.getUsePoint(); // 포인트

					Map<String, Object> paramMap = new HashMap<String, Object>();
					paramMap.put("ordrOptnTy", "BASE");
					paramMap.put("ordrCd", ordrVO.getOrdrCd());
					paramMap.put("sttsTy", "CA02");
					int lastObj = ordrDtlService.selectLastReturn(paramMap);

					if(lastObj == 1) {
						mailForm = mailForm.replace("{couponAmt}", numberFormat.format(couponAmt + mlg + point));
					}else {
						mailForm = mailForm.replace("{couponAmt}", numberFormat.format(couponAmt));
					}

					mailForm = mailForm.replace("{totalOrdrPc}", numberFormat.format(totalGdsPc));
					mailForm = mailForm.replace("{dlvyPc}", numberFormat.format(dlvyPc));
					mailForm = mailForm.replace("{stlmAmt}", numberFormat.format(totalRfndAmt)); // 결제금액

					String rfndCard = FileUtil.readFile(MAIL_FORM_PATH+"mail_rfnd_card.html");
					String rfndBank = FileUtil.readFile(MAIL_FORM_PATH+"mail_rfnd_bank.html");

					if(ordrVO.getStlmTy().equals("VBANK") || ordrVO.getStlmTy().equals("BANK")) {
						rfndBank = rfndBank.replace("{rfndTy}", "계좌이체");
						rfndBank = rfndBank.replace("{rfndAmt}", numberFormat.format(totalRfndAmt));
						rfndBank = rfndBank.replace("{rfndBank}", EgovStringUtil.null2string(nowDtlList.get(0).getRfndBank(), ""));
						rfndBank = rfndBank.replace("{actno}", EgovStringUtil.null2string(nowDtlList.get(0).getRfndActno(), ""));
						rfndBank = rfndBank.replace("{rfndNm}", ordrVO.getPyrNm());
						mailForm = mailForm.replace("{rfndInfo}", rfndBank);

					}else {
						rfndCard = rfndCard.replace("{rfndTy}", ordrVO.getCardCoNm());
						rfndCard = rfndCard.replace("{stlmAmt2}", ordrVO.getDpstTermDt());
						mailForm = mailForm.replace("{rfndInfo}", rfndCard);
					}


					// 메일 발송
					String mailSj = "[이로움ON] 회원님의 주문이 취소 되었습니다.";
					if(EgovStringUtil.equals("real", activeMode)) {
						mailService.sendMail(sendMail, ordrVO.getOrdrrEml(), mailSj, mailForm);
					}else if(EgovStringUtil.equals("dev", activeMode)) {
						mailService.sendMail(sendMail, ordrVO.getOrdrrEml(), mailSj, mailForm);
					}else {
						mailService.sendMail(sendMail, "gyoh@icubesystems.co.kr", mailSj, mailForm); //테스트
					}
				} else {
					System.out.println("사용자 상품 주문 취소 알림 EMAIL 전송 실패 :: 이메일 체크 " + ordrVO.getOrdrrEml());
				}
			} catch (Exception e) {
				System.out.println("사용자 상품 주문 취소 알림 EMAIL 전송 실패 :: " + e.toString());
			}
		}

		//쿠폰 사용 처리 취소
		for(String ordrDtlNo : ordrDtlNos) {
			OrdrDtlVO ordrrDtlVO = ordrDtlService.selectOrdrDtl(EgovStringUtil.string2integer(ordrDtlNo));
			String couponCd = ordrrDtlVO.getCouponCd();

			Map<String, Object> paramMap = new HashMap<String, Object>();
			paramMap.put("srchUseYn", "N");
			paramMap.put("srchCouponCd", couponCd);

			couponLstService.updateCouponUseYnNull(paramMap);
		}


		// result
		Map<String, Object> resultMap = new HashMap<String, Object>();
		resultMap.put("result", result);
		return resultMap;
	}


	// 배송정보 저장
	@ResponseBody
	@RequestMapping(value="dlvySave.json")
	public Map<String, Object> dlvySave(
			@RequestParam(value="ordrCd", required=true) String ordrCd
			, @RequestParam Map<String,Object> reqMap) throws Exception {

		boolean result = false;

		Integer resultCnt = ordrService.updateDlvyInfo(reqMap);
		if(resultCnt == 1){
			result = true;
		}

		// result
		Map<String, Object> resultMap = new HashMap<String, Object>();
		resultMap.put("result", result);
		return resultMap;
	}

	// 배송사+송장번호 저장 -> 배송중
	@ResponseBody
	@RequestMapping(value="dlvyCoSave.json")
	public Map<String, Object> dlvyCoSave(
			@RequestParam(value="ordrNo", required=true) int ordrNo
			//, @RequestParam(value="ordrDtlNo", required=true) int ordrDtlNo
			, @RequestParam(value="ordrDtlCd", required=true) String ordrDtlCd
			, @RequestParam(value="dlvyCo", required=true) String dlvyCo
			, @RequestParam(value="dlvyInvcNo", required=true) String dlvyInvcNo
			, @RequestParam Map<String,Object> reqMap) throws Exception {

		boolean result = false;

		ArrayList<String> tmpOrdrDtlNos = new ArrayList<String>();
		List<OrdrDtlVO> ordrDtlList = ordrDtlService.selectOrdrDtlList(ordrDtlCd);
		for (OrdrDtlVO ordrDtlVO : ordrDtlList) {
			tmpOrdrDtlNos.add(EgovStringUtil.integer2string(ordrDtlVO.getOrdrDtlNo()));
		}
		String[] ordrDtlNos = tmpOrdrDtlNos.toArray(new String[tmpOrdrDtlNos.size()]);
		String[] dlvyNm = dlvyCo.split("[|]");

		OrdrDtlVO ordrDtlVO = new OrdrDtlVO();
		ordrDtlVO.setOrdrNo(ordrNo);
		ordrDtlVO.setOrdrDtlCd(ordrDtlCd);
		ordrDtlVO.setOrdrDtlNos(ordrDtlNos);
		ordrDtlVO.setSttsTy("OR07");
		ordrDtlVO.setResnTy("");
		ordrDtlVO.setResn(dlvyNm[1] + " 송장번호 입력<br>["+ dlvyInvcNo +"]");
		ordrDtlVO.setRegUniqueId(mngrSession.getUniqueId());
		ordrDtlVO.setRegId(mngrSession.getMngrId());
		ordrDtlVO.setRgtr(mngrSession.getMngrNm());

		//배송사+송장번호 정보
		ordrDtlVO.setDlvyCoNo(EgovStringUtil.string2integer(dlvyNm[0]));
		ordrDtlVO.setDlvyCoNm(dlvyNm[1]);
		ordrDtlVO.setDlvyInvcNo(dlvyInvcNo);

		Integer resultCnt = ordrDtlService.updateOrdrOR07(ordrDtlVO);

		if(resultCnt == 1){
			result = true;
		}

		// result
		Map<String, Object> resultMap = new HashMap<String, Object>();
		resultMap.put("result", result);
		return resultMap;
	}


	// 주문확정(배송준비중 <-> 결제완료)
	@ResponseBody
	@RequestMapping(value="ordrConfrm.json")
	public Map<String, Object> ordrConfrm(
			@RequestParam(value="ordrNo", required=true) int ordrNo
			, @RequestParam(value="sttsTy", required=true) String sttsTy
			, @RequestParam(value="dtLNoList[]", required=true) String[] dtLNoList
			, @RequestParam(value="dtLCdList[]", required=true) String[] dtLCdList
			, @RequestParam(value="sndngDtList[]", required=true) String[] sndngDtList
			, @RequestParam Map<String,Object> reqMap) throws Exception {

		boolean result = false;
		Integer totalResultCnt = 0;

		for(int i=0; i < dtLCdList.length ; i++ ) {

			OrdrDtlVO ordrDtlVO = new OrdrDtlVO();
			ordrDtlVO.setOrdrNo(ordrNo);
			ordrDtlVO.setSttsTy(sttsTy);
			ordrDtlVO.setOrdrDtlNos(dtLNoList);
			ordrDtlVO.setOrdrDtlNo(EgovStringUtil.string2integer(dtLNoList[i]));
			ordrDtlVO.setOrdrDtlCd(dtLCdList[i]);

			if("OR06".equals(ordrDtlVO.getSttsTy())) {
				if(EgovStringUtil.isNotEmpty(sndngDtList[i])) {
					ordrDtlVO.setSndngDt(EgovDateUtil.dateFormatCheck(sndngDtList[i], "yyyy-MM-dd"));
				}else {
					ordrDtlVO.setSndngDt(null);
				}
			}else {
				ordrDtlVO.setSndngDt(null);
			}

			log.debug("ordrDtlVO>> " + ordrDtlVO.toString());

			Integer resultCnt = ordrDtlService.updateOrdrOR05OR06(ordrDtlVO);

			if(resultCnt == 1){
				String resn = "주문확정";
				if("OR05".equals(ordrDtlVO.getSttsTy())) {
					resn = "주문확정 취소";
				}
				ordrChgHistService.insertOrdrSttsChgHist(ordrDtlVO.getOrdrNo(), ordrDtlVO.getOrdrDtlNo(), "", resn, ordrDtlVO.getSttsTy());
				totalResultCnt += 1;
			}
		}

		if(totalResultCnt == dtLCdList.length){
			result = true;

			// 주문완료 이메일
			SimpleDateFormat  formatter = new SimpleDateFormat ("yyyy-MM-dd HH:mm:ss");
			DecimalFormat numberFormat = new DecimalFormat("###,###");

			OrdrVO ordrVO = ordrService.selectOrdrByNo(ordrNo);

			try {
				if(ValidatorUtil.isEmail(ordrVO.getOrdrrEml())) {
					String MAIL_FORM_PATH = mailFormFilePath;
					String mailForm = FileUtil.readFile(MAIL_FORM_PATH+"mail_ordr_confirm.html");

					mailForm = mailForm.replace("{mbrNm}", ordrVO.getOrdrrNm()); // 주문자
					mailForm = mailForm.replace("{ordrDt}", formatter.format(ordrVO.getOrdrDt())); // 주문일
					mailForm = mailForm.replace("{ordrCd}", ordrVO.getOrdrCd()); // 주문번호

					// 상품 정보 Start

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

					// 배송정보
					mailForm = mailForm.replace("{recptrNm}", ordrVO.getRecptrNm()); // 받는사람
					mailForm = mailForm.replace("{dpstTermDt}", ordrVO.getDpstTermDt()); // 입금기한
					mailForm = mailForm.replace("{zip}", ordrVO.getRecptrZip()); // 지번
					mailForm = mailForm.replace("{addr}", ordrVO.getRecptrAddr() + ordrVO.getRecptrDaddr()); // 주소

					// 결제 정보
					int totalGdsPc = 0; // 총 상품 금액 ((상품 가격 * 수량))
					int dlvyPc = 0; // 배송비
					int couponAmt = 0; // 쿠폰 할인

					int mlg = ordrVO.getUseMlg(); // 마일리지
					int point = ordrVO.getUsePoint(); // 포인트

					for(OrdrDtlVO ordrDtlVO : ordrVO.getOrdrDtlList()) {
						totalGdsPc += (ordrDtlVO.getOrdrPc() * ordrDtlVO.getOrdrQy());
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
					String mailSj = "[이로움ON] 회원님의 주문이 완료 되었습니다.";
					if(EgovStringUtil.equals("real", activeMode)) {
						mailService.sendMail(sendMail, ordrVO.getOrdrrEml(), mailSj, mailForm);
					}else if(EgovStringUtil.equals("dev", activeMode)) {
						mailService.sendMail(sendMail, ordrVO.getOrdrrEml(), mailSj, mailForm);
					}else {
						mailService.sendMail(sendMail, "gyoh@icubesystems.co.kr", mailSj, mailForm); //테스트
					}
				} else {
					System.out.println("사용자 상품 주문 완료 알림 EMAIL 전송 실패 :: 이메일 체크 " + ordrVO.getOrdrrEml());
				}
			} catch (Exception e) {
				System.out.println("사용자 상품 주문 완료 알림 EMAIL 전송 실패 :: " + e.toString());
			}

		}

		// result
		Map<String, Object> resultMap = new HashMap<String, Object>();
		resultMap.put("result", result);
		return resultMap;
	}



	/**
	 * 주문상태 변경 저장
	 * @param ordrDtlNos
	 * @param sttsTy
	 * @param reqMap
	 * @return
	 * @throws Exception

	@ResponseBody
	@RequestMapping(value="ordrSttsChgSave.json")
	public Map<String, Object> ordrSttsChgSave(
			@RequestParam(value="ordrNo", required=true) int ordrNo
			, @RequestParam(value="ordrDtlNo", required=false) int ordrDtlNo
			, @RequestParam(value="ordrDtlNos", required=false) String[] ordrDtlNos
			, @RequestParam(value="sttsTy", required=true) String sttsTy
			, @RequestParam(value="resnTy", required=false) String resnTy
			, @RequestParam(value="resn", required=true) String resn
			, @RequestParam Map<String,Object> reqMap) throws Exception {

		boolean result = false;

		OrdrDtlVO ordrDtlVO = new OrdrDtlVO();
		ordrDtlVO.setOrdrNo(ordrNo);
		ordrDtlVO.setOrdrDtlNo(ordrDtlNo);
		ordrDtlVO.setOrdrDtlNos(ordrDtlNos);
		ordrDtlVO.setSttsTy(sttsTy);
		ordrDtlVO.setResnTy(resnTy);
		ordrDtlVO.setResn(resn);

		Integer resultCnt = ordrDtlService.updateOrdrStts(ordrDtlVO, reqMap);

		if(resultCnt == 1){
			result = true;
		}

		// result
		Map<String, Object> resultMap = new HashMap<String, Object>();
		resultMap.put("result", result);
		return resultMap;
	}
	*/

	// 배송완료
	@ResponseBody
	@RequestMapping(value="dlvyDone.json")
	public Map<String, Object> dlvyDone(
			@RequestParam(value="ordrNo", required=true) int ordrNo
			, @RequestParam(value="ordrDtlCd", required=true) String ordrDtlCd
			, @RequestParam(value="resnTy", required=false) String resnTy
			, @RequestParam(value="resn", required=true) String resn
			, @RequestParam Map<String,Object> reqMap) throws Exception {

		boolean result = false;

		// 주문 상세코드로 주문 상세번호를 가져온 뒤 처리
		ArrayList<String> tmpOrdrDtlNos = new ArrayList<String>();
		List<OrdrDtlVO> ordrDtlList = ordrDtlService.selectOrdrDtlList(ordrDtlCd);
		for (OrdrDtlVO ordrDtlVO : ordrDtlList) {
			tmpOrdrDtlNos.add(EgovStringUtil.integer2string(ordrDtlVO.getOrdrDtlNo()));
		}

		String[] ordrDtlNos = tmpOrdrDtlNos.toArray(new String[tmpOrdrDtlNos.size()]);

		OrdrDtlVO ordrDtlVO = new OrdrDtlVO();
		ordrDtlVO.setOrdrNo(ordrNo);
		ordrDtlVO.setOrdrDtlCd(ordrDtlCd);
		ordrDtlVO.setOrdrDtlNos(ordrDtlNos);
		ordrDtlVO.setSttsTy("OR08");
		ordrDtlVO.setResnTy(resnTy);
		ordrDtlVO.setResn(resn);
		ordrDtlVO.setRegUniqueId(mngrSession.getUniqueId());
		ordrDtlVO.setRegId(mngrSession.getMngrId());
		ordrDtlVO.setRgtr(mngrSession.getMngrNm());

		Integer resultCnt = ordrDtlService.updateOrdrOR08(ordrDtlVO);

		if(resultCnt == 1){
			result = true;

			//자동 구매확정 처리 예정 이메일 발송
			SimpleDateFormat  formatter = new SimpleDateFormat ("yyyy-MM-dd HH:mm:ss");
			DecimalFormat numberFormat = new DecimalFormat("###,###");
			Calendar cal = Calendar.getInstance();

			OrdrVO ordrVO = ordrService.selectOrdrByNo(ordrNo);

			try {
				if(ValidatorUtil.isEmail(ordrVO.getOrdrrEml())) {
					String MAIL_FORM_PATH = mailFormFilePath;
					String mailForm = FileUtil.readFile(MAIL_FORM_PATH+"mail_ordr_auto.html");

					cal.setTime(formatter.parse(ordrVO.getDpstTermDt()));
					cal.add(Calendar.DATE, 7);

					mailForm = mailForm.replace("{yyyy}", formatter.format(cal.getTime()).substring(0, 4));
					mailForm = mailForm.replace("{mm}", formatter.format(cal.getTime()).substring(5, 7));
					mailForm = mailForm.replace("{dd}", formatter.format(cal.getTime()).substring(8, 10));

					mailForm = mailForm.replace("{mbrNm}", ordrVO.getOrdrrNm()); // 주문자
					mailForm = mailForm.replace("{ordrDt}", formatter.format(ordrVO.getOrdrDt())); // 주문일
					mailForm = mailForm.replace("{ordrCd}", ordrVO.getOrdrCd()); // 주문번호

					// 상품 정보 Start

					// 기본 상품 수량
					int baseQy = 0;
					for(OrdrDtlVO ordrDtl4VO : ordrVO.getOrdrDtlList()) {
						if(ordrDtl4VO.getOrdrOptnTy().equals("BASE") && ordrDtl4VO.getOrdrDtlCd().equals(ordrDtlCd)) {
							baseQy ++;
						}
					}

					String gdsForm = "{gdsView}";
					String gdsAdit = "";
					for(int i=0; i<baseQy; i++) {
						gdsAdit += (gdsForm+i);
					}

					mailForm = mailForm.replace("{gdsView}", gdsAdit);

					for(int i=0; i<ordrVO.getOrdrDtlList().size(); i++) {
						String base = FileUtil.readFile(MAIL_FORM_PATH+"mail_ordr_gds.html");
						String adit = FileUtil.readFile(MAIL_FORM_PATH+"mail_ordr_gds_optn.html");
						String bplc = FileUtil.readFile(MAIL_FORM_PATH+"mail_ordr_bplc.html");

						if(ordrVO.getOrdrDtlList().get(i).getOrdrOptnTy().equals("BASE")) {
							base = base.replace("{gdsNm}", ordrVO.getOrdrDtlList().get(i).getGdsNm());

							if(!ordrVO.getOrdrDtlList().get(i).getOrdrOptn().equals("")) {
								base = base.replace("{gdsOptnNm}", ordrVO.getOrdrDtlList().get(i).getOrdrOptn());
							}else {
								base = base.replace("{gdsOptnNm}", "없음");
							}

							base = base.replace("{ordrQy}", EgovStringUtil.integer2string(ordrVO.getOrdrDtlList().get(i).getOrdrQy()));
							base = base.replace("{ordrPc}", numberFormat.format(ordrVO.getOrdrDtlList().get(i).getOrdrPc())+" 원");

							if((i+1) < ordrVO.getOrdrDtlList().size()) {
								if(ordrVO.getOrdrDtlList().get(i+1).getOrdrOptnTy().equals("ADIT")) {
									adit = adit.replace("{optnNm}", ordrVO.getOrdrDtlList().get(i+1).getOrdrOptn());
									adit = adit.replace("{optnQy}", EgovStringUtil.integer2string(ordrVO.getOrdrDtlList().get(i+1).getOrdrQy()));
									adit = adit.replace("{optnPc}", numberFormat.format(ordrVO.getOrdrDtlList().get(i+1).getOrdrOptnPc()));

									base = base.replace("{aditOptn}", adit);
								}else {
									base = base.replace("{aditOptn}", "");
								}
							}else {
								base = base.replace("{aditOptn}", "");
							}

							if(!ordrVO.getOrdrTy().equals("N")) {
								bplc = bplc.replace("{bplcNm}", ordrVO.getOrdrDtlList().get(i).getBplcInfo().getBplcNm());
								bplc = bplc.replace("{telno}", ordrVO.getOrdrDtlList().get(i).getBplcInfo().getTelno());
								bplc = bplc.replace("{dlvyPc}", numberFormat.format((ordrVO.getOrdrDtlList().get(i).getDlvyAditAmt()+ordrVO.getOrdrDtlList().get(i).getDlvyBassAmt())));
								base = base.replace("{bplc}", bplc);
							}else {
								base = base.replace("{bplc}", "");
							}
							mailForm = mailForm.replace("{gdsView}"+i, base);
						}
					}

					// 배송정보
					mailForm = mailForm.replace("{recptrNm}", ordrVO.getRecptrNm()); // 받는사람
					mailForm = mailForm.replace("{dpstTermDt}", ordrVO.getDpstTermDt()); // 입금기한
					mailForm = mailForm.replace("{zip}", ordrVO.getRecptrZip()); // 지번
					mailForm = mailForm.replace("{addr}", ordrVO.getRecptrAddr() + ordrVO.getRecptrDaddr()); // 주소

					// 메일 발송
					String mailSj = "[이로움ON] 자동 구매확정처리 예정 안내드립니다.";
					if(EgovStringUtil.equals("real", activeMode)) {
						mailService.sendMail(sendMail, ordrVO.getOrdrrEml(), mailSj, mailForm);
					}else if(EgovStringUtil.equals("dev", activeMode)) {
						mailService.sendMail(sendMail, ordrVO.getOrdrrEml(), mailSj, mailForm);
					}else {
						mailService.sendMail(sendMail, "gyoh@icubesystems.co.kr", mailSj, mailForm); //테스트
					}
				} else {
					System.out.println("구매확정처리 예정 안내 EMAIL 전송 실패 :: 이메일 체크 " + ordrVO.getOrdrrEml());
				}
			} catch (Exception e) {
				System.out.println("구매확정처리 예정 안내 EMAIL 전송 실패 :: " + e.toString());
			}
		}

		// result
		Map<String, Object> resultMap = new HashMap<String, Object>();
		resultMap.put("result", result);
		return resultMap;
	}


	// 구매확정
	@ResponseBody
	@RequestMapping(value="ordrDone.json")
	public Map<String, Object> ordrDone(
			@RequestParam(value="ordrNo", required=true) int ordrNo
			, @RequestParam(value="ordrDtlCd", required=true) String ordrDtlCd
			, @RequestParam(value="resn", required=true) String resn
			, @RequestParam Map<String,Object> reqMap) throws Exception {

		boolean result = false;

		ArrayList<String> tmpOrdrDtlNos = new ArrayList<String>();
		List<OrdrDtlVO> ordrDtlList = ordrDtlService.selectOrdrDtlList(ordrDtlCd);
		int totalAccmlMlg = 0;
		for (OrdrDtlVO ordrDtlVO : ordrDtlList) {
			tmpOrdrDtlNos.add(EgovStringUtil.integer2string(ordrDtlVO.getOrdrDtlNo()));
			totalAccmlMlg += ordrDtlVO.getAccmlMlg();
		}

		String[] ordrDtlNos = tmpOrdrDtlNos.toArray(new String[tmpOrdrDtlNos.size()]);

		OrdrDtlVO ordrDtlVO = new OrdrDtlVO();
		ordrDtlVO.setOrdrNo(ordrNo);
		ordrDtlVO.setOrdrDtlCd(ordrDtlCd);
		ordrDtlVO.setOrdrDtlNos(ordrDtlNos);
		ordrDtlVO.setSttsTy("OR09");
		ordrDtlVO.setResn(resn);
		ordrDtlVO.setRegUniqueId(mngrSession.getUniqueId());
		ordrDtlVO.setRegId(mngrSession.getMngrId());
		ordrDtlVO.setRgtr(mngrSession.getMngrNm());

		ordrDtlVO.setTotalAccmlMlg(totalAccmlMlg);

		Integer resultCnt = ordrDtlService.updateOrdrOR09(ordrDtlVO);

		if(resultCnt == 1){
			result = true;
		}

		// result
		Map<String, Object> resultMap = new HashMap<String, Object>();
		resultMap.put("result", result);
		return resultMap;
	}



	//교환접수
	@RequestMapping(value="include/ordrExchng")
	public String ordrExchng(
			@RequestParam(value="ordrNo", required=true) int ordrNo
			, @RequestParam(value="ordrDtlCd", required=true) String ordrDtlCd
			//@RequestParam(value="ordrDtlNo", required=true) String ordrDtlNo
			//, @RequestParam(value="gdsNo", required=true) int gdsNo
			, @RequestParam Map<String,Object> reqMap
			, Model model) throws Exception {

		// 상품정보
		//OrdrDtlVO ordrDtlVO = ordrDtlService.selectOrdrDtl(EgovStringUtil.string2integer(ordrDtlNo));
		//model.addAttribute("ordrDtlVO", ordrDtlVO);

		List<OrdrDtlVO> ordrDtlList = ordrDtlService.selectOrdrDtlList(ordrDtlCd);
		model.addAttribute("ordrDtlList", ordrDtlList);

		model.addAttribute("ordrNo", ordrNo);
		model.addAttribute("ordrDtlCd", ordrDtlCd);

		model.addAttribute("gdsTyCode", CodeMap.GDS_TY);
		model.addAttribute("ordrExchngTyCode", CodeMap.ORDR_EXCHNG_TY);

		return "/manage/ordr/include/ordr_exchng";
	}


	//교환신청 접수 (EX01)
	@ResponseBody
	@RequestMapping(value="ordrExchngRcpt.json")
	public Map<String, Object> ordrExchngRcpt(
			@RequestParam(value="ordrNo", required=true) int ordrNo
			, @RequestParam(value="ordrDtlCd", required=true) String ordrDtlCd
			, @RequestParam(value="resnTy", required=false) String resnTy
			, @RequestParam(value="resn", required=true) String resn
			, @RequestParam Map<String,Object> reqMap) throws Exception {

		boolean result = false;

		ArrayList<String> tmpOrdrDtlNos = new ArrayList<String>();
		List<OrdrDtlVO> ordrDtlList = ordrDtlService.selectOrdrDtlList(ordrDtlCd);
		for (OrdrDtlVO ordrDtlVO : ordrDtlList) {
			tmpOrdrDtlNos.add(EgovStringUtil.integer2string(ordrDtlVO.getOrdrDtlNo()));
		}
		String[] ordrDtlNos = tmpOrdrDtlNos.toArray(new String[tmpOrdrDtlNos.size()]);

		OrdrDtlVO ordrDtlVO = new OrdrDtlVO();
		ordrDtlVO.setOrdrNo(ordrNo);
		ordrDtlVO.setOrdrDtlNos(ordrDtlNos);
		ordrDtlVO.setSttsTy("EX01");
		ordrDtlVO.setResnTy(resnTy);
		ordrDtlVO.setResn(resn);
		ordrDtlVO.setRegUniqueId(mngrSession.getUniqueId());
		ordrDtlVO.setRegId(mngrSession.getMngrId());
		ordrDtlVO.setRgtr(mngrSession.getMngrNm());

		Integer resultCnt = ordrDtlService.updateOrdrEA01(ordrDtlVO);
		if(resultCnt == 1){
			result = true;
		}

		// result
		Map<String, Object> resultMap = new HashMap<String, Object>();
		resultMap.put("result", result);
		return resultMap;
	}


	//교환접수 승인 (EX02)
	@ResponseBody
	@RequestMapping(value="exchngConfm.json")
	public Map<String, Object> exchngConfm(
			@RequestParam(value="ordrNo", required=true) int ordrNo
			, @RequestParam(value="ordrDtlCd", required=true) String ordrDtlCd
			, @RequestParam(value="resn", required=true) String resn
			, @RequestParam Map<String,Object> reqMap) throws Exception {

		boolean result = false;

		ArrayList<String> tmpOrdrDtlNos = new ArrayList<String>();
		List<OrdrDtlVO> ordrDtlList = ordrDtlService.selectOrdrDtlList(ordrDtlCd);
		for (OrdrDtlVO ordrDtlVO : ordrDtlList) {
			tmpOrdrDtlNos.add(EgovStringUtil.integer2string(ordrDtlVO.getOrdrDtlNo()));
		}

		String[] ordrDtlNos = tmpOrdrDtlNos.toArray(new String[tmpOrdrDtlNos.size()]);

		OrdrDtlVO ordrDtlVO = new OrdrDtlVO();
		ordrDtlVO.setOrdrNo(ordrNo);
		ordrDtlVO.setOrdrDtlCd(ordrDtlCd);
		ordrDtlVO.setOrdrDtlNos(ordrDtlNos);
		ordrDtlVO.setSttsTy("EX02");
		ordrDtlVO.setResn(resn);
		ordrDtlVO.setRegUniqueId(mngrSession.getUniqueId());
		ordrDtlVO.setRegId(mngrSession.getMngrId());
		ordrDtlVO.setRgtr(mngrSession.getMngrNm());

		Integer resultCnt = ordrDtlService.updateOrdrEX02(ordrDtlVO);

		if(resultCnt == 1){
			result = true;
		}

		// result
		Map<String, Object> resultMap = new HashMap<String, Object>();
		resultMap.put("result", result);
		return resultMap;
	}


	//교환완료 (EX03)
	@ResponseBody
	@RequestMapping(value="exchngDone.json")
	public Map<String, Object> exchngDone(
			@RequestParam(value="ordrNo", required=true) int ordrNo
			, @RequestParam(value="ordrDtlCd", required=true) String ordrDtlCd
			, @RequestParam(value="resn", required=true) String resn
			, @RequestParam Map<String,Object> reqMap) throws Exception {

		boolean result = false;

		ArrayList<String> tmpOrdrDtlNos = new ArrayList<String>();
		List<OrdrDtlVO> ordrDtlList = ordrDtlService.selectOrdrDtlList(ordrDtlCd);
		for (OrdrDtlVO ordrDtlVO : ordrDtlList) {
			tmpOrdrDtlNos.add(EgovStringUtil.integer2string(ordrDtlVO.getOrdrDtlNo()));
		}

		String[] ordrDtlNos = tmpOrdrDtlNos.toArray(new String[tmpOrdrDtlNos.size()]);

		OrdrDtlVO ordrDtlVO = new OrdrDtlVO();
		ordrDtlVO.setOrdrNo(ordrNo);
		ordrDtlVO.setOrdrDtlCd(ordrDtlCd);
		ordrDtlVO.setOrdrDtlNos(ordrDtlNos);
		ordrDtlVO.setSttsTy("EX03");
		ordrDtlVO.setResn(resn);
		ordrDtlVO.setRegUniqueId(mngrSession.getUniqueId());
		ordrDtlVO.setRegId(mngrSession.getMngrId());
		ordrDtlVO.setRgtr(mngrSession.getMngrNm());

		Integer resultCnt = ordrDtlService.updateOrdrEX03(ordrDtlVO);

		if(resultCnt == 1){
			result = true;
		}

		// result
		Map<String, Object> resultMap = new HashMap<String, Object>();
		resultMap.put("result", result);
		return resultMap;
	}


	// 반품 모달
	@RequestMapping(value="include/ordrReturn")
	public String ordrReturn(
			@RequestParam(value="ordrCd", required=true) String ordrCd
			, @RequestParam Map<String,Object> reqMap
			, Model model) throws Exception {

		// 주문정보
		OrdrVO ordrVO = ordrService.selectOrdrByCd(ordrCd);


		// result
		model.addAttribute("recipterYnCode", CodeMap.RECIPTER_YN);
		model.addAttribute("gradeCode", CodeMap.GRADE);
		model.addAttribute("bassStlmTyCode", CodeMap.BASS_STLM_TY);
		model.addAttribute("bankTyCode", CodeMap.BANK_TY);
		model.addAttribute("ordrReturnTyCode", CodeMap.ORDR_RETURN_TY);

		model.addAttribute("gdsTyCode", CodeMap.GDS_TY);
		model.addAttribute("ordrSttsCode", CodeMap.ORDR_STTS);



		model.addAttribute("ordrVO", ordrVO);
		model.addAttribute("bankTyCode", CodeMap.BANK_TY);

		return "/manage/ordr/include/ordr_return";
	}


	// 반품접수
	@ResponseBody
	@RequestMapping(value="ordrReturnSave.json")
	public Map<String, Object> ordrReturnSave(
			@RequestParam(value="ordrNo", required=true) int ordrNo
			, @RequestParam(value="ordrDtlCds[]", required=true) String[] ordrDtlCds
			, @RequestParam(value="resnTy", required=true) String resnTy
			, @RequestParam(value="resn", required=false) String resn
			, @RequestParam(value="rfndBank", required=false) String rfndBank // 환불 은행
			, @RequestParam(value="rfndActno", required=false) String rfndActno // 환불 계좌
			, @RequestParam(value="rfndDpstr", required=false) String rfndDpstr // 환불계좌 예금주
			//, @RequestParam(value="rfndAmt", required=false ) int rfndAmt // 환불금액
			, @RequestParam Map<String,Object> reqMap) throws Exception {

		boolean result = false;

		ArrayList<String> tmpOrdrDtlNos = new ArrayList<String>();
		for(String ordrDtlCd : ordrDtlCds) {
			List<OrdrDtlVO> ordrDtlList = ordrDtlService.selectOrdrDtlList(ordrDtlCd);
			for (OrdrDtlVO ordrDtlVO : ordrDtlList) {
				tmpOrdrDtlNos.add(EgovStringUtil.integer2string(ordrDtlVO.getOrdrDtlNo()));
			}
		}
		String[] ordrDtlNos = tmpOrdrDtlNos.toArray(new String[tmpOrdrDtlNos.size()]);

		OrdrDtlVO ordrDtlVO = new OrdrDtlVO();
		ordrDtlVO.setOrdrNo(ordrNo);
		ordrDtlVO.setOrdrDtlNos(ordrDtlNos);
		ordrDtlVO.setSttsTy("RE01"); // 반품접수
		ordrDtlVO.setResnTy(resnTy);
		ordrDtlVO.setResn(resn);
		ordrDtlVO.setRegUniqueId(mngrSession.getUniqueId());
		ordrDtlVO.setRegId(mngrSession.getMngrId());
		ordrDtlVO.setRgtr(mngrSession.getMngrNm());

		//환불정보
		Map<String, Object> rfndMap = new HashMap<String, Object>();
		rfndMap.put("rfndYn", "N");
		rfndMap.put("rfndBank", rfndBank);
		rfndMap.put("rfndActno", rfndActno);
		rfndMap.put("rfndDpstr", rfndDpstr);
		rfndMap.put("mdfcnUniqueId", mngrSession.getUniqueId());
		rfndMap.put("mdfcn_id", mngrSession.getMngrId());
		rfndMap.put("mdfr", mngrSession.getMngrNm());

		//Integer resultCnt = ordrDtlService.updateOrdrStts(ordrDtlVO, reqMap);
		Integer resultCnt = ordrDtlService.updateOrdrRE01(ordrDtlVO, rfndMap);
		if(resultCnt == 1){
			result = true;
		}

		// result
		Map<String, Object> resultMap = new HashMap<String, Object>();
		resultMap.put("result", result);
		return resultMap;
	}



	//교환접수 승인 (RE02)
	@ResponseBody
	@RequestMapping(value="returnConfm.json")
	public Map<String, Object> returnConfm(
			@RequestParam(value="ordrNo", required=true) int ordrNo
			, @RequestParam(value="ordrDtlCd", required=true) String ordrDtlCd
			, @RequestParam(value="resn", required=true) String resn
			, @RequestParam Map<String,Object> reqMap) throws Exception {

		boolean result = false;

		ArrayList<String> tmpOrdrDtlNos = new ArrayList<String>();
		List<OrdrDtlVO> ordrDtlList = ordrDtlService.selectOrdrDtlList(ordrDtlCd);
		for (OrdrDtlVO ordrDtlVO : ordrDtlList) {
			tmpOrdrDtlNos.add(EgovStringUtil.integer2string(ordrDtlVO.getOrdrDtlNo()));
		}

		String[] ordrDtlNos = tmpOrdrDtlNos.toArray(new String[tmpOrdrDtlNos.size()]);

		OrdrDtlVO ordrDtlVO = new OrdrDtlVO();
		ordrDtlVO.setOrdrNo(ordrNo);
		ordrDtlVO.setOrdrDtlCd(ordrDtlCd);
		ordrDtlVO.setOrdrDtlNos(ordrDtlNos);
		ordrDtlVO.setSttsTy("RE02");
		ordrDtlVO.setResn(resn);
		ordrDtlVO.setRegUniqueId(mngrSession.getUniqueId());
		ordrDtlVO.setRegId(mngrSession.getMngrId());
		ordrDtlVO.setRgtr(mngrSession.getMngrNm());

		Integer resultCnt = ordrDtlService.updateOrdrRE02(ordrDtlVO);

		if(resultCnt == 1){
			result = true;
		}

		// result
		Map<String, Object> resultMap = new HashMap<String, Object>();
		resultMap.put("result", result);
		return resultMap;
	}


	//반품완료 (RE03)
	@ResponseBody
	@RequestMapping(value="returnDone.json")
	public Map<String, Object> returnDone(
			@RequestParam(value="ordrNo", required=true) int ordrNo
			, @RequestParam(value="ordrDtlCd", required=true) String ordrDtlCd
			, @RequestParam(value="resn", required=true) String resn
			, @RequestParam(value="rfndBank", required=false) String rRfndBank
			, @RequestParam(value="rfndActno", required=false) String rfndActno
			, @RequestParam(value="rfndDpstr", required=false) String rfndDpstr
			, @RequestParam Map<String,Object> reqMap) throws Exception {

		boolean result = false;

		ArrayList<String> tmpOrdrDtlNos = new ArrayList<String>();
		List<OrdrDtlVO> ordrDtlList = ordrDtlService.selectOrdrDtlList(ordrDtlCd);
		for (OrdrDtlVO ordrDtlVO : ordrDtlList) {
			tmpOrdrDtlNos.add(EgovStringUtil.integer2string(ordrDtlVO.getOrdrDtlNo()));
		}

		String[] ordrDtlNos = tmpOrdrDtlNos.toArray(new String[tmpOrdrDtlNos.size()]);

		OrdrDtlVO ordrDtlVO = new OrdrDtlVO();
		ordrDtlVO.setOrdrNo(ordrNo);
		ordrDtlVO.setOrdrDtlCd(ordrDtlCd);
		ordrDtlVO.setOrdrDtlNos(ordrDtlNos);
		ordrDtlVO.setSttsTy("RE03");
		ordrDtlVO.setResn(resn);
		ordrDtlVO.setRegUniqueId(mngrSession.getUniqueId());
		ordrDtlVO.setRegId(mngrSession.getMngrId());
		ordrDtlVO.setRgtr(mngrSession.getMngrNm());
		ordrDtlVO.setRfndBank(rRfndBank);
		ordrDtlVO.setRfndActno(rfndActno);
		ordrDtlVO.setRfndDpstr(rfndDpstr);
		Integer resultCnt = ordrDtlService.updateOrdrRE03(ordrDtlVO);

		if(resultCnt == 1){
			result = true;

			//반품 이메일 발송
			SimpleDateFormat  formatter = new SimpleDateFormat ("yyyy-MM-dd HH:mm:ss");
			DecimalFormat numberFormat = new DecimalFormat("###,###");

			OrdrVO ordrVO = ordrService.selectOrdrByNo(ordrNo);
			List<OrdrDtlVO> nowDtlList = ordrDtlService.selectOrdrDtlList(ordrDtlCd);

			try {
				if(ValidatorUtil.isEmail(ordrVO.getOrdrrEml())) {
					String MAIL_FORM_PATH = mailFormFilePath;
					String mailForm = FileUtil.readFile(MAIL_FORM_PATH+"mail_ordr_return.html");

					mailForm = mailForm.replace("{yyyy}", formatter.format(ordrVO.getOrdrDt()).substring(0, 4));
					mailForm = mailForm.replace("{mm}", formatter.format(ordrVO.getOrdrDt()).substring(5, 7));
					mailForm = mailForm.replace("{dd}", formatter.format(ordrVO.getOrdrDt()).substring(8, 10));

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

					for (int i=0; i<nowDtlList.size(); i++) {

						// BASE
						if(nowDtlList.get(i).getOrdrOptnTy().equals("BASE")) {
							base = base.replace("{aditOptn}", "");
							base_reset = "";
							String base_html = FileUtil.readFile(MAIL_FORM_PATH + "mail_ordr_gds.html");
							base_html = base_html.replace("{gdsNm}", nowDtlList.get(i).getGdsNm());
							base_html = base_html.replace("{gdsOptnNm}", nowDtlList.get(i).getOrdrOptn());
							base_html = base_html.replace("{ordrQy}", EgovStringUtil.integer2string(nowDtlList.get(i).getOrdrQy()));
							base_html = base_html.replace("{ordrPc}", numberFormat.format(nowDtlList.get(i).getOrdrPc()));

							// 멤버스
							if (!ordrVO.getOrdrTy().equals("N")) {
								bplc = FileUtil.readFile(MAIL_FORM_PATH + "mail_ordr_bplc.html");
								bplc = bplc.replace("{bplcNm}", nowDtlList.get(i).getBplcInfo().getBplcNm());
								bplc = bplc.replace("{telno}", nowDtlList.get(i).getBplcInfo().getTelno());
								bplc = bplc.replace("{dlvyPc}",
										numberFormat.format((nowDtlList.get(i).getDlvyAditAmt()
												+ nowDtlList.get(i).getDlvyBassAmt())));
								base_html = base_html.replace("{bplc}", bplc);
							} else {
								base_html = base_html.replace("{bplc}", "");
							}

							base_reset = base_html;
						}

						if(nowDtlList.get(i).getOrdrOptnTy().equals("ADIT")) {
							// ADIT
							adit_reset = "";
							String adit_html = FileUtil.readFile(MAIL_FORM_PATH + "mail_ordr_gds_optn.html");
							adit_html = adit_html.replace("{optnNm}", nowDtlList.get(i).getOrdrOptn());
							adit_html = adit_html.replace("{optnQy}", EgovStringUtil.integer2string(nowDtlList.get(i).getOrdrQy()));
							adit_html = adit_html.replace("{optnPc}", numberFormat.format(nowDtlList.get(i).getOrdrOptnPc()));

							adit_reset = adit_html;
						}


						if(i == (nowDtlList.size()-1)) {

							if(nowDtlList.get(i).getOrdrOptnTy().equals("BASE")) {

								base += base_reset;
								base = base.replace("{aditOptn}", "");
							}else {
								adit += adit_reset;
								base = base.replace("{aditOptn}",adit);
							}
							last += base;

							mailForm = mailForm.replace("{gdsView}", last);
						}else {
							if(nowDtlList.get(i).getOrdrOptnTy().equals("BASE")) {
								base += base_reset;
							}else {
								adit += adit_reset;
							}
						}
					}

					// 결제 정보
					int totalGdsPc = 0; // 총 상품 금액 (상품 가격 * 수량)
					int dlvyPc = 0; // 배송비
					int  couponAmt = 0; // 쿠폰 할인
					int totalRfndAmt = 0; // 환불금액
					String rfndBanks = "";
					String actnos = "";

					for(OrdrDtlVO nowDtlVO : nowDtlList) {
						totalGdsPc += (nowDtlVO.getOrdrPc() * nowDtlVO.getOrdrQy());
						dlvyPc += (nowDtlVO.getDlvyBassAmt() + nowDtlVO.getDlvyAditAmt());
						couponAmt += nowDtlVO.getCouponAmt();
						totalRfndAmt += nowDtlVO.getRfndAmt();
						rfndBanks = nowDtlVO.getRfndBank();
						actnos = nowDtlVO.getRfndActno();
					}

					int mlg = ordrVO.getUseMlg(); // 마일리지
					int point = ordrVO.getUsePoint(); // 포인트

					Map<String, Object> paramMap = new HashMap<String, Object>();
					paramMap.put("ordrOptnTy", "BASE");
					paramMap.put("ordrCd", ordrVO.getOrdrCd());
					paramMap.put("sttsTy", "CA02");
					int lastObj = ordrDtlService.selectLastReturn(paramMap);

					if(lastObj == 1) {
						mailForm = mailForm.replace("{couponAmt}", numberFormat.format(couponAmt + mlg + point));
					}else {
						mailForm = mailForm.replace("{couponAmt}", numberFormat.format(couponAmt));
					}

					mailForm = mailForm.replace("{totalOrdrPc}", numberFormat.format(totalGdsPc));
					mailForm = mailForm.replace("{dlvyPc}", numberFormat.format(dlvyPc));
					mailForm = mailForm.replace("{stlmAmt}", numberFormat.format(totalRfndAmt)); // 결제금액

					String rfndCard = FileUtil.readFile(MAIL_FORM_PATH+"mail_rfnd_card.html");
					String rfndBank = FileUtil.readFile(MAIL_FORM_PATH+"mail_rfnd_bank.html");

					if(ordrVO.getStlmTy().equals("VBANK") || ordrVO.getStlmTy().equals("BANK")) {
						rfndBank = rfndBank.replace("{rfndTy}", "계좌이체");
						rfndBank = rfndBank.replace("{rfndAmt}", numberFormat.format(totalRfndAmt));
						rfndBank = rfndBank.replace("{rfndBank}", rfndBanks);
						rfndBank = rfndBank.replace("{actno}", actnos);
						rfndBank = rfndBank.replace("{rfndNm}", ordrVO.getPyrNm());
						mailForm = mailForm.replace("{rfndInfo}", rfndBank);

					}else {
						rfndCard = rfndCard.replace("{rfndTy}", ordrVO.getCardCoNm());
						rfndCard = rfndCard.replace("{stlmAmt2}", ordrVO.getDpstTermDt());
						mailForm = mailForm.replace("{rfndInfo}", rfndCard);
					}


					// 메일 발송
					String mailSj = "[이로움ON] 회원님의 상품 반품이 완료 되었습니다.";
					if(EgovStringUtil.equals("real", activeMode)) {
						mailService.sendMail(sendMail, ordrVO.getOrdrrEml(), mailSj, mailForm);
					}else if(EgovStringUtil.equals("dev", activeMode)) {
						mailService.sendMail(sendMail, ordrVO.getOrdrrEml(), mailSj, mailForm);
					}else {
						mailService.sendMail(sendMail, "gyoh@icubesystems.co.kr", mailSj, mailForm); //테스트
					}
				} else {
					System.out.println("사용자 상품 반품 완료 알림 EMAIL 전송 실패 :: 이메일 체크 " + ordrVO.getOrdrrEml());
				}
			} catch (Exception e) {
				System.out.println("사용자 상품 반품 완료 알림 EMAIL 전송 실패 :: " + e.toString());
			}
		}

		// result
		Map<String, Object> resultMap = new HashMap<String, Object>();
		resultMap.put("result", result);
		return resultMap;
	}


	//환불완료 (RF02)
	@ResponseBody
	@RequestMapping(value="rfndDone.json")
	public Map<String, Object> rfndDone(
			@RequestParam(value="ordrNo", required=true) int ordrNo
			, @RequestParam(value="ordrDtlCd", required=true) String ordrDtlCd
			, @RequestParam(value="resn", required=true) String resn
			, @RequestParam Map<String,Object> reqMap) throws Exception {

		boolean result = false;

		ArrayList<String> tmpOrdrDtlNos = new ArrayList<String>();
		List<OrdrDtlVO> ordrDtlList = ordrDtlService.selectOrdrDtlList(ordrDtlCd);
		for (OrdrDtlVO ordrDtlVO : ordrDtlList) {
			tmpOrdrDtlNos.add(EgovStringUtil.integer2string(ordrDtlVO.getOrdrDtlNo()));
		}

		String[] ordrDtlNos = tmpOrdrDtlNos.toArray(new String[tmpOrdrDtlNos.size()]);

		OrdrDtlVO ordrDtlVO = new OrdrDtlVO();
		ordrDtlVO.setOrdrNo(ordrNo);
		ordrDtlVO.setOrdrDtlCd(ordrDtlCd);
		ordrDtlVO.setOrdrDtlNos(ordrDtlNos);
		ordrDtlVO.setSttsTy("RF02");
		ordrDtlVO.setResn(resn);
		ordrDtlVO.setRegUniqueId(mngrSession.getUniqueId());
		ordrDtlVO.setRegId(mngrSession.getMngrId());
		ordrDtlVO.setRgtr(mngrSession.getMngrNm());

		Integer resultCnt = ordrDtlService.updateOrdrRF02(ordrDtlVO);

		if(resultCnt == 1){
			result = true;
		}

		// result
		Map<String, Object> resultMap = new HashMap<String, Object>();
		resultMap.put("result", result);
		return resultMap;
	}


	//승인대기 -> 승인관리 모달
	@RequestMapping(value="include/ordrConfm")
	public String ordrConfm(
			@RequestParam(value="ordrDtlNo", required=true) int ordrDtlNo
			, @RequestParam Map<String,Object> reqMap
			, Model model) throws Exception {

		// 주문정보
		OrdrDtlVO ordrDtlVO = ordrDtlService.selectOrdrDtl(ordrDtlNo);
		model.addAttribute("ordrDtlVO", ordrDtlVO);

		return "/manage/ordr/include/ordr_confm";
	}


	//승인관리 > 승인/반려
	@ResponseBody
	@RequestMapping(value="ordrConfmSave.json")
	public Map<String, Object> ordrConfmSave(
			@RequestParam(value="ordrNo", required=true) int ordrNo
			, @RequestParam(value="ordrDtlCd", required=true) String ordrDtlCd
			, @RequestParam(value="sttsTy", required=true) String sttsTy
			, @RequestParam(value="resnTy", required=false) String resnTy
			, @RequestParam(value="resn", required=false) String resn
			, @RequestParam Map<String,Object> reqMap
			, Model model) throws Exception {

		boolean result = false;

		// 주문 상세코드로 주문 상세번호를 가져온 뒤 처리
		ArrayList<String> tmpOrdrDtlNos = new ArrayList<String>();
		List<OrdrDtlVO> ordrDtlList = ordrDtlService.selectOrdrDtlList(ordrDtlCd);
		for (OrdrDtlVO ordrDtlVO : ordrDtlList) {
			tmpOrdrDtlNos.add(EgovStringUtil.integer2string(ordrDtlVO.getOrdrDtlNo()));
		}

		String[] ordrDtlNos = tmpOrdrDtlNos.toArray(new String[tmpOrdrDtlNos.size()]);

		OrdrDtlVO ordrDtlVO = new OrdrDtlVO();
		ordrDtlVO.setOrdrNo(ordrNo);
		ordrDtlVO.setOrdrDtlNos(ordrDtlNos);
		ordrDtlVO.setSttsTy(sttsTy);
		ordrDtlVO.setResnTy(resnTy);
		ordrDtlVO.setResn(resn);
		ordrDtlVO.setRegUniqueId(mngrSession.getUniqueId());
		ordrDtlVO.setRegId(mngrSession.getMngrId());
		ordrDtlVO.setRgtr(mngrSession.getMngrNm());

		Integer resultCnt = ordrDtlService.updateOrdrOR02OR03(ordrDtlVO);
		if(resultCnt == 1){
			result = true;
		}

		// result
		Map<String, Object> resultMap = new HashMap<String, Object>();
		resultMap.put("result", result);
		return resultMap;

	}


	// 주문상세 > 진행내역 모달
	@RequestMapping(value="include/ordrSttsHist")
	public String ordrSttsHist(
			@RequestParam(value="ordrDtlNo", required=true) String ordrDtlNo
			, @RequestParam Map<String,Object> reqMap
			, Model model) throws Exception {


		// 상품정
		OrdrDtlVO ordrDtlVO = ordrDtlService.selectOrdrDtl(EgovStringUtil.string2integer(ordrDtlNo));
		model.addAttribute("ordrDtlVO", ordrDtlVO);

		// 진행내역 리스트
		List<OrdrChgHistVO> sttsChgHistList= ordrChgHistService.selectOrdrChgHistList(ordrDtlNo);
		for(OrdrChgHistVO ordrChgHistVO : sttsChgHistList) {
			ordrChgHistVO.setResn(HtmlUtil.enterToBr(ordrChgHistVO.getResn()));
		}

		model.addAttribute("sttsChgHistList", sttsChgHistList);

		// result
		model.addAttribute("bassStlmTyCode", CodeMap.BASS_STLM_TY);
		model.addAttribute("bankTyCode", CodeMap.BANK_TY);
		model.addAttribute("ordrCancelTyCode", CodeMap.ORDR_CANCEL_TY);
		model.addAttribute("ordrExchngTyCode", CodeMap.ORDR_EXCHNG_TY);
		model.addAttribute("ordrReturnTyCode", CodeMap.ORDR_RETURN_TY);

		model.addAttribute("gdsTyCode", CodeMap.GDS_TY);
		model.addAttribute("ordrSttsCode", CodeMap.ORDR_STTS);


		return "/manage/ordr/include/ordr_stts_hist";
	}


	// 자동결제 해지
	@ResponseBody
	@RequestMapping(value="billingCancel.json")
	public Map<String, Object> billingCancel(
			@RequestParam(value="ordrNo", required=true) int ordrNo
			, @RequestParam(value="billingKey", required=true) String billingKey
			, @RequestParam Map<String,Object> reqMap
			, Model model) throws Exception {

		boolean result = false;

		try {
			HashMap<String, Object> res = bootpayApiService.destroyBillingKey(billingKey);
			if(res.get("error_code") == null) { //success
		       log.debug("destroyBillingKey success: " + res);

		       ordrService.updateBillingCancel(ordrNo);

		       result = true;
		   } else {
		       log.debug("destroyBillingKey false: " + res);
		   }

		} catch (Exception e) {
			// TODO: handle exception
		}

		// result
		Map<String, Object> resultMap = new HashMap<String, Object>();
		resultMap.put("result", result);
		return resultMap;

	}

	// 카드변경 모달
	@RequestMapping(value="include/rebillPayChg")
	public String rebillPayChg(
			@RequestParam(value="ordrCd", required=true) String ordrCd
			, @RequestParam Map<String,Object> reqMap
			, Model model) throws Exception {


		// 주문정보
		OrdrVO ordrVO = ordrService.selectOrdrByCd(ordrCd);

		// result
		model.addAttribute("ordrVO", ordrVO);

		return "/manage/ordr/include/ordr_rebill_chg";
	}

	// 결제정보 변경
	/**
	 * 2023-04-14
	 * 이니시스 -> 비인증 방식 불가로 홀딩
	 */
	@ResponseBody
	@RequestMapping(value = "rebillPayChg.json")
	public Map<String, Object> rebillPayChg(
			@RequestParam(value = "ordrNo", required=true) String ordrNo
			, @RequestParam(value = "cardNo",required=true) String cardNo
			, @RequestParam(value = "cardPw",required=true) String cardPw
			, @RequestParam(value = "expireMonth",required=true) String expireMonth
			, @RequestParam(value = "expireYear",required=true) String expireYear
			, @RequestParam(value = "birth",required=true) String birth
			, @RequestParam Map<String, Object> reqMap
			, Model model
			)throws Exception {
		boolean result = false;

		OrdrVO ordrVO = ordrService.selectOrdrByNo(EgovStringUtil.string2integer(ordrNo));

		Bootpay bootpay = new Bootpay(bootpayRestKey, bootpayPrivateKey);
		bootpay.getAccessToken();

		Subscribe subscribe = new Subscribe();
		subscribe.orderName = ordrVO.getOrdrDtlList().get(0).getGdsNm();
		subscribe.subscriptionId = ordrVO.getOrdrCd();
		subscribe.pg = "inicis";
		subscribe.cardNo = cardNo;
		subscribe.cardPw = cardPw;
		subscribe.cardExpireMonth = expireMonth; //실제 테스트시에는 *** 마스크처리가 아닌 숫자여야 함
		subscribe.cardExpireYear = expireYear; //실제 테스트시에는 *** 마스크처리가 아닌 숫자여야 함
		subscribe.cardIdentityNo = birth; //생년월일 또는 사업자 등록번호 (- 없이 입력)


		subscribe.user = new User();
		subscribe.user.username = "오근영";
		subscribe.user.phone = "01033662658";

		String billingKey = "";

		try {
			   HashMap res = bootpay.getBillingKey(subscribe);
			   JSONObject json =  new JSONObject(res);
			   System.out.printf( "JSON: %s", json);

			   if(res.get("error_code") == null) { //success
			       System.out.println("getBillingKey success: " + res);

			    // 성공 시 빌링키 삭제
				HashMap<String, Object> oldRes = bootpayApiService.destroyBillingKey(ordrVO.getBillingKey());
				if(oldRes.get("error_code") == null) { //success
			       log.debug("destroyBillingKey success: " + oldRes);
			       ordrService.updateBillingCancel(EgovStringUtil.string2integer(ordrNo));
				}else {
					log.debug("destroyBillingKey false: " + oldRes);
				}

				//빌링키 업데이트
				JSONObject data =  new JSONObject((JSONObject)json.get("card_data"));
				billingKey = (String)json.get("billing_key");

				Map<String, Object> paramMap = new HashMap<String, Object>();
				paramMap.put("billingKey", billingKey);
				paramMap.put("cardAprvno", (String)data.get("card_approve_no"));
				paramMap.put("cardCoNm", (String)data.get("card_company"));
				paramMap.put("cardNo", cardNo.substring(0, 6) + "*********" + cardNo.substring(15));
				paramMap.put("delngNo", (String)data.get("receipt_id"));
				paramMap.put("ordrNo", ordrVO.getOrdrNo());
				ordrService.updateBillingChg(paramMap);

				result = true;

			   } else {
			       System.out.println("getBillingKey false: " + res);
			   }
			} catch (Exception e) {
				log.debug(" ###  rebillPayChg fail ### : " + e.toString());
			   e.printStackTrace();
			}

		Map<String, Object> resultMap = new HashMap<String, Object>();
		resultMap.put("result", result);
		return resultMap;
	}

	/**
	 * 엑셀 다운로드
	 * @param ordrStts
	 * @param model
	 */
	@RequestMapping(value="{ordrStts}/excel")
	public String excelDownload(
			@PathVariable String ordrStts
			, HttpServletRequest request
			, @RequestParam Map<String, Object> reqMap
			, Model model) throws Exception{

		Map<String, Object> paramMap = new HashMap<String, Object>();
		if(!ordrStts.toUpperCase().equals("ALL")) {
			paramMap.put("srchSttsTy", ordrStts.toUpperCase());
		}
		 List<OrdrDtlVO> ordrDtlList =ordrDtlService.selectOrdrSttsList(paramMap);

		model.addAttribute("gdsTyCode", CodeMap.GDS_TY);
		model.addAttribute("bassStlmTyCode", CodeMap.BASS_STLM_TY);
		model.addAttribute("ordrSttsCode", CodeMap.ORDR_STTS);
		model.addAttribute("ordrCancelTyCode", CodeMap.ORDR_CANCEL_TY);

		model.addAttribute("ordrDtlList", ordrDtlList);
		model.addAttribute("ordrSttsTy", ordrStts.toUpperCase());

		return "/manage/ordr/excel";
	}

}
