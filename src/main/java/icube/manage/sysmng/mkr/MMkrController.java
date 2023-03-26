package icube.manage.sysmng.mkr;

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
import icube.manage.sysmng.mkr.biz.MkrService;
import icube.manage.sysmng.mkr.biz.MkrVO;
import icube.manage.sysmng.mngr.biz.MngrSession;



@Controller
@RequestMapping(value="/_mng/sysmng/mkr")
public class MMkrController extends CommonAbstractController {

	@Resource(name = "mkrService")
	private MkrService mkrService;

	@Autowired
	private MngrSession mngrSession;

	private static String[] targetParams = {"curPage", "cntPerPage", "srchTarget", "srchText", "sortBy", "srchYn"};

    /**
     * 시스템 관리 > 제조사관리 > 리스트
     */
	@RequestMapping(value="list")
	public String list(
			HttpServletRequest request
			, Model model) throws Exception {

		CommonListVO listVO = new CommonListVO(request);
		listVO = mkrService.mkrListVO(listVO);

		model.addAttribute("listVO", listVO);
		model.addAttribute("useYn", CodeMap.USE_YN);

		return "/manage/sysmng/mkr/list";
	}

	/**
	 * 시스템 관리 > 제조사관리 > 작성
	 */
	@RequestMapping(value="form")
	public String form(
			MkrVO mkrVO
			, @RequestParam Map<String, Object> reqMap
			, HttpServletRequest request
			, HttpSession session
			, Model model) throws Exception{

		int mkrNo = EgovStringUtil.string2integer((String) reqMap.get("mkrNo"));

		if(mkrNo == 0){
			mkrVO.setCrud(CRUD.CREATE);
		}else{
			mkrVO = mkrService.selectMkr(mkrNo);
			mkrVO.setCrud(CRUD.UPDATE);
		}

		model.addAttribute("mkrVO", mkrVO);
		model.addAttribute("param", reqMap);
		model.addAttribute("useYn", CodeMap.USE_YN);

		return "/manage/sysmng/mkr/form";
	}

	/**
	 * 시스템 관리 > 제조사관리 > 정보 처리
	 */
	@RequestMapping(value="action")
	public View action(
			MkrVO mkrVO
			, @RequestParam Map<String,Object> reqMap
			, HttpSession session) throws Exception {

		JavaScript javaScript = new JavaScript();
		String pageParam = HtmlUtils.htmlUnescape(EgovStringUtil.null2void(CommonUtil.getPageParam(targetParams, reqMap)));


		// 관리자정보
		mkrVO.setRegUniqueId(mngrSession.getUniqueId());
		mkrVO.setRegId(mngrSession.getMngrId());
		mkrVO.setRgtr(mngrSession.getMngrNm());
		mkrVO.setMdfcnUniqueId(mngrSession.getUniqueId());
		mkrVO.setMdfcnId(mngrSession.getMngrId());
		mkrVO.setMdfr(mngrSession.getMngrNm());

		switch (mkrVO.getCrud()) {
			case CREATE:
				mkrService.insertMkr(mkrVO);

				javaScript.setMessage(getMsg("action.complete.insert"));
				javaScript.setLocation("./list?" + pageParam);
				break;

			case UPDATE:
				mkrService.updateMkr(mkrVO);

				javaScript.setMessage(getMsg("action.complete.update"));
				javaScript.setLocation(
					"./form?mkrNo=" + mkrVO.getMkrNo() + ("".equals(pageParam) ? "" : "&" + pageParam));
				break;

			default:
				break;
		}

		return new JavaScriptView(javaScript);
	}

	/**
	 * 시스템 관리 > 제조사관리 > 제조사명 중복 검사
	 * @author ogy
	 */
	@RequestMapping("mkrDuplicate.json")
	@ResponseBody
	public int dupicate(
			@RequestParam(value="mkrNm", required=true) String mkrNm
			, @RequestParam(value="crud", required=true) String crud
			, @RequestParam(value="no", required=true) int mkrNo
			, HttpSession session
			)throws Exception {

		int result = 0;
		if(mkrNm.isEmpty()) {
			result  = 2; //필수입력
		}else {
			if(crud.equals("CREATE")) {
					//초기 등록
					MkrVO mkrVO = mkrService.selectMkr(mkrNm);
					if(mkrVO == null) {
						result = 3;	//가능
					}else {
						result = 4;	//불가능
					}
				}
		}
		return result;
	}

}
