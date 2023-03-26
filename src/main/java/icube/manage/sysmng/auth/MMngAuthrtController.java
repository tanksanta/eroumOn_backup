package icube.manage.sysmng.auth;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.egovframe.rte.fdl.string.EgovStringUtil;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.View;

import icube.common.framework.abst.CommonAbstractController;
import icube.common.framework.view.JavaScript;
import icube.common.framework.view.JavaScriptView;
import icube.common.util.HtmlUtil;
import icube.common.values.CRUD;
import icube.common.values.CodeMap;
import icube.common.vo.CommonListVO;
import icube.manage.sysmng.auth.biz.MngAuthrtService;
import icube.manage.sysmng.auth.biz.MngAuthrtVO;
import icube.manage.sysmng.menu.biz.MngMenuService;
import icube.manage.sysmng.menu.biz.MngMenuVO;

/**
 * 화면사용x
 */
@Controller
@RequestMapping(value = "/_mng/sysmng/mngAuthrt")
public class MMngAuthrtController extends CommonAbstractController {

	@Resource(name="mngAuthrtService")
	private MngAuthrtService mngAuthrtService;

	@Resource(name="mngMenuService")
	private MngMenuService mngMenuService;


	@RequestMapping(value="list")
	public String list(
			HttpServletRequest request
			, Model model) throws Exception{

		CommonListVO listVO = new CommonListVO(request);
		listVO = mngAuthrtService.mngAuthrtListVO(listVO);

		model.addAttribute("listVO", listVO);
		model.addAttribute("authTyMap", CodeMap.MNGR_AUTH_TY);

		return "/manage/sysmng/mng-authrt/list";
	}

	@RequestMapping(value="view")
	public String view(
			HttpServletRequest request,
			@RequestParam(required=true) int authrtNo
			, @RequestParam Map<String,Object> reqMap
			, Model model) throws Exception{

		MngAuthrtVO mngAuthrtVO = mngAuthrtService.selectMngAuthrt(authrtNo);
		mngAuthrtVO.setMemo(HtmlUtil.enterToBr(mngAuthrtVO.getMemo()));

		List<MngMenuVO> mngMenuList = mngMenuService.selectMngMenuAuthList(authrtNo, "");

		model.addAttribute("mngMenuList", mngMenuList);
		model.addAttribute("mngAuthrtVO", mngAuthrtVO);
		model.addAttribute("authTyMap", CodeMap.MNGR_AUTH_TY);

		return "/manage/sysmng/mng-authrt/view";
	}

	@SuppressWarnings("unchecked")
	@RequestMapping(value="form")
	public String form(
			MngAuthrtVO mngAuthrtVO
			, @RequestParam Map<String,Object> reqMap
			, HttpServletRequest request
			, Model model) throws Exception{

		int authrtNo = EgovStringUtil.string2integer((String) reqMap.get("authrtNo"));

		List<MngMenuVO> mngMenuList = null;

		if (authrtNo == 0) {
			mngAuthrtVO.setCrud(CRUD.CREATE);
			mngMenuList = mngMenuService.selectMngMenuList();
		} else {
			mngAuthrtVO = mngAuthrtService.selectMngAuthrt(authrtNo);
			mngAuthrtVO.setCrud(CRUD.UPDATE);
			mngMenuList = mngMenuService.selectMngMenuAuthList(authrtNo, "");

		}

		model.addAttribute("mngMenuList", mngMenuList);
		model.addAttribute("mngAuthrtVO", mngAuthrtVO);
		model.addAttribute("authTyMap", CodeMap.MNGR_AUTH_TY);

		return "/manage/sysmng/mng-authrt/form";
	}

	@RequestMapping(value="action")
	public View action(
			MngAuthrtVO mngAuthrtVO
			, @RequestParam(value = "arrMenuNo", required = false) String[] arrMenuNo
			//, @RequestParam(value = "authSites", required = false) String authSites
			, @RequestParam(value = "authMenus", required = false) String authMenus
			, @RequestParam(value = "authMngMenus"
			, required = false) String authMngMenus
			, HttpSession session)
			throws Exception {

		JavaScript javaScript = new JavaScript();

		switch (mngAuthrtVO.getCrud()) {
			case CREATE:
				mngAuthrtService.insertMngAuthrt(mngAuthrtVO);
				mngAuthrtService.executeMngAuthrtMenu(mngAuthrtVO.getAuthrtNo(), authMngMenus);
				javaScript.setMessage(getMsg("action.complete.insert"));
				break;

			case UPDATE:
				mngAuthrtService.updateMngAuthrt(mngAuthrtVO);
				mngAuthrtService.executeMngAuthrtMenu(mngAuthrtVO.getAuthrtNo(), authMngMenus);
				javaScript.setMessage(getMsg("action.complete.update"));
				break;

			case DELETE:
				mngAuthrtService.deleteMngAuthrt(mngAuthrtVO.getAuthrtNo());
				javaScript.setMessage(getMsg("action.complete.delete"));
				break;

			default:
				break;
		}

		javaScript.setLocation("./list");
		return new JavaScriptView(javaScript);
	}


	@ResponseBody
	@RequestMapping("getMngMenuList.json")
	public List<MngMenuVO> getMenuList() throws Exception {
		Map<String, Object> paramMap = new HashMap<String, Object>();
		paramMap.put("useYn", "Y");
		List<MngMenuVO> list = (List<MngMenuVO>) mngMenuService.selectMngMenuList(paramMap);
		return list;
	}

}
