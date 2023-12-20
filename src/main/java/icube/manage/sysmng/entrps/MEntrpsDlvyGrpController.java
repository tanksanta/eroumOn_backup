package icube.manage.sysmng.entrps;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.egovframe.rte.fdl.string.EgovStringUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import icube.common.framework.abst.CommonAbstractController;
import icube.common.values.CRUD;
import icube.common.values.CodeMap;
import icube.common.vo.CommonListVO;
import icube.manage.gds.gds.biz.GdsService;
import icube.manage.gds.gds.biz.GdsVO;
import icube.manage.sysmng.entrps.biz.EntrpsDlvyGrpService;
import icube.manage.sysmng.entrps.biz.EntrpsDlvyGrpVO;
import icube.manage.sysmng.entrps.biz.EntrpsService;
import icube.manage.sysmng.entrps.biz.EntrpsVO;
import icube.manage.sysmng.mngr.biz.MngrSession;

@Controller
@RequestMapping(value="/_mng/sysmng/entrps/dlvygrp")
public class MEntrpsDlvyGrpController extends CommonAbstractController {

	@Resource(name = "gdsService")
	private GdsService gdsService;

	@Resource(name = "entrpsService")
	private EntrpsService entrpsService;

	@Resource(name = "entrpsDlvyGrpService")
	private EntrpsDlvyGrpService entrpsDlvyGrpService;

	@Autowired
	private MngrSession mngrSession;

	// private static String[] targetParams = {"curPage", "cntPerPage", "srchTarget", "srchText", "sortBy", "srchYn"};

    /**
     * 관리자 관리 > 입점업체 > 리스트
     */
	@RequestMapping(value="list")
	public String list(
			HttpServletRequest request
			, @RequestParam Map<String,Object> reqMap
			, Model model) throws Exception {

		CommonListVO entrpsListVO = new CommonListVO(request);
		entrpsListVO = entrpsService.entrpsListVO(entrpsListVO);

		CommonListVO listVO = new CommonListVO(request);

		int entrpsNo;
		if (reqMap.get("srchTarget") != null && !EgovStringUtil.equals(reqMap.get("srchTarget").toString(), "")){
			entrpsNo = Integer.parseInt(reqMap.get("srchTarget").toString());
			listVO.setParam("srchEntrpsNo", entrpsNo);
		}else  if ( entrpsListVO.getListObject().size() > 0){
			entrpsNo = ((EntrpsVO) (entrpsListVO.getListObject().get(0))).getEntrpsNo();
			listVO.setParam("srchEntrpsNo", entrpsNo);
		}

		listVO = entrpsDlvyGrpService.entrpsDlvyGrpListVO(listVO);

		model.addAttribute("listVO", listVO);
		model.addAttribute("entrpsList", entrpsListVO);
		model.addAttribute("keyTy", CodeMap.ENTRPS_KEY_TY);
		model.addAttribute("useYn", CodeMap.USE_YN);
		model.addAttribute("dlvyCalcTyList", CodeMap.DLVY_CALC_TY_LIST);
		

		return "/manage/sysmng/entrps/dlvygrp/list";
	}

	
	@RequestMapping(value="modalform")
	public String formModal(
			HttpServletRequest request
			, Model model) throws Exception{

		CommonListVO entrpsListVO = new CommonListVO(request);
		entrpsListVO = entrpsService.entrpsListVO(entrpsListVO);

		model.addAttribute("entrpsList", entrpsListVO);
		model.addAttribute("useYnCode", CodeMap.USE_YN);
		model.addAttribute("dlvyCalcTyCode", CodeMap.DLVY_CALC_TY);

		
				
		return "/manage/sysmng/entrps/include/dlvygrp_add_modal";
	}
	
	@RequestMapping(value="{entrpsNo}/choicemodal")
	public String popupChoiceModal(
			HttpServletRequest request
			, @PathVariable int entrpsNo // 카테고리 1
			, Model model) throws Exception{

		CommonListVO entrpsListVO = new CommonListVO(request);
		entrpsListVO = entrpsService.entrpsListVO(entrpsListVO);

		List<EntrpsDlvyGrpVO> entrpsDlvyGrpList = entrpsDlvyGrpService.selectEntrpsDlvyGrpListAll(entrpsNo);

		model.addAttribute("entrpsList", entrpsListVO);
		model.addAttribute("entrpsDlvyGrpList", entrpsDlvyGrpList);
		model.addAttribute("useYnCode", CodeMap.USE_YN);
		model.addAttribute("dlvyCalcTyCode", CodeMap.DLVY_CALC_TY_LIST);
				
		return "/manage/sysmng/entrps/include/dlvygrp_choice_modal";
	}

	@RequestMapping("dlvygrpno.json")
	@ResponseBody
	public Map<String, Object> selectMapByNo(
				@RequestParam(value="entrpsDlvygrpNo", required=false) int entrpsDlvygrpNo
				, @RequestParam(value="entrpsNo", required=false) int entrpsNo
			) throws Exception {//@RequestParam(value="mngrId", required=true) String mngrId

		Map <String, Object> resultMap = new HashMap<String, Object>();

		
		EntrpsDlvyGrpVO entrpsDlvygrpVO = entrpsDlvyGrpService.selectEntrpsDlvyGrpByNo(entrpsDlvygrpNo);
			
		resultMap.put("success", true);
		resultMap.put("resultData", entrpsDlvygrpVO);

		return resultMap;
	}

