/*
 *
 */
package icube.manage.consult;

import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Date;
import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;
import java.util.function.Function;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.egovframe.rte.fdl.string.EgovStringUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.View;
import org.springframework.web.util.HtmlUtils;

import icube.common.api.biz.BiztalkConsultService;
import icube.common.api.biz.TilkoApiService;
import icube.common.framework.abst.CommonAbstractController;
import icube.common.framework.view.JavaScript;
import icube.common.framework.view.JavaScriptView;
import icube.common.util.CommonUtil;
import icube.common.util.DateUtil;
import icube.common.util.ExcelExporter;
import icube.common.util.HtmlUtil;
import icube.common.util.StringUtil;
import icube.common.values.CRUD;
import icube.common.values.CodeMap;
import icube.common.vo.CommonListVO;
import icube.manage.consult.biz.ConsltHistory;
import icube.manage.consult.biz.MbrConsltChgHistVO;
import icube.manage.consult.biz.MbrConsltMemoVO;
import icube.manage.consult.biz.MbrConsltResultService;
import icube.manage.consult.biz.MbrConsltResultVO;
import icube.manage.consult.biz.MbrConsltService;
import icube.manage.consult.biz.MbrConsltVO;
import icube.manage.mbr.mbr.biz.MbrService;
import icube.manage.mbr.mbr.biz.MbrVO;
import icube.manage.mbr.recipients.biz.MbrRecipientsService;
import icube.manage.mbr.recipients.biz.MbrRecipientsVO;
import icube.manage.members.bplc.biz.BplcService;
import icube.manage.members.bplc.biz.BplcVO;
import icube.manage.sysmng.mngr.biz.MngrSession;

/**
 * 장기요양 상담 신청
 * @author ogy
 *
 * @update kkm : 상담 프로세스 추가
 *
 */
@Controller
@RequestMapping(value="/#{props['Globals.Manager.path']}/consult/recipter")
public class MMbrConsltController extends CommonAbstractController{

	@Resource(name = "mbrService")
	private MbrService mbrService;
	
	@Resource(name = "mbrConsltService")
	private MbrConsltService mbrConsltService;

	@Resource(name = "mbrConsltResultService")
	private MbrConsltResultService mbrConsltResultService;

	@Resource(name= "mbrRecipientsService")
	private MbrRecipientsService mbrRecipientsService;

	@Resource(name= "tilkoApiService")
	private TilkoApiService tilkoApiService;
	
	@Resource(name = "bplcService")
	private BplcService bplcService;
	
	@Resource(name = "biztalkConsultService")
	private BiztalkConsultService biztalkConsultService;
	
	
	@Autowired
	private MngrSession mngrSession;

	private static String[] targetParams = {"curPage", "cntPerPage", "srchTarget", "srchText", "sortBy"};

	@RequestMapping(value = "list")
	public String list(
		HttpServletRequest request
		, Model model
		) throws Exception {

		CommonListVO listVO = new CommonListVO(request);
		listVO.setParam("srchUseYn", "Y");
		listVO = mbrConsltService.selectMbrConsltListVO(listVO);

		
		//개인정보 마스킹
		for(Object listObj : listVO.getListObject()) {
			MbrConsltVO vo = (MbrConsltVO)listObj;
			vo.setMbrNm(StringUtil.nameMasking(vo.getMbrNm()));
			vo.setMbrTelno(StringUtil.phoneMasking(vo.getMbrTelno()));
			vo.setRgtr(StringUtil.nameMasking(vo.getRgtr()));
		}
		
		
		model.addAttribute("listVO", listVO);
		model.addAttribute("genderCode", CodeMap.GENDER);
		model.addAttribute("prevPath", CodeMap.PREV_PATH);
		
		HashMap<String, String> map = new LinkedHashMap<String, String>();
		map.put("MBR_NM", "수급자 성명");
		map.put("MBR_TELNO", "상담받을 연락처");
		map.put("RGTR", "회원이름");
		map.put("REG_ID", "회원아이디");
		
		model.addAttribute("FindCdList", map);

		return "/manage/consult/recipter/list";
	}


