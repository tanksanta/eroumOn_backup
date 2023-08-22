package icube.membership.info;

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

import icube.common.framework.abst.CommonAbstractController;
import icube.common.framework.view.JavaScript;
import icube.common.framework.view.JavaScriptView;
import icube.common.values.CRUD;
import icube.market.mbr.biz.MbrSession;
import icube.membership.info.biz.DlvyService;
import icube.membership.info.biz.DlvyVO;

/**
 * 마이페이지 > 회원정보 > 배송지 관리
 *
 * 20230815 kkm : market -> mambership
 */

@Controller
@RequestMapping(value = "#{props['Globals.Membership.path']}/info/dlvy")
public class MbrsDlvyController extends CommonAbstractController {

	@Resource(name = "dlvyService")
	private DlvyService dlvyService;

	@Autowired
	private MbrSession mbrSession;

	@Value("#{props['Globals.Market.path']}")
	private String marketPath;

	/**
	 * 배송지 관리 목록
	 * @param request
	 * @param model
	 * @param dlvyVO
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="list")
	public String list(
			HttpServletRequest request
			, Model model
			) throws Exception {


		Map<String, Object> paramMap = new HashMap<String, Object>();
		paramMap.put("srchUniqueId", mbrSession.getUniqueId());
		paramMap.put("srchUseYn", "Y");

		List<DlvyVO> resultList = dlvyService.selectDlvyListAll(paramMap);

		model.addAttribute("resultList", resultList);

		return "/membership/info/dlvy/list";
	}

	/**
	 * 배송지 관리 모달
	 * @param request
	 * @param model
	 * @param uniqueId
	 * @param dlvyMngNo
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="dlvyMngModal")
	@SuppressWarnings({"rawtypes","unchecked"})
	public String dlvyMngModal(
			HttpServletRequest request
			, Model model
			, DlvyVO dlvyVO
			, @RequestParam Map <String, Object> reqMap
			) throws Exception{

		int dlvyMngNo = EgovStringUtil.string2integer((String)reqMap.get("dlvyMngNo"));

		if(dlvyMngNo == 0) {
			dlvyVO.setCrud(CRUD.CREATE);
		}else {
			Map paramMap = new HashMap();
			paramMap.put("srchDlvyMngNo", dlvyMngNo);
			paramMap.put("srchUniqueId", mbrSession.getUniqueId());

			dlvyVO = dlvyService.selectDlvy(paramMap);
			dlvyVO.setCrud(CRUD.UPDATE);
		}

		model.addAttribute("dlvyVO", dlvyVO);


		return "/membership/info/dlvy/include/dlvy-mng-modal";
	}

	/**
	 * 배송지 관리 처리
	 * @param request
	 * @param model
	 * @param dlvyVO
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="action")
	public View action(
			HttpServletRequest request
			, Model model
			, DlvyVO dlvyVO
			) throws Exception {

		JavaScript javaScript = new JavaScript();

		//등록자 정보
		dlvyVO.setUniqueId(mbrSession.getUniqueId());
		dlvyVO.setRegId(mbrSession.getMbrId());
		dlvyVO.setRegUniqueId(mbrSession.getUniqueId());
		dlvyVO.setRgtr(mbrSession.getMbrNm());

		Map<String, Object> paramMap = new HashMap<String, Object>();


		switch (dlvyVO.getCrud()) {
		case CREATE:

			dlvyService.insertDlvyCoMng(dlvyVO);

			if(EgovStringUtil.isNotEmpty(dlvyVO.getBassDlvyYn()) && dlvyVO.getBassDlvyYn().equals("Y")) {
				paramMap.put("srchUniqueId", mbrSession.getUniqueId());
				paramMap.put("srchBassDlvyYn", "N");
				dlvyService.updateBassDlvy(paramMap);

				paramMap.put("srchBassDlvyYn", "Y");
				paramMap.put("srchDlvyMngNo", dlvyVO.getDlvyMngNo());
				dlvyService.updateBassDlvy(paramMap);
			}else if(EgovStringUtil.isNull(dlvyVO.getBassDlvyYn())){
				paramMap.put("srchDlvyMngNo", dlvyVO.getDlvyMngNo());
				paramMap.put("srchBassDlvyYn", "N");
				dlvyService.updateBassDlvy(paramMap);
			}

			javaScript.setMessage(getMsg("action.complete.insert"));
			javaScript.setLocation("./list");
			break;

		case UPDATE:


			dlvyService.updateDlvyCoMng(dlvyVO);

			if(EgovStringUtil.isNotEmpty(dlvyVO.getBassDlvyYn()) && dlvyVO.getBassDlvyYn().equals("Y")) {
				paramMap.put("srchUniqueId", mbrSession.getUniqueId());
				paramMap.put("srchBassDlvyYn", "N");
				dlvyService.updateBassDlvy(paramMap);

				paramMap.put("srchBassDlvyYn", "Y");
				paramMap.put("srchDlvyMngNo", dlvyVO.getDlvyMngNo());
				dlvyService.updateBassDlvy(paramMap);
			}else if(EgovStringUtil.isNull(dlvyVO.getBassDlvyYn())){
				paramMap.put("srchDlvyMngNo", dlvyVO.getDlvyMngNo());
				paramMap.put("srchBassDlvyYn", "N");
				dlvyService.updateBassDlvy(paramMap);
			}

			javaScript.setMessage(getMsg("action.complete.update"));
			javaScript.setLocation("./list");
			break;

			default:
				break;

		}

		return new JavaScriptView(javaScript);
	}


	/**
	 * 배송지 삭제
	 * @param request
	 * @param model
	 * @param dlvyMngNo
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="delDlvyMng.json")
	@SuppressWarnings({"rawtypes","unchecked"})
	@ResponseBody
	public Map delDlvyMng(
			HttpServletRequest request
			, Model model
			, @RequestParam(value="dlvyMngNo",required=true) int dlvyMngNo
			) throws Exception {

		Map resultMap = new HashMap();

		boolean result = false;

		try {
			Map paramMap = new HashMap();
			paramMap.put("uniqueId", mbrSession.getUniqueId());
			paramMap.put("dlvyMngNo", dlvyMngNo);
			dlvyService.deleteDlvyCoMng(paramMap);

			result = true;

		}catch(Exception e) {
			e.printStackTrace();
			log.debug("DELETE DLVY MNG ERROR");
		}

		resultMap.put("result", result);

		return resultMap;
	}

	/**
	 * 기본 배송지 카운트 검사
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="baseDlvyChk.json")
	@SuppressWarnings({"rawtypes","unchecked"})
	public Map baseDlvyChk(
			HttpServletRequest request
			, Model model
			, @RequestParam(value="paramType", required=false) String type
			) throws Exception {
		Map resultMap = new HashMap();

		boolean result = false;

		Map paramMap = new HashMap();
		paramMap.put("srchUniqueId", mbrSession.getUniqueId());

		if(type.equals("regist")) {
			paramMap.put("srchUseYn", "Y");
			int baseCnt = dlvyService.selectBassCount(paramMap);
			result = true;
			resultMap.put("totalCount", baseCnt);

		resultMap.put("result", result);

		}
		return resultMap;
	}



}
