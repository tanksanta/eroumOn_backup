/*
 *
 */
package icube.manage.consult;

import java.util.ArrayList;
import java.util.Collections;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.egovframe.rte.fdl.string.EgovStringUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.View;
import org.springframework.web.util.HtmlUtils;

import icube.common.framework.abst.CommonAbstractController;
import icube.common.framework.view.JavaScript;
import icube.common.framework.view.JavaScriptView;
import icube.common.util.CommonUtil;
import icube.common.util.DateUtil;
import icube.common.util.HtmlUtil;
import icube.common.values.CodeMap;
import icube.common.vo.CommonListVO;
import icube.manage.consult.biz.ConsltHistory;
import icube.manage.consult.biz.MbrConsltChgHistVO;
import icube.manage.consult.biz.MbrConsltMemoVO;
import icube.manage.consult.biz.MbrConsltResultService;
import icube.manage.consult.biz.MbrConsltResultVO;
import icube.manage.consult.biz.MbrConsltService;
import icube.manage.consult.biz.MbrConsltVO;
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

	@Resource(name = "mbrConsltService")
	private MbrConsltService mbrConsltService;

	@Resource(name = "mbrConsltResultService")
	private MbrConsltResultService mbrConsltResultService;

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

		model.addAttribute("listVO", listVO);
		model.addAttribute("genderCode", CodeMap.GENDER);

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

		model.addAttribute("mbrConsltVO", mbrConsltVO);
		model.addAttribute("genderCode", CodeMap.GENDER);
		model.addAttribute("historyText", historyText);
		model.addAttribute("chgHistList", chgHistList);

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


		if(EgovStringUtil.isNotEmpty(bplcUniqueId) &&
				(EgovStringUtil.equals(mbrConsltVO.getConsltSttus(), "CS02") || EgovStringUtil.equals(mbrConsltVO.getConsltSttus(), "CS08"))) {

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
			
			
			//1:1 상담 배정 이력 추가
			Map<String, Object> srchMap = new HashMap<>();
			srchMap.put("srchConsltNo", mbrConsltVO.getConsltNo());
			MbrConsltResultVO srchConsltResult = mbrConsltResultService.selectMbrConsltBplc(srchMap);
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

		mbrConsltService.updateMbrConslt(mbrConsltVO);


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
			mbrConsltChgHistVO.setBplcConsltNo(mbrConsltResultVO.getBplcConsltNo());
			mbrConsltChgHistVO.setBplcConsltSttusChg("CS09");
			mbrConsltChgHistVO.setConsltBplcUniqueId(mbrConsltResultVO.getBplcUniqueId());
			mbrConsltChgHistVO.setConsltBplcNm(mbrConsltResultVO.getBplcNm());
			mbrConsltChgHistVO.setResn(CodeMap.CONSLT_STTUS_CHG_RESN.get("THKC 취소"));
			mbrConsltChgHistVO.setMngrUniqueId(mngrSession.getUniqueId());
			mbrConsltChgHistVO.setMngrId(mngrSession.getMngrId());
			mbrConsltChgHistVO.setMngrNm(mngrSession.getMngrNm());
			mbrConsltService.insertMbrConsltChgHist(mbrConsltChgHistVO);
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
		paramMap.put("bplcConsltNo", mbrConsltResultVO.getBplcConsltNo());
		int resultCnt = mbrConsltResultService.updateSttus(paramMap);
		
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
			mbrConsltChgHistVO.setBplcConsltNo(mbrConsltResultVO.getBplcConsltNo());
			mbrConsltChgHistVO.setBplcConsltSttusChg(changedSttus);
			mbrConsltChgHistVO.setConsltBplcUniqueId(mbrConsltResultVO.getBplcUniqueId());
			mbrConsltChgHistVO.setConsltBplcNm(mbrConsltResultVO.getBplcNm());
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


	@RequestMapping("excel")
	public String excelDownload(
			HttpServletRequest request
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

		model.addAttribute("resultList", resultList);
		model.addAttribute("genderCode", CodeMap.GENDER);

		return "/manage/consult/recipter/excel";
	}
}