	// 상세내역 + 이로움 관리자메모
	@RequestMapping(value="view")
	public String view(
			@RequestParam(value="consltNo", required=true) int consltNo
			, @RequestParam Map<String, Object> reqMap
			, HttpServletRequest request
			, Model model) throws Exception{

		Map<String, Object> paramMap = new HashMap<String, Object>();
		paramMap.put("consltNo", consltNo);
		MbrConsltVO mbrConsltVO = mbrConsltService.selectMbrConslt(reqMap);

		if(mbrConsltVO == null) {
			model.addAttribute("alertMsg", getMsg("alert.author.common"));
			return "/common/msg";
		}else {
			List<MbrConsltResultVO> consltResultList = mbrConsltVO.getConsltResultList();
			for(MbrConsltResultVO mbrConsltResultVO : consltResultList) {
				mbrConsltResultVO.setConsltDtls(HtmlUtil.enterToBr(mbrConsltResultVO.getConsltDtls()));
				mbrConsltResultVO.setReconsltResn(HtmlUtil.enterToBr(mbrConsltResultVO.getReconsltResn()));
			}
		}

		//상담기록 및 진행상태 변경 내역
		List<ConsltHistory> historyList = new ArrayList<>();
		paramMap = new HashMap<String, Object>();
		paramMap.put("srchConsltNo", consltNo);

		List<MbrConsltMemoVO> memoList = mbrConsltService.selectMbrConsltMemo(paramMap);
		for(MbrConsltMemoVO memoVO : memoList) {
			ConsltHistory ConsltHistory = new ConsltHistory();
			ConsltHistory.setRegDt(memoVO.getRegDt());
			ConsltHistory.setName(memoVO.getMngrNm());
			ConsltHistory.setId(memoVO.getMngrId());
			ConsltHistory.setContent(memoVO.getMngMemo());
			historyList.add(ConsltHistory);
		}

		List<MbrConsltChgHistVO> chgHistList =  mbrConsltService.selectMbrConsltChgHist(paramMap);
		for(MbrConsltChgHistVO chgHistVO : chgHistList) {
			ConsltHistory ConsltHistory = new ConsltHistory();
			ConsltHistory.setRegDt(chgHistVO.getRegDt());
			ConsltHistory.setName(EgovStringUtil.isNotEmpty(chgHistVO.getMbrNm()) ? chgHistVO.getMbrNm()
					: EgovStringUtil.isNotEmpty(chgHistVO.getMngrNm()) ? chgHistVO.getMngrNm()
					: chgHistVO.getBplcNm());
			ConsltHistory.setId(EgovStringUtil.isNotEmpty(chgHistVO.getMbrId()) ? chgHistVO.getMbrId()
					: EgovStringUtil.isNotEmpty(chgHistVO.getMngrId()) ? chgHistVO.getMngrId()
					: chgHistVO.getBplcId());
			ConsltHistory.setContent("상태변경: [" + chgHistVO.getResn() + "]");
			historyList.add(ConsltHistory);
		}

		Collections.sort(historyList, Collections.reverseOrder());

		String historyText = "";
		for(int i = 0; i < historyList.size(); i++) {
			ConsltHistory hist = historyList.get(i);
			if (i != 0) {
				historyText += "\n";
			}
			historyText += hist.toString();
		}
		
		String regUniqueId = mbrConsltVO.getRegUniqueId();
		MbrVO mbrVO = mbrService.selectMbrByUniqueId(regUniqueId);
		if (mbrVO != null) {
			mbrVO.setCrud(CRUD.UPDATE);
		}

		model.addAttribute("mbrConsltVO", mbrConsltVO);
		model.addAttribute("mbrVO", mbrVO);
		model.addAttribute("genderCode", CodeMap.GENDER);
		model.addAttribute("historyText", historyText);
		model.addAttribute("chgHistList", chgHistList);
		model.addAttribute("MBR_RELATION_CD", CodeMap.MBR_RELATION_CD);
		model.addAttribute("PREV_PATH", CodeMap.PREV_PATH);
		model.addAttribute("MBER_STTUS", CodeMap.MBER_STTUS);
		
		
		if (chgHistList.size() > 0) {
			model.addAttribute("consltBplcUniqueId", chgHistList.get(0).getConsltBplcUniqueId());
		}

		return "/manage/consult/recipter/view";
	}