	@RequestMapping("dlvygrpmodalaction.json")
	@ResponseBody
	public Map<String, Object> dlvygrpModalAction(
		HttpServletRequest request
		, EntrpsDlvyGrpVO entrpsDlvygrpVO
		, @RequestParam Map<String,Object> reqMap
		, Model model
		) throws Exception {

		
		// 관리자정보
		entrpsDlvygrpVO.setRegUniqueId(mngrSession.getUniqueId());
		entrpsDlvygrpVO.setRegId(mngrSession.getMngrId());
		entrpsDlvygrpVO.setRgtr(mngrSession.getMngrNm());
		entrpsDlvygrpVO.setMdfcnUniqueId(mngrSession.getUniqueId());
		entrpsDlvygrpVO.setMdfcnId(mngrSession.getMngrId());
		entrpsDlvygrpVO.setMdfr(mngrSession.getMngrNm());

		if (entrpsDlvygrpVO.getEntrpsDlvygrpNo() > 0){
			entrpsDlvygrpVO.setCrud(CRUD.UPDATE);
			entrpsDlvyGrpService.updateEntrpsDlvyGrp(entrpsDlvygrpVO);
		}else{
			entrpsDlvygrpVO.setCrud(CRUD.CREATE);
			entrpsDlvyGrpService.insertEntrpsDlvyGrp(entrpsDlvygrpVO);
		}
		

		Map <String, Object> resultMap = new HashMap<String, Object>();
		if (entrpsDlvygrpVO.getEntrpsDlvygrpNo() > 0){
			resultMap.put("success", true);

			if (entrpsDlvygrpVO.getCrud() == CRUD.CREATE){
				resultMap.put("sucmsg", getMsg("action.complete.insert"));
			}else{
				resultMap.put("sucmsg", getMsg("action.complete.update"));
			}
			
			
		}
		
		return resultMap;
	}

	@RequestMapping("dlvygrpmodaldelete.json")
	@ResponseBody
	public Map<String, Object> dlvygrpModalDelete(
		HttpServletRequest request
		, EntrpsDlvyGrpVO entrpsDlvygrpVO
		, @RequestParam(value="entrpsDlvygrpNo", required=false) int entrpsDlvygrpNo
		, @RequestParam(value="entrpsNo", required=false) int entrpsNo
		, Model model
		) throws Exception {

		entrpsDlvyGrpService.deleteEntrpsDlvyGrp(entrpsDlvygrpVO);

		Map <String, Object> resultMap = new HashMap<String, Object>();

		resultMap.put("success", true);

		resultMap.put("sucmsg", getMsg("action.complete.delete"));
		
		return resultMap;
	}

	@RequestMapping("dlvygrpgdsreset.json")
	@ResponseBody
	public Map<String, Object> dlvygrpGdsReset(
		HttpServletRequest request
		, GdsVO gdsVO
		, @RequestParam(value="entrpsDlvygrpNo", required=true) int entrpsDlvygrpNo
		, @RequestParam(value="entrpsNo", required=true) int entrpsNo
		, @RequestParam(value="arrGdsNo[]", required=true) String[] arrGdsNo
		, Model model
		) throws Exception {

		gdsService.updateGdsByDlvygrpResetSelected(gdsVO);

		Map <String, Object> resultMap = new HashMap<String, Object>();

		resultMap.put("success", true);

		resultMap.put("sucmsg", getMsg("action.complete.delete"));
		
		return resultMap;
	}

	/**
	 * 관리자 관리 > 입점업체 > 등록 및 수정
	 */
	@RequestMapping(value="detail")
	public String form(
		@RequestParam Map<String, Object> reqMap
		, HttpServletRequest request
		, Model model) throws Exception{

		int entrpsNo = Integer.parseInt(reqMap.get("entrpsNo").toString());
		if (reqMap.get("entrpsNo") != null && !EgovStringUtil.equals(reqMap.get("entrpsNo").toString(), "")){
			EntrpsVO entrpsVO = entrpsService.selectEntrps(entrpsNo);
			model.addAttribute("entrpsVO", entrpsVO);
		}
		if (reqMap.get("entrpsDlvygrpNo") != null && !EgovStringUtil.equals(reqMap.get("entrpsDlvygrpNo").toString(), "")){
			int entrpsDlvygrpNo = Integer.parseInt(reqMap.get("entrpsDlvygrpNo").toString());
			EntrpsDlvyGrpVO entrpsDlvygrpVO = entrpsDlvyGrpService.selectEntrpsDlvyGrpByNo(entrpsDlvygrpNo);
			if (entrpsDlvygrpVO.getEntrpsNo() != entrpsNo){
				return "";
			}
			
			model.addAttribute("entrpsDlvygrpVO", entrpsDlvygrpVO);
			

			CommonListVO gdsList = new CommonListVO(request);
			gdsList.setParam("entrpsNo", entrpsNo);
			gdsList.setParam("entrpsDlvygrpNo", entrpsDlvygrpNo);

			gdsList = gdsService.selectGdsListByDlvygrp(gdsList);
			model.addAttribute("gdsList", gdsList);
		}

		model.addAttribute("param", reqMap);
		model.addAttribute("dlvyCalcTyList", CodeMap.DLVY_CALC_TY);

		model.addAttribute("dspyYnCode", CodeMap.DSPY_YN);
		model.addAttribute("useYnCode", CodeMap.USE_YN);
		model.addAttribute("gdsTyCode", CodeMap.GDS_TY);
		model.addAttribute("gdsTagCode", CodeMap.GDS_TAG);

		return "/manage/sysmng/entrps/dlvygrp/detail";
	}



}
