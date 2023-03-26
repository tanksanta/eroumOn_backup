package icube.manage.clcln;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.egovframe.rte.fdl.string.EgovStringUtil;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import icube.common.framework.abst.CommonAbstractController;
import icube.common.util.DateUtil;
import icube.common.values.CodeMap;
import icube.manage.clcln.biz.ClclnService;
import icube.manage.ordr.dtl.biz.OrdrDtlVO;

@Controller
@RequestMapping(value="/_mng/clcln")
public class MClclnController extends CommonAbstractController {

	@Resource(name = "clclnService")
	private ClclnService clclnService;

	// Page Parameter Keys
	private static String[] targetParams = {"curPage", "cntPerPage", "srchTarget", "srchText", "sortBy"};

	// 마켓정산
	@RequestMapping(value="/market/list")
	public String marketList(
			@RequestParam Map<String, Object> reqMap
			, HttpServletRequest request
			, Model model) throws Exception {


		String srchOrdrYmdBgng = (String) reqMap.get("srchOrdrYmdBgng");
		if(EgovStringUtil.isEmpty(srchOrdrYmdBgng)) {
			srchOrdrYmdBgng = DateUtil.getCurrentDateTime("yyyy-MM-dd");
		}
		String srchOrdrYmdEnd = (String) reqMap.get("srchOrdrYmdEnd");
		if(EgovStringUtil.isEmpty(srchOrdrYmdEnd)) {
			srchOrdrYmdEnd = DateUtil.getCurrentDateTime("yyyy-MM-dd");
		}

		Map<String, Object> paramMap = new HashMap<String, Object>();
		paramMap.put("srchOrdrYmdBgng", srchOrdrYmdBgng);
		paramMap.put("srchOrdrYmdEnd", srchOrdrYmdEnd);

		List<OrdrDtlVO> resultList = clclnService.selectOrdrList(paramMap);

		model.addAttribute("gdsTyCode", CodeMap.GDS_TY);
		model.addAttribute("bassStlmTyCode", CodeMap.BASS_STLM_TY);
		model.addAttribute("ordrSttsCode", CodeMap.ORDR_STTS);

		model.addAttribute("ordrList", resultList);

		model.addAttribute("srchOrdrYmdBgng", srchOrdrYmdBgng);
		model.addAttribute("srchOrdrYmdEnd", srchOrdrYmdEnd);

		return "/manage/clcln/market_list";
	}


	@RequestMapping(value="/market/excelDown")
	public String marketExcel(
			@RequestParam Map<String, Object> reqMap
			, HttpServletRequest request
			, Model model) throws Exception {


		String srchOrdrYmdBgng = (String) reqMap.get("srchOrdrYmdBgng");
		if(EgovStringUtil.isEmpty(srchOrdrYmdBgng)) {
			srchOrdrYmdBgng = DateUtil.getCurrentDateTime("yyyy-MM-dd");
		}
		String srchOrdrYmdEnd = (String) reqMap.get("srchOrdrYmdEnd");
		if(EgovStringUtil.isEmpty(srchOrdrYmdEnd)) {
			srchOrdrYmdEnd = DateUtil.getCurrentDateTime("yyyy-MM-dd");
		}

		Map<String, Object> paramMap = new HashMap<String, Object>();
		paramMap.put("srchOrdrYmdBgng", srchOrdrYmdBgng);
		paramMap.put("srchOrdrYmdEnd", srchOrdrYmdEnd);

		List<OrdrDtlVO> resultList = clclnService.selectOrdrList(paramMap);

		model.addAttribute("gdsTyCode", CodeMap.GDS_TY);
		model.addAttribute("bassStlmTyCode", CodeMap.BASS_STLM_TY);
		model.addAttribute("ordrSttsCode", CodeMap.ORDR_STTS);

		model.addAttribute("ordrList", resultList);

		model.addAttribute("srchOrdrYmdBgng", srchOrdrYmdBgng);
		model.addAttribute("srchOrdrYmdEnd", srchOrdrYmdEnd);

		return "/manage/clcln/include/market_excel";
	}



	// partners > 사업소 전체
	@RequestMapping(value="/partners/list")
	public String partnersList(
			@RequestParam Map<String, Object> reqMap
			, HttpServletRequest request
			, Model model) throws Exception {

		String srchBplcNm = (String) reqMap.get("srchBplcNm");

		String srchOrdrYmdBgng = (String) reqMap.get("srchOrdrYmdBgng");
		if(EgovStringUtil.isEmpty(srchOrdrYmdBgng)) {
			srchOrdrYmdBgng = DateUtil.getCurrentDateTime("yyyy-MM-dd");
		}
		String srchOrdrYmdEnd = (String) reqMap.get("srchOrdrYmdEnd");
		if(EgovStringUtil.isEmpty(srchOrdrYmdEnd)) {
			srchOrdrYmdEnd = DateUtil.getCurrentDateTime("yyyy-MM-dd");
		}

		Map<String, Object> paramMap = new HashMap<String, Object>();
		paramMap.put("srchBplcNm", srchBplcNm);
		paramMap.put("srchOrdrYmdBgng", srchOrdrYmdBgng);
		paramMap.put("srchOrdrYmdEnd", srchOrdrYmdEnd);

		List<Map<String, Object>> resultList = clclnService.selectPartnerList(paramMap);

		model.addAttribute("ordrList", resultList);

		model.addAttribute("srchOrdrYmdBgng", srchOrdrYmdBgng);
		model.addAttribute("srchOrdrYmdEnd", srchOrdrYmdEnd);

		return "/manage/clcln/partner_list";
	}

	// blpc > 사업소 별
	@RequestMapping(value="/partners/{bplcUniqueId}/list")
	public String bplcList(
			@PathVariable String bplcUniqueId
			, @RequestParam Map<String, Object> reqMap
			, HttpServletRequest request
			, Model model) throws Exception {

		String srchOrdrYmdBgng = (String) reqMap.get("srchOrdrYmdBgng");
		if(EgovStringUtil.isEmpty(srchOrdrYmdBgng)) {
			srchOrdrYmdBgng = DateUtil.getCurrentDateTime("yyyy-MM-dd");
		}
		String srchOrdrYmdEnd = (String) reqMap.get("srchOrdrYmdEnd");
		if(EgovStringUtil.isEmpty(srchOrdrYmdEnd)) {
			srchOrdrYmdEnd = DateUtil.getCurrentDateTime("yyyy-MM-dd");
		}

		Map<String, Object> paramMap = new HashMap<String, Object>();
		paramMap.put("srchBplcUniqueId", bplcUniqueId);
		paramMap.put("srchOrdrYmdBgng", srchOrdrYmdBgng);
		paramMap.put("srchOrdrYmdEnd", srchOrdrYmdEnd);


		List<OrdrDtlVO> resultList = clclnService.selectOrdrList(paramMap);

		model.addAttribute("gdsTyCode", CodeMap.GDS_TY);
		model.addAttribute("bassStlmTyCode", CodeMap.BASS_STLM_TY);
		model.addAttribute("ordrSttsCode", CodeMap.ORDR_STTS);

		model.addAttribute("ordrList", resultList);

		model.addAttribute("srchOrdrYmdBgng", srchOrdrYmdBgng);
		model.addAttribute("srchOrdrYmdEnd", srchOrdrYmdEnd);


		return "/manage/clcln/bplc_list";
	}

}
