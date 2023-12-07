package icube.manage.ordr.ordr;

import java.net.URLEncoder;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.StringJoiner;

import javax.annotation.Resource;
import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.CellStyle;
import org.apache.poi.ss.usermodel.Font;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.ss.util.CellRangeAddress;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
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
import icube.common.mail.MailForm2Service;
import icube.common.mail.MailFormService;
import icube.common.util.ArrayUtil;
import icube.common.util.ExcelExporter;
import icube.common.util.HtmlUtil;
import icube.common.util.StringUtil;
import icube.common.util.WebUtil;
import icube.common.values.CodeMap;
import icube.common.vo.CommonListVO;
import icube.manage.gds.gds.biz.GdsService;
import icube.manage.gds.gds.biz.GdsVO;
import icube.manage.gds.optn.biz.GdsOptnVO;
import icube.manage.mbr.mbr.biz.MbrService;
import icube.manage.mbr.mbr.biz.MbrVO;
import icube.manage.ordr.chghist.biz.OrdrChgHistService;
import icube.manage.ordr.chghist.biz.OrdrChgHistVO;
import icube.manage.ordr.dtl.biz.OrdrDtlService;
import icube.manage.ordr.dtl.biz.OrdrDtlVO;
import icube.manage.ordr.ordr.biz.OrdrService;
import icube.manage.ordr.ordr.biz.OrdrVO;
import icube.manage.sysmng.dlvy.biz.DlvyCoMngService;
import icube.manage.sysmng.dlvy.biz.DlvyCoMngVO;
import icube.manage.sysmng.entrps.biz.EntrpsService;
import icube.manage.sysmng.entrps.biz.EntrpsVO;
import icube.manage.sysmng.mngr.biz.MngrLogService;
import icube.manage.sysmng.mngr.biz.MngrService;
import icube.manage.sysmng.mngr.biz.MngrSession;
import icube.manage.sysmng.mngr.biz.MngrVO;
import kr.co.bootpay.Bootpay;
import kr.co.bootpay.model.request.Subscribe;
import kr.co.bootpay.model.request.User;

/**
 * ordrStts : 주문상태
 */
@Controller
@RequestMapping(value="/_mng/ordr")
public class MOrdrController extends CommonAbstractController {


			
	@Resource(name = "mbrService")
	private MbrService mbrService;

	@Resource(name = "ordrService")
	private OrdrService ordrService;

	@Resource(name = "ordrDtlService")
	private OrdrDtlService ordrDtlService;

	@Resource(name = "ordrChgHistService")
	private OrdrChgHistService ordrChgHistService;

	@Resource(name = "gdsService")
	private GdsService gdsService;

	@Resource(name = "entrpsService")
	private EntrpsService entrpsService;

	@Resource(name = "dlvyCoMngService")
	private DlvyCoMngService dlvyCoMngService;

	@Resource(name="mngrService")
	private MngrService mngrService;

	@Resource(name= "bootpayApiService")
	private BootpayApiService bootpayApiService;

	@Resource(name="mailFormService")
	private MailFormService mailFormService;

	@Resource(name="mailForm2Service")
	private MailForm2Service mailForm2Service;
	
	
	@Resource(name="mngrLogService")
	private MngrLogService mngrLogService;

	@Value("#{props['Bootpay.Script.Key']}")
	private String bootpayScriptKey;

	@Value("#{props['Bootpay.Private.Key']}")
	private String bootpayPrivateKey;

	@Value("#{props['Bootpay.Rest.Key']}")
	private String bootpayRestKey;

	@Autowired
	private MngrSession mngrSession;

	// Page Parameter Keys
	//private static String[] targetParams = {"curPage", "cntPerPage", "srchTarget", "srchText", "sortBy"
		//									, "srchSttsTy", "srchOrdrYmdBgng", "srchOrdrYmdEnd", "srchOrdrrNm", "srchRecptrNm", "srchOrdrTy", "srchStlmTy", "srchGdsCd", "srchGdsNm"};

