package icube.manage.sysmng.entrps;

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
import org.springframework.web.servlet.View;
import org.springframework.web.util.HtmlUtils;

import icube.common.framework.abst.CommonAbstractController;
import icube.common.framework.view.JavaScript;
import icube.common.framework.view.JavaScriptView;
import icube.common.util.CommonUtil;
import icube.common.values.CRUD;
import icube.common.values.CodeMap;
import icube.common.vo.CommonListVO;
import icube.manage.sysmng.entrps.biz.EntrpsService;
import icube.manage.sysmng.entrps.biz.EntrpsVO;
import icube.manage.sysmng.mngr.biz.MngrSession;

@Controller
@RequestMapping(value="/_mng/sysmng/entrps")
public class MEntrpsController extends CommonAbstractController {

	@Resource(name = "entrpsService")
	private EntrpsService entrpsService;

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

		CommonListVO listVO = new CommonListVO(request);
		listVO = entrpsService.entrpsListVO(listVO);

		model.addAttribute("listVO", listVO);
		model.addAttribute("keyTy", CodeMap.ENTRPS_KEY_TY);
		model.addAttribute("useYn", CodeMap.USE_YN);

		return "/manage/sysmng/entrps/list";
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

		return "/manage/sysmng/entrps/form";
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

}