	// 처리
	@RequestMapping(value="action")
	public View action(
			MbrConsltVO mbrConsltVO
			, @RequestParam Map<String,Object> reqMap
			, HttpServletRequest request) throws Exception {

		JavaScript javaScript = new JavaScript();
		String pageParam = HtmlUtils.htmlUnescape(EgovStringUtil.null2void(CommonUtil.getPageParam(targetParams, reqMap)));

		// 사업소 선택 정보 처리
		String bplcUniqueId = (String) reqMap.get("bplcUniqueId");
		String bplcId = (String) reqMap.get("bplcId");
		String bplcNm = (String) reqMap.get("bplcNm");
		String originConsltSttus = (String) reqMap.get("originConsltSttus");
		String originConsltBplcUniqueId = (String) reqMap.get("originConsltBplcUniqueId");
		
		BplcVO bplcVO = null;
		MbrConsltResultVO srchConsltResult = null;
		if(EgovStringUtil.isNotEmpty(bplcUniqueId) &&
				(EgovStringUtil.equals(mbrConsltVO.getConsltSttus(), "CS02") || EgovStringUtil.equals(mbrConsltVO.getConsltSttus(), "CS08"))) {

			//3차까지만 재신청 가능하도록 검사
			int mbrConsltResultCtn = mbrConsltResultService.selectMbrConsltBplcCntByConsltNo(mbrConsltVO.getConsltNo());
			if (mbrConsltResultCtn >= 3) {
				javaScript.setMessage("사업소 배정은 3차까지 가능합니다.");
				javaScript.setLocation("./view?consltNo=" + mbrConsltVO.getConsltNo() + ("".equals(pageParam) ? "" : "&" + pageParam));
				return new JavaScriptView(javaScript);
			}
			
			MbrConsltResultVO mbrConsltResultVO = new MbrConsltResultVO();
			mbrConsltResultVO.setConsltNo(mbrConsltVO.getConsltNo());
			mbrConsltResultVO.setBplcUniqueId(bplcUniqueId);
			mbrConsltResultVO.setBplcId(bplcId);
			mbrConsltResultVO.setBplcNm(bplcNm);
			mbrConsltResultVO.setRegUniqueId(mngrSession.getUniqueId());
			mbrConsltResultVO.setRegId(mngrSession.getMngrId());
			mbrConsltResultVO.setRgtr(mngrSession.getMngrNm());

			mbrConsltResultVO.setConsltSttus(mbrConsltVO.getConsltSttus()); //배정

			if(EgovStringUtil.equals(mbrConsltVO.getConsltSttus(), "CS02")) { // 처음 배정이면 기존 사업소 삭제
				mbrConsltResultService.deleteMbrConsltBplc(mbrConsltResultVO);
			}

			mbrConsltResultService.insertMbrConsltBplc(mbrConsltResultVO);

			
			//추가된 사업소 상담 정보 조회
			Map<String, Object> srchMap = new HashMap<>();
			srchMap.put("srchConsltNo", mbrConsltVO.getConsltNo());
			srchConsltResult = mbrConsltResultService.selectMbrConsltBplc(srchMap);
			
			//상담 테이블에 현재 매칭된 사업소 상담 정보 저장
			mbrConsltService.updateCurConsltResultNo(mbrConsltVO.getConsltNo(), srchConsltResult.getBplcConsltNo());
			
			//1:1 상담 배정 이력 추가
			String resn = "CS02".equals(mbrConsltVO.getConsltSttus()) ? CodeMap.CONSLT_STTUS_CHG_RESN.get("배정") : CodeMap.CONSLT_STTUS_CHG_RESN.get("재배정");

			MbrConsltChgHistVO mbrConsltChgHistVO = new MbrConsltChgHistVO();
			mbrConsltChgHistVO.setConsltNo(mbrConsltVO.getConsltNo());
			mbrConsltChgHistVO.setConsltSttusChg(mbrConsltVO.getConsltSttus());
			mbrConsltChgHistVO.setBplcConsltNo(srchConsltResult.getBplcConsltNo());
			mbrConsltChgHistVO.setBplcConsltSttusChg(mbrConsltResultVO.getConsltSttus());
			mbrConsltChgHistVO.setConsltBplcUniqueId(mbrConsltResultVO.getBplcUniqueId());
			mbrConsltChgHistVO.setConsltBplcNm(mbrConsltResultVO.getBplcNm());
			mbrConsltChgHistVO.setResn(resn);
			mbrConsltChgHistVO.setMngrUniqueId(mngrSession.getUniqueId());
			mbrConsltChgHistVO.setMngrId(mngrSession.getMngrId());
			mbrConsltChgHistVO.setMngrNm(mngrSession.getMngrNm());
			mbrConsltService.insertMbrConsltChgHist(mbrConsltChgHistVO);
		}

		// 상담정보 > 관리자(이로움) 메모 처리
		mbrConsltVO.setMngrUniqueId(mngrSession.getUniqueId());
		mbrConsltVO.setMngrId(mngrSession.getMngrId());
		mbrConsltVO.setMngrNm(mngrSession.getMngrNm());
		
		



		Integer iResult = mbrConsltService.updateMbrConslt(mbrConsltVO);
		
		if (iResult > 0 ) {
			if (EgovStringUtil.isNotEmpty(bplcUniqueId) 
					&& (
							EgovStringUtil.equals("CS01", originConsltSttus) // 접수
							|| (EgovStringUtil.equals("CS02", originConsltSttus) && !EgovStringUtil.equals(bplcUniqueId , originConsltBplcUniqueId)) //배정
							|| EgovStringUtil.equals("CS07", originConsltSttus) //재접수
							|| (EgovStringUtil.equals("CS08", originConsltSttus) && !EgovStringUtil.equals(bplcUniqueId , originConsltBplcUniqueId)) //재배정
						)
					) {
				/*상담 매칭*/
				if (bplcVO == null) bplcVO = bplcService.selectBplcByUniqueId(bplcUniqueId);
				
				MbrRecipientsVO mbrRecipientsVO = mbrRecipientsService.selectMbrRecipientsByRecipientsNo(mbrConsltVO.getRecipientsNo());
				
				MbrVO mbrVO = mbrService.selectMbrByUniqueId(mbrConsltVO.getRegUniqueId());
			
				biztalkConsultService.sendOnTalkMatched(mbrVO, mbrRecipientsVO, bplcVO, mbrConsltVO.getConsltNo());
				if (srchConsltResult != null){
					biztalkConsultService.sendCareTalkMatched(bplcVO, mbrConsltVO.getConsltNo(), srchConsltResult.getBplcConsltNo());
				}
			}
			
			if (EgovStringUtil.equals(originConsltSttus, "CS02") && EgovStringUtil.isNotEmpty(originConsltBplcUniqueId)) {
				BplcVO bplcVOOrigin = bplcService.selectBplcByUniqueId(originConsltBplcUniqueId);
				
				biztalkConsultService.sendCareTalkCancel(bplcVOOrigin, mbrConsltVO.getConsltNo());
			}
		} 
		


		javaScript.setMessage(getMsg("action.complete.update"));
		javaScript.setLocation("./view?consltNo=" + mbrConsltVO.getConsltNo() + ("".equals(pageParam) ? "" : "&" + pageParam));

		return new JavaScriptView(javaScript);
	}