	// 리스트
	@SuppressWarnings("unchecked")
	@RequestMapping(value="{ordrStts}/list")
	public String list(
			@PathVariable String ordrStts
			, HttpServletRequest request
			, Model model) throws Exception {

        Map<String, String> mbgrReqMap = new HashMap<>();
        mbgrReqMap.put("mngrId", mngrSession.getMngrId());
        MngrVO curMngrVO = mngrService.selectMngrById(mbgrReqMap);

		CommonListVO listVO = new CommonListVO(request);
		//배송관리 화면인 경우 검색 조건에 따라 조회
		if ("or06".equalsIgnoreCase(ordrStts)) {
			if (EgovStringUtil.isEmpty(listVO.getParam("srchSttsTy"))) {
				listVO.setParam("ordrSttsTy", "OR06");
				listVO.setParam("srchSttsTy", "OR06");
			}
			else {
				listVO.setParam("ordrSttsTy", listVO.getParam("srchSttsTy").toUpperCase());
			}
		} else {
			listVO.setParam("ordrSttsTy", ordrStts.toUpperCase());
		}
		

        //현재관리자에 입점업체 정보가 있으면 해당 입점업체만 조회되도록 구현
        if (curMngrVO.getEntrpsNo() > 0) {
        	listVO.setParam("srchEntrpsNo", curMngrVO.getEntrpsNo());
        	model.addAttribute("mngrEntrpsNo", curMngrVO.getEntrpsNo());
        }

		listVO = ordrService.ordrListVO(listVO);

		//간편로그인 ID 너무 길어서 간단하게 표시작업
		listVO.getListObject().stream().forEach(ordr -> {
			OrdrDtlVO ordrDtlltVO = (OrdrDtlVO)ordr;
			if (ordrDtlltVO.getOrdrrId().endsWith("@K")) {
				ordrDtlltVO.setOrdrrId("카카오 계정");
			} else if (ordrDtlltVO.getOrdrrId().endsWith("@N")) {
				ordrDtlltVO.setOrdrrId("네이버 계정");
			}
			
			//개인정보 마스킹
			try {
				ordrDtlltVO.setOrdrrNm(StringUtil.nameMasking(ordrDtlltVO.getOrdrrNm()));
				ordrDtlltVO.setRecptrNm(StringUtil.nameMasking(ordrDtlltVO.getRecptrNm()));
        	} catch (Exception ex) {
        		ordrDtlltVO.setOrdrrNm("");
    			ordrDtlltVO.setRecptrNm("");
        	}
		});

		//입점업체 호출
		List<EntrpsVO> entrpsList = entrpsService.selectEntrpsListAll(new HashMap<String, Object>());
		model.addAttribute("entrpsList", entrpsList);

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
			, HttpServletRequest request
			, Model model) throws Exception {

		// 주문정보
		OrdrVO ordrVO = ordrService.selectOrdrByCd(ordrCd);

		// 택배사
		Map<String, Object> paramMap = new HashMap<String, Object>();
		paramMap.put("srchUseYn", "Y");
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

		
		//상세조회 로그 수집
        mngrLogService.insertMngrDetailLog(request);
		
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

			//log.debug("resultCnt: " + resultCnt);
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

		int resultCnt = ordrDtlService.updateCA02AndReturnCoupon(ordrNo, ordrDtlVO, ordrDtlNos);

		if(resultCnt == 1) {
			result = true;

			OrdrVO ordrVO = ordrService.selectOrdrByNo(ordrNo);
			MbrVO mbrVO =  mbrService.selectMbrByUniqueId(ordrVO.getUniqueId());
			mailForm2Service.sendMailOrder("MAILSEND_ORDR_MNG_REFUND", mbrVO, ordrVO, ordrDtlCd);
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
			, @RequestParam(value="ordrDtlCd", required=true) String ordrDtlCd
			, @RequestParam(value="dlvyCo", required=false) String dlvyCo
			, @RequestParam(value="dlvyInvcNo", required=false) String dlvyInvcNo
			, @RequestParam Map<String,Object> reqMap) throws Exception {

		boolean result = false;
		// result
		Map<String, Object> resultMap = new HashMap<String, Object>();


		ArrayList<String> tmpOrdrDtlNos = new ArrayList<String>();
		List<OrdrDtlVO> ordrDtlList = ordrDtlService.selectOrdrDtlList(ordrDtlCd);
		for (OrdrDtlVO ordrDtlVO : ordrDtlList) {
			tmpOrdrDtlNos.add(EgovStringUtil.integer2string(ordrDtlVO.getOrdrDtlNo()));

			//택배사 정보가 없는 경우는 배송완료 -> 배송중으로 저장할 경우
			if (EgovStringUtil.isEmpty(dlvyCo)) {
				dlvyCo = String.valueOf(ordrDtlVO.getDlvyCoNo()) + "|" + ordrDtlVO.getDlvyCoNm();
				dlvyInvcNo = ordrDtlVO.getDlvyInvcNo();
			}
		}


		//택배사 정보가 없으면 잘못된 요청
		if (EgovStringUtil.isEmpty(dlvyCo) || EgovStringUtil.isEmpty(dlvyInvcNo)) {
			resultMap.put("result", result);
			return resultMap;
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

			try {
				ordrDtlService.updateOrdr0506AndOrdrChgHist(ordrDtlVO);
				totalResultCnt += 1;
			}catch(Exception e) {
				e.printStackTrace();
				log.debug("updateOrdr0506AndOrdrChgHist Error : " + e.toString());
			}
		}

		if(totalResultCnt == dtLCdList.length){
			result = true;

			OrdrVO ordrVO = ordrService.selectOrdrByNo(ordrNo);
			MbrVO mbrVO =  mbrService.selectMbrByUniqueId(ordrVO.getUniqueId());
			mailForm2Service.sendMailOrder("MAILSEND_ORDR_MNG_CONFIRM", mbrVO, ordrVO);
		}

		// result
		Map<String, Object> resultMap = new HashMap<String, Object>();
		resultMap.put("result", result);
		return resultMap;
	}

	// 배송중 -> 배송준비중
	@ResponseBody
	@RequestMapping(value="dlvyPreparing.json")
	public Map<String, Object> dlvyPreparing(
			@RequestParam(value="ordrNo", required=true) int ordrNo
			, @RequestParam(value="ordrDtlCd", required=true) String ordrDtlCd
			, @RequestParam(value="ordrDtlNo", required=true) int ordrDtlNo) throws Exception {

		boolean result = false;

		OrdrDtlVO ordrDtlVO = new OrdrDtlVO();
		ordrDtlVO.setOrdrNo(ordrNo);
		ordrDtlVO.setOrdrDtlCd(ordrDtlCd);
		ordrDtlVO.setOrdrDtlNo(ordrDtlNo);

		try {
			ordrDtlService.updateOrdr06AndOrdrChgHist(ordrDtlVO);
			result = true;
		}catch(Exception e) {
			log.error("==== 배송중 취소 오류 ====", e);
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

			// OrdrVO ordrVO = ordrService.selectOrdrByNo(ordrNo);

			// String mailSj = "[이로움ON] 자동 구매확정처리 예정 안내드립니다.";
			// String mailHtml = "mail_ordr_auto.html";
			// mailFormService.makeMailForm(ordrVO, null, mailHtml, mailSj);
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
			OrdrVO ordrVO = ordrService.selectOrdrByNo(ordrNo);
			ordrVO.setOrdrDtlList(ordrDtlList);
			
			MbrVO mbrVO = mbrService.selectMbrByUniqueId(ordrVO.getUniqueId());

			mailForm2Service.sendMailOrder("MAILSEND_ORDR_SCHEDULE_CONFIRM_ACTION", mbrVO, ordrVO);
			
			result = true;
		}

		// result
		Map<String, Object> resultMap = new HashMap<String, Object>();
		resultMap.put("result", result);
		return resultMap;
	}


	// 구매확정 취소
	@ResponseBody
	@RequestMapping(value="cancelOrdrDone.json")
	public Map<String, Object> cancelOrdrDone(
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
		ordrDtlVO.setSttsTy("OR08");
		ordrDtlVO.setResn(resn);
		ordrDtlVO.setRegUniqueId(mngrSession.getUniqueId());
		ordrDtlVO.setRegId(mngrSession.getMngrId());
		ordrDtlVO.setRgtr(mngrSession.getMngrNm());

		ordrDtlVO.setTotalAccmlMlg(totalAccmlMlg);

		Integer resultCnt = ordrDtlService.updateCancelOrdrOR09(ordrDtlVO);

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
			, @RequestParam Map<String,Object> reqMap
			, Model model) throws Exception {

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

		OrdrVO ordrMailSendVO = ordrService.selectOrdrByNo(ordrNo);

		ArrayList<String> tmpOrdrDtlNos = new ArrayList<String>();
		List<OrdrDtlVO> ordrDtlList = ordrDtlService.selectOrdrDtlList(ordrDtlCd);
		for (OrdrDtlVO ordrDtlVO : ordrDtlList) {
			tmpOrdrDtlNos.add(EgovStringUtil.integer2string(ordrDtlVO.getOrdrDtlNo()));
		}
		ordrMailSendVO.setOrdrDtlList(ordrDtlList);

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
		Integer resultCnt = ordrDtlService.updateOrdrRE03(ordrDtlVO, ordrDtlNos);

		if(resultCnt == 1){
			result = true;

			MbrVO mbrVO =  mbrService.selectMbrByUniqueId(ordrMailSendVO.getUniqueId());
			mailForm2Service.sendMailOrder("MAILSEND_ORDR_MNG_RETURN", mbrVO, ordrMailSendVO);
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


		// 상품정보
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
	@SuppressWarnings("rawtypes")
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
	public void excelDownload(
			@PathVariable String ordrStts
			, HttpServletRequest request
			, HttpServletResponse response
			, @RequestParam Map<String, Object> reqMap
			, Model model) throws Exception{

		/*
		Map<String, Object> paramMap = new HashMap<String, Object>();
		if(!ordrStts.toUpperCase().equals("ALL")) {
			paramMap.put("srchSttsTy", ordrStts.toUpperCase());
		}
		*/

		Map<String, String> mbgrReqMap = new HashMap<>();
        mbgrReqMap.put("mngrId", mngrSession.getMngrId());
        MngrVO curMngrVO = mngrService.selectMngrById(mbgrReqMap);

		CommonListVO listVO = new CommonListVO(request, 1, 10000);
		listVO.setParam("ordrSttsTy", ordrStts.toUpperCase());

        //현재관리자에 입점업체 정보가 있으면 해당 입점업체만 조회되도록 구현
        if (curMngrVO.getEntrpsNo() > 0) {
        	listVO.setParam("srchEntrpsNo", curMngrVO.getEntrpsNo());
        	model.addAttribute("mngrEntrpsNo", curMngrVO.getEntrpsNo());
        }

		boolean cellAdd231206 = true;/* 주문자 휴대폰번호, 수령인 휴대폰번호, 우편번호, 배송지*/
		ordrStts = ordrStts.toUpperCase();
 		if(ordrStts.equals("OR03") || ordrStts.equals("OR04") || ordrStts.equals("OR09")) {//구매확정
			cellAdd231206 = false;
        }else if(ordrStts.equals("CA01")) {//취소관리
			cellAdd231206 = false;
        }

		Map<String, Boolean> dataAdd231206Map = new HashMap<String, Boolean>(){{
			put("OR01", true); // 주문승인대기
			put("OR02", true);//주문승인완료
			put("OR03", false);//주문승인반려

			put("OR04", false);//결제대기
			put("OR05", true);//결제완료
			put("OR06", true);//배송준비중
			put("OR07", true);//배송중
			put("OR08", false);//배송완료
			put("OR09", false);//구매확정

			put("CA01", false); // 취소접수
			put("CA02", false);//취소완료
			put("CA03", false);//주문취소

			put("EX01", true); // 교환접수
			put("EX02", true);//교환진행중
			put("EX03", false);//교환완료

			put("RE01", true);  // 반품접수
			put("RE02", true);//반품진행중
			put("RE03", false);//반품완료

			put("RF01", false); // 환불접수
			put("RF02", false);//환불완료
		}};

		listVO = ordrService.ordrListVO(listVO);

		List<OrdrDtlVO> ordrDtlList = listVO.getListObject();

		Workbook workbook = new XSSFWorkbook();
        Sheet sheet = workbook.createSheet("DataSheet");


        Font font = workbook.createFont();
        font.setFontHeightInPoints((short) 10);	// 글자크기

        CellStyle style = workbook.createCellStyle();
        style.setFont(font);
        style.setWrapText(true); //줄바꿈처리 : \n

		int cellPos = 0;

        // 첫 번째 행 (상위 헤더)
        Row row1 = sheet.createRow(0);
        row1.createCell(cellPos++).setCellValue("주문일시");
        row1.createCell(cellPos++).setCellValue("주문자");
		if (cellAdd231206) row1.createCell(cellPos++).setCellValue("주문자 휴대전화");
        row1.createCell(cellPos++).setCellValue("수령인");
		if (cellAdd231206 ) {
			row1.createCell(cellPos++).setCellValue("수령인 휴대전화");
			row1.createCell(cellPos++).setCellValue("우편번호");
			row1.createCell(cellPos++).setCellValue("배송주소");
			row1.createCell(cellPos++).setCellValue("배송 요청사항");
		}

        row1.createCell(cellPos++).setCellValue("상품구분");
        row1.createCell(cellPos++).setCellValue("상품번호");
        row1.createCell(cellPos++).setCellValue("입점업체");
        row1.createCell(cellPos++).setCellValue("상품명/옵션");
        row1.createCell(cellPos++).setCellValue("상품가격");
        row1.createCell(cellPos++).setCellValue("수량");
        row1.createCell(cellPos++).setCellValue("주문금액");
        
		row1.createCell(cellPos++).setCellValue("쿠폰 할인");
        row1.createCell(cellPos++).setCellValue("마일리지 할인");
        row1.createCell(cellPos++).setCellValue("포인트 할인");
        
		row1.createCell(cellPos++).setCellValue("배송비");
        row1.createCell(cellPos++).setCellValue("결제금액");
        row1.createCell(cellPos++).setCellValue("결제수단");
        row1.createCell(cellPos++).setCellValue("멤버스");
        row1.createCell(cellPos++).setCellValue("주문상태");
        
        // 스타일 적용하고 싶음
        ExcelExporter.setCellStyleForRow(row1, style);

        int i = 1; //2row부터
        for(OrdrDtlVO ordrDtlVO : ordrDtlList) {
        	Row dataRow = sheet.createRow(i);
			cellPos = 0;

			dataRow.createCell(cellPos++).setCellValue(new SimpleDateFormat("yyyy-MM-dd HH:mm").format(ordrDtlVO.getOrdrDt()) + "\n" + ordrDtlVO.getOrdrCd());
        	dataRow.createCell(cellPos++).setCellValue(ordrDtlVO.getOrdrrNm() + "\n(" + ordrDtlVO.getOrdrrId() + ")");
			if (cellAdd231206){
				if (dataAdd231206Map.containsKey(ordrDtlVO.getSttsTy()) && dataAdd231206Map.get(ordrDtlVO.getSttsTy())){
					dataRow.createCell(cellPos++).setCellValue(ordrDtlVO.getOrdrrMblTelno());//주문자 휴대폰번호
				}else{
					dataRow.createCell(cellPos++).setCellValue("");//주문자 휴대폰번호
				}
			}
        	dataRow.createCell(cellPos++).setCellValue(ordrDtlVO.getRecptrNm());
			if (cellAdd231206){
				if (dataAdd231206Map.containsKey(ordrDtlVO.getSttsTy()) && dataAdd231206Map.get(ordrDtlVO.getSttsTy())){
					dataRow.createCell(cellPos++).setCellValue(ordrDtlVO.getRecptrMblTelno());//수령인 휴대폰번호
				}else{
					dataRow.createCell(cellPos++).setCellValue("");//수령인 휴대폰번호
				}
				if (dataAdd231206Map.containsKey(ordrDtlVO.getSttsTy()) && dataAdd231206Map.get(ordrDtlVO.getSttsTy())){
					dataRow.createCell(cellPos++).setCellValue(ordrDtlVO.getRecptrZip());//우편번호
				}else{
					dataRow.createCell(cellPos++).setCellValue("");//우편번호
				}
				if (dataAdd231206Map.containsKey(ordrDtlVO.getSttsTy()) && dataAdd231206Map.get(ordrDtlVO.getSttsTy())){
					dataRow.createCell(cellPos++).setCellValue(ordrDtlVO.getRecptrAddr() + " " + ordrDtlVO.getRecptrDaddr());//배송지
				}else{
					dataRow.createCell(cellPos++).setCellValue("");//배송지
				}
				if (dataAdd231206Map.containsKey(ordrDtlVO.getSttsTy()) && dataAdd231206Map.get(ordrDtlVO.getSttsTy())){
					dataRow.createCell(cellPos++).setCellValue(ordrDtlVO.getOrdrrMemo());//배송메세지
				}else{
					dataRow.createCell(cellPos++).setCellValue("");//배송메세지
				}
			}

        	dataRow.createCell(cellPos++).setCellValue(CodeMap.GDS_TY.get(ordrDtlVO.getOrdrTy()));
        	dataRow.createCell(cellPos++).setCellValue(ordrDtlVO.getGdsCd());
        	dataRow.createCell(cellPos++).setCellValue(ordrDtlVO.getEntrpsNm());

        	String gdsNm = "";
        	gdsNm = ordrDtlVO.getGdsNm();
        	if(ordrDtlVO.getOrdrOptnTy().equals("BASE")) {
        		if(EgovStringUtil.isNotEmpty(ordrDtlVO.getOrdrOptn())) {
        			gdsNm += "\n(" + ordrDtlVO.getOrdrOptn() + ")";
        		}
    		}else {
    			gdsNm = ordrDtlVO.getOrdrOptn();
    		}
    		dataRow.createCell(cellPos++).setCellValue(gdsNm);

    		String gdsPc = String.format("%,d", ordrDtlVO.getGdsPc());
    		if(ordrDtlVO.getOrdrOptnTy().equals("BASE")) {
    			gdsPc += "(+" + String.format("%,d", ordrDtlVO.getOrdrOptnPc())  +")";
    		}else {
    			gdsPc = String.format("%,d", ordrDtlVO.getOrdrOptnPc());
    		}
        	dataRow.createCell(cellPos++).setCellValue(gdsPc);
        	dataRow.createCell(cellPos++).setCellValue(String.format("%,d", ordrDtlVO.getOrdrQy()));
        	dataRow.createCell(cellPos++).setCellValue(String.format("%,d", ordrDtlVO.getOrdrPc()));

        	dataRow.createCell(cellPos++).setCellValue(String.format("%,d", ordrDtlVO.getCouponAmt()));
        	dataRow.createCell(cellPos++).setCellValue(String.format("%,d", ordrDtlVO.getUseMlg()));
        	dataRow.createCell(cellPos++).setCellValue(String.format("%,d", ordrDtlVO.getUsePoint()));

        	String dlvyAmt = String.format("%,d", ordrDtlVO.getDlvyBassAmt());
        	if(ordrDtlVO.getDlvyAditAmt() > 0) {
        		dlvyAmt += "(" + String.format("%,d", ordrDtlVO.getDlvyAditAmt()) +")";
        	}
        	dataRow.createCell(cellPos++).setCellValue(dlvyAmt);

        	dataRow.createCell(cellPos++).setCellValue(String.format("%,d", ordrDtlVO.getStlmAmt()));
        	String stlmTy = "미정";
        	if(EgovStringUtil.isNotEmpty(ordrDtlVO.getStlmTy())) {
        		stlmTy = CodeMap.BASS_STLM_TY.get(ordrDtlVO.getStlmTy());
        	}
        	dataRow.createCell(cellPos++).setCellValue(stlmTy);

        	dataRow.createCell(cellPos++).setCellValue(ordrDtlVO.getBplcNm());

        	String sttsTy = CodeMap.ORDR_STTS.get(ordrDtlVO.getSttsTy());
        	if((ordrDtlVO.getSttsTy().equals("RE03") || ordrDtlVO.getSttsTy().equals("RF01")) && ordrDtlVO.getRfndYn().equals("N")) {
        		sttsTy = "환불접수(반품완료)";
        	}else if((ordrDtlVO.getSttsTy().equals("RE03") || ordrDtlVO.getSttsTy().equals("RF02")) && ordrDtlVO.getRfndYn().equals("Y")) {
        		sttsTy = "환불완료(반품완료)";
        	}
        	dataRow.createCell(cellPos++).setCellValue(sttsTy);

        	i++;

        	ExcelExporter.setCellStyleForRow(dataRow, style);

        }

        for(int j=0; j<18; j++) {
        	sheet.autoSizeColumn(j);
        }

        // 파일명요청
        String fileName = "전체_주문_목록";
        ordrStts = ordrStts.toUpperCase();
        if(ordrStts.equals("OR01")) {
        	fileName = "승인대기_주문_목록";
        }else if(ordrStts.equals("OR02")) {
        	fileName = "승인완료_주문_목록";
        }else if(ordrStts.equals("OR03")) {
        	fileName = "승인반려_주문_목록";
        }else if(ordrStts.equals("OR04")) {
        	fileName = "결제대기_주문_목록";
        }else if(ordrStts.equals("OR05")) {
        	fileName = "결제완료_주문_목록";
        }else if(ordrStts.equals("OR06")) {
        	fileName = "배송관리_주문_목록";
        }else if(ordrStts.equals("OR09")) {
        	fileName = "구매확정_주문_목록";
        }else if(ordrStts.equals("CA01")) {
        	fileName = "취소관리_주문_목록";
        }else if(ordrStts.equals("EX01")) {
        	fileName = "교환관리_주문_목록";
        }else if(ordrStts.equals("RE01")) {
        	fileName = "반품관리_주문_목록";
        }else if(ordrStts.equals("RF01")) {
        	fileName = "환불관리_주문_목록";
        }

        // Excel 다운로드를 위한 응답 유형을 설정하고 데이터를 작성
        fileName = URLEncoder.encode(fileName,  "UTF-8");
        response.setContentType("application/vnd.openxmlformats-officedocument.spreadsheetml.sheet");
        response.setHeader("Content-Disposition", "attachment; filename=" + fileName + "_" + EgovDateUtil.getCurrentDateAsString()  + ".xlsx");

        try (ServletOutputStream outputStream = response.getOutputStream()) {
            workbook.write(outputStream);
            workbook.close();
        }

		// model.addAttribute("gdsTyCode", CodeMap.GDS_TY);
		// model.addAttribute("bassStlmTyCode", CodeMap.BASS_STLM_TY);
		// model.addAttribute("ordrSttsCode", CodeMap.ORDR_STTS);
		// model.addAttribute("ordrCancelTyCode", CodeMap.ORDR_CANCEL_TY);

		// model.addAttribute("ordrDtlList", ordrDtlList);
		// model.addAttribute("ordrSttsTy", ordrStts.toUpperCase());

		//return "/manage/ordr/excel";
	}

}
