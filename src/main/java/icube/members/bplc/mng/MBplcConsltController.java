package icube.members.bplc.mng;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.egovframe.rte.fdl.string.EgovStringUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
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
import icube.common.values.CodeMap;
import icube.common.vo.CommonListVO;
import icube.manage.consult.biz.MbrConsltChgHistVO;
import icube.manage.consult.biz.MbrConsltResultService;
import icube.manage.consult.biz.MbrConsltResultVO;
import icube.manage.consult.biz.MbrConsltService;
import icube.manage.consult.biz.MbrConsltVO;
import icube.members.biz.PartnersSession;

@Controller
@RequestMapping(value="#{props['Globals.Members.path']}/{bplcUrl}/mng/conslt")
public class MBplcConsltController extends CommonAbstractController {

	@Resource(name = "mbrConsltService")
	private MbrConsltService mbrConsltService;

	@Resource(name = "mbrConsltResultService")
	private MbrConsltResultService mbrConsltResultService;

	@Autowired
	private PartnersSession partnersSession;
	
	@Value("#{props['Globals.EroumCare.PrivateKey']}")
	private String eroumCarePrivateKey;
	
	private static String[] targetParams = {"curPage", "cntPerPage"};
	

	@RequestMapping(value = "list")
	public String list(
		HttpServletRequest request
		, Model model
		) throws Exception {

		CommonListVO listVO = new CommonListVO(request);
		listVO.setParam("srchUseYn", "Y");
		listVO.setParam("srchBplcUniqueId", partnersSession.getUniqueId());

		listVO = mbrConsltResultService.selectMbrConsltResultListVO(listVO);

		model.addAttribute("listVO", listVO);
		model.addAttribute("genderCode", CodeMap.GENDER);

		return "/members/bplc/mng/conslt/list";
	}


	// 상세내역 + 사업소 상담 내역
	@RequestMapping(value="view")
	public String view(
			@RequestParam(value="consltNo", required=true) int consltNo
			, @RequestParam(value="bplcConsltNo", required=true) int bplcConsltNo
			, @RequestParam Map<String, Object> reqMap
			, HttpServletRequest request
			, Model model) throws Exception{

		Map<String, Object> paramMap = new HashMap<String, Object>();
		paramMap.put("consltNo", consltNo);
		paramMap.put("srchConsltNo", consltNo);
		paramMap.put("srchBplcConsltNo", bplcConsltNo);
		paramMap.put("srchBplcUniqueId", partnersSession.getUniqueId());

		MbrConsltVO mbrConsltVO = mbrConsltService.selectMbrConslt(paramMap);
		MbrConsltResultVO mbrConsltResultVO = mbrConsltResultService.selectMbrConsltBplc(paramMap);

		if(mbrConsltVO == null) {
			model.addAttribute("alertMsg", getMsg("alert.author.common"));
			return "/common/msg";
		}

		model.addAttribute("mbrConsltVO", mbrConsltVO);
		model.addAttribute("mbrConsltResultVO", mbrConsltResultVO);

		model.addAttribute("genderCode", CodeMap.GENDER);

		return "/members/bplc/mng/conslt/view";
	}


	// 상담 완료 처리 (이로움 관리자의 처리와 다름)
	@RequestMapping(value="action")
	public View action(
			MbrConsltResultVO mbrConsltResultVO
			, @RequestParam Map<String,Object> reqMap
			, HttpServletRequest request) throws Exception {

		JavaScript javaScript = new JavaScript();
		String pageParam = HtmlUtils.htmlUnescape(EgovStringUtil.null2void(CommonUtil.getPageParam(targetParams, reqMap)));

		// 상담정보 > 관리자(사업소) 메모 처리
		mbrConsltResultVO.setRegUniqueId(partnersSession.getUniqueId());
		mbrConsltResultVO.setRegId(partnersSession.getPartnersId());
		mbrConsltResultVO.setRgtr(partnersSession.getPartnersNm());

		mbrConsltResultService.updateDtlsConslt(mbrConsltResultVO);

		// 상담 완료 이력 저장
		MbrConsltChgHistVO mbrConsltChgHistVO = new MbrConsltChgHistVO();
		mbrConsltChgHistVO.setConsltNo(mbrConsltResultVO.getConsltNo());
		mbrConsltChgHistVO.setConsltSttusChg("CS06");
		mbrConsltChgHistVO.setBplcConsltNo(mbrConsltResultVO.getBplcConsltNo());
		mbrConsltChgHistVO.setBplcConsltSttusChg("CS06");
		mbrConsltChgHistVO.setConsltBplcUniqueId(partnersSession.getUniqueId());
		mbrConsltChgHistVO.setConsltBplcNm(partnersSession.getPartnersNm());
		mbrConsltChgHistVO.setResn(CodeMap.CONSLT_STTUS_CHG_RESN.get("완료"));
		mbrConsltChgHistVO.setBplcUniqueId(partnersSession.getUniqueId());
		mbrConsltChgHistVO.setBplcId(partnersSession.getPartnersId());
		mbrConsltChgHistVO.setBplcNm(partnersSession.getPartnersNm());
		mbrConsltService.insertMbrConsltChgHist(mbrConsltChgHistVO);
		
		javaScript.setMessage(getMsg("action.complete.update"));
		javaScript.setLocation("./view?bplcConsltNo="+ mbrConsltResultVO.getBplcConsltNo() +"&consltNo=" + mbrConsltResultVO.getConsltNo() + ("".equals(pageParam) ? "" : "&" + pageParam));

		return new JavaScriptView(javaScript);
	}