	// 상담취소
	@RequestMapping(value = "canclConslt.json")
	@ResponseBody
	public Map<String, Object> cancelConslt(
			@RequestParam(value = "consltNo", required=true) int consltNo
			, @RequestParam(value = "canclResn", required=true) String canclResn
			, @RequestParam(value = "consltmbrNm", required=true) String consltmbrNm
			, @RequestParam(value = "consltMbrTelno", required=true) String consltMbrTelno
			, HttpServletRequest request
			) throws Exception {

		boolean result = false;

		Map<String, Object> paramMap = new HashMap<String, Object>();
		paramMap.put("consltSttus", "CS09"); //관리자에서 취소시 THKC 취소
		paramMap.put("canclResn", canclResn);
		paramMap.put("consltNo", consltNo);

		int resultCnt = mbrConsltService.updateCanclConslt(paramMap);

		if(resultCnt > 0) {
			result = true;

			//1:1 관리자 상담 취소 이력 저장
			Map<String, Object> srchMap = new HashMap<String, Object>();
			srchMap.put("srchConsltNo", consltNo);
			MbrConsltResultVO mbrConsltResultVO = mbrConsltResultService.selectMbrConsltBplc(srchMap);

			MbrConsltChgHistVO mbrConsltChgHistVO = new MbrConsltChgHistVO();
			mbrConsltChgHistVO.setConsltNo(consltNo);
			mbrConsltChgHistVO.setConsltSttusChg("CS09");
			if (mbrConsltResultVO != null) {
				mbrConsltChgHistVO.setBplcConsltNo(mbrConsltResultVO.getBplcConsltNo());
				mbrConsltChgHistVO.setBplcConsltSttusChg("CS09");
				mbrConsltChgHistVO.setConsltBplcUniqueId(mbrConsltResultVO.getBplcUniqueId());
				mbrConsltChgHistVO.setConsltBplcNm(mbrConsltResultVO.getBplcNm());
			}
			mbrConsltChgHistVO.setResn(CodeMap.CONSLT_STTUS_CHG_RESN.get("THKC 취소"));
			mbrConsltChgHistVO.setMngrUniqueId(mngrSession.getUniqueId());
			mbrConsltChgHistVO.setMngrId(mngrSession.getMngrId());
			mbrConsltChgHistVO.setMngrNm(mngrSession.getMngrNm());
			mbrConsltService.insertMbrConsltChgHist(mbrConsltChgHistVO);

			MbrConsltVO mbrConsltVO  = mbrConsltService.selectMbrConsltByConsltNo(consltNo);
			
			MbrVO mbrVO = mbrService.selectMbrByUniqueId(mbrConsltVO.getRegUniqueId());
			MbrRecipientsVO mbrRecipientsVO = mbrRecipientsService.selectMbrRecipientsByRecipientsNo(mbrConsltVO.getRecipientsNo());

			//관리자 상담취소 ==> 일반사용자에게 메세지
			biztalkConsultService.sendOnTalkCancel(mbrVO, mbrRecipientsVO, mbrConsltVO.getConsltNo());
			
			//관리자 상담취소 ==> 사업소가 있는 경우 사업소 담당자에게 메세지
			if (mbrConsltResultVO != null && EgovStringUtil.isNotEmpty(mbrConsltResultVO.getBplcUniqueId())){
				/*상담 매칭*/
				BplcVO bplcVO = bplcService.selectBplcByUniqueId(mbrConsltResultVO.getBplcUniqueId());
				biztalkConsultService.sendCareTalkCancel(bplcVO, mbrConsltVO.getConsltNo());	
			}
			
		}

		Map<String, Object> resultMap = new HashMap<String, Object>();
		resultMap.put("result", result);
		return resultMap;
	}

