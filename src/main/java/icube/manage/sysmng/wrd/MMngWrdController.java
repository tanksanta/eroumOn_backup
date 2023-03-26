package icube.manage.sysmng.wrd;

import icube.manage.sysmng.mngr.biz.MngrSession;
import icube.manage.sysmng.wrd.biz.MngWrdService;
import icube.manage.sysmng.wrd.biz.MngWrdVO;

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
import org.springframework.web.bind.annotation.ResponseBody;

import org.springframework.web.servlet.View;
import org.springframework.web.util.HtmlUtils;

import icube.common.framework.abst.CommonAbstractController;
import icube.common.framework.view.JavaScript;
import icube.common.framework.view.JavaScriptView;
import icube.common.util.CommonUtil;
import icube.common.values.CRUD;
import icube.common.values.CodeMap;
import icube.common.vo.CommonListVO;

@Controller
@RequestMapping(value="/_mng/sysmng/wrd")
public class MMngWrdController extends CommonAbstractController {

	@Resource(name = "mngWrdService")
	private MngWrdService mngWrdService;

	@Autowired
	private MngrSession mngrSession;

	private static String[] targetParams = {"curPage", "cntPerPage", "srchText", "sortBy", "srchYn"};

	/**
	 * 시스템 관리 > 금지어 관리 > 리스트
	 */
	@RequestMapping(value="list")
	public String list(
			HttpServletRequest request
			, Model model) throws Exception {

		CommonListVO listVO = new CommonListVO(request);
		listVO = mngWrdService.selectMngWrdListVO(listVO);

		model.addAttribute("listVO", listVO);
		model.addAttribute("useYn", CodeMap.USE_YN);

		return "/manage/sysmng/wrd/list";
	}

	/**
	 * 시스템 관리 > 금지어 관리 > 정보 등록
	 */
	@RequestMapping(value="form")
	public String form(
			MngWrdVO mngWrdVO
			, @RequestParam Map<String, Object> reqMap
			, HttpServletRequest request
			, HttpSession session
			, Model model) throws Exception{

		int wrdNo = EgovStringUtil.string2integer((String) reqMap.get("wrdNo"));

		if(wrdNo == 0){
			mngWrdVO.setCrud(CRUD.CREATE);
		}else{
			mngWrdVO = mngWrdService.selectMngWrd(wrdNo);
			mngWrdVO.setCrud(CRUD.UPDATE);
		}

		model.addAttribute("mngWrdVO", mngWrdVO);
		model.addAttribute("param", reqMap);
		model.addAttribute("useYn", CodeMap.USE_YN);

		return "/manage/sysmng/wrd/form";
	}

	/**
	 * 시스템 관리 > 금지어 관리 > 정보 처리
	 */
	@RequestMapping(value="action")
	public View action(
			MngWrdVO mngWrdVO
			, @RequestParam Map<String,Object> reqMap
			) throws Exception {

		JavaScript javaScript = new JavaScript();
		String pageParam = HtmlUtils.htmlUnescape(EgovStringUtil.null2void(CommonUtil.getPageParam(targetParams, reqMap)));


		// 관리자정보
		mngWrdVO.setRegUniqueId(mngrSession.getUniqueId());
		mngWrdVO.setRegId(mngrSession.getMngrId());
		mngWrdVO.setRgtr(mngrSession.getMngrNm());
		mngWrdVO.setMdfcnUniqueId(mngrSession.getUniqueId());
		mngWrdVO.setMdfcnId(mngrSession.getMngrId());
		mngWrdVO.setMdfr(mngrSession.getMngrNm());

		switch (mngWrdVO.getCrud()) {
			case CREATE:
				mngWrdService.insertMngWrd(mngWrdVO);

				javaScript.setMessage(getMsg("action.complete.insert"));
				javaScript.setLocation("./list?" + pageParam);
				break;

			case UPDATE:
				mngWrdService.updateMngWrd(mngWrdVO);

				javaScript.setMessage(getMsg("action.complete.update"));
				javaScript.setLocation(
					"./form?wrdNo=" + mngWrdVO.getWrdNo() + ("".equals(pageParam) ? "" : "&" + pageParam));
				break;

			default:
				break;
		}

		return new JavaScriptView(javaScript);
	}

	/**
	 * 시스템 관리 > 금지어 관리 > 금지어 중복 검사
	 * @author ogy
	 */
	@ResponseBody
	@RequestMapping(value="ChkDuplicate.json")
	public boolean ChkDuplicate(
			@RequestParam(value="prhibtWrd", required=true) String wrdNm
			, @RequestParam(value="crud", required=true) String crud
			, @RequestParam(value="no", required=true) int wrdNo
			, HttpSession session
			) throws Exception {

		boolean result = false;

		MngWrdVO mngWrdVO = mngWrdService.selectMngWrdNm(wrdNm);
		if(mngWrdVO == null) {
			result = true;
		}else {
			return result;
		}

		return result;
	}
}

