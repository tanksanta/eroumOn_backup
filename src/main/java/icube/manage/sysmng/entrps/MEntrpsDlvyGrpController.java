package icube.manage.sysmng.entrps;

import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;
import java.util.function.Function;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

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
import icube.common.util.ExcelExporter;
import icube.common.values.CRUD;
import icube.common.values.CodeMap;
import icube.common.vo.CommonListVO;
import icube.manage.sysmng.entrps.biz.EntrpsDlvyGrpService;
import icube.manage.sysmng.entrps.biz.EntrpsService;
import icube.manage.sysmng.entrps.biz.EntrpsVO;
import icube.manage.sysmng.mngr.biz.MngrSession;

@Controller
@RequestMapping(value="/_mng/sysmng/entrps/dlvygrp")
public class MEntrpsDlvyGrpController extends CommonAbstractController {

	@Resource(name = "entrpsService")
	private EntrpsService entrpsService;

	@Resource(name = "entrpsDlvyGrpService")
	private EntrpsDlvyGrpService entrpsDlvyGrpService;

	@Autowired
	private MngrSession mngrSession;

	private static String[] targetParams = {"curPage", "cntPerPage", "srchTarget", "srchText", "sortBy", "srchYn"};

    /**
     * 관리자 관리 > 입점업체 > 리스트
     */
	@RequestMapping(value="list")
	public String list(
			HttpServletRequest request
			, Model model) throws Exception {

		CommonListVO entrpsListVO = new CommonListVO(request);
		entrpsListVO = entrpsService.entrpsListVO(entrpsListVO);

		CommonListVO listVO = new CommonListVO(request);

		if (entrpsListVO.getListObject().size() > 0){
			int entrpsNo = ((EntrpsVO) (entrpsListVO.getListObject().get(0))).getEntrpsNo();
			listVO.setParam("srchEntrpsNo", entrpsNo);
		}

		listVO = entrpsDlvyGrpService.entrpsDlvyGrpListVO(listVO);

		model.addAttribute("listVO", listVO);
		model.addAttribute("entrpsList", entrpsListVO);
		model.addAttribute("keyTy", CodeMap.ENTRPS_KEY_TY);
		model.addAttribute("useYn", CodeMap.USE_YN);

		return "/manage/sysmng/entrps/dlvygrp/list";
	}

	
	@RequestMapping(value="modalform")
	public String formModal(
			HttpServletRequest request
			, Model model) throws Exception{
		return "/manage/sysmng/entrps/include/dlvygrp_form";
	}

	@RequestMapping("modal.json")
	@ResponseBody
	public Map<String, Object> magrIdCheck(
			) throws Exception {//@RequestParam(value="mngrId", required=true) String mngrId

		Map<String, Object> paramMap = new HashMap<String, Object>();
		// paramMap.put("mngrId", mngrId);

		// Map<String, Object> resultMap = mngrService.mngrIdCheck(paramMap);
		// if (resultMap == null) {
		// 	paramMap.put("isUsed", false);
		// } else {
		// 	paramMap.put("isUsed", true);
		// }

		return paramMap;
	}


	/**
	 * 관리자 관리 > 입점업체 > 등록 및 수정
	 */
	@RequestMapping(value="form")
	public String form(
			EntrpsVO entrpsVO
			, @RequestParam Map<String, Object> reqMap
			, HttpServletRequest request
			, Model model) throws Exception{

		int entrpsNo = EgovStringUtil.string2integer((String) reqMap.get("entrpsNo"));

		if(entrpsNo == 0){
			entrpsVO.setCrud(CRUD.CREATE);
		}else{
			entrpsVO = entrpsService.selectEntrps(entrpsNo);
			entrpsVO.setCrud(CRUD.UPDATE);
		}


		model.addAttribute("entrpsVO", entrpsVO);
		model.addAttribute("param", reqMap);
		model.addAttribute("useYn", CodeMap.USE_YN);
		model.addAttribute("cycle", CodeMap.CLCLN_CYCLE);		//정산주기
		model.addAttribute("bank", CodeMap.BANK_NM);
		model.addAttribute("job", CodeMap.PIC_JOB);

		return "/manage/sysmng/entrps/dlvygrp/form";
	}