	// 상담기록(관리자 메모) 저장
	@RequestMapping(value = "saveMemo.json")
	@ResponseBody
	public Map<String, Object> saveMemo(
			@RequestParam(value = "consltNo", required=true) int consltNo
			, @RequestParam(value = "mngMemo", required=true) String mngMemo
			, HttpServletRequest request
			) throws Exception {

		boolean result = false;

		Map<String, Object> paramMap = new HashMap<String, Object>();
		paramMap.put("consltNo", consltNo);
		paramMap.put("mngMemo", mngMemo);

		//상담의 메모 컬럼만 변경
		int resultCnt = mbrConsltService.updateMngMemo(paramMap);

		//관리자 상담 메모 저장
		MbrConsltMemoVO newMemoVO = new MbrConsltMemoVO();
		newMemoVO.setConsltNo(consltNo);
		newMemoVO.setMngMemo(mngMemo);
		newMemoVO.setMngrUniqueId(mngrSession.getUniqueId());
		newMemoVO.setMngrId(mngrSession.getMngrId());
		newMemoVO.setMngrNm(mngrSession.getMngrNm());

		resultCnt += mbrConsltService.insertMbrConsltMemo(newMemoVO);

		if(resultCnt > 1) {
			result = true;
		}

		Map<String, Object> resultMap = new HashMap<String, Object>();
		resultMap.put("result", result);
		return resultMap;
	}