	// 사업소 상담중 사용자 취소(CS03)
	@RequestMapping(value = "canclConslt.json")
	@ResponseBody
	public Map<String, Object> cancelConslt(
			@RequestParam(value = "consltNo", required=true) int consltNo
			, @RequestParam(value = "bplcConsltNo", required=true) int bplcConsltNo
			, @RequestParam(value = "canclResn", required=true) String canclResn
			, HttpServletRequest request
			) throws Exception {

		boolean result = false;

		Map<String, Object> paramMap = new HashMap<String, Object>();
		paramMap.put("consltSttus", "CS03"); //상담자 취소
		paramMap.put("canclResn", canclResn);
		paramMap.put("consltNo", consltNo);
		paramMap.put("bplcConsltNo", bplcConsltNo);

		int resultCnt = mbrConsltResultService.updateCanclConslt(paramMap);
		if(resultCnt > 0) {
			result = true;
			
			//사용자 취소 이력 저장
			MbrConsltChgHistVO mbrConsltChgHistVO = new MbrConsltChgHistVO();
			mbrConsltChgHistVO.setConsltNo(consltNo);
			mbrConsltChgHistVO.setConsltSttusChg("CS03");
			mbrConsltChgHistVO.setBplcConsltNo(bplcConsltNo);
			mbrConsltChgHistVO.setBplcConsltSttusChg("CS03");
			mbrConsltChgHistVO.setResn(CodeMap.CONSLT_STTUS_CHG_RESN.get("상담자 취소"));
			mbrConsltChgHistVO.setBplcUniqueId(partnersSession.getUniqueId());
			mbrConsltChgHistVO.setBplcId(partnersSession.getPartnersId());
			mbrConsltChgHistVO.setBplcNm(partnersSession.getPartnersNm());
			mbrConsltService.insertMbrConsltChgHist(mbrConsltChgHistVO);
		}

		Map<String, Object> resultMap = new HashMap<String, Object>();
		resultMap.put("result", result);
		return resultMap;
	}


	// 사업소 > 상담수락 or 상담거부
	@RequestMapping(value = "changeSttus.json")
	@ResponseBody
	public Map<String, Object> changeSttus(
			@RequestParam(value = "consltNo", required=true) int consltNo
			, @RequestParam(value = "bplcConsltNo", required=true) int bplcConsltNo
			, @RequestParam(value = "consltSttus", required=true) String consltSttus
			, HttpServletRequest request
			) throws Exception {

		boolean result = false;
		Map<String, Object> resultMap = new HashMap<String, Object>();
		
		try {
			resultMap = mbrConsltResultService.changeSttusForBplc(bplcConsltNo, consltSttus);
			result = (boolean)resultMap.get("success");
		} catch (Exception ex) {
			result = false;
		}

		resultMap = new HashMap<String, Object>();
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
		paramMap.put("srchBplcUniqueId", partnersSession.getUniqueId());

		List<MbrConsltResultVO> resultList = mbrConsltResultService.selectListForExcel(paramMap);
		for(MbrConsltResultVO mbrConsltResultVO : resultList) {
			int yyyy =  EgovStringUtil.string2integer(mbrConsltResultVO.getMbrConsltInfo().getBrdt().substring(0, 4));
			int mm =  EgovStringUtil.string2integer(mbrConsltResultVO.getMbrConsltInfo().getBrdt().substring(4, 6));
			int dd =  EgovStringUtil.string2integer(mbrConsltResultVO.getMbrConsltInfo().getBrdt().substring(6, 8));
			mbrConsltResultVO.getMbrConsltInfo().setAge(DateUtil.getRealAge(yyyy, mm, dd));
		}

		model.addAttribute("resultList", resultList);
		model.addAttribute("genderCode", CodeMap.GENDER);

		return "/members/bplc/mng/conslt/excel";
	}
}
