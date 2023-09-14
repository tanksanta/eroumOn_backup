/*
 *
 */
package icube.manage.consult;

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

		model.addAttribute("mbrConsltVO", mbrConsltVO);
		model.addAttribute("genderCode", CodeMap.GENDER);

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