	// 상담진행상태 변경
	@RequestMapping(value = "changeConsltSttus.json")
	@ResponseBody
	public Map<String, Object> changeConsltSttus(
		@RequestParam(value = "consltNo", required=true) int consltNo
		, @RequestParam(value = "changedSttus", required=true) String changedSttus  //변경할 상태
		, HttpServletRequest request
		) throws Exception {

		boolean result = false;

		//가장 최신에 매칭된 사업소 조회
		Map<String, Object> srchMap = new HashMap<String, Object>();
		srchMap.put("srchConsltNo", consltNo);
		MbrConsltResultVO mbrConsltResultVO = mbrConsltResultService.selectMbrConsltBplc(srchMap);

		//상태 변경
		Map<String, Object> paramMap = new HashMap<String, Object>();
		paramMap.put("consltSttus", changedSttus);
		paramMap.put("consltNo", consltNo);
		int resultCnt = 0;
		if (mbrConsltResultVO == null) {
			resultCnt = mbrConsltResultService.updateSttusWithOutResult(paramMap);
		}
		else {
			paramMap.put("bplcConsltNo", mbrConsltResultVO.getBplcConsltNo());
			resultCnt = mbrConsltResultService.updateSttus(paramMap);
		}


		if(resultCnt > 0) {
			result = true;

			//상담 변경 이력 저장
			String resn = "CS01".equals(changedSttus) ? CodeMap.CONSLT_STTUS_CHG_RESN.get("접수")
					: "CS02".equals(changedSttus) ? CodeMap.CONSLT_STTUS_CHG_RESN.get("배정")
					: "CS03".equals(changedSttus) ? CodeMap.CONSLT_STTUS_CHG_RESN.get("상담자 취소")
					: "CS04".equals(changedSttus) ? CodeMap.CONSLT_STTUS_CHG_RESN.get("사업소 취소")
					: "CS05".equals(changedSttus) ? CodeMap.CONSLT_STTUS_CHG_RESN.get("진행")
					: "CS06".equals(changedSttus) ? CodeMap.CONSLT_STTUS_CHG_RESN.get("완료")
					: "CS07".equals(changedSttus) ? CodeMap.CONSLT_STTUS_CHG_RESN.get("재접수")
					: "CS08".equals(changedSttus) ? CodeMap.CONSLT_STTUS_CHG_RESN.get("재배정")
					: CodeMap.CONSLT_STTUS_CHG_RESN.get("THKC 취소");

			MbrConsltChgHistVO mbrConsltChgHistVO = new MbrConsltChgHistVO();
			mbrConsltChgHistVO.setConsltNo(consltNo);
			mbrConsltChgHistVO.setConsltSttusChg(changedSttus);
			if (mbrConsltResultVO != null) {
				mbrConsltChgHistVO.setBplcConsltNo(mbrConsltResultVO.getBplcConsltNo());
				mbrConsltChgHistVO.setBplcConsltSttusChg(changedSttus);
				mbrConsltChgHistVO.setConsltBplcUniqueId(mbrConsltResultVO.getBplcUniqueId());
				mbrConsltChgHistVO.setConsltBplcNm(mbrConsltResultVO.getBplcNm());
			}
			mbrConsltChgHistVO.setResn(resn);
			mbrConsltChgHistVO.setMngrUniqueId(mngrSession.getUniqueId());
			mbrConsltChgHistVO.setMngrId(mngrSession.getMngrId());
			mbrConsltChgHistVO.setMngrNm(mngrSession.getMngrNm());
			mbrConsltService.insertMbrConsltChgHist(mbrConsltChgHistVO);
		}

		Map<String, Object> resultMap = new HashMap<String, Object>();
		resultMap.put("result", result);
		return resultMap;
	}