	/**
	 * 관리자 관리 > 입점 업체 > 정보 처리
	 */
	@RequestMapping(value="action")
	public View action(
			EntrpsVO entrpsVO
			, @RequestParam Map<String,Object> reqMap
			, HttpSession session) throws Exception {

		JavaScript javaScript = new JavaScript();
		String pageParam = HtmlUtils.htmlUnescape(EgovStringUtil.null2void(CommonUtil.getPageParam(targetParams, reqMap)));

		// 관리자정보
		entrpsVO.setRegUniqueId(mngrSession.getUniqueId());
		entrpsVO.setRegId(mngrSession.getMngrId());
		entrpsVO.setRgtr(mngrSession.getMngrNm());
		entrpsVO.setMdfcnUniqueId(mngrSession.getUniqueId());
		entrpsVO.setMdfcnId(mngrSession.getMngrId());
		entrpsVO.setMdfr(mngrSession.getMngrNm());

		switch (entrpsVO.getCrud()) {
			case CREATE:

				entrpsService.insertEntrps(entrpsVO);
				javaScript.setMessage(getMsg("action.complete.insert"));
				javaScript.setLocation("./list?" + pageParam);
				break;

			case UPDATE:
				entrpsService.updateEntrps(entrpsVO);

				javaScript.setMessage(getMsg("action.complete.update"));
				javaScript.setLocation(
					"./form?entrpsNo=" + entrpsVO.getEntrpsNo() + ("".equals(pageParam) ? "" : "&" + pageParam));
				break;
			default:
				break;

		}

		return new JavaScriptView(javaScript);
	}

	/**
	 * 엑셀 다운로드
	 * @param request
	 * @param model
	 * @return list
	 */
	@RequestMapping(value = "excel")
	public void excelDownload(
			HttpServletRequest request
			, HttpServletResponse response
			, @RequestParam Map<String, Object> reqMap
			, Model model ) throws Exception {

		Map<String, Object> paramMap = new HashMap<String, Object>();
		List<EntrpsVO> entrpsList = entrpsService.selectEntrpsListAll(paramMap);

		// excel data
        Map<String, Function<Object, Object>> mapping = new LinkedHashMap<>();
        mapping.put("번호", obj -> "rowNum");
        mapping.put("상호/법인명", obj -> ((EntrpsVO)obj).getEntrpsNm());
        mapping.put("담당자", obj -> ((EntrpsVO)obj).getPicNm());
        mapping.put("사업자번호", obj -> ((EntrpsVO)obj).getBrno());
        mapping.put("대표자", obj -> ((EntrpsVO)obj).getRprsvNm());
        mapping.put("등록일", obj ->  new SimpleDateFormat("yyyy-MM-dd").format(((EntrpsVO)obj).getRegDt()));
        mapping.put("상태", obj -> CodeMap.USE_YN.get( ((EntrpsVO)obj).getUseYn()) );

        List<LinkedHashMap<String, Object>> dataList = new ArrayList<>();
        for (EntrpsVO entrpsVO : entrpsList) {
 		    LinkedHashMap<String, Object> tempMap = new LinkedHashMap<>();
 		    for (String header : mapping.keySet()) {
 		        Function<Object, Object> extractor = mapping.get(header);
 		        if (extractor != null) {
 		            tempMap.put(header, extractor.apply(entrpsVO));
 		        }
 		    }
		    dataList.add(tempMap);
		}

		ExcelExporter exporter = new ExcelExporter();
		try {
			exporter.export(response, "입점업체_목록", dataList, mapping);
		} catch (IOException e) {
		    e.printStackTrace();
 		}

	}


}
