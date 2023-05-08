package icube.manage.sysmng.dlvy;

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
import icube.manage.sysmng.dlvy.biz.DlvyCoMngService;
import icube.manage.sysmng.dlvy.biz.DlvyCoMngVO;
import icube.manage.sysmng.mngr.biz.MngrSession;

@Controller
@RequestMapping(value="/_mng/sysmng/dlvy")
public class MDlvyCoMngController extends CommonAbstractController {

	@Resource(name = "dlvyCoMngService")
	private DlvyCoMngService dlvyCoMngService;

	@Autowired
	private MngrSession mngrSession;

	private static String[] targetParams = {"curPage", "cntPerPage", "srchText", "sortBy", "srchUseYn"};

    /**
     * 시스템 관리 > 배송 업체 관리 > 리스트
     */
	@RequestMapping(value="list")
	public String list(
			HttpServletRequest request
			, Model model) throws Exception {

		CommonListVO listVO = new CommonListVO(request);
		listVO = dlvyCoMngService.dlvyCoMngListVO(listVO);

		model.addAttribute("listVO", listVO);
		model.addAttribute("useYn", CodeMap.USE_YN);

		return "/manage/sysmng/dlvy/list";
	}

    /**
     * 시스템 관리 > 배송 업체 관리 > 작성
     */
	@RequestMapping(value="form")
	public String form(
			DlvyCoMngVO dlvyCoMngVO
			, @RequestParam Map<String, Object> reqMap
			, HttpServletRequest request
			, HttpSession session
			, Model model) throws Exception{

		int coNo = EgovStringUtil.string2integer((String) reqMap.get("coNo"));

		if(coNo == 0){
			dlvyCoMngVO.setCrud(CRUD.CREATE);
		}else{
			dlvyCoMngVO = dlvyCoMngService.selectDlvyCoMng(coNo);
			dlvyCoMngVO.setCrud(CRUD.UPDATE);
		}

		model.addAttribute("dlvyCoMngVO", dlvyCoMngVO);
		session.setAttribute("coNo", coNo);
		model.addAttribute("param", reqMap);
		model.addAttribute("useYn", CodeMap.USE_YN);

		return "/manage/sysmng/dlvy/form";
	}


	 /**
     * 시스템 관리 > 배송 업체 관리 > 정보처리
     */
	@RequestMapping(value="action")
	public View action(
			DlvyCoMngVO dlvyCoMngVO
			, @RequestParam Map<String,Object> reqMap
			, HttpSession session) throws Exception {

		JavaScript javaScript = new JavaScript();
		String pageParam = HtmlUtils.htmlUnescape(EgovStringUtil.null2void(CommonUtil.getPageParam(targetParams, reqMap)));


		// 관리자정보
		dlvyCoMngVO.setRegUniqueId(mngrSession.getUniqueId());
		dlvyCoMngVO.setRegId(mngrSession.getMngrId());
		dlvyCoMngVO.setRgtr(mngrSession.getMngrNm());
		dlvyCoMngVO.setMdfcnUniqueId(mngrSession.getUniqueId());
		dlvyCoMngVO.setMdfcnId(mngrSession.getMngrId());
		dlvyCoMngVO.setMdfr(mngrSession.getMngrNm());

		switch (dlvyCoMngVO.getCrud()) {
			case CREATE:
				dlvyCoMngService.insertDlvyCoMng(dlvyCoMngVO);

				javaScript.setMessage(getMsg("action.complete.insert"));
				javaScript.setLocation("./list?" + pageParam);
				break;

			case UPDATE:
				dlvyCoMngService.updateDlvyCoMng(dlvyCoMngVO);

				javaScript.setMessage(getMsg("action.complete.update"));
				javaScript.setLocation(
					"./form?coNo=" + dlvyCoMngVO.getCoNo() + ("".equals(pageParam) ? "" : "&" + pageParam));
				break;


			default:
				break;
		}

		return new JavaScriptView(javaScript);
	}

	/**
	 * 시스템 관리 > 배송 업체 관리 > 배송업체명 중복검사
	 * @author ogy
	 */
	@RequestMapping("NmDup")
	@ResponseBody
	public boolean NmDup(
			@RequestParam(value="dlvyCoNm", required=true) String nm
			, HttpSession session
			) throws Exception {

		int coNo = (Integer) session.getAttribute("coNo");

		boolean i = true;

		if(coNo == 0) {
			//초기 등록
			DlvyCoMngVO dlvyCoMngVO = dlvyCoMngService.selectDlvyCoMng(nm);
			if(dlvyCoMngVO == null) {
				i = true;
			}else {
				i = false;
			}
		}else {
			//수정 등록
			DlvyCoMngVO dlvyCoMngVO = dlvyCoMngService.selectDlvyCoMng(coNo);
			String ori = dlvyCoMngVO.getDlvyCoNm();
			if(ori.equals(nm)) {
				i = true;
			}else {
				DlvyCoMngVO dlvyCoMngVO2 = dlvyCoMngService.selectDlvyCoMng(nm);
				if(dlvyCoMngVO2 != null) {
					i = false;
				}else {
					i = true;
				}
			}
		}
		return i;
	}
}