	@RequestMapping(value = "delConslt.json")
	@ResponseBody
	public Map<String, Object> delConslt(
			@RequestParam(value = "arrDelConslt[]", required=true) String[] consltList
			, HttpServletRequest request
			) throws Exception {

		boolean result = false;
		int resultCnt = 0;

		try {
			for(String consltNo : consltList) {
				resultCnt += mbrConsltService.updateUseYn(EgovStringUtil.string2integer(consltNo));
			}

			if(resultCnt > 0) {
				result = true;
			}

		}catch(Exception e) {
			e.printStackTrace();
			log.debug("delConslt.Json Error : " + e.getMessage());
		}

		Map<String, Object> resultMap = new HashMap<String, Object>();
		resultMap.put("result", result);
		return resultMap;
	}

	public static final Map<String, String> CONSLT_STTUS_MAP = new HashMap<String, String>() {{
	    put("CS01", "상담 신청 접수");
	    put("CS02", "장기요양기관 배정 완료");
	    put("CS03", "상담 취소 (신청자 상담거부)");
	    put("CS04", "상담 취소 (장기요양기관 상담거부)");
	    put("CS05", "상담 진행 중");
	    put("CS06", "상담 완료");
	    put("CS07", "재상담 신청 접수");
	    put("CS08", "장기요양기관 재배정 완료");
	}};


	@RequestMapping("excel")
	public void excelDownload(
			HttpServletRequest request
			, HttpServletResponse response
			, @RequestParam Map<String, Object> reqMap
			, Model model) throws Exception{

		Map<String, Object> paramMap = new HashMap<String, Object>();
		paramMap.put("srchUseYn", "Y");

		List<MbrConsltVO> resultList = mbrConsltService.selectListForExcel(paramMap);
		for(MbrConsltVO mbrConsltVO : resultList) {
			int yyyy =  EgovStringUtil.string2integer(mbrConsltVO.getBrdt().substring(0, 4));
			int mm =  EgovStringUtil.string2integer(mbrConsltVO.getBrdt().substring(4, 6));
			int dd =  EgovStringUtil.string2integer(mbrConsltVO.getBrdt().substring(6, 8));
			mbrConsltVO.setAge(DateUtil.getRealAge(yyyy, mm, dd));
		}

		// excel data
        Map<String, Function<Object, Object>> mapping = new LinkedHashMap<>();
        mapping.put("번호", obj -> "rowNum");
        mapping.put("상담진행상태", obj -> {
        	 String consltSttus = ((MbrConsltVO) obj).getConsltSttus();
        	 return CONSLT_STTUS_MAP.getOrDefault(consltSttus, "");
        });
        mapping.put("사업소배정", obj -> {
        	String rtnStr = "";
        	if(!"CS01".equals( ((MbrConsltVO)obj).getConsltSttus()) ) {
        		int i = 1;
        		for(MbrConsltResultVO mbrConsltResultVO : ((MbrConsltVO)obj).getConsltResultList()) {
        			Date regDt = mbrConsltResultVO.getRegDt();
        			if(regDt == null) {
        				rtnStr += i++ + "차 : " + mbrConsltResultVO.getBplcNm() + "\n";
        			}else {
        				rtnStr += i++ + "차 : " + mbrConsltResultVO.getBplcNm() + "(" + new SimpleDateFormat("yyyy-MM-dd HH:mm").format(mbrConsltResultVO.getRegDt()) + ")\n";
        			}
        		}
        	}
        	if("CS01".equals( ((MbrConsltVO)obj).getConsltSttus()) || EgovStringUtil.isEmpty(((MbrConsltVO)obj).getConsltSttus()) ) {
        		rtnStr = "-";
        	}
        	return rtnStr;
        });

        mapping.put("성명", obj -> ((MbrConsltVO)obj).getMbrNm());
        mapping.put("성별", obj -> CodeMap.GENDER.get(((MbrConsltVO)obj).getGender()));
        mapping.put("연락처", obj -> ((MbrConsltVO)obj).getMbrTelno());
        mapping.put("만나이", obj -> "만 " + ((MbrConsltVO)obj).getAge() + " 세");
        mapping.put("생년월일", obj -> ((MbrConsltVO)obj).getBrdt());
		mapping.put("거주지주소", obj -> ((MbrConsltVO) obj).getZip() + " "
				+ ((MbrConsltVO) obj).getAddr() + " " + ((MbrConsltVO) obj).getDaddr());
        mapping.put("상담신청일", obj -> {
        	String rtnStr = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(((MbrConsltVO)obj).getRegDt());
        	if(((MbrConsltVO)obj).getConsltSttus().equals("CS07") || ((MbrConsltVO)obj).getConsltSttus().equals("CS08")) {
        		Date reConsltDt = ((MbrConsltVO)obj).getReConsltDt();
        		if (reConsltDt == null) {
        	    }else {
        	    	rtnStr += "\n" + new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(reConsltDt);;
        	    }
        	}
        	return rtnStr;
        });


        List<LinkedHashMap<String, Object>> dataList = new ArrayList<>();
        for (MbrConsltVO mbrConsltVO : resultList) {
 		    LinkedHashMap<String, Object> tempMap = new LinkedHashMap<>();
 		    for (String header : mapping.keySet()) {
 		        Function<Object, Object> extractor = mapping.get(header);
 		        if (extractor != null) {
 		            tempMap.put(header, extractor.apply(mbrConsltVO));
 		        }
 		    }
		    dataList.add(tempMap);
		}

		ExcelExporter exporter = new ExcelExporter();
		try {
			exporter.export(response, "장기요양테스트_상담목록", dataList, mapping);
		} catch (IOException e) {
		    e.printStackTrace();
 		}


		model.addAttribute("resultList", resultList);
		model.addAttribute("genderCode", CodeMap.GENDER);
		model.addAttribute("prevPath", CodeMap.PREV_PATH);
		model.addAttribute("mberSttus", CodeMap.MBER_STTUS);

		//return "/manage/consult/recipter/excel";
	}
	
