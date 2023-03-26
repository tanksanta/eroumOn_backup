package icube.manage.sysmng.bbs;

import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.egovframe.rte.fdl.string.EgovStringUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.View;
import org.springframework.web.util.HtmlUtils;

import icube.common.framework.abst.CommonAbstractController;
import icube.common.framework.view.JavaScript;
import icube.common.framework.view.JavaScriptView;
import icube.common.util.ArrayUtil;
import icube.common.util.CommonUtil;
import icube.common.values.CRUD;
import icube.common.values.CodeMap;
import icube.common.vo.CommonListVO;
import icube.manage.sysmng.bbs.biz.BbsSetupService;
import icube.manage.sysmng.bbs.biz.BbsSetupVO;
import icube.manage.sysmng.mngr.biz.MngrSession;

@Controller
@RequestMapping(value = "/_mng/sysmng/bbsSet" )
public class MBbsSetupController extends CommonAbstractController {

	@Resource(name = "bbsSetupService")
	private BbsSetupService bbsSetupService;

	@Autowired
	private MngrSession mngrSession;

	// Page Parameter Keys
	private static String[] targetParams = { "curPage", "cntPerPage", "srchUseYn", "srchTarget", "srchText", "srchBbsTy" };

	@RequestMapping(value = "list")
	public String list(
			HttpServletRequest request
			, Model model) throws Exception {

		CommonListVO listVO = new CommonListVO(request);
		listVO = bbsSetupService.selectBbsSetupListVO(listVO);

		model.addAttribute("listVO", listVO);
		model.addAttribute("useYnCode", CodeMap.USE_YN);
		model.addAttribute("boardTyCode", CodeMap.BBS_TY);

		return "/manage/sysmng/bbs/setup/list";
	}


	@RequestMapping(value = "form")
	public String form(
			BbsSetupVO bbsSetupVO
			, @RequestParam Map<String,Object> reqMap
			, HttpSession session
			, HttpServletRequest request
			, Model model) throws Exception {

		int bbsNo = EgovStringUtil.string2integer((String) reqMap.get("bbsNo"));

		if (bbsNo == 0) {
			bbsSetupVO.setCrud(CRUD.CREATE);
		} else {
			bbsSetupVO = bbsSetupService.selectBbsSetup(bbsNo);
			bbsSetupVO.setCrud(CRUD.UPDATE);

			if(EgovStringUtil.isNotEmpty(bbsSetupVO.getAtchfilePermExtnVal())) {
				bbsSetupVO.setAtchfilePermExtn(ArrayUtil.stringToArray(bbsSetupVO.getAtchfilePermExtnVal()));
			}

		}

		// return value
		model.addAttribute("bbsSetupVO", bbsSetupVO);
		model.addAttribute("boardTyCode", CodeMap.BBS_TY);
		model.addAttribute("extnKindCode", CodeMap.EXTN_KIND);
		model.addAttribute("param", reqMap);

		return "/manage/sysmng/bbs/setup/form";
	}


	@RequestMapping(value = "action")
	public View action(
			BbsSetupVO bbsSetupVO
			, MultipartHttpServletRequest multiReq
			, @RequestParam Map<String,Object> reqMap
			, HttpSession session) throws Exception {

		JavaScript javaScript = new JavaScript();
		String pageParam = HtmlUtils
				.htmlUnescape(EgovStringUtil.null2void(CommonUtil.getPageParam(targetParams, reqMap)));

		//확장자
		bbsSetupVO.setAtchfilePermExtnVal( ArrayUtil.arrayToString(bbsSetupVO.getAtchfilePermExtn(), ",") );

		/** 관리자 정보 */
		bbsSetupVO.setRegUniqueId(mngrSession.getUniqueId());
		bbsSetupVO.setRegId(mngrSession.getMngrId());
		bbsSetupVO.setRgtr(mngrSession.getMngrNm());
		bbsSetupVO.setMdfcnUniqueId(mngrSession.getUniqueId());
		bbsSetupVO.setMdfcnId(mngrSession.getMngrId());
		bbsSetupVO.setMdfr(mngrSession.getMngrNm());

		switch (bbsSetupVO.getCrud()) {
		case CREATE:

			bbsSetupService.registerBbsSetup(bbsSetupVO);

			javaScript.setLocation("./list?" + pageParam);
			javaScript.setMessage(getMsg("action.complete.save"));
			break;

		case UPDATE:

			bbsSetupService.modifyBbsSetup(bbsSetupVO);

			javaScript.setMessage(getMsg("action.complete.save"));
			javaScript.setLocation(
					"./form?bbsNo=" + bbsSetupVO.getBbsNo() + ("".equals(pageParam) ? "" : "&" + pageParam));
			break;

		case DELETE:

			bbsSetupService.deleteBbsSetup(bbsSetupVO.getBbsNo());

			javaScript.setMessage(getMsg("action.complete.delete"));
			javaScript.setLocation("./list?" + pageParam);
			break;

		default:
			break;
		}

		return new JavaScriptView(javaScript);
	}

}
