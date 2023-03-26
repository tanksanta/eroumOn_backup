package icube.manage.sysmng.menu;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.egovframe.rte.fdl.string.EgovStringUtil;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import icube.common.framework.abst.CommonAbstractController;
import icube.common.values.CodeMap;
import icube.manage.sysmng.menu.biz.MngMenuService;
import icube.manage.sysmng.menu.biz.MngMenuVO;

@Controller
@RequestMapping(value = "/_mng/sysmng/menu")
public class MMngMenuController extends CommonAbstractController {

	@Resource(name="mngMenuService")
	private MngMenuService mngMenuService;

	@RequestMapping(value="form")
	public String form(
			MngMenuVO mngMenuVO
			, HttpServletRequest request
			, Model model) throws Exception{

		model.addAttribute("useYnCode", CodeMap.USE_YN);
		model.addAttribute("mngMenuTyCode", CodeMap.MNG_MENU_TY);

		return "/manage/sysmng/menu/form";
	}


	@ResponseBody
	@RequestMapping("action.json")
	public Map<String, Object> action(
			MngMenuVO mngMenuVO) throws Exception {

		Map<String, Object> resultMap = new HashMap<String, Object>();
		String result = "N";
		String resultMsg = "";

		switch (mngMenuVO.getCrud()) {
		case CREATE:
			mngMenuService.insertMngMenu(mngMenuVO);
			result = "Y";
			resultMsg = getMsg("action.complete.insert");
			break;

		case UPDATE:
			mngMenuService.updateMngMenu(mngMenuVO);
			// 사용여부를 아니오(N) 선택시 하위메뉴 일괄 적용, Y/N 둘다 처리하려면 if 삭제
			if (EgovStringUtil.equals(mngMenuVO.getUseYn(), "N")) {
				mngMenuService.updateLowerMenuUseYn(mngMenuVO);
			}

			result = "Y";
			resultMsg = getMsg("action.complete.update");
			break;

		case DELETE:
			mngMenuService.deleteMngMenu(mngMenuVO.getMenuNo());

			result = "Y";
			resultMsg = getMsg("action.complete.delete");
			break;

		default:
			break;
		}

		resultMap.put("result", result);
		resultMap.put("resultMsg", resultMsg);
		resultMap.put("menuNo", mngMenuVO.getMenuNo());

		return resultMap;
	}


	@ResponseBody
	@RequestMapping("getMenuList.json")
	public List<MngMenuVO> getMenuList() throws Exception {
		List<MngMenuVO> list = (List<MngMenuVO>) mngMenuService.selectMngMenuList();
		return list;
	}


	@ResponseBody
	@RequestMapping("setMenuUseYn.json")
	public Map<String, Object> setMenuUseYn(
			@RequestParam(required = true) String menuNo
			, @RequestParam(required = true) String useYn
			, MngMenuVO mngMenuVO) throws Exception {

		int resultCnt = mngMenuService.updateMenuUseYn(mngMenuVO);
		if (resultCnt > 0 && "N".equals(useYn)) {
			mngMenuService.updateLowerMenuUseYn(mngMenuVO);
		}

		Map<String, Object> paramMap = new HashMap<String, Object>();
		paramMap.put("result", resultCnt > 0);

		return paramMap;
	}


	@ResponseBody
	@RequestMapping("setNewMenu.json")
	public Map<String, Object> setNewMenu(
			MngMenuVO mngMenuVO
			, @RequestParam Map<String, String> reqMap
			, HttpServletRequest request
			) throws Exception {

		Map<String, Object> resMap = new HashMap<String, Object>();

		mngMenuService.insertMngMenu(mngMenuVO);

		resMap.put("oldId", reqMap.get("id"));
		resMap.put("vo", mngMenuVO);

		return resMap;
	}


	@ResponseBody
	@RequestMapping("setMenuName.json")
	public Map<String, Object> setMenuName(
			@RequestParam(required = true) int menuNo
			, @RequestParam(required = true) String menuNm
			, HttpServletRequest request
			) throws Exception {

		Map<String, Object> resMap = new HashMap<String, Object>();
		resMap.put("menuNo", menuNo);
		resMap.put("menuNm", menuNm);

		int result = mngMenuService.updateMngMenuNm(resMap);
		resMap.put("result", result==1);
		return resMap;
	}


	@ResponseBody
	@RequestMapping("moveMenu.json")
	public Map<String, Object> moveMenu(
			@RequestParam(required = true) int menuNo
			, @RequestParam(required = true) int upMenuNo
			, @RequestParam(required = true) int sortNo
			, @RequestParam(required = true) String sortSeq
			, HttpServletRequest request
			) throws Exception {

		MngMenuVO mngMenuVO = new MngMenuVO();
		mngMenuVO.setMenuNo(menuNo);
		mngMenuVO.setUpMenuNo(upMenuNo);
		mngMenuVO.setSortNo(sortNo);

		boolean ok = false;
		try {
			mngMenuService.moveMngMenu(mngMenuVO, sortSeq);
			ok = true;
		} catch(Exception e) {
			log.debug(e.getMessage());
		}

		Map<String, Object> result = new HashMap<String, Object>();
		result.put("result", ok);

		return result;
	}


	@ResponseBody
	@RequestMapping("getMngMenu.json")
	public MngMenuVO getMngMenu(
			@RequestParam(required = true) int menuNo
			) throws Exception{

		MngMenuVO mngMenuVO = mngMenuService.selectMngMenu(menuNo);

		return mngMenuVO;
	}


	@ResponseBody
	@RequestMapping("hasChildMenu")
	public String hasChildMenu(
			@RequestParam(value="menuNo", required=true) String menuNo
			) throws Exception {

		String rtnVal = "false";

		Map<String, Object> paramMap = new HashMap<String, Object>();
		paramMap.put("menuNo", menuNo);

		Integer resultCnt = mngMenuService.selectLowerMenuCheck(paramMap);
		if (resultCnt == 0) {
			rtnVal = "true";
		}
		return rtnVal;
	}

}