	/**
	 * 모달에서 1:1 상담 수정하기
	 */
	@ResponseBody
	@RequestMapping(value = "/updateMbrConslt.json")
	public Map<String, Object> updateMbrConslt(
			MbrConsltVO mbrConsltVO
		)throws Exception {

		Map <String, Object> resultMap = new HashMap<String, Object>();

		try {
			//요양인정번호를 입력한 경우 조회 가능한지 유효성 체크
			if (EgovStringUtil.isNotEmpty(mbrConsltVO.getRcperRcognNo())) {
				Map<String, Object> returnMap = tilkoApiService.getRecipterInfo(mbrConsltVO.getMbrNm(), mbrConsltVO.getRcperRcognNo());
				
				Boolean result = (Boolean) returnMap.get("result");
				if (result == false) {
					returnMap.put("success", false);
					resultMap.put("msg", "유효한 요양인정번호가 아닙니다.");
					return resultMap;
				}
			}
			
			MbrConsltVO srchMbrConslt = mbrConsltService.selectMbrConsltByConsltNo(mbrConsltVO.getConsltNo());
			srchMbrConslt.setRelationCd(mbrConsltVO.getRelationCd());
			srchMbrConslt.setRcperRcognNo(mbrConsltVO.getRcperRcognNo());
			srchMbrConslt.setMbrTelno(mbrConsltVO.getMbrTelno());
			srchMbrConslt.setZip(mbrConsltVO.getZip());
			srchMbrConslt.setAddr(mbrConsltVO.getAddr());
			srchMbrConslt.setDaddr(mbrConsltVO.getDaddr());
			if(EgovStringUtil.isNotEmpty(mbrConsltVO.getBrdt())) {
				srchMbrConslt.setBrdt(mbrConsltVO.getBrdt().replace("/", ""));
			}
			srchMbrConslt.setGender(mbrConsltVO.getGender());
			srchMbrConslt.setMdfcnMngrUniqueId(mngrSession.getUniqueId());
			srchMbrConslt.setMdfcnMngrId(mngrSession.getMngrId());
			srchMbrConslt.setMdfcnMngrNm(mngrSession.getMngrNm());
			mbrConsltService.updateMbrConsltByMngr(srchMbrConslt);

			resultMap.put("success", true);
		} catch (Exception ex) {
			resultMap.put("success", false);
			resultMap.put("msg", "상담 수정에 실패하였습니다");
		}
		return resultMap;
	}
}
