package icube.members.bplc.mng;

import java.util.HashMap;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.egovframe.rte.fdl.string.EgovStringUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.View;
import org.springframework.web.util.HtmlUtils;

import icube.common.framework.abst.CommonAbstractController;
import icube.common.framework.view.JavaScript;
import icube.common.framework.view.JavaScriptView;
import icube.common.util.CommonUtil;
import icube.common.values.CodeMap;
import icube.common.vo.CommonListVO;
import icube.manage.consult.biz.MbrConsltResultService;
import icube.manage.consult.biz.MbrConsltResultVO;
import icube.manage.consult.biz.MbrConsltService;
import icube.manage.consult.biz.MbrConsltVO;
import icube.manage.members.bplc.biz.BplcVO;
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
		//listVO = mbrConsltService.formatMbrConsltVO(listVO);

		model.addAttribute("listVO", listVO);
		model.addAttribute("genderCode", CodeMap.GENDER);

		return "/members/bplc/mng/conslt/list";
	}


	// 상세내역 + 사업소 상담 내역
	@RequestMapping(value="view")
	public String view(
			@RequestParam(value="consltNo", required=true) int consltNo
			, @RequestParam Map<String, Object> reqMap
			, HttpServletRequest request
			, Model model) throws Exception{

		Map<String, Object> paramMap = new HashMap<String, Object>();
		paramMap.put("consltNo", consltNo);
		paramMap.put("srchConsltNo", consltNo);
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


	// 처리 (이로움 관리자의 처리와 다름)
	@RequestMapping(value="action")
	public View action(
			MbrConsltResultVO mbrConsltResultVO
			, @RequestParam Map<String,Object> reqMap
			, HttpServletRequest request) throws Exception {

		JavaScript javaScript = new JavaScript();
		String pageParam = HtmlUtils.htmlUnescape(EgovStringUtil.null2void(CommonUtil.getPageParam(targetParams, reqMap)));

		// 사업소 선택 정보 처리
		String bplcUniqueId = (String) reqMap.get("bplcUniqueId");
		String bplcId = (String) reqMap.get("bplcId");
		String bplcNm = (String) reqMap.get("bplcNm");


		// 상담정보 > 관리자(사업소) 메모 처리
		mbrConsltResultVO.setRegUniqueId(partnersSession.getUniqueId());
		mbrConsltResultVO.setRegId(partnersSession.getPartnersId());
		mbrConsltResultVO.setRgtr(partnersSession.getPartnersNm());

		mbrConsltResultService.updateDtlsConslt(mbrConsltResultVO);


		javaScript.setMessage(getMsg("action.complete.update"));
		javaScript.setLocation("./view?consltNo=" + mbrConsltResultVO.getConsltNo() + ("".equals(pageParam) ? "" : "&" + pageParam));

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
		paramMap.put("consltSttus", "CS03"); //상담자 취소
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

}
